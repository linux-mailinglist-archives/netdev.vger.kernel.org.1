Return-Path: <netdev+bounces-300678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MDCPDXoTNWq3mgYAu9opvQ
	(envelope-from <netdev+bounces-300678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 12:01:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 869FF6A5162
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 12:01:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=SUyQz4Nd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300678-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300678-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7F53309B551
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7DA369D5D;
	Fri, 19 Jun 2026 09:58:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D336897C
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:58:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863110; cv=none; b=T4W4Ib0rA9mZtsLH1l8VsQo1qL1fm1mYw51kiDz3yGV9cW6332BDsqFO/DoI5DkTW0GAUAUFBFgkBVZMYIQJub8BBODjyHTIg2myhgxPlOJNPveXTRbHG9HssRZBbNfBg78C3x1sPYzUwou5To0yUchDTz0lSnlF7G+6CLg3cGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863110; c=relaxed/simple;
	bh=BTt/K2JWfrQDdqzbvi++kEY8yewq0GPzCMMRQFavZqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVvHHh3yoQN9oHMJRSSA5vTuK4/YC1VDZ6kswSgN8RddCFfTgNuGLQIuPKRA2NSUNFP21eSUikO+zrMLDzahdxoAvO4u/PyM3umNjSaGEyyOCmBQkFO9mA6ZFDsm2wMtyF8YxQ6Fa2flPUpxNIFUucMs3SXWHImxyUsJt1txcUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=SUyQz4Nd; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ee449671fso154704f8f.2
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1781863104; x=1782467904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D4gSM3/604WX+8tErv38oK3fMXYCTdkycNGjiUgklF0=;
        b=SUyQz4NdYnefPpfsWep9vJXXFbIxeYhaR9KFMDlfZBAp8vumS2o4p+HlBko7gBJYyV
         KdX5+A7WdqTd10+rgP0khYt5xSqlX20gGe1ZZCfLaC9jyBNxM+R7E1PTAVGjbcucAxlU
         Ro7drepVmp6FjMASNn2hSOaaYOHxFYPJ0SJOIUoCsnS+SAwjl2cC8q2hPqW27LAfXigT
         T3epqE7efzCzkRE0PK5VYtCT+E2RX4LaUJYc+K2udfzcWc1jVEuIfMxxC8ZRz1q+R2zh
         Z4NpjM5ou+R3ORdkDzD2SvTZu7GA/5B5/O/fLFGyAc0kUl9NATSBj9jeFu4TbmTuK6U3
         6BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781863104; x=1782467904;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4gSM3/604WX+8tErv38oK3fMXYCTdkycNGjiUgklF0=;
        b=o05RtVg83Cwxj5qUPeoolhTakD3wE9QpE84INbD9bpic4cJK1oEpqzAI/opqJ0F7jm
         a2RyAWuXXno+ed8dhJM9q5b9t1k9lTflmy8JnQENdnV9PVsOtdJ4p0n+hoy1uVu1my8B
         c+/jHxEDLn6gj3/6DciLgEdwEboOeVO/JvQNjDLBNumWsOwI48jEBF6DWh2fruuNesGn
         aCdBfbNBznsrilz2aZR2MAJ5T4/3ZtZMUc2WkDAahUtHaghALWTZYijKC6iD3ULOK0Ba
         A9TbnrQz960vqSehFbvjqqgJLqRFP9PolcvXJUsE8BrKh5YjOt6H8hdPYhzLcHGt2vHI
         iESA==
X-Forwarded-Encrypted: i=1; AFNElJ9lGhEB8czcvD3yy28E/12FtJaYJGJVCbcfn61x06ByLddkp9VcnJX6mPzQdZSfrnt/IP9onCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpo6Cs9nIAfc0sy999S2TXSjg34Xq6iqZKfGPglbsbumjvLk/2
	6+f77OYEMqYGDViEaXIwbbg1gdCsGGChmsiSizpBYXLeKk5SdRS1F6keqvUMyWUeDFU=
X-Gm-Gg: AfdE7clQBmCrjZRmlnWfmz1U8RSdH+DPhMI0CTLVW9Fj1jEcPKvX7m6vGN3JE3iAbtg
	7f0XBTxTcE0YZTiDtC9PUYqUGXX1WSAM0E1yEJP8i7+h2dYb8+t/jXwmvxnlm0n+KVbn9f0QpTU
	MDM6Ho2ZTgCLEOf3s3BneztHZCnc4EYl3RgV0r1wscIxYgJgpFHXZxxl+WPX3+GVN2O+3Ig/4Qi
	Jcqtld3Zm8rHtIdkb+Xfa5+6uGevU/oq6rgOdAh90ujc2/cfd/22rZZqMYX0XS5tFQmRCaJtzef
	Qftyqlkg8yCJSJ9DMpYyN3RfyvfwHrlAwHBXubrnsagJ5n8UM8fGBVO6uHfH0NdoDhUosWYZsrh
	LOX6X7gDfnnCL9J9A0pv3pSMTJbTSdWQFVnvISqV6SjqbGLTUEsDh7tQTaYBeZzIaOJzCLtM6AZ
	8x5/3k8PyEt94TlkbjXMf1xDgoWLvC7y2vmCNwU6K9zxE8+rslzIS+OI41SmfNdPhCbQ==
X-Received: by 2002:a05:6000:1ace:b0:460:2db3:8cd8 with SMTP id ffacd0b85a97d-4650005cf49mr2383970f8f.2.1781863104526;
        Fri, 19 Jun 2026 02:58:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650bc429adsm6328086f8f.32.2026.06.19.02.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 02:58:24 -0700 (PDT)
Message-ID: <491465c3-0d1a-42f6-86fe-6c31812e23c9@6wind.com>
Date: Fri, 19 Jun 2026 11:58:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 5/6] ipv6: reset value and position for proxy_ndp
 sysctl restart
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: shemminger@vyatta.com, dforster@brocade.com, gospo@cumulusnetworks.com,
 ddutt@cumulusnetworks.com, brian.haley@hp.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org
References: <20260618162225.4588-1-fmancera@suse.de>
 <20260618162225.4588-6-fmancera@suse.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260618162225.4588-6-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300678-lists,netdev=lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:shemminger@vyatta.com,m:dforster@brocade.com,m:gospo@cumulusnetworks.com,m:ddutt@cumulusnetworks.com,m:brian.haley@hp.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[nicolas.dichtel.6wind.com:query timed out,netdev@vger.kernel.org:query timed out];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:dkim,6wind.com:replyto,6wind.com:mid,6wind.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 869FF6A5162

Le 18/06/2026 à 18:22, Fernando Fernandez Mancera a écrit :
> When handling proxy_ndp, if rtnl_net_trylock() fails, the operation is
> retried but as the value was already modified by the initial
> proc_dointvec() call, the restarted syscall will read the newly modified
> value as the 'old' state.
> 
> Fix this by restoring the original value and position pointer before
> restarting the syscall.
Is it not better to call rtnl_net_trylock() at the beginning of the function?
It avoids flapping the sysctl value.

> 
> Fixes: c92d5491a6d9 ("netconf: add support for IPv6 proxy_ndp")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  net/ipv6/addrconf.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 8ff015975e27..1cfb223476bd 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -6483,8 +6483,9 @@ static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
>  		void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	int *valp = ctl->data;
> -	int ret;
> +	loff_t pos = *ppos;
>  	int old, new;
> +	int ret;
>  
>  	old = *valp;
>  	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
> @@ -6493,8 +6494,12 @@ static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
>  	if (write && old != new) {
>  		struct net *net = ctl->extra2;
>  
> -		if (!rtnl_net_trylock(net))
> +		if (!rtnl_net_trylock(net)) {
> +			/* Restore the original values before restarting */
> +			*valp = old;
> +			*ppos = pos;
>  			return restart_syscall();
> +		}
>  
>  		if (valp == &net->ipv6.devconf_dflt->proxy_ndp) {
>  			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,


