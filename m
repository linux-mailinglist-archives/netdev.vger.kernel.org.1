Return-Path: <netdev+bounces-240605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEB0C76C1D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 01:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A57704E3EFB
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C99266B6C;
	Fri, 21 Nov 2025 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EbQR1EcS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1725C6F9
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684472; cv=none; b=YfKvYYfXqotmCzA+x7GXAGfs0Je04oPSpJIla2anxILfPTTa4GXLCANYxzuypHxK6IUGnthsxWSNKkySHEEB2RiU0E0lidHfP+SvSJl/qAX1DFMqj5nDxJzc35MFsHpgIax2N1mac3XHUfEPcNSfEsq1uxaMT4+9RY2Ir9xOPCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684472; c=relaxed/simple;
	bh=TiJ7du/bJLVd7FrcVB1Wn5eLmGQO4LJpoZ81v/AlVB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kksB/yeL1FzCdgLQhHxwMfjaq1DEab6xePBmSeUL4KQeiNIWtHveNKD69zGA+hMKJX4O54sDCi4uJwrOmIPwIgjcd4QYBDysOUZrhg2ASxeM+FyMj3g53wGspJ3eekUIPO+CaUhOTT1usyw9J/bLeq/hjyiyS+VemHgGu/9SmbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EbQR1EcS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47774d3536dso11358085e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 16:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684469; x=1764289269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReuLHRL+g94kJe1OeakAaiS5olz1aE0z/OwRB/MABw4=;
        b=EbQR1EcSLo/Q9Ost9DLYz6sI35sqZudpn0a89syuOsRR2ynlor1HRMibI6LZHSPR09
         GFuDWchBuw5vlhqeAUmWv2NCOcmuHEGYH1SELwsHFhrrWaGoIhTZZMS/kPfI2TyEMy19
         EAjDAoYK9VfufsyZo02tVo4bqJomcrIIYjZ1MzVhu0SfDRc0iOaJFv8mRed9TKy86FUn
         dUV8GvNYcCnLrLQt4fWsVZon2SYGfgKus22sOouDu0jUyVtHkQZtzS8O1reYemoMP8Ib
         HiTpS7AL2HvNBONwUmKme/r2sC2DwL4BL7DMXSYBDc3oGjjXOFxy7i+q0U5MbhLRTwIe
         6+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684469; x=1764289269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ReuLHRL+g94kJe1OeakAaiS5olz1aE0z/OwRB/MABw4=;
        b=wKAiYzJ1QE0yLDZ3tjjBlQvqsMlvxhY5G2auIGAOE0YuPe5y2XxjqKnvs2gTjqLumx
         3fmShtoD/QgnCwjs6MuKZdQUctMd9dWS0QbHgXhANgtiqoDj+YD0RgCQ86upzfVuf5HJ
         w9V4QWRGnDFQFbkuq4xNcGFY/OGTJ54M+gJpqUQrs0OG0vPlQQhlMb63pBh1Xj5NlBMR
         tX159gUVK0RB9F/y/esrNuX7063zxpM33DhVjx6pSzxwNNIyLXo72KkuSpKX2njnkWFZ
         zeoo6wwGq2QFhujAnJIMXIKiRNDjbW9TxPQYdPM9ICacvTB9Ek6/0cPSAHMdiAJlRKM/
         rDxw==
X-Gm-Message-State: AOJu0Yw49DrOHUgsG3icvaxB3T4G/iZ43Yj/UomuAaQMG4FHhhJrzX14
	PaNDsKrI8TkJHW133HzDggAuLma/dczne4mhdFjbyEVX11GgVwyLxNGepkL4hNuX7iNJpggnKNF
	QzQ4P2gRiEOnvNpVTNHVS60g7QHAK4stuXN88Zs6KRN6lqz/LMpb+cnhkkmdxHx05o3Y=
X-Gm-Gg: ASbGncs1aOXpb2ySLSAwKuhxUSsbRGKIU0MsZMRPXtWqTV0chjHTzkfpHa4MNwhQNy0
	uUnbIgZBZbB/I94+VGNjc2HtVkSLVNJkU8sPxA8C3r6thbFslqdwzbVY3JieTmvMV6VgpeLgM/H
	hIaKmho/dZ+AzpZQUh3UPupWP/udAtF3vzhhIuIk5jIikO2cAX381YKI47motwCv0U7wSXtDeGA
	vP1pQsXH/9fhv0x3elaYrRcs94jeMYxovwtzhaO+O6boTQhT4XCZRcee4o0h1kWhgCAw+RQEveY
	FwXmrRwhvyqfmTwql5bBwHjTkTI1xeI3ZVW5P/okp+LRTC89amC2f0+zMM3or83OJMw5EhiDw2P
	8tFtUs7mL5UrGPaMihDBJTsaMEZ2ueV+SqrJxRG/lqpTwoobZV939vzdAWQfNjU3VZNBSVBspgV
	1nDSym/e0ZOtAKn3EooP5cMLnR
X-Google-Smtp-Source: AGHT+IH8XqCKH+TSnVSR28auuUzdlBLcuSIXO6/h7JjbptXpvxDKudJz07hsSDrN7rxf3d3NXdsPXg==
X-Received: by 2002:a05:600c:6d52:b0:475:dadd:c474 with SMTP id 5b1f17b1804b1-477b9ee479dmr30081365e9.10.1763684468839;
        Thu, 20 Nov 2025 16:21:08 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:21:07 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [RFC net-next 10/13] ovpn: use bound device in UDP when available
Date: Fri, 21 Nov 2025 01:20:41 +0100
Message-ID: <20251121002044.16071-11-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121002044.16071-1-antonio@openvpn.net>
References: <20251121002044.16071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

Use the socket’s bound network interface if it’s explicitly specified
via the --bind-dev option in openvpn.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index d6a0f7a0b75d..328819f27e1e 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -154,6 +154,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		.fl4_dport = bind->remote.in4.sin_port,
 		.flowi4_proto = sk->sk_protocol,
 		.flowi4_mark = sk->sk_mark,
+		.flowi4_oif = sk->sk_bound_dev_if,
 	};
 	int ret;
 
@@ -231,7 +232,8 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		.fl6_dport = bind->remote.in6.sin6_port,
 		.flowi6_proto = sk->sk_protocol,
 		.flowi6_mark = sk->sk_mark,
-		.flowi6_oif = bind->remote.in6.sin6_scope_id,
+		.flowi6_oif = sk->sk_bound_dev_if ?:
+				      bind->remote.in6.sin6_scope_id,
 	};
 
 	local_bh_disable();
-- 
2.51.2


