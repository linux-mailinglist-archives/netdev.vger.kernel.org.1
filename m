Return-Path: <netdev+bounces-195830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D57CAD25EF
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E557E16E6E4
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A700F21E08A;
	Mon,  9 Jun 2025 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+HYrAjn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD8F21D5BB
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494666; cv=none; b=pIYZ2UX+vYAWgVu5sCNEXBYGwDMQVNKLxF0JD7z4BlBcSpWOYJc1tq190tNa6MB7UfqzWr/bO//EmAs0nuYmP9+dKRYCtTvF/jW7fnmxahQeBoY1WvsC1JQKxk2gnxqHqAJNrU+JX59rjSSXzqFjFfvbnAaeul5siWbbLVXSXiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494666; c=relaxed/simple;
	bh=CgORoqapYSDqojXWtiLlCYpDFC0DG6PeAkmzFRBa3uk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWUe8NXTWyNLRYBpp3JdTW+ZCiSC6hvC5ZUV5v9IC8cw56Bpq5wKnR8NWLzfNudkUBjIU95u7tas4cgCgChsw5mgY+4Smo5Kt2F3IN4MK8OIstKUT4G7mHkBq2jAVHh1J0jENy+nHJiZy1/XO/psEphJe+y3xY1Jeu8Nfvdv9L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+HYrAjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75BBC4CEEB;
	Mon,  9 Jun 2025 18:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749494666;
	bh=CgORoqapYSDqojXWtiLlCYpDFC0DG6PeAkmzFRBa3uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t+HYrAjnSWV9kLUibiGOqLJY6aToCTDTtCX2fQFfynxzmv2rwT+pMpAJOYgjGLwhw
	 Jbw7bCdGhuI6qnVY/n3VI3DtzAtKPpIkb0ycH7hlUIoax164ZtiJV9Dmi8xzvRijiR
	 F12GwbMdVHUdzMIBDSLzc7gXqC7M0kPdTIBT5+qbNY6zOKivuiRFaP6Bn+uJSKWuo9
	 VvfjuaM+DvNhl5M27AttD0YVtyXpbSYFq2AqNumfmslqzLPDzy7dZ3b2sCUWr13yRI
	 cjqodW/Cthdtb9l2c8zrn0R+1vv3dJoiODEmRClT5rSmQNZZOy9wU5mRwr70R6Du6o
	 oJkScRyWw1hYw==
Date: Mon, 9 Jun 2025 11:44:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: pavan.chebbi@broadcom.com, willemdebruijn.kernel@gmail.com,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [RFC net-next 4/6] eth: bnxt: support RSS on IPv6 Flow Label
Message-ID: <20250609114424.6e57da26@kernel.org>
In-Reply-To: <CACKFLik-ri1gkE4T8UWEwCPZMtPE6PPZXYVbnYJSM26LwQqtnw@mail.gmail.com>
References: <20250609173442.1745856-1-kuba@kernel.org>
	<20250609173442.1745856-5-kuba@kernel.org>
	<CACKFLik-ri1gkE4T8UWEwCPZMtPE6PPZXYVbnYJSM26LwQqtnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 11:24:39 -0700 Michael Chan wrote:
> > It appears that the bnxt FW API has the relevant bit for Flow Label
> > hashing. Plumb in the support. Obey the capability bit.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Looks good to me, but we need to report RXH_IP6_FL in bnxt_grxfh() for
> IP V6 flows, right?

Ah, sorry, something like this?

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index fd9405cadad1..4385a94d4d1e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1582,9 +1582,14 @@ static u64 get_ethtool_ipv4_rss(struct bnxt *bp)
 
 static u64 get_ethtool_ipv6_rss(struct bnxt *bp)
 {
+	u64 rss = 0;
+
 	if (bp->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6)
-		return RXH_IP_SRC | RXH_IP_DST;
-	return 0;
+		rss |= RXH_IP_SRC | RXH_IP_DST;
+	if (bp->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL)
+		rss |= RXH_IP6_FL;
+
+	return rss;
 }
 
 static int bnxt_grxfh(struct bnxt *bp, struct ethtool_rxnfc *cmd)

Would someone at Broadcom be able to test (per cover letter)?
I'd love to have the test validated on bnxt if possible :(
I can post a v2 with the snippet merged in if that helps.

