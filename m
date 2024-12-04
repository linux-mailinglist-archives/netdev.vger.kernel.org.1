Return-Path: <netdev+bounces-149054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77589E3EC3
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C975166CF0
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C9320CCDA;
	Wed,  4 Dec 2024 15:55:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A51FA16B;
	Wed,  4 Dec 2024 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327754; cv=none; b=qRkzd/SETEoBFdMHGtrQ5J9+r2PmZcUEpyPtcPjxJCEV68pzCE+tagD9HcLk7cY46i3iau5zc1ZhK0vtCxUpF11GoUh1TYcB5p/VSNmEO8hwUyJKE+jmLzkjLU2d/5tudzVKquDrGfTZjmKiY/PbfIo0zoSYwpHf23dkuAJpidU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327754; c=relaxed/simple;
	bh=nx/1q4UxfEC4CdlsFRFIMhLyLex9mIfjyJUUuj/UgFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3vRRrj/fO/mr0N9m35HasUfoc/qzlkB+Y4Xm+196hJmUtxaK2/CoHiIKkXXD/uMyT4ojufUZYZqB4fjZUHgHYc7ORi0Gr24IKHoZUtabxWst5IiOlYA+b2heE1NHmIdwDgt0q7knO4eWwC4dyEY2H6fOrhqc/kF43oh1RtQ0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7252b7326f4so6207364b3a.2;
        Wed, 04 Dec 2024 07:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327752; x=1733932552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiduPAtZh1MVyOKWslb5l/TwKEKfq1TiSzGE5bgoCZQ=;
        b=IXrCFV72hY15/Xmv00k39YfBo6aE34rGtdhygW4B2aJvyz4dAJu8YN55ZIrj6+00nw
         efCaUgWDctiZwgKErgEBtBLQ6CdDtWk2eTwfN/vJR5vaxuyjXTiL96QjuFghJEfj4L8s
         Dt02PfZ4slaYTKFgZv5xJzUVLbgPx3/Aup34YNNv/ibiXtCjMHk9Z+qHm52Bsq7rfj2P
         n0QG05eu9mrVeLkEq44AplcLfOfha3csHdTcJxPa493d04Ei/l3xbWBib9cFUYf3l1pz
         A9AxgPpMAjqC/0aRbkcq/qS+Bpgthw/kPRBlpFBNvgZ91M/PEzqkEwNMlgMvT01JfyWE
         rMCw==
X-Forwarded-Encrypted: i=1; AJvYcCW1TC6NoVZBGHZMM2396AzT1u3OQUElVxvcpgeIfk9ux+quH+n20V8ScGUY5MZwCICvbWh1psxRHvQ=@vger.kernel.org, AJvYcCXzanBpO8z5gyyghXPnz+0QgciuZarbCh0x/bGpoucRtBZqhAwC7CBPTg2Oe7xUxelkc0OEGPt16nSjFCFM@vger.kernel.org
X-Gm-Message-State: AOJu0YxK2zfq1eMVE073cLPFKJs7DQYxFwIM+lR2fItkdpcVhRUxN5j8
	aey8NtdfkvUQuIdhUSd02D3o/2sNX/up111j0eA08o2CrKWiaBQu7ewb9Pg=
X-Gm-Gg: ASbGncvue7TL/xTIKMVWJLYQWywirXX/uFPr1RfW+Km9x5K3Mai05OOTbnisTGVStf2
	xw1Tub6Dd+S4RhH373yz8jowYwO0tCI8Q6cNN8tYkRVXE1YnmHhj11y4SdT2OUvw9zRutG6EB0W
	MiP1xtWS/A32AoRaybAwG2m73kXSs0OXK4DCMSH+sLyF0ChmWFFBUTsCyndvKTO8HiKU+dR9cBE
	lUUxb7kUxl3MIvq9Tc1eRNq/OF1bOhLgCGf5pKYqrc/nxeeRA==
X-Google-Smtp-Source: AGHT+IEb/8kSlEdlfyzNNSzd4WF8HxFr1in1dQcr8sQhfINfF5D5fn4Qps6VKazzl9J8zI9bFQvj7Q==
X-Received: by 2002:a17:902:f686:b0:215:a179:14d2 with SMTP id d9443c01a7336-215bd180059mr90428605ad.50.1733327751784;
        Wed, 04 Dec 2024 07:55:51 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21548e144b0sm91615835ad.68.2024.12.04.07.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:55:51 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next v4 1/8] ynl: support enum-cnt-name attribute in legacy definitions
Date: Wed,  4 Dec 2024 07:55:42 -0800
Message-ID: <20241204155549.641348-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204155549.641348-1-sdf@fomichev.me>
References: <20241204155549.641348-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is similar to existing attr-cnt-name in the attributes
to allow changing the name of the 'count' enum entry.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/netlink/genetlink-c.yaml             | 3 +++
 Documentation/netlink/genetlink-legacy.yaml        | 3 +++
 Documentation/userspace-api/netlink/c-code-gen.rst | 4 +++-
 tools/net/ynl/ynl-gen-c.py                         | 8 ++++++--
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 4f803eaac6d8..9660ffb1ed6a 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -106,6 +106,9 @@ additionalProperties: False
         name-prefix:
           description: For enum the prefix of the values, optional.
           type: string
+        enum-cnt-name:
+          description: Name of the render-max counter enum entry.
+          type: string
         # End genetlink-c
 
   attribute-sets:
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 8db0e22fa72c..16380e12cabe 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -117,6 +117,9 @@ additionalProperties: False
         name-prefix:
           description: For enum the prefix of the values, optional.
           type: string
+        enum-cnt-name:
+          description: Name of the render-max counter enum entry.
+          type: string
         # End genetlink-c
         # Start genetlink-legacy
         members:
diff --git a/Documentation/userspace-api/netlink/c-code-gen.rst b/Documentation/userspace-api/netlink/c-code-gen.rst
index 89de42c13350..46415e6d646d 100644
--- a/Documentation/userspace-api/netlink/c-code-gen.rst
+++ b/Documentation/userspace-api/netlink/c-code-gen.rst
@@ -56,7 +56,9 @@ If ``name-prefix`` is specified it replaces the ``$family-$enum``
 portion of the entry name.
 
 Boolean ``render-max`` controls creation of the max values
-(which are enabled by default for attribute enums).
+(which are enabled by default for attribute enums). These max
+values are named ``__$pfx-MAX`` and ``$pfx-MAX``. The name
+of the first value can be overridden via ``enum-cnt-name`` property.
 
 Attributes
 ==========
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index d8201c4b1520..bfe95826ae3e 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -801,6 +801,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             self.user_type = 'int'
 
         self.value_pfx = yaml.get('name-prefix', f"{family.ident_name}-{yaml['name']}-")
+        self.enum_cnt_name = yaml.get('enum-cnt-name', None)
 
         super().__init__(family, yaml)
 
@@ -2472,9 +2473,12 @@ _C_KW = {
                     max_val = f' = {enum.get_mask()},'
                     cw.p(max_name + max_val)
                 else:
+                    cnt_name = enum.enum_cnt_name
                     max_name = c_upper(name_pfx + 'max')
-                    cw.p('__' + max_name + ',')
-                    cw.p(max_name + ' = (__' + max_name + ' - 1)')
+                    if not cnt_name:
+                        cnt_name = '__' + name_pfx + 'max'
+                    cw.p(c_upper(cnt_name) + ',')
+                    cw.p(max_name + ' = (' + c_upper(cnt_name) + ' - 1)')
             cw.block_end(line=';')
             cw.nl()
         elif const['type'] == 'const':
-- 
2.47.0


