Return-Path: <netdev+bounces-169909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC5A46684
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE8519C4419
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED321885B;
	Wed, 26 Feb 2025 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAcyqrHx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063444A32
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585972; cv=none; b=Wyn3ILMzb5/ihO38LBhTlGpqGS8gYtwAbhG+pa+pcGELTpwNYqj8DfSi201tRn06qmBg3euvmO78EiHkPOgkWdZ/umOi5WLVan8K7E2xm4sa7qtCqfGN44eN6mOzPGCx3QYrY7tJ3k7TJmQYS9ckcxOKdNNvzBrGNreHER/kf/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585972; c=relaxed/simple;
	bh=cTuIOhtjPEQgLhjl1tnvNS4Pdf98+E0hUj6iMccOpBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRLBKzuvslaghm+mlryRtuobI2TiZr+ekQxEbOjZgugtNbea90nkBmDxyXITxvNVqbpqS3QDCZHYJCSNy/vzCQqDAQT3SGRZwic6GBxybm5X57FnuVgFjSJnbDPdQVtcdtRHkXtGz1FhNqsO5WcEcWSrPVfqPg1LEC5aSE5XPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAcyqrHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6248CC4CED6;
	Wed, 26 Feb 2025 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740585971;
	bh=cTuIOhtjPEQgLhjl1tnvNS4Pdf98+E0hUj6iMccOpBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gAcyqrHx+aG8uEGmEbb/r9BCDWVHMll8V8D8MZ1MttCI/d6JMp6HyBampCTBrqqZG
	 m+IBYmRSdMMMiGxdvnEwqnVj9Kb6MrVnEU48ElDNv+i0/uZoBoOlrK47Y03t2I0Oj3
	 iDTq71IOm9nb88FoqtkS6IycgiYuArO4d030mQa3rb7ONN9c+qr65FQpRckeDbbhPc
	 3rHe3Wo9aHsI9vGZYTSrFncH88SJt7AShpmUJLAfbUoJhb/2Bvc31hbCPy3NAZylAQ
	 8Q4O6SnoNuRV7Zdbgz3IhG7fLbeIE0Q2M2NTk8trMaRfMOCvXuUznhXV3AeHq9grrK
	 C1x/3D6SxV6yw==
Message-ID: <a9473fc0-d721-466e-b70c-8e9010c5c541@kernel.org>
Date: Wed, 26 Feb 2025 09:06:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 v3] tc: Fix rounding in tc_calc_xmittime and
 tc_calc_xmitsize.
Content-Language: en-US
To: Jonathan Lennox <jonathan.lennox@8x8.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
References: <5b9f16c1-450c-4a39-be2c-634b4f1864b5@kernel.org>
 <952BE2E8-CE07-4D82-A47D-D181C229720A@8x8.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <952BE2E8-CE07-4D82-A47D-D181C229720A@8x8.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 11:42 AM, Jonathan Lennox wrote:
> diff --git a/tc/tc_core.c b/tc/tc_core.c
> index 37547e9b..32fd094f 100644
> --- a/tc/tc_core.c
> +++ b/tc/tc_core.c
> @@ -23,12 +23,12 @@
> static double tick_in_usec = 1;
> static double clock_factor = 1;
> 
> -static unsigned int tc_core_time2tick(unsigned int time)
> +static double tc_core_time2tick(double time)
> {
> 	return time * tick_in_usec;
> }
> 
> -unsigned int tc_core_tick2time(unsigned int tick)
> +double tc_core_tick2time(double tick)
> {
> 	return tick / tick_in_usec;
> }
> @@ -45,7 +45,7 @@ unsigned int tc_core_ktime2time(unsigned int ktime)
> 
> unsigned int tc_calc_xmittime(__u64 rate, unsigned int size)
> {
> -	return tc_core_time2tick(TIME_UNITS_PER_SEC*((double)size/(double)rate));
> +	return ceil(tc_core_time2tick(TIME_UNITS_PER_SEC*((double)size/(double)rate)));
> }
> 
> unsigned int tc_calc_xmitsize(__u64 rate, unsigned int ticks)
> diff --git a/tc/tc_core.h b/tc/tc_core.h
> index 7a986ac2..c0fb7481 100644
> --- a/tc/tc_core.h
> +++ b/tc/tc_core.h
> @@ -12,7 +12,7 @@ enum link_layer {
> };
> 
> 
> -unsigned tc_core_tick2time(unsigned tick);
> +double tc_core_tick2time(double tick);
> unsigned tc_core_time2ktime(unsigned time);
> unsigned tc_core_ktime2time(unsigned ktime);
> unsigned tc_calc_xmittime(__u64 rate, unsigned size);


git am (and patch for that matter) is not liking your patch. Please make
sure the patch is against iproute2-next and top of tree.

You should also try sending the patch to yourself, saving to a file and
applying using `git am`.

