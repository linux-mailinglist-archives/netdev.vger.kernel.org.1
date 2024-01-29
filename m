Return-Path: <netdev+bounces-66894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415F8415C2
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33FEB23A11
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422CB5B1EC;
	Mon, 29 Jan 2024 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+zzDs2j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3854666;
	Mon, 29 Jan 2024 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567736; cv=none; b=tWYaVv3ruSU8s7XrvGmf6s0x2i5Cq9nhktnYUdUQWkw0ZmergoPdKm9nkNwyVt0QIjRMXHw3TGU72z3dWl/XBOS1dnCOi0UhmXGxkDTgbxxZ82szKplof7mqP9fa1K8blqdQp7Rhb6ifLX6iJjFMPeh420TqPvGwmQcQw8iP3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567736; c=relaxed/simple;
	bh=/zsXTUB3sjsImCCK9upNqx8I9wVeovJbph39RKjkwx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBTTBqhjvOdUJw4K6MW8sjJDBsRpcBNYpbtzXJBmypaaJ9tqY+nUS9O+5vzpjYBvfW8jasTu0XM4dXSCZie+x7E4lI8gQSP6CF0O5zJWz/8/rhBWuZ2AQ3P22rVRQ1enrKF4ulobwMVnjL+s25iZ4cUbI+yo8374UOZWIFfWWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+zzDs2j; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40ed356a6ecso29309795e9.2;
        Mon, 29 Jan 2024 14:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706567732; x=1707172532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqSkYHAmR43l7wpB22/dLWRzx8oLOkfvDSmsds3Q2K4=;
        b=X+zzDs2jeGvGJcWJPXQqPtvoAkRpc5cJ6987kgqMM7EQr7dpAJFJ4oO07c/2SgZf9a
         3CcS8Ls6zXvpOzUa+xArqWVQriSfPKqBtz/y8T34MkuiGEaV94YpIV0mao10oLuxY+Kc
         F+W670lR8nqszqZsCEPiBjlAMYZuLUs2N4BF70RUWaJRgHymKnCw/wxbU2FJIijsV9/k
         wW0fPFlz2y5u61NF9kFMSYmstbHcfovyK38CAdyQSPj6g2K93JI60mq3INdXZuj+iZw7
         yt1vV+EI9wqC4ryXh3dUf7TnJNpL4rvKqnRdfmsxYAnBRgWJsAWPd9kvfZcoxcju3V6p
         28bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567732; x=1707172532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqSkYHAmR43l7wpB22/dLWRzx8oLOkfvDSmsds3Q2K4=;
        b=P+RkmYyTNO6DP42Lglfa0nxlpRMDhKhjOwYlHsEe9OhGwXGy38NQtOkYxPXaF5sQyo
         GqKPTiWLe1dJWoMPmKhyKFf7n27JpHd+D51vH1ZIAO7l16SVxYtRaw5ZYSg6JdYaWqrO
         VBdRt8lc7x8FS9Dq5lsdt31ORTfnYbIql9PU+2tR1g3X/Y95OJ5yuUdiGLcpU4ZYdGBn
         9r34xGmY01n+x6+rXielXR+Xbr4DCdc0okuoIDKiJJ+prRk3aM9FmRrawtEiQdzPmfcZ
         rKjIP6CbfqaneMcDtH68j5Egi6H7NfSSMqF2P5J4+hxHmm9u/YeSDJ0+njkrJ6kWaqe9
         BN0Q==
X-Gm-Message-State: AOJu0YxitKApvF/s+GqnCCn/j1cxPTbzoOQMxpuwbaaJ373rS+6P2lNY
	QdRI14SFcxESvwAyv+jAsxo7WUoAyJykdc2kjrr1Hvz+++0qEI23kU1sGm1k0lQ=
X-Google-Smtp-Source: AGHT+IGFR4Pfb1zlHg1h0N+vtD1O0WHmdcvf/w22FftA+PBZvJeX0mHNgQrPEi1nCuEoj4ThBSj4iA==
X-Received: by 2002:a1c:7914:0:b0:40e:ccca:33e with SMTP id l20-20020a1c7914000000b0040eccca033emr6275758wme.31.1706567732462;
        Mon, 29 Jan 2024 14:35:32 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm11357281wmb.1.2024.01.29.14.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:35:32 -0800 (PST)
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
Subject: [PATCH net-next v2 11/13] doc/netlink: Describe nested structs in netlink raw docs
Date: Mon, 29 Jan 2024 22:34:56 +0000
Message-ID: <20240129223458.52046-12-donald.hunter@gmail.com>
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

Add a description and example of nested struct definitions
to the netlink raw documentation.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 .../userspace-api/netlink/netlink-raw.rst     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/userspace-api/netlink/netlink-raw.rst b/Documentation/userspace-api/netlink/netlink-raw.rst
index 32197f3cb40e..1990eea772d0 100644
--- a/Documentation/userspace-api/netlink/netlink-raw.rst
+++ b/Documentation/userspace-api/netlink/netlink-raw.rst
@@ -158,3 +158,37 @@ alongside a sub-message selector and also in a top level ``attribute-set``, then
 the selector will be resolved using the value 'closest' to the selector. If the
 value is not present in the message at the same level as defined in the spec
 then this is an error.
+
+Nested struct definitions
+-------------------------
+
+Many raw netlink families such as :doc:`tc<../../networking/netlink_spec/tc>`
+make use of nested struct definitions. The ``netlink-raw`` schema makes it
+possible to embed a struct within a struct definition using the ``struct``
+property. For example, the following struct definition embeds the
+``tc-ratespec`` struct definition for both the ``rate`` and the ``peakrate``
+members of ``struct tc-tbf-qopt``.
+
+.. code-block:: yaml
+
+  -
+    name: tc-tbf-qopt
+    type: struct
+    members:
+      -
+        name: rate
+        type: binary
+        struct: tc-ratespec
+      -
+        name: peakrate
+        type: binary
+        struct: tc-ratespec
+      -
+        name: limit
+        type: u32
+      -
+        name: buffer
+        type: u32
+      -
+        name: mtu
+        type: u32
-- 
2.42.0


