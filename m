Return-Path: <netdev+bounces-131711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B0498F502
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4811C2173C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9AD1A7250;
	Thu,  3 Oct 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkTkvX/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2819F46D;
	Thu,  3 Oct 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976192; cv=none; b=hb5NVd5f05aXJ+o8uHzo5ztTM2ZG9Hw6jSog95cUc79aVcKxdQPmrYk5xrQT/tfIswW2QQ6BIdQlP98ELOzL7vM19WOdEXuHvz/N3o/GCqjHHDzTer+FS8ucOMKuqQ+9GLICA1GmQo2QiJF62uKlC9tS1BkaDdGYgAl/TbYRwKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976192; c=relaxed/simple;
	bh=HZ5wxK5BzWO7f3FVf5HbVWGBb/UqsslvIruSeqLGFdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCzOaeTvzlLXcd+QQcIl1mL7qHAXISPr6lt5w/sEMbhLoVY8t3ZyBgwYSHCsaZSfYAopLV/len7usPGuH/FlBqaR9x5TOtVnQ5WwtYd5aEcgLCJgsR2RMbsu8xEQN1PcRBSKQmF3yOgI+Abtknvi+d52pCzdLADiHJSL9nkfrzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkTkvX/u; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso1402568a12.2;
        Thu, 03 Oct 2024 10:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727976188; x=1728580988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZ5wxK5BzWO7f3FVf5HbVWGBb/UqsslvIruSeqLGFdg=;
        b=CkTkvX/u78XUKvIGsQaraNT/3R4Ul52MaEC6DT69vQguCujVQ4TvGCpkmwTdZXHYnv
         T3PhJInS0qQyNV25LQvQjoJhLi1ArBj6l1IfYHDwSEBijZBKjjfKHbICAn3w1lLbRYJn
         BbIiCFXe4l5rLfDDRSU4d2iCVsANpatHFLlsRslYUCSkk5p/PUtzhKQtwmzF06uxKTHT
         Np+sRL1gWCtOsYkYzuF+DuOu/KeGdE/kkq6Z6w9CTZ7nUBmJedGpCtT12O0iIXOr3b2S
         uNvnixh2zEFh0sG20/XSd5RiK21l26PG+5ScjwsFT9h4OVkYPaUs469JVCCnJ5zbEL10
         w6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976188; x=1728580988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZ5wxK5BzWO7f3FVf5HbVWGBb/UqsslvIruSeqLGFdg=;
        b=qhG7OnQiMXWRRZkOnqzJRFO6Kk+UlSjSi2J22NOBLD2pUjxX5YrrMnzGYSf/ICMkBV
         CcL+tEAZjSlietPzke9CTQR0HvK0jLCkVbV9xrh5U/2NVGsdAT5NsRZtNddbAVW3J5OV
         CwsHFpHPve6WPcrTDZj5QiI1i9QE0JWdldVYhXn85xrgyMY7ZNXszJDbmfd++J1HYyVz
         zWkDslmmBUJDE4QG1R0Au2a24wvEPK95ty6wEvfAJTVGULDRAAUIVUcYD0Y4EYgRfQcp
         hoGQW2HhFe+fzdsXrsiWaACaPEIiu5Arrl5zTma+erlUHchRAO//z8Bq8SNMcnuCQMzw
         sOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr7g0ntnHkEleVeithbdfa/+avoGGQIDmiyYaQc3mKUbv93TPV+Xc2AVsYCrXJGsy9Et6h3fBA2t0=@vger.kernel.org, AJvYcCX5EkoXNZhnZq8duDS2PJAn4pZApR2moSQTfV3b0MrLlpX1K66xmCDpsgBYBCDAnfJG9XS8ZHXa@vger.kernel.org
X-Gm-Message-State: AOJu0YxJDvS4LiS9U0mo9OEgwamCZTebYKgvn/oV0HJ/rJLrjRcwCT7D
	HcN7R5wRFg0AyCI/i3+y4Sfbt3dKQYbMgkcHBct32nHXALsbsxga7MoWppcsEq5knfkmvGOX4UE
	4IbcUKsvPKlYJHdxaLiqVbLQNEP4=
X-Google-Smtp-Source: AGHT+IHit+QfCZc2xBabzYz+S76HYCM8qlbR1CKWfLpRUf0uorcSKkkTGKFjfnp0SHBI5+s/28abdfSedMwmxXOocFs=
X-Received: by 2002:a05:6402:5108:b0:5c8:9553:c779 with SMTP id
 4fb4d7f45d1cf-5c8b1b781a5mr5776689a12.27.1727976187993; Thu, 03 Oct 2024
 10:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-2-ap420073@gmail.com>
 <CACKFLi=1h=GBq5bN7L1pq9w8cSiHA16CZz0p8HJoGdO+_5OqFw@mail.gmail.com>
In-Reply-To: <CACKFLi=1h=GBq5bN7L1pq9w8cSiHA16CZz0p8HJoGdO+_5OqFw@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 4 Oct 2024 02:22:56 +0900
Message-ID: <CAMArcTXUjb5XuzvKx03_xGrEcA4OEP6aXW2P0eCpjk9_WaUS8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/7] bnxt_en: add support for rx-copybreak
 ethtool command
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:14=E2=80=AFAM Michael Chan <michael.chan@broadcom.=
com> wrote:
>

Hi Michael,
Thanks a lot for the review!

> On Thu, Oct 3, 2024 at 9:06=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
> >
> > The bnxt_en driver supports rx-copybreak, but it couldn't be set by
> > userspace. Only the default value(256) has worked.
> > This patch makes the bnxt_en driver support following command.
> > `ethtool --set-tunable <devname> rx-copybreak <value> ` and
> > `ethtool --get-tunable <devname> rx-copybreak`.
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v3:
> > - Update copybreak value before closing nic.
> >
> > v2:
> > - Define max/vim rx_copybreak value.
> >
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c | 24 +++++----
> > drivers/net/ethernet/broadcom/bnxt/bnxt.h | 6 ++-
> > .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 49 ++++++++++++++++++-
> > 3 files changed, 68 insertions(+), 11 deletions(-)
> >
>
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.h
> > index 69231e85140b..cff031993223 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > @@ -34,6 +34,10 @@
> > #include <linux/firmware/broadcom/tee_bnxt_fw.h>
> > #endif
> >
> > +#define BNXT_DEFAULT_RX_COPYBREAK 256
> > +#define BNXT_MIN_RX_COPYBREAK 65
> > +#define BNXT_MAX_RX_COPYBREAK 1024
> > +
>
> Sorry for the late review. Perhaps we should also support a value of
> zero which means to disable RX copybreak.

I agree that we need to support disabling rx-copybreak.
What about 0 ~ 64 means to disable rx-copybreak?
Or should only 0 be allowed to disable rx-copybreak?

Thanks a lot!
Taehee Yoo

