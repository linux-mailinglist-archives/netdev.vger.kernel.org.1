Return-Path: <netdev+bounces-223009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E541CB57829
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236482040D8
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67507302152;
	Mon, 15 Sep 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rsb0V5T+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ly0jmR4l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rsb0V5T+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ly0jmR4l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD1301472
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935660; cv=none; b=WZObnTO0i/gJc0UbbQpnDtV/du27cGBVC7wa9lL77Nf9rsYtQ/vfOPOH0OPvbUliqQPaGnFjZ9B2AxnBw74zmsa1qr1oEpNP7XyZoOX/RTVfCnXWS0BhQGfFGwZeOGgAypTVx3ITNw0lTNUkPJpISvSoH/TdzFPBDqOV2e2CgoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935660; c=relaxed/simple;
	bh=YHQS7oCQKUANz8KL2VKX+GE23Upm3bXldCC/jRePUPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SeYbaKmkEey9iwRCNUgQ2P+TM7LNNMfiJMXEsKaR32LjyORiXlCScnBn7brWbJTpGvj4pGaeZGTovKAzNAqMZ9QlK+ta7mFKxT9h4Mn0e4IMJYhn2FJ03f31IsOBznHrPyD0gSxzdvzIC47CcjmmHJbnTyi/07Qt2QEvLlHw4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rsb0V5T+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ly0jmR4l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rsb0V5T+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ly0jmR4l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 348A11F8B0;
	Mon, 15 Sep 2025 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757935656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JntDITgOThJNLP4MXQJ43VBflgagcrs9tOitGbwZPX8=;
	b=Rsb0V5T+AAgLb/QUPTZ/JYQZNEavTu8wHlENSEYwTlmHShN5RECnFYNLQPuXo1HLU7ZXzN
	qxo/8HlVKsXY+T2zeq7YJBo3GSPZRzyGbBC2ZfAU+W49ycEOzlIa+PGcP7XoHMl1EvxBnz
	H9mNLitqdRL3QHOT4TSBBDVdLiD/AME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757935656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JntDITgOThJNLP4MXQJ43VBflgagcrs9tOitGbwZPX8=;
	b=ly0jmR4lryxNId0U7Z6g6pGZdqf3d3Dk/dfFCIOKx/mNg8LaQy5oLJdFhRijLmmouqOEva
	ZGdv9tm2o4wKITCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Rsb0V5T+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ly0jmR4l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757935656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JntDITgOThJNLP4MXQJ43VBflgagcrs9tOitGbwZPX8=;
	b=Rsb0V5T+AAgLb/QUPTZ/JYQZNEavTu8wHlENSEYwTlmHShN5RECnFYNLQPuXo1HLU7ZXzN
	qxo/8HlVKsXY+T2zeq7YJBo3GSPZRzyGbBC2ZfAU+W49ycEOzlIa+PGcP7XoHMl1EvxBnz
	H9mNLitqdRL3QHOT4TSBBDVdLiD/AME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757935656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JntDITgOThJNLP4MXQJ43VBflgagcrs9tOitGbwZPX8=;
	b=ly0jmR4lryxNId0U7Z6g6pGZdqf3d3Dk/dfFCIOKx/mNg8LaQy5oLJdFhRijLmmouqOEva
	ZGdv9tm2o4wKITCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 250271372E;
	Mon, 15 Sep 2025 11:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9GaQBif4x2hwJQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 15 Sep 2025 11:27:35 +0000
Message-ID: <8715a21b-83ac-4bc1-b856-fa90bb5b809f@suse.de>
Date: Mon, 15 Sep 2025 14:27:34 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] net: cadence: macb: Add support for Raspberry Pi
 RP1 ethernet controller
To: Stanimir Varbanov <svarbanov@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrea della Porta <andrea.porta@suse.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Phil Elwell
 <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, Andrew Lunn <andrew@lunn.ch>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20250822093440.53941-4-svarbanov@suse.de>
 <0142ac69-f0eb-4135-b0d2-50c9fec27d43@suse.de>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <0142ac69-f0eb-4135-b0d2-50c9fec27d43@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 348A11F8B0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01



On 9/10/25 2:32 PM, Stanimir Varbanov wrote:
> Hi Jakub,
> 
> On 8/22/25 12:34 PM, Stanimir Varbanov wrote:
>> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>>
>> The RP1 chip has the Cadence GEM block, but wants the tx_clock
>> to always run at 125MHz, in the same way as sama7g5.
>> Add the relevant configuration.
>>
>> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
> 
> This patch is missing in net-next but ("dt-bindings: net: cdns,macb: Add
> compatible for Raspberry Pi RP1") from this series has been applied.
> 
> Could you take this patch as well, please.

Gentle ping.

~Stan

