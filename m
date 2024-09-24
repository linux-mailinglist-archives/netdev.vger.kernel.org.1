Return-Path: <netdev+bounces-129400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62040983A9E
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 02:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120DA1F23779
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 00:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A5B1B85DA;
	Tue, 24 Sep 2024 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSo3hjIZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D25C1B95B;
	Tue, 24 Sep 2024 00:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727138272; cv=none; b=j8VGBaYb9HXfiag+fQzgjUIM2o0/5JMsOMHI2jB90pvbMG0t6ypEH8Oa4SnBvUPbxpwMoKTEqdhKhxCb6OE1fbAnL4kDlyVs1af5jTkO97T5Nx+CEhgGQoFzi77+iU+BX38H9GutZ+Dt/qrGmOJZUa+n6Vl3Ra8vz2BxxM0kEuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727138272; c=relaxed/simple;
	bh=p7oNS5eaV/rjyrBNKPwDsltNGnzh2U6DekaWyXUf4uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN+yDW/UHoVoY9q72LMNl3EsOhyMsvAtJipIwcffE3vVC2xsfznooC2uGBD9VlFr5ELR2IKVTvJv2bGKULvZGlt8DqNjqAemK+aj6KGsWLetY6CBc6AyqHuj8BgxN5K7pKyilZ7l55EYiRSoUaZrwHNAJS7F2HGf6iFJrgC4g1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSo3hjIZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20573eb852aso37481805ad.1;
        Mon, 23 Sep 2024 17:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727138271; x=1727743071; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3sF7bp+9YNuz/1OUexYb03klrCNegDMvCwEWeusF4wg=;
        b=nSo3hjIZXDicLgRYw6B/LnASMqTMun5MhCyRyCyBRdREvfSHU5pDguV+gd8h5CBDZd
         50Rf8i9mxmTzX9yK0C50l5ijU29ik500XlFcETP0wSkxBexF/ZntvTpoIjS7463oi//g
         tZef7WPfJKpAcp4OD1XdDoD/RnXs4SYH4xEIvYB8JIN2ANdDTl2qEkDVu6ZbXEqjTN0q
         emZk/df3N1aS+ViD357+CnW95glZxRSycqTfqoQMwgBjYK4A9C699J4q5JhOaaanF5V1
         5J5P1CMKThtR1/taeR+TgvmlCo7JHsDWb9jhQl9ptZ6CcPjGnvoFQPeXUU3Pjxw4JTYk
         U+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727138271; x=1727743071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3sF7bp+9YNuz/1OUexYb03klrCNegDMvCwEWeusF4wg=;
        b=iiUBPsjYJ+8rdVZ0vSu1QEUVQ7fgwp9jG0YxrnnOENWvTceLGfJzOhejoJwXWqPngz
         8+f65yK/6gscTJfBAfugryQTitesWWewBTedUV8cvYKcznZjfVSSr4CB9X11M0N5h0xH
         fNVY5wO90Ql72Edo4/Kz1THOFuOWyNy9SXcbf8L3ekTjZzlal0P9FwZVSDao/7a1Qc2L
         QDAzRvuomgzWgBGgFutxj2msXdmyYCoZDA6Wu2BN/gL2LwZ/cYiDpIstjkbbOfFDKvmU
         mVpWZ3zNU67QcPkch8nePDCFHHgIzyH6Lm/25elkguHxW5Y2qQnB6voCvUq5qSA/zKWI
         3lUg==
X-Forwarded-Encrypted: i=1; AJvYcCXxJ1/Vq6wzrH95RD/OShvgOH9hWDs4UUUbUvWYqmQEh/hkZI9jvTcbM3adocnEe0k4aNI9hsycpesouLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoHeimXJ30TLnpBZW+JCwlYY6rDKlp8BcyNRhYML/g75BeyKE1
	C+VVJuRWDBZae+dhqeon41Pb/iJNa2ojeGON1sfBU3dGoWAoDpcgMxEvVNXUDakg8w==
X-Google-Smtp-Source: AGHT+IEoqURXR+G23iXfZ+wGFKSd5/M3MbDYTQGTy5+iUDUHCW1FPtuwo2BTJxpGoHC7SudLcHTRnA==
X-Received: by 2002:a17:902:f54c:b0:206:a6fe:2343 with SMTP id d9443c01a7336-20aed088d76mr22398325ad.8.1727138270601;
        Mon, 23 Sep 2024 17:37:50 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c3f1f3sm136718a12.26.2024.09.23.17.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 17:37:50 -0700 (PDT)
Date: Tue, 24 Sep 2024 00:37:43 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: show slave priority in proc info
Message-ID: <ZvIJ1xewGuJ_JhbE@fedora>
References: <20240923072843.46809-1-liuhangbin@gmail.com>
 <CANn89iLoVexJpUbZzwAYtGpLiTZ36tFh5GpJU=mYH6YazJeTPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLoVexJpUbZzwAYtGpLiTZ36tFh5GpJU=mYH6YazJeTPQ@mail.gmail.com>

Hi Eric,

On Mon, Sep 23, 2024 at 09:45:23AM +0200, Eric Dumazet wrote:
> On Mon, Sep 23, 2024 at 9:29 AM Hangbin Liu <liuhangbin@gmail.com> wrote:
> >
> > The slave priority is currently not shown in the proc filesystem, which
> > prevents users from retrieving this information via proc. This patch fixes
> > the issue by printing the slave priority in the proc filesystem, making it
> > accessible to users.
> >
> > Fixes: 0a2ff7cc8ad4 ("Bonding: add per-port priority for failover re-selection")
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  drivers/net/bonding/bond_procfs.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
> > index 7edf72ec816a..8b8580956edd 100644
> > --- a/drivers/net/bonding/bond_procfs.c
> > +++ b/drivers/net/bonding/bond_procfs.c
> > @@ -210,6 +210,7 @@ static void bond_info_show_slave(struct seq_file *seq,
> >         seq_printf(seq, "Permanent HW addr: %*phC\n",
> >                    slave->dev->addr_len, slave->perm_hwaddr);
> >         seq_printf(seq, "Slave queue ID: %d\n", READ_ONCE(slave->queue_id));
> > +       seq_printf(seq, "Slave prio: %d\n", READ_ONCE(slave->prio));
> >
> >         if (BOND_MODE(bond) == BOND_MODE_8023AD) {
> >                 const struct port *port = &SLAVE_AD_INFO(slave)->port;
> > --
> > 2.46.0
> >
> 
> proc interface is deprecated in favor of rtnl.
> 
> slave->prio is correctly reported in IFLA_BOND_SLAVE_PRIO attribute.
> 
> No further kernel change is needed.

Thanks for the reply. Some users said they still prefer to use /proc
to get the bonding info as it's easier compared with get info via rtnl(ip
link). I'm OK to drop this patch.

Thanks
Hangbin

