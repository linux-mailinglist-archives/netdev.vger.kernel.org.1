Return-Path: <netdev+bounces-230720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DEFBEE557
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4E03A9415
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE8C2E8B72;
	Sun, 19 Oct 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dSePp/hl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C952E88A6
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877950; cv=none; b=WZj8a9mpKDLW8YOYpGQzi7d5HhcEsHY+/YaQ/0GoqTIDgk5XGfUd4/U4Jv/dpY03EAEDE3jPruZwwY1VlwjNepm9zyu9rYxx+n5+0GsCqZQ0zBipBXfyUIKp4Gyz83PzvjasdO3XwWaT/lBHj2L24P04+6gTFW+aq63GqFZK2ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877950; c=relaxed/simple;
	bh=1I+ZsuBg0UdnoIKEEzTbkQeFlzkeHVAGD2Ztup8Ifyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mjpfB3PYdqHZl9WvqkMyMwhuzT+dSS3Paweioa81y1Q/yY6AxFW1xRcSlAXvGp8U0LMR9zviELC1LCyagTkRFYeA17XRgyCK3VffnGeTr+MYs27VRa74O0oMiftwHVQu4w2VnuHjYj64fEgsL0OcOFTcyG7pi1wiLqYv0oVonvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dSePp/hl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso5775656a12.0
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877947; x=1761482747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sB4CC5zvn+S4YI0MbjpF4L6Qba6coIxIhHj/jqUzm+s=;
        b=dSePp/hloCpjJnKOqB+Wqa6vYAxlJjS4Yvr0PkztXFrsEEP1wK1xrYIugUe4S/DVrD
         wcxHaxsA1i22GY+SKpvGC7PbmbTKycHMlV2dA0nLj4//CYP3FpSgA+mkrUKG1d5pde0g
         NFCp5DXEw2xBbfYSKU0DH/poPshxakQZb9LnNQlz+LgkKg/VasC2UCBS4YvCyygCuRd+
         w/g+gAq+Rx1ph+wIH8Gpg/Zh3K00sVYLjA3Q7Hhgrq7h+8msPUYPZqVppEh1IXZwT9Jy
         LcMs5f+0mPx2JKsLfyfJ6w6Z3rOpMVu9PIZtu2YV9q5rrWDM42E1twxW0bRuZmfGYfsL
         wEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877947; x=1761482747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB4CC5zvn+S4YI0MbjpF4L6Qba6coIxIhHj/jqUzm+s=;
        b=ocf5iwpXC0JxuiaNFaIsCE53oLvWbsbqn4KLuPbJFG4w7/LwFwl61QKL1XdyuceEBR
         pNd/zlcYoBs7rQe6JHDNv02i4EdgaZohkoHtOnv0OcpZQ4hTd8rDvxTXcfTbOZnqewgf
         A62cXIeLbTmtjI27EWL4Co7HhQ+xdmIgRrBwiI9O0kVEPxc7ZvQOni47RBV1Xru/9Lm1
         /bZh3wbLHTJPue+1vPr64omsSnItRLiqMle0dAR46rvqS+BIxCLMu4oF5TndHYz6dImf
         yJZW/SYCJJAdTF/KMDxE9PNKXVl21S7/PX9ZyI+aywWZTJDj4mWWIazmIIclsPQrNe3Q
         q6+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVrsTsoh/dRhZ7g8dqY8STTTjC6oQl4CC7Ny0sfTsgpVE+i6ft7mInKz57FQ/KxMLrTH2itWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmbtpGIBth9BpTB4brlulAwrythsbTH1ngREJJ8UU68PLvgoEp
	c5aUgJ68lhZSvsxmagQiLcnIwOM1kz57WB6ZZ0st1muH2GvGDT4q6s12bLRTMcWWnk1OFMIF+Bf
	dS+rD
X-Gm-Gg: ASbGncvNV4Rn6BFWwB6HIpTxbgOe3qi4kLbCltN/+pODCid1V/uBeIuhKXOKqXckLcj
	AzqJNb1FzRU9gP9zIQrui5sW5sOU8BEf6zVCQvQtpqOX35QsLORJHW9qsViNcGvYxznEXUsq+FY
	UXdWsLu2VTtNMgatt4evWdObZ2fE14o3VQwecdGWrmajN2YIXUK+zme1OVsjw2wMhZTFzro2cuX
	FfsSGMlwNydFace6Y2QR3uVie+KTrB8hvwXZuqb1Si78DnblZ70KlaMD6OQQaN6Psxzq0dPpr3S
	fGJfFs82FAS1sUYFSGHLjsrwq+/MEcn6bOfPji5kMlCciiquT1GP9EKnZXBCSj84OokCxVN6tig
	/AtlPoNn5RisZ8H+wAMtXocFeTI+mBnWVnDUXstB4YWmQ6vWoaEvNIoI2u5nsTuoncAXGXxWvlu
	AbUXM6Ah3HxWR3v6Qy3D1vUjonsDAY601bv1F3Y7xTfmcG0rJbzeghhM47y4c=
X-Google-Smtp-Source: AGHT+IFpcO5S6siaUvsRXvkKHYSNVxPHRFrWWrlCBR9YZZMVkB0ovmLJiuoiztfM+kngKVRTvI2MwA==
X-Received: by 2002:a05:6402:5111:b0:639:4c9:9c9e with SMTP id 4fb4d7f45d1cf-63c1f66c726mr9839827a12.10.1760877946759;
        Sun, 19 Oct 2025 05:45:46 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c49430272sm4118779a12.23.2025.10.19.05.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:28 +0200
Subject: [PATCH bpf-next v2 04/15] bpf: Make bpf_skb_vlan_pop helper
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-4-f9a58f3eb6d6@cloudflare.com>
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
In-Reply-To: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Use the metadata-aware helper to move packet bytes after skb_pull(),
ensuring metadata remains valid after calling the BPF helper.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/if_vlan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index afa5cc61a0fa..4ecc2509b0d4 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -738,9 +738,9 @@ static inline void vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 
 	*vlan_tci = ntohs(vhdr->h_vlan_TCI);
 
-	memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
 	vlan_set_encap_proto(skb, vhdr);
 	__skb_pull(skb, VLAN_HLEN);
+	skb_postpull_data_move(skb, VLAN_HLEN, 2 * ETH_ALEN);
 }
 
 /**

-- 
2.43.0


