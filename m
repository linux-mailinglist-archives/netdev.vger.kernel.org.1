Return-Path: <netdev+bounces-132344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AE69914E2
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 08:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533361C219B5
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 06:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C4E54F95;
	Sat,  5 Oct 2024 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUGXn7LX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6C53389;
	Sat,  5 Oct 2024 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728109809; cv=none; b=myrx1mDGTrNb1GDhnO8qLyB5OmFozJCVvWBqiiQuOsx5Pn6DUzXpQsBwfS44cuwgdq61etNcz2OMS5JsuLQezQ/PmlOhNYqW7Xd9DJ8YX9xuLshFaOyTHRQ5rAelyngNr6tKyCjPRsJzkhj9gGQx4wNO/vkm7VpTrFvdXrlHM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728109809; c=relaxed/simple;
	bh=kM8YnYYl1uMNrQthL/ao2/qiluaruUXBJz4zY1CP1lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ka4U9wiVGvnK+gt5VHysWVl7gP/DSmmpaHQU9asoxxVUdTQIkF7bbOk4VezagvWZzrJ4h6dKTdux+hyfcoEOfPag0tojQyFfCjSX4zhGE4/3+u5U10sOsLQVHDkYaW6tEW+v2Au2/62laHoDquUuH2Fv60janmu08sIYGFCKpkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUGXn7LX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so5657065a12.0;
        Fri, 04 Oct 2024 23:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728109806; x=1728714606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBoMftGa/McsjubC4gQDLAonai8KexTRljE+MZCD93U=;
        b=jUGXn7LXWyHPqaYCPq70OUwdFvrGZfyTR8/53jO2nMB0qk3J/nwMfg/P2l4ndn5JAO
         EyCsOJEKkjwDvXH3X18atypiUXmodEUyTynru7Rnsw8gBEOBX+7Nk5hZJ3vqUYy2seWI
         B7owzKioxW9j6al6Af43D4PVTl+qxXeMrF1f53ZFEqQELYtuDY22KkL3qMD/qL3r83hm
         8vZ1ohSb9a8yNnctSi26KT/ppvPSy04O0WlD4nV4cEuVHWnuTuET53fpUnjPX+vcDtEk
         Z1Y7ulJ4w4JCgRgM3N/LOLXH5GXYiPWPgizL5CiXROfRb3xkZjRkwEMvZ+ZnbevMGPni
         wIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728109806; x=1728714606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBoMftGa/McsjubC4gQDLAonai8KexTRljE+MZCD93U=;
        b=uViWzyM5mjykV7enfiNJmiYrqCAnP0MgBP8FsGHgI63zs3UfAWrnFg3b9tgaULVVyO
         mR4oTQixphRRUi/k9+AToJiNoNTp9gaDGv/X1oxaZTTTgZ9d4+oLeNKT/zwc8HgJrJ1d
         2WpUKcC+FKS+WgW+03ljhK+/c7jO3exn7X6w0E0Y/qhWSmqSCD93jlSsbEIBkTISN88e
         N5vOQ9H5ETvlY5mkqMuvLqIsyD2GOg4hxcB+Cd3Chb5cRRG499ySMvD1YG2FOyZSYyLa
         Nk9OMLcimqylFNoKGrwsYo6a3Cq0le8AtTNHq4Q9/hbEZj0lrLLesQi3GD6uAtBCrWkR
         wXFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU76q+zkNRzgmfrBMbuyoPmrj/Y/XrSKCk578FHW+w4zb7lGn0/giuDVkn4gmJLbhdUPGvcX1EwGGY=@vger.kernel.org, AJvYcCXKgytyztCUSwpS6qNApeOBcdfzmC5MMVD6hc4MVkXtnnua4PXAcoIsAXMOOwXkw4q6pP2cS0Mb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi94NIQc60/L6Sm9TYFs8cEngxu3ySHTgvE7NnqMbxEcupvr9x
	JfgKDfvrdx+08NZ4hcWb7UjK0qkdN8dFIIUgAMN/FS0Gv6CfjaACY9GmhikDsQC4DdY22DiDPZd
	PmVR5rwSI89vM3oDyar7O1wCYN6c=
X-Google-Smtp-Source: AGHT+IHQaSDG7cwF2wPsX24tcApW4tk+ISWIahcBMpke2LmDGMnPF0xGZ1OStGr8+fXjtwqp/pc6xOur1x9/n/0rbH8=
X-Received: by 2002:a05:6402:5384:b0:5c8:a01c:e9b2 with SMTP id
 4fb4d7f45d1cf-5c8d2fa30aamr4676760a12.17.1728109805957; Fri, 04 Oct 2024
 23:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-2-ap420073@gmail.com>
 <CACKFLi=1h=GBq5bN7L1pq9w8cSiHA16CZz0p8HJoGdO+_5OqFw@mail.gmail.com>
 <CAMArcTXUjb5XuzvKx03_xGrEcA4OEP6aXW2P0eCpjk9_WaUS8Q@mail.gmail.com>
 <CACKFLikCqgxTuV1wV4m-kdDvXhiFE7P=G_4Va_FmPsui9v2t4g@mail.gmail.com> <a3bd0038-60e0-4ffc-a925-9ac7bd5c30ae@lunn.ch>
In-Reply-To: <a3bd0038-60e0-4ffc-a925-9ac7bd5c30ae@lunn.ch>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 5 Oct 2024 15:29:54 +0900
Message-ID: <CAMArcTUgDLawxxvFKsfavJiBs0yrEBD3rZOUcicYOAWYr+XYyQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/7] bnxt_en: add support for rx-copybreak
 ethtool command
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, almasrymina@google.com, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, donald.hunter@gmail.com, 
	corbet@lwn.net, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 1:41=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>

Hi Andew,
Thanks a lot for the review!

> > > I agree that we need to support disabling rx-copybreak.
> > > What about 0 ~ 64 means to disable rx-copybreak?
> > > Or should only 0 be allowed to disable rx-copybreak?
> > >
> >
> > I think a single value of 0 that means disable RX copybreak is more
> > clear and intuitive.  Also, I think we can allow 64 to be a valid
> > value.
> >
> > So, 0 means to disable.  1 to 63 are -EINVAL and 64 to 1024 are valid. =
 Thanks.
>
> Please spend a little time and see what other drivers do. Ideally we
> want one consistent behaviour for all drivers that allow copybreak to
> be disabled.

There is no specific disable value in other drivers.
But some other drivers have min/max rx-copybreak value.
If rx-copybreak is low enough, it will not be worked.
So, min value has been working as a disable value actually.

I think Andrew's point makes sense.
So I would like to change min value from 65 to 64, not add a disable value.

Thanks a lot!
Taehee Yoo

>
>         Andrew

