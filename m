Return-Path: <netdev+bounces-129240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F397E6C9
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 09:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B187B20A30
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 07:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AAD374C3;
	Mon, 23 Sep 2024 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SO92R/ZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D27023C9
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727077537; cv=none; b=k6HI1vL73EGh+ZI/zcj3gJwqWe3cFQ94MeVLkc9Mo7sOGf9adWVM2cYr3xsO5NAtV8v5CA8Fev548MBGpcNj/gbWh8J7iUpXwDf5atnj1gYK7jAz/6YhVP9fwiMMfvwXNNT8KkeEbUNcWd9ebnLTyplK9ZjrVnPDcNHGpgjDTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727077537; c=relaxed/simple;
	bh=QrQXKavQ3kAABvu7IsbQ/w0uI/OqFs7EBjA3NkiLJ9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/tPIt0HhJQpoeWubLFbnadYzH0Ha1VKhZjCtkkN0owvJbk4HWdyEahdB4wt8NSY/e1BceMz+ikimyAGAyR6kYqB6CGmjfx54NDozSdJMfbNz7fSVbXAwrvqTchnUZQAZO/nWd3qWCfbzkezciErwgt0DjPmF4QL4BM2onpQ2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SO92R/ZU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c3d209db94so5274605a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727077535; x=1727682335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jtumo6vJ3j8mdCTUgzYikqHbLFWBv6wsqW8Um5r7las=;
        b=SO92R/ZUgkxTOGSA2yZiBVgOQFq5mgPaCDrW3Hr1BDs6UUazQ1CrJsqV2yLcinvI9u
         9b/ua1BAQA5pwXkA+fZmeAv35OzfEPIddbroEAIgkfsgA2G302TytGlAouIatOaTMPoW
         rGZwcaafBWyQAtGKCqsbruDaY5UAF/xbCt8qrTqw8R/ODIPKsscsYPJ9iogJM+nWl9l0
         ikDDn6oOm3pHSvPvCgRLc6olfenxRsaoXcIw7Qbt9z27cCF1zGKKrWrgeZ+BhruaIAt+
         VYQJG6nH7Cfrd7xltc1QOYqeD6eIdBvl5/iSJL/xBcw2bk80SNVPwpC36aFkiFvNyCtx
         r5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727077535; x=1727682335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jtumo6vJ3j8mdCTUgzYikqHbLFWBv6wsqW8Um5r7las=;
        b=lNcj+VSS9vppgFrI4wRY9qh5euqe3ZP8hRXVleN30FTYBjK8GxinJ8xjlaEicbmuHy
         l2j7wBqNHvrnRG6AI06+jJJwG11OCPmnQWDRnYZ/W3l4ViYQiUzlRUWwEgOyT+PO76Aa
         Jd023z9st9Eiv8Hw2jXy34YuePrlPH9Mn/xt36dU/lXvFbBtRclDdgMmsGyC7yn8zEhJ
         hUg5zmDD57CKKOvJr00vUwYx9Q2BRh5KqqLLFHaGAkB27ZvNHBTrWCEAsUlBaVzEgjOz
         Cp9SSGQvY7wWm9GcFBWnc9gkOgOegGn3fbnug3qIg7vYGgwBQAoZoi+A/I+XLgDz3WeI
         lUIg==
X-Gm-Message-State: AOJu0YxQmRSUgfk5XuKIUkrqIzI2JeiS+lIve3skq76/wt6ReGgKfzhC
	AQUEA5S6rQL/t1MI0kxWE7cATJ5C5ogDM0Z0SdDVKvQGVEGVFMHv2OXe8HmA2U8eHKY3t8k87SD
	WZYfdfw0c7ezYZMKQrQrIX/KoaIdVsJsuwz2T
X-Google-Smtp-Source: AGHT+IEDzuCBAfmmgyAaScURt34uswQWh04lq4DlOHTmMt1iJsKsfOdPvYgM+YV4rL0rd6uyFkzu29hioKHFLOazdqo=
X-Received: by 2002:a05:6402:3506:b0:5c5:c2a7:d53a with SMTP id
 4fb4d7f45d1cf-5c5c2a7d69amr2000932a12.12.1727077534319; Mon, 23 Sep 2024
 00:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923072843.46809-1-liuhangbin@gmail.com>
In-Reply-To: <20240923072843.46809-1-liuhangbin@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 09:45:23 +0200
Message-ID: <CANn89iLoVexJpUbZzwAYtGpLiTZ36tFh5GpJU=mYH6YazJeTPQ@mail.gmail.com>
Subject: Re: [PATCH net] bonding: show slave priority in proc info
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 9:29=E2=80=AFAM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> The slave priority is currently not shown in the proc filesystem, which
> prevents users from retrieving this information via proc. This patch fixe=
s
> the issue by printing the slave priority in the proc filesystem, making i=
t
> accessible to users.
>
> Fixes: 0a2ff7cc8ad4 ("Bonding: add per-port priority for failover re-sele=
ction")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_procfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond=
_procfs.c
> index 7edf72ec816a..8b8580956edd 100644
> --- a/drivers/net/bonding/bond_procfs.c
> +++ b/drivers/net/bonding/bond_procfs.c
> @@ -210,6 +210,7 @@ static void bond_info_show_slave(struct seq_file *seq=
,
>         seq_printf(seq, "Permanent HW addr: %*phC\n",
>                    slave->dev->addr_len, slave->perm_hwaddr);
>         seq_printf(seq, "Slave queue ID: %d\n", READ_ONCE(slave->queue_id=
));
> +       seq_printf(seq, "Slave prio: %d\n", READ_ONCE(slave->prio));
>
>         if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
>                 const struct port *port =3D &SLAVE_AD_INFO(slave)->port;
> --
> 2.46.0
>

proc interface is deprecated in favor of rtnl.

slave->prio is correctly reported in IFLA_BOND_SLAVE_PRIO attribute.

No further kernel change is needed.

