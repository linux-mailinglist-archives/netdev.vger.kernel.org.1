Return-Path: <netdev+bounces-119530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D284956150
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 05:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A32A1C20434
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 03:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAA913957C;
	Mon, 19 Aug 2024 03:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO3/Tsm7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338971CA8D
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724036750; cv=none; b=RLj/qOJ2B1A6kccWuO/mmDPTzJGX0LxVscSfp9Z/pJbgVVjoZkAG/LxCbMCZJ5Il7HT2nqHVN7L60uWPY/fLAO/3R8/VFCWieoEPA5CmEj4DVqlA/N2+C2WQOKfG6mzx5C5G0X8CyVfB2tcIoGawsqEEaZaIPLclIvOAEsMs8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724036750; c=relaxed/simple;
	bh=Eq4vg0kpD8fcaroH3dr2NWbyB0m3YzIAyrdBQNK2iwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk9IPlAW5J/TgVue99btgAsNq9ki4H33EsTZCxNBsqsfulp1v1JyKOQuDBdHkhJ8gkfjnmGVqwfqAImBKz4o+PSfzWjDkb0BTsggron8clJ38bfTW0Isvcj1cvykj1iJ9M37wWXBKhSdoklAg1UIc4TeyWgLWDqRKT/mzRC8EbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO3/Tsm7; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6bce380eb96so2226717a12.0
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 20:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724036748; x=1724641548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDgMlQm7Fka4Y/yYFPLcGdREJsNSkZkWIcL3XqNMU0c=;
        b=HO3/Tsm7s97xOoO9ftyg0iUARItcRcMyJYwSgZreBY99+OeQ1Dodzi/FG7+7hA9HDG
         ZRZ8zOclN6IhjBMkGso4pGvCntNbCUsayO5dVOJbchzu27tNXhV0exkYXYo87WOoJj7v
         znxFNeUvc3FNeMimFJlRTJzniSqP01CrBnYZKJRvNPNLkp4N6UtYKmO/SPsq6NgjwXbg
         7HWv5+N+rW2eo5A+EIlanTnJ8Y/7vbInFfUkcmBwJodZp+vPTmxArfKH8xqrPAZnwoL5
         asF/+io22UIj26LlzMoXmZk0xTfyjKzD1bneZnbtRO7lkfG4jlH99J1B2T997qoem+9i
         YxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724036748; x=1724641548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDgMlQm7Fka4Y/yYFPLcGdREJsNSkZkWIcL3XqNMU0c=;
        b=FMelKEwV5/XF+2u+s2EG7SgsOkuviB6xlaPHvMZLP4Tdrkg44icx8BRwT3cGYtfdMT
         NgY3DSQ3vT8P4wqf5Mc2BFVdtI+ZYaCkRk0XPxi/QiAWWU9hqy3DCTSaAns4xZO4FkMq
         U4BwpUDCLPF4DdiHzFK3DWtQo/gGA2LcGUDcOmPBnwyWOSzzfNC0CwAd+ayudwf/exvW
         J/UAOQ8SLnpa+c2JSZbuM/S1+dwrtpe9JX97m4NGpYtL/TaevCn3ZV7+OL4KVv2jqxZ9
         VD332ysL9Ee/nSCfmw0tx1XCrpZ8+Kk/1diAzlqTRWtBwyBxTVdT9XtgVH9sDErM4S4m
         Nyjw==
X-Gm-Message-State: AOJu0YypH2e1taVaOhRbCKsElr84XaUzpoqmss0ZI2cQx39p/OGureYj
	fQc4O6ZX8bbrV/1P6Fhnc9LlRcsG9cpAxYZtDFmyMhQ90mc5yANa
X-Google-Smtp-Source: AGHT+IHLHtrb+SSl94Q33E6yD3CpA6v86SGvorAMWMdgSg1NwsuP11w85lkgsbiCOq4Y9Nt0GT5jRw==
X-Received: by 2002:a17:90b:1086:b0:2cd:4100:ef17 with SMTP id 98e67ed59e1d1-2d3dfff6674mr8175098a91.31.1724036748215;
        Sun, 18 Aug 2024 20:05:48 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c74f3fsm6135567a91.46.2024.08.18.20.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 20:05:47 -0700 (PDT)
Date: Mon, 19 Aug 2024 11:05:41 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net, jv@jvosburgh.net, andy@greyhouse.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jarod@redhat.com
Subject: Re: [PATCH net 4/4] bonding: fix xfrm state handling when clearing
 active slave
Message-ID: <ZsK2hY8w6zP8ejUY@Laptop-X1>
References: <20240816114813.326645-1-razor@blackwall.org>
 <20240816114813.326645-5-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816114813.326645-5-razor@blackwall.org>

On Fri, Aug 16, 2024 at 02:48:13PM +0300, Nikolay Aleksandrov wrote:
> If the active slave is cleared manually the xfrm state is not flushed.
> This leads to xfrm add/del imbalance and adding the same state multiple
> times. For example when the device cannot handle anymore states we get:
>  [ 1169.884811] bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
> because it's filled with the same state after multiple active slave
> clearings. This change also has a few nice side effects: user-space
> gets a notification for the change, the old device gets its mac address
> and promisc/mcast adjusted properly.
> 
> Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
> Please review this one more carefully. I plan to add a selftest with
> netdevsim for this as well.
> 
>  drivers/net/bonding/bond_options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index bc80fb6397dc..95d59a18c022 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -936,7 +936,7 @@ static int bond_option_active_slave_set(struct bonding *bond,
>  	/* check to see if we are clearing active */
>  	if (!slave_dev) {
>  		netdev_dbg(bond->dev, "Clearing current active slave\n");
> -		RCU_INIT_POINTER(bond->curr_active_slave, NULL);
> +		bond_change_active_slave(bond, NULL);

The good part of this is we can do bond_ipsec_del_sa_all and
bond_ipsec_add_sa_all. I'm not sure if we should do promisc/mcast adjustment
when set active_slave to null.

Jay should know better.

Thanks
Hangbin
>  		bond_select_active_slave(bond);
>  	} else {
>  		struct slave *old_active = rtnl_dereference(bond->curr_active_slave);
> -- 
> 2.44.0
> 

