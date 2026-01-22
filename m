Return-Path: <netdev+bounces-252253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMs4KfHxcWmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:46:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B45764C04
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC569621DFF
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C876431ED76;
	Thu, 22 Jan 2026 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="WMmVf+cD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50767305048
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074548; cv=pass; b=CXYL11dnMDtuLbDLCx2AkASwYCrDtdPE1CY2ylG5l+iPzq7PaIDL13VI41QRSRf5oNfZHEW+nf+y0oo0KqPMLqJD9V+ROrh74zBWdoP3lUW29ZpL1+QzEc/7gU2+ZzpSKOh18Fy2B9U+yoq3D6V+5UPBqlW79SYEmPrx7FiU7MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074548; c=relaxed/simple;
	bh=CpowxPIs9WsIvTj4/MuMW1Y5/GmzHzBIUQWzh9qqtsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mt0dPe118CMePcrFe5IitdVxRQAoDRXTHgqwJVS+G4d/nls2G+M9cBQ5h1IB6bY9kZGz8IjVpyJ9w6ytEI4ecXbsPF9EDB10ICEiLU2FAIddAw41qxhtUIj5QB3rLi2jSiLXFNuAewNk6vE/6DHTixfTcFbzm/ZJBCyyvNXoyBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=WMmVf+cD; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65807a2012fso1301889a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 01:35:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769074545; cv=none;
        d=google.com; s=arc-20240605;
        b=GcAz1npi5VYqCWgXrmdzmU2CJZjziYTfzvH9HrmD6MD7OwjNpD0TFbEkHuzLxrA29m
         LAjUC9qFAcgXyuL6VXLh2zig1BCSKY53LyvmjUr8PmTbiWAr3Z3zbWzj+eLPGOKwRyCb
         jWQoxaUskF5748roAlegyHVxWwLyfES6lr5CQTxZ8RK9pyGlHZIwI6EmLQWkDgcujXdX
         RvFwUe/O3k3Pie0Iabwpi3D6Q33elgYIU2wweiRgMHjcW2dLhtm+uW+LkkDdQ4h+RvCN
         DvXwlOQsPi2/1Bog5JziCQ1+klF+0CruA5EzYKDHtf83bkQ9jiMhEF4YsHogA+Bae8vi
         rF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CpowxPIs9WsIvTj4/MuMW1Y5/GmzHzBIUQWzh9qqtsQ=;
        fh=VR3cP9WO5WVMOINQWCky3SsGbJHpmh/fWhqiaXjqx38=;
        b=KuelG0L5CIie56dG94xpk8CARLnZVxAHpCPlZD/oDvwZrIxnIe1xWuLBsUjVhGL5yq
         OzTA7XSDw/ol06ZoMPi81IQ00KaxRjb+hSe4N3nRAWSI+K12Q/KrX5p+v3ttEz5Rb4HG
         Yg9fRi/RMyjklA8eTF0ASv+OgV+YQlCOFZbNZ6dQhETBenkS/7A/4rsCfe71yHjOdKOG
         R30G1KeVFtTZi8WCHnCtxp8+FVP9yG7EtW6QM4+3g3WnOa0KRpFfujY2yJKx/sOPl3Oj
         2umPzWxyvqmAN49posGjNxAROurSx1s+rmAfBjTQaduELR85QyOT650G9HwhWSHSXCJ/
         OsIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1769074545; x=1769679345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpowxPIs9WsIvTj4/MuMW1Y5/GmzHzBIUQWzh9qqtsQ=;
        b=WMmVf+cDPVXyzKm73nlXhVqX/GgwBPysyw+V8fdoMVElEaKbT5iIB+JX6bg1SMgNHp
         BZ/xpZLXmDtL49wkbLH6Qe5t/c1FlVbMBwB35Yj2bfbomiTfVmmlbRHxUoEZR/oQWck+
         Be74nd4grwTHoU8lZrxh7rK5Z11b36UuyBJ2+hjYl8aOJ18c08LpQdSkzjpNZL7dXtFS
         T9v9pdYZUJX2F6R2ZKeQUFJ7x2iA+DdPl0QupDzrrWAwUT1dVBgpkasAEVxZ/M05ccks
         CyBCrEYEw1asEPFNKbUBuBO1ZPFruijEtPlo7DqxHXrUhxmMxMlp5rmrVyWYwRFOfOVs
         sNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769074545; x=1769679345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CpowxPIs9WsIvTj4/MuMW1Y5/GmzHzBIUQWzh9qqtsQ=;
        b=Q6eE7F9BcAyOvN3HwwVTudp5Ha0kOGE6gg1FwV3mYgp7pG29k2p9ii1qo2NRBP1D/y
         rE0P1MXMj0hskcBkWV6eHjjIjXdG4PpvgIsTZAiSH2P+HTIrV4rHMzSbUSfLpgDcO2Sm
         B8cNVUJJ5MOLnGNdaKZihuhiWcJEN1H46JOhz68j7C5kd5u1T8feSOsqACEJSfF3Rr0M
         4VXawpAyGJtBCL7+DgjcZRrphIgWei2MgxwRpRbwm/qs8Qyj+Aa7LX0+2l7mZY1S3DeS
         mOUea6L2VeK0pA7Np2kVCXMc5jOBVTJYFBk74MPK5/ZRNhlPwI2YDa7HJkqhsJ+vt42r
         6W4g==
X-Forwarded-Encrypted: i=1; AJvYcCWgJcmKvLiynaq7qbTDhbIkmYTeuO7GCkObESvO//FoQfKL+aK2V6tAV4qvlEk3Dep8FnrCVcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy47p94jWfZCjOewqIrskG+tcRxCFzQQkWF1VQWJyP9GAZ8YZmI
	qweuXGDFwTUpFYD7vNQpwkZByrjYKtjQ1NiAvxKFgKZkF4/MAH2fJseWjElJmgCXGpmhmQgcJCd
	P5/idZCxd+FDC6hB7EWa70mF2ndYzl6StgpjCC3uHYQ==
X-Gm-Gg: AZuq6aJfRYz5WUDoz/htqviJWiordovHoS+VGhDHFfIgSaBnIdWNaFivN1XKdwPCQIN
	qSV+fleUW8eGZxNCcjL9XxJmnZvrLCvaqvxqSrivQ+B9eWB4BLONouXT4fLbHdRoMvs8vV35Ala
	dctCGDnwofj8xTqsuFdV63XlwgKLCdgTmeNUbro2dMAGvL6OOJR7mWnxGznrzHhpkE7FUgYC2nr
	AvlJibhW+lhJYrLhk8easwB5xLRyCuNzNYEQQybXDVHRTCiyxd7PbfjXDB1+otLJAX9i7zNT53a
	+M1O4+P1jHQ+asHIRxqJlf+rbZlgDTNJjSPTzwiu/tCS/HrA9KjPODsLLI0Uhg==
X-Received: by 2002:a05:6402:f02:b0:658:1304:b68b with SMTP id
 4fb4d7f45d1cf-6581304b771mr3388171a12.15.1769074544348; Thu, 22 Jan 2026
 01:35:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115114021.111324-1-robert.marko@sartura.hr>
 <20260115114021.111324-7-robert.marko@sartura.hr> <CAD++jLmitNVhWmUf9BBqLR2_WsAR7V-+ykVJsLK3MuOSUKQF0A@mail.gmail.com>
In-Reply-To: <CAD++jLmitNVhWmUf9BBqLR2_WsAR7V-+ykVJsLK3MuOSUKQF0A@mail.gmail.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 22 Jan 2026 10:35:33 +0100
X-Gm-Features: AZwV_QgGcZewelkI3QjoxNf_Rdp39oV_bH_54mEjrqvn-sBMKJLuqze3gq5di5o
Message-ID: <CA+HBbNEw_9FNOFxx8Mo63Aq49MxWvvuQ4Sc75mXFYpwtMmETiw@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] dt-bindings: pinctrl: pinctrl-microchip-sgpio:
 add LAN969x
To: Linus Walleij <linusw@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, herbert@gondor.apana.org.au, davem@davemloft.net, 
	lee@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Steen.Hegelund@microchip.com, daniel.machon@microchip.com, 
	UNGLinuxDriver@microchip.com, olivia@selenic.com, richard.genoud@bootlin.com, 
	radu_nicolae.pirea@upb.ro, gregkh@linuxfoundation.org, 
	richardcochran@gmail.com, horatiu.vultur@microchip.com, 
	Ryan.Wanner@microchip.com, tudor.ambarus@linaro.org, 
	kavyasree.kotagiri@microchip.com, lars.povlsen@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-serial@vger.kernel.org, luka.perkov@sartura.hr, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252253-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,bootlin.com,tuxon.dev,gondor.apana.org.au,davemloft.net,lunn.ch,google.com,redhat.com,selenic.com,upb.ro,linuxfoundation.org,gmail.com,linaro.org,vger.kernel.org,lists.infradead.org,sartura.hr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sartura.hr:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[sartura.hr,reject];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:email,microchip.com:email,mail.gmail.com:mid,sartura.hr:email,sartura.hr:url,sartura.hr:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B45764C04
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 1:44=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Hi Robert,
>
> On Thu, Jan 15, 2026 at 12:41=E2=80=AFPM Robert Marko <robert.marko@sartu=
ra.hr> wrote:
>
> > Document LAN969x compatibles for SGPIO.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>
> Should I just merge this one patch to the pinctrl tree?

That would be great as other bindings are slowly being picked into
their respective trees.

Regards,
Robert
> Looks good to me.
>
> Yours,
> Linus Walleij



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

