Return-Path: <netdev+bounces-295722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GaJ9Mc+HImoSZwEAu9opvQ
	(envelope-from <netdev+bounces-295722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:24:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ED96465D4
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:24:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=lQCE+b4X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295722-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295722-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA5423029322
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BFD3CDBD8;
	Fri,  5 Jun 2026 08:21:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3CF3CE483
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 08:21:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647672; cv=none; b=PXWjWEQvRN+l1eApOn8pvB/CNcTW4BU31gy47BzuU64c5h8SPAGOqdcbc7qzrwGwQgOe2Lpy/CYSNbEP5r9Gk2Ev6foiOeyu4FXskOj7TD8xBCz9JWWrio6iKJSRWH5W773b8YCj+u8V0WMM3guvY4LolZbfSgUfSv3CEA1yzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647672; c=relaxed/simple;
	bh=rgfSYOiXywKrwLfB/qrMOdVjNG8ygmP3bouuywyCiSo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=S+8Fp9mPg9tQ6SEOzNkMvrQdXdIzxbkGJGWitI0f7zSjJRArEbAvrqXPluFukc8PSzfFIbrWqop2WQfGjuBhsSu27vYaIjD/tAHhKxtgM6ssKZAIpJ/1FLameVqYxCqUnP4dM0Eq/8OerKBlBuMAFpfZ9X7spks60oLGXXgco/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=lQCE+b4X; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso18367855e9.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780647669; x=1781252469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xTR+ZXHU2zHqRTVuftEearzPbfFaRCiKJR11oO5z0GA=;
        b=lQCE+b4Xau2GlY3QvO+SA3NmUzxPjvzh0asUeHoks7TRi8pAZtrchxL7EHtEy+55HT
         HmEAHeC8AQNWU5SIsHp7GyEbQgwj6V3w23/WSsF740Eu6kbpjfjmeaPWJ3yHqv8EgE8E
         /ndkqzlbvcR751xa3/UBJdveyFPVb91pPFtoEKFCXRhz3LBQ35FxLmxKRtRejxK3wj/y
         wfoe+J44TLZDIJ+MKJg2HokmvAtdX8KMUBGAiBrzkdT1YGRCWtVv6e7feN/Uc1a3rjYo
         yV/3x82IPHtPw2hxGk21NZjDZS7ZKuP2k0ccBS46y7fAoH3Oje//+KVAHKvFwO+PZWMM
         zKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647669; x=1781252469;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTR+ZXHU2zHqRTVuftEearzPbfFaRCiKJR11oO5z0GA=;
        b=k3SJDB67Hyl4GIhRjml9IzDGYO4aBe9GlZE5dDMYBGUJF0xxL82u/5T4AiPggGsVz2
         tDxbZqU3ZasFib4ttZ7JUL8GFJMGRXYFQE7XEoe9sNOyUZMTAE6fvQJNBnX45lcLhFI1
         6R1elxjI9k7yJQRq5auunExhaNmiXMf2Qx25tfp0IMhe27Kfiq6Q7h3rKQtDn+f/CSCd
         AeTZpNQMd8K3UtfUPZmDrjOo0+i+NZb8PPTduqDwXAPloIZwzTQf7GTTWPgF6B7tA0tz
         /INogsqCej2wbdXsnFhzTBcyTCkxP7b+rYRqXISaNrm2BdPviUDqOrANs5aydqNjCAA/
         Wcfg==
X-Forwarded-Encrypted: i=1; AFNElJ/umn0FXhIzMN+gQn4omMAmdcSlalSP7irpXbGEmuwn+EHzMF+W6HPHO511YrwZTPw4SIDodCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMFcVBidH/vk78K13l9TJTi1w0cemv5VogyKzT1qMqaoD526tq
	7n/aSytxyvgd0MSJ2YZjLNi6SFRRUFWTNlSB0dCJibZsqZ++Cf+LbJGdqoOQB56tDnw=
X-Gm-Gg: Acq92OF/ituS+TkVUtcof16R5YTnmj6DIsIlKUqFA3ioKl5a64cmzRb9JTci8mgFMRn
	+y64PL1SB2cNZu9ENYMJkQD8KbyK5LCZeEKO5qcy+DkfRfFT25jg2suaw5IeVReQSsk1O6Qda62
	I7UIolI020k2Bg7EntoBkV6Gc2Qb9LWJpjdTHwg2avqu0OAvGuCTiYXSwvytnlGSHFgzUUoWyGo
	yJO9OaTd7hARKDqaQplFRGMv+Oc6sVjxrKcIxdi1NN+yGgz6iGqhNXDO1nGPqPhIIvTbAXsybik
	dpNzc2KXXlENuEEKipQWSsNYuTG584/xX151D2G+5qRFByQ1dgyKDmIioidHNtA3iFVi7uW9Ntd
	XbEdCpDIfF57qNFRXGX0AWLLY6MopXLw35wDrL26ybKDIxVcZcD6XTfTmr6BxsnjbLmHiWDHypD
	sD7x7ReQR+dC/CQQDDIY9FX7L89cRVNjdKBKog14pxXEkZ6fEWj1CFG8A0dUIWgsjV
X-Received: by 2002:a05:600c:4ed1:b0:490:b4cb:3866 with SMTP id 5b1f17b1804b1-490c2cf67f7mr22714655e9.10.1780647669382;
        Fri, 05 Jun 2026 01:21:09 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm141002065e9.14.2026.06.05.01.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 01:21:08 -0700 (PDT)
Message-ID: <8186bef1-aa58-47c5-9816-1b707ec949da@blackwall.org>
Date: Fri, 5 Jun 2026 11:21:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net: bridge: Move long delayed work on
 system_dfl_long_wq
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Simon Horman <horms@verge.net.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>
References: <20260507134815.295588-1-marco.crivellari@suse.com>
 <CAAofZF6CcyxoOsYr94KARUFtfi+=H1nF3mBQAtFWxEujdVgXUw@mail.gmail.com>
 <4d9067d9-2a4a-45e2-aa43-c456648989da@blackwall.org>
In-Reply-To: <4d9067d9-2a4a-45e2-aa43-c456648989da@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295722-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:marco.crivellari@suse.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:bridge@lists.linux.dev,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:frederic@kernel.org,m:bigeasy@linutronix.de,m:mhocko@suse.com,m:horms@verge.net.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:idosch@nvidia.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,davemloft.net,google.com,redhat.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,blackwall.org:mid,blackwall.org:dkim,blackwall.org:from_mime,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69ED96465D4

On 05/06/2026 11:20, Nikolay Aleksandrov wrote:
> On 05/06/2026 11:16, Marco Crivellari wrote:
>> Hi,
>>
>> On Thu, May 7, 2026 at 3:48 PM Marco Crivellari
>> <marco.crivellari@suse.com> wrote:
>>> [...]
>>>   net/bridge/br_fdb.c    | 2 +-
>>>   net/bridge/br_stp.c    | 2 +-
>>>   net/bridge/br_stp_if.c | 2 +-
>>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> Gentle ping.
>>
>> Thanks!
>>
> 
> Ping about what? The patch is marked as RFC so it is not
> going to be considered. It already got a reviewed-by one

err, considered to be applied

> of the maintainers, I'm ok with it too, so when sending it please add:
> 
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> Cheers,
>   Nik


