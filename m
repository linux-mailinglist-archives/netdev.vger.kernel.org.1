Return-Path: <netdev+bounces-221643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DA4B515C4
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 13:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 604AE4E2E80
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 11:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3028641D;
	Wed, 10 Sep 2025 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XmnRsdoE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WQjoJjmB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XmnRsdoE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WQjoJjmB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E832857CB
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503932; cv=none; b=BbAj6el996I5qSsaAZTbdxnNVx7RvaVZHQIp60TFa9gwF3x47cXFVVBTDTZV562fKem3VnA4pW2HMJI0NHKv7Lk6ypyo6W2zHyPxQ8GdoYMjvm68O1PdB/lRfeAsBCJHop+aEUiirVZKM4LWx2z/MyHTxv+1JOqstQT12MD9YnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503932; c=relaxed/simple;
	bh=2Vd32T0ceqN/8RF9ehZuA7jW8Xgr1hnnN7gmAvXqc94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9A1cMrPhuIJXhUZYh+n655o6j1oHa/zsrIBtL5HDhE6Cc+6Z+uPT/y7xz+QLYtOdNQ/RGiAUIrMK0K/oPwqvMOwAKlhhIuMHaCUL3o8+OxNC4JiyaDo3sSq2vGcd8M7QEpazOQ3vz8ccpGzverkBYMJ2t4/ymvgpVSr6w2hzTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XmnRsdoE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WQjoJjmB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XmnRsdoE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WQjoJjmB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49AEE37A4B;
	Wed, 10 Sep 2025 11:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757503928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCBsG25MpOzEykkbBH/E55NK+Tl8cYqZNEQJun7ve6c=;
	b=XmnRsdoEWSmHkxJ1H9lzOvkpCZYMa6WLSfsDtAxJY30k6xTQFxckNOIY4ufGNaRpi8+5C3
	IKeWOXF6wbBVHMqn7q047noRuDFmXieWQBPw6YCCJ43H7ScRHyE4Z2VmuY0AJqIAymBO2H
	xqj3QIX4OkuVk7Wd6niCWzizhXjzj8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757503928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCBsG25MpOzEykkbBH/E55NK+Tl8cYqZNEQJun7ve6c=;
	b=WQjoJjmBTrX+O1EvjPGtvjn5usQYCywN/2Ula2eTN2NSj/81PoGIuI6wvkG6QKQau4ywGD
	1thQuYUdbHo38xDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757503928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCBsG25MpOzEykkbBH/E55NK+Tl8cYqZNEQJun7ve6c=;
	b=XmnRsdoEWSmHkxJ1H9lzOvkpCZYMa6WLSfsDtAxJY30k6xTQFxckNOIY4ufGNaRpi8+5C3
	IKeWOXF6wbBVHMqn7q047noRuDFmXieWQBPw6YCCJ43H7ScRHyE4Z2VmuY0AJqIAymBO2H
	xqj3QIX4OkuVk7Wd6niCWzizhXjzj8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757503928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCBsG25MpOzEykkbBH/E55NK+Tl8cYqZNEQJun7ve6c=;
	b=WQjoJjmBTrX+O1EvjPGtvjn5usQYCywN/2Ula2eTN2NSj/81PoGIuI6wvkG6QKQau4ywGD
	1thQuYUdbHo38xDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A8F313301;
	Wed, 10 Sep 2025 11:32:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ad7ZD7dhwWgQaAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 10 Sep 2025 11:32:07 +0000
Message-ID: <0142ac69-f0eb-4135-b0d2-50c9fec27d43@suse.de>
Date: Wed, 10 Sep 2025 14:32:05 +0300
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
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20250822093440.53941-4-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,raspberrypi.com:email,lunn.ch:email];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi Jakub,

On 8/22/25 12:34 PM, Stanimir Varbanov wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> The RP1 chip has the Cadence GEM block, but wants the tx_clock
> to always run at 125MHz, in the same way as sama7g5.
> Add the relevant configuration.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

This patch is missing in net-next but ("dt-bindings: net: cdns,macb: Add
compatible for Raspberry Pi RP1") from this series has been applied.

Could you take this patch as well, please.

reagrds,
~Stan


