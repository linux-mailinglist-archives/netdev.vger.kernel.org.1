Return-Path: <netdev+bounces-285972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBx6BtZK/mllowAAu9opvQ
	(envelope-from <netdev+bounces-285972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:43:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A86DB4FB934
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CBBF3067974
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 20:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1738041B36A;
	Fri,  8 May 2026 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvt1fY/b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D984218B5
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272881; cv=none; b=gynTQwNIf8UyMY/xO4nn+rM4a2li67q2DqRztFqmgM3fSR2ENILeeBobV38Czs+F0Fq8s0rVPDEuWPZKbprMwRBmdfF6yQZCAhamjHb6vZwCzZij8CC5WkUbiUJGofj/bHxQuC9LNTa7DsaR73yIZrkaB8oAgABrjy6V7m4u+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272881; c=relaxed/simple;
	bh=Rudsp3CgAchrH3IB/N7e9+zgOiTPsW8hmwduNNiQft4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdKdLppg6yeH6YL1scsDztXxRXEa9lAtHh3pKCB0EtKRUTi1q5RJqvh1ESfqlcncS9VLaGO9ihTNMCCmFdYTOF/yC92Xm+5kIIDDDox3rdxQ5wTeS72AcpaTAeVmO5IyQTyNjqtH9aeyEojWT2gnn60FCKFTR0z5mGLMOTylOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qvt1fY/b; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c801912c903so1066798a12.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 13:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778272878; x=1778877678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wca3zx/WnWoLrmOvHZAPyXYy9sROruOyKA5iNfJEY8=;
        b=Qvt1fY/bt3u+bi3DNlKNx/hTJoqiipJquW/0oOysZuGIfL7eD1qIu1+KeN5qGgV8F/
         8mdwwwmzWbZP3yYPTdu74JiIIMAT8PIR6WHfPACRyzS5EfIOGu4iIhYWpZ1M/lIcqms2
         gKZN/OhynE6ciRt8Lp0kTgsTed/rEr85Dkp/ZpRXZombmPhVkr4j8FtaEpdOr19HcaJq
         9sebBte65fb9QGvgIavgv1NDkG8Mo4ulLaQ2HjWKu1LT2T1tCGdBMvj4qXqzrgZM3hcO
         uUQSQIaV5LarV1+Ohkmvhf7yw0pHtr2k7Ay+0IMW1AQbHuNw4KfB9udtZLd2LTjM9kjm
         1l5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778272878; x=1778877678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0wca3zx/WnWoLrmOvHZAPyXYy9sROruOyKA5iNfJEY8=;
        b=dkRHdZAqLZh/Eqyekb53c6bojwDHm8gqwepBL1zriLQUPSdEpB8EiJgwojFGFMhvfb
         mk5C1+DrswNrh/etFnZweGfKxKUeqUVcXcaZHMQ2Of6mHNNS1X4GdkA0srAbCT21PRh8
         igHiT7+hPHWFNQrpD1RQeLkpIsC2XVL+aeaanMJlUDhvYycePmG1J0MrcnxAwgLfI3aP
         woMbTejzuJ851fAwRvoXNibZnwULojQ9tyrMekHcd9RLhA38eS2RX/0oVoL6DscWBg17
         HYcMcAW/qdYE/pFDvg1Mn3QKs9tvQbc1qV7iWwRDWqDzRhN5ksRXQCGbsy/87pCL08Zs
         M2Nw==
X-Gm-Message-State: AOJu0YwEzngzaHQXX0f+KvqNDDFxdgKr/ce7bMCskMidWL2TOh8js+Pb
	O7nPNbd2WYeh3RSJSgQ9NvK25DxOvbWp6U9UT0RHNgw1DmB+wmnGJEvg76ocJ5VX
X-Gm-Gg: AeBDiesAGQnTXsgCHqsEskDgKACAg/vEFCxeVSQGEMmNw3Ok5lBKk7UisuQn1N6qNOV
	xjJMsXNzEKedhClaxvxAI2jA84c14d/MbKyI5496oJi8QMO/AMxJm5mSl6fX5WOcrXHzlyfi9eG
	B0c2MTaOwkgXUPOKmakLhMwiUO+Cag5OzHl65CJDb0Ne2f01uUiIfL1TT0qZuqCE55tmyqWy6uB
	BRFpmxxEjV3mLX3qO4ZnRen0DJhqn20mTrUBsvQ382QHjUGDryk1je3QOnyjFMAuRWZFCv7N3a0
	5e55WiwlXDKHYPIBU158a8AGYDA4ow8PJk5wNzBF00LLYaBNSFEiTcyH7aI29z9RY61fuBX5jTX
	Jr3Jw0a4G3rzDp0PvijQRkUazcC5YNVqo8lOwC7eSr2sGD4CaoXqax3qzjKY95VqXI3dUJj/8Nr
	VgzPFtmZVHUx3AkZnI
X-Received: by 2002:a05:6a20:3949:b0:398:4bf2:4285 with SMTP id adf61e73a8af0-3aa5a49f218mr15966769637.16.1778272877749;
        Fri, 08 May 2026 13:41:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826772742bsm2764471a12.29.2026.05.08.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 13:41:17 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	horms@kernel.org,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] tools/ynl: add check-deps target to verify Makefile.deps completeness
Date: Fri,  8 May 2026 13:41:14 -0700
Message-ID: <20260508204114.205896-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508204114.205896-1-sdf@fomichev.me>
References: <20260508204114.205896-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A86DB4FB934
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285972-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add two make rules that detect missing entries in Makefile.deps:

check-existing-deps-<family>: for families that already have CFLAGS,
  parse each force-included header for #include directives and verify
  that every included uapi header is either already listed in CFLAGS
  or findable by the compiler without -idirafter.

check-new-deps-<family>: for families without CFLAGS, check whether
  their default uapi header (linux/<family>.h) exists in the kernel
  tree but is not findable by the compiler -- meaning it needs a new
  CFLAGS entry.

(this is slop but I added extensive comments on how it works)

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/net/ynl/Makefile.deps      | 35 ++++++++++++++++++++++++++++++++
 tools/net/ynl/generated/Makefile |  6 +++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index cc53b2f21c44..f2c24097a2c8 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -52,3 +52,38 @@ CFLAGS_tc:= $(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,_TC_TUNNEL_KEY_H,tc_act/tc_tunnel_key.h)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
 CFLAGS_wireguard:=$(call get_hdr_inc2,_LINUX_WIREGUARD_H,_WG_UAPI_WIREGUARD_H,wireguard.h)
+
+# For families that already have CFLAGS, verify that every #include in
+# their force-included headers is accounted for.
+#
+# How it works:
+#   1. Extract -include paths from CFLAGS_<family>      (grep + sed)
+#   2. Parse each header for #include <...> directives  (sed)
+#   3. Skip if the included file is not a uapi header   (test against UAPI_PATH)
+#   4. Skip if it is already listed in CFLAGS_<family>  (grep)
+#   5. Skip if the compiler can find it without help    (try $(CC))
+#   6. Otherwise error -- the header needs to be added
+check-existing-deps-%:
+	@for inc in $$(sed -n 's/.*#include <\([^>]*\)>.*/\1/p' \
+		$$(echo "$(CFLAGS_$*)" | grep -o '\-include [^ ]*' | sed 's/-include //')); do \
+	  test -f $(UAPI_PATH)/$$inc || continue; \
+	  echo "$(CFLAGS_$*)" | grep -qF "$$inc" && continue; \
+	  echo "#include <$$inc>" | $(CC) -x c -fsyntax-only - 2>/dev/null && continue; \
+	  echo "ERROR: $* missing $$inc"; exit 1; \
+	done; true
+
+# For families without CFLAGS, check whether their default uapi header
+# (linux/<family>.h) exists in the kernel tree but is not findable by
+# the compiler -- meaning it needs a new CFLAGS entry.
+#
+# How it works (short-circuit chain, all four must fail to error):
+#   1. Skip if CFLAGS_<family> is already defined          (test -n)
+#   2. Skip if the default uapi header does not exist      (test -f)
+#   3. Skip if the compiler can find it without help       (try $(CC))
+#   4. Otherwise error -- a new CFLAGS entry is needed
+check-new-deps-%:
+	@test -n "$(CFLAGS_$*)" \
+	  || ! test -f $(UAPI_PATH)/linux/$(subst -,_,$*).h \
+	  || echo "#include <linux/$(subst -,_,$*).h>" | \
+	     $(CC) -x c -fsyntax-only - 2>/dev/null \
+	  || { echo "ERROR: $* needs CFLAGS entry for linux/$(subst -,_,$*).h"; exit 1; }
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 86e1e4a959a7..0f1d2c70b6a5 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -83,5 +83,9 @@ install-rsts: $(RSTS)
 
 install: install-headers install-rsts install-specs
 
-.PHONY: all clean distclean regen install install-headers install-rsts install-specs
+check-deps: $(patsubst %,check-existing-deps-%,$(GENS)) \
+	    $(patsubst %,check-new-deps-%,$(GENS))
+	@echo "All Makefile.deps OK"
+
+.PHONY: all clean distclean regen install install-headers install-rsts install-specs check-deps
 .DEFAULT_GOAL: all
-- 
2.53.0-Meta


