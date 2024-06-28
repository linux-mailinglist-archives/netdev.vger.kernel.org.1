Return-Path: <netdev+bounces-107514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D6491B406
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 02:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B71B224DD
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 00:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968EE17BDC;
	Fri, 28 Jun 2024 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdXcbO7V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB724C635
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534811; cv=none; b=tvQd4hZqRNMXdTCaobO0mvUeqdS0cCB1RSx3R+xnxaMY8OFkbtNIhKMk+ODKcMnbTxdTmTwqs5FdjgBesc0T/BcOb2soQf7bVbGRYpyltioTZMaQkF37PCQZINXqf4OWhygrg7w8prObvjSO8AaCYWLYRCddqrbdJ8cSDKFAOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534811; c=relaxed/simple;
	bh=VIdQ960Dcv8A+OPQudKrpMY7gCZvwJ1R4w3Ia/nWdpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nMQ3Y94VKgIcLV/bM4wCjs3TVxR//XKoIJHcoZssO8dhFrBUPgbi872TqJbVprXdJ8LXSwIrItjmcaWWFtearhsqWRz8bhe4cGAwe7PR9rQB2RxuIeXdp6DUWPe0YaoZpgKs7aBmIpqSIRVIc1RD/4XrvQvST2MnbDnJaPMWD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UdXcbO7V; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c7a8a79cebso122271a91.3
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 17:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719534801; x=1720139601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HtAkC7dc7eD7owfI6upy3bTZg9Fqg9IfLoFV+/ACewo=;
        b=UdXcbO7VlGQSKwAt2o2TpwzjpeDF4TApPC5qkpp6zGB9vZIYx74kW1Nk9gIZyQJw2W
         2Ks9yTf2WhdpImsmyllxWUYrD8hBkvnjlZ2rF23bPoaNWb805NPTvEXLc1CG+FLe38t3
         w81xLUUZLaFOThVpTwKIWCnVcoJgCf6ZSVwzv4FcOijg69iAy8EoKMCBZa+gzViF0jaX
         aPlAyCe1YNsfFk0rA/QovXjSKUMfnRql72KR54Fl5+SSp10QvRnyjg/SmSurqXal86F5
         NK6GrT2siy8vtXf2YgRMl7VGI3gA/YetgXSrIwZqE5RCI2518qqA/0blm6E8zZHsQSQd
         Zemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534801; x=1720139601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtAkC7dc7eD7owfI6upy3bTZg9Fqg9IfLoFV+/ACewo=;
        b=BHVNLWvm3P4dNCJeqRERUmWtyKy+UQcRx3P3J7MqxO2tqIhVdloGroYZgI5WiWV1Ip
         IdNv0hdbhgM1juolj6tOnVnaz/vfsBTzo2NoNHjsE2TsCzqR7i5ra6dOC2LODm/DJg3f
         G5Kgt50/gTWxqbHenElank9KI4mTf0xY+76fkPFlOj5LD1PogRkQxV58UUw45NloGgM7
         gpo6bLUWHiLs6Lr5p8RHAOQXNyLPeAVgT5HeZmkDmJJp/wY9jbfZPsUWDJb7r6jElBa5
         H9JFGIC0Jj1JAx0FGuAOv++8kD9Ak/js2viUr7ajOwqVFdgL+wnxRf/R3eR9/U+8g8uR
         dT8w==
X-Gm-Message-State: AOJu0YyrjxiXDrmeajwduNGI31QSmZBlgmQ3vu0UgfWP46hbY2mzJXMT
	k3ATMOmzFfrRN6N3P5JYBfvcfPtX2vR95S8QB3r4imWuk6dQxQiK7/Lzry/15XHhc5QZV3+rIKv
	crKk9MHCAhhVwct0MWcovdzVy5gNc9wmjII23ipEwhTqlhqrWmEwhfmkbV+VXHJuFG8adt75vcL
	xRMTlnv9/M7DP2euX/3A+1ap/uSEydRl3PdoSx1/8Q8SkPm51a2Eme5ZXYWwo=
X-Google-Smtp-Source: AGHT+IGLRaLTSytcMUc42cO5VbPk30udJR/OWLWuA3cZvbicGZ/TcfoTV4BSYF/3gyDoC1Kg15GgKgYZNfdRX/OyyQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a17:90a:6fa4:b0:2c4:bb9e:fcdc with
 SMTP id 98e67ed59e1d1-2c86144e0femr168873a91.9.1719534800464; Thu, 27 Jun
 2024 17:33:20 -0700 (PDT)
Date: Fri, 28 Jun 2024 00:32:50 +0000
In-Reply-To: <20240628003253.1694510-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628003253.1694510-14-almasrymina@google.com>
Subject: [PATCH net-next v15 13/14] tools: net: package libynl for use in selftests
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jakub Kicinski <kuba@kernel.org>

Support building the C YNL userspace library into one big static file.
We can then link selftests against it for easy to use C netlink
interface.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v15:
- Added this patch from Jakub to fix linking against ynl.
- Squashed fix from Jakub to support O=xyz builds.
---
 tools/net/ynl/Makefile             |  6 +++++-
 tools/net/ynl/lib/Makefile         |  4 +++-
 tools/testing/selftests/net/ynl.mk | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/ynl.mk

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index 8e9e09d84e269..d1cdf2a8f8266 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -2,9 +2,12 @@
 
 SUBDIRS = lib generated samples
 
-all: $(SUBDIRS)
+all: $(SUBDIRS) libynl.a
 
 samples: | lib generated
+libynl.a: | lib generated
+	@echo -e "\tAR $@"
+	@ar rcs $@ lib/ynl.o generated/*-user.o
 
 $(SUBDIRS):
 	@if [ -f "$@/Makefile" ] ; then \
@@ -17,5 +20,6 @@ clean distclean:
 			$(MAKE) -C $$dir $@; \
 		fi \
 	done
+	rm -f libynl.a
 
 .PHONY: all clean distclean $(SUBDIRS)
diff --git a/tools/net/ynl/lib/Makefile b/tools/net/ynl/lib/Makefile
index dfff3ecd1cbab..2887cc5de530f 100644
--- a/tools/net/ynl/lib/Makefile
+++ b/tools/net/ynl/lib/Makefile
@@ -14,7 +14,9 @@ include $(wildcard *.d)
 all: ynl.a
 
 ynl.a: $(OBJS)
-	ar rcs $@ $(OBJS)
+	@echo -e "\tAR $@"
+	@ar rcs $@ $(OBJS)
+
 clean:
 	rm -f *.o *.d *~
 	rm -rf __pycache__
diff --git a/tools/testing/selftests/net/ynl.mk b/tools/testing/selftests/net/ynl.mk
new file mode 100644
index 0000000000000..59cb26cf3f738
--- /dev/null
+++ b/tools/testing/selftests/net/ynl.mk
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# YNL selftest build snippet
+
+# Inputs:
+#
+# YNL_GENS:      families we need in the selftests
+# YNL_PROGS:     TEST_PROGS which need YNL (TODO, none exist, yet)
+# YNL_GEN_FILES: TEST_GEN_FILES which need YNL
+
+YNL_OUTPUTS := $(patsubst %,$(OUTPUT)/%,$(YNL_GEN_FILES))
+
+$(YNL_OUTPUTS): $(OUTPUT)/libynl.a
+$(YNL_OUTPUTS): CFLAGS += \
+	-I$(top_srcdir)/usr/include/ $(KHDR_INCLUDES) \
+	-I$(top_srcdir)/tools/net/ynl/lib/ \
+	-I$(top_srcdir)/tools/net/ynl/generated/
+
+$(OUTPUT)/libynl.a:
+	$(Q)$(MAKE) -C $(top_srcdir)/tools/net/ynl GENS="$(YNL_GENS)" libynl.a
+	$(Q)cp $(top_srcdir)/tools/net/ynl/libynl.a $(OUTPUT)/libynl.a
-- 
2.45.2.803.g4e1b14247a-goog


