Return-Path: <netdev+bounces-65521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A576383AE67
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4674B1F25ED8
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2291E519;
	Wed, 24 Jan 2024 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIf/s/KA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC6D433AD
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114060; cv=none; b=M+jbx32Xui4p+lyOta8ErlQhUwEMF6ivlRutHmERS/PPhW/J7egPtfyx6E+4p8IdoY2dl1wNjPDAqm2szrqqp7n+PlGT+yB4X/0T36GCesKiopOF1Z711vkkd/vf92bWxcRYtECi7Zk4hjk7bigRu1iyh1bpfD4fHuQhXNbzRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114060; c=relaxed/simple;
	bh=KDmiXafVeOAS2XjwuncIc49P9RDSKqipQeu88/AZaMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSB1b+KY6hBdS5hN00chSZApOoOFLowYoe+eE3mCSZy3a9CtvWhAeKxQBie4ymVo9maP1h2xz7b4F8wqcDN3FLJmEE7SWGqb/16LLrgytigzsODjgHlKjkOcS/Jnbn9KKTg/pEdjQDWaI7oDPm8gTA4Wruz87uc3IVqtk0ZPJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIf/s/KA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e775695c6so55262255e9.3
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706114057; x=1706718857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2XubokNW8ReU7BjOg/NxC3mSlOCuSxN1FKMUPTov0A=;
        b=hIf/s/KA98+20Ov9CzNUclqQ8n2zTquYGwtG8Uq3dxGUQqGwc5srisoqWEExmV3Z0E
         /+po28/me8bojmzrd4seiNmCJOUo2vpVBK1pGw26KGBM1P3CuhAkhfcCJpcM4fyVb1vy
         jcXIIbSJdHxWb0dVeUUxlYlui4uUx0e44EdZyh1Rv2kJ0jRNyReO8KXgRNzq3qb9z1EC
         NXlaB1fExVWG4kTFIb7/95EjmA5TposrOf71ixoKFOobUR65rKlGtR7qtksAU+fq29ey
         t409wU5zm61saXX8kbhyacLL3mgSehXBQ7jpohhMJ9hVZDv1DagoUHvj2r4Q3Xqyi4Nl
         4CAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114057; x=1706718857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2XubokNW8ReU7BjOg/NxC3mSlOCuSxN1FKMUPTov0A=;
        b=KUa++K73uiqj1btEnkFRMf7PkQNjPmEjQVdefCIe4NNwp+WD2KD3BP7f6wB3tkKleO
         dXYxtyU3zVnsBJC7GLMvLk+KVSBhdUyWDew4in6/GJfuawjOKDiO5qzDvmtdFVF7D+FN
         AVqJYIVuUeyn1V6o1hx/wWJCTyc5EWKAAZ2GO79RzBQm0NV+b4HQ33L+yGkfWGPQwZXe
         zlM1xiH3aLgk3S2r9TPAXYFxKWf8W6fu4uz5K+u3R11zeeDq752fyboy339TKgVfnJp4
         UsxYYoabBxIBtoJ9vv0LA1xucatDQ1fNCDfSX/6Bj0GY/+8oRr7gFqIduMY2Hs/mMndo
         TFHQ==
X-Gm-Message-State: AOJu0YykwgHjWyom1y45sd0nPxXFZ0Yj605gi0ruKvTvJcW+Rus9rIPL
	zcN+iXfNVOZQnG7BSQIwE8Ogw9MGFr8pbjVeNRvPKRvllNKA/g6S
X-Google-Smtp-Source: AGHT+IGE0wauiZGWntdcLvhA2viRURO7FOvHKoWyqT9xOoM6zV1o4rQcwJZtL24I0UviNTF9jRnGhg==
X-Received: by 2002:a05:600c:a018:b0:40e:b4af:a189 with SMTP id jg24-20020a05600ca01800b0040eb4afa189mr2006707wmb.68.1706114057009;
        Wed, 24 Jan 2024 08:34:17 -0800 (PST)
Received: from fw.. (93-43-161-139.ip92.fastwebnet.it. [93.43.161.139])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d63cb000000b00337aed83aaasm19082866wrw.92.2024.01.24.08.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:34:16 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH net-next 3/3] tools: ynl: add support for encoding multi-attr
Date: Wed, 24 Jan 2024 17:34:38 +0100
Message-ID: <803d08dd985ff7a97cb61e3156200a0c2f27536b.1706112190.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706112189.git.alessandromarcolini99@gmail.com>
References: <cover.1706112189.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multi-attr elements could not be encoded because of missing logic in the
ynl code. Enable encoding of these attributes by checking if the nest
attribute in the spec contains multi-attr attributes and if the value to
be processed is a list.

This has been tested both with the taprio and ets qdisc which contain
this kind of attributes.

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index dff2c042e6c3..bd01b1016fef 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -427,10 +427,18 @@ class YnlFamily(SpecFamily):
         if attr["type"] == 'nest':
             nl_type |= Netlink.NLA_F_NESTED
             attr_payload = b''
-            subvals = ChainMap(value, vals)
-            for subname, subvalue in value.items():
-                attr_payload += self._add_attr(attr['nested-attributes'],
-                                               subname, subvalue, subvals)
+            nested_attrs = self.attr_sets[attr['nested-attributes']].attrs
+            if any(a.is_multi for a in nested_attrs.values()) and isinstance(value, list):
+                for item in value:
+                    subvals = ChainMap(item, vals)
+                    for subname, subvalue in item.items():
+                        attr_payload += self._add_attr(attr['nested-attributes'],
+                                                       subname, subvalue, subvals)
+            else:
+                subvals = ChainMap(value, vals)
+                for subname, subvalue in value.items():
+                    attr_payload += self._add_attr(attr['nested-attributes'],
+                                                   subname, subvalue, subvals)
         elif attr["type"] == 'flag':
             attr_payload = b''
         elif attr["type"] == 'string':
-- 
2.43.0


