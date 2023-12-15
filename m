Return-Path: <netdev+bounces-57836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293068144B5
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8989D28462E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D051C6A0;
	Fri, 15 Dec 2023 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjgrCTz6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE2199D5;
	Fri, 15 Dec 2023 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c4846847eso5006635e9.1;
        Fri, 15 Dec 2023 01:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633068; x=1703237868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1DwTwiH/Leh/GzY5n/Y96LuM3JjSfBQ31fwehUobXk=;
        b=kjgrCTz6SWfV9/Gd6Z5la4i8WcN83K5uqPhZoGvdPXi4dzZzGYWCR2pKM4jYG0f58n
         Dw3I0mEZazy7yi1lWsYdi2vwpLtFT1oZ32RGYWFa1XIaeJMNx8ZGQ2873OVYiRBJMuYs
         Ya+R5l7/zVfsGvxAP/VQUtD6mgxHoPiWZEnjwhlBGwpkJgKTXX9C4Z0j6KfK1jt0C/Rc
         3m+oyoolw+IeNHjoh5SKf+hAYiSSSx/iCiDvaFRH/dAXecIN6l591WfUlBicA2PrKf6U
         jwBl7mFs7/hShd8AA0OhGS2atgB2X3Ql80lJOkykk59xr2rsQflbgfVhIwd2wNOxzoU5
         CVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633068; x=1703237868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1DwTwiH/Leh/GzY5n/Y96LuM3JjSfBQ31fwehUobXk=;
        b=P9+kyammN2kzOVzM28YFWhIVlB8StW7s6vo8qi8tCpGD3T+eYV+p6A4HLXmY8MvzjX
         US7S3oubv9Ps1bbOAxbgLY/6ziRpvY63TUl7ooWGVyT8WkM/FIJJ8cvaqRcfpp1KTjKx
         6Y5wrhKc2JTVJ+0BPU4Qewfqpsy+vGxQ7Vc0CXXFeSzKOivCiIfVHhn1YeEjzfV3I4Ow
         IcPFaFLWAHBTTa1OoC0lctVm3LKsRZ0pzrdGl680J29pKTV32yopyjCAF4JBovM0RYDu
         nybZEpEGKSSqBonRpJtyYJPISG8DeWwxboghpnbU0CrioQkRVeZJoz3noX+Nje1KMuhL
         pfLQ==
X-Gm-Message-State: AOJu0YzAIgTld6SflYeyDnMy/wxCmCmDDf8QDYZXhofwMLb+dIc+dA1J
	IezKBs9XdBjU5/A0RCAA+n6epxPXLQ28Qg==
X-Google-Smtp-Source: AGHT+IF+/DyoGf1rNkf1YBErCppyVghthwSBFx5cubt7oHdwItFAaKJU1C27YMxbpZdDs6nEb24KAQ==
X-Received: by 2002:a7b:ce92:0:b0:40b:5e21:e26a with SMTP id q18-20020a7bce92000000b0040b5e21e26amr5814045wmj.87.1702633067861;
        Fri, 15 Dec 2023 01:37:47 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b1d8:3df2:b6c7:efd])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm30748947wms.30.2023.12.15.01.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:37:47 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v5 11/13] tools/net/ynl-gen-rst: Sort the index of generated netlink specs
Date: Fri, 15 Dec 2023 09:37:18 +0000
Message-ID: <20231215093720.18774-12-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215093720.18774-1-donald.hunter@gmail.com>
References: <20231215093720.18774-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The index of netlink specs was being generated unsorted. Sort the output
before generating the index entries.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 19e5b34554a1..6b7afaa56e22 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -377,7 +377,7 @@ def generate_main_index_rst(output: str) -> None:
 
     index_dir = os.path.dirname(output)
     logging.debug("Looking for .rst files in %s", index_dir)
-    for filename in os.listdir(index_dir):
+    for filename in sorted(os.listdir(index_dir)):
         if not filename.endswith(".rst") or filename == "index.rst":
             continue
         lines.append(f"   {filename.replace('.rst', '')}\n")
-- 
2.42.0


