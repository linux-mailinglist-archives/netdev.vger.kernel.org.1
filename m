Return-Path: <netdev+bounces-55999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA9180D355
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2EB281A73
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599444D10A;
	Mon, 11 Dec 2023 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKuVvymB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B6EC4
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:11:47 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54f4b31494fso6771328a12.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702314706; x=1702919506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1dRWJn6S0pN+UaUECAaAQfLfHqYkq5vUqQJaAecMXw=;
        b=jKuVvymBj6gkEAHsmxQy2Ul3lUyWeP2e6pjwFBPyjtb1TPLAL2ABDF8J325S51l313
         pek3tvX4K7LfJUlQjqCofwWSriQonTJOU/QmbKVzYyiSk88cgVnD6OiIDap9L9p5TaSw
         /lxvuJSMAOD9gRc86+chq0CvXGsJacZ9vXPmYT+ClSOBuMcaszv/W8qJ8MFFdxWOQRSo
         mbGS6tME+81ANZDzjIDXdWEXepTKGeNItAzFRVSGDUoAtKvEfzf1oGEPxHVrOBZqkKP1
         2IXHBLJSTPBmY2ezgbvbj4pyB797U2ecsSzhtL+1qZUMvx3wUahKq2ojsTFrpQvwLj18
         7YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702314706; x=1702919506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1dRWJn6S0pN+UaUECAaAQfLfHqYkq5vUqQJaAecMXw=;
        b=u1UuJEdjqXnKjnN15CEnMK2QdqFpuIiMuV8Ansmsn4x/tf7ip6dnAmK1e9ULvk4yBy
         OwjaxVc6MS9zHCFC1v8VqEnBrwPb/Yr5NmYzqyuHz9DayLb2Lc5zmbVtzvcdXMJZ/TzE
         z7eOBmjDod8QQuDCGLVwlTww5CtITvzuz6yOm0dp2Rx3d7NEAaQ3uG0a1xdHLd88HILC
         9xB02wQRHA+n62LEOs6712HFvlZEYBjMtsxTYzGt37eTcb/Pg9vW9vqANz/GZe34bNnQ
         9ms17O9zZN/zMHIYyfPju5SSq0hHgxySzsfGxnxJsEpzFpDMuKdlEqgb17lzFF5kFL5O
         c4AQ==
X-Gm-Message-State: AOJu0YwBKqriieFpoZQbVC37/KAhDqpkjmtZlFV4yCy9fItFdsH5adEQ
	OcWt1aVmqy8oY4k8FIFNUYo=
X-Google-Smtp-Source: AGHT+IFuGRXdOJlZC6/3yxRWFFwxSQrR2DxHAvVaCEu2FgpbFqtFrPQisARxRM0ftS2k1gMF5Qh1RQ==
X-Received: by 2002:aa7:dac9:0:b0:54b:346d:cf00 with SMTP id x9-20020aa7dac9000000b0054b346dcf00mr6223606eds.18.1702314705983;
        Mon, 11 Dec 2023 09:11:45 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id vo9-20020a170907a80900b00a1d450d6f8esm5178428ejc.17.2023.12.11.09.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:11:45 -0800 (PST)
Date: Mon, 11 Dec 2023 19:11:43 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 2/7] net: dsa: realtek: put of node after MDIO
 registration
Message-ID: <20231211171143.yrvtw7l6wihkbeur@skbuf>
References: <20231208045054.27966-1-luizluca@gmail.com>
 <20231208045054.27966-3-luizluca@gmail.com>
 <CAJq09z7yykDsh2--ZahDX=Pto9SF+EQUo5hBnrLiWNALeVY_Bw@mail.gmail.com>
 <i3qp6sjkgqw2mgkbkrpgwxlbcdblwfp6vpohpfnb7tnq77mrpc@hrr3iv2flvqh>
 <CAJq09z45WQv-F9dw-y13E_6DXAfmpxH20JnRoO10za3cuS2kZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z45WQv-F9dw-y13E_6DXAfmpxH20JnRoO10za3cuS2kZw@mail.gmail.com>

On Fri, Dec 08, 2023 at 03:05:41PM -0300, Luiz Angelo Daros de Luca wrote:
> Reviewing the code again, I believe it was not just misplacing the
> of_put_node() but probably calling it twice.
> 
> devm_mdiobus_alloc() doesn't set the dev in mii_bus. So, dev is all
> zeros. The dev.of_node normal place to be defined is:
> 
> devm_of_mdiobus_register()
>   __devm_of_mdiobus_register()
>     __of_mdiobus_register()
>       device_set_node()
> 
> The only way for that value, set by the line I removed, to persist is
> when the devm_of_mdiobus_register() fails before device_set_node().

Did you consider that __of_mdiobus_register() -> device_set_node() is
actually overwriting priv->user_mii_bus->dev.of_node with the same value?
So the reference to mdio_np persists even if technically overwritten.
The fact that the assignment looks redundant is another story.

> My guess is that it was set to be used by realtek_smi_remove() if it
> is called when registration fails. However, in that case, both
> realtek_smi_setup_mdio() and realtek_smi_setup_mdio() would put the

You listed the same function name twice. You meant realtek_smi_remove()
the second time?

> node. So, either the line is useless or it will effectively result in
> calling of_node_put() twice.

False logic, since realtek_smi_remove() is not called when probe() fails.
ds->ops->setup() is called from probe() context. So no double of_node_put().
That's a general rule with the kernel API. When a setup API function fails,
it is responsible of cleaning up the temporary things it did. The
teardown API function is only called when the setup was performed fully.

(the only exception I'm aware of is the Qdisc API, but that's not
exactly the best model to follow)

> If I really needed to put that node in the realtek_smi_remove(), I
> would use a dedicated field in realtek_priv instead of reusing a
> reference for it inside another structure.
> 
> I'll add some notes to the commit message about all these but moving
> the of_node_put() to the same function that gets the node solved all
> the issues.

"Solved all the issues" - what are those issues, first of all?

The simple fact is: of_get_compatible_child() returns an OF node with an
elevated refcount. It passes it to of_mdiobus_register() which does not
take ownership of it per se, but assigns it to bus->dev.of_node, which
is accessible until device_del() from mdiobus_unregister().

The PHY library does not make the ownership rules of the of_node very
clear, but since it takes no reference on it, it will fail in subtle
ways if you pull the carpet from under its feet.

For example, I expect of_mdio_find_bus() to fail. That is used only
rarely, like by the MDIO mux driver which I suppose you haven't tested.

If you want, you could make the OF MDIO API get() and put() the reference,
instead of using something it doesn't fully own. But currently the code
doesn't do that. Try to acknowledge what exists, first.

