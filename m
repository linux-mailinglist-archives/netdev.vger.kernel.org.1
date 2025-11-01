Return-Path: <netdev+bounces-234822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F80DC27B09
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 10:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1915C3B241E
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033A62C21ED;
	Sat,  1 Nov 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWI0kLND"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26E219303
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990482; cv=none; b=iUMi4BOqQrNmDUQ9pPxxh+U+ps8dcfjgnmkASelwwvMKKe38nsSV8ALKvsf2k6CpLWLzU6E/9WtgDXiiRC6Yon0pplINY0RNQ0bg3kGyWRnhxIm3BizsvRjV2+2knkM3WWn3FlC/gkEEJ3jM5ghvVP5jVcbKmIum+WQ8SsZBvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990482; c=relaxed/simple;
	bh=jBrlYcqe70CRFPI8eWpEHN0i3WJ0kusKzZ2MB0TsxBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkNsU0QqxKbU6V4KC7RfHziqBNypVYdycvVgYzcfWianQImaI/xmUegFdKQcUlmV2Vk8RUvIv7RWcc9qVVcmLDNwgeFt/sI/MZq3xr7ifWL6MOVVS+xJyDmM3+Rk23ek1Z67mjNRYD7Xu0SKeRKfVkPlWC15wE2Hf8UxIP9a6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWI0kLND; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so4189723b3a.2
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990481; x=1762595281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lh5XxpkroE5dbbQU8eQ46vBGwFwM21sJCPsPPmpqn7w=;
        b=iWI0kLNDq0YVYUEvGD4n/ernbNX8wov24hfn67Ze73ActdyyW5tCL2kuidCd311M+v
         pJbDsUxjSBOTtnjF2g608v5CSqTh2Ce9J58jzkgQIgJKgeV0/P7s4ZYXnnqMJLAK7IJ9
         YohKRbGe/Cyoe7B+h2ZgZtgCEcmarpv3rjE81wceIFVTFxB2WqpXzvwumAK/l2qht3xS
         Fwlo+qOy5PREHWLXXK50+Fui6kOzMEIAS1Bm4mDw3KyOxHT2u+TL+QU0E2vEEcJaTdtz
         QEyXPSbmw5kf0FSZQ4yI/0vTz9maHolKlmCyTO0C2IVx/ugemoW2gvceiNP8mdYl91sy
         oDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990481; x=1762595281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lh5XxpkroE5dbbQU8eQ46vBGwFwM21sJCPsPPmpqn7w=;
        b=Q97v2/qRanV+KPmrHtEzJLi1ZC7VD9gasG6KEGiAi7w/vmUVXdg6aCU3mzz2VD3e+1
         Vfucfplm3V38Fo56jyHoYmp1Qfzp8aR89HGJH1/NpMZRIDXCRAmji4LOpLJV8y0Op+Oo
         c/bsWo6cVAMCjsQqxnQMPN8xHESqdUPCjh++RpDURifF0PcG+7NmcQuiLV4OI6QrYUvT
         ABB85NnShYRyDDf37M7wAU7GETaLYDudv2clEMIOD9QThUA1J/4dWqfFgNCZODJbZQcY
         TAZzq8D4dGLKXL7T42AzTVsUtc+hurfNYKCEcg0P9znK2zfBqiin6LS7abQhRZyR37BN
         S5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKT4uJOXS7WsMnU3Y1B7pa8diGfV/tSoyRMwv/TUmuaFD/yvHfnqHuhJF1vfnMWOnAQKLoRLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJyzwb8Xg7Csp399/va525RhFL8mYhL/KKIE18uDn39jwhwtP
	IebiXjznrWuBH0Wd5a7ngBUGiwOjSnAIcRAMMSGcUP29vJ95v1+w27AT
X-Gm-Gg: ASbGncuR7HktDzyPIlRe0Ajs4QsTNShdbHFovtAv+KI1Ng6OeQMACHM+E6Ow4oMxhDr
	8uKk1XY7cR7FuQG0A3/GJ5ZDSnAnI5TDfG13cuP4mMtX6B0I9B7mV4ZD2lbiTA/nDCXIoVZHHvf
	NkkmNSLcfQmbFVwXdJZeuLHCd5rmV02NA0EjY0ArGAhrdhC8rt7nmDc5TRVdU9V+qWp+8ZrlBEX
	axf5ftC092cHDhOmWUMr6SAC5yAPJJDDIIchKA69oKYRTkQSDx1NPZNZ4RwkQcaMnlomZRNKhxG
	SatbYkru4EwjVNzoH1Ff3LYcLS+UmxNY4nRvbNa/HHrNIXSHyPYmdnuhw/Ajd4VnjAhY8lq9gpe
	Jlt9txhhCCwqAGIY/4w/CMjzVp0S47SOYRsUB6kQSPcCip0iUrT6MpQw4vfbFWnmWpB5xyAR+Xu
	mW
X-Google-Smtp-Source: AGHT+IGpZ8T1BxXQj+tbJHhY/gv3ZX3xWUHXlnenPWSDSg5J509xuNLz5YpbVfswDuRWy+McMfmuBg==
X-Received: by 2002:a05:6a20:4308:b0:340:fbd5:15ae with SMTP id adf61e73a8af0-348cca03eb6mr8335718637.47.1761990480655;
        Sat, 01 Nov 2025 02:48:00 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67cbdfsm4802995b3a.49.2025.11.01.02.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:47:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7E23C4201B81; Sat, 01 Nov 2025 16:47:56 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v2 2/8] Documentation: xfrm_device: Use numbered list for offloading steps
Date: Sat,  1 Nov 2025 16:47:38 +0700
Message-ID: <20251101094744.46932-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251101094744.46932-1-bagasdotme@gmail.com>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=bagasdotme@gmail.com; h=from:subject; bh=jBrlYcqe70CRFPI8eWpEHN0i3WJ0kusKzZ2MB0TsxBA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms13J35gp+ZJa+2bAoSvDmR+96dvEwhfae2W3d39dl1 ukkzdzbUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIloeTH8Myn1yi+4rL9gmeQe 2WtnAuqnr5HkjrzZ1P1ZyPy4TM0sE0aGF7tjvMTqzaYFzHguxN/9N/N0SfwippfKF3kjv/QuWmX MDQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Format xfrm offloading steps as numbered list.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_device.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 7a13075b5bf06a..86db3f42552dd0 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -153,26 +153,26 @@ the packet's skb.  At this point the data should be decrypted but the
 IPsec headers are still in the packet data; they are removed later up
 the stack in xfrm_input().
 
-	find and hold the SA that was used to the Rx skb::
+1. Find and hold the SA that was used to the Rx skb::
 
-		get spi, protocol, and destination IP from packet headers
+		/* get spi, protocol, and destination IP from packet headers */
 		xs = find xs from (spi, protocol, dest_IP)
 		xfrm_state_hold(xs);
 
-	store the state information into the skb::
+2. Store the state information into the skb::
 
 		sp = secpath_set(skb);
 		if (!sp) return;
 		sp->xvec[sp->len++] = xs;
 		sp->olen++;
 
-	indicate the success and/or error status of the offload::
+3. Indicate the success and/or error status of the offload::
 
 		xo = xfrm_offload(skb);
 		xo->flags = CRYPTO_DONE;
 		xo->status = crypto_status;
 
-	hand the packet to napi_gro_receive() as usual
+4. Hand the packet to napi_gro_receive() as usual.
 
 In ESN mode, xdo_dev_state_advance_esn() is called from
 xfrm_replay_advance_esn() for RX, and xfrm_replay_overflow_offload_esn for TX.
-- 
An old man doll... just what I always wanted! - Clara


