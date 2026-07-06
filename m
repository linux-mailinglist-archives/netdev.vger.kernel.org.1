Return-Path: <netdev+bounces-304971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L2x/DGOiS2qwXQEAu9opvQ
	(envelope-from <netdev+bounces-304971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 14:41:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71441710A3F
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 14:41:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leemhuis.info header.s=key2 header.b=i+KwKcdS;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304971-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304971-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DCE330CB861
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC343CB8E6;
	Mon,  6 Jul 2026 10:44:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7C3AFAE0
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 10:44:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334699; cv=none; b=BkYfiFjK8i2/2MWzpvSHU/HpiHhg88CNKA6Zpx0qkgnNFdYCSls0uBrzYv7/S+MCVvF3Sbe94jut96FLL/NObM23118b7e4ySyPg+uhkkztqX5fk6576bhZySxXCqDXyD1St2hpEtgKW+LanX4Ff88UaHypdURDACG3MFRULkos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334699; c=relaxed/simple;
	bh=JjuKGHr5f1tMgUDW2DbGgYzImER6dPYjPVLgbValBZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+j4STapabTh0NYySfHdXvgx53Ak30by5KEuHs1cmWwc5AlF76Pex5HV/DEz4n2X96ExzRdkBsSVYwO7dYdXPSlWg8avkruV6PDRo8qZhXFNdWFu6foO9tZ40UozTqOA7o5HutEU0M40yywO9hA19UOx7NFsTrCw54KhaMgCMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=i+KwKcdS; arc=none smtp.client-ip=188.68.63.102
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4gv1Fm3Wdbz67pg;
	Mon,  6 Jul 2026 12:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1783334684;
	bh=JjuKGHr5f1tMgUDW2DbGgYzImER6dPYjPVLgbValBZw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i+KwKcdSU2UzSh0QdQ9DFQWbENkhDRld1LBCIm23wdnKNE/W76WREhx2SLKUt32JG
	 s8+XGTHY+295AbBxqzd0e8NPWXF9N2u7Wx6NuxCD89NvghgR8vrGX+Ty5N3d3KH8h+
	 b7gz0EZa2gQ89CNEtYH8TpcZOBQFg1J6zzP3YbEfvodiIon0gdbRzSUTH/852eCqk1
	 0rL6tqEUUhs1dFcjJ1HF7l49TTdRRWI2utso2YkvOQ0dfEGb8wqDLCU9fklw7CTMuL
	 lRnIDJ50VQYGRzBVKVErbj3cAAOT45x0FqDF0XFWl3Z+BkFh4e5evZ+UdntVXzl5Mq
	 krOkpFoAvXE2A==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4gv1Fm2mwdz4xrQ;
	Mon,  6 Jul 2026 12:44:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gv1Fk2sy7z8tcS;
	Mon,  6 Jul 2026 12:44:42 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 187B95F96B;
	Mon,  6 Jul 2026 12:44:37 +0200 (CEST)
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <d97ce247-fe77-47e8-afbd-b239a1f39b3f@leemhuis.info>
Date: Mon, 6 Jul 2026 12:44:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CL37 autonegotiation not working on amd-xgbe
To: "K.R, Prashanth Kumar" <PrashanthKumar.K.R@amd.com>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 Jakub Kicinski <kuba@kernel.org>, "Banavara, Madhu" <Madhu.Banavara@amd.com>
Cc: Patrick Oppenlander <patrick.oppenlander@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: 
 <CAEg67GmFS0Q4oSZkz8zWdOzckSth9_vBPiOy6a7-d697C2w2Xg@mail.gmail.com>
 <20260427162839.350135c8@kernel.org>
 <fa98f520-7539-42c0-a8f4-1858553946fe@amd.com>
 <59207b24-4fc1-45ec-b34d-359e1d247c54@leemhuis.info>
 <MN6PR12MB8513D5386E2A586BE4FC68D7CF102@MN6PR12MB8513.namprd12.prod.outlook.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <MN6PR12MB8513D5386E2A586BE4FC68D7CF102@MN6PR12MB8513.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178333467748.682906.1968513969677098489@mxe9fb.netcup.net>
X-NC-CID: OguUympBzJUO5agnLOU3TOnpfS7GmR92XdOEbGc0oWrL5kK8M/8=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TAGGED_FROM(0.00)[bounces-304971-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:PrashanthKumar.K.R@amd.com,m:Shyam-sundar.S-k@amd.com,m:kuba@kernel.org,m:Madhu.Banavara@amd.com,m:patrick.oppenlander@gmail.com,m:netdev@vger.kernel.org,m:regressions@lists.linux.dev,m:patrickoppenlander@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[leemhuis.info];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71441710A3F

On 6/4/26 08:51, K.R, Prashanth Kumar wrote:
> On 5/6/26 05:55, Shyam Sundar S K wrote:
>> On 4/28/2026 04:58, Jakub Kicinski wrote:
>>> On Thu, 23 Apr 2026 10:18:49 +1000 Patrick Oppenlander wrote:
>>>> A recent change [1]
> FWIW, that was 42fd432fe6d320 ("amd-xgbe: align CL37 AN sequence as per
> databook") [v6.16-rc5]
> 
>>>> stopped CL37 autonegotiation from working on amd-xgbe hardware.
>> Thanks for the bug report. Prashanth will maintain this driver going
>> forward.
>>
>> Prashanth, can you address this bug? Also, please update the
>> MAINTAINERS list by dropping Raju's name.
> Any progress? It looks like nothing happened to fix this regression since above mail, but I'm looking at things from the outside and there it's easy to miss something, so please tell me if that's the case.
> 
> Thanks for the follow-up.

Side note: please fix your quoting, it leads to confusion.

> A fix has been identified and a patch is prepared. We are currently running regression testing to ensure the fix does not introduce any unintended issues. We will share the patch on the mailing list once regression validation is complete.
That was a months ago. Any progress? Didn't spot anything on the lists,
but it's easy to miss something.

Ciao, Thorsten

