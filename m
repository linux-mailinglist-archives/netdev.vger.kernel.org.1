Return-Path: <netdev+bounces-145177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA799CD633
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 05:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0FD280D14
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2DE156C6C;
	Fri, 15 Nov 2024 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4Wv7gk/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CE22C80;
	Fri, 15 Nov 2024 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731644652; cv=none; b=lNBXqCSRPTX3QA5AXtl/zTYkQSBFXsV/SW5IZei+EUZJ9llJFUwYkT5mkZfm0aN0rtBY2CGV7BNETE/wheNzfMlXj+9LcECVzE2MFmfuj3pTDkH4AmF4GKVbyr94V67WfcWSZFK+SEAKwb5FpSkorxvyemShSGjOxgNCs5Ujt3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731644652; c=relaxed/simple;
	bh=EV1uDgz3X6IOxMC9T0IZTe2MrjSKylAEE990foBREqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBzfV/R3xfnSaC1IeqBuiyzvt7NcFKpgmc6O0HFk5co9DO2kRt70M4piaaH/zMN82GcIR044d/ad2y6ov2lnAcflKv+yg+qdNg0+henO1GTEObLcGf4Uly3REhRPlsuCz4U0gzyvcGlILgZb+uhouhalLe8mX2uslb7kUZPjSr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4Wv7gk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3B5C4CECF;
	Fri, 15 Nov 2024 04:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731644652;
	bh=EV1uDgz3X6IOxMC9T0IZTe2MrjSKylAEE990foBREqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r4Wv7gk/c9HX0KCH7XNf4e9bx198RMPhyxZTUZRQMRc6tF0zfqqSYxZ1gey6eQxyd
	 Mhc7ymlPK7RuW6pPEeTDTvmekOlAdbRmbYQok6rM71e1wJuwTbu3Kl2o0t0gNcWj2L
	 g3lWbtz5koRDX+jextp1Y3MNC6QsKhZpw4GHtu6SCXpUwyfoKdKETwEbBmtW5PwZRU
	 mGOAbQHLmC1XTGt/9p2zzfffx4RlkpfQcutegPNamJrh6dXBvBjxh3LPnt4nXtBRc6
	 KkUPcbQ8hFXQRakuxbxa5DX/Y4QrrLYFYpSg12dWozBJHMCUHj8hK8hqgXjcuIJP6w
	 /6P/ugwP4wzzQ==
Date: Thu, 14 Nov 2024 20:24:09 -0800
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
Message-ID: <20241114202409.3f4f2611@kernel.org>
In-Reply-To: <20241113173222.372128-5-ap420073@gmail.com>
References: <20241113173222.372128-1-ap420073@gmail.com>
	<20241113173222.372128-5-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 17:32:18 +0000 Taehee Yoo wrote:
> +  ``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH``      u32     threshold of
> +                                                            header / data split
> +  ``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_MAX``  u32     max threshold of

nit: s/_HEADER_DATA_SPLIT_/_HDS_/ ;)

We can explain in the text that HDS stands for header data split.
Let's not bloat the code with 40+ character names...

