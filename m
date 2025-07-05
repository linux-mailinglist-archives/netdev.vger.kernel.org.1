Return-Path: <netdev+bounces-204305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713B1AFA05C
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 15:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65C33B2BCE
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 13:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C75119B3EC;
	Sat,  5 Jul 2025 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="R0JfRKgi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90193134A8
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751723972; cv=none; b=blaSg48GZA6urIvT286kw8gwk3yUWYe4pYuTfUo8sA/1mcVSpMMPuC2d6iPn3lyVNmGV6ECnmL1WAPtQ9o2gBzmDYq3Al+9WtAOHYPox7m2dMVoqzlwVJ/gudD6UJ0loL9J2WzgcTSUdOe76IrUAWz4Tws5uNgT3LZv8lhHT4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751723972; c=relaxed/simple;
	bh=Hfa7K9tsCT7tpi1elmIF6vRXQkM+FAXCJQH90EedI4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeniIq3xn6k38nxcCQn5g2+wAMBS5u5m4nDQuB8sBqKlmePuyYw6Kw7jnr8amEFly6L+8Z9uX24vYxpL/vS7eFbyEnY8hRno2y1DLA6fMVuD7dmJO7tf1Vd+1tbA41M6ipCWIE25tzP9G5OJCZ0l0F6Qi0fuaK3T46l7oxPwhUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=R0JfRKgi; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748feca4a61so969546b3a.3
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751723971; x=1752328771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hfa7K9tsCT7tpi1elmIF6vRXQkM+FAXCJQH90EedI4o=;
        b=R0JfRKgiXVo/3GXgoQ1A43+4/UxAsEerJkQCEA5jU68tudTRTI/U1jriYPTg8PU8A3
         QUztqAxPgj6GFcapxPu0dU2zeYk+zOuw5ecBHoE1/3ZBM9J2O3oPfVy29qVHlGhlA+rN
         agQODAPX4f3KCfT1utLVz2YzMSBxLNtJAh6cJlSgo9FLjNoKp4O93Aek5bzns+VJUqt4
         t89ClTuSNcQauqLJbJIDCQnrkQVwMwPW3us+SDWcz2boIGeOc5KcGm7LP0off8/45fO3
         jZm0v0pZAy0zj3vX7KzGc5n7MAQkdQNPozBf0K+riDI0J974w0fqQv8q7mBmhBe91v46
         wAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751723971; x=1752328771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hfa7K9tsCT7tpi1elmIF6vRXQkM+FAXCJQH90EedI4o=;
        b=DTruCmdEH7Di0lbZMfp/kyw1a/1sTDBYZWW5QPNi0SMgQjr2viuDxo9bUC6Zm1c5M7
         ygiTj3cGu9b2EIr/KDiqILiijZF0Utb2wRK4zVxeRctJ2G++LIQ5fmFAIY6KvyIJVGVT
         hOliPLCwId6pPAR/l+CDFpg7/gMLgH6klwFslg/X4PXGCO4T8TRMPkxxsJghlasDmd+W
         iUFcpbdHJObQGNF9KLrAk+rCgmuQ6RmUvP6E7Z3MwOzbSGxJORjIBDQAzGUdh0A7son5
         G6pphXb84Rl3oQ0++4E4rqZiM2VDP/SZ/Ubn7Aru29+kVFtH2U8rNhoj5NVed+Tg9ovc
         2bnw==
X-Forwarded-Encrypted: i=1; AJvYcCUNc3T6ecGtx5Hf4aLQfBBUvI8lsFBax8PS+th2o4sq/WxqRfTBKuCpIhN5Zv8M1e/SrWpDOdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN+Qz6Efa36Pq042jFpqL5tzlHFmENetzhC2iVcqc/Au9GxVGB
	agFFY9GeJ4EjUUQT5CWDjfpHwzMq1ZkNldFpP/nwc/CISWMNkNXX/J0v5ASx/aQSji2ZPLx33q1
	3UFR8+NF4gUxom7ztiC3ZD0Ha8gB0h7fQBnt7f8X0OQF8ytYmxbDF4g==
X-Gm-Gg: ASbGnct1f0VJ/4n3HoG3l3FwbjxdS94HnypNaHLUAg2fGioPqdEIQmoQoxqWR359Mu9
	+Kqc/QOeavf9wsVcK/iuXzWW6d10aU0XQAlVHhp5ruNr2KOdnXxClpGJTZWbafI8jKUutrwX3bp
	oQe0XQSJBvf/etA7jxP4+BpZ5FFXhEnA6pv4WCWQIrqw==
X-Google-Smtp-Source: AGHT+IGqC/1uitnb5fUKNTcl0PthQF1yxz5P5Q3mkVvNY0INFRPePnrT40jlCyplS57rhErie3F7gcdClboHB3N6yWs=
X-Received: by 2002:a05:6a00:194a:b0:742:3cc1:9485 with SMTP id
 d2e1a72fcca58-74ce8a8ddb0mr7121083b3a.12.1751723970850; Sat, 05 Jul 2025
 06:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGhr2R3vkwBT/uiv@pop-os.localdomain> <20250705011823.1443446-1-lizhi.xu@windriver.com>
 <aGizFhZwnPo98Bj/@pop-os.localdomain>
In-Reply-To: <aGizFhZwnPo98Bj/@pop-os.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 5 Jul 2025 09:59:19 -0400
X-Gm-Features: Ac12FXxtcKFKBXIaMag0cucTZ_RoWP7mX93yvxNidg1N68n0h_2He8IWpkc3HZw
Message-ID: <CAM0EoMneGBL0OkRC_if5VEax-XXXnFAwtpij1J3kOq9NbEPmrA@mail.gmail.com>
Subject: Re: [PATCH V2] net/sched: Prevent notify to parent who unsupport
 class ops
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Lizhi Xu <lizhi.xu@windriver.com>, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 5, 2025 at 1:07=E2=80=AFAM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> Hi Lizhi,
>
> On Sat, Jul 05, 2025 at 09:18:22AM +0800, Lizhi Xu wrote:
> > If the parent qdisc does not support class operations then exit notify.
> >
> > In addition, the validity of the cl value is judged before executing th=
e
> > notify. Similarly, the notify is exited when the address represented by
> > its value is invalid.
> >
> > Reported-by: syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D1261670bbdefc5485a06
>
> Maybe I didn't make it clear, I think Victor's patch also fixes this
> bug.
>
> https://lore.kernel.org/netdev/20250704163422.160424-1-victor@mojatatu.co=
m/
>
> Can you check if you still see the crash with his fix?
>

syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com (in this report)
is part of what Victor's patch fixes (as listed in that patch).

cheers,
jamal

> The reason why I am asking is because his fix addresses a problem
> earlier on the code path, which possibly makes your fix unnecessary.
> Hence, his fix is closer to the root cause.
>
> Please test and confirm.
>

V
> Thanks!

