Return-Path: <netdev+bounces-225615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8967FB96144
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB39481410
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6761C1FFC48;
	Tue, 23 Sep 2025 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsvgh7a6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B1C1F2C45
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635304; cv=none; b=LYNZY7C+q2bYIwDHgn8aypqZ5xX2VT5VsHvqS+TmHfQGZhOS+oYSClR+v+zJ98tY+QK95XNlXoN5kbIokHzOEEKHtxDsnZHP3SqFYk1TJnGmN+wR7ikhXXqn4k3+DtgpasPByix6LQYBVGjp5LVvT/p3JMOw7dFUEPeDDw93xuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635304; c=relaxed/simple;
	bh=HSvxDah8PAJbvi+HUMRmPhIRc1k1FkLhgLsH23IU5pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDVNpirrw9YE7FSFt6W8ka1iyjoDuqDy1ry2y7O2P5aC5mKO58Dp8WX2Q9u4SP00yr+eKFo3OVI0zDOwrPxC/UrideKdA/j2gDZiJ6cpuvDRHsHFPF1TLUNuf7UqMkaX6dGZZSl257pv+K4hmYVpfgy5xRYgWLGCZct80LjvP3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsvgh7a6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45f2cf99bbbso26783155e9.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635300; x=1759240100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kt95hu8RP1vRz3kETYiiRm4qQ2ioU1izT1ZmP00xGoo=;
        b=jsvgh7a6tfvXO2awl51tuMWy5k5OD2xiE/Wi7ToOeUpvVBQ8eCDVm3REseom7NHjTn
         ov21MCj/K77Rf6HuHrf6daXTl79VpRmrW7tCxPPj6J5wKSVA7i9kioxLnIwr/aFJXI7x
         lLt/otmBdbVGqFCoH+TLsA6rSwITuFn5v5pTD9tzODPqJfm9F2xeSkuDrV5KB+SpifRu
         lySoeYYfXwOeAl8DZIl03BIMR0qj6VHUvwCCHCk9OGPLfftJY+74kRnuKJbTJLlX6wCq
         zpNYtNRR1o9elag1uPHmIg5VY43e4tmQx5dvceLo+UDOiMvphsc6s892WRZbjokkJex7
         6E5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635300; x=1759240100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kt95hu8RP1vRz3kETYiiRm4qQ2ioU1izT1ZmP00xGoo=;
        b=C6EhjaRPX0SA63elo2/ara/AKsjCSauEOJLudxaaSikuvnIbJKTLK0Bgl3vbuU4Kxz
         RBpzifmBWp1F1i94ywVZwXBf478mdGGqXmOYKl+y5Xz11Mtm47wgjXQrApBOT4p3wlwD
         3WOXQFxleAOxVLYLV54fJVPQc9/LuK1Txhj1y8q/GWgW9YsN+Rd2qTAZjtm/uofSYEdz
         1+18IGmfr5rm9T34puKia7WA4oF1BZL3ut1n7umrYKOKcIMbZ1KKe/WBTngOz1jdzNGa
         ncfAKQGzFWs9WhFTTKXn3/v9qDHcqPGCWgKVv66qYhMYA+YwqqapePdIwFV0GOm6GeLZ
         96Rw==
X-Gm-Message-State: AOJu0YxASBcrYD7ishFPNAQYPOyUXLSr+VsU0iaXTjrEmGnexX/sujC1
	0UGbkLDmbYbBndt0628m6PCrX7PMO/vl6IvtiImOU0JUpEJlkcmV6ElL
X-Gm-Gg: ASbGncuzLk8YdxtSAGCYVG89Lv3ZzHJHHuv+mRnW8uYOeBqRJJf8l1rL5QKTIyH8Ls3
	GqCVTcxLGwABj8rZORmLxeg1ZPA4W6CYfqqKmfkVLAo15LZS9dj5XeDewY8YISrU3Vs+ptTTTTL
	pNzH9wz/3J4mAPJF6StRpSjrl7Addww4ZM0t3Z8zI2xsPzHsHDrKqIcWbAVqpCS/USV2S1zFFvz
	VevfrJxTmtTIsvJkaUdxi+xYy6kElWe+I0O4ZrCey+BgYuJPJZk+OLcNieJR4GhuiTLrClQKHUK
	6KsWziuVXqiYjnaSNQiffCAmxGfBKpFkPOIOs0gwWeS0/pU36lUavihFJ27JjRL8DqNpead6TGT
	CMINMtomuIVYa2NyUYOXVCd2ksm0DzOXRrZ1vOAqVAj8ZfBxr8vG13BkML0g=
X-Google-Smtp-Source: AGHT+IEvTB0RKWK8YWqDSe/oacHNMiXmgXTZPgRv2vTC77CbQ+2mPOFU1Gekinc/SgafGVCinCcMTQ==
X-Received: by 2002:a5d:5f54:0:b0:3e9:d0a5:e45d with SMTP id ffacd0b85a97d-405c684751dmr1951089f8f.17.1758635299908;
        Tue, 23 Sep 2025 06:48:19 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4613ddc01e6sm277234895e9.18.2025.09.23.06.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:48:19 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 12/17] net: Enable BIG TCP with partial GSO
Date: Tue, 23 Sep 2025 16:47:37 +0300
Message-ID: <20250923134742.1399800-13-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

From: Maxim Mikityanskiy <maxim@isovalent.com>

skb_segment is called for partial GSO, when netif_needs_gso returns true
in validate_xmit_skb. Partial GSO is needed, for example, when
segmentation of tunneled traffic is offloaded to a NIC that only
supports inner checksum offload.

Currently, skb_segment clamps the segment length to 65534 bytes, because
gso_size == 65535 is a special value GSO_BY_FRAGS, and we don't want
to accidentally assign mss = 65535, as it would fall into the
GSO_BY_FRAGS check further in the function.

This implementation, however, artificially blocks len > 65534, which is
possible since the introduction of BIG TCP. To allow bigger lengths and
avoid resegmentation of BIG TCP packets, store the gso_by_frags flag in
the beginning and don't use a special value of mss for this purpose
after mss was modified.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 net/core/skbuff.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d331e607edfb..2ebacf5fa09a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4699,6 +4699,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	struct sk_buff *tail = NULL;
 	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
 	unsigned int mss = skb_shinfo(head_skb)->gso_size;
+	bool gso_by_frags = mss == GSO_BY_FRAGS;
 	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
 	unsigned int offset = doffset;
 	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
@@ -4714,7 +4715,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	int nfrags, pos;
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
-	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
+	    !gso_by_frags && mss != skb_headlen(head_skb)) {
 		struct sk_buff *check_skb;
 
 		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
@@ -4742,7 +4743,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	sg = !!(features & NETIF_F_SG);
 	csum = !!can_checksum_protocol(features, proto);
 
-	if (sg && csum && (mss != GSO_BY_FRAGS))  {
+	if (sg && csum && !gso_by_frags)  {
 		if (!(features & NETIF_F_GSO_PARTIAL)) {
 			struct sk_buff *iter;
 			unsigned int frag_len;
@@ -4776,9 +4777,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		/* GSO partial only requires that we trim off any excess that
 		 * doesn't fit into an MSS sized block, so take care of that
 		 * now.
-		 * Cap len to not accidentally hit GSO_BY_FRAGS.
 		 */
-		partial_segs = min(len, GSO_BY_FRAGS - 1) / mss;
+		partial_segs = len / mss;
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
@@ -4802,7 +4802,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		int hsize;
 		int size;
 
-		if (unlikely(mss == GSO_BY_FRAGS)) {
+		if (unlikely(gso_by_frags)) {
 			len = list_skb->len;
 		} else {
 			len = head_skb->len - offset;
-- 
2.50.1


