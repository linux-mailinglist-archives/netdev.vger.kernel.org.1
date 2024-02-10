Return-Path: <netdev+bounces-70742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F23B850388
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 09:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF951C21FCF
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7381D1400D;
	Sat, 10 Feb 2024 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xtmywsua";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7hPgaN+q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xtmywsua";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7hPgaN+q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1207282E1
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707554268; cv=none; b=thFguxMZgU+fh+FOUBXlJNMJTxL7K41VGm9z8CkX0rfiz6eC8DJB/LBsnCEszvdZ+UMFwwbj4bJXZ+3X6obCQLhieDNrf72wLo7xlfNdnkX85zA+KCsTJm+DxwkLWpotI8lp+goVRQo/AKKRsmgpvtFO/dm9m8ksGkOgSv+YeAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707554268; c=relaxed/simple;
	bh=ZBHg9W6jJyaNyigThMUmhDFHXmfi1wzBYja5y+axqvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwyiukRAJ2oX/F19U4rcPgKPUx8O3Tz7Klud9QFYz/kPBpwx6BqUWJJSxV9OPgT/6pGzikjYytbkiGR4xKm2m5vHpq8jirOzY6zNCJRDXiXg4Jm/ujPGrNuUJDClq3mBx7bhkGUYoL2FWmglSEBg2gJkLEkLc91KbRNnDHz/88k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xtmywsua; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7hPgaN+q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xtmywsua; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7hPgaN+q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4D2822246;
	Sat, 10 Feb 2024 08:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707554264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNfvD7L1p68k2+3URSO437/oxj+erv4om1J6U6p0Xjs=;
	b=xtmywsuaoVV2ShB1TWDHZ0FVDUUPo3V3QU3qFMjSLj8+r09fy9dma6Q9SLpPh/eIyMduaw
	eo73ThwuF4TwXYfIHKlM8Dpc4nfcECITgtCq9xiJrlP1y5thmcCkC82+i03+S+ECEccMdB
	tA+qzDQHK9qLKIiQVqiFjgXvmQkAkG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707554264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNfvD7L1p68k2+3URSO437/oxj+erv4om1J6U6p0Xjs=;
	b=7hPgaN+qOX0bTfJGBAkC45Dqdg0uL2bJw8L6Otj5FwuyMeGqxYphrbJCogK7Sbk6COLAg2
	O1LuHDwY0SsUybDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707554264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNfvD7L1p68k2+3URSO437/oxj+erv4om1J6U6p0Xjs=;
	b=xtmywsuaoVV2ShB1TWDHZ0FVDUUPo3V3QU3qFMjSLj8+r09fy9dma6Q9SLpPh/eIyMduaw
	eo73ThwuF4TwXYfIHKlM8Dpc4nfcECITgtCq9xiJrlP1y5thmcCkC82+i03+S+ECEccMdB
	tA+qzDQHK9qLKIiQVqiFjgXvmQkAkG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707554264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNfvD7L1p68k2+3URSO437/oxj+erv4om1J6U6p0Xjs=;
	b=7hPgaN+qOX0bTfJGBAkC45Dqdg0uL2bJw8L6Otj5FwuyMeGqxYphrbJCogK7Sbk6COLAg2
	O1LuHDwY0SsUybDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69E4B13867;
	Sat, 10 Feb 2024 08:37:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B05YFtg1x2XOdwAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Sat, 10 Feb 2024 08:37:44 +0000
Message-ID: <5e070719-260e-4219-a972-82db360ac847@suse.de>
Date: Sat, 10 Feb 2024 11:37:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 1/2] lib: utils: introduce scnprintf
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Denis Kirjanov <kirjanov@gmail.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org
References: <20240209093619.2553-1-dkirjanov@suse.de>
 <20240209083330.391a773e@hermes.local>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240209083330.391a773e@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.29
X-Spamd-Result: default: False [-1.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 BAYES_HAM(-0.00)[34.45%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[networkplumber.org,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO



On 2/9/24 19:33, Stephen Hemminger wrote:
> On Fri,  9 Feb 2024 04:36:18 -0500
> Denis Kirjanov <kirjanov@gmail.com> wrote:
> 
>> The function is similar to the standard snprintf but
>> returns the number of characters actually written to @buf
>> argument excluding the trailing '\0'
>>
>> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
>> ---
> 
> I don't understand, why not use snprintf in ifstat?
> None of the cases in patch 2 care about the return value length.
Hi Stephen,

My intention is just use one safe version of the string formatting function.
I'm going to convert other places as well.


