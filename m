Return-Path: <netdev+bounces-235959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10593C37710
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 20:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56C0E4F1904
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 19:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FC931BCA9;
	Wed,  5 Nov 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9xlxQE3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF52F29
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369802; cv=none; b=sFG6NjKt4WXN2PWmnD1fh1tLU3Damou4/mYlc2OAvx/UcaLt2yO4EWMuym7SmU+o8A0W6O7mgflfo74mqD0HM5BKpGgUxcmJIxs3W0mT8j6w7h8pn9UPWbFkr0w81bwhmOb3tDa+zB9NmpfMnhr/N3vLg2D7g9w+DjjPgh0G1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369802; c=relaxed/simple;
	bh=WtDoxLAB+pagHFY90q1VC1PoBncwGJ2OqzmZTqPCTyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U56RdBMXTgKemXacdG+SljA5W0qLPuaoV/JUYJHGXuw5nrZaxMZnvy4My8Daq+Es6Z4sExMmF33/MRoX/QMFJU06T4Jx2s1HEZu2gZ2cEHql3ZPw7fjmUFB5nipRkHt7X8tmyMakoZO3+o18Jq389XUIGS3Z2JDLqAjCqoVj4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9xlxQE3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762369797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=foW1WVSyO5IhwvgcB9OaWE3W4gqUg6ircXXsum3Jz/w=;
	b=f9xlxQE3UOddrcvpLgrRqjDiz5G4uFUj3Ye9Q8lzcKaU4hj7l0D1z/lG9DNU8h8svbv+GY
	NXv0DCdjepyTFI+ScAdcriVWNbR3qOTdiMew0BAr7Ukb1ZN9/XreydTuxDc26OG8oGw+Q1
	tEZf8FRsqq3Ne3xYk6dG6hUbXrVfbj4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-kbOYFsneOh2_Lq8jgN9OSQ-1; Wed,
 05 Nov 2025 14:09:55 -0500
X-MC-Unique: kbOYFsneOh2_Lq8jgN9OSQ-1
X-Mimecast-MFC-AGG-ID: kbOYFsneOh2_Lq8jgN9OSQ_1762369794
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF3A31956080;
	Wed,  5 Nov 2025 19:09:53 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.91])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A9A31800451;
	Wed,  5 Nov 2025 19:09:51 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	jiri@resnulli.us,
	Petr Oros <poros@redhat.com>,
	Ivan Vecera <ivecera@redhat.com>
Subject: [PATCH iproute2-next] dpll: Add dpll command
Date: Wed,  5 Nov 2025 20:09:39 +0100
Message-ID: <20251105190939.1067902-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add a new userspace tool for managing and monitoring DPLL devices via the
Linux kernel DPLL subsystem. The tool uses libmnl for netlink communication
and provides a complete interface for device and pin configuration.

The tool supports:

- Device management: enumerate devices, query capabilities (lock status,
  temperature, supported modes, clock quality levels), configure phase-offset
  monitoring and averaging

- Pin management: enumerate pins with hierarchical relationships, configure
  frequencies (including esync), phase adjustments, priorities, states, and
  directions

- Complex topologies: handle parent-device and parent-pin relationships,
  reference synchronization tracking, multi-attribute queries (frequency
  ranges, capabilities)

- ID resolution: query device/pin IDs by various attributes (module-name,
  clock-id, board-label, type)

- Monitoring: real-time display of device and pin state changes via netlink
  multicast notifications

- Output formats: both human-readable and JSON output (with pretty-print
  support)

The tool belongs in iproute2 as DPLL devices are tightly integrated with
network interfaces - modern NICs provide hardware clock synchronization
support. The DPLL subsystem uses the same netlink infrastructure as other
networking subsystems, and the tool follows established iproute2 patterns
for command structure, output formatting, and error handling.

Example usage:

  # dpll device show
  # dpll device id-get module-name ice
  # dpll device set id 0 phase-offset-monitor enable
  # dpll pin show
  # dpll pin set id 0 frequency 10000000
  # dpll pin set id 13 parent-device 0 state connected prio 10
  # dpll pin set id 0 reference-sync 1 state connected
  # dpll monitor
  # dpll -j -p device show

Co-developed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Makefile             |    3 +-
 bash-completion/dpll |  316 +++++++
 dpll/.gitignore      |    1 +
 dpll/Makefile        |   38 +
 dpll/dpll.c          | 2022 ++++++++++++++++++++++++++++++++++++++++++
 man/man8/dpll.8      |  433 +++++++++
 6 files changed, 2812 insertions(+), 1 deletion(-)
 create mode 100644 bash-completion/dpll
 create mode 100644 dpll/.gitignore
 create mode 100644 dpll/Makefile
 create mode 100644 dpll/dpll.c
 create mode 100644 man/man8/dpll.8

diff --git a/Makefile b/Makefile
index 50545ef6bfdf3d..1bebf08fed4771 100644
--- a/Makefile
+++ b/Makefile
@@ -71,7 +71,7 @@ YACCFLAGS = -d -t -v
 
 SUBDIRS=lib ip tc bridge misc netem genl man
 ifeq ($(HAVE_MNL),y)
-SUBDIRS += tipc devlink rdma dcb vdpa netshaper
+SUBDIRS += tipc devlink rdma dcb vdpa netshaper dpll
 endif
 
 LIBNETLINK=../lib/libutil.a ../lib/libnetlink.a
@@ -111,6 +111,7 @@ install: all
 	install -m 0755 -d $(DESTDIR)$(BASH_COMPDIR)
 	install -m 0644 bash-completion/tc $(DESTDIR)$(BASH_COMPDIR)
 	install -m 0644 bash-completion/devlink $(DESTDIR)$(BASH_COMPDIR)
+	install -m 0644 bash-completion/dpll $(DESTDIR)$(BASH_COMPDIR)
 	install -m 0644 include/bpf_elf.h $(DESTDIR)$(HDRDIR)
 
 version:
diff --git a/bash-completion/dpll b/bash-completion/dpll
new file mode 100644
index 00000000000000..6e4d39a5b5b6bb
--- /dev/null
+++ b/bash-completion/dpll
@@ -0,0 +1,316 @@
+# bash completion for dpll(8)                             -*- shell-script -*-
+
+# Get all the optional commands for dpll
+_dpll_get_optional_commands()
+{
+    local object=$1; shift
+
+    local filter_options=""
+    local options="$(dpll $object help 2>&1 \
+        | command sed -n -e "s/^.*dpll $object //p" \
+        | cut -d " " -f 1)"
+
+    # Remove duplicate options from "dpll $OBJECT help" command
+    local opt
+    for opt in $options; do
+        if [[ $filter_options =~ $opt ]]; then
+            continue
+        else
+            filter_options="$filter_options $opt"
+        fi
+    done
+
+    echo $filter_options
+}
+
+# Complete based on given word
+_dpll_direct_complete()
+{
+    local device_id pin_id value
+
+    case $1 in
+        device_id)
+            value=$(dpll -j device show 2>/dev/null \
+                    | jq '.device[].id' 2>/dev/null)
+            ;;
+        pin_id)
+            value=$(dpll -j pin show 2>/dev/null \
+                    | jq '.pin[].id' 2>/dev/null)
+            ;;
+        module_name)
+            value=$(dpll -j device show 2>/dev/null \
+                    | jq -r '.device[]."module-name"' 2>/dev/null \
+                    | sort -u)
+            ;;
+    esac
+
+    echo $value
+}
+
+# Handle device subcommands
+_dpll_device()
+{
+    local command=$1
+
+    case $command in
+        show)
+            case $prev in
+                id)
+                    COMPREPLY=( $( compgen -W \
+                        "$(_dpll_direct_complete device_id)" -- "$cur" ) )
+                    return 0
+                    ;;
+                *)
+                    COMPREPLY=( $( compgen -W "id" -- "$cur" ) )
+                    return 0
+                    ;;
+            esac
+            ;;
+        set)
+            case $prev in
+                id)
+                    COMPREPLY=( $( compgen -W \
+                        "$(_dpll_direct_complete device_id)" -- "$cur" ) )
+                    return 0
+                    ;;
+                phase-offset-monitor)
+                    COMPREPLY=( $( compgen -W "enable disable true false 0 1" -- "$cur" ) )
+                    return 0
+                    ;;
+                phase-offset-avg-factor)
+                    # numeric value, no completion
+                    return 0
+                    ;;
+                *)
+                    COMPREPLY=( $( compgen -W "id phase-offset-monitor \
+                        phase-offset-avg-factor" -- "$cur" ) )
+                    return 0
+                    ;;
+            esac
+            ;;
+        id-get)
+            case $prev in
+                module-name)
+                    COMPREPLY=( $( compgen -W \
+                        "$(_dpll_direct_complete module_name)" -- "$cur" ) )
+                    return 0
+                    ;;
+                clock-id)
+                    # numeric value, no completion
+                    return 0
+                    ;;
+                type)
+                    COMPREPLY=( $( compgen -W "pps eec" -- "$cur" ) )
+                    return 0
+                    ;;
+                *)
+                    COMPREPLY=( $( compgen -W "module-name clock-id type" \
+                        -- "$cur" ) )
+                    return 0
+                    ;;
+            esac
+            ;;
+    esac
+}
+
+# Handle pin subcommands
+_dpll_pin()
+{
+    local command=$1
+
+    case $command in
+        show)
+            case $prev in
+                id)
+                    COMPREPLY=( $( compgen -W \
+                        "$(_dpll_direct_complete pin_id)" -- "$cur" ) )
+                    return 0
+                    ;;
+                device)
+                    COMPREPLY=( $( compgen -W \
+                        "$(_dpll_direct_complete device_id)" -- "$cur" ) )
+                    return 0
+                    ;;
+                *)
+                    COMPREPLY=( $( compgen -W "id device" -- "$cur" ) )
+                    return 0
+                    ;;
+            esac
+            ;;
+        set)
+            case $prev in
+                id|parent-device)
+                    COMPREPLY=( $( compgen -W \
+                        "$(_dpll_direct_complete device_id)" -- "$cur" ) )
+                    return 0
+                    ;;
+                parent-pin|reference-sync)
+                    COMPREPLY=( $( compgen -W \
+                        "$(_dpll_direct_complete pin_id)" -- "$cur" ) )
+                    return 0
+                    ;;
+                frequency|phase-adjust|esync-frequency|prio)
+                    # numeric value, no completion
+                    return 0
+                    ;;
+                direction)
+                    COMPREPLY=( $( compgen -W "input output" -- "$cur" ) )
+                    return 0
+                    ;;
+                state)
+                    COMPREPLY=( $( compgen -W \
+                        "connected disconnected selectable" -- "$cur" ) )
+                    return 0
+                    ;;
+                *)
+                    # Check if we are in nested context (after parent-device/parent-pin/reference-sync)
+                    local i nested_keyword=""
+                    for (( i=cword-1; i>0; i-- )); do
+                        case "${words[i]}" in
+                            parent-device)
+                                nested_keyword="parent-device"
+                                break
+                                ;;
+                            parent-pin|reference-sync)
+                                nested_keyword="parent-pin"
+                                break
+                                ;;
+                            id|frequency|phase-adjust|esync-frequency)
+                                # Hit a top-level keyword, not in nested context
+                                break
+                                ;;
+                        esac
+                    done
+
+                    if [[ "$nested_keyword" == "parent-device" ]]; then
+                        COMPREPLY=( $( compgen -W "direction prio state" -- "$cur" ) )
+                    elif [[ "$nested_keyword" == "parent-pin" ]]; then
+                        COMPREPLY=( $( compgen -W "state" -- "$cur" ) )
+                    else
+                        COMPREPLY=( $( compgen -W "id frequency phase-adjust \
+                            esync-frequency parent-device parent-pin reference-sync" \
+                            -- "$cur" ) )
+                    fi
+                    return 0
+                    ;;
+            esac
+            ;;
+        id-get)
+            case $prev in
+                module-name)
+                    COMPREPLY=( $( compgen -W \
+                        "$(_dpll_direct_complete module_name)" -- "$cur" ) )
+                    return 0
+                    ;;
+                clock-id)
+                    # numeric value, no completion
+                    return 0
+                    ;;
+                board-label|panel-label|package-label)
+                    # string value, no completion
+                    return 0
+                    ;;
+                type)
+                    COMPREPLY=( $( compgen -W "mux ext synce-eth-port \
+                        int-oscillator gnss" -- "$cur" ) )
+                    return 0
+                    ;;
+                *)
+                    COMPREPLY=( $( compgen -W "module-name clock-id \
+                        board-label panel-label package-label type" \
+                        -- "$cur" ) )
+                    return 0
+                    ;;
+            esac
+            ;;
+    esac
+}
+
+# Handle monitor subcommand
+_dpll_monitor()
+{
+    # monitor has no additional arguments
+    return 0
+}
+
+# Complete any dpll command
+_dpll()
+{
+    local cur prev words cword
+    local opt='--Version --json --pretty'
+    local objects="device pin monitor"
+
+    _init_completion || return
+    # Gets the word-to-complete without considering the colon as word breaks
+    _get_comp_words_by_ref -n : cur prev words cword
+
+    if [[ $cword -eq 1 ]]; then
+        case $cur in
+            -*)
+                COMPREPLY=( $( compgen -W "$opt" -- "$cur" ) )
+                return 0
+                ;;
+            *)
+                COMPREPLY=( $( compgen -W "$objects help" -- "$cur" ) )
+                return 0
+                ;;
+        esac
+    fi
+
+    # Deal with options
+    if [[ $prev == -* ]]; then
+        case $prev in
+            -V|--Version)
+                return 0
+                ;;
+            -j|--json)
+                COMPREPLY=( $( compgen -W "--pretty $objects" -- "$cur" ) )
+                return 0
+                ;;
+            *)
+                COMPREPLY=( $( compgen -W "$objects" -- "$cur" ) )
+                return 0
+                ;;
+        esac
+    fi
+
+    # Remove all options so completions don't have to deal with them.
+    local i
+    for (( i=1; i < ${#words[@]}; )); do
+        if [[ ${words[i]::1} == - ]]; then
+            words=( "${words[@]:0:i}" "${words[@]:i+1}" )
+            [[ $i -le $cword ]] && cword=$(( cword - 1 ))
+        else
+            i=$(( ++i ))
+        fi
+    done
+
+    local object=${words[1]}
+    local command=${words[2]}
+    local pprev=${words[cword - 2]}
+    local prev=${words[cword - 1]}
+
+    case $object in
+        device|pin|monitor)
+            if [[ $cword -eq 2 ]]; then
+                COMPREPLY=( $( compgen -W "help" -- "$cur") )
+                if [[ $object != "monitor" ]]; then
+                    COMPREPLY+=( $( compgen -W \
+                        "$(_dpll_get_optional_commands $object)" -- "$cur" ) )
+                fi
+            else
+                "_dpll_$object" $command
+            fi
+            ;;
+        help)
+            return 0
+            ;;
+        *)
+            COMPREPLY=( $( compgen -W "$objects help" -- "$cur" ) )
+            ;;
+    esac
+
+} &&
+complete -F _dpll dpll
+
+# ex: ts=4 sw=4 et filetype=sh
diff --git a/dpll/.gitignore b/dpll/.gitignore
new file mode 100644
index 00000000000000..9c5a7748a5f4c7
--- /dev/null
+++ b/dpll/.gitignore
@@ -0,0 +1 @@
+dpll
diff --git a/dpll/Makefile b/dpll/Makefile
new file mode 100644
index 00000000000000..6ffecdf5fc3ef7
--- /dev/null
+++ b/dpll/Makefile
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../config.mk
+
+# iproute2 libraries
+LIBNETLINK=../lib/libutil.a ../lib/libnetlink.a
+
+TARGETS :=
+ALLOBJS :=
+
+# Check if libmnl is available
+ifeq ($(HAVE_MNL),y)
+
+DPLLOBJ = dpll.o ../devlink/mnlg.o
+TARGETS += dpll
+ALLOBJS += dpll.o
+
+# libmnl flags
+dpll.o: CFLAGS += -I../include -I../include/uapi
+
+else
+$(warning "libmnl not found, skipping dpll tool build")
+endif
+
+# Default CFLAGS for all objects
+CFLAGS += -I../include -I../include/uapi
+
+all: $(TARGETS) $(LIBS)
+
+dpll: $(DPLLOBJ) $(LIBNETLINK)
+	$(QUIET_LINK)$(CC) $^ $(LDFLAGS) $(LDLIBS) -o $@
+
+install: all
+	for i in $(TARGETS); \
+	do install -m 0755 $$i $(DESTDIR)$(SBINDIR); \
+	done
+
+clean:
+	rm -f $(ALLOBJS) $(TARGETS)
diff --git a/dpll/dpll.c b/dpll/dpll.c
new file mode 100644
index 00000000000000..995f90b66759fa
--- /dev/null
+++ b/dpll/dpll.c
@@ -0,0 +1,2022 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * dpll.c	DPLL tool
+ *
+ * Authors:	Petr Oros <poros@redhat.com>
+ */
+
+#include <errno.h>
+#include <getopt.h>
+#include <inttypes.h>
+#include <poll.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/dpll.h>
+#include <linux/genetlink.h>
+#include <libmnl/libmnl.h>
+
+#include "../devlink/mnlg.h"
+#include "mnl_utils.h"
+#include "version.h"
+#include "utils.h"
+#include "json_print.h"
+
+#define pr_err(args...) fprintf(stderr, ##args)
+#define pr_out(args...) fprintf(stdout, ##args)
+
+struct dpll {
+	struct mnlu_gen_socket nlg;
+	int argc;
+	char **argv;
+	bool json_output;
+};
+
+static volatile sig_atomic_t monitor_running = 1;
+
+static void monitor_sig_handler(int signo __attribute__((unused)))
+{
+	monitor_running = 0;
+}
+
+static int str_to_bool(const char *s, bool *val)
+{
+	if (!strcmp(s, "true") || !strcmp(s, "1") || !strcmp(s, "enable"))
+		*val = true;
+	else if (!strcmp(s, "false") || !strcmp(s, "0") ||
+		 !strcmp(s, "disable"))
+		*val = false;
+	else
+		return -EINVAL;
+	return 0;
+}
+
+static const char *str_enable_disable(bool v)
+{
+	return v ? "enable" : "disable";
+}
+
+static int dpll_argc(struct dpll *dpll)
+{
+	return dpll->argc;
+}
+
+static const char *dpll_argv(struct dpll *dpll)
+{
+	if (dpll_argc(dpll) == 0)
+		return NULL;
+	return *dpll->argv;
+}
+
+static void dpll_arg_inc(struct dpll *dpll)
+{
+	if (dpll_argc(dpll) == 0)
+		return;
+	dpll->argc--;
+	dpll->argv++;
+}
+
+static const char *dpll_argv_next(struct dpll *dpll)
+{
+	const char *ret;
+
+	dpll_arg_inc(dpll);
+	if (dpll_argc(dpll) == 0)
+		return NULL;
+
+	ret = *dpll->argv;
+	dpll_arg_inc(dpll);
+	return ret;
+}
+
+static bool dpll_argv_match(struct dpll *dpll, const char *pattern)
+{
+	if (dpll_argc(dpll) == 0)
+		return false;
+	return strcmp(dpll_argv(dpll), pattern) == 0;
+}
+
+static int dpll_arg_required(struct dpll *dpll, const char *arg_name)
+{
+	if (dpll_argc(dpll) == 0) {
+		pr_err("%s requires an argument\n", arg_name);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static bool dpll_argv_match_inc(struct dpll *dpll, const char *pattern)
+{
+	if (!dpll_argv_match(dpll, pattern))
+		return false;
+	dpll_arg_inc(dpll);
+	return true;
+}
+
+static bool dpll_no_arg(struct dpll *dpll)
+{
+	return dpll_argc(dpll) == 0;
+}
+
+static int str_to_dpll_pin_state(const char *s, __u32 *v)
+{
+	if (!strcmp(s, "connected"))
+		*v = DPLL_PIN_STATE_CONNECTED;
+	else if (!strcmp(s, "disconnected"))
+		*v = DPLL_PIN_STATE_DISCONNECTED;
+	else if (!strcmp(s, "selectable"))
+		*v = DPLL_PIN_STATE_SELECTABLE;
+	else
+		return -EINVAL;
+	return 0;
+}
+
+static int str_to_dpll_pin_type(const char *s, __u32 *type)
+{
+	if (!strcmp(s, "mux"))
+		*type = DPLL_PIN_TYPE_MUX;
+	else if (!strcmp(s, "ext"))
+		*type = DPLL_PIN_TYPE_EXT;
+	else if (!strcmp(s, "synce-eth-port"))
+		*type = DPLL_PIN_TYPE_SYNCE_ETH_PORT;
+	else if (!strcmp(s, "int-oscillator"))
+		*type = DPLL_PIN_TYPE_INT_OSCILLATOR;
+	else if (!strcmp(s, "gnss"))
+		*type = DPLL_PIN_TYPE_GNSS;
+	else
+		return -EINVAL;
+	return 0;
+}
+
+static int dpll_parse_state(struct dpll *dpll, __u32 *state)
+{
+	const char *str = dpll_argv(dpll);
+
+	if (str_to_dpll_pin_state(str, state)) {
+		pr_err("invalid state: %s (use connected/disconnected/selectable)\n",
+		       str);
+		return -EINVAL;
+	}
+	dpll_arg_inc(dpll);
+	return 0;
+}
+
+static int dpll_parse_direction(struct dpll *dpll, __u32 *direction)
+{
+	if (dpll_argv_match_inc(dpll, "input")) {
+		*direction = DPLL_PIN_DIRECTION_INPUT;
+	} else if (dpll_argv_match_inc(dpll, "output")) {
+		*direction = DPLL_PIN_DIRECTION_OUTPUT;
+	} else {
+		pr_err("invalid direction: %s (use input/output)\n",
+		       dpll_argv(dpll));
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int dpll_parse_pin_type(struct dpll *dpll, __u32 *type)
+{
+	const char *str = dpll_argv(dpll);
+
+	if (str_to_dpll_pin_type(str, type)) {
+		pr_err("invalid type: %s (use mux/ext/synce-eth-port/int-oscillator/gnss)\n",
+		       str);
+		return -EINVAL;
+	}
+	dpll_arg_inc(dpll);
+	return 0;
+}
+
+static int dpll_parse_u32(struct dpll *dpll, const char *arg_name,
+			  __u32 *val_ptr)
+{
+	const char *__str = dpll_argv_next(dpll);
+
+	if (!__str) {
+		pr_err("%s requires an argument\n", arg_name);
+		return -EINVAL;
+	}
+	if (get_u32(val_ptr, __str, 0)) {
+		pr_err("invalid %s: %s\n", arg_name, __str);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int dpll_parse_attr_u32(struct dpll *dpll, struct nlmsghdr *nlh,
+			       const char *arg_name, int attr_id)
+{
+	__u32 val;
+
+	if (dpll_parse_u32(dpll, arg_name, &val))
+		return -EINVAL;
+	mnl_attr_put_u32(nlh, attr_id, val);
+	return 0;
+}
+
+static int dpll_parse_attr_s32(struct dpll *dpll, struct nlmsghdr *nlh,
+			       const char *arg_name, int attr_id)
+{
+	const char *str = dpll_argv_next(dpll);
+	__s32 val;
+
+	if (!str) {
+		pr_err("%s requires an argument\n", arg_name);
+		return -EINVAL;
+	}
+	if (get_s32(&val, str, 0)) {
+		pr_err("invalid %s: %s\n", arg_name, str);
+		return -EINVAL;
+	}
+	mnl_attr_put_u32(nlh, attr_id, val);
+	return 0;
+}
+
+static int dpll_parse_attr_u64(struct dpll *dpll, struct nlmsghdr *nlh,
+			       const char *arg_name, int attr_id)
+{
+	const char *str = dpll_argv_next(dpll);
+	__u64 val;
+
+	if (!str) {
+		pr_err("%s requires an argument\n", arg_name);
+		return -EINVAL;
+	}
+	if (get_u64(&val, str, 0)) {
+		pr_err("invalid %s: %s\n", arg_name, str);
+		return -EINVAL;
+	}
+	mnl_attr_put_u64(nlh, attr_id, val);
+	return 0;
+}
+
+static int dpll_parse_attr_str(struct dpll *dpll, struct nlmsghdr *nlh,
+			       const char *arg_name, int attr_id)
+{
+	const char *str = dpll_argv_next(dpll);
+
+	if (!str) {
+		pr_err("%s requires an argument\n", arg_name);
+		return -EINVAL;
+	}
+	mnl_attr_put_strz(nlh, attr_id, str);
+	return 0;
+}
+
+static int dpll_parse_attr_enum(struct dpll *dpll, struct nlmsghdr *nlh,
+				const char *arg_name, int attr_id,
+				int (*parse_func)(struct dpll *, __u32 *))
+{
+	__u32 val;
+
+	if (dpll_arg_required(dpll, arg_name))
+		return -EINVAL;
+	if (parse_func(dpll, &val))
+		return -EINVAL;
+	mnl_attr_put_u32(nlh, attr_id, val);
+	return 0;
+}
+
+/* Macros for printing netlink attributes
+ * These macros combine the common pattern of:
+ *
+ * if (tb[ATTR])
+ *	print_xxx(PRINT_ANY, "name", "format", mnl_attr_get_xxx(tb[ATTR]));
+ *
+ * Generic versions with custom format string (_FMT suffix)
+ * Simple versions auto-generate format string: "  name: %d\n"
+ */
+
+#define DPLL_PR_INT_FMT(tb, attr_id, name, format_str)                         \
+	do {                                                                   \
+		if (tb[attr_id])                                               \
+			print_int(PRINT_ANY, name, format_str,                 \
+				  mnl_attr_get_u32(tb[attr_id]));              \
+	} while (0)
+
+#define DPLL_PR_UINT_FMT(tb, attr_id, name, format_str)                        \
+	do {                                                                   \
+		if (tb[attr_id])                                               \
+			print_uint(PRINT_ANY, name, format_str,                \
+				   mnl_attr_get_u32(tb[attr_id]));             \
+	} while (0)
+
+#define DPLL_PR_U64_FMT(tb, attr_id, name, format_str)                         \
+	do {                                                                   \
+		if (tb[attr_id])                                               \
+			print_lluint(PRINT_ANY, name, format_str,              \
+				     mnl_attr_get_u64(tb[attr_id]));           \
+	} while (0)
+
+#define DPLL_PR_STR_FMT(tb, attr_id, name, format_str)                         \
+	do {                                                                   \
+		if (tb[attr_id])                                               \
+			print_string(PRINT_ANY, name, format_str,              \
+				     mnl_attr_get_str(tb[attr_id]));           \
+	} while (0)
+
+/* Simple versions with auto-generated format */
+#define DPLL_PR_INT(tb, attr_id, name)                                         \
+	DPLL_PR_INT_FMT(tb, attr_id, name, "  " name ": %d\n")
+
+#define DPLL_PR_UINT(tb, attr_id, name)                                        \
+	DPLL_PR_UINT_FMT(tb, attr_id, name, "  " name ": %u\n")
+
+#define DPLL_PR_U64(tb, attr_id, name)                                         \
+	DPLL_PR_U64_FMT(tb, attr_id, name, "  " name ": %" PRIu64 "\n")
+
+/* Helper to read signed int (can be s32 or s64 depending on value) */
+static __s64 mnl_attr_get_sint(const struct nlattr *attr)
+{
+	if (mnl_attr_get_payload_len(attr) == sizeof(__s32))
+		return *(__s32 *)mnl_attr_get_payload(attr);
+	else
+		return *(__s64 *)mnl_attr_get_payload(attr);
+}
+
+#define DPLL_PR_SINT_FMT(tb, attr_id, name, format_str)                        \
+	do {                                                                   \
+		if (tb[attr_id])                                               \
+			print_s64(PRINT_ANY, name, format_str,                 \
+				  mnl_attr_get_sint(tb[attr_id]));             \
+	} while (0)
+
+#define DPLL_PR_SINT(tb, attr_id, name)                                        \
+	DPLL_PR_SINT_FMT(tb, attr_id, name, "  " name ": %" PRId64 "\n")
+
+#define DPLL_PR_STR(tb, attr_id, name)                                         \
+	DPLL_PR_STR_FMT(tb, attr_id, name, "  " name ": %s\n")
+
+/* Temperature macro - JSON prints raw millidegrees, human prints formatted */
+#define DPLL_PR_TEMP(tb, attr_id)                                              \
+	do {                                                                   \
+		if (tb[attr_id]) {                                             \
+			__s32 temp = mnl_attr_get_u32(tb[attr_id]);            \
+			if (is_json_context()) {                               \
+				print_int(PRINT_JSON, "temp", NULL, temp);     \
+			} else {                                               \
+				div_t d = div(temp, 1000);                     \
+				pr_out("  temp: %d.%03d C\n", d.quot, d.rem);  \
+			}                                                      \
+		}                                                              \
+	} while (0)
+
+/* Generic version with custom format */
+#define DPLL_PR_ENUM_STR_FMT(tb, attr_id, name, format_str, name_func)         \
+	do {                                                                   \
+		if (tb[attr_id])                                               \
+			print_string(                                          \
+				PRINT_ANY, name, format_str,                   \
+				name_func(mnl_attr_get_u32(tb[attr_id])));     \
+	} while (0)
+
+/* Simple version with auto-generated format */
+#define DPLL_PR_ENUM_STR(tb, attr_id, name, name_func)                         \
+	DPLL_PR_ENUM_STR_FMT(tb, attr_id, name, "  " name ": %s\n", name_func)
+
+/* Multi-attr enum printer - handles multiple occurrences of same attribute */
+#define DPLL_PR_MULTI_ENUM_STR(nlh, attr_id, name, name_func)                  \
+	do {                                                                   \
+		struct nlattr *__attr;                                         \
+		bool __first = true;                                           \
+                                                                               \
+		if (!nlh)                                                      \
+			break;                                                 \
+                                                                               \
+		mnl_attr_for_each(__attr, nlh, sizeof(struct genlmsghdr))      \
+		{                                                              \
+			if (mnl_attr_get_type(__attr) == (attr_id)) {          \
+				__u32 __val = mnl_attr_get_u32(__attr);        \
+				if (__first) {                                 \
+					if (is_json_context()) {               \
+						open_json_array(PRINT_JSON,    \
+								name);         \
+					} else {                               \
+						pr_out("  " name ":");         \
+					}                                      \
+					__first = false;                       \
+				}                                              \
+				if (is_json_context()) {                       \
+					print_string(PRINT_JSON, NULL, NULL,   \
+						     name_func(__val));        \
+				} else {                                       \
+					pr_out(" %s", name_func(__val));       \
+				}                                              \
+			}                                                      \
+		}                                                              \
+		if (__first)                                                   \
+			break;                                                 \
+		if (is_json_context()) {                                       \
+			close_json_array(PRINT_JSON, NULL);                    \
+		} else {                                                       \
+			pr_out("\n");                                          \
+		}                                                              \
+	} while (0)
+
+static void help(void)
+{
+	pr_err("Usage: dpll [ OPTIONS ] OBJECT { COMMAND | help }\n"
+	       "       dpll [ -j[son] ] [ -p[retty] ]\n"
+	       "where  OBJECT := { device | pin | monitor }\n"
+	       "       OPTIONS := { -V[ersion] | -j[son] | -p[retty] }\n");
+}
+
+static int cmd_device(struct dpll *dpll);
+static int cmd_pin(struct dpll *dpll);
+static int cmd_monitor(struct dpll *dpll);
+
+static int dpll_cmd(struct dpll *dpll, int argc, char **argv)
+{
+	dpll->argc = argc;
+	dpll->argv = argv;
+
+	if (dpll_argv_match(dpll, "help") || dpll_no_arg(dpll)) {
+		help();
+		return 0;
+	} else if (dpll_argv_match_inc(dpll, "device")) {
+		return cmd_device(dpll);
+	} else if (dpll_argv_match_inc(dpll, "pin")) {
+		return cmd_pin(dpll);
+	} else if (dpll_argv_match_inc(dpll, "monitor")) {
+		return cmd_monitor(dpll);
+	}
+	pr_err("Object \"%s\" not found\n", dpll_argv(dpll));
+	return -ENOENT;
+}
+
+static int dpll_init(struct dpll *dpll)
+{
+	int err;
+
+	err = mnlu_gen_socket_open(&dpll->nlg, "dpll", DPLL_FAMILY_VERSION);
+	if (err) {
+		pr_err("Failed to connect to DPLL Netlink (DPLL subsystem not available in kernel?)\n");
+		return -1;
+	}
+	return 0;
+}
+
+static void dpll_fini(struct dpll *dpll)
+{
+	mnlu_gen_socket_close(&dpll->nlg);
+}
+
+static struct dpll *dpll_alloc(void)
+{
+	struct dpll *dpll;
+
+	dpll = calloc(1, sizeof(*dpll));
+	if (!dpll)
+		return NULL;
+	return dpll;
+}
+
+static void dpll_free(struct dpll *dpll)
+{
+	free(dpll);
+}
+
+int main(int argc, char **argv)
+{
+	static const struct option long_options[] = {
+		{ "Version", no_argument, NULL, 'V' },
+		{ "json", no_argument, NULL, 'j' },
+		{ "pretty", no_argument, NULL, 'p' },
+		{ NULL, 0, NULL, 0 }
+	};
+	const char *opt_short = "Vjp";
+	struct dpll *dpll;
+	int err, opt, ret;
+
+	dpll = dpll_alloc();
+	if (!dpll) {
+		pr_err("Failed to allocate memory\n");
+		return EXIT_FAILURE;
+	}
+
+	while ((opt = getopt_long(argc, argv, opt_short, long_options, NULL)) >=
+	       0) {
+		switch (opt) {
+		case 'V':
+			printf("dpll utility, iproute2-%s\n", version);
+			ret = EXIT_SUCCESS;
+			goto dpll_free;
+		case 'j':
+			dpll->json_output = true;
+			break;
+		case 'p':
+			pretty = true;
+			break;
+		default:
+			pr_err("Unknown option.\n");
+			help();
+			ret = EXIT_FAILURE;
+			goto dpll_free;
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+
+	new_json_obj_plain(dpll->json_output);
+	if (dpll->json_output)
+		open_json_object(NULL);
+
+	/* Skip netlink init for help commands */
+	bool need_nl = true;
+	if (argc > 0 && strcmp(argv[0], "help") == 0)
+		need_nl = false;
+	if (argc > 1 && strcmp(argv[1], "help") == 0)
+		need_nl = false;
+
+	if (need_nl) {
+		err = dpll_init(dpll);
+		if (err) {
+			ret = EXIT_FAILURE;
+			goto json_cleanup;
+		}
+	}
+
+	err = dpll_cmd(dpll, argc, argv);
+	if (err) {
+		ret = EXIT_FAILURE;
+		goto dpll_fini;
+	}
+
+	ret = EXIT_SUCCESS;
+
+dpll_fini:
+	if (need_nl)
+		dpll_fini(dpll);
+json_cleanup:
+	if (dpll->json_output)
+		close_json_object();
+	delete_json_obj_plain();
+dpll_free:
+	dpll_free(dpll);
+	return ret;
+}
+
+/*
+ * Device commands
+ */
+
+static void cmd_device_help(void)
+{
+	pr_err("Usage: dpll device show [ id DEVICE_ID ]\n");
+	pr_err("       dpll device set id DEVICE_ID [ phase-offset-monitor { enable | disable } ]\n");
+	pr_err("                                      [ phase-offset-avg-factor NUM ]\n");
+	pr_err("       dpll device id-get [ module-name NAME ] [ clock-id ID ] [ type TYPE ]\n");
+}
+
+static const char *dpll_mode_name(__u32 mode)
+{
+	switch (mode) {
+	case DPLL_MODE_MANUAL:
+		return "manual";
+	case DPLL_MODE_AUTOMATIC:
+		return "automatic";
+	default:
+		return "unknown";
+	}
+}
+
+static const char *dpll_lock_status_name(__u32 status)
+{
+	switch (status) {
+	case DPLL_LOCK_STATUS_UNLOCKED:
+		return "unlocked";
+	case DPLL_LOCK_STATUS_LOCKED:
+		return "locked";
+	case DPLL_LOCK_STATUS_LOCKED_HO_ACQ:
+		return "locked-ho-acq";
+	case DPLL_LOCK_STATUS_HOLDOVER:
+		return "holdover";
+	default:
+		return "unknown";
+	}
+}
+
+static const char *dpll_type_name(__u32 type)
+{
+	switch (type) {
+	case DPLL_TYPE_PPS:
+		return "pps";
+	case DPLL_TYPE_EEC:
+		return "eec";
+	default:
+		return "unknown";
+	}
+}
+
+static int str_to_dpll_type(const char *s, __u32 *type)
+{
+	if (!strcmp(s, "pps"))
+		*type = DPLL_TYPE_PPS;
+	else if (!strcmp(s, "eec"))
+		*type = DPLL_TYPE_EEC;
+	else
+		return -EINVAL;
+	return 0;
+}
+
+static const char *dpll_lock_status_error_name(__u32 error)
+{
+	switch (error) {
+	case DPLL_LOCK_STATUS_ERROR_NONE:
+		return "none";
+	case DPLL_LOCK_STATUS_ERROR_UNDEFINED:
+		return "undefined";
+	case DPLL_LOCK_STATUS_ERROR_MEDIA_DOWN:
+		return "media-down";
+	case DPLL_LOCK_STATUS_ERROR_FRACTIONAL_FREQUENCY_OFFSET_TOO_HIGH:
+		return "fractional-frequency-offset-too-high";
+	default:
+		return "unknown";
+	}
+}
+
+static const char *dpll_clock_quality_level_name(__u32 level)
+{
+	switch (level) {
+	case DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_PRC:
+		return "itu-opt1-prc";
+	case DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_SSU_A:
+		return "itu-opt1-ssu-a";
+	case DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_SSU_B:
+		return "itu-opt1-ssu-b";
+	case DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EEC1:
+		return "itu-opt1-eec1";
+	case DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_PRTC:
+		return "itu-opt1-prtc";
+	case DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRTC:
+		return "itu-opt1-eprtc";
+	case DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EEEC:
+		return "itu-opt1-eeec";
+	case DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRC:
+		return "itu-opt1-eprc";
+	default:
+		return "unknown";
+	}
+}
+
+/* Netlink attribute parsing - device attributes */
+static int attr_cb(const struct nlattr *attr, void *data)
+{
+	int type = mnl_attr_get_type(attr);
+	const struct nlattr **tb = data;
+
+	if (mnl_attr_type_valid(attr, DPLL_A_MAX) < 0)
+		return MNL_CB_OK;
+
+	tb[type] = attr;
+	return MNL_CB_OK;
+}
+
+/* Netlink attribute parsing - pin attributes */
+static int attr_pin_cb(const struct nlattr *attr, void *data)
+{
+	int type = mnl_attr_get_type(attr);
+	const struct nlattr **tb = data;
+
+	if (mnl_attr_type_valid(attr, DPLL_A_PIN_MAX) < 0)
+		return MNL_CB_OK;
+
+	tb[type] = attr;
+	return MNL_CB_OK;
+}
+
+/* Print device attributes */
+static void dpll_device_print_attrs(const struct nlmsghdr *nlh,
+				    struct nlattr **tb)
+{
+	DPLL_PR_UINT_FMT(tb, DPLL_A_ID, "id", "device id %u:\n");
+	DPLL_PR_STR(tb, DPLL_A_MODULE_NAME, "module-name");
+	DPLL_PR_ENUM_STR(tb, DPLL_A_MODE, "mode", dpll_mode_name);
+	DPLL_PR_U64(tb, DPLL_A_CLOCK_ID, "clock-id");
+	DPLL_PR_ENUM_STR(tb, DPLL_A_TYPE, "type", dpll_type_name);
+	DPLL_PR_ENUM_STR(tb, DPLL_A_LOCK_STATUS, "lock-status",
+			 dpll_lock_status_name);
+	DPLL_PR_ENUM_STR(tb, DPLL_A_LOCK_STATUS_ERROR, "lock-status-error",
+			 dpll_lock_status_error_name);
+	DPLL_PR_MULTI_ENUM_STR(nlh, DPLL_A_CLOCK_QUALITY_LEVEL,
+			       "clock-quality-level",
+			       dpll_clock_quality_level_name);
+	DPLL_PR_TEMP(tb, DPLL_A_TEMP);
+	DPLL_PR_MULTI_ENUM_STR(nlh, DPLL_A_MODE_SUPPORTED, "mode-supported",
+			       dpll_mode_name);
+	DPLL_PR_ENUM_STR_FMT(tb, DPLL_A_PHASE_OFFSET_MONITOR,
+			     "phase-offset-monitor",
+			     "  phase-offset-monitor: %s\n",
+			     str_enable_disable);
+	DPLL_PR_UINT(tb, DPLL_A_PHASE_OFFSET_AVG_FACTOR,
+		     "phase-offset-avg-factor");
+}
+
+/* Netlink callback - device get (single device) */
+static int cmd_device_show_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct nlattr *tb[DPLL_A_MAX + 1] = {};
+
+	mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_cb, tb);
+	dpll_device_print_attrs(nlh, tb);
+
+	return MNL_CB_OK;
+}
+
+/* Netlink callback - device dump (multiple devices) */
+static int cmd_device_show_dump_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct nlattr *tb[DPLL_A_MAX + 1] = {};
+
+	mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_cb, tb);
+
+	open_json_object(NULL);
+	dpll_device_print_attrs(nlh, tb);
+	close_json_object();
+
+	return MNL_CB_OK;
+}
+
+static int cmd_device_show_id(struct dpll *dpll, __u32 id)
+{
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = mnlu_gen_socket_cmd_prepare(&dpll->nlg, DPLL_CMD_DEVICE_GET,
+					  NLM_F_REQUEST | NLM_F_ACK);
+	mnl_attr_put_u32(nlh, DPLL_A_ID, id);
+
+	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_device_show_cb, NULL);
+	if (err < 0) {
+		pr_err("Failed to get device %u\n", id);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int cmd_device_show_dump(struct dpll *dpll)
+{
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = mnlu_gen_socket_cmd_prepare(&dpll->nlg, DPLL_CMD_DEVICE_GET,
+					  NLM_F_REQUEST | NLM_F_ACK |
+						  NLM_F_DUMP);
+
+	open_json_array(PRINT_JSON, "device");
+
+	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_device_show_dump_cb,
+				     NULL);
+	if (err < 0) {
+		pr_err("Failed to dump devices\n");
+		close_json_array(PRINT_JSON, NULL);
+		return -1;
+	}
+
+	close_json_array(PRINT_JSON, NULL);
+
+	return 0;
+}
+
+static int cmd_device_show(struct dpll *dpll)
+{
+	bool has_id = false;
+	__u32 id = 0;
+
+	while (dpll_argc(dpll) > 0) {
+		if (dpll_argv_match(dpll, "id")) {
+			if (dpll_parse_u32(dpll, "id", &id))
+				return -EINVAL;
+			has_id = true;
+		} else {
+			pr_err("unknown option: %s\n", dpll_argv(dpll));
+			return -EINVAL;
+		}
+	}
+
+	if (has_id)
+		return cmd_device_show_id(dpll, id);
+	else
+		return cmd_device_show_dump(dpll);
+}
+
+static int cmd_device_set(struct dpll *dpll)
+{
+	struct nlmsghdr *nlh;
+	bool has_id = false;
+	__u32 id = 0;
+	int err;
+
+	nlh = mnlu_gen_socket_cmd_prepare(&dpll->nlg, DPLL_CMD_DEVICE_SET,
+					  NLM_F_REQUEST | NLM_F_ACK);
+
+	while (dpll_argc(dpll) > 0) {
+		if (dpll_argv_match(dpll, "id")) {
+			if (dpll_parse_u32(dpll, "id", &id))
+				return -EINVAL;
+			mnl_attr_put_u32(nlh, DPLL_A_ID, id);
+			has_id = true;
+		} else if (dpll_argv_match(dpll, "phase-offset-monitor")) {
+			const char *str = dpll_argv_next(dpll);
+			bool val;
+
+			if (!str) {
+				pr_err("phase-offset-monitor requires an argument\n");
+				return -EINVAL;
+			}
+			if (str_to_bool(str, &val)) {
+				pr_err("invalid phase-offset-monitor value: %s (use enable/disable)\n",
+				       str);
+				return -EINVAL;
+			}
+			mnl_attr_put_u32(nlh, DPLL_A_PHASE_OFFSET_MONITOR,
+					 val ? 1 : 0);
+		} else if (dpll_argv_match(dpll, "phase-offset-avg-factor")) {
+			if (dpll_parse_attr_u32(dpll, nlh,
+						"phase-offset-avg-factor",
+						DPLL_A_PHASE_OFFSET_AVG_FACTOR))
+				return -EINVAL;
+		} else {
+			pr_err("unknown option: %s\n", dpll_argv(dpll));
+			return -EINVAL;
+		}
+	}
+
+	if (!has_id) {
+		pr_err("device id is required\n");
+		return -EINVAL;
+	}
+
+	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, NULL, NULL);
+	if (err < 0) {
+		pr_err("Failed to set device\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Netlink callback - print device ID found by query */
+static int cmd_device_id_get_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct nlattr *tb[DPLL_A_MAX + 1] = {};
+	int *found = data;
+
+	mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_cb, tb);
+
+	if (tb[DPLL_A_ID]) {
+		__u32 id = mnl_attr_get_u32(tb[DPLL_A_ID]);
+
+		if (is_json_context()) {
+			print_uint(PRINT_JSON, "id", NULL, id);
+		} else {
+			printf("%u\n", id);
+		}
+		if (found)
+			*found = 1;
+	}
+
+	return MNL_CB_OK;
+}
+
+static int cmd_device_id_get(struct dpll *dpll)
+{
+	struct nlmsghdr *nlh;
+	int found = 0;
+	int err;
+
+	nlh = mnlu_gen_socket_cmd_prepare(&dpll->nlg, DPLL_CMD_DEVICE_ID_GET,
+					  NLM_F_REQUEST | NLM_F_ACK);
+
+	while (dpll_argc(dpll) > 0) {
+		if (dpll_argv_match(dpll, "module-name")) {
+			if (dpll_parse_attr_str(dpll, nlh, "module-name",
+						DPLL_A_MODULE_NAME))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "clock-id")) {
+			if (dpll_parse_attr_u64(dpll, nlh, "clock-id",
+						DPLL_A_CLOCK_ID))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "type")) {
+			const char *str = dpll_argv_next(dpll);
+			__u32 val;
+
+			if (!str) {
+				pr_err("type requires an argument\n");
+				return -EINVAL;
+			}
+			if (str_to_dpll_type(str, &val)) {
+				pr_err("invalid type: %s (use pps/eec)\n", str);
+				return -EINVAL;
+			}
+			mnl_attr_put_u32(nlh, DPLL_A_TYPE, val);
+		} else {
+			pr_err("unknown option: %s\n", dpll_argv(dpll));
+			return -EINVAL;
+		}
+	}
+
+	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_device_id_get_cb,
+				     &found);
+	if (err < 0) {
+		pr_err("Failed to get device id\n");
+		return -1;
+	}
+
+	if (!found) {
+		pr_err("No device found matching the criteria\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int cmd_device(struct dpll *dpll)
+{
+	if (dpll_argv_match(dpll, "help") || dpll_no_arg(dpll)) {
+		cmd_device_help();
+		return 0;
+	} else if (dpll_argv_match_inc(dpll, "show")) {
+		return cmd_device_show(dpll);
+	} else if (dpll_argv_match_inc(dpll, "set")) {
+		return cmd_device_set(dpll);
+	} else if (dpll_argv_match_inc(dpll, "id-get")) {
+		return cmd_device_id_get(dpll);
+	}
+
+	pr_err("Command \"%s\" not found\n",
+	       dpll_argv(dpll) ? dpll_argv(dpll) : "");
+	return -ENOENT;
+}
+
+/*
+ * Pin commands
+ */
+
+static void cmd_pin_help(void)
+{
+	pr_err("Usage: dpll pin show [ id PIN_ID ] [ device DEVICE_ID ]\n");
+	pr_err("       dpll pin set id PIN_ID [ frequency FREQ ]\n");
+	pr_err("                              [ phase-adjust ADJUST ]\n");
+	pr_err("                              [ esync-frequency FREQ ]\n");
+	pr_err("                              [ parent-device DEVICE_ID [ direction DIR ]\n");
+	pr_err("                                                        [ prio PRIO ]\n");
+	pr_err("                                                        [ state STATE ] ]\n");
+	pr_err("                              [ parent-pin PIN_ID [ state STATE ] ]\n");
+	pr_err("                              [ reference-sync PIN_ID [ state STATE ] ]\n");
+	pr_err("       dpll pin id-get [ module-name NAME ] [ clock-id ID ]\n");
+	pr_err("                       [ board-label LABEL ] [ panel-label LABEL ]\n");
+	pr_err("                       [ package-label LABEL ] [ type TYPE ]\n");
+}
+
+static const char *dpll_pin_type_name(__u32 type)
+{
+	switch (type) {
+	case DPLL_PIN_TYPE_MUX:
+		return "mux";
+	case DPLL_PIN_TYPE_EXT:
+		return "ext";
+	case DPLL_PIN_TYPE_SYNCE_ETH_PORT:
+		return "synce-eth-port";
+	case DPLL_PIN_TYPE_INT_OSCILLATOR:
+		return "int-oscillator";
+	case DPLL_PIN_TYPE_GNSS:
+		return "gnss";
+	default:
+		return "unknown";
+	}
+}
+
+static const char *dpll_pin_state_name(__u32 state)
+{
+	switch (state) {
+	case DPLL_PIN_STATE_CONNECTED:
+		return "connected";
+	case DPLL_PIN_STATE_DISCONNECTED:
+		return "disconnected";
+	case DPLL_PIN_STATE_SELECTABLE:
+		return "selectable";
+	default:
+		return "unknown";
+	}
+}
+
+static const char *dpll_pin_direction_name(__u32 direction)
+{
+	switch (direction) {
+	case DPLL_PIN_DIRECTION_INPUT:
+		return "input";
+	case DPLL_PIN_DIRECTION_OUTPUT:
+		return "output";
+	default:
+		return "unknown";
+	}
+}
+
+static void dpll_pin_capabilities_name(__u32 capabilities)
+{
+	if (capabilities & DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE)
+		pr_out(" state-can-change");
+	if (capabilities & DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE)
+		pr_out(" priority-can-change");
+	if (capabilities & DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE)
+		pr_out(" direction-can-change");
+}
+
+/* Multi-attribute collection context */
+struct multi_attr_ctx {
+	int count;
+	struct nlattr **entries;
+};
+
+static void dpll_pin_print_freq_supported(struct nlattr *attr)
+{
+	struct multi_attr_ctx *ctx = (struct multi_attr_ctx *)attr;
+	int i;
+
+	if (!attr)
+		return;
+
+	open_json_array(PRINT_JSON, "frequency-supported");
+	if (!is_json_context())
+		pr_out("  frequency-supported:\n");
+
+	/* Iterate through all collected frequency-supported entries */
+	for (i = 0; i < ctx->count; i++) {
+		struct nlattr *tb_freq[DPLL_A_PIN_MAX + 1] = {};
+		__u64 freq_min = 0, freq_max = 0;
+
+		mnl_attr_parse_nested(ctx->entries[i], attr_pin_cb, tb_freq);
+
+		if (tb_freq[DPLL_A_PIN_FREQUENCY_MIN])
+			freq_min = mnl_attr_get_u64(
+				tb_freq[DPLL_A_PIN_FREQUENCY_MIN]);
+		if (tb_freq[DPLL_A_PIN_FREQUENCY_MAX])
+			freq_max = mnl_attr_get_u64(
+				tb_freq[DPLL_A_PIN_FREQUENCY_MAX]);
+
+		open_json_object(NULL);
+
+		/* JSON: always print both min and max */
+		if (is_json_context()) {
+			if (tb_freq[DPLL_A_PIN_FREQUENCY_MIN])
+				print_lluint(PRINT_JSON, "frequency-min", NULL,
+					     freq_min);
+			if (tb_freq[DPLL_A_PIN_FREQUENCY_MAX])
+				print_lluint(PRINT_JSON, "frequency-max", NULL,
+					     freq_max);
+		} else {
+			/* Legacy: if min == max, print single value, else print range */
+			pr_out("    ");
+			if (freq_min == freq_max) {
+				print_lluint(PRINT_FP, NULL, "%" PRIu64 " Hz\n",
+					     freq_min);
+			} else {
+				print_lluint(PRINT_FP, NULL, "%" PRIu64,
+					     freq_min);
+				pr_out("-");
+				print_lluint(PRINT_FP, NULL, "%" PRIu64 " Hz\n",
+					     freq_max);
+			}
+		}
+
+		close_json_object();
+	}
+	close_json_array(PRINT_JSON, NULL);
+}
+
+static void dpll_pin_print_capabilities(struct nlattr *attr)
+{
+	__u32 caps;
+
+	if (!attr)
+		return;
+
+	caps = mnl_attr_get_u32(attr);
+	if (is_json_context()) {
+		open_json_array(PRINT_JSON, "capabilities");
+		if (caps & DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE)
+			print_string(PRINT_JSON, NULL, NULL,
+				     "state-can-change");
+		if (caps & DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE)
+			print_string(PRINT_JSON, NULL, NULL,
+				     "priority-can-change");
+		if (caps & DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE)
+			print_string(PRINT_JSON, NULL, NULL,
+				     "direction-can-change");
+		close_json_array(PRINT_JSON, NULL);
+	} else {
+		pr_out("  capabilities: 0x%x", caps);
+		dpll_pin_capabilities_name(caps);
+		pr_out("\n");
+	}
+}
+
+static void dpll_pin_print_esync_freq_supported(struct nlattr *attr)
+{
+	struct multi_attr_ctx *ctx = (struct multi_attr_ctx *)attr;
+	int i;
+
+	if (!attr)
+		return;
+
+	open_json_array(PRINT_JSON, "esync-frequency-supported");
+	if (!is_json_context())
+		pr_out("  esync-frequency-supported:\n");
+
+	/* Iterate through all collected esync-frequency-supported entries */
+	for (i = 0; i < ctx->count; i++) {
+		struct nlattr *tb_freq[DPLL_A_PIN_MAX + 1] = {};
+		__u64 freq_min = 0, freq_max = 0;
+
+		mnl_attr_parse_nested(ctx->entries[i], attr_pin_cb, tb_freq);
+
+		if (tb_freq[DPLL_A_PIN_FREQUENCY_MIN])
+			freq_min = mnl_attr_get_u64(
+				tb_freq[DPLL_A_PIN_FREQUENCY_MIN]);
+		if (tb_freq[DPLL_A_PIN_FREQUENCY_MAX])
+			freq_max = mnl_attr_get_u64(
+				tb_freq[DPLL_A_PIN_FREQUENCY_MAX]);
+
+		open_json_object(NULL);
+
+		/* JSON: always print both min and max */
+		if (is_json_context()) {
+			if (tb_freq[DPLL_A_PIN_FREQUENCY_MIN])
+				print_lluint(PRINT_JSON, "frequency-min", NULL,
+					     freq_min);
+			if (tb_freq[DPLL_A_PIN_FREQUENCY_MAX])
+				print_lluint(PRINT_JSON, "frequency-max", NULL,
+					     freq_max);
+		} else {
+			/* Legacy: if min == max, print single value, else print range */
+			pr_out("    ");
+			if (freq_min == freq_max) {
+				print_lluint(PRINT_FP, NULL, "%" PRIu64 " Hz\n",
+					     freq_min);
+			} else {
+				print_lluint(PRINT_FP, NULL, "%" PRIu64,
+					     freq_min);
+				pr_out("-");
+				print_lluint(PRINT_FP, NULL, "%" PRIu64 " Hz\n",
+					     freq_max);
+			}
+		}
+
+		close_json_object();
+	}
+	close_json_array(PRINT_JSON, NULL);
+}
+
+static void dpll_pin_print_parent_devices(struct nlattr *attr)
+{
+	struct multi_attr_ctx *ctx = (struct multi_attr_ctx *)attr;
+	int i;
+
+	if (!attr)
+		return;
+
+	open_json_array(PRINT_JSON, "parent-device");
+	if (!is_json_context())
+		pr_out("  parent-device:\n");
+
+	/* Iterate through all collected parent-device entries */
+	for (i = 0; i < ctx->count; i++) {
+		struct nlattr *tb_parent[DPLL_A_PIN_MAX + 1] = {};
+		mnl_attr_parse_nested(ctx->entries[i], attr_pin_cb, tb_parent);
+
+		open_json_object(NULL);
+		if (!is_json_context())
+			pr_out("    ");
+
+		DPLL_PR_UINT_FMT(tb_parent, DPLL_A_PIN_PARENT_ID, "parent-id",
+				 "id %u");
+		DPLL_PR_ENUM_STR_FMT(tb_parent, DPLL_A_PIN_DIRECTION,
+				     "direction", " direction %s",
+				     dpll_pin_direction_name);
+		DPLL_PR_UINT_FMT(tb_parent, DPLL_A_PIN_PRIO, "prio",
+				 " prio %u");
+		DPLL_PR_ENUM_STR_FMT(tb_parent, DPLL_A_PIN_STATE, "state",
+				     " state %s", dpll_pin_state_name);
+		DPLL_PR_SINT_FMT(tb_parent, DPLL_A_PIN_PHASE_OFFSET,
+				 "phase-offset", " phase-offset %" PRId64);
+
+		if (!is_json_context())
+			pr_out("\n");
+		close_json_object();
+	}
+	close_json_array(PRINT_JSON, NULL);
+}
+
+static void dpll_pin_print_parent_pins(struct nlattr *attr)
+{
+	struct multi_attr_ctx *ctx = (struct multi_attr_ctx *)attr;
+	int i;
+
+	if (!attr)
+		return;
+
+	open_json_array(PRINT_JSON, "parent-pin");
+	if (!is_json_context())
+		pr_out("  parent-pin:\n");
+
+	for (i = 0; i < ctx->count; i++) {
+		struct nlattr *tb_parent[DPLL_A_PIN_MAX + 1] = {};
+		mnl_attr_parse_nested(ctx->entries[i], attr_pin_cb, tb_parent);
+
+		open_json_object(NULL);
+		if (!is_json_context())
+			pr_out("    ");
+
+		DPLL_PR_UINT_FMT(tb_parent, DPLL_A_PIN_PARENT_ID, "parent-id",
+				 "id %u");
+		DPLL_PR_ENUM_STR_FMT(tb_parent, DPLL_A_PIN_STATE, "state",
+				     " state %s", dpll_pin_state_name);
+
+		if (!is_json_context())
+			pr_out("\n");
+		close_json_object();
+	}
+	close_json_array(PRINT_JSON, NULL);
+}
+
+static void dpll_pin_print_refsync_pins(struct nlattr *attr)
+{
+	struct multi_attr_ctx *ctx = (struct multi_attr_ctx *)attr;
+	int i;
+
+	if (!attr)
+		return;
+
+	open_json_array(PRINT_JSON, "reference-sync");
+	if (!is_json_context())
+		pr_out("  reference-sync:\n");
+
+	for (i = 0; i < ctx->count; i++) {
+		struct nlattr *tb_ref[DPLL_A_PIN_MAX + 1] = {};
+		mnl_attr_parse_nested(ctx->entries[i], attr_pin_cb, tb_ref);
+
+		open_json_object(NULL);
+		if (!is_json_context())
+			pr_out("    ");
+
+		DPLL_PR_UINT_FMT(tb_ref, DPLL_A_PIN_ID, "id", "pin %u");
+		DPLL_PR_ENUM_STR_FMT(tb_ref, DPLL_A_PIN_STATE, "state",
+				     " state %s", dpll_pin_state_name);
+
+		if (!is_json_context())
+			pr_out("\n");
+		close_json_object();
+	}
+	close_json_array(PRINT_JSON, NULL);
+}
+
+/* Print pin attributes */
+static void dpll_pin_print_attrs(struct nlattr **tb)
+{
+	DPLL_PR_UINT_FMT(tb, DPLL_A_PIN_ID, "id", "pin id %u:\n");
+	DPLL_PR_STR(tb, DPLL_A_PIN_MODULE_NAME, "module-name");
+	DPLL_PR_U64(tb, DPLL_A_PIN_CLOCK_ID, "clock-id");
+	DPLL_PR_STR(tb, DPLL_A_PIN_BOARD_LABEL, "board-label");
+	DPLL_PR_STR(tb, DPLL_A_PIN_PANEL_LABEL, "panel-label");
+	DPLL_PR_STR(tb, DPLL_A_PIN_PACKAGE_LABEL, "package-label");
+	DPLL_PR_ENUM_STR(tb, DPLL_A_PIN_TYPE, "type", dpll_pin_type_name);
+	DPLL_PR_U64_FMT(tb, DPLL_A_PIN_FREQUENCY, "frequency",
+			"  frequency: %" PRIu64 " Hz\n");
+
+	/* Print frequency-supported ranges */
+	dpll_pin_print_freq_supported(tb[DPLL_A_PIN_FREQUENCY_SUPPORTED]);
+
+	/* Print capabilities */
+	dpll_pin_print_capabilities(tb[DPLL_A_PIN_CAPABILITIES]);
+
+	/* Print phase adjust range, granularity and current value */
+	DPLL_PR_INT(tb, DPLL_A_PIN_PHASE_ADJUST_MIN, "phase-adjust-min");
+	DPLL_PR_INT(tb, DPLL_A_PIN_PHASE_ADJUST_MAX, "phase-adjust-max");
+	DPLL_PR_INT(tb, DPLL_A_PIN_PHASE_ADJUST_GRAN, "phase-adjust-gran");
+	DPLL_PR_INT(tb, DPLL_A_PIN_PHASE_ADJUST, "phase-adjust");
+
+	/* Print fractional frequency offset */
+	DPLL_PR_SINT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
+		     "fractional-frequency-offset");
+
+	/* Print esync frequency and related attributes */
+	DPLL_PR_U64_FMT(tb, DPLL_A_PIN_ESYNC_FREQUENCY, "esync-frequency",
+			"  esync-frequency: %" PRIu64 " Hz\n");
+
+	dpll_pin_print_esync_freq_supported(
+		tb[DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED]);
+
+	DPLL_PR_UINT_FMT(tb, DPLL_A_PIN_ESYNC_PULSE, "esync-pulse",
+			 "  esync-pulse: %u\n");
+
+	/* Print parent-device relationships */
+	dpll_pin_print_parent_devices(tb[DPLL_A_PIN_PARENT_DEVICE]);
+
+	/* Print parent-pin relationships */
+	dpll_pin_print_parent_pins(tb[DPLL_A_PIN_PARENT_PIN]);
+
+	/* Print reference-sync capable pins */
+	dpll_pin_print_refsync_pins(tb[DPLL_A_PIN_REFERENCE_SYNC]);
+}
+
+struct multi_attr_counter {
+	int attr_type;
+	int count;
+};
+
+/* Count how many times a specific attribute type appears */
+static int count_multi_attr_cb(const struct nlattr *attr, void *data)
+{
+	struct multi_attr_counter *counter = data;
+	int type = mnl_attr_get_type(attr);
+
+	if (type == counter->attr_type)
+		counter->count++;
+	return MNL_CB_OK;
+}
+
+/* Helper to count specific multi-attr type occurrences */
+static unsigned int multi_attr_count_get(const struct nlmsghdr *nlh,
+					 struct genlmsghdr *genl, int attr_type)
+{
+	struct multi_attr_counter counter;
+
+	counter.attr_type = attr_type;
+	counter.count = 0;
+	mnl_attr_parse(nlh, sizeof(*genl), count_multi_attr_cb, &counter);
+	return counter.count;
+}
+
+/* Initialize multi-attr context with proper allocation */
+static int multi_attr_ctx_init(struct multi_attr_ctx *ctx, unsigned int count)
+{
+	if (count == 0) {
+		ctx->count = 0;
+		ctx->entries = NULL;
+		return 0;
+	}
+
+	ctx->entries = calloc(count, sizeof(struct nlattr *));
+	if (!ctx->entries)
+		return -ENOMEM;
+	ctx->count = 0;
+	return 0;
+}
+
+/* Free multi-attr context */
+static void multi_attr_ctx_free(struct multi_attr_ctx *ctx)
+{
+	free(ctx->entries);
+	ctx->entries = NULL;
+	ctx->count = 0;
+}
+
+/* Generic helper to collect specific multi-attr type */
+struct multi_attr_collector {
+	int attr_type;
+	struct multi_attr_ctx *ctx;
+};
+
+static int collect_multi_attr_cb(const struct nlattr *attr, void *data)
+{
+	struct multi_attr_collector *collector = data;
+	int type = mnl_attr_get_type(attr);
+
+	if (type == collector->attr_type) {
+		collector->ctx->entries[collector->ctx->count++] =
+			(struct nlattr *)attr;
+	}
+	return MNL_CB_OK;
+}
+
+static void dpll_multi_attr_parse(const struct nlmsghdr *nlh, int attr_type,
+				  struct multi_attr_ctx *ctx)
+{
+	struct multi_attr_collector collector;
+
+	collector.attr_type = attr_type;
+	collector.ctx = ctx;
+	mnl_attr_parse(nlh, sizeof(struct genlmsghdr), collect_multi_attr_cb,
+		       &collector);
+}
+
+/* Callback for pin get (single) */
+static int cmd_pin_show_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
+	struct multi_attr_ctx parent_dev_ctx = { 0 }, parent_pin_ctx = { 0 },
+			      ref_sync_ctx = { 0 };
+	struct multi_attr_ctx freq_supp_ctx = { 0 },
+			      esync_freq_supp_ctx = { 0 };
+	struct nlattr *tb[DPLL_A_PIN_MAX + 1] = {};
+	unsigned int count;
+	int ret;
+
+	/* First parse to get main attributes */
+	mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_pin_cb, tb);
+
+	/* Pass 1: Count multi-attr occurrences and allocate */
+	count = multi_attr_count_get(nlh, genl, DPLL_A_PIN_PARENT_DEVICE);
+	if (count > 0 && multi_attr_ctx_init(&parent_dev_ctx, count) < 0)
+		goto err_alloc;
+
+	count = multi_attr_count_get(nlh, genl, DPLL_A_PIN_PARENT_PIN);
+	if (count > 0 && multi_attr_ctx_init(&parent_pin_ctx, count) < 0)
+		goto err_alloc;
+
+	count = multi_attr_count_get(nlh, genl, DPLL_A_PIN_REFERENCE_SYNC);
+	if (count > 0 && multi_attr_ctx_init(&ref_sync_ctx, count) < 0)
+		goto err_alloc;
+
+	count = multi_attr_count_get(nlh, genl, DPLL_A_PIN_FREQUENCY_SUPPORTED);
+	if (count > 0 && multi_attr_ctx_init(&freq_supp_ctx, count) < 0)
+		goto err_alloc;
+
+	count = multi_attr_count_get(nlh, genl,
+				     DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED);
+	if (count > 0 && multi_attr_ctx_init(&esync_freq_supp_ctx, count) < 0)
+		goto err_alloc;
+
+	/* Pass 2: Collect multi-attr entries */
+	if (parent_dev_ctx.entries)
+		dpll_multi_attr_parse(nlh, DPLL_A_PIN_PARENT_DEVICE,
+				      &parent_dev_ctx);
+	if (parent_pin_ctx.entries)
+		dpll_multi_attr_parse(nlh, DPLL_A_PIN_PARENT_PIN,
+				      &parent_pin_ctx);
+	if (ref_sync_ctx.entries)
+		dpll_multi_attr_parse(nlh, DPLL_A_PIN_REFERENCE_SYNC,
+				      &ref_sync_ctx);
+	if (freq_supp_ctx.entries)
+		dpll_multi_attr_parse(nlh, DPLL_A_PIN_FREQUENCY_SUPPORTED,
+				      &freq_supp_ctx);
+	if (esync_freq_supp_ctx.entries)
+		dpll_multi_attr_parse(nlh, DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED,
+				      &esync_freq_supp_ctx);
+
+	/* Replace tb entries with contexts */
+	if (parent_dev_ctx.count > 0)
+		tb[DPLL_A_PIN_PARENT_DEVICE] = (struct nlattr *)&parent_dev_ctx;
+	if (parent_pin_ctx.count > 0)
+		tb[DPLL_A_PIN_PARENT_PIN] = (struct nlattr *)&parent_pin_ctx;
+	if (ref_sync_ctx.count > 0)
+		tb[DPLL_A_PIN_REFERENCE_SYNC] = (struct nlattr *)&ref_sync_ctx;
+	if (freq_supp_ctx.count > 0)
+		tb[DPLL_A_PIN_FREQUENCY_SUPPORTED] =
+			(struct nlattr *)&freq_supp_ctx;
+	if (esync_freq_supp_ctx.count > 0)
+		tb[DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED] =
+			(struct nlattr *)&esync_freq_supp_ctx;
+
+	dpll_pin_print_attrs(tb);
+
+	ret = MNL_CB_OK;
+	goto cleanup;
+
+err_alloc:
+	fprintf(stderr,
+		"Failed to allocate memory for multi-attr collection\n");
+	ret = MNL_CB_ERROR;
+
+cleanup:
+	/* Free allocated memory */
+	multi_attr_ctx_free(&parent_dev_ctx);
+	multi_attr_ctx_free(&parent_pin_ctx);
+	multi_attr_ctx_free(&ref_sync_ctx);
+	multi_attr_ctx_free(&freq_supp_ctx);
+	multi_attr_ctx_free(&esync_freq_supp_ctx);
+
+	return ret;
+}
+
+/* Callback for pin dump (multiple) - wraps each pin in object */
+static int cmd_pin_show_dump_cb(const struct nlmsghdr *nlh, void *data)
+{
+	int ret;
+
+	open_json_object(NULL);
+	ret = cmd_pin_show_cb(nlh, data);
+	close_json_object();
+
+	return ret;
+}
+
+static int cmd_pin_show_id(struct dpll *dpll, __u32 id)
+{
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = mnlu_gen_socket_cmd_prepare(&dpll->nlg, DPLL_CMD_PIN_GET,
+					  NLM_F_REQUEST | NLM_F_ACK);
+	mnl_attr_put_u32(nlh, DPLL_A_PIN_ID, id);
+
+	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_pin_show_cb, NULL);
+	if (err < 0) {
+		pr_err("Failed to get pin %u\n", id);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int cmd_pin_show_dump(struct dpll *dpll, bool has_device_id,
+			     __u32 device_id)
+{
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = mnlu_gen_socket_cmd_prepare(&dpll->nlg, DPLL_CMD_PIN_GET,
+					  NLM_F_REQUEST | NLM_F_ACK |
+						  NLM_F_DUMP);
+
+	/* If device_id specified, filter pins by device */
+	if (has_device_id)
+		mnl_attr_put_u32(nlh, DPLL_A_ID, device_id);
+
+	/* Open JSON array for multiple pins */
+	open_json_array(PRINT_JSON, "pin");
+
+	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_pin_show_dump_cb,
+				     NULL);
+	if (err < 0) {
+		pr_err("Failed to dump pins\n");
+		close_json_array(PRINT_JSON, NULL);
+		return -1;
+	}
+
+	/* Close JSON array */
+	close_json_array(PRINT_JSON, NULL);
+
+	return 0;
+}
+
+static int cmd_pin_show(struct dpll *dpll)
+{
+	bool has_pin_id = false, has_device_id = false;
+	__u32 pin_id = 0, device_id = 0;
+
+	while (dpll_argc(dpll) > 0) {
+		if (dpll_argv_match(dpll, "id")) {
+			if (dpll_parse_u32(dpll, "id", &pin_id))
+				return -EINVAL;
+			has_pin_id = true;
+		} else if (dpll_argv_match(dpll, "device")) {
+			if (dpll_parse_u32(dpll, "device", &device_id))
+				return -EINVAL;
+			has_device_id = true;
+		} else {
+			pr_err("unknown option: %s\n", dpll_argv(dpll));
+			return -EINVAL;
+		}
+	}
+
+	if (has_pin_id)
+		return cmd_pin_show_id(dpll, pin_id);
+	else
+		return cmd_pin_show_dump(dpll, has_device_id, device_id);
+}
+
+static int cmd_pin_parse_parent_device(struct dpll *dpll, struct nlmsghdr *nlh)
+{
+	struct nlattr *nest;
+	__u32 parent_id;
+
+	dpll_arg_inc(dpll);
+	if (dpll_arg_required(dpll, "parent-device"))
+		return -EINVAL;
+
+	if (get_u32(&parent_id, dpll_argv(dpll), 0)) {
+		pr_err("invalid parent-device id: %s\n", dpll_argv(dpll));
+		return -EINVAL;
+	}
+	dpll_arg_inc(dpll);
+
+	nest = mnl_attr_nest_start(nlh, DPLL_A_PIN_PARENT_DEVICE);
+	mnl_attr_put_u32(nlh, DPLL_A_PIN_PARENT_ID, parent_id);
+
+	/* Parse optional parent-device attributes */
+	while (dpll_argc(dpll) > 0) {
+		if (dpll_argv_match_inc(dpll, "direction")) {
+			if (dpll_parse_attr_enum(dpll, nlh, "direction",
+						 DPLL_A_PIN_DIRECTION,
+						 dpll_parse_direction))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "prio")) {
+			if (dpll_parse_attr_u32(dpll, nlh, "prio",
+						DPLL_A_PIN_PRIO))
+				return -EINVAL;
+		} else if (dpll_argv_match_inc(dpll, "state")) {
+			if (dpll_parse_attr_enum(dpll, nlh, "state",
+						 DPLL_A_PIN_STATE,
+						 dpll_parse_state))
+				return -EINVAL;
+		} else {
+			/* Not a parent-device attribute, break to parse
+			 * next option.
+			 */
+			break;
+		}
+	}
+
+	mnl_attr_nest_end(nlh, nest);
+
+	return 0;
+}
+
+static int cmd_pin_parse_parent_pin(struct dpll *dpll, struct nlmsghdr *nlh)
+{
+	struct nlattr *nest;
+	__u32 parent_id;
+
+	dpll_arg_inc(dpll);
+	if (dpll_arg_required(dpll, "parent-pin"))
+		return -EINVAL;
+
+	if (get_u32(&parent_id, dpll_argv(dpll), 0)) {
+		pr_err("invalid parent-pin id: %s\n", dpll_argv(dpll));
+		return -EINVAL;
+	}
+	dpll_arg_inc(dpll);
+
+	nest = mnl_attr_nest_start(nlh, DPLL_A_PIN_PARENT_PIN);
+	mnl_attr_put_u32(nlh, DPLL_A_PIN_PARENT_ID, parent_id);
+
+	/* Parse optional parent-pin attributes */
+	while (dpll_argc(dpll) > 0) {
+		if (dpll_argv_match_inc(dpll, "state")) {
+			if (dpll_parse_attr_enum(dpll, nlh, "state",
+						 DPLL_A_PIN_STATE,
+						 dpll_parse_state))
+				return -EINVAL;
+		} else {
+			/* Not a parent-pin attribute, break to parse next
+			 * option.
+			 */
+			break;
+		}
+	}
+
+	mnl_attr_nest_end(nlh, nest);
+
+	return 0;
+}
+
+static int cmd_pin_parse_reference_sync(struct dpll *dpll, struct nlmsghdr *nlh)
+{
+	struct nlattr *nest;
+	__u32 ref_pin_id;
+
+	dpll_arg_inc(dpll);
+	if (dpll_arg_required(dpll, "reference-sync"))
+		return -EINVAL;
+
+	if (get_u32(&ref_pin_id, dpll_argv(dpll), 0)) {
+		pr_err("invalid reference-sync pin id: %s\n", dpll_argv(dpll));
+		return -EINVAL;
+	}
+	dpll_arg_inc(dpll);
+
+	nest = mnl_attr_nest_start(nlh, DPLL_A_PIN_REFERENCE_SYNC);
+	mnl_attr_put_u32(nlh, DPLL_A_PIN_ID, ref_pin_id);
+
+	/* Parse optional reference-sync attributes */
+	while (dpll_argc(dpll) > 0) {
+		if (dpll_argv_match_inc(dpll, "state")) {
+			if (dpll_parse_attr_enum(dpll, nlh, "state",
+						 DPLL_A_PIN_STATE,
+						 dpll_parse_state))
+				return -EINVAL;
+		} else {
+			/* Not a reference-sync attribute, break to parse
+			 * next option.
+			 */
+			break;
+		}
+	}
+
+	mnl_attr_nest_end(nlh, nest);
+
+	return 0;
+}
+
+static int cmd_pin_set(struct dpll *dpll)
+{
+	struct nlmsghdr *nlh;
+	bool has_id = false;
+	__u32 id = 0;
+	int err;
+
+	nlh = mnlu_gen_socket_cmd_prepare(&dpll->nlg, DPLL_CMD_PIN_SET,
+					  NLM_F_REQUEST | NLM_F_ACK);
+
+	while (dpll_argc(dpll) > 0) {
+		if (dpll_argv_match(dpll, "id")) {
+			if (dpll_parse_u32(dpll, "id", &id))
+				return -EINVAL;
+			mnl_attr_put_u32(nlh, DPLL_A_PIN_ID, id);
+			has_id = true;
+		} else if (dpll_argv_match(dpll, "frequency")) {
+			if (dpll_parse_attr_u64(dpll, nlh, "frequency",
+						DPLL_A_PIN_FREQUENCY))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "phase-adjust")) {
+			if (dpll_parse_attr_s32(dpll, nlh, "phase-adjust",
+						DPLL_A_PIN_PHASE_ADJUST))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "esync-frequency")) {
+			if (dpll_parse_attr_u64(dpll, nlh, "esync-frequency",
+						DPLL_A_PIN_ESYNC_FREQUENCY))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "parent-device")) {
+			if (cmd_pin_parse_parent_device(dpll, nlh))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "parent-pin")) {
+			if (cmd_pin_parse_parent_pin(dpll, nlh))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "reference-sync")) {
+			if (cmd_pin_parse_reference_sync(dpll, nlh))
+				return -EINVAL;
+		} else {
+			pr_err("unknown option: %s\n", dpll_argv(dpll));
+			return -EINVAL;
+		}
+	}
+
+	if (!has_id) {
+		pr_err("pin id is required\n");
+		return -EINVAL;
+	}
+
+	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, NULL, NULL);
+	if (err < 0) {
+		pr_err("Failed to set pin\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int cmd_pin_id_get_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct nlattr *tb[DPLL_A_PIN_MAX + 1] = {};
+	int *found = data;
+
+	mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_pin_cb, tb);
+
+	if (tb[DPLL_A_PIN_ID]) {
+		__u32 id = mnl_attr_get_u32(tb[DPLL_A_PIN_ID]);
+		if (is_json_context()) {
+			print_uint(PRINT_JSON, "id", NULL, id);
+		} else {
+			printf("%u\n", id);
+		}
+		if (found)
+			*found = 1;
+	}
+
+	return MNL_CB_OK;
+}
+
+static int cmd_pin_id_get(struct dpll *dpll)
+{
+	struct nlmsghdr *nlh;
+	int found = 0;
+	int err;
+
+	nlh = mnlu_gen_socket_cmd_prepare(&dpll->nlg, DPLL_CMD_PIN_ID_GET,
+					  NLM_F_REQUEST | NLM_F_ACK);
+
+	/* Parse arguments */
+	while (dpll_argc(dpll) > 0) {
+		if (dpll_argv_match(dpll, "module-name")) {
+			if (dpll_parse_attr_str(dpll, nlh, "module-name",
+						DPLL_A_PIN_MODULE_NAME))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "clock-id")) {
+			if (dpll_parse_attr_u64(dpll, nlh, "clock-id",
+						DPLL_A_PIN_CLOCK_ID))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "board-label")) {
+			if (dpll_parse_attr_str(dpll, nlh, "board-label",
+						DPLL_A_PIN_BOARD_LABEL))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "panel-label")) {
+			if (dpll_parse_attr_str(dpll, nlh, "panel-label",
+						DPLL_A_PIN_PANEL_LABEL))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "package-label")) {
+			if (dpll_parse_attr_str(dpll, nlh, "package-label",
+						DPLL_A_PIN_PACKAGE_LABEL))
+				return -EINVAL;
+		} else if (dpll_argv_match(dpll, "type")) {
+			if (dpll_parse_attr_enum(dpll, nlh, "type",
+						 DPLL_A_PIN_TYPE,
+						 dpll_parse_pin_type))
+				return -EINVAL;
+		} else {
+			pr_err("unknown option: %s\n", dpll_argv(dpll));
+			return -EINVAL;
+		}
+	}
+
+	err = mnlu_gen_socket_sndrcv(&dpll->nlg, nlh, cmd_pin_id_get_cb,
+				     &found);
+	if (err < 0) {
+		pr_err("Failed to get pin id\n");
+		return -1;
+	}
+
+	if (!found) {
+		pr_err("No pin found matching the criteria\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int cmd_pin(struct dpll *dpll)
+{
+	if (dpll_argv_match(dpll, "help") || dpll_no_arg(dpll)) {
+		cmd_pin_help();
+		return 0;
+	} else if (dpll_argv_match_inc(dpll, "show")) {
+		return cmd_pin_show(dpll);
+	} else if (dpll_argv_match_inc(dpll, "set")) {
+		return cmd_pin_set(dpll);
+	} else if (dpll_argv_match_inc(dpll, "id-get")) {
+		return cmd_pin_id_get(dpll);
+	}
+
+	pr_err("Command \"%s\" not found\n",
+	       dpll_argv(dpll) ? dpll_argv(dpll) : "");
+	return -ENOENT;
+}
+
+/* Monitor command - notification handling */
+static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
+	const char *cmd_name = "UNKNOWN";
+	const char *json_name = "unknown";
+	int ret = MNL_CB_OK;
+
+	switch (genl->cmd) {
+	case DPLL_CMD_DEVICE_CREATE_NTF:
+		cmd_name = "DEVICE_CREATE";
+		json_name = "device-create-ntf";
+		/* fallthrough */
+	case DPLL_CMD_DEVICE_CHANGE_NTF:
+		if (genl->cmd == DPLL_CMD_DEVICE_CHANGE_NTF) {
+			cmd_name = "DEVICE_CHANGE";
+			json_name = "device-change-ntf";
+		}
+		/* fallthrough */
+	case DPLL_CMD_DEVICE_DELETE_NTF: {
+		if (genl->cmd == DPLL_CMD_DEVICE_DELETE_NTF) {
+			cmd_name = "DEVICE_DELETE";
+			json_name = "device-delete-ntf";
+		}
+		struct nlattr *tb[DPLL_A_MAX + 1] = {};
+		mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_cb, tb);
+
+		if (is_json_context()) {
+			open_json_object(NULL);
+			print_string(PRINT_JSON, "name", NULL, json_name);
+			open_json_object("msg");
+		} else {
+			pr_out("[%s] ", cmd_name);
+		}
+
+		dpll_device_print_attrs(nlh, tb);
+
+		if (is_json_context()) {
+			close_json_object();
+			close_json_object();
+		}
+		break;
+	}
+	case DPLL_CMD_PIN_CREATE_NTF:
+		cmd_name = "PIN_CREATE";
+		json_name = "pin-create-ntf";
+		/* fallthrough */
+	case DPLL_CMD_PIN_CHANGE_NTF:
+		if (genl->cmd == DPLL_CMD_PIN_CHANGE_NTF) {
+			cmd_name = "PIN_CHANGE";
+			json_name = "pin-change-ntf";
+		}
+		/* fallthrough */
+	case DPLL_CMD_PIN_DELETE_NTF: {
+		if (genl->cmd == DPLL_CMD_PIN_DELETE_NTF) {
+			cmd_name = "PIN_DELETE";
+			json_name = "pin-delete-ntf";
+		}
+
+		if (is_json_context()) {
+			open_json_object(NULL);
+			print_string(PRINT_JSON, "name", NULL, json_name);
+			open_json_object("msg");
+		} else {
+			pr_out("[%s] ", cmd_name);
+		}
+
+		ret = cmd_pin_show_cb(nlh, NULL);
+
+		if (is_json_context()) {
+			close_json_object();
+			close_json_object();
+		}
+		break;
+	}
+	default:
+		pr_err("Unknown notification command: %d\n", genl->cmd);
+		break;
+	}
+
+	return ret;
+}
+
+static int cmd_monitor(struct dpll *dpll)
+{
+	struct pollfd pfd;
+	struct sigaction sa;
+	int ret = 0;
+	int fd;
+
+	/* Subscribe to monitor multicast group */
+	ret = mnlg_socket_group_add(&dpll->nlg, "monitor");
+	if (ret) {
+		pr_err("Failed to subscribe to monitor group: %s\n",
+		       strerror(errno));
+		return ret;
+	}
+
+	if (!dpll->json_output) {
+		pr_out("Monitoring DPLL events (Press Ctrl+C to stop)...\n");
+	}
+
+	/* Setup signal handler for graceful exit */
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = monitor_sig_handler;
+	sigaction(SIGINT, &sa, NULL);
+	sigaction(SIGTERM, &sa, NULL);
+
+	/* Get netlink socket fd for polling */
+	fd = mnlg_socket_get_fd(&dpll->nlg);
+	if (fd < 0) {
+		pr_err("Failed to get netlink socket fd\n");
+		return -1;
+	}
+
+	if (dpll->json_output) {
+		open_json_array(PRINT_JSON, "monitor");
+	}
+
+	/* Setup poll structure */
+	memset(&pfd, 0, sizeof(pfd));
+	pfd.fd = fd;
+	pfd.events = POLLIN;
+
+	/* Enter notification loop */
+	while (monitor_running) {
+		ret = poll(&pfd, 1, 1000); /* 1 second timeout */
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			pr_err("poll() failed: %s\n", strerror(errno));
+			ret = -errno;
+			break;
+		}
+
+		if (ret == 0)
+			continue; /* Timeout, check monitor_running flag */
+
+		/* Data available, receive and process */
+		ret = mnlu_gen_socket_recv_run(&dpll->nlg, cmd_monitor_cb,
+					       NULL);
+		if (ret < 0) {
+			/* Only print error if we're still supposed to be running.
+			 * If monitor_running is false, we're shutting down gracefully. */
+			if (monitor_running)
+				pr_err("Failed to receive notifications: %s\n",
+				       strerror(errno));
+			break;
+		}
+	}
+
+	if (dpll->json_output) {
+		close_json_array(PRINT_JSON, NULL);
+	}
+
+	/* Reset signal handlers */
+	signal(SIGINT, SIG_DFL);
+	signal(SIGTERM, SIG_DFL);
+
+	return ret < 0 ? ret : 0;
+}
diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
new file mode 100644
index 00000000000000..23b1d352725a86
--- /dev/null
+++ b/man/man8/dpll.8
@@ -0,0 +1,433 @@
+.TH DPLL 8 "23 October 2025" "iproute2" "Linux"
+.SH NAME
+dpll \- Digital Phase Locked Loop (DPLL) subsystem management
+.SH SYNOPSIS
+.ad l
+.in +8
+.ti -8
+.B dpll
+.RI "[ " OPTIONS " ]"
+.B device
+.RI "{ " COMMAND " | "
+.BR help " }"
+.sp
+
+.ti -8
+.B dpll
+.RI "[ " OPTIONS " ]"
+.B pin
+.RI "{ " COMMAND " | "
+.BR help " }"
+.sp
+
+.ti -8
+.B dpll
+.RI "[ " OPTIONS " ]"
+.B monitor
+
+.ti -8
+.IR OPTIONS " := { "
+\fB\-V\fR[\fIersion\fR] |
+\fB\-j\fR[\fIson\fR] |
+\fB\-p\fR[\fIretty\fR] |
+\fB\-n\fR[\fIo-nice-names\fR] }
+
+.SH DESCRIPTION
+The
+.B dpll
+utility is used to configure and monitor Digital Phase Locked Loop (DPLL)
+devices and pins. DPLLs are used for clock synchronization in various
+hardware, particularly in telecommunications and networking equipment.
+
+A DPLL device can lock to one or more input pins and provide synchronized
+output. Pins can be physical external signals (like GNSS 1PPS, SyncE), or
+internal oscillators.
+
+.SH OPTIONS
+.TP
+.BR "\-V" , " \-Version"
+Print the version of the
+.B dpll
+utility and exit.
+
+.TP
+.BR "\-j" , " \-json"
+Output results in JavaScript Object Notation (JSON).
+
+.TP
+.BR "\-p" , " \-pretty"
+When combined with \-j, generates a pretty JSON output with indentation
+and newlines for better human readability.
+
+.TP
+.BR "\-n" , " \-no-nice-names"
+Use numeric values for enum fields instead of human-readable names.
+
+.SH DEVICE COMMANDS
+
+.SS dpll device show [ id ID ]
+
+Display information about DPLL devices. If no arguments are specified,
+shows all devices in the system.
+
+.TP
+.BI id " ID"
+Show only the device with the specified numeric identifier.
+
+.PP
+Output includes:
+.RS
+.IP \[bu] 2
+Device ID
+.IP \[bu]
+Module name providing the device
+.IP \[bu]
+Clock ID (unique identifier)
+.IP \[bu]
+Operating mode (manual, automatic, holdover, freerun)
+.IP \[bu]
+Lock status (locked-ho-ack, locked, unlocked, holdover)
+.IP \[bu]
+Temperature (if supported)
+.IP \[bu]
+Type (PPS or EEC)
+.RE
+
+.SS dpll device set id ID [ phase-offset-monitor { enable | disable } ] [ phase-offset-avg-factor FACTOR ]
+
+Configure DPLL device parameters.
+
+.TP
+.BI id " ID"
+Specifies which device to configure (required).
+
+.TP
+.BI phase-offset-monitor " { enable | disable | true | false | 0 | 1 }"
+Enable or disable phase offset monitoring between the device and its pins.
+When enabled, the kernel continuously measures and reports phase differences.
+
+.TP
+.BI phase-offset-avg-factor " FACTOR"
+Set the averaging factor (1-255) applied to phase offset calculations.
+Higher values provide smoother but slower-responding measurements.
+
+.SS dpll device id-get [ module-name NAME ] [ clock-id ID ] [ type TYPE ]
+
+Retrieve the device ID based on identifying attributes. Useful for scripting
+when you need to find a device's numeric ID. At least one attribute should
+be specified to identify the device.
+
+.TP
+.BI module-name " NAME"
+Kernel module name.
+
+.TP
+.BI clock-id " ID"
+64-bit clock identifier in decimal or hex (0x prefix).
+
+.TP
+.BI type " TYPE"
+Device type:
+.BR pps " or " eec .
+
+.SH PIN COMMANDS
+
+.SS dpll pin show [ id ID ] [ device ID ]
+
+Display information about DPLL pins. If no arguments are specified,
+shows all pins in the system.
+
+.TP
+.BI id " ID"
+Show only the pin with the specified numeric identifier.
+
+.TP
+.BI device " ID"
+Show only pins associated with the specified device ID.
+
+.PP
+Output includes:
+.RS
+.IP \[bu] 2
+Pin ID
+.IP \[bu]
+Module name
+.IP \[bu]
+Clock ID
+.IP \[bu]
+Board label (hardware label from device tree or ACPI)
+.IP \[bu]
+Pin type (mux, ext, synce-eth-port, int-oscillator, gnss)
+.IP \[bu]
+Frequency and supported frequency ranges
+.IP \[bu]
+Capabilities (state-can-change, priority-can-change, direction-can-change)
+.IP \[bu]
+Phase adjustment range, granularity, and current value
+.IP \[bu]
+Parent device relationships (direction, priority, state, phase offset)
+.IP \[bu]
+Parent pin relationships
+.IP \[bu]
+Reference sync information
+.IP \[bu]
+Esync frequency support (if applicable)
+.RE
+
+.SS dpll pin set id ID [ PARAMETER VALUE ] ...
+
+Configure DPLL pin parameters. Multiple parameters can be specified
+in a single command.
+
+.TP
+.BI id " ID"
+Specifies which pin to configure (required).
+
+.TP
+.BI frequency " FREQ"
+Set pin frequency in Hz. The pin must support the specified frequency
+(check frequency-supported ranges in pin show output).
+
+.TP
+.BI phase-adjust " ADJUSTMENT"
+Set phase adjustment in picoseconds. This value fine-tunes the phase
+of the output signal. Negative values shift the phase backwards,
+positive values shift it forwards. The value must be within the
+phase-adjust-min and phase-adjust-max range.
+
+.TP
+.BI esync-frequency " FREQUENCY"
+Set enhanced SyncE (Synchronous Ethernet) frequency in Hz for capable pins.
+
+.TP
+.BI parent-device " DEVICE_ID " "[ " "direction DIR" " ] [ " "prio PRIO" " ] [ " "state STATE" " ]"
+Configure the relationship between this pin and a parent DPLL device.
+.RS
+.TP
+.BI direction " { input | output }"
+Set the pin's direction relative to the parent device.
+.TP
+.BI prio " PRIORITY"
+Set priority (0-255) for this pin on the parent device.
+.TP
+.BI state " { connected | disconnected | selectable }"
+Set the pin's state on the parent device.
+.RE
+
+.TP
+.BI parent-pin " PIN_ID " "[ " "state STATE" " ]"
+Configure the relationship to a parent pin.
+
+.TP
+.BI reference-sync " PIN_ID " "[ " "state STATE" " ]"
+Configure reference sync relationship with another pin.
+
+.SS dpll pin id-get [ SELECTOR ] ...
+
+Retrieve a pin ID based on identifying attributes.
+
+.TP
+.BI module-name " NAME"
+Filter by kernel module name.
+
+.TP
+.BI clock-id " ID"
+Filter by 64-bit clock identifier.
+
+.TP
+.BI board-label " LABEL"
+Filter by board label (hardware identifier).
+
+.TP
+.BI panel-label " LABEL"
+Filter by panel label.
+
+.TP
+.BI package-label " LABEL"
+Filter by package label.
+
+.TP
+.BI type " TYPE"
+Filter by pin type:
+.BR mux ", " ext ", " synce-eth-port ", " int-oscillator ", " gnss .
+
+.SH MONITOR COMMAND
+
+.SS dpll monitor
+
+Monitor DPLL subsystem events in real-time. Displays notifications about:
+.RS
+.IP \[bu] 2
+Device creation, deletion, and configuration changes
+.IP \[bu]
+Pin creation, deletion, and configuration changes
+.IP \[bu]
+Lock status changes
+.IP \[bu]
+Phase offset updates
+.IP \[bu]
+Frequency changes
+.RE
+
+.PP
+Events are prefixed with their type: [DEVICE_CREATE], [DEVICE_CHANGE],
+[DEVICE_DELETE], [PIN_CREATE], [PIN_CHANGE], [PIN_DELETE].
+
+.PP
+Press Ctrl+C to stop monitoring.
+
+.SH EXAMPLES
+
+.SS Show all DPLL devices
+.nf
+.B dpll device show
+.fi
+
+.SS Show specific device in JSON format
+.nf
+.B dpll -j device show id 0
+.fi
+
+.SS Enable phase offset monitoring on device 0
+.nf
+.B dpll device set id 0 phase-offset-monitor enable
+.fi
+
+.SS Show all pins
+.nf
+.B dpll pin show
+.fi
+
+.SS Show pin with pretty JSON output
+.nf
+.B dpll -jp pin show id 5
+.fi
+
+.SS Set pin frequency to 10 MHz
+.nf
+.B dpll pin set id 0 frequency 10000000
+.fi
+
+.SS Configure pin relationship to parent device
+.nf
+.B dpll pin set id 1 parent-device 0 prio 10 direction input state connected
+.fi
+
+.SS Adjust phase by -1000 picoseconds
+.nf
+.B dpll pin set id 2 phase-adjust -1000
+.fi
+
+.SS Set multiple pin parameters at once
+.nf
+.B dpll pin set id 3 frequency 10000000 phase-adjust -1000
+.fi
+
+.SS Monitor DPLL events
+.nf
+.B dpll monitor
+.fi
+
+.SS Monitor events in JSON format
+.nf
+.B dpll -jp monitor
+.fi
+
+.SS Get device ID by module name
+.nf
+.B dpll device id-get module-name ice
+.fi
+
+.SS Get pin ID by board label
+.nf
+.B dpll pin id-get board-label "GNSS-1PPS"
+.fi
+
+.SH PHASE ADJUSTMENT
+Phase adjustment is specified in picoseconds (1e-12 seconds) and allows
+fine-tuning of signal phase. This is crucial for precise time synchronization
+applications like 5G networks and high-frequency trading.
+
+.PP
+Important considerations:
+.RS
+.IP \[bu] 2
+Check phase-adjust-min and phase-adjust-max before setting values
+.IP \[bu]
+Some hardware requires values to be multiples of phase-adjust-gran
+.IP \[bu]
+Negative values shift phase backwards (earlier in time)
+.IP \[bu]
+Positive values shift phase forwards (later in time)
+.IP \[bu]
+The kernel validates all phase adjustment requests
+.RE
+
+.SH CAPABILITIES
+Pins may have various capabilities that determine which operations are allowed:
+
+.TP
+.B state-can-change
+The pin's state (connected/disconnected/selectable) can be modified.
+
+.TP
+.B priority-can-change
+The pin's priority can be modified. This may apply to top-level priority
+or priority within parent-device relationships.
+
+.TP
+.B direction-can-change
+The pin's direction (input/output) can be modified.
+
+.PP
+Use
+.B dpll pin show
+to check which capabilities a pin supports before attempting configuration
+changes.
+
+.SH EXIT STATUS
+.TP
+.B 0
+Success
+.TP
+.B 1
+General failure
+.TP
+.B 2
+Invalid arguments or usage
+.TP
+.B 255
+Netlink communication error
+
+.SH NOTES
+.IP \[bu] 2
+The DPLL subsystem requires kernel support (CONFIG_DPLL=y or m)
+.IP \[bu]
+Hardware support varies by device and driver
+.IP \[bu]
+Some operations require specific hardware capabilities
+.IP \[bu]
+Phase offset values are measured by hardware and cannot be set directly
+.IP \[bu]
+Changes to device/pin configuration may affect system clock synchronization
+
+.SH SEE ALSO
+.BR ip (8),
+.BR devlink (8),
+.BR ethtool (8)
+
+.PP
+Linux kernel documentation:
+.I Documentation/driver-api/dpll.rst
+
+.PP
+Netlink specification:
+.I Documentation/netlink/specs/dpll.yaml
+
+.SH AUTHOR
+dpll was written by Arkadiusz Kubalewski, Vadim Fedorenko, and others.
+
+This manual page was written by Petr Oros.
+
+.SH REPORTING BUGS
+Report bugs to <netdev@vger.kernel.org>
-- 
2.51.0


