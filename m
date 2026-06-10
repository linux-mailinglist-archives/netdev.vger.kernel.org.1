Return-Path: <netdev+bounces-297849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WtCeL5DoKWrhfQMAu9opvQ
	(envelope-from <netdev+bounces-297849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 00:43:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3458866D3B4
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 00:43:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GCDhfGUX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297849-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297849-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C074300DEDB
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A9833F38B;
	Wed, 10 Jun 2026 22:43:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BE235BDAA
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 22:43:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781131405; cv=none; b=VXFoFx9VatnnU5tZBnAu2lswO+gdn447HTewDJojxTwpjTZ1NFrcti1CwmU8vPS2LkLvF9qD60bU1CBKv9gmtsBTm91+0saQHfALT9wZ+s66ID3lQwCsSzZr7si1LZfvWPcF/duhvvNHPSBJfDsHxDK0nCKlTQS8bQI6CbCmkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781131405; c=relaxed/simple;
	bh=0mIimJZwSrMOwOod1z2uAYi8SE+ZraOi6XHfdAjx1Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMzzdpeXbiP7i+JxToaBu4ozeT6QKjfrDmawqdcbEweOZIYcXdAhDBSrSjd6NjvQpeMMv9Z4p3hTs8DoLj9y0MWgwgyLhx3rtwxhz9XIhpfMDIo8Z5P0A1sZE4SCOFVzhj2ga7OLlIdVmFrWKFdfkmy5CISnZNX9+/q+Oda5jL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCDhfGUX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CB81F00898
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 22:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781131404;
	bh=62bFE+9EiC4Wl6sR/gNVDtGRVBnRqEmz0YnELUX+5Xs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GCDhfGUXvvVNHLXhr3frkjO1Rp4OtsKp0qM3R31fePjb//IULavexvDmNUUwA04Ub
	 Dzlzh2pzRTGy59f+l+FcFl6Yb7JHo1erepIH9ag8J/kku0Cip94/n/lnMR10AXod+E
	 Eo9yh0/1Iz8nn2Z2avr7KPAgjzoa5BEPnlspQTzlg3rKjx1wz7yacqY5QAT1hJvXmc
	 p+h4mmaqYQXlAywwxh+PM6aAWHmctdeOpMdFSOJmYCYFWVtcq+mLZQz8SbOiIU5i+B
	 W6h3yZfiZGrVAGQ4KxdyXBJ5+NYJjpIS11ozMi8kHTJQg+Iz/vEkAJtdxm8C+VNjjZ
	 1YzD783Gy0FgA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bebb72b845aso1167495766b.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:43:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8BYf1529ktTGMW38s7gszFhgc9jg00oj0I/lyOiWbTQJKaFEhGJo91kFXjUDrj2sKVjk9f5kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YweqDmOdjJoIi5W2xC/Wt9VCYeX7yvMJNUqcq8P65Is7Rf89XHq
	PaJ0k8SGi6m09kfh4+fhpuqdXBBf5AfqdJOybcGxaVZ3Zh6ud0MQWXDlI71Zw0lh/viDKVywqji
	Or+F7Agwazo5kf5tUAtIj7xWbyEw/pA==
X-Received: by 2002:a17:907:c28c:b0:bd0:df77:98bb with SMTP id
 a640c23a62f3a-bf3702817fbmr1479114866b.9.1781131402612; Wed, 10 Jun 2026
 15:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609151212.29469-1-ansuelsmth@gmail.com> <20260609151212.29469-9-ansuelsmth@gmail.com>
In-Reply-To: <20260609151212.29469-9-ansuelsmth@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 10 Jun 2026 17:43:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJdBxsbUK+n9h17K9SC7ojcPxemeijJhUGQt9HuB82OYg@mail.gmail.com>
X-Gm-Features: AVVi8CfnalHGFSDJtFBoMIJ88H-i-Yw1YCOHz7GBxBm4GdczRrsSV4xJzXraBNE
Message-ID: <CAL_JsqJdBxsbUK+n9h17K9SC7ojcPxemeijJhUGQt9HuB82OYg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/12] of: property: fw_devlink: Add support
 for "pcs-handle"
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297849-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ansuelsmth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3458866D3B4

On Tue, Jun 9, 2026 at 10:13=E2=80=AFAM Christian Marangi <ansuelsmth@gmail=
.com> wrote:
>
> Add support for parsing PCS binding so that fw_devlink can
> enforce the dependency with Ethernet port.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 136946f8b746..e6584a2f705d 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1392,6 +1392,7 @@ DEFINE_SIMPLE_PROP(access_controllers, "access-cont=
rollers", "#access-controller
>  DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
>  DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
>  DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
> +DEFINE_SIMPLE_PROP(pcs_handle, "pcs-handle", "#pcs-cells")

There is no such common property "#pcs-cells".

>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
>
> @@ -1548,6 +1549,7 @@ static const struct supplier_bindings of_supplier_b=
indings[] =3D {
>         { .parse_prop =3D parse_interrupts, },
>         { .parse_prop =3D parse_interrupt_map, },
>         { .parse_prop =3D parse_access_controllers, },
> +       { .parse_prop =3D parse_pcs_handle, },
>         { .parse_prop =3D parse_regulators, },
>         { .parse_prop =3D parse_gpio, },
>         { .parse_prop =3D parse_gpios, },
> --
> 2.53.0
>

