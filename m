Return-Path: <netdev+bounces-302306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AUOjFvdgP2qXSQkAu9opvQ
	(envelope-from <netdev+bounces-302306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 07:34:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF126D12F3
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 07:34:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=HG8ufkzV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302306-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302306-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D54C30254C2
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 05:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A723537F9;
	Sat, 27 Jun 2026 05:34:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5E92FFDD5
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 05:34:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782538481; cv=none; b=kILc6Lf9vr5pU+aw+FMG4Jo8gDXNupYl3z6mKLxgofhOap+mCzxBN7Q7hLOq9wVBwkCwz+95gBiEvcKfAct+Q9W0lMXNt6/8SZinW/aDRJKrmxLGmOxJvknOtYSUKAvaXJ0606QLAuKSNvGECSQBrTaS99bwh5u6MOT7w7Ey6r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782538481; c=relaxed/simple;
	bh=Lc67fDfzAHgdQDca2Bkf0o6FdhNVsNDsGMzoxLvTEe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZDa0EAjjzOKJ0ewENJV4ikayEQtJinAWbh0v5Cyi1JzeXVgx2kPcROxKp+4x5/pYviH6+KaHeiiVcExApsAiqxi1YJECSu4KPN+hl+ZZBhRQa7JLf4y/tSLWfgmzKmGmDuWVMTeSUBES0wppqd/u/NZNQwMaeVGMum1ynllWNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HG8ufkzV; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 192D44E409E2;
	Sat, 27 Jun 2026 05:34:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C8F9B60233;
	Sat, 27 Jun 2026 05:34:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF7FD106F1187;
	Sat, 27 Jun 2026 07:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782538476; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=CRj4z96LHvGMoyZtYopxhImpYIXmGbPsbFs8FpUj9KE=;
	b=HG8ufkzVveQlXEJk1/YLHqNoEkFgh5wNcxTHiRNBcqixF3XtWsbtL9oVbYBviAY0HBrNbs
	O7NQraPS7k2mHsirVrIyQnB21SfAyljVeQW58R5Jp5T7HCbRzQlW8BR9LWPEjAfxduwDGs
	nl5qBHklK803FIkdjC9dxI4pse+SHWtUUDWHr+UJZ+fRpwlA2X5EKV7xR1YoUmqmaMScYA
	ebsqQgJS7xalujwtJornv6fz5kg9XhXLXcx2i5CHmUiylcHr0pVnavG4Weo4R1Oxx0KX9O
	KnT/Ff+MEtXr/DbkRdt6aTIApT8wX40LPlBhMAcJceky1WG3h/SFrAfp2aqx9Q==
Message-ID: <12b66ea3-42df-4ecb-8eb7-44471407b83f@bootlin.com>
Date: Sat, 27 Jun 2026 07:34:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <20260526172447.10ca4b9e@kernel.org>
 <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
 <38bafe7e-d419-46f7-8fa7-87e9183e578c@bootlin.com>
 <58f37d6e-973b-4242-be82-0561ccdb1a6f@lunn.ch>
 <65d26fd2-fbb3-49cd-a9ac-07863d9a8909@bootlin.com>
 <5b7dbdbc-93fd-4664-abad-0f47855fab55@lunn.ch>
 <20260626173352.7dc8f106@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260626173352.7dc8f106@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302306-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:o.rempel@pengutronix.de,m:vladimir.oltean@nxp.com,m:f.fainelli@gmail.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFF126D12F3

Hi Jakub,

On 6/27/26 02:33, Jakub Kicinski wrote:
> On Fri, 26 Jun 2026 14:39:57 +0200 Andrew Lunn wrote:
>> On Fri, Jun 26, 2026 at 10:33:50AM +0200, Maxime Chevallier wrote:
>>>   
>>>> Sphinx follows pythons object orientate structure. So you could have a
>>>> class test_ethtool_pause_advertising, with class documentation. And
>>>> then methods within the class which are individual tests.  The
>>>> commented out section would then be method documentation.  
>>>
>>> Good point, so maybe something along these lines :
>>>
>>>  - A class for the test
>>>  - methods for indivitual tests
>>>  - For readability, I've written what the internal test helper would look
>>>    like (_adv_test), and how a test would look like without the helper in
>>>    adv_rx_on_tx_on().
>>>
>>> I'm already diving into coding, but it helps me a bit in the definition of the
>>> "description" format :)
>>>
>>> this is what the class would look like :  
>>
>> I like this :-)
> 
> This is very far from what existing python tests do in netdev.

We can probably drop the class, as it is with this discussion, it's merely a way
to regroup doc common to similar tests. The rest really is the usual set of
ksft funcs you can feed to the run function, with a set of ksft_ethtool_*
annotators for generic checks.

> 
> I would prefer to stick to the "bash on steroids" use of Python.
Maxime

