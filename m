Return-Path: <netdev+bounces-294661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SVXxG9fjH2qFrwAAu9opvQ
	(envelope-from <netdev+bounces-294661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:20:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6744D635A32
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:20:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=C9Z4dDxK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294661-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294661-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C2B33025F8A
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40F73F58C5;
	Wed,  3 Jun 2026 07:44:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25D3939C0
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:44:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472649; cv=none; b=knP1XOGyllu6eldTSiiJnSSkxTVJRhczN8bDd0e8Bsew4Uy5EFUzI3vtSdBJJIhHvmBxcfqd2uiLWxHbJnQNMwQLrzphiWvxh58ffpk2hAp4tqf3Qw3d2JMw/d0qLiBYM+m/lBfuAWRer0Yto5LI54UWu+/zbAvxV9syR/KBlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472649; c=relaxed/simple;
	bh=mfifGihAo4w6JJC8KvC/Ih+T/x/zNLuPgP/1TDLr/Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1o7uFobdKFpOZl0Eg8nGey3zSCwrs5scnvgF22KWOnflKfgiK1XYZ6sfzdm1uu/J5fxbSJkCrVflgAx5ASeObE2VVdyJ2D/n+L8rCUoSnnLOUsP+SGqfkCngzg8b+EzJOTe4HJYkYBYU07x/ReXbchDVfUCktk0/lyFNGidAoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=C9Z4dDxK; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eee266c6cso4665038f8f.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780472647; x=1781077447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aF9TN5NMNmQd7euFhlOqll+BVjmvjyy0JM3fs3q+cd0=;
        b=C9Z4dDxKSJB7oL7fvkU2M6fYJruvnLsH3WSfTP9zajL9AIJRYPNkRwHtoeUdI/8xBw
         AFExhOxLsOhxucyYLdbbZI/BuibRWBOtRiIvzGF4Ei1+rGLWtAYgIcfI7bHgU2jrrLZX
         Q/Pom7ge86YuTtbOukr2TwFrzN7PvwejuiczcsjQVTtC+EtjtT8VyeDPZirpwZs093pe
         zN2Y7nHpnxdmB9d6JdVvcIa6odXKq7D7EgcH5fQq5taBr9KVJG8OvDb0YDA4/ZZBnalu
         xSxiBoc5VS0TDcCx3TDoLi+0An11EvOXwVUnejAMwon1xJPAJ57Kh0HeiyPMFZjt0Ahb
         iXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780472647; x=1781077447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aF9TN5NMNmQd7euFhlOqll+BVjmvjyy0JM3fs3q+cd0=;
        b=hTJ2wOPQNfr6lLq5H8sGnug1a/g3kdlrjM3Z8cD4vo0sC8CmAdavalu7jG7b8SEEnA
         yUHJBjEXleS581YhxFqDy/HoeCyV3Vx1sT5b1S/wVkF4IHsdzi7HPk+gqMJj1pY/vh7i
         sKj6/4ezUaGTKLvZr4tr44EsylzzUtCIwbI4wnBHX1hF8PAuxZ4EBabqLogWhWmLchzw
         hL+L4GzXsQ55p6HQ6fPp6ew848EO0bqHju5OIqYGUhHei+e3QjpHwgARD4hDkU8KLnKM
         o244NH4jiTpfpB7BAe0UKBCdV1oSKhGP6K8VqOAGwLxQD5SmFaoLnvqofL7GD/CZ81gI
         zukA==
X-Forwarded-Encrypted: i=1; AFNElJ+jl/dCxh/6y3aojUDpxwfWqGBfYAOgIwwtOXzYptE93sDGBzB++4WxQ4m9XEPxDDAtneU65DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTtDKFlY+2ZEXkGC8/pCl953kFZR+0rezU4BIjqKfc/UiXpSrj
	sOdhUy6gsuhEr2Ogx13323CgDofEXs0PKyYv4sBhUtJta7kn6sbrUa6LPQkcGRczC8k=
X-Gm-Gg: Acq92OHToN3Zl/KVqgjU3FE2m0ddbokrg2x+fsoJgdi1kXm9BcKvVut7n1UwCAGdVyG
	6xzHIPAt1eYrdvUyxqdOHafDGwZz+BV+XMrbLLmlE6YzCWyJWarw0tm/49IBb+N86BDxMnmlJrJ
	DpqILJXbA36oons9JnzysG8rDPCdLPM2v8jXoyjJfwoYB3R7mnULlcLcAhYDap0wojgrqR5nNK0
	kPlM4t145ezQJ/LWjgIo3RGwxPbXDmEB1q+YRPXLKzefyZq5fD5U/SUFxKyI2y5LZadl7VZ0Wg3
	zaUCcHhmYMyfgX8gjNmUaaaktHyyLZQnPmCrkQVZUyvH8uT5Obl6f8gyrCGlQJTFK73xJ51jHNy
	wC29LhBy/6peG08zOZjTvbglCqH3mAohuxDFAUpTFGO/CLB8Iwwh0OgrqVYsZbFQ/4EeV5WQ6Gb
	6bUEBS/U66IOgSpEEzeEQqZhG2vG17i5xDhD1K6gU/xQnqBtIS6XHQI8fMmFVEehTR
X-Received: by 2002:a05:6000:60a:b0:45e:f4f7:7cad with SMTP id ffacd0b85a97d-46021980b94mr2628110f8f.39.1780472646494;
        Wed, 03 Jun 2026 00:44:06 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc294sm8488649f8f.7.2026.06.03.00.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:44:06 -0700 (PDT)
Message-ID: <320bf57b-ec91-4aca-bf57-de8d8d9cda30@blackwall.org>
Date: Wed, 3 Jun 2026 10:44:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 05/11] bridge: provide lockless access to
 p->path_cost
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-6-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603062043.3911278-6-edumazet@google.com>
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
	TAGGED_FROM(0.00)[bounces-294661-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,blackwall.org:mid,blackwall.org:dkim,blackwall.org:from_mime,blackwall.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6744D635A32

On 03/06/2026 09:20, Eric Dumazet wrote:
> Add READ_ONCE()/WRITE_ONCE() annotations around p->path_cost.
> 
> This is needed at least for sysfs show_path_cost(), BRCTL_GET_PORT_INFO
> and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/bridge/br_if.c       |  2 +-
>   net/bridge/br_ioctl.c    |  2 +-
>   net/bridge/br_netlink.c  |  2 +-
>   net/bridge/br_stp.c      | 17 +++++++++++------
>   net/bridge/br_stp_if.c   |  2 +-
>   net/bridge/br_sysfs_if.c |  2 +-
>   6 files changed, 16 insertions(+), 11 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


