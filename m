Return-Path: <netdev+bounces-202391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC0EAEDB26
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F11E3A885E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AAE25F7A6;
	Mon, 30 Jun 2025 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DDSvJ7h7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D6F25E827
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283261; cv=none; b=aGfoKR0JHSMMHoIC1CyPI73L2HcZXD7j91w8qgZ0A5Z0t3CERVma0++ec02ZP+zRG1B9IgBy2a0MF53t58r8Y0dwnpPUdJ1ey/leaKX7tK9asv33uWs97lfSmVxLq6GpMbwL/9FvBKKScYIdjXJVyh6nu7VrGGJp9La7Irk02og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283261; c=relaxed/simple;
	bh=PuucDEXdElMl2LXXetGT+YaBlmlXvYx8GrwmBkmp1oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gsg5ldkxjZLysH6gOGVsPHSwOwJ+UmSL0kv+df8E9vt+zNTBSxe0eX8M1dRzVCLtzaG61vDIttEuhuTdMvSY9VlVb6LCLPgsbMIh0tan0RgCn8wCxb8/trh9eapkuDaEPHlJDJOu0L/diCxXTougC/V6qPVPUHxXHKgNR0xTjt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=DDSvJ7h7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-749248d06faso4521823b3a.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 04:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751283259; x=1751888059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmDDTn+kk7zPY32MQypCfgx0gvGJYf4dOkvfGVm0t/Q=;
        b=DDSvJ7h71wu4JNEe4ucfXOmTTKSurYN8eHb2yFKI9yBDU0eF7CMec+xdxeVn2WA5J/
         XBIhxcisw9coKpD/LcW7sZ+5sWbPGppQc831ygpvWxOiOYu4B5r4Tax2i+EwMet1Y+on
         7wkrisXTISkzp7UFPlBcaK2g1HiyEI9fxrQFTaN+Vv80Rwgl2dM/rvrzlrvK/GUe47Cm
         OwmgKoU/RHjtpy6X+pxwIeFeC5eItV1b0oF6sNhcTHhp581Bh+rqV23dFtOR5+vMEdx7
         oyeuTswUdlnD8Q61yLTJoL2FXNSMgk2Iv63nzBxsn8eucjL2tblFyBioonLF0b5e79Ch
         xEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751283259; x=1751888059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmDDTn+kk7zPY32MQypCfgx0gvGJYf4dOkvfGVm0t/Q=;
        b=sI/J/a4mFUcdXuCAs7pFdFvHEkcWQE11UoyV8Kt2qzBACj315vkm/63LvORi4G4bpM
         dmTetl/7e3zYqujtKcjYedrtOp7xbpkFJY6epWgRluiAIR/lhl1d3h/LShW68k4nK8nv
         Xw/HBClZrt5wjh4o2w5HRu6Ks/h+AptjaLFlM8B654YfTnD0g30BP964lZcD8xp8+1as
         2JFkusG9wbgPeI6oukgoBoZvTOGzfdrkgnsf3i3HZgze4HPv+7IZu46osqPgScEHW/WA
         dj7vc39chh01/VNaaM66phg3Q7tFw/3NExNeXPbtqf/YFusJkFRRQK6ulK7NWTovVTo5
         Jeeg==
X-Forwarded-Encrypted: i=1; AJvYcCUpIQ0oBc9ULyx0KeWDkgjXvCynZTE6/hxCxSGH5lIGDTgaYtD0Pq9CY5+Cc8K4u6DKVkddLbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpzYlPCUve1btN2Nzfhdl976+5aRaCcGFu6mHp6sMqAFEmesJI
	eUlmlPTfbM0WgByfRRPNN7omh5LvjpeMzQGZnmEOO07W451dYpZZhqg5rCcY8QtC14J6gZkIl+O
	ZSAUOpsWI/6vcNQNJlkyy7cADZSy+oaHK6qsvwBOA
X-Gm-Gg: ASbGncs25msL5CbzwCg2Bvc3ORWDzNlwOLNJAZcIpQ6lxAMUUe0Y8nOqgchF6artYBo
	/l1oJICGiUg3oUAFUAF+hj7MrSG2RSZFtHpafY2IRjmUUmqEt5veIyW31+dr6l+I+xttpU3IgBv
	KvGC9IfjBIHWgShNnqK0igyiRcYgvb20cvjMBxc0efv+p1BQdt39Vt
X-Google-Smtp-Source: AGHT+IEhAzaHopVsnLFQbixGoV0+h1TlOeoZgtwdX1pF9Lowhq5wUnGCqa0OH7JWT1cw8opTzeFowDD3vfMFTtjuyHU=
X-Received: by 2002:a05:6a00:1992:b0:749:ad1:ac8a with SMTP id
 d2e1a72fcca58-74af6f409ddmr18606118b3a.11.1751283259047; Mon, 30 Jun 2025
 04:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain> <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com> <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com> <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
 <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
 <aGGZBpA3Pn4ll7FO@pop-os.localdomain> <8e19395d-b6d6-47d4-9ce0-e2b59e109b2b@gmail.com>
In-Reply-To: <8e19395d-b6d6-47d4-9ce0-e2b59e109b2b@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 30 Jun 2025 07:34:08 -0400
X-Gm-Features: Ac12FXwpqNUX5SjyhA34p-svHSBT6dsArCtgS9xyumEFFugk-ZmDNBv4z5VpfZo
Message-ID: <CAM0EoMmoQuRER=eBUO+Th02yJUYvfCKu_g7Ppcg0trnA_m6v1Q@mail.gmail.com>
Subject: Re: Incomplete fix for recent bug in tc / hfsc
To: Lion Ackermann <nnamrec@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, Mingi Cho <mincho@theori.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 30, 2025 at 5:04=E2=80=AFAM Lion Ackermann <nnamrec@gmail.com> =
wrote:
>
> Hi,
>
> On 6/29/25 9:50 PM, Cong Wang wrote:
> > On Sun, Jun 29, 2025 at 10:29:44AM -0400, Jamal Hadi Salim wrote:
> >>> On "What do you think the root cause is here?"
> >>>
> >>> I believe the root cause is that qdiscs like hfsc and qfq are droppin=
g
> >>> all packets in enqueue (mostly in relation to peek()) and that result
> >>> is not being reflected in the return code returned to its parent
> >>> qdisc.
> >>> So, in the example you described in this thread, drr is oblivious to
> >>> the fact that the child qdisc dropped its packet because the call to
> >>> its child enqueue returned NET_XMIT_SUCCESS. This causes drr to
> >>> activate a class that shouldn't have been activated at all.
> >>>
> >>> You can argue that drr (and other similar qdiscs) may detect this by
> >>> checking the call to qlen_notify (as the drr patch was
> >>> doing), but that seems really counter-intuitive. Imagine writing a ne=
w
> >>> qdisc and having to check for that every time you call a child's
> >>> enqueue. Sure  your patch solves this, but it also seems like it's no=
t
> >>> fixing the underlying issue (which is drr activating the class in the
> >>> first place). Your patch is simply removing all the classes from thei=
r
> >>> active lists when you delete them. And your patch may seem ok for now=
,
> >>> but I am worried it might break something else in the future that we
> >>> are not seeing.
> >>>
> >>> And do note: All of the examples of the hierarchy I have seen so far,
> >>> that put us in this situation, are nonsensical
> >>>
> >>
> >> At this point my thinking is to apply your patch and then we discuss a
> >> longer term solution. Cong?
> >
> > I agree. If Lion's patch works, it is certainly much better as a bug fi=
x
> > for both -net and -stable.
> >
> > Also for all of those ->qlen_notify() craziness, I think we need to
> > rethink about the architecture, _maybe_ there are better architectural
> > solutions.
> >
> > Thanks!
>
> Just for the record, I agree with all your points and as was stated this
> patch really only does damage prevention. Your proposal of preventing
> hierarchies sounds useful in the long run to keep the backlogs sane.
>
> I did run all the tdc tests on the latest net tree and they passed. Also
> my HFSC reproducer does not trigger with the proposed patch. I do not hav=
e
> a simple reproducer at hand for the QFQ tree case that you mentioned. So
> please verify this too if you can.
>
> Otherwise please feel free to go forward with the patch. If I can add
> anything else to the discussion please let me know.
>

Please post the patch formally as per Cong request. A tdc test case of
the reproducer would also help.

cheers,
jamal

