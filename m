Return-Path: <netdev+bounces-220323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 415CEB456BE
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FF494E285A
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0CD34575B;
	Fri,  5 Sep 2025 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JmF/Scg+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0yH5OsCc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JmF/Scg+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0yH5OsCc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B93451D6
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072646; cv=none; b=hB/ips00Br9sXgGJzznKI0XC24RnD/jn9DBVSXypBSbPkDbt3K1OgYHvcyu8rziCPjH8gJjFbW+9lylXuOi5gBveQ+6SGAU9HlMCFSGXlNOhI7ZAaGr75A6tquoUblCo4C42XtIJorDia1zCnD4QfkRTKzpdB68U15Qwx2hZKSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072646; c=relaxed/simple;
	bh=A0JZNcP/l7j7461GpAtddsPVcHGBybyL7IER6rtJFgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWEG/9kvHSw6C2CHFzh3IAXBObjzY820rxBp8YxlQpxY3NgoQ9sGVqYBf9SsRe3un4e1CR8QMqsDUH0XGUxczRxSSnFmRdKlfTHOEaZAjxM9Yova+0m5APivRsg10l3cCzWAN++ye2cHYXsyLLYF0F7m2t9jnNTyRGoblIOt2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JmF/Scg+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0yH5OsCc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JmF/Scg+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0yH5OsCc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C02154E440;
	Fri,  5 Sep 2025 11:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757072642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqGmq+/tciN/X02OS0kFJpbQdadqAWQTqIRmXPCqGYs=;
	b=JmF/Scg+6OLJ+HjL08exUUQWkL3dkcCmpCHobuPze67W32iNvfeayZgBBtXwoTMTXnUUMo
	vNUiih25jAU6ZH98n0cA/IOGTYXlr41QPRVNNZzMLv/u2tQXvuSduY+T1qRuA73udPwTSG
	4wpqz2qqF1/LnDgYtVoP2vkDYG8sKwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757072642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqGmq+/tciN/X02OS0kFJpbQdadqAWQTqIRmXPCqGYs=;
	b=0yH5OsCcQHpkeCegKTHMMsW+mYK9nyzTahKp7a72BZqvHrUFMStoTYENaVX32I4v5RtZma
	OtRxu4qlxiskNrBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757072642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqGmq+/tciN/X02OS0kFJpbQdadqAWQTqIRmXPCqGYs=;
	b=JmF/Scg+6OLJ+HjL08exUUQWkL3dkcCmpCHobuPze67W32iNvfeayZgBBtXwoTMTXnUUMo
	vNUiih25jAU6ZH98n0cA/IOGTYXlr41QPRVNNZzMLv/u2tQXvuSduY+T1qRuA73udPwTSG
	4wpqz2qqF1/LnDgYtVoP2vkDYG8sKwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757072642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqGmq+/tciN/X02OS0kFJpbQdadqAWQTqIRmXPCqGYs=;
	b=0yH5OsCcQHpkeCegKTHMMsW+mYK9nyzTahKp7a72BZqvHrUFMStoTYENaVX32I4v5RtZma
	OtRxu4qlxiskNrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A665139B9;
	Fri,  5 Sep 2025 11:44:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1qPKIgHNumgiVQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 05 Sep 2025 11:44:01 +0000
Message-ID: <8574e531-fc4d-4f36-886b-6e7fc0656da3@suse.de>
Date: Fri, 5 Sep 2025 14:43:57 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] dd ethernet support for RPi5
To: Jakub Kicinski <kuba@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andrea della Porta <andrea.porta@suse.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Phil Elwell
 <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <06017779-f03b-4006-8902-f0eb66a1b1a1@broadcom.com>
 <20250904184757.1f7fb839@kernel.org> <20250904184941.207518c8@kernel.org>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20250904184941.207518c8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Hi Jacub,

On 9/5/25 4:49 AM, Jakub Kicinski wrote:
> On Thu, 4 Sep 2025 18:47:57 -0700 Jakub Kicinski wrote:
>>> netdev maintainers, I took patches 4 and 5 through the Broadcom ARM SoC 
>>> tree, please take patches 1 through 3 inclusive, or let me know if I 
>>> should take patch 2 as well.  
>>
>> Thanks for the heads up! Let me take patch 3 right now.
> 
> s/patch 3/patch 2/
> 
>> I'm a bit unclear on where we landed with the parallel efforts to add
>> the >32b address support :(
> 

If you talk about 1/5 from this series, you can ignore it for now. I'll
monitor the fixes series from Théo Lebrun and will resend it if needed.

regards,
~Stan

