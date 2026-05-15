Return-Path: <netdev+bounces-288217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMrzNwPUBmqKoAIAu9opvQ
	(envelope-from <netdev+bounces-288217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:06:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF2C54B07E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 381EE30B019B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC463FAE0E;
	Fri, 15 May 2026 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDUWpdbk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1F63B8D48
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778832031; cv=none; b=eXxVf7jojhNdvN+01wocok/JgxTdycpsU/v3c6eRqEOIt8zNL4CaFb97xm7XJ2pZCeJTmg8PPfyPrtr1PQwYBZF7vJDKUuoj5tRRZFZ5Ze8M9HUf90rl2qD25FC1TzPNMAG4xN8fZolxkmyPGtgRmMLL412IsDcNcf4nfjMZ3iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778832031; c=relaxed/simple;
	bh=lYTXQrRnn3pTeKP0KarraCZ6ditW7PaLIGVHyzGhWCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQcYQuk8S63nsxcoJQnSUxBI9uLMOz3WRhqc7FqvslzZslnSPpiSHH7NWbX6nlIdwmf9Z4CFbTMYQtbiAjNSHf6+zK32eRhC8Tz+E+oOBrWV+sGKHr/ZwUfvuQXq6m4uiwr9eQ5rR3WSEGpOkYfmp4aL/KX0WnWY8W3RLPWk1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDUWpdbk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd11a3729e8so757885566b.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778832028; x=1779436828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lYTXQrRnn3pTeKP0KarraCZ6ditW7PaLIGVHyzGhWCo=;
        b=LDUWpdbkGDwuo+JA0/qPmMUcT1+o9Fq93WvytNkz/3sxPoxHDl91IBdr2EcHt17Rdh
         1kkjkWadDlKf+N3xyFAmatdCSXya7XEnok4zUXnjVrpEoIkDt7Rl2Msb6BIP0vPbUnau
         VTNpGUTd+LXqCZ2rqMuN3EZ7u0YPBa/vVAx4itPHDk6gqILwJTHvRvd7N55C//QjLmj3
         10x4mdaet/M5PYPGB/O1nZ9TT/N/Tv+OUCewxHAio7JjSIdkZMJM2ypTRQWJitwgJlO3
         cPBlN36wCM6MyNLDztTyJzBcbLXFxMp4WsNMXmwy59EyuSU3D9QjFd1AhQ11ZpwXRnwg
         nuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778832028; x=1779436828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYTXQrRnn3pTeKP0KarraCZ6ditW7PaLIGVHyzGhWCo=;
        b=FqkdatA7dEvXnN3Y3ROoKKW/ASNAGE+vxoM+Ps1POVqnDJSZaQZ+NF3Vq78ydZgJEt
         Db9LrMed9IWATWOd1d4614Ej11ozJSb+Dpc0TzYfDqtRAhKF/zr5WRsnkHmeldpk+lXu
         hLegRY7ayMjUBqD0SCcxJOEkjs38VBzoz0uvl33L5xM0xIA2JVnXOk5iedrhF5NcmnUv
         TF8D5eC/nm8ZWfHZee2InJw0FccfjFez4OLW3FeldvPM+9YSbDYFlFxHl5kt0ZD3RwY/
         RWOIZ5tuTSCqRd41Bs/O6/wvt6Ct8f2ZuPHI/PJC831spM91BA+BC3mEPx+e1/ANMKn4
         TPeQ==
X-Gm-Message-State: AOJu0Yx/BcfVoiFG4bhwt16B0krNYsmo/IuveCuFdBk3s+V4AfXSYJFC
	0K38Tv6AqbQ8a/N7w+0GoM9QJ38C4vs1tn2/80hkvFsU1fIbaZ/KVtuu
X-Gm-Gg: Acq92OHSgY0C6WNgstM++CE5dMyVH+TvVNOhJ+dlYaaluFen53e+6JP9IjmkDClWcE8
	2kI0qq5EO1fQ8wUQh6hLNhaghzNPlqZmT/y/Au9sCRXRNS+U0HgS+PgscGI4zNvKfff+27xExFI
	L2RMIu9c4RKG8XagoI3m10LNeDeWT+zPMzwOBa4ILJMyuJndVUOv0oR6Z6/AYJPLTvgtvSOvoy4
	sWr70w1NfJQZlVZuo3CgwpJWl9ppsSxHLFapW1OC3T+aODSlv7wT4k0sycI/c+pz9a0WqO6OhK0
	d5azAf6OFWfQh9W6l9PL+zd/HIM7zOUMmRmX8QUimW8KxlIDGTGgiOAANCVaWzgIuav/d6V8MX8
	+7/23KrGrbtjoaBxNUfqQhq7YU4KAIctMomZhGexDCAizY0Tx3oz1oWcUuC+FuIun3SqMHCIfjr
	bAC8CEoFI+C3FhL5fpuJj1/4s+go1f6H5Lem5eRyHnX3ffNnRfz0ttU+iM8QWotaPAxHOp1pZxK
	d704/jDbiL4ytJ9261Wv1F0uP1YEsu8Rjim
X-Received: by 2002:a17:907:6b0d:b0:bd3:2e95:7778 with SMTP id a640c23a62f3a-bd517a8865cmr130887866b.45.1778832027729;
        Fri, 15 May 2026 01:00:27 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f130:7401:896b:ff64:44fa:9150? ([2001:9e8:f130:7401:896b:ff64:44fa:9150])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4eac613sm185085366b.56.2026.05.15.01.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 01:00:27 -0700 (PDT)
Message-ID: <445c5889-20d2-4e24-b539-c38603d8c64d@gmail.com>
Date: Fri, 15 May 2026 10:00:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] net: sfp: extend SMBus support
Content-Language: en-US
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260507093301.1144740-1-jelonek.jonas@gmail.com>
 <20260507093301.1144740-3-jelonek.jonas@gmail.com>
 <a9f99a01-4ee2-4d46-a512-8e920a0e7ead@bootlin.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <a9f99a01-4ee2-4d46-a512-8e920a0e7ead@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7DF2C54B07E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288217-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Maxime,

On 15.05.26 09:33, Maxime Chevallier wrote:
> Hi Jonas,
>
> [...]
> I gave this a test and it seems to work fine with all modules I have :)
>
> I tested on both boards that have single-byte smbus, and ones with a real i2c controller. I had to hack around in the i2c controller to pretend it only supported smbus, that did the trick.

Happy to hear that, thanks for the testing effort :)

>
> I'm unsure if you're going to followup with the sashiko review on this particular patch, it does seem to raise a valid point. I'll followup with tested-by/reviewed-by on the next iteration :)
>

Yes, that's a valid point. I'll provide a follow up where this is fixed.

> Thanks for this work :)
>
> Maxime
>
> [...]

Regards,
Jonas Jelonek

