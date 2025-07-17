Return-Path: <netdev+bounces-207654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC6FB08135
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 02:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7411E581458
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93D12E36FE;
	Thu, 17 Jul 2025 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVrPAsXY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF4635
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752710534; cv=none; b=pDI8mi8gg+xctgMRK7rSfcV0nIEzjXm9vEMn8jH0J8RH/oAWaVZMOBMpz7SIdsaNxRb6L4H+4817u3fX5nWp8yKmRIY4qkPnnuclnohqOSLUpwSjMvfbjPB6Y5BvcuhUdMv1h13yNd4iJpN8ztlBDxx1NCJFUyo4QlxY9lyy0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752710534; c=relaxed/simple;
	bh=p+3AANXMY7wqTjJz7QYMobewTSSlUKwfh/NZ8L25YDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5frsXsEzcv8pqHTNphS7as/DDRLm5iWJrwqJbWpe61q/YBDL/eVOIf5gq+CYhzid4pNFJTwm2IPyjHX1fQKgS/ocnzJ5+8bVseyCeF8JUqvyQ5h06a8uduX11dhMvsVpXttGu5w1CZIvPLoYxVUrzc/LueQdHoIZ3Aw/ZHKqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVrPAsXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5888C4CEE7;
	Thu, 17 Jul 2025 00:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752710534;
	bh=p+3AANXMY7wqTjJz7QYMobewTSSlUKwfh/NZ8L25YDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NVrPAsXY/9L06fR2aRcHoG1EtDvBJQzA1ZJpkkpfRYhVSKhSvcH0SPhCL/mfzyerM
	 68hfJ/Xpejjs3Vzhno4B/E+vF2dqx/10uj8vAHDJQ0Fq6gS6dTu6hnK5ZXpyctF3y8
	 RQSQ0Q8iLMoUMmtBXgnQZyCU0DoJ5LVSXkyjJZVX3flDzz8JsO6nPbS8KhU5HLCF3L
	 27dj5yUe5Db+ga2+Zrc2/uqlBhmbKlFm5sScGtdQ8HuEPiKvqEAmsmjS0Tm8T7agsf
	 ODi/7ZAsuwb1bzJW9IIMYK1tgy0607OiAmUSD+DB1+oRa4wObTDCEsU6/bqqy/9BWa
	 xbcWcosCaiGgQ==
Date: Wed, 16 Jul 2025 17:02:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>, <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH net-next v2] amd-xgbe: add hardware PTP timestamping
 support
Message-ID: <20250716170212.2a2cde21@kernel.org>
In-Reply-To: <20250714065811.464645-1-Raju.Rangoju@amd.com>
References: <20250714065811.464645-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 12:28:11 +0530 Raju Rangoju wrote:
>  	/* For Timestamp config */
> -	int (*config_tstamp)(struct xgbe_prv_data *, unsigned int);
> -	void (*update_tstamp_addend)(struct xgbe_prv_data *, unsigned int);
> -	void (*set_tstamp_time)(struct xgbe_prv_data *, unsigned int sec,
> +	void (*init_ptp)(struct xgbe_prv_data *pdata);
> +	void (*config_tstamp)(struct xgbe_prv_data *pdata,
> +			      unsigned int mac_tscr);
> +	void (*update_tstamp_addend)(struct xgbe_prv_data *pdata,
> +				     unsigned int addend);
> +	void (*set_tstamp_time)(struct xgbe_prv_data *pdata, unsigned int sec,
>  				unsigned int nsec);
> +	void (*update_tstamp_time)(struct xgbe_prv_data *pdata,
> +				   unsigned int sec,
> +				   unsigned int nsec);
>  	u64 (*get_tstamp_time)(struct xgbe_prv_data *);
>  	u64 (*get_tx_tstamp)(struct xgbe_prv_data *);

Please start with removing this abstraction / callbacks instead of
starting to used them. They each seem to have only one function
assigned, and there isn't even a null check before calling.
They make the code harder to follow and review.

The removal should be a separate patch for ease of review.
-- 
pw-bot: cr

