Return-Path: <netdev+bounces-56628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F880FA19
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7A41C20DE5
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186C666101;
	Tue, 12 Dec 2023 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJNgGhIS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C18AA;
	Tue, 12 Dec 2023 14:16:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-336166b8143so3594900f8f.3;
        Tue, 12 Dec 2023 14:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702419404; x=1703024204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1Cw3Yu6aGvXs5Wx/DiJERo5X0a59a10/3prA+sLwwY=;
        b=CJNgGhIS2yFvXiUCP6sNktfYb2F+zb75yvxVKogRLUaXyQq1T459dUa8nlwPpoe5lk
         Y3isIKdiMDdVx4C4kg/dtxuRS3bGpZtoE8EjfIzoTWoe7YecA9SiQWx/ZaDPuaMdHdCi
         qUOpoNAxyWbkuFUcF62gQJ1Y3WJOKqFaqd+iENHj8p57EjudebfdpR4t2ZmrG/mM5uHL
         8dQxoU8jAGvmx6SFwlPR4OMRIf0NoSvljUqHRJyZM4yIAg0K68+c40kUsUVbKgs8ARJn
         Z1NOKqvy2EV3C2Fqc4fE9+Tb3aKfDY/S5T+fzeYot77cQ1eiU+42HDuDSkrW2idxxVG+
         Cnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419404; x=1703024204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1Cw3Yu6aGvXs5Wx/DiJERo5X0a59a10/3prA+sLwwY=;
        b=lJ3Vjxk40xVgcT4pkQ0rCw17WWX5OM9dcQDPszb9dfaZwAt+rnc3rMpxha76VPKmZs
         uU5oWp7AL0FnTRccxAVu7/78vssDviTxOy4T1lxytCxz7BjWmSHYltViV16/e+xCdm08
         8eSzqyd72XnyHbkDaTYHLGXnWvNBcUzZFWCiwLG642MKLhqTeEGDWvVxzkxN4H53XNW5
         KCUhk/1SoUX7ninol7CD9xHakH4uxgF7OeWvfZhbLYReKRRzjzDaQJA2F2Y2TdK4Qk0X
         bNgKoCYIsfgiZoNUfZDe50kRXHxvt6WbiBGWbKsZeljXQe1gyERAlakDBq9ahBn2fnQ1
         7CdQ==
X-Gm-Message-State: AOJu0YzfUlnbTXD9dGth+3Il65QDs870GA/wNGhPV/Ekx4MF3hSsUZm7
	tQimHHLhJfcZnExlNMxaGBYKSJ3M+phtrw==
X-Google-Smtp-Source: AGHT+IEn3WXHXbYrN77yKklDgvS8j8yKX4bkmropEc0jRswZCj2pz3Zib9LmFOWwFAIkNFHkwJtkdg==
X-Received: by 2002:adf:9dca:0:b0:336:36a0:2e53 with SMTP id q10-20020adf9dca000000b0033636a02e53mr379987wre.48.1702419404375;
        Tue, 12 Dec 2023 14:16:44 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:a1a0:2c27:44f7:b972])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm11680482wrt.22.2023.12.12.14.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:16:43 -0800 (PST)
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
Subject: [PATCH net-next v3 12/13] tools/net/ynl-gen-rst: Remove bold from attribute-set headings
Date: Tue, 12 Dec 2023 22:15:51 +0000
Message-ID: <20231212221552.3622-13-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212221552.3622-1-donald.hunter@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generated .rst for attribute-sets currently uses a sub-sub-heading
for each attribute, with the attribute name in bold. This makes
attributes stand out more than the attribute-set sub-headings they are
part of.

Remove the bold markup from attribute sub-sub-headings.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 6b7afaa56e22..675ae8357d5e 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -235,7 +235,7 @@ def parse_attr_sets(entries: List[Dict[str, Any]]) -> str:
         lines.append(rst_section(entry["name"]))
         for attr in entry["attributes"]:
             type_ = attr.get("type")
-            attr_line = bold(attr["name"])
+            attr_line = attr["name"]
             if type_:
                 # Add the attribute type in the same line
                 attr_line += f" ({inline(type_)})"
-- 
2.42.0


