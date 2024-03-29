Return-Path: <netdev+bounces-83339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32654891FA6
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAED31F27C8C
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718E214600B;
	Fri, 29 Mar 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRuQYicx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C49139D00
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711720231; cv=none; b=ZE5qfYT25aGz9ezgE/ESA5jrcJI4cq2irhVkKpx0PCqXicjIkbn7KGU84wkK2YrzciCFfn6klD6asONbUrGnMj4XucCl5eI+rlDueGfTFZBA0IdpKZIpeaKWkpppys166dGkdyqL34fap1Z2yvph2WhwIK2obOZsramtAoO12Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711720231; c=relaxed/simple;
	bh=yrwOh+QBerZG+x69Hbd/5g3E6bkIyh9W3lC1eVjZ3h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=retncdPeH2xJj3CXkHK8OvKcPCmOFySTTP099/DmJSqsyItbDK90crGmJJr25946eRzNNK0qWRNOXrlYa2T92nYfX2KKFzCVul5NIqW1NYC5SseGv8QuIWdQKAqdUIiXunuGQVTZ4kI4GTBtWX8wVnWgMPwVFnKboAzy/UoROHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRuQYicx; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d094bc2244so21582191fa.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711720227; x=1712325027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMkki4A/Vj7KhowkYLIWUYp+Nt56+Jptyl5JQbMrydA=;
        b=nRuQYicxCskGuNoo7k3g+GWf6Cz+CAGX6BdFULuLV8t9UYYDQFniXHjvtROQ/kjKp5
         OdjJp5TxBzXpQ88tOFeXLauwmlK9n+bDyL0Wg1t4nsVerzej1HCoGR2WmTYT3bzT/szX
         XooUfat7RzUE+3sebSa66NbWmtjrauaDusv5b4l4cuIOQ0IWRqyjyArCG7fa4K7Hy/y4
         si9Y1QdIQZDWHsFVJkGLOpuohz+G13Q/KElVoIrCNnvzxjmtB9dMVfshD9+j+XRi4kdc
         YrV1HJEXyx9XMfnn/TwHBpP+RtaAMMb/YTge9+tiGPu6mk5DBhZiuu6MlAhk9kGCSh8v
         N3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711720227; x=1712325027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMkki4A/Vj7KhowkYLIWUYp+Nt56+Jptyl5JQbMrydA=;
        b=EwpznKtG14BRd2tN1yMDpXGTj2z0zkbJqyLMSOxrZ9PV5IKeZkV2gRQDqZLcq5gu6H
         u4AOV210CLcY11JTEEiPuVQK4a1RTzzloAA8L4DBp7f20LN70gnalimyK9+JeHipcDJ0
         G52czgNZm6gpiiERCclzMHNhhk9EySaFj5OIL99tq8c47xnV54ZFiZSACHTgY67zOpab
         CslHXHk0K5rynJJU3HBr6dDoT4WTbJuJCR03N1dpbs4u6ptr0MWXcYOd6763a5SQx1KV
         6+lWd9P7sCvdtESc8Uq+80pqD7mQ+vhaw/Pn77GMDzG/Hw8RXYH9i1QLkP1CLa7OjpJR
         +Lrg==
X-Gm-Message-State: AOJu0YzCL7BXHMxLMmg4Hhd6ll7Fub2ay3138DWPJGEuz9EbHI3m01KM
	0T9iFGsRt3Ll6GxNFzswJMqQtIxH9BuS6V92aoLTWRGgxywkddh7MKPhVM7rBEQ=
X-Google-Smtp-Source: AGHT+IEYDHtKgFom+uJiYKSUZGXAuOxgFydYDvgE2X1BfUQ1cWnCd6+tKg+0XkhG99Ik241cbRnE6Q==
X-Received: by 2002:a2e:804a:0:b0:2d2:6193:6d53 with SMTP id p10-20020a2e804a000000b002d261936d53mr1369789ljg.13.1711720227281;
        Fri, 29 Mar 2024 06:50:27 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:3c9d:7a51:4242:88e2])
        by smtp.gmail.com with ESMTPSA id s21-20020a05600c45d500b0041487f70d9fsm8590633wmo.21.2024.03.29.06.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 06:50:26 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Breno Leitao <leitao@debian.org>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 1/3] doc: netlink: Change generated docs to limit TOC to depth 3
Date: Fri, 29 Mar 2024 13:50:19 +0000
Message-ID: <20240329135021.52534-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329135021.52534-1-donald.hunter@gmail.com>
References: <20240329135021.52534-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tables of contents in the generated Netlink docs include individual
attribute definitions. This can make the contents exceedingly long and
repeats a lot of what is on the rest of the pages. See for example:

https://docs.kernel.org/networking/netlink_spec/tc.html

Add a depth limit to the contents directive in generated .rst files to
limit the contents depth to 3 levels. This reduces the contents to:

 - Family
   - Summary
   - Operations
     - op-one
     - op-two
     - ...
   - Definitions
     - struct-one
     - struct-two
     - enum-one
     - ...
   - Attribute sets
     - attrs-one
     - attrs-two
     - ...

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 tools/net/ynl/ynl-gen-rst.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 927407b3efb3..5825a8b3bfb4 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -291,7 +291,7 @@ def parse_yaml(obj: Dict[str, Any]) -> str:
 
     title = f"Family ``{obj['name']}`` netlink specification"
     lines.append(rst_title(title))
-    lines.append(rst_paragraph(".. contents::\n"))
+    lines.append(rst_paragraph(".. contents:: :depth: 3\n"))
 
     if "doc" in obj:
         lines.append(rst_subtitle("Summary"))
-- 
2.44.0


