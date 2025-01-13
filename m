Return-Path: <netdev+bounces-157789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B43A0BBA0
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175C7188024D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B293D24023C;
	Mon, 13 Jan 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCKGVgIx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119AA240224
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781555; cv=none; b=bH9m1D2NgN7MTgYFJVV1oFvp5SAEVspKXmol7fkld6bWelwYj70g2gjEWuAO9RaGjtidYdZPZguo4XamHm/s8+aexX1+tfiqNEpVP1V+repTTJn8sHPgANQ2jkEaHfqXXCCPjY8tQ0BTWbx66HXvP9AfDwaBVQlNjTtDAJDILWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781555; c=relaxed/simple;
	bh=d3N9DCLGRvuIuT1enKfcCum1GV0sfPJFJ62i0hf/rz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GA7tHZV48ahXLOZj+9V/1m/L5zDQ6MIFyW+8oyfvufouhPgsKjVAGsXcBuBKTMvxbiyoyoZz8DVafc1YoAypLfVpI8INgyFkkKFAFo3Wv5233NDmsuRykOyTZFf1kH8xq8hzqY851yOm9TTGO13p+4yYXTJP36ShQHejJTO5ySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCKGVgIx; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ce4b009465so16540835ab.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 07:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736781553; x=1737386353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwXLgSNPXup/7eo0cZ1oQzwJKpL3dcZz0IHNeR1MukY=;
        b=bCKGVgIx+53S6VTKHC5e9AAeOAKbsXzpmNnJvNhY2GXBbg4+3bKSegx/9n0qyDTPdg
         nB09+2DKvfIZ5Yqmev09J2sEataNoX0gVkewoxNgGho7ivF1ceelyA4OseM0vm8qz8/Y
         LpmtJUqYS0iHKlXRyH52O9YHqr7egyOdhcT1uKq8aMPj/8DJrFta4023HWh0bs044iIo
         XI0TtRELFa7nCgBRM50sd7ZgSdtqRlBcOWC0ze5KuCCHMvSZ9gzD3L5wlKMxchQGZt5p
         LfbVh0kdQlRMrCicmJeBWkCBOFM7PmmgAnuEH61ttJFqxfO3JkmncXsRqSgLayZxkLX6
         xKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736781553; x=1737386353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwXLgSNPXup/7eo0cZ1oQzwJKpL3dcZz0IHNeR1MukY=;
        b=lga8a0NgIdY1WDJgOzDPRHyXu2IcSUsiWmtcB+gDNFpJGJtgT0Fg3sYByLJvSIhQnh
         iARklTPJrMMZgS7fYCiDf4JZQZcYNzzuIuGc1MSR/bOwZdP8k7BvseIdmM84rke/JLgh
         LjDV8wNarv5cjeLAKk1fwvBeM2vf7n4y5/2IfDnAS39lNAc5D1YVj+8BkydU3/5RfchX
         L7LIP0hd2Zr59qudRwRYKJ/SAmRt/E4EJIvh3B6F+7decyZgF2O8sLAg/0WhL+2bZwJ0
         ViIsbPa7/MdoXnFaaN2ish4PdoPgLAaUDhVSlzAPaEcIs1mKJhV7JZmGD+1tCL+eIxlx
         FBjw==
X-Forwarded-Encrypted: i=1; AJvYcCWTY4nrcFEQU2BhWUOjc7pd8/NkAOekVl1vPK3b2ednnXsMRGmbIiwIlLX+LW4a8Mh6XbxP2TE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5M9bfk/HnyFC33HCw26C+k3NThSYxG5bTS45bf7gvxwpw6/RI
	FB/Ac5LQ9MSaMX5NKAuM5b8OX/YMBRtueOXrBjrcuhV4bHU14A77iSqa/5wDgdlL2GeWZ38+kx0
	zIVw/XgVS0vQdymY7KOjaGzYNpVfoRcN7
X-Gm-Gg: ASbGncvfIHfNkTheO+e+zZVpcJEycpLH2fH5TWZlyPEvGOxmw4bMUuA3Dgwt10uqlqT
	IPbjqE2hFJdewDCzyZ+Tz15pPpp9mQwi8jThRCg==
X-Google-Smtp-Source: AGHT+IHReHn8upgTC8nonYxi5eJw6RZigfqwF4/ryJ2D8WL4NKosg6ugw+sylH+blzjtfFBHrRovhFWgUUOZLkqOW38=
X-Received: by 2002:a05:6e02:509:b0:3ce:46e2:429b with SMTP id
 e9e14a558f8ab-3ce46e24583mr90079825ab.10.1736781552910; Mon, 13 Jan 2025
 07:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b9e81aa97ab8ca62e979b7d55c2ee398790b935b.1736176112.git.lucien.xin@gmail.com>
 <48e9bf0a-3275-4d2c-84ae-9bc1163ab8cb@fiberby.net>
In-Reply-To: <48e9bf0a-3275-4d2c-84ae-9bc1163ab8cb@fiberby.net>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 13 Jan 2025 10:19:01 -0500
X-Gm-Features: AbW1kvZ0D8TqIsXl_pY05_hbyEnI4M0FLFmUOARhx5GnHQ67Nr6HxT7kgbPuGco
Message-ID: <CADvbK_cBD_JW5_x0HWY7f4uM7cgyfCvzBSyu_EL=XX7m7VJwhw@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: refine software bypass handling in tc_run
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Shuang Li <shuali@redhat.com>, 
	network dev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 8:25=E2=80=AFAM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
>
> Sorry for the late response, it has been a busy first week back, too many
> operational issues with devices in our network running crappy vendor imag=
es.
>
> On 1/6/25 3:08 PM, Xin Long wrote:
> > This patch addresses issues with filter counting in block (tcf_block),
> > particularly for software bypass scenarios, by introducing a more
> > accurate mechanism using useswcnt.
> >
> > Previously, filtercnt and skipswcnt were introduced by:
> >
> >    Commit 2081fd3445fe ("net: sched: cls_api: add filter counter") and
> >    Commit f631ef39d819 ("net: sched: cls_api: add skip_sw counter")
> >
> >    filtercnt tracked all tp (tcf_proto) objects added to a block, and
> >    skipswcnt counted tp objects with the skipsw attribute set.
> >
> > The problem is: a single tp can contain multiple filters, some with ski=
psw
> > and others without. The current implementation fails in the case:
> >
> >    When the first filter in a tp has skipsw, both skipswcnt and filterc=
nt
> >    are incremented, then adding a second filter without skipsw to the s=
ame
> >    tp does not modify these counters because tp->counted is already set=
.
> >
> >    This results in bypass software behavior based solely on skipswcnt
> >    equaling filtercnt, even when the block includes filters without
> >    skipsw. Consequently, filters without skipsw are inadvertently bypas=
sed.
>
> Thank you for tracking it down. I wasn't aware that a tp, could be used b=
y multiple
> filters, and didn't encounter it during my testing.
>
> > To address this, the patch introduces useswcnt in block to explicitly c=
ount
> > tp objects containing at least one filter without skipsw. Key changes
> > include:
> >
> >    Whenever a filter without skipsw is added, its tp is marked with use=
sw
> >    and counted in useswcnt. tc_run() now uses useswcnt to determine sof=
tware
> >    bypass, eliminating reliance on filtercnt and skipswcnt.
> >
> >    This refined approach prevents software bypass for blocks containing
> >    mixed filters, ensuring correct behavior in tc_run().
> >
> > Additionally, as atomic operations on useswcnt ensure thread safety and
> > tp->lock guards access to tp->usesw and tp->counted, the broader lock
> > down_write(&block->cb_lock) is no longer required in tc_new_tfilter(),
> > and this resolves a performance regression caused by the filter countin=
g
> > mechanism during parallel filter insertions.
>
> You are trying to do two things:
> A) Fix functional defect when filters share a single tp
> B) Improve filter updates performance
>
> If you do part A in a minimalistic way, then IMHO it might be suitable
> for net (+ stable), but for part B I agree with Paolo, that it would
> properly be better suited for net-next.
>
> I focused my testing on routing performance, not filter update performanc=
e,
> I also didn't test it in any multi-CPU setups (as I don't have any).
>
> The static key was added to mitigate concerns, about the impact that the
> bypass check would have for non-offloaded workloads in multi-CPU systems.
>
> https://lore.kernel.org/netdev/28bf1467-b7ce-4e36-a4ef-5445f65edd97@fiber=
by.net/
> https://lore.kernel.org/netdev/CAM0EoMngVoBcbX7cqTdbW8dG1v_ysc1SZK+4y-9j-=
5Tbq6gaYw@mail.gmail.com/
Hi, Asbj=C3=B8rn, thanks for the comment.

I will keep the static key, and not touch the code in tc_run() in
net/core/dev.c, and we can make it without holding the block->cb_lock
by atomic_inc/dec_return():

        if (atomic_inc_return(&block->useswcnt) =3D=3D 1)
                static_branch_inc(&tcf_bypass_check_needed_key);

        if (!atomic_dec_return(&tp->chain->block->useswcnt))
                static_branch_dec(&tcf_bypass_check_needed_key);

It doesn't look good to split this patch into two, I will post v2 on
net.git with these changes.

Let me know if there are any other concerns.

