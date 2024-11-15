Return-Path: <netdev+bounces-145371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 395359CF4B1
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF4C1F20F64
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AA61E1C04;
	Fri, 15 Nov 2024 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmwYxz//"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E301D5146;
	Fri, 15 Nov 2024 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731698332; cv=none; b=Tw2gQwgv5gVgstUTT7qnb/ud9a9/U9bfKgo1pq7VMZviPDJN1UJTs8VmFv6zgq8rE0wTekca5ZE+lAfHk0THfwWRDfSlruaFngRVwQ1oz9M2FvMKngUa9Cf8+WJmKDyfblnO8VXE5yKwYdk1ENOGg8vs2dvyONRil8mIZ5WOjaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731698332; c=relaxed/simple;
	bh=J3xrabR3RS0j1r9Vs9v/kbGeuVBoZ/qXH30Zse/SkjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGTwaR3kOhSE/fblMl8uaoMpQcYAzxey3CAyOgjSqUuloDoqWivOtp73LzEgqsfFMJFoW9G0rY0AvGN1xRUKZilH8Ze6DF98pFaTklkC4FAm2c/TVsjrDQSlO+z6qh7L4e4Lq+5JdraNpAE8kmhJBEHrlFs0BBqFVdlwj3paBL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmwYxz//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5C8C4CECF;
	Fri, 15 Nov 2024 19:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731698332;
	bh=J3xrabR3RS0j1r9Vs9v/kbGeuVBoZ/qXH30Zse/SkjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DmwYxz//wbIBKpfCTqE8BcdTrG6vJNyguHhQplj7JUNN03a3pW2bGbSLGbnuoXMlV
	 6dJ30RhErQTXsrXQgdehB7oNr2RagpM88MVFASfQ2/rIx4bTTCcl6rChHKg10Ob7/w
	 q0LIACMn3qKxuDxFbbxwBy5ENxGfLDb6dh8OlkeIjqVVlODwbOp/2LV3WHpU2avKQ0
	 clb+WIA/YYNnhkWZ6XS0w4yAabo/07xQ8uZ/AndNQ2a/R9KbBHQIzeCbr377JOehB4
	 w/nh3DzdBQnMuDh4MGJUmDRiiq98E05iilyPpbPFZDWWm4cBy9YB4hc3jq/dPWH+y1
	 T5ffKQkJVH8xA==
Date: Fri, 15 Nov 2024 11:18:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v5 4/7] net: ethtool: add support for
 configuring header-data-split-thresh
Message-ID: <20241115111850.4069fdb7@kernel.org>
In-Reply-To: <CAMArcTUfGp0SEm=w3dg=GHd52w4zw2kG7mGLsaP4b9NjTYMTrw@mail.gmail.com>
References: <20241113173222.372128-1-ap420073@gmail.com>
	<20241113173222.372128-5-ap420073@gmail.com>
	<20241114202409.3f4f2611@kernel.org>
	<CAMArcTUfGp0SEm=w3dg=GHd52w4zw2kG7mGLsaP4b9NjTYMTrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Nov 2024 03:05:33 +0900 Taehee Yoo wrote:
> > nit: s/_HEADER_DATA_SPLIT_/_HDS_/ ;)
> >
> > We can explain in the text that HDS stands for header data split.
> > Let's not bloat the code with 40+ character names...  
> 
> I'm not familiar with the ynl, but I think there are some dependencies
> between Documentation/netlink/spec/ethtool.yaml.
> Because It seems to generate ethtool-user.c code automatically based
> on ethtool.yaml spec. I think If we change this name to HDS, it need to
> change ethtool spec form "header-data-split-thresh" to "hds-thresh" too.
> 
> However, I agree with changing ethtool option name from
> "header-data-split-thresh" to "hds-thresh". So, If I understand correctly,
> what about changing ethtool option name from "header-data-split-thresh"
> to "hds-thresh"?

Correct. And yes, you'll need to change in both places the spec and the
header. FWIW Stanislav is working on auto-generating the ethtool header
from the YAML spec, hopefully that will avoid having to change both
places long term.

