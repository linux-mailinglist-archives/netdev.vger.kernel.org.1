Return-Path: <netdev+bounces-55960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87E680CF91
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFC91C212F9
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6AD4B5B7;
	Mon, 11 Dec 2023 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsVtw4ra"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6B7E8
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 07:30:59 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50e04354de0so374720e87.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 07:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702308658; x=1702913458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6C3J0WYAyipRa+Ytnx9imDkaoNr2MbR4O614jO5iC5E=;
        b=RsVtw4raHq+wj7Mwosc8a5Q2qQNdSZEFxD4Nf+EYzvU6j0rJMQK3vGuWyHvKsYVE77
         3yYTtUnZHuud9c5SdvhlXrcmbOkHivWOxbYSqKXu7wSnbVM4slpWcgp/x4JkqaAME/LM
         1/bPrqJAqYLJ3a897aPWG2xwiarvPTAjYepKoR0fB0tKkiAKjyU9VUFDAgJvYuPXCW0/
         v3k35p+RB44Sp7L5dEY3bnQUiSDLlhSv14eja1hscKhpQ4QpUAPAEHTQFHWLpH7+Oz85
         J17OZ4z1PBENYnC034swoIMXCIZ4+ahg5eRJkumHOflgIFRUZP2Q1igqwK38gCcjE+bM
         ZNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308658; x=1702913458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C3J0WYAyipRa+Ytnx9imDkaoNr2MbR4O614jO5iC5E=;
        b=hVV7Fzarl2RONtB0/xrCXF5Hc25kqzTolCkW15XIH4iMeRc6TU1Lh4LflDvtr4OQac
         1+vf4zX3bjapQCb/otPXiFU4xhol1CYXK/5ZZ6Ywf1OMEBZl5szRqnu/nmjxXfCZ9Vr3
         YmUh7dMyqf2+HHnm9Hnt+A850FStnFkOOabHNB04NdPy2wAlGaUHMm0RqP3yeOeqmwXh
         jjS1Ey/1CzC03FDt5QjVEgzFg4k0CCLT2BD2/9wVsci3YTnVQ1W0s0mG8s5vCXg3iAN5
         H7U9JaBC/y+3lUooZY8hQuikgO/5wAjPNqKm5jlwXyPOmov4JBcb3apfttn6EjNwc9QR
         NPcA==
X-Gm-Message-State: AOJu0YyvKfhDU4WK1bKbhhpLBFLnvBPwRIdTxjoA74DfpjrshirRnHOi
	EccKtNBGxx81GmH4drXAHQ0xIe+b6HAaTw==
X-Google-Smtp-Source: AGHT+IHRLIMX/OImBi71r9/Kql8uMh1i5khn7K+bA2j7HJEKYJ25Cw81MWgnfTLDTwIvu1SuaxE6DQ==
X-Received: by 2002:ac2:5e26:0:b0:50b:e571:9bb8 with SMTP id o6-20020ac25e26000000b0050be5719bb8mr1586616lfg.110.1702308657624;
        Mon, 11 Dec 2023 07:30:57 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id cw5-20020a056402228500b0054ce0b24cfdsm3747229edb.23.2023.12.11.07.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:30:57 -0800 (PST)
Date: Mon, 11 Dec 2023 17:30:54 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: realtek: Rewrite RTL8366RB MTU
 handling
Message-ID: <20231211153054.vpgbx7oufazujtzf@skbuf>
References: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
 <20231209-rtl8366rb-mtu-fix-v1-2-df863e2b2b2a@linaro.org>
 <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
 <20231209-rtl8366rb-mtu-fix-v1-2-df863e2b2b2a@linaro.org>
 <CAJq09z4fJmc9=CwdVSS_+LfOS9ax+voWrkPMwDmiBtrCwzc20A@mail.gmail.com>
 <CAJq09z4fJmc9=CwdVSS_+LfOS9ax+voWrkPMwDmiBtrCwzc20A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z4fJmc9=CwdVSS_+LfOS9ax+voWrkPMwDmiBtrCwzc20A@mail.gmail.com>
 <CAJq09z4fJmc9=CwdVSS_+LfOS9ax+voWrkPMwDmiBtrCwzc20A@mail.gmail.com>

On Mon, Dec 11, 2023 at 12:14:39AM -0300, Luiz Angelo Daros de Luca wrote:
> > The MTU callbacks are in layer 1 size, so for example 1500
> > bytes is a normal setting. Cache this size, and only add
> > the layer 2 framing right before choosing the setting. On
> > the CPU port this will however include the DSA tag since
> > this is transmitted from the parent ethernet interface!
> >
> > Add the layer 2 overhead such as ethernet and VLAN framing
> > and FCS before selecting the size in the register.
> >
> > This will make the code easier to understand.
> >
> > The rtl8366rb_max_mtu() callback returns a bogus MTU
> > just subtracting the CPU tag, which is the only thing
> > we should NOT subtract. Return the correct layer 1
> > max MTU after removing headers and checksum.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Don't we need a Fixes tag?

If there's nothing observably broken, no.

> I'm not sure you need this old code. Whenever you change the MTU in a
> user port, it will also call rtl8366rb_change_mtu() for the CPU port
> if the max MTU changes. A call to change both the port and the CPU
> port makes sense when you need to update something inside the switch
> to set the MTU per port. However, these realtek switches only have a
> global MTU size for all ports. What I did in rtl8365mb is to ignore
> any MTU change except it is related to the CPU port. I hope this is a
> "core feature" that you can rely on.

Ha, "core feature" :-/

It is a valid way to simplify the programming of a register that is
global to the switch, when the DSA methods are per port. The largest_mtu
is programmed via DSA_NOTIFIER_MTU to all cascade and CPU ports. So it
makes sense to want to use it. But with a single CPU port, the driver
would program the largest_mtu to hardware once. With 2 CPU ports (not
the case here), twice (although it would still be the same value).

To do as you recommend would still not make it a "core feature".
That would be if DSA were to call a new ds->ops->set_global_mtu() with a
clear contract and expectation about being called once (not once per CPU
port), and with the maximum value only.

Searching through the code to see how widespread the pattern is, I
noticed mv88e6xxx_change_mtu() and I think I found a bug.

static int mv88e6xxx_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
{
	struct mv88e6xxx_chip *chip = ds->priv;
	int ret = 0;

	/* For families where we don't know how to alter the MTU,
	 * just accept any value up to ETH_DATA_LEN
	 */
	if (!chip->info->ops->port_set_jumbo_size &&
	    !chip->info->ops->set_max_frame_size) {
		if (new_mtu > ETH_DATA_LEN)
			return -EINVAL;

		return 0;
	}

	if (dsa_is_dsa_port(ds, port) || dsa_is_cpu_port(ds, port))
		new_mtu += EDSA_HLEN;

	mv88e6xxx_reg_lock(chip);
	if (chip->info->ops->port_set_jumbo_size)
		ret = chip->info->ops->port_set_jumbo_size(chip, port, new_mtu);
	else if (chip->info->ops->set_max_frame_size)
		ret = chip->info->ops->set_max_frame_size(chip, new_mtu);
	mv88e6xxx_reg_unlock(chip);

	return ret;
}

If the chip uses set_max_frame_size() - which is not per port - then it
will accept any latest value, and not look just at the largest_mtu.

b53_change_mtu() also looks like it suffers from a similar problem, it
always programs the latest per-port value to a global register.

So I guess there is ample opportunity to get this wrong, and maybe
making the global MTU "core functionality" is worth considering.
As "net-next" material - I think the bugs are sufficiently artificial,
and workarounds exist, to not bother the stable kernels with fixes over
the existing API.

Would you volunteer to do that?

