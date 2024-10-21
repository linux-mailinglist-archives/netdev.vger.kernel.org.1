Return-Path: <netdev+bounces-137591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766CB9A7162
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DB01C22C42
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE551F131F;
	Mon, 21 Oct 2024 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNwDAWvI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164741EB9EF
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533005; cv=none; b=bv6zBMuuwue1jiC/xcPtgzlQCS6yMuOQGT3hydwLchMAq8wnFNfCs5TWwTwv7Fc52/8YgiqKkrkuVlTtO7+KisJebaN5QSaUio9y70L/1yyRq97PDQNCVAgepvW009A0DSyMo2FDwOAtgzjVMeMOL6KwfhdvPys/AhqOOsoWLeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533005; c=relaxed/simple;
	bh=thWgYPLWsQ5uEt2CJgrMonCIUbTSN+6hJrm79KstynE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3syZlLBQpHkcVRxVpcJr6Std8flizn9CQlepNm8ZHOZf7DRnrcEWUjQ9oGAPc3GP24KJXlkrQpiO1fi6BoZ353+MKd/K4hcSp3jVSP6+J1nE3qOzFGxpgmhmsYibbwaHLQX368JRT4Zb7DgYE6kZrw28Nwg1mCvQnpGlcsmmHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNwDAWvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CC7C4CEC3;
	Mon, 21 Oct 2024 17:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729533004;
	bh=thWgYPLWsQ5uEt2CJgrMonCIUbTSN+6hJrm79KstynE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oNwDAWvIZfaV8epC0b6ACXfk4ZLnJdAPVCE2OYEevOgISXmzZ37BhQFW+6gNJpPcS
	 WB9dgBxdqqCHkj7zAJ8hSPaUU72P+hViRMgC5BHBwjaYNPtmjDTj6dJ7jO8LnM0j1d
	 G/niUc/vMhp+gNjJ1lbsKJt6eDRYUNfhz0bymgToXS3a8PefLbF5gbtxw55QnyVp66
	 TJCUbbqgPylHpR4xetLTrXLgzPKHau4ivDKcJHLUP/3XpQWVBFvXR4DtPfmYOXqtzf
	 HPLkqrM57/l77HVJNT2wOsdE0Auz+IqxIRYtqqdgGbIKmaCWdCKR7O2oiBfcuHWJev
	 fArkGxXp6Jq5w==
Message-ID: <f6e70c8d-b9d8-4d15-bb25-69fbec0d138a@kernel.org>
Date: Mon, 21 Oct 2024 11:50:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] tcp: add a common helper to debug the
 underlying issue
Content-Language: en-US
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241021155245.83122-1-kerneljasonxing@gmail.com>
 <20241021155245.83122-2-kerneljasonxing@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241021155245.83122-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 9:52 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Following the commit c8770db2d544 ("tcp: check skb is non-NULL
> in tcp_rto_delta_us()"), we decided to add a helper so that it's
> easier to get verbose warning on either cases.
> 
> Link: https://lore.kernel.org/all/5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com/
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> ---
> v2
> Link: https://lore.kernel.org/all/38811a75-ae98-48e7-96c0-bb1a39a0d722@kernel.org/
> 1. fix "break quoted strings at a space character" warning (David Ahern)
> ---
>  include/net/tcp.h | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



