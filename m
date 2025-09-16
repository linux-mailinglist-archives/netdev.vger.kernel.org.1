Return-Path: <netdev+bounces-223594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CB8B59A91
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6903716E637
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A9F31B808;
	Tue, 16 Sep 2025 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7yIZDHE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9C28C84F
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033340; cv=none; b=QUzeky6KLmMOMiZGnULgcbamnEmwDVXpwrh1yvhPxJ4eyhLuswDD/LoQktwFC1Y7V20nfK3TCchbOKW3WhAzvCXfwewhwa3AybWyDXapmhVSajS/AQeTKvBxbvrRypL1cB1byfy/Kw2Bw6c93kPpgWrYJac3Wl0HpaGQ27PlGLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033340; c=relaxed/simple;
	bh=nh+rfaYH23FisXMTZy0AbxT1UHZAIUEFMBVA+YZOxjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUgHza7pF0pSCwZoE5hhiDqB1yF3lIMKWcciz+9rl5B/p0TdV7bU7qIfRuYyiuMQI5iFdFdUI1YllSiwqwQrIql1vocVHP601tBgr/AQ1lrQIuoGRZ0JMYaYl/c21u1LsbmmjMs1giU2YgCEvFWD7soFokqAAM8TuZ+VDhKBspg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7yIZDHE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b9bc2df29so5212795e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758033337; x=1758638137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PiACegxonOL+XxSJ3T2OwCjP6EWjOpVRSkXRaLRkEiE=;
        b=K7yIZDHEJGWv62GRDK5YOYgsHrGyzJiLCHZZfYgSkBEaw9GYpvq6Z+FmqkWkBbqnVE
         qGa7bitw3m0xD2M92QIxLa3uigJKDkr/Q1Pgbotpr9JQe/Tkl267xpwW8MekBO3a8KPC
         Gn49F8bQnN4/qDMY8h9L59j0Q51Ty94fP6dK3cM8/NcyFdl08SZGyCoTGzBKA0siEwsb
         Q9joDVROnPSyrvkWTINqJMkOD60lDgGkyyGszfnlDzUm2TRMWuBArXK2k1jEukAdrjk6
         asT+fDM+ab16UY4lVjry+G0apKfLUGtNuhGdc4pIcb/k1l8gEVnYUu3LlhQ9EAqhtEdI
         WfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758033337; x=1758638137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiACegxonOL+XxSJ3T2OwCjP6EWjOpVRSkXRaLRkEiE=;
        b=nUcKrZvj6wbNOgo83PU5DDGQ8bXmsEr5ph2+PKs/VKidXpVG7SsxXfBMmQ/ZRAJ533
         6wa82lm3gsUl/5sgjXJzkl7wFCSIcs7mbtICB6XnGAsw9QZjnSCPioI8+dZkLGm5Xr6A
         cqRLKU4D3fXjasgvCkY6wvuR35jG9j8yWfFmjjFN2abN97ivxKXwHCEWizFdZ0J+/pVF
         Xli2EI3Zav/1at5ilZEmGlKK3JwzG56sPrCbcsJJLW3JAszybyZK7HPIHFzI0hoBlhXJ
         VoZVJLrtyPx4MhMTae3n2QgTWDdrC/hJkamzuQaJtmylH6HbDSSB4cOGqOngTjMUcdwB
         dpyw==
X-Forwarded-Encrypted: i=1; AJvYcCWuI9jAFYXvE6gZ80dPDk8x5N1a79bjI1oJqQQQP/XMGBkF9+NLjxKZgWrSvjULKCclufe2sjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlEaCieHdWtCiYnDNB4ht42Xb9PhWnzH2igYy5j5TIs0xczag
	NCcqffPtjhRCZANsAFijNQDFM8dMKNWLQ4A4s8JPWEl2byByKT/3+OzV
X-Gm-Gg: ASbGncthGxG5i/lDz+Sdrrr+PlvK1mES0GwLLsk0KOZdjP6si58K0hSIELYupYrPF20
	6BVB1bs0HXcfpPLnASj6619vOkq9edus8yh65E3bs59576GNuEdVz0ip+Iuaa6UeVrE5GXVuG/k
	FA5rjp2pKnJ0VnVQQLq10RWXFCf9tY1DDm1OkfYKfMu8wSUmHpJqBwg+p/pc2vXlo80ZfND4krl
	SgshFeKy+digARqFuMZcfNYcQXyvJCm950dGw/n7siLp/uaMAwIbLt/yJtyEQGV4e9QuaEF8VQf
	tSNeePd/vQU3BSw1J6scRqlviDmWMfCYiOzSkQ/35TIu4S9smjXaOAyQvJr0xHt0gQZg9SeylIZ
	n9DWV66OJuLfaZDs=
X-Google-Smtp-Source: AGHT+IEDQ9H77WIyx0CUbsnB6V/0is5YXI2rXFKa/FK49p3xCH+rakNhgdjzq4WG/+gUAsD4xFaFlg==
X-Received: by 2002:a05:600c:5492:b0:45d:d39b:53e4 with SMTP id 5b1f17b1804b1-45f29356ca0mr49567505e9.8.1758033336406;
        Tue, 16 Sep 2025 07:35:36 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:2310:283e:a4d5:639c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325a32f6sm18441425e9.2.2025.09.16.07.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:35:35 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:35:33 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 1/5] net: dsa: mv88e6xxx: rename TAI definitions
 according to core
Message-ID: <20250916143533.3jqqlpyp62gjwhh7@skbuf>
References: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
 <E1uy8uN-00000005cF5-24Vd@rmk-PC.armlinux.org.uk>
 <20250916084645.gy3zdejdsl54xoet@skbuf>
 <aMlnwFGS-uBbBzRF@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMlnwFGS-uBbBzRF@shell.armlinux.org.uk>

On Tue, Sep 16, 2025 at 02:36:00PM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 16, 2025 at 11:46:45AM +0300, Vladimir Oltean wrote:
> > On Mon, Sep 15, 2025 at 02:06:15PM +0100, Russell King (Oracle) wrote:
> > >  /* Offset 0x09: Event Status */
> > > -#define MV88E6XXX_TAI_EVENT_STATUS		0x09
> > > -#define MV88E6XXX_TAI_EVENT_STATUS_ERROR	0x0200
> > > -#define MV88E6XXX_TAI_EVENT_STATUS_VALID	0x0100
> > > -#define MV88E6XXX_TAI_EVENT_STATUS_CTR_MASK	0x00ff
> > > -
> > >  /* Offset 0x0A/0x0B: Event Time */
> > 
> > Was it intentional to keep the comment for a register with removed
> > definitions, and this placement for it? It looks like this (confusing
> > to me):
> > 
> > /* Offset 0x09: Event Status */
> > /* Offset 0x0A/0x0B: Event Time */
> > #define MV88E6352_TAI_EVENT_STATUS		0x09
> 
> Yes, totally intentional.
> 
> All three registers are read by the code - as a single block, rather
> than individually. While the definitions for the event time are not
> referenced, I wanted to keep their comment, and that seemed to be
> the most logical way.

What I don't find so logical is that the bit fields of MV88E6352_TAI_EVENT_STATUS
follow a comment which refers to "Event Time".

Do we read the registers in a single mv88e6xxx_tai_read() call because
the hardware requires us, or because of convenience? For writes, we
write only a single u16 corresponding to the Event Status, so I suspect
they are not completely indivisible, but I don't have documentation to
confirm.

This is more of what I was expecting.

/* Offset 0x09: Event Status */
#define MV88E6352_TAI_EVENT_STATUS		0x09
#define MV88E6352_TAI_EVENT_STATUS_CAP_TRIG	0x4000
#define MV88E6352_TAI_EVENT_STATUS_ERROR	0x0200
#define MV88E6352_TAI_EVENT_STATUS_VALID	0x0100
#define MV88E6352_TAI_EVENT_STATUS_CTR_MASK	0x00ff
/* Offset 0x0A/0x0B: Event Time Lo/Hi. Always read together with Event Status */

Anyway, this is not so important.

