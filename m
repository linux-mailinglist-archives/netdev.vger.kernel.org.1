Return-Path: <netdev+bounces-279902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOvCDfZ35mmFwwEAu9opvQ
	(envelope-from <netdev+bounces-279902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:01:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F4343323A
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FCBE3020A85
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161113B6356;
	Mon, 20 Apr 2026 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIvoW29B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC473BB9E5
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776711331; cv=none; b=L9vvM2/V6iC5ytdtzqzB17y+wz+3o+U4yUX33u6KtZgmK3vulxoE9Ro/MCMSunUvMZWvbHdSYkYD0Fq442OEMS6JXKloMiKvp9xFP6K8rxiY9MBzGWfw9H29uza2iZdfKEZlL9qN3kcGkVqSNvv+cP5DEURU0fYOt57tDkzDV4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776711331; c=relaxed/simple;
	bh=ubgUX7BNuvKy9uoM6ebqr7kPkBbxP5jfsEyerQ8viyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9TYAkw7YJOA9NBoQJQAm6fWM2Igi+2to6XUScU9b3AhEcbRlsJV/71ZZzM/XGXpHtks0KJv0dAvzcYo0BlnDKaBY9wkuq4dDLY3bYMEPVK3agdj5IYuby/LHYY7b4e7hDxkGQnM27W57QiYjjRZ7EmjTJRF53AM5pnrnEth9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIvoW29B; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso29163315e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 11:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776711328; x=1777316128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/HVK11ntRH+XIcJMBV/Pz8SBCVICjVsqQ/5VvsFVlw=;
        b=SIvoW29BJ5dmb4IX76NXEstzmGOvWD9UKAvsDeLr1J76H2UrHWnasq0b0i1kV6QpuS
         1gjpwFNFb/Bo0SYf4oWQGby64Ipl3ZCHgWyj8GO8Ao+4rwGAnbvkMkuvM06kGrd22BdC
         gF8I/jsebR2dM9vIRsPsvIS2yBudtL9G3raut3KL90C6VBcjdJGE6fQ+mnHlKMQia3pQ
         JATCyXuNh9txVU0KAQjMbE0iwQvFqf/W2RhFRf1zxlcx6ot+4wJvO9h6dwEe5ja0XjNZ
         GsU9+kTj++HIXp2fSDaMB55ENIhjuvfxuuv4JbOM4DXNbLpVQ9A9mJ8rkwRA8/y1s2YE
         pFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776711328; x=1777316128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/HVK11ntRH+XIcJMBV/Pz8SBCVICjVsqQ/5VvsFVlw=;
        b=VDzwzOaG8RTEEJueksLpOEU1RQtcSeV8ibAjWn+8T4xPC337dSs5h++m7XJQgeaNXw
         NRCyHUKIP2RJQ0AfPzGOcTq6IiBFImuSd2Cgh/Q8/dm1s8a9CFCljl3HxiqZKI2G59kX
         glyrM6tJiOryxXSwPBfd4a6ZuffTmCBoY1yuy8fz5ebEYRmZx1lLi84st5HNbEuCNVer
         JEAt96zj2xfnaMFCaOcQ57lCzovnVJUtxTP3y1B/tmpFEE2n+BpZPBsOYW/cvQsn31ES
         Har3psW/aOv1G5YTMtAnJKsDu+eYt6kDhfDxk6EN5Yw77niiJQ4mP7dHRULjhJeRcCZy
         txxA==
X-Forwarded-Encrypted: i=1; AFNElJ8aAK2TmurrjgZh/JyBupQB9b10mocX1dQqWx+1u3UfxdU1pyM5FC2RUQRUcxQZ7A6R7lo3eRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTudekOvndn6DveM1Vbqnmr4VecgGhOoml3gqRQkpnbYWdYff
	ZDT3tDijN79d1u5yDvxgQLYKO4LRf4YXwAz2MAzPnucYz+3BeklOiFNq
X-Gm-Gg: AeBDieuYUvZk3tydkFSM1k9MXxl1/sIpe2KYXFvnYeHUGJ6lpr4w0sXS+wjtvbwOHPx
	q6sUMwwfUab3C385F7SI6npc2Ng0DYdZ/s3blVTYWaQDOcDq6/vVpvOiZvua4cs8gUnQt5u1N4i
	+In28cTuxx0h9MZJqZr50mSLR+6vMKq5nmnYlnk0O4tCd+D6arzomj6NsJrH1NF0pU4yGetQJVJ
	f283z4QQJ4ti1DoIMnZqijpJGalD6xLj88J1T8nr7mxbpDLY0V0okehnNqd90vGruYTu2mc4Ock
	jH8ey+/W8Vey4w3fCzKb4uOUIlBPIqCPFBkK+U4RmtJNaCaXAx9VN0WEcIfc1mTbmpHylJ3w2yX
	ui52ogiMONr0aUwZ99jip0nemmOnRMy/HM3H1U/xiWV7g1Qp6p+oKSfWJAS3PKmwwE3e4Tp9yXn
	E6NU/hsB7wCPoxER635udPPLE2Dk71Zk2Vl8LrU9E9Mx0GEf+9MmiJwqxsWYkM4t8z4FVuRagoX
	nbbO0ChAW9W8/TGNnEkD5XSnC4=
X-Received: by 2002:a05:600c:c0d6:b0:489:ecee:c4ef with SMTP id 5b1f17b1804b1-489eceec9e3mr35706065e9.13.1776711327925;
        Mon, 20 Apr 2026 11:55:27 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:98a0:d751:7986:3f62? ([2a02:a03f:a75e:9a00:98a0:d751:7986:3f62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc558f2sm181352375e9.1.2026.04.20.11.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 11:55:27 -0700 (PDT)
Message-ID: <524def33-63e1-47c0-be38-dee68d859332@gmail.com>
Date: Mon, 20 Apr 2026 20:55:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: Apply max_dst_opts_cnt to
 ip6_tnl_parse_tlv_enc_lim
To: Ido Schimmel <idosch@nvidia.com>, daniel@iogearbox.net
Cc: kuba@kernel.org, edumazet@google.com, dsahern@kernel.org,
 tom@herbertland.com, willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260418121538.706095-1-daniel@iogearbox.net>
 <7c715640-5c20-4226-9c31-d2c5eef551db@gmail.com>
 <d8d60970-6f73-4b9d-8808-76f4f8023100@iogearbox.net>
 <8fdf517b-6217-4df6-8adf-0c79ce8d3be8@gmail.com>
 <20260419143137.GA885197@shredder>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260419143137.GA885197@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,herbertland.com,gmail.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279902-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06F4343323A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/19/26 16:31, Ido Schimmel wrote:
> On Sun, Apr 19, 2026 at 12:37:35AM +0200, Justin Iurman wrote:
>> Nope. But if it happens, users would be confused as max_dst_opts_cnt would
>> not have the same meaning in two different code paths. OTOH, I agree that
>> such situation would look suspicious. I guess it's fine to keep your patch
>> as is and to not over-complicate things unnecessarily.
> 
> I agree that it's weird to reuse max_dst_opts_cnt here:
> 
> 1. The meaning is different from the Rx path.
> 
> 2. We only enforce max_dst_opts_cnt, but not max_dst_opts_len.
> 
> 3. The default is derived from the initial netns, unlike in the Rx path.
> 
> Given the above and that:
> 
> 1. We believe that 8 options until the tunnel encapsulation limit option
> is liberal enough.
> 
> 2. We don't want to over-complicate things.
> 
> Can we go with an hard coded 8 and see if anyone complains? In the
> unlikely case that someone complains we can at least gain some insight
> into how this option is actually used with tunnels.

In general, I'm not a big fan of hard-coded values, but I also think 
that in this context it would make sense to do so. This is not a strong 
+1, let's say it's more a "not against it".

