Return-Path: <netdev+bounces-128648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DEA97AABD
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 06:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C3EB23CF8
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 04:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A842C18C;
	Tue, 17 Sep 2024 04:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zach.us header.i=@zach.us header.b="CoIVm1Do"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285CC26ACB
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 04:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726547490; cv=none; b=ft9aeZpzS3HGSBfc78eKJ2l4n4/SxO83Nm/OZdDDbGB1+14J8kmKa82s3lMRRwrTvSMZ7MDel8YcFEHXhgyww2DsWIjaPUjxqPnQgM4e8UCNDR1ndtCGg2i5VClzPU36V6l4rVPBCyM501AkPd3y8WEaTTLJGoQNSeJuxjLh7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726547490; c=relaxed/simple;
	bh=l8miaHMe04523C6YCUfUQRfGF4ZRTHcQdIE0ha82H1Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=S76NDjj4EK0poijHJYp30gO9WrQuqaT/dpnW1tBzzEbClKA0x8fXun0ikrhfYuFF7K2UO/gynOoeU4ZMIJTNs5fJ181Xy9+E418KrFW+dfHrnOtwtcWwjQX9qOrOu1IHIYA4jdslgAgO44GVGyQDTCGk9lTmVwWFJpZc3elH29A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zach.us; spf=none smtp.mailfrom=zach.us; dkim=pass (2048-bit key) header.d=zach.us header.i=@zach.us header.b=CoIVm1Do; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zach.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=zach.us
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1d22ecf2a6so3425718276.1
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 21:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zach.us; s=google; t=1726547488; x=1727152288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LIHNcE4v45VqxruROqcgpWF9mo28yczvOySQoZ/7kjo=;
        b=CoIVm1DoZ2Sj62iGRLNMfnGKhTz2gvoS6CLJujqG8sr2QwQUujCe0nJO7YkfzYQKse
         fkiHqw2dTtHzIGj2TMpxgvnim3tPZCK/caT0cklqh2gKmcUx20LAgPnGENfON1y88TKT
         t4IfASHw/TNNToLjn443mxkjEamY+MNDxOucSmblnrR4StMrIqb6kDselMX+R5gJ3G0z
         P891UwF9IYt9j/vTKiZrKX2X1u5aX9llpIEuuteqnLveCYq0KE076zIZHaVyWqtQHh1E
         2FUhQxLuOihcAMYSZtNVI1pDO1pnge6uIDoaH/71KhobPY8fDxIqz/iXjuP3us75otHQ
         ZaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726547488; x=1727152288;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIHNcE4v45VqxruROqcgpWF9mo28yczvOySQoZ/7kjo=;
        b=OGJW3mTuEApGyZuy7n08KnKiEoAlcg9k9hKtZxhhwprCGZlejPDbQoyQpuMybBuaHf
         +9oEWO5SahaigVnGGQQAmkIDJUDeOuQmIsi8xFgYlESnIu2Ozm+PDIaGtvq2HwB4Wdbp
         NkbWraq5O3yaISdFRzJjijAcwiCJCpRo/RjqoI+XEkQfoumLvwwfuCPEGXyR0FlyQAo/
         gkeJvlAJZZjctIPy+4Wyi0NvoFfBfAKnTDZzHS9tS0vACDYZWgF5eM88sGsdjD6K1Svy
         aALgXXMODWKMdhdGn9bMvIH9qz8OTpX2z6gDYmWD984t6sHr3zhAKZQKJr2QFNBYlcUk
         Solw==
X-Forwarded-Encrypted: i=1; AJvYcCXXXGWFLxZ16Ry7yDttI/q3Jh75vrhdri2sDbIve43kUpOlBdx/rX3eUxFb+cUEsqjB10uTqfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Sas5oo9kpiVS/2u/OdQenyMvpXfVQIj1CzeSqf5egV0CRCNK
	W68PXAUx+rcFtDzBjHi3+J/q6S8QEWo70w3hdL546Rag8kcsi6VMd25H4RbXXNkm0REBzA8XHu4
	pD0tFd52+Oy0clE1GzOgEgUnJiYsRU9M0loH1Gg==
X-Google-Smtp-Source: AGHT+IGQfAujIncgZNtuPIZLaroqEPGZbnEfG6FzYF5SiY4HBnyhDQbtOvg2tIf7Z7xScqm1pw4/wBTNSRTc1+6Vygg=
X-Received: by 2002:a05:690c:7204:b0:6db:b7a9:bc99 with SMTP id
 00721157ae682-6dbcc59b74emr113769267b3.43.1726547488077; Mon, 16 Sep 2024
 21:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zach Walton <me@zach.us>
Date: Mon, 16 Sep 2024 21:31:17 -0700
Message-ID: <CABQG4PHGcZggTbDytM4Qq_zk2r3GPGAXEKPiFf9htjFpp+ouKg@mail.gmail.com>
Subject: Allow ioctl TUNSETIFF without CAP_NET_ADMIN via seccomp?
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I was debugging a seccomp profile that attempts to allow TUNSETIFF in
a container, relevant bits:

...
      {
            "names":[
                  "ioctl"
            ],
            "action":"SCMP_ACT_ALLOW",
            "args":[
                  {
                        "index":1,
                        "value":1074025674,
                        "op":"SCMP_CMP_EQ"
                  },
                  {
                        "index":1,
                        "value":2147767498,
                        "op":"SCMP_CMP_EQ"
                  }
            ]
      },
...

...but I get:

Tuntap IOCTL TUNSETIFF failed [0], errno operation not permitted

Looking at the code, it seems that there's an explicit check for
CAP_NET_ADMIN, which I'd prefer not to grant the container because the
permissions are excessive (yes, I can lock it down with seccomp but
still...): https://github.com/torvalds/linux/blob/3352633ce6b221d64bf40644d412d9670e7d56e3/drivers/net/tun.c#L2758-L2759

Is it possible to update this check to allow TUNSETIFF operations if a
seccomp profile allowing it is in place? (I am not a kernel developer
and it's unlikely I could safely contribute this)

