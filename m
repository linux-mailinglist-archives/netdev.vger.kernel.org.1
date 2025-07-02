Return-Path: <netdev+bounces-203378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB98AF5ABB
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603941899448
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2052BD5B5;
	Wed,  2 Jul 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="O2RaDGjY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E32BD5AE
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465584; cv=none; b=osfrYuCnKa+iWla7zk0tQMffPKAeUpbON7ZRmflc9raYTSLc8Ns/MeWipIOkSGUGzR5jEU84+ru0i+Hqo7GvB+Bt4lf0Yg+GC6j089kcxOFoAqvSAmzW8TJxsLskWypAkTP2SpA1XKWn/Sq7+pUanhQZgXTr0FiUFI3JpwEkI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465584; c=relaxed/simple;
	bh=XqVM6L44l/3DMRjR6nwQYxZk/NlWEnr50qImnhlqP9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOHscgSA6Rmj3ACVomzafYTlpETp75tfQqKBfIDV4WlVc60K43eJpcV9BpXYO5snZOd1r5KsmTAtGtg0c2R3K1hYu5Cg1hiTxPn2hKb8GkgM/CwTHZLClSh6Qv5tMcdU58YGR4B7SQ87Pn8/YGUwOqYwYa2n6Z+TkdTExVzclDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=O2RaDGjY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747fba9f962so6391221b3a.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751465582; x=1752070382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s7SABiNVY2alIsNNW/KkyyFQ8Sz0JJJXnA/VmE6G/E=;
        b=O2RaDGjY93YOCrcdLxQng2HIkYnDgqIvwVJ/IJurg22cuuEe2J/3UCFOJfzOkM7whq
         s+EIhXOOl5yivZkaNiUQuJJKgz1uxLb97RLiteQtmVopIQ8V50Gd4MU2yxr7Ihl3xq0o
         ufsHlGjZ2IgcMs+oa9nDjjxTMChUdV+1FBgKjawxBFfpTvVsyVs8uRYojA1upJ+at8aL
         wLBtXIahwW7Z8VrFJAr1Pz2yFdpY1+/0LjJ9+8TMytDbwI/wLXbLWEkSpO+lB2w0IV+A
         2f8MNSDqCVVvEMHgumJmImaYUngtwIf2c8t/+aUyhfqdAk36OJZsZ1SGlSL8EMpXei0/
         Z/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751465582; x=1752070382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+s7SABiNVY2alIsNNW/KkyyFQ8Sz0JJJXnA/VmE6G/E=;
        b=ECwVCJSAI/IDFkbjB2JEoG40GhCYOW+oFABYKTYK6mws56AxpQZjaCqRbdIvBqNXw/
         bEYCh9noJzgiqKVQIP7/MeWeUZo8dNN3r/67lW4TMR5Ru23BNBgiRoNn0elnYnmlMsHn
         BLBWfbehzc/9fgJbgmFaj7c2KxauZ7FduvmTGaxEmHdYMvHdykg9sgpIvWN/Za+snzq1
         qSIUCzFUPCyTaRTei20jfM9VYAXoL0zt9WImIK0rL9bSkqF6G8VxVCy3fliQ9Wn/d1fM
         zVPaaNnCOrDqPg6CqALjcU0ZoGoWefZVMBRm4ysoQkUxQo/Bk8nIOASgd8o8emJhFNAk
         Cfag==
X-Gm-Message-State: AOJu0Yymz8Tp7NzsUJIvRbFDVOMGXYnWgxCwmQeTslu+V0orOcFKFWko
	b7rFu8Qh1NAbFMBul31vxVLSmEmc8U0gCTCBg9gBdHO9x0VlPCji49Gp09IUTjdntpBqn7XDTTF
	A+IK5Ccn8dp6Xit+lhzxPoo3zRBKylmN8I2yKYQswOdQrB+aQCYI=
X-Gm-Gg: ASbGncsRvPKFjdId83tnyEC10VyYs44M5BNc7WjPl2XBbG9EBOhDCrJmgp2orvouP6w
	c3yxCcf+QAyo86CSmXSJZwzJh3Xx1rIDwnoAjdmFlzS0pUuZTUF6r1QpniqDzuhI7elb06RpWio
	Ty33UNzGSL5JCYQJ/LgADRAZksZ0PSusuoNPgICOoUYMyNx2ECzSzD
X-Google-Smtp-Source: AGHT+IF2ddilI2yH/sDYLyY/CkRQjHNUJO1YS6X8bcdua2HbOAH4herrcSNs9KEjhAuXYiM+X0S8M3gwiVuCe2S1j7g=
X-Received: by 2002:aa7:8881:0:b0:749:1e60:bdd with SMTP id
 d2e1a72fcca58-74b51f48d5amr4052733b3a.2.1751465581833; Wed, 02 Jul 2025
 07:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
 <20250701231306.376762-2-xiyou.wangcong@gmail.com> <aGSSF7K/M81Pjbyz@pop-os.localdomain>
In-Reply-To: <aGSSF7K/M81Pjbyz@pop-os.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 2 Jul 2025 10:12:50 -0400
X-Gm-Features: Ac12FXyyDRMP1y_1Z5fNY3BcfnQyuoM33Te9W9Z-T9qnoFhid3qZ7q2ZssB73r8
Message-ID: <CAM0EoMmDj9TOafynkjVPaBw-9s7UDuS5DoQ_K3kAtioEdJa1-g@mail.gmail.com>
Subject: Re: [Patch net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, will@willsroot.io, stephen@networkplumber.org, 
	Savino Dicanosa <savy@syst3mfailure.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 9:57=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> On Tue, Jul 01, 2025 at 04:13:05PM -0700, Cong Wang wrote:
> > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > index fdd79d3ccd8c..33de9c3e4d1b 100644
> > --- a/net/sched/sch_netem.c
> > +++ b/net/sched/sch_netem.c
> > @@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
> >       skb->prev =3D NULL;
> >
> >       /* Random duplication */
> > -     if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q=
->prng))
> > +     if (tc_skb_cb(skb)->duplicate &&
>
> Oops, this is clearly should be !duplicate... It was lost during my
> stupid copy-n-paste... Sorry for this mistake.
>

I understood you earlier, Cong. My view still stands:
You are adding logic to a common data structure for a use case that
really makes no sense. The ROI is not good.
BTW: I am almost certain you will hit other issues when this goes out
or when you actually start to test and then you will have to fix more
spots.

cheers,
jamal

