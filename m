Return-Path: <netdev+bounces-254769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JLfN25Ce2n6CwIAu9opvQ
	(envelope-from <netdev+bounces-254769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:20:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF25AF8EF
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52A61300CCB2
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EB1385EF2;
	Thu, 29 Jan 2026 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDCtSlPd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oT6m03fG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F72C11CB
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685612; cv=none; b=RfRjsnfFt6pPAWB9psxN2RLXPeUus6ft2bewN9Jeld/CbhGwqJvaj6xZ3vbFDYcnxPQzznR9dkZ4Olil7OMTmoA6Z/ACR6yYbMU9o0bR78UXruNkb4dcmVtsNr+ROGY5sRDnLL3NNmEcR2cdLQAPxdNW7ox994tBpyjdP7yRTTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685612; c=relaxed/simple;
	bh=3c2UpRNRPcNADyWDct72e6Ft1GfHMTkWulKblwm+x7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2yBwBhupSRV97vdiriatMse9QU/GnGpHeob14aDcwIyD3drlqpZVBbmJmpyEq16g0w3Jk0N6s/UePlxm7ICvU05ig3/HEqoOtFszHL85OGG8Fo4pukh70vrJCbI3vE4kl8b9vpSMtkkSCyNLhuE3vvdgJHUyBdNSX/5lxzx8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDCtSlPd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oT6m03fG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769685609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9KAwwFiWC0huuspRlkL7Z783ifqdkU5r49JiW+Bk/k=;
	b=BDCtSlPdYDFR7BchcsbVKp0QxulVIwY33l1Pe1znEIKqUiCvDizFZSwuLX0XMFDie/bHEQ
	GsgY/qOqvM2UPvCog3FMVVACrrb5+5RHhtoCc3/pDRzNdXsOkkObnXNliGr4Oz8//rK+2M
	udb05fxhsrnMjEwuvjVVzdERwF5uFt4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-AcWnfjnfPy-K0yP0rxCyqQ-1; Thu, 29 Jan 2026 06:20:08 -0500
X-MC-Unique: AcWnfjnfPy-K0yP0rxCyqQ-1
X-Mimecast-MFC-AGG-ID: AcWnfjnfPy-K0yP0rxCyqQ_1769685607
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fcfe4494so997468f8f.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 03:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769685607; x=1770290407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9KAwwFiWC0huuspRlkL7Z783ifqdkU5r49JiW+Bk/k=;
        b=oT6m03fGjKaHq7bcERMDLOzXeLc3YwQag2/om5v7P/U9rp3BxESf169zcEPzzgVRw7
         zdtA2QZ/3HFDP4YNT1DDgKRVS6ypwTiu/+jOrBxtb2RpdKXjsP4oSTaJD0Q5TLgQptgf
         m9kGsUlvFgnlvY8xog1HqxXjfHZdn5kLE8InhduE63H7fiwJa2yiCIzHaNUo/a24grLn
         6U8RYafXLaVDku6ai5Fp2oGNTaA7e/3zsAIZPumv5RbYT1Ou88ZwN0p4Olk4h/NryWEX
         8erEJJr+izSandUBVCgAr9DCIeJlEMpKWa8Jpc9i6DVLLOLjSB+dczpadefsXP/a3yOJ
         c/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769685607; x=1770290407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9KAwwFiWC0huuspRlkL7Z783ifqdkU5r49JiW+Bk/k=;
        b=Ky0tjbSX77AHFs2MRtg1d9aGv9JY1BbThdvlRG1ZSItSBL6Xy8Cfew1vAwm81MU51D
         XNRs3wbclKP4JyW8dz14gShGWChjvVpEeYPwd7kzTBbcRsvxLwcKfJwkZ6vTCbqnIxt0
         BOjzK61eruM0IjeK8wVLuS/+jJQJlarhMGoHjpWFC348GHJ1rKIxbFIdWegbBl9wXFA1
         2wQ8SBuHTG71O8utS3MQnI7gYfesM14R3Oatpobq/HYbBU+eCAPJflk6MxtFgPx/u1Em
         6TldQZraz+5+9EdF4XB9JE4PDvo0xj165XkUIxSqauN1oXQ2EQZNHpjaNA+LBEFjP2rw
         N/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvgy+lWn57TjtJMj/13M9buFHQYDD2IIE72f/ZKkjTSgYSqdulwCj90LMPQO9ow7dgPtObSq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynNrfGBuk30vKozQsF7g8NYNRhL57Le6ETb3Ky4ppPZa8FfMC4
	n81JJxz2143BSiPCJWYSgnjEwAwX81vlbAxuxsl6NwAZe7EfpqP9uksLrKFE75ml/hpVjVq0zOD
	5HSmvpi4sRYkFNcAf8hlvpx6epQ7C12WoJz7QfLfHRs+1RK6K/u/oHl87K+sk8QEMTA==
X-Gm-Gg: AZuq6aLwS3up2LzyZybz/tx5NuaQzSSnH3x5k5jTljm2MXzXnXk7cThVQncqmIPDT7R
	x4TtnJOWCjY0yTDLiJsvktGTQnWX1YNaXrAWCchIk0z4XJ/oUqOm9XJ00uzpiD65bc6LRh6aq1d
	GQMLZDtvv7ocL65SQLBRGtXo8Rn2EVHSKbMLGYbxMHcaSqQPgL/xqSI288IMIL5eiOB+KRRhzep
	g70Ylz/viB3oIVsrs4sABAenquwbEzXgbJba6Nv4RhqZu/O97id0LZm9n08aJZVBJGuTVfhCvje
	UCTaDEUb2/w22803xo5ymcqAjyaPtuTGVhZUv3tbKteytR3hIdz+tKdPLx064nXYZcIKAnA2c95
	PgUW803wpizav
X-Received: by 2002:a05:6000:2312:b0:430:ff81:2961 with SMTP id ffacd0b85a97d-435dd1c8f14mr11363844f8f.51.1769685606532;
        Thu, 29 Jan 2026 03:20:06 -0800 (PST)
X-Received: by 2002:a05:6000:2312:b0:430:ff81:2961 with SMTP id ffacd0b85a97d-435dd1c8f14mr11363779f8f.51.1769685605948;
        Thu, 29 Jan 2026 03:20:05 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1353ac2sm14589049f8f.38.2026.01.29.03.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 03:20:05 -0800 (PST)
Message-ID: <f65fa8c9-651b-4a38-b1aa-bb923011f450@redhat.com>
Date: Thu, 29 Jan 2026 12:20:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: dsa: ocelot: check policer entry
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
References: <20260126061340.757543-1-mmyangfl@gmail.com>
 <20260126061340.757543-4-mmyangfl@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260126061340.757543-4-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254769-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BF25AF8EF
X-Rspamd-Action: no action

On 1/26/26 7:13 AM, David Yang wrote:
> rate_bytes_per_sec might be 0, check for it.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/ocelot/felix.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
> index 9e5ede932b42..fb2d02ff0fe7 100644
> --- a/drivers/net/dsa/ocelot/felix.c
> +++ b/drivers/net/dsa/ocelot/felix.c
> @@ -2011,6 +2011,10 @@ static int felix_port_policer_add(struct dsa_switch *ds, int port,
>  		.burst = policer->burst,
>  	};
>  
> +	if (dsa_mall_policer_tc_entry_type(policer) !=
> +	    DSA_MALL_POLICER_TC_KNOWN)
> +		return -EOPNOTSUPP;

I'm not sure this strict mode is what we want or even we can apply it
now: it could cause functional regression with setup previously
completing successfully in presence of 'new' params and working to some
degree and now failing to start.

Generally speaking some/most offloads are free to ignore
tunable/parameter not available in the H/W.

I think a way to opt-in the new behavior could help.

/P


