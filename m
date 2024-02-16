Return-Path: <netdev+bounces-72389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B13857DCA
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 14:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8390E281D3E
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD67D12A14A;
	Fri, 16 Feb 2024 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fYdtqEJC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="epr85msj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fYdtqEJC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="epr85msj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72136129A6F
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090655; cv=none; b=I8uYIhsdzqOtGCrmNavAmoiy/tmrpUeH7DpKKZ+ZONge4pqnlhoQisWFmOHdjulzWWESwpVavNmHJnPfk+BV3qlw5GJj2dyhKFa22W9UbA2ZNyhu+GYS28iT/nnEUznTJF6OB6PAgNkOXmygWG1q/BfX8eOf0GfRgHyRWiZcDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090655; c=relaxed/simple;
	bh=189OnlCwntyXqHxuQLtzulCV2gBAAFxCgcJK2ozJADM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AL6RlGjXCUClubofTfZjdTuqBss6nqsYWdexc6Gu/LktmtPEnm143OGSZsWILVs2cuyD/8MNg0DM/DxCzWMLtgR7WdLeYxU+n0uLeiSxRMFxHqdAbu5k2fB1GHLeDLx8h9iA6vmrvdNKqrc0GLpbAT5ZOYZzyix3lLWJKa+s6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fYdtqEJC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=epr85msj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fYdtqEJC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=epr85msj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 380C521ECE;
	Fri, 16 Feb 2024 13:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708090648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxV3iyDpZ08YtsL9xjW9JGYy8Kh1U4I8tGTCS0tcTYQ=;
	b=fYdtqEJCxu1OfjVfwFTdlKB0PezZ2REjJTnq29Mn+EI9Q1v4VsQFi5y2ghDid9KI+epUNt
	RET9RJxOaPyRoirwvNjP9RIevwgElV8sepullN9zM9/dyr3alsi1wzrsKVGo1AXzmxHzHW
	WP+UmtPwjo6yBR+ZQMNJKrtQw68mQZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708090648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxV3iyDpZ08YtsL9xjW9JGYy8Kh1U4I8tGTCS0tcTYQ=;
	b=epr85msjOS7cYNyZzYbUit210baJvb4XL+bl/T86iy5hrcDevNNCXLdlw5npsKzOmI623/
	btYf8FcW/vVnYAAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708090648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxV3iyDpZ08YtsL9xjW9JGYy8Kh1U4I8tGTCS0tcTYQ=;
	b=fYdtqEJCxu1OfjVfwFTdlKB0PezZ2REjJTnq29Mn+EI9Q1v4VsQFi5y2ghDid9KI+epUNt
	RET9RJxOaPyRoirwvNjP9RIevwgElV8sepullN9zM9/dyr3alsi1wzrsKVGo1AXzmxHzHW
	WP+UmtPwjo6yBR+ZQMNJKrtQw68mQZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708090648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxV3iyDpZ08YtsL9xjW9JGYy8Kh1U4I8tGTCS0tcTYQ=;
	b=epr85msjOS7cYNyZzYbUit210baJvb4XL+bl/T86iy5hrcDevNNCXLdlw5npsKzOmI623/
	btYf8FcW/vVnYAAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BBC0D13421;
	Fri, 16 Feb 2024 13:37:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 73bpKBdlz2XoLQAAn2gu4w
	(envelope-from <dkirjanov@suse.de>); Fri, 16 Feb 2024 13:37:27 +0000
Message-ID: <c4a632da-c779-4be0-829e-492e602240b6@suse.de>
Date: Fri, 16 Feb 2024 16:37:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool] ethtool: put driver specific code into drivers
 dir
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Denis Kirjanov <kirjanov@gmail.com>, mkubecek@suse.cz,
 netdev@vger.kernel.org
References: <20240214135505.7721-1-dkirjanov@suse.de>
 <2951e395-7982-47bb-a9f6-c732c2affaaf@lunn.ch>
 <f6ae42d5-5fb8-476e-acfa-db192ac8aec9@suse.de>
 <23bdba44-0a82-428f-b813-3675b2da1984@lunn.ch>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <23bdba44-0a82-428f-b813-3675b2da1984@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_SOME(0.00)[];
	 BAYES_HAM(-0.00)[16.38%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.09



On 2/15/24 17:40, Andrew Lunn wrote:
> On Thu, Feb 15, 2024 at 04:41:47PM +0300, Denis Kirjanov wrote:
>>
>>
>> On 2/14/24 21:12, Andrew Lunn wrote:
>>> On Wed, Feb 14, 2024 at 08:55:05AM -0500, Denis Kirjanov wrote:
>>>> the patch moves the driver specific code in drivers
>>>> directory
>>>
>>> It is normal for the commit message to give the answer to the question
>>> "Why?".
>>
>> "For better code organization the patch moves the driver-specific code into drivers directory"
> 
> Is that enough justify the code churn? Are you about to add a lot more
> driver code?

> 
>>> Also, what is your definition of a driver? I would not really call the
>>> sfp parts drivers.
>>
>> Sure, I'll put them back in the next version
> 
> It is i while since i looked at the insides of ethtool. But if i
> remember correctly, the 'drivers' are there to pretty print values
> returned by ethtool --register-dump. SFP was just an example, i
> suspect there are other files which you moved which are not used by
> register-dump as drivers. Hence my question, what is your definition
> of driver?

Right, the code is used for dumping registers. 
Actually ethtool already calls it driver_list:

#ifdef ETHTOOL_ENABLE_PRETTY_DUMP
static const struct {
        const char *name;
        int (*func)(struct ethtool_drvinfo *info, struct ethtool_regs *regs);

} driver_list[]
....


> 
>    Andrew

