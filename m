Return-Path: <netdev+bounces-155698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56590A0358E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49F31880964
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BDF74059;
	Tue,  7 Jan 2025 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8574t/r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853126ADD;
	Tue,  7 Jan 2025 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218496; cv=none; b=FyoilQwBZA6Nl5ncM4VtrWabjeI7tVIiVuurnzNn9ybhAk8L/VFVrr4ZHvlMvFsoPaZZ/D//4doppTnTT3vK+3TBGwWx4PqjVgVmbPNuPxKPvBAu+uzZHZyPob8XXNtk//hRZnJ51ZalLi5ugwrwOcb2Tz8Dq02weLTR+DdylHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218496; c=relaxed/simple;
	bh=9KNumHpxv/QVbO/R83t4SdtQ0IaqfHQouJQh6DkzEEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=As2PySTa1LOVN4AoFjWiVEOIXTkqH1BGsBV6QOtXsbP1EoexRyEbl5Gk5hOt4hy0NlbuszGf7nte160dMaRTw64XrLIQtd4Cf1W2UMtWlepo1BNMTcP1DQ1dvbu7ExrSHfAJi7WV+0kkzEQ4rVo8QeTBaQ5aqz6ULhTiRjpxLV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8574t/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6DFC4CED2;
	Tue,  7 Jan 2025 02:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736218496;
	bh=9KNumHpxv/QVbO/R83t4SdtQ0IaqfHQouJQh6DkzEEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A8574t/r9dBNEn0i1ml2t+0khfC6uQbLu0R2yQilGNQwInbGNwrAzrdLeCwzJNaiF
	 KO/iEOYp/2GaYLrVU0q6cEA923iujnaj7IWXSz2DJTTv/0DwEQO1DBCtEcTxYwIS0H
	 f4F/MTz4Oex/4XXwYOEjFvUnLGNbbWdaJWlT67REBAIN9cKOy1S0ARITB0AlNpe+bG
	 /Xd++vF4jhL+6YTX266BsJwMzGdCwyhOVysFP6obk0EECPHx3bVXB7lRqRWjusNv4d
	 6H/Lp4EwG7XwUEI65cDOkZULpioHjVC9o9QxsjhQJg/q6UYaQVYkg9/RRo4H8zJ92z
	 z5INXWEWhh4Kw==
Date: Mon, 6 Jan 2025 18:54:54 -0800
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
 daniel.zahka@gmail.com, Andy Gospodarek <gospo@broadcom.com>
Subject: Re: [PATCH net-next v7 07/10] bnxt_en: add support for
 tcp-data-split ethtool command
Message-ID: <20250106185454.537cd59a@kernel.org>
In-Reply-To: <20250103150325.926031-8-ap420073@gmail.com>
References: <20250103150325.926031-1-ap420073@gmail.com>
	<20250103150325.926031-8-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jan 2025 15:03:22 +0000 Taehee Yoo wrote:
> NICs that uses bnxt_en driver supports tcp-data-split feature by the
> name of HDS(header-data-split).
> But there is no implementation for the HDS to enable by ethtool.
> Only getting the current HDS status is implemented and The HDS is just
> automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled.
> The hds_threshold follows rx-copybreak value. and it was unchangeable.
> 
> This implements `ethtool -G <interface name> tcp-data-split <value>`
> command option.
> The value can be <on> and <auto>.
> The value is <auto> and one of LRO/GRO/JUMBO is enabled, HDS is
> automatically enabled and all LRO/GRO/JUMBO are disabled, HDS is
> automatically disabled.
> 
> HDS feature relies on the aggregation ring.
> So, if HDS is enabled, the bnxt_en driver initializes the aggregation ring.
> This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.

Acked-by: Jakub Kicinski <kuba@kernel.org>

