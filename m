Return-Path: <netdev+bounces-142076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCA29BD4C7
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 19:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB791C22766
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D3D1EABB9;
	Tue,  5 Nov 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7DzHrhx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5568C1E906B;
	Tue,  5 Nov 2024 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831873; cv=none; b=OpDJw7N8F6UKrqr5dJO5LIGQ7wCLbDib7G921fMbfU3EaLfd0GcAQzSu/o3M0LSYvOfSmL5fiyL0nYsbNjT9qfO3HOzRHUk5sKHyxDXmKwxYlfu98UkYcdQAwSMG+Eo88roOMbrKjjDY7SqpuL8ZWabnGhMlxhkMH/+i/22Ycg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831873; c=relaxed/simple;
	bh=EgDlh2EBkM5FH3cZ7ahyg2+lYODj1FnKkc1N6UZ9HqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITvmkoxcyxnMRe/BzxnPWZThHqwLGKBO98BXEDdDkW2HkAxZExLnrKymSkYGxP4EwNStX1rlj38a6B/wf9CtK1rMJI2BlDY/wnJZxxu4l/TIIjLe+RK5efrlJsYM2fXkX/OqX/JRyMUCIvzfnduKzoNE4aAXx8AJSUz6HxqOPlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7DzHrhx; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e2e3e4f65dso11344167b3.3;
        Tue, 05 Nov 2024 10:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730831871; x=1731436671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2t4SvXKJl/as9BSR5e20xumSeA80xAkDkuxPKKvOGyQ=;
        b=M7DzHrhxlRHx/y3qv5HVsjjxG0ysqAqy7lSW1bbOLUksB3FfsGriDY6QO49qCYTcgZ
         RD2GTZtZuDI6wLDKrwduqHmvRzuOo2sTz9RqVQRRPQCHUzsvA8iAlbkVyzIlDTU6eB+B
         PRKrnxrJjfJ+QdDjsFohNUf0buABSOjSVHOPQm4rRrqzs+0CMpQmFgaIjWPHmbWt1Wvg
         Xdr5xGL4SoZ1KNEMoiMl6jP0Z9LZmSJMVCteEv4ZW51nQ3kFacmXxZ7VpcQ7gL5YQugN
         cDkyzwEgEZHZihlKSMi0pRgPHcw1jA3bKFcNcYJsgrG0kC2Y876y9Sq991bx2q5OAedN
         rFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730831871; x=1731436671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2t4SvXKJl/as9BSR5e20xumSeA80xAkDkuxPKKvOGyQ=;
        b=Sdcej0b1saANKieTDnsGC544F3jLTmi7UETIQ+jjo6zHExXHrAW4rKoAXf3SFNYBYj
         FqsH0JO0B63ypscS2AyfMt5g0+RkPvQ6vB0edJ1dBv9a02WiFKxlQ1bME9REHXVxJhBv
         oS6ei2Dywn8OJXUXDeRhb/j93nn2rczeabfvKx5+2nZ0z8/C9KFlIYoa9swQRZ9qpBlj
         MWt6Z99SvSJOodgm808AWZkHgKeza6MtG7BYVBLCtUhUYiyTlGmnFPYNmxKadQWqUj7d
         /Vx4YaJuzZqK4Kbjj55w251+nUhEw/mY0S6rP4NvstJJ6GdHpTtAZnRXJdAOeKS+cGzN
         rDhA==
X-Forwarded-Encrypted: i=1; AJvYcCWEWJbr2XuYOrm86Mt9PLqJd4nhWjy4RgUOvYOO71mW425ZPtpKDYkuY59rIhNDb4ZusWn83lnnbCrSr5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcyolLqVpHv21Gj5zdsIX+1D/RF5JtDcWsu//3uXO7TxpDVEYi
	GoqLxcISFQGqOyu+WPIVYJ3L9TUtzpp5oCkJIpDGwfm+ZpdesNfoVUSCAoKz/qz+kYqetr2Z6Yv
	PItkLqrK6FnB/mPvZjwN1pyvDdks=
X-Google-Smtp-Source: AGHT+IHT8tJTXWv791Sn6gVFqB0xEube/wNW5a9FU6AKEXghvMNc8IOLUaGTE6vbzsdbEOYWWH8hGCCe6y4Hq41odpk=
X-Received: by 2002:a05:690c:9a0a:b0:6e3:21a9:d3c9 with SMTP id
 00721157ae682-6e9d8962048mr365855607b3.9.1730831871431; Tue, 05 Nov 2024
 10:37:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101220023.290926-1-rosenp@gmail.com> <20241101220023.290926-2-rosenp@gmail.com>
 <20241105140043.GF4507@kernel.org>
In-Reply-To: <20241105140043.GF4507@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 5 Nov 2024 10:37:40 -0800
Message-ID: <CAKxU2N--pCxqP5O_++danSig-MkXcNJftdX_-PiLgwBkvKWQDQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: hisilicon: hns3: use ethtool string helpers
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jian Shen <shenjian15@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jijie Shao <shaojijie@huawei.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 6:00=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Fri, Nov 01, 2024 at 03:00:23PM -0700, Rosen Penev wrote:
> > The latter is the preferred way to copy ethtool strings.
> >
> > Avoids manually incrementing the pointer. Cleans up the code quite well=
.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > Reviewed-by: Jijie Shao <shaojijie@huawei.com>
> > Tested-by: Jijie Shao <shaojijie@huawei.com>
>
> ...
>
> > diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drive=
rs/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> > index 97eaeec1952b..b6cc51bfdd33 100644
> > --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> > +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> > @@ -509,54 +509,38 @@ static int hns3_get_sset_count(struct net_device =
*netdev, int stringset)
> >       }
> >  }
> >
> > -static void *hns3_update_strings(u8 *data, const struct hns3_stats *st=
ats,
> > -             u32 stat_count, u32 num_tqps, const char *prefix)
> > +static void hns3_update_strings(u8 **data, const struct hns3_stats *st=
ats,
> > +                             u32 stat_count, u32 num_tqps,
> > +                             const char *prefix)
> >  {
> >  #define MAX_PREFIX_SIZE (6 + 4)
>
> Hi Rosen,
>
> As per Jakub's feedback on v1, can't this #define be removed?
Removed in v2.
>
> ...

