Return-Path: <netdev+bounces-190629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE853AB7E77
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 09:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0213B754E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 07:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764B194A44;
	Thu, 15 May 2025 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDXeYj5G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ADA1C36;
	Thu, 15 May 2025 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747292536; cv=none; b=ItBVcd+9lLpKDZCFh4CY3dC+PWr0FT/Y5VsvQTSZz/iRscqL6CBOHK2zszg4DNQtWO31C9jNU13pTYmE5n+IfeepA2hat883TEuOCToOIGMfZTuD+cFIZeJF+exJomCG8NddMooZmw2c0tjafV5uHUBfcBiuI0PFcfpghzDqS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747292536; c=relaxed/simple;
	bh=jscU0ocsacVXZvYxqXAwNblzhf6Di0ig1Ic+fxc21mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AE5MzdIrpZ91urHyOjz5MODdCa331OFDboDiaKhh5av/DtGbMWxIIKhkUZWDY/QgNPKjyGrFFnt8r7KVxk+LumQPfe1c66keLrzf4jpvWMvh0Yov07pumGJeJ9ftezCJFFxpLam/0iYbph5rSMDjbIe8oS8NK8e9DBj8eKX8pcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDXeYj5G; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70a32708b4eso4209647b3.3;
        Thu, 15 May 2025 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747292533; x=1747897333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev23EJpUhfpuaTDvzV5dAzqSiBl4iuITpugYgy4/wT0=;
        b=SDXeYj5G2rgvBA9Rj2xBZhT/Cft3gfGhuJj32/2+/AleQArddwO/05jF9f94MGMWbC
         VzCU3vIGFY6bmZOS0m7QGwntP26KlE+xB6Kq4eeriVVcSw1Q3aS9VapACLE7q60SvbmX
         GReo4tRwv1Bw/MK/rY7GX/xODnFnHocMep48V0roqI0fyqYap3fGlZPuK8NeIcOsWTl7
         7pbeRYUe6zUXZ3VLkdbfkYoGEEp8kTWUaRHJ4SNioZ/PSGO6Xb6AI07vUhemnp931Rgm
         Z6Eu0bJAsdBcnf/3JWhJWlbRoOgBm0kEnRTXsa0IUiN/IdOYxt9aCA9J+PwIbZNovjtn
         GdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747292533; x=1747897333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ev23EJpUhfpuaTDvzV5dAzqSiBl4iuITpugYgy4/wT0=;
        b=jOXz0TI6qyI04nMuNs7RgQBGKgAzVeJQEhxJXg0uGmjcMmPZf7uvHEW7dBZlXngjU+
         efrFTqPcmFK0L5Pw5TOV5WCDlrMqVXWkq02tEerBytw8VUlnCvMdXTo5QRsGXl7UAYkC
         G88qkaQNxKq2Wr2wodFrkgFOW/1uWzhFgAm7Gr5RCEy+3swVjmpwwoXIY+HIgv0Tw4ex
         GlJKCNSJoB2OWJAIahzb/x7AlDEwYV0ysEWdKOmOfmXexoNpz6e91O3wUlmU+NaclX3x
         EeRqRGrvFa7PKDQzjjrEEfFAEjyfzA142CmLlCtAvk4MlKzrlQuGI9Lt51gwws952bma
         aH5w==
X-Forwarded-Encrypted: i=1; AJvYcCVst3UUsjdc7dIWEbdfak9Cm/9khlOzd666o3o1wCUTYB4dhoQchompC9Mk2GWZmYmB2Qz4DcT8xOHedjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOhIX8aGhM0w6c46du5NPBgZA/9RMZzCPe35Ev9Qg9Z7mMuzd2
	f8M0IeDyFKA2iWXg5iWSebhZ4LYaKH7yRAGJ+OVTz0Y3hgu6ffhdK1X6snjp1EZAgVUdAb5s30n
	8iTcGF1o0AmPNcLPhqEYrT8ERNhM=
X-Gm-Gg: ASbGncuC9DGoNOjMY6dNyaFRWXo6YC02AKTdQcazKDU4jJXWscYUZJ8L8IXs8egpDmS
	76R1ZwmRHM+YmtG6EcvYTz3tCImiFAbhX7vGxqoasnbYhCrbk29Q4UHw9slR5h5hsGKrkCVqW53
	SQUBPM2OZw1MuenOM18I0XS+nQ8DRj2zj9
X-Google-Smtp-Source: AGHT+IGlJBExoNVm21b9koa1j40kjuKuqyYlVovJnnJ3hJaaoqYhDVpnG4Dg8bMA9y15TzfUwk/MD13Ttqh9gX+VPb0=
X-Received: by 2002:a05:690c:6a03:b0:705:5fde:1b82 with SMTP id
 00721157ae682-70c7f13926bmr88913207b3.13.1747292533304; Thu, 15 May 2025
 00:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512191901.73823-1-stefano.radaelli21@gmail.com>
 <20250514173511.158088-1-stefano.radaelli21@gmail.com> <4c64695a-fb98-4b77-a886-3a056e6b229f@lunn.ch>
 <CAK+owoid1woDTiCxcGiEmdvKNHJeCnaKBjPEHyNrtHt_hKqi9g@mail.gmail.com> <d994cff7-e960-41fa-9ce6-c35cee3a2560@lunn.ch>
In-Reply-To: <d994cff7-e960-41fa-9ce6-c35cee3a2560@lunn.ch>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Thu, 15 May 2025 09:02:02 +0200
X-Gm-Features: AX0GCFtQ7P4HXzqzRxxk8WpC7jmRWlKvw0O7riLjCvHMabLK1laFi4IR6lK37b0
Message-ID: <CAK+owojR_pRpZKJcyd-QgOBNCQo2XiVs7J7GWzEH98T_poWANw@mail.gmail.com>
Subject: Re: [PATCH v2] net: phy: mxl-8611: add support for MaxLinear
 MxL86110/MxL86111 PHY
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Xu Liang <lxu@maxlinear.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Yes, I can confirm that the MXL86110 only supports copper (10/100/1000BASE-=
T)
over RGMII, and does not include any dual media or fiber logic.
That definitely simplifies things.

I'll go ahead and work on a revised version of the driver that supports onl=
y
the MXL86110 for now, addressing the issues you pointed out. The MXL86111
support can then be reworked and submitted separately once it's
cleaned up properly.

I=E2=80=99ll start a new thread with the updated patchset for the MXL86110
driver once it's ready.

Thanks again for your patience,
Stefano

Il giorno gio 15 mag 2025 alle ore 01:56 Andrew Lunn <andrew@lunn.ch>
ha scritto:
>
> On Thu, May 15, 2025 at 12:29:48AM +0200, Stefano Radaelli wrote:
> > Hi Andrew,
> >
> > Thanks again for your detailed review and suggestions,
> > I really appreciate the time you took to go through the patch.
> >
> > After reviewing your feedback, I realized that most of the more complex=
 issues
> > are specific to the MXL86111. The MXL86110 side, on the other hand, see=
ms much
> > closer to being ready once I address the points you raised.
>
> I did not look too close. Does the MXL86110 not have this dual
> Copper/Fibre setup? Removing that will make the driver a lot
> simpler. So yes, submitting a simpler, more restricted driver is fine.
>
>         Andrew

