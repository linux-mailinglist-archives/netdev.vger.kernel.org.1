Return-Path: <netdev+bounces-176226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416FBA696A5
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEA527A15AF
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35825207A2A;
	Wed, 19 Mar 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S2MiDkxi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2561F8730
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405753; cv=none; b=fx+b2+Oh8LV0nd7sCeG59DRugjE/vlPQhe/gFYc1rQN+QHN0Fo8XFnaoE1v249LMbbp7lsUf6NmDj2x+hhdbdKxqsAHW0MU55gxuzsUxktPVd6wrjF866M0wNBLtuVYWX1TTYfW4W2ve6+bo6UeluY7I+qqUVL/DxdnOh2ZsJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405753; c=relaxed/simple;
	bh=0l2z93wokPsNlr9CNoUbjWKtixu8c3OJeKbw+StPh74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmPllrVIQVI6/aLxUp34lJtzlS5QfLUbfYL8mVZn5Bf+pSHyYXivp1E2lFM7ScmBRxRAC33yxsyZUGLM6J53aEfxywVAg7NL07GJRTElX1pB+13a4r5ARMHqrFa20FiEgTL94e6VA/RAezGCBDDNns4ux75vacDb41Xrd8golWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S2MiDkxi; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso22997395e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742405749; x=1743010549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0l2z93wokPsNlr9CNoUbjWKtixu8c3OJeKbw+StPh74=;
        b=S2MiDkxiWVxeVrodJNDEDVn+o4/Ap8hnAMdkeK4F1d/+S2VLk0VfzUeR9eO6eJqt/X
         8N7PZpX4Z+J2FnSYf2u8ruHHjq2G/rE7aUtMXhZm8MoKLYOvqMdggatBl6yWTSukZad4
         ttJC+1eF9vY4FtEpbGRkRh8j8ZbW1iD94uDGrhSFXqWQvpbeGG7+E+9faTl38UKQ9nag
         ZNXB56cRmh7niHEEmgra0cFMyIgOcpdO1sDoiRIxrBCWGcAb4aQQUiByamkpmUKwp+Ip
         grnR0Jdq64TtlESaJGfi8Fkl2Ni90YDg9VVc1HibJgKZorTwbFOTqL5x+Cj/yG9RIJu6
         T+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742405749; x=1743010549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0l2z93wokPsNlr9CNoUbjWKtixu8c3OJeKbw+StPh74=;
        b=Za7AXmSRc2zdA01KaXXRYq9LBDrqWE5EZJ7H4KXWaTtXotl3bnIhiE78eKO4Thjl2e
         mf+SJ55JMFubm/oAZzC48pdIKS3U+SyzCH+Nw/u5rYIzX4hLx+aTxx0E0QGKHq2wOOD4
         NdUMFcudqGAXTcQIMd6jnmGEula8YAjRfkHYdAPY1IjDtxGza/FaWN31mhnicsOiFKd9
         XGaP9XaoIjUZ2qZ9Avh81hQVnu+fOoUCeQt2oezuVJHeV0DZ/BQdB/l1S9A1M2sezL2B
         nynrwF251aPCc7tvNG87zIl1ugXWBDz8UUHvFVqjSgB7PszTkHfl0AFpn07tEhjVn7AK
         xdjg==
X-Forwarded-Encrypted: i=1; AJvYcCX/BI7JPBSyscod9zAQAy5soB6LhAqLEwDPdoGPjWjvVe+om+c+LTEcVWyv5cSl+jJ9tF5wg1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRFApFdhaCdWh2c/j/btDJRCo8RC7IQrFoZX0BivKojwJbs08U
	5JybyiJET2aVxy525CmFeZDXut2LRDjT0Vrv7xYcPWPmjSI3qIn7X3UknLPIpqU=
X-Gm-Gg: ASbGncvwvwYDAoEaYp/to8Hl6NUdzuYk+tBGlARpVx56pJteTNfGqxblgWcz/2HCFD7
	biRQMSJxjGjEFkhYw5iVby5bItxVq4ER4c+oQqLHhQCPDxGWEmMpJJGWWMXBFiLD1RY/Go0bQ9e
	q4YRYWdHN7WqAMyp2yxL5jS+Ld+4GSbWCmyNIyNo9tZeihzW840zlaAreV2HzpVY4fvxry6pABw
	krtIIgyU1jA74H9KXHoZSSj1QFENtrKciKdsrRF/MvKXX/mUvFNssrzOh03sP8WfljPRxGSQvZs
	QCwsXn/udoMBW6i6+do1CdcOz1J34YNWd+k1lJWDWMKjvcM=
X-Google-Smtp-Source: AGHT+IGSY1s1s9fdWTOqCvd15nCY+1i4tmiNttO/M//h1esu/RG1YRloGZrRBRjGkhNkFUvY5SdRkw==
X-Received: by 2002:a05:600c:3ac6:b0:43c:fe85:e4a0 with SMTP id 5b1f17b1804b1-43d4378b869mr37926545e9.7.1742405749373;
        Wed, 19 Mar 2025 10:35:49 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f55721sm24738885e9.20.2025.03.19.10.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:35:48 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:35:47 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cgroups@vger.kernel.org, 
	Jan Engelhardt <ej@inai.de>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v2] netfilter: Make xt_cgroup independent from net_cls
Message-ID: <xn76sakdk5zai3o4puz4x25eevw4jxhh7v5uqkbollnlbuh4ly@vziavmudqqlv>
References: <20250305170935.80558-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mkh2zl7plkwrsur7"
Content-Disposition: inline
In-Reply-To: <20250305170935.80558-1-mkoutny@suse.com>


--mkh2zl7plkwrsur7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] netfilter: Make xt_cgroup independent from net_cls
MIME-Version: 1.0

Hello.

On Wed, Mar 05, 2025 at 06:09:35PM +0100, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
=2E..
> Changes from v1 (https://lore.kernel.org/r/20250228165216.339407-1-mkoutn=
y@suse.com)
> - terser guard (Jan)
> - verboser message (Florian)
> - better select !CGROUP_BPF (kernel test robot)

Are there any more remarks or should I resend this?

Michal

--mkh2zl7plkwrsur7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9sAcAAKCRAt3Wney77B
SculAP9GVIoNd21oKejOf5K+kuWK6ln1L3Qw50YXK5VXLv4gMwEArmRvNKABVTIK
cPswoGaacpZ2rtBI+7CV6ppLjJtekQU=
=11CI
-----END PGP SIGNATURE-----

--mkh2zl7plkwrsur7--

