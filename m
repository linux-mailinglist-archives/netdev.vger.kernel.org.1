Return-Path: <netdev+bounces-301164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JrDBJythOWpdrQcAu9opvQ
	(envelope-from <netdev+bounces-301164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:22:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E78B26B117C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:22:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=iU13BGH1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301164-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301164-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2D30303FAC6
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDD82BF3F3;
	Mon, 22 Jun 2026 16:17:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46A28B4FD
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 16:17:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145023; cv=none; b=FlMhxEoZzUWVDr92lfj5qWWgLSK/VnEACyjov61Hc7TiXz9cdIsrCQmgb4HAnd+fdQir7xTDw8x1Lz1Rd193W5xo+UJOOzxuQHKkHGrwJg7TKSZwDqopWsBhCvPe73+vivS+iopCrFg+HvPD3/Dpc8IsD7YfMpHmHXipTTPeC5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145023; c=relaxed/simple;
	bh=bWEoJFHHy62FjA8QEigDCnFd7magrSdNWqBBONZ7zY0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MxFbop5OQQRvpaqtRTmAE/kmwdXQaOMWCV6mn7T3Flx77VTUOHTF9IDeS+OjEqcf/bmnuuHaKiOn8JA/+ZS5CUH8lNHw6+bgCTj+RaCe1CQiJwV3lYcXcNysuOeCTaGX9LJA3f+/C+tDeoOXBs2aqdPOlHlUHfME8904rvxQ/cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iU13BGH1; arc=none smtp.client-ip=74.125.82.74
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-139b74d67e0so5199073c88.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782145021; x=1782749821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SMSmZxIMhOBeYVyXoP64tmtdyk4nneH9mpG3GDncSfY=;
        b=iU13BGH1bBtvwZmcpSB0I5+Q+8pcw7VAbTmOo9kVJOJicpvywjHl3vxIe7hkkTLNDI
         r1KQa0Vz/a6/WcJJBI7xbC3KLSA3ScxDlBjJ522vOl/7s8hRzxSJsgt5e6Xk2YgRoo+S
         8T8UdIiBCFzad9FCgo9AIfPwiZJG5FcGMVI39DTxC1WCGi4jo8La1YLvJkP/LwWD91P+
         LGsO/J0KI4xKkNY500jKGfhDjm7H+QMQvH20eZ3QsrE4wW5e10jsexU48MBW4gGVFKwG
         FYbHl0Wi7hR5ti2Yyph0gfTmFfBb6MZkTpPYKKabeAzLDDzftvSq0aeJARDsMz5jg9nG
         aMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782145021; x=1782749821;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMSmZxIMhOBeYVyXoP64tmtdyk4nneH9mpG3GDncSfY=;
        b=DlL8dKDEITz11AnwaeD7GVz/phD97+v7MuGpSlAdnAf+GeGzJ3nD+leBWjqGvUEqvd
         /JRjZfphDjYYYJlKb4Lnkz8E3yC7BWsPCQdhWjiMhI4rUt8XPcxio26f3l+s4ZGyNnHo
         8vfvWH3auOkkB6upHULX8NhqZeSPcqG24cCu1/T8dfdOlpk9NkerFSP0PCDQFRoSPQaD
         mbOVhygW9648rPgwlS92GMCv41GSf2KrG4StDNcXRKqw1U9V21kQ7dTq5Z3/r31JmkWW
         5m0TozeEnllGX0yncz4R3oVQ3WFYaH0D3w+CCL30GKc4OandMssSs9mc/dXhcFObLaMG
         Nkhg==
X-Gm-Message-State: AOJu0YxrNRGv+5B7GsimZ2gzaiygiSgkS19qq+d87B6yr6IR48jwNa37
	9c1zLgQ8JOuvIRfGtcEeU9UFnZel/+0RN7oRfblViyOkGd19aqIS+rjmo0DbMJH3C8ZUOVdrCoS
	zT6KJVGKnIg==
X-Received: from dldz1-n1.prod.google.com ([2002:a05:701b:4181:10b0:139:aab5:170b])
 (user=gthelen job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:982:b0:136:9ebf:3c04
 with SMTP id a92af1059eb24-139ad7113femr6849007c88.25.1782145020905; Mon, 22
 Jun 2026 09:17:00 -0700 (PDT)
Date: Mon, 22 Jun 2026 09:16:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260622161659.145047-1-gthelen@google.com>
Subject: [PATCH] tools: ynl: build archives with $(AR)
From: Greg Thelen <gthelen@google.com>
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_HAS_CURRENCY(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gthelen@google.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[gthelen@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gthelen@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301164-lists,netdev=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E78B26B117C

Use $(AR) to allow build system to override the archiver tool (e.g.,
when cross-compiling for a different architecture) by setting the AR
environment variable.

GNU Make defaults AR to ar, so this change will not break existing build
environments that do not explicitly set AR.

Fixes: 07c3cc51a085 ("tools: net: package libynl for use in selftests")
Fixes: 86878f14d71a ("tools: ynl: user space helpers")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 tools/net/ynl/Makefile           | 2 +-
 tools/net/ynl/generated/Makefile | 2 +-
 tools/net/ynl/lib/Makefile       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index d514a48dae27..3cefe4ed96cb 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -22,7 +22,7 @@ tests: | lib generated libynl.a
 ynltool: | lib generated libynl.a
 libynl.a: | lib generated
 	@echo -e "\tAR $@"
-	@ar rcs $@ lib/ynl.o generated/*-user.o
+	@$(AR) rcs $@ lib/ynl.o generated/*-user.o
 
 $(SUBDIRS):
 	@if [ -f "$@/Makefile" ] ; then \
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 86e1e4a959a7..ea4128f612d6 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -37,7 +37,7 @@ all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI) $(RSTS)
 
 protos.a: $(OBJS)
 	@echo -e "\tAR $@"
-	@ar rcs $@ $(OBJS)
+	@$(AR) rcs $@ $(OBJS)
 
 %-user.h: $(SPECS_DIR)/%.yaml $(TOOL)
 	@echo -e "\tGEN $@"
diff --git a/tools/net/ynl/lib/Makefile b/tools/net/ynl/lib/Makefile
index 4b2b98704ff9..9b98c0599600 100644
--- a/tools/net/ynl/lib/Makefile
+++ b/tools/net/ynl/lib/Makefile
@@ -15,7 +15,7 @@ all: ynl.a
 
 ynl.a: $(OBJS)
 	@echo -e "\tAR $@"
-	@ar rcs $@ $(OBJS)
+	@$(AR) rcs $@ $(OBJS)
 
 clean:
 	rm -f *.o *.d *~
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


