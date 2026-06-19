Return-Path: <netdev+bounces-300709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X9xBMEg+NWo9pwYAu9opvQ
	(envelope-from <netdev+bounces-300709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:04:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 188686A5ED0
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:04:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=Dzhb3Z5k;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300709-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300709-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA7B03014DBE
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C4B3839B9;
	Fri, 19 Jun 2026 13:04:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987037E316
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 13:04:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874245; cv=none; b=MBNUuKCUohFcwfGT5fPNWti0dxO/YvL9Qx+CVFR6SmchX3L2q4ifItrY5k1D/rRucWZV8KywZZz8vtt272OoPZ07gkRddXPjo9kvYt+KOs3LCAV/tARXEtDsYPxYdZ0zD255RY14mf5cZdu28yUCoVf9qJ98u7FkpthBpbjUwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874245; c=relaxed/simple;
	bh=ZBpbbsWUFlyvu7VP+YrZv4wJ8Vf5XVvvTY6/lGa61Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfie8Mg681b4/gsGv6R4roj2nu4yc+QAoNJrhNKAXgK9uI5MorqcmrNXnUfoviCuNBfhhflWaRXDdRYmuE5kzB0S1y10Krr1igSNoS/7U5ZAeqLH7FTdypGB4geewbocn1ccJnrs9O8Z4XiXSTUu2jVqnY+gn11NZYb2CN/lylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Dzhb3Z5k; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b1df16acso1798245e9.3
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1781874242; x=1782479042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VDxXrwPz6AmvaNhK8pjhvQJCVmDB3Bue1bOTEogDoeM=;
        b=Dzhb3Z5kkMinDPMysobpjM6cTohyOKgPlw7sUKmPaiEIC0WJnQxJK5cLLkyxqEOvbZ
         CRxEQvF+UXBZ/RyBHVekZTLuzLlFoSWHtF7a3D3gZS6CS+VUnHja40enZEoTqwoxIDkn
         pw4witEj2SKkrl2RwJwjJ2x0W12T3nP424wC5XyWxMl4AZvprXQM2LTQG1nWhIP9gMP6
         PqfBwaUMnoYfkiuJj/qZ0PzsKGG/5D6t6nYC5wERsRzGT4ZvSe4GdIeFm3XCMO6k/Mez
         twv75wfJngrs246sAX1pfrDSL/0lrLKavH66An98vH9nvwAee6TcbqBPSFwUj+ediCfw
         feig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874242; x=1782479042;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDxXrwPz6AmvaNhK8pjhvQJCVmDB3Bue1bOTEogDoeM=;
        b=RuMzeaBYQl765HW7NP80qdP6yMAlJSp4uTc0EXByX1t4atoFaPcbMSW+QE3o3NE0mm
         +lsmWERr+M2f6HEsM8ZGkvkDHznTW2L4QXJlcE7C4QquOiWtr006yDQGnPohJJtWTHwn
         tvw3sebyH2wR5Rx7YqFH+ZtJ08Ni4rQfayqnSPV2pz0PzoFw1fsOOiytaOm3vmRB+xmO
         6VG/mJucambDiKeeLNYtHKuLtO1ZtTaS6FttUQvsRexl18W4UuVImnCF/EIOc1u6f7np
         cvITr42Pfzw+epcp5QIVmJbGBRh99UQ1IDgkW8K2w536H92KXGj3iIP48BuPA/Z5otp5
         bgMg==
X-Forwarded-Encrypted: i=1; AFNElJ84eqeqGnmPJY69m8TW1SZKeL7CYym+wo+FS12SwMm8ubKGFgrWRHnRstfKbYXww9K4yb/Qh6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YweHAwCrroipzUIEcYLU5UCw2INk/QXnZDJJOCkQUSan/oV+qjT
	Z2qSRoQwZbMpgd4H2YbT2m1mBOE4Voxx31mG8GIElJJ808Ilk7nFdESUwMsJO1UgOBE=
X-Gm-Gg: AfdE7cnaa/kYBz3vZHFzNKTlo8U39yXto8smnqgeV++ebkdqrauYuxfTujPKZ2ShtI6
	pouXh923BUj/CfE9m7ps3mbcNvImJLu4+EisNo2vViHafliKyRoUOKqECQ76Na074a8w9Sqx5A5
	cmxM3f+hoKbAYL+aa8JOfOz/wvfOH+p5zk3iuBx3ONdVs3kH/12C3YuvwQW/ZELiBFC7JdTJG9O
	w4pfLiloHET5cP7kiZsja6an08CFzzlWTaIhHf0VLQKVj0J74rYwPDrKD6qSHEd0XgDkM9VYhIS
	sqStw8/URAQGsOLeSYPvQA4dPr3qOaphv63Ayj9AJibUyccWCYoDGm3hXCqhng141ZPt69wcvVH
	31KU7QfVtFo1HHyq+FMl1vNkKdXudIwBSHLGJaTW2JITs/GXjeU+7mybsirC8LFYZM19LDUGLuh
	i7d2u+K6YRupSWjetJhNonT4yfids10wxl12yKjmfnFrDw+KKJzcgha1OdGhZ0X483Jg==
X-Received: by 2002:a05:600c:4fd2:b0:490:ec79:3063 with SMTP id 5b1f17b1804b1-4923f57a10cmr29923105e9.3.1781874241454;
        Fri, 19 Jun 2026 06:04:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd15535sm74418965e9.3.2026.06.19.06.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 06:04:00 -0700 (PDT)
Message-ID: <4742976d-b8d5-4852-a8cb-783d2fa5b713@6wind.com>
Date: Fri, 19 Jun 2026 15:04:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 3/6] ipv6: fix error handling in forwarding sysctl
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: shemminger@vyatta.com, dforster@brocade.com, gospo@cumulusnetworks.com,
 ddutt@cumulusnetworks.com, brian.haley@hp.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org
References: <20260618162225.4588-1-fmancera@suse.de>
 <20260618162225.4588-4-fmancera@suse.de>
 <fa7cbedb-33f3-4a79-acff-2b23cf3f57d8@6wind.com>
 <91d77512-f741-41d1-a799-5409690da5d7@suse.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <91d77512-f741-41d1-a799-5409690da5d7@suse.de>
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
	DKIM_TRACE(0.00)[6wind.com:+];
	TAGGED_FROM(0.00)[bounces-300709-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:shemminger@vyatta.com,m:dforster@brocade.com,m:gospo@cumulusnetworks.com,m:ddutt@cumulusnetworks.com,m:brian.haley@hp.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,6wind.com:from_mime,6wind.com:dkim,6wind.com:email,6wind.com:mid,6wind.com:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 188686A5ED0

Le 19/06/2026 à 12:28, Fernando Fernandez Mancera a écrit :
> On 6/19/26 11:34 AM, Nicolas Dichtel wrote:
>> Le 18/06/2026 à 18:22, Fernando Fernandez Mancera a écrit :
>>> When writing to the forwarding sysctl, if proc_dointvec() fails to parse
>>> the input, it returns a negative error code. The current implementation
>>> is overwriting that error for write operations.
>>>
>>> This results in a silent failure, it returns a successful write although
>>> the configuration was not modified at all. When modifying the "all"
>>> variant it can also modify the configuration of existing interfaces to
>>> the wrong value.
>>>
>>> Fix this by checking the return value of proc_dointvec() and returning
>>> early on failure.
>>>
>>> Fixes: b325fddb7f86 ("ipv6: Fix sysctl unregistration deadlock")
>> The bug existed before the git era.
>> Maybe
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>
>>
> 
> 
> Hm, not really, AFAICS b325fddb7f86 is the first commit overwriting the return
> value from proc_dointvec(). See:
> 
> @@ -3983,7 +3986,7 @@ int addrconf_sysctl_forward(ctl_table *ctl, int write,
> struct file * filp,
>      ret = proc_dointvec(ctl, write, filp, buffer, lenp, ppos);
> 
>      if (write)
> -        addrconf_fixup_forwarding(ctl, valp, val);
> +        ret = addrconf_fixup_forwarding(ctl, valp, val);
>      return ret;
>  }
Hmm, you're right.

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

