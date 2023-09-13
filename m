Return-Path: <netdev+bounces-33650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9833E79F0BD
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 19:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F71E1C20AE1
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 17:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CBB200CA;
	Wed, 13 Sep 2023 17:58:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308F200C3
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 17:58:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 369C919AE
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694627927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qawn5ppsw1vm2xxtX3RUrgq9U34E1jYZhJD2HrMAzsc=;
	b=K0MYzyZdLkqMt7dMJEa4hhNdgqbYRTvwCdOqcs0Z4RByjL8FvzHh08xBWmYL6Kv22kWkpe
	+uOYG7x6+HtXKSAlJchvtneRa0McsJmdY7X+68EQCS7eyxKZmbxJ5JbfM+3lEHBUBj5yTh
	tsoplMvp8PxgBsDtdZYQYzca4uyFl3o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-DCPnJ2wGOrmQPM9phsFezA-1; Wed, 13 Sep 2023 13:58:44 -0400
X-MC-Unique: DCPnJ2wGOrmQPM9phsFezA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7A33101B456;
	Wed, 13 Sep 2023 17:58:43 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.193.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A76A040C6EA8;
	Wed, 13 Sep 2023 17:58:41 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux-foundation.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2-next 1/2] configure: add the --color option
Date: Wed, 13 Sep 2023 19:58:25 +0200
Message-ID: <844947000ac7744a3b40b10f9cf971fd15572195.1694625043.git.aclaudi@redhat.com>
In-Reply-To: <cover.1694625043.git.aclaudi@redhat.com>
References: <cover.1694625043.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2

This commit allows users/packagers to choose a default for the color
output feature provided by some iproute2 tools.

The configure script option is documented in the script itself and it is
pretty much self-explanatory. The default value is set to "never" to
avoid changes to the current ip, tc, and bridge behaviour.

Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 Makefile  |  3 ++-
 configure | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7d1819ce..a24844cf 100644
--- a/Makefile
+++ b/Makefile
@@ -41,7 +41,8 @@ endif
 DEFINES+=-DCONF_USR_DIR=\"$(CONF_USR_DIR)\" \
          -DCONF_ETC_DIR=\"$(CONF_ETC_DIR)\" \
          -DNETNS_RUN_DIR=\"$(NETNS_RUN_DIR)\" \
-         -DNETNS_ETC_DIR=\"$(NETNS_ETC_DIR)\"
+         -DNETNS_ETC_DIR=\"$(NETNS_ETC_DIR)\" \
+         -DCONF_COLOR=$(CONF_COLOR)
 
 #options for AX.25
 ADDLIB+=ax25_ntop.o
diff --git a/configure b/configure
index 18be5a03..eb689341 100755
--- a/configure
+++ b/configure
@@ -5,6 +5,7 @@
 INCLUDE="$PWD/include"
 PREFIX="/usr"
 LIBDIR="\${prefix}/lib"
+COLOR="never"
 
 # Output file which is input to Makefile
 CONFIG=config.mk
@@ -479,6 +480,24 @@ check_cap()
 	fi
 }
 
+check_color()
+{
+	case "$COLOR" in
+		never)
+			echo 'CONF_COLOR:=COLOR_OPT_NEVER' >> $CONFIG
+			echo 'never'
+			;;
+		auto)
+			echo 'CONF_COLOR:=COLOR_OPT_AUTO' >> $CONFIG
+			echo 'auto'
+			;;
+		always)
+			echo 'CONF_COLOR:=COLOR_OPT_ALWAYS' >> $CONFIG
+			echo 'always'
+			;;
+	esac
+}
+
 quiet_config()
 {
 	cat <<EOF
@@ -509,6 +528,10 @@ usage()
 {
 	cat <<EOF
 Usage: $0 [OPTIONS]
+	--color <never|auto|always>	Default color output configuration. Available options:
+					  never: color output is disabled (default)
+					  auto: color output is enabled if stdout is a terminal
+					  always: color output is enabled regardless of stdout state
 	--include_dir <dir>		Path to iproute2 include dir
 	--libdir <dir>			Path to iproute2 lib dir
 	--libbpf_dir <dir>		Path to libbpf DESTDIR
@@ -527,6 +550,11 @@ if [ $# -eq 1 ] && [ "$(echo $1 | cut -c 1)" != '-' ]; then
 else
 	while [ "$#" -gt 0 ]; do
 		case "$1" in
+			--color)
+				shift
+				COLOR="$1" ;;
+			--color=*)
+				COLOR="${1#*=}" ;;
 			--include_dir)
 				shift
 				INCLUDE="$1" ;;
@@ -563,6 +591,12 @@ else
 	done
 fi
 
+case "$COLOR" in
+	never) ;;
+	auto) ;;
+	always) ;;
+	*) usage 1 ;;
+esac
 [ -d "$INCLUDE" ] || usage 1
 if [ "${LIBBPF_DIR-unused}" != "unused" ]; then
 	[ -d "$LIBBPF_DIR" ] || usage 1
@@ -634,6 +668,9 @@ check_strlcpy
 echo -n "libcap support: "
 check_cap
 
+echo -n "color output: "
+check_color
+
 echo >> $CONFIG
 echo "%.o: %.c" >> $CONFIG
 echo '	$(QUIET_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CPPFLAGS) -c -o $@ $<' >> $CONFIG
-- 
2.41.0


