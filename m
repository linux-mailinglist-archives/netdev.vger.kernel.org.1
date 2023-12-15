Return-Path: <netdev+bounces-57832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FCC8144AD
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5DD1F23646
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB861A73F;
	Fri, 15 Dec 2023 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAXp+Nxd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE921A5B4;
	Fri, 15 Dec 2023 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c2308faedso5459295e9.1;
        Fri, 15 Dec 2023 01:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633062; x=1703237862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3JY0Tl5uBoHE8m/ovbgncHc7wHlXG+lWF7d67MSbyU=;
        b=MAXp+NxdJ9tUvxxbU+46Euh50hC+9dZQCxUVt5Hr1Ki8DNn8MwIuC3OLT90wj/fCiv
         TNYBRa5qmN9W5eKYcy6zWwkBoRLGCsMntR/UUVkSHC0ZwMtGmLSSYOqQvPvz/ghOEb4w
         vLQQoMxc+3nJU37J8+l/I6POyNhgt9odd6u+Hgh+XDl8y9kuXwx2U3QcjtKI3D0Ao+yR
         qf+ciD+DvfPaLfNz5wfe8jeZLDZ8mIx/3ZDTNugyJEM0l5pU/xMPBGNS7I+zt3Xp5/22
         n2I2gatYW/gPv/H9jTQUAkUGrgyc3sPmpNE3OzIKRADs9SGFHY2oW68KPQzT7l6iOu1o
         Hg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633062; x=1703237862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3JY0Tl5uBoHE8m/ovbgncHc7wHlXG+lWF7d67MSbyU=;
        b=RJ7I9qkrmja2ADAG/IWVXMmJTEsVZTxl537/tAFqPK7c0m2wzc6j7llO05J1E+TNlw
         V0viuexIhvXnnGgvnzeCmtqioXZVp1RU+EN4J/iuckv8Rdx3pXaiaJwDiiULfgkhLDyJ
         SNm2yLhbWa1yNMRVqUt8XPg0f9Lk9z6QDYUwALRIA4j6475ZkuKcvhIyWTsRhAODOC3o
         F8DlGZ7237A2ykF6ZFQskWLr8tQpqYeIZPMtpV/9IlKJARbOEHHJHjQAxJAwEAxgY68q
         s4y7+v/vrh8ReX5a5qQaIMT7UjKiUYP1U73UfVvb2hAHLT2D9LnypBBvDNJzRGX1F2ud
         d61g==
X-Gm-Message-State: AOJu0Yxlz3rmrjlN+lnW2Jh7jqtJuA+q60mVpi+kJDePPb7XxHjJbwA7
	XzDPAE+fYs6CYTWM8YlqpzUwu959SeqD7A==
X-Google-Smtp-Source: AGHT+IFKf9CP22/OVtqbgQeTJKlDVLtSwhyyL5JpgQm8GI/ruOEWd88PGXrlZclwY1gDveZWRLFT3A==
X-Received: by 2002:a05:600c:1913:b0:40c:a12:d626 with SMTP id j19-20020a05600c191300b0040c0a12d626mr5979077wmq.103.1702633062167;
        Fri, 15 Dec 2023 01:37:42 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b1d8:3df2:b6c7:efd])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm30748947wms.30.2023.12.15.01.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:37:41 -0800 (PST)
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
Subject: [PATCH net-next v5 07/13] doc/netlink/specs: use pad in structs in rt_link
Date: Fri, 15 Dec 2023 09:37:14 +0000
Message-ID: <20231215093720.18774-8-donald.hunter@gmail.com>
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

The rt_link spec was using pad1, pad2 attributes in structs which
appears in the ynl output. Replace this with the 'pad' type which
doesn't pollute the output.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_link.yaml | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index ea6a6157d718..1ad01d52a863 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -66,8 +66,9 @@ definitions:
         name: ifi-family
         type: u8
       -
-        name: padding
-        type: u8
+        name: pad
+        type: pad
+        len: 1
       -
         name: ifi-type
         type: u16
@@ -719,11 +720,9 @@ definitions:
         name: family
         type: u8
       -
-        name: pad1
-        type: u8
-      -
-        name: pad2
-        type: u16
+        name: pad
+        type: pad
+        len: 3
       -
         name: ifindex
         type: u32
-- 
2.42.0


