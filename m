Return-Path: <netdev+bounces-111332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFE3930896
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 07:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67B51C20A7F
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 05:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7CBF505;
	Sun, 14 Jul 2024 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="dJWaXN5l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D520EB
	for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720935078; cv=none; b=CGSt6x/O+RiBD6zHEcWgRrg5Rk5zQ4woZiSg1OZVTLNd5FtpzP3Z1YOPgpunT5hywINZe2XyrYj3sZx2bJqY9c0/pEHjYA42hSwpkfrWvRzDaxPhOjMGyRu4E61ASPrO3A2lvR7OFVS7Mo5Ioiaz41tT4czhDbet9+24vE82c2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720935078; c=relaxed/simple;
	bh=3QIMAs3IFSh7u1SCIPMUxyPU5FqaYl2jhpJiMumGDeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzQAnaIrK/mZGjP/6W6p4j6zHPFgWnb7Pwwl1ZvLlwFZ5a8DeGMpG/eh2bl1bEAAuIryYAO/o6koOpd6oLuslRPhGb6pM0Hp+hBnL+++B8U4veaqa0dRd5vEAj0z/O1n2c99iPBRPnM0BJHlYpTb0LiHw8jU73rBqdMHpeBDciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=dJWaXN5l; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d91e390601so1966478b6e.1
        for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 22:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720935075; x=1721539875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fG/PfKdeWUxDcrt2oIAXldZj9CzlPpZ261JHkQi/zXU=;
        b=dJWaXN5l9v5aqZGYeITR+nBcd7j7ckJ2/ndkVu5zfeKPalBf70/2hvTukD3jO2F8t2
         75D+M1fMn/pEzMScQULZmWXeLqyh4tWf+YRFsFmomkHDrA5Yr3yamR9C/BVJQi/90Zzv
         EBjez/whzPS1ZI45v537IQjS7wKyZFuZ1ardVoZEamLxgLoVw2TnETWo6gpGwtk0Zna0
         Tznl5QgYmRJH6nyd0/JLh5V6xjO4i94Q9zsELeodKpbsTZrKDJ6xDE0UldbRGoYWFVcg
         974Hgo2fe+WmgjsKkSWxVBET+4OKIror8Hcq0dWZhQBrkE9Mh+LuDJFY0hC2XIpybTk6
         Hmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720935075; x=1721539875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fG/PfKdeWUxDcrt2oIAXldZj9CzlPpZ261JHkQi/zXU=;
        b=N0iXovDIiBRPBA93TyCHJK0EX5wMYM/MDPdYokCFKCeKhCybhVvghUgZ9FdN8eKfov
         ry8nqM1s7KhfisiFaRQqkFczy6Ne/VGlh8OkDck0ojEOz3Z4tKsh/RHFcF1oP99yQjCQ
         mqLFnlK9iWEDnu+Ts8nMCq9LvmWVYOAsj/iIacFumB198zagiAEwtKhxfh9ctIENksF6
         wSFwu1QE712rgvqheCyn3aizS0zYZjGdQEZykuUJFSr5KlFOdrSi+0ffx+fViXCciaV4
         jom3QK/frdlCl+BVWbJXzhR+83X4Y2IPN5dhhXAxRj6tZuJPZBa2bm+ru8iIeYMvaTQa
         gw0w==
X-Forwarded-Encrypted: i=1; AJvYcCWDR+4rlQCNWg+tMogtNg4LvGLvLb4ZUgoCl7kvmgcVDtDDjXK12YDbuapnnSE/iHONdacVsHoyHEfnGIBUe+OMpwFvxufq
X-Gm-Message-State: AOJu0YxI9a1yQj9XyWtdFmiw81bx3aHc8JR30B8LZ9DL73eJ/gbxO3Xy
	lNo9XeTjM/1uazvRv8aEYnVY2OXDeSLKl+nd19villLNxJSulsNtk4EwcM4eoFQ=
X-Google-Smtp-Source: AGHT+IEtxJqu4j5l5kEVZts9GPmpqkb6+LMj87Bezmzc+8y/bcNnj/BuvWU5TphzRDvdVcPidUZI6Q==
X-Received: by 2002:a05:6808:2991:b0:3d9:dcbc:6b7a with SMTP id 5614622812f47-3d9dcbc733bmr12440111b6e.13.1720935075379;
        Sat, 13 Jul 2024 22:31:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc273d7sm18048705ad.120.2024.07.13.22.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 22:31:14 -0700 (PDT)
Date: Sat, 13 Jul 2024 22:31:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Adam Nielsen <a.nielsen@shikadi.net>, netdev@vger.kernel.org
Subject: Re: Is the manpage wrong for "ip address delete"?
Message-ID: <20240713223112.4d5db4b6@hermes.local>
In-Reply-To: <m2sewezypi.fsf@gmail.com>
References: <20240712005252.5408c0a9@gnosticus.teln.shikadi.net>
	<m2sewezypi.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 11:33:45 +0100
Donald Hunter <donald.hunter@gmail.com> wrote:

> Adam Nielsen <a.nielsen@shikadi.net> writes:
> 
> > Hi all,
> >
> > I'm trying to remove an IP address from an interface, without having to
> > specify it, but the behaviour doesn't seem to match the manpage.
> >
> > In the manpage for ip-address it states:
> >
> >     ip address delete - delete protocol address
> >        Arguments: coincide with the arguments of ip addr add.  The
> >        device name is a required  argument. The rest are optional.  If no
> >        arguments are given, the first address is deleted.
> >
> > I can't work out how to trigger the "if no arguments are given" part:
> >
> >   $ ip address delete dev eth0
> >   RTNETLINK answers: Operation not supported
> >
> >   $ ip address delete "" dev eth0
> >   Error: any valid prefix is expected rather than "".
> >
> >   $ ip address dev eth0 delete
> >   Command "dev" is unknown, try "ip address help".
> >
> > In the end I worked out that "ip address flush dev eth0" did what I
> > wanted, but I'm just wondering whether the manpage needs to be updated
> > to reflect the current behaviour?  
> 
> Yes, that paragraph of the manpage appears to be wrong. It does not
> match the manpage synopsis, nor the usage from "ip address help" which
> both say:
> 
>   ip address del IFADDR dev IFNAME [ mngtmpaddr ]
> 
> The description does match the kernel behaviour for a given address
> family, which you can see by using ynl:
> 
> $ ip a show dev veth0
> 2: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
>     link/ether 6a:66:c7:67:bc:81 brd ff:ff:ff:ff:ff:ff
>     inet 6.6.6.6/24 scope global fred
>        valid_lft forever preferred_lft forever
>     inet 2.2.2.2/24 scope global veth0
>        valid_lft forever preferred_lft forever
>     inet 4.4.4.4/24 scope global veth0
>        valid_lft forever preferred_lft forever
> 
> $ sudo ./tools/net/ynl/cli.py \
>   --spec Documentation/netlink/specs/rt_addr.yaml \
>   --do deladdr --json '{"ifa-family": 2, "ifa-index": 2}'
> None
> 
> $ ip a show dev veth0
> 2: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
>     link/ether 6a:66:c7:67:bc:81 brd ff:ff:ff:ff:ff:ff
>     inet 2.2.2.2/24 scope global veth0
>        valid_lft forever preferred_lft forever
>     inet 4.4.4.4/24 scope global veth0
>        valid_lft forever preferred_lft forever
> 
> I guess it makes sense for "ip address del" to be stricter since 'first
> address' is quite arbitrary behaviour.

I wonder if it used to work long ago in some early version (like 2.4) and
got broken and no one ever noticed

