Return-Path: <netdev+bounces-72048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584588564A6
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AEE41C210C3
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0008F12FF8C;
	Thu, 15 Feb 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OxMr/dfM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TRh4sP/M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OxMr/dfM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TRh4sP/M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF9512BF3D
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004511; cv=none; b=I22iYP3vvymDawIbA14vUW1afczgKSTyb3hl8xVvLrk09cILTnorbzQ5OpobE+Qookkdt5ZWcIDRz6dVqKhLCHvhvpamQKbVF2rEzeKOh17gPQ9hBbPQHyw/oKmxujJWZ8JGPMm6LFQ1DV8SFzvSyDnVIQ/WsbajNzqE8t8NoCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004511; c=relaxed/simple;
	bh=dcwLihil4igzzwUhpkcu9HoHeqw9l+1dIq2/TwMXeSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmrN9+Wt7aOiD7I474h2S7Ts1H+sYYCoyvoAEbhdCE0+VtpdAaybE+90abBzC/VkDKSqlZbJd9nPzKNPKUrR9ZxDsGRxaQy8p7zBVmNpkju3MgCg835Jbk5zW7ij6fzRFf4QK0j5xgtrXLPnnXPGDYETj8pZA6xTBwX+5AMG6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OxMr/dfM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TRh4sP/M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OxMr/dfM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TRh4sP/M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7972A21D98;
	Thu, 15 Feb 2024 13:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708004508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/zc2dnO4itUQdbZCCHiTIsPsEZquxX3wzRQavNOJ6Y=;
	b=OxMr/dfMbFj6OaOIZo0bTKQ32AHclCT+CoxWaq9CHoK5vxHq42mB0WT7YeEw8Ev+PVLD+J
	fa5Y9xTdazJ5oqF4qar2Fkvwj2Wo/r+n6AtAbeRPdVmkq7tEI5bEX43oUBiObgNYumAvLv
	CEhPxqX+Bkh8QqE0MDZYVgNni3MvDpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708004508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/zc2dnO4itUQdbZCCHiTIsPsEZquxX3wzRQavNOJ6Y=;
	b=TRh4sP/MdFLz6UwniamnFaoWLHKehIlRViAJhrbna2g6ukSuOlZ8abBrT20OwPjK06Ju/6
	N/3r2AlusjChnFCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708004508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/zc2dnO4itUQdbZCCHiTIsPsEZquxX3wzRQavNOJ6Y=;
	b=OxMr/dfMbFj6OaOIZo0bTKQ32AHclCT+CoxWaq9CHoK5vxHq42mB0WT7YeEw8Ev+PVLD+J
	fa5Y9xTdazJ5oqF4qar2Fkvwj2Wo/r+n6AtAbeRPdVmkq7tEI5bEX43oUBiObgNYumAvLv
	CEhPxqX+Bkh8QqE0MDZYVgNni3MvDpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708004508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/zc2dnO4itUQdbZCCHiTIsPsEZquxX3wzRQavNOJ6Y=;
	b=TRh4sP/MdFLz6UwniamnFaoWLHKehIlRViAJhrbna2g6ukSuOlZ8abBrT20OwPjK06Ju/6
	N/3r2AlusjChnFCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E713139D0;
	Thu, 15 Feb 2024 13:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YkxIOpsUzmWYHQAAn2gu4w
	(envelope-from <dkirjanov@suse.de>); Thu, 15 Feb 2024 13:41:47 +0000
Message-ID: <f6ae42d5-5fb8-476e-acfa-db192ac8aec9@suse.de>
Date: Thu, 15 Feb 2024 16:41:47 +0300
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
To: Andrew Lunn <andrew@lunn.ch>, Denis Kirjanov <kirjanov@gmail.com>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org
References: <20240214135505.7721-1-dkirjanov@suse.de>
 <2951e395-7982-47bb-a9f6-c732c2affaaf@lunn.ch>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <2951e395-7982-47bb-a9f6-c732c2affaaf@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="OxMr/dfM";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="TRh4sP/M"
X-Spamd-Result: default: False [-0.44 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 BAYES_HAM(-0.14)[68.18%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.44
X-Rspamd-Queue-Id: 7972A21D98
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /



On 2/14/24 21:12, Andrew Lunn wrote:
> On Wed, Feb 14, 2024 at 08:55:05AM -0500, Denis Kirjanov wrote:
>> the patch moves the driver specific code in drivers
>> directory
> 
> It is normal for the commit message to give the answer to the question
> "Why?".

"For better code organization the patch moves the driver-specific code into drivers directory"

> 
> Also, what is your definition of a driver? I would not really call the
> sfp parts drivers.

Sure, I'll put them back in the next version

> 
>     Andrew
> 

