Return-Path: <netdev+bounces-242580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 215FBC924A7
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C6134E4C53
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D74E258ED4;
	Fri, 28 Nov 2025 14:20:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686AF227E95
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339657; cv=none; b=LStgHrPCmAvlJTi/A4yiEokyV0Dxukdl6j8cNCEyenZF70g6qiiVqyG7U3LimTGnTd8qk1gK7l807TuN+ahh+F9p/pekPDPdS0VUVFMjcMEhaI/N0Gz5hkQ+yIDD9AzBy7iQnziUs/6punLiYcDa9z3O5yJ9/deoI8XI+H0lnc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339657; c=relaxed/simple;
	bh=dlYzWgdKJezE3ECdVRuaFQ4lSQ2fO+F5ZxnSjSVmSQY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F4ylqzjD3p/hN6JWUYMFDiwH1GUmJm1ZoSDBanhNU6CPDq/3/EWVsV2GXP6bQpb9Q/Q2qD2080pbjSRARzDcUzcflOrk8FSb6uyrU7h3TQLsBExlzEEPUABSd9YAscP9HoH/MnJd8/Oc/JtNAvdkLe9HgG7JUV5mEkjPJPyqFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c6d3676455so594157a34.2
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 06:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764339655; x=1764944455;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrbGLMdK80DjaisbPeaWQi49eJZoN/NohgD7YPqnYL4=;
        b=gyx7/IwBL2/T8vDTinIR6Q4DDbPHijcbHDvvBtSaKplCD+YaCYs8/D7z7xNNrbSbIH
         lgmcbVeX9NsUJCX9cwZrW96orEGFz7O4XPMaBKXAk4NkD2McbHCXCvrh9ah5UKBrJ719
         Sz0WVtCP4bqO2ct8GpC2JH9C+5IQ3j/SivLCzxUBonToKOpwjs4eSwQTGFUN65ERkdQa
         F7uFS88lRYgmJz4jO3qs0Sal/r6OXciLsE+ctEzB4ewaDr/Rp7Exyn9Np3bXYBMUCGLQ
         ujs06seLnodWoRMnFmnC6kpA47EMTrUkU/lm3C5z0BX4KocyDt2y5G5gsA4R6l2xa/lX
         eZSw==
X-Gm-Message-State: AOJu0Yy4cUteyy3JsSZPLvCOfQbCkNslb8B3UwAi1s795+XN6W/l4BPc
	0QM/um/t8YGmkgM9SKRfcIyqjfpwBSJuBgjjXlOomO3ndYwN9jofJjba
X-Gm-Gg: ASbGncufn3fgLV4Uew2EIRm++aymhF4lhlc3CHOS6cCophiw6AzQ0Y05sxmkrfMzXPz
	klhpJyaccs4JO3k9QzGdo6M7iW+fkNn7oov1PZU6NOyk0cNnBJDK+SUIabOMMAasdLzCZFS1SIj
	gZzDLNOEjB4LYIAiB5A6VaiQiX0WAVxcs08Defche9cgw8Lt1pGOqRHAwBAN/fW/oVuXeMXTCar
	YufwBj3TcEN7DKy+JLQaKu6qm0AAMGBMJ8kFgTF7d5qAqaW//VBZZKYHRQEC89WDLxDrlZFeqKT
	qxwVF2UEE0yN63pvTXmLtIl4txafx0aPndYsnfTppm/S4JnrWWhAld91ZOBPJ9E83kb1BE1g6Kg
	veAfwxFZEd89/miYBvnZjdkIWrOz8PlGdkjsjy3obXZFDJwPrlsKk8dUIoDrCdNGaSWGTn825vI
	hDBG5RN+SRqYm0jA==
X-Google-Smtp-Source: AGHT+IEukTJJoSoCJBYd7Ajt13DEto12fjYWxAVqOZ1Kr7K6BN3PDrZk1Z2lUPjn1deToE63cQFX7w==
X-Received: by 2002:a05:6830:848d:b0:7c5:3c7d:7e65 with SMTP id 46e09a7af769-7c798fadaabmr12298319a34.16.1764339655389;
        Fri, 28 Nov 2025 06:20:55 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90fe0f650sm1584491a34.23.2025.11.28.06.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 06:20:54 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/4] (no cover subject)
Date: Fri, 28 Nov 2025 06:20:45 -0800
Message-Id: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL2vKWkC/x3MYQqDMAwG0KuE77eFtaLTXmUMGW3mAls6mjIE8
 e4D3wHeDuMqbIi0o/JPTIoiku8I6fXQlZ1kREK4hMH7cHXKLRW18ubFWPPysdVN8+T7eRhzCj0
 6wrfyU7ZzvUG5OeWt4X4cfy9MjVJvAAAA
X-Change-ID: 20251127-netconsole_send_msg-89813956dc23
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org, 
 kernel-team@meta.com, Petr Mladek <pmladek@suse.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=leitao@debian.org;
 h=from:subject:message-id; bh=dlYzWgdKJezE3ECdVRuaFQ4lSQ2fO+F5ZxnSjSVmSQY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKa/FRtTjWQbN4ZRH8XIGVZNJGjrhySQJN+Bd4
 iKJpTr2BYGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSmvxQAKCRA1o5Of/Hh3
 bZVWD/4lsRjAv6/OKe7Pq8tqjztfFUWCRfhj74SofeyX7dFqSIJ18/CVzl5tZb+rAGAdYFWWa1U
 h4p4Jpd0L6/rRuoQOyvl8y7UnaIcjp3N7LF/ndDQSnfPKR7ebW1ngt8mzGif9GLByLKWNqY0MWc
 xtq3hfp35W5Y3f41XyGqX3npzh+LBUxWsCj7fT8h/YlnDPU1xPUYbh0qgYpE222DCP7NbTe8KT0
 x8+v2GsldnJkdANyrhbNyflGGp8NWXx6veQUkBpirafxXIZpFqy2aOYHckVv6mqJu7Q1rKejvE3
 xTNKiq4xPX7ym2tc1RWEWkQ3qRe4jcIbHkVi4ZeqZK9kaRaXeBcesr09yIrAb0dxQv/AUJj/Vm9
 YOzeumVETujkqCFR34G38PlhB0Amk2oi5gsFEOzKLWfg0cAmhLTBPXZa9PoxkALHRV8BtUzfU4/
 4hZLdPXHA+MBmEL4zFIZ/ABrk8r4HSgEZPiJXfZXea2scpHUQeqtP3LdV8R3MUiogOvG6dpVi/O
 QOmYeZP8VBGgUqUOpYlkz08tK2r5Z73A6nZqujsrFzbex/fM8ZpY4vgBM/F9MaxaOKmtG8fepu6
 ibsjeneE8aso75R4Lu4w6G8b084ssSjIhzhMk3EC3+UQbRX021cMFZ8Hhl4SFaPgP06+/J9Y/iE
 mWQ27034Naq4z5Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patch series introduces a new configfs attribute that enables sending
messages directly through netconsole without going through the kernel's logging
infrastructure.

This feature allows users to send custom messages, alerts, or status updates
directly to netconsole receivers by writing to
/sys/kernel/config/netconsole/<target>/send_msg, without poluting kernel
buffers, and sending msgs to the serial, which could be slow.

At Meta this is currently used in two cases right now (through printk by
now):

  a) When a new workload enters or leave the machine.
  b) From time to time, as a "ping" to make sure the netconsole/machine
  is alive.

The implementation reuses the existing message transmission functions
(send_msg_udp() and send_ext_msg_udp()) to handle both basic and extended
message formats.

Regarding code organization, this version uses forward declarations for
send_msg_udp() and send_ext_msg_udp() functions rather than relocating them
within the file. While forward declarations do add a small amount of
redundancy, they avoid the larger churn that would result from moving entire
function definitions.

---
Breno Leitao (4):
      netconsole: extract message fragmentation into send_msg_udp()
      netconsole: Add configfs attribute for direct message sending
      selftests/netconsole: Switch to configfs send_msg interface
      Documentation: netconsole: Document send_msg configfs attribute

 Documentation/networking/netconsole.rst            | 40 +++++++++++++++
 drivers/net/netconsole.c                           | 59 ++++++++++++++++++----
 .../selftests/drivers/net/netcons_sysdata.sh       |  2 +-
 3 files changed, 91 insertions(+), 10 deletions(-)
---
base-commit: ab084f0b8d6d2ee4b1c6a28f39a2a7430bdfa7f0
change-id: 20251127-netconsole_send_msg-89813956dc23

Best regards,
--  
Breno Leitao <leitao@debian.org>


