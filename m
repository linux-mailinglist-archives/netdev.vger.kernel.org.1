Return-Path: <netdev+bounces-151446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC2C9EF215
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEC928CA53
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412C723ED77;
	Thu, 12 Dec 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4s45MbO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B4923ED48
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021368; cv=none; b=J5QUW7jgdzDSm8YLHePPmBGkJAaMhfYZbyziMRxORM3q0RLt/4f2dxLKE7VIYo2nmBMAQaSHHQxWdzEOOadEdmRF7mBSaKdkahug6X2Jaea8cLojxvReMYT553sO4Xuek8I3wMAYszHQnR2UJKz5oo4yunCGS90RhGmt1rpuIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021368; c=relaxed/simple;
	bh=/wE78hjVyyV8gczFve8UKEcop+EeJS3tl3c9CK1d3+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMVVnx9z2yGdBz2yR4OFlL2+A/7pzFStsEaDi7LpU/frkK9WTPs78KqNoeZlolk1mmWPC6328/xEHsX3iLxHx7/nokWHUs5PyR01eiVTHPeSecEyVf1T12roTSARb7KC5f3HX7pF5HJpBLu+gHJG6ECJwx7luGkc27pmpUUI+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4s45MbO; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ab37d98dd4so2726205ab.3
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 08:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734021366; x=1734626166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyg6P8IFLpK2PR+/+zhqdZvH/sNBRUr40QwjKDuJuhQ=;
        b=B4s45MbOQcVDHn+OpuHXwVBSRw/isO2mAD7IFCeNZyHCKQ5meCswfObMizxl+NKWd/
         wLe1GGtJvmsmn42g9+sTLaxLiM3VBPaJHT5IasZ2wLavWUCwlquLombGmcRCHgmlhhZw
         Pgazuf2gIozUJi/yLYdhrpgWAa6AThA7sxAcI4iR3JHM7MV4T3lNg6aQwVjScwmhRvVo
         wwzky/vuz25z72y5pK9d+GoSTjkHUi5FwpOzP2MFabiSser9oGApEiaJ709M0kHRWu0M
         HTUOlcXlDk0OsZ6hmmM2WDey6+5OfCc+08e0zEbh5inznieLaoTf6MvO1g/9VMcf+ta4
         1ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734021366; x=1734626166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyg6P8IFLpK2PR+/+zhqdZvH/sNBRUr40QwjKDuJuhQ=;
        b=kyh97x9YYELgAsN23hyEqb4M9O2PTyVyXajZBEK22m7swMDLC6iJ0CfGTvXqsuKYhS
         Cop+acXxA2ulrlNUHkaKH604wbRbgRxvtRX+63r9DY0U+6pat3JyBQVB9qWxXe6+VGQ8
         KpXoUluOV87E0gE4m4HhJ4X5hGnljQ2vYHUFpF8wrshpHceq9bdAQfXh6luMEAPp2Ip9
         OwlvtscPLi4XiIKG0IxRgxmYBCWu+Ehyqi19gNAer8rklghHOiahMkck52fc8obO9Z5P
         VcJm6wU2yv07sSmAl1mj0kqALEZVXg4/ITcGxpztsd513IALa0lF8IEjRz6UTuUyGszy
         fiTg==
X-Gm-Message-State: AOJu0Yxa6AIcHq1Wku5l5P07SDLobeCUbUK0XGWH6FhCvWdyQDTnVwXW
	pUVQhRSBCMi2JMxGtwRV68DLwKupt3bIMht8neOmnTiTmx51SPpcqYe1zFXr/TjGiLtaly6hMv0
	Xrlmfui7x7plBVI9ANOxtTGCHE9k=
X-Gm-Gg: ASbGncvsvLS1KvTPPpBSzmHpZ08Pb/mG/4R2n5CtB00+dLFtqtPgXYuA/KS/3Lf9Z0H
	HZG7pRm6cspbdBosM3lD6GTYpCHXZlWOBXN6rbYqRN8XDwajrO8AAEXHgrqQWBGfUwzwwhXAC
X-Google-Smtp-Source: AGHT+IFiZf4piSO4IxQXkFqwFZfZuQ7Xjd+/NcNdtU1jW43ftcBx7VzZXgAZ+z4KzuYftqgjpNH1dmhs8BYyUdq6w3c=
X-Received: by 2002:a92:cda3:0:b0:3a7:e592:55cd with SMTP id
 e9e14a558f8ab-3ae568be503mr7308415ab.14.1734021365687; Thu, 12 Dec 2024
 08:36:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210191309.8681-1-annaemesenyiri@gmail.com>
 <20241210191309.8681-4-annaemesenyiri@gmail.com> <Z1ljFkEk3jZHRGl3@shredder>
In-Reply-To: <Z1ljFkEk3jZHRGl3@shredder>
From: Anna Nyiri <annaemesenyiri@gmail.com>
Date: Thu, 12 Dec 2024 17:35:54 +0100
Message-ID: <CAKm6_RtLzq7MW6Ut0ok_2rOyGqOgVDWr9mbaE-4Ts4Hup_454w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/4] selftests: net: test SO_PRIORITY
 ancillary data with cmsg_sender
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What is the current maximum allowed line length? Because the
checkpatch script permits up to 100 characters for max_line_length.
But I received warning on patchwork.kernel.org site:

WARNING: line length of 86 exceeds 80 columns
#64: FILE: tools/testing/selftests/net/cmsg_sender.c:121:
+ while ((o =3D getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l:L:H:Q:")) !=
=3D -1) {

Ido Schimmel <idosch@idosch.org> ezt =C3=ADrta (id=C5=91pont: 2024. dec. 11=
., Sze, 11:02):
>
> On Tue, Dec 10, 2024 at 08:13:08PM +0100, Anna Emese Nyiri wrote:
> > Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
> > ancillary data.
> >
> > cmsg_so_priority.sh script added to validate SO_PRIORITY behavior
> > by creating VLAN device with egress QoS mapping and testing packet
> > priorities using flower filters. Verify that packets with different
> > priorities are correctly matched and counted by filters for multiple
> > protocols and IP versions.
> >
> > Suggested-by: Ido Schimmel <idosch@idosch.org>
> > Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Ido Schimmel <idosch@nvidia.com>
>
> Few nits that you can address in a follow up
>
> > @@ -252,6 +259,8 @@ cs_write_cmsg(int fd, struct msghdr *msg, char *cbu=
f, size_t cbuf_sz)
> >
> >       ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> >                         SOL_SOCKET, SO_MARK, &opt.mark);
> > +     ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> > +                     SOL_SOCKET, SO_PRIORITY, &opt.priority);
>
> Need to align to the open parenthesis
>
> >       ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> >                         SOL_IPV6, IPV6_DONTFRAG, &opt.v6.dontfrag);
> >       ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> > diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh b/tools/te=
sting/selftests/net/cmsg_so_priority.sh
> > new file mode 100755
> > index 000000000000..1fdfe6939a97
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/cmsg_so_priority.sh
>
> [...]
>
> > +fi
> > +
>
> Unnecessary blank line:
>
> Applying: selftests: net: test SO_PRIORITY ancillary data with cmsg_sende=
r
> .git/rebase-apply/patch:228: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.

