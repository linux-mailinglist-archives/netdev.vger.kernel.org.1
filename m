Return-Path: <netdev+bounces-82744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2805388F8AA
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0BCB2374C
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF8751C27;
	Thu, 28 Mar 2024 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MV54KqWu"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE412561F
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610878; cv=none; b=QNIdTuLV8a/CQs2UwJORqhsrF11yifwcyUuZsJnlrXaTViAOMlJgO+JSfXU7Q+x9Gg4sJ5QljkjmLoKb/C7x3wKUDCQ0zsWsI95nCvI6oO9NAkajm/zyRFB4unH+G25M1YO/aCOcjugjwkzhwALagDPF4GmooWD085WStqwkzmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610878; c=relaxed/simple;
	bh=wkdatT5C0jwZccnhZqFH1RLssfB//i5tEVMb3hYcIe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvsWOfOGTVHXMaCb23taMfc/iM7pYzlsM4DHl6BTsJcaN04OkTnnVOTW3iXY6uUkO1ppcEndy8zz92kEyZnGnTJ2N6z1UQwmjlQsnNlS1rUeDg/8uMf9+xRrYmZor+O3xlFYzeSXdvZdMXgUz84pnnvQK78eMyqHKluWuMfc8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MV54KqWu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2AEukLxIliae8y2z4gLCpGetRKM6887Vh6O3ET1Umy4=;
	t=1711610876; x=1712820476; b=MV54KqWuf0ofls2kfe7rlICL8Ex0EiXwOi3oCJty4ENvzY7
	+2lEJa154v9Ty/ybLLzk8cXYZMTnxwkiQ674xDhpx/Ky5A894SV4mC/cLUWcVTmyF/PsJJvN+fx7f
	jDBDGlX9EG4diZRxcl5nuX+YUgmYWafd+c5mv6ePPbpNnCwGYVC4MzpsOIYz4Wkuk2nS/i5vEQT+m
	u8DLK+NAJHzH3akSjOwqW9fLG/aDtKzpy+WSB559F/ZR1B0WYO+duLFiVfyqyrICxqI1Z/Ik5Zw52
	UEH3KT5BUyus364AX6+IdKwJ+EuJrS86HJN0G9S0SBAhDinrzI39gmXelM4GFHPA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpkAy-00000000jvG-32Hz;
	Thu, 28 Mar 2024 08:27:52 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	victor@mojatatu.com,
	kuba@kernel.org,
	pctammela@mojatatu.com,
	martin@strongswan.org,
	horms@kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next v2 2/2] netdevice: add DEFINE_FREE() for dev_put
Date: Thu, 28 Mar 2024 08:27:50 +0100
Message-ID: <20240328082748.4f7e1895ed81.I1515fdc09a9f39fdbc26558556dd65a2cb03576a@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328082748.b6003379b15b.I9da87266ad39fff647828b5822e6ac8898857b71@changeid>
References: <20240328082748.b6003379b15b.I9da87266ad39fff647828b5822e6ac8898857b71@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For short netdev holds within a function there are still a lot of
users of dev_put() rather than netdev_put(). Add DEFINE_FREE() to
allow making those safer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: resend
---
 include/linux/netdevice.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cb37817d6382..f6c0d731fa35 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4127,6 +4127,8 @@ static inline void dev_put(struct net_device *dev)
 	netdev_put(dev, NULL);
 }
 
+DEFINE_FREE(dev_put, struct net_device *, if (_T) dev_put(_T))
+
 static inline void netdev_ref_replace(struct net_device *odev,
 				      struct net_device *ndev,
 				      netdevice_tracker *tracker,
-- 
2.44.0


