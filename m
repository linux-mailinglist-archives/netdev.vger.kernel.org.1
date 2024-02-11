Return-Path: <netdev+bounces-70804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7723850822
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 09:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C851C20986
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 08:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE73258AD1;
	Sun, 11 Feb 2024 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e0G52sxl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OvfgdEJd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H1937i/s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q59hCpnF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DF558ABE
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640758; cv=none; b=dmt/Km4bObdDFwWZPho8e6L8e11M8mFHvntuqPJLSPwgC/xsSGqhzUUyCrOc8AgqOxjMba7xn1nOjgj+uoZhglhXLXoy4Yp1OVeej92y+wSvYPo2eNxs51J/ZnxBsGY2mxq02FTCRSn5FaizCgQp2756gVV8dLQq8EyC3WIFq5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640758; c=relaxed/simple;
	bh=NP/H0ty8Sb1xtLFRfyMNHi5f1mFkss0KqCt6XmeE7As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1bqilJzaa5qtitGbk9eLNIHIs27UUZnu+naJEotnw0t/9B7XbCq5o/18t7yyuL/INOhkAiAaJP39WvjtWqFk5bHPMYjYnQkqTxiPSje6M4SMDYciaxeiBrLp4YFNgf4JI+BHFow23n0AZNigpIpW0giwufui9fAYSvB42Zp7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e0G52sxl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OvfgdEJd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H1937i/s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q59hCpnF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E727421EC4;
	Sun, 11 Feb 2024 08:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707640755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXt5a7TLJ6x0PCT7wAp72vLpQRmYu05AngFx9zyzru8=;
	b=e0G52sxlefsqXlFCABofZgNd+3Pv1l3P4DroEzyN7vbPCRY/b5913XHw5v2VL89PMQu3lJ
	J6WrNyK+5KeDMgkdSfNrJy8oNhI/h7u7KHu9G94B9NS3EeFrvTa3xjx2oFwPUpGr1LxVNY
	qvLUU6c+ZSG2Bcryhxkj7TEfhiS0Npc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707640755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXt5a7TLJ6x0PCT7wAp72vLpQRmYu05AngFx9zyzru8=;
	b=OvfgdEJdRkOSD7nqFaN59T92gQYlD6ApvjPzeAwoOcBA4kf/wgQkuN7Uer+eNGmvT0UQfq
	fOYXl7Zx09zcJ0BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707640754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXt5a7TLJ6x0PCT7wAp72vLpQRmYu05AngFx9zyzru8=;
	b=H1937i/sIiDzlI3H06xWgpj2O2WZMtCtb47J36KuHT6k3bBq6TlYqKn081vUE1nOYHXgeh
	0pBCRFSUKDUqMjHwZWR1hczjipBMvo6XgmIeYlH66au+zgQCQIifhL7HZ4wfB53H6eiXfT
	iWUjZFeovOCfTjmZXdPWyN6PT/Q5h70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707640754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXt5a7TLJ6x0PCT7wAp72vLpQRmYu05AngFx9zyzru8=;
	b=q59hCpnFmf/GkheCxlAAu/tUOlwiYoe76kh/dUh1Anc9aQHy+O4XcoTTpjjMpU6FIFkKr4
	rWg8/VMY59JyxTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5D9E13985;
	Sun, 11 Feb 2024 08:39:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IeFHJbKHyGWRNAAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Sun, 11 Feb 2024 08:39:14 +0000
Message-ID: <331c1b3b-4dbe-48e7-9e75-0536528a8868@suse.de>
Date: Sun, 11 Feb 2024 11:39:13 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2] ifstat: convert sprintf to snprintf
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org
References: <20240202093527.38376-1-dkirjanov@suse.de>
 <20240210123303.4737392e@hermes.local>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240210123303.4737392e@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="H1937i/s";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=q59hCpnF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.53 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 BAYES_HAM(-0.04)[58.92%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FREEMAIL_TO(0.00)[networkplumber.org,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.18)[-0.918];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.53
X-Rspamd-Queue-Id: E727421EC4
X-Spam-Flag: NO



On 2/10/24 23:33, Stephen Hemminger wrote:
> On Fri,  2 Feb 2024 04:35:27 -0500
> Denis Kirjanov <kirjanov@gmail.com> wrote:
> 
>> Use snprintf to print only valid data
>>
>> v2: adjust formatting
>>
>> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
>> ---
> 
> Tried this but compile failed
> 
> ifstat.c:896:2: warning: 'snprintf' size argument is too large; destination buffer has size 107, but size argument is 108 [-Wfortify-source]
>         snprintf(sun.sun_path + 1, sizeof(sun.sun_path), "ifstat%d", getuid());

Right, this is addressed in the patch with scnprintf
 

