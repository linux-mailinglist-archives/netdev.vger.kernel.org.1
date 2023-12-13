Return-Path: <netdev+bounces-57079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A6C8120D7
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5BF2826B5
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 21:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3477FBA4;
	Wed, 13 Dec 2023 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLNp9H+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E04FDB
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 13:41:03 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4258423e133so53436891cf.3
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 13:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702503662; x=1703108462; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ENsPs54kjRIcSGHvpPRlMUMeU51Igm+ASIsv1zG5SA=;
        b=DLNp9H+ecdWCYwKMRlAjzg7rPQG/NirkaW1gVg7naqc16S/4cqMs1bT5TEH1E96vQQ
         SrHJJovb9Oeb2ZlxYMiIqpxdHE9eCMkc06mH8fchFrgdl1xEPm1O9qZAIbaYJ0UIl8IV
         wIJJmYY2kqFjJlrC1aF0RuigNNtpSWANeSkG9XkhIkFUvkvyqqBZ+DhhEIyB8l9jaqy9
         PrkuSUacCEni+mHpK/9D/SwCTZqTrBHlWc+bmIkuFrivg68OleqbQfhFm8UgOESop7MQ
         8MVnpmZJIeNCQO5B4S2pzED17ygY6rDkrrAVJxcnp7xE9nAVXfN0fTxUsh7VjkgMwE+h
         iJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702503662; x=1703108462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ENsPs54kjRIcSGHvpPRlMUMeU51Igm+ASIsv1zG5SA=;
        b=AopKrxXkf+1mT5hRMZeosFtbkyUY8cZOojHcOrXbxXsc40eUYbvCyVZ52C1KtAdIgL
         Px9jjVRfyj4EcCZe8Q+yGQ3ls/smEsavateqvHXyhpgW6cTzZeGI154UawoeUrexWplJ
         6S3y+HulKVZ4s0815MglU0z5OEG4Y7Y3My5kGkqaTZGB0ulrKKTlegpVxhQrFiFqq0aa
         B/4HCc+KbmPvj/cra3cyVqMCBlYsSge6shuAury5DUbV0Z6Z2AIMrHgzU6vOVup6jqZ+
         7vyRIatXUma2eC1m0dZFtBP1wCeDX4Os0C+84z1I0E7S9vEkbQ0QSf9gD5DgT6/vw4Cr
         qCfw==
X-Gm-Message-State: AOJu0YxRP8hYJk4ElUQnYnUPPofacjBtf/6NPBbZoj/kYro7LLP579Se
	8hK8ga7nrM+zjTSVkkRhGH4=
X-Google-Smtp-Source: AGHT+IH044XEFl/mUwRa5bGbk3kvBKAnPqR19W8D+sx6e0/F61LcdZiSixAU6yKtjYnAZ5Yuuj+S/A==
X-Received: by 2002:a05:622a:144e:b0:425:aa00:cdd9 with SMTP id v14-20020a05622a144e00b00425aa00cdd9mr11872185qtx.16.1702503662488;
        Wed, 13 Dec 2023 13:41:02 -0800 (PST)
Received: from localhost ([69.156.66.74])
        by smtp.gmail.com with ESMTPSA id e7-20020ac845c7000000b00418122186ccsm5198285qto.12.2023.12.13.13.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 13:41:02 -0800 (PST)
Date: Wed, 13 Dec 2023 16:40:53 -0500
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	mlxsw@nvidia.com, Jay Vosburgh <j.vosburgh@gmail.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Import top-level lib.sh
 through $lib_dir
Message-ID: <ZXok5cRZDKdjX1nj@d3>
References: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
 <ZXcERjbKl2JFClEz@Laptop-X1>
 <87fs07mi0w.fsf@nvidia.com>
 <ZXi_veDs_NMDsFrD@d3>
 <ZXlIew7PbTglpUmV@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXlIew7PbTglpUmV@Laptop-X1>

On 2023-12-13 14:00 +0800, Hangbin Liu wrote:
> On Tue, Dec 12, 2023 at 03:17:01PM -0500, Benjamin Poirier wrote:
> > On 2023-12-12 18:22 +0100, Petr Machata wrote:
[...]
> > There is also another related issue which is that generating a test
> > archive using gen_tar for the tests under drivers/net/bonding does not
> > include the new lib.sh. This is similar to the issue reported here:
> > https://lore.kernel.org/netdev/40f04ded-0c86-8669-24b1-9a313ca21076@redhat.com/
> > 
> > /tmp/x# ./run_kselftest.sh
> > TAP version 13
> > [...]
> > # timeout set to 120
> > # selftests: drivers/net/bonding: dev_addr_lists.sh
> > # ./net_forwarding_lib.sh: line 41: ../lib.sh: No such file or directory
> > # TEST: bonding cleanup mode active-backup                            [ OK ]
> > # TEST: bonding cleanup mode 802.3ad                                  [ OK ]
> > # TEST: bonding LACPDU multicast address to slave (from bond down)    [ OK ]
> > # TEST: bonding LACPDU multicast address to slave (from bond up)      [ OK ]
> > ok 4 selftests: drivers/net/bonding: dev_addr_lists.sh
> > [...]
> 
> Hmm.. Is it possible to write a rule in the Makefile to create the net/
> and net/forwarding folder so we can source the relative path directly. e.g.
> 
> ]# tree
> .
> ├── drivers
> │   └── net
> │       └── bonding
> │           ├── bond-arp-interval-causes-panic.sh
> │           ├── ...
> │           └── settings
> ├── kselftest
> │   ├── module.sh
> │   ├── prefix.pl
> │   └── runner.sh
> ├── kselftest-list.txt
> ├── net
> │   ├── forwarding
> │   │   └── lib.sh
> │   └── lib.sh
> └── run_kselftest.sh

That sounds like a good idea. I started to work on that approach but I'm
missing recursive inclusion. For instance

cd tools/testing/selftests
make install TARGETS="drivers/net/bonding"
./kselftest_install/run_kselftest.sh -t drivers/net/bonding:dev_addr_lists.sh

includes net/forwarding/lib.sh but is missing net/lib.sh. I feel that my
'make' skills are rusty but I guess that with enough make code, it could
be done. A workaround is simply to manually list the transitive
dependencies in TEST_SH_LIBS:
 TEST_SH_LIBS := \
-	net/forwarding/lib.sh
+	net/forwarding/lib.sh \
+	net/lib.sh

I only converted a few files to validate that the approach is viable. I
used the following tests:
drivers/net/bonding/dev_addr_lists.sh
net/test_vxlan_vnifiltering.sh
net/forwarding/pedit_ip.sh

Let me know what you think.

---
 tools/testing/selftests/Makefile                            | 5 ++++-
 tools/testing/selftests/drivers/net/bonding/Makefile        | 6 ++++--
 .../testing/selftests/drivers/net/bonding/dev_addr_lists.sh | 2 +-
 .../selftests/drivers/net/bonding/net_forwarding_lib.sh     | 1 -
 tools/testing/selftests/lib.mk                              | 3 +++
 tools/testing/selftests/net/forwarding/Makefile             | 3 +++
 tools/testing/selftests/net/forwarding/lib.sh               | 3 ++-
 7 files changed, 17 insertions(+), 6 deletions(-)
 delete mode 120000 tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 3b2061d1c1a5..0aaa7efa3015 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -256,7 +256,10 @@ ifdef INSTALL_PATH
 	@ret=1;	\
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install \
+		$(MAKE) install OUTPUT=$$BUILD_TARGET -C $$TARGET \
+				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
+				SH_LIBS_PATH=$(INSTALL_PATH) \
+				BASE_PATH=$(shell pwd) \
 				O=$(abs_objtree)		\
 				$(if $(FORCE_TARGETS),|| exit);	\
 		ret=$$((ret * $$?));		\
diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 8a72bb7de70f..6682f8c1fe79 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -15,7 +15,9 @@ TEST_PROGS := \
 TEST_FILES := \
 	lag_lib.sh \
 	bond_topo_2d1c.sh \
-	bond_topo_3d1c.sh \
-	net_forwarding_lib.sh
+	bond_topo_3d1c.sh
+
+TEST_SH_LIBS := \
+	net/forwarding/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh b/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
index 5cfe7d8ebc25..e6fa24eded5b 100755
--- a/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
+++ b/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
@@ -14,7 +14,7 @@ ALL_TESTS="
 REQUIRE_MZ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 source "$lib_dir"/lag_lib.sh
 
diff --git a/tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh b/tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
deleted file mode 120000
index 39c96828c5ef..000000000000
--- a/tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
+++ /dev/null
@@ -1 +0,0 @@
-../../../net/forwarding/lib.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 118e0964bda9..94b7af7d6610 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -137,6 +137,9 @@ endef
 install: all
 ifdef INSTALL_PATH
 	$(INSTALL_RULE)
+	$(if $(TEST_SH_LIBS), \
+		cd $(BASE_PATH) && rsync -aR $(TEST_SH_LIBS) $(SH_LIBS_PATH)/ \
+	)
 else
 	$(error Error: set INSTALL_PATH to use install)
 endif
diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index df593b7b3e6b..4f6921638bae 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -128,4 +128,7 @@ TEST_PROGS_EXTENDED := devlink_lib.sh \
 	sch_tbf_etsprio.sh \
 	tc_common.sh
 
+TEST_SH_LIBS := \
+	net/lib.sh
+
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8f6ca458af9a..b99fae42e3c0 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -38,7 +38,8 @@ if [[ -f $relative_path/forwarding.config ]]; then
 	source "$relative_path/forwarding.config"
 fi
 
-source ../lib.sh
+libdir=$(dirname "$(readlink -f "$BASH_SOURCE")")
+source "$libdir"/../lib.sh
 ##############################################################################
 # Sanity checks
 
-- 
2.43.0


