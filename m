Return-Path: <netdev+bounces-56534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670E280F43E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 18:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BC6B20B58
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1347B3CE;
	Tue, 12 Dec 2023 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ezieIPTO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8B0B7
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 09:17:01 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c629a9fe79so3204566a12.3
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 09:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702401421; x=1703006221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmlBGiLnTXufZhhYVxstUsh6oXrKrQ3/N468H8ZSHWs=;
        b=ezieIPTOik80v6zCyu2OCF2cSr80M7p+w44R+M4yE5WXp5xLHo1bW2Y+NJAxlftwL1
         XHL3/Xtdgxy9aykPuIUBAVMYXt86LaTKRYWO2UvmGh7G0/1JsGsI+pRyYEOByH51QJri
         fBmrZBhx4zu2QwhxY3jpzgFhGazl9HZa+T3fOCDQl8KF9y01o3Eng964k4opmY9j20ZQ
         ZbtE9/Pbpq/FP6K7pzxV5uOG3lR7rvpLeDVOAASMMaZ1vFcHaabLzk9IGNB7aqqO5ays
         rmrUMZzOVJh2P0PTwtvlrEWn/yH2mM65Wun+r0tZM2PIYFtHJXoYPQD2MZT7EERoTdBp
         6j6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702401421; x=1703006221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmlBGiLnTXufZhhYVxstUsh6oXrKrQ3/N468H8ZSHWs=;
        b=gzohV/hzLY8z4NIpSMd/Y2dQbHyxM/9fmBhng55Q4YkOrGoZoo08rUGKY1tSGzRKVb
         XKDp4/+alkczN1148+5gBaWaZJtXDVeq09Lc10k2H67SOPHeFlY3lEpAzlaKGKGEW2a3
         DWR6sAOyYk5qoA160WEZNr8x+OGNoh+7mm7fA255ejHui99jWtBP0GTJj+CIVRneTA2n
         0C5bFSJuREUOGTTfEb7cGgVh4yBm7KYZXSI8u16A56aEJaUAAjdesTb3xC34czNM7Um1
         NLfg6pOm6uMdg/hUmuwPkO/+IQqwmoGQgPR4Pkq7KeJg74rt103jtY2Mwv22qekD1e+x
         0uTQ==
X-Gm-Message-State: AOJu0Yy7vEOYVlMiwBw0e8eTINNRWkQZGQ4fLhubqGCN9t/lGzmxLk3k
	/PHwMhWMLRAAD+zlY7KJRUlg/YNQ80Arf8xW3VLNnw==
X-Google-Smtp-Source: AGHT+IFcFLHr3MZNFX/DEUglm0YJ6O1jW1S1pG+UthpP4NBXdubMKYHxvC45FfDYqVvC7qSBjvu7VSPZ0EzJXQsKCcM=
X-Received: by 2002:a17:90a:d102:b0:28a:fc:5cda with SMTP id
 l2-20020a17090ad10200b0028a00fc5cdamr3000921pju.89.1702401421046; Tue, 12 Dec
 2023 09:17:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205205030.3119672-1-victor@mojatatu.com> <20231205205030.3119672-3-victor@mojatatu.com>
 <20231211182534.09392034@kernel.org> <CAM0EoMkYq+qqO6pwMy_G58_+PCT6A6EGtpPJXPkvQ1=aVvY=Sw@mail.gmail.com>
 <CANn89i+-G0gTF=Vmr5NprYizdqXqpoQC5OvnXbc-7dA47tcdyQ@mail.gmail.com>
In-Reply-To: <CANn89i+-G0gTF=Vmr5NprYizdqXqpoQC5OvnXbc-7dA47tcdyQ@mail.gmail.com>
From: Jamal Hadi Salim <hadi@mojatatu.com>
Date: Tue, 12 Dec 2023 12:16:50 -0500
Message-ID: <CAAFAkD8X-EXt4K+9Jp4P_f607zd=HxB6WCEF_4BGcCm_hSbv_A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: sched: Make tc-related drop reason
 more flexible for remaining qdiscs
To: Eric Dumazet <edumazet@google.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, pabeni@redhat.com, daniel@iogearbox.net, 
	dcaratti@redhat.com, netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:57=E2=80=AFAM 'Eric Dumazet' via kernel issues
<kernel@mojatatu.com> wrote:
>
> On Tue, Dec 12, 2023 at 5:28=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
>
> >
> > So when we looked at this code there was some mystery. It wasnt clear
> > how to_free could have more than one skb.
>
> Some qdisc can free skbs at enqueue() time in  a batch for performance
> reason (fq_codel_drop() is such an instance)

Ok, makes more sense, should've caught that (there are others like taprio).

> I agree that all skbs in this list have probably the same drop_reason ?

It seems that way. We will review all the qdiscs to see if there's any
exceptions.
Thanks Eric.

cheers,
jamal

