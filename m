Return-Path: <netdev+bounces-14964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5977449E8
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 16:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CCC1C20B80
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46D6C2D6;
	Sat,  1 Jul 2023 14:38:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A961DC2C0
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 14:38:07 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD8E35B7;
	Sat,  1 Jul 2023 07:38:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-668704a5b5bso2306632b3a.0;
        Sat, 01 Jul 2023 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688222284; x=1690814284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7QFlP+ck1sPDbYpq6eJw7KwHc8WuXZIyqHl9nsKIb7k=;
        b=Kph4vMT3O1lFXNh2Wx+M6qCEneYiOdGzdWYvDPJmMecVmiRyARZVfLoUtmwAD49qtn
         AgqHgnBSb4vil9AvnDza0sWVtCBHQBY5X61cfphfFjoRjr1uHOLQl9wE8Urk69c1FvIz
         wDLSwWuN+xPhUaTb8do6TnaVw4E8BxZKQIexSJMP+cZ64zR9x3/XPpkR2/ZbcpFxfGDl
         qXzYUPkqe8ZWpvCU2+uDYxiKwCtoXWtUnp+tBtsxChda2hWySBCwRvTMsWTzdQeqmDGj
         YmKq1WM19DqMU/GRfZLd7RC9QOPOauO+SbXxAq0InwymnSnFX355UYBa0fUHTs1in5Eb
         HWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688222284; x=1690814284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QFlP+ck1sPDbYpq6eJw7KwHc8WuXZIyqHl9nsKIb7k=;
        b=BTRT+kz1OKfB2QOSFgiz20kpoVYN29t+9Wp8Mos9tqO2ZbpjghAWivEnCQPKAl7mCm
         bU1hPAK7RE7p4qS4cn06YKhSZ4DpSzkZpmiaS5cPfJ95zYOzOk6BagqpuPB1fzU4V4eU
         w3Qm2QeyQU5+J65JwJwdUqdp0Wql54gEwQoY/usNusRnpMsgPI6ozisBkVp81NDBtMNw
         m+oX9EimxpQqwJ26Wy99PljUIf+C+KqBouivaZezIZdGlF9fxCdxoIX5oacI1KXP5YBz
         8YTSWZVS1lT/u/W3ybJfbYAArdoaE+SipRrK9zlQcmRW0w0rEvQUCrnp23cCKzvR+NbS
         PULA==
X-Gm-Message-State: ABy/qLYeSVp/ZVS+B9FclOMvMSTRymVF0zqKObbNYNA/WbM+w5aAQ282
	AQvACjGgHF6HT8Tr6YeykdYbMpvTFLbLnC+p
X-Google-Smtp-Source: APBJJlEb7OoJf2O7FO1WZj+uSvXwXJDTgNRmadjiLVb2vQzYmeObXFmhNFSCrJ6ToyE3UYtW+kpYyQ==
X-Received: by 2002:a05:6a00:1a54:b0:667:85e6:4d1 with SMTP id h20-20020a056a001a5400b0066785e604d1mr6564462pfv.33.1688222284456;
        Sat, 01 Jul 2023 07:38:04 -0700 (PDT)
Received: from localhost.localdomain ([117.147.109.75])
        by smtp.gmail.com with ESMTPSA id r13-20020a635d0d000000b005533c53f550sm12229758pgb.45.2023.07.01.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 07:38:04 -0700 (PDT)
From: "J.J. Martzki" <mars14850@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pabeni@redhat.com,
	netdev@vger.kernel.org,
	"J.J. Martzki" <mars14850@gmail.com>
Subject: [PATCH] samples: pktgen: fix append mode failed issue
Date: Sat,  1 Jul 2023 22:37:37 +0800
Message-Id: <20230701143737.65471-1-mars14850@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Each sample script sources functions.sh before parameters.sh
which makes $APPEND undefined when trapping EXIT no matter in
append mode or not. Due to this when sample scripts finished
they always do "pgctrl reset" which resets pktgen config.

So move trap to each script after sourcing parameters.sh
and trap EXIT explicitly.

Signed-off-by: J.J. Martzki <mars14850@gmail.com>
---
 samples/pktgen/functions.sh                         | 13 +++++++------
 .../pktgen/pktgen_bench_xmit_mode_netif_receive.sh  |  4 ++++
 samples/pktgen/pktgen_bench_xmit_mode_queue_xmit.sh |  4 ++++
 samples/pktgen/pktgen_sample01_simple.sh            |  4 ++++
 samples/pktgen/pktgen_sample02_multiqueue.sh        |  3 +++
 samples/pktgen/pktgen_sample03_burst_single_flow.sh |  4 ++++
 samples/pktgen/pktgen_sample04_many_flows.sh        |  4 ++++
 samples/pktgen/pktgen_sample05_flow_per_thread.sh   |  4 ++++
 ...ktgen_sample06_numa_awared_queue_irq_affinity.sh |  3 +++
 9 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/samples/pktgen/functions.sh b/samples/pktgen/functions.sh
index dd4e53ae9b73..c08cefb8eb1f 100644
--- a/samples/pktgen/functions.sh
+++ b/samples/pktgen/functions.sh
@@ -108,12 +108,13 @@ function pgset() {
     fi
 }
 
-if [[ -z "$APPEND" ]]; then
-	if [[ $EUID -eq 0 ]]; then
-		# Cleanup pktgen setup on exit if thats not "append mode"
-		trap 'pg_ctrl "reset"' EXIT
-	fi
-fi
+function trap_exit()
+{
+    # Cleanup pktgen setup on exit if thats not "append mode"
+    if [[ -z "$APPEND" ]] && [[ $EUID -eq 0 ]]; then
+        trap 'pg_ctrl "reset"' EXIT
+    fi
+}
 
 ## -- General shell tricks --
 
diff --git a/samples/pktgen/pktgen_bench_xmit_mode_netif_receive.sh b/samples/pktgen/pktgen_bench_xmit_mode_netif_receive.sh
index 99ec0688b044..b4328db4a164 100755
--- a/samples/pktgen/pktgen_bench_xmit_mode_netif_receive.sh
+++ b/samples/pktgen/pktgen_bench_xmit_mode_netif_receive.sh
@@ -33,6 +33,10 @@ root_check_run_with_sudo "$@"
 
 # Parameter parsing via include
 source ${basedir}/parameters.sh
+
+# Trap EXIT first
+trap_exit
+
 # Using invalid DST_MAC will cause the packets to get dropped in
 # ip_rcv() which is part of the test
 if [ -z "$DEST_IP" ]; then
diff --git a/samples/pktgen/pktgen_bench_xmit_mode_queue_xmit.sh b/samples/pktgen/pktgen_bench_xmit_mode_queue_xmit.sh
index 04b0dd0c36d6..f2beb512c5cd 100755
--- a/samples/pktgen/pktgen_bench_xmit_mode_queue_xmit.sh
+++ b/samples/pktgen/pktgen_bench_xmit_mode_queue_xmit.sh
@@ -14,6 +14,10 @@ root_check_run_with_sudo "$@"
 
 # Parameter parsing via include
 source ${basedir}/parameters.sh
+
+# Trap EXIT first
+trap_exit
+
 if [ -z "$DEST_IP" ]; then
     [ -z "$IP6" ] && DEST_IP="198.18.0.42" || DEST_IP="FD00::1"
 fi
diff --git a/samples/pktgen/pktgen_sample01_simple.sh b/samples/pktgen/pktgen_sample01_simple.sh
index 09a92ea963f9..cdb9f497f87d 100755
--- a/samples/pktgen/pktgen_sample01_simple.sh
+++ b/samples/pktgen/pktgen_sample01_simple.sh
@@ -13,6 +13,10 @@ root_check_run_with_sudo "$@"
 # - go look in parameters.sh to see which setting are avail
 # - required param is the interface "-i" stored in $DEV
 source ${basedir}/parameters.sh
+
+# Trap EXIT first
+trap_exit
+
 #
 # Set some default params, if they didn't get set
 if [ -z "$DEST_IP" ]; then
diff --git a/samples/pktgen/pktgen_sample02_multiqueue.sh b/samples/pktgen/pktgen_sample02_multiqueue.sh
index 7fa41c84c32f..93f33d7d0a81 100755
--- a/samples/pktgen/pktgen_sample02_multiqueue.sh
+++ b/samples/pktgen/pktgen_sample02_multiqueue.sh
@@ -14,6 +14,9 @@ root_check_run_with_sudo "$@"
 # Required param: -i dev in $DEV
 source ${basedir}/parameters.sh
 
+# Trap EXIT first
+trap_exit
+
 [ -z "$COUNT" ] && COUNT="100000" # Zero means indefinitely
 
 # Base Config
diff --git a/samples/pktgen/pktgen_sample03_burst_single_flow.sh b/samples/pktgen/pktgen_sample03_burst_single_flow.sh
index 8bf2fdffba16..8f8ed1ac46a0 100755
--- a/samples/pktgen/pktgen_sample03_burst_single_flow.sh
+++ b/samples/pktgen/pktgen_sample03_burst_single_flow.sh
@@ -25,6 +25,10 @@ root_check_run_with_sudo "$@"
 
 # Parameter parsing via include
 source ${basedir}/parameters.sh
+
+# Trap EXIT first
+trap_exit
+
 # Set some default params, if they didn't get set
 if [ -z "$DEST_IP" ]; then
     [ -z "$IP6" ] && DEST_IP="198.18.0.42" || DEST_IP="FD00::1"
diff --git a/samples/pktgen/pktgen_sample04_many_flows.sh b/samples/pktgen/pktgen_sample04_many_flows.sh
index cff51f861506..65ed486ce4f1 100755
--- a/samples/pktgen/pktgen_sample04_many_flows.sh
+++ b/samples/pktgen/pktgen_sample04_many_flows.sh
@@ -12,6 +12,10 @@ root_check_run_with_sudo "$@"
 
 # Parameter parsing via include
 source ${basedir}/parameters.sh
+
+# Trap EXIT first
+trap_exit
+
 # Set some default params, if they didn't get set
 if [ -z "$DEST_IP" ]; then
     [ -z "$IP6" ] && DEST_IP="198.18.0.42" || DEST_IP="FD00::1"
diff --git a/samples/pktgen/pktgen_sample05_flow_per_thread.sh b/samples/pktgen/pktgen_sample05_flow_per_thread.sh
index 3578d0aa4ac5..bcbc386b2284 100755
--- a/samples/pktgen/pktgen_sample05_flow_per_thread.sh
+++ b/samples/pktgen/pktgen_sample05_flow_per_thread.sh
@@ -16,6 +16,10 @@ root_check_run_with_sudo "$@"
 
 # Parameter parsing via include
 source ${basedir}/parameters.sh
+
+# Trap EXIT first
+trap_exit
+
 # Set some default params, if they didn't get set
 if [ -z "$DEST_IP" ]; then
     [ -z "$IP6" ] && DEST_IP="198.18.0.42" || DEST_IP="FD00::1"
diff --git a/samples/pktgen/pktgen_sample06_numa_awared_queue_irq_affinity.sh b/samples/pktgen/pktgen_sample06_numa_awared_queue_irq_affinity.sh
index 264cc5db9c49..0c5409cb5bab 100755
--- a/samples/pktgen/pktgen_sample06_numa_awared_queue_irq_affinity.sh
+++ b/samples/pktgen/pktgen_sample06_numa_awared_queue_irq_affinity.sh
@@ -14,6 +14,9 @@ root_check_run_with_sudo "$@"
 # Required param: -i dev in $DEV
 source ${basedir}/parameters.sh
 
+# Trap EXIT first
+trap_exit
+
 # Base Config
 [ -z "$COUNT" ]     && COUNT="20000000"   # Zero means indefinitely
 [ -z "$CLONE_SKB" ] && CLONE_SKB="0"
-- 
2.39.2 (Apple Git-143)


