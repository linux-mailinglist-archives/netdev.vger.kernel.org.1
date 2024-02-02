Return-Path: <netdev+bounces-68532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F4C84718D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E7928D40E
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5404D13541C;
	Fri,  2 Feb 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4MHtVhZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2167AE4C
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706882386; cv=none; b=d69CwPIVwjYNQpkhgikeIRcjF8ZM1np+hbG5hWu5ejnOENXsWqRTX10c6NFIe1rEkuRGnRKgY3W8pl2s1ngPIdgV6aNu9jbRAQGiFVwuUGUbso/blFnuOzN6AA1j77REOHx316ka14lxyVYtQ8MKQHwZlT6r28yl3i6HfxiBkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706882386; c=relaxed/simple;
	bh=Ls4bZ3kXJ5xX1hRkaYsgKcB0ggzLvWWupUkIeLD5n/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbn01yTd7fEZjooU+fcYfCATN3FGqkVEgUN9jbhdWs6EMPty/v/y9kNF+dQ73H+hW5Z1R1SOA5WJMx/AZL6EhFNevmWZIq1tAXZU2WI0ldmEWaSqvY5gzEY1pUGJiSYbOaxHqVztKFeR0b79R0pRBgPtsjZqHHqu2TWC+G2R9t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4MHtVhZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so19055615e9.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 05:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706882373; x=1707487173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQxGcuk2wJM51qDiz0MU2m8IcoS7QKse3nkS/aiS/KQ=;
        b=L4MHtVhZPiQyNsVoS6HB82bHuEcQzETArdWW7jmMtnS/wvxRy7NXJz0gW8ZKSMPqLp
         E1UQ+Au3E4kOiFe6z8P19Mo3uHbXvR/+qAROAO79cB6RUmXz/WeMICb7QJHFIRfg8iJ9
         aZ5NMTgxfMaM1l4ikB/vYXB+3/h6Hbzh1Afe7haKFqdOv38M5wgdoxdV+YoyvSK7X/9i
         itiOxtNvMoUONjF0BB0lJkT74WcLHwCrCBiWVj7ODuIyhPYbJxTX3rxm+uYdbwaZoOCu
         izAfruBuqDu0S+GWByzQpIwU/lzW+sZwm4la+VNJuWsyeozuLfA0pIHMf0KTtg2EHyXs
         RVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706882373; x=1707487173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQxGcuk2wJM51qDiz0MU2m8IcoS7QKse3nkS/aiS/KQ=;
        b=ErbT5PXgf1CNUb+wZmCLJmwtfJ9TQyNEtHig/XHYomYoADznIDSOH9RF0zgbrn/lRy
         KfC6f/H59n/k0u/e9AU02lA+80C756dYCiH3upqOthuVsZWnEeLwxUoJJoijcBL6gAMW
         HBqp0jtdDlEHGuz4jwwfpf+rQBgQyRVPd7rcVMB6c3XFp/o5CrLwYLEbxfr2FEbhxjSf
         CcGMzJmpPpll3bTX65Y62VDIdkQKwOI+tPLIV17cjp+0a+lUoBrdpTXWUvqvrFyYSqQ7
         nO2o4ucwBUfoiORKANKQCvvH9YXKMaCzgGN2ABEnhe7bDhU3VtnLbCmt55febBwNJMzl
         mJ4w==
X-Gm-Message-State: AOJu0Yx2uyCeAtBlFAC2j6QyFpRr1bCCwg5g+ce7jfVPWnQSGYMwZYHR
	8/vylHdzl/KeNKl/vGh3wTPExzMu7HQarCkhew2xOxZZr3+Jla8l
X-Google-Smtp-Source: AGHT+IFFVwJLpPNojIrEZVu/GjZH0xizIikOI18rq84uDKUp9u6IW/8pBneyKVY5UVqGngp9VDHp1A==
X-Received: by 2002:a05:600c:35cd:b0:40e:b313:b8db with SMTP id r13-20020a05600c35cd00b0040eb313b8dbmr6048101wmq.28.1706882373104;
        Fri, 02 Feb 2024 05:59:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUNFMRK5EkJrTYek+989NrBlowpF+Roghe1ZKu0bk0X3/k/pfGSdWrE6k8pscExspjMun4ZT+Z4f3lgI63bzV0qClCOFiJr/ll6ZPvrtjFYGj6XHdu7k1iCgmLyoQV1wNwDkeNavSm4RfLHJM+YmVVRO3iZ+NyckawoqMF6eyB33vN/z2d99D7UhvcWNo6f0DcXS3jNlZQTHRGbwrfCt9waH+u0lv5fTstG0P89+u/+i2eMGJOvJLyEA7lYrYqOcfXzMAblogmekIMK8BaoX9XJvPMX1LnX4T8nG2pSL7RWI1Aw38iKrFSq/XKgSUAzr5M5mqXbmWXGrdNCg33afNH6grlvpExrLIad
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id x16-20020adff0d0000000b0033b1ab837e1sm2003952wro.71.2024.02.02.05.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:59:30 -0800 (PST)
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
Subject: [PATCH v3 net-next 3/3] tools: ynl: add support for encoding multi-attr
Date: Fri,  2 Feb 2024 15:00:05 +0100
Message-ID: <9399f6f7bda6c845194419952dfbcf0d42142652.1706882196.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706882196.git.alessandromarcolini99@gmail.com>
References: <cover.1706882196.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multi-attr elements could not be encoded because of missing logic in the
ynl code. Enable encoding of these attributes by checking if the
attribute is a multi-attr and if the value to be processed is a list.

This has been tested both with the taprio and ets qdisc which contain
this kind of attributes.

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 0f4193cc2e3b..d5779d023b10 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -444,6 +444,11 @@ class YnlFamily(SpecFamily):
         except KeyError:
             raise Exception(f"Space '{space}' has no attribute '{name}'")
         nl_type = attr.value
+        if attr.is_multi and isinstance(value, list):
+            attr_payload = b''
+            for subvalue in value:
+                attr_payload += self._add_attr(space, name, subvalue, search_attrs)
+            return attr_payload
         if attr["type"] == 'nest':
             nl_type |= Netlink.NLA_F_NESTED
             attr_payload = b''
-- 
2.43.0


