Return-Path: <netdev+bounces-206041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB071B011EF
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 06:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32FBC17ECDE
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 04:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CB08F7D;
	Fri, 11 Jul 2025 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="sXc00bXc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B37179A7
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 04:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206855; cv=none; b=U99hXRlt4n0Z/D+SzycNyXNAdiskMGeI9yvxPtvotJzJplf/n2LTFOnOQL7IDnYC05CsswPvVsF5M3voIGze6WSOGfgRT0R/ZPDU+PiENqVozQGz0UQlM4eixNgkP1NuTJII8yyDTeCFkFyG75tFQLl2+2ri64id3iAKLLBI7HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206855; c=relaxed/simple;
	bh=j5AsxP9ygZ+4fLvkZ8fLF8g1ByH0EVRv6XFYqy13y9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2nQnT1K1DZ5/agdDm4vItUBOt7oJ+d3UnTbPtSddO+pkH3St+fKnie/tVQI5p6jqfCf+IBMtlJ1XB0BIYEZUa+J6QhIb/p47V0PPtF0Mi3vECNVyo0FfHMbxgF3n22poKUfhRHbkH04x/17hlY/50nPX/dp2/OUa56IQ81B8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=sXc00bXc; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d9eac11358so179596885a.3
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752206853; x=1752811653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozI0Im86wAHsju6y0mF3RNQgE8ARNsXr6q3IFbk6UJ4=;
        b=sXc00bXcfY//854jxpkgbeajZbi/4pJxuXVtTx/S8LQqvfCJ0U0W4P2ZATrRyyj9Pr
         ZwQNnbzEJ2oLMAgTPrR4yOW0WlaGXqLhnelZ42mOP8PQIaxhxjPcgatGj+2Si6eKxcYr
         4HgC5SnuXYfMC6fx/le02PODrjm4HWI06CKe9ciemBaRuV92Ge8/OAmnNeqUPWUVV7v5
         vD/eZb84OYw9NkCObB2JAMtQRYOFIqwwnM3O5I7KUxMR/RfFJuFG87IVpOB4V5itG2IV
         Ikjjwod1duvI8dncTCPk7SVYRRpx43m5feJtseMPCFvhOFiR9pP40jL9Hz3K/avkcawh
         SyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752206853; x=1752811653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozI0Im86wAHsju6y0mF3RNQgE8ARNsXr6q3IFbk6UJ4=;
        b=c1yvuTFkjqfLfvjLH8+wnHB7FfxlQRcsKZz67SNz62Dn6uXBMMArphux1yi/K5dvWV
         9w053pQPH8XkGTLGDIJY+yg5R9BK6OgHpZvbYyZewH1x1ShuHLwgyjS/TmoyceNt3kDA
         aE2GQ+KqTkFNDltkWrp/KAU5jgmnxjNWqcuiCslK83Kt59BKBswr8o25L0+GxZJWqz79
         PhHa2Xk75qUJFcyK8gD4XA4HEL+7JWq6x5SD9miKfCqJaDIQwlxPPujHvD38iAoacwYw
         17WbronK4ufV9cRdju5TMdXz/175N3j53fU5pN9DSC5BNb97qFX0cOe739j1VN5ychP1
         lFLQ==
X-Gm-Message-State: AOJu0Yx8JuZaX0Glyyy4gmY3sXaefnw0npMyiRQF36oPM5qZpyOqBMe5
	posd0SQP41n7p077f8Iol3LjyOs7gCR4QcFhGqvN/81n9AhQyk6wG6NWENzN2ma5CMk=
X-Gm-Gg: ASbGncvN9cmJcV1PJxre5KNyLe2PVt4SrW4/OZcQxENaA259rQ7/0kVgZrVGu1TW+ia
	uyPrNTC8SH1QJVYcUaL5utRH2UDx5VP7et6fa8xlPzYc/wbel3quzCkTZfXgqs1yXpWTLFW1NW2
	SiYr/JpgqbyOwV03v29BpMi7s/S0JFMc9EZ//oZNW25G9VxUimonRQB8Xu+tQQ1o4+Pgp8bdYSV
	ZvwHcJas8hLHky7aEgq8FCiy73S06qc5/pArbfEUs8wPaiqwWR/udfHdIo3Obo9hTD9jivoSbqC
	mGaiUzJuT5IArI7bdX4cLRabG5pt0Q2rUFCFZU29QeqtvWXoj1iKT3GjRFS+Rtl0BY1DuMBozje
	L8cWXE+A+/QNoBy5FwFqQo+QoVpsgnp1k1H9Ar/bJ4eJgKgw0H7G59URp1NEcR5jOMGinPYgIKP
	1XOnx4NH8/MA==
X-Google-Smtp-Source: AGHT+IFg+opR7QKrPek/aiw2KMWIeqj6WMrtKH54JNMGj4ISErFzTHBHopOhx9PIfMQ8GfRP14PjZg==
X-Received: by 2002:a05:6214:21e1:b0:6fd:ace:4cf8 with SMTP id 6a1803df08f44-704a39721a0mr25881386d6.30.1752206852620;
        Thu, 10 Jul 2025 21:07:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e3146sm15991256d6.41.2025.07.10.21.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 21:07:32 -0700 (PDT)
Date: Thu, 10 Jul 2025 21:07:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Li Tian <litian@redhat.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2] hv_netvsc: Add IFF_NO_ADDRCONF to VF priv_flags
 before
Message-ID: <20250710210729.36231c98@hermes.local>
In-Reply-To: <20250711034021.11668-1-litian@redhat.com>
References: <20250710024603.10162-1-litian@redhat.com>
	<20250711034021.11668-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 11:39:58 +0800
Li Tian <litian@redhat.com> wrote:

> Add an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.
> 
> Commit 8a321cf7becc6c065ae595b837b826a2a81036b9
> ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
> 
> This new flag change was not made to hv_netvsc resulting in the VF being
> assinged an IPv6.
> 
> Suggested-by: Cathy Avery <cavery@redhat.com>
> 
> Signed-off-by: Li Tian <litian@redhat.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index c41a025c66f0..8be9bce66a4e 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2317,8 +2317,11 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
>  	if (!ndev)
>  		return NOTIFY_DONE;
>  
> -	/* set slave flag before open to prevent IPv6 addrconf */
> +	/* Set slave flag and no addrconf flag before open
> +	 * to prevent IPv6 addrconf.
> +	 */
>  	vf_netdev->flags |= IFF_SLAVE;
> +	vf_netdev->priv_flags |= IFF_NO_ADDRCONF;
>  	return NOTIFY_DONE;
>  }
>  


Thanks this worked originally but got broken, please add:

Fixes: 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
Cc: lucien.xin@gmail.com

Looks like team and failover have the same problem.

