Return-Path: <netdev+bounces-303111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id unQYKOenQ2qAeQoAu9opvQ
	(envelope-from <netdev+bounces-303111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:26:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C886E3928
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:26:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=JDfHbbdS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303111-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303111-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23C55307A9F0
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF88B3F9A1A;
	Tue, 30 Jun 2026 11:14:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7323FC5B9
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:14:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818053; cv=none; b=GyV2WI9hGN14NEIgV/aLX5gFjFjaHgf7CtmPobFmL/b4+1Ro1qo9sKPONM3XUEylQHUpYjU1ZoVuISNA3TDdriTw9IsCDSOjHwU1n8zcrp8Stt7Eyu0otyEplQdca+U8ssaXCIKJDIuA57oAMTKDfkOETjroCk9f4Md6URksLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818053; c=relaxed/simple;
	bh=2jHdBd2TZxXeWYLbDxLIUZTeCVDGgcKDOI9MSlOFEug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEvy87fo4AIar++ue+HcCj/Wnauo6OcEiD0NPvq78JYajYb9N2UTIKtGm46OS4yBVS7g1IJ/y9JnutWLE2CUGENL71QhIa+ulSVuCCDbr2yhwHNbgSu3ppYHJjQ9iZE+3aLXWzbnqC3zBGRe6zFqhy7CAYcGVuiSbPiPBdL0+xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JDfHbbdS; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-473dc4cf238so1249174f8f.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1782818050; x=1783422850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PsOO+w3djRWiTqdG7cX2rCfwTu+I1JT8lTk17i2VrWM=;
        b=JDfHbbdSOl0sz2orUs891a4FVVaDq899oeTnRAF0i5GPETbGTe0aJtgiOJ4CRvsLto
         yR+d3XBtjvvY1Ga2xXA3t2HyByH7USTrnUOP7Nn7Co2SNYajC6qhNf8ZxXcb0OHJRm5d
         Ahr/f906DnGj38Li5gA+yYqRprDgXmpOI5KLSFm/mcxy3D9tlsq+6GDLRawb/sbGIpSf
         PPFS2d5ixD2Gi6iP04TUBNZjPumgb4AhRsFdM67XDTD4cMENH9UdkonEwsyhXDUa9qB8
         8aeXobbxRM/Ir9mDlTPbgJF8j+sW6bz7z5dzT5/52PNsqltpAXU+EJBre5zGnkkCprcw
         yesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782818050; x=1783422850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsOO+w3djRWiTqdG7cX2rCfwTu+I1JT8lTk17i2VrWM=;
        b=ntDyLiZu50xJ3qxnaYHGsoIuccHWgcMxLiAvhFqFUPK7Q+koBqeiXdWJEcpe7P9R3I
         LDBVkzazXncpcbamrTd9PFDxReYJ7ILBp3/N2Ll5Z2ahLHWKyTIgyx55iNIgRbSGPqtU
         D4llmZsrEFa2F9EY/lF6Pj0XL5Q9iZNIJQGy4utRbQ/e5KOcXLlTDGN6V9qQsYUWa3lm
         GPmKmPMAHDTk7Qzro49XsnJMfUP+oLWGFTLhWUAgKy+3tJFkQsCShguIM0ZUusc1Hq5a
         7BQrqOgRYQ8g7J863pya0vcePx/7dqi2zszC+JVx4pyJe854UoE2LyTszGihcY+obNKy
         3flQ==
X-Forwarded-Encrypted: i=1; AHgh+RpliHJBrYwcJtO3DXM1VPicR/XxAE5Ii/O+nzwUk/X09Zj9qeDQvejZga+UVjXL5e4uEde+CVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpjgwhqaNPf6paYYQvOfxejbO01xKM015blOOm5x/t9LbXvWeR
	EOhzzaNKldEsHTjzdOPWAJk0kMl/ft0Vy4Z2ICBVtm4Gt8K+MsecWZtxgt6W1efvQTk=
X-Gm-Gg: AfdE7cleykmVHujjmw9uj+Vfmkg8HPDVd1jegONc6jnf/FUmQKV3mO6gMuANITUH1SM
	t5IQ/RRdTfS/QjDsYRwd2YyqwkmJjxxTuA8snXP18ZXt+vzkkjZg1sLihYI8DUkk7aL2p0kmjXL
	NaCHnMyXj1EGAviL/ojPhO9fU2a55rz7xV7NfqxKohSoRh33rVkJ/aXFd8/3WPRJ4aZjFtz81H8
	RKzrBDjVDQN1Lr62fVGkgS68uTnHQR++wSJqwYudivXOIWqxhhZ4OC/2GYVIVciT4RMfS4fgi8X
	zg5+tPl8Mr6XBh7O+sOUfuwZN4MZIjndkprqMd67TIjE97GPQMfAd7/S4vi59MhdJRhilb+P54Y
	gguM6rjPhNgt74WNZb+oaeZJHRqJ+gF5hoL8xGRlGEHWghnAWe2APiZ0dffeveM5CcQDTIbsYhK
	4chSFLcFQFqx3gOLUfhqySt9gG2l5d8N1UU57hIK+us1c=
X-Received: by 2002:a05:6000:460d:b0:474:8aad:2e0 with SMTP id ffacd0b85a97d-475505f2fbamr4383015f8f.9.1782818050681;
        Tue, 30 Jun 2026 04:14:10 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d194bbsm6212490f8f.3.2026.06.30.04.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 04:14:09 -0700 (PDT)
Message-ID: <e6f8ab21-c4e8-49fb-99b7-59efd6a95448@blackwall.org>
Date: Tue, 30 Jun 2026 14:14:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next] bonding: no longer rely on RTNL in
 bond_fill_info()
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20260629173200.469953-1-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260629173200.469953-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303111-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:ericdumazet@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,jvosburgh.net,lunn.ch];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,jvosburgh.net:email,blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,blackwall.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92C886E3928

On 29/06/2026 20:32, Eric Dumazet wrote:
> Add READ_ONCE()/WRITE_ONCE() annotations on port->is_enabled.
> While this field is written under bond->mode_lock protection,
> is is read without this lock being held.
> 
> Change bond_fill_info() to acquire RCU and use READ_ONCE()
> to read bond->params fields that can be updated concurrently
> from sysfs/procfs/rtnetlink.
> 
> Add const qualifiers to bond_uses_primary(), __agg_active_ports(),
> bond_option_active_slave_get_rcu(), bond_3ad_get_active_agg_info(),
> __bond_3ad_get_active_agg_info() helpers.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> ---
> v4: addressed Sashiko/Jakub feedback
> 
>   drivers/net/bonding/bond_3ad.c     |  24 ++++---
>   drivers/net/bonding/bond_netlink.c | 109 ++++++++++++++++-------------
>   drivers/net/bonding/bond_options.c |   8 +--
>   include/net/bond_3ad.h             |   4 +-
>   include/net/bonding.h              |   8 +--
>   5 files changed, 85 insertions(+), 68 deletions(-)
> 

A bit late to the party but fwiw:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
  Nik


