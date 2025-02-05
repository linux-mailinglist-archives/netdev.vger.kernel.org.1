Return-Path: <netdev+bounces-162882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F09A28452
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 07:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B65F18853E4
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 06:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671FF229B12;
	Wed,  5 Feb 2025 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="rQiSpLAK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF3227BB2
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736570; cv=none; b=KsQtDI1Dqe9lqho3oax9513W/rmnmcZAETt2BYWInb/gWs5VE24THXK4UDhCLataCUbX1PTq4e4FMuhUmkBzgKM/yKnVCEFMJneCEI++85FvW/kz3YQoQMAMsYG4PT3swrerX4PAG02Yk1ep/fhw8hPPa0WoxFii3u39ru8RY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736570; c=relaxed/simple;
	bh=OvIPYK+g9j4h856snHiOWJ7ZQgHA0nLVU5L7vERmbt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gx/FjLypLRHnxSQIpWl5wBUirtYSdjPmxRB5ilQB1hSY5m80WDZgDpI4P4euByOQORYclRsB+Fjn/D6vwd/HQdd8QH+yD2DXuACKav9xXOX2o5qiCE4r0229vdgcAn/1TTTosthdsTfRbCmwAy+GnkyNBi8rRzn7IM2JXwkcuE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=rQiSpLAK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f169e9595so7486635ad.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 22:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738736567; x=1739341367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3Yb4yc3CLfLvYu/aaxzBml3Yua5P+KV0PLbqfrkL/0=;
        b=rQiSpLAKLYhgPz/Dq0zwIKV8znShlql2iGSmW+6IMuMdpGfWlQEaVwWGaP7U4lg7q5
         ZkYRyXEP4+X5CnhgHKmAccQd5+NS0mWeHh3POI6xr9dU7xPdg84T6OSWGcg0DFdjygh5
         uDUPePRXftXd9yj5jyi3FLWSZqhVN3scuyHxheP+PcRNP/NS4cYdJVRLwhn8zwTy04qQ
         OL0AinXEEcLMxrhJBwW48m2qaUsIk5JNxbceO5wn4Uq4wUzx8dk+KT9046JGI3hcqQCv
         8JjkrMRHXWvRs7OsGjLChRdrPgqw+chuT66d/4qYv/15ze0IUEBnHTLK1AisM9iAKo0k
         m0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738736567; x=1739341367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3Yb4yc3CLfLvYu/aaxzBml3Yua5P+KV0PLbqfrkL/0=;
        b=Mai1u9IzAIynEXHpT43AnlKJRMuFm2VITK95H4UPVW8tIdYfI3QAtBOI8dzL38SbRM
         mN8CcnyZiaSF4MR3mKDO+Qkjt5/xzYQfiOtOavATobUZDqrXVeFhIgy1mkCRXnejA6pn
         rl9dUDj/UdwsjRDYux2cumWGvrApn3Cp+MHz9aIrSFjP4jseJw2flerMeRkLzjZ602QR
         6hQIofF1V+zNEwIcoBf7qgaE+B4FDwGReDJ40O53OuhR/tqGwzEuEL9GB/MVsRiZKTPo
         +yIEwSBCBgGAcYjApBF8nOGqcD74zhxhIwx1cL1/qbSFb2l4yjet5pKShcF5WP4Jn7P1
         aSSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8gha5O1C5PHXNDc1FsTyeAOnj73k2StLzwFMblWLzgeeJ2KQV0hNaLbQavaai6QsadAO4zGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+pM0/1h6zcWZWug9BU93tNJnCYThoeJOWoihasKvzLSkxJPi
	xWhWZqA2f32tlwcI9gDiAs4LaP7xjC6W1bH1DhCX5LFolNFuiuJOJe1fPu0UDOk=
X-Gm-Gg: ASbGncsygeIxK5m82II8Nd36z4KVmFRsdYF2iAVf4o56SHoCrBSZXA9Oy6ur4kv7Arx
	fvbNCEZn9cgUEU1IO47fOjtHgD22nvn08GOcXr4t3w/sjnJXxP6CsWhpi10HnSx+OLesDJgJWb8
	4h4Iq9hT2wd+SZY6fVrNd/nAIPMWaMNOjaElPwfj+Mo24TJotUgwwUhrxT5JoG2SycLrqcpjw1N
	JAeTTEc/WqD7ecDPWoIbOR19S7MRTDncODFKTfQIctY0lJuUstukTw3xBROnJ0gQlBFWBwFEg96
	C9kXAZGqVOaHZzyQ3fs=
X-Google-Smtp-Source: AGHT+IGzWVq9qQMR0OtpSV0vC3qHwySYobptxhoMmB1piJ2/BjXgoNAU3mlOXjwt7ZL5XD+44dzxog==
X-Received: by 2002:a05:6a00:2e1b:b0:71e:6c3f:2fb6 with SMTP id d2e1a72fcca58-73035101c2bmr2780925b3a.8.1738736567160;
        Tue, 04 Feb 2025 22:22:47 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe6427309sm11714424b3a.43.2025.02.04.22.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:22:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 05 Feb 2025 15:22:24 +0900
Subject: [PATCH net-next v5 2/7] tun: Keep hdr_len in tun_get_user()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-tun-v5-2-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
In-Reply-To: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.14.2

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/tun.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 452fc5104260fe7ff5fdd5cedc5d2647cbe35c79..9d4aabc3b63c8f9baab82d7ab2bba567e9075484 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1746,6 +1746,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	struct virtio_net_hdr gso = { 0 };
 	int good_linear;
 	int copylen;
+	int hdr_len = 0;
 	bool zerocopy = false;
 	int err;
 	u32 rxhash = 0;
@@ -1772,19 +1773,21 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		if (!copy_from_iter_full(&gso, sizeof(gso), from))
 			return -EFAULT;
 
-		if ((gso.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
-		    tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2 > tun16_to_cpu(tun, gso.hdr_len))
-			gso.hdr_len = cpu_to_tun16(tun, tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2);
+		hdr_len = tun16_to_cpu(tun, gso.hdr_len);
 
-		if (tun16_to_cpu(tun, gso.hdr_len) > len)
+		if (gso.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+			hdr_len = max(tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2, hdr_len);
+			gso.hdr_len = cpu_to_tun16(tun, hdr_len);
+		}
+
+		if (hdr_len > len)
 			return -EINVAL;
 		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
 	}
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
 		align += NET_IP_ALIGN;
-		if (unlikely(len < ETH_HLEN ||
-			     (gso.hdr_len && tun16_to_cpu(tun, gso.hdr_len) < ETH_HLEN)))
+		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
 			return -EINVAL;
 	}
 
@@ -1797,9 +1800,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		 * enough room for skb expand head in case it is used.
 		 * The rest of the buffer is mapped from userspace.
 		 */
-		copylen = gso.hdr_len ? tun16_to_cpu(tun, gso.hdr_len) : GOODCOPY_LEN;
-		if (copylen > good_linear)
-			copylen = good_linear;
+		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
 		linear = copylen;
 		iov_iter_advance(&i, copylen);
 		if (iov_iter_npages(&i, INT_MAX) <= MAX_SKB_FRAGS)
@@ -1820,10 +1821,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	} else {
 		if (!zerocopy) {
 			copylen = len;
-			if (tun16_to_cpu(tun, gso.hdr_len) > good_linear)
-				linear = good_linear;
-			else
-				linear = tun16_to_cpu(tun, gso.hdr_len);
+			linear = min(hdr_len, good_linear);
 		}
 
 		if (frags) {

-- 
2.48.1


