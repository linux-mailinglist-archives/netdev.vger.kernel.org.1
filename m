Return-Path: <netdev+bounces-223093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00FCB57F00
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F7C3A9536
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AB432A806;
	Mon, 15 Sep 2025 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N6wMOPav";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RVHJWlNB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N6wMOPav";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RVHJWlNB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D14E1D79BE
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946687; cv=none; b=BcN5NNfejY4cMq+FXfkgsqOgYf8pXM95DI1TnfzcWd63t5uUTHGTr1KyDWh0wIxut6KqL7vE4mVzcnk96C6EH8/oPiAJZ6JTj8+BWzfEeeWpSc8YbbTsw3hFZ1KEYq5Rt0J/UB1Is5cq8i+sF7VAVXW4Zn+xSmYtvlWhaZ8Y4io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946687; c=relaxed/simple;
	bh=yoQolAx41O8GQCQhu9dZcTPWss6tqiCGnkwE4nYtSqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qt6Z/8WukzKZlzddaXPjXARogm9qNj5ruECcOe6hS6mbQFfd3ad2s7BAFIaF7hM8SegT0gyh9VB6Zcy9w1gj9dbdu1B4N5oRwF9xudJW/GtPWk+NE8xK3qxT+x8Mqy2C4H5svvW7JKjSQ971apPyO46n23cz/3AqemZLsa4TQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N6wMOPav; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RVHJWlNB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N6wMOPav; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RVHJWlNB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B87F336BF;
	Mon, 15 Sep 2025 14:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757946683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mNaU9AhJn4Xq2FHC7G2kb7GgzktfPd9RfttKwzj4HA=;
	b=N6wMOPavB1lqRwyCxggSCOXxUC4RE9D4hvNEiH8DopNz2Io85LyNsX2urRGQ8lyuu3HHhP
	t1aNNFc4E4LTYGrHNwjksYnWUEGYPVh/1ikzA/gf63Mq4WQHIM520X/ukYi0HxRkuOBUfI
	tBp1trRLeaOXzToXGcVolwq6M3k04/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757946683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mNaU9AhJn4Xq2FHC7G2kb7GgzktfPd9RfttKwzj4HA=;
	b=RVHJWlNBbcWbFWhbZWerd4SLJEEPIkqECj7HlekZWRPZXKYUavodpaTZAERdl+WcMFVU58
	QXfo9dkBx6dnJZAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757946683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mNaU9AhJn4Xq2FHC7G2kb7GgzktfPd9RfttKwzj4HA=;
	b=N6wMOPavB1lqRwyCxggSCOXxUC4RE9D4hvNEiH8DopNz2Io85LyNsX2urRGQ8lyuu3HHhP
	t1aNNFc4E4LTYGrHNwjksYnWUEGYPVh/1ikzA/gf63Mq4WQHIM520X/ukYi0HxRkuOBUfI
	tBp1trRLeaOXzToXGcVolwq6M3k04/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757946683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mNaU9AhJn4Xq2FHC7G2kb7GgzktfPd9RfttKwzj4HA=;
	b=RVHJWlNBbcWbFWhbZWerd4SLJEEPIkqECj7HlekZWRPZXKYUavodpaTZAERdl+WcMFVU58
	QXfo9dkBx6dnJZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EED21368D;
	Mon, 15 Sep 2025 14:31:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mooGCTojyGiRYgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 15 Sep 2025 14:31:22 +0000
Message-ID: <c2448974-7a66-4fa8-87ee-3c4a824ea1cc@suse.de>
Date: Mon, 15 Sep 2025 17:31:13 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] net: cadence: macb: Add support for Raspberry Pi
 RP1 ethernet controller
To: Andrew Lunn <andrew@lunn.ch>, Stanimir Varbanov <svarbanov@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrea della Porta <andrea.porta@suse.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Phil Elwell
 <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20250822093440.53941-4-svarbanov@suse.de>
 <0142ac69-f0eb-4135-b0d2-50c9fec27d43@suse.de>
 <8715a21b-83ac-4bc1-b856-fa90bb5b809f@suse.de>
 <d2afd474-1514-4663-9e96-7efea30a5eaa@lunn.ch>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <d2afd474-1514-4663-9e96-7efea30a5eaa@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_RCPT(0.00)[dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -6.80

Hi Andrew,

Thank you the answer!

On 9/15/25 4:34 PM, Andrew Lunn wrote:
> On Mon, Sep 15, 2025 at 02:27:34PM +0300, Stanimir Varbanov wrote:
>>
>>
>> On 9/10/25 2:32 PM, Stanimir Varbanov wrote:
>>> Hi Jakub,
>>>
>>> On 8/22/25 12:34 PM, Stanimir Varbanov wrote:
>>>> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>>>>
>>>> The RP1 chip has the Cadence GEM block, but wants the tx_clock
>>>> to always run at 125MHz, in the same way as sama7g5.
>>>> Add the relevant configuration.
>>>>
>>>> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>>>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>>> ---
>>>>  drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>
>>> This patch is missing in net-next but ("dt-bindings: net: cdns,macb: Add
>>> compatible for Raspberry Pi RP1") from this series has been applied.
>>>
>>> Could you take this patch as well, please.
>>
>> Gentle ping.
> 
> Such pings are ignored. Please rebase the patch to net-next and submit
> it again.

Sorry about that.

I did not realized that if it applies cleanly on net-next I need to
re-send it.

I will send it as a separate one with version v3.

~Stan



