Return-Path: <netdev+bounces-57097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DFF8121E9
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2D91F21673
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3168184E;
	Wed, 13 Dec 2023 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtJ6y0Xj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861A2D46;
	Wed, 13 Dec 2023 14:42:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-336417c565eso825342f8f.3;
        Wed, 13 Dec 2023 14:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507336; x=1703112136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj94wzE87RLEym7VefjYamBPKqN2ktHl1CeOxhfULeA=;
        b=PtJ6y0XjA99fFGsP8c3sqcqlQoO7vgVqLSne2f5XoUPlbSHCWThlUOaduyU65Tlxtd
         KFHXp7xF2LHfl/IQ0yHpbWMFClvFPH6zb1lKLMLDiaFV7ZBgjW/yg1rkL85G/x3FEfCL
         /ul+eCc5kd7aRzTlGstv51vnnkpXcZ/eZ3sS5l0vArAbvThgh5HTehxtgg8vL1grOYoE
         6IKiVXoliXXYKp/gZ7Tn41zkXKk8i2/oeC1CQMlrVjGI7YyFS5Qsf4W05zR4Qkb6irko
         0uaS1zuf1vKEXgTvCu8YCrtr6mpijHRKwcJDf2qyjY+MfxICK5uyeAKUK23yVA6gOnmJ
         790Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507336; x=1703112136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uj94wzE87RLEym7VefjYamBPKqN2ktHl1CeOxhfULeA=;
        b=HH6xuX/ifVkZdmq74iDT2itUpkL3dX3wTKrojGtx6nQwfg9iSLwDvySHJQmFELjIfR
         iI2PfquwgGFq+0Z1SLn7gVp4j4TYIGdqmKqZKeO3NSSV5Eq9M1rWJeD5u2TX7Yke4Zo9
         oZd6DLy1itr7gC6mwO9pNa6nsn6in0R1OGq7H+aS0t08VnXAQ2ct57FBZv3E0pCl7+b8
         qsuAwwKr2h8l1g3L7G9Xb3TlJ2BG7/QnHvvuzkQhRQSZvxpvcPKeGR0lPsO1CJj6U1fW
         7ActbehfdFYkOLbRKLD/pls9rIF7Cno6aipxx4L4de0SqvReg7G7d88Um1FoWal5Cty5
         F0Kg==
X-Gm-Message-State: AOJu0YyxsKTvbtzc5Fd0NhtbDSYURGCV900Mb1OOFlT5JlY96uUl0Rv2
	FNg2jFDWoEkML+jghxaNwiS9xZz+XgfgBw==
X-Google-Smtp-Source: AGHT+IFKAWeGIvpyQ01t5wZdlrjaHPGt+VQIM92P6srZCK0gKoTeZzZDpaFTyKFUS/kNqSgKhyBQ/A==
X-Received: by 2002:adf:ff8d:0:b0:336:462a:dc16 with SMTP id j13-20020adfff8d000000b00336462adc16mr74936wrr.166.1702507335913;
        Wed, 13 Dec 2023 14:42:15 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4f0c000000b00336442b3e80sm998562wru.78.2023.12.13.14.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:42:14 -0800 (PST)
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
Subject: [PATCH net-next v4 11/13] tools/net/ynl-gen-rst: Sort the index of generated netlink specs
Date: Wed, 13 Dec 2023 22:41:44 +0000
Message-ID: <20231213224146.94560-12-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213224146.94560-1-donald.hunter@gmail.com>
References: <20231213224146.94560-1-donald.hunter@gmail.com>
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
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


