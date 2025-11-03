Return-Path: <netdev+bounces-235221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000CAC2DB85
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 19:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AA53A66D2
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF6D31B131;
	Mon,  3 Nov 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKd7buNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6111313E0F
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195522; cv=none; b=Wgq43/q5mIzxL9+f35R+TFPIvKtn3BJeEyu8Aaeohgt51SfZQL7uulFUd9F/91MgOihROz6hTKIQ73WQ+NLFkAGx4RQdIaS2c87znQNyXV5iU0I/tLdyJZAdVvltiOQ58ae2l7vxlEOhim6AbKRuXBD2d8vXtA3b4N9qBAn9KUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195522; c=relaxed/simple;
	bh=prOLPjRhNwhjqEXp1NsT05g66lCbw/24/gxyd8v1xBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTt6gyc+YfFD14IZSsi5Ty0nxozxga62+4waVyhrg9QiyfUS5a80SgkscmUt58I35xM6MXkCnNTqtxdP/MIMkn4y5pWdQTZV+SrsOVYL7ZSK8mS9uGGVTEratUJzXxuKUirklK8acsXCrA9vV2P2RvZk2s1p2aLFvc8S+sPdzn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKd7buNi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429c82bf86bso2241307f8f.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 10:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762195519; x=1762800319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km0NgyANyt85YBiufjQpkK6GzKroUj0XdZqe77+JqE4=;
        b=OKd7buNislQUxDUHo/kNFRl5hXAGvJEalpSBzJpebvOqggvrN52grnflI+m/AE7Ksx
         dgLjVWSSKEusJoI+GAqbzCwScs+wej9NebnkLwtEgVSd97DHvaCZocvsjp5jPnyuOceD
         2y1PX1yvDEcggNexyF5vFPWyxCBgrDrgsf1oB7p/WFqER4r6MWa/SDh1K7rw7eL+C+Bk
         aTcSBcENxEk+VnEoYjrk+mkY3ZeFmXaGUjoWu7nIdJePdP5HBobIpphOKM5BA3dATPbT
         +vHanwuJZQ8oBeVC1udeNGuGZqz85mNKy4Aqx9BSg8kxHOqzb+JCujsPk6CNc1ve+FnP
         fhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762195519; x=1762800319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Km0NgyANyt85YBiufjQpkK6GzKroUj0XdZqe77+JqE4=;
        b=Ojrk17E5ThXrWtViCBQczwm3qI//umm7tDsD49Wurv+M/V1mYdY31Ow+IB6LvhUihQ
         zghetEEcy7z9ZRubXKFLEMuT5qCJ6Uq0iBjW7Gb3rH0n4Q7f6cWl4HGf1YnNnY5MdwAB
         0NaKWsKOh2elNxjg2r1eL2E4G++yfhzQBBAWj/NOLS+LzbuXFL3aiemwd3eaeZf17iDQ
         uhkraAkQ8LQWcM+iNM2YT2GOsz6V8pH7qio/Yf92w0AheOzZcgXvojBZXeXjh4usVS3g
         DMwWYXeCLEUWve8JNf/EE7Ii/+D6m08UEhgokdL+xFaa2mqAkJ1PV9BbBh/xNGV8hT15
         g/Uw==
X-Gm-Message-State: AOJu0YxTEfBRiffHUjIynN183lT24HzUSksk8vOrYeCGkUp136+szlg4
	pD6r2tTXLfZvNbatJRr5FGrCal+jVVHoyU1cNT3X4BHKeTSw2PzwPK74EKXcl0PbiAvIfB534NP
	q3voFl77Sciwab9IehMvJ39ecaxJWi4A=
X-Gm-Gg: ASbGncvoPClcYe9FMpW+W01eXtzWfY5xlx0BbOEbt1elg007rzUUW/62w8UkA8m8t37
	UqtiIoeM6O1EaMqU8FgxZpp4xVZM9uCVC6n1GfkkT10xPvr8BRkeaViMEVeVyF+OnNUhNnkMJ5Q
	y3jcVtbIQ8oSq0nkqFXXgCxODsnYbnAUQW1BPaFMqW9VuUBaVIs8sNRKy25FQstMDXO/Ke6X8nF
	ia5XU8cdwW+nTFflQK40zTmY6JkxSEK3J8LhuPp9jXB4a7s0WIyiGXoZmW77iYdjqpTDSY=
X-Google-Smtp-Source: AGHT+IEvk+zA0geR2qDyjqC3oQlfMJhvVNIV8FOrMfMM4VmOXelHtHvhLNFBLy3zcYrNjal1D7MOu/Ls7XdvvT9zqUc=
X-Received: by 2002:a05:6000:1a8e:b0:425:7e38:a09e with SMTP id
 ffacd0b85a97d-429bd6886e6mr11209655f8f.2.1762195518862; Mon, 03 Nov 2025
 10:45:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
 <176218925451.2759873.6130399808139758934.stgit@ahduyck-xeon-server.home.arpa>
 <aQjrQIl-Yo6G_kGv@shell.armlinux.org.uk>
In-Reply-To: <aQjrQIl-Yo6G_kGv@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 3 Nov 2025 10:44:41 -0800
X-Gm-Features: AWmQ_bkEKPJLSrlwheMdrw28zG-Xjm2W32l5UryeNuK65luhnXgr93wr1XunmCk
Message-ID: <CAKgT0Udv7q-fENNAwGToaVZDiaH1GE9kQhe9HqrPGZnXfFC7bQ@mail.gmail.com>
Subject: Re: [net-next PATCH v2 08/11] fbnic: Cleanup handling for link down
 event statistics
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com, 
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, pabeni@redhat.com, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 9:49=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Nov 03, 2025 at 09:00:54AM -0800, Alexander Duyck wrote:
> > @@ -86,10 +86,10 @@ static int fbnic_stop(struct net_device *netdev)
> >  {
> >       struct fbnic_net *fbn =3D netdev_priv(netdev);
> >
> > +     fbnic_mac_free_irq(fbn->fbd);
> >       phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
> >
> >       fbnic_down(fbn);
> > -     fbnic_mac_free_irq(fbn->fbd);
>
> This change makes no sense to me, and doesn't seem to be described in
> the commit message.

It was mostly about just disabling the IRQ before we tear down the
link in the non-BMC case. Otherwise we run the risk of an interrupt
firing to indicate that the link is down and incrementing the
link_down_event counter when we do an ifconfig down and the link was
intended to be torn down.

