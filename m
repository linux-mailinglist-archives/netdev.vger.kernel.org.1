Return-Path: <netdev+bounces-55985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC6980D247
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A5828186E
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1526F48CF0;
	Mon, 11 Dec 2023 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHoFS5gq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCBC91;
	Mon, 11 Dec 2023 08:41:00 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c4846847eso10463955e9.1;
        Mon, 11 Dec 2023 08:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702312858; x=1702917658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc+rwxkDvCK0xFO0GZ1YFx5JRdH7QRFS65KoHttfYIE=;
        b=GHoFS5gqpWXQQc3XWCtHCYafbz7k3ZrAJS8kmrKVX1JSt8iJGziPd9Tn4x/CbESNru
         01nzgyrpW7GOitISyc4gBFv6Br5OBzKFKPeWXVEcWMuSC2q9PlXjL1u0D3BSke6Rea8v
         8Dltj5cuYjp3h8JCrBalIMKQL7P3fs88bSuZj9tdfMw2rR8Qe6yATtI2dWusXpJG0vf+
         VgN1USjn8oQY5PNLx1P5aKrt1WmMrONnNIy20Qqa1t6spWV1zBM//bIENPCkN69Ft/Dp
         ePCGYdNutbu/MScGs5EXTxmjJJ7x76vSJsznIM7Mxocu+gujouVGv7ARLI5KWrbmuj/A
         Nzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312858; x=1702917658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lc+rwxkDvCK0xFO0GZ1YFx5JRdH7QRFS65KoHttfYIE=;
        b=n7r7ipYND/WxryH4jorUf4Jmv156tl70KaT7f9aTCcsAYYmJyqOHIQvAb8P0Dt2sg3
         3XtXu/5bdPaVluTLfYM4oh3DANGuslWYp1XC1NUobrRlhplyYTHHWI8VmCP6UXxR0VRr
         evIcbftBm2ciHgTgLTtlVS5MGLwqablHhDCEJivypAlpTUtjvYpSbcg6VGJhz/3J/H8M
         xoMi/HH3n7R9KNeVvxnHVuHkMHEO0iNSijhOazFvvcgpvRJqidMZWcB2T1Si8Z453rDH
         u6eQpHMRnM8CHvNhG1kqEwyfbP48dnBVJW+b8Z65iod8HKUEe3pSpvpGqHqrPsB8Yfzr
         ZGZQ==
X-Gm-Message-State: AOJu0YzT9lvXWT7reIAixpgutUc8qI8TQxTRuUzK9BYbXM0SFj8fq3CQ
	MwgCEp2D8Kts7L/yQ3UtW8B7EyEermvV+g==
X-Google-Smtp-Source: AGHT+IFHWuwSJ5bG5+XCx2nqfvdegIBXBitUpfYX9nlopbgruAvGI+gaTgTmGhG6NSRaNcentR9IFA==
X-Received: by 2002:a7b:cd12:0:b0:40c:3891:b0a3 with SMTP id f18-20020a7bcd12000000b0040c3891b0a3mr2630567wmj.160.1702312857795;
        Mon, 11 Dec 2023 08:40:57 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm7418679wmq.26.2023.12.11.08.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:40:57 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 02/11] tools/net/ynl-gen-rst: Sort the index of generated netlink specs
Date: Mon, 11 Dec 2023 16:40:30 +0000
Message-ID: <20231211164039.83034-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211164039.83034-1-donald.hunter@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The index of netlink specs was being generated unsorted. Sort the output
before generating the index entries.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index a1d046c60512..f0bb2f4dc4fa 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -354,7 +354,7 @@ def generate_main_index_rst(output: str) -> None:
 
     index_dir = os.path.dirname(output)
     logging.debug("Looking for .rst files in %s", index_dir)
-    for filename in os.listdir(index_dir):
+    for filename in sorted(os.listdir(index_dir)):
         if not filename.endswith(".rst") or filename == "index.rst":
             continue
         lines.append(f"   {filename.replace('.rst', '')}\n")
-- 
2.42.0


