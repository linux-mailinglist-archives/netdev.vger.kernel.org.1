Return-Path: <netdev+bounces-138561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9249AE1EC
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0756BB24767
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2E21B392C;
	Thu, 24 Oct 2024 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvwUEdbE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19514F11E;
	Thu, 24 Oct 2024 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764106; cv=none; b=BVdS4kHnKd1oJo6vHi0sZou01VfUlEf3cGCzJAavJqgx4T/OUhdBv021mVq0xZ9XIpxxKnFhmYklhfENwrHrkzNrFJNPg1VMDCq4ELv1KMIYMFIMK+/yIknt12780FldH+gzJM2eIdwjxFCRu2S1XdWc6F34ydfELyvvbTe7IKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764106; c=relaxed/simple;
	bh=MPy6/5ShmaA/r3iJah2uDelJSClWGiyq3tiinNtqT90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViEErLueYLvjf/XDL6pK8z+H8aOcVFLR6uIbSGnLp2KzbcT1jcVYQLkK6QbG/R9ncud/TeK2LvqmTndcOjeKD0YeAZMQ7CdsVZE+Fd/upc+aLFvTBxBsOfRCU/93t8VYziUV50clViEhkAhnws0ZZ/0UNKXzmNiEPpcyNbW3elY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvwUEdbE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cbcd71012so6402605ad.3;
        Thu, 24 Oct 2024 03:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729764103; x=1730368903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYUvSi+gse+8H/LOQ3JaF6Mgi/9sTqvwNeV7DL4St4s=;
        b=YvwUEdbEB+JjvSCl06endnZppGHpWUhpHUZVIzjlec5kjYpu73Hg5wTai/Aj4TYOK+
         6w7qsspPsUgMshNT75c8fldoE3T+zcdTy70iJb0k8Wj3HE7wXLwpHIr5Xcnayr1aO2Il
         zX3jf1SAndzmBA8t5r41qIy2efBHYTpl1NhbP2yHZ5dacMMHOl/JDWXk2e7kI+ZvfVrb
         lvmH+jolw6Bfst5kezbyBQzJCwbmXkcUsI7gj9H37hgn40bH9E46WHUlbp6NY7qm/zTJ
         ynDlLoholOC4G+MIpuwq2LuilYdjhHqhmNrnJcWTThEHMM82y7Cn06xVQB9LTTGitBrc
         MFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729764103; x=1730368903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYUvSi+gse+8H/LOQ3JaF6Mgi/9sTqvwNeV7DL4St4s=;
        b=qVMqn9G7bKtS0tiYHHbsj3VNCGhiADnbb0c3BnSHEoopFL/91gmzSb5fGQMsTzSJS9
         KyyCUzEa4dr6k8GaZiLC4iMza6/g3ZHgDKayFFNKtWByXXxetXrLZLPQT6ptkhky/6rD
         uf4RFPBuou7y00NjMZvHgXsZ7FyJ7g/GoS99nrxmhrP6ONuZl3QJRDKcfERQ74RkjbNF
         rPP2b9gCoUvn54Ui5f6sYo4lqbpee3XzFOEwerSQCiqrwulKdfOHqif03VUBMk0KpcMR
         wvmxVpcZ7ID/5LX2x19TTf8Bsna5m3yC7Xu/VjxPFdDmPeM81PbG4cbBh8gifo4PT2eq
         nYsA==
X-Forwarded-Encrypted: i=1; AJvYcCWs+Til+2M0CPfM9d9QE87a/07h++mTYHkj/qxYiD8Tz2XI6eckQ4lPtNLj3M+4nrJ/cVPpOu4ITN3LEKV1@vger.kernel.org, AJvYcCX05uPvECwspglyMEmRo7q3GaPuC09Rt5ibt+1JGZhZJEMrC2IcP9IhpJWAMEBTL/gMegKCEcA57nU=@vger.kernel.org, AJvYcCXk6S/vZxCWWvPS745eiVLiw3H8XRZ7HsDTHUZ3kEI42OOobzBqpN23NJ5RUktnoDOjroqOoUKu@vger.kernel.org
X-Gm-Message-State: AOJu0YyHLuXAefpnejavGzSTNl79XdVKavJCeOj0U0bqMhONH7CtVd5Q
	w+j7qEJWIrjHbgxt7pQA2N7d5pUiGtsta6lQfJsT9VWjyrJT1D6g
X-Google-Smtp-Source: AGHT+IHVtZgCwaNHrrrkEsT/G/oYXdvXmuP6ANPNRJmjPBg1sdexrB5zsRm2r8XpvSP4j1jVbplywg==
X-Received: by 2002:a17:902:db0f:b0:20b:5aff:dd50 with SMTP id d9443c01a7336-20fa9e5e924mr82116675ad.31.1729764103111;
        Thu, 24 Oct 2024 03:01:43 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0de3fasm69876125ad.196.2024.10.24.03.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:01:41 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 71C594416BFE; Thu, 24 Oct 2024 17:01:38 +0700 (WIB)
Date: Thu, 24 Oct 2024 17:01:38 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Breno Leitao <leitao@debian.org>, Jonathan Corbet <corbet@lwn.net>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-team@meta.com, Thomas Huth <thuth@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Mina Almasry <almasrymina@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4] net: Implement fault injection forcing skb
 reallocation
Message-ID: <ZxobAhwYt5I3rgNW@archie.me>
References: <20241023113819.3395078-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r7nh6+ejvv9gOphX"
Content-Disposition: inline
In-Reply-To: <20241023113819.3395078-1-leitao@debian.org>


--r7nh6+ejvv9gOphX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 04:38:01AM -0700, Breno Leitao wrote:
> +- fail_skb_realloc
> +
> +  inject skb (socket buffer) reallocation events into the network path. =
The
> +  primary goal is to identify and prevent issues related to pointer
> +  mismanagement in the network subsystem.  By forcing skb reallocation at
> +  strategic points, this feature creates scenarios where existing pointe=
rs to
> +  skb headers become invalid.
> +
> +  When the fault is injected and the reallocation is triggered, these po=
inters
> +  no longer reference valid memory locations. This deliberate invalidati=
on
> +  helps expose code paths where proper pointer updating is neglected aft=
er a
> +  reallocation event.
> +
> +  By creating these controlled fault scenarios, the system can catch ins=
tances
> +  where stale pointers are used, potentially leading to memory corruptio=
n or
> +  system instability.
> +
> +  To select the interface to act on, write the network name to the follo=
wing file:
> +  `/sys/kernel/debug/fail_skb_realloc/devname`
> +  If this field is left empty (which is the default value), skb realloca=
tion
> +  will be forced on all network interfaces.
> +
>  - NVMe fault injection
> =20
>    inject NVMe status code and retry flag on devices permitted by setting
> @@ -216,6 +238,19 @@ configuration of fault-injection capabilities.
>  	use a negative errno, you better use 'printf' instead of 'echo', e.g.:
>  	$ printf %#x -12 > retval
> =20
> +- /sys/kernel/debug/fail_skb_realloc/devname:
> +
> +        Specifies the network interface on which to force SKB reallocati=
on.  If
> +        left empty, SKB reallocation will be applied to all network inte=
rfaces.
> +
> +        Example usage::
> +
> +          # Force skb reallocation on eth0
> +          echo "eth0" > /sys/kernel/debug/fail_skb_realloc/devname
> +
> +          # Clear the selection and force skb reallocation on all interf=
aces
> +          echo "" > /sys/kernel/debug/fail_skb_realloc/devname
> +

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--r7nh6+ejvv9gOphX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxoa+wAKCRD2uYlJVVFO
o7zXAP9tIGnmbEhtrEuMpZzgsDagMAIHMMOCahEbv+bVZCTIDAEAzbrkaL2aj++P
1EF/KP6qOo9Uv0LmTmD6G7a+p9OPYA4=
=JpzN
-----END PGP SIGNATURE-----

--r7nh6+ejvv9gOphX--

