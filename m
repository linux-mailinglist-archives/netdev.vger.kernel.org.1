Return-Path: <netdev+bounces-302543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9P5BH/0/QmrS2gkAu9opvQ
	(envelope-from <netdev+bounces-302543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:50:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC036D875C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:50:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=EFpPL8VO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302543-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302543-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2977A300E92A
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF093F8EB3;
	Mon, 29 Jun 2026 09:30:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12737998C
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:30:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725452; cv=none; b=bcJUBqlSEpxae3qGjlk3nRTQZu0ke/807pgaDl91Ws5Y/e3U3PwH/i+pV+CNRAwaEiYd0WRgFMmiEIWiU+ypJFymHOA0xTvmGxDyUPWs4/ZLX90T064VekStAflihUo4cZlK1E8E2Uz0BbgcIimeALMIt3kCp7vc0hgDNKGvOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725452; c=relaxed/simple;
	bh=t1FMdQ1smOG7dSC5qcmD6qxt4wO2Y84/h0+n8e+iADw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ey/7BkDEScveSiQVwwYpHAR6ijF+EbOnsLVQaNxYXgmC0lwVw3DvrMw0XbeV9OaL687RSpzfbSymSL2JYTcffe53MuOMix458p379HeL/GTPLbWbNM9OhJdMcFjx5PO85SZttuARusvr2gR/E01Na0pkv53BWaITv3d0hzX0oGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EFpPL8VO; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CB25E4E40B71;
	Mon, 29 Jun 2026 09:30:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9DD0F5FF96;
	Mon, 29 Jun 2026 09:30:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7067D106F169E;
	Mon, 29 Jun 2026 11:30:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782725446; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ifd0ynvUGQGwkdE3eU1CD0ZPuKRIYA4F4nsjtxLfbYo=;
	b=EFpPL8VOyfgS3I+G9iv61IlYZeQdVOAGqO1vxosq8ZYcXgYDUdh78zSeDQy2skdMxKhqEG
	fr6NsdwilFwIXGxsv23Yr13UUjLN4uZ/PIbNY1vzRcVJ9Jxalo87Y0ZabUkEFhdZdJJblh
	gAZD7NZdSjTcf/p1KrX5ohMpyjQmZw7AOWTWKaXXtblVyFz3tZLoINnNDwmNumm84XoEla
	fhmV2VUn3GTuiBOCWe+7heivGmU/BODzPj8c//50mz1fSYw/z5kfUT3Twy9C1Mwx942EzR
	N4TqnEBEdvpuGwOVCEFTAVrIzlVpz2Z5xJCSpIdwSWiB5lUNjSWt1nl2EYiP1w==
Message-ID: <1b3975a8-788a-4b81-94ec-3ab5708b251b@bootlin.com>
Date: Mon, 29 Jun 2026 11:30:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
To: "D H, Siddaraju" <siddaraju.dh@intel.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Das, Shubham" <shubham.das@intel.com>,
 "Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
 "Srinivasan, Vijay" <vijay.srinivasan@intel.com>,
 Michal Kubecek <mkubecek@suse.cz>
References: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2994edfc-0894-49c9-abac-6daea5e12075@lunn.ch>
 <MW4PR11MB6912BE7FEDE5C509B6C5D5DF9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2baa5a77-3305-4ed9-b56d-ba27cecc1911@lunn.ch>
 <MW4PR11MB6912BABFEED268D38B4BC2BB9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <MW4PR11MB6912BABFEED268D38B4BC2BB9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302543-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:siddaraju.dh@intel.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:shubham.das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,m:mkubecek@suse.cz,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AC036D875C

Hi,

+Michal

On 6/26/26 21:19, D H, Siddaraju wrote:
> Sure, thanks for pointing them, Andrew, will follow.
> Now I realized what you meant there, thank you for the quick feedback.
> 
> About options,
> Ok, got it: "option-(a): renaming *10000baseCR*" is out.
>   Sure, will support this from uAPI backward-compatibility point-of-view.
> 
>   Just to highlight Maxime, yes during exploration, we too came across
>   those few vendor products. But when we looked further to understand
>   which standard those 10GBaseCR cables were following, we found they all
>   explicitly call out that its SFP+ DA conforming to SFF-8431.
> 
> What about
> "option-(b): create a new enum ETHTOOL_LINK_MODE_10G_SFI_DA_Full_BIT"?
>   Idea is just to create a new enum, with same enum value of 10000baseCR.
>   This will NOT consume a bit position in "ethtool_link_mode_bit_indices".
>   It just helps those tech-savvy people, who does not accept 10000baseCR
>   and prefer 10000sfiDA for being explicit.

The thing is that even with a new enum value, that won't bring much to
the table. It would likely be better to have a comment near the
10000baseCR definition explaining the SFF equivalency.

> 
> At worst case, hope we agree for
> "option-(c): ethtool.8 man page help strings to indicate 10G_SFI_DA"
>   Something like
>     "10000baseCR (10G_SFI_DA    SFF-8431 SFP+ DA)
>   under "advertise" mask values.

In that case, let's add Michal in the loop as the ethtool maintainer. Even
then it's not straightforward as some tooling relies on the JSON output
from ethtool, so _if_ we change the output for that mode, it should only
be in the non-json output.

My personal opinion would be that adding a comment in the enum definition
near 10000baseCR is enough :/

Maxime


