Return-Path: <netdev+bounces-197468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C656AD8B6C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335741885C34
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509FC2D2392;
	Fri, 13 Jun 2025 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2HDweTd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F022A4F1;
	Fri, 13 Jun 2025 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749815750; cv=none; b=dtv2Ac2AG2pCJLSxdY5f8gtRs2O6+awe6RBuItkdds+/b/OMdVKBuX64T5k50szIbrnCpQx6ckfNhI+ZqOLeYRmMA8h2yPSXAFnqfTp5eZgP2fiDxq5u7vpyLOkQZABkxfspSLSaesRM4GwETbbPOsS8x6qb0fX6+0ICibyc6wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749815750; c=relaxed/simple;
	bh=J0EhitDlrIu1hu+1XXXSUw/oOLeGybNBfQdPNA3VApM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=pU7536bAvwtAw7M9Aw4TUJd+qHoBvfAAI6s5rD+WJWWS5p5xAEANlD2IXHuqS/VrEIZN7/n1qA0tQHn6yGM8Fov0Lo53UPwHjUaD1//vTUredhFrOIQD7YmQoN45FGqlPVF2VStaKvNqD93Krv9wU5ozOeqN6GZLgOG5peguf20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2HDweTd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450ce671a08so12490415e9.3;
        Fri, 13 Jun 2025 04:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749815746; x=1750420546; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s0Jd7r0YovHZb9j6sJLhJrjT0z3EOg/1+unPiSwN2eo=;
        b=c2HDweTdZHCqZVT1ChS0tO4EgIKEdj9oOGOAiH3UHhSpG0GfAfZvNXoz9P19G+1NUM
         4TU4eCHrV+P+c2NdJIaxVJ7i5C5y6VX3a2OTfwHNP2quDBKEGC85D9Pj0+ejEkK9Phu9
         74veDGvLkvivAUSxeuvkY/pMDLPn4J/Yt/ktNusLoCtaedB6bpMxAZtcXTWiyqxcBj28
         iXoKwgeEfK6U6IEcM2ufRTErUaPIZmfcD6sIz1RJtNrD7BmvRnwqSnzJEa4iTtiP1eZm
         SQvLkVBvGlk47JqTFzLDYaONwBxFNaX603KlT/Nccgrsd0Z5EWXpBLBZe+7pVAutAAIe
         mKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749815746; x=1750420546;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0Jd7r0YovHZb9j6sJLhJrjT0z3EOg/1+unPiSwN2eo=;
        b=G35TwxsiHtBOzqn+kj4YG5rDCwl/g2ohcAayIeQ3K5FkNFeEuaI/kucYVTJTOirbVW
         8CUx1VimXoy18XAJgEZ5h+EzuRgpXPdueyAnz5GiCQ4gfva0+yx1cM5Yw369xn831ejS
         TiqQfVxyXKYgZJT1qc7cd0W25zu+I7PVXRBm39lrTihP9hGqg/ynfVc8NxUJhciSWry5
         a4shzTz9LvhV1C+38N/FjZUkw7DdZsBLe9UWJZAi+Wu1CoeVzSsPfnl08plzsDNEFEf/
         7uvQ278MS/ImL9hs5aRxTkHkkBO2xTlX3PaX8LIgxhGoZNL4rPrguMEZeSpPDDntppPA
         cZ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNETc7ymz5BEJ6NErFtjTL1nzqjMb6mZ5Wd5o/KGnrR2ww/qIkyTvAYGIED+OZwKdNMiyrRaZL@vger.kernel.org, AJvYcCXVUAKhlSsNjAZpR0o5legqbkXp39MKoxsx2MLx/6A4IEyI3+0bviTzgpcONG2IcnELJDt/h6gnPsgrdS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEOB5DB6YQjP0AG3h6z91NlmcvpXl0WJ/CQvIn9/nFS2qeZOSO
	PqG7ZyXKPeLOtNUqQSgCRDUlxzOV1a/8WsYiW8FKblWFTCWOkxojvJz3
X-Gm-Gg: ASbGnctR7aa0vpzixZld59UwJCCjNhA9eDNQUxQr0b5DDwi3Iy48SatSMuygkXroVAL
	yp9e6gBM9y85NXPGX0MIOB6X81QNrhpgXljyQdaweBi4USb5g07sHhQrMvJ13qYte4SfknByvT8
	Fi1qGQOGNP+Fhiv1HajmORr/nulT8gN+yvsrsif8HW3jzNnWPEG3P8Dsj13v/fNIVBcZeq13sPw
	f22nGlghlOg/cEQjSNbN90dvRZ+TVvSVcmjS5ecFLJ16lBXDaTH1N/Ldphe9JR2+DfWqI3ZiZfV
	fqUw9+UXri5U34JnQ1YKG69wkLzO0xjHhQbDakTknvNANGPooAs7OEOYb+OedFjUjkqP7GA/+EU
	=
X-Google-Smtp-Source: AGHT+IGW0eL0Sz+MMQ5fKW1+Pqr/GURhwD5tm2GubA4NtMMgQA1khyv0UdopZBiD1m8D03I6QjyEeA==
X-Received: by 2002:a05:600c:5395:b0:43e:afca:808f with SMTP id 5b1f17b1804b1-45334b06b56mr29131225e9.31.1749815746230;
        Fri, 13 Jun 2025 04:55:46 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:75e0:f7f7:dffa:561e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e16b425sm49552735e9.34.2025.06.13.04.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:55:41 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Ruben
 Wauters" <rubenru09@aol.com>,  "Shuah Khan" <skhan@linuxfoundation.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v2 11/12] docs: use parser_yaml extension to handle
 Netlink specs
In-Reply-To: <931e46a6fdda4fa67df731b052c121b9094fbd8a.1749723671.git.mchehab+huawei@kernel.org>
Date: Fri, 13 Jun 2025 12:50:48 +0100
Message-ID: <m2ldpvn9lz.fsf@gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<931e46a6fdda4fa67df731b052c121b9094fbd8a.1749723671.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Instead of manually calling ynl_gen_rst.py, use a Sphinx extension.
> This way, no .rst files would be written to the Kernel source
> directories.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/Makefile                        | 17 ---------
>  Documentation/conf.py                         | 11 +++---
>  Documentation/netlink/specs/index.rst         | 38 +++++++++++++++++++
>  Documentation/networking/index.rst            |  2 +-
>  .../networking/netlink_spec/readme.txt        |  4 --
>  Documentation/sphinx/parser_yaml.py           |  2 +-
>  6 files changed, 46 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/netlink/specs/index.rst
>  delete mode 100644 Documentation/networking/netlink_spec/readme.txt
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index d30d66ddf1ad..9185680b1e86 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -102,22 +102,6 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>  		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
>  	fi
>  
> -YNL_INDEX:=$(srctree)/Documentation/networking/netlink_spec/index.rst
> -YNL_RST_DIR:=$(srctree)/Documentation/networking/netlink_spec
> -YNL_YAML_DIR:=$(srctree)/Documentation/netlink/specs
> -YNL_TOOL:=$(srctree)/tools/net/ynl/pyynl/ynl_gen_rst.py
> -
> -YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
> -YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))
> -
> -$(YNL_INDEX): $(YNL_RST_FILES)
> -	$(Q)$(YNL_TOOL) -o $@ -x
> -
> -$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
> -	$(Q)$(YNL_TOOL) -i $< -o $@
> -
> -htmldocs texinfodocs latexdocs epubdocs xmldocs: $(YNL_INDEX)
> -
>  htmldocs:
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
> @@ -184,7 +168,6 @@ refcheckdocs:
>  	$(Q)cd $(srctree);scripts/documentation-file-ref-check
>  
>  cleandocs:
> -	$(Q)rm -f $(YNL_INDEX) $(YNL_RST_FILES)
>  	$(Q)rm -rf $(BUILDDIR)
>  	$(Q)$(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media clean
>  
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 12de52a2b17e..add6ce78dd80 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -45,7 +45,7 @@ needs_sphinx = '3.4.3'
>  extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
>                'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
>                'maintainers_include', 'sphinx.ext.autosectionlabel',
> -              'kernel_abi', 'kernel_feat', 'translations']
> +              'kernel_abi', 'kernel_feat', 'translations', 'parser_yaml']
>  
>  # Since Sphinx version 3, the C function parser is more pedantic with regards
>  # to type checking. Due to that, having macros at c:function cause problems.
> @@ -143,10 +143,11 @@ else:
>  # Add any paths that contain templates here, relative to this directory.
>  templates_path = ['sphinx/templates']
>  
> -# The suffix(es) of source filenames.
> -# You can specify multiple suffix as a list of string:
> -# source_suffix = ['.rst', '.md']
> -source_suffix = '.rst'
> +# The suffixes of source filenames that will be automatically parsed
> +source_suffix = {
> +        '.rst': 'restructuredtext',
> +        '.yaml': 'yaml',

The handler name should probably be netlink_yaml 

> +}
>  
>  # The encoding of source files.
>  #source_encoding = 'utf-8-sig'
> diff --git a/Documentation/netlink/specs/index.rst b/Documentation/netlink/specs/index.rst
> new file mode 100644
> index 000000000000..ca0bf816dc3f
> --- /dev/null
> +++ b/Documentation/netlink/specs/index.rst
> @@ -0,0 +1,38 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. NOTE: This document was auto-generated.
> +
> +.. _specs:
> +
> +=============================
> +Netlink Family Specifications
> +=============================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   conntrack
> +   devlink
> +   dpll
> +   ethtool
> +   fou
> +   handshake
> +   lockd
> +   mptcp_pm
> +   net_shaper
> +   netdev
> +   nfsd
> +   nftables
> +   nl80211
> +   nlctrl
> +   ovpn
> +   ovs_datapath
> +   ovs_flow
> +   ovs_vport
> +   rt-addr
> +   rt-link
> +   rt-neigh
> +   rt-route
> +   rt-rule
> +   tc
> +   tcp_metrics
> +   team
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index ac90b82f3ce9..b7a4969e9bc9 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -57,7 +57,7 @@ Contents:
>     filter
>     generic-hdlc
>     generic_netlink
> -   netlink_spec/index
> +   ../netlink/specs/index
>     gen_stats
>     gtp
>     ila
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
> diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> index eb32e3249274..cdcafe5b3937 100755
> --- a/Documentation/sphinx/parser_yaml.py
> +++ b/Documentation/sphinx/parser_yaml.py
> @@ -55,7 +55,7 @@ class YamlParser(Parser):
>          fname = document.current_source
>  
>          # Handle netlink yaml specs
> -        if re.search("/netlink/specs/", fname):
> +        if re.search("netlink/specs/", fname):

Please combine this change into the earlier patch so that the series
doesn't have unnecessary changes.

>              if fname.endswith("index.yaml"):
>                  msg = self.netlink_parser.generate_main_index_rst(fname, None)
>              else:

