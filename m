Return-Path: <netdev+bounces-155700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C723A035A6
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 04:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F86F3A3009
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392C3198A0D;
	Tue,  7 Jan 2025 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuDUutOe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BE8185E7F;
	Tue,  7 Jan 2025 03:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218875; cv=none; b=edKcgag8K8nnxCSYQ4hbg6XT9AJhCRzlyNfkcqBVCLLfzTojAbnpNUI+sfUwpl6IMe9G2yS8tl75pUq/M5Ivwl1RM0lUq9uq3XR9DPU2Y5hiXARiGmsvFL2rqo99/6KSZkBkfc2g8qCb3au0IaUuWjIBGIAGOKstkWwUIT3GOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218875; c=relaxed/simple;
	bh=bkdVbJTRTnAfgz0I8G4ZJ/DMBB1QEIYgr08jODOzGMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFoz5tGpxLcm35BNsKSFIbs7sgo26eMHDLL60Kl91LLjdLaekDgo1dZrJOgA8US0gVxP9kQNEFhOio0q9Q3Cz1d4Tfh4E6gk6xluXNf8NXNeLFe1puV0EdrxZp/bO/Hm49UrLfuK0kqjTIxpJIYjzqf0OafAYho0tr9uLKCxMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuDUutOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E474C4CED2;
	Tue,  7 Jan 2025 03:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736218874;
	bh=bkdVbJTRTnAfgz0I8G4ZJ/DMBB1QEIYgr08jODOzGMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BuDUutOe+5K7V9/hpIPDg1a/kf4/R8l/5eR0SeHiinLkrlUANj8WhfwmgRChlpsDp
	 9IS+ueRV9QZpXFwbAB4nicLZOHEpEVqle6bbfeuY42nIL4yyS/hQrtbWLK6Y0VdBKY
	 Jx8GyKW8pGS+DLCCfT14KSVIQaRbP48n3W2ActDSTe/Z3AWwqsEYoz6Dj5zIinzK2v
	 3SKIzI1R6pDTN0y1ShqRKSCnVt5RtemhNBs2CWWyo41uCfczHbSV2TnKssfPN9t6KV
	 RG0CFQYVQAa2aVf+/eQK7g6gu645fBBmmWy9WDyCdIHo2IDD5bHFk9MXVbk/nzBjiN
	 9qLE+wUTYnZ6A==
Date: Mon, 6 Jan 2025 19:01:12 -0800
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
Subject: Re: [PATCH net-next v7 10/10] selftest: net-drv: hds: add test for
 HDS feature
Message-ID: <20250106190112.6ae27767@kernel.org>
In-Reply-To: <20250103150325.926031-11-ap420073@gmail.com>
References: <20250103150325.926031-1-ap420073@gmail.com>
	<20250103150325.926031-11-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jan 2025 15:03:25 +0000 Taehee Yoo wrote:
> +    try:
> +        netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'hds-thresh': hds_gt})
> +    except NlError as e:
> +        if e.error == errno.EOPNOTSUPP:
> +            raise KsftSkipEx("ring-set not supported by the device")
> +        ksft_eq(e.error, errno.EINVAL)
> +    else:
> +        raise KsftFailEx("exceeded hds-thresh should be failed")

Nice work on the tests! FWIW you could use ksft_raises(NlError) here,
but this works too. You can leave it as is if you prefer.

