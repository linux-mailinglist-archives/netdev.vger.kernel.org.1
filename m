Return-Path: <netdev+bounces-301166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B49gIOljOWrCrQcAu9opvQ
	(envelope-from <netdev+bounces-301166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:33:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E18CF6B1277
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:33:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leemhuis.info header.s=key2 header.b=X2p43JOD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301166-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301166-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D74B7301F5BA
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800431E5207;
	Mon, 22 Jun 2026 16:33:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F2F322A
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 16:33:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146021; cv=none; b=twawgSgL0crhFvsL/sXUSxQ6bABvJD5yFTyxzgGxB0oVcyzxyYHGpyiWwGrU7b6gt0tmBvcuI+JU38iQtp/XqOKfMwBxxcw9QqblHZFub3nyurMavObogW2gJbwfEHjBdm7uhNcEEgYJ1t4dPqzkP8e5W3FZ1KMz1K4eLqfRezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146021; c=relaxed/simple;
	bh=u7K9lHXUeh4A3ylUATa1fQpK3YxiEKxE/CGHOX0yMRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLnLUI8zw+Khd2Yx09OzO/AZnwwp4x+UclwRWzWOFPIa2r5TZJj1e6+Wsew7gvUQayAoFgY4P28EhOkAv/CSUtVRaHnkDRxntO7QZfiPy3ELkqbOXKAkL7bK2d6DciYjoUkzofwtNEplhHlkWeXO/GUeHUTWJ9JuK19U1fC+7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=X2p43JOD; arc=none smtp.client-ip=188.68.63.162
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4gkYfg4qyqz45P2;
	Mon, 22 Jun 2026 18:33:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1782146011;
	bh=u7K9lHXUeh4A3ylUATa1fQpK3YxiEKxE/CGHOX0yMRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X2p43JODEcyKR8bUg/Pu2mFANeIUCjZUcD4yQBdOKMxVs8pQhC6ATuVfnmqfuVNSO
	 YI1CRaPb0ZkdzHDO7C/ZtjBYuuUjGiLqKAZwzKaTIL6vnLuHj1bf4cEHzW0GhWnQLP
	 6xBwhEiWtLsbtEA5VwNoxSmr+Oh4MUu5aM6N+1U7XPz1WCsJKkMp3/1xrKp9g7LflT
	 cxaMwl2s15OoYBs9f6i6URwS879IjlEHoYBEMP4C1WXU9MhBgqlfHsl/z0k5h4tXqo
	 HDaqAISezC9X/VOSiAI1btDfI3gGZxCtMXoJbsR/yBpaIbs5u4+TJbSfCExJCB1hJc
	 ka1o31malOAxg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4gkYfg44txz44QL;
	Mon, 22 Jun 2026 18:33:31 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gkYff22Nwz8sZP;
	Mon, 22 Jun 2026 18:33:30 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 90638603DA;
	Mon, 22 Jun 2026 18:33:29 +0200 (CEST)
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f88cfe04-c817-4383-866b-530c5bc5bd95@leemhuis.info>
Date: Mon, 22 Jun 2026 18:33:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: building ynl afaics requires updating the UAPI headers first
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev <netdev@vger.kernel.org>,
 Riana Tauro <riana.tauro@intel.com>
References: <ade91456-2f93-442c-b76c-28bd7157f074@leemhuis.info>
 <20260618170605.0e2e4dd4@kernel.org>
 <cec7685e-df12-4501-b851-9c8f7b8b06cb@leemhuis.info>
 <20260622090534.2af8ae9e@kernel.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260622090534.2af8ae9e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178214600991.4121450.5074439885049923709@mxe9fb.netcup.net>
X-NC-CID: /QJyIQzAANWNowCF4AipS/kcQQAMEmlKmtKotQQfsS1jA7wFoeI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301166-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,leemhuis.info:dkim,leemhuis.info:mid,leemhuis.info:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DMARC_NA(0.00)[leemhuis.info];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:donald.hunter@gmail.com,m:netdev@vger.kernel.org,m:riana.tauro@intel.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[linux@leemhuis.info,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E18CF6B1277

On 6/22/26 18:05, Jakub Kicinski wrote:
> On Fri, 19 Jun 2026 09:28:47 +0200 Thorsten Leemhuis wrote:
>> On 6/19/26 02:06, Jakub Kicinski wrote:
>>> On Thu, 18 Jun 2026 15:39:46 +0200 Thorsten Leemhuis wrote:  
>>>> DRM_RAS_CMD_CLEAR_ERROR_COUNTER was introduced to mainline yesterday as
>>>> ee18d39a087792 ("drm/drm_ras: Add clear-error-counter netlink command to
>>>> drm_ras") [v7.1-post].
>>>>
>>>> I finally looked closer today and noticed how to prevent this: update
>>>> the kernel's UAPI files (e.g. the stuff that lives in /usr/include/) on
>>>> the builder. Thing is: that's basically impossible to do from a srpm, as
>>>> those should not change the build environment and can't even when
>>>> working as non-root.
>>>> [...]  
>>>
>>> Can't repro for some reason, but we probably need something like 
>>> commit 46e9b0224475abc to add the explicit include rule.  
>>
>> Thx for the pointer. So I guess you mean something like the below,
>> which did the trick for me. Will submit this as properly, unless
>> someone points out something stupid in it.
>
> [...]
>
> Looks good, did you send it?

No, because the funny thing is: now I fail to reproduce it myself. And I
don't know why, as 24h earlier when you had written "Can't repro for
some reason" I had once more checked that I could trigger this by
downgrading Fedora's kernel-headers package to a version from some weeks
ago. Not sure what changed since then.

Want me to sent it nevertheless?

Ciao, Thorsten

