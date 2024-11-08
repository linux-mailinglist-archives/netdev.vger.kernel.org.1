Return-Path: <netdev+bounces-143358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E65399C226A
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE00B2452E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E501EBFEC;
	Fri,  8 Nov 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQnRK3DG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AE1EF09F
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084443; cv=none; b=RnSGOYQxMshu+FDA42igNDc1PnXtKR6OgF+1c4KUoXcSuoZAJq52JEIprcNaIuWZ/iuuDe81Lf3WSC8xpbneXlmmznqVcV579AIpBHKa4TvWzwxe83pmBARbr6PzpiS2R2kJWy14lbVILROuyLMNcuV3kINEbLoD194zucZ3Dqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084443; c=relaxed/simple;
	bh=HgpX6tjgGPAMEkbHtYCsKAtXDMaBY39C4BAyLKPf9qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKuWrvY6CWeYE+WWPrSR7g8ZLTSqxpAK8CJPuOyMAUujoqQ0fdOxm6sXzn5IFBS8N8nxrAs2W73h+egCLj45Dr/erE5f18nHyqMDa5eEWUe2w6l2UAWQqK6ezUsUKfon8sjw1H2avXafGghb7XvRdb3Qmf8X5x08K2yAhvhFxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQnRK3DG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731084441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e0cIt/+XAIZgDENxrBqdIIl26BAp6/hywyRIqUkYYwM=;
	b=WQnRK3DG6xAgrjJ92tNKP0bM30G7lqxGedCr7kFwMWBm+Mbs69TztgQ/d3YIymHUKSrXTJ
	7XW+w/XMfMpGemd6kDPsKzc7xLjEEc5JMqSULBeWFFhREZSBddjDzCDdq2IebhEgMwNpxk
	ghVTxItlWbv+eX2qgQYrqgmS6Po+WrU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-Lm6wTesDNlC16HFiokVrBg-1; Fri, 08 Nov 2024 11:47:20 -0500
X-MC-Unique: Lm6wTesDNlC16HFiokVrBg-1
X-Mimecast-MFC-AGG-ID: Lm6wTesDNlC16HFiokVrBg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43164f21063so15041895e9.2
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 08:47:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731084439; x=1731689239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0cIt/+XAIZgDENxrBqdIIl26BAp6/hywyRIqUkYYwM=;
        b=hXLKACiJKBcTo9hdfEL76JV5d+E5fMjtcM37IzOq2XHKnAu0vndd0hlg6ybE6YyLD0
         aDc4xAvLLwKJoaRtJO8Osj6qhTqKDtY8YKsHZex2WUpIHjy/tCTOhdqWGjOv+QrIa+Xv
         FKUofxqRX5v80ll+DWX/2Wqp/hZXeNVlcq2tF7ud1VcwRxCKYi64z1ZLdtAfoGgBDN2r
         rcUWHk7Ysx17jORhht4cHKA3cvvY0Q6mtQL2VpMj1D4LTpHQM4Q0VU7A8UzVvoFC9TG7
         w41Vi4//PCLcdBhrC0V9ui1e7oWYnHJfk3ArvYUx2GeyEFN6nZKMnnAcYM95YD7oqjyx
         DBgQ==
X-Gm-Message-State: AOJu0YyQQOKoWNBGeDEf5kJyehDmGdktgqRGBrp4tg0I82dwmvvNkE/m
	UwcXWvRRpHJwro935hSuf3lGpaZldNotKCwZzpT/I1XlG7VEO+/6amHLNxUpC5vQO8lYFkhm8RO
	uHV/gOK2AI9d25SA6axBgCTGCXehEXxHq9Ck9EFZVGIDPk7eLlI9v7QlL9mgYLOjV
X-Received: by 2002:a05:6000:1f87:b0:37d:39f8:a77a with SMTP id ffacd0b85a97d-381f18270c4mr2439961f8f.8.1731084438808;
        Fri, 08 Nov 2024 08:47:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi//4NoWzVklrn7s3bkXBgd2ArudhPQnTT0EjnZgbd0c6RqQ0eaSZZYBxd4RY2wzrJ5vaOTg==
X-Received: by 2002:a05:6000:1f87:b0:37d:39f8:a77a with SMTP id ffacd0b85a97d-381f18270c4mr2439945f8f.8.1731084438400;
        Fri, 08 Nov 2024 08:47:18 -0800 (PST)
Received: from debian (2a01cb058d23d60039a5c1e29a817dbe.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:39a5:c1e2:9a81:7dbe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b0562ccdsm73851045e9.23.2024.11.08.08.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 08:47:17 -0800 (PST)
Date: Fri, 8 Nov 2024 17:47:15 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, bpf@vger.kernel.org
Subject: [PATCH net-next 2/2] bpf: lwtunnel: Prepare bpf_lwt_xmit_reroute()
 to future .flowi4_tos conversion.
Message-ID: <8338a12377c44f698a651d1ce357dd92bdf18120.1731064982.git.gnault@redhat.com>
References: <cover.1731064982.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731064982.git.gnault@redhat.com>

Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
dscp_t value to __u8 with inet_dscp_to_dsfield().

Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
the inet_dscp_to_dsfield() call.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/core/lwt_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index e0ca24a58810..6655af5c267d 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -207,7 +207,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 		fl4.flowi4_oif = oif;
 		fl4.flowi4_mark = skb->mark;
 		fl4.flowi4_uid = sock_net_uid(net, sk);
-		fl4.flowi4_tos = iph->tos & INET_DSCP_MASK;
+		fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(iph));
 		fl4.flowi4_flags = FLOWI_FLAG_ANYSRC;
 		fl4.flowi4_proto = iph->protocol;
 		fl4.daddr = iph->daddr;
-- 
2.39.2


