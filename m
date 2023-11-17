Return-Path: <netdev+bounces-48854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7417EFC0D
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 00:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833C2281351
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFE04642E;
	Fri, 17 Nov 2023 23:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3zXSP5z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64954D6D;
	Fri, 17 Nov 2023 15:19:36 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a0907896so3665173e87.2;
        Fri, 17 Nov 2023 15:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700263174; x=1700867974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qmbnEIi9dPNexFhCLMEthS6uAcVCm6VmC8NeVy5h2gU=;
        b=H3zXSP5zQFMvNTVpel+M5maIw6J/ALZxpi7uMOzSUY4O7nrh/6MJvt+JbPdFUI6MH+
         E8epflpWiCukCqtT51+KDUlohT9XeY3xISTbCkqzLSlON+2nNp2qVcvzw8PBX2CgbX76
         ZqW/Bt3s2nWCwk9iQEj2VYLfhMqWcdk5TI5TrxMbZ8FaEScNBYqtpYzCmnvtNd7A9nNo
         rZ3ox3X8DaFe1+4ALqt9zSBWXfB+PDXQvYjeDpQu/swIXSsuNYw3zpIgpWiE9Wh0CV8x
         jyVbVzXK0v/pcUAEO3D4RvWm0/w1hvoDCDpxCHbIgIB5QO3YeHnwjflKf53KYMpRdwWl
         tIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700263174; x=1700867974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmbnEIi9dPNexFhCLMEthS6uAcVCm6VmC8NeVy5h2gU=;
        b=WwpK/dAERhsUDUkk2t4jFdAZFwC1Vx88IahKAzKWapOal2VkMv8yTCBUc2Ljk5hcds
         evPS9ZWE9eu7SqAAbrfc6XGAMSeR2QZRYChlssZfBCXvrDc+1uF2/3JH4sD5SSVS3+hQ
         7cunzS0Nwe+9U1YAJJ1qBjXTl8vo+PcVCDxMcsWCA27dIn9O8o40ArNIL3k2pqdWNVVu
         cqxjtnybL8nKrKo2LhOQxikEfI1yz9/zU0aThAFOHE4SvyWmJZpu8jbKEf4kais2ZceW
         XJEB49w+OWi7BPr6RDvwfwXUL2lQWVbHU0l8pmngeUKEZH1t565cx/aBBWEXmbb5i+p9
         flzg==
X-Gm-Message-State: AOJu0YyYJ8IPvyUnCQ2bU8dJV735nXX7YYIgLfA/yv5T15LdZPXFmhtM
	On6Al3TCcY4AQWTr93BDZUGTGh3nCzM=
X-Google-Smtp-Source: AGHT+IEkenYUznh+RUvSHO6NPZSFWhAddbVKcy5W/yiqSx0jx0cYtRWlTsQOqGAGXt/rqN4clLUWXg==
X-Received: by 2002:ac2:5203:0:b0:502:cc8d:f20a with SMTP id a3-20020ac25203000000b00502cc8df20amr687369lfl.27.1700263174326;
        Fri, 17 Nov 2023 15:19:34 -0800 (PST)
Received: from rafiki.local ([89.35.145.100])
        by smtp.gmail.com with ESMTPSA id q22-20020ac246f6000000b005095881dc1asm377788lfo.87.2023.11.17.15.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 15:19:33 -0800 (PST)
From: Lech Perczak <lech.perczak@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Lech Perczak <lech.perczak@gmail.com>
Subject: [PATCH 0/2] usb: fix port mapping for ZTE MF290 modem
Date: Sat, 18 Nov 2023 00:19:16 +0100
Message-Id: <20231117231918.100278-1-lech.perczak@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This modem is used iside ZTE MF28D LTE CPE router. It can already
establish PPP connections. This series attempts to adjust its
configuration to properly support QMI interface which is available and
preferred over that. This is a part of effort to get the device
supported b OpenWrt.

Lech Perczak (2):
  usb: serial: option: don't claim interface 4 for ZTE MF290
  net: usb: qmi_wwan: claim interface 4 for ZTE MF290

 drivers/net/usb/qmi_wwan.c  | 1 +
 drivers/usb/serial/option.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.39.2


