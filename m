Return-Path: <netdev+bounces-289810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INm1GaZiDWquwgUAu9opvQ
	(envelope-from <netdev+bounces-289810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:28:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4E7588F2F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C43DD30055E3
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 07:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BB6369D71;
	Wed, 20 May 2026 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k/gph02s"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D8E34DCC8
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262112; cv=none; b=I48z19q+mnLCHtm/kEmVW28aKmcK/Q0AbHkAVboGdN2jKYuVtSG4duUGYoUEDu/ZEF07/lM2WdRZICK1SuhOxCmj9FNzuZtymyxqjhQYVdIdBEBb9DQmXHib+SxeSXhpgSAvxZOlhyHyGhBwQMFo68Y0M8M/ca9/21jjoT1SO54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262112; c=relaxed/simple;
	bh=JCJFfdLKOXWLw+lPbUx2sXT4Z/Qydb5arHJKQqBkmFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aeuk4SVIDlvp/lQ9IkXI866iqedEtd+lrkOhIgfB/JhTvB1/o0BoqxM3FGIMKmGPwj7Nt5iJ6dJrBO2uOlMcbeQWhHKVpqqMYB30P1tGRN8H4W5LnBO4jomSQjp1daQyzyAZ8UcrSG/wGeOhqqqXK22jmnLre+kKygaf9cWNOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k/gph02s; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F1D6C1A363B;
	Wed, 20 May 2026 07:28:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B74C56070E;
	Wed, 20 May 2026 07:28:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A397107E9CC9;
	Wed, 20 May 2026 09:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779262107; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=I7L0B4zuJvU5VGGd4jsf1N+GzT9Dz3BE0MhokQDV5K4=;
	b=k/gph02soOpNxhtgf0jHjSDzxtUS6q1YG8RdzDhXdyfZ9dTn6l9dZK1EKYK1eRvl033vyj
	1cpBLMmxA4aMEehLZuxG2B6ANWv8SW7PS1ofpgwQL7XQb7cYlWlvK2YRCqeDDNp7LIcgM5
	g2SSKlSKGDdHbtBk4kPSiipXmfDlUuXz/+UntoLgG3dbP6sqV6D+UtbKW4pZHeijoBj1Dz
	wxmv0G7BifDh0yDoeoiWHQ5JbfutjZugGVG6sUQYsRfKGJVUAd6D1TIo6u7mTi+3BPFMLk
	xl35y2rxd9+FoBcPiuCMnnQY5gkWlSY1/evyjrzDMFVlRdTJal6wrDntX4hKdg==
Message-ID: <b1eb4c18-7dd9-4c40-97c8-81e277332228@bootlin.com>
Date: Wed, 20 May 2026 09:28:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 6/9] net: phy: phy_port: Store information
 about a MII port's vacant state
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>
References: <20260513130521.1064094-1-maxime.chevallier@bootlin.com>
 <20260513130521.1064094-7-maxime.chevallier@bootlin.com>
 <97cd33a0-ee74-4f64-b11a-bb5b88bce79a@lunn.ch>
 <c68f3abd-7a3d-4d37-9589-02433bbd5c5c@bootlin.com>
 <d7086094-9f8b-4d18-92ae-e278b4e67658@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <d7086094-9f8b-4d18-92ae-e278b4e67658@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289810-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:mid,bootlin.com:dkim,phy_port.id:url]
X-Rspamd-Queue-Id: 5E4E7588F2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi again,

On 5/15/26 15:12, Andrew Lunn wrote:
> On Fri, May 15, 2026 at 09:22:29AM +0200, Maxime Chevallier wrote:
>> Hi Andrew,
>>
>> On 5/14/26 15:58, Andrew Lunn wrote:
>>>> We have information about what MII they can handle, however we don't
>>>> store anything about whether they are currently connected to an SFP
>>>> module or not. As phy_port aims at listing the front-facing ports, let's
>>>> store an "vacant" bit to know whether or not a MII port is currently
>>>> vacant (i.e. there's no module in the SFP cage), or not (i.e.
>>>> there's an SFP module).
>>>
>>> vacant == False actually means a bit more than there is a module in
>>> the cage. It also means that, so far, we have not had any errors
>>> trying to use the module. If there is an error, we might have a module
>>> physically in the cage, but vacant == True.
>>
>> This is a good point. Even with an error, we should have vacant = false.
>>
>> TBH I'm unsure how to name this, vacant may not be the best word there, but
>> I'm struggling to find a better term.
>>
>> maybe "empty" ?
> 
> My comment is really about, what do we mean by vacant/empty?
> 
> Is it simply about there physically being a module in the cage, or is
> it also about being able to drive that module? If it is just about
> there being a module in the cage, then vacant/empty is good. If we
> also want to say that we have been able to read out the EEPROM and
> determined the module will work in combination with the PCS and MAC,
> then i would probably use a different name. "usable", "compatible"?
> 
> Either way, i think the code either needs simplifying, or made more
> complex.

I've given this a go, and now I remember why it's that way. In a 
nutshell, if something fails during .module_insert() (e.g. module isn't 
compatible with the MII modes ont the cage), then .module_remove() isn't 
called, so we can't track module presence unless we add that in the sfp 
code itself.

However a better way to deal with this whole situation may just be to 
store the presence information in the module's port itself, as the 
parent port id :
                    phy_port.id = 1
                   /                   phy_port.id = 2;
                  /                  / phy_port.upstream_port = 1
+------+     +----------+     +------------+
| MAC  | --- | SFP Cage | --- | SFP module |
+------+     +----------+     +------------+

So, we lose one piece of information, that is "is there an SFP module 
present, even if the module doesn't work". It's now indirectly present
as "there's another port that references the SFP cage port, hence it's
not empty".

We gain however information about the topology, and this is relevant for 
combo-port support :


                    phy_port.id = 1
                   /                   phy_port.id = 3;
                  /                  / phy_port.upstream_port = 1
+------+     +----------+     +------------+
| PHY  | --- | SFP Cage | --- | SFP module |
|      | -   +----------+     +------------+
+------+  \
            \   +------+
             -- | RJ45 |
                +------+
                  \
                   phy_port.id = 2

If we want to allow userspace to select which port to use, the following
commands will be equivalent (the command itself isn't set in stone, just 
a rough idea of what it'll look like) :

# Force using SFP

   ethtool --set-port eth0 port 1 force-active on
and
   ethtool --set-port eth0 port 3 force-active on

These commands above should be exactly equivalent

As they act on ports, having the relationship "port 3 is actually 
controlled through port 1" readily available will ease the implementation.

If that's ok, add this change to the next iteration (only the GET part, 
not yet the port selection :) )

Maxime

