Return-Path: <netdev+bounces-92554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C388B7D86
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1171F24DD6
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950903E478;
	Tue, 30 Apr 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRRKV1Hz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D717141C89
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495822; cv=none; b=sGNjtfNW0Zpmygc2/bm36yXkxJAmlp6OEsqFsOCc6sJX1/pyKpnSAnUtAw73T4Jlw+Fwa7/ThgB3PZjCwkL1ZnTJibvvTs4lRHhgL/nRBP1JcSP7VQChlCH+vYYEilrNCu227yYf/IFtUAh/mtGGlMi/K5CfKxRB9MAuRXMJ9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495822; c=relaxed/simple;
	bh=IM9wftrSwbXrJxznss9wwAHejYpHq7rl8BcSGQi9r10=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jPhTT3RqCHJKSXJ4UFGSCWBQaS/v/9gaKBrKG1PwWXB5u5D1LJrm8ppz0niyr59Or8Sd0RcCgss26kTChpNwmHyRtyT1X9xTJFJ1lFe+YcBoZNCCvl+M5y5W9nzfhFhgD78ZwwumAtaQLSvx99i968PqUKPR1JKpQY7SKafb820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRRKV1Hz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714495819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=m6iQ1xIPs6ZjYd9HyQi8HQC3LgsDXkwv7BaswhphiOM=;
	b=bRRKV1HzY1MrbXMCEHmi1IoKKhI2DVGj6YR0KMNcBRZ5uVzFiUIFqrKOCgbCNt7FBGX24C
	ZETKkvo27BZEMbP3dq6KBiNiYosyK2MRR9X1XS155LFD9k7gjqoYGLn50sBZyaSKfJERVR
	lKPg1YD3vK+Q58sofxXMRFy9j1csVqg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-F4-LhnKzPH2jzLhM0mASaQ-1; Tue, 30 Apr 2024 12:50:18 -0400
X-MC-Unique: F4-LhnKzPH2jzLhM0mASaQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-51d6630a5ebso2419183e87.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 09:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714495816; x=1715100616;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6iQ1xIPs6ZjYd9HyQi8HQC3LgsDXkwv7BaswhphiOM=;
        b=B0WeUGCB2xf482yX+feOrS3SAFg5jR2b8rtLaOg5pFvwsROD/LosrgRR73fIeQK9VR
         4aZ60yBX3ZdFvKTbXWo7YjmH1CV5VoNxecDlw0DwlTT61aLDlHv+gH9h74yxPzpCPla9
         u8Y8MDHQ9YGPWiTcQaLxsHNpqeYSCzEUu1sXi19d5sKg7oSU30R8iAG9RpEuP0tY4sJq
         HSvBo22ayYrpUtjQ7mPwubzcTvSdNsxwSbROYRnFJ1Lx4ZmfQttx8KA8l1lBal6MLu63
         IrO8z8XEmE2dQzhtVUj5mcUw6Q22kZm6ogawU048yr02TT8/ac6lhI42KOOmuXFWxM6z
         nqWA==
X-Gm-Message-State: AOJu0YyBCh6iHvUcuO+KDRytFABQOCCj0EM35x6YhrvDpUvqKvSwCQxl
	qkrRdC/C9kFomIGw/yNrbQt5vDoLppvWhgZ9u9JNa/aS6+GSbqBsBRjvMIcWw/9BktQuuuwFPz1
	zhg05L9mtgJEfzNWlALvJzmj12FuFfitoqmiCZ69asFcmUuak2QthgFQmyNaUpQ==
X-Received: by 2002:a05:651c:617:b0:2e1:26c:7e7f with SMTP id k23-20020a05651c061700b002e1026c7e7fmr238473lje.8.1714495816395;
        Tue, 30 Apr 2024 09:50:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0cf6TBP+DhT256cidrWiXo1nsNz0MNvGsk3lOu/WCMQXe0B6xn0aCpNbhBqJzNuLYYB9g9Q==
X-Received: by 2002:a05:651c:617:b0:2e1:26c:7e7f with SMTP id k23-20020a05651c061700b002e1026c7e7fmr238462lje.8.1714495816016;
        Tue, 30 Apr 2024 09:50:16 -0700 (PDT)
Received: from debian (2a01cb058d23d60076af5b8efeaf7f6c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:76af:5b8e:feaf:7f6c])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c4e9100b004182b87aaacsm45635077wmq.14.2024.04.30.09.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:50:15 -0700 (PDT)
Date: Tue, 30 Apr 2024 18:50:13 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jiri Benc <jbenc@redhat.com>, Breno Leitao <leitao@debian.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net] vxlan: Pull inner IP header in vxlan_rcv().
Message-ID: <1239c8db54efec341dd6455c77e0380f58923a3c.1714495737.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ensure the inner IP header is part of skb's linear data before reading
its ECN bits. Otherwise we might read garbage.
One symptom is the system erroneously logging errors like
"vxlan: non-ECT from xxx.xxx.xxx.xxx with TOS=xxxx".

Similar bugs have been fixed in geneve, ip_tunnel and ip6_tunnel (see
commit 1ca1ba465e55 ("geneve: make sure to pull inner header in
geneve_rx()") for example). So let's reuse the same code structure for
consistency. Maybe we'll can add a common helper in the future.

Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/vxlan/vxlan_core.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index c9e4e03ad214..3a9148fb1422 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1674,6 +1674,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	bool raw_proto = false;
 	void *oiph;
 	__be32 vni = 0;
+	int nh;
 
 	/* Need UDP and VXLAN header to be present */
 	if (!pskb_may_pull(skb, VXLAN_HLEN))
@@ -1762,9 +1763,25 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		skb->pkt_type = PACKET_HOST;
 	}
 
-	oiph = skb_network_header(skb);
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
 	skb_reset_network_header(skb);
 
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(vxlan->dev, rx_length_errors);
+		DEV_STATS_INC(vxlan->dev, rx_errors);
+		vxlan_vnifilter_count(vxlan, vni, vninode,
+				      VXLAN_VNI_STATS_RX_ERRORS, 0);
+		goto drop;
+	}
+
+	/* Get the outer header. */
+	oiph = skb->head + nh;
+
 	if (!vxlan_ecn_decapsulate(vs, oiph, skb)) {
 		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
-- 
2.39.2


