Return-Path: <netdev+bounces-223296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7AFB58A7B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2426D169563
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F43C186E40;
	Tue, 16 Sep 2025 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTNmXHCY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11084E07
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984495; cv=none; b=fspgqNuagY14o2rjhhSg5ClSHF6YhIc1b4OU0ygwe1AVy1o44OWtFYxv+VZMXoyGGI7o8/tbrqnt64adIyz0qeYxRCowJ5eikLBfpEPa91YgyZ/HCtloAkeEAFYeDu/uerCVwROa3RP/YGN5H1RnnpRMuBIbo2Agr9VcYDMzbF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984495; c=relaxed/simple;
	bh=wKrQfWtd1tZ0qs+AjJ1pBwafLoTFRq+T98zZFLasgcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRw7T8l1u1EouYsXLjut3dsKqdG5qBqJgpU3cSySeq+XTvlnzumMoQz6BIINi30WQuFUedaDan7ffP28oj1IAVVSJLnZol7624GxCeDvTvDuWqpuygXJcKRU2wTta2IAZtorsakrURp8xzH1mK6IcbwLTvQYy+KQnNHg1TbGC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTNmXHCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1CAC4CEF1;
	Tue, 16 Sep 2025 01:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984494;
	bh=wKrQfWtd1tZ0qs+AjJ1pBwafLoTFRq+T98zZFLasgcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GTNmXHCY8qY8FhVPgIja8JH5xC4y641+xFbT7AVWiZE7j+DfX+6Aj3cDEXQ/Y5w8C
	 2q6bXQbi0+zkB5Obfqd4gaFCqVLIgnk4nDOAjehaS9I87Z7gQognrV5IdA8V696u3N
	 UsY15CtFsuj26RcloaARRDG4xBI1ByeKvaOAl7XQU/wkhA//xE8QXt1YFel2sNpKVC
	 xmLGusRAHIbDemQHdD+PrdHbg0r7G3fl2OfC2ePYT6fzTZtDlZB8BnU0VvsSOXsvxL
	 5O1AVk9P661WfiXDeAYUETEswQy2S25PtWF9kq9ThpcWrAJYW85DDAAytQKJbQEElW
	 ntudvvIyfuUDA==
Date: Mon, 15 Sep 2025 18:01:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v4 1/2] net: libwx: support multiple RSS for
 every pool
Message-ID: <20250915180133.2af67344@kernel.org>
In-Reply-To: <20250912062357.30748-2-jiawenwu@trustnetic.com>
References: <20250912062357.30748-1-jiawenwu@trustnetic.com>
	<20250912062357.30748-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 14:23:56 +0800 Jiawen Wu wrote:
> Subject: [PATCH net-next v4 1/2] net: libwx: support multiple RSS for every pool

"support multiple RSS" needs an object. Multiple RSS keys? Multiple
contexts? Multiple tables?

> -static void wx_store_reta(struct wx *wx)
> +u32 wx_rss_indir_tbl_entries(struct wx *wx)
>  {
> +	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
> +		return 64;
> +	else
> +		return 128;
> +}

Is WX_FLAG_SRIOV_ENABLED set only when VFs are created?
What if the user set a table with 128 entries?
The RSS table can't shrink once intentionally set to a specific size.

> +void wx_store_reta(struct wx *wx)
> +{
> +	u32 reta_entries = wx_rss_indir_tbl_entries(wx);
>  	u8 *indir_tbl = wx->rss_indir_tbl;
>  	u32 reta = 0;
>  	u32 i;
> @@ -2007,36 +2016,55 @@ static void wx_store_reta(struct wx *wx)
>  	/* Fill out the redirection table as follows:
>  	 *  - 8 bit wide entries containing 4 bit RSS index
>  	 */
> -	for (i = 0; i < WX_MAX_RETA_ENTRIES; i++) {
> +	for (i = 0; i < reta_entries; i++) {
>  		reta |= indir_tbl[i] << (i & 0x3) * 8;
>  		if ((i & 3) == 3) {
> -			wr32(wx, WX_RDB_RSSTBL(i >> 2), reta);
> +			if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
> +			    test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags))
> +				wr32(wx, WX_RDB_VMRSSTBL(i >> 2, wx->num_vfs), reta);

Do we need to reprogram the RSS when number of VFs change, now?

> +			else
> +				wr32(wx, WX_RDB_RSSTBL(i >> 2), reta);
>  			reta = 0;
>  		}
>  	}
>  }
>  
> +void wx_store_rsskey(struct wx *wx)
> +{
> +	u32 random_key_size = WX_RSS_KEY_SIZE / 4;

They key is just initialized to a random value, it doesn't have to be
random. Just "key_size" is better.

> +	u32 i;
> +
> +	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
> +	    test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
> +		for (i = 0; i < random_key_size; i++)
> +			wr32(wx, WX_RDB_VMRSSRK(i, wx->num_vfs),
> +			     *(wx->rss_key + i));

Prefer normal array indexing:

			     wx->rss_key[i]

> +	} else {
> +		for (i = 0; i < random_key_size; i++)
> +			wr32(wx, WX_RDB_RSSRK(i), wx->rss_key[i]);
> +	}
> +}

> -	u32 rss_field = 0;

completely unclear to me why moving rss_field to struct wx is part of
this patch. It looks unrelated / prep for the next patch. 
-- 
pw-bot: cr

