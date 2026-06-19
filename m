Return-Path: <netdev+bounces-300665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RgthLRQNNWqymQYAu9opvQ
	(envelope-from <netdev+bounces-300665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:34:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 596C36A4F8E
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:34:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=XFGSQnM2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300665-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300665-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD8A13007889
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C5033B966;
	Fri, 19 Jun 2026 09:34:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B988424B28
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:34:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861651; cv=none; b=WYQZPpIK/kS1laibr3z3WVfqW5LDHl/zCg9zbfRdcS9a3GSCA/sW9kcF7KV7tZMo+WptrOTsdJbXpijuDdZw8Ts0H050X0uTqH87FoMvW/M0gkaVa/sKl7QFPpVt/wFfgIMVgZWE4rJ1YIPGpf7rIrcm+H1YV/hv5audh1u7NXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861651; c=relaxed/simple;
	bh=4CJOGsp/3cXb/k4FB91vg1RUd4iEyfL+xfjXED5mWH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L75F9UIkdVDIKbWJ2oh2NWRdGJxwtVDmmRaud8PbMUp46lRZc7OU+4kBYAK4+zTA/7ZccdtSoDgymakOH8tmoaM2vC3m1/UVCqVc0CEOo3o6dVID6XcshjO/t9ehHGLOJbm1C/ubcULpbcEfk1fd/BoqDgS1PqLGPwakI+Y1zFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=XFGSQnM2; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490a767521dso802955e9.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1781861648; x=1782466448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mgIMhShs3cyN1Yq9R2fIjMUlL6jiFPIgCzxIQyG7JdU=;
        b=XFGSQnM2OsuXNH1py+zXPgnzmlW6iqjBnzMJsJqK1CaE7xMbfl3iW+ISGDttr9AXSn
         t00q0ainxd8/Y2wyZpehMv4upIv8Ia7xfdRSG7JUcGW/6Ad+WkadOozHVpORaL2pJvS/
         YHel2zD/DdVI0g3BXFe/ds8uxvbEw6fEBUvV+lskIrUQeBLpMYuLWURXoVQ4TR/Riyqe
         WED3jpjFBvIjLwpEHI4w3qwn4f4JDwXbDvKr/c4gvEMex4lpm9MrLpF0iZIElhQW7AsN
         S/PvxLsTzqNmvECZiRcqGkKObW+dZ+mGCLCaRLyCqVjSEpCEe9t7UiNHXJnj3+64sSPD
         VrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781861648; x=1782466448;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgIMhShs3cyN1Yq9R2fIjMUlL6jiFPIgCzxIQyG7JdU=;
        b=iAmsLsAYkSZ+x9o21Ask4+cyO4Ik9VlySElgVXmJmYcGIPcOr+vNq4Nkor8x3iQXSK
         0Pwj1Eaz7Qvuphi6LC08YTu4L7w5kIMeo+KN3RX5bgocqKnSjkdMkucLJA/sU0MztFSb
         G8wc+T7+a0x/HUPAQ1IFbRpt5H+1P9PJ2w2kzeqQXICTZVZSAvQ73QOkLZvmssJUDnJp
         XLUf4cJBnHrUSPzbYlpNFfI4s6UTZaJ+7PPDlIjzgxOqXGHb/UrcbG9GcBm3edcp0WzH
         92P8EL8aCNQ/o5pIML2UmFQjnvMRJYVmxU4nqKAwb/XOn8skr1IL/zLhMuykl8hHdWh0
         uGtw==
X-Forwarded-Encrypted: i=1; AFNElJ/Z/JCTD8AoTLuuQouRXk3iHXZ4//n2r0TW8MSFn6HwbFIf6Y0StMbYHBT5SJH/the2HEQIJ/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1lZOubHB9MfKjmfVbdXJucvQBX19OQX2BLNv6IBmUop9InuI
	+iGpaI2BR3yJ5R6bVqHR4akVWc0DZmoQLjwJrK0UGds4Vv96BUBDA0hkPxb/KShIx4M=
X-Gm-Gg: AfdE7ck63SiogUE43TX+MQNHJ6BnZw4dpRjUkX6JKtJOY/qtIN2e1lm1bvNYs3owZXb
	pCcpqTgzUXVCONVphotWP2pYmm56zjodvWBPojcxaxwHo2cWkR54INJPEyq1Nb7DVdnKdQWhPc5
	p4/ii4czQkbBtXYDLCWBxcQd1KkgbyQQVIWHVDhs+1jN+WWt0bcorXpqn8Z5g7Lw8GTVYUZ3M+u
	io4B19cJmR3XZ2ifdjaHkY4gADK4lb0OxxRW6urw3dF0qtnWRT6VQyAhVd9qyY8aO82secBxCg4
	FPgqEPdgNGNPBCwVtpFo+HHtgw1wh4GN3OuaQbZRZTlLR99ejnpErVGRkRZZS4+0BNvA/MIbKe7
	oSx+yKjTBRoXZY4QD2/VfUG/zaJh37DGyaXs5Atjjeik347RKJLghxtrZbiZSYaoBNR2vKvg4qm
	bQ1TpbE7J8l8a/91HPSTtXrsYJjGn7O7sDhKFoYdH8EjezwIFXpUKEBQxmqDK5/tOcEg==
X-Received: by 2002:a05:600c:4f84:b0:490:c123:3b7a with SMTP id 5b1f17b1804b1-4923f5adcb4mr24136535e9.4.1781861648058;
        Fri, 19 Jun 2026 02:34:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a04b55sm6662083f8f.5.2026.06.19.02.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 02:34:07 -0700 (PDT)
Message-ID: <392b2c7f-7f06-4384-96e3-147dedb77117@6wind.com>
Date: Fri, 19 Jun 2026 11:34:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 2/6] ipv6: fix error handling in
 ignore_routes_with_linkdown sysctl
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: shemminger@vyatta.com, dforster@brocade.com, gospo@cumulusnetworks.com,
 ddutt@cumulusnetworks.com, brian.haley@hp.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org
References: <20260618162225.4588-1-fmancera@suse.de>
 <20260618162225.4588-3-fmancera@suse.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260618162225.4588-3-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TAGGED_FROM(0.00)[bounces-300665-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,6wind.com:from_mime,6wind.com:dkim,6wind.com:email,6wind.com:mid,6wind.com:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 596C36A4F8E

Le 18/06/2026 à 18:22, Fernando Fernandez Mancera a écrit :
> When writing to the ignore_routes_with_linkdown sysctl, if
> proc_dointvec() fails to parse the input, it returns a negative error
> code. The current implementation is overwriting that error for write
> operations.
> 
> This results in a silent failure, it returns a successful write although
> the configuration was not modified at all. When modifying the "all"
> variant it can also modify the configuration of existing interfaces to
> the wrong value.
> 
> Fix this by checking the return value of proc_dointvec() and returning
> early on failure.
> 
> Fixes: 35103d11173b ("net: ipv6 sysctl option to ignore routes when nexthop link is down")
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

