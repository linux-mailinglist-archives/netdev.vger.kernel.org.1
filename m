Return-Path: <netdev+bounces-127108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624297423B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 20:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12291F26180
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686331A3BDB;
	Tue, 10 Sep 2024 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkPHCzCR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2B1990CD
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993080; cv=none; b=fWsFO8pF1PDp7ozjGW1wS7gSfKIACt/CHd0mtVuh7Q1xCGDSUxHLit6H9HebydkrpS0Oa3lmBERF8yku6fHmRZ2V4M/Bj/vYwB4vRgfRpyBzt/ajxxwlojOWbzf+tsUH0fTh3MbS8DRDQ5waB5y4RqrVLZrXXI3TsqLzmV5sE3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993080; c=relaxed/simple;
	bh=JiJGJbyaHZt3h92Zj07YSqqoaWT91gxCr1hKgT6/Xkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJnY7lv5orTVLy5ji4+2Hf5sI+ncYdS7c/M7sG2UV2AAq/ksH3xKK6NdNulWxHTvkhB1G0OHqyxpS5+7clP+t3c0W1ry9Z5g+5IdS9CcbCgw9THZIKZHVg13QR/2huynjVX+Mi1SI/RwFz8MEjQJkgFAdFxuGbrhlLf3VmgXJKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BkPHCzCR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725993077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk1/qnciRDVXAFEbwkCHcWWIMqqsBf66utbeH8ohuzw=;
	b=BkPHCzCReF8dZqctUqrYjNyhjt8O1I0Z8UYBjUIcmkJoJk1OrBI6I1Lt6bDsS4jnY2utBn
	Xgdg1CVnHtHIspAiN0j6vG3QViOpmvZxoPfY84m6PpbVtMlU9l603a6NyvJSX9qpanSTq2
	zt7iHfZkDifqvMvshyyxHxuZILgFA/8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-GtV_ZNZwPLKOCCAH5i4weQ-1; Tue, 10 Sep 2024 14:31:15 -0400
X-MC-Unique: GtV_ZNZwPLKOCCAH5i4weQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb99afa97so18154385e9.2
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 11:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725993074; x=1726597874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bk1/qnciRDVXAFEbwkCHcWWIMqqsBf66utbeH8ohuzw=;
        b=pr5Xsytg7I51sBgONf4VeiHzv429daU1JGfnsCQ70rwrNHkrUSu07mmAkxY5DKD5Zf
         6k9YHeyLZadt230o6VsgRFYUgfpYfF4DUF+ZiOlmZ+8qHPthluS16nfIT1qDOatTK6Qw
         Ro9ZOG6ETmUYPzkcuvQLDgx/ItnK1kzLukp1E4AJsmHtW5Vh4XZtx8IoSZntEej9mh9u
         aAMhv147AHnOrBuu8TKF7BLz9lwfiJGpllHoj+C8/Gcuinh5sy0w9sBdzmLwbns7sVpE
         xpcWbLX4nBtzbQVFOYRK9GSnipNjPeEEbroVRLFSJziv7Ib9X9PL26meYS/G2KT3ZQdw
         Z6oQ==
X-Gm-Message-State: AOJu0Yz0cEdefBc1+8AhJtxdo9IujWkEH+TOodPJov60Ol6C2axVzk1E
	7yCLprF32uHWZ7a0Bw2Ao4OlWTrf+3cfH14tUDi6cJLE/uYY9pGDlTCHZDgxN7XNd3yGH/9nAf4
	6Me6JKb8F4i0DaZ91YWXbfy2+YBiLUXIzTYo8DZnEjhHyPO59VfSZ/w==
X-Received: by 2002:a05:600c:1f90:b0:425:7c95:75d0 with SMTP id 5b1f17b1804b1-42c9f9850d1mr114663425e9.18.1725993073909;
        Tue, 10 Sep 2024 11:31:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpbN/OE/VnJD8rDGHigqNIy+clkpL89tcmEPtSFla8UiQKEh+cMF7uYzSJvvjjK0nXaQOK/w==
X-Received: by 2002:a05:600c:1f90:b0:425:7c95:75d0 with SMTP id 5b1f17b1804b1-42c9f9850d1mr114663235e9.18.1725993073441;
        Tue, 10 Sep 2024 11:31:13 -0700 (PDT)
Received: from debian (2a01cb058d23d6001ef525940bfc7e6a.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1ef5:2594:bfc:7e6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8afbesm119464995e9.41.2024.09.10.11.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 11:31:13 -0700 (PDT)
Date: Tue, 10 Sep 2024 20:31:11 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH net 2/2] bareudp: Pull inner IP header on xmit.
Message-ID: <ff989c7a154344f1b280dc39603ec26a79cd4d8c.1725992513.git.gnault@redhat.com>
References: <cover.1725992513.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725992513.git.gnault@redhat.com>

Both bareudp_xmit_skb() and bareudp6_xmit_skb() read their skb's inner
IP header to get its ECN value (with ip_tunnel_ecn_encap()). Therefore
we need to ensure that the inner IP header is part of the skb's linear
data.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/bareudp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index b4e820a123ca..e80992b4f9de 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -317,6 +317,9 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be32 saddr;
 	int err;
 
+	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+		return -EINVAL;
+
 	if (!sock)
 		return -ESHUTDOWN;
 
@@ -384,6 +387,9 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
+	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+		return -EINVAL;
+
 	if (!sock)
 		return -ESHUTDOWN;
 
-- 
2.39.2


