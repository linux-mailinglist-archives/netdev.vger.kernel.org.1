Return-Path: <netdev+bounces-141096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBA89B97E6
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 19:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A74EFB20F7B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9161C9B80;
	Fri,  1 Nov 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBXWmhmA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C314E2CF;
	Fri,  1 Nov 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487024; cv=none; b=I8Y/cM7wO03LaKRQhdDqvgGav0Wbbcz77AD4twa7FWzK0wqRtidszcec683tKRAPTovs8hXx4LzV4bCcgroV5V4JW/n0Pmpddrr2LI+R8nX1GwZSTR4leYqobCXgsKdjnvLKjJr8WbZ1QKPXWQh8ydThzawX4B7ql6iA8XqTBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487024; c=relaxed/simple;
	bh=IzKndoq1y5uvkISusZBjbIdpZ6DgTUHjs9SpnABBesY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAA/5WnXGDjIbp02PtFLOaM3XwSXA/Ecob4G6FZ55CalGWOibhnCLsEFRGFlVlzFAxpki56re83ZRgmKC/FIBnVQCvh2Be6ezJuBWQR4jLyvHNvWgCv40hxr3EX0+g81dWlkgK6YD9NrIwTTLbeawRi0JrKMr6LKM90XL6lyw/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBXWmhmA; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so2604850a12.2;
        Fri, 01 Nov 2024 11:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730487021; x=1731091821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cx1j4qPEH2XN2Dq+8x0lOo2o9j/yfjA6WKPbJ2T5FU=;
        b=GBXWmhmA+83dOuuF08C90KCXkNMkxppU9E7tEgzT2FQnesNeTwiblK9hYX2DwQWLGr
         WWl5G3uyjcYU2JaZ07tpSlBBl9pf09CNSDKFdpXiwYhx48NCdFBh5/NH1XmLHxVh6rWW
         mcQ1G7FMMnkK9YRnToVelz55yFNpHjInloO24xcz/289jgk1QJxUXQqj3c7ZoAr6HupI
         woX8XCihZhsU22fYE6ryrKeO0k3ZkS5LO+P1TKkChNbbiXGpTdb45etR/UCVSh1mdrVn
         Xm9iGpHMx0ymUtk94o2hF0mRcqxfURr04S0vJZx3ZZNEDVPXBKGTHw6/CjVfC4dHsckp
         R77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730487021; x=1731091821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cx1j4qPEH2XN2Dq+8x0lOo2o9j/yfjA6WKPbJ2T5FU=;
        b=sv91dpFqnH9BQWeAnAwL2AhOOWc17yFtTSNHSedZm0VbxIeXRPp4pDsLGvhHT3Cyzs
         ImynkyaNX19D75APpiVXDTZzjGR/Ad649YL7d8iXCEY6Lc6Fzu5YQVGGJI0+Rlylxjaw
         3mKGobyC1TLok60pMWfp16CYbjWayMTCEdeqmJeSfJwVsngQzsL+1ItEA6NfrMheqTVZ
         YNQOG97uK/tbXurHKBv2VQLSDf7VtpCbUJT8fyvw6UTmcoY8LX3YHxiezL2Zj+pCA3R0
         1XLJhE1vtD/SlNoxO0lIuP/JH41T+DIs9e1pZqFdv6oIBDljBTBK1EK5VquJYZepAacH
         R6kg==
X-Forwarded-Encrypted: i=1; AJvYcCU3EOZgXp2rbTq4o1QMGHesusetQGtMx/AxH5LxirX8xM+0f180ussZ45wGJ0KeMXbY0H+tCo3S@vger.kernel.org, AJvYcCXdm34WBx18okeCT2lb6UEJ28cntEV1zEBsEJV3++UVEdoAK3oKtJb9/scAQVaqPbu7KjRqpyWZfWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwONhBo70bzJ1o0/qkEm68hS/63/sJXNH+U6Lk4FXgA0Zn06XKs
	5HjODhE/bnUtdWaG2Jz5SIK/Qz6o2MGCV5nRgBWJr51E8k+pEiovn6pI6demxen4qoll4TVkiZe
	EZoGnWVYpN8IEhoyMUG6t1BVJGlQ=
X-Google-Smtp-Source: AGHT+IECCJUMetbyiWUo3MWiJJbExvRiT8/JwwURxEhSCq7lHx3DrQe2R3Dxu+uO5SgSHl+goQbGOpYvHPJR11J/IyU=
X-Received: by 2002:a05:6402:51d4:b0:5cb:acfa:621d with SMTP id
 4fb4d7f45d1cf-5cbbf876aa1mr16708719a12.3.1730487020986; Fri, 01 Nov 2024
 11:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-4-ap420073@gmail.com>
 <CAHS8izOSuPj66UiZ=pDn2Bin_C6_6b5ya0AxiRkuv0apKcU0fA@mail.gmail.com>
In-Reply-To: <CAHS8izOSuPj66UiZ=pDn2Bin_C6_6b5ya0AxiRkuv0apKcU0fA@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 2 Nov 2024 03:50:09 +0900
Message-ID: <CAMArcTXAMezwF4gEQ6fE7sJAS2FPMonOVx7qm=8itYMD5Zv0ug@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/8] net: ethtool: add support for configuring header-data-split-thresh
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
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

On Fri, Nov 1, 2024 at 11:56=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Tue, Oct 22, 2024 at 9:24=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> w=
rote:
> >
> > The header-data-split-thresh option configures the threshold value of
> > the header-data-split.
> > If a received packet size is larger than this threshold value, a packet
> > will be split into header and payload.
> > The header indicates TCP and UDP header, but it depends on driver spec.
> > The bnxt_en driver supports HDS(Header-Data-Split) configuration at
> > FW level, affecting TCP and UDP too.
> > So, If header-data-split-thresh is set, it affects UDP and TCP packets.
> >
> > Example:
> >    # ethtool -G <interface name> header-data-split-thresh <value>
> >
> >    # ethtool -G enp14s0f0np0 tcp-data-split on header-data-split-thresh=
 256
> >    # ethtool -g enp14s0f0np0
> >    Ring parameters for enp14s0f0np0:
> >    Pre-set maximums:
> >    ...
> >    Header data split thresh:  256
> >    Current hardware settings:
> >    ...
> >    TCP data split:         on
> >    Header data split thresh:  256
>
> This is a nit, feel free to ignore, but I wonder if we should call it
> 'Data split thresh' instead of 'Header data split threshold'.
>
> It was a bit weird for me to refer to the feature as tcp-data-split,
> but the threshold as hds_threshold which i guess is short for header
> split threshold. Aligning the names to 'TCP data split [threshold]'
> would be nice I think.

The reason why I used it is that I thought a command name and print
should be the same or very similar. Both "Data split thresh" and
"TCP data split threshold" are similar to the command.
But "Header data split thresh" is the same as the command. it's
very clear. So I still prefer "Header data split thresh".
But If you prefer these names, I will change it.

Thanks a lot!
Taehee Yoo

>
> --
> Thanks,
> Mina

