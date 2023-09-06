Return-Path: <netdev+bounces-32235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB35793ACB
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7511D1C20A0D
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7A5883D;
	Wed,  6 Sep 2023 11:11:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86A8485
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:11:22 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA99DCF1
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:11:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fef56f7248so34083365e9.3
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 04:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693998679; x=1694603479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpPF9RfAwT0DNIMsCCAE4BmGdPexfWTM2VW1hA0QgsU=;
        b=MW9cy3bV0xE2+VlaeEkIQ3KxwUkE7BAvqTHdeQI9ltDHXSIyd8Pp10Hi46KLiAb4S+
         F66xQGnrQP1CYzmRFWW90fd3O4LCuT8t2WWyfKGGNBx5Ux45TQwzOFK+ScJx567JM25x
         xNANBcg8vGC4Ae5FKvd+WO5wJrvT4aLhXYhu5Okv2SeWdVD64MCXEYhioPxIbZIc2OJ1
         CzfYC36mWEIWzGXSJb7eviSNOZAfPe4t7NN4QtK4dyG+G8mUy7gPGhERmITCbG+Pj6IS
         RyzJvW/K+TwMwV8bJsxznJ3ZBnMrkMB2W8BZXSEPzcweguw9m9TIpiA1Lb02wW09s7Ai
         aieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693998679; x=1694603479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpPF9RfAwT0DNIMsCCAE4BmGdPexfWTM2VW1hA0QgsU=;
        b=jWF3qUTukn2h4iFWb+CwTfotOBu/QF6pYXgbQjIeXaAc5U2vbj1KPSpuQK2qfEfoUe
         F7JhHg4iH53wK/xtnVmKPLTkbqC+FdyPa7dKcXDhZRKNFP9+xvcQE16IgDvA5B4r2I6k
         pb2f/hkshZMp2K2KX+NuzbK2Q+wwlhd4AXdH/fyDCSaM4TnXd4nZgn6vRB/PEEyi2wTT
         2+29bv9pCVujbaVa1wiZeSWQiF8DVvnOQjyAlxkM6ahmWpnpvGohxnNynJJD3e0zhOaP
         KOyLZv3XR9+1fObouju+RoOhEMS/rVSyADWRQobXyDwAWvjbbheNh7+BkFvnctw/a8Mz
         s7rg==
X-Gm-Message-State: AOJu0YwsfR/Y3SQqWX1gFebh8fB4C84PQVRCjqc8eb3j1+pdCf8Ppa/8
	c9Gf2zqu9JdTW2TPGqsVuPNhbdUec1DKZjKt9pw=
X-Google-Smtp-Source: AGHT+IEf4iCqwdqyPaNp/qC6rDLMtTG7SRwtr0XG4XbcRYaeYZgE8KFT25nUYG6dIUQaJgSzkbA/Aw==
X-Received: by 2002:a05:600c:378c:b0:401:8225:14ee with SMTP id o12-20020a05600c378c00b00401822514eemr1973623wmr.41.1693998679454;
        Wed, 06 Sep 2023 04:11:19 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o9-20020adfe809000000b003176c6e87b1sm20256482wrm.81.2023.09.06.04.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:11:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next v2 2/6] devlink: make parsing of handle non-destructive to argv
Date: Wed,  6 Sep 2023 13:11:09 +0200
Message-ID: <20230906111113.690815-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906111113.690815-1-jiri@resnulli.us>
References: <20230906111113.690815-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Currently, handle parsing is destructive as the "\0" string ends are
being put in certain positions during parsing. That prevents it from
being used repeatedly. This is problematic with the follow-up patch
implementing dry-parsing. Fix by making a copy of handle argv during
parsing.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 6643f659a8bd..f383028ec560 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -378,6 +378,7 @@ struct dl {
 	struct list_head ifname_map_list;
 	int argc;
 	char **argv;
+	char *handle_argv;
 	bool no_nice_names;
 	struct dl_opts opts;
 	bool json_output;
@@ -1066,9 +1067,8 @@ static int __dl_argv_handle(char *str, char **p_bus_name, char **p_dev_name)
 	return 0;
 }
 
-static int dl_argv_handle(struct dl *dl, char **p_bus_name, char **p_dev_name)
+static int dl_argv_handle(char *str, char **p_bus_name, char **p_dev_name)
 {
-	char *str = dl_argv_next(dl);
 	int err;
 
 	err = ident_str_validate(str, 1);
@@ -1121,10 +1121,9 @@ static int __dl_argv_handle_port_ifname(struct dl *dl, char *str,
 	return 0;
 }
 
-static int dl_argv_handle_port(struct dl *dl, char **p_bus_name,
+static int dl_argv_handle_port(struct dl *dl, char *str, char **p_bus_name,
 			       char **p_dev_name, uint32_t *p_port_index)
 {
-	char *str = dl_argv_next(dl);
 	unsigned int slash_count;
 
 	if (!str) {
@@ -1146,11 +1145,10 @@ static int dl_argv_handle_port(struct dl *dl, char **p_bus_name,
 	}
 }
 
-static int dl_argv_handle_both(struct dl *dl, char **p_bus_name,
+static int dl_argv_handle_both(struct dl *dl, char *str, char **p_bus_name,
 			       char **p_dev_name, uint32_t *p_port_index,
 			       uint64_t *p_handle_bit)
 {
-	char *str = dl_argv_next(dl);
 	unsigned int slash_count;
 	int err;
 
@@ -1199,10 +1197,9 @@ static int __dl_argv_handle_name(char *str, char **p_bus_name,
 	return str_split_by_char(handlestr, p_bus_name, p_dev_name, '/');
 }
 
-static int dl_argv_handle_region(struct dl *dl, char **p_bus_name,
+static int dl_argv_handle_region(char *str, char **p_bus_name,
 				 char **p_dev_name, char **p_region)
 {
-	char *str = dl_argv_next(dl);
 	int err;
 
 	err = ident_str_validate(str, 2);
@@ -1218,10 +1215,9 @@ static int dl_argv_handle_region(struct dl *dl, char **p_bus_name,
 }
 
 
-static int dl_argv_handle_rate_node(struct dl *dl, char **p_bus_name,
+static int dl_argv_handle_rate_node(char *str, char **p_bus_name,
 				    char **p_dev_name, char **p_node)
 {
-	char *str = dl_argv_next(dl);
 	int err;
 
 	err = ident_str_validate(str, 2);
@@ -1244,11 +1240,10 @@ static int dl_argv_handle_rate_node(struct dl *dl, char **p_bus_name,
 	return err;
 }
 
-static int dl_argv_handle_rate(struct dl *dl, char **p_bus_name,
+static int dl_argv_handle_rate(char *str, char **p_bus_name,
 			       char **p_dev_name, uint32_t *p_port_index,
 			       char **p_node_name, uint64_t *p_handle_bit)
 {
-	char *str = dl_argv_next(dl);
 	char *identifier;
 	int err;
 
@@ -1698,14 +1693,24 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 {
 	struct dl_opts *opts = &dl->opts;
 	uint64_t o_all = o_required | o_optional;
+	char *str = dl_argv_next(dl);
 	uint64_t o_found = 0;
 	int err;
 
+	if (str) {
+		str = strdup(str);
+		if (!str)
+			return -ENOMEM;
+		free(dl->handle_argv);
+		dl->handle_argv = str;
+	}
+
 	if (o_required & DL_OPT_HANDLE && o_required & DL_OPT_HANDLEP) {
 		uint64_t handle_bit;
 
-		err = dl_argv_handle_both(dl, &opts->bus_name, &opts->dev_name,
-					  &opts->port_index, &handle_bit);
+		err = dl_argv_handle_both(dl, str, &opts->bus_name,
+					  &opts->dev_name, &opts->port_index,
+					  &handle_bit);
 		if (err)
 			return err;
 		o_required &= ~(DL_OPT_HANDLE | DL_OPT_HANDLEP) | handle_bit;
@@ -1714,7 +1719,7 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 		   o_required & DL_OPT_PORT_FN_RATE_NODE_NAME) {
 		uint64_t handle_bit;
 
-		err = dl_argv_handle_rate(dl, &opts->bus_name, &opts->dev_name,
+		err = dl_argv_handle_rate(str, &opts->bus_name, &opts->dev_name,
 					  &opts->port_index,
 					  &opts->rate_node_name,
 					  &handle_bit);
@@ -1724,25 +1729,25 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			handle_bit;
 		o_found |= handle_bit;
 	} else if (o_required & DL_OPT_HANDLE) {
-		err = dl_argv_handle(dl, &opts->bus_name, &opts->dev_name);
+		err = dl_argv_handle(str, &opts->bus_name, &opts->dev_name);
 		if (err)
 			return err;
 		o_found |= DL_OPT_HANDLE;
 	} else if (o_required & DL_OPT_HANDLEP) {
-		err = dl_argv_handle_port(dl, &opts->bus_name, &opts->dev_name,
-					  &opts->port_index);
+		err = dl_argv_handle_port(dl, str, &opts->bus_name,
+					  &opts->dev_name, &opts->port_index);
 		if (err)
 			return err;
 		o_found |= DL_OPT_HANDLEP;
 	} else if (o_required & DL_OPT_HANDLE_REGION) {
-		err = dl_argv_handle_region(dl, &opts->bus_name,
+		err = dl_argv_handle_region(str, &opts->bus_name,
 					    &opts->dev_name,
 					    &opts->region_name);
 		if (err)
 			return err;
 		o_found |= DL_OPT_HANDLE_REGION;
 	} else if (o_required & DL_OPT_PORT_FN_RATE_NODE_NAME) {
-		err = dl_argv_handle_rate_node(dl, &opts->bus_name,
+		err = dl_argv_handle_rate_node(str, &opts->bus_name,
 					       &opts->dev_name,
 					       &opts->rate_node_name);
 		if (err)
@@ -9902,6 +9907,7 @@ static struct dl *dl_alloc(void)
 
 static void dl_free(struct dl *dl)
 {
+	free(dl->handle_argv);
 	free(dl);
 }
 
-- 
2.41.0


