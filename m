Return-Path: <netdev+bounces-300667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LHd+BkANNWq3mQYAu9opvQ
	(envelope-from <netdev+bounces-300667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:34:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6432C6A4F98
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:34:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=OnYKgSC+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300667-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300667-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCD2E302F990
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DA3357A3E;
	Fri, 19 Jun 2026 09:34:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31033342C
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:34:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861688; cv=none; b=OsKYyYme5UNYBbhuX1zIiTCO0V3+OfhWLaZZfYhdCoSSKCR0ohgbj7HH0bj+BFhwfE6jedIC40sczm69VDq4T8w9/P00/noHEjcnNMv0EI3buOQmzIVs7Vs2ER9pL5YdPTPEPIPY3JcP3Gf2183ceYvKhSI/17ytwY+zH1ulXAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861688; c=relaxed/simple;
	bh=fCZEWraopoZs7y6IlkSZBbrpGFYBpV+F0nEQxCYWOhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBP2pbOEAiiB5ADRlKCpX1daV/ilQ4G8tkilqSm0aAV1gC50cQL0rcQhYX1kZg2w4ILXwdFayWZ0LsbQGhEV9z0orQ7CEQ188goW69rl1qw0eSqMTxJBja2YKFVlWSs2AtU4FX5KG9NLIloEj+BVhwi6D6y9+8y+4Fw+4aPnty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=OnYKgSC+; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b1c39fe4so833385e9.3
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1781861685; x=1782466485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yk6nANVaknISEgeLtcEFDzfuYldu3rIeyicZLflUUb4=;
        b=OnYKgSC+oPEl3Yok8vN6ySNB2zKiqFm0Ud9nLdL7xOuuzPxiSy9bimg5aIwrjgO2GU
         YmxsK/Mhe1EtsqNI3nhx6wUgFiNjtzrK5i9AYfd9LwENk44cwxBIZtnhnBjskFXr4z+d
         wYr46QM8py9wv5hkkORd7ytWHf9ZOsLugZ9EV+B09ktmkS6TLX14jevfP6K7QE/+JL0G
         1k7/rUb4cXZ9RrOhVsFu0UjqdBXZ2qfPmcZAzKYhWxwGEgHqiPAqNONYn7/XlmHId5k/
         xuZhRykElLXximjhmbEvPM6YuUu8z3qLqhCNfZCJEYIcvNTYCvgeI7O5GIRHZLq4vePW
         TF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781861685; x=1782466485;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yk6nANVaknISEgeLtcEFDzfuYldu3rIeyicZLflUUb4=;
        b=sGsUACzYDPtVIJ9KWlNBeMGf+P6MZeAIAJIQWI04intbrOPstpGnuZq9pmSttAPAAj
         yQwwyGyCDFbOCZj8WJ9O88ohjG0k2ELWWwK0OfKRWO9QBI8WluQ/vQq9Y0FpPKiLDPS/
         ESGYxbeUn2PUbfkrhEhWOguSCrmITlRv8WDtCKileKVmkVMejl+HnI93xuBNSERektvu
         blviqauP1/HiQMqlXgQbJuUvZhLXksWI+7N9Mjr2U2eLp+05+Qt7f8N/t5FNgVWSYYiH
         /HJLu5w1IQCKAt9YJA1BUS6yOueAuqvEhsMeclgUdT/vk3JvAn6BsR24E1UnL/gSKBoF
         vlEA==
X-Forwarded-Encrypted: i=1; AFNElJ++ngxBxs6ZVpRTtI7SEoyj9QoM9xI+qgGrG/O1rSn44GFL4QekXE4x7SCVmTYoC6XeillE6DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWB2dadptYsgBhlinn6AoT3DbyUFDixQ5rzW6kJkqqaFitwbyl
	wQSgQw6bBwNZeNJbMJwLgfYKzVvgYL6CiHrFXo7SomExnaUKljcxgdUIrvz7ifyAYgI=
X-Gm-Gg: AfdE7ckoFpVDn8aG1fPG87zAm+7e7bwUdUdnFRz0fcq5S4Ae0Jq93evCJlmE+pFAHQA
	mayRri6iFsaP+lNseyVwRUY3GE80YgJxZABfPcHkmyQHx6PUDJOGqz1N2F5OO4lM5rbOUV6Kaj7
	cWL0AYeoQ5cn2y+WubFYBqR+oc6Hs2mEJxo310rHkJ/d9HJ8nBAqeEcLZcwEhXxRrXDgzefJSkH
	OeoOaUYJPf/8oK3bomCMcu1C9vTcgva+Q9I7YHDKAymeCO/MONoDj/KV/Dqjxss6IvqMlWcCFE8
	Ek6MQPltGpjf8GIpbZyyVzRmdlvfE4zxlZ3JB9KTxy3fZSHm5Ej8oksHMwu3hubeZWhT1HOmzCl
	hkBTFMfrthQ2qJKxMxXy94SVI5WSdH6q6pN9plOMNDhQKaIwbXO5tDEbYlJh1rmKKljXfqxwQbS
	MFfrVomI6aQZQKW9f/GU8I1S5kri3c6HQ8ZSf3sZNeDROmdYOQ/EYUDSyw5bQ28O17qg==
X-Received: by 2002:a05:600c:8b74:b0:490:ade7:9ca4 with SMTP id 5b1f17b1804b1-4923ef5c3aemr22711175e9.2.1781861684936;
        Fri, 19 Jun 2026 02:34:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7b359sm52596005e9.9.2026.06.19.02.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 02:34:44 -0700 (PDT)
Message-ID: <fa7cbedb-33f3-4a79-acff-2b23cf3f57d8@6wind.com>
Date: Fri, 19 Jun 2026 11:34:43 +0200
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
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260618162225.4588-4-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-300667-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:shemminger@vyatta.com,m:dforster@brocade.com,m:gospo@cumulusnetworks.com,m:ddutt@cumulusnetworks.com,m:brian.haley@hp.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,6wind.com:dkim,6wind.com:replyto,6wind.com:mid,6wind.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6432C6A4F98

Le 18/06/2026 à 18:22, Fernando Fernandez Mancera a écrit :
> When writing to the forwarding sysctl, if proc_dointvec() fails to parse
> the input, it returns a negative error code. The current implementation
> is overwriting that error for write operations.
> 
> This results in a silent failure, it returns a successful write although
> the configuration was not modified at all. When modifying the "all"
> variant it can also modify the configuration of existing interfaces to
> the wrong value.
> 
> Fix this by checking the return value of proc_dointvec() and returning
> early on failure.
> 
> Fixes: b325fddb7f86 ("ipv6: Fix sysctl unregistration deadlock")
The bug existed before the git era.
Maybe
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")


