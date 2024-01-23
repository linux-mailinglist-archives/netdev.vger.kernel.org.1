Return-Path: <netdev+bounces-65219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73756839AFD
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A728E1C20E6F
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741B72C682;
	Tue, 23 Jan 2024 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Nt4Thvmg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C9F39848
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706044983; cv=none; b=YectAesUfSF2t0nwJoLeKd/TJRJDgDtHaJcKqw4CfZi3dKF6D/b/xwTkuLRUUUUUdBE7/qX72ExMJLnRqZth6WMZbD1QxjaQYIJxiCSgU7hC76P88XLFFc22v/y2z8X3HmQNhw2E/nnmAKON0l04AB1ivK7wE1/e30qtwnKJWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706044983; c=relaxed/simple;
	bh=v/BS1G92ZM6qJJ7l3wYgSXjUs4iS7llskyFpoh808eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5QN6FDi+1k7I8uOfbNal3i4z8obZRaiStiJyqBHqqzvDtPQuiiohdwNdli7ez25zf8yb/KJLxaWBgXhmN8neN5IHaXWKyK0WtUE0LgabWn+FVisP+BhtyzRuHBCLu2xm3m6j5DzkBI85Ee+u2HeuL9yGNVYf0FsmcAj8o54T10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Nt4Thvmg; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ff7ec8772dso40345147b3.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706044980; x=1706649780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/BS1G92ZM6qJJ7l3wYgSXjUs4iS7llskyFpoh808eE=;
        b=Nt4ThvmgoLJLo5dx8/Y8i63mvkNJfhnWjtQJm0iqQCNTnPZP2WYtoaiVf2h7edV/OE
         Fbfbm0vCFV4va4Ooblf6R6Mnqyq7nqeAeOWMZpJiPThIh2+joImJAWmFaj+lmhS7ccun
         tqnVBM3PE1BBAAYJAwfgKWMiy45ilX6aSOiO1Po+nRfVQNmiVnuD4VDdmPeBH81nn5f/
         qZ+BA9gJfmhQb5h8wNP724xekCKfH66tIA6eXlHvV8ODoOYMkkt2Ey3RfUhbaQ/z3hmK
         lpHl2xVHMw+21a6yFkcEQE/ui7Ei0rtHNLo119M98yMPk4hBeplXER4fRw2u7SokjQls
         6fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706044980; x=1706649780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/BS1G92ZM6qJJ7l3wYgSXjUs4iS7llskyFpoh808eE=;
        b=VnHTlxq6A4JJNdR7cyN7Amzhu9ggS7sCwP077aBTKo0e+o1r4kRdvv+6pXJ3cY1Fak
         i0aQObkTrpDnS8Yj3wUj8YdbIiYxUNmHrpLgaZDxtR78fVDNXQ4UoZxeubYnqYCY6Wk0
         LOjWG5pong0NT+mt62PB4gG25NQNfwHvKp7n0sC8mj7+RqfWs/Ty3haqGuCX5oFNYcsL
         AKoJcR+48JwYEgflmZXavMTp3Y16w0pi7aif9BHdAffOTcfeXLCdw8mc7jE/MBylx0Cb
         Lz5jxw1dlr91oPdtqFhbQp5a+VOSM18BRlNmfEG3d+8S2XWLgk93obnofKykm2DMObsk
         /kvQ==
X-Gm-Message-State: AOJu0Yw3qOlIUtjdofub5anyAyiwz1yfGO992LvqWnej2vU11lYOi7dv
	yRSV/3ex9Ok5XuCWDlqg/udDw2xz0TU7SlEFzfqCeXHwzUy+pS98yycxjzw1HH/MzA0GrYn2jlu
	zuJ5Lr5/svxAPLaH7zxERswp1tfl+GEeT7A1K
X-Google-Smtp-Source: AGHT+IGcxrQvRcwm56PfjcmaPE+SOdyP2+F/HAKLLHxZL+xbNqIMILex8o/At6qSroJX/lLyiy5cRHzve8Xqtt/F0zI=
X-Received: by 2002:a25:7486:0:b0:dc2:43d0:6e07 with SMTP id
 p128-20020a257486000000b00dc243d06e07mr4235948ybc.118.1706044980385; Tue, 23
 Jan 2024 13:23:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALNs47v8x8RsV=EOKQnsL3RFycbY9asrq9bBV5z-sLjYYy+AVw@mail.gmail.com>
In-Reply-To: <CALNs47v8x8RsV=EOKQnsL3RFycbY9asrq9bBV5z-sLjYYy+AVw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 23 Jan 2024 16:22:49 -0500
Message-ID: <CAM0EoM=1C2xWi1HHoD9ihHD_c6AfQLFKYt4_Y=rnu+YeGX7qMA@mail.gmail.com>
Subject: Re: Suggestions for TC Rust Projects
To: Trevor Gross <tmgross@umich.edu>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Trevor,

On Mon, Jan 22, 2024 at 6:59=E2=80=AFPM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> Hi Jamal,
>
> At a meeting you mentioned that TC might have some interest in a
> Rust-written component, I assume probably a scheduler or BPF. Is there
> anything specific you have in mind that would be useful?
>

I think a good starting point would be tc actions. You can write a
simple hello world action.
Actions will put to test your approach for implementing netlink and
skbs which are widely used in the net stack for both control(by
netlink) and the runtime datapath. If you can jump that hoop it will
open a lot of doors for you into the network stack.
Here's a simple action:
https://elixir.bootlin.com/linux/v6.8-rc1/source/net/sched/act_simple.c
Actually that one may be hiding a lot of abstractions - but if you
look at it we can discuss what it is hiding.

Note: We have written user space netlink code using rust and it was
fine but the kernel side is more complex.

cheers,
jamal

> We are getting more contributors interested in doing Rust work that
> are looking for projects, so just collecting some ideas we can point
> them at.
>
> Thanks,
> Trevor

