Return-Path: <netdev+bounces-304978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pLSpGuqNS2rAVQEAu9opvQ
	(envelope-from <netdev+bounces-304978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:13:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4490070FB6D
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:13:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leemhuis.info header.s=key2 header.b=OGcdM4XX;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304978-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304978-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58E63300D79F
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D339A812;
	Mon,  6 Jul 2026 11:04:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A9034BA33
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 11:04:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335874; cv=none; b=ppQrxvU2kz3R6prFTmgY5D3KnqwLMiM/R+JAf4JzjEw3iTMDFTDuLT6r3Uusp0p2ASVKxXfYzf4JpGwxb5X9/CWzCcm3p/pXFo/bkbtMwZSkXh58jtQR203afspA8yX9ojJRyeCuaAz1GKd7ZVH+nbo0dTYIRDLLntu6Fq5htRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335874; c=relaxed/simple;
	bh=ZhHjS76EDOyMCf5zoYs4QB/MG761m5MsVg+3Ds7w/qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=peUPd2kPJYSyliJuzLpjx1gBinIzMp7rMUuW9spYPCcRdvcZBYM4Q1/3RwylXh8giljQcaEaNHEkWk6qLWkZb8JfQhDY36ZM7Uvj64WSlwy6+L0PeM8bpAN+KGgt7JnEVz4ZqCJNY6vTqKtj0DYi2ASzTlqnbmOgPNLKv7ZWvg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=OGcdM4XX; arc=none smtp.client-ip=188.68.63.102
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4gv1gj5MkXz60yB;
	Mon,  6 Jul 2026 13:03:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1783335825;
	bh=ZhHjS76EDOyMCf5zoYs4QB/MG761m5MsVg+3Ds7w/qo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OGcdM4XXn3ezQZq6hccgb32L75EEkTpPiAM83GIoyGsCJj+179jNY+QiiZQOP6Hr0
	 pXGu2ZTefK5v3xM9QOOe3i+u/wMX3CvdKvsB8yAXo7Gtq462WGCDO5P/7znbgR+WAu
	 I+kHcJIknTsutWdqX5wNxq6lWUmND/KLL/HeYUEOXXVoGIoRcpktgTmyaTm5WhJHaz
	 34iex8yG5eAMhsaagSv0sTOWjFCAhn2pT/G20BSW0THyMWd0DE5AT43jRjF2TT3UD3
	 DW/45p8AstdKQSlfWStw/Nf0dKOel/kpi4BNIAPAvcWwtEYM4bD4SWwEMeXlnzKRBA
	 1uk7PQgKRpYyQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4gv1gj4fWbz4xc2;
	Mon,  6 Jul 2026 13:03:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gv1gf2fT5z8tXL;
	Mon,  6 Jul 2026 13:03:42 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id BEEB7603ED;
	Mon,  6 Jul 2026 13:03:41 +0200 (CEST)
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <eb5bb7ba-d6f5-4989-8cdc-bd57059fda34@leemhuis.info>
Date: Mon, 6 Jul 2026 13:03:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 221606] r8169: PCIe AER errors and recovery failure after
 recent driver changes
To: Lasse Bjerre <lasse@lgb.dk>, Javen <javen_xu@realsil.com.cn>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <bug-221606-201211@https.bugzilla.kernel.org/>
 <bug-221606-201211-LMiiKJhHhg@https.bugzilla.kernel.org/>
 <b1bda1da-8231-4f05-94a7-7511041ae489@gmail.com>
 <9b206f58d93b48d194980374cf0da7b1@realsil.com.cn>
 <PA4PR02MB6991F71D748EE9A99191EEACDA1E2@PA4PR02MB6991.eurprd02.prod.outlook.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: 
 <PA4PR02MB6991F71D748EE9A99191EEACDA1E2@PA4PR02MB6991.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178333582208.734786.13573271730310934407@mxe9fb.netcup.net>
X-NC-CID: Dz8q2ScuPMkR5wg978Cw6BuZlfVICEx7YH48LH/2tpGwle3ujdc=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:lasse@lgb.dk,m:javen_xu@realsil.com.cn,m:netdev@vger.kernel.org,m:hkallweit1@gmail.com,m:regressions@lists.linux.dev,s:lists@lfdr.de];
	DMARC_NA(0.00)[leemhuis.info];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,leemhuis.info:from_mime,leemhuis.info:dkim,leemhuis.info:mid,lgb.dk:email];
	FORGED_SENDER(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304978-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4490070FB6D

On 6/10/26 19:58, Lasse Bjerre wrote:
> 
> Absolutely, I have attached a full dmesg from a fresh boot as well as
> the output of lspci.
> Important to note (should have done so earlier) that I have manually
> turned on l1_1_aspm using a udev rule. It is not on by default, but has
> worked flawlessly until the issue in question.

Hmm, seems nothing happened since then -- or was there progress and I
just missed it? If not: is this intentional (due to manually enabling
l1_1_aspm maybe?), or did this regression fall through the cracks?

Ciao, Thorsten
> ------------------------------------------------------------------------
> *From:* Javen <javen_xu@realsil.com.cn>
> *Sent:* 04 June 2026 11:01
> *To:* Heiner Kallweit <hkallweit1@gmail.com>
> *Cc:* netdev@vger.kernel.org <netdev@vger.kernel.org>; Lasse Bjerre
> <lasse@lgb.dk>
> *Subject:* RE: [Bug 221606] r8169: PCIe AER errors and recovery failure
> after recent driver changes
>  
>>On 03.06.2026 09:44, bugzilla-daemon@kernel.org wrote:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=221606 <https://
> bugzilla.kernel.org/show_bug.cgi?id=221606>
>>>
>>> --- Comment #2 from lasse@lgb.dk ---
>>> Commit 9ab94a32af704fa9c873094283ae8744a07baf25 (r8169: enable LTR
>>> support) seems to be the issue. Running the commit before this doesn't
>>> give me any AER errors and everything seems to behave normally.
>>>
>>Bisecting the reported issue points to one of your commits.
>>Could you please check with the user?
> 
> Hi, Heiner, Lasse
> 
> Thanks for reporting this issue.
> 
> Currently, we haven't received any similar reports from our customers,
> and I am unable to reproduce this AER error on my local test platforms.
> 
> Could you please provide some more detailed information? The full dmesg
> log will help me check the exact AER error messages and the boot
> context. Also the output of sudo lspci -vvv. I need this to check the
> exact platform information, PCIe topology, and the LTR/ASPM capabilities
> of both your Root Port and the Realtek NIC.
> 
> While reviewing the initialization flow, I noticed a potential logic
> contradiction. If rtl_aspm_is_safe(tp) returns false, the driver
> disables L1 at the PCIe core level, but tp->aspm_manageable might still
> be set to true. This could cause the driver to incorrectly enable ASPM/
> LTR in the MAC registers later, creating a hardware state mismatch (PCIe
> L1 disabled, but MAC LTR enabled) which usually leads to AER.
> 
> Could you please test if the following patch fixes the AER error on your
> side?
> 
> -       if (enable && tp->aspm_manageable) {
> +       if (enable && tp->aspm_manageable && rtl_aspm_is_safe(tp)) {
> 
> Thanks,
> BRs,
> Javen


