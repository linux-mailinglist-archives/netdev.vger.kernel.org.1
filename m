Return-Path: <netdev+bounces-233843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9361FC19226
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4C6F5851FA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5471431AF14;
	Wed, 29 Oct 2025 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L13SktAy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9439931A567
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726185; cv=none; b=u09ya0Zl/ENYd6wX8LobTA5EPCB+HzUogfKuS/FFqdFSavSDlMbEnefpUJVZ/fK9lkXeSUxl/IgdQly9PIGUBwYLk0MPioeAaJ02Qog8KFeeaq/mt3eSlE3hcTcz0yAMRYyKS9jrHkEPtY1ruYp/8Qe5AHLFSotxHy9DAK2SN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726185; c=relaxed/simple;
	bh=utVy6JvlKERgKujYhOgnVpCTFIWZ2va0wC2CkiqbEWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzGrrsx5yom8gQ7sgdXw1i6HAxicXkTSFdFaFueeznpw6pAea5mA/GTGQtH4xaxuXa8dGDYc2HSjYR/cCBtUm6dfG1UWurh5yqSOz5SQa/DmMPctW0f7FLrqsaWoz72uJcD3NL+zA3iyytqZXr4aUCEdvpswTuK+0OEX5y6IJVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L13SktAy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26a0a694ea8so49799975ad.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726183; x=1762330983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za7hYkkLPLqSVT9uZfocsnw3yWLzRulvJUyGOCLkCKY=;
        b=L13SktAyCHfKdAyKlRiuooXieBpv6wayTeNRFob0aYzBgir8FcLsTd3mZI1pJt84Z+
         ioiKiVTSZqRFjOcgjZG306hH139i8Pwqe3tvs2rqRSneboUCRp0QlUrq+tFZsUBvrMnO
         J6bomQ1zYJSUc79e/tXNpuncK2C3RvrRH9YF1a8Ea6rJbFYGrXktqG/XXb3CSDUkRgI6
         2lBgBv4LrYYV9LWibtYeEfmC+RfMNzBzUOEXlODZAQ7diGMNIos+5s8qyQ0sDaTHatsk
         LL3j2VbDBcWKe7xVtFVP20dNPcZb6Vi8ZOnrHYTS2xxIef2UlV4yzPJM29FivK2QIcKb
         +75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726183; x=1762330983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=za7hYkkLPLqSVT9uZfocsnw3yWLzRulvJUyGOCLkCKY=;
        b=PUZcnPmDy3T7K+0W4Xi2n9RrPTqC93RECGLFMimqJkoM7DT0soDbLyb97Xk3IvAJOV
         KZCiTxU8SSshiM0AkdfSvSNdiF7PFaELMLjopues/AIxCzG5RtDBPh2Be0LeUJ6tnn4R
         q3/OB7ZknwReQkNcTG69hMVSgq4c+me+F4PoAPMkqPeYFWZmcJSmTeL5BeaAREg7C4Gi
         vD7mTMzEF5Gu2l8BWIVUDl0h3MsNME56vD5GaZhS/1gdSFoNLdW4OwsXXbXhk3rTvjxQ
         O3fMfbKxj6uw5++SvuT1FVNm1KJBMG6T/TrwLPcjDFKv/YuNzF5w61WuslNlgQEIQeXr
         h+9w==
X-Gm-Message-State: AOJu0Yyc0BohfewN7cZbhzzG7u4T9ngAC+XiUIoS/H1kXoroieYZT/t4
	0mpSwoHVtdj6RCKG9u8tJWduaVdjRTLGFzI3IOHxxeb4gZzFBySyf/UkNLTKxXI1qqM=
X-Gm-Gg: ASbGncvva7wXEWVC5aEdSeUglcqGfpc1GSOWrKqN+L4uZ2wGAGcqE4MytZF03M3FOiB
	WqOqUPNQlR62cdzCtke9r1hm2NwLktHoL/QDM6ZeDJefdPbXCAyMn/TQaH9IuDX3b27GG4I6myx
	qDQSKqAkzkGr9PHJV3W3nwG8WTxAwRf4aZQbFeQK2/l2GGcQVRmdCbvlgmUutwH0HnIHhIpe3l4
	ituoXgNn2SUjWw/+eAJbjcsrk0ieNnZVXBvp58Koupb/3ww8fpvyRbZz/TKHRaxXAbGySHpLf5S
	TCvAUvvtXOWrR6tNp8FaCQWoAT9ff6zbqT61TPSQxn0hbjSOVJDrnr74SEJXhekge0EkkRxWEYX
	ZtI7ea7m1Om1oDCpHgZBCJ+FF+6jW2Z9nXOZSs2Xja7w+W4frdmguH9912Ng4phst0bKjLd9dau
	vN2tH+VawKdxmEnd4=
X-Google-Smtp-Source: AGHT+IELDLicKMzwVGPxSzunKaHjKZ5b7HNcUcQ44DbmU71BO4kqKnfk4QDr6sZzaqPuCrB5RxEsvw==
X-Received: by 2002:a17:903:3d0d:b0:290:78b2:675 with SMTP id d9443c01a7336-294def46d76mr24636355ad.41.1761726182753;
        Wed, 29 Oct 2025 01:23:02 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09958sm141906005ad.24.2025.10.29.01.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:23:02 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 1/3] tools: ynl: Add MAC address parsing support
Date: Wed, 29 Oct 2025 08:22:43 +0000
Message-ID: <20251029082245.128675-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029082245.128675-1-liuhangbin@gmail.com>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing support for parsing MAC addresses when display_hint is 'mac'
in the YNL library. This enables YNL CLI to accept MAC address strings
for attributes like lladdr in rt-neigh operations.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 225baad3c8f8..36d36eb7e3b8 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -985,6 +985,15 @@ class YnlFamily(SpecFamily):
                 raw = bytes.fromhex(string)
             else:
                 raw = int(string, 16)
+        elif attr_spec.display_hint == 'mac':
+            # Parse MAC address in format "00:11:22:33:44:55" or "001122334455"
+            if ':' in string:
+                mac_bytes = [int(x, 16) for x in string.split(':')]
+            else:
+                if len(string) % 2 != 0:
+                    raise Exception(f"Invalid MAC address format: {string}")
+                mac_bytes = [int(string[i:i+2], 16) for i in range(0, len(string), 2)]
+            raw = bytes(mac_bytes)
         else:
             raise Exception(f"Display hint '{attr_spec.display_hint}' not implemented"
                             f" when parsing '{attr_spec['name']}'")
-- 
2.50.1


