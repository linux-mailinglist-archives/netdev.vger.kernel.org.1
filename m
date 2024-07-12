Return-Path: <netdev+bounces-111052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4171A92F92B
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 12:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED937282327
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8501914EC73;
	Fri, 12 Jul 2024 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAwI4Oyr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCCD146D7A
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781608; cv=none; b=as91aHyaSIjr49y4sKZTS86IuhWw4kvrYrk/wihSN6wl2lMy1IrT0YGAp0C3e728I0U886CEm5RTVEcWdotmdAUxYna0lIBN7NoEGEOwF0mMpxu9+VLCHsEAKGXrI5DWg3orRjMjo9p6MGOcFqrr095r4Y79tGMfiDSk8D/xsQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781608; c=relaxed/simple;
	bh=tCFZuMtVtMBuyJdliChvuY/ukdPToyrfLSwiurn6Ex0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=KjCFY1g2y5rWXbPkxidyvu6xqz4+OQVAsrojFbhHP3TAWNeWAR21BPAS1F7TFfEAiYxjuVCd53rf7xw0pUgVSZasO7CK9JbuMvTS9yeK82WlTIsmL8PWt4u8fy103b+sBqV+pO5b8IECHKsj/cFVaSm5JDPOTGsBQij+1VyGyAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAwI4Oyr; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e9c6b5a62so1987653e87.0
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 03:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720781603; x=1721386403; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GBYTv3D66ZQBPCyAJlLK1YqhMSWTQpRP3NRiMFdsHx4=;
        b=jAwI4OyrVkisJ5oiCFRFidYEUrBY3UdrWHYGzHogEZ3kAAMa7KIIh74nmHh6Y7ZP1U
         p40H7rdAUZvPU5judyVA/ApSSgTtgdE5LrkW/V35punMtaWBor4bzGDFDuGMNeatVF2W
         Gb8ur4YyaksRWv33da800QYeRSLRxZZtEhDXhaCz+kQiiTxi0XuqPDRbBntS5RBot6fd
         3MOombzyfN31tonT/ZbEge10dfbff5Cuds6rzBq/UQVCUkO6H7If1/6MZ8v6P/i0cJfi
         BfNXKfE89Ep/Bu1tcZ1ExtE5h4/GyKv9HftrfYW1X99c6XUMOTfhsaCSOPlWfXs4Z5Hj
         N9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720781603; x=1721386403;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBYTv3D66ZQBPCyAJlLK1YqhMSWTQpRP3NRiMFdsHx4=;
        b=itrLD0araG5zY89oKn4zZvOm4JFnrV/O39QxcdPSR1T1YsYGdA9rCSt/4VrN6V1ocg
         U+vgjqng7EooaeAZnjglkCtJDdOEjF514r6pysSEpuZfAkvo4RPrzLtKsNoVm2VyvI6t
         vxMB8acCKCjynWWpyVG2rluhiTwSectVuX4oYMu7tjHKX7O9xOI/ZHumR9RquDQPaY9K
         Dx6i7XRQxmvBZ2nTJJXsYiZa0nTh7Ghd9myiwSWYZcj03pLM99HhrUNwfh65bagMGHaP
         iejy84ujhDPgALZYQPkwmXWs0Deq+90l3QQVwo8oGSLvZDNmdZfBj4mwrqyc37BRwLWs
         3j1Q==
X-Gm-Message-State: AOJu0YzP/PXVcfWW9eq48TnpvxjHQl62kyBZe1/0MWR2ERKC4q+FM/Qj
	HMY+Xnz4ZGmlVX/iy1ljpbwauFPgKDLfbWOEsa+lZwIWnJ7FqqzzpvmwWA==
X-Google-Smtp-Source: AGHT+IEwwAi4hJxpYsnK+MAaQ2H46YE3YP78b4i9C4VLMzyIxxCZd143ECVxbzuR0471KdJLSyVcVA==
X-Received: by 2002:ac2:4c56:0:b0:52e:be49:9d32 with SMTP id 2adb3069b0e04-52ebe499f4amr6304446e87.47.1720781603113;
        Fri, 12 Jul 2024 03:53:23 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8864:d940:9b3e:7e21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa0694sm9978661f8f.66.2024.07.12.03.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:53:22 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Adam Nielsen <a.nielsen@shikadi.net>
Cc: netdev@vger.kernel.org
Subject: Re: Is the manpage wrong for "ip address delete"?
In-Reply-To: <20240712005252.5408c0a9@gnosticus.teln.shikadi.net> (Adam
	Nielsen's message of "Fri, 12 Jul 2024 00:52:52 +1000")
Date: Fri, 12 Jul 2024 11:33:45 +0100
Message-ID: <m2sewezypi.fsf@gmail.com>
References: <20240712005252.5408c0a9@gnosticus.teln.shikadi.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adam Nielsen <a.nielsen@shikadi.net> writes:

> Hi all,
>
> I'm trying to remove an IP address from an interface, without having to
> specify it, but the behaviour doesn't seem to match the manpage.
>
> In the manpage for ip-address it states:
>
>     ip address delete - delete protocol address
>        Arguments: coincide with the arguments of ip addr add.  The
>        device name is a required  argument. The rest are optional.  If no
>        arguments are given, the first address is deleted.
>
> I can't work out how to trigger the "if no arguments are given" part:
>
>   $ ip address delete dev eth0
>   RTNETLINK answers: Operation not supported
>
>   $ ip address delete "" dev eth0
>   Error: any valid prefix is expected rather than "".
>
>   $ ip address dev eth0 delete
>   Command "dev" is unknown, try "ip address help".
>
> In the end I worked out that "ip address flush dev eth0" did what I
> wanted, but I'm just wondering whether the manpage needs to be updated
> to reflect the current behaviour?

Yes, that paragraph of the manpage appears to be wrong. It does not
match the manpage synopsis, nor the usage from "ip address help" which
both say:

  ip address del IFADDR dev IFNAME [ mngtmpaddr ]

The description does match the kernel behaviour for a given address
family, which you can see by using ynl:

$ ip a show dev veth0
2: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 6a:66:c7:67:bc:81 brd ff:ff:ff:ff:ff:ff
    inet 6.6.6.6/24 scope global fred
       valid_lft forever preferred_lft forever
    inet 2.2.2.2/24 scope global veth0
       valid_lft forever preferred_lft forever
    inet 4.4.4.4/24 scope global veth0
       valid_lft forever preferred_lft forever

$ sudo ./tools/net/ynl/cli.py \
  --spec Documentation/netlink/specs/rt_addr.yaml \
  --do deladdr --json '{"ifa-family": 2, "ifa-index": 2}'
None

$ ip a show dev veth0
2: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 6a:66:c7:67:bc:81 brd ff:ff:ff:ff:ff:ff
    inet 2.2.2.2/24 scope global veth0
       valid_lft forever preferred_lft forever
    inet 4.4.4.4/24 scope global veth0
       valid_lft forever preferred_lft forever

I guess it makes sense for "ip address del" to be stricter since 'first
address' is quite arbitrary behaviour.

> Cheers,
> Adam.
>
> (Not subscribed, please CC)

