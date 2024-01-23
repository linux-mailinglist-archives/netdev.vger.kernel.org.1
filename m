Return-Path: <netdev+bounces-65112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC221839445
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBCF1C25C73
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623496BB20;
	Tue, 23 Jan 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYYYrec5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D66A34B;
	Tue, 23 Jan 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025970; cv=none; b=coqG44skJxTUAjSfj4iO/lNDjUezyfD/x5b+yCzASu7kRla8M0EzHHIZTcxDlauND+u/9Pt00qyZeiFv0Z7Gn4lSZboYcvuSs7B1Zs6ZO090BP529SW4GBFb8mUcdFF4mSWd9DoGCBeyPJf5WMwXtm0de6PwH/R11xJ1FiaM/jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025970; c=relaxed/simple;
	bh=V3+5S4rk6FEBta28/vmz1BVv0vhjbWZ588SlkhoF+6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4i/pJbGoUgOwia6LPxFohRN2Y0lsejH4LKFpDx74xu8XUFoqL6mMb0N3yNAkd6vVjjS1VLMjP3pE6qwQO+LufNwvJLr5wESNpptvZJfPhwXFHV0vQhBje/39VoBZN2a3sWsa9+axit4g3qxcj9bc01WJzi/It17Jtr5GNztc2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYYYrec5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so4574205f8f.1;
        Tue, 23 Jan 2024 08:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706025965; x=1706630765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/XVIEYy5evfGmhxOHljdtJwUAo3rOHzIbpX1J17qo0=;
        b=EYYYrec5Pf04goJaWf1YfBUbfC34Hxd2YkHqrCmfosCQvEa7jlg0HpyPON8bzJ+V+I
         P/ZhA2WISI8RUwelshWePcqHeq+8COCHjEANy6h7jJ8a5hcDhefRtBwVaS6e6EcyUidG
         w7mkMl52rgvlDM3cemm9ieduSIlbIK7NSnciSdngGPNd/9axeqdryt7Q81NUgyE+H4z5
         EJeR7Zc9KWOWW0uvXWHMRw1y/4yhOnWVFfav/KKA65G1fF9120OaV+lbzuHeQzxSY2Tt
         fw7x1hAGCLnUPXY7Rn/HFjtWWVqZ1/6E8ixi/dt5ovnBUaSDB1T8oG0H0t0KE1SkMAGp
         krdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025965; x=1706630765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/XVIEYy5evfGmhxOHljdtJwUAo3rOHzIbpX1J17qo0=;
        b=fAcoEaEG8MZBv7t1O4q6hbW9s1uj/B5Cf0SatJkY6+a0NaadMhXW8GpPIiXICkrF3b
         sIQr5ii+CFE7l/noutqnFCmoxJnJwtCRzI11jWZavO2X9r8oTei3cUafyQRixZ+KtZjm
         0vNXZX8EcTYvpwuQBJWbXmXkRhKB7JvNgYm6DUVAI7q+pB93HrRH7L8F6J+BmQN2gFBY
         MiyjYg4vBxaItzpAqe+Ged9FLAkc1pXSTr0hmCNX0KSHPjZhmDMRsFMQmAutVfUtyHO0
         ksS8Qsr2VjKqbzEG2IxR3gYouMlIErH/8X3XgAXTJq9ZA5XiIqSwpJRjy+MOjn1NwynJ
         sHTQ==
X-Gm-Message-State: AOJu0YzoZpfdIsLweZAsGQB06XQjBtFSztpOZtqurBV8lt4pwBcePTBY
	oJOz75izKyvlbBSCxiUfCpsQnlPt2FaImH6ZA2E3VHF4umYfN4aY6iu/sCKQPfi12d95
X-Google-Smtp-Source: AGHT+IF5UGjohAJ5ro+4uehknauclV6WuTP5b/sa7lqenf2WFhAI1b/1VHNlZKVhAOfXM9HblCL0fA==
X-Received: by 2002:a5d:40c4:0:b0:339:48da:a15 with SMTP id b4-20020a5d40c4000000b0033948da0a15mr464228wrq.76.1706025965516;
        Tue, 23 Jan 2024 08:06:05 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm8123830wrr.1.2024.01.23.08.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:06:04 -0800 (PST)
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
Subject: [PATCH net-next v1 10/12] doc/netlink: Describe nested structs in netlink raw docs
Date: Tue, 23 Jan 2024 16:05:36 +0000
Message-ID: <20240123160538.172-11-donald.hunter@gmail.com>
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

Add a description and example of nested struct definitions
to the netlink raw documentation.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 .../userspace-api/netlink/netlink-raw.rst     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/userspace-api/netlink/netlink-raw.rst b/Documentation/userspace-api/netlink/netlink-raw.rst
index 1e14f5f22b8e..ecf04c91f70e 100644
--- a/Documentation/userspace-api/netlink/netlink-raw.rst
+++ b/Documentation/userspace-api/netlink/netlink-raw.rst
@@ -150,3 +150,37 @@ attributes from an ``attribute-set``. For example the following
 
 Note that a selector attribute must appear in a netlink message before any
 sub-message attributes that depend on it.
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


