Return-Path: <netdev+bounces-236938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A796C42546
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 03:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27E61893301
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 03:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD562C21C1;
	Sat,  8 Nov 2025 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF0eJ3cj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D0EBA34;
	Sat,  8 Nov 2025 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570779; cv=none; b=rz8ORmYsYeX02OMYboBqQkCWjxn/hfSBHOpKipSEQya6P29pKUclIQb8lQi9SWbc9XA0CRjOMUkWMPfqyKP9RkUJFRGLVhuPpjs4eGyxop+GzNaHrHGvZ54IDXNN31BDwEr2z1CaXS6Ik/JxiTEn7av9SY6P2QGVzpd4HPo0/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570779; c=relaxed/simple;
	bh=r0V8RunR0rphJHRhau+kMyV3SG5U13zHxEWpzPFnguI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd7y0jmA5w7BU5++q7KCXn0gTlxHvfNFO9pMBTmnyzaww16K8j81rY6N/84AsmcX2E0a1ZsyobsDa/Co3/hWOaUkWTDvS47AjeS2OWRl8mhSmELutLtWAAOx0o57g1XMnG7XRg173IIT899uS5Y1BObOoabHR+/mWQtkzSO162g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF0eJ3cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED21C4CEF5;
	Sat,  8 Nov 2025 02:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762570779;
	bh=r0V8RunR0rphJHRhau+kMyV3SG5U13zHxEWpzPFnguI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZF0eJ3cj5NC2kZBVIPr713n7H9kzbW4y9Ka8Sa+JQ+QABIi52szMU/l8BrK03RRc6
	 hJzIR01dKp5+WBw6iNaz3XbRPj3sa5Hf227+T/Sp2wSMbPvUHLeYzTxMe7GiyiJ/rZ
	 b1AweB1VxNWR9xYCSxFP9eZuLMuBWaJw49LaHOeOyPKzdKolWtq1WGCbwOcnsHDedP
	 l5NGqoo5b1LcyMQa9HgmI1iForVC1bh1oHsba6tcbSiSi4So5sa2XHeIDYOq1JR/Gh
	 eVcObMGxy+TsE7/gbSRR2A/Gy+nutdwjYKnzdErOfD5gxaXtKCiviNezQMSfEVemlf
	 1EUvAmoQdpPWA==
Date: Fri, 7 Nov 2025 18:59:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 eric@nelint.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: fec: correct rx_bytes statistic for the case
 SHIFT16 is set
Message-ID: <20251107185937.0cbaf200@kernel.org>
In-Reply-To: <20251106021421.2096585-1-wei.fang@nxp.com>
References: <20251106021421.2096585-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Nov 2025 10:14:21 +0800 Wei Fang wrote:
>  		ndev->stats.rx_bytes += pkt_len;
> +		if (fep->quirks & FEC_QUIRK_HAS_RACC)
> +			ndev->stats.rx_bytes -= 2;

Orthogonal to this patch, but why not:

	ndev->stats.rx_bytes += pkt_len - sub_len;

? Is this driver intentionally counting FCS as bytes?

