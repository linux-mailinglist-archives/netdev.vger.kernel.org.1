Return-Path: <netdev+bounces-37031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744D07B33FC
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 15:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 02B61284003
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 13:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4524121A;
	Fri, 29 Sep 2023 13:47:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C31BE4F
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:47:51 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815BA1AB
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 06:47:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso1909166966b.1
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 06:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695995268; x=1696600068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8QojxeRYsrfEub+ueQzXhzL/3NhmUL7iaIG8nx5dBA=;
        b=sMO36QjJZaBwAn1nPLwloGHG4panPBpKQ9nxTs5x1xFm1Sh6Jj4jsxHieeoG2Ueu6b
         tWCPhCCqJgNyeohwKHzb/61gtN3xGI5A7qB1WQRtlNaGw95eQG/G01+0VmFucgjADoqz
         6WYr4iIjVWYBmilAvJCaFRE6kgSYFUOgIU+bNGOO8h04vGkGNqVxaQXoBCPkzkuWWf8b
         7+uLf1mUimIGAauYAgtz3yoCl6mt5BMAwyPgwDawRLEXZaF+TwrA86xl2rgC4S33I/Wn
         aJTbo1nmkbAP5sZIeWhiEP8Wsq4zz9n0GFJwiJym6X2BWF4EtKi1mXaBAdTBMANLzNrD
         AS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695995268; x=1696600068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8QojxeRYsrfEub+ueQzXhzL/3NhmUL7iaIG8nx5dBA=;
        b=jmaxoA9CnoZe78UnLBKgTHTdxeDSW5Vp7CsWcPbNL/S/+IKp8BsDdaeEnGdtd9D4Oz
         tZ5ru/FHQyX0joEfgr+389xXdsF+6nWFu7vJlTVWhwR8VtAB2vda8YaRGnQmlum8YMs5
         MfffHDqIXZAK8nt1XsiknljtG2smJRe4og/oS42fkxLQT6XRFCVjMSUxWIqeXxvUxo9V
         IzgBmL4JncutmKL7MYNda3huj9156snyECnh0DlF/JVUFCXXoRUcmHIh5yLungBY18nS
         CLfDm2J7D9OgFyK2G0cM7nCs70mTE9U+nSOu+3NvvNOVZwQ1C89poY0cwYhiuauvZspR
         Qf6w==
X-Gm-Message-State: AOJu0YyJIxcYZj+SZ7q2BQaMrhxG9F1nQo0VLBFG+TNz+Y4CTshV9L9j
	BEtwWTPPpx+Pe/RdrJrzb2arVvoU2oNrC9nsdzY=
X-Google-Smtp-Source: AGHT+IF/cjsxL6GZ5W70cVs2wnxZ2EiRai+4BVInWaTZ1IYQMgh/MyiCsCk+f7z16d6ueR+jf8VWyw==
X-Received: by 2002:a17:906:2212:b0:9a5:9f8d:770 with SMTP id s18-20020a170906221200b009a59f8d0770mr3981110ejs.46.1695995267820;
        Fri, 29 Sep 2023 06:47:47 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j25-20020a170906255900b0099bcf1c07c6sm12365594ejb.138.2023.09.29.06.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 06:47:47 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	donald.hunter@gmail.com
Subject: [patch net-next v2 2/3] netlink: specs: remove redundant type keys from attributes in subsets
Date: Fri, 29 Sep 2023 15:47:41 +0200
Message-ID: <20230929134742.1292632-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929134742.1292632-1-jiri@resnulli.us>
References: <20230929134742.1292632-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

No longer needed to define type for subset attributes. Remove those.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 Documentation/netlink/specs/devlink.yaml | 10 ----------
 Documentation/netlink/specs/dpll.yaml    |  8 --------
 Documentation/netlink/specs/ethtool.yaml |  3 ---
 3 files changed, 21 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index d1ebcd927149..86a12c5bcff1 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -199,54 +199,44 @@ attribute-sets:
     attributes:
       -
         name: reload-stats
-        type: nest
       -
         name: remote-reload-stats
-        type: nest
   -
     name: dl-reload-stats
     subset-of: devlink
     attributes:
       -
         name: reload-action-info
-        type: nest
   -
     name: dl-reload-act-info
     subset-of: devlink
     attributes:
       -
         name: reload-action
-        type: u8
       -
         name: reload-action-stats
-        type: nest
   -
     name: dl-reload-act-stats
     subset-of: devlink
     attributes:
       -
         name: reload-stats-entry
-        type: nest
   -
     name: dl-reload-stats-entry
     subset-of: devlink
     attributes:
       -
         name: reload-stats-limit
-        type: u8
       -
         name: reload-stats-value
-        type: u32
   -
     name: dl-info-version
     subset-of: devlink
     attributes:
       -
         name: info-version-name
-        type: string
       -
         name: info-version-value
-        type: string
 
 operations:
   enum-model: directional
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 8b86b28b47a6..1c1b53136c7b 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -278,36 +278,28 @@ attribute-sets:
     attributes:
       -
         name: parent-id
-        type: u32
       -
         name: direction
-        type: u32
       -
         name: prio
-        type: u32
       -
         name: state
-        type: u32
   -
     name: pin-parent-pin
     subset-of: pin
     attributes:
       -
         name: parent-id
-        type: u32
       -
         name: state
-        type: u32
   -
     name: frequency-range
     subset-of: pin
     attributes:
       -
         name: frequency-min
-        type: u64
       -
         name: frequency-max
-        type: u64
 
 operations:
   enum-name: dpll_cmd
diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 837b565577ca..5c7a65b009b4 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -818,13 +818,10 @@ attribute-sets:
     attributes:
       -
         name: hist-bkt-low
-        type: u32
       -
         name: hist-bkt-hi
-        type: u32
       -
         name: hist-val
-        type: u64
   -
     name: stats
     attributes:
-- 
2.41.0


