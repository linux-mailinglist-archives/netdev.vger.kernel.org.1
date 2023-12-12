Return-Path: <netdev+bounces-56488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E5C80F1AA
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8BA1F21681
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269A277620;
	Tue, 12 Dec 2023 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="xbs+Qc1k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DAF8E
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 07:59:14 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-db548cd1c45so5335297276.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 07:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702396753; x=1703001553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLMOlesMGrIvIEeZU48KlTtonvU/4dgNPCmO39cP8fw=;
        b=xbs+Qc1kgxodGCQQMYGdgBPkzDprDZ36kOLBXOz74mHd19fYxkLiVdK2dCBmejjTm2
         2MilTeiJSa8FGujpPvtzVBPlP31UckDg8Apru08SFgeKJRkL6cmxu3IWDoOmBMxBYEwJ
         qn5XguQ7eKhxVbvI/G+vj/QxKeJ0yNghHrU+8D2m6rFuZTnH5fDNC8xBidaXfs81VNM1
         qMh6FY9giPCcz+/Pdtfr+02thSdFiAk3pRtP7hBa+4e2iSnVDv3vfn5uVpEBPGhaw815
         5Ve+nFqV9QVtdI6b/g5f9YZAVq5tBBMh0t7Y6wvbAVVsbLxGsEP7lcoTMtD/YskBJKK9
         eLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702396753; x=1703001553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLMOlesMGrIvIEeZU48KlTtonvU/4dgNPCmO39cP8fw=;
        b=xKQSATGSIFk6ECfqVvluecbzxZ3FN6SzyTOhNte0jK8SwjYtiDCE/tlg0nJT9CjBpm
         a6g+jtbh/Fz6hdYBbdV/Z3jSPmkX9ZecSnM02SE5Qdubzm7yeCTppgWGtmEg2flv4TZs
         DZzdOC6LPB6c35E6UOH4fDV6zec6NdBmBZ7wBvuDD8LhYnBooZCIoGJuq/uYNvKhIXMe
         VJdR+3olfPsfFg8NUlQ/qSG2upv0akzzM7ztjA4FVu7Xw1z7OGQokK1RU/Erzl/dU8+i
         8vlmmHJc06ujnTtlotkmXNAWMgHFhhEwpmLLnoGOy93zcdRxeYNJOQ9tylzgkzsQFAYu
         imVg==
X-Gm-Message-State: AOJu0YylR47EBriU/3Y4QsEreXthz4tKUvdVDiNOx6K9naFuXUrRpaEF
	/TGXlBgLojBK+2im5Due8+xwkqNkVzGWoVPVUGrAxg==
X-Google-Smtp-Source: AGHT+IHOrPH2JJdYupJvLk9itQssI3tY3KCDfTr1MKaatuyskcFI99hjm8Q6yZdBHOj0/rdU7c1DroXbNK4LLpcgs/k=
X-Received: by 2002:a25:b61a:0:b0:dbc:bf55:e017 with SMTP id
 r26-20020a25b61a000000b00dbcbf55e017mr541144ybj.56.1702396753117; Tue, 12 Dec
 2023 07:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211181807.96028-1-pctammela@mojatatu.com>
In-Reply-To: <20231211181807.96028-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 12 Dec 2023 10:59:01 -0500
Message-ID: <CAM0EoMnvR7R+fhBzE7CHdrFkCwKYgt=NiV_EfhcGEUZWoA1v8g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] net/sched: optimizations around action
 binding and init
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, marcelo.leitner@gmail.com, vladbu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 1:18=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> Scaling optimizations for action binding in rtnl-less filters.
> We saw a noticeable lock contention around idrinfo->lock when
> testing in a 56 core system, which disappeared after the patches.
>
> v1->v2:
> - Address comments from Vlad
>

For the series:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> Pedro Tammela (2):
>   net/sched: act_api: rely on rcu in tcf_idr_check_alloc
>   net/sched: act_api: skip idr replace on bound actions
>
>  include/net/act_api.h |  2 +-
>  net/sched/act_api.c   | 76 ++++++++++++++++++++++++++++---------------
>  net/sched/cls_api.c   |  2 +-
>  3 files changed, 51 insertions(+), 29 deletions(-)

