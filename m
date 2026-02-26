Return-Path: <netdev+bounces-261310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM9cGkk0oGntggQAu9opvQ
	(envelope-from <netdev+bounces-261310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:53:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC85C1A560E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58D98318B187
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5E7376BE5;
	Thu, 26 Feb 2026 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Te6vM2Oh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC7936A032
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106459; cv=pass; b=MJdtyIjEL0cdS+Olit669+u3NC0sG+a9zr5rjqgIgz4Gc1rmZJHfM7HokHsWTD5fBtaZyrO6dxR7zFQeDUU79RT9zcwo+CqqwMpP6oGTtmO5Zxp1ssNhUivZ9mocOfIM2vpkRinstKoqMUbM4G4acmm4QKTwcK4XtZ/DlX5IR+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106459; c=relaxed/simple;
	bh=euSTzPq2F1klfGutM2tOKaO76fvZ7WdYUpBMkfRWduM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXgBVC3LiILXN2Vjls7VfQwbdYQWZDIOKl8XSJ7sY2Ddl2FaoGplnOrJ7afIgl3ZoyUw4bH8k0O8IEyfzvnsBXK38jz8wkM7pIDFO6Jo4Ug068+6qi5qNL75+X49hNvcB4jSlP7Hh8cNOjdsOkIYSjkmYFGbiYdZZ3hPm1pAS0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Te6vM2Oh; arc=pass smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2ab232cc803so3756515ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106458; x=1772711258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDgQfZEqeYjIqNd6BT6EySh1xk9DorRuGMHGS2SIX1Y=;
        b=HJGik2bzwl01MzEE/886txJZpdBaJXFk4xOEprDMjA3pUx9BFxzGNsiXlZ1opY9LX1
         8/BskXCeBVCdkmsBqtt/Ws18yPFHeETPsYYjrA7o1AelK+t9q+EpEQegqohCC4xv/HOG
         JjqfFcT6pKiwmSzwfoxn9zn7HwhxaCvDJ6J6W4wlGw6i4MGwdpswlZPYqj3jv3+Fduip
         MvLUqYlvGcuo6V6ldKJEEyyeoPt5HhFeU0+Z55vNy74xtdCA/JqxerWMQzDheCrTSFCM
         RlyiuklROBSlfSowZgSYmFmexyXTI46fLsIc4wggZ9Jt7FNlfTg7TVANXUrNRxvQyQty
         DZgg==
X-Forwarded-Encrypted: i=2; AJvYcCXV/mf0a3L6Hvr/cJP4m+eQmOk5QdYwaoBiAhsk3UJbqBi+QsHaLtFTrl34d/0pJkq2D99QErY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsQSRr0p14uWkvENadmnN34fdAVFdRf+vIZGWlKPNL78394hii
	1zdP+4JIxFHPhiyMz0yHrDmAa9iX5WwaLShwhBjVHSa1J+B1wm+xV/VGr0TfDcQlP45ObV+MoG4
	wxAan1+IzrwU2DKXqslc3fMh16EQlP02pjhepWWtbfiHOSKmIwwYIDM0Pr+kaZyZq1fF3KAw8AY
	YWZJhHXr9Dzg9wnz6j1qgw221q3t7sY/3ZWNkdyZDSGPCUOQ7llY1gPn2eoAdFMrOWAk1VbzAWp
	eUx1mkw1g==
X-Gm-Gg: ATEYQzw7g2C+KDUN+K4G7Yffyf5vfZHC1/5Kj96nnPlQq4SXaP+QY5WJ3E8c/O8nFYZ
	sRq7DBALnBIGU6LgGmfXyje0TNmfN9BFgqeif86hxWJ9Aja+PQ3lZZcYcxC3GkxxFPncP9Um6aP
	pewnnYQs5thqKcp2q7n3Sv3ju3aoRDYWsLg/pGkBzOCTAY4IPQWnSaMGSmXGkTPmnXBFURLLcWe
	p7LyY6OzAhjXzOaVmc7HQzszp48aWHKlsAvNRuXUXUfLLHqc6nqIJ3yOFGPp3sX2fjMu1i7km7V
	qcBfOdYKXeIFu9Rp0N7bBp4aUVs5/95eg0qR6NqKTVnB8NrY+iZ2RIR+5lpsycMCCGytz+9A4KY
	ti8XCXY/TPXnWqMohVaCfYgD1X8CpNCezpsta7XkwTtwdQjJ1TneotK9UIr6A5ce/SqLx5+1wcQ
	nBqMc8uzvftgHBLArJ/hvoYiE5QUT2Al0H7A7EKs3BPzJDa1oViJ3NLIeWkQ==
X-Received: by 2002:a17:902:db02:b0:2a0:fe9f:1884 with SMTP id d9443c01a7336-2ade9aac40amr37532025ad.55.1772106457579;
        Thu, 26 Feb 2026 03:47:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb5eee32sm2263645ad.42.2026.02.26.03.47.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 03:47:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c5269fcecdeso429680a12.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:47:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772106456; cv=none;
        d=google.com; s=arc-20240605;
        b=DH6dG4zkZZDIOSWO7/QgcxNfJOhbBHSfAbpptgHJhOtWU6XTRl0b7D/AwKTwRfotEx
         fymfkaM29jHnntWu1uCIkTQxQbaM+7pZjLs3T6hOTVfEow5v3/ASNMUn4Q1FQHhZqZ4q
         aBsxsbh8DU/by6+Hu0qXEe3aUUrUdw1ndqWM1twLCKYmTiaRIyoIHF5ixFTgeeo64hi5
         4NDfsag4NQVXvPhg/E4OKpfHCrMYTcSi8rlEJgDqQ+R3zqc/aEHhOWQBUNnQfk5KMz2c
         CsQfZjNLL1XzDacabJfFWD3iwAImfL8Lo7vNZvYj02whs42DBdk8nt9ZhiLrEBHjcWLL
         uPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uDgQfZEqeYjIqNd6BT6EySh1xk9DorRuGMHGS2SIX1Y=;
        fh=aM7YBv92mTAopUdolQeOePUU58/1ANBKFfBs9RyuHJw=;
        b=HVETb+Iys07rGRRk3rMRi8+AnLJFL0EdJC9vPlrLlwhfp7S+GTkt4I9xluqFHKOqWt
         7BFAqJid6QBxxnrh2LjfICvQuGKfq/FyOuW7wSUj1x4bO8nLQaa+OFW5++WZGzWyqZd5
         y/kmu+W0CYj4lri523OVaDsHN3bBxOjuyxIOL/za1PnXB2EWxSyDsQZ98uI0AF/dDzu9
         /AdmZSmEH1vW5H5WNFvLIqNqrKji0jBqvLs92sUigcdataPQVZvV5y8IkI4cNyYV74uL
         eOoZUIM4zUKLajYCleLrIyRomrqqR5DyoRkRTYOAr8/HqKrgnuP4PBH3Npt6tMvvhCra
         5bRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772106456; x=1772711256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDgQfZEqeYjIqNd6BT6EySh1xk9DorRuGMHGS2SIX1Y=;
        b=Te6vM2Ohq5XsFj/IvimXNliI9xw2JRRZk6vpGsyRwNpTcGA2kyoFR5wBo2wbihFa+c
         hjINIPnGebMFkAZ/AIGNCtQaoPo/Bke6EZ8MwRTwro0wuqtw4rq18XR3PEcSmNi+qZKn
         GJ15mp+ObcRmi9KIELHiFP3uqx1h+nRs+99KY=
X-Forwarded-Encrypted: i=1; AJvYcCUB7sx/kwLubNJXGpj0b/hYAjXzK5rx20xG5a/3ctAOzd666AuYTHtduMMvR1fYXOgM18mwTpM=@vger.kernel.org
X-Received: by 2002:a05:6a20:2d08:b0:38d:fbb3:d577 with SMTP id adf61e73a8af0-395ad27e8efmr3361286637.66.1772106455936;
        Thu, 26 Feb 2026 03:47:35 -0800 (PST)
X-Received: by 2002:a05:6a20:2d08:b0:38d:fbb3:d577 with SMTP id
 adf61e73a8af0-395ad27e8efmr3361269637.66.1772106455462; Thu, 26 Feb 2026
 03:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223191154.2800616-1-kiran.kella@broadcom.com>
 <20260223191154.2800616-2-kiran.kella@broadcom.com> <0a850f65-be67-4a66-941f-17d8440e987b@gmail.com>
In-Reply-To: <0a850f65-be67-4a66-941f-17d8440e987b@gmail.com>
From: Kiran Kella <kiran.kella@broadcom.com>
Date: Thu, 26 Feb 2026 17:16:58 +0530
X-Gm-Features: AaiRm53xFbGiXfLqovTFpAqyCtRs5jzO3JWaPF3zjgRMA39ajMSJwkWfEtSXQXA
Message-ID: <CAPHeo3eJRYc503Ta24h9r+Uu1cGqb1dCfmnxuZQ4MJLCTFd9Lw@mail.gmail.com>
Subject: Re: [net-next, v2 1/2] psp: Support for transmit on logical device
 when the underlying transport device supports PSP.
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	willemb@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com, 
	akhilesh.samineni@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261310-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: BC85C1A560E
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 2:28=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
>
>
> On 2/23/26 2:11 PM, Kiran Kella wrote:
> > This is achieved by propagating the psp_dev from the lower device
> > to the upper devices in the device stack via a netdevice notifier.
> > The lowest device owns the psp_dev pointer while the upper devices
> > just borrow the pointer. When the lower device is unlinked, the
> > borrowed pointer is cleared in the upper device.
> > Assumption being that psp_dev is set on the lowest device before
> > any upper devices are stacked on that lowest device.
> >
> > Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
> > Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
> > Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
> > ---
> >   net/psp/psp_main.c | 109 ++++++++++++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 108 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> > index a8534124f626..fac785dcfa0f 100644
> > --- a/net/psp/psp_main.c
> > +++ b/net/psp/psp_main.c
> > @@ -3,6 +3,7 @@
> >   #include <linux/bitfield.h>
> >   #include <linux/list.h>
> >   #include <linux/netdevice.h>
> > +#include <linux/rtnetlink.h>
> >   #include <linux/xarray.h>
> >   #include <net/net_namespace.h>
> >   #include <net/psp.h>
> > @@ -110,13 +111,45 @@ void psp_dev_free(struct psp_dev *psd)
> >       kfree_rcu(psd, rcu);
> >   }
> >
> > +/**
> > + * psp_clear_upper_dev_psp_dev() - Clear borrowed psp_dev pointer on u=
pper
> > + *                              device
> > + * @upper_dev:       Upper device that may have borrowed psp_dev point=
er
> > + * @priv:    netdev_nested_priv containing the psp_dev being unregiste=
red
> > + *
> > + * Callback for netdev_walk_all_upper_dev_rcu() to clear borrowed psp_=
dev
> > + * pointers on upper devices when the underlying psp_dev is being unre=
gistered.
> > + *
> > + * Return: 0 to continue walking, non-zero to stop.
> > + */
> > +static int psp_clear_upper_dev_psp_dev(struct net_device *upper_dev,
> > +                                    struct netdev_nested_priv *priv)
> > +{
> > +     struct psp_dev *psd =3D priv->data;
> > +     struct psp_dev *upper_psd;
> > +
> > +     upper_psd =3D rcu_dereference(upper_dev->psp_dev);
> > +     if (upper_psd =3D=3D psd)
> > +             rcu_assign_pointer(upper_dev->psp_dev, NULL);
> > +
> > +     return 0;
> > +}
> > +
> >   /**
> >    * psp_dev_unregister() - unregister PSP device
> >    * @psd:    PSP device structure
> > + *
> > + * Unregisters a PSP device and clears all borrowed psp_dev pointers o=
n
> > + * upper devices (e.g., VLAN subinterfaces) that reference this device=
.
> > + * This prevents use-after-free if upper devices still have borrowed
> > + * pointers when the psp_dev structure is freed.
> >    */
> >   void psp_dev_unregister(struct psp_dev *psd)
> >   {
> >       struct psp_assoc *pas, *next;
> > +     struct netdev_nested_priv priv =3D {
> > +             .data =3D psd,
> > +     };
> >
> >       mutex_lock(&psp_devs_lock);
> >       mutex_lock(&psd->lock);
> > @@ -137,6 +170,12 @@ void psp_dev_unregister(struct psp_dev *psd)
> >
> >       rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
> >
> > +     /* Clear borrowed psp_dev pointers on all upper devices */
> > +     rcu_read_lock();
> > +     netdev_walk_all_upper_dev_rcu(psd->main_netdev,
> > +                                   psp_clear_upper_dev_psp_dev, &priv)=
;
> > +     rcu_read_unlock();
> > +
> >       psd->ops =3D NULL;
> >       psd->drv_priv =3D NULL;
> >
> > @@ -313,11 +352,79 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, =
u8 generation, bool strip_icv)
> >   }
> >   EXPORT_SYMBOL(psp_dev_rcv);
> >
> > +/**
> > + * psp_netdevice_event() - Handle netdevice events for PSP device prop=
agation
> > + * @nb:              notifier block
> > + * @event:   netdevice event
> > + * @ptr:     netdevice notifier info
> > + *
> > + * Propagates psp_dev pointer from lower devices to upper devices when
> > + * upper devices are created (e.g., VLAN subinterfaces).
> > + * Excluding from this logic, the upper devices that have multiple low=
er
> > + * devices eg., bond devices.
> > + *
> > + * Return: NOTIFY_DONE
> > + */
> > +static int psp_netdevice_event(struct notifier_block *nb,
> > +                            unsigned long event, void *ptr)
> > +{
> > +     struct netdev_notifier_changeupper_info *info;
> > +     struct net_device *dev, *upper_dev;
> > +     struct psp_dev *psd;
> > +
> > +     if (event !=3D NETDEV_CHANGEUPPER)
> > +             return NOTIFY_DONE;
> > +
> > +     info =3D ptr;
> > +     dev =3D netdev_notifier_info_to_dev(ptr);
> > +     upper_dev =3D info->upper_dev;
> > +
> > +     if (netif_is_lag_master(upper_dev))
> > +             return NOTIFY_DONE;
> > +
> > +     if (info->linking) {
> > +             /* Lower device is being linked to an upper device.
> > +              * Propagate psp_dev from the immediate lower device to t=
he
> > +              * upper device. The immediate lower device would have al=
ready
> > +              * got the psp_dev pointer set in a previous notification=
 (or
> > +              * owns it if it's the lowest device).
> > +              * Upper devices just borrow the pointer.
> > +              */
> > +             psd =3D rtnl_dereference(dev->psp_dev);
> > +             if (psd)
> > +                     rcu_assign_pointer(upper_dev->psp_dev, psd);
> > +     } else {
> > +             /* Lower device is being unlinked from an upper device.
> > +              * Clear the borrowed psp_dev pointer.
> > +              */
> > +             psd =3D rtnl_dereference(upper_dev->psp_dev);
> > +             if (psd)
> > +                     rcu_assign_pointer(upper_dev->psp_dev, NULL);
> > +     }
> > +
> > +     return NOTIFY_DONE;
> > +}
> > +
> > +static struct notifier_block psp_netdevice_notifier =3D {
> > +     .notifier_call =3D psp_netdevice_event,
> > +};
> > +
> >   static int __init psp_init(void)
> >   {
> > +     int err;
> > +
> >       mutex_init(&psp_devs_lock);
> >
> > -     return genl_register_family(&psp_nl_family);
> > +     err =3D register_netdevice_notifier(&psp_netdevice_notifier);
> > +     if (err)
> > +             return err;
> > +
> > +     err =3D genl_register_family(&psp_nl_family);
> > +     if (err) {
> > +             unregister_netdevice_notifier(&psp_netdevice_notifier);
> > +             return err;
> > +     }
> > +     return 0;
> >   }
> >
> >   subsys_initcall(psp_init);
>
> The lack of support for netns is a bit of a gap for this feature. It may
> make sense to see if what was posted in
> https://lore.kernel.org/netdev/20260224002410.1553838-1-weibunny@fb.com/
> is sufficient for your use case, as it handles cases where upper devices
> are in a different netns from psd->main_netdev.

Thanks. Went through the changes in
https://lore.kernel.org/netdev/20260224002410.1553838-1-weibunny@fb.com/
It is sufficient for my use case too, although it specifically
addresses the cross-netns virtual devices use case.
But the same net-ns stacked devices like VLANs can be handled with
this patch implicitly, without user intervention through dev-assoc.
I think both approaches can co-exist without conflict.
However, I am ok with using a single approach to use the dev-assoc for
the same net-ns use case too.

Thanks,
Kiran

