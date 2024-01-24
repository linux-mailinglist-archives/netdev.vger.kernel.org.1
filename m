Return-Path: <netdev+bounces-65580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4697683B10B
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 19:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3071F25424
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BC612AAD5;
	Wed, 24 Jan 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JxMA5xHh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4DE12A171
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120686; cv=none; b=sjr18ILiumn4xjA+qOV/nQtdD6DsZpTJkmUGnsQEN2vnnN5W52Z1R3M6huhEekZxcpwsnzs8W96N58cifn3rWOs5G26D3E+UwDwcdEdgBiWqTt0kYSazFi8+ROPlNzRakaV3b4HBi5TV6dWVW7Ly4HhSE01Wh6vVBYF8WvUdoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120686; c=relaxed/simple;
	bh=d6GDc+QkNSrk9oyuCdAXMvGQPW/LMWt0q3wXnRE1Gzw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=VcfyoCeSEkx+Hh0VKfdFPAXDTBhoAYZNkVZzBLUJUsBOntYqDF8VOl3YJPcJkguzf7vYV5bXUxUmsS0qYBjCBGHk1CDKG2TDnDtSFOkM/AamaTIvXtXKNs2MmB/82mkfcby9UWmFcr4B7nupVZumOVxtg2QeL7428HC0OdBGHmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JxMA5xHh; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E661740A19
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706120682;
	bh=WFJAzGJpjiEflCT7uULX/fRESimoKCgcTGRqRm1jnZ0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=JxMA5xHheS59r0Bh6QyKSfWYlt+mR3nKYfeLA1bWP9RFURsCtC9CmwlPitGZrRy0J
	 FrPzpnAdoBcyTcKeMEKXtS+JfEDeaSR7uZLIBkfY3ALw3A3ts+t41S1P7xhtQaPurW
	 EyzhzfKW0QoA5LQ7tmcN0Yr0YTnuiIoxgG4tKJ1b+xgpPDyDyQRRZhNvx69UgalMTt
	 nsoPNPaWYwmvw8ooUUIi8N608Iff4stEskmDTJD63WTYorAYFl6qgx0NY4+rkWhAMh
	 2v4kVH7OVIdRajEEgB57Y3oX73uR2JHPB3UTFar1bLE7aTlTCcxnkNqHiAwqF3hST/
	 YnCdjaeIfGmHQ==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5ca4ee5b97aso2737146a12.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 10:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120679; x=1706725479;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFJAzGJpjiEflCT7uULX/fRESimoKCgcTGRqRm1jnZ0=;
        b=lEPKtzagisk0llgG2WD1SpZcJX6nJAJo4B72reAZdQmYIBjDMyuNhSvQfuA8Q839YG
         UcwYkcWm3wK0zgiFNjqq4Fk75Ze5NA73fcC3gznWyd3guU/STZDO4sGG5lkGCJkfhYTf
         6lhbH/JA5gxE9E3KfdeTkpwT2re4MOdMj0xIb/1xvJihwUKpFLQOsZ84hhUZboG2/Yky
         p1Zf5hOPpjM/OTq3n8R+ogK82hhXyWBxywlO7mHTBYOh9qyUT9HR8DqEkoy/GUvoQ2OB
         m0VSjDBT3ORwDnHl3BqWKptQjoYu88BTlz3IYW1yyrykyIMOeIaE1JTeKyAo56PKOU2A
         W20Q==
X-Gm-Message-State: AOJu0Yxu4opk8e8k8iCCUlK7+HixihJDWPCor3H5cTvox3aa/SAzVJk2
	E5MthEby7EhwYA8bqA6s+0qNKiaekb4D4f+Y7xROgNOmyOLmJo9DnMn93y+iYv8yl9RXH34jjhB
	FxXeu/XjMLVP5NkNqiaGoXnI1lm4DnfIGM4DLGZdJKlmBqta8GXA56fzi8hNm2D9S6NOK8g==
X-Received: by 2002:a17:902:e9c4:b0:1d7:3687:ca33 with SMTP id 4-20020a170902e9c400b001d73687ca33mr1175134plk.68.1706120679035;
        Wed, 24 Jan 2024 10:24:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOVgCZ+57YFrf80kfBTxr3WLJy7dvkAlYiXQXpAyKtlTZIwxzv+zgQyjCVZ5Zkb+L9cuUcRg==
X-Received: by 2002:a17:902:e9c4:b0:1d7:3687:ca33 with SMTP id 4-20020a170902e9c400b001d73687ca33mr1175120plk.68.1706120678727;
        Wed, 24 Jan 2024 10:24:38 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090332c500b001d7715031f9sm2812198plr.171.2024.01.24.10.24.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2024 10:24:38 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id D75A35FFF6; Wed, 24 Jan 2024 10:24:37 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id CF99A9FB50;
	Wed, 24 Jan 2024 10:24:37 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andy Gospodarek <andy@greyhouse.net>, Andrew Lunn <andrew@lunn.ch>,
    Florian Fainelli <f.fainelli@gmail.com>,
    Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Petr Machata <petrm@nvidia.com>,
    Danielle Ratson <danieller@nvidia.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Ido Schimmel <idosch@nvidia.com>,
    Johannes Nixdorf <jnixdorf-oss@avm.de>,
    Davide Caratti <dcaratti@redhat.com>,
    Tobias Waldekranz <tobias@waldekranz.com>,
    Zahari Doychev <zdoychev@maxlinear.com>,
    Hangbin Liu <liuhangbin@gmail.com>, linux-kselftest@vger.kernel.org,
    linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] selftests: bonding: Add net/forwarding/lib.sh to TEST_INCLUDES
In-reply-to: <20240124170222.261664-3-bpoirier@nvidia.com>
References: <20240124170222.261664-1-bpoirier@nvidia.com> <20240124170222.261664-3-bpoirier@nvidia.com>
Comments: In-reply-to Benjamin Poirier <bpoirier@nvidia.com>
   message dated "Wed, 24 Jan 2024 12:02:18 -0500."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8204.1706120677.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jan 2024 10:24:37 -0800
Message-ID: <8205.1706120677@famine>

Benjamin Poirier <bpoirier@nvidia.com> wrote:

>In order to avoid duplicated files when both the bonding and forwarding
>tests are exported together, add net/forwarding/lib.sh to TEST_INCLUDES a=
nd
>include it via its relative path.
>
>Reviewed-by: Petr Machata <petrm@nvidia.com>
>Tested-by: Petr Machata <petrm@nvidia.com>
>Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
>---
> tools/testing/selftests/drivers/net/bonding/Makefile        | 6 ++++--
> .../selftests/drivers/net/bonding/bond-eth-type-change.sh   | 2 +-
> .../testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh | 2 +-
> .../testing/selftests/drivers/net/bonding/dev_addr_lists.sh | 2 +-
> .../drivers/net/bonding/mode-1-recovery-updelay.sh          | 2 +-
> .../drivers/net/bonding/mode-2-recovery-updelay.sh          | 2 +-
> .../selftests/drivers/net/bonding/net_forwarding_lib.sh     | 1 -
> 7 files changed, 9 insertions(+), 8 deletions(-)
> delete mode 120000 tools/testing/selftests/drivers/net/bonding/net_forwa=
rding_lib.sh
>
>diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools=
/testing/selftests/drivers/net/bonding/Makefile
>index 8a72bb7de70f..1e10a1f06faf 100644
>--- a/tools/testing/selftests/drivers/net/bonding/Makefile
>+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
>@@ -15,7 +15,9 @@ TEST_PROGS :=3D \
> TEST_FILES :=3D \
> 	lag_lib.sh \
> 	bond_topo_2d1c.sh \
>-	bond_topo_3d1c.sh \
>-	net_forwarding_lib.sh
>+	bond_topo_3d1c.sh
>+
>+TEST_INCLUDES :=3D \
>+	../../../net/forwarding/lib.sh
> =

> include ../../../lib.mk
>diff --git a/tools/testing/selftests/drivers/net/bonding/bond-eth-type-ch=
ange.sh b/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change=
.sh
>index 862e947e17c7..8293dbc7c18f 100755
>--- a/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh
>+++ b/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh
>@@ -11,7 +11,7 @@ ALL_TESTS=3D"
> REQUIRE_MZ=3Dno
> NUM_NETIFS=3D0
> lib_dir=3D$(dirname "$0")
>-source "$lib_dir"/net_forwarding_lib.sh
>+source "$lib_dir"/../../../net/forwarding/lib.sh
> =

> bond_check_flags()
> {
>diff --git a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.s=
h b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
>index a509ef949dcf..0eb7edfb584c 100644
>--- a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
>+++ b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
>@@ -28,7 +28,7 @@
> REQUIRE_MZ=3Dno
> NUM_NETIFS=3D0
> lib_dir=3D$(dirname "$0")
>-source ${lib_dir}/net_forwarding_lib.sh
>+source "$lib_dir"/../../../net/forwarding/lib.sh

	Is there a way to pass TEST_INCLUDES via the environment or as a
parameter, so that it's not necessary to hard code the path name here
and in the similar cases below?

	-J

> s_ns=3D"s-$(mktemp -u XXXXXX)"
> c_ns=3D"c-$(mktemp -u XXXXXX)"
>diff --git a/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.s=
h b/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
>index 5cfe7d8ebc25..e6fa24eded5b 100755
>--- a/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
>+++ b/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
>@@ -14,7 +14,7 @@ ALL_TESTS=3D"
> REQUIRE_MZ=3Dno
> NUM_NETIFS=3D0
> lib_dir=3D$(dirname "$0")
>-source "$lib_dir"/net_forwarding_lib.sh
>+source "$lib_dir"/../../../net/forwarding/lib.sh
> =

> source "$lib_dir"/lag_lib.sh
> =

>diff --git a/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-=
updelay.sh b/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-u=
pdelay.sh
>index b76bf5030952..9d26ab4cad0b 100755
>--- a/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay=
.sh
>+++ b/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay=
.sh
>@@ -23,7 +23,7 @@ REQUIRE_MZ=3Dno
> REQUIRE_JQ=3Dno
> NUM_NETIFS=3D0
> lib_dir=3D$(dirname "$0")
>-source "$lib_dir"/net_forwarding_lib.sh
>+source "$lib_dir"/../../../net/forwarding/lib.sh
> source "$lib_dir"/lag_lib.sh
> =

> cleanup()
>diff --git a/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-=
updelay.sh b/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-u=
pdelay.sh
>index 8c2619002147..2d275b3e47dd 100755
>--- a/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay=
.sh
>+++ b/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay=
.sh
>@@ -23,7 +23,7 @@ REQUIRE_MZ=3Dno
> REQUIRE_JQ=3Dno
> NUM_NETIFS=3D0
> lib_dir=3D$(dirname "$0")
>-source "$lib_dir"/net_forwarding_lib.sh
>+source "$lib_dir"/../../../net/forwarding/lib.sh
> source "$lib_dir"/lag_lib.sh
> =

> cleanup()
>diff --git a/tools/testing/selftests/drivers/net/bonding/net_forwarding_l=
ib.sh b/tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
>deleted file mode 120000
>index 39c96828c5ef..000000000000
>--- a/tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
>+++ /dev/null
>@@ -1 +0,0 @@
>-../../../net/forwarding/lib.sh
>\ No newline at end of file
>-- =

>2.43.0
>
>

