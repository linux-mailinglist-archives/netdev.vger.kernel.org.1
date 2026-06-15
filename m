Return-Path: <netdev+bounces-299387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GclkDjnLL2rTGQUAu9opvQ
	(envelope-from <netdev+bounces-299387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:51:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE116852E6
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:51:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=U628W6tx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299387-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299387-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3541130325BC
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19153C37A3;
	Mon, 15 Jun 2026 09:50:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0432F8EB0
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 09:50:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781517059; cv=none; b=L2s/NCwohKbFOlIuHaWfNf+VibAtvtYXPLEe9XZYfk2kpXAO1s8LXh6fvOX1Ea6UivEeEq+jBc4iRgQZdXxg6RM7Ze1lJkpJFeBamBFRhANiuSDk6rrvFJbBpLgpU5dlHND7NMLtXl5RJuAtsit6jzLuJ90eTULwvGJ5kwKTQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781517059; c=relaxed/simple;
	bh=1Xh/9jpvgqev0sUOAVugYLiqyO+1oxRfC2+ya3TNrUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7mXLbqVXbuQMBc2b8flxWOmyzbLpm7eHVfyzuOvrN+KC1OL9o1sejwmIB8lhiQsKwM+o4cgtiurQ8N4ThcKfreh5wiDns7p9AvtwudV+JjHwjUPmZ+x8n34CgmemfZxOtbxCym7Wy2vSf51TmwyAL9TRyfFV5j/Dzpe7BIgqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U628W6tx; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so2575052f8f.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 02:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781517057; x=1782121857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Xh/9jpvgqev0sUOAVugYLiqyO+1oxRfC2+ya3TNrUM=;
        b=U628W6txnXyDJFsRtuyotITDlzy3czwEWKAMQlGqkvW4u1JzNViylapaRD1JybGLDM
         uPnB5pIlzCLhrSWfQZIsqQSDO+MbHHq1b4lHvwK5zM/byxG9e+foTfA11BoWwqvsFxV8
         a5mREMxjJqZyGtPBxjPuLQcGjf/GTgLcEU3gEVTLMIwtkJ+jouUFa0F9Eo89bFIBH7xI
         eUDruFAOFrlegD/pGwyg354c2Se5zLtMw2II/Z3Jg+/lUfmFV7+J7ilUeZxJD6g3JLb6
         XRPNauVYxUupZJ9c8lMqtGsNEZUbdo6QwuajXUVzYlfdfztIZUNMi45SpUKDCkk6l1bB
         Yf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781517057; x=1782121857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Xh/9jpvgqev0sUOAVugYLiqyO+1oxRfC2+ya3TNrUM=;
        b=bTDPb8gWdci1J2uOZ6LyFEXlwd62h8QsS2M5KodfeocvqddVR1wYogBx44re1TpoF1
         b8pgJYbk4jatlBNXj82EvXMtSxUqCivt+31UxHjk2/xF6afomi9RqJMvjko8jr5nMOEv
         pYRLghOklgfCvkR0NtybLCRoWqQKHcmbVcELBV4DdCcOwUz6F/TQGTn/mVA8yBozLJ3+
         Wqtli21wtZhW7Pza/Kftea4uvXP3WS/IPrFl4jL9Buf9RBMVD2QVEmgBTUrlQjOFTOUq
         5TGH3N3cgI2iQtn0npYGKtTrDDjdOqTEQxFo403m/w9GXYa4S0SCvaoHxC5IhOvtgdtC
         48Ew==
X-Forwarded-Encrypted: i=1; AFNElJ/lzAm+hIPLUnguVf2dwaLWPaeC/t3QXfqiO3uukAeYAqDHOvskR8JMLuvSCCvSjqVrH31642M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8QJ0S+49Nk6ZWC8JbRJFxDJKDVFAOxuzymOCb6Eo3uxlm5wyZ
	gR3spt3cX7vONU75+YhSKZYj09Z+lUxdUGDuxY3kWWkQGYJlDqJxlY4G
X-Gm-Gg: Acq92OH8d/Nrjcz0q2taIroPhQ8QEkP6mtKwkMUGDzvjwvo8gtH9TTsXi2Dd3d7mC8G
	gjka/nGSI53yLy+cW7ClC+yBCLJc03ueWvipSqq0KEtcxI11aeCWnSvwwF7/rqgDqyzCrVp44Mn
	/7NeXr+Y4uGR8GwpxEvs/f4yqRZOzvEF31I3oBk0CP0zzBCRZdtvhuJ5vjkaIWMF67el15DTzPb
	XtKrBFah+jgXmyg0T300RfrS2xbc573xS4TqTjV16OiD39xz/tVWnMUOJwpD3mdzClYn+4lNtpi
	kS/y07PeXo4Gv/6FGpIn/kvU3kFtJBxJQxT/9JijQ7FzZbC2sStzZfuTjClFAHl5tH+8pBrjknP
	XhJPlUDnu+wvHf8i3kn5d8nG6EotEV0jcgrhUfHLHgrm2FVms+PzYMu/rRtZulnZcx2jgFTTVcO
	BRwjF5bjY8lESSf7z1TdqnmCc+/a3CESw8Q5tXSvywYqfTfmCZMEjQbKxgJLyHEwVkW7KXYY+hp
	C9KGzLZtzmNowa5TEqC3yqyQA==
X-Received: by 2002:a05:6000:1845:b0:45e:e509:d2fa with SMTP id ffacd0b85a97d-4606da69cd2mr18394666f8f.3.1781517056750;
        Mon, 15 Jun 2026 02:50:56 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f12e:9401:c875:96a4:7b6f:72fd? ([2001:9e8:f12e:9401:c875:96a4:7b6f:72fd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c3fcfsm29186872f8f.26.2026.06.15.02.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 02:50:56 -0700 (PDT)
Message-ID: <f7cee53f-c1a5-4780-9aef-a3c791b9f7f8@gmail.com>
Date: Mon, 15 Jun 2026 11:50:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: pse-pd: add Realtek/Broadcom PSE MCU
 driver
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kory.maincent@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@makrotopia.org, bjorn@mork.no, Simon Horman <horms@kernel.org>
References: <20260612132944.460646-3-jelonek.jonas@gmail.com>
 <20260615090733.739423-2-horms@kernel.org> <ai_ITHd_xxt7an4q@pengutronix.de>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <ai_ITHd_xxt7an4q@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-299387-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:horms@kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FE116852E6

Hi Oleksij,

thanks for your message.

On 15.06.26 11:39, Oleksij Rempel wrote:
> Hi Jonas,
>
> On Mon, Jun 15, 2026 at 10:07:33AM +0100, Simon Horman wrote:
>> This is an AI-generated review of your patch. The human sending this
>> email has considered the AI review valid, or at least plausible.
>> Full review at: https://sashiko.dev
> It probably sounds scary, but sashiko finds not all issues in one time.
> Bigger patches and more different included frameworks - increase findings
> probability a lot. With other words, it may more rounds than expected.

Sure, I've noticed that in another series recently. I'll just be patient and
address/discuss the review/issues accordingly :)

> You may optimize it if you have access to some free or payed tokes,
> by using sashik-cli with LLM of you choice as backend.
>
> Best Regards,
> Oleksij

Best regards,
Jonas

