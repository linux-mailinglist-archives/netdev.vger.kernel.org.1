Return-Path: <netdev+bounces-227172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C313CBA97E8
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF444205BB
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E20B30AD0F;
	Mon, 29 Sep 2025 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aLHTSwgO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7673090D0
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154971; cv=none; b=JxlcpGv4H/vAfHa6tU9+vsKQXuguoKsb9eiaqxHlaJHWecJ17ilsifqm5I6M7CioZgwbHM0hFRzqlMeH1ulWjk8PP5EQPJAQCMrhZD5duMJWOkByX2/RNRO0KSfzgMT6IdXHidTWmdHJuiKkThULOqT90yu/6GIVskhpaClUQ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154971; c=relaxed/simple;
	bh=Mk6474eT/XN2ckgVBZ8mvHsLuwRmfJnx35ZyL6p+1S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WZwb3BJdIWRZyfIdGw+hPooaEeJ5JD35EbXJkmdVLlaCF6cBli2Y+FU95G1xeuaye3WQu5iA08n4VYWAYZ4/JkLYfqfrrIJAu4Y33BFgqtbWoTKAn46mBW70Hrs0Tf/3grm55gZJrpWlDNGVIXbg9xyOPdU0jolThKYMUOb2JU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aLHTSwgO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6364eb29e74so1504937a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 07:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154967; x=1759759767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtxYAP6+wBT1VKxXkpyRLfEBYbOA5bWokqZy0K6rLg4=;
        b=aLHTSwgOp4SXcQIKKO9w6s7ExK3MFZT04S1RPJqZlNGkM7SIVCWU5LTqnl5+UifXCV
         XQUb7gTqy2tfpzkO9dsgPZMZ8M0WOv2poeN0XJ9MmCUy+4UNW+O5kOEUZBDDS1p3OJau
         C0ykDawZ0iniKsVv40mfmw+tveH0BRRpJmY7XY5GniluWKSX05CdYTQ/ijVdWygnX2L6
         1wRw1hmWwl6JKOOXrFHmW55fZeweKwATA78vyx9daNwauxLTCXCfiIk7DKuRUWnhJ9Fb
         CSJg0LVc8Ac2OO/Fa/2p/RKVA7Eu1KKBp9dCChaHO7oIcw6qCbh+EXRbwjPvz66fUfen
         3c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154967; x=1759759767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtxYAP6+wBT1VKxXkpyRLfEBYbOA5bWokqZy0K6rLg4=;
        b=aMi6hUD2PWENwZcdy6RNsIBJ366w8yG3nYsMHjnqfS3oh0CQBnSlxyDVN52+amWJ6m
         2Ql9DM7ZxNA2GOYgpcYaH2Iy7g61apZSOvBMc0snfLNIXoeQsHoQC05lLWj/0hT/zh6A
         1buMUW208ZZXxbd579ZHaYXE/WbdPBaop9ft1wbRMMll0uxd9GUmvwSOwSzBxs+tz7Pd
         YgdmI4vckMAVBL+HcLP0rHXYDk95IIFDpsP5xVEC9F8We2f4DoPsyjmaE92ewQCwSa/k
         iAZPZBy0ePYzWvNveeU681jMSufocSy3MiiEjSODRSCBUr4vsM/UNov9yAcoiKeMYj14
         szjQ==
X-Gm-Message-State: AOJu0YyBy/ASaLQdwI/Mm/ps2WiOR8MfFKkZcdjSRauTO4fdvzh7pFOr
	iMWr4eAE2T5EQU7QbhHP8R5a0g5ylk/VtVN2cQLDKjZa7lvRhxy307nO3mWJOeP6VLp4YgtY8Wa
	i/QB4
X-Gm-Gg: ASbGncsQRJOOhK/7HUaWWMZ/t7YrthxRv22jwgdODQSsNLrlhncLhxHW7MI7odYk/KH
	heXIGZVrvNIk9abH1bXrDHtQwUrTwXQNnXaggW+gaJXgl3XMEeFbvGY/NiBSVN6nXaXvDLCeTSV
	gNahUNStiQhRwILGkxZrrvV3wn5gxpMCQoJ3KAXbsW7ugA7Ud7s57nT8KWWoCgyCkt0l+oC4VoL
	NJTgaiuZ2n5tomot2Kg6zNZsySyhrSelVUAtiPI7Cubo9I4vv0Xz0VOBc1u7VELslBCVgQ1n7ta
	Okh6SKbQomG2/yjoii2qAms4OE3Ko09fbY97WXVefcIzwcedJThJQqHgr0y3X7oMTCdBoZO89P6
	U3IC6Ppq5pIs7TRqnt+T23rMnEj6YZpHFVTbxFtjE38yfYusPhq31gRxIkUZBjDygpDfSpHTonw
	ovvTMTrnO5S8AXt53y
X-Google-Smtp-Source: AGHT+IHVMciMJCns8Rhue44SEU9UNWUGgFfjyQ2O/TgY45Bd9sI80gLncixYnsWQhOgKkRXT5o4ffA==
X-Received: by 2002:a17:907:9803:b0:b18:63b8:c508 with SMTP id a640c23a62f3a-b34be0fd02cmr1572432166b.44.1759154967065;
        Mon, 29 Sep 2025 07:09:27 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e3940168fsm249214266b.73.2025.09.29.07.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:26 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:10 +0200
Subject: [PATCH RFC bpf-next 5/9] bpf: Make bpf_skb_vlan_push helper
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-5-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Use the metadata-aware helper to move packet bytes after skb_push(),
ensuring metadata remains valid after calling the BPF helper.

Also, take care to reserve sufficient headroom for metadata to fit.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/if_vlan.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 4ecc2509b0d4..b0e1f57d51aa 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -355,16 +355,17 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
 					  __be16 vlan_proto, u16 vlan_tci,
 					  unsigned int mac_len)
 {
+	const u8 meta_len = mac_len > ETH_HLEN ? skb_metadata_len(skb) : 0;
 	struct vlan_ethhdr *veth;
 
-	if (skb_cow_head(skb, VLAN_HLEN) < 0)
+	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
 		return -ENOMEM;
 
 	skb_push(skb, VLAN_HLEN);
 
 	/* Move the mac header sans proto to the beginning of the new header. */
 	if (likely(mac_len > ETH_TLEN))
-		memmove(skb->data, skb->data + VLAN_HLEN, mac_len - ETH_TLEN);
+		skb_postpush_data_move(skb, VLAN_HLEN, mac_len - ETH_TLEN);
 	if (skb_mac_header_was_set(skb))
 		skb->mac_header -= VLAN_HLEN;
 

-- 
2.43.0


