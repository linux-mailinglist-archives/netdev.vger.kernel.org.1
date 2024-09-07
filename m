Return-Path: <netdev+bounces-126258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E55029703FE
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 22:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85791C21BF9
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C016315F316;
	Sat,  7 Sep 2024 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQL4T7Jp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BB52746D;
	Sat,  7 Sep 2024 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725739384; cv=none; b=k5L0TS43Lwpc1aaOSSCYHVl2rdUf5tWhxYxrOE89f3R4vCnJq09mfmdCNxZQTnbQPjodm/3Fy3Lxv+toMLz2sh/EyhOfEwaBAkt9e43XzriOwiqi9R3SxIYGxpCieKhDcMKNjVKd4uvrIRqxH4Wvu/37R9dE9ECL+boYuhP9XIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725739384; c=relaxed/simple;
	bh=jcCRsgoiNvtNjQptTsma0iBJiQUJYcIfGBRQtls8xVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2KXj+isVEQu/IT3GpJA55kybLch/NAy7wdWFPTGW5EDB4p3U204TWO1uujtjqLdoxadlNJy6rPDqDydLElEPHK/rn4FIvq0fQ/5wYDp2RmTQA9To4mkfD1vfS/JSJr9/bI9SuWE1y0YqSpUnPFvCNhGcpsGQLFnG0MMxq6FEp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQL4T7Jp; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1a9dc3efc1so3728652276.2;
        Sat, 07 Sep 2024 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725739382; x=1726344182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqbXcuXqYwih8NnABPT5/U6NpCCiIRuSclg73DPqR1g=;
        b=iQL4T7Jp6jWhv79fGk4tPLE+CEAao3G0OyYy3RFo6FV4t8xwThFDimIzwX4rvEoNyJ
         mWtAGSNVq2vtJeqAXtyfnr89eDqQiisQTMQ6DITUo18VRmHTq3BL6ilfLAAgxmoBHKwm
         abkaTnyQX/59u6nBCjQYVEMr3ggBrdtGbe4q+q7TuT7rYAlDBeF/nmxhlQRTQIp0L+0f
         fv4bJ++TIzMIX6UF9HMDAMUhoOXQ66d9L/YfAsYo5y699rgtaNvwissolRWb3UTy+ZNH
         VnUDd6a89TttSM1v+/Aigks89ir0c5tID5ojZrcV6ZVumJY+aU8zjlCy4SxpqYN4uOiT
         NvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725739382; x=1726344182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqbXcuXqYwih8NnABPT5/U6NpCCiIRuSclg73DPqR1g=;
        b=ZEp3BprWpTg0ctse1ijneyWXHBJVnP/jiRRo6MWb8usb1xdXLoELR939TEudxk5HoG
         4u11EkZhchMFu7dwA0T9UuiFlS956fVFynAbmSwiPp7AErfi6wydhtOWF+7e70EBGDFV
         yaTrgjiLQkBvBGDUezDuzvmpeWMqFoJXLXzjZPh4L5RQmS1XWJBiijxdX/Lz16jSV7x9
         GOo7fm4iI3HpQx6eXvJWFGNF+xdgB4O4dHlig5gEgPlCsjxdo2X7JLWbu3Bi+7P8d5si
         EKC9CieJaVVL+mwg2BqIO3VNhhpk5ZHsazCqgW+5uvwzGFesNbDc9rbWkAY4dkQ+jJb9
         W3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVWsufYXNgEvSgMa909utBXYhmooFy4gHUWvhscxthEMDYw93GkQelyo4XQojIKmq8CN7LuyaLsa8UeH3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQXAt6TluytW63SmaQC9+mrUNG/aSQG+JJAcoymgSKKnkFGiAA
	c6a1Vfj7HvPTJfeelu4hSAMulLz3Qz6EiBMB969FcrHbYOheQiAJxYr4bHkRTV0zbvhPGt/4SJ/
	zPJM0LTMsYmoHx+jL4nj71aqvq0U=
X-Google-Smtp-Source: AGHT+IE07T/1kt4P27JoE/pNX9c7SWuLJacmpqCDmLIlDiLlDGKsG/UbkUUc5ETOTuq3HTkObAlEWlFwj+q+6H2RlWc=
X-Received: by 2002:a05:690c:dcb:b0:643:92a8:ba00 with SMTP id
 00721157ae682-6db44a61301mr83316277b3.0.1725739382099; Sat, 07 Sep 2024
 13:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907184528.8399-1-rosenp@gmail.com> <3a0eb0ec-48e4-488c-933f-49c45e256650@wanadoo.fr>
In-Reply-To: <3a0eb0ec-48e4-488c-933f-49c45e256650@wanadoo.fr>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 7 Sep 2024 13:02:51 -0700
Message-ID: <CAKxU2N_ddO9Ts+4NeMOTA0h8-cU0g75t6gVZOq6UOp99M8_kcA@mail.gmail.com>
Subject: Re: [PATCHv4 net-next 0/8] net: ibm: emac: modernize a bit
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, jacob.e.keller@intel.com, horms@kernel.org, 
	sd@queasysnail.net, chunkeey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 12:43=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 07/09/2024 =C3=A0 20:45, Rosen Penev a =C3=A9crit :
> > It's a very old driver with a lot of potential for cleaning up code to
> > modern standards. This was a simple one dealing with mostly the probe
> > function and adding some devm to it.
> >
> > v2: removed the waiting code in favor of EPROBE_DEFER.
> > v3: reverse xmas order fix, unnecessary assignment fix, wrong usage of
> > EPROBE_DEFER fix.
> > v4: fixed line length warnings and unused goto.
> >
> > Rosen Penev (8):
> >    net: ibm: emac: manage emac_irq with devm
> >    net: ibm: emac: use devm for of_iomap
> >    net: ibm: emac: remove mii_bus with devm
> >    net: ibm: emac: use devm for register_netdev
> >    net: ibm: emac: use netdev's phydev directly
> >    net: ibm: emac: replace of_get_property
> >    net: ibm: emac: remove all waiting code
> >    net: ibm: emac: get rid of wol_irq
> >
> >   drivers/net/ethernet/ibm/emac/core.c | 210 +++++++++-----------------=
-
> >   drivers/net/ethernet/ibm/emac/core.h |   4 -
> >   2 files changed, 68 insertions(+), 146 deletions(-)
> >
> There was 9 patches in v3.
>
> Patch 1/9: net: ibm: emac: use devm for alloc_etherdev is no more.
> Is it removed intentionaly?
Nope. I messed up when resending.
>
> Also I made a comment on v3 6/9. It also apply to v4 5/9.
Sure. Unfortunately net-next closes on Monday. It might make sense to
resubmit when it reopens.
>
> CJ

