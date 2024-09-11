Return-Path: <netdev+bounces-127220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE18097496C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A582886E7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 05:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389763BBC1;
	Wed, 11 Sep 2024 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="cssZolsN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41CD8F6B
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 05:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726030821; cv=none; b=gqCda0ZHck3AWEPZIzVWIxx8Ni9E09Xo9lG7+yNM3//u1JAcAeBNCICUGwqZXTvl/cZSJyNDl+9cl+Cy96q51gnDYtFJwpNPEL/kiQBY9F2fsLMcSHi+XtWRbcnk6DOLKx54D1Q8zujA/Ya+oTAnmwtOrkZ8/nDD5UtnRgq4Y6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726030821; c=relaxed/simple;
	bh=blGVA0FVUmF0Puz6vN5cQLw1HjyaHFJUinzFd6FzbG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r69JcY5evbszk+HUEPvQ2/9bo8UfiRkYrRF50A8ZwbJVBDNE6buBbarwZLkB1O9j582wtrHCOC0ISRfEX1qPNFwX663FSlLNMxqwaT/dIZiM9th8anFdTiRDujXc1TXP57EQtYZhxMVIrUC4HkQtA3QtmZ4KhPjem71dtCquJPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=cssZolsN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718d606726cso3510174b3a.3
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 22:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1726030818; x=1726635618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zpXQJwWFRR7GvLQIw+MK/C/FLlt1XyTFItuKdkdohQ=;
        b=cssZolsNgxNQ8WwlUECtNEkbfKQYPCiYxl7xyhmjKOxp3xJl7SOzKwtkmN3TeuegQs
         TOvC/WDAGgSw7bnKtHnJBbhQ3sZJRA3HlaOTEI3LIaw4l+jvVX8O8GAi7hoKmxLS+Zqi
         UfiafYPx28+8o8MV3yT+RjjoIpcdBDKbCEfK+MbCxlUwHBwxTkpta9y4YH7NqkQJ8Lbf
         pvg9ptt+Ng02to2mCr5NkMWcn72QPkVMcSkjD918e562X2P9H4Iw0+inUccbCMlozt3F
         4kqFvdqwZjGjOhY0kKcududnk4AjhSP/2l9B+LP2jal2rtaiXgOkakDA/zPZVPu6xBnR
         o1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726030818; x=1726635618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zpXQJwWFRR7GvLQIw+MK/C/FLlt1XyTFItuKdkdohQ=;
        b=kkWy9PsdFy7VqqnsJj7ki6vFPqqxdpleBsyuzhXqcX/s8RpqUQIiUteXZ7IcLJcvzo
         U+8mAL68uoP6wg7X6zr2Bznbpp2jEIvf+ml1vrSjjioU0SrcviP7fDI6WfL7aq3NEjOo
         8kaovvBdhkNFhS3Yo7De4FAQu9fdpiJwSEnP7PZSHaRlWu9V1idWFFE0QSA/qxXf3E6h
         M5hZKxNGbgz9M8oHZzOlxfPvzsOKaT2iHW+6K9Ajdw+kK/+CJA/24aOhliLsheFB2uLO
         BlQTa6W8Hi5wigGhUhxdaLBWD0THYkBM/xalYp0e4lRPFKfMxNK0S0KKaQ5yQeNdB+ZO
         DXig==
X-Forwarded-Encrypted: i=1; AJvYcCXuUZ8cqtbSVo2l6BNx7HEUO3rYcLg3K62yt7yyhc2nIAnk+g89TBgtxpKqa+TjyPsw6N+HSAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9Bq8544TUgHJMUnCchMpyZA8fmQSKXy8GFqM9KKhawPclmMM
	zueAX3piPB6027jUoyiPGll8s7DDidJqtiZiTUtIeoF0YnvuTO6S+LIgqGq4DlA=
X-Google-Smtp-Source: AGHT+IFnSirYsGZj0lwxE/PH3X9hGEd+OJhQnYS6v4IJvHr77tCKxvJYsZ2IEoTJqSqkc8XS1ofcXQ==
X-Received: by 2002:a05:6a00:a83:b0:706:6962:4b65 with SMTP id d2e1a72fcca58-718d5e564c2mr20054392b3a.14.1726030818116;
        Tue, 10 Sep 2024 22:00:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d825ab136asm6527300a12.86.2024.09.10.22.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 22:00:17 -0700 (PDT)
Date: Tue, 10 Sep 2024 22:00:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Atlas Yu <atlas.yu@canonical.com>
Cc: kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v1] dev_ioctl: fix the type of ifr_flags
Message-ID: <20240910220016.160ed631@hermes.local>
In-Reply-To: <CAB55eyUZ=D-vnQZNaNEvLu6gVp33OXvsjJMmdeMiYqVR1FJ2XQ@mail.gmail.com>
References: <20240911034608.43192-1-atlas.yu@canonical.com>
	<20240910205642.2d4a64ca@hermes.local>
	<CAB55eyUZ=D-vnQZNaNEvLu6gVp33OXvsjJMmdeMiYqVR1FJ2XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Sep 2024 12:17:24 +0800
Atlas Yu <atlas.yu@canonical.com> wrote:

> On Wed, Sep 11, 2024 at 11:56=E2=80=AFAM
> Stephen Hemminger <stephen@networkplumber.org> wrote:
>=20
> > On Wed, 11 Sep 2024 11:46:08 +0800
> > Atlas Yu <atlas.yu@canonical.com> wrote: =20
> > > diff --git a/include/uapi/linux/if.h b/include/uapi/linux/if.h
> > > index 797ba2c1562a..b612b6cd7446 100644
> > > --- a/include/uapi/linux/if.h
> > > +++ b/include/uapi/linux/if.h
> > > @@ -244,7 +244,7 @@ struct ifreq {
> > >               struct  sockaddr ifru_broadaddr;
> > >               struct  sockaddr ifru_netmask;
> > >               struct  sockaddr ifru_hwaddr;
> > > -             short   ifru_flags;
> > > +             unsigned int    ifru_flags;
> > >               int     ifru_ivalue;
> > >               int     ifru_mtu;
> > >               struct  ifmap ifru_map; =20
> >
> > NAK
> > This breaks userspace ABI. There is no guarantee that
> > older application correctly zeros the upper flag bits. =20
>=20
> Thanks, any suggestions though? How about introducing
> another ioctl request for these extended bits.

Doing anything with ioctl's is hard, there are so many layers to deal with.
Mostly, networking has treated ioctl's as legacy API and switched to using
netlink for any new features.

