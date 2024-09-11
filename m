Return-Path: <netdev+bounces-127234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA83974B38
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2122878DF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF313C8F9;
	Wed, 11 Sep 2024 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ht9pNGhx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA7A13B284
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039599; cv=none; b=O6sS3FDbtlKYAb2ak01CpwLtXgqqKZCCLA6/ubLvgN9x2EiLWEGgVnb5nyWQ641Y7QlgfDNdQ9XEXg+eOUVrrJXHQE5XMPfg4KthqWLreBsir/1RO9C5UNIqVojQh7xRD8JceA8ZdSKz966KxtJZFc88D42RKwNVTessE5J4HcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039599; c=relaxed/simple;
	bh=g/Fjt+IZe7AcMApvLTV3LW6COQN5ALZvCZMWD58xZHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6DXzmCxwxozMlvTY2N34J6efwm55DtWLzlCGy5wxwRAAvy3Gk2dz5uAjzxQWCy8DeV//VIIdgyPaPT69doJ3X3qFUYrv2nbfTcqTjYbXsWuspzBirQQ2FGS9dLBirWjvpMRF2RHqUjEmqIc8eIvrYYtuqP3Nv948ibkebaa9Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ht9pNGhx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8ce5db8668so114839866b.1
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726039596; x=1726644396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/Fjt+IZe7AcMApvLTV3LW6COQN5ALZvCZMWD58xZHI=;
        b=ht9pNGhxLKx4O/pkNUqqb00WQ9jgDSbnoHDIRzSwmCk9+H8owm7brJva5YZ3Uarodu
         4Vz8kWTOrTyNVkbBH3CoiCowyYjaZkwPqKPBucokQPHg5wANyZCvOKrZpOlOE34KOt94
         NKcw/60uyfB1JPOJu78pc9IaDM7jaVWslZSnUulPJ6jS3L3eA4z5f6rp+y/nmcl0stsb
         WN8zqxOwka8r29gvOhPInTtZ4aea4XQxSD6YWecDYlEELu6VFcyEiAZB2qZ6WCX8HaYQ
         StiJBHzAVVy48vUz928QT6pMNn0nQHGmmOCpctqGje1vSl0msuE7Hr2MdDY+Jrnq4G4O
         IL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726039596; x=1726644396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/Fjt+IZe7AcMApvLTV3LW6COQN5ALZvCZMWD58xZHI=;
        b=piIRH7zhIs/uV4HaANo1nz11Q9TvL3hJJh7IX0j6oaMrmdIFzGA22H2Vrh359UxJ/O
         EZdJvisL5qYWlXpaHE8p76m2jyrgHolV3Z9QMbkVfd7+cAwAhrtmxkXW8oBsGqmrBjr7
         UoEVl87l6vNVu9iZYrs2gLV2iNa2TMWwT08uow9ZrdxBV8Ymfrg62UWXm841dySgptSQ
         I7xIx1kiGDfKxuoT2A0dfDPIBgnCtejFADOdjGgrWAIkGfoNbAgD6g/88+FxXLYb9qMl
         qT+0v8EfQCzD7xhwXYQmA9NRxsYlVhSpcpylytBQPHwW1YVbY01XCR1Qxv6nIx5NOoMH
         Xwfg==
X-Forwarded-Encrypted: i=1; AJvYcCUcT3hLOudR3a3/UT0OK4sAsQtNjJbXozfioQ8QfaPGDmbsroiQPSlZxipXqPZldMUPfNNek9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuByzd5QkXIymngxF3m/VDKnoA6Xljh35Z7Qu7Qk7il0SU1a4
	ZConUg+/j0ZsSAz6xhLdNSLoZtGXRNdlA2JhZhdEuXpa1JRY0mbNg/3mZC4w1kCU82f37FY7hW/
	bpUoDO5KIvEMEmwEQ0zMQ3P4CWyEKidqsBN0G
X-Google-Smtp-Source: AGHT+IGVpkBn8RUpuDxQlOtKpPtR/qRX02F+JdkFtCruT3r9iMJWufOPR9VNi9q1e5Xgeu06OOVkwFNcMZplFtIqJZs=
X-Received: by 2002:a17:907:3682:b0:a86:a866:9e26 with SMTP id
 a640c23a62f3a-a8ffaaa4c30mr447255266b.3.1726039595194; Wed, 11 Sep 2024
 00:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910174636.857352-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20240910174636.857352-1-maxime.chevallier@bootlin.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Sep 2024 09:26:23 +0200
Message-ID: <CANn89iKxDzbpMD6qV6YpuNM4Eq9EuUUmrms+7DKpuSUPv8ti-Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethtool: phy: Check the req_info.pdn field
 for GET commands
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	=?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>, 
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org, 
	Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Romain Gantois <romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 7:46=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> When processing the netlink GET requests to get PHY info, the req_info.pd=
n
> pointer is NULL when no PHY matches the requested parameters, such as whe=
n
> the phy_index is invalid, or there's simply no PHY attached to the
> interface.
>
> Therefore, check the req_info.pdn pointer for NULL instead of
> dereferencing it.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Eric Dumazet <edumazet@google.com>
> Closes: https://lore.kernel.org/netdev/CANn89iKRW0WpGAh1tKqY345D8WkYCPm3Y=
9ym--Si42JZrQAu1g@mail.gmail.com/T/#mfced87d607d18ea32b3b4934dfa18d7b366692=
85
> Fixes: 17194be4c8e1 ("net: ethtool: Introduce a command to list PHYs on a=
n interface")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

Thanks, there is another issue found by syzbot BTW (one imbalanced netdev_p=
ut())

Reviewed-by: Eric Dumazet <edumazet@google.com>

