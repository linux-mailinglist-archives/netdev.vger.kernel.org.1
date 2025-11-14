Return-Path: <netdev+bounces-238572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E08C5B3DA
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 04:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4001A349645
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 03:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BD22609E3;
	Fri, 14 Nov 2025 03:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAznD11j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A4219313
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763092034; cv=none; b=gAmdfHdQ8lhjlp2ddcHvSlUj9fhguxn/prY+n4rNuVE3TYFOhBrRYqFXysQAdioZ9l1HkEB25H1UDK2Z3OyaH1HNgMs3rv3TDfMFt7x6tUazK66TfzOI/lwXmV770y+3bHQS2RePX4BZJDgqoEBeAD3RnrsYhnkkWdRDnWJ5qHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763092034; c=relaxed/simple;
	bh=a3mQP2Xuhuc9vMqDmv8RDKu8+IrewBRRJksEnm7FEXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwSx9LA/I+hXpoe3cxs/aoFmAVQ+PRRo0bxSRm1+t8+rnqSzoAtH7XjRBkwUf18BUA4uee5O6nFNv6CVnp6/Qhlw8Nh21VyrdLreMosb5mh4PmpbBj8K7QnSvU1hYoSBNjRiAkiPjWVbllu4WCbnEi7HYmSo94RSzIWzqyGBR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAznD11j; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso1330744a91.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 19:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763092032; x=1763696832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK8i+NSied8oqhXfoDi5WTsM8+Fd6zB86UHgYvVK7N0=;
        b=NAznD11jNI17lr9t5tM6IPoyo8s5oEePiia1ezvO22U3NvAuH+KER9/f+xSvV3QZwk
         qOqiNCJXEnv5IqVdUoJX4EM4yhJRwMF4NsabXE2+8w/NqT8G2oOab3TeGq1CQyRwHBOu
         L1oIlfsmUeU0p00AAJk6G4im2eeF/hz97GA4EGW8vt7Z23vZsHR6ALQ/qdtf1Dy+Zw1M
         tIXWYrarJ86fZsw2Zm9Bguc1ni4vWep70Q+zLptpLkSdEYEJD+SKchArRrAqZd6g15Wx
         bSONzmXdBGVpLzafU8C0JrSTWaWFzNe/+UZz6KLgT+FIxa6l6LzXCX6zz1M8OPeffKh+
         eaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763092032; x=1763696832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zK8i+NSied8oqhXfoDi5WTsM8+Fd6zB86UHgYvVK7N0=;
        b=CSMqYL5R2dqVBQmn3CetmTN7TE0SaNV1fFq3iw4YBQ4NMW3wHghZn7oMaeVmlFYJH9
         O4aQRMoGueue3Ur7ln0B+WffFSkf9Ud3HEWz/Gfg9vn8EdTkcprWnBc0H7C27C9SuEPi
         x+9sTtJ5ZiAiQ3P07DKVVdY+7ElYFZm8bDUfIeCX3pt1d4wTVo///4F4UFwhhj5L86y7
         gp/GCPl6BY7vQDq204DP4oezFOXCD0J6wSNO9LO5WiFcQu5R148mfNqz0O4PmWOGh9gY
         RE8KlXc6ogoKU3olOWk3gpe4C47QLwJwWoWLZlITLMHh/hQuDF/KAeLo64tMxQop4HAE
         lEZg==
X-Gm-Message-State: AOJu0YygYQHeG9QhPqiGfSZ6+ViJr4FJ5hqLXhd01Ovmg8ePjbA1KlMm
	+nZ1Pl2tHcjfnl54j7zQzDUZFGuJEkJ86zEfBuR7hhB7CsNgBSnfHLS9+g3P3MmLX9E=
X-Gm-Gg: ASbGncveysUy1jLzjs6MJnvvC68EC9CNNrlRwmtdg3ASCPekfiptHzl/Yrpys3/j0Va
	wHVb0bHWFue/qgcWRrFcEFV5KxD8bswn8c18XRGZCvBF7r3/bZL4VAgI/FZ1k5EIR89LamVt3TE
	M2Tw+AFu61n5/TRTsnF8+ckEzllWr1poVccc+M75CDF3jizeQhZouvNmsSboYcq+ofd1/ulYUGP
	YYc8O9e62Jx9JL5hP4ZsQTzExJUTUDvDigfLOfoIYlp7+ll2++bYrGNyoEcqipRGLmovj1PjJqr
	wyxlq7fdoAIkdEKx/gl6cFYqVCZqHy9FvIL7bsGFWcZjlcW1XJCAhwTQqNajvA3vxwRl8j2pOcF
	IL3WdEdvWgfouDM70ZWVA4BfC8C1GJU/vqgiqnT9lJMwTuO8oFiFdajl7SV/tfqeMMsBs0WTfpp
	5lA0K8
X-Google-Smtp-Source: AGHT+IEq0QKs4rCZhmQxUcEAHnhlKNvo36JAT0i7V8MaWjKVVQrR14dmU23T1XnBEK3D/AGNOoWEdA==
X-Received: by 2002:a17:90b:1c91:b0:340:ad5e:ca with SMTP id 98e67ed59e1d1-343f9ec96d3mr2129675a91.12.1763092031845;
        Thu, 13 Nov 2025 19:47:11 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927826273sm3669756b3a.52.2025.11.13.19.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 19:47:11 -0800 (PST)
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
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 1/3] tools: ynl: Add MAC address parsing support
Date: Fri, 14 Nov 2025 03:46:49 +0000
Message-ID: <20251114034651.22741-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251114034651.22741-1-liuhangbin@gmail.com>
References: <20251114034651.22741-1-liuhangbin@gmail.com>
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

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
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


