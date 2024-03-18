Return-Path: <netdev+bounces-80296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E8187E305
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 06:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA3FAB215E4
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 05:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2BC20B22;
	Mon, 18 Mar 2024 05:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrEZC+pM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F820B0F
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 05:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739428; cv=none; b=glElXEoSOJzXYTsM1ycUVejnoQwSYNOrpjhRV8TQUpYDtM3z0JhdIv+Gct1qQPzcD8/Dq7Yx0oc4nave9d/zjIBS9uXfB2uM+PcxZ9CrFjLRc0nUfsb8xMo8Epj4lphumUUGWVuvY2hOn3Gq0spIOONBB+KnDrHVxAJYntT6SXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739428; c=relaxed/simple;
	bh=fkJ5bVXJrdRgREISya4JRVFjMcBxv8rTnqxXqzynJkk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gdYwy4l5WosG412XL3hJBE+TRZkGhiVzC+YT69F5OZwg6aBTvwCb4G5rutId4Ne/KEtZ8O6Z8fguwToDVm3XtFo0RfGkT61VN5R/FcusPgVXinbQ0diA/NP5E29fI77/DxcTtZrqjjjiEF4k9MdTF+XP+fp61SYocvRjNpxdQbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrEZC+pM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710739425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqIJDJckAru/XBURT2OqghgjmKd3WFeh5L4nLJzVtKI=;
	b=RrEZC+pMH0UihUJ0C5CYKjlM+ZYKpd+8IhEKKfVV8bJauyY8SoT0dnsqNGON5MYuYB4Xfv
	E2ahCecP5WJxxa9EMkQoJI3NzxldmBzYflbub20AVUW4b99EgTYQEBlt3ZohUzcgJ6JSsL
	hSOHSdHie7qfeLh2qOhvDUPoynHJYSk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-yaGfzIp-MLSq5CDZXTlY0g-1; Mon, 18 Mar 2024 01:23:41 -0400
X-MC-Unique: yaGfzIp-MLSq5CDZXTlY0g-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e01e8875b9so5699705ad.1
        for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 22:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710739421; x=1711344221;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HqIJDJckAru/XBURT2OqghgjmKd3WFeh5L4nLJzVtKI=;
        b=ah6P30n2SEUv3k7EF53s8WwIHRcfxGjizlh67JD6mqJfSo3lkcu9lRDpPQ309MkXjb
         GqocwRHcV6/253KKaxpU/Z/Ijpsy3O93mJYwS7Efk8EDZHllzktxC/AGnJ7uj8aJgK2H
         VufbOan/xvq8MPtcNjZHuXjE7pppa/YXTbMpDzdzyG5K9vBqJVHN6niqolIkjC8z/aAv
         EmzR4hppIzF/u65SPRSsQc4ylP8CrvzzX/mhyM2CCh+rjItfrw1D/UiS50saiC/AzCOb
         Ztlar/JvkifqTgkhlYAkwf4yhas8U3MdBLsuVPJH5NzW9DLBzZNbR+t2NnuEhnh9V56z
         RODg==
X-Gm-Message-State: AOJu0Yxo+4e94huE5RbHjE+PtbMyc6eW06h7VaBHJrFB3l7Dkr+ly517
	/uIkJ7i5oU1BQ2HeBtPR8EAWEQHNj00r8LEnGTIYzG5jTQNCU3OlZmCfI8urwpX9okAI6On4Rus
	INWWNk2hoSQOHv9PhNSIe/wy3JP1dNH+u5YYQk25uc+JNET0Z8x1mNg==
X-Received: by 2002:a17:903:40cf:b0:1de:f18c:cdd with SMTP id t15-20020a17090340cf00b001def18c0cddmr8918893pld.3.1710739420759;
        Sun, 17 Mar 2024 22:23:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2rrwCO0SvKT3PGemUlC2F54cUiFbxicnli6xRKj7SDczUPT+holSwqiGXXUR1uvaRfG2w3Q==
X-Received: by 2002:a17:903:40cf:b0:1de:f18c:cdd with SMTP id t15-20020a17090340cf00b001def18c0cddmr8918882pld.3.1710739420438;
        Sun, 17 Mar 2024 22:23:40 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:7d25:e853:5f28:2681])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001ddc83fda95sm3642886plg.186.2024.03.17.22.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 22:23:40 -0700 (PDT)
Date: Mon, 18 Mar 2024 14:23:34 +0900 (JST)
Message-Id: <20240318.142334.2245574100586239129.syoshida@redhat.com>
To: fmaurer@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, leitao@debian.org, dkirjanov@suse.de
Subject: Re: [PATCH net v2] hsr: Handle failures in module init
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <3ce097c15e3f7ace98fc7fd9bcbf299f092e63d1.1710504184.git.fmaurer@redhat.com>
References: <3ce097c15e3f7ace98fc7fd9bcbf299f092e63d1.1710504184.git.fmaurer@redhat.com>
X-Mailer: Mew version 6.9 on Emacs 29.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 15 Mar 2024 13:04:52 +0100, Felix Maurer wrote:
> A failure during registration of the netdev notifier was not handled at
> all. A failure during netlink initialization did not unregister the netdev
> notifier.
> 
> Handle failures of netdev notifier registration and netlink initialization.
> Both functions should only return negative values on failure and thereby
> lead to the hsr module not being loaded.
> 
> Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>

The patch LGTM. Module initialization errors are handled
correctly. Netdev notifier is correctly unregistered when netlink
initialization fails.

Reviewed-by: Shigeru Yoshida <syoshida@redhat.com>

> ---
>  net/hsr/hsr_main.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
> index cb83c8feb746..9756e657bab9 100644
> --- a/net/hsr/hsr_main.c
> +++ b/net/hsr/hsr_main.c
> @@ -148,14 +148,21 @@ static struct notifier_block hsr_nb = {
>  
>  static int __init hsr_init(void)
>  {
> -	int res;
> +	int err;
>  
>  	BUILD_BUG_ON(sizeof(struct hsr_tag) != HSR_HLEN);
>  
> -	register_netdevice_notifier(&hsr_nb);
> -	res = hsr_netlink_init();
> +	err = register_netdevice_notifier(&hsr_nb);
> +	if (err)
> +		return err;
> +
> +	err = hsr_netlink_init();
> +	if (err) {
> +		unregister_netdevice_notifier(&hsr_nb);
> +		return err;
> +	}
>  
> -	return res;
> +	return 0;
>  }
>  
>  static void __exit hsr_exit(void)
> -- 
> 2.44.0
> 
> 


