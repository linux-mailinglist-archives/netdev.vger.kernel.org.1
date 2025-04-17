Return-Path: <netdev+bounces-183792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 682F9A91FB5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60863ACEF5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023AF1B87EE;
	Thu, 17 Apr 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+AMz0FD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD0A13AD3F
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900209; cv=none; b=ppL10DjndhS/6QNFPD8JywarXkKF8lU31kodKu8YciN1hJw/Ja4Sxnzkpa+8LTqRakB9svkaKWDC6kSp/6AN3NEKl7wAyd07vofUE2lzE27ouu9zwbBO3g84PJMyqJt8jyOI4L8pMZja8Saq3fH/XPxz1LOIZrcQGDlS6kgLu1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900209; c=relaxed/simple;
	bh=T+gmBUW9UTFxcwCmoeuqE9IFQehOc6rXr5096aJ1u3w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u858KAiQz2RyEqeXJAP6p9ZuQzkgYK11QGEj+JUGDsQAo+XdgXl5NK8Pl9XEN1cF+ndYS4713P7tbkopG3vX7LvvU7AUvZEvik3g+H3H7xoVJkqY0meEEbQEjX1CSHROxbSXqF7yRSqs23zow6PYKihq8vRpLC/XnCBGYCkxj04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+AMz0FD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso706012b3a.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 07:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744900207; x=1745505007; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D4YI1ufUTW3giIcsHV0W+gzE22HdLKBPDlMf/viAXnI=;
        b=j+AMz0FD2KTcn//srOAKH28ZG5eDIjR4YLhg9cAYkToQnPAr6RM9mH/2bVCpynNMMQ
         h/SYl8Ygg+Kz0MEeSGveqnaWf0TKrmVlWc2N43ISc/rkA0vKpVBI/2euOg2baG6owISr
         H6rHxpE35FdPqhT+5r2D4HoAocm7yFzF45HUZgWyujXoO331p1StWLiCZbkPJMFbpurM
         ZMP6POIGUIKclQmnzXN6Orfn5Zr3KN1u6m36+CU184/tfu9UdnSaBFDendyNaMFRfiMQ
         +jeP0z0AnuzyvPCZEEfdDQsUAiS6h3NwaqqtAiPCadB78/FIHCv0uMvwhKWwn/iRWUKs
         79ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744900207; x=1745505007;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4YI1ufUTW3giIcsHV0W+gzE22HdLKBPDlMf/viAXnI=;
        b=tELeLwBuruTNwGl7JXR/EgrjZqTCL+okB87g4qmPw7+L2JB2EE/WedoPJlJMM28ThZ
         UBJub5J/Z07IWOBUWr8Cok9qemX0eUcymH6JaSkxPKYZWsV6NV++IJV/JK2bvPPV9Llk
         Aykio2RUcZwshtBcL0wJ5qaihxYUis46HSDqKbuScEblV0Zbf/0JDjNPgOdiZq0ASZpJ
         ZwgGhOUGahIdpCta4rq8oqTiJOKtw4efIT157kbDYkTJ5RSu4uJdkCVsfia0rlEmQjta
         TSaAdG7S9bgac7uMH6BCBGglXcLiSFCikguncylQCwTIrLvOYGHyG78DvuIhJsl4PmTU
         ldeg==
X-Forwarded-Encrypted: i=1; AJvYcCU4nQn8qqQ5PfSVzRfSH6uzHM+rYZDia0i/zLYYxBIr0jGobbyj384ssf2VJn73p/QLb481fqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHT3gEwh5JcV/tkr/6iaJBwVpL4UW+riCYbCsGzroI1ecDbJkS
	+ArhaYywOBWnWAD/7Fd/7KTGRJor/57IE6jbJKO4JzuXvMfUHOqv
X-Gm-Gg: ASbGnctm0AkQLXK1ihtt76N4ahUmW472GhojcGr9EUjpmuOc0D0izRUXVeLUAIN6/gW
	L2zd0I6nXkIPCmJIZ8c899JeqB8FiqhoYkx0fnv7HFNlFqL4eT07Qv1XtnTRPcnRak2/Hs1gJrI
	OQPZ80J50ZoKxNziICIZZKOf5LnxruhOVLQG4MxcfNZ1J3i8oGJPsWKOzorK3rgY0Q9HIqvfLfA
	JFHlpmswXUs799kryKBCo34z+s4xl+/qkNDd3xlLC6i+oaU+70rZkd01D0tkEfRGYI8cGMd0Nr3
	bQCkYNp8I2S+6MtCJaUSWcNUYgwnkRyAKaSmE49TlehoCloS2lmNJ0X53ELeD6+LMWOSJXkU31u
	S7ZQ8zVpQ0z2BUIHt+ahw
X-Google-Smtp-Source: AGHT+IFmwOC4JZu93efxaOTzyOX/Q4eN75L1SHnkU0mAWO8pXFiHN2YESHwNgctppEQcLN2NUDpxOw==
X-Received: by 2002:a05:6a21:9205:b0:1f5:8dea:bb93 with SMTP id adf61e73a8af0-203b3e6db66mr10378284637.7.1744900207430;
        Thu, 17 Apr 2025 07:30:07 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b0b22217ecasm3055904a12.68.2025.04.17.07.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:30:06 -0700 (PDT)
Message-ID: <9910f0885c4ee48878569d3e286072228088137a.camel@gmail.com>
Subject: Re: [PATCH net] net: phylink: fix suspend/resume with WoL enabled
 and link down
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Andrew Lunn
	 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Joakim Zhang
 <qiangqing.zhang@nxp.com>,  netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Date: Thu, 17 Apr 2025 07:30:05 -0700
In-Reply-To: <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
References: <Z__URcfITnra19xy@shell.armlinux.org.uk>
	 <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-16 at 17:16 +0100, Russell King (Oracle) wrote:
> When WoL is enabled, we update the software state in phylink to
> indicate that the link is down, and disable the resolver from
> bringing the link back up.
>=20
> On resume, we attempt to bring the overall state into consistency
> by calling the .mac_link_down() method, but this is wrong if the
> link was already down, as phylink strictly orders the .mac_link_up()
> and .mac_link_down() methods - and this would break that ordering.
>=20
> Fixes: f97493657c63 ("net: phylink: add suspend/resume support")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>=20
> To fix the suspend/resume with link down, this is what I think we
> should do. Untested at the moment.
>=20
>  drivers/net/phy/phylink.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 69ca765485db..d2c59ee16ebc 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -81,6 +81,7 @@ struct phylink {
>  	unsigned int pcs_state;
> =20
>  	bool link_failed;
> +	bool suspend_link_up;
>  	bool major_config_failed;
>  	bool mac_supports_eee_ops;
>  	bool mac_supports_eee;

I'm pretty sure this extra bit of state isn't needed.

> @@ -2545,14 +2546,16 @@ void phylink_suspend(struct phylink *pl, bool mac=
_wol)
>  		/* Stop the resolver bringing the link up */
>  		__set_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state);
> =20
> -		/* Disable the carrier, to prevent transmit timeouts,
> -		 * but one would hope all packets have been sent. This
> -		 * also means phylink_resolve() will do nothing.
> -		 */
> -		if (pl->netdev)
> -			netif_carrier_off(pl->netdev);
> -		else

This is the only spot where we weren't setting netif_carrier_on/off and
old_link_state together. I suspect you could just carry old_link_state
without needing to add a new argument. Basically you would just need to
drop the "else" portion of this statement.

In the grand scheme of things with the exception of this one spot
old_link_state is essentially the actual MAC/PCS link state whereas
netif_carrier_off is the administrative state.

> +		pl->suspend_link_up =3D phylink_link_is_up(pl);
> +		if (pl->suspend_link_up) {
> +			/* Disable the carrier, to prevent transmit timeouts,
> +			 * but one would hope all packets have been sent. This
> +			 * also means phylink_resolve() will do nothing.
> +			 */
> +			if (pl->netdev)
> +				netif_carrier_off(pl->netdev);
>  			pl->old_link_state =3D false;
> +		}
> =20
>  		/* We do not call mac_link_down() here as we want the
>  		 * link to remain up to receive the WoL packets.
> @@ -2603,15 +2606,18 @@ void phylink_resume(struct phylink *pl)
>  	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
>  		/* Wake-on-Lan enabled, MAC handling */
> =20
> -		/* Call mac_link_down() so we keep the overall state balanced.
> -		 * Do this under the state_mutex lock for consistency. This
> -		 * will cause a "Link Down" message to be printed during
> -		 * resume, which is harmless - the true link state will be
> -		 * printed when we run a resolve.
> -		 */
> -		mutex_lock(&pl->state_mutex);
> -		phylink_link_down(pl);
> -		mutex_unlock(&pl->state_mutex);
> +		if (pl->suspend_link_up) {
> +			/* Call mac_link_down() so we keep the overall state
> +			 * balanced. Do this under the state_mutex lock for
> +			 * consistency. This will cause a "Link Down" message
> +			 * to be printed during resume, which is harmless -
> +			 * the true link state will be printed when we run a
> +			 * resolve.
> +			 */
> +			mutex_lock(&pl->state_mutex);
> +			phylink_link_down(pl);
> +			mutex_unlock(&pl->state_mutex);
> +		}

You should be able to do all of this with just old_link_state. The only
thing that would have to change is that you would need to set
old_link_state to false after the if statement.

I'm assuming part of the reason for forcing the link down here also has
to do with the fact that you are using phylink_mac_initial_config which
calls phylink_major_config after this?

