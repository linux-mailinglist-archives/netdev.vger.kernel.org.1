Return-Path: <netdev+bounces-155687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A25A03576
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E433A68DD
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9522613B5AE;
	Tue,  7 Jan 2025 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIP/vzoE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1533086;
	Tue,  7 Jan 2025 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218230; cv=none; b=YVsNzPgNP1+0kIJ5T9UElvjxhtRcGLKM+RKsIOthCZYR9p+l8mHtgIrBPu385I9dLXuAVnGo5poISBLtcijQA5WPDXiH7eEYtiPClB9j5MwmZC5o8bnzuf/ZCB8yMAj2ql3Nyq+TDB4srqgxhdrTiZvIUbA3MnR02FKwhpUa6iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218230; c=relaxed/simple;
	bh=56CVjBvjx6FP5/HNpzGbBM3HRk3zUM6Fh7oD1qCe6wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUKTfvPXEOtvkhynmJ6EJmw677JGh1R3Pzfh12SuM7PjDLyjS1SNUfR10azK1Qfnzx+1sSKnNXIJK7t8YA25uTPBJdUH/qCoPcRC0akIedAbfPzMoCIfio0D6lH83JNcSaR02v8NyCeEZZPerfI+NKnr74AOdodVdvtuGY5UDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIP/vzoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B97C4CED2;
	Tue,  7 Jan 2025 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736218227;
	bh=56CVjBvjx6FP5/HNpzGbBM3HRk3zUM6Fh7oD1qCe6wQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fIP/vzoEWhq4m3C3TK3X5Hj9FLNK2AJ56YtTGABRpMBRmPchiQDC8eueCb+qVpO0m
	 oH1rgn21ZKFA4sNbujogdsgiXNasm8qolqC2q9RnODbWgmUnVFNqQLZWJcRBaMbTmC
	 4PA8MkeUAJEK79rPvmejMU89lf/vZCqQ+7cwRo3bXEV3PHI0+qspcRwDRfALDwVTKr
	 fREIwwZNZXbDw4PYPRwexmwU4V7LhYFpcaZgh9CauZ6y/5Gft1XQDx1sgx8x35ZVoi
	 dHw58I2o3fmxALLyY+WGbsu6QVTy5r04tfLqQhWDrz+JdYL20Eg+9GZzEdHGoqz1G3
	 2KoD3jv2t4TPg==
Date: Mon, 6 Jan 2025 18:50:26 -0800
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
Subject: Re: [PATCH net-next v7 04/10] net: ethtool: add ring parameter
 filtering
Message-ID: <20250106185026.6ecdea0e@kernel.org>
In-Reply-To: <20250103150325.926031-5-ap420073@gmail.com>
References: <20250103150325.926031-1-ap420073@gmail.com>
	<20250103150325.926031-5-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jan 2025 15:03:19 +0000 Taehee Yoo wrote:
> While the devmem is running, the tcp-data-split and
> hds-thresh configuration should not be changed.
> If user tries to change tcp-data-split and threshold value while the
> devmem is running, it fails and shows extack message.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

