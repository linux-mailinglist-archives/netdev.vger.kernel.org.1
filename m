Return-Path: <netdev+bounces-144989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7479C8F1E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E529B28BA1F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1BF17A583;
	Thu, 14 Nov 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGcgJIqg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E00165EFC
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600233; cv=none; b=O2PAH8vddalwMe6iKyCMVgOFALcemmLh2HSaZfw3k9MMesj2KCIBlbGUortJynuM1UjlQRTVGpXBX/v5OnEJid95VKweOC50SZh4CJspMxUmJ31eHH5HW54WfiipXpozVgiq2KPOk1IbWR1JpEaxC775YNLL1DtQL3iyl28mq2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600233; c=relaxed/simple;
	bh=v0kwmtFfnXfpy5cKJxovL0kPGe2aqm4prwx082mj9sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mghO1kt6gXEmovozUnEWa5e81TO4GxDGlEmRRJTc1/IdrjEMpq4QDBAS22NBeagj6vZL1fZPkt9ken2V/dkN5VF9PyUyAl/zC8Ia/wQKCBXFNBXkOAGt4E5OktKNToSEV9hy/qzqwYtT2/URYFdBZc9IawfyLgKDPfzClYqQBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGcgJIqg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731600231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EdliM8Z7gt2RM9bOVe4sgL9YGb6zubuIY0PyqbDtTg8=;
	b=VGcgJIqgkdhiWVkLtCBGWlIVJB6CswatwMRH+Ih6iVnOcImUG53SAXuwVma8Hb+l8uH6d5
	zvMnRfw+fgi8UcbTpVQ4f39m1YMnG2Y7prGaYJ8/mz1Irs8YOSgBXX70clE0InuD44uSn1
	ZJCKvMNzSegEAGLjCGMJ5BxKFsybobM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-G179PfG2N16UGJ2lQYlLEA-1; Thu, 14 Nov 2024 11:03:50 -0500
X-MC-Unique: G179PfG2N16UGJ2lQYlLEA-1
X-Mimecast-MFC-AGG-ID: G179PfG2N16UGJ2lQYlLEA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d5ca192b8so505162f8f.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 08:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600229; x=1732205029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdliM8Z7gt2RM9bOVe4sgL9YGb6zubuIY0PyqbDtTg8=;
        b=Y/83QW+2FE0s2nQp6vWZvCUDzSuAUSUGQeVr0Ci3PcgTl5bPiiz6aKv99Zq0vRb3UB
         CSGSDXxoEwZnd2sAhxsCGkIist7EnrlXMzeKaOngI7CfZq/UI5RQSOX4WM94gwA8MEea
         R1jtpJnEQs2sK/Y8x/19hFb+iBNu9UnXrDy+s9LGRYyyNGjBqnq8bbZDrQFFRr082jcn
         LHQp/WMDm9S7QJcr5qza1WRHqnwo7TB8pnJ4YlP+McNjntMVV55/yURQjdsnHxowsYyd
         ONrGLqFUydm+DUw4MZcpgtiyUqNji8GiibcY9rMg8qipZF2fye3ewvKLX5RaUwLCYv3Z
         3nOA==
X-Forwarded-Encrypted: i=1; AJvYcCV42H4tEMlXUFtSWTyMafYkCrE0ZSfM3evFoPkCNG00NiiBIWK3Bmep1mw+D5+Wg/T4ECxG++g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvkf4eiUCl8/+4kWbjS0wz//9QBflWcF3KlXFTEB4B3AAyQ1Kq
	yvhV2it51aWU6AqqxoRyNAYsAQLyx6W3t+IAOnSFcg8kQE2/hFddDfowDrpOC81yeZ80Bg+aBd9
	qymagFafqXmxF8C18KzvU28OBJnWntBxEugTlgsNTEdIc+n+is21wdA==
X-Received: by 2002:a5d:5f43:0:b0:37d:5251:e5ad with SMTP id ffacd0b85a97d-38213fe93femr3410130f8f.2.1731600228602;
        Thu, 14 Nov 2024 08:03:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmzBFIAWUMu8T177cyJQovSzl+Bfg2xMH/w7cpjzmzMiQkbhzX/e3tpT04f7jPfRKFJIHXbA==
X-Received: by 2002:a5d:5f43:0:b0:37d:5251:e5ad with SMTP id ffacd0b85a97d-38213fe93femr3410053f8f.2.1731600227803;
        Thu, 14 Nov 2024 08:03:47 -0800 (PST)
Received: from debian (2a01cb058d23d600b637ad91a758ba3f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b637:ad91:a758:ba3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbe7dfsm1812740f8f.56.2024.11.14.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:03:47 -0800 (PST)
Date: Thu, 14 Nov 2024 17:03:45 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, coreteam@netfilter.org,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH nf-next 4/5] netfilter: nft_fib: Convert nft_fib4_eval() to
 dscp_t.
Message-ID: <f1b248fc908489dc5dbf6c48408b29152de149e0.1731599482.git.gnault@redhat.com>
References: <cover.1731599482.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731599482.git.gnault@redhat.com>

Use ip4h_dscp() instead of reading iph->tos directly.

ip4h_dscp() returns a dscp_t value which is temporarily converted back
to __u8 with inet_dscp_to_dsfield(). When converting ->flowi4_tos to
dscp_t in the future, we'll only have to remove that
inet_dscp_to_dsfield() call.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/netfilter/nft_fib_ipv4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
index 09fff5d424ef..625adbc42037 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -11,6 +11,7 @@
 #include <net/netfilter/nft_fib.h>
 
 #include <net/inet_dscp.h>
+#include <net/ip.h>
 #include <net/ip_fib.h>
 #include <net/route.h>
 
@@ -107,7 +108,7 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	if (priv->flags & NFTA_FIB_F_MARK)
 		fl4.flowi4_mark = pkt->skb->mark;
 
-	fl4.flowi4_tos = iph->tos & INET_DSCP_MASK;
+	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(iph));
 
 	if (priv->flags & NFTA_FIB_F_DADDR) {
 		fl4.daddr = iph->daddr;
-- 
2.39.2


