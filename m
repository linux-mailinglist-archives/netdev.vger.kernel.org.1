Return-Path: <netdev+bounces-145349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EA99CF2AD
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CCF28B10F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AE81D63F3;
	Fri, 15 Nov 2024 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGZONgCG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ADF1D5AAD;
	Fri, 15 Nov 2024 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691090; cv=none; b=hN2D1/oBvL4gjn05JWi92EzUKZ5z0kTH3rqcYGtTg6cjRM6XjzAWw/asGRr7mkuQ8Sjs+ixbIZudNZvQXAO7fPCzay/4c/p4DI+NKjAy+OuCmMYs6EcAPPSXVPBE+wot6NDE33y9lmU/dfM4M6WDCLFhOYh1qIz1cdpmwoJyz/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691090; c=relaxed/simple;
	bh=01OzKZ3LnQHQWiVFVS4IIK5959v6MIymChZSpGosESU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgU5hHlsb9d9mhpzhnVUROikXkwATaASiuR1CXKmW5DkWX53yMWxklUkoRRnUu0yyF1dloJIZ/rb72HpX5F5LjxIINXMD8vKeQGn8JQDgxrMub2Txkf0cpii6BScvO0RmGKMguXQuujKH0qM8ZzcN3l/Egyr7Mv3YR5S09tV8K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGZONgCG; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so3386129a12.0;
        Fri, 15 Nov 2024 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731691087; x=1732295887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkt3Ff7sDNJlH1kI+wf1tL1jV62LWopLZpgKDe6O4nI=;
        b=IGZONgCGoA+xMT0Ij0iNDUDJikfA1WAHlU97+NsUKqSz8hZ0TVWFm2hNUCpriNmo98
         KIaD3FKFTBxvGzGpFWYUWtmu9Qrs19N5yQndgbLg9dIpU7Y8gcGvyxUUjEJ6qtTrD1bd
         v98ow5nOL0buklAoHcFUlosbOJgnmAveblhycEK+ZPCOEJJtjyLp/4bwX0U63xl7xjYi
         H7Me2NzjpWg0/7jrby04edlLzmOJavPCYQhJNtN5hxKLoctw6+s43OPt8H+ZhfOrG2te
         e0Rla3odlUldICHeolgtsYI8bHKHQdE34jBs9Sxnb3GfvZmvgCJy7GKUvKZoj9nUyHzV
         Ac7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731691087; x=1732295887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkt3Ff7sDNJlH1kI+wf1tL1jV62LWopLZpgKDe6O4nI=;
        b=CAHxn3tQCqyGM/jVqb44NpDDvKP115MaGey9DeqTPPeT63eykQ6ZfIU+uCoi4RpHg7
         LGisZMRZYETyRDvVVUqigSQVFtT9+ffrw3Oubw942kdFayJ7qljikfZ+LTRLWp2v02bj
         8/a0aRbLp+GCnL148zt92h5ndf16LycYLgcTfhXi40DR/3GlfsOsrAndJjZ3rIC9eeKI
         FekSEeHoH9k3+uf8b0r4GiTeLvbJh5HLDirkcjABvz344KxtocDP9uCALyOIC/F81X8P
         KT+TYOlfDEC3RVUCm1yyeIm2Aq0r7JobWMvkYILE4QQtTP3hylAoAXQk7Pt7NiEToGw2
         I5Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUCnkz4kvkcraLbw6Wd8UH8hOadm9Tepss7docv72W4xNRfsgJxl7niK4UtzW7wqsQYhDcg+sKlypA=@vger.kernel.org, AJvYcCXHY0XaD+gRHxfo4/PyJmN/m0o+BYY4lXPVHzGBmijP4XHjTa2G29NnFLfi4VnJVRWCPScmw69f@vger.kernel.org
X-Gm-Message-State: AOJu0YyWE/Y8ZaUTtTfadu1agPyTJpJHZe2BzSloJggaC06La0xuAwjk
	gVDO1G7It/V8KQs1HPzW7+tPnglzi95/Dl6DnA+si/JIX7l34mCbnrX8DxfU7JherUDbHb++grK
	0/t5HzLp+8KlKCjQ6HyDnZdTaRnw=
X-Google-Smtp-Source: AGHT+IG9oNJIdClgmumB2FTMFaScUZiI/6EZcPFulFPZfR0THxcuyrrWoCMzBLfKXl9vXJIfILUiejdUBSvZsyhAmLw=
X-Received: by 2002:a05:6402:1e93:b0:5ce:dfbc:7fa5 with SMTP id
 4fb4d7f45d1cf-5cf8fd300d3mr2822962a12.25.1731691086837; Fri, 15 Nov 2024
 09:18:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113173222.372128-1-ap420073@gmail.com> <20241113173222.372128-3-ap420073@gmail.com>
 <20241114202239.3c80ef6a@kernel.org>
In-Reply-To: <20241114202239.3c80ef6a@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 16 Nov 2024 02:17:55 +0900
Message-ID: <CAMArcTWfxiKWghy3cFEL4rj7=VKku_Sm4W9pVWk39TEae1fyAw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/7] net: ethtool: add tcp_data_split_mod
 member in kernel_ethtool_ringparam
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

On Fri, Nov 15, 2024 at 1:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 13 Nov 2024 17:32:16 +0000 Taehee Yoo wrote:
> > When tcp-data-split is UNKNOWN mode, drivers arbitrarily handle it.
> > For example, bnxt_en driver automatically enables if at least one of
> > LRO/GRO/JUMBO is enabled.
> > If tcp-data-split is UNKNOWN and LRO is enabled, a driver returns
> > ENABLES of tcp-data-split, not UNKNOWN.
> > So, `ethtool -g eth0` shows tcp-data-split is enabled.
> >
> > The problem is in the setting situation.
> > In the ethnl_set_rings(), it first calls get_ringparam() to get the
> > current driver's config.
> > At that moment, if driver's tcp-data-split config is UNKNOWN, it return=
s
> > ENABLE if LRO/GRO/JUMBO is enabled.
> > Then, it sets values from the user and driver's current config to
> > kernel_ethtool_ringparam.
> > Last it calls .set_ringparam().
> > The driver, especially bnxt_en driver receives
> > ETHTOOL_TCP_DATA_SPLIT_ENABLED.
> > But it can't distinguish whether it is set by the user or just the
> > current config.
> >
> > The new tcp_data_split_mod member indicates the tcp-data-split value is
> > explicitly set by the user.
> > So the driver can handle ETHTOOL_TCP_DATA_SPLIT_ENABLED properly.
>
> I think this can work, but it isn't exactly what I had in mind.
>
> I was thinking we'd simply add u8 hds_config to
> struct ethtool_netdev_state (which is stored inside netdev).
> And update it there if user request via ethnl_set_rings() succeeds.
>
> That gives the driver and the core quick and easy access to checking if
> the user forced the setting to ENABLED or DISABLED, or didn't (UNKNOWN).
>
> As far as the parameter passed to ->set_ringparam() goes we could do
> (assuming the new fields in ethtool_netdev state is called hds):
>
>         kernel_ringparam.tcp_data_split =3D
>                 nla_get_u32_default(tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT],
>                                     dev->ethtool->hds);
>
> If the driver see UNKNOWN it means user doesn't care.
> If the driver sees ENABLED/DISABLE it must comply, doesn't matter if
> the user requested it in current netlink call, or previous and hasn't
> reset it, yet.
>
> Hope this makes sense...

Thank you so much for the details!
I will try to use ethtool_netdev_state instead of this approach.

Thanks a lot!
Taehee Yoo

