Return-Path: <netdev+bounces-96200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37C28C4A21
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D435C1C20C80
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4E182488;
	Mon, 13 May 2024 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcrFw7oC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6F1D559
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715643525; cv=none; b=h64P89V6nBSvKRC90XR9nHzJYV/DPqbBo6DKkGpVAwiY7GESjy0d8r7bwyvHE1WPcctZOJOnW08L9U7JlGxRKhoYWgI8zj+aNEpHaxW2X+GzasFUjnOTQM5+TCWQO7lnNcahuR+cOMhmxAtq3LYn+xoypvZPj6vHU35PE1f6FXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715643525; c=relaxed/simple;
	bh=N0onKzk9vxiH3LWDCbUxd7eqoNDM23RUelEZ/NvMBCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTrc3v5heczxzFvKGQpYyu21aBGw3cML9cfJdNIKj7QLG2XF9/NTcbk470ukMF2U+N6Ho1NXVN2Boh9kB0H0flt0ulPy/VQNNwTwpmz25U1LX2lmku0MdsWtfzSH0Yvx71deztNYLy8uZqqn59nRIGuJnPsDw+w7AYAVSWlbiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcrFw7oC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52E3C113CC;
	Mon, 13 May 2024 23:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715643525;
	bh=N0onKzk9vxiH3LWDCbUxd7eqoNDM23RUelEZ/NvMBCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HcrFw7oCf4UKhCdhJgzb0mPVCo1wIzxQHZcVd3Pe/GOL/A1nCTh23Xp+QUOP0xh/R
	 xSXfIctIeAqfc4rPy8d9Adn6AhY7RfMFYCk+fVBue1D0HRIRSiqxWN3+t5yeyvnlby
	 EloBkaEKuObzfFHrLH0dCLGx1m2utxOZkWA8z1VpmD3cG8xtI2xaJtgpJushq3N8ss
	 zlzJowi4yuC5N6CCZqGXfqkUjZbZVPSJRtDzHxA80Kwizn8oRaqidnGz6swEL/bf8x
	 V22QsPvX55WFwzNbbgPr73FTvNU3NXcxz9HyLeCKfyVZitEtDuDSb/6d7tNVpl2YIp
	 sLCnXxC8dAZJw==
Date: Mon, 13 May 2024 16:38:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin =?UTF-8?B?RsOkY2tuaXR6?= <faecknitz@hotsplots.de>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mhi: set skb mac header before entering RX
 path
Message-ID: <20240513163844.402a926d@kernel.org>
In-Reply-To: <20240513133830.26285-1-faecknitz@hotsplots.de>
References: <20240513133830.26285-1-faecknitz@hotsplots.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 May 2024 15:38:30 +0200 Martin F=C3=A4cknitz wrote:
> skb->mac_header must be set before passing the skb to the network stack,
> because skb->mac_len is calculated from skb->mac_header in
> __netif_receive_skb_core.
>=20
> Some network stack components, like xfrm, are using skb->mac_len to
> check for an existing MAC header, which doesn't exist in this case. This
> leads to memory corruption.

Could you add a Fixes tag identifying the commit where the buggy code
was added? And please make sure to CC the relevant maintainers (I mean
the maintainers of the MHI code, specifically) on v2.
--=20
pw-bot: cr

