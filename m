Return-Path: <netdev+bounces-69010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 995F184920D
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 01:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251FE1F21C45
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 00:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F964800;
	Mon,  5 Feb 2024 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j/PZI/Ht"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E465C
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707093365; cv=none; b=CFH2mz2x+drQnF1LFWC182VQWS5QH8AedyEefrjXpMRNcxhZEZjY2ZT/LjKJBJ1d/JU/TrNGyVkyr89PDzoTAh1P3zaIkVISqEI0RXWapzwJC0P6hK0TlTbSsQEIZtpi6sS1/hDSFULaiGdPzJxVdTyjWuApBkVhQ+eLkhz8300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707093365; c=relaxed/simple;
	bh=m69DGvIzuKUVjW3O1QFMxwepscTybDO2RxRMOFDP7GA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MO1Usx0pO1v6K9ftQ/L8f6iz0nw6NRo9Z2Dgjmj5caZvOR3UYFQKbar47YbCb0oP8qkmBNTJlZ3C5Nt2bgZqpqeLfbuVBjJ6bB9MtL6rtpdu25m+w7MqyH7UnzFcRTmYz8pUxGqzpAm1lYD8LEevEDpmBzdP6RFiJAvIfg+SmOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=j/PZI/Ht; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so33937715e9.1
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 16:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707093362; x=1707698162; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuk5rPRODqBdHzneVF/fVUHfeNieIovnQ/lNIrR8ro4=;
        b=j/PZI/Htz7P1x4ijBvj5nHhBE3Kl8mzMBOWKYeLs3BZz7m4B+BsRoD3rzfZgklY7Rp
         01ee155x42730LMCfWG+DjdcXVbr1y0V5ehMhyJKjSbzqsDH1x2pzbJPK1kppptH+Jog
         NkFg0dBrwehY+6VV4ago31WAjwnp6j8WuztDQmgUm9PM+WRGFavszj4VCTw3R2ay0vQ2
         Ku8UPi2v8ra6zgJhuHfaPQt7viMEiFUe94z2880xUkZAVLMZWUBVmx1GKR19TniJW+02
         /8/C0YbOXM1SOw4wQxhUk/Mz3kUGIKMRpcG6G2bpNFlgTHIqbI+lwB4VeYukdknDc7ne
         InLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707093362; x=1707698162;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuk5rPRODqBdHzneVF/fVUHfeNieIovnQ/lNIrR8ro4=;
        b=GPa0RJrB2fH3HjnqO8blUJmBUCg2z8YVkz2dkqmIXtJy4Si/JBABj3wpIX5xj1fCvh
         4iwCwIOwxGortPucgKkH+hw684+4JmV9iEJZXH+WldH9RiVPkyAat4ctGFzfXFh9LWUC
         faEamQRZq6MqeEsUR+YKouav8d710kMjbTGLTECY2p6K9LptbORkDAxdo70Ln1rt9jan
         EIPNBEU01FU+t/v6Tt/cO+5mO+G9n/D3/9JvpfGl9b2jw66g4kLfUJI45frExlcqWVnG
         T7+dQ1gSWXtER86UWIwmv5zqN73vD1WU9vMTAS8gYePZFw08a3XuB2KkL6SK/fz5RCrN
         4zKQ==
X-Gm-Message-State: AOJu0YzHsRgnTkqM6HyPjPfaZvuRPUv1e4iLx4LMF4pmHzkYj6auRTGF
	KOBKyWKlHKsLks8ilwa+kR0IBfIwCzNFHgr9x37hILIAQPYCkAno
X-Google-Smtp-Source: AGHT+IH9X4s7p0+kYhJiCcE+tFtELn2VmAQobbLW8gI5L1+HtbFU56PNMwYIc7iWhoArLh+OgY5WPA==
X-Received: by 2002:a05:600c:3d9b:b0:40e:f5d0:8517 with SMTP id bi27-20020a05600c3d9b00b0040ef5d08517mr3481943wmb.33.1707093361826;
        Sun, 04 Feb 2024 16:36:01 -0800 (PST)
Received: from mars-2.fritz.box ([2a02:8071:7130:82c0:da34:bd1d:ae27:5be6])
        by smtp.gmail.com with ESMTPSA id fa10-20020a05600c518a00b0040fd0b29255sm5720277wmb.13.2024.02.04.16.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 16:36:01 -0800 (PST)
Message-ID: <b7c66e3ea1a87e4dc0edb2df15e29f43fa5bf723.camel@googlemail.com>
Subject: Re: qca_spi: SPI_REG_SIGNATURE sometimes not recognized
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Stefan Wahren <wahrenst@gmx.net>
Cc: netdev <netdev@vger.kernel.org>
Date: Mon, 05 Feb 2024 01:36:00 +0100
In-Reply-To: <e6c64849-ded6-49e0-aa15-283346b185e4@gmx.net>
References: <75ea348da98cf329099b0abf1ef383cd63c70c40.camel@googlemail.com>
	 <e6c64849-ded6-49e0-aa15-283346b185e4@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> >   working on a board with QCA7005, on probe() SPI_REG_SIGNATURE
> > sometimes fails (~1 out of 5 times) to be recognized correctly, even
> > after multiple reads and retries.

> at the time of writing the driver, i assumed the QCA7000 is always
> powered up (takes ~ 1 second) during probe of the driver and the driver
> could do the signature check during probe. But this doesn't work in all
> cases. So qca_spi driver has the module parameter qcaspi_pluggable,
> which is disabled per default. If you enable this, this will skip the
> signature check during probe and let the spi thread handle the
> synchronization.
>=20
> Does this fix your problem?

Yes, thanks - this seems to fix the probe issue.

> Regardless of the results, i think qcaspi_pluggable should be enabled
> per default.

I think so too. Because the current default (off) is only appropriate
when the chip already gets powered up long before probing. This seems
unusual and at the same time understandable because the driver lacks
regulator and gpio-reset handling.

What about removing qcaspi_pluggable completely while adding a warning
when QCASPI_SYNC_UNKNOWN hits way too many times?

Thanks
  -- Christoph


