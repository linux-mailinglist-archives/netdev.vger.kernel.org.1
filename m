Return-Path: <netdev+bounces-49382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7F77F1DC3
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283DF28125E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6114637173;
	Mon, 20 Nov 2023 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwrlbX4O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB73714B;
	Mon, 20 Nov 2023 20:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FDDC433C8;
	Mon, 20 Nov 2023 20:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700510827;
	bh=qDhVmeRxMwWr07EGDhK+eYCT2EyQYeCpb9U7RNVpTcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZwrlbX4O71gbSINgSdWtmM9Jt8g9BQ1SOH4d9uRzQuzAIa8QKrXb1gMBsLS93Rr24
	 +M4eZ6XJEFiuiqjoX6CWktLduWna9Jb04nylaCAJalxbIXmw4Ptg6ktNuKcWm1MChi
	 1n+OqAgi2ClBIpuyvYE2qKsGLBvZ73t8HBJs4V33c/cx1DWFz1iq4+aKFDV/irBkM9
	 u/2OZSPeJda7jEnxoV7/geclz0+KqSyLRrtcUSPpukUZd2jdGdhTuUM3PWgi7EplKP
	 GY2ruhmygSJPAaJThHKaYCGLi/5grW5iESxl8dpMjyd1gsdy94zZzgK44vpIGzGKBO
	 FDU2ZM0U2aHdw==
Date: Mon, 20 Nov 2023 12:07:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: leit@meta.com, Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 donald.hunter@gmail.com, linux-doc@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Document each netlink family
Message-ID: <20231120120706.40766380@kernel.org>
In-Reply-To: <ZVu5rq1SdloY41nH@gmail.com>
References: <20231113202936.242308-1-leitao@debian.org>
	<87y1ew6n4x.fsf@meer.lwn.net>
	<20231117163939.2de33e83@kernel.org>
	<ZVu5rq1SdloY41nH@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 11:55:26 -0800 Breno Leitao wrote:
> I am not planning to do it, since I would like to trust Make. Let me
> know if you think this is important and I can do it also.

Makefile is good enough for me.

> +$(YNL_INDEX): $(YNL_RST_FILES)
> +       $(YNL_TOOL) -x # Generate the index
> +
> +%.rst: $(YNL_YAMLS_FILES)
> +       $(YNL_TOOL) -i $(patsubst %.rst,%.yaml, $(@F)) # generate individual rst files

IDK what @F means, can the tool take one file at a time and then
we can make the rule a more usual:

%.rst: $(YNL_YAML_DIR)/%.yaml
	$(YNL_TOOL) -i $< -o $@

?

> +htmldocs: $(YNL_INDEX)
>         @$(srctree)/scripts/sphinx-pre-install --version-check
>         @+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))

