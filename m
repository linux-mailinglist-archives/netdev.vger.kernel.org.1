Return-Path: <netdev+bounces-56623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBECB80FA0D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723062821EB
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2336472A;
	Tue, 12 Dec 2023 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPrrPceE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070EFBD;
	Tue, 12 Dec 2023 14:16:38 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3363880e9f3so96999f8f.3;
        Tue, 12 Dec 2023 14:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702419396; x=1703024196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3JY0Tl5uBoHE8m/ovbgncHc7wHlXG+lWF7d67MSbyU=;
        b=bPrrPceE4Hac7MsajnStPJciJ6QDenqs1Y6oIl9eZOyKVp6OnlHMqqoG35ChbSpvn2
         H/1UgjaBHECWSqtGU9CAkbkZJbQItKX/ifIRQdNAjxQL8VBz8Qfhzuin7bHjRFUAlS7s
         xjzlRqAzqTIeZ03o5s2N8AaZahSO1rzmOWv092k+UGM7H9Y3CLsNyNPlTvOwmnHF9wfI
         K1Pc3dE7iOU20k3/gjZ0tM3sQ7iVtWKXhq2iD8dT49OebmhFMmY81QFtMiciryCOVUU0
         R+MElDxQmFqJgnuP4ZHCVr7mILu1H56tyxpX9KSAKWmB13gdruA8U5wm9v1vcj+kGexd
         diEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419396; x=1703024196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3JY0Tl5uBoHE8m/ovbgncHc7wHlXG+lWF7d67MSbyU=;
        b=VJWcNhyhGrhpX5HcDpnNnxlbeT+E919j7b+1TwWHnzhxXIHUmCsRTH4/yV1U519+oS
         XrevOcZjFYfJC5Xvl6KbiZiU8BPtuEQLGe7W2R0jaR7Ji/ZNoY9q6yYvXV7mTH6c+9T3
         2dxVpbYJrlzMB0p8+HYacDxWZib9/N5dHiwXFOFBKD/o/w00XPqnlNV1ZwhUBHqmb3u2
         YMJeyL25FJeEecOcVaNVmjB84yhNb03CfdImxOKEuVVsP/3Uc24GsqdnsKGCxaWWqIvF
         rmn167gQXdwNcJVyHRvR45Ylpc/AXaoEmOubb42QbkgDxiyqe+AS5A2UqPesk7/jvsm8
         kLKw==
X-Gm-Message-State: AOJu0YwVUsGXXljCw5rfXX+NihiWLxXfSFoCV7Lqlw/l1UgV1gNBJbZS
	3/s9qT4ICY8Cig4q8fIkfOefZ4HTg/81ww==
X-Google-Smtp-Source: AGHT+IHZd8sy/oZ7CAsAIoSO36s46HIEjR2oNrMnt8nbTm2Sb/iTHntoCVoHPxUu80VPbaT5HotIcw==
X-Received: by 2002:a5d:69cf:0:b0:336:34d2:9eb8 with SMTP id s15-20020a5d69cf000000b0033634d29eb8mr732681wrw.28.1702419396091;
        Tue, 12 Dec 2023 14:16:36 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:a1a0:2c27:44f7:b972])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm11680482wrt.22.2023.12.12.14.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:16:35 -0800 (PST)
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
Subject: [PATCH net-next v3 07/13] doc/netlink/specs: use pad in structs in rt_link
Date: Tue, 12 Dec 2023 22:15:46 +0000
Message-ID: <20231212221552.3622-8-donald.hunter@gmail.com>
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


