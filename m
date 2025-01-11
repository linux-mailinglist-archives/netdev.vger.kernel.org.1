Return-Path: <netdev+bounces-157470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4E4A0A61C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 22:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0789916853E
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840F91B87DF;
	Sat, 11 Jan 2025 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="RU51ey+l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ECA79D2
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736630278; cv=none; b=PmhppTqKVZ6RA0aIl8HsoE4DbKS0I1fJW5H3OTkiRJ8TCZGozQgTbbnlnqAwbw1Bk2yDUEjWC9UjCSIqoqT21zUxKrBg8DhbpwWlgUFh2zCHqFSYrT0CG6sxrc4EZrDI2JPqRL0XHBOOHRpVQKETASUIOBujy2Hff3LF8g+stvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736630278; c=relaxed/simple;
	bh=16ABFFdwV90k330EOSd/0E7npNEzoB0e8AenHzI8Av8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPqQ3iCoF0Yyz/fEZaUKin3acBox59tzuU5hIN8uMpLvvOG0Lb/8lURfRE0nb9PrIQIgWF7k6IfCzGmLCzP8rb3F074J+jmuCTD/M+U9aDUQQ4iscLlCHuwu7Cdm9KBMT5BzHRxncpubggxfYBhpyBsG7Cc0JJz5eWr/yfTswuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=RU51ey+l; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso4261340a91.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 13:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736630276; x=1737235076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yE2U4HtS8Jve2u6+efl87IdKIqeye1Ij962QjEm8+k=;
        b=RU51ey+lMj2eqoCg6aJdPvZO7sbkZmqJmot6R20hoUBB0cCcWx8o6ki463skJOKw0C
         4zCUXOjfI8bmF1vzvGUSGl5OqBegHzl5XgIsf+wpQJTgpKGjM2p1BQBioW+M+oQcGBGG
         URLZI7Uc9Coy/bfUSxc3Cs8H5siu55OCwAC8bn0Tj0YOq8hU6u7o3D9YUlasdVC2vkbq
         nz7r87pzAtfLsbVJhPXIiwYsaMw38QbsnlYAzbkgrh1MmqtfEDgdu9x4YvScE4R1klZa
         wWPdIP3UU46hex5mXzJz4jUMnGMAHCkkrJb8855Qn11nGR+e/8zL0YU495XwBU3fJyJw
         wp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736630276; x=1737235076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yE2U4HtS8Jve2u6+efl87IdKIqeye1Ij962QjEm8+k=;
        b=RozoQIFZEn95yM0LRql1bL6+khQWIFgGGlLBS05eNjeo2TEPRgYCP5IUYqkgpByHYo
         aUpOnkdFx5kNyE6C74QZ7i2yyMknLL21l6g+DDQNMvB7bts2eQSPTWh2L53+xNjQ0gFE
         MEMhRHfy0bt4fH3W5ZL9EmtjbauZgZfgOxwvK1s0XH8QVGlikWpsIqFBXOiLEsoQSjZe
         Cw25iX+tKqLYkzDd/c7vxXGfOP+zSphqkAFIeI9ggRbjye2n+Z0LT5CQCFiWKbfQVaxO
         34oLXXUK9Noi9nq0KzTG/vx+IKViGgMu1c7N12Jh96geKE6m+qZvppXG+9bfnzamhDp4
         MslQ==
X-Gm-Message-State: AOJu0YyzZBIZHIwDII/PbIbUERn6PQFb2KqxNZ0CEszuNHEaEfJTHZdo
	dA4dtGEGz8mz7PxuAMLiSew8ySelfU4MSffKadhadfnI9j/vkvEzUk/pnhe5JzFYztXOjJEj67D
	2h0XLybOo7vuoHBGHjmlpQrp+rWmCXoV2TVSp
X-Gm-Gg: ASbGncs8LQhHsKhhFaSschW+l2+uopwZ1drFMd9Ouad603iCvRlxsSsybbgGv1m0cN8
	IVT9tzAzpmxloTCCKAF+EfYhAw+ra5l1FvOnW
X-Google-Smtp-Source: AGHT+IEGU/TnpZxEZUaogtofh/+Y8PgCluA8hIG7gVABeW5f3GK4AkQG7gABvnaE9nha1sKIAFIMTca+1+RB2Xhi5Bw=
X-Received: by 2002:a17:90b:2f0d:b0:2ee:f076:20fa with SMTP id
 98e67ed59e1d1-2f548f1c518mr22388088a91.25.1736630276379; Sat, 11 Jan 2025
 13:17:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111145740.74755-1-jhs@mojatatu.com> <20250111130154.6fddde00@kernel.org>
In-Reply-To: <20250111130154.6fddde00@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 11 Jan 2025 16:17:45 -0500
X-Gm-Features: AbW1kvZMPfteJAElFOLDBJDVe57QStwqcgpz1CSkEzlflk-JOSTW30HHkUTFPnA
Message-ID: <CAM0EoMkRqod-MsMb60krtZ38SszwTR+3jjwE1BHPKe4m6oVArw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] net: sched: fix ets qdisc OOB Indexing
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, petrm@mellanox.com, 
	security@kernel.org, g1042620637@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 4:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 11 Jan 2025 09:57:39 -0500 Jamal Hadi Salim wrote:
> > Haowei Yan <g1042620637@gmail.com> found that ets_class_from_arg() can
> > index an Out-Of-Bound class in ets_class_from_arg() when passed clid of
> > 0. The overflow may cause local privilege escalation.
>
> Code is identical to v1 here...
>

The inequality changed > vs >=3D

> While fixing the code, could you also trim the stack trace?
> Like this:
>
>    UBSAN: array-index-out-of-bounds in net/sched/sch_ets.c:93:20
>    index 18446744073709551615 is out of range for type 'ets_class [16]'
>    CPU: 0 UID: 0 PID: 1275 Comm: poc Not tainted 6.12.6-dirty #17
>    Call Trace:
>     <TASK>
>     ets_class_change+0x3d6/0x3f0
>     tc_ctl_tclass+0x251/0x910
>     rtnetlink_rcv_msg+0x170/0x6f0
>     netlink_rcv_skb+0x59/0x110
>     rtnetlink_rcv+0x15/0x30
>     netlink_unicast+0x1c3/0x2b0
>     netlink_sendmsg+0x239/0x4b0
>     ____sys_sendmsg+0x3e2/0x410
>     ___sys_sendmsg+0x88/0xe0
>     __sys_sendmsg+0x69/0xd0
>
> the rest has no value.

Still want this change?

cheers,
jamal

