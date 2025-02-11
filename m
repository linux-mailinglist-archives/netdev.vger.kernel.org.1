Return-Path: <netdev+bounces-165279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5791CA31663
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534967A298A
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE29262D14;
	Tue, 11 Feb 2025 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="twsj5kPc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20911E47B3
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739304367; cv=none; b=cOOK3IHMJX8kIvu86qVjcda1hUL6y7eWBAK082xnVrMzhKToW6DtVrzms90Ldg/TxkW6XelMev6FMhIANeg8gHMKwuAOAEuUHiUaYmDYN4DGIvcIwFWYcQZTcN6HLNbt7q8XG+BPF8Ch0zw02cw+bNnCU49CSy531YEbVoDBDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739304367; c=relaxed/simple;
	bh=ft0iTXOlvHUjc3hz8JBZEHUjPHt9IGzMRpYUZVq8nDk=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=hjCK0UvcrSrenxM9BHhXdJ5rImDtzg1eR9XSbzX3lY1iZp/C27JeXgHBPpRj1fTp4i9ILEgXI1Lyj3A5YRfFIqUuoPXU/YOtMdIwKsg+TnvrFuspmgVFSKMw8mZReCD8GYNEt6Z6FPdpucxBulaU5h40eWqzOPsRPbe2aPlQsPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=twsj5kPc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1319678666b.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 12:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739304364; x=1739909164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nxkie6yLM0q2pX+0WAYEdeQeZkDttdl+fqsW8wL2k/g=;
        b=twsj5kPcxUDuVWjBv9vg518yUWxM4dXIEiKPGZm0+MKODqD8lGnR1yluoDEsaV/3vF
         ogdYolUyq6Tou1SUyRnYa9bIpNA+eXIQT2oCuhYfJ5GUpkvAemGwXuMGjNCkj3/sFpGI
         0FvoD4SEOUh9RuzTr04S4Q194TuiPUGp0bGeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739304364; x=1739909164;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nxkie6yLM0q2pX+0WAYEdeQeZkDttdl+fqsW8wL2k/g=;
        b=oZzWZwhf+VUGHE0Oxr0MGsUAbSKoxCncIl52dLIZNHg1ipOMIHAbKx9GM7mmP2sknp
         IzHvyeeMs9ysc4k2MfGm220jowZDEXHolv8RrTbbmVYkX/hdzwXZk4iH88Fl3iJJRJ/K
         MmIEYHrrxVObVTkBHLiHDONfqCJwnTGLovAHSiy2N6VljUznhkJtEjL/Lgi1w4wR7rEk
         XdIX5+DiEwjVLulD5w8i8+23KS7NUhL08gQl+0YN5850pxn2Rp1R+1zGaTEtTpBGhjeD
         jcF4swq+exOUrYY2vX62fEIMCVTrROtMHpr4t/69Xa4oJYnNCm3NdzIFjioCPGu4HgWQ
         X8uA==
X-Gm-Message-State: AOJu0YzWLbo3PeNqv3nURe6vzjwF4QY4QJK10cXCIHmVkmvfFJDfagkX
	+9VZ0AKIYzDGCQN+kPl2ofp7PUDR8Wrvzr/zUYgLaB3EYA0VM+pCNPrRFgRMwWnEhfVW4QaTp33
	KhJM0IdpLpZvyJCgFo5qQZPB5h8fkEZsAnx25UrAX9VAhRLF+WXI=
X-Gm-Gg: ASbGncvtrmvHE6XSCJuulnPSjbZ2m95LoJYUjIB4xsgsoTCSE1Bxxz4EqwwNiT4NC/S
	WzMUEbE1b/HjWEq9ye72UQ7FJ5QOl0KbydAioiuVuFmL80pgCm697lIopWaevP9IEb5UzaU4Ii2
	Pmn4V/qSOWiJayV7hDGsM1zknC
X-Google-Smtp-Source: AGHT+IHoKfgQCKWZr7QsjqOlhYz8Ox3tvPFbg93XOMkmh6ra72F9JlcLUDZxrph5gh4NGZsFZXFolvtA6RlQNHopUqo=
X-Received: by 2002:a17:907:6d05:b0:aab:8ca7:43df with SMTP id
 a640c23a62f3a-ab7f347db66mr24967366b.39.1739304363872; Tue, 11 Feb 2025
 12:06:03 -0800 (PST)
Received: from 155257052529 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Feb 2025 20:06:03 +0000
From: Joe Damato <jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Feb 2025 20:06:03 +0000
X-Gm-Features: AWEUYZm9IYCWBJGOUEwrC9uMXesN9YSdVvlwLoAEoxsHN8IrvsvNvDyqzWHbUjM
Message-ID: <CALALjgz_jtONSFLAhOTYFcfL2-UwDct9AxhaT4BFGOnnt2UF8A@mail.gmail.com>
Subject: [PATCH net-next v2] documentation: networking: Add NAPI config
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, rdunlap@infradead.org, bagasdotme@gmail.com, 
	ahmed.zaki@intel.com, Joe Damato <jdamato@fastly.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Document the existence of persistent per-NAPI configuration space and
the API that drivers can opt into.

Update stale documentation which suggested that NAPI IDs cannot be
queried from userspace.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - Reword the Persistent Napi config section using some suggestions
     from Jakub.

 Documentation/networking/napi.rst | 33 ++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/napi.rst
b/Documentation/networking/napi.rst
index f970a2be271a..d0e3953cae6a 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -171,12 +171,43 @@ a channel as an IRQ/NAPI which services queues
of a given type. For example,
 a configuration of 1 ``rx``, 1 ``tx`` and 1 ``combined`` channel is expected
 to utilize 3 interrupts, 2 Rx and 2 Tx queues.

+Persistent NAPI config
+----------------------
+
+Drivers often allocate and free NAPI instances dynamically. This leads to loss
+of NAPI-related user configuration each time NAPI instances are reallocated.
+The netif_napi_add_config() API prevents this loss of configuration by
+associating each NAPI instance with a persistent NAPI configuration based on
+a driver defined index value, like a queue number.
+
+Using this API allows for persistent NAPI IDs (among other settings), which can
+be beneficial to userspace programs using ``SO_INCOMING_NAPI_ID``. See the
+sections below for other NAPI configuration settings.
+
+Drivers should try to use netif_napi_add_config() whenever possible.
+
 User API
 ========

 User interactions with NAPI depend on NAPI instance ID. The instance IDs
 are only visible to the user thru the ``SO_INCOMING_NAPI_ID`` socket option.
-It's not currently possible to query IDs used by a given device.
+
+Users can query NAPI IDs for a device or device queue using netlink. This can
+be done programmatically in a user application or by using a script included in
+the kernel source tree: ``tools/net/ynl/pyynl/cli.py``.
+
+For example, using the script to dump all of the queues for a device (which
+will reveal each queue's NAPI ID):
+
+.. code-block:: bash
+
+   $ kernel-source/tools/net/ynl/pyynl/cli.py \
+             --spec Documentation/netlink/specs/netdev.yaml \
+             --dump queue-get \
+             --json='{"ifindex": 2}'
+
+See ``Documentation/netlink/specs/netdev.yaml`` for more details on
+available operations and attributes.

 Software IRQ coalescing
 -----------------------

base-commit: ae9b3c0e79bcc154f80f6e862d3085de31bcb3ce
-- 
2.43.0

