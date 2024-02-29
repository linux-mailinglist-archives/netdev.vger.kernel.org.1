Return-Path: <netdev+bounces-76114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6727E86C677
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC221F23201
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA6E6351F;
	Thu, 29 Feb 2024 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Idc0wP+3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4686350C
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201409; cv=none; b=Kywcn9YNDHpr3pH4V+JfJiSaH6XNVJU3XhR7BTv84M0zCk24Nb1jdNlPmx0GOdvBPNwtkT0J1M8tto5vr7UDpW130mm528LidlnRbH4tMossheJNJdXVf29wAAi/RJ/ZojUUPK0kFGjxrJG1avsdv9m1fJJF3/CtQvs/0vRN8wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201409; c=relaxed/simple;
	bh=DWjMA3lq180jBtZQ2KEz5F/uTtoZHOvIFII2FdcP+so=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W1X8n8EBmRgBfGwW8k98WA5TnAculKmMUT0GivpwNU7CR55cWeeoWAXR6eJSwsfiCNPSPo3vIeON9C1OzaIWBCAOT556kcKYLWRBQeIUoBrmOLdOxQIdP+HZMrYkenrWeRaBlOTzl46YwX2uTPvV77yhptlXdos1go6guiCsohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Idc0wP+3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709201406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DWjMA3lq180jBtZQ2KEz5F/uTtoZHOvIFII2FdcP+so=;
	b=Idc0wP+3yy6D1Zs59Zcbh6tDQM7FpUKuWL4sH82PVKvBj+93DLZsiu5wUplRu/ZllNdL3z
	olqCzvs9dGUN6JZ2OItfrVg8HJk62dYD+cRyABJ5f+LV0yWTBXy/O2dxtNJvaToYebYtBK
	6+UVEWkPslUlXESJv7anwiwNo1ZtNLg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-rOwXhkQlNAeAcs8awrqFaQ-1; Thu, 29 Feb 2024 05:10:04 -0500
X-MC-Unique: rOwXhkQlNAeAcs8awrqFaQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so990235e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 02:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709201403; x=1709806203;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWjMA3lq180jBtZQ2KEz5F/uTtoZHOvIFII2FdcP+so=;
        b=nhvH+GbFeLeKA7D5fYnKD9SMprbTwrEPmeP7m9ogetj7t3XQjt5jdaUSolNGDJEGa4
         ZUkzhHdmTqpYD6hENDh5bb1WPbTqHhKqZwGcXcpq7EgY9spZpirRpHr1nxWdLTZMSbFq
         kQllur8lYPggub0S4vKOLxskvRpz1Y/2GvTm+djSQAjYIIxqgwJX51n50HbKcfJMtt2L
         lvm55HkTY8wBE4/p3BK+MXPiT721tVkkkC7mXMN0qh6Lw7jjowyDm4sYCSZMYQ08Bs3r
         p3LyphKnBO7WT5iLzuXa6zhqj0W4dY79WVDZEwpZOGDi++ebeAd6nLT4KY4uWlkmksSf
         v3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDs7YsarTr7SWIai9+CX7fTipA9t4KyJiU23ZklV5+F3vNf6uxRq96IECZUfOohmM2+Rz4OwK9IuE5CzZdWq5A7kSBZPk3
X-Gm-Message-State: AOJu0YyQ7p4msgm5+fHV3jTGrcVzYoKP6K0Xw9rt+OHg284nXwqpmitc
	1yLJvsDLEWOHaLwhqYOgvFTJNmranm0eK7pnW+0my3B0Kc4EEAnqDKAF/fjhQCWEcK+5amZRf8r
	RXKAGKo8mSoDFlCWYoDQ/CnIhk/Ga/wwdL1oXLcd8/Q334JqqiW/zCw==
X-Received: by 2002:a05:600c:358d:b0:412:a314:a9e4 with SMTP id p13-20020a05600c358d00b00412a314a9e4mr1349179wmq.4.1709201403303;
        Thu, 29 Feb 2024 02:10:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjrtjcKNFY6rMFm4eWT26w7ad23/L/F1W1O6LsnK6z/fE4unK4jUwbsFONC/bl42AKDc3iEQ==
X-Received: by 2002:a05:600c:358d:b0:412:a314:a9e4 with SMTP id p13-20020a05600c358d00b00412a314a9e4mr1349161wmq.4.1709201402909;
        Thu, 29 Feb 2024 02:10:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-250-174.dyn.eolo.it. [146.241.250.174])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c210a00b00410df4bf22esm4705780wml.38.2024.02.29.02.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:10:02 -0800 (PST)
Message-ID: <1b6e7f4bc7e664950889c4d46f2e5dcf9e66986a.camel@redhat.com>
Subject: Re: [PATCH v2] net: hsr: Use correct offset for HSR TLV values in
 supervisory HSR frames
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>, Lukasz Majewski <lukma@denx.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Tristram.Ha@microchip.com,  Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>
Date: Thu, 29 Feb 2024 11:10:00 +0100
In-Reply-To: <Zd8nuLjDxLKPgX-W@nanopsycho>
References: <20240228085644.3618044-1-lukma@denx.de>
	 <Zd8nuLjDxLKPgX-W@nanopsycho>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 13:31 +0100, Jiri Pirko wrote:
> Wed, Feb 28, 2024 at 09:56:44AM CET, lukma@denx.de wrote:
> > Current HSR implementation uses following supervisory frame (even for
> > HSRv1 the HSR tag is not is not present):
> >=20
> > 00000000: 01 15 4e 00 01 2d XX YY ZZ 94 77 10 88 fb 00 01
> > 00000010: 7e 1c 17 06 XX YY ZZ 94 77 10 1e 06 XX YY ZZ 94
> > 00000020: 77 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00000030: 00 00 00 00 00 00 00 00 00 00 00 00
> >=20
> > The current code adds extra two bytes (i.e. sizeof(struct hsr_sup_tlv))
> > when offset for skb_pull() is calculated.
> > This is wrong, as both 'struct hsrv1_ethhdr_sp' and 'hsrv0_ethhdr_sp'
> > already have 'struct hsr_sup_tag' defined in them, so there is no need
> > for adding extra two bytes.
> >=20
> > This code was working correctly as with no RedBox support, the check fo=
r
> > HSR_TLV_EOT (0x00) was off by two bytes, which were corresponding to
> > zeroed padded bytes for minimal packet size.
> >=20
> > Fixes: eafaa88b3eb7 ("net: hsr: Add support for redbox supervision fram=
es")
> >=20
>=20
> And yet the extra empty line is still here :/

To avoid more back & forth on otherwise correct patch, I'll fix this
while applying the patch. I hope it's clear to everybody this is an
exception and not the new normal :)

> > Signed-off-by: Lukasz Majewski <lukma@denx.de>

Please have a better look to the Documentation before the next post,
and use the checkpatch script before the submission.

Thanks,

Paolo


