Return-Path: <netdev+bounces-65110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 085FB839440
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6141C23488
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F363A6281F;
	Tue, 23 Jan 2024 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEsypYZy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E666B2D;
	Tue, 23 Jan 2024 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025965; cv=none; b=daE2165przretvvr+EHD+eywO65hHLJ9alXjBVVjV52zd4QM5KpCzSFHYBbpFJmm+UIszcCYQGXM/m/CLy6aOIdV4hxIubr5B1Lsv5HrpmVoFZKEDj5xk25xvIPil5eRauPO5Z5tClD0Y2Nqq/MOU8pDBBA2dnKSFES49xhOxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025965; c=relaxed/simple;
	bh=gYpSoNVwYSUHAQ4vAEn0J0gwqp4tMtngpsxCMyrgN2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRL7SsKBjiSFB3/35U+U+wvqp07LXzsNaINHBmSfz4+r22OZniC0vNRSVtymBNyv/k7y5RPdHBgbOrw7wnIsyISszgpW03CuBOg3he1aMz5/+FdMKZG9rEaKAM05fWsXZ9XRF3W9Xjn5rmmj998Ov/pJABMscP/SAO9irbym3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEsypYZy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-339237092dcso3235363f8f.3;
        Tue, 23 Jan 2024 08:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706025961; x=1706630761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iq26HBINM2nU3+AvRmdY5V2S4741Z9krycPhNrWN7d4=;
        b=QEsypYZybh37YTnPNvLWZ0GPqjqTIyh5xWljSet+Two0NVgitUkwwP+0XAPrYGTOxt
         5/LIXyACfeyXoex/4qf1ny9pekakMcmLHE7ejBGPfhSc/t8I5lU7j2AJO0A5OrHzHGbX
         uaPUU6o9feT/xIHmt4tiOX0frj9Hx0I2iYlE1L0tkam7m8ceLNZX3qFdsYcVIVUOzJP0
         HFreTGS3Fk7ZOTEq22GmxcxgJMHmxkvgc0k1Jc7844nMrB9F1R086eDE402aO7rn67nh
         f4L1lnATHa3mQFeDBFMfFSh2uS9/BgHVAb17TNSplqaAc7IpPRSptLeWDJhHyjwow4hk
         xxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025961; x=1706630761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iq26HBINM2nU3+AvRmdY5V2S4741Z9krycPhNrWN7d4=;
        b=nKzgjm5XFxF0Lj1w1QHZrVKzdWe9lc15ZLimKGiGEt1Sna0csehEn6AQMgLTDEqfeF
         biZ4leGvHrlK9XssZEUI1IhsddtV/BcqleiJPlYy2q7zVvEc8FtBP4xVbVfheD+5z8Dq
         fAp6PSoqy1NYtc4eT9Zr12agLKZlkNblWiE55zqeh8ZiuVHQlnV/psfrRftoEqPi/87W
         QWCNqmwWN+p536573CEEdAZGwOQNxF1+jjNQVN1/iQ+ol0TRlgQbljGfGKsL2lrUvs9b
         o6xO8eZjEAPZvc/PwpuQt6HrU45W873nSM0f3dVw/QQtdP/zGHUrAiSMH1fm5EXNhTH5
         181A==
X-Gm-Message-State: AOJu0YyLQ1j/FqcP191iPKqdDFWQwr8S+WT9Au3mpiknX7qiP/paW/sk
	fX3vt134yycTiG4qY8PCcdeX73RXAX2AuftrhOUY1HPFwFZr2SFIeybaGVDphQMeJRpv
X-Google-Smtp-Source: AGHT+IH3nSlrRChsNweeRViM9IA7fRAxb+PXaNuYkXAD2g6UukKIkD0ln6ADhImZtu/Mh5ikOx129g==
X-Received: by 2002:adf:e58f:0:b0:337:b56f:caf0 with SMTP id l15-20020adfe58f000000b00337b56fcaf0mr3689217wrm.47.1706025961395;
        Tue, 23 Jan 2024 08:06:01 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm8123830wrr.1.2024.01.23.08.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:05:59 -0800 (PST)
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
Subject: [PATCH net-next v1 08/12] tools/net/ynl: Move formatted_string method out of NlAttr
Date: Tue, 23 Jan 2024 16:05:34 +0000
Message-ID: <20240123160538.172-9-donald.hunter@gmail.com>
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

The formatted_string() class method was in NlAttr so that it could be
accessed by NlAttr.as_struct(). Now that as_struct() has been removed,
move formatted_string() to YnlFamily as an internal helper method.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index f040c8a2a575..c9c5b1fcc6f4 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -113,20 +113,6 @@ class NlAttr:
                 else format.little
         return format.native
 
-    @classmethod
-    def formatted_string(cls, raw, display_hint):
-        if display_hint == 'mac':
-            formatted = ':'.join('%02x' % b for b in raw)
-        elif display_hint == 'hex':
-            formatted = bytes.hex(raw, ' ')
-        elif display_hint in [ 'ipv4', 'ipv6' ]:
-            formatted = format(ipaddress.ip_address(raw))
-        elif display_hint == 'uuid':
-            formatted = str(uuid.UUID(bytes=raw))
-        else:
-            formatted = raw
-        return formatted
-
     def as_scalar(self, attr_type, byte_order=None):
         format = self.get_format(attr_type, byte_order)
         return format.unpack(self.raw)[0]
@@ -510,7 +496,7 @@ class YnlFamily(SpecFamily):
         else:
             decoded = attr.as_bin()
             if attr_spec.display_hint:
-                decoded = NlAttr.formatted_string(decoded, attr_spec.display_hint)
+                decoded = self._formatted_string(decoded, attr_spec.display_hint)
         return decoded
 
     def _decode_array_nest(self, attr, attr_spec):
@@ -696,7 +682,7 @@ class YnlFamily(SpecFamily):
                 if m.enum:
                     value = self._decode_enum(value, m)
                 elif m.display_hint:
-                    value = NlAttr.formatted_string(value, m.display_hint)
+                    value = self._formatted_string(value, m.display_hint)
                 attrs[m.name] = value
         return attrs
 
@@ -719,6 +705,19 @@ class YnlFamily(SpecFamily):
                 attr_payload += format.pack(value)
         return attr_payload
 
+    def _formatted_string(self, raw, display_hint):
+        if display_hint == 'mac':
+            formatted = ':'.join('%02x' % b for b in raw)
+        elif display_hint == 'hex':
+            formatted = bytes.hex(raw, ' ')
+        elif display_hint in [ 'ipv4', 'ipv6' ]:
+            formatted = format(ipaddress.ip_address(raw))
+        elif display_hint == 'uuid':
+            formatted = str(uuid.UUID(bytes=raw))
+        else:
+            formatted = raw
+        return formatted
+
     def handle_ntf(self, decoded):
         msg = dict()
         if self.include_raw:
-- 
2.42.0


