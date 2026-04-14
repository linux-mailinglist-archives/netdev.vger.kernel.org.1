Return-Path: <netdev+bounces-278333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKCANG743WlTlwkAu9opvQ
	(envelope-from <netdev+bounces-278333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:18:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 447523F7174
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F0C53073391
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B633939D0;
	Tue, 14 Apr 2026 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="bufE4HTZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B585396585
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154295; cv=none; b=IlNMExQxHm1rDX0sup8/HSzxrmufPJISx4AfnTBZhr6gCr4uvKaXbf/99UyOdsJgCmbEEaBTJUBHlJv0XQ84WVM2YWQR8FXcDiV1ZGLP6zeKM0ilZm1deYPC9KG8K+5s7zCmAVvS8Olp0P8nCpOZcg0qzsMeYBC0BaV8YD3Gh5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154295; c=relaxed/simple;
	bh=LKC3GcEPQd76Mokydk8xRN+V5u+9fgtnIFc0ntDRVhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+zDF9pCMrTPJOVSX8pvOu1LlC1y+8BrI+2W3Oq/jjxFyLi8bvdExFRpjgy7m0XLVriv3apU2czLfcsdGvDLWMSog2FdF3btyCV9bBuc5qtI8i23qWlCQMMYL9KloaSf1lLbrvLXVMmlLOZ4Wnifg7B2hzwRoZSFo1OEuvkx6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=bufE4HTZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d72875729so1397056f8f.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1776154291; x=1776759091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCgLvGkWd75O30+6JJyar2xTEu5+f+uj2d+eIIvMSsk=;
        b=bufE4HTZSxwDQ8ErH5W1LLybhvizO7J8LoP7/FEejolhIhpXjPuo7cei77qUtetK6s
         kJjjefJ1WxpPWHZ6aRv7c8r7sJjpnsLaUdhGAGArC2ivTtQwG15QnO69Dj+Iz/zcKnzC
         Owem+M3mb/gww3fb+5LK48j07d09gJAPuO9TFC085SJe6FLvHLHPnKs7f2HqZLNy5E0R
         xlTjYTcg8POngcPucx/2v693b/GRkkpEt54kx9OJ7DEJkJpHtCBBS1nY3Do4p7uwjhG/
         87T9InLafKzPVZyDYnc0UaF4dOxR30njKXO5exaWGSPBw+h7IU73hpNdoR01MgMk3FGk
         0R5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776154291; x=1776759091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCgLvGkWd75O30+6JJyar2xTEu5+f+uj2d+eIIvMSsk=;
        b=R2Sp5CMtEsn48KasD17yLlL/BL61ojM6Svgi8u1yKi/mzdoWPl4MpWg8HYMnuJIqSY
         aEnl5mq8ocjdYKHfz4wIGR+3y92B7vJYP+cLXgSoD6zNyUtm+9VHkWzRWvwdF1wqncAA
         bP6F/o0rVB1rwxYjLHXCG7ORosFZhXz3ToCgs7IYVwaymXJz86MtwzmBIDfDS8cbC5iX
         mCXCgRFAi2T39lC6tFtNRwOPpmmOjKL9KP/QmlT5bcCtVQdIPXtwGimGVw167mtzqeY0
         QyAp+ASYdH2ZmEIZ+PWXek9t4feQ4ak3v3uMrh7I35v5dq3Xge5ucokmj1fijMP3WmgL
         AMJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9PoeuKGteSKywrGTsxGIU9KrVeT6u7oWNO+jVI/lGYScSHdt0FC57/rZhdXdYFEFj9NTUVjos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOFElXgB2KEKUj738oYZYroEq4/BCkfvVcknOsF7aLeMJ7s2Ek
	dgDCvxM8VWe2ThNo1hqRGurRiBpwVE37DNeEF0HnroFvFOceEceUO/fDKViKTjLtBhw=
X-Gm-Gg: AeBDiesYH7rg87n9biJN1HWj9bDyWoCC42nY6P9qYliO9vQLPOrdMaP0KawLsJ6rZgj
	P2+qdvwVmV1Fuo+0r0E/PGui9XI6ILube/B6SLm1934dQxCDXZbo6hIYuxDQ7E272tnfCVnM2KE
	8KPqEGrTzTY2h1LK08p4VVkPzUKBiOhFsz+Fz6Z6ag4yEqbLsKMVLEQRuwngst7MgWD40mIboJa
	h1WrRtnPt5RpJVKKRcYmMbtOID4JjkURSBtkjzFZ5TAe9YGSbnnug7X1M6ES9pNkCG55kFwI8uc
	9QJrAGQ4q4j5n2uY6ubui9sfZNdRjCMRCTLzxCfvKt0fxnNOOX5nj+5OB8XDmCKy0V4iQ7dguz9
	SKE/Vf7LX2yPsIGbtIFtYUvnYrhR/VPrt+htJs/7g0JyStBqiWCeE+ZgudCeusu5OLJoRP8TuMf
	RfhpwRllcMtqXZZDWZarS2N+Y0OkKBv8RxAEfMBaacCoKmnKx4TXlcWEq5B/baiA8l
X-Received: by 2002:a05:6000:24c2:b0:43b:8f30:39bb with SMTP id ffacd0b85a97d-43d642ab9a7mr23139224f8f.24.1776154291062;
        Tue, 14 Apr 2026 01:11:31 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7b219576sm11932485f8f.19.2026.04.14.01.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 01:11:30 -0700 (PDT)
Message-ID: <7b776442-7c72-4270-b016-28d845e99da4@blackwall.org>
Date: Tue, 14 Apr 2026 11:11:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] MAINTAINERS: Add netkit selftest files
Content-Language: en-US, bg
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: kuba@kernel.org, dw@davidwei.uk, pabeni@redhat.com
References: <20260414075249.611608-1-daniel@iogearbox.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260414075249.611608-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-278333-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email]
X-Rspamd-Queue-Id: 447523F7174
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 14/04/2026 10:52, Daniel Borkmann wrote:
> The following selftest files are related to netkit and should have
> netkit folks in Cc for review:
> 
>    - tools/testing/selftests/bpf/prog_tests/tc_netkit.c
>    - tools/testing/selftests/drivers/net/hw/nk_qlease.py
>    - tools/testing/selftests/net/nk_qlease.py
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   [ on top of https://lore.kernel.org/netdev/20260413220809.604592-1-daniel@iogearbox.net/ ]
> 
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 65902b97f5df..fa1bdb1db73e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4901,6 +4901,9 @@ L:	netdev@vger.kernel.org
>   S:	Supported
>   F:	drivers/net/netkit.c
>   F:	include/net/netkit.h
> +F:	tools/testing/selftests/bpf/prog_tests/tc_netkit.c
> +F:	tools/testing/selftests/drivers/net/hw/nk_qlease.py
> +F:	tools/testing/selftests/net/nk_qlease.py
>   
>   BPF [NETWORKING] (struct_ops, reuseport)
>   M:	Martin KaFai Lau <martin.lau@linux.dev>

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


