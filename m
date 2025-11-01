Return-Path: <netdev+bounces-234821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10D9C27B00
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 10:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AC63AFC8B
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00952BE7C2;
	Sat,  1 Nov 2025 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2KBum1A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0D23C4FD
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990482; cv=none; b=uFsJVRxe20H35kmiYq9k3etbBJOT1IwyCsFMijH5PBOiU0rJuSf/fZsu3AP7WH6s5zUbccCD0TZLb1Z+EFJt7YlkIoj8ozAj9m18gjhZqxfgTn91I49pWbnBAHL2dJSEG3JHzwLKdu6I388W9bI76J2BmU8sHfQfgf8kdRVvk/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990482; c=relaxed/simple;
	bh=WsMaVYjhEX5xzYsbLkIYbNUU/KAzYM8jBkJPwJqvx+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgEOSc4+8l7i231exW2Okx16igbYO+Xbz6dqGFxhMVB9AkiV8Kfn8r8GaGOqmSR8XydFf9Aa4vhiVTZAnJ/ORQYT2TFpogKhAB2BbGe+y13mnTZ7Uz2xENLmSjRduJudTuwtzvQ5OJ+pCA1eKdGdfD/aQI8g+kKi4uKOuO1eans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2KBum1A; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33ff5149ae8so2506591a91.3
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 02:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990480; x=1762595280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys+iXshBYZnizwFhgQPeQbnnGsPPwsLlRfA8FiXKhyI=;
        b=i2KBum1A1oetCqXn/NH0NnP0kM1of8OivYXErx5FS7wf5Ny6rLV6nSuuL2EeZ39B8W
         f4Y9NFPAAcVYr6FMaeebliczS9IxyZHoU+XPuceX/CG8SeVQNII4jeHZ3ydiLw1dl2UO
         yfxMIEkpjrzfmZ5ddQHbkR+VPGJGnsF46AesdYLNDBRustXeFjRqPJGyhDHuOw/DcVcJ
         hzwYzmzqD8LIdbbiLAV1PQtYA5PaW7WvfQgBlyjUpLOQb4smhQEcS1nMx5tGS/ql5LtM
         EcLwk0qLrAamMbgUOxo7lvOPf/VZfMbaWo8+VaarpW0ayar61mFa6EiLXH/OzQgdIe9M
         qtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990480; x=1762595280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys+iXshBYZnizwFhgQPeQbnnGsPPwsLlRfA8FiXKhyI=;
        b=lJC4HlQq/shtWXukR2mbw8CDnsO/PpLi8PlSoFubyCMhikc8JIHcr3ZjGKRZ78VRjc
         X7E6U6ztZkh0aeaIwv8ODSU8IFIkZVXKc+/0FzIl3QrJOCcwXQs/EqkfqnRrrVj8LItn
         Iq/NtzXGy2H1ilWtJrEUVAcG0mztD/AEt4djklWoPjPc+DCxdHqgsHH4cafqjwclLA24
         MPoOGuQrA09lkq2YDxfWLTzl7p5De1WKSiTDrtWm580DmUC/0k6h6TsOYD1x1NOOhsvv
         SlXT8PuB+xvh7KatqXUHl2xHZqOHF0HX5jv3Z6PLvBrbe4nJ78q/P8GFE9vr/x60dvq4
         NPfg==
X-Forwarded-Encrypted: i=1; AJvYcCVcL1uuJ3rJsrkIshf1rNj2ZYgMLT6UdCdISCd6PSubet1pLFleUcHDsxiZzvM+7DEH9m/Rnfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yYaJJ8dXGGFLp/OFWhrNik4xNXLrnxSFzjAGDSzO+mfnud4z
	MlNPzfQ2SxN4H1Say3z0jMkgH/4VrDYLMQECqvIeAgSpB+zRS27253Es
X-Gm-Gg: ASbGncvmxisQILTUn2NX3YQNejQnRkQYmP10W9E9rChUhhb9MbGE9rY4iic1hMoIBD2
	CgSMltwD4rTA33ciDwt6z0guAXz6FYQyG4XNy+28obsmg2bi04wztm+3bGTNmXU/U7KctFdS4wy
	I9iVh9L/4AhiL/ZbXBRQdbQBZ0LBu4TBNhUNL5GCf1Kn6WVgfn8whmQA+fmvv8GtSdmzs5pBdo7
	5+5I1/q/fPYaHhDQzDZM3l+gF7CDPdZD6OFzR8Lq09GG3jtCLPWgLPn9cX28iunzTUbh6vNJ4AF
	HkUcTClYLpNB1vcl0MLLgMbaAB7r95kh9dKFcYbZVbbcAoFXWLFY5K5kC2pbwyM9KqfqnFT9Vyi
	1iX+rcBif8WfX51WXvWnRs/ahMVZw6cEfZ9fjbw9FcRgvmZ1zJzRW8izAnKdfQL3ZrUvnIeGK/f
	Ny
X-Google-Smtp-Source: AGHT+IEuf2OXCpVvj5mt9JoXkTV63btzK3GM762PmBpPq77R+yTBCtQ7CzPQQFc+4UmjQ7/sOnLiHQ==
X-Received: by 2002:a17:902:e5d2:b0:246:e1b6:f9b0 with SMTP id d9443c01a7336-2951a38af0amr90955605ad.18.1761990480237;
        Sat, 01 Nov 2025 02:48:00 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268d10e9sm50868325ad.50.2025.11.01.02.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:47:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 64F3D4209E90; Sat, 01 Nov 2025 16:47:56 +0700 (WIB)
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
Subject: [PATCH net-next v2 1/8] Documentation: xfrm_device: Wrap iproute2 snippets in literal code block
Date: Sat,  1 Nov 2025 16:47:37 +0700
Message-ID: <20251101094744.46932-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251101094744.46932-1-bagasdotme@gmail.com>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=bagasdotme@gmail.com; h=from:subject; bh=WsMaVYjhEX5xzYsbLkIYbNUU/KAzYM8jBkJPwJqvx+Y=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms13Kblm6rb3ryI+T9Q+WPFs0pi1svRc3x2Oq64MTPF 0zlH6+d6ShlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEpPMY/kr62J815jXz/FLd 2HP0xr50vrL37DMXPGjLnBejwvieo5KR4e/D+bXTT/7i4HW9dY7Tc9VR2b5lk1fuPj6N0SA9zPy 2OScA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

iproute2 snippets (ip x) are shown in long-running definition lists
instead. Format them as literal code blocks that do the semantic job
better.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_device.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 122204da0fff69..7a13075b5bf06a 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -34,7 +34,7 @@ Right now, there are two types of hardware offload that kernel supports.
 Userland access to the offload is typically through a system such as
 libreswan or KAME/raccoon, but the iproute2 'ip xfrm' command set can
 be handy when experimenting.  An example command might look something
-like this for crypto offload:
+like this for crypto offload::
 
   ip x s add proto esp dst 14.0.0.70 src 14.0.0.52 spi 0x07 mode transport \
      reqid 0x07 replay-window 32 \
@@ -42,7 +42,7 @@ like this for crypto offload:
      sel src 14.0.0.52/24 dst 14.0.0.70/24 proto tcp \
      offload dev eth4 dir in
 
-and for packet offload
+and for packet offload::
 
   ip x s add proto esp dst 14.0.0.70 src 14.0.0.52 spi 0x07 mode transport \
      reqid 0x07 replay-window 32 \
-- 
An old man doll... just what I always wanted! - Clara


