Return-Path: <netdev+bounces-264501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IoOCSbAqWnNDQEAu9opvQ
	(envelope-from <netdev+bounces-264501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:40:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC4221661B
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19F1C308109B
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 17:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CFB3E51E2;
	Thu,  5 Mar 2026 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMkGmsLW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFC53E51DE
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732289; cv=none; b=qOM0aWPCANvLKtP42oCE5wSldDt1gdrRbwu9yvko9LI7eheSuoY674AQu6D1m9LLrUql3lVo2UdPiv/0Fu1cr9tJnjjV7JQ8t9ept11vrOBlOIjrZ3SZ+F8/SihLcrhodPW2BhWP43oDHr5UFt2UUrB9oBUpRPbEYQ45zIZ3gmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732289; c=relaxed/simple;
	bh=1SFivHJNp6lFqWXGCjmUNDc5ku8X8fzz9fVp7gurgLs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YgMrjoGViaCtQt9HFWDUYigNho80/+YwByWK8+OZMZ2x+4mA+0+aOWMpmwCp5F3YRbUtv9THssjljfdvpl1ATmM1VwWHMcRXMkUo9dkQhKI1zJap+lmp1h8EMZjLOT2rUqlFc7nlof2A995IqMcryHReiOHPa2TpmYLkb5xVtzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMkGmsLW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48336a6e932so52362295e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 09:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772732286; x=1773337086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Im4Z1NaOYIMEkgHbYhBFyPg24mwOCuMpeAwC+Wa7ls=;
        b=YMkGmsLWoy9Ync6ebWVryx5N3fA0cYiEILaPrGL9txC9uz7DmIj8CV5FTQRf7GN2NN
         +i+R9MoiVDGFYsLBlALpVH58C1GTiRM2hibrRRkAWrs9jSterSUX2virgPAFySJhVyP4
         7aC+qTA05XLyGGdZe3QKGL/pHW6OK9OLlQD6DeXxXBGBaSUMlapkKf4ywNRH1QAO1c/h
         tcA/BDE+Hn/wKUg77NGd0UeCEXdB2UH7NrOvyESAiHHR0fKF2BK903XIPqTFNhVNY4xV
         P5hXjSzctDhohMLQ+rTlJZBiKQEJMO980gdfPXkPxVynwziQ0ye1g7b9miHhli7hTKzj
         C0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772732286; x=1773337086;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Im4Z1NaOYIMEkgHbYhBFyPg24mwOCuMpeAwC+Wa7ls=;
        b=d/RoI95zB7Ox2yFrGAn8Q9piDge5w+s9aPd8fe3hffrQpeFiDOraIQhunKJ8hO9qHL
         9Rp0jbqX+/iaCfFVR0RhePlMoppv+jgbwm1KwUXOorCrJdeT5YOsu0lzncrQqTLvLmsJ
         bUmpqB5Wx4aeYCMCMvO4eHadeDo8RKBrf4AoJkY7GMRN+dYqy/AVDI4wm/kVPw2lTlJn
         XRDuYAjSseDvxuHumFAv6uUV00hwtkSDcx3ukpy0XoHY1HHUfBvFolefnLQECm/NM1TO
         89XizLjjYsE5V30jeG6Hbt0NNcdN3qCBH4faI8PqLakgIGp3b7wiDGWEUggy2uqEnVVs
         3STQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8NF2o/Ia0tccdCPfyLThvC7V9c+ZFb5k+KK5EJhpTma0hOSDqFxvfmiMWpERv8HLA8RzQt50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMgS3kZ6ByjTjk2P7YOlQ/x1jm8A5FK6kO55qKAwtKAbAR9UdP
	6fCrDQ5VJkPe4G6oLGvLBAK7Bmk+v3UCce/zHURp6vH/FkYIeuTXOSxf
X-Gm-Gg: ATEYQzxaFOjQvfzsgq2H7PbFQhmffuq3MIivYxgZ86UPxGIxQQZiFwEbpqXnK51gh0D
	K14fbAhnG3nuw6EMd7h7/o4AYe0pU+GejRtqwvXXyIugnMykngUQ1Hw/IbC9Cy82popzPAht0FB
	s5KtafHfurOq3auL13JOOQEILIZYXlOMx4YHXCA0hcH24xby3mrQhIh2N8hvgo/AejezmTPUaOB
	lZHSLcH6LpQY074McJPxxNsGG7VkphsWsSu9Anw/H3IyIGca3CLJQ8f9iATc8vgj9+b5sFn2OtN
	SOwiv/qKlsZsDOKqu0DfwDbsVVtXAXB5bQBSezCGk3GPG8aB5Mxv1u8pUd/Rw3EebxnFTtF89vm
	fL62J99kZO83edcrJWYiGvbqm8CE/enMo8m7Bobk+zcqVZbZuAI1Ra78yGx0hoqZeHRiQPYAV1p
	upaYwq7eX6Kw6p9MCwGbBA/TV9yXi02wyoc6tK6CnmP7CIA2m9Ws411m/7TU55Q9Cbyrc6nd0po
	6BPOMR21Vcg7cA5mnmwncikrkKLK0RuB5qrdFepr0IR0uBMPwDe3dKNho8/6qYMBA==
X-Received: by 2002:a05:600c:4f8b:b0:483:71f7:2797 with SMTP id 5b1f17b1804b1-485198516bamr106794695e9.14.1772732284992;
        Thu, 05 Mar 2026 09:38:04 -0800 (PST)
Received: from ?IPV6:2003:ea:8f26:e300:f4ea:baa8:3194:fe01? (p200300ea8f26e300f4eabaa83194fe01.dip0.t-ipconnect.de. [2003:ea:8f26:e300:f4ea:baa8:3194:fe01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b503424fsm37162072f8f.22.2026.03.05.09.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 09:38:04 -0800 (PST)
Message-ID: <05fa2c19-1b6d-4803-b37a-e554b6e51670@gmail.com>
Date: Thu, 5 Mar 2026 18:38:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Revert "net: phy: improve mdiobus_stats_acct"
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <9246ddb9-3f55-467d-b9fa-9239d9391020@gmail.com>
Content-Language: en-US
In-Reply-To: <9246ddb9-3f55-467d-b9fa-9239d9391020@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6CC4221661B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264501-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,samsung.com:email]
X-Rspamd-Action: no action

On 05.03.2026 17:51, Heiner Kallweit wrote:
> This reverts commit 1afccc5a201ec7c9023370958bae1312369b64da.
> 
> As reported by Marek the change causes a warning on non-PREEMPT_RT
> 32 bit systems.
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

SoB missing, will resubmit.

--
pw-bot: cr

