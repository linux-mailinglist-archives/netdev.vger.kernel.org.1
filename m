Return-Path: <netdev+bounces-83883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77823894AAD
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 06:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320FF281D45
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 04:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A006D17C72;
	Tue,  2 Apr 2024 04:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECYEgUpR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B231F9DF
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 04:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033647; cv=none; b=iuwOlErQrjCjxImWVdOoVTCPEStXu9/RYeoX3Eoi1K3nvDCmPPSuT9ccCsWB+kw4S6lrot67yEtX1lKmCpfZ0dtsSGB5EzoU/qIygveXhcC8Syq8JDU0wBjaHa3t2vs98qdor4eM3G1yKtDEIGRndysRqXSnZ3rA+8B5AUcmxbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033647; c=relaxed/simple;
	bh=2f81g5IaGBxBQJWOwYHAYs+10AhgnN5h6Wg8GE0zg9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9A2LdboLbyc6ebzH0hMZqs3DBmviHv7zHYGX5fXzrY/3HKCmIoXPubJ1ZfgrHhhQJmMvPDg2DGpWnRFdvUXPOfqxeQl+FpPRBk4/tocU8Z/JSBhgHXUqA2p/EuDbT+CjUW8gj7WV5m844QLY/q6znH06bRDQRmcPj52BW8fLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECYEgUpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DBEC433F1;
	Tue,  2 Apr 2024 04:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712033647;
	bh=2f81g5IaGBxBQJWOwYHAYs+10AhgnN5h6Wg8GE0zg9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ECYEgUpRjcXVzemUs6ETgu3V7s5yEF4qfN3ULgu59R0MD0lFmTncqqSrQEHLoSCl3
	 uBqN2eD/GfXj3XY3M4dVx+BxFrKauzh1shwZumhhXb8Mq9NMp+d3WtrpwVg/S3HMa+
	 opYVh+R6ON1qHSrb7NVJP1u7uZ6/4bhmOO+UUAczS0DX/63mTXNDQ/KRNAHGTxB30E
	 49fjZfZ0eWUneDYxPZNygYnkZm/XeG2dS926H36NF9zK5IOtss/rlLF3rjam+5lJTH
	 C0s1bqflHVjpp8xCSS0pTRAUVttRI1YTB7eThTTek4HdTmIfTc1Z2qrcv3DP5aPdpQ
	 rGkLraohv2+rg==
Date: Mon, 1 Apr 2024 21:54:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
 gospo@broadcom.com, netdev@vger.kernel.org, pabeni@redhat.com, Sreekanth
 Reddy <sreekanth.reddy@broadcom.com>, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next 7/7] bnxt_en: Add warning message about
 disallowed speed change
Message-ID: <20240401215405.12ecd5e2@kernel.org>
In-Reply-To: <20240401035730.306790-8-pavan.chebbi@broadcom.com>
References: <20240401035730.306790-1-pavan.chebbi@broadcom.com>
	<20240401035730.306790-8-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Mar 2024 20:57:30 -0700 Pavan Chebbi wrote:
> +		netdev_warn(bp->dev,
> +			    "Speed change not supported with dual rate transceivers on this board\n"
> +			    );

closing bracket goes on the end of the previous line

