Return-Path: <netdev+bounces-235235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5158FC2E032
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 21:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC64B3BD51E
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 20:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4323A23EAA6;
	Mon,  3 Nov 2025 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q54U1W4t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6328E126BF7
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762201159; cv=none; b=JKngq9I+9rFj6AuitWD//QuAn/GGaFHBKUf5q/23rnW/Bg4gE/WhGf7y5dR7DuXqO3+UQ33QYwGRwfx7aGi4EtfKlVWuIUfQexi4hazTCdF6mehx7FcQ+eGBgce9RV3iefQSLnqmujHbpLnSx2nq76vJD+huT+KJPUFw6GKi4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762201159; c=relaxed/simple;
	bh=QCTPnVQY3V7Xqh+AJu8ypwKqT0Kso2fj8Yr6n8lm8T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNtSBv4aMralWn4UfQhdOUFZhU6kXKFrzdwubxL6icCP1bqae72mkWNAJdjh/By6WYE3zylFgbwz9QjWNrQI1hfduYO40XNeg+ju3HGMs/ydE0xfWLKXUo3TEJGFgiV5tIbwX1n8dZy8AitxMJyB/nUT+rkVk/bX1HdAqobu1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q54U1W4t; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42421b1514fso2830247f8f.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 12:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762201155; x=1762805955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCTPnVQY3V7Xqh+AJu8ypwKqT0Kso2fj8Yr6n8lm8T0=;
        b=Q54U1W4tigsKHxZayu/OzE7S8tUWyN9BxK/W8vd06ggPo09UvsE5YGNC5uhfg3V8Vt
         PqyyL60tSq2ZeFfakvPIVzXBSSzGF2Pyvlg5W7GAmm3O01bvuuX+sCNXZATdCEJWye71
         gGbWqVwzixcZHiGnRRyfXxo9cnChAeuzaHi7VSPQ/TyRMkcUA9TN3cmLEgS6nKMy7NrD
         aikRyQhxvTQNCMT0O1MmKB4ntoyOGNsE77oUjw9tCzDntgRo1ScdaFcIg3JxLxAJ37zN
         QZtu16Ghwd4tMQvm3zCamBP9Sg2futUa7awe1GY+NR6dKc9ub0uE6cmgjqVQVC5gKeYs
         +ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762201155; x=1762805955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCTPnVQY3V7Xqh+AJu8ypwKqT0Kso2fj8Yr6n8lm8T0=;
        b=iuJbkeRkalttTch/hlWX9GF004vI3m7YLX8G+NxFfO/9zkSAlbi2tQHlR+PRVMGXbP
         93+3s42nHhR+C/tJQMQCIblA6rY9Ipwok14EZGHgXRns2sVGWU8jCojrirqzvKJTGIRN
         XnwRrWkx/3QJh4b29wRaH0LIa6t+KsnYocqZj5b45CH6Dtwm5DBXdCATpr8VmY3NZGsv
         I3qMcpig1ZmWmg1d0bt4lwnAgyecD7ANe5kQWMdfgF/Cn22zg8UUg0mifc9tSjvt10RR
         J8TFPAvo0QIY+AsvveKeda3ioTdyLxZPN33rg5qKXvxZcr64UHY1uoEcvY8pQ1UYbCZs
         1eCw==
X-Gm-Message-State: AOJu0YyTYYGe6Vz7ScBMdqD2lkbvnBVlkFLnWqfPXwB/anozuR90a0Y3
	5DOq8U1Mx3JrBzxsM6hSVQ34c9a6aY45Y4sbXzk55p5ZN6vcLSD43A2DW73SBzsywbFWPO46EtY
	Sbf2r6qORTr9J0i4mtGhP7kko5AWcnuo=
X-Gm-Gg: ASbGncuwNo3rV4BpJ3PxwjP/ieD+WYi9Y7TC9zl2SMR9JiD+MEVx7NSSzj8UMMDQBpt
	3QGYy9n5zZNML2YAhuy6PG1ET5Vcog1lXOWhS8oQvkxMmececkHPqpKlPdnMvd2NyyziVQ78w+U
	EwEuTBN9asbD+7IwdmuYapS9uUfpTUp/6lTAuHNiWAQAUvHU6tbAsY7H0x3YTqqpsRIdvSJSVC/
	omVPvLcWsMaYY85MDKFCfoo/0Q21mxnOCK+oADkCB+yxrbzuEoqT/LRe084NX2u90Jc9HEzyVbz
	Te5T+XoQbLuNKdZ22Q==
X-Google-Smtp-Source: AGHT+IHg6JgaZDvmFf79UiQ9QOkrQFZPFmVBc6IbZwE0b9DEcda2HGOTglVTW8GwKIXpsW5q7cbbzYxVi5U6E+hFlHQ=
X-Received: by 2002:a05:6000:258a:b0:429:cd3f:f42f with SMTP id
 ffacd0b85a97d-429cd3ff727mr6932751f8f.61.1762201154444; Mon, 03 Nov 2025
 12:19:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
 <176218926115.2759873.9672365918256502904.stgit@ahduyck-xeon-server.home.arpa>
 <2fabbe4a-754d-40bb-ba10-48ef79df875c@lunn.ch>
In-Reply-To: <2fabbe4a-754d-40bb-ba10-48ef79df875c@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 3 Nov 2025 12:18:38 -0800
X-Gm-Features: AWmQ_bkjW3_RsvBktUctxrF-j1QkwrJExbPu14Zz_Hw177OE4OgkwRvhgmLujdg
Message-ID: <CAKgT0UeiLjk=9Ogqy1NU-roz4U32HXHjVs8LqRKEdnPqYNcBjQ@mail.gmail.com>
Subject: Re: [net-next PATCH v2 09/11] fbnic: Add SW shim for MDIO interface
 to PMA/PMD and PCS
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com, 
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 10:59=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > The interface will consist of 2 PHYs each consisting of a PMA/PMD and a=
 PCS
> > located at addresses 0 and 1.
>
> I'm missing a bit of architecture here.
>
> At least for speeds up to 10G, we have the MAC enumerate what it can
> do, the PCS enumerates its capabilities, and we read the EERPOM of the
> SFP to find out what it supports. From that, we can figure out the
> subset of link modes which are supported, and configure the MAC and
> PCS as required.

The hardware we have is divisible with multiple entities running it
parallel. It can be used as a single instance, or multiple. With our
hardware we have 2 MACs that are sharing a single QSFP connection, but
the hardware can in theory have 4 MACs sharing a QSFP-DD connection.
The basic limitation is that underneath each MAC we can support at
most 2 lanes of traffic, so just the Base-R/R2 modes. Effectively what
we would end up with is the SFP PHY having to be chained behind the
internal PHY if there is one. In the case of the CR/KR setups though
we are usually just running straight from point-to-point with a few
meter direct attach cable or internal backplane connection.

So from the MAC we have the XPCS which has support for 2 lanes. To
support that we will need to have access to 2 PCS instances as the IP
is divisible to support either 1 or 2 lanes through a single instance.
Then underneath that is an internal PCS PMA which I plan to merge in
with the PMA/PMD I am representing here as the RSFEC registers are
supposed to be a part of the PMA. Again with 2 lanes supported I need
to access two instances of it for the R2 modes. Then underneath that
we have the PMD which is configurable on a per-lane basis. Technically
it is just a SerDes PHY and doesn't have a link detection, it is just
detecting if there is a signal or not and then kicking off the
training, but we can essentially just represent it with the phydev so
that we can report if it is ready to handle the link or not.

> What information is missing from this picture that requires the
> PMA/PMD to be represented? And how is this going to work when we do
> have access to the SFPs EERPOM?

The issue is that the firmware is managing the PMD underneath us. As a
result we don't have full control of the link. One issue we are
running into is that the FW will start training when it first gets a
signal and it doesn't block the signal from getting to the PCS. The
PCS will see the signal and immediately report the link as "up" if the
quality is good enough. This results in us suddenly seeing the link
flapping for about 2-3 seconds while the training is happening. So to
prevent that from happening we are adding the phydev representing the
PMD to delay the link up by the needed 4 seconds to prevent the link
flap noise.

