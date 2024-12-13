Return-Path: <netdev+bounces-151769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BA39F0CF4
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6313F188A84A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788501DFE2C;
	Fri, 13 Dec 2024 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFLaDf2f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656B1B3922
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095250; cv=none; b=TbxqA/q49p7TI1k3OuYMZqcfXlpXM9QFeEyYZdK20kFjcpfVeRXLmDr/Z3H5hEfzkLkjxAHMZzo/zJ81s3p7gT/GmkTmaimWZWuEEueh5pxUs9GxGWKeTQkiOds3PFOJKO1G9hKGwua6eVZpOHpSHZi5P9bsuEebqUhNpkE2a0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095250; c=relaxed/simple;
	bh=aUeCvcpTmnZ7DO6kPu73Qvod3ib0Q0iS6VNZQj8ecbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blHf73LQd6VlxttIW0ZSLO1WmXZEVWSWa1fweOg1ckkTa78Izl8rbPi3EfIwXSSRB7jrEI/xPKaEJLdGik/9PZbgvZkN0cumPaTMKj/HqRBpdUKoNIbIQ1bTPzpAnvZyH7iF1hmJ7EvnHUytazE4AIPDuGzmKlNUSqbmEonoyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFLaDf2f; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436202dd730so12403105e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 05:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734095245; x=1734700045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eereptyc8NoqpTc1cXCD0uSN1W8/KqI4a9obj7asMw0=;
        b=bFLaDf2fXuLBCkGos+H1httk+2ZcOFgQYGhBBnjXV2iilamZrp2x/narqF8fAi581b
         SNPH+3wA3syTdyo+cuyv9CQTvjCea0PeUC6PcjHvVauhwyhcIF2Mdq1NFY2JfKB6WzHH
         ZEFR5/PvvjjIjRdou1CLzdh3KDpdiTuBPDvNya+YuME8hJxozM1xOGF0FYifTiLCmZuT
         2haE5992KGTMByHWMFC+FIbuQNb82gf6P4+U0Uq2Sir4gFJ0lOp6inl1bWq3eyvWvkxb
         E8sP/Q1x08QLrQDH20x4V/BFwjZSYrxFcgyLjtOT8REzr5qBWzUfwKAIT8lYNlLtJe6Z
         cFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095245; x=1734700045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eereptyc8NoqpTc1cXCD0uSN1W8/KqI4a9obj7asMw0=;
        b=cnS7C5i5OvVu0hLd6qmw4S3qBXNs90vkSXsMdTzmiaGrRDpT9KJt/P+0IyJwgN6Qkd
         YQDIM13Tiauljzymc0rh+zpNo+GidwP4yybNPzUYaYmr8fhM8aK9UlMkGqyGsSUOXS5R
         oDlBbl7+dEpabBtDj3STZY847NScvGPxFnvB1phgOL5dkk+CariUEKe6J6yI+w3npC0Y
         bATb4qpC6E2yWngFV1IaZMfg1vRefP45jMAZS4AdGSZ4a3gwH6UQFuUmdrXarRZHI+Ia
         rzi2yJsyte55dCrIunAeQCaAb4CMAOrbOiIMm4IbLjVJH6c5N/Hmnf4SejQoRRzdfMie
         z9hA==
X-Gm-Message-State: AOJu0YzvEnVcFq+Rkl03dbUUdRBJWscE4IQB7v5Ydzp0HyDnQ+k5LAU/
	hE2SDC2mnbbFQ/3epg7r3+15tzolTNFaFZnhQjtta49yVwyYBixAuIl8qv7v
X-Gm-Gg: ASbGncsP5JoGOmoL0fRDuNidfYD/hAGSVb1XrOa/wXGV/ZT6cXaEiygMNDsQs8hYZeB
	ndwrtSwBO/1oAUW8qfDvo0+akNke0rY+GUSUEtDYUk+sGBP+XWSi7HhD0OyPLIZ6PSaRE/l0Hs1
	bDc/pELwOnuIdeD9TxzLqepswA90qeBRrjqregwfKoHQwPAviIIJOtjzelbuuibclOEwOcHA3P5
	dnCHJNxCpRB1Fs/W0ztwXVt+K8MXfKwzUMMkZimcS1TekRYASyX+YmC3LrO2OxAq/1rh4yy6vA=
X-Google-Smtp-Source: AGHT+IFsyAQAsDo/fwq6Gkn1S5Wgm0bDyP8k2lqjAAOyubw2lS3hDHEjQf6bj1WCDC08s/IV778MYg==
X-Received: by 2002:a05:600c:5397:b0:433:c76d:d57e with SMTP id 5b1f17b1804b1-4362aa34e4cmr18832755e9.5.1734095245223;
        Fri, 13 Dec 2024 05:07:25 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:dda3:d162:f7b1:f903])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b7d46sm48562985e9.35.2024.12.13.05.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:07:24 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1] tools/net/ynl: fix sub-message key lookup for nested attributes
Date: Fri, 13 Dec 2024 13:07:11 +0000
Message-ID: <20241213130711.40267-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct attribute space for sub-message key lookup in nested
attributes when adding attributes. This fixes rt_link where the "kind"
key and "data" sub-message are nested attributes in "linkinfo".

For example:

./tools/net/ynl/cli.py \
    --create \
    --spec Documentation/netlink/specs/rt_link.yaml \
    --do newlink \
    --json '{"link": 99,
             "linkinfo": { "kind": "vlan", "data": {"id": 4 } }
             }'

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 01ec01a90e76..eea29359a899 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -556,10 +556,10 @@ class YnlFamily(SpecFamily):
         if attr["type"] == 'nest':
             nl_type |= Netlink.NLA_F_NESTED
             attr_payload = b''
-            sub_attrs = SpaceAttrs(self.attr_sets[space], value, search_attrs)
+            sub_space = attr['nested-attributes']
+            sub_attrs = SpaceAttrs(self.attr_sets[sub_space], value, search_attrs)
             for subname, subvalue in value.items():
-                attr_payload += self._add_attr(attr['nested-attributes'],
-                                               subname, subvalue, sub_attrs)
+                attr_payload += self._add_attr(sub_space, subname, subvalue, sub_attrs)
         elif attr["type"] == 'flag':
             if not value:
                 # If value is absent or false then skip attribute creation.
-- 
2.47.1


