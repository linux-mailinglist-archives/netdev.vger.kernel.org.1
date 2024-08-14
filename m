Return-Path: <netdev+bounces-118356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AE69515E0
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9876B27DB8
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9137131E2D;
	Wed, 14 Aug 2024 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2f+eLd0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0B4430
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621889; cv=none; b=NtTYT6DLbl8WQleXeJJo3XoVs/uhBW/s2nL7Ikdjpg9k1IxaeNt/NIm60yT7+TnVWQxKE3y0NneOr9ZyWhu+Xl+6ew2H9/DoZvr+SOIZXcJ/1bsG9NdK7MWfl76G2glePi2pOrOm3FFy9t4J5mL0DtKHeYurcHXCjSLXnVm2efk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621889; c=relaxed/simple;
	bh=tLDSQqQj8wvKloFN5KWeA1FxycF+qhvKYIy8HfLrSFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJF5z6d3ebWYMOBe8K1+TkSAaF0K9Ml9+osAFq0zPiYhqghK/JfNDuHhVnxB31L9QhRm7O6Igh/NHpbI4CeBOcr+wgkWwPARmmlAalCGfb7qO8crtqhBh8NICIngaHOApWeCUIr+enoZESyOqzswnQBUR++N4eZOkBndX/5c54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2f+eLd0; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef23d04541so71712531fa.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723621886; x=1724226686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKgJ50h6TUdFxAxo1lxQotsJcM/bRpDcRcZ0Sful8dg=;
        b=X2f+eLd0HludDuo/d9bj4bhBp55ije33FYBQJtr5eyhF51Tk4n/F1SPL5PwZAqWTzM
         4EdakZc02Fg5GJbxT5HVR9BgZsIimhQuxlaW4XYJDpRboXbcKF48fpPjQCbsAbVRdaXx
         Q37lZn/i2W2Uf/nHto/SlDNlvxwLCuj3XxepXGp0CI6JFqcMjPKd5jj1sGPTyn6ZU4nn
         fLTARdyR7VcxUPgDI/xnk11lERqlxHGHPwiJgj76PuctjmJeRs7gE5u0CjtgO4/rcfiD
         O65q5QK6ZHiZEOkUJJlfEAG1tBMZAsGwY2OAh1y+nqhFcW+Mb3WiSReM2MokMYY3aNJP
         zUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723621886; x=1724226686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKgJ50h6TUdFxAxo1lxQotsJcM/bRpDcRcZ0Sful8dg=;
        b=JvEJ/ojGExVudsLDBu8llCLc8RO7bvYhLTZibyS+kxAWdewwSq9ppb6E+jV7J73lQp
         W4Rkyvew8Peu8qehyIKcU1nN6aindRoFLK2Kuxawi5ezpKJBrE0cCn9lf8SquG5ICX8p
         QoTbaPKNq4BZIU4n//HSFsPz+9XApZ60QLrz19AqD9vl9s9/Ho0EChgK/A8Dd+WPisd+
         B1Z1Jrt0LbfyB5K9M0JtNAixOSvr5jXdgBaaT786Eg8nkcl96jo67oCIfbNICEAxF9w1
         7hSYjjm6lZP9pH6OApOWqnKvezbYGdie92naMKZ5DTxF7DT5ZrFdSDJV1LIe8IDLrKvV
         d/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRElFRBAt6F/eAQc2zLgtyH8SEfnI8T/FZQkLlGYX7q2vI/Tqk2MZ2yCeMtcDvP/z802gLvDkhWTZrvbCd6cun2NuWfQdU
X-Gm-Message-State: AOJu0YwPEKOdRrARHUgHKBZ8ZFy8Akrmtnp4CKXsEzK+JOo8rH2LhyIw
	zrDkdTlOvcHj0B88kN0susvdnJmvF/lW4JfkHjvsVsL3ZJjr4jQd9w0Zu4yLtxT32h7mPoIUu8s
	fIeKhnfu9Me85LvFJdTmz6T4iJ6g=
X-Google-Smtp-Source: AGHT+IFTWxzamONpnmGeDDbUQaKyWiCXgcnGI75Bxg2RPxESteyjrzTYbRoGvmpJQXpIOccBis6/l9PB87Y0WGtJ15w=
X-Received: by 2002:a05:651c:199e:b0:2f0:20cd:35fc with SMTP id
 38308e7fff4ca-2f3aa1b383dmr14328061fa.7.1723621886064; Wed, 14 Aug 2024
 00:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMArcTXtKGp24EAd6xUva0x=81agVcNkm9rMos+CdEh6V_Ae4g@mail.gmail.com>
 <20240813181708.5ff6f5de@kernel.org> <CACKFLimwA=P4M8UEW5cKgnCMCRu99d5DBX17O6ERriUkC=NxMA@mail.gmail.com>
In-Reply-To: <CACKFLimwA=P4M8UEW5cKgnCMCRu99d5DBX17O6ERriUkC=NxMA@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 14 Aug 2024 16:51:14 +0900
Message-ID: <CAMArcTW2yvEJLr_55G7FDsGtzKjTa2zMndOrAOBCshsW7UUj5A@mail.gmail.com>
Subject: Re: Question about TPA/HDS feature of bnxt_en
To: Michael Chan <michael.chan@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Wei <dw@davidwei.uk>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Mina Almasry <almasrymina@google.com>, 
	Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 11:08=E2=80=AFAM Michael Chan <michael.chan@broadco=
m.com> wrote:
>

Hi Michael,

> On Tue, Aug 13, 2024 at 6:17=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 13 Aug 2024 19:42:51 +0900 Taehee Yoo wrote:
> > > Hi,
> > > I'm currently testing the device memory TCP feature with the bnxt_en
> > > driver because Broadcom NICs support TPA/HDS, which is a mandatory
> > > feature for the devmem TCP.
> > > But it doesn't work for short-sized packets(under 300?)
> > > So, the devmem TCP stops or errors out if it receives non-header-spli=
tted skb.
> > >
> > > I hope the bnxt_en driver or firmware has options that force TPA to
> > > work for short-sized packets.
> > > So, Can I get any condition information on TPA?
> >
> > I don't have any non-public info but look around the driver for
> > rx_copy_thresh, it seems to be sent to FW.
> >
>
> Yes, the rx_copy_thresh is also the HDS threshold. The default value
> is 256, meaning that packet sizes below 256 will not be split. So a
> 300-byte packet should be split.
>
> TPA is related but is separate. There is a min_agg_len that is
> currently set to 512 in bnxt_hwrm_vnic_set_tpa(). I think it should
> be fine to reduce this value for TPA to work on smaller packets.

Thank you so much for confirming the hds_threshold variable.
I tested this variable, it worked as I expected.
For testing, I kept the rx_copy_threshold and tpa settings unchanged,
but modified the hds_threshold variable to 0.

BTW, how about separating rx_copy_threshold into rx-copy-break
and hds_threshold?
If so, we can implement `ethtool --set-tunable eth0 rx-copybreak N`
and `ethtool -G  eth0 tcp-data-split on`

Thank you so much again,
Taehee Yoo

