Return-Path: <netdev+bounces-66889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819898415B7
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD2B28A487
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E6853803;
	Mon, 29 Jan 2024 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjsSPFgN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698EC4F88E;
	Mon, 29 Jan 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567731; cv=none; b=L/lm1SYE8PT1bU+s8Rwf8BZ4RaOffGXKo0vJ0RvMkFXUYQQAEyGRIc1yJSVTyi07PxQnTAWyJMuyA0H34fU0OS8dO2wEtORxPgcfZLC/+JIqhGzo0PV6+N3tsSPyzGAlg/drcqlFBbXMS/TKu4rYygcsb0DFN01fSgbx8jYxXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567731; c=relaxed/simple;
	bh=ZASf48694OrEmuDePErvbVSLSggReyyUKqPIO7O3PJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uztYdjVkahSSqzY+xU71CrI/PV8Wm3Rwiq1f79wmkbv64yIyaKL9aed7as/jkKEc710a17mdN/aCFuwYbKhT3Fm0dISPsgz/FcJRoGp+OekuC8yAjSArpip/kmZCim3GEW5bPbZNj0J0X8Rc9qhHHXm36u+PWO8m+/7InupWgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjsSPFgN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e800461baso47412935e9.3;
        Mon, 29 Jan 2024 14:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706567727; x=1707172527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFL3pgYoLnlV7dRNW/O+RioCRgfWEC9qcVky3MedcLo=;
        b=IjsSPFgNA6w1MOGMYXPo+vU7qsSzLDpB1seN18GXz30mle4L7rw/1LVbWc7qBFHxMa
         Ury4/N8NzgFutcje4UAfFBwpEsylsKVisg18iE65tKAy+WC216WqlPzieLe+dx9WsXC2
         RQggVU5t/2I95gYDhb7YpLyhB0yPSJ83zzvO6SKUfom5RroSjTywUMD+2eTjRyoa6w3u
         UCX922bPF442W9mTrvu7t9keGHqoRkzNR4dV4AoZsxcd59Hf0PLvu5RiTgOOzvAj7sc6
         mFwURxIRQvn6p12OOmFnvXlJW5B1Jwi2lBJ3yaicc9Pbdzp5VEt7IDJQYEv3WF9PX4s9
         tQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567727; x=1707172527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFL3pgYoLnlV7dRNW/O+RioCRgfWEC9qcVky3MedcLo=;
        b=OjdUmPZ7/z/s9Lzy38+idpYexJ6nXBREIT5F7bzKJPJpYagJjfDEc/4OvyIZyAcE02
         QKCpg/QW1yASNRxHMKhvLcg3GK0dyrH++ugzTeY57k4/k/XaUZQEW5RwI11BzaT7lmEJ
         J0jjx43QB0p+xH9eeh61xbmtcnPg/kXCsXr+MzzFdwFGRBb2w27V+A/e0glQWLozP+To
         qvcC1KE7xx2fUeM3MNL1+efwwUDwiY6o18d3S9XZakAkcz73BpVe3GFmMf05Pu+x/thJ
         0rLK7w6werHWyGsb8iIrDzoaDi2Degebk/nS4Go45eul5CA2TjfLSrimM8iw9LYlFjDX
         PQQw==
X-Gm-Message-State: AOJu0YyGvCLMnk71r7vLmI0vssg5m621vIJYtflDZBMyDntA/G9pf1FJ
	gE5RbdimHmqB1SY8hA+fxlnFJ6DcqrccBo/mQo27kWkCpdIqGFevQH3KXK7P/rE=
X-Google-Smtp-Source: AGHT+IHCh02Mtuqjh2ITXAJ6/WFwFQdpBis6XGKqpnJ/9SLLVD4MwT7cex2KUkDqLiUoAcIY0exYkw==
X-Received: by 2002:a05:600c:4754:b0:40e:a39e:461f with SMTP id w20-20020a05600c475400b0040ea39e461fmr6482057wmo.38.1706567727322;
        Mon, 29 Jan 2024 14:35:27 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm11357281wmb.1.2024.01.29.14.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:35:26 -0800 (PST)
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
Subject: [PATCH net-next v2 06/13] tools/net/ynl: Encode default values for binary blobs
Date: Mon, 29 Jan 2024 22:34:51 +0000
Message-ID: <20240129223458.52046-7-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240129223458.52046-1-donald.hunter@gmail.com>
References: <20240129223458.52046-1-donald.hunter@gmail.com>
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
index b063094e8a4b..d04435f26f89 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -742,12 +742,17 @@ class YnlFamily(SpecFamily):
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


