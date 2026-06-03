Return-Path: <netdev+bounces-294665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pXQAEAnhH2q8rgAAu9opvQ
	(envelope-from <netdev+bounces-294665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:08:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C035635881
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:08:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b="LU6R/nbo";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294665-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294665-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A18330CE9C7
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AD040B6DC;
	Wed,  3 Jun 2026 07:49:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56450408033
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:49:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472969; cv=none; b=Z70gyKSVLksgBBnRUg9DfpdKPUOZocu6FHBVrm7KMIXqhVI3e7dZtoEgue5/T8Sre0KGyrcDiebczzFSyhvW17/j7hMGoZnTp6XYmPLc/S+mAul1NgDfimzBX3mXqW1zmWpo88AnuGlCg+5EeD07FwFkopu6cW8XdwZMLGTlOEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472969; c=relaxed/simple;
	bh=zEG+i3P1lHKCAC1eCi91e4ihr/Q/qxsS4WTGc7Ig/Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSaEo0189v5Zp29mhAr1g0HbRA95eE/uLkCeZlqP1NeQKPc1eprUKZ9jon7r5wDHW0JoWeFBwZF1cFsBxaaJXslbDNrhsrOcE6DPEURmXctA3rV2kibrtdY1RHGEJ/dm2keL1m/RcWF/t+VvMWJKSwdGc0dFtn4n20CYEz1Hg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LU6R/nbo; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so15350925e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780472962; x=1781077762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZKrB+sQPLZnuhkbyzkgA0Pj2pVr+WrfmmMKpUXADMQ=;
        b=LU6R/nbo8bcKi+mmsycrHRHhwLTFd+IzOnkob+Tgj9A1oGCQRxYVs8pM5xSncsVcSK
         cnD/CvFhllab7f+VuQ2wKpFWt6q/8p0oaP0dN5ymjalx3/ytTyG4eKNW8JGacmEwrMcS
         MK2SHJMIlGUfx4ADphDsYnaRvv3idcjpZVY7xRk0OSssOprB30JAxvtQrXeu5Ol9+Raz
         3B1kmW7Ulfk0Q/G/oY5URkJQqlS/rFKZI77FkRZ0rjXa6Fo4/MogJssXLPjJBdCOcMsD
         7GVmW8faKZLqK8Jt0yvaiO1twRF/y+BN7La7Bkv0pu125D3sJ9XYkQ+YKd+UxvLZHFct
         mhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780472962; x=1781077762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZKrB+sQPLZnuhkbyzkgA0Pj2pVr+WrfmmMKpUXADMQ=;
        b=BWywqhKBQsnWw1h+4MlQu8QrtAAI2L9xoxJjE3W113N1i3rP6LMNf9B+WbWO4ywJ+J
         a/lZqHjADZjKy/qFdMvNn7ME9YiJazPMkUU1FtpdBHgZqsWSDrsjbzL1SmjO9a47gKaD
         /imsenqfFk/x82AJM9K3vF+PkBluY5xJ9aMtOhdtI8PLoWCXS5weH4TelSsYub+GDaFK
         msLAk4s+saLEtSHBvjCUZ6KRLSAfeauyym72LnMInFspuEu/wb5f98pdiSLv/aOjEiQh
         KrJFVHg5ErWVFkxBqOVTfUxsMugXTlj6jiXY4VM3okVqUZPiPasH2raeTrj3owEXYILv
         /tHg==
X-Forwarded-Encrypted: i=1; AFNElJ9+WB3UFq87uouw7X4/Ra/Ys9Obp78vKH0xUC6rdQagnvHi6OcSekeACj7pbRIUulY7XkpLeFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqiNAo1552sTnepO2zvJ3cJ2NH4vfHfGzvjvgN/+nN6q6InbEy
	ttTBM8sPinqRu3EFqwvQryoWp9SuMbcKNcgonCvpyesDRy6RafVXtsza9wim47BZA3I=
X-Gm-Gg: Acq92OEqFwSkGIZc9RYeVRO5FO1JKafaevhCEFZtTba4trYWx0MnyZZC3C5UQUq2Aat
	VUkMgZRSCIWe9iIK5nsi35m/p2MGWHWXchHkLRf9tt6oI1PpGMuJhfxCRr77hXEQmwClVkjUZTM
	iNWouIas4WMr7/LNQQTF8IwFxAarnoMvXN6iyY0bKKB0FioSrWpEbvMG/4R1QLZU/GU8348Pg4b
	sOrYXkdXTRzI2IQXRUD5USCmGgBQQK77qQcRpbxpSikPrh28HVSv1z5io1w1SRJcEIV+f+M3zYs
	25ItYoSnB9y9DVNh7eqdGoUT3ICLuqBijDkvKFiCPYrSMvsvB1bXq/ilScdppuCYxT02j5QaSqi
	AckZzUJ3tuXhCQUzHtDLtwPsOechHLSKRneIGuwyCMWPUFmF6Cs05K6usxMfiAvvGEE5pJKVBBA
	EVJLuL1BXmVIodg7juczQftGBKLCzGUaNDFnQQTZtDNgAh/pfQD4R1066BBbZk18TJ
X-Received: by 2002:a05:600c:470a:b0:490:4f91:5519 with SMTP id 5b1f17b1804b1-490b5e51b3bmr36495775e9.18.1780472961635;
        Wed, 03 Jun 2026 00:49:21 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0daefbbsm201972655e9.0.2026.06.03.00.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:49:20 -0700 (PDT)
Message-ID: <300c7fb3-9a8a-43f6-93e8-90ab268178e0@blackwall.org>
Date: Wed, 3 Jun 2026 10:49:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 08/11] bridge: provide lockless access to
 p->priority
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-9-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603062043.3911278-9-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294665-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,blackwall.org:mid,blackwall.org:dkim,blackwall.org:from_mime,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C035635881

On 03/06/2026 09:20, Eric Dumazet wrote:
> sysfs show_priority() needs this.
> 
> Also br_port_fill_attrs() might in the future run without RTNL.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_netlink.c  | 2 +-
>   net/bridge/br_stp_if.c   | 2 +-
>   net/bridge/br_sysfs_if.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


