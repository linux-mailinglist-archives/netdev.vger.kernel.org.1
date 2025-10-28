Return-Path: <netdev+bounces-233571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E571C159F1
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9091C22BB4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B577327991E;
	Tue, 28 Oct 2025 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZd8z5EU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2102B23FC4C
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666506; cv=none; b=kMOEkn/6FM2m6nZSB2KaPQKdIl80WLxurd7OGj4QK5XLzg5MDXNsJ9jn+mXnEq4X4cyHUU5ok46vPgGRDAF4lWuFaMNcRYtfTEYDLSYRE2jR/Omtw1s0vDAwxjXHI/c3ykryArBWevWV52fx6KvS9ARTHdeRH4+N8jmCkt71A/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666506; c=relaxed/simple;
	bh=2bOY6gnUwb4nFCgw2yqY+36HofjZmkIDlMsu7BOd0iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maY/5EPH6Y5yUe1oJGDS2Evc79MQiONYEqn/EAPll2FOZSOQkn6jbOOPLF2hHYGacBj85EAa/PQXaxFOYEUs3hbhg4L2t8Xm4aKPZVuCH7XJck/SDrUeVlqpyAqVf74PUp/EZLR9adaCTm8hH46NeAVDnQPLlcprjBTXD3TTUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZd8z5EU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475dab5a5acso22269905e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761666503; x=1762271303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upZIuMB9ObsKnLxIeEEbncHV6JDOCPeXZREqtGp1TxQ=;
        b=PZd8z5EUOqmps3EyqEBGE2slhNnuO3Lqs7gjlQLBxam+BW4RXYObosvcNB1la7Jsgc
         KswyupMLzAALk+PD4uJNDFPSRiYpo9vH0mz9uK/JtIbJCXzPqoqLbvPr3CCrHC/46/TS
         rcy0q7lrG9XTYzZlIfSu2VjQjSrE/Pyz8KyhHa/W/XtIwvl3iGbweHGmfIpsMfYA07AX
         OVOXMEI5U+Sbk+pJ9iwu2G7Im2IXOJvwYrOznFgHAjKuyCHJORiN9OYVQlYCEUYt9q3Y
         sEb5YkE06S1OELw+L1TGenhXNnj780VYVMZNyQfBvKwjdDpE5+qxzPJBnv3289Y473AK
         jMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666503; x=1762271303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upZIuMB9ObsKnLxIeEEbncHV6JDOCPeXZREqtGp1TxQ=;
        b=Fbcs2Hi3Of+PKPoYlq8YKwW/bidnLShhy1Xn0yI+j7sj4ixA4J9h0M/01Evy5MQbR1
         8CVN58BF809h/4SnLBNt5FjY6yXnEMvNjeP4iP57txp2vNSmJIXYAuNJM0tef8o3ejKK
         2s1caFDWpgXKXuxjuCue11koHCtieFKWznGSlx0XSj9qTewpI5AcrZi0v4zSKG19q7Sl
         f3rlPfJycM2/R8bruJOTP1TMlyjf5JPj347IYUVkB0j2MqT9E1N4KHJI5COMuZewt4Rj
         c0FFpG8nQunlqdtz1ZAPKZ69lRNjF9I8p+gyWMm0w3qUcw8HamiTxTMIq/Gihcu5aaAe
         9QEA==
X-Gm-Message-State: AOJu0YxCAoJodqz4Xd2RAzZ3a4aDwiS34JoznEwXMBbIvjzYcyRO8W5L
	GzvSAeBARbB2RgFjlXXlSybaT/x07gA2024jY9ckfS6Vkt9ztMsY+Sllj574zYrEZIV+sLLJSmP
	divtLM1emP7d4BkPp0Fst3Wn3qAIynpw=
X-Gm-Gg: ASbGncu1MFlU9Q7O8hphDKZpgfk5sb/gRFCDbHsSOr1DtMZVUffHmPqUm4HY7dv8jjr
	foJJw1FFuc+WJGIuC3HnSJGy3Vt9iTm324jGbC0H8nSRHodwW+pNp1QmFIDG08gMzBJXY1pHvc7
	/ZBs90sn4ytUP8CKWlFnjsr4GX+eSubzapwiTxUeOaPOISCl7xqWp08/zin6FKnChaqnIvHUY9+
	Fezj39e1R6pBkPOIbyg4kStyg9kmCDcm0qkinUyaMcKWcAfOgrpDD4bjEIpKqj5JWA7+TT9KanC
	FR72MmwKFBwADIm27A==
X-Google-Smtp-Source: AGHT+IF789c3V0PqzWIYueqeJM5wXvGmj4WgXd+sc7NbTJncHGH4wM2ozJi5DdEb6LUDxgd5G6mnjH6E1dCesSbigSY=
X-Received: by 2002:a05:6000:2f85:b0:427:490:68d2 with SMTP id
 ffacd0b85a97d-429a7e4af41mr3536115f8f.10.1761666503370; Tue, 28 Oct 2025
 08:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
 <176133844020.2245037.14851736632255812541.stgit@ahduyck-xeon-server.home.arpa>
 <691b8687-65ec-44c0-8c19-c3bd8bb6ed2b@lunn.ch>
In-Reply-To: <691b8687-65ec-44c0-8c19-c3bd8bb6ed2b@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 28 Oct 2025 08:47:47 -0700
X-Gm-Features: AWmQ_blwrUH1fDQ6eFM1-B7FkdxRHWtYLldi7s9tfca0c2hnl2_7KxuiuyWeCA8
Message-ID: <CAKgT0UcORiTryUFGiz7mb6j-WK_cXOWW=v+ktQxMoBjfBjoCVw@mail.gmail.com>
Subject: Re: [net-next PATCH 1/8] net: phy: Add support for 25, 50 and 100Gbps
 PMA to genphy_c45_read_pma
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com, 
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:12=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> >  #define MDIO_PMA_SPEED_2B            0x0002  /* 2BASE-TL capable */
> >  #define MDIO_PMA_SPEED_10P           0x0004  /* 10PASS-TS capable */
> > +#define MDIO_PMA_SPEED_50G           0x0800  /* 50G capable */
>
> This is 45.2.1.4 PMA/PMD speed ability (Register 1.4) ??
>
> 50G is bit 3. So is 0x0800 correct? I think it should be 0x0008.
>
>     Andrew

Yeah, looks like it was a copy/paste error as that was the correct
value for 25G.

