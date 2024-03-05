Return-Path: <netdev+bounces-77491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB03871EE7
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8AF288156
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D00E5A11B;
	Tue,  5 Mar 2024 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U7aRZsBd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2LWVyLb7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U7aRZsBd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2LWVyLb7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0759171
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641058; cv=none; b=RVD4EsSNd6WOCy1qZMVA9JNLfNIBuv88i0IN76F8upMjgdhT+5dUXW99khBpzFmGqcj8Ran87nuPbCscY9aeNd/Lq5tI3K2g48wKgjZWADbgJ8Q56w7ExtNpWbEBHDfcFlZzW+ZZalBMCPq1oz83twAwwKXeFUvlII8iWcUy+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641058; c=relaxed/simple;
	bh=6rnOKdVwQI2MzdmwdMhHLrpnUs9YP1aZJ1ru0xf/YJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDXHwRzC5RVor2gcv7rNyDl0ZhKpyl1t1HUnakVcHe7LAXujA5RKBWfEtpexyeePNM8+aV6nP//0vFzfKQuGlivVgntqfUUuYlAuqAPWFvEsgmKOrhza3PBy4eg/BPGRQ/preHDZbtXC2cpKpGZOQiy3YebMt+cyNLOpPC+O3OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U7aRZsBd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2LWVyLb7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U7aRZsBd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2LWVyLb7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2915D6AF87;
	Tue,  5 Mar 2024 12:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709641055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTTKqT14OzUQFc7BGqNFhCR/qKYl/0QT6tHoGFcDCE0=;
	b=U7aRZsBdYbSAIFbgaJkhE/OYsBKQodPMVZeYThqpKcNZxg94fAeMRvUG4tA4q/KgtvadeW
	Efo4RnmUGsJa3kokoo2s66nAbpPf1UwmVEIBZLuXwPUqw0X5rOFaxw7DFA149FbgAHdEbs
	x3ogIr4UYIRUHYjmH24fmERyFyeK/rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709641055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTTKqT14OzUQFc7BGqNFhCR/qKYl/0QT6tHoGFcDCE0=;
	b=2LWVyLb7WnfvDOlGy8ES1Ocw7VJ5RDnZ0iuypeSYDceg1TuEVxpmmpOabrFTsOY8QJZWQL
	0Xtf5EDUdwNYUtBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709641055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTTKqT14OzUQFc7BGqNFhCR/qKYl/0QT6tHoGFcDCE0=;
	b=U7aRZsBdYbSAIFbgaJkhE/OYsBKQodPMVZeYThqpKcNZxg94fAeMRvUG4tA4q/KgtvadeW
	Efo4RnmUGsJa3kokoo2s66nAbpPf1UwmVEIBZLuXwPUqw0X5rOFaxw7DFA149FbgAHdEbs
	x3ogIr4UYIRUHYjmH24fmERyFyeK/rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709641055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTTKqT14OzUQFc7BGqNFhCR/qKYl/0QT6tHoGFcDCE0=;
	b=2LWVyLb7WnfvDOlGy8ES1Ocw7VJ5RDnZ0iuypeSYDceg1TuEVxpmmpOabrFTsOY8QJZWQL
	0Xtf5EDUdwNYUtBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EF4213A5D;
	Tue,  5 Mar 2024 12:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oW1CGV4N52WlJgAAn2gu4w
	(envelope-from <dkirjanov@suse.de>); Tue, 05 Mar 2024 12:17:34 +0000
Message-ID: <6464c0d2-8610-4419-b081-fd21cd5e70b6@suse.de>
Date: Tue, 5 Mar 2024 15:17:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 0/4] net: Provide SMP threads for backlog NAPI
Content-Language: en-US
To: Wander Lairson Costa <wander@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Yan Zhai <yan@cloudflare.com>
References: <20240305120002.1499223-1-bigeasy@linutronix.de>
 <3fpntlz5golidj775wfnlzecd7ksimwutcqg7e6d2efejt6sip@akexo2hmy3hb>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <3fpntlz5golidj775wfnlzecd7ksimwutcqg7e6d2efejt6sip@akexo2hmy3hb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=U7aRZsBd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2LWVyLb7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.34)[96.95%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -5.84
X-Rspamd-Queue-Id: 2915D6AF87
X-Spam-Flag: NO


>>
> 
> Patch 0002 does not apply for me. I tried torvalds/master and
> linux-rt-devel/linux-6.8.y-rt. Which tree should I use?

git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git

> 
> 

