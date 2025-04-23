Return-Path: <netdev+bounces-185231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9BEA99671
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 19:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902493B4ECB
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6652328C5BF;
	Wed, 23 Apr 2025 17:21:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from caffeine.csclub.uwaterloo.ca (caffeine.csclub.uwaterloo.ca [129.97.134.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1DD28A41A;
	Wed, 23 Apr 2025 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.97.134.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428896; cv=none; b=dzScx89f2OXDBey777bToJjcKwpQhRrxE31QSGtqQ06ZvPgBVLIU3dI10yySsUNkx8j6uK4gZBN3yD1lIq/mfDmpMIrHqYDv77ykwxWx3fAAKwaUtH+SLCPKMivdAvDQR8Aci7V+KBOODRjDZuec2md4fIGcrxNZ7dr8uVhD664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428896; c=relaxed/simple;
	bh=d4Egn7mgBRaSWdNorW7Zr3c+3merAWcJknb6FQv5GeA=;
	h=Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:From; b=YFYUKQr7xiuZlp2g9r1KfqWlpbgZhBrFpBMvhoqId2Au0BgLVyTOGQIG3lHbeVgZdVWA1n2KEmoh3e8xIlNFzvl7yonDydToI5X7cOcXHv0VKOOdTIJCgGqCdqpfVc+f7puexkSDEYaUyv1t4stmyR+B3ycQfuYpsWsbSRHmLbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csclub.uwaterloo.ca; spf=pass smtp.mailfrom=csclub.uwaterloo.ca; arc=none smtp.client-ip=129.97.134.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csclub.uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csclub.uwaterloo.ca
Received: by caffeine.csclub.uwaterloo.ca (Postfix, from userid 20367)
	id 97DED460E57; Wed, 23 Apr 2025 13:12:54 -0400 (EDT)
Date: Wed, 23 Apr 2025 13:12:54 -0400
To: intel-wired-lan@lists.osuosl.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>,
	Len Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Fix promiscous and multicast mode on iavf after reset
Message-ID: <aAkflkxbvC8MB8PG@csclub.uwaterloo.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>

I discovered that anything that causes a reset in iavf makes breaks
promiscous mode and multicast.  This is because the host side ice
driver clears the VF from filters when it is reset.  iavf then correctly
calls iavf_configure, but since the current_netdev_promisc_flags already
match the netdev promisc settings, nothing is done, so the promisc and
multicast settings are not sent to the ice host driver after the reset.
As a result the iavf side shows promisc enabled but it isn't working.
Disabling and re-enabling promisc on the iavf side fixes it of course.
Simple test case to show this is to enable promisc, check that packets
are being seen, then change the mtu size (which does a reset) and check
packets received again, and promisc is no longer active.  Disabling
promisc and enabling it again restores receiving the packets.

The following seems to work for me, but I am not sure it is the correct
place to clear the saved flags.

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 6d7ba4d67a19..4018a08d63c1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3233,6 +3233,14 @@ static void iavf_reset_task(struct work_struct *work)
 		iavf_shutdown_adminq(hw);
 		iavf_init_adminq(hw);
 		iavf_request_reset(adapter);
+
+		/* Clear remembered promisc and multicast flags since
+		 * reset clears them on the host so they will get force
+		 * applied again through iavf_configure() down below.
+		 */
+		spin_lock_bh(&adapter->current_netdev_promisc_flags_lock);
+		adapter->current_netdev_promisc_flags &= ~(IFF_PROMISC | IFF_ALLMULTI);
+		spin_unlock_bh(&adapter->current_netdev_promisc_flags_lock);
 	}
 	adapter->flags |= IAVF_FLAG_RESET_PENDING;
 

-- 
Len Sorensen

