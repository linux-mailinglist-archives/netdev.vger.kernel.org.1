Return-Path: <netdev+bounces-103056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 927CE9061B4
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 04:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC58B2110F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 02:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AD333062;
	Thu, 13 Jun 2024 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIssFhjJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3C079DF
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245479; cv=none; b=DIShBwLWSYeSf5UkJA6tR8bJPZecSk/O8JRPOcV9YzrQR2Dbk27Yf8ELUV2iAaCvVeJUaodAYZ+eh6t1sInlRXF8y+/i0ydYVWQ0sq9o05r51czVydSHi5grhc8zR+CSCD4nVo2j6vCtakh6z7jlEBU+Rwx85/ygG8TGg79rCHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245479; c=relaxed/simple;
	bh=0WlF+AQLoORWYsEi6UcPxa06P/NrADr2KV/AVOGaUpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qu1FE5eF4lugySbqDzT3ZvXsswnh3TUjump4Mh0xSPaQCpa20H+z8TyMyGPxbd/DGSTycq6VyaM4AHYbcwn2dRCS6x+yZv0rQOdRg7ilS0RQfY1KgWxVeg3DhEtUzvEaV7cj9mzBJSIh3E2edQBuf+mhEzz3xMODy2bvnkfQ4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIssFhjJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a62ef52e837so70863366b.3
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 19:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245476; x=1718850276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x75JUfTMKBBYZMRqXGPmvZpFfhNCLsJEa0jWPUIh9M=;
        b=GIssFhjJFAd9V8V5/KvBFJbP15+p5zBCFtdDXbSASzg92gJhTfc+BKoa0pC8QR1Z6V
         nOhUb8RSBtXwZb37tZ7ViiJobFJmUHv83FNpeIXcUANZ14BZy7s028ZL9HY1e5/RQEMW
         AddvApNTvaGPYoVoDk6BMzIhNhElCja4UIuUFBejAk5eGNxlw+4O6gAcfsYJ+9qzsHwZ
         U6RL5fp7gXz4+UlvhO8gu5UqfDovJ/wXPnJaCa95Kf/QPS764j212nf0w9EecNKmh9VD
         NQI+ycmLNCmkccdvDPJ0Xsg/qVzf7rkEZghc+XU2sMJdAg9Penl2lnxxAfIwMCIk5P1c
         27Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245476; x=1718850276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+x75JUfTMKBBYZMRqXGPmvZpFfhNCLsJEa0jWPUIh9M=;
        b=DbH0T14M0O38aGU2t3symrgNi+z3a0t8Yl/aQB8qJpxThVbZsoZi3eOKxWMM78GWFo
         zehHVtGV2pryyBaa2wRptfVPQ82EUr08Aqk4eWlL0kIoPQzvo+P2UZfQ71jyWRU08eH2
         OMUviU8K9jDNe3VhLMcn0BTAXsMkYuqa+tqIGErK1Z7VL67+CgtwcbWl9LaHrHzGHyCl
         CFVZUzZnQorJ6HlFk9d8FKwPkGeRd7VhDq9sE4lh5wAKRJUhg2s8W4dSMOHm9617zlkN
         8faUPdLdJq0Gm1dcTgyvbCN2zulc0fkMgHW0WpGv7nWdKGN3dyoumhrMtyAyrGPg2oaX
         /DdA==
X-Forwarded-Encrypted: i=1; AJvYcCXMQZqG23sgiXlBMYXBykfNSQ5truOoDpr0deh/40TVboVRBjsdiRA9qR7tFjmErt3Rt5R03gi1I9nL12D3NXp1YG02O27m
X-Gm-Message-State: AOJu0Yy7K8/LxNBHkDrK81z+115rDxYuGy41IezJzAvkTwpJNGoE8cRL
	i08tszaZgbib1RAMGTk1TetCrYMwmEIQh6X+Wk2j2xnHGJp81QKvmjXpQzAwmpTMPKm82rAeuU7
	fRaGBbLQoLz7/uTIoFjIDp694liw=
X-Google-Smtp-Source: AGHT+IGzCwbNmopPurcgqVv5VbIyUyYTAh2cyAjFd9SWUUFUeysZGyeXl7aXmCYgrtwxI18Undevh1q5Eq8fv+gfT4M=
X-Received: by 2002:a17:907:724a:b0:a6f:1036:98cf with SMTP id
 a640c23a62f3a-a6f4801305amr303768066b.54.1718245475730; Wed, 12 Jun 2024
 19:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611033203.54845-1-kerneljasonxing@gmail.com> <20240612144023.15f8032b@kernel.org>
In-Reply-To: <20240612144023.15f8032b@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Jun 2024 10:23:57 +0800
Message-ID: <CAL+tcoAi7jOFJ+0hMNh1BnAg2A=tZ74FY-aYQ+-06WFVONtqQg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:40=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 11 Jun 2024 11:32:03 +0800 Jason Xing wrote:
> > +++ b/include/linux/netdevice.h
> > @@ -1649,6 +1649,9 @@ struct net_device_ops {
> >   * @IFF_SEE_ALL_HWTSTAMP_REQUESTS: device wants to see calls to
> >   *   ndo_hwtstamp_set() for all timestamp requests regardless of sourc=
e,
> >   *   even if those aren't HWTSTAMP_SOURCE_NETDEV.
> > + * @IFF_NO_BQL: driver doesn't use BQL for flow control for now. It's =
used
> > + *   to check if we should create byte_queue_limits directory in dqs
> > + *   (see netdev_uses_bql())
>
> Sorry for nit but since it's netdevice.h.. can we rephrase the comment
> a bit? How about just:
>
> + * @IFF_NO_BQL: driver doesn't support BQL, don't create "byte_queue_lim=
its"
> + *     directories in sysfs.

No problem. I will revise it as you said. Thanks.

