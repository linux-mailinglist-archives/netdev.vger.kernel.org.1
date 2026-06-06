Return-Path: <netdev+bounces-296077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UMhHMuvYI2qVzgEAu9opvQ
	(envelope-from <netdev+bounces-296077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 10:23:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A09B64CEAE
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 10:23:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=UH05RJSL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296077-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296077-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BBF33031025
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 08:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FB931714F;
	Sat,  6 Jun 2026 08:21:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCDA317143
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 08:21:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780734099; cv=none; b=TYxPEEvN3UMtGiICeiFbQE8OzvsJiytukvhYs4zuX7pQXqrjQ99+hUQTVZZoJXses7LcNYrGRgoc2kdoZzkUVB/vOp5CrQV+bg5p9HNlpa4M9nayJiTw3lXmfPwST32Syk4F37w5bb7tXraUHdhvVTL/JaQlO02pxQqhb0r5geo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780734099; c=relaxed/simple;
	bh=xNsig66RaSc9mwJJKda5AfVrR7MopkMm6DomHG+DJVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNm3QCuVFyeBazqkXL3KkGxe6lhWUmBaiIQpmne/are0ZXbT8QbCcQvkWtBU7FDnqqgIWD2bE2UNpog/RQA71zyN/1f1auRW3h2LiPf53EIxDKOXh1SiG2T5F3ZI7reBmczNNJF2rDmG1TLfUc55qeKZirn1zquV2mZRVDCgszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=UH05RJSL; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso31393485e9.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 01:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780734096; x=1781338896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gMg6KaYvC+cJxi997viIEAJIuy1B+hppRNVQz2bByc=;
        b=UH05RJSLI0QctYLwr0qzLZKFjNETsRVKTwKFx0L2fmVue84qdzMF8amgvjFCWr9kYZ
         /YtZKrp2m4lw32rFAyxTxX3UEbZeM9XSO9EKvrTaAfuaRgimy+HY05Xz/wOXm7inNem0
         6dxSFjusNVmEtwOfQ4wAc4gKl2niSPWagQP18+7wFKEaaTURdQ/MZYbOoWY8euXKQwT5
         amH+ztZnH4WPThQHboUNfr66vOCjk0nceCr+VgpXhcU7wk3V5S6n/G4WzGxnbVmaKpC8
         +IIzaQbP+7FDFGNE9qOZLc5B/PtUzJ0kmhqdpMD6z6ECjaBJY9aUwNm+i+IPjHXwNy97
         j5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780734096; x=1781338896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gMg6KaYvC+cJxi997viIEAJIuy1B+hppRNVQz2bByc=;
        b=ZCcMXcnRqeHHrmIvyvKigUhaP+bdo5MD3X3F3zqym7KJ9LQf+a/asRoQ9Zvdo51yve
         XujCp727AKFRywmz2OEkRuvNQG9/TNw9wsmPXpopr6ehzu15NcmLIiSVoJfvcoypcu0S
         Cas7lkyDJk3vX3PwZpVXcoVv0BlTMcg5+WjKTywptBWvohpUsFsLEUwHNfhhP76CGes7
         o+PEJaIqlMT9IdWCKtoDe8RFOcjO1jUWMJvBR8A+SyMKb7uMrS1O2JzfIuWaepOKkBEk
         nkMnLFQLZYtJHsA3XGZmjZCalW5B6oA4pWum722WgT0LuVOLoj2XDD/bkTQJRxA0UcUI
         90ZA==
X-Forwarded-Encrypted: i=1; AFNElJ/KN1A7cZesu67TKX4r3V+oeApaoF9gE/U5PajZFM8BRX8GZrnWjwaMOK6dGOHAftZcQSa1ipg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzEEcetCJ2ZoKxTb2HpA8R3RrKX2H+/WZZoQrxCXAn4OSO3FYN
	jtBbIirjXz55Wc1c/OvZ9B1GELmKp8Z2H3B69cojvgJ+6LcMdqbooDEQ75ktnoeqdbI=
X-Gm-Gg: Acq92OHWzV3rP6RRLOF3sPAlucqIyBwv+bZ3pdlkFmbvkEKCS7W0wxJHVpxLy4Lg6c2
	rAhjNDEr/nYcWKTCx09NgJtMFdeIycyQloOOvEN4T9ErznVpRerz7GV9gYn+uPZ5znyfjaqZtB7
	EIU7H0ktzzEX6nGsYtJmCiCf77sPcN5Z1CQTodOfnu1CcG71kTLeTZnHW5ciYmvqp5IwoSPZjQk
	QEdrAWQ5uMLlJHLqOOAXz0jRu510eAV1rkA3QzuLl9jGrxspj2DzgvqaCTpiiLgDqzemD8Zi8mM
	PWep2KwHriBB1XIMNnqIC8HXiEZbnjYVvnEx5rZWAz/OW/Ha5FzanmNSpsB7xU5jn7AFeG6oHIF
	x4Rb4FrmgVusFy4s2Rr9ObN3EF/gVTyyf1zJYrLs+bnqZVTW3n+MTwh2HGyGVmTZ5+rqNWN7fyt
	yV8VgF+RLo6oEV5zsG+VdYdq/3lEqrX4I4bEq7mS7TPUb/pSkxk+n6jmgn84CaXFsK
X-Received: by 2002:a05:600c:4e4c:b0:490:bb3e:30b0 with SMTP id 5b1f17b1804b1-490c25b2ab5mr131639785e9.4.1780734095644;
        Sat, 06 Jun 2026 01:21:35 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d4891csm82571075e9.1.2026.06.06.01.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 01:21:35 -0700 (PDT)
Message-ID: <a63eed7d-b674-4830-a690-1b55dfdc9a72@blackwall.org>
Date: Sat, 6 Jun 2026 11:21:33 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
Content-Language: en-US, bg
To: Luke Howard <lukeh@padl.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Max Hunter <max@huntershome.org>,
 Kieran Tyrrell <kieran@sienda.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
 <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
 <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
 <d0e650fb-4011-4d64-9780-a0ddd0ca1cf3@lunn.ch>
 <CCF20D32-6C9F-49DC-9838-592EFB5E88D2@padl.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CCF20D32-6C9F-49DC-9838-592EFB5E88D2@padl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296077-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:andrew@lunn.ch,m:cedric.jehasse@gmail.com,m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,nvidia.com,lunn.ch,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,blackwall.org:mid,blackwall.org:from_mime,blackwall.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A09B64CEAE

On 06/06/2026 11:02, Luke Howard wrote:
> 
>> So it sounds like you first need to work on the software
>> implementation and expand the simplified version with the features you
>> need. You can then add support to accelerate this by offloading it to
>> the hardware.
> 
> Agreed.
> 
> The definition of Dynamic Reservation Entries in 802.1Q (clause 8.8.7) might support the addition of a new MDB (or even FDB) entry state to the kernel:
> 
> - add MDB_DYNAMIC_RESERVATION (a state, not a flag);
> - the software bridge only _classifies_ packets against  MDB_DYNAMIC_RESERVATION entries, and only when MDB is authoritative. Classification sets dynamic_reservation_hit on tc_skb_ext;
> - dynamic_reservation_hit is visible to the flow dissector so can be used for policy enforcement.
> 

See, saying the bridge has to classify doesn't sound right. Why not do the
classification where such operations are usually done, e.g. tc?
You have to manually designate these entries anyway.

> Advantages:
> 
> - the new MDB state maps well to 802.1Q;
> - minimal changes to bridge;
> - actual policy (reclassify, drop, etc) is left to the user;
> - doesn’t require a new tc-flower entry for each stream DA;
> - entry state maps 1:1 to mv88e6xxx AVB_NRL ATU EntryState.
> 
> Disadvantages:
> 
> - no unicast support, although potentially can be extended (there are some subtleties);
> - mv88e6xxx support would either require rich enough tc-flower support in TCAM, intercepting TCA_FLOWER_DYNAMIC_RESERVATION_HIT and mapping to native AVB admission control, or a per-port devlink parameter (not so nice).
> 
> This is implemented and working with the software bridge, I still haven’t quite figured out the right mapping for mv88e6xxx.
> 
> Luke
> 
> PS. I previously incorrectly asserted that 802.1Q required dropping frames with AVB/SRP PCPs but without valid dynamic reservation entries. 802.1Q discussions priority mapping in clause 6.9.4 for traffic from SRP boundary ports (those not participating in SRP). In practice I think this should all be policy, e.g. you might want to reprioritise valid DSCP traffic from within a SRP domain, or drop instead of reprioritise, etc.


