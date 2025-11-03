Return-Path: <netdev+bounces-235222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656DC2DBF4
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 19:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B94554F3EFF
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E49322A2E;
	Mon,  3 Nov 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR3T7UHe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2995231B131
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195809; cv=none; b=sZByMzaWp63xNKNXTHc74iXzidcFKnZdKaH5HhGCD9KDCbGhy6IdZAAyiYKs9+95xd7z90HUAiplP5LdDZ6NFsCfc2ZkwflxLYE+bl/soaoGT3TgA4HUhsbvTpMit79B08EuwGRTmA552YLuHc7ZKZ9IBuQsUrnJz15RokFmrxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195809; c=relaxed/simple;
	bh=bN9yMqTL1Fe4OvFd39XvzI2XY34sgsHQ+vwdW95Uokk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+8/6qzbJs8mot4a7fPn4deGLNgrYrZ7rfGr8NxDnpMiXa/x5JMKlnM92m25OErW4qpAzGDxg3jNcCaaaIlXInWBjcNgQeCmDYYQDICWB3OOFVaZ/OKl7VC+S2GLE1kpTcRXamLpFcaghO7Csmo1JHcsZzh3K6vjfAEW9+3P7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR3T7UHe; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee130237a8so2903542f8f.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 10:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762195805; x=1762800605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pWbkEdJQeYlYJyqjrJzg7dOusXBw8JuymL7oG3IAY8=;
        b=hR3T7UHeqmGIEypVBjVX0WHQ56otQXnJZRqUnHT25AXhxb8fm2gc/QWRtV2K1vXeey
         hP1nXx7u3uQv2qVPDN19QtbV+ZzSYVWP+PqO9MX/jvp/LG/2iRQoZZ3FOQ+A6xVek12Z
         K/Icpqtim8dEfbkasKOk4ll71hc0DuUV2me6p7TdHOYl9yyg70VxbBI6O1a1YfkOci/U
         FNfySqlfyQrfS6X8g227rSgTEPV/59GeewHTDZymaDFYFVoRsEieMOYmkHgLRzX4JFe2
         N0k9gNoLaQVjszwcqAK1XxmGSdUqWfMdsqi4RBDmOtqtGuz3lo19NiINEoWg/D7iIp6U
         ValQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762195805; x=1762800605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pWbkEdJQeYlYJyqjrJzg7dOusXBw8JuymL7oG3IAY8=;
        b=oTm+4ahNV9KfPNwMsU2uNBqBeGvjhuRuSQXu6xHIbk8X1C1J4Y5G5S2xmef1Jt9lO5
         kjLdBsLc/iRfgkIjWxS7DpRjPmmwKK/rF6EVTraA0DtPZ1PcnxQgW8TR6y67xmwoFQjS
         XuLHJXStf7ftpKFJ01EmeanHoz/YwJDx9KQlp3LC+lLqo+sJR3JuoNO3gbgRwg7NQ3hh
         e9J/PBH5iiwcygm3ZAbd5XpqXN6fCJCPqXX5SZuBR/nkL5/oMK/zFnX1JJWw2wDph1zO
         riETxBrjdz3wFa1KUlVw7MNjDB0Ew0GWCgmbSTzKFUXqoheaOhINbP6NRFXIfqC163vb
         ykmQ==
X-Gm-Message-State: AOJu0YxnPoE2xadELSg6wSNchagaAHWB1FUcRXUOn0AiPK+0KisGvOSI
	EtkgYr1/nFEsOjER5weG5HveBXBb+1DWyg8gQ+G01G2eBpZyBRXifOd9lZIDKfP9N2pEmi0Pjyc
	VSejXsLf/Q2juUeP55xt7B33J/oEj4aY=
X-Gm-Gg: ASbGncvL2OkMdCymRzdGoyCWGvMUgb+a8ARrYKYccuXBB29NwwgOj8bltVQC3JwaHsN
	RNKMrusXZAX/+VVTYtidi6JN5I8OrbQGiX7pa1a0BGQn3Dc7GWeW58owFN9LSziVHt4hyQs9ENn
	/Zx3YMPWczPNM+7Ehicakzz6deiGJWddwo23UPXvOObzpa4PDhQQMw8Gnc6iY3wrG2dOKsBiY0+
	aCZCSaBI6Nqwhw0zplMNb9TNmsJhzTxRvuGZDctU7CjjE95fZ5N7Dp8XnbqhCQ84seQdOAJaXUB
	n+BQWAdeO1qcp2+haDl/D0u9W8FU
X-Google-Smtp-Source: AGHT+IF7WpJOyolMieXE10v4BLK1fU24xdvvTZ43+8DbaR/kVeqBYxBTyEVgsIEwq3kBXS+Dr0bzk2FrfrZYBUXM9+s=
X-Received: by 2002:a05:6000:258a:b0:429:ce0c:e661 with SMTP id
 ffacd0b85a97d-429ce0ce71amr5866429f8f.54.1762195805220; Mon, 03 Nov 2025
 10:50:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
 <176218924103.2759873.8687328716983200406.stgit@ahduyck-xeon-server.home.arpa>
 <aQjqzVL6SYKeg5uI@shell.armlinux.org.uk>
In-Reply-To: <aQjqzVL6SYKeg5uI@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 3 Nov 2025 10:49:28 -0800
X-Gm-Features: AWmQ_bnyHTpbEBi4pB8OHBoiKuWP7Ol2dEtuwo-WDLLDh4obpUC1TmA-AHosLXU
Message-ID: <CAKgT0Uf+ykSS3ZHLrDrUB2RFpV9f3BXsFC7JFRXYqsB7ZuLEUA@mail.gmail.com>
Subject: Re: [net-next PATCH v2 06/11] fbnic: Rename PCS IRQ to MAC IRQ as it
 is actually a MAC interrupt
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com, 
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, pabeni@redhat.com, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 9:48=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Nov 03, 2025 at 09:00:41AM -0800, Alexander Duyck wrote:
> > @@ -131,26 +131,26 @@ static irqreturn_t fbnic_pcs_msix_intr(int __alwa=
ys_unused irq, void *data)
> >
> >       fbn =3D netdev_priv(fbd->netdev);
> >
> > -     phylink_pcs_change(&fbn->phylink_pcs, false);
> > +     phylink_mac_change(fbn->phylink, false);
>
> Please don't. phylink_mac_change() is the older version from before
> phylink ended up with split PCS support. Some drivers still use it
> (because I haven't got around to sorting those out - I've got the
> mess formerly known as stmmac that I'm dealing with.)
>
> It only makes sense to tell phylink about a change in status if there
> is a PCS, because that's the only way phylink can be told of updated
> status.

Okay. I will update that. But FYI this is just a transient change as
these all get replaced with calls to phy_mac_interrupt when we add the
phydev to deal with the PMD link state tracking.

