Return-Path: <netdev+bounces-143129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4853B9C139C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FC91C222BC
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03AF1BD9FB;
	Fri,  8 Nov 2024 01:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWcdgiMf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F968F7D
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029230; cv=none; b=N+lbsPC8ZpxcgOUpI/zwuPNItZ1G8NaSr7vSfOHVeZMfmVkFVel6qgpdHxZI4yDgVuDw/Dz5HJqp+j8+bwOontiah73BIN8RNczeJqYq1NCgztqG1Z5H46ktRqOnjF9CdhwMnndGVgsw92cmP4bX/XB0uMGRJz79Nz+yaYx8IMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029230; c=relaxed/simple;
	bh=cHLxfATXd2prsuBhqT/qT5sgUQ+oT6ZUokN91LzlCg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1/x1SrcbxMe212zm+sYU3x5Qxiy4KoFHWRUiD/6C2SWfyOFvtzIKabkeJ3DFkBVuJ0oNfB3pPZUiLVaCsatpm0ICHAeiEdA28p3DNgjVUO6lp3Oj51FiKiz+BE9ByVNEA01HZ8RnP8o2pAKSqvUy5sXQ1755eAD5B86Z83O9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWcdgiMf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720d01caa66so1486332b3a.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 17:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731029228; x=1731634028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHLxfATXd2prsuBhqT/qT5sgUQ+oT6ZUokN91LzlCg8=;
        b=PWcdgiMf/hlgTc7ocovJpUOMvIEU6Ry/SgU2NsSzf3VQ8JFQCLTucibQBcsix6nG9a
         hXvKrbJ9pBiZEPlGVYL1yGd/ZlEQ9/pZxVNz4zLzfpGVAJqXdePEt1DvnaEL8PdKWa9d
         BJeOcHemQ6pbaVEkD0rXq5yTyc/vMI5yWWHTp3fKdVlxa6bHI2zFle31farNhZNB3awk
         2fe94swhdwMkw92t2H2AD1Dg1hgaKSVJfF5Dq89hP4FfuSR65C0MrOXNzRq5ITLi9Yon
         E1orsTHtHgZNuwyZVyTt2LK9Kjxa/ye7WoiPQMryzsrI6um0ZKm24UdXdBgAgeUHnYqh
         95GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731029228; x=1731634028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHLxfATXd2prsuBhqT/qT5sgUQ+oT6ZUokN91LzlCg8=;
        b=TvT4WhK7yFOLhkLgVjQC0ckC3N2gH3u4OjLmxQqTptjfcZ03VuK9zfuDls7B6oMOw5
         gDeYT6KSFIKSMF2gGDR2kX5mLKbv0V7O+JbA7qxf3E3D6rZS+Og6GrGcxBGc1D0Drw0Q
         B5Ob6XPyd7ai5Lsnku7ESqJURZjBRtMP+6VTqTHSQyoJHrmFP376KbhRfta2L0JfqsfI
         x0TRTI3gVY6/NW/drRd1JcfqIVdILVGE2rDaYUXCOMnn/P1MQStd76aNn7WM2LMvC13v
         TpmVK5kIOIFYGyVIOHd/3YzvBaozm9Cs3o7G6vNlqFKwH5VHzRdNcG/iudNIueclchN4
         Zi0A==
X-Forwarded-Encrypted: i=1; AJvYcCWeTS2x3u/858/hh9N/ZSzyWVbTGh6L1FS3mD9clBK7XUvZzV5VK9beamZ+QiH8GAyTgJ99wIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3hN/rnxx2wdyY4H2ucXWl0RDO4FqDS4NJ43rw/XU5uTE3jxl
	1blAps7+yoSNXhXUwMH2ntsWMiz+yOxtbgaHc71ffNIV9BY0W91FE1JSUfrJMocseBGuezVmjIL
	SXuzcKSmjjwtTLeocC2bSSPn8DeA=
X-Google-Smtp-Source: AGHT+IFmeSZK/9FYtWLDwUAJX3B/7HaESykqJT22phQQfKUFfXZPbZhEIXM8DtRyktEbzvYw9RTLB2lyvSmJZs1M0ZA=
X-Received: by 2002:a05:6a00:b4b:b0:71e:77e7:d60 with SMTP id
 d2e1a72fcca58-7241338acbcmr1560177b3a.23.1731029228604; Thu, 07 Nov 2024
 17:27:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEFUPH2npsz4XKna0KYjOeU_MfYN-bVTw25jn6m2dS+f32RuxQ@mail.gmail.com>
 <630f1b99-fcf6-4097-888c-3e982c9ab8d0@lunn.ch> <CAEFUPH20oR-dmaAxvpbYw7ehYDRGoA1kiv5Z+Bkiz7H+0XvZeA@mail.gmail.com>
 <20241029153614.2cdt2kyhn7sb6aqi@skbuf>
In-Reply-To: <20241029153614.2cdt2kyhn7sb6aqi@skbuf>
From: SIMON BABY <simonkbaby@gmail.com>
Date: Thu, 7 Nov 2024 17:26:57 -0800
Message-ID: <CAEFUPH3dBiZqTSawEJCd7JaeRyQU2TBVdBKLXssrXCrpA=S=YA@mail.gmail.com>
Subject: Re: query on VLAN with linux DSA ports
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Team,

Do we have any patch available for linux DSA interface for configuring
QOS in marvel 88E6390 switch hardware?

Regards
Simon


On Tue, Oct 29, 2024 at 8:36=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Thu, Oct 24, 2024 at 08:15:50AM -0700, SIMON BABY wrote:
> > Any advantages of using vlan aware bridges?
>
> Bridges can have more than one lower interface, unlike VLAN (8021q) inter=
faces.
> The lower interfaces of a bridge will forward packets between each other
> according to the destination MAC address (optionally + VLAN ID), which is
> something VLANs don't do.
>
> I don't believe that a bridge with a single lower interface (port), as in
> your example, is exactly "intended use".

