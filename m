Return-Path: <netdev+bounces-133116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3232994ECC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50F31C210CC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C191DF96E;
	Tue,  8 Oct 2024 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD1qYShi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94341DF732;
	Tue,  8 Oct 2024 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393663; cv=none; b=dzRVz+XHPPaoK0XCTBVF+ZKJ3XYU19/x17EGYfOlw7sZqpQaEoChzErAXSpwEYg9To01e9nF4WSU+KaGwnk5LFbH/QiXxQGXiM0Rd+PJNqEOd7PwMi4epTzsxFxNaqEPfDwNKz6lywsJATuRLAhybG1Y0IoHq9s8G/bvsH5ZID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393663; c=relaxed/simple;
	bh=oBG1k3U9mJCgilqEugPuk5SlXey/aKBhuR6cvQk1sgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI5vomrlAfMME6V5zFb1yuDqvsjsvCz5aebaBwLQ/DhYcT/fm5L8qKTia9rwjKUHl7dRWDN0fSx50gayNC86S4g5x6YcZXvKUlEs+Q3+9EUkst8HNplbeUwplCaW83SVrSVXpGvrAR90aUpimzJiyLKGqT//sz67jiEZErsLyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD1qYShi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04759C4CECE;
	Tue,  8 Oct 2024 13:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728393663;
	bh=oBG1k3U9mJCgilqEugPuk5SlXey/aKBhuR6cvQk1sgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bD1qYShid/ppRc18Gs/DYX2cJDKDFc+Of5QeXTcYdj17nmVy5rulX0e/Niq6ZYMeK
	 yiCRdaY8K/O8wLVVmOQ8qQfdKxvrhSCHRUpqc2dlIWv4ZgwW6cHdFrOwLlNIGzihMt
	 Z2BPX4wa4bTz8R9pXfz8/Y0xST70ZrM4Mape0t3tRqpZD41bbvB+gdPgMcKMzfyk+E
	 N+Qetu+iVsrG59z5rqyRObaRWRFO4CYdFgAPI9CuVPRyD9l0VBmfBeAbjmDFDFc0pS
	 /rlQdDC56IHUJFnROdOhe43bnXugjpq1taxKSA6Y9OlJH1DqDVRpVzfaFLpOgyqiM0
	 JR+czfEqHIZyA==
Date: Tue, 8 Oct 2024 14:20:58 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 6/6] octeontx2-pf: handle otx2_mbox_get_rsp errors
 in otx2_dcbnl.c
Message-ID: <20241008132058.GP32733@kernel.org>
References: <20241006164703.2177-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006164703.2177-1-kdipendra88@gmail.com>

On Sun, Oct 06, 2024 at 04:47:02PM +0000, Dipendra Khadka wrote:
> Add error pointer check after calling otx2_mbox_get_rsp().
> 
> Fixes: 8e675581("octeontx2-pf: PFC config support with DCBx")

nit: there should be a space before '(', and 12 characters of hash.

Fixes: 8e67558177f8 ("octeontx2-pf: PFC config support with DCBx")

> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

...

