Return-Path: <netdev+bounces-65107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9AE83943B
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210FE1C237FE
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A82664A89;
	Tue, 23 Jan 2024 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO6dnfc5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A0664C5;
	Tue, 23 Jan 2024 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025959; cv=none; b=se/lHXRMYV7Ak7Q18hUKunk1juHd0trNHfYlfBMaWAbjwrlqancW607ZUAx5+ow3OtNxnPfZlk4LOCdHPZQ9hgxUbnn/dNtjFN5RfJky6BFSUPqWotv05gjIewjGmAsR3+EBv9KtnN36ljlxByao+jhRMZfBbmisQZDh/iCBfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025959; c=relaxed/simple;
	bh=WWlzWq4ogMbA5Bv/ttRCAgp137pwlwv7TucnOnjb4fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwjs1dll15oY8Akkz47fbgUhUunHpJb3Y/rbA/aaE7A2yXfAUJcAkbAjdDeiRfFmLt00EtW1VCPyA9U4HDsoMB9yXPjFkit2oYpRK+oxYY6Q2VDxya3IcqltiYg+aciQEcV1Lo9Fm/bZkLzDgeUqpa9RZBa/q4Z6xjrb2bywzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nO6dnfc5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40ec34160baso2190165e9.1;
        Tue, 23 Jan 2024 08:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706025955; x=1706630755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPCt3LCuPfxhjiLPFiqNs15NK/ZpR78NNqvYkTrubSs=;
        b=nO6dnfc5x6h+IWJC0RlQxW4QLcOdkJF7apd7U1wAluTxBuxxYWaAjChEsp45soosQ9
         FSzy/Mi/Rq0aB6/p14rCJ35ad7xstJvsPF0o3PHIZvLQGHlyqsBwjxw5OCG/iSenNb27
         UXhcxx9/KB1vMoPn+Ltq7Dn3xcfsf0boyILXDKGQ2RGqsdlo4nz68LIFsrKM5EXgwikT
         c4qPHqlD2CRiNISBZJrx4zdnmqhxmvgb/opfz6OIqAtpqqWQmKRy6DzkrehMmRAscyM+
         Jm9cmHnZMm1Ea/ZFGDsA96is0h0QHaBNaBi6eKv3+5e9wpIj5Go0Pu/4KNm9v1iLCVtB
         rDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025955; x=1706630755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPCt3LCuPfxhjiLPFiqNs15NK/ZpR78NNqvYkTrubSs=;
        b=ZEOoog+Zomu4ZQEUQnMVkpIg//JXeBBD9kqQgBA62VVwhPl0kPGmeYL7mxEmoR8iAD
         p9JtVsyLdZkL51+8KjaY7zXpg7kRl7MGDzywOJBctcuGm8TgUGLJclaVCeQ1Q7TFczyU
         Y4EO9zKMeC1989LGsgqhfLomwwzPavJz/mcdbDUlLMYLWXtgOBpYj16cRzMawu7hG7s+
         tCrf5N4OOpyUGqKjAXQ6fPU9w5wQcCd/LUrddc+wT5GREYIoXxzpbrIFiPkXuDZf0Adx
         hy3IyTpzY/uO2UKb9AXpPWYISWJY/24lf+GD/kx3f2eDPEnbdrdW8AaWnioD8h2qmpPZ
         61Ew==
X-Gm-Message-State: AOJu0YzR9DGM6opYT5delLXmoox+JSWf8mhqv0Xtb2in/tAYa8FP3y3n
	A/My0ZXRKdUityuZhnE7EvRAnI7zGEBh9KpWaYfOP0AOAsC1mxN8lpAc72irLlqKJjsG
X-Google-Smtp-Source: AGHT+IGNF1CcHGzMWJ6BVF4PRWOPMgIcgB8Wb3pb4TGBKFY2U8//vkH6JV+3BsmY2EYg7lbBEtFEjw==
X-Received: by 2002:a05:600c:4fd0:b0:40e:b981:db9a with SMTP id o16-20020a05600c4fd000b0040eb981db9amr797766wmq.7.1706025954895;
        Tue, 23 Jan 2024 08:05:54 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm8123830wrr.1.2024.01.23.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:05:53 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 05/12] tools/net/ynl: Encode default values for binary blobs
Date: Tue, 23 Jan 2024 16:05:31 +0000
Message-ID: <20240123160538.172-6-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240123160538.172-1-donald.hunter@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for defaulting binary byte arrays to all zeros as well as
defaulting scalar values to 0 when encoding input parameters.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index d1005e662d52..ea4638c56802 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -723,12 +723,17 @@ class YnlFamily(SpecFamily):
         members = self.consts[name].members
         attr_payload = b''
         for m in members:
-            value = vals.pop(m.name) if m.name in vals else 0
+            value = vals.pop(m.name) if m.name in vals else None
             if m.type == 'pad':
                 attr_payload += bytearray(m.len)
             elif m.type == 'binary':
-                attr_payload += bytes.fromhex(value)
+                if value is None:
+                    attr_payload += bytearray(m.len)
+                else:
+                    attr_payload += bytes.fromhex(value)
             else:
+                if value is None:
+                    value = 0
                 format = NlAttr.get_format(m.type, m.byte_order)
                 attr_payload += format.pack(value)
         return attr_payload
-- 
2.42.0


