Return-Path: <netdev+bounces-190693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A133BAB849F
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5949E67FC
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7453F298271;
	Thu, 15 May 2025 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AFQUTVj0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C887298C14
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307679; cv=none; b=BAU5i7VS8r7sK13PKKgsxykBfLHyC+tSX0H64Z2Rh1wdJ13+HYbU5GXKNM8+OdKEBfAGm/Ih8mNTDvGm3ZtmpO8JzQDUus87iLvNA+XsfqQ9SpiBkgHt0cb06Ws3qVN6N99YHL469YA2jn4fz3i+lg/BrkFpBtkV9S7jYNsZtt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307679; c=relaxed/simple;
	bh=1E4oiIOli/V+aD5b0ZtnXBwi6TZQUNjUxEi2bOzap/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYhnPCdSTBeAV5bWNo6SAqG5mTabmgKXhGk5g2cvR/BhKz+mPFeKrJ0It3RQEH9YP04xA9cTes+oyrwWE3Dr48b+eetVuU0ExvqNJXRAhgfbOryw/ZWxTWGbjQF2LlB/egguvclfUwNMqPPfmEkUC6IysyBSQpf2V++xRQvostw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AFQUTVj0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so6515455e9.0
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 04:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747307675; x=1747912475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1thfRx0P4OMA0aXvQAnyREXbXGbBd80rGLJoPpij78=;
        b=AFQUTVj0k4ybIXFVpfhmebd7qWTluL1elClkrahDcFLy3E9rz/NMp1upBRBazk7gnu
         onUtiMZTi68REfdBixf2rFhUpHBxxKOsWqMmRTpPjnhq1kAfcsnrjVsB5xFpkFeUkLHS
         w2TacnIGvv1Ov+eRiZ3AA+ygS8KkfuUyFOpZyLtce/rYZ2y/Wfd09YlEGEC/OuxHteLc
         9Vv8koBrBorKvAZkCDzhAtzuizexASXM45heji4nNRxste8hM3QaDhxqqNPuiMZ9Dgyp
         KUj/kQIMQl/cNaEcKk9XlOW51xKmHSBZCFwj3xwzK+E/o9rzUFpP2K4u/2/UatALHs5Q
         AUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747307675; x=1747912475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1thfRx0P4OMA0aXvQAnyREXbXGbBd80rGLJoPpij78=;
        b=qntBwGtytZTzaOaGmw07xLxTJujNld6GaulCdKjGsiEz9LaUketYcf0gbbxora86XQ
         Wq+2/ujTeI9x/m6MetRmYjNOUBk9GW/T81beEHH8wB3G+0bfD3HG+HvsHcgdbP9nG5A4
         4PbVU/4vYQrs1PZtZCjtvXczi8QCgqwt3Lll0Lqo4lOjs8luNI/hmym6Z581LO5L7k+J
         +2EV+OsQctZEzez8qm9cZcHBy6SCdXROYxMavrsP0uUxnqHuofjgvA24ypUWjaDl1D3w
         k2LHbz0uU99/MwUGa+pB+MswY70BPqviqtBdxpr2TqBAwodIsGH9qUkQqn32ZX55lj+K
         Tb9w==
X-Gm-Message-State: AOJu0YzJnmAOLPUvJEoGCdR/HLp3s11NbDlZcU9bo40/rcz7sB9ZpK5A
	DJ3WtF6/W+T/qjQrEE4DVqhY4K/jSe5erweapmYnfPeiAm+VlzOdg+oTBA4FqPfnmwE+6YzCbFv
	q3CPrxnyBfKSCGsi1IOb0O0XhE+dhWXrwLHVN8yS55dRiugPu+IEv5Vm2Hw0S
X-Gm-Gg: ASbGncvN19DAayiI/WB5PJGzGK8r0R5Y+YUt1hZqXd0UU58ERRuOvBT08Yh2RUYghXF
	YZfMsyargfTdFqQHGQ+W7wN0aA4FM1MKmEaYO4aJflW0vm4cohlmWCOBC6B80bzUimx1upgNxWA
	9R0ZJokQzobOHSAbrXB3SlxuDWprs0DGQ9ko9iV75dcByw6ieaXnrV+JiNq3nG1Jc6dQvvNpql5
	2DmyOgSDbj/UzLrvHwqxNyjiYPMn9pKCfDraxCT21Ka43RfKnPivO1VaCYFm/JCeU6CW+YOOs4W
	EFUZIZeX/O8YsOqKoMcTBCTyTp3khoWt+ioghk+6HvKxvnFw3npoB7YwN9L+dvcnJGkHltLHHfo
	=
X-Google-Smtp-Source: AGHT+IEQ+3PnjlJ440dHuY6nbuZUBPG92fZ1LZe53h55gbkQ0e3VjsbiWReP8NbYjVg3UqVkIysM9A==
X-Received: by 2002:a05:600c:a009:b0:441:d228:1fe5 with SMTP id 5b1f17b1804b1-442f217a0b1mr57606745e9.33.1747307675206;
        Thu, 15 May 2025 04:14:35 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:d81f:3514:37e7:327a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8fc4557sm24321435e9.6.2025.05.15.04.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:14:34 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net
Subject: [PATCH net-next 10/10] ovpn: fix check for skb_to_sgvec_nomark() return value
Date: Thu, 15 May 2025 13:13:55 +0200
Message-ID: <20250515111355.15327-11-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515111355.15327-1-antonio@openvpn.net>
References: <20250515111355.15327-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on the data offset, skb_to_sgvec_nomark() may use
less scatterlist elements than what was forecasted by the
previous call to skb_cow_data().

It specifically happens when 'skbheadlen(skb) < offset', because
in this case we entirely skip the skb's head, which would have
required its own scatterlist element.

For this reason, it doesn't make sense to check that
skb_to_sgvec_nomark() returns the same value as skb_cow_data(),
but we can rather check for errors only, as it happens in
other parts of the kernel.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/crypto_aead.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 74ee639ac868..2cca759feffa 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -88,12 +88,15 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 	/* build scatterlist to encrypt packet payload */
 	ret = skb_to_sgvec_nomark(skb, sg + 1, 0, skb->len);
-	if (unlikely(nfrags != ret))
-		return -EINVAL;
+	if (unlikely(ret < 0)) {
+		netdev_err(peer->ovpn->dev,
+			   "encrypt: cannot map skb to sg: %d\n", ret);
+		return ret;
+	}
 
 	/* append auth_tag onto scatterlist */
 	__skb_push(skb, tag_size);
-	sg_set_buf(sg + nfrags + 1, skb->data, tag_size);
+	sg_set_buf(sg + ret + 1, skb->data, tag_size);
 
 	/* obtain packet ID, which is used both as a first
 	 * 4 bytes of nonce and last 4 bytes of associated data.
@@ -201,11 +204,14 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 	/* build scatterlist to decrypt packet payload */
 	ret = skb_to_sgvec_nomark(skb, sg + 1, payload_offset, payload_len);
-	if (unlikely(nfrags != ret))
-		return -EINVAL;
+	if (unlikely(ret < 0)) {
+		netdev_err(peer->ovpn->dev,
+			   "decrypt: cannot map skb to sg: %d\n", ret);
+		return ret;
+	}
 
 	/* append auth_tag onto scatterlist */
-	sg_set_buf(sg + nfrags + 1, skb->data + OVPN_AAD_SIZE, tag_size);
+	sg_set_buf(sg + ret + 1, skb->data + OVPN_AAD_SIZE, tag_size);
 
 	/* iv may be required by async crypto */
 	ovpn_skb_cb(skb)->iv = kmalloc(OVPN_NONCE_SIZE, GFP_ATOMIC);
-- 
2.49.0


