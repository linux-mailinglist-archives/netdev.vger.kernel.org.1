Return-Path: <netdev+bounces-226496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B7DBA1066
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F89B175D92
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1C131A04D;
	Thu, 25 Sep 2025 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH2injt/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610513128C9
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825063; cv=none; b=mvK3X/1zcan8cwIjVbJk1RHa69bO//7f0I3Xz+Stw9FaH3MOeWWX8Xlh0qHrlKoo15+H5hlNQ6ShbWGLHJVJt6sqHu7k2uVDbn/ho9TuP2jzEP5bibvO+l9wzoSyI43hUomXPgnb9V2cpcYC1eaK6/g7TPDGVaLM8yopcK7f6P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825063; c=relaxed/simple;
	bh=fdY4s91tI+lPau1JubbQ0x8fEYiPT2Mrr0LtPH6xCk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6+QxA/P8bvplXrfPTdj6QXajNiMR6Qx9nAMXdCUxOWnvjgbeChAlve9RyIwRd9frvb8RWsY54kn/eoNftOImL7fQI47tYnf3U4ugscz5Njvt41lPMFl0UzLy1XOOVMAvW1kTLQiqcenc1PSlOkFhTCyDrbV69yZekUA63WFfD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH2injt/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so2433496a12.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825060; x=1759429860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+3n/wt4G7GIqXmLm7jMx2L0Drt9lvIRoMC4cC/d+Ac=;
        b=jH2injt/CMkV4jSxqw2ePn/HL3j5USxEo6oglVEr0Gf+5fvQzgxX1YklXxR+bNowqw
         23L0WL5T5vGJ3V5pPabmF2G+1ppfdHpFBH3U42m/GdJGQF+y13pG43ifjGc3YwRMPsaG
         wEj/7zprVfwGp8ZhIfdHaA0/1AWKSU4/8hNvGDGITZmmSo8YVGI6cC8V9Evn+2VA+axx
         TjLpZnzbcEg9vOGmC7GT1B8Myk4L8JfLPXX068bTz43STTe0Unml5ydxshX6EzXK8mrg
         jler5Rv2Ti6gMZJUGQ2GkqcpGy1vcn+0HdtTztb6oqfAqz+Rh+uHhOTwSmjOSsjHagAk
         rrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825060; x=1759429860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+3n/wt4G7GIqXmLm7jMx2L0Drt9lvIRoMC4cC/d+Ac=;
        b=jnAxC6CJ2lweKvEdrzWTDs7o6dLq5XwQR8kUsHtcM3DZvaObeJW0tpiGz2oC4rIOyi
         +nDdvQXLgj2E7kZizK4wxMfMB8JecBs7qMenKlHjo/O7h1elA74wLO9VAPu86u6qtrCT
         MsHlAIp/NtOKX4JVp8GbM6zCszgXiKT7oD47b5dAo7XeH0LzcdNydSADga1SdF3rkZAB
         /uZI6sxHhH0hAxMJd1/uCbn6bJATvhVVMFqSp6dm9LSfGAO+8lIS13tov/84ZvML8J+X
         l0FkB/UULFVO56naK/b7+Q/C0D/Gmxgs67jbZaZ8POi5uIEAygmyIxZzsp7fy3lPPU5+
         D2rg==
X-Forwarded-Encrypted: i=1; AJvYcCW2BjEJ/xkWbFSpT9GugjNpYKnNvMVcR16AS4/YESdceDr2bDAqnu4Fu9zXztkgYoX7AJtEx7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+cPeEXlnFSfBnJ8SCJ2P1ce/xFkd/EZMacMqdsU2pQVSGpVR4
	HqCeY9FkJTzW0Nmk8LIM6z/e/DEBn1vBazkJUcdGglt7PHMuJfTIfQHU
X-Gm-Gg: ASbGncshcJVeT5wJcKQXZXbkpA49cVc0SP1pWbaOHGitjF6rYphDVFcICOvjUhIFUVZ
	bjF4voG7zCGyV5MDQqb1yqvwrnNm/VR4ISDoc75unFGl5HzRpB0NMvjiK3mbF+DlSyzFYeUR13K
	2wyYI9Pb075TVMvnUCe5dGhhUvF5ssxH7YyLMqetDwJhJktUcXazrvpja+AsotNQTZJn0c+7nTu
	VzA27Nr7/cC2cX0etb7t2UsavwnaCWhCejxKKveSovIbfSo1cbZX+0A4pcYlquKvaYJtKG9VN2K
	mmeDwyyLmB/e2McA80h1yRgcmJfp05VSDghKfsWWPI8STON5yRTMTLRqewa/DtICH5vD8kIIA7d
	KZE+HWfshsgmwkzpZtK3Ak5jQTngK4QWBzcqvA9g0dXUv1SIfNwwOPVmMz5B9ZMyZa3xRUqvMY9
	u5R4K6p00zB+VS905n8A==
X-Google-Smtp-Source: AGHT+IGAa02mHOQA+yISRuVyAiyglwnY2AxzVt78/ebOCI2IUEbTqhhH5+ovN3xQr0fSLhe5oRXbZA==
X-Received: by 2002:a17:906:f597:b0:b21:6dce:785 with SMTP id a640c23a62f3a-b34b7209d39mr472920266b.1.1758825059575;
        Thu, 25 Sep 2025 11:30:59 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a9c560sm211198666b.107.2025.09.25.11.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:30:59 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v15 nf-next 1/3] netfilter: utils: nf_checksum(_partial) correct data!=networkheader
Date: Thu, 25 Sep 2025 20:30:41 +0200
Message-ID: <20250925183043.114660-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250925183043.114660-1-ericwouds@gmail.com>
References: <20250925183043.114660-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the conntrack hook it may not always be the case that:
skb_network_header(skb) == skb->data, i.e. skb_network_offset(skb)
is zero.

This is problematic when L4 function nf_conntrack_handle_packet()
is accessing L3 data. This function uses thoff and ip_hdr()
to finds it's data. But it also calculates the checksum.
nf_checksum() and nf_checksum_partial() both use lower skb-checksum
functions that are based on using skb->data.

Adjust for skb_network_offset(skb), so that the checksum is calculated
correctly.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/utils.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/utils.c b/net/netfilter/utils.c
index 008419db815a..7b33fe63c5fa 100644
--- a/net/netfilter/utils.c
+++ b/net/netfilter/utils.c
@@ -124,16 +124,25 @@ __sum16 nf_checksum(struct sk_buff *skb, unsigned int hook,
 		    unsigned int dataoff, u8 protocol,
 		    unsigned short family)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* pull/push because the lower csum functions assume that
+	 * skb_network_offset(skb) is zero.
+	 */
+	__skb_pull(skb, nhpull);
 	switch (family) {
 	case AF_INET:
-		csum = nf_ip_checksum(skb, hook, dataoff, protocol);
+		csum = nf_ip_checksum(skb, hook, dataoff - nhpull, protocol);
 		break;
 	case AF_INET6:
-		csum = nf_ip6_checksum(skb, hook, dataoff, protocol);
+		csum = nf_ip6_checksum(skb, hook, dataoff - nhpull, protocol);
 		break;
 	}
+	__skb_push(skb, nhpull);
 
 	return csum;
 }
@@ -143,18 +152,25 @@ __sum16 nf_checksum_partial(struct sk_buff *skb, unsigned int hook,
 			    unsigned int dataoff, unsigned int len,
 			    u8 protocol, unsigned short family)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* See nf_checksum() */
+	__skb_pull(skb, nhpull);
 	switch (family) {
 	case AF_INET:
-		csum = nf_ip_checksum_partial(skb, hook, dataoff, len,
-					      protocol);
+		csum = nf_ip_checksum_partial(skb, hook, dataoff - nhpull,
+					      len, protocol);
 		break;
 	case AF_INET6:
-		csum = nf_ip6_checksum_partial(skb, hook, dataoff, len,
-					       protocol);
+		csum = nf_ip6_checksum_partial(skb, hook, dataoff - nhpull,
+					       len, protocol);
 		break;
 	}
+	__skb_push(skb, nhpull);
 
 	return csum;
 }
-- 
2.50.0


