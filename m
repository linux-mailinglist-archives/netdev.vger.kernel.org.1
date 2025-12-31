Return-Path: <netdev+bounces-246397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16434CEB2E5
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 04:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93FE83007C67
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 03:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3A416EB42;
	Wed, 31 Dec 2025 03:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIHxPYO4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2758F3C0C
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 03:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767151053; cv=none; b=e2HX99BDPNk8jnX0mXHeJ7rA2HuVNAUq5k3t8XVlksA/uLPgG1OkpbUG/tUjJq7pcr6joDzaM2mcuwjd8S+uOKAGuhakAjeAf4fmQ6KChRfao8VL2M/xj3cJkg87+iCwWuAJlTK4WxnXmG6cYtbxEJD9ykhLPDzhKN7UXAgrIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767151053; c=relaxed/simple;
	bh=TzFgzR/i52rGJzD0S2GBuYd6dgVsQDGejya+ywx9b/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmRA9LNNG1u7G+4s04xBCEVgPSX2cXT90nkdX93E6fTE8vMOQrbVSLwYEj+HjOUx5wTrDerCWOp/TA7rSdxxoR/GmzVgtxIJHVAq2m4S6dvYSTlMgagr7ATwb837G+VVgYiS+/dZZH8Qj7L9xCCAy58dcKNxeiDTDBnU6sxW7m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIHxPYO4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7636c96b9aso1907675366b.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 19:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767151050; x=1767755850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4lro/TNp5JKHHkv7Fbfv1XLzIu3BUCeIGtt7kOfY7sI=;
        b=dIHxPYO46XOb/mWS7DhwgKDE876AUoDypi12lelkKwiek4ACmMGsgKU8GY9hhItr98
         4HAG42LZV86tMjI8EOm7gcEWmShgk3oATi6XvX7F2ULpoPGPqcl2xBH5xJI4DMilyN1G
         DLtol1bDxzY0yTGxkfqBj2+yHgWQMI84mvp9Jzr2im5SjEazJN2Nr7Elq8XycKJFgrjh
         w5UvHyev8Z2vHdWZhX/Lx1mHcMZa5vh1e4zP2JaaQnP+/o+cklu4pOgcK2K7yytBP38W
         Xgz9ZRJ2GM7UYaWrgfuLo++/paCanVUD94/lrxKa4FgdLKWrvqYUB3eXhN3OLZMuB6jC
         aNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767151050; x=1767755850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lro/TNp5JKHHkv7Fbfv1XLzIu3BUCeIGtt7kOfY7sI=;
        b=oB70dQks1oEhb7w7u+E1XXPgF06jxroC/oPLq4/ty+m4PnYRH8yihg4PWuTZs+Jxg9
         lMBlf7MKVvc0490SHh8dLeAlqFKD+l2E7hZEVGVj+/ZG4b+lFVQkyD7qbnauVAb1gKYE
         gN5gWqInThSXZlj1SDa7ntyKxUpAvLq6HuX5BBHh9MqCdTeXxvncHdJ7YQjWJklZWbtu
         RwUAXVaNR40VNBt907arUGATzXsxUO3/jE7fW0flYVuVlmlgwj+iu//JRRvOex69wuAG
         tzngRrMQW24F2wyDTJiAVb+ViUBHmAUo83+v5I5aIGzBoK7HY9vHb1sNM8WWY7rcegom
         w/Ug==
X-Gm-Message-State: AOJu0YzIeq4xJBV+NzB6nXj0MbC2woWfjymmNtmCiSMVlun1bdzamTdO
	TF9BOQbUaNk1ScVP+RZUc694/BDIoT1FJu09/gPyzp118u3Oj80CpD4mt4vJWFYKAc8eivkGGs/
	SXD9i42wx304JLT5/qxgOfHN496YPtXQ=
X-Gm-Gg: AY/fxX4xItxLH3l8i2Hhz5Y5Up6KUOwKPD5jIUSv1PINNgHOQ/EoavGFdEe52qskOfe
	QFf96oHqVCOq+2aoezPL4V+hA+TtPEuTr3jRXeRQcHcHAaA4QNdgJAF6msZ4dFAeVV4OV3tkz/U
	Saf5ors8QEEYFVX5iw2v90PgwSLjn3oBbKMQ2tNUNka+ps+rFb/CKbMZ/PYnOWtzZh44/tM7aY/
	MZATBmn7YyYE8kHTGQBcQPmK/mXC6PXPkb+ydjwC8zho9QEwLUX2I92jEuNClERCn8pDjDubDuY
	7Nmr/ueeHsG4tkAmDCI2lyIRspFaHQ==
X-Google-Smtp-Source: AGHT+IFFTGzjOIpSs6HWWtm+Hs5FllL0XxNXpPAfz7vrWwn1uxA1tKVRysr1Tpxydvro4reZw6bfg5GC9oyku2Be2Vc=
X-Received: by 2002:a17:907:9613:b0:b83:972c:77fe with SMTP id
 a640c23a62f3a-b83972c78b1mr395757566b.2.1767151050325; Tue, 30 Dec 2025
 19:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127120902.292555-1-vladimir.oltean@nxp.com> <20251127120902.292555-11-vladimir.oltean@nxp.com>
In-Reply-To: <20251127120902.292555-11-vladimir.oltean@nxp.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 31 Dec 2025 00:17:17 -0300
X-Gm-Features: AQt7F2puhYLfGdhBDLMRQVJlNN8D2b0WZN_iGlKoAr3IQvBXHTDbDvmdbGJy1Ac
Message-ID: <CAJq09z713UGs0LRzs+J=iNs+frwozSg-9g0x+Zg2xg+0F+4J5Q@mail.gmail.com>
Subject: Re: [PATCH net-next 10/15] net: dsa: tag_rtl4_a: use the
 dsa_xmit_port_mask() helper
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Content-Type: text/plain; charset="UTF-8"

>         out = (RTL4_A_PROTOCOL_RTL8366RB << RTL4_A_PROTOCOL_SHIFT);
>         /* The lower bits indicate the port number */
> -       out |= BIT(dp->index);
> +       out |= dsa_xmit_port_mask(skb, dev);
>
>         p = (__be16 *)(tag + 2);
>         *p = htons(out);
> --

It looks like overkill for this simple switch ASIC but it will work as before.

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

