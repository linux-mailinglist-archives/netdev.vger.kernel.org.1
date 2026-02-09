Return-Path: <netdev+bounces-257929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGJqLu+6iWmEBQUAu9opvQ
	(envelope-from <netdev+bounces-257929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 11:46:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DDB10E47C
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 11:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94911301ECFC
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 10:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77187368264;
	Mon,  9 Feb 2026 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YF/F6hZm"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E519367F52
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633845; cv=none; b=NvBLOxknocO0wnsB4sXspi9QzxVGjpREaXDWXBLJvvjsYL2cZTsyPxTIre0wo+YueJ/hlGNKOxaK6IJnhh4p5qXEbW33nK9e6tX+Xj2CItacmhKdBUjW2i2RthsDJ6zo9wiEvAfmlBIi5ABN+KHYXW74+8w0YNopZZr4f2g7H5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633845; c=relaxed/simple;
	bh=KPdrSSVeXDv3a0A+bKuqk0XJOqTNqwZOKoMAc0HDxIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaJjli3SHdaE+FU5vVZsZm+69tVX8CpszV3J5zFkRFaEM8Omm9lxyLI8CWA2NeVtRodQMWBzmnm+vqoykT8foALOyuSyTDs6UNzBTEGWNCkte3mEqx4Py42fumnah48xs6du7MfLUXHbK8IdIlxnKobB5zjHymTv4n89taOV1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YF/F6hZm; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770633841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2IQbg3EuRQv0ZXMFr8IH+0gBnowsk1pZP6YBjPZW0Y=;
	b=YF/F6hZm/vwgeSDSvzouBC+ViBsrDG5LVxECAjdUZ+4Y3hs8dbRL8f8Lr5tjYqTkk00wkv
	PosVz6iUp/Jn28OlZEuFTuPBqz+G630U2vfAjLh+TgLm0SDYkADmydApFbXUsIqB1nJx0A
	oeeMw2q5as0j1+UKj2WfNjXh/URoB7Y=
Date: Mon, 9 Feb 2026 10:43:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>
References: <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
 <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
 <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
 <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260209090621.GiZqTiMJ@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257929-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,davemloft.net,intel.com,linutronix.de,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 16DDB10E47C
X-Rspamd-Action: no action

On 09/02/2026 09:06, Sebastian Andrzej Siewior wrote:
> On 2026-02-08 11:25:40 [-0500], Willem de Bruijn wrote:
>>>>> But it's more like a question to maintainers whether it is acceptable
>>>>> way of "fixing" drivers or it's no-go solution
>>>>
>>>> Requiring OPT_TSONLY unless CAP_NET_RAW would break legacy users.
>>>
>>> Well, they are kinda broken already. Without OPT_TSONLY and CAP_NET_RAW all TX
>>> timestamps are silently dropped.
>>
>> Are you referring to sysctl_tstamp_allow_data?
>>
>> That is enabled by default.
> 
> Yes. If so, then we don't need the check below which requires
> sk_callback_lock.
> 
> Are SIOCSHWTSTAMP the legacy users or the ones which do not set
> OPT_TSONLY?
> 
> I would suggest to move the CAP_NET_RAW check to the point where
> timestamping is getting enabled.
> Also if ndo_hwtstamp_set is the preferred method of getting things done,
> I could check how many old ones are can be easily converted…

Looks like you are mixing things. SIOCSHWTSTAMP/ndo_hwtstamp_set are HW
configuration calls while OPT_TSONLY is socket option, which is setup 
via setsockopt, you can find points searching for
SOF_TIMESTAMPING_OPT_TSONLY in the sources, basically
sock_set_timestamping() is the function to check

> 
>>> To receive these timestamps users have to get
>>> CAP_NET_RAW permission, and it will work with the updated logic as well...
> 
> Sebastian


