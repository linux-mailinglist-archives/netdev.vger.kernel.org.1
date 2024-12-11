Return-Path: <netdev+bounces-150989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9AC9EC47E
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AAF188B485
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 05:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21341C463F;
	Wed, 11 Dec 2024 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hsp1NV8M"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098431C2457
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733896609; cv=none; b=o9gI0GYOqt8XDWSLO1FVgvvsbRLVt7S1MfvghalPR2HrIdHca6rWKISbvKh4bJ6S+jvn0IIoeKgJrD8MTIe1EKgOuGtEnAxcht9/QIx35ZXjC4KLBqzBpk64dUIRLSQo0lUnt/aSMdGkyfdeOVXhZPYzkP695M+wxLmwR+ssZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733896609; c=relaxed/simple;
	bh=1VxNeLDw1DXamTowiJZ0+vvsnHBWT4Ig+73wMlUgEZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rl40Fut9bML0MxMdiB1pdV/Gw9E5SRVu5NCl5MKYjLCBpXZ7/VQ7MWnVu8tNhTAaBKlnOOoRrliFYVlGZjzEhRQXCto1B9GIcvI2wXCZaLHSgiUspVLARseJU5Cz3275zYwRUlIZG0FYUfLnsfz0LN1csOztluNtHXbRVEsbkfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hsp1NV8M; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1733896599;
	bh=0gIyjngxpjh8dKRgWiQ7JmKdEaRZMJpel9SGDyPSS2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hsp1NV8Mc/Sb2zmEVtZphYThox7nc54heIpSV/8154KsVbPJADmFGfTEX+jOCsChM
	 RHemeKMUPz/R10MmGTVDqzaW2U/VFkTb7ab1DgWRY3kuXw3NHeCxXUidHcKa1TtBRI
	 0w7BPiaQyXPwB5kWaVRt7kPb3zyriUMUFVgSunIGTcvRc3lTiQKCLmc7q+e5o+nfap
	 edeyaPBJI/8illQeo67vgp9rGDgDkl8YxzJXGsLvoobPeaGlT8y8991YqeiKMuiS7c
	 Mw1xT89LBetPpLCAyGPBF6t8koplnIMeg5+UItGQEFqdOMwa5MsOzfPHsDl0tqFnR7
	 VAYy4GpqdWHAQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id B0D556E7A9; Wed, 11 Dec 2024 13:56:39 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 11 Dec 2024 13:56:18 +0800
Subject: [PATCH net-next 3/3] net: mctp: Allow MCTP_NET_ANY for v2 tag
 control ioctls
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-mctp-next-v1-3-e392f3d6d154@codeconstruct.com.au>
References: <20241211-mctp-next-v1-0-e392f3d6d154@codeconstruct.com.au>
In-Reply-To: <20241211-mctp-next-v1-0-e392f3d6d154@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

With ALLOCTAG2/DROPTAG2, we added a net field, to allow allocating tags
outside of the default network. However, we may still want to use the
same ioctl for a default net, so implement the same NET_ANY logic which
falls back to the default net.

This makes it a little more ergonomic to use the ALLOCTAG2/DROPTAG2
interfaces on simpler MCTP network setups.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/af_mctp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 87adb4b81ca3ee7d240c80a8a40c4a2e8a876075..1086bff475c1c475df24aedf09737186f87e196f 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -383,6 +383,9 @@ static int mctp_ioctl_tag_copy_from_user(struct net *net, unsigned long arg,
 		ctl->tag = ctl_compat.tag;
 	}
 
+	if (ctl->net == MCTP_NET_ANY)
+		ctl->net = mctp_default_net(net);
+
 	if (ctl->flags)
 		return -EINVAL;
 

-- 
2.39.2


