Return-Path: <netdev+bounces-34629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD55F7A4E5F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DE31C211F4
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18B123740;
	Mon, 18 Sep 2023 16:11:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44121113
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:11:07 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7CC5FE0
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:10:15 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-656340e666eso18954766d6.1
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1695053414; x=1695658214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AWFvNFzOuw49wCC5Zxo5d6QmpGOnKT+lQbsmukcEyFk=;
        b=tM3zBcfQ6L9GKBkOthiypmRFi/ftfq3i8EgrWOyp8qeoH3ZzCgSe5qETEXfU8mh+01
         13GojkZhV1HFqAOf24obBLS435i67RI8281FsOA8f+pjAPizc52FA2POfNujCVVF5OAm
         IoYQz2mROI7z46+l44QPDoQALDb+1AtoZYJCvnT357fpLzgHc5rFhDjucjQ3C9cdzOZS
         dbqfoLNaaup/GddocZH6dCy6nLbhQj0JpvMA41hDfPtaHBYKr/Xr2v6dYaWMClRStHTC
         H623mJoaAU5pdvz3qHj7p2AjStg7zHpak0dWZOL0MFFFrdnneFvlOZvfSPeuugWeIdON
         aqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053414; x=1695658214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWFvNFzOuw49wCC5Zxo5d6QmpGOnKT+lQbsmukcEyFk=;
        b=t4/mOALNL9h4FcfPyeCYClPbzYSbIZiM8rgJOks7j9P6SLsThrElDro3+Bp2CTrCSn
         NixuISmmOcoiOCwKk3nDoL4lxF/nl2fWj0l+XvHy8i8UtstJ6BuvOCwDbqElwoXV3xNW
         KgwoGJZtMQm8qy8SjnRTdsfYuhxRZCPHTb+Zj+oSw+rq4J4dAZkT89gr9aE4NdxOCMIF
         33M3rrO9DX124hoF1xIQ6HFX6CkY1nnCdlNFrbJ6GTmqlis0xQgpjiICmlxWL0IBfZe0
         aGgmbm67nBQXNpiPSQlgTmU5TBwobrRiIsltX8NImshOfwCTd+9TOT6OI4xC/bR0i7jI
         tsVw==
X-Gm-Message-State: AOJu0Yx+nu7r4P+g8QWVaEfWtZwfYbASsQvM8oG5Co0AYIMiuDsizyJN
	asCG0O757mEVE+iUdZba+r/M8XwhJoi4ye4NkoKvBw==
X-Google-Smtp-Source: AGHT+IGEwZPGnEYe4dGdY6uWQuv43sKM8Cl4VjNrE3bUlYbAW/FCiroYxg8QweItbxJFOeD7g+4ZZQ==
X-Received: by 2002:a05:6a00:1890:b0:68f:dd50:aef8 with SMTP id x16-20020a056a00189000b0068fdd50aef8mr8357084pfh.4.1695050966027;
        Mon, 18 Sep 2023 08:29:26 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id a23-20020a62e217000000b00666e649ca46sm7333207pfi.101.2023.09.18.08.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:29:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next v3] allow overriding color option in environment
Date: Mon, 18 Sep 2023 08:29:10 -0700
Message-Id: <20230918152910.5325-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For ip, tc, and bridge command introduce IPROUTE_COLORS to enable
automatic colorization via environment variable.
Similar to how grep handles color flag.

Example:
  $ IPROUTE_COLORS=auto ip -br addr

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v3 - drop unneccessary check for NULL in match_colors
     all three callers pass valid pointer.
     drop unnecessary check for NULL in default_color

 bridge/bridge.c   |  2 +-
 include/color.h   |  1 +
 ip/ip.c           |  2 +-
 lib/color.c       | 39 +++++++++++++++++++++++++++------------
 man/man8/bridge.8 |  8 ++++++--
 man/man8/ip.8     | 14 ++++++++------
 man/man8/tc.8     |  8 ++++++--
 tc/tc.c           |  2 +-
 8 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/bridge/bridge.c b/bridge/bridge.c
index 339101a874b1..d506f75ebc46 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -102,7 +102,7 @@ static int batch(const char *name)
 int
 main(int argc, char **argv)
 {
-	int color = CONF_COLOR;
+	int color = default_color();
 
 	while (argc > 1) {
 		const char *opt = argv[1];
diff --git a/include/color.h b/include/color.h
index 17ec56f3d7b4..1ddd1bda5797 100644
--- a/include/color.h
+++ b/include/color.h
@@ -20,6 +20,7 @@ enum color_opt {
 	COLOR_OPT_ALWAYS = 2
 };
 
+int default_color(void);
 bool check_enable_color(int color, int json);
 bool matches_color(const char *arg, int *val);
 int color_fprintf(FILE *fp, enum color_attr attr, const char *fmt, ...);
diff --git a/ip/ip.c b/ip/ip.c
index 860ff957c3b3..0befe14e3d66 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -168,7 +168,7 @@ int main(int argc, char **argv)
 	const char *libbpf_version;
 	char *batch_file = NULL;
 	char *basename;
-	int color = CONF_COLOR;
+	int color = default_color();
 
 	/* to run vrf exec without root, capabilities might be set, drop them
 	 * if not needed as the first thing.
diff --git a/lib/color.c b/lib/color.c
index 59976847295c..7f58e107773b 100644
--- a/lib/color.c
+++ b/lib/color.c
@@ -93,13 +93,36 @@ bool check_enable_color(int color, int json)
 	return false;
 }
 
+static bool match_color_value(const char *arg, int *val)
+{
+	if (*arg == '\0' || !strcmp(arg, "always"))
+		*val = COLOR_OPT_ALWAYS;
+	else if (!strcmp(arg, "auto"))
+		*val = COLOR_OPT_AUTO;
+	else if (!strcmp(arg, "never"))
+		*val = COLOR_OPT_NEVER;
+	else
+		return false;
+	return true;
+}
+
+int default_color(void)
+{
+	const char *name;
+	int val;
+
+	name = getenv("IPROUTE_COLORS");
+	if (name && match_color_value(name, &val))
+		return val;
+
+	/* default is from config */
+	return CONF_COLOR;
+}
+
 bool matches_color(const char *arg, int *val)
 {
 	char *dup, *p;
 
-	if (!val)
-		return false;
-
 	dup = strdupa(arg);
 	p = strchrnul(dup, '=');
 	if (*p)
@@ -108,15 +131,7 @@ bool matches_color(const char *arg, int *val)
 	if (matches(dup, "-color"))
 		return false;
 
-	if (*p == '\0' || !strcmp(p, "always"))
-		*val = COLOR_OPT_ALWAYS;
-	else if (!strcmp(p, "auto"))
-		*val = COLOR_OPT_AUTO;
-	else if (!strcmp(p, "never"))
-		*val = COLOR_OPT_NEVER;
-	else
-		return false;
-	return true;
+	return match_color_value(p, val);
 }
 
 static void set_color_palette(void)
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index c52c9331e2c2..6ad34e4d704a 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -315,10 +315,14 @@ color output is enabled regardless of stdout state. If parameter is
 stdout is checked to be a terminal before enabling color output. If parameter is
 .BR never ,
 color output is disabled. If specified multiple times, the last one takes
-precedence. This flag is ignored if
+precedence.
+The default color setting is
+.B never
+but can be overridden by the
+.B IPROUTE_COLORS
+environment variable. This flag is ignored if
 .B \-json
 is also given.
-
 .TP
 .BR "\-j", " \-json"
 Output results in JavaScript Object Notation (JSON).
diff --git a/man/man8/ip.8 b/man/man8/ip.8
index 72227d44fd30..63858edc318d 100644
--- a/man/man8/ip.8
+++ b/man/man8/ip.8
@@ -193,15 +193,17 @@ stdout is checked to be a terminal before enabling color output. If
 parameter is
 .BR never ,
 color output is disabled. If specified multiple times, the last one takes
-precedence. This flag is ignored if
+precedence.The default color setting is
+.B never
+but can be overridden by the
+.B IPROUTE_COLORS
+environment variable. This flag is ignored if
 .B \-json
 is also given.
 
-Used color palette can be influenced by
-.BR COLORFGBG
-environment variable
-(see
-.BR ENVIRONMENT ).
+The color palette used can be adjusted with
+.B COLORFGBG
+environment variable.
 
 .TP
 .BR "\-t" , " \-timestamp"
diff --git a/man/man8/tc.8 b/man/man8/tc.8
index d436d46472af..e47817704e4c 100644
--- a/man/man8/tc.8
+++ b/man/man8/tc.8
@@ -801,10 +801,14 @@ color output is enabled regardless of stdout state. If parameter is
 stdout is checked to be a terminal before enabling color output. If parameter is
 .BR never ,
 color output is disabled. If specified multiple times, the last one takes
-precedence. This flag is ignored if
+precedence.
+The default color setting is
+.B never
+but can be overridden by the
+.B IPROUTE_COLORS
+environment variable. This flag is ignored if
 .B \-json
 is also given.
-
 .TP
 .BR "\-j", " \-json"
 Display results in JSON format.
diff --git a/tc/tc.c b/tc/tc.c
index 082c6677d34a..e8b214802d1f 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -253,7 +253,7 @@ int main(int argc, char **argv)
 {
 	const char *libbpf_version;
 	char *batch_file = NULL;
-	int color = CONF_COLOR;
+	int color = default_color();
 	int ret;
 
 	while (argc > 1) {
-- 
2.39.2


