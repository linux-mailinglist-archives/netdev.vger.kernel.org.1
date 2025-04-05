Return-Path: <netdev+bounces-179437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BEAA7CA30
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 18:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DE4188D318
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F92129A78;
	Sat,  5 Apr 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPJe7cpo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7A72C9D
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743870015; cv=none; b=HBgy6zbB9Xn6LCib6NZCmppG4wCgLz8kCBwD9cUIyKnLuaW0qWC6EhGN81zVhbNiDdU4Ky72VUJ92/fXMaeqClI6gGTCny+/M6H3zZhx00/R9I7k8JlSl7LNvhhQyWTWfVgY8S6NWIrk/U6OGshn9yGNTBFWlX4pd/yVsBxaqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743870015; c=relaxed/simple;
	bh=cRIEfvxI5iFciyvZxPkxDZ6iwnsnypyizthtb5z7HzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/bXTWCY4Lquet8nLAdrpt3hBhU+r9RVXTWQBhNMpmVhtrVII/KUSPE5+/CqA/ffyJsG7sychj7sC8ULE1F2IgiNCbG8E/NCqy9A2MhU00HovGTRDT00dl67Q/iDeL/m2WpJFu5gWyDi3/s5fUrqdxpp1CLgOlLHMnajQo+UXkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPJe7cpo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfe574976so20294855e9.1
        for <netdev@vger.kernel.org>; Sat, 05 Apr 2025 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743870012; x=1744474812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L6UpCjkaeu+d3RUnNMasIAmhv9TOpDLRlGRsHZLc58=;
        b=bPJe7cpo3ChQQ1DUT9pqPkDa8PqMEaUJhzdsMXCuHtudD5bf9qUFHe6IldLggdSLbE
         qktQNvgT5sXsrs8jed6e8ADR+6Hkem5CX2ZmuImElzbLDF3drbp8urltebdJqFqavNdW
         8vPVXsW0/gPCkCLOV7h2u+3wP71Ftc/9V6dH+C8ILWAYwaCyNRr8XhcG7EfivQnbC2Xg
         LGWoDg/+inQP7IBcipPpyW8V1qUo1bhmyXvKS1LHnoUKgkcX+yWhhhOouLuWCVoj/Va3
         7+i9BafDulq371eTjdB5lYuzsbBfrCybwDWXi3ReefQm6jDNjWay9/Nbfn2+OjZ8Fg2F
         Arig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743870012; x=1744474812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/L6UpCjkaeu+d3RUnNMasIAmhv9TOpDLRlGRsHZLc58=;
        b=SbLDiok0CAv9UTOuZq55if4azHQCZRKBSUk1J3NQOLrAxpPiHCYPq7awGuBEMQR/kH
         t4qTcb3yk+ZMV4j5rS4VA9gY+QBIM/cYGeUOm6VR8bwK/vyH4l9Z7CyHppy7JFKOLTnL
         OlW8LAvacLxJ68p9Q+pMbrrPwUFyB086Ywq6z0ubKdeeF0glurY7tX4cdgHvaJiLHXRU
         QYiAEYJgZQnuaX82bzkON3ZMRhmdUpIZkBM8YkuVWsYJXkaLdbWdXnE/uw1zbuj5OCKH
         AVkAxGD7z4Orz8o4c8xDGSJ8gpbod5A2UBx4cJC2bgFdvUgF5W9uCzBkyvuEru2Q6egq
         MACw==
X-Forwarded-Encrypted: i=1; AJvYcCX8PgBSFpGbM2Hsp3v6Se+vkzpFVgO/HLdw9OQO4fOppnfA4nAgtbkIREbSq8AQ7H+qHUc4PZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9sRTfT9adkJyxwRBePTAxan68P3Y4ODE437da/DylYbbDLMnc
	aiOsGz5Ar3sigBmgXCDYVPcVgN5XEcYkkWjNTHIkUUYzKcXHKW8LZ01u9LY2uEbcqIqJgV5j+Pn
	gltMpEYDJzrx+31G3TYkE+SDzz6VH/w==
X-Gm-Gg: ASbGnct0VFrMuI6Gmp810fKfoVnEFq6Y635+WNTXORtrWOiSdM/wDjnU+vslLWupV6m
	rlUs4xACswDJmsh1ceDNinpPO4IikVCw+DhHquPw7T2Vy5CeHfBeDPcJQf0U081vX1z3ayiyoq/
	NOzYsOqpThRRR1yp7n56mvICaGDGtfOmJgv0Rcs3TfD0y8fMKFePG+wR6VMCw=
X-Google-Smtp-Source: AGHT+IGTqHQrJLTpqESIXUaOBUTTerSlJjTJf/O9duS9HvneuFL83jrQf45F6o7EtKFvIY2d2d3oWKRAPMhRV4VNPDY=
X-Received: by 2002:a05:600c:3ecb:b0:43d:7588:66a5 with SMTP id
 5b1f17b1804b1-43ecfa06563mr72204745e9.31.1743870012028; Sat, 05 Apr 2025
 09:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk> <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch> <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
 <Z-8XZiNHDoEawqww@shell.armlinux.org.uk> <CAKgT0UepS3X-+yiXcMhAC-F87Zcd74W2-2RDzLEBZpL3ceGNUw@mail.gmail.com>
 <Z_DzhKiMkjFVNMMY@shell.armlinux.org.uk> <2f09e79a-fbc3-439d-bd51-13b50f04395a@lunn.ch>
In-Reply-To: <2f09e79a-fbc3-439d-bd51-13b50f04395a@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 5 Apr 2025 09:19:35 -0700
X-Gm-Features: ATxdqUFS4dbzCefKbJmZEOZq4wOqLW5S1gBLxvtZAqqHUX0u0Ykq8EG2Q5jPDgM
Message-ID: <CAKgT0UdmwJVQ8u8OXD3ttJ8rRY6QDRRfWoCd3Vku9fFFGj_BXA@mail.gmail.com>
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to phy_lookup_setting
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
	hkallweit1@gmail.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 8:52=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Hmm, I'm guessing 50G is defined in 802.3 after the 2018 edition (which
> > is the latest I have at the moment.)

If you don't want the full document I think the 50G stuff is 802.3cd
as I recall. I will try to get to your replies later today. Will need
some time to read and process them.

> I have 2022 edition to hand. Clause 131 is Introduction to 50 GB/s
> networks. Clause 132 is the RS sublayer. Clause 133 is the PCS. Clause
> 134 RS-FEC, etc.
>
> IEEE makes 802.3 free to download, along with all the other 802
> standard, although it always takes me a while to find where to
> download it from.
>
>         Andrew

If you have access to the 2022 edition figure 135-2 is a good diagram
showing essentially what I am working with. Essentially everything
below the AUI would be the SFP. Our MAC essentially just does 50GMII
or CGMII and coming out the bottom is one or two lanes w/ NRZ or PAM4
depending on the PCS/PMA configuration. The LAUI-2 portion is only a
partial fit in that what we have is more 2 lanes of 25G than LAUI-2,
but I am having to overlap that with the 25G/50G consortium
implementation and they do match in the 50G non-FEC case.

