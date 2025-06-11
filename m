Return-Path: <netdev+bounces-196554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEB1AD5424
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EFD3A4EEB
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906DC26056B;
	Wed, 11 Jun 2025 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwwtIp0w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30025256C81;
	Wed, 11 Jun 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641851; cv=none; b=VU2fGKKuijSlw+MA6Lw71CXyM3jqkYo3F4mAN5qUHXAeHJdsO+D3GWLR1iUd1tQ5Sw/DTwwVlc2iZLrcbk8mkOyJrZHbj9+mNofL9R14NLwpwa2a7GsoQcgfyhk2GW7jbZaHrSg0gYjndScItrZjCkREYx9WriaM1uFBE+bwsfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641851; c=relaxed/simple;
	bh=ynapGZn6oVCGqIqdm9ICyxeW7g0aY9YgageUSZw/YVc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=l6P+mOe1OcaiBNU6svYbqNQTgauWMo4iEmgJhnEF+MwqRqxWX1H54eJgml9jwHPnbLfkSMSjfYTdb3l0gcz9qZK/lIgPdpSt0RZeySa2NDZsHmualr/NM+IxX3JQRjS3tMM9s3qmM3vOZlD4xc7/NPG57iwkVQMCB6uQK1odgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwwtIp0w; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-442fda876a6so59484795e9.0;
        Wed, 11 Jun 2025 04:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749641846; x=1750246646; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3srtY1BF1LfZhi5tBhl5EYeXZw1pakC0x+LoDf81OWM=;
        b=BwwtIp0w0UGmXVNEz/X4RMmatvouucmUnpv1HBpOpIT0y+M0skIWJ4qlvdmeWg6rLq
         0oVd3vN3PCZUuaeMLwMDMdBfOJi3HkwZ3BgZEo5iR5XJfcvjQ0q9k6X/DTihbaOlA9Zd
         pw8P5kgukVvFO/Am5bek6BSk0crI3JBWksmDKjHQftGvRV8Gpik5H9XHrPgXSXkKLspI
         xd/nCdkKo0WO+xxSuAmLI4mXPpbJcJCqG2Nb3O10O3gIXBCZlGVP/uYu/fmP1s3XNxOL
         HSbcWLv3NyQN2igU84O3yKFb4BSccXCOhk3vAc8hjYE2kgmhswZHM4CjxqVuND+00NBZ
         YJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749641846; x=1750246646;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3srtY1BF1LfZhi5tBhl5EYeXZw1pakC0x+LoDf81OWM=;
        b=pAyKEAn7rBGL9WC8dszOCYt0DEdSaBhiUQfHah+CexILiQ9ZwE5pvn4uzrknvtIM0T
         8l5x5u8y4qfjz/on5mEk2cQ3Gy6H2aGU4JWwhX3VYA+0u5IhFCT6sqrXrUKoEBV7gm80
         4voMLVVBQ2DlZAWsI9+41bQ/C9opw0UoqWa0UNnc/dDT7vVxdatR4N3HOXYFeCkfA812
         cSxxrtBqDQn4IzZ/QJx9hDYxnTrIB4U9LBR/zbEQSyJ5boVCpo50r7xtOll/Oi5QmmoB
         UCzknEUrjiR2+WFVPtvsU0o534ZZeAlsqKM8tNOLtgWGc5tj1vazCa4+qtRRxeCLih7y
         uQ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEy8FyEGzRHly22blh8269+7Pexa/gZhNS8LC6lskpJi7BTmL8gRBHONSp89dbXSUKUUaJEE7jkqZ0Mvg=@vger.kernel.org, AJvYcCXTIDxtvhNI6bYwAE+PfBx6E/AUbjYXygukzB8rlLg+bAPa0rt3kWFvkQ62sPHjnRqPEPwmIQv+@vger.kernel.org
X-Gm-Message-State: AOJu0YyehdYTrJPLu1CAU7oxqWp8IIzFe46I6IUKPKPhFy/qd7HH+Qv3
	HFpHzCdepfeDqfASF4tFq+nyai4YZcyTl0adrnjbXGAVxBNpgsd91WZhXdY7RFKz
X-Gm-Gg: ASbGnctZ3jolaH/bWDKB85fe6R8QKvqQmDBSy7xBms6HhAVYxa35Vgz1KVPNFCkKyMZ
	q+KjI01uqYpSu882Jx8Xz64Zv0xwuLkK218ZNAvqcbwg98cwLQgpijYIH+EEZiQ4sPWFAe0HyOs
	SbE3/KAU8OEQf4jH3mT0krZxOwZs2rIM3uMQ8WdN/LZuM4BHgUeErdtIAP8BDFWUKU4aZzIz3E2
	Ky/T5Yk4SSYRxL8cPaEqbEagy2QeQxzz25xoSUNU/8dV3xBdSl8/UPf2vOjnrIjGCPl4Io9Lj+Z
	CAn42npwg6M5U5alvGt6vXd2v9Lx34h3hL6DfFuLVgby6gEwptUhgSrRiIzDVPF/SWfkznLJGPs
	RRPd0FdpwdQ==
X-Google-Smtp-Source: AGHT+IG/cnGtWMEfZprUpCdtd2OSBMsmyCKvHWbbS5Cw+GO1Y8SaUfoOEkBPDp9EDQhsDwPgcNJh6A==
X-Received: by 2002:a05:600c:37c6:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-453248cd27emr21132465e9.20.1749641846123;
        Wed, 11 Jun 2025 04:37:26 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:acc4:f1bd:6203:c85f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532515e62asm18395095e9.13.2025.06.11.04.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 04:37:25 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  "Jonathan Corbet"
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Ignacio
 Encinas Rubio" <ignacio@iencinas.com>,  "Marco Elver" <elver@google.com>,
  "Shuah Khan" <skhan@linuxfoundation.org>,  Eric Dumazet
 <edumazet@google.com>,  Jan Stancek <jstancek@redhat.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Ruben Wauters <rubenru09@aol.com>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH 4/4] docs: netlink: store generated .rst files at
 Documentation/output
In-Reply-To: <5183ad8aacc1a56e2dce9cc125b62905b93e83ca.1749551140.git.mchehab+huawei@kernel.org>
Date: Wed, 11 Jun 2025 12:36:57 +0100
Message-ID: <m24iwmpl0m.fsf@gmail.com>
References: <cover.1749551140.git.mchehab+huawei@kernel.org>
	<5183ad8aacc1a56e2dce9cc125b62905b93e83ca.1749551140.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> It is not a good practice to store build-generated files
> inside $(srctree), as one may be using O=<BUILDDIR> and even
> have the Kernel on a read-only directory.
>
> Change the YAML generation for netlink files to be inside
> the documentation output directory.
>
> This solution is not perfect, though, as sphinx-build only produces
> html files only for files inside the source tree. As it is desired
> to have one netlink file per family, it means that one template
> file is required for every file inside Documentation/netlink/specs.
> Such template files are simple enough. All they need is:
>
> 	# Template for Documentation/netlink/specs/<foo>.yaml
> 	.. kernel-include:: $BUILDDIR/networking/netlink_spec/<foo>.rst

I am not a fan of this approach because it pollutes the
Documentation/output dir with source files and the kernel-include
directive is a bit of a hacky workaround.

> A better long term solution is to have an extension at
> Documentation/sphinx that parses *.yaml files for netlink files,
> which could internally be calling ynl_gen_rst.py. Yet, some care
> needs to be taken, as yaml extensions are also used inside device
> tree.

The extension does seem like a better approach, but as mentioned by
Jakub, we'd want to add stub creation to the YNL regen.

The only other approach I can think of to avoid generating files in the
source tree or polluting the Documentation/output dir is to stage all of
the Documentation/ tree into BUILDDIR before adding generated files
there, then running:

  sphinx-build BUILDDIR/Documentation BUILDDIR/Documentation/output

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/Makefile                        |  8 ++++----
>  .../networking/netlink_spec/conntrack.rst     |  3 +++
>  .../networking/netlink_spec/devlink.rst       |  3 +++
>  .../networking/netlink_spec/dpll.rst          |  3 +++
>  .../networking/netlink_spec/ethtool.rst       |  3 +++
>  Documentation/networking/netlink_spec/fou.rst |  3 +++
>  .../networking/netlink_spec/handshake.rst     |  3 +++
>  .../networking/netlink_spec/index.rst         |  6 ++++++
>  .../networking/netlink_spec/lockd.rst         |  3 +++
>  .../networking/netlink_spec/mptcp_pm.rst      |  3 +++
>  .../networking/netlink_spec/net_shaper.rst    |  3 +++
>  .../networking/netlink_spec/netdev.rst        |  3 +++
>  .../networking/netlink_spec/nfsd.rst          |  3 +++
>  .../networking/netlink_spec/nftables.rst      |  3 +++
>  .../networking/netlink_spec/nl80211.rst       |  3 +++
>  .../networking/netlink_spec/nlctrl.rst        |  3 +++
>  .../networking/netlink_spec/ovpn.rst          |  3 +++
>  .../networking/netlink_spec/ovs_datapath.rst  |  3 +++
>  .../networking/netlink_spec/ovs_flow.rst      |  3 +++
>  .../networking/netlink_spec/ovs_vport.rst     |  3 +++
>  .../networking/netlink_spec/readme.txt        |  4 ----
>  .../networking/netlink_spec/rt-addr.rst       |  3 +++
>  .../networking/netlink_spec/rt-link.rst       |  3 +++
>  .../networking/netlink_spec/rt-neigh.rst      |  3 +++
>  .../networking/netlink_spec/rt-route.rst      |  3 +++
>  .../networking/netlink_spec/rt-rule.rst       |  3 +++
>  Documentation/networking/netlink_spec/tc.rst  |  3 +++
>  .../networking/netlink_spec/tcp_metrics.rst   |  3 +++
>  .../networking/netlink_spec/team.rst          |  3 +++
>  tools/net/ynl/pyynl/ynl_gen_rst.py            | 19 +++++++++++++------
>  30 files changed, 101 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/networking/netlink_spec/conntrack.rst
>  create mode 100644 Documentation/networking/netlink_spec/devlink.rst
>  create mode 100644 Documentation/networking/netlink_spec/dpll.rst
>  create mode 100644 Documentation/networking/netlink_spec/ethtool.rst
>  create mode 100644 Documentation/networking/netlink_spec/fou.rst
>  create mode 100644 Documentation/networking/netlink_spec/handshake.rst
>  create mode 100644 Documentation/networking/netlink_spec/index.rst
>  create mode 100644 Documentation/networking/netlink_spec/lockd.rst
>  create mode 100644 Documentation/networking/netlink_spec/mptcp_pm.rst
>  create mode 100644 Documentation/networking/netlink_spec/net_shaper.rst
>  create mode 100644 Documentation/networking/netlink_spec/netdev.rst
>  create mode 100644 Documentation/networking/netlink_spec/nfsd.rst
>  create mode 100644 Documentation/networking/netlink_spec/nftables.rst
>  create mode 100644 Documentation/networking/netlink_spec/nl80211.rst
>  create mode 100644 Documentation/networking/netlink_spec/nlctrl.rst
>  create mode 100644 Documentation/networking/netlink_spec/ovpn.rst
>  create mode 100644 Documentation/networking/netlink_spec/ovs_datapath.rst
>  create mode 100644 Documentation/networking/netlink_spec/ovs_flow.rst
>  create mode 100644 Documentation/networking/netlink_spec/ovs_vport.rst
>  delete mode 100644 Documentation/networking/netlink_spec/readme.txt
>  create mode 100644 Documentation/networking/netlink_spec/rt-addr.rst
>  create mode 100644 Documentation/networking/netlink_spec/rt-link.rst
>  create mode 100644 Documentation/networking/netlink_spec/rt-neigh.rst
>  create mode 100644 Documentation/networking/netlink_spec/rt-route.rst
>  create mode 100644 Documentation/networking/netlink_spec/rt-rule.rst
>  create mode 100644 Documentation/networking/netlink_spec/tc.rst
>  create mode 100644 Documentation/networking/netlink_spec/tcp_metrics.rst
>  create mode 100644 Documentation/networking/netlink_spec/team.rst
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index d30d66ddf1ad..2383825dba49 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -102,8 +102,8 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>  		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
>  	fi
>  
> -YNL_INDEX:=$(srctree)/Documentation/networking/netlink_spec/index.rst
> -YNL_RST_DIR:=$(srctree)/Documentation/networking/netlink_spec
> +YNL_INDEX:=$(BUILDDIR)/networking/netlink_spec/netlink_index.rst
> +YNL_RST_DIR:=$(BUILDDIR)/networking/netlink_spec/
>  YNL_YAML_DIR:=$(srctree)/Documentation/netlink/specs
>  YNL_TOOL:=$(srctree)/tools/net/ynl/pyynl/ynl_gen_rst.py
>  
> @@ -111,12 +111,12 @@ YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
>  YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))
>  
>  $(YNL_INDEX): $(YNL_RST_FILES)
> -	$(Q)$(YNL_TOOL) -o $@ -x
> +	$(Q)$(YNL_TOOL) -o $@ -d $(YNL_YAML_DIR) -x
>  
>  $(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
>  	$(Q)$(YNL_TOOL) -i $< -o $@
>  
> -htmldocs texinfodocs latexdocs epubdocs xmldocs: $(YNL_INDEX)
> +htmldocs texinfodocs latexdocs epubdocs xmldocs: $(YNL_INDEX) $(YNL_RST_FILES)
>  
>  htmldocs:
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
> diff --git a/Documentation/networking/netlink_spec/conntrack.rst b/Documentation/networking/netlink_spec/conntrack.rst
> new file mode 100644
> index 000000000000..6fc6af1e6de4
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/conntrack.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/conntrack.rst
> diff --git a/Documentation/networking/netlink_spec/devlink.rst b/Documentation/networking/netlink_spec/devlink.rst
> new file mode 100644
> index 000000000000..412295d396c1
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/devlink.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/devlink.rst
> diff --git a/Documentation/networking/netlink_spec/dpll.rst b/Documentation/networking/netlink_spec/dpll.rst
> new file mode 100644
> index 000000000000..913e1d9ef744
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/dpll.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/dpll.rst
> diff --git a/Documentation/networking/netlink_spec/ethtool.rst b/Documentation/networking/netlink_spec/ethtool.rst
> new file mode 100644
> index 000000000000..42136a8572b9
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/ethtool.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/ethtool.rst
> diff --git a/Documentation/networking/netlink_spec/fou.rst b/Documentation/networking/netlink_spec/fou.rst
> new file mode 100644
> index 000000000000..103528337d46
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/fou.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/fou.rst
> diff --git a/Documentation/networking/netlink_spec/handshake.rst b/Documentation/networking/netlink_spec/handshake.rst
> new file mode 100644
> index 000000000000..600abec80431
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/handshake.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/handshake.rst
> diff --git a/Documentation/networking/netlink_spec/index.rst b/Documentation/networking/netlink_spec/index.rst
> new file mode 100644
> index 000000000000..8a07a77f2e8b
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/index.rst
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Netlink documentation is populated during the build of the documentation
> +# (htmldocs) by the tools/net/ynl/pyynl/ynl_gen_rst.py script.
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/netlink_index.rst
> diff --git a/Documentation/networking/netlink_spec/lockd.rst b/Documentation/networking/netlink_spec/lockd.rst
> new file mode 100644
> index 000000000000..6374dc2a982c
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/lockd.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/lockd.rst
> diff --git a/Documentation/networking/netlink_spec/mptcp_pm.rst b/Documentation/networking/netlink_spec/mptcp_pm.rst
> new file mode 100644
> index 000000000000..8923db35603e
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/mptcp_pm.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/mptcp_pm.rst
> diff --git a/Documentation/networking/netlink_spec/net_shaper.rst b/Documentation/networking/netlink_spec/net_shaper.rst
> new file mode 100644
> index 000000000000..82d9300f1c0c
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/net_shaper.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/net_shaper.rst
> diff --git a/Documentation/networking/netlink_spec/netdev.rst b/Documentation/networking/netlink_spec/netdev.rst
> new file mode 100644
> index 000000000000..c379a79c5f23
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/netdev.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/netdev.rst
> diff --git a/Documentation/networking/netlink_spec/nfsd.rst b/Documentation/networking/netlink_spec/nfsd.rst
> new file mode 100644
> index 000000000000..40716f4a3fa8
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/nfsd.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/nfsd.rst
> diff --git a/Documentation/networking/netlink_spec/nftables.rst b/Documentation/networking/netlink_spec/nftables.rst
> new file mode 100644
> index 000000000000..1dc6d7c5ca58
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/nftables.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/nftables.rst
> diff --git a/Documentation/networking/netlink_spec/nl80211.rst b/Documentation/networking/netlink_spec/nl80211.rst
> new file mode 100644
> index 000000000000..c056418f7068
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/nl80211.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/nl80211.rst
> diff --git a/Documentation/networking/netlink_spec/nlctrl.rst b/Documentation/networking/netlink_spec/nlctrl.rst
> new file mode 100644
> index 000000000000..7fe48f26718e
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/nlctrl.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/nlctrl.rst
> diff --git a/Documentation/networking/netlink_spec/ovpn.rst b/Documentation/networking/netlink_spec/ovpn.rst
> new file mode 100644
> index 000000000000..c146b803d742
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/ovpn.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/ovpn.rst
> diff --git a/Documentation/networking/netlink_spec/ovs_datapath.rst b/Documentation/networking/netlink_spec/ovs_datapath.rst
> new file mode 100644
> index 000000000000..0b1242f2cc9c
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/ovs_datapath.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/ovs_datapath.rst
> diff --git a/Documentation/networking/netlink_spec/ovs_flow.rst b/Documentation/networking/netlink_spec/ovs_flow.rst
> new file mode 100644
> index 000000000000..c1019ab06aff
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/ovs_flow.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/ovs_flow.rst
> diff --git a/Documentation/networking/netlink_spec/ovs_vport.rst b/Documentation/networking/netlink_spec/ovs_vport.rst
> new file mode 100644
> index 000000000000..13eb53ff4c75
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/ovs_vport.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/ovs_vport.rst
> diff --git a/Documentation/networking/netlink_spec/readme.txt b/Documentation/networking/netlink_spec/readme.txt
> deleted file mode 100644
> index 030b44aca4e6..000000000000
> --- a/Documentation/networking/netlink_spec/readme.txt
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -SPDX-License-Identifier: GPL-2.0
> -
> -This file is populated during the build of the documentation (htmldocs) by the
> -tools/net/ynl/pyynl/ynl_gen_rst.py script.
> diff --git a/Documentation/networking/netlink_spec/rt-addr.rst b/Documentation/networking/netlink_spec/rt-addr.rst
> new file mode 100644
> index 000000000000..2739e81b7a04
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/rt-addr.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/rt-addr.rst
> diff --git a/Documentation/networking/netlink_spec/rt-link.rst b/Documentation/networking/netlink_spec/rt-link.rst
> new file mode 100644
> index 000000000000..d4df7268d07c
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/rt-link.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/rt-link.rst
> diff --git a/Documentation/networking/netlink_spec/rt-neigh.rst b/Documentation/networking/netlink_spec/rt-neigh.rst
> new file mode 100644
> index 000000000000..6c8b62d7b2ff
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/rt-neigh.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/rt-neigh.rst
> diff --git a/Documentation/networking/netlink_spec/rt-route.rst b/Documentation/networking/netlink_spec/rt-route.rst
> new file mode 100644
> index 000000000000..a629d14bf405
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/rt-route.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/rt-route.rst
> diff --git a/Documentation/networking/netlink_spec/rt-rule.rst b/Documentation/networking/netlink_spec/rt-rule.rst
> new file mode 100644
> index 000000000000..e4a991b1bacd
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/rt-rule.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/rt-rule.rst
> diff --git a/Documentation/networking/netlink_spec/tc.rst b/Documentation/networking/netlink_spec/tc.rst
> new file mode 100644
> index 000000000000..1e78d3caeb5d
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/tc.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/tc.rst
> diff --git a/Documentation/networking/netlink_spec/tcp_metrics.rst b/Documentation/networking/netlink_spec/tcp_metrics.rst
> new file mode 100644
> index 000000000000..ea43bd6f6925
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/tcp_metrics.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/tcp_metrics.rst
> diff --git a/Documentation/networking/netlink_spec/team.rst b/Documentation/networking/netlink_spec/team.rst
> new file mode 100644
> index 000000000000..45a3f4d3ed80
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/team.rst
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-include:: $BUILDDIR/networking/netlink_spec/team.rst
> diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
> index 7bfb8ceeeefc..70417a9a8e96 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_rst.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
> @@ -365,6 +365,7 @@ def parse_arguments() -> argparse.Namespace:
>  
>      parser.add_argument("-v", "--verbose", action="store_true")
>      parser.add_argument("-o", "--output", help="Output file name")
> +    parser.add_argument("-d", "--input_dir", help="YAML input directory")
>  
>      # Index and input are mutually exclusive
>      group = parser.add_mutually_exclusive_group()
> @@ -405,11 +406,14 @@ def write_to_rstfile(content: str, filename: str) -> None:
>      """Write the generated content into an RST file"""
>      logging.debug("Saving RST file to %s", filename)
>  
> +    dir = os.path.dirname(filename)
> +    os.makedirs(dir, exist_ok=True)
> +
>      with open(filename, "w", encoding="utf-8") as rst_file:
>          rst_file.write(content)
>  
>  
> -def generate_main_index_rst(output: str) -> None:
> +def generate_main_index_rst(output: str, index_dir: str, ) -> None:
>      """Generate the `networking_spec/index` content and write to the file"""
>      lines = []
>  
> @@ -418,12 +422,15 @@ def generate_main_index_rst(output: str) -> None:
>      lines.append(rst_title("Netlink Family Specifications"))
>      lines.append(rst_toctree(1))
>  
> -    index_dir = os.path.dirname(output)
> -    logging.debug("Looking for .rst files in %s", index_dir)
> +    index_fname = os.path.basename(output)
> +    if not index_dir:
> +        index_dir = os.path.dirname(output)
> +
> +    logging.debug("Looking for .yaml files in %s", index_dir)
>      for filename in sorted(os.listdir(index_dir)):
> -        if not filename.endswith(".rst") or filename == "index.rst":
> +        if not filename.endswith(".yaml") or filename == index_fname:
>              continue
> -        lines.append(f"   {filename.replace('.rst', '')}\n")
> +        lines.append(f"   {filename.replace('.yaml', '')}\n")
>  
>      logging.debug("Writing an index file at %s", output)
>      write_to_rstfile("".join(lines), output)
> @@ -447,7 +454,7 @@ def main() -> None:
>  
>      if args.index:
>          # Generate the index RST file
> -        generate_main_index_rst(args.output)
> +        generate_main_index_rst(args.output, args.input_dir)
>  
>  
>  if __name__ == "__main__":

