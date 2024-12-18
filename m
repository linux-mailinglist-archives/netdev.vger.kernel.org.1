Return-Path: <netdev+bounces-152981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6D49F6833
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DACA518935FE
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FB31B0414;
	Wed, 18 Dec 2024 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOICPwh/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5DA73446
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531687; cv=none; b=htO55H7UK6iHtbdmAbKWfBB/F9NYzaTimi4JpFCzf4xF8j9WSRVluycXnzBy4EtI1Fbj3RA3XMLUOsRY+7OggXmzdt8CUkJYh3+IUPAfBxBvq1BVfgwK1VyfGE8o4W0J1Wq04Hebz7H0y5I/N+1Tqhf1r9tk1fOLY45Y2uXKIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531687; c=relaxed/simple;
	bh=7EfhJMAGoUDDd3WAx/fPg7Sc93c/yhaslJXSydwpCdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwUIxWKsErnyHFPuU7NbPGuntK+H49DPaiq0wguEoCq4wT8ZjL6Rq5/Szp4o+bDHe+pFjdoCmX0XhfuSK2e9RB9oWVbJfwst1jCe3fVFwZ+nciQIX7BbaAWJeFId+EBMrW0ibzaQaLZxBp15nebXEh9l6XftdLoOn1sLNNLnCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOICPwh/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso8666101a12.0
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 06:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734531684; x=1735136484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn4pllNqfD1Dkr06yMbYynREm4fDuu4oYb+r3qMVadY=;
        b=MOICPwh/8bW2g6v7edo/ROYWsAd/0cnDTpqtDflBaxebzQRgpGg0iOoM/ryim69SKI
         5F97HuCWlaIYe9mSMKWJwzOnCGfcRd+Jy6FfnqEEUBKAherth/QWy6EB+zeFCehbu5xD
         CpevwGSVDhtin9zss1q86qn6OINOX560lApxdH0OAvOBDvYr3+s6kihbloh71j5sMH6A
         40ExQO9eNizl2/hWG/sLBHArW4x7A8VpwsnBk0DiNyQLmx6dfwg9l3QG3pdpvfdtgnUH
         7sZ1QyW/4ktEpsUnHeE+jjIvtruDx3R1wwOYGRmHSBcew/lpYYne8PkllCuAthG8PgaO
         GWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734531684; x=1735136484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qn4pllNqfD1Dkr06yMbYynREm4fDuu4oYb+r3qMVadY=;
        b=KDaJ4iINRCPUfKVyJWV78HutJQ3SAroMzk+ogBvF5a5+lygbZhruNTj+ZcSukYoIq4
         L/CfwkZz4BjcAlPnmjezlKbQyIIEnTSV2YMTG3PUgcJfEyHapcJmDpyy2bOT7df49yfs
         Y588VhwzKoSMN5IWCBokNTLb36+jWn84iUvf1kIG9gbiU0npOflksf1tLpJ7YyL99e3n
         PgHPPNhr+QN/fU8VwbvneuxFCzspDHRqj3LvZtMKPUqaJnLRhRT65MjE/SzOAm77KuRO
         mowX/REGzDaeuMa8tl67clvM3LjTwCk3RisWNecCr+8T9NZx/LbEYdaZDsoPI7D6TMOM
         JwrA==
X-Forwarded-Encrypted: i=1; AJvYcCUDku4eZuREEYxSOCoD13rMJp1qd8V9wHu9Ww9IlW4UkQkYtsGt4R4v25/suWmTAevJbJUAffY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL1dqcOyTZp3KZOWTRtqEJG3DgYHr1wk+NrPS1kH0FELLfZ2m7
	uL1NbGFH/IG4kiFuauQ5fx/k5uOzXX2WkptUxzNk561a7ComJtLMGPwDHDMcP9DI1MBwNvs3hfY
	+lu8JomiPFlp6QwE0Hz8KC1VcjoLD7mxwF6W7
X-Gm-Gg: ASbGncvqeNDaPbjutZBW4dVKZluwuv/nEheIm0/Bb0BIwaMAwlsJhqmACipPKYRRBCe
	u5oh95y8t8EwMcrTj2+glZsZD9IuZJRoA8DhdFepHaFDEqLzV5TRi5zVGG55nCIc0hSW+MLA=
X-Google-Smtp-Source: AGHT+IFL3w5rIpwCUSg7XCtw1d15+RBvCkJLrp8VpMp0ZysMMGwb0mQCY3A+1Ey/aKk+qUTjCRpYUt4Nxw/u1old79s=
X-Received: by 2002:a05:6402:35d4:b0:5cf:e66f:678d with SMTP id
 4fb4d7f45d1cf-5d7ee410c8bmr2874796a12.28.1734531683791; Wed, 18 Dec 2024
 06:21:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-2-srasheed@marvell.com> <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
 <Z2A9UmjW7rnCGiEu@lzaremba-mobl.ger.corp.intel.com> <BY3PR18MB4721712299EAB0ED37CCEEEFC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
 <Z2GvpzRDSTjkzFxO@lzaremba-mobl.ger.corp.intel.com> <CO1PR18MB472973A60723E9417FE1BB87C7042@CO1PR18MB4729.namprd18.prod.outlook.com>
 <Z2LNOLxy0H1JoTnd@lzaremba-mobl.ger.corp.intel.com>
In-Reply-To: <Z2LNOLxy0H1JoTnd@lzaremba-mobl.ger.corp.intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Dec 2024 15:21:12 +0100
Message-ID: <CANn89iJXNYRNn7N9AHKr0jECxn0Lh6_CtKG7kk9xjqhbVjjkjQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Shinas Rasheed <srasheed@marvell.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani <hgani@marvell.com>, 
	Sathesh B Edara <sedara@marvell.com>, Vimlesh Kumar <vimleshk@marvell.com>, 
	"thaller@redhat.com" <thaller@redhat.com>, "wizhao@redhat.com" <wizhao@redhat.com>, 
	"kheib@redhat.com" <kheib@redhat.com>, "konguyen@redhat.com" <konguyen@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "einstein.xue@synaxg.com" <einstein.xue@synaxg.com>, 
	Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Abhijit Ayarekar <aayarekar@marvell.com>, Satananda Burla <sburla@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 2:25=E2=80=AFPM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:

>
> It is hard to know without testing (but testing should not be hard). I th=
ink the
> phrase "Statistics must persist across routine operations like bringing t=
he
> interface down and up." [0] implies that bringing the interface down may =
not
> necessarily prevent stats calls.

Please don't  add workarounds to individual drivers.

I think the core networking stack should handle the possible races.

Most dev_get_stats() callers are correctly testing dev_isalive() or
are protected by RTNL.

There are few nested cases that are not properly handled, the
following patch should take care of them.


diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2593019ad5b1614f3b8c037afb4ba4fa740c7d51..768afc2a18d343d051e7a1b6311=
24910af9922d2
100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5342,6 +5342,12 @@ static inline const char
*netdev_reg_state(const struct net_device *dev)
        return " (unknown)";
 }

+/* Caller holds RTNL or RCU */
+static inline int dev_isalive(const struct net_device *dev)
+{
+       return READ_ONCE(dev->reg_state) <=3D NETREG_REGISTERED;
+}
+
 #define MODULE_ALIAS_NETDEV(device) \
        MODULE_ALIAS("netdev-" device)

diff --git a/net/core/dev.c b/net/core/dev.c
index c7f3dea3e0eb9eb05865e49dd7a8535afb974149..f11f305f3136f208fcb285c7b31=
4914aef20dfad
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11044,8 +11044,13 @@ struct rtnl_link_stats64
*dev_get_stats(struct net_device *dev,
        const struct net_device_ops *ops =3D dev->netdev_ops;
        const struct net_device_core_stats __percpu *p;

+       memset(storage, 0, sizeof(*storage));
+       rcu_read_lock();
+
+       if (unlikely(!dev_isalive(dev)))
+               goto unlock;
+
        if (ops->ndo_get_stats64) {
-               memset(storage, 0, sizeof(*storage));
                ops->ndo_get_stats64(dev, storage);
        } else if (ops->ndo_get_stats) {
                netdev_stats_to_stats64(storage, ops->ndo_get_stats(dev));
@@ -11071,6 +11076,8 @@ struct rtnl_link_stats64 *dev_get_stats(struct
net_device *dev,
                        storage->rx_otherhost_dropped +=3D
READ_ONCE(core_stats->rx_otherhost_dropped);
                }
        }
+unlock:
+       rcu_read_unlock();
        return storage;
 }
 EXPORT_SYMBOL(dev_get_stats);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 2d9afc6e2161efa51ffa62813ec10c8f43944bce..3f4851d67015c959dd531c571c4=
6fc2ac18beb65
100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -36,12 +36,6 @@ static const char fmt_uint[] =3D "%u\n";
 static const char fmt_ulong[] =3D "%lu\n";
 static const char fmt_u64[] =3D "%llu\n";

-/* Caller holds RTNL or RCU */
-static inline int dev_isalive(const struct net_device *dev)
-{
-       return READ_ONCE(dev->reg_state) <=3D NETREG_REGISTERED;
-}
-
 /* use same locking rules as GIF* ioctl's */
 static ssize_t netdev_show(const struct device *dev,
                           struct device_attribute *attr, char *buf,

