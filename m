Return-Path: <netdev+bounces-195515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC52AD0E19
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 17:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6D716D67B
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 15:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1251C84C6;
	Sat,  7 Jun 2025 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+DZPIv5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978136D;
	Sat,  7 Jun 2025 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749310125; cv=none; b=bVquXRCIIaHjfzeK4nNxDtOUbZMRaGLWzvhMaPFR5/tuYQSs/c/hsuBCcvZrrdO/JDxK917R98UKjsoBs94N5mPeyQhOUcutm5e5t/kjizBUMcoH36C3j1XP5G5tqF5WjF+oMe9sReyALdDnTlg15ionQn+uG7x0rfEYy9sbI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749310125; c=relaxed/simple;
	bh=z+jyBC0rDsvIMFnB2CX5hTuZkM0uQU8PSDEQ97J9Fms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msxe/qAPqpK74NiI4tmYekdVwTZfzV+dhCbGlABqBtZ8KehCQo7ZS+yPKtP97a3KFTnkiNOpg4UV2qR94gKXpWKzOUz288L9eLgacT0S2osMMZ9q3n3kMCbMwpIk37AYxQPYir1h65XoTO6C0eS/WUWhaN1zjGUbMNuVNRFZiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+DZPIv5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c27df0daso2757933b3a.1;
        Sat, 07 Jun 2025 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749310123; x=1749914923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+c2fxGTrOu+gHD3RHbFZi/o0nuFFUaAiSBwnrt9ygdg=;
        b=W+DZPIv5k3zkxUrraIUqUJnWBKbw91RGvfgeDFjbPLSRpzgdY24O1EOIMYrEjC3lba
         wavtlk+gqVxFoLLa+ixWSxT9RgBJ0jzXiNZqBPEwAcTxymbWTZYJtXogXowoElgRgxgo
         eANYLY+q6vPV2ztOZpfQOiONQp6rksg35sqMyu5ILOPvqmedsvyikR+AgjCcZwz7j93j
         KAHbaSGMh6IymiJswoBxrlc/9ANFUpmFU3ZYGN2nfXn9kNzmZt+pj/WtaX/61sjd1/aR
         XxkR3H/Btu0qbMD2WxmE5ztRrwx97qYu40yQybY/BfMOjr9ce7fp7ZRjWezBYFRup5Bp
         r52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749310123; x=1749914923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+c2fxGTrOu+gHD3RHbFZi/o0nuFFUaAiSBwnrt9ygdg=;
        b=nuJvpCTlCicvfef4+s0G/B7b4vf6ZCRYImITm2OqMc9A3hmlOi/u5iQZsfEVJEh43q
         nmywkzhKnGU3VAn9DLcahqipbT6UjwtMWwFUl192pb2Q1s1BBeCzm4MjSZFrv6Y6AsHu
         LO3pq6uCcvD/ON46v6Q2cjfuzO+b8slhrf+7a/xEj0AYE6KAno6DJazhU6Wdgc9D1Dok
         1/Kjw7OcZVIBUhbObnmLfboedtZE/ZJdBmsgurNTpL1trIihsV0VBfoi7Jl4PrpsFtGk
         SBDlXnatrG0u3PZndJUYxn1zuOleiFAwy+QabRyL5A23Cm7k1kZJ3/O8gg/69xSFZQU9
         S/4g==
X-Forwarded-Encrypted: i=1; AJvYcCVGj2pNIa+D27LyAxI/4tohYbrrQJkEpqNJA61QALldk356YxxGc0PZUJrqMoYo5S0wpY0n0GgtC0bao3I=@vger.kernel.org, AJvYcCXA0YRFw4ugy6kIJWBdnvQ5Hx2HJO4ufiC3LJ4UiZk5r69KnpxKGMq5I8U2e5fM6YErNm9QUj05@vger.kernel.org
X-Gm-Message-State: AOJu0YzSftKquSbUDi21ZOtSDZb/8OnFeDdg9aL4dNLQCA1pZcvVFmC6
	M/VjMv9Sv5blCJB8VV4lVmqyck6KBNfRpLEEA3sKQr0CZtZN1nr/MeV4
X-Gm-Gg: ASbGnct7Q35DP7hmfNSS4KJbtjkJQjpQyZ/YwniJGg+EXWsfbJf7zCZOWN9EPbXTBsw
	opTTo6LNfh/O1wXQsJNJDzGmnLeVgRJLkujPmijB7Z5OEmlIyHDBK5Ai6u6+fR6YSrVzLlzC2Ie
	00P5PYs+DezPrnZM1ZT/3yrAfhkEbJwasy4x0hzElqYxd/t/Dnq9b3z4ICSG6wmiNXCgHYX1ist
	MP2p10c4ICizpipFgg/zk2dvo/LuJzypWCWrd1CoTx5ar7MM4k79h1wXJCLpH0HMZWtkcHVVK6W
	69+jpsYBTp8QeYieAu7RaFRukayAV3bc3kukQc3fUxiZtxsO2T+WgkWDVbG8B4hSyMhQMBs=
X-Google-Smtp-Source: AGHT+IGe5PvLLkyfOcvRfGoQZO2yM5rs9oLpWj19Gd+8+aRM/ZSBmC4cTKl3EgRRwqh8R4Ru25G9lw==
X-Received: by 2002:a05:6a00:4612:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-74827fa2840mr8940461b3a.5.1749310123426;
        Sat, 07 Jun 2025 08:28:43 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c66:bf5b:2e56:6e66:c9ef:ed1b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af3831esm2965754b3a.13.2025.06.07.08.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 08:28:42 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: skhan@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] net: ipconfig: replace strncpy with strscpy
Date: Sat,  7 Jun 2025 20:58:30 +0530
Message-ID: <20250607152830.26597-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated strncpy() with strscpy() as the destination
buffer is NUL-terminated and does not require any
trailing NUL-padding. Also increase the length to 252
as NUL-termination is guaranteed.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 net/ipv4/ipconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index c56b6fe6f0d7..eb9b32214e60 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1690,7 +1690,7 @@ static int __init ic_proto_name(char *name)
 			*v = 0;
 			if (kstrtou8(client_id, 0, dhcp_client_identifier))
 				pr_debug("DHCP: Invalid client identifier type\n");
-			strncpy(dhcp_client_identifier + 1, v + 1, 251);
+			strscpy(dhcp_client_identifier + 1, v + 1, 252);
 			*v = ',';
 		}
 		return 1;
-- 
2.49.0


