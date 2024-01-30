Return-Path: <netdev+bounces-67291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6BE8429B8
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 17:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAFAB25405
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818AC129A7D;
	Tue, 30 Jan 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdyWKcLR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC4128382
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632892; cv=none; b=ZYSJG0zjw6qBt9e1HWo/TJHDnGKsl+BkUj1z38zQdrXGEMnn1si4vUnZi1I26wRd8mP2Zjjix99NYOwobI5TTR2s2s0wk4ADYyS9xkAmsFnYY3SxbPLhH/owjgwFJiDu5vpCQpQHlXUPNlsQ16LrXbGUchEuKWZaYyBqiX+RvFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632892; c=relaxed/simple;
	bh=xjzjJrysSvPLCMEzQXvZ+Yu3MMpIhvxElmjRfyJJaJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjXujCsOkna0XZ9y4MXKd3Y/4gzfXqQ6AIv7rH1+MJNifdES4axyiqnZd0Z6HRuFWpges+yb4/Sxvonvd2CNtttwKyhCZ0RFw6aICm6HuQsuqjdqDQl9n/S/55fL/HL7wGDUl+LN0mUGEl/cj571KLVnc4assHxAcYY6Bd4RfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdyWKcLR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d8d08f9454so186975ad.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 08:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706632890; x=1707237690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90dsUhogDic1HENZzxBxVkMyjCg4enXsEvtqV/HnIcY=;
        b=gdyWKcLRV1JqtL4YsXoA09HrZ8oIUbdr5VnbzQExcmAtUB9kzX3FBaYZDv7vVHEDI0
         O6a8i1m5K1xK9ZRnZmZwU359H02UXg9jJDyce/U47ggU+m/9fKPBv1LJm2fS2tEAPH55
         v83wCeOCFnmra4ZKyTd2Zx/ClxsP8Jtq+3/kKNr1DEDqj55i5iiiT+cnmkc2JPJux31z
         6DDoAU2Rj8mXhrWBQQ3CjbVHy9XaQkBdmY71n3Ib5nXKQDNKdJ5sTeFl/kPiwuMQyuKD
         DYmN8HwexyovoKVL6Psdjsvti7TqHkjHfwlR42Q0YEBA3FVlAMXc/5/zXSlWSIG94l7s
         ftxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632890; x=1707237690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90dsUhogDic1HENZzxBxVkMyjCg4enXsEvtqV/HnIcY=;
        b=qywnzxQUJEW2g8zTwPApFwY25CtdEpjS04vMQxK6nUOyHziqnvreCWM8VSwXWbwgfl
         n3nG+JHaM9xD8QDuw9WSlP0FfgISe4ON091XtVbj2quGxs3esb5Ewvc8aGoC2sdab091
         55PNY8AXUjuoFvOA7ExnNzQuebeZZZUel3ss2K4Xb1pEc3le9XUavSvQS7ccYPUVgNob
         63zEYv1e6xl1A964GvraDfC92w6YJAYTIZSbfy3acJcG0uQ028bu7EF+IYVk+IleSueP
         82Gf6w2/DOP2NGirf1Gw/wALYdUBE7WfvQ1xFEtTu1vDfoMOsUxOsh22r8sAEia8raVC
         JOlg==
X-Gm-Message-State: AOJu0Yzcb9ojqFmySg/nhexNzZk7VdAiBesB2RYtv4XaCyfGxsmXp+7s
	dvPlZ6uWDuoiwboYaASlZRzMe5yKDzHNhqnXwF65VjGZrL7B3PEMAoiHnem7zzoARYAl3lkKSlo
	PjyhkzhK+HlKHzaBglxK2+90MQfKsA53izl3r
X-Google-Smtp-Source: AGHT+IHIP7C3utp4fY/dALdbVUWF+osAYCzO9ppmlrDUJjiU1ke2Swm5Kxm7V+pizKtZTAN6z4eEbMWQ0Gqqu4lSIek=
X-Received: by 2002:a17:902:dccd:b0:1d3:7db1:388b with SMTP id
 t13-20020a170902dccd00b001d37db1388bmr233504pll.11.1706632884096; Tue, 30 Jan
 2024 08:41:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000ee5c6c060fd59890@google.com> <20240126142335.6a01b39f@kernel.org>
In-Reply-To: <20240126142335.6a01b39f@kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 30 Jan 2024 17:41:12 +0100
Message-ID: <CANp29Y65E_jqfhkipGzJQ5DuDhpZzLrNJmL=foAgk9cgD8L5tw@mail.gmail.com>
Subject: Re: [syzbot] [net?] [v9fs?] WARNING: refcount bug in p9_req_put (3)
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+d99d2414db66171fccbb@syzkaller.appspotmail.com>, 
	asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	netdev@vger.kernel.org, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[resending the same reply in plaintext]

Hi!

Thanks for reminding me. I've just regenerated the list of
classification rules based on the latest linux-next[1], syzbot will
reclassify all findings once the PR is merged.

[1] https://github.com/google/syzkaller/pull/4471

--=20
Aleksandr


On Fri, Jan 26, 2024 at 11:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 26 Jan 2024 01:05:28 -0800 syzbot wrote:
> > HEAD commit:    4fbbed787267 Merge tag 'timers-core-2024-01-21' of git:=
//g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D11bfbdc7e80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4059ab9bf06=
b6ceb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd99d2414db661=
71fccbb
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > userspace arch: i386
>
> Hi Aleksandr,
>
> we did add a X: net/9p entry to MAINTAINERS back in November [1]
> but looks like 9p still gets counted as networking. Is it going
> to peter out over time or something's not parsing things right?
>
> [1]
> https://lore.kernel.org/all/CANp29Y77rtNrUgQA9HKcB3=3Dbt8FrhbqUSnbZJi3_OG=
mTpSda6A@mail.gmail.com/

