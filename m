Return-Path: <netdev+bounces-66892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B39638415BD
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEF828A531
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1625F5465B;
	Mon, 29 Jan 2024 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL3CS2kD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4953E07;
	Mon, 29 Jan 2024 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567734; cv=none; b=YM0HuF35fHD/IaIuyuRtOlcM4w1udK3pjZtJ3Rd/C3nJG4beSLcRb1bSYku+3I45gdSpNKO+gYyUPwAu4dSVDnj0/MBe/nsQmYUdRT176/hRMs0hqdzzloeSTIqrdyCLt7fI2Je7GaJVWE+ofI6Uko125ljmMsutAfGtNe1ONIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567734; c=relaxed/simple;
	bh=1mZRqWZII3pMTZWLi8ep1djbp4wRvSZDAG85K3O66ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgu6CksRWt4AFNw/vyWxgIsEbYmnTPnnVP3H4Yoxg7dKvuC7jEZDU+E8nSJSI6SrCVBlQ5Z14/91LH7fh2iRFRXJPJFnkusKVp1zDDoZqsNOyaODHimWQ0NLe/huHnGkp+rUJapqoHiH/scm12AhHRF2EzEzngAXiEFDwy3lcO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL3CS2kD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40eec4984acso26169955e9.2;
        Mon, 29 Jan 2024 14:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706567730; x=1707172530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyCHyvffOH+oRJ6ypOtqrlTb6yApdanhXfSR1Ucu//I=;
        b=XL3CS2kDBSp0zxPVQdVTBc/pgy7vV7cdkKL6qJYQwsA/uBHjQN3s/Sxb38sjRtcdtz
         YPKN5aDCJYhYfmWQWvTAzxhoFr794zuG09OOBi119CKJdus8MBN11yyomuyCoBO2/UiJ
         YlVT+VqITqIWA3cA/Zkcd4Q82CPh1Mbjgq63sxwsIrdK4DJjpmo51ETnNGxZXXC6ejRx
         ZduSu/kAJ8xyN8QdXHo/4KArLV+RDZaqGtM8aTRfYg0XwCtFuInRGRyRzXgNfGruYIS1
         qHsaKCfkoSfWgV4RJtBNf28GRg3TgtxuMxe3z1v9sV9AnhSkYSLCXYutJjx0SMXNX3fb
         rqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567730; x=1707172530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyCHyvffOH+oRJ6ypOtqrlTb6yApdanhXfSR1Ucu//I=;
        b=pjJGDhgn9cfHT7Inzx2uKpiOD9FsB5C+7dB++o1GEHQJqzKEudyscm+95ksViziff9
         pQIUvJIEsdQVJM9roH5YobSNCSNuMhjZmMpOKC5985kQUkezJI2qyiow9OKwfKgmaAW8
         WkHli7cFG+SF33PE78sCA614IM46GbEVDtM8CsqjRhxJXCBxvYQFu5lapYN3Ma2nZyCG
         mVl/yOrC7gR+MNhOOIH/9A0xg/YUSsmQq1NfGUAQEMaIXacN+VJFAto+3EMzqzggOMc9
         1wRawfpiLHumcN3ei32l1Pa3u53CtkIcqdUEgDy/NfQsiBGawwLhdk0ht9UqYUv6li9g
         vhcw==
X-Gm-Message-State: AOJu0Yx3dgISv7qE+tV0PZQ0ypMQfsauCaP6jKBPK8Xj3m4QhdW0w8zE
	dPYHRgYbSwrhc0fvUqCYWcA/RRvX4iw2veYKBlF+Jdw6daXtEJJ7UEk8cgSDphw=
X-Google-Smtp-Source: AGHT+IF62LOUAk04aWRddh9fCzf/eGijkdKw+5e6vuL03XW6DU3uUY4iVsnmXygxkY8W6MlSvXdbKg==
X-Received: by 2002:a05:600c:350b:b0:40e:d176:1c98 with SMTP id h11-20020a05600c350b00b0040ed1761c98mr5292202wmq.18.1706567730451;
        Mon, 29 Jan 2024 14:35:30 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm11357281wmb.1.2024.01.29.14.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:35:30 -0800 (PST)
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
Subject: [PATCH net-next v2 09/13] tools/net/ynl: Move formatted_string method out of NlAttr
Date: Mon, 29 Jan 2024 22:34:54 +0000
Message-ID: <20240129223458.52046-10-donald.hunter@gmail.com>
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

The formatted_string() class method was in NlAttr so that it could be
accessed by NlAttr.as_struct(). Now that as_struct() has been removed,
move formatted_string() to YnlFamily as an internal helper method.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 tools/net/ynl/lib/ynl.py | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 173ef4489e38..2b0ca61deaf8 100644
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
@@ -530,7 +516,7 @@ class YnlFamily(SpecFamily):
         else:
             decoded = attr.as_bin()
             if attr_spec.display_hint:
-                decoded = NlAttr.formatted_string(decoded, attr_spec.display_hint)
+                decoded = self._formatted_string(decoded, attr_spec.display_hint)
         return decoded
 
     def _decode_array_nest(self, attr, attr_spec):
@@ -715,7 +701,7 @@ class YnlFamily(SpecFamily):
                 if m.enum:
                     value = self._decode_enum(value, m)
                 elif m.display_hint:
-                    value = NlAttr.formatted_string(value, m.display_hint)
+                    value = self._formatted_string(value, m.display_hint)
                 attrs[m.name] = value
         return attrs
 
@@ -738,6 +724,19 @@ class YnlFamily(SpecFamily):
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


