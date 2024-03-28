Return-Path: <netdev+bounces-82837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D2188FE5E
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D201C24BA3
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B403839FD8;
	Thu, 28 Mar 2024 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xE7zUx9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075647E117
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711626726; cv=none; b=h1XewDSJjTJ7gmeRWeI45wGPoA/VPW2rs8CgUifvDR7ZIY64YKRCpLg64U5umjzSUov8EL5zipPfuPu7MjRa5XMFyxP8sJsyEA1H8OsmWsPhgplL2PKHb6IfyOiVWBVLWghaiMW7FHfum2FnW7Q44xFOH6wjHexJG22tF2NuWyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711626726; c=relaxed/simple;
	bh=X9vscd+ZWxOUzB6s0cg9fL01cIcNiKiOWiazs2FFlRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atdpFUMYY2LhG/PRgNJLUFHCB/QG0dauwRP3Hd60heH/IMQc1aftTISjQBBCIsKQWDkLY/tWHYxjYPsefnJANjC7nHg44sBQe6FTQl7Um538/ItvLKEoyurN7t07McYyRdtBzYdcocFObHTvKlxAOlUZ54nWjOSGdL4f+DnMO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0xE7zUx9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c3689ad32so9161a12.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711626723; x=1712231523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZYmYX73+H5vkda2Jhugy5aBQDVMyeLOQbEUTfAjRE8=;
        b=0xE7zUx9ACL9VJsyPWP61rrPfbA8imgibJ9PR+drMu8C51qf+oZ/QwIHSctPqyzs/c
         V+1qJTBAF2nhG4pf+ULnmipmvqRPwTIhN/Rn4xoZOLyudRH9HQMY+5WRfyUxYvDsAvRD
         ovYUiUEDmvwlabAeJYeP+PIwaM15zBNZ8GPPbZNdOETQiSBwwSLK6YuO2hVera8nJqw1
         oZqJHOcsbuLam/pC9eWehwHrw8hzdaQfxBZoqhpocILOqDAUySqcYAAUkFTXgPYVy3Ic
         GUHgVTTsxkMrqeGv7RUFAGRg4MW+vnqPSIDHbA1nKQR4asK9A5peFJ9CNdKvcXoF0maG
         KTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711626723; x=1712231523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZYmYX73+H5vkda2Jhugy5aBQDVMyeLOQbEUTfAjRE8=;
        b=YHXSlLeTq7OQM/ITcsLMldu3hDpgqhayDzfOb2GQMUJZEO4r8fjJe31F9dE/085IDn
         A77q4KIDSMCDaKatAPvePKY55blhKm/ILf1Ns7t9Qgr0LyY6bH0HWEMOVtnuC9bn0vUK
         NrOLxwiVnn0+bBqp13KDTcGNZGNN0avmQZ0h+8a/2xy0SKpheva+dwRWcyX6jqQq9WYE
         +HxGslGqMf5MDA4Rus4Uj1L6lfbuJDEMuonqdMKEbmdGdVwKHAdiWdmYZ7kZ/CjBQ0Cr
         3YqogkD4oHGfHeSfGJQZd2GniGqsiGm0nSP/zqPWvsxCyg7PRm05CFQXjXvOdcJrnyJZ
         AMXg==
X-Gm-Message-State: AOJu0Yz0sgKBShVI+c6WFqPi/SyeM3gKsIKkxJBZmt/DEqD0SJdV0mxb
	JpsZ3TDW/vYCgRD3YQv+4EqB5tWIJZwho3lnkOoc/zoOyrQr63reVbPbxLU/0Sd2lQNc8ZqSQai
	3LpZqYZntwmEUE6hxo5r/S2zsEnTxc8TlaULk
X-Google-Smtp-Source: AGHT+IFZXGu8bTgZSrhmp6W5exyFbNoOYeFMOSZ2NQr1glTb4zZHE9tJSDg6wwbLiy1saf8qdcg5nBmX5kgceaa/FGA=
X-Received: by 2002:aa7:c90e:0:b0:56c:5230:de80 with SMTP id
 b14-20020aa7c90e000000b0056c5230de80mr71744edt.2.1711626723089; Thu, 28 Mar
 2024 04:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328113233.21388-1-dkirjanov@suse.de>
In-Reply-To: <20240328113233.21388-1-dkirjanov@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Mar 2024 12:51:51 +0100
Message-ID: <CANn89iJ51cc+FrOxst_AJOr38byPFPOSkP7f721V38ZR019oDA@mail.gmail.com>
Subject: Re: [PATCH v2 net] RDMA/core: fix UAF in ib_get_eth_speed
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	Denis Kirjanov <dkirjanov@suse.de>, syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 12:32=E2=80=AFPM Denis Kirjanov <kirjanov@gmail.com=
> wrote:
>
> A call to ib_device_get_netdev from ib_get_eth_speed
> may lead to a race condition while accessing a netdevice
> instance since we don't hold the rtnl lock while checking
> the registration state:
>         if (res && res->reg_state !=3D NETREG_REGISTERED) {
>
> v2: unlock rtnl on error patch
>

What about other callers of ib_device_get_netdev() ?

It seems they also could be racy.

> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed =
from netdev")
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  drivers/infiniband/core/verbs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/ve=
rbs.c
> index 94a7f3b0c71c..9c09d8c328b4 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1976,11 +1976,13 @@ int ib_get_eth_speed(struct ib_device *dev, u32 p=
ort_num, u16 *speed, u8 *width)
>         if (rdma_port_get_link_layer(dev, port_num) !=3D IB_LINK_LAYER_ET=
HERNET)
>                 return -EINVAL;
>
> +       rtnl_lock();
>         netdev =3D ib_device_get_netdev(dev, port_num);
> -       if (!netdev)
> +       if (!netdev) {
> +               rtnl_unlock()
>                 return -ENODEV;
> +       }
>
> -       rtnl_lock();
>         rc =3D __ethtool_get_link_ksettings(netdev, &lksettings);
>         rtnl_unlock();
>
> --
> 2.30.2
>

