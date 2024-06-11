Return-Path: <netdev+bounces-102636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BA7904087
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 17:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B97281081
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B4381AA;
	Tue, 11 Jun 2024 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DjDzQLOU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F738390
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121222; cv=none; b=eCDUZGXowvrqwRMQPIeA+gHdjt4b3mAb6CmetjLDbHxYfN5uDDsspC4hK1i7G9aFV/M9rMHO8R70rAfejTU6yW3CP8el5dY2nLJFm4laOFozJuYTabDrOx+Sg2BA9C38aqY4oULbItroaEKcTA78yhMBZVre3DqlWmajfJrYJTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121222; c=relaxed/simple;
	bh=+Ey6AlHzeNeSIvLXsBwC+cjHinHJjK2su63SRAf35NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfQki//IjoQGvNVCxF73GrJs3DEicuJnmqackxwPvhcLq01DiBASxb+ZBGAYg9zQBwtpkEzG7iokp4QSsZNGEsB511QhxXHUCY6DvU0HAoswlsBsAe1FOs/eSErdtLvzXnrM1pkC6jeTdvKc14yB1BJpbK3fD8NtNap9S/gbuMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=DjDzQLOU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62a2424ecb8so57324747b3.1
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1718121220; x=1718726020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ey6AlHzeNeSIvLXsBwC+cjHinHJjK2su63SRAf35NA=;
        b=DjDzQLOUMStaXVrEIBXL/fcsvtVz6040BBjr52eAErqk3qnLlUQLrcSfnFNfGAALlS
         yIh8s5gQ48pzlSvkxdq2pifmsYkpebcWB1LYKQeTMwyN0zCNDxalO6+4Mrd0HFjc6dPm
         cIimQEubDF197MCkjA8LyLjLgvi05jma6zU52Z1exAEaJE/L6iCAU+JqWns+VK0QReeN
         zREXtAAuOImwcUU2OlzgSIoqHv/DZMibK/I1P0sqgFdnR8xcBNtH1eWg6Kq7g3pKFBSI
         nxn4/ttyxCqmMqpLMN5KClvGGxyE1f4hjWzC4hOYqFjVFa6rywBYXpJjp6MYzRy2DHHx
         p7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718121220; x=1718726020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ey6AlHzeNeSIvLXsBwC+cjHinHJjK2su63SRAf35NA=;
        b=lhR6wUW1s1bQK2eQuWMLN8rFpITQ3+tfTOpwEiuaepHJO7C98rpgF/lzVnPKH2p809
         DLRPfJENQ55HoXnaKFrG+kPBbIxfg89BSi+sNkeNINOnKHr9uGsOAJA9HHDII5Xp7ZVN
         Y3C3Ti/II20ZijE84irwNcEHibjnWqksr6XJHKLi7alYTdJdhGMCuPwblGjSaRSQfZYu
         9cR8BjcWFcD5Vi4TvGScpKHH0XkxtyYyr4HWugSEuxkZd4dt2kMaONL8gS8SHfS6WN0K
         G02+StGVHzIJEqFTgZlPRiS71Mij9rqlDgh3t4P/VSTGgYy+rYbx/qCtChD8YPnTqEtb
         9LZQ==
X-Gm-Message-State: AOJu0YyAqrA9MoZ8uDTfs56i0lct0NH5lMm1Mtwaar16qJxYs3/sDEkE
	yxzs/kx/K6JbSHGMlAJ3SYKQbbtN85Le6uUNJan4JhCuqqgzNGKRq+qLOoLwiZqgStFDSnkASzJ
	yl/1OeqeltNO0qyiXgYTsbW3Pb37OM7WsJZbT4rnmIJWy9soGHQ==
X-Google-Smtp-Source: AGHT+IFNDTPiC0vl5v2dPaqcB+z9t5a2Yp6bknx5f2cOU7wOSP2cjjEAfPVmU+ZDE8rFZfeS9xuXfToP7gfrNVkdPdc=
X-Received: by 2002:a81:bb4e:0:b0:62c:f6c6:d5fc with SMTP id
 00721157ae682-62cf6c6d796mr78091417b3.26.1718121220207; Tue, 11 Jun 2024
 08:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <20240611072107.5a4d4594@kernel.org>
 <CAM0EoMkAQH+zNp3mJMfiszmcpwR3NHnEVr8SN_ysZhukc=vt8A@mail.gmail.com> <20240611083312.3f3522dd@kernel.org>
In-Reply-To: <20240611083312.3f3522dd@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 11 Jun 2024 11:53:28 -0400
Message-ID: <CAM0EoMkgxXX4sFJ98n_UTLLFjP3KHx00aaq76t4zJJsO9zNO4A@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, 
	toke@redhat.com, victor@mojatatu.com, pctammela@mojatatu.com, 
	Vipin.Jain@amd.com, dan.daly@intel.com, andy.fingerhut@gmail.com, 
	chris.sommers@keysight.com, mattyk@nvidia.com, bpf@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Oz Shlomo <ozsh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 11:33=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 11 Jun 2024 11:10:35 -0400 Jamal Hadi Salim wrote:
> > > Before the tin foil hats gather - we have no use for any of this at
> > > Meta, I'm not trying to twist the design to fit the use cases of big
> > > bad hyperscalers.
> >
> > The scope is much bigger than just parsers though, it is about P4 in
> > which the parser is but one object.
>
> For me it's very much not "about P4". I don't care what DSL user prefers
> and whether the device the offloads targets is built by a P4 vendor.
>

I think it is an important detail though.
You wouldnt say PSP shouldnt start small by first taking care of TLS
or IPSec because it is not the target.

> > Limiting what we can do just to fit a narrow definition of "offload"
> > is not the right direction.
>
> This is how Linux development works. You implement small, useful slice
> which helps the overall project. Then you implement the next, and
> another.
>
> On the technical level, putting the code into devlink rather than TC
> does not impose any meaningful limitations. But I really don't want
> you to lift and shift the entire pile of code at once.
>

Yes, the binary blob is going via devlink or some other scheme.

> > P4 is well understood, hardware exists for P4 and is used to specify
> > hardware specs and is deployed(See Vipin's comment).
>
> "Hardware exists for P4" is about as meaningful as "hardware exists
> for C++".

We'll have to agree to disagree. Take a look at this for example.
https://www.servethehome.com/pensando-distributed-services-architecture-sma=
rtnic/

cheers,
jamal

