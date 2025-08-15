Return-Path: <netdev+bounces-214147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520FEB285B6
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8903B601EB
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918FE2F9C5B;
	Fri, 15 Aug 2025 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSiRkUW/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D96B218EB1
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281936; cv=none; b=peKCfB6RCqKPELFomYEzrMhxIZwfZpxFBATrSFVIXWNu7qqMJ250pmfWjUH7QZWTKtj1mUyR4k51QdaeLfla+6xWINdJMJSDbE03Qhv3ixmCEAvCRhx5/BGobpYyKycnKT/+pbNY8UW10A2Gg3iGqug+bKPuZ4i77rWEf7u0xOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281936; c=relaxed/simple;
	bh=ujkalNO0fo39nSMHUUcBvgj5Nx1Sb2W1Thd/WbcLpZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzuyPxEtgR2ZSGJj+eTXSQb5Cq3DCaPXT30/JqHdzb7BhWj+5wjldUlyWYznq6TBlNmz7fthYFckwzb2iGapbzYuK29+tzYHhl7hK+7xjmL7vqX0oHwmStynWMq+K9m1EdY+9qsBsHqwDK+a6dJdLj1Q+Hgv9UMc/lH1jUIZQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSiRkUW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AFAC4CEF5;
	Fri, 15 Aug 2025 18:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755281935;
	bh=ujkalNO0fo39nSMHUUcBvgj5Nx1Sb2W1Thd/WbcLpZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uSiRkUW/jvZoNxzdsUEjP6VB92gKfU9NJ+KtvFFXwvFfhVIQBiuxHvgpCK0de2LtT
	 494+Sx+NNSTlPOuop35WO9LkQv4hQaG4ikkGORyfstM6Y15BeUTgUczDgl5/V91nCg
	 uSNqQj00/upBYricEpAnPnmOgppGd3rai6/1h1NsSlfUavIXPr6KGyy35/hTmCUVge
	 An+vx9qJ5FxEUyKBCjHrIAfftW8qBY+jipQm9BKUtF8OitInBbbuGl4JCzmQRrDRN1
	 J4rMr4lIKWXLGTv5fc5UMD42BNHhBQ4kbGjofL976Wez16IySBrw5+SRoBMn7r2n4M
	 W0/X1RUK6GNlw==
Date: Fri, 15 Aug 2025 11:18:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v4 4/4] net: wangxun: support to use adaptive
 RX/TX coalescing
Message-ID: <20250815111854.170fea68@kernel.org>
In-Reply-To: <20250812015023.12876-5-jiawenwu@trustnetic.com>
References: <20250812015023.12876-1-jiawenwu@trustnetic.com>
	<20250812015023.12876-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 09:50:23 +0800 Jiawen Wu wrote:
> @@ -878,6 +909,8 @@ static int wx_poll(struct napi_struct *napi, int budget)
>  
>  	/* all work done, exit the polling mode */
>  	if (likely(napi_complete_done(napi, work_done))) {
> +		if (wx->adaptive_itr)
> +			wx_update_dim_sample(q_vector);

this is racy, napi is considered released after napi_complete_done()
returns. So napi_disable() can succeed right after that point...

> @@ -1611,6 +1708,8 @@ void wx_napi_disable_all(struct wx *wx)
>  	for (q_idx = 0; q_idx < wx->num_q_vectors; q_idx++) {
>  		q_vector = wx->q_vector[q_idx];
>  		napi_disable(&q_vector->napi);
> +		cancel_work_sync(&q_vector->rx.dim.work);
> +		cancel_work_sync(&q_vector->tx.dim.work);

so you may end up with the DIM work scheduled after the device is
stopped.
-- 
pw-bot: cr

