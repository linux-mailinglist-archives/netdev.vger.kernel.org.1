Return-Path: <netdev+bounces-131007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04FC98C606
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89452840E6
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597951CCED6;
	Tue,  1 Oct 2024 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hi2pL8Nk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0701CCEC2
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810926; cv=none; b=X6katzoaZDfDlnh1GenIyvOHM2yYcqDhCXqlVcj/jvUb0/4+WXswP9VxDqk4Md1BK4jxIlCMaMdE/oSxm/nKHgVMTRmfhmdjjTBkE2qdP+90al7vo8YiHYredLVVvIf8DOKiNqoo9+hugqX4ZcaSYPVpeNA8gCHT67/asRS0Bgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810926; c=relaxed/simple;
	bh=kQwKxUoxM616c6GXhLfMK+mkQQO3M0IdyU7HOIN6IWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiUafTPNMjlpAQcOVaZjHEMbAnxplLU2wDhR5fWpivmtjKFFakLGb+UM5TaMi+mkAPUEtQZ6qXi6MIc/D9zCo673JJHhvGPNrt8m4tXlFN6pBhMlnXuZielYo8qzhI2xA13gDy2LVGWFdiZ8BDGuP8VjNQf+drDTBF4PRMqXRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hi2pL8Nk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727810923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYljn/550Gg8n8QqqWO/ld0tGv+QhqLsSOmFpWNXCNE=;
	b=hi2pL8NkEJUTWzR1DLMWpP2qJoE2+C89rBZWyNOOrmoF5RF8dxfViRhr+eo8ANEQMdmXp6
	G0c+8UXHnqRNooKZlaUZIdgmFcTgONeCw8wEpqlp2V0R+u7Knki+iJCNp1xiBZ+gufl6UW
	UW3gWGupXNTYHuV+HFEhk3dVR/kVNGQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-LxJSGBfOMKWOem3QJBIXZQ-1; Tue, 01 Oct 2024 15:28:41 -0400
X-MC-Unique: LxJSGBfOMKWOem3QJBIXZQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37cdbe8a6e8so1832982f8f.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 12:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727810920; x=1728415720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYljn/550Gg8n8QqqWO/ld0tGv+QhqLsSOmFpWNXCNE=;
        b=OfaeGtyIoU5W1hKHZSJ1xdmqlhb5yuajxLgdIJ4gyYSYDvoR8XYfR8eCHyPNBC8Vvy
         FfqdjhdXEWYTOlUhsBGHnWWD1/VE81BBuB+z8pvgX9jlthaMgphMsPW/qbyVJ8xS/IsU
         UT1WKgSGuAnBCgHQBEluBssVB8qrIwmA3LoA7YEOfU549BsSiHzqXT1uGcufPe8AD+J3
         TXUP7VA+d3kuXfZKRhyg8onUMUnPmaUdPpNbnP2rpFvcPZwwhZiWLMdcGMGnbzByxifG
         76ilXET1o4MpDUj9f8MPX4hv+I11B4GhiiGBxRzX9sczoZO43FdHOx8Kj8bdl2BS+sYJ
         1Y5g==
X-Gm-Message-State: AOJu0YwxGPaaL5dAeo4LACJ+jXhCLD4qLcmfGRyafknhgOmuouNJqLtd
	HDmiBu+qqsLJL4FEgNXmAcY0TgCX5Cko1qV6No74MdmWW1zuXbdFQF4bVgxXOXLbfLKGarghnKR
	ke33lLEihtC4QXIQgRVWS5SbojtwbdLqt2+5zkQPCDv6RBMlAC2tcMA==
X-Received: by 2002:adf:ee88:0:b0:37c:d225:6d33 with SMTP id ffacd0b85a97d-37cfba16c85mr436994f8f.55.1727810920045;
        Tue, 01 Oct 2024 12:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn+cYLFsJtUVtZRvFLQCORYSOkPunpra//+FR74VtQlk+TDuulie4IGHA9coNXaMwR1IXZwA==
X-Received: by 2002:adf:ee88:0:b0:37c:d225:6d33 with SMTP id ffacd0b85a97d-37cfba16c85mr436988f8f.55.1727810919579;
        Tue, 01 Oct 2024 12:28:39 -0700 (PDT)
Received: from debian (2a01cb058d23d60018ec485714c2d3db.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:18ec:4857:14c2:d3db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5730e6fsm12466925f8f.83.2024.10.01.12.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:28:38 -0700 (PDT)
Date: Tue, 1 Oct 2024 21:28:37 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/5] ipv4: Convert icmp_route_lookup() to dscp_t.
Message-ID: <294fead85c6035bcdc5fcf9a6bb4ce8798c45ba1.1727807926.git.gnault@redhat.com>
References: <cover.1727807926.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727807926.git.gnault@redhat.com>

Pass a dscp_t variable to icmp_route_lookup(), instead of a plain u8,
to prevent accidental setting of ECN bits in ->flowi4_tos. Rename that
variable ("tos" -> "dscp") to make the intent clear.

While there, reorganise the function parameters to fill up horizontal
space.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/icmp.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e1384e7331d8..7d7b25ed8d21 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -478,13 +478,11 @@ static struct net_device *icmp_get_route_lookup_dev(struct sk_buff *skb)
 	return route_lookup_dev;
 }
 
-static struct rtable *icmp_route_lookup(struct net *net,
-					struct flowi4 *fl4,
+static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 					struct sk_buff *skb_in,
-					const struct iphdr *iph,
-					__be32 saddr, u8 tos, u32 mark,
-					int type, int code,
-					struct icmp_bxm *param)
+					const struct iphdr *iph, __be32 saddr,
+					dscp_t dscp, u32 mark, int type,
+					int code, struct icmp_bxm *param)
 {
 	struct net_device *route_lookup_dev;
 	struct dst_entry *dst, *dst2;
@@ -498,7 +496,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	fl4->saddr = saddr;
 	fl4->flowi4_mark = mark;
 	fl4->flowi4_uid = sock_net_uid(net, NULL);
-	fl4->flowi4_tos = tos & INET_DSCP_MASK;
+	fl4->flowi4_tos = inet_dscp_to_dsfield(dscp);
 	fl4->flowi4_proto = IPPROTO_ICMP;
 	fl4->fl4_icmp_type = type;
 	fl4->fl4_icmp_code = code;
@@ -547,7 +545,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
 		orefdst = skb_in->_skb_refdst; /* save old refdst */
 		skb_dst_set(skb_in, NULL);
 		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
-				     tos, rt2->dst.dev);
+				     inet_dscp_to_dsfield(dscp), rt2->dst.dev);
 
 		dst_release(&rt2->dst);
 		rt2 = skb_rtable(skb_in);
@@ -741,8 +739,9 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	ipc.opt = &icmp_param.replyopts.opt;
 	ipc.sockc.mark = mark;
 
-	rt = icmp_route_lookup(net, &fl4, skb_in, iph, saddr, tos, mark,
-			       type, code, &icmp_param);
+	rt = icmp_route_lookup(net, &fl4, skb_in, iph, saddr,
+			       inet_dsfield_to_dscp(tos), mark, type, code,
+			       &icmp_param);
 	if (IS_ERR(rt))
 		goto out_unlock;
 
-- 
2.39.2


