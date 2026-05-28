Return-Path: <netdev+bounces-292615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGjmHGgIGGoaawgAu9opvQ
	(envelope-from <netdev+bounces-292615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:18:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D8A5EF702
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 578CD30DCA2E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5363639EF2A;
	Thu, 28 May 2026 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYdcj6a3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqCGTfej"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD4A360ED2
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959512; cv=none; b=tgt2/VYBz2LTmn/jmUSlDy8Y70/rTIqrxy9mD8PIxH6+vU0lyIhkTHRvQU+NZ1ty/lT6W5EelDVWquTMUQ2xHIpYgZF/g/oVvOZjdoEzD2Fe76sKv8YVZXUqGqeVA2cGiO/a3cRfYsv0fMONDYIr4Wa+EUUOYqmInAccKaEoBDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959512; c=relaxed/simple;
	bh=pUOefxLKRD/8nIsLy1D5xsRSLGkcrMh6iOBWFi2AZL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSKJHkuVtHCzuXyVsZjyiNWENTT9W1llru5Q+yR2Lg3nF0oIOl3gNppofSMqIRAqpI5WiS/8NnJjRoPCQ9KY/HmovhT1SpaanYQJkeGgfjBhE1Gj/e+BOE4VPgED3bvXVtoKbQi8SfhIn4dxz05Sn4dAt82VdZ5mgsC/V8wA0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYdcj6a3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqCGTfej; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779959509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mN29L0/PsDx4KgsXr/3kO5bmaCD9RTyqP1jmd8OFwPI=;
	b=XYdcj6a3Ngp5w7Dm0NqLNIUN4tUTPhQK2EaevIdqcr7Zig/BqwLT1cVftsgB+SZSaxPS4n
	jH23VAIflLT13ggkMBd3vHwZj5zOUoWef0rot53/7iK46RQUhYjJN9fkgxadhxhcpzrolX
	KnH73hq+Zk1rJnDvTZ6kdyMWRj1EXd4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-4gby9X6QPRS4x5L4hO3itw-1; Thu, 28 May 2026 05:11:48 -0400
X-MC-Unique: 4gby9X6QPRS4x5L4hO3itw-1
X-Mimecast-MFC-AGG-ID: 4gby9X6QPRS4x5L4hO3itw_1779959507
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49051422d55so56908055e9.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779959507; x=1780564307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mN29L0/PsDx4KgsXr/3kO5bmaCD9RTyqP1jmd8OFwPI=;
        b=eqCGTfejjIh4Mnf8dI0gOF18qsrMhJUsrmaAbJuhgbxR/OsKXN1H9t3l4tDaeVkMl1
         ReG+ZCUcthOQY6QrM6q8GqrbKfmF/27ivXgqySPa7OM7JDTehyk3Dvr64KlIUSsrUzpm
         eGTq23nhHHw1d5YseIOyABwpX9paEoH9CK6hC4Bj6FoQVb09Qf4JL8exh3R/1rAVp+m5
         iJfAn3EMMXDAqRg7I6v5sw6aije5mKOtbdSWPsojzUiksC9666CdHXyAxuoq37ls/Irs
         59A8p3S//8h2RXz6naBd1Y1mXLdbRrjpPlQhMhZtmsrAnq7ZkotriHj1t7bkXec+zahf
         Thbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779959507; x=1780564307;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mN29L0/PsDx4KgsXr/3kO5bmaCD9RTyqP1jmd8OFwPI=;
        b=FT6D2g9pHghfXo425WcU6Q1XvxCoqBrp4xZwUu+GXl7gRBLN5hHU6HTExprYOCRY1u
         KR1g3EFVto1VHj9xxJ1GAgGrvBKUJKEjiMx1VT8XgsCXm4EJNnn1K2Ou7LkzK/hegvH4
         PjdrCiEqXul2YkG3rsApf1vQJJvY+9oIUvvs20RlZR4UMa8ivp/fd277fa891bwqmO+l
         LqQilr0HoavWc4UbMjzYF0UZuBBjUDJFxXeYp9b8nRp/LneEAPMwYfCAj3o8Xq8n0hBG
         nLhHo4oCdCISPntaxMt7DlGXlnSVv/+11XQVttqsPWE/GrtXzJaFXJyCan9FPmJdwnd2
         x+9w==
X-Gm-Message-State: AOJu0Yzb1LND0CmJFeczPI03jNDl844NNzFkyrqMB9rQ83XCq14VYN5i
	+hTHxMZwS9T5jTKeaWPQZxYhLRL+02DaXOAYlmbnl2TeywxultkCxvHDuuxGeG020EUAoEZ627k
	NDW+vkNUCbYRvIqTsWc5gpM/X9jArPC9Ghs12IL+PAvrZu6+xzriVvG270UxU5oVuhg==
X-Gm-Gg: Acq92OGT64tp8RarDSU8DUMyPh/kCPUaw+JPtcq00Q5blxLQWGNGbBJBL42begDuQ5m
	mEdoAKwoCGso0tg//872Nh5uQfT0ATzaOJxLmawUm1bloJOVtl50J895BUM5cRClJCWrWaCKk2k
	gzOvW38/EG2l766KRtkXEgS3Ocj24WiNxxKmCztKDodRwCcvCdWAyDe+0yADXgtSNO4gdimZgVa
	8HGTP1nFD0D9ggYs+MizSDQ5YLHjcNJJxXROItWDRz8iQ+ZqHeVgwUGVLQrmMAhZYT1ElFDzph5
	zJT7CdroOgojBE6dbwMHtPOkhhdYc/wqsJaJisr2R5qE5Wot7dujN5Fj4NxG9mEtDWRKFDcItpC
	qJLrrIHjUsdBfCtznKPtLvknGwEj51+6muxmYoqKuUk6VsQ2PkRoFLC85eatOdNbBTA==
X-Received: by 2002:a05:600c:8484:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-490426cda54mr472689695e9.21.1779959506863;
        Thu, 28 May 2026 02:11:46 -0700 (PDT)
X-Received: by 2002:a05:600c:8484:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-490426cda54mr472689185e9.21.1779959506485;
        Thu, 28 May 2026 02:11:46 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908b8aa05esm13079785e9.13.2026.05.28.02.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 02:11:45 -0700 (PDT)
Message-ID: <12d45e5e-0d19-46f8-86bf-f14fc5acbee0@redhat.com>
Date: Thu, 28 May 2026 11:11:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/3] ksz87xx: add support for low-loss cable
 equalizer errata
To: Marek Vasut <marex@nabladev.com>,
 Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
 <0a9433d4-6b4a-45d2-9625-c33d502ab674@nabladev.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <0a9433d4-6b4a-45d2-9625-c33d502ab674@nabladev.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292615-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nabladev.com,gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 36D8A5EF702
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/24/26 6:19 PM, Marek Vasut wrote:
> On 5/24/26 12:44 PM, Fidelio Lawson wrote:
>> This series contains:
>>
>>    1. Support for the KSZ87xx low‑loss cable erratum in the KSZ8 DSA driver,
>>       including the short‑cable preset and orthogonal tuning controls.
>>
>>    2. Addition of vendor‑specific PHY tunable identifiers for the
>>       short‑cable preset, LPF bandwidth, and DSP EQ initial value.
>>
>>    3. Exposure of these tunables through the Micrel PHY driver via
>>       get_tunable / set_tunable callbacks.
>>
>> This version follows the design agreed upon during v3 review and
>> reworks the interface accordingly.
>>
>> This series is based on net-next.
> Please note that I provided RBs for V6 already.

As Fidelio stripped them, if you are still ok with the series, you have
to explicitly re-send them. Note that you can reply to the cover letter
and the tag will be propagated automatically to all the patches in the
series.

/P


