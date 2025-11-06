Return-Path: <netdev+bounces-236124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 756CCC38B12
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1593A4049
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E0C219A7D;
	Thu,  6 Nov 2025 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV/zUKgb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0100214813
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392085; cv=none; b=Yzlw1FCOk3/xczgOLNGhR8z7dqsf4adr1agWb8RtU8jwdNq+i5IFFl4EDsP81fgbDt/Ni1Z23P2FD/A5wOsLuZeClGvT/9zuRnz7sRq5cMMA/URovhUgRt2PVwC35FlLjnZojK6NXNhDX7WMzVKhaaP4l5HX0UqhCZ00usn5HJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392085; c=relaxed/simple;
	bh=Zb4qG+DH2+6VaVA10nYzqnAn+yyysR0Y5SrxNNAe3hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEFk90JV1Cju/gGUp79QQwTPbcV+dqNU5/27Eagw+AnC4S0MZyoDNYDp6RiMtLeq9bUxvtyhfLd9T1+5ZinvGiV/tCdLe9R5QeehevnvJHzFGWLq/YpVTLDRu1s15iNz/Ux6wWOWkUyaXtzRnp30ab+CUtgqz2jm78U+qnYCz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV/zUKgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D95C4CEF5;
	Thu,  6 Nov 2025 01:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762392084;
	bh=Zb4qG+DH2+6VaVA10nYzqnAn+yyysR0Y5SrxNNAe3hQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VV/zUKgb1HcsKOAk2et5rGcze2Bgn7Ckrqwz72nWvaxTvaM4udRy2d89cWqxeljLO
	 GgY0OPRNarGl3+nx4EPnv/tt7TpRX2Bf9UdUE6UwdYMKlbFgP0UAuKHLqt43abmtBj
	 dXi7j1jrxDzjRQDbpMDGWOEESoYukHUIa+a8MHRymekO7OBt2pmLrm0HR2qKaUN+AK
	 Vov1ipun5NnqhpIIy+4qEyRS8NvLVl6LRkoYCafBS1tU32xs9SABPRFgQFMfzB1KKl
	 nLeEWAHcrmxzfqm5J57E+6UOXVYEV3hsBrzHtcnFrdefKkMRoz/SG3LKpTtlmRaMgz
	 UA1FXnjEl7S5Q==
Date: Wed, 5 Nov 2025 17:21:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Manish Chopra <manishc@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>, Jacob
 Keller <jacob.e.keller@intel.com>, Kory Maincent
 <kory.maincent@bootlin.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] qede: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251105172123.60cfe775@kernel.org>
In-Reply-To: <20251105185133.3542054-3-vadim.fedorenko@linux.dev>
References: <20251105185133.3542054-1-vadim.fedorenko@linux.dev>
	<20251105185133.3542054-3-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Nov 2025 18:51:33 +0000 Vadim Fedorenko wrote:
> The driver implemented SIOCSHWTSTAMP ioctl cmd only, but it stores
> configuration in private structure, so it can be reported back to users.
> Implement both ndo_hwtstamp_set and ndo_hwtstamp_set callbacks.
> ndo_hwtstamp_set implements a check of unsupported 1-step timestamping
> and qede_ptp_cfg_filters() becomes void as it cannot fail anymore.

drivers/net/ethernet/qlogic/qede/qede_ptp.c:289:6: warning: unused variable 'rc' [-Wunused-variable]
  289 |         int rc;
      |             ^~

Please consider:
https://github.com/linux-netdev/nipa?tab=readme-ov-file#running-locally
-- 
pw-bot: cr

