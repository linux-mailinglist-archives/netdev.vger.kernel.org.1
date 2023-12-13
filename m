Return-Path: <netdev+bounces-57103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400028121F7
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A7DB21092
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A8283AE7;
	Wed, 13 Dec 2023 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vyp9KlOl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41181BCC;
	Wed, 13 Dec 2023 14:42:12 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-336445a2749so355985f8f.0;
        Wed, 13 Dec 2023 14:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507329; x=1703112129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3JY0Tl5uBoHE8m/ovbgncHc7wHlXG+lWF7d67MSbyU=;
        b=Vyp9KlOlSifYiLlkftXwKQCs5uwtFm25TPUf2EGBasPC0tCZ2CD7yKisozqYWlRH+j
         YhXB2fp/IuhYeh5ZotnEyLxHYUWIsOa1UBf42Y/j4NrUJiK2aD88Hb3JNmqte5rp3Yyb
         tKFn3C5ihJnN9HkVNIWeqx3PPQ+AvN3vEHspqCi/R/6PIc2MzyACpQH7e5uOlK8A0UzD
         ILiIxeengvXwJZU3zQ1L2Rx+UwuzRSCKSmNWBRgXHhKqTa9i0QPqAgpZDAVvvoh3QW1k
         A4CxeWiZuXD8f56+cmUemr1VY4beNfeeTCc76sK8ZyIw5wFnK+LYNlUbu+5FcRGx5u9z
         oQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507329; x=1703112129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3JY0Tl5uBoHE8m/ovbgncHc7wHlXG+lWF7d67MSbyU=;
        b=RvL66vkqKloCDWRK8TYwACi5gaK4bVjxd7puIowa80xCCynfljnCoJi6uDkxkR6eRW
         G+d5fnLI0tLmt4CHItzVquqBjEC+j5tBW0KJa5syxr3LuBRSZ60q50BSG7rgZuhLqIbY
         RHE2rw/eYJfRhAiFak/dHYVWzE3iGkLrmek0m1hrfI0wCk0SS8kqkqupTBRQWFdi5nty
         HbLnT/JEyeBeW95N47Gm4xGZ8IwOw5EnLIhu+9CJZm8ieIaqGSXoFJ+EH+QU8ftPXMQ2
         6pr1cVv47hmVm4GG/JdTSRf0/gUEGHNCM1u3YuQWThy0/WpSVlKDftCMiMbrnTzqcjVq
         gcIg==
X-Gm-Message-State: AOJu0YxYa/1Jvu8udXM4jUHibcf8iqAbaz2dig5QPz7tg5XxgYg9mROB
	nCN30DTccgrCLqnmvNadcoKtGaykLrvnYA==
X-Google-Smtp-Source: AGHT+IE7R1lEYc2Ylhz1odvk1h5dIilWAzLIsZYplmnPbbFi8zIIWk7XSDauaVp561tM5YYaQDW7wQ==
X-Received: by 2002:adf:e94a:0:b0:336:3510:61fb with SMTP id m10-20020adfe94a000000b00336351061fbmr1729503wrn.55.1702507329302;
        Wed, 13 Dec 2023 14:42:09 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4f0c000000b00336442b3e80sm998562wru.78.2023.12.13.14.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:42:08 -0800 (PST)
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
Subject: [PATCH net-next v4 07/13] doc/netlink/specs: use pad in structs in rt_link
Date: Wed, 13 Dec 2023 22:41:40 +0000
Message-ID: <20231213224146.94560-8-donald.hunter@gmail.com>
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


