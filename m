Return-Path: <netdev+bounces-254869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APEuAyaXe2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:21:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D90BB2C62
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D6803031CF0
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3493344033;
	Thu, 29 Jan 2026 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu0DgLFu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE028DC4
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707175; cv=none; b=uP9c/z+iYq+tRQWu7qyvn/vm+86sxXxgtYFptLJ7ckXZVMBiqf1VI+mvXs01CM+bC4h34bDq+hR34Sx0MxyrZNZ0tfzokOrWQIefai/twwF5n0tv9lcaWTs9KXMrQg9tHVoRplwdGcCMUNBG1T97UB6MGhHnDZw80HUlwxsTbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707175; c=relaxed/simple;
	bh=JAWrFU7vHqS6oBoH7J6k7PgYZoNDXNbj0FUCj9SWlOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pO3QtAq61C62QyaHLV8CQEHXgZFK1OdoPJYNVh+JOKLfL73iwcYrG6FsnP4+q4RuEDK06UjBfYO1KlxpMCNfsssJETw4kwOG9r8ys7zcCOARYK9yXKIZjY2I57VVrTMGwq4rxTPqzoBAbsXKvAfYEo65o3sv10RkXpG1NBktfhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu0DgLFu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d2c96215so1089511f8f.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 09:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769707173; x=1770311973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQAHoAe72kF+hFvj2sT6lTtKxgEAzGcjolt58+bwc44=;
        b=Uu0DgLFuloSW0afu3SYefZxdSDxKoLKkDYO8YXY6K7OuxDzjhQnNk+WpGERogX5EXw
         XNqF+Cfouq65DAMRhhLNWpEgXTgRrI1ZEzjSWMw3QhSyQZIagt4J91yMAyBWpk8g/7nN
         mGcz2uZp3E9omXXqD3LpCO2J5k8eqxRq7PG6+5WERMfQZJcgeChZcaOckXUsv9yeBy8j
         7RKRe3BZoqquQMOCINugMS3CFCmtVJyU3mjXVunDNWCqvkTDMbL5th7Vj4AVgoWU0ILy
         nhbA1R71IMgCJqV8ISsF+0Y5NgVA5jeWtrIebHhvZMuKH/EDUV+Ua8rFJhLQZRjFTiLz
         B1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769707173; x=1770311973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQAHoAe72kF+hFvj2sT6lTtKxgEAzGcjolt58+bwc44=;
        b=dgzZ5Nv1FV9PpWBEaZITgYbLnv/y82QOtVYlPd2pGvbZ/KbvBUoFZfCQ/WKraL8X0i
         apWQf8NBWrtOggTb9+k1NVnQqfLIRpNBzZXndaqsO29HzwsSWU2YtIAvjgrUA3s1oLpL
         YNDPg6mRW3x9WlOHZydFOQNf8H4tXuhUrLv66zydjVnRDnygBbCTOB/UYbGNr1BkJiWp
         k+PEuJ9XC/yfvnIkP2C+k07130vQjfdpYP36QFifKBXczM142wcwK4//kjJMRyDccGjY
         YNavwqMfVQVStvACBADSs7H7DN36BrDUB2BBG23nLSdrC2JhORN6IKu4huZNPFnQ/2oI
         Ihgg==
X-Gm-Message-State: AOJu0YzLagPcTbDX9xSXN55QrQFYTUydJj5QL2Q0y1p3MexhKeQf+PRh
	4F+M2hV5aeDBI9WdU4utW5KNETk6l/NYHU1z+QeJCIsyDZZraDw6bH3R
X-Gm-Gg: AZuq6aJ9g41ctGXGG8/e7d0ntOfy5L2icnUL/QnZKoybVRIE/Tx6C7hUvo1EUVnH23K
	S1iMwToSbI+nYIqkUhpDjrYjxboJ0VRqxce5VPY0whVu9ihKoCdT59kQN+lRI9GUuCukYMVMA4B
	UguZBzJCz/IWCbMYtcs+DHJj50/5fzDWY3mesAIX0KZEKm16BWLrWjdDMwUg+tcLPYPA4+hkJ7N
	5eZUs5Yh6vS4wG4s7hvC023NcGVAcZt7ApM4mln7sGO7Eo32U0w6WvAa7HhStaqahTUiE2kBZLb
	rSWP/C1cOR7/sElGmL0UJExjbOaaVFtUqzwoTcBS0jJn0utq/AvXomJdlKg3M/ebgNWIKAG4AeV
	TeUIyUB6WHGErIDxUasbnLeC9goJn9FBXeIIBArAivs6sVMYmiK5yQ7E9NgTWbE9GDZmXzcMSd1
	fWZi+3mtZxScWCTd4S6282EMsAmCEc8KBZEwKwk1xfaCoGzZU35/4eVYwB5c00hAUDNYi5Nyg9K
	b/L5SgrMiDA2sLhCSnPEiZwDgRiTKlJ5Us27gqdjFGW014qIKSTeET43K84RSo4
X-Received: by 2002:a05:6000:1a8d:b0:42b:41d3:daf1 with SMTP id ffacd0b85a97d-435f3aaa61fmr500999f8f.38.1769707172458;
        Thu, 29 Jan 2026 09:19:32 -0800 (PST)
Received: from ?IPV6:2003:ea:8f0b:f500:2d0a:8724:17dc:1df1? (p200300ea8f0bf5002d0a872417dc1df1.dip0.t-ipconnect.de. [2003:ea:8f0b:f500:2d0a:8724:17dc:1df1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfccsm15077189f8f.17.2026.01.29.09.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 09:19:31 -0800 (PST)
Message-ID: <489999a0-b99d-4b72-976f-4f646f01be08@gmail.com>
Date: Thu, 29 Jan 2026 18:19:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Status of orphaned ltq_etop ethernet driver: mainline vs. OpenWRT
To: Hauke Mehrtens <hauke@hauke-m.de>, John Crispin <john@phrozen.org>,
 Daniel Golle <daniel@makrotopia.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 OpenWrt Development List <openwrt-devel@lists.openwrt.org>
References: <43dff7cf-cb00-4480-8856-501a8313951e@gmail.com>
 <d80fef86-ba14-4bd4-bce5-4d61a75d591b@hauke-m.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <d80fef86-ba14-4bd4-bce5-4d61a75d591b@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254869-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D90BB2C62
X-Rspamd-Action: no action

On 1/29/2026 1:04 AM, Hauke Mehrtens wrote:
> On 1/28/26 21:23, Heiner Kallweit wrote:
>> This driver in mainline lost its in-tree user with commit
>> cd93b4895ea5 ("MIPS: lantiq: drop mips_machine support")
>> in 2012. Since then it has had no in-tree user.
>>
>> Only (?) user seems to be OpenWRT, with several changes to
>> the in-tree driver version:
>> target/linux/lantiq/patches-6.12/035-owrt-lantiq-wifi-and-ethernet-eeprom-handling.patch
>> target/linux/lantiq/patches-6.12/028-NET-lantiq-various-etop-fixes.patch
>> target/linux/lantiq/patches-6.12/701-NET-lantiq-etop-of-mido.patch
>> So it seems the driver is maintained in OpenWrt only
>> (except tree-wide in-tree changes).
>>
>> To me this leaves two questions:
>> - Move this driver to OpenWRT completely?
>> - Or mainline all downstream changes, maintain driver in
>>    mainline, and mainline also the users of this driver?
>>
> 
> Hi,
> 
> I think dropping this from the mainline kernel is fine, if it causes efforts for you.
> This is the Ethernet of the Lantiq Danube SoC, the SoC is probably EoL since 15 years. I assume that all users either use the vendor SDK with Linux 2.6.X or OpenWrt.
> 
> I will not spend much effort on this driver and others will probably also not spend much effort. We can move it completely into OpenWrt and keep it running there.
> 
Great, thanks for the prompt reply. Then I'll submit a patch for
removing this driver from mainline.

> Hauke

Heiner

