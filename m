Return-Path: <netdev+bounces-158097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A8EA1074F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B40C3A6A2E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4C0234D0A;
	Tue, 14 Jan 2025 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFbQ85uH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6D230272
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859831; cv=none; b=tRUGN874803oV9FIL4rmk9WHQ3R3NS5keaH51Y5fvoHMqwMoQosbrd15CtzkcHfXzrV1VpQRLEDuRD9S8awpsBOPwfZpgPurm3M9bFRhKSkSXpmjA3LeMZPrj3ptnsKf5XTGKN2enYBif2vfjnHZbcXynun/era/OCCE/Fe6cuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859831; c=relaxed/simple;
	bh=Yk/FsoWWMGEyKKcgQOWglitsOlsO+x7ZKiprJRP52TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7sMRu7B+MGs8EYtIr0yxO1I4h3HiBsjls3ErmhVy5eq9Fo9CgrBEotEjnKd2Iz8AtpaiXv0I8lpFl9lnchvi4RWayAVUT+bz3+WnRBUU5g/D1WRPpHDDvpKuHemw9KyBOGld5InUi+nreMuhVFCEtkAAiKrlebbwu3nflXtygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DFbQ85uH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso8887311a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 05:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736859828; x=1737464628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uk3ZyK6btxCIVBjuONM6haXtJQPq8N/6A2KkKNOTMGY=;
        b=DFbQ85uHfr24B5QIOUckAuGB8KVdt4LcfqntfENBMWOq0PdLZbOEb/72wIF6NCEGWm
         LIPis+f4eExA46BckyvpQg5lYVM/9gDrnGL70FtmzGlI3fNm4FWmqf9l1Ffrkkb9skly
         TqQTPOhhqLepxI+4pLdaWRYlf2smkuvhVu40P/aQXkUJsGUTa8gPEXDcJd2D9uEitWJw
         EYu/c2zl7HIbb6Rj4XAfboYSedsfrvNKcaEWOqm9taT4XG/yRRRaTwAm2RHO0zaaAAwu
         lhUAd8lmlSK7llHBvCOowjcimSgzFc8kSVeRFlqUwNmRXAhXRTUqeMS3bhgU+NZJCDNE
         6oPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736859828; x=1737464628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uk3ZyK6btxCIVBjuONM6haXtJQPq8N/6A2KkKNOTMGY=;
        b=AazSmJUdy618ac3LrTBiIXbq4qB1Zbewhm68uPamytvL8fMGmCDrWqAGuKz/EGEIzm
         n+29+pgx1lPanzOM+LF4yow66MZP61I2rgqZauQj9zgjg47uI0gtmRfsQMGfoPgTFIF7
         2BQiERfD0rox9NwfPPUbgQf0eafdoOSdgzZJYVvU0USLuCzVsg02fOoA5LlmeqCABq6i
         /9rApduqg2T2bvCCryoTaHeGkIqEtdZYXakDvYS72SmOZUeRTUT+AU9KqLpH3l46Zu/F
         vKZqMr3JzSy+rCLRjcxfZvV+gQ21NeFO4TigHAgCuvRZ8Z5rGlCi2Misbi2KWEaE11iR
         o7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXkAPmyBBK4K7hm9jnPoIs81SUEGXqvQcsiRVeVn2uX5n70navJ7u69wvSrlFPrO6loZ05HH1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKc38PTGlegdFvQTHw1f4gwwPwiWOe2V1piZec2R+/YSfLHLf
	wXmtvoogXnv2sYof6ibVvnDlVI+OQe7C5AXR6+w1JgAtO5N9jdUKd2QUgK8ZRaqEjzW8fPDf+fO
	dbJBnLxUqKK9memGKqHwX++Nhabqw5qsT/qKF
X-Gm-Gg: ASbGncvkhzbg0sBGaXOThJH02MO58YMmKMN5fAoCKwW1AH7glD/CXpJjjOxA2lEzJ01
	cDqOD3UiNVcy8MjXTtk168ugEwEIuhMG/9J3/Lw==
X-Google-Smtp-Source: AGHT+IEOHc0dZv7Svd/PZMYslGcCGj7Kq6Cyra8lDFp6ZrZ+teDDZHUH97RUHbpdYq8gTTwkT02vFlWBmWr0fHRxRDY=
X-Received: by 2002:a05:6402:538d:b0:5d3:d7ae:a893 with SMTP id
 4fb4d7f45d1cf-5d972e48691mr22166758a12.25.1736859826753; Tue, 14 Jan 2025
 05:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114035118.110297-1-kuba@kernel.org> <20250114035118.110297-3-kuba@kernel.org>
In-Reply-To: <20250114035118.110297-3-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jan 2025 14:03:35 +0100
X-Gm-Features: AbW1kvY8vE96Wx74wj5OROpPPMu8SHqkUWRnbdlt7DKRdUwp0nSLJBSNEoDSR_8
Message-ID: <CANn89iKo4k7PaUof+qjiUGT+-25WNed-1+UkWadnASBAMcZ2Bw@mail.gmail.com>
Subject: Re: [PATCH net-next 02/11] net: add helpers for lookup and walking
 netdevs under netdev_lock()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Add helpers for accessing netdevs under netdev_lock().
> There's some careful handling needed to find the device and lock it
> safely, without it getting unregistered, and without taking rtnl_lock
> (the latter being the whole point of the new locking, after all).
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/dev.h |  16 +++++++
>  net/core/dev.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 126 insertions(+)
>
> diff --git a/net/core/dev.h b/net/core/dev.h
> index d8966847794c..25ae732c0775 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -2,6 +2,7 @@
>  #ifndef _NET_CORE_DEV_H
>  #define _NET_CORE_DEV_H
>
> +#include <linux/cleanup.h>
>  #include <linux/types.h>
>  #include <linux/rwsem.h>
>  #include <linux/netdevice.h>
> @@ -23,8 +24,23 @@ struct sd_flow_limit {
>  extern int netdev_flow_limit_table_len;
>
>  struct napi_struct *netdev_napi_by_id(struct net *net, unsigned int napi=
_id);
> +struct napi_struct *
> +netdev_napi_by_id_lock(struct net *net, unsigned int napi_id);
>  struct net_device *dev_get_by_napi_id(unsigned int napi_id);
>
> +struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex=
);
> +struct net_device *__netdev_put_lock(struct net_device *dev);
> +struct net_device *
> +netdev_xa_find_lock(struct net *net, struct net_device *dev,
> +                   unsigned long *index);
> +
> +DEFINE_FREE(netdev_unlock, struct net_device *, if (_T) netdev_unlock(_T=
));
> +
> +#define for_each_netdev_lock_scoped(net, var_name, ifindex)            \
> +       for (struct net_device *var_name __free(netdev_unlock) =3D NULL; =
 \
> +            (var_name =3D netdev_xa_find_lock(net, var_name, &ifindex));=
 \
> +            ifindex++)
> +
>  #ifdef CONFIG_PROC_FS
>  int __init dev_proc_init(void);
>  #else
> diff --git a/net/core/dev.c b/net/core/dev.c
> index fda4e1039bf0..5c1e71afbe1c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -783,6 +783,49 @@ struct napi_struct *netdev_napi_by_id(struct net *ne=
t, unsigned int napi_id)
>         return napi;
>  }
>
> +/**
> + *     netdev_napi_by_id_lock() - find a device by NAPI ID and lock it
> + *     @net: the applicable net namespace
> + *     @napi_id: ID of a NAPI of a target device
> + *
> + *     Find a NAPI instance with @napi_id. Lock its device.
> + *     The device must be in %NETREG_REGISTERED state for lookup to succ=
eed.
> + *     netdev_unlock() must be called to release it.
> + *
> + *     Return: pointer to NAPI, its device with lock held, NULL if not f=
ound.
> + */
> +struct napi_struct *
> +netdev_napi_by_id_lock(struct net *net, unsigned int napi_id)
> +{
> +       struct napi_struct *napi;
> +       struct net_device *dev;
> +
> +       rcu_read_lock();
> +       napi =3D netdev_napi_by_id(net, napi_id);
> +       if (!napi || napi->dev->reg_state !=3D NETREG_REGISTERED) {

nit: this should be READ_ONCE(napi->dev->reg_state) !=3D NETREG_REGISTERED

> +               rcu_read_unlock();
> +               return NULL;
> +       }
> +
> +       dev =3D napi->dev;
> +       dev_hold(dev);
> +       rcu_read_unlock();
> +
> +       dev =3D __netdev_put_lock(dev);
> +       if (!dev)
> +               return NULL;
> +
> +       rcu_read_lock();
> +       napi =3D netdev_napi_by_id(net, napi_id);
> +       if (napi && napi->dev !=3D dev)
> +               napi =3D NULL;
> +       rcu_read_unlock();
> +
> +       if (!napi)
> +               netdev_unlock(dev);
> +       return napi;
> +}
> +
>  /**
>   *     __dev_get_by_name       - find a device by its name
>   *     @net: the applicable net namespace
> @@ -971,6 +1014,73 @@ struct net_device *dev_get_by_napi_id(unsigned int =
napi_id)
>         return napi ? napi->dev : NULL;
>  }
>
> +/* Release the held reference on the net_device, and if the net_device
> + * is still registered try to lock the instance lock. If device is being
> + * unregistered NULL will be returned (but the reference has been releas=
ed,
> + * either way!)
> + *
> + * This helper is intended for locking net_device after it has been look=
ed up
> + * using a lockless lookup helper. Lock prevents the instance from going=
 away.
> + */
> +struct net_device *__netdev_put_lock(struct net_device *dev)
> +{
> +       netdev_lock(dev);
> +       if (dev->reg_state > NETREG_REGISTERED) {

I presume the netdev lock will be held at some point in
netdev_run_todo and/or unregister_netdevice_many_notify
so no need for a READ_ONCE() here.

Reviewed-by: Eric Dumazet <edumazet@google.com>

