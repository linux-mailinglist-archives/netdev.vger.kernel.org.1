Return-Path: <netdev+bounces-270243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEx0AZvqvmnzjQMAu9opvQ
	(envelope-from <netdev+bounces-270243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:59:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A462E6E0C
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0CA6300A769
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4736A2E5B21;
	Sat, 21 Mar 2026 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="meaJgqlb"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD73230D0F;
	Sat, 21 Mar 2026 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774119575; cv=none; b=O8cQTkVfehCmFyWZ3kE7sGQWJnn3pal9VD7MPFYXtclHLvawoEJBjwysumYbb342wkj1eNVygwq6lEw5bv6Pf+J3H4iwRN6T9zPXE+2HH347irh/KYBYa8O9lU17RZjfasLUWgbM7x18cposagKMAa3q9MeBccKs54PW7Jc0hKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774119575; c=relaxed/simple;
	bh=EM6B7KnMN6pN6Wls9p1SUSWPPyrTsIdsGAx/ocLn7HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jbv/1RJWHEj9k8WqB9+LUZoxALNkqZmBVTGmngjsvc/E1wgfl2FhcT9j3AgxdeUKIohqTFVFcR6IPkIFvEukEh6jh4LvU+9Zl6CIq+YL3kYZT/RowPuA2pn4I48+41LPtWpu3N0TYKWAwzAjPSTmCsIKHnQmVEOLxFcjiDlFbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=meaJgqlb; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fdTJ145HPz9tGC;
	Sat, 21 Mar 2026 19:59:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774119569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xwK9Zdkdfh44gOBfUOaVfMU+aaMqtJrGLBYJa23K74=;
	b=meaJgqlbolEuvmHGIHra8HUWlrSHpaxTFAEadGnZoxHDBoApLWSanP2pVNXhlqSotsmjL9
	a3o2Xi/sdGP4ZNIM9NSYYY75NMvAj/uIdbsr3gPWqPvWoqo+ddNz6sP86qR67guQAMo7R6
	Znk8tEVfyl07N9Fv2YSlwOZwmRlCZySlYNjHLnD91q1bl8T/tktq+xSf0Iz/mIHLadBMNr
	4OifFDilDDEfzN30Uh1gJmBQsqsbWx7cTZtv5JipXl3P8BH3kvuWWqGn6Vb+9vcNdWy3W9
	qNd7x+0waoi5vCsukAy668kuG4WxLwBzyH64PCdBZHYj6ZPIbwZVXfAaPHOLng==
Message-ID: <b47b7fb0-4859-41f7-810d-b9ad59934db2@mailbox.org>
Date: Sat, 21 Mar 2026 19:59:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH v3 3/3] net: phy: realtek: Add property to enable
 SSC
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Ivan Galkin <ivan.galkin@axis.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 devicetree@vger.kernel.org
References: <20251218173718.12878-1-marek.vasut@mailbox.org>
 <20251218173718.12878-3-marek.vasut@mailbox.org>
 <a37be87a-e1aa-443a-9005-da62e4f51d63@mailbox.org>
 <d6c83860-85ba-4a99-b2ab-486ad040ea55@mailbox.org>
 <20260228110257.bowskqkl3ujv3ri6@skbuf>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260228110257.bowskqkl3ujv3ri6@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4474442b20a2512b3a0
X-MBO-RS-META: hhy8us7hhfn4jt5yn413w67cefm4p7jz
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270243-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,wp.pl,lunn.ch,kernel.org,google.com,gmail.com,axis.com,fossekall.de,redhat.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53A462E6E0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2/28/26 12:02 PM, Vladimir Oltean wrote:
> On Sat, Feb 28, 2026 at 04:57:25AM +0100, Marek Vasut wrote:
>> On 2/4/26 3:25 PM, Marek Vasut wrote:
>>> On 12/18/25 6:36 PM, Marek Vasut wrote:
>>>> Add support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
>>>> RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. The implementation
>>>> follows EMI improvement application note Rev. 1.2 for these PHYs.
>>>>
>>>> The current implementation enables SSC for both RXC and SYSCLK clock
>>>> signals. Introduce DT properties 'realtek,clkout-ssc-enable',
>>>> 'realtek,rxc-ssc-enable' and 'realtek,sysclk-ssc-enable' which control
>>>> CLKOUT, RXC and SYSCLK SSC spread spectrum clocking enablement on these
>>>> signals.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
>>> Is there anything that should be adjusted in these patches ?
>>
>> How can we proceed here ?
> 
> The state in Patchwork is Deferred. You were told that you submitted the
> series in the merge window.
> https://patchwork.kernel.org/project/netdevbpf/patch/20251218173718.12878-1-marek.vasut@mailbox.org/
> 
> It won't be applied as is (needs to be build-tested again on v7.0-rc...),
> so please resend.

I now sent V4.

