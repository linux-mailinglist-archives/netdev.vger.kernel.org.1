Return-Path: <netdev+bounces-153381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB2C9F7CE2
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1120B1644A8
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C45D224B01;
	Thu, 19 Dec 2024 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlQ9H/zl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AA32111;
	Thu, 19 Dec 2024 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617671; cv=none; b=MuAqwJpmL84acFpK5z69lLFmN9Tv06RBI+GR8HPuHzynsjrFerst+8KOabH89aCarI3Wa/pTPG6qtU2ulQRYwKmPUt1+lErRxGzoOnqKdO8YiHSGErMWFo3xwKbXTdQ5cyLMxPT/dhBVgGGmKS/B72lQQvneJL+VAQjl9PgGlu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617671; c=relaxed/simple;
	bh=SN3b/czpCYxfQq5adU6DOjuxCZ8Pm54/iwOowNPF5XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTvoM4usyxEr2GiX3KNZ9oCNKi2687uvCxLRMPl+QBPLEs75CszfBh0zoxgvxfrcEuAbrYqpVxp1KS8l7pT5VHQvdzniS8pOy7kOwelNS/Mkl1Drgj2qHzb9HwLKRcyHgRHPyBQliSQklT5XtcM8gT6pneq2r0LlaUTHk0HUybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlQ9H/zl; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so1034910a12.1;
        Thu, 19 Dec 2024 06:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734617668; x=1735222468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ie0nzlfS/IDa+jPnuSGAMuTWaRJCkhKtiTYGfLG9nLY=;
        b=dlQ9H/zlOnL5XBWtn26YZ+6iVTZVB6rnh1zyGLZ9Q/ETXAvfSUSxFcXOeGEltkcgo7
         8AS2MZOkTVsIZJvAf6ZLspvqgMWg3jEaWt+f3XFhS9yG4RlrdcuF6xm+Ae3qdnO3yg2o
         5dGhJymsxkEKATqQqKRKVK18jENAnb51aDYET6qluVkI4sfgD8XFJVIrzirgQPTUO7dT
         K9mQotN1xHRuWN7FJaEUlxHB6LOs/P3+4vTgWCF52IksxCI+kWthhXSV4xW0CtkvdD7j
         ciyhmwK+65t/p071GgRfGiNA5VZzgE5OZfnA0cXfaJzXPyDixi6YSnh9Iernn7TcRIX9
         2oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734617668; x=1735222468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ie0nzlfS/IDa+jPnuSGAMuTWaRJCkhKtiTYGfLG9nLY=;
        b=W5HdttiWN+WH14ZCSFlyAl5sKdIAx1t+/riZH+FkT6RUU59b4dNHw+JOgyPft19LHL
         BHywwxx4GiBPOsWWz0QG/P3l4sc5a1UCAnRoYrPLr1I1/cJjvLnrjeyUTY5IRk4Zm2XG
         jMXIX3E+Q+rSfgAzzkPJNkct2TfKuZ7/WiHXGU/pdy5s7F4JVUS2SVVFY2JPudGlV4OZ
         DvAF1C2FGbYtUVa7g1pDbyI0KlZugGwQtzNOew+bxeWcVsUt23OlPi5XCFURqa5uOisw
         CGw4NSQ20mnzmnWMSlRldbmhaqUfy7EnB9GdaJLmiyuEU9B8xRqj31DAqrKNT45TImLx
         VTbw==
X-Forwarded-Encrypted: i=1; AJvYcCVYw0hH8Nde8jNtgagYt+S8WNmqsuz9iKQ5PfmbIt1TugblVROtKEh28+LQ3LfVDQXouGqfMM8h@vger.kernel.org, AJvYcCXE55/y9yqyr4zZ3N1kjU9fqmg6W/x/7VLq+R7oSco0V9fNP2rUSwtwhuub0qEQFFe+HZgT6cKSqD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrnMWdyXoATXahC05yT5GMx8jz4kGDm+yWITjTL9VQHwk+xejx
	C1Dtqzr/cHbXX0wtpWmAoG2NIIHOu73k5Q9+0SZBOlvg4RFfSOpaccunPny5gtKqwCkELMxLi4Y
	DL3icvyIiy3ZJ+KqUdCqrXo7RDJQ=
X-Gm-Gg: ASbGncvKxuct+1ZVqSvpcQ7APkSPvNVe0iUd6gYS+HGTHTQoXW9J5H3ZBrWJdWgNYWj
	Vv2trtubN+YvyrR1VLSbCd/vLXzArEsl0R3nKvUE=
X-Google-Smtp-Source: AGHT+IH8k3I4LoEfNrVA5Du3SZIF0OAgaH1+h15PTd+QlKo8EU53mDv3lFegNUJd2J0kyG91jMmOyQ8cJqeih1/fiIk=
X-Received: by 2002:a05:6402:5409:b0:5d0:c684:bae5 with SMTP id
 4fb4d7f45d1cf-5d7ee3cc2d8mr6393353a12.13.1734617667383; Thu, 19 Dec 2024
 06:14:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218144530.2963326-1-ap420073@gmail.com> <20241218144530.2963326-9-ap420073@gmail.com>
 <20241218184444.1e726730@kernel.org>
In-Reply-To: <20241218184444.1e726730@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 19 Dec 2024 23:14:16 +0900
Message-ID: <CAMArcTXKnbamu_H-OzfbwWKjy4YNAFAHygBbAezJEU0yBHvh0Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 8/9] net: disallow setup single buffer XDP
 when tcp-data-split is enabled.
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 11:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 18 Dec 2024 14:45:29 +0000 Taehee Yoo wrote:
> > +          bpf->command =3D=3D XDP_SETUP_PROG_HW) &&
>
> PROG_HW will be fine, you can drop this part of the check.
> HDS is a host feature, if the program is offloaded offload driver
> does much more precise geometry validation already.

Thanks, I will remove this condition.

Thanks a lot!
Taehee Yoo

