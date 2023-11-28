Return-Path: <netdev+bounces-51805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7397FC408
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD60282BEC
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 19:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F7446B86;
	Tue, 28 Nov 2023 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcWcZ/xr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3E41707
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 11:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701198680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icVcrPvb7mhccbOxNNk26SEmQa+m5qfERMbDOHpAP2Q=;
	b=CcWcZ/xryhxC2QcRU4ZS+y/2UhAwJbMoELzs7thhDVHcs5IYx4AsglR3DwrsSVSUqRBs/U
	E9+CEz4JHK5axBe6/3hgMW5Kyb1+ar5MLTsCVBHEWrmpip8S9fv8ruyw7yjZ4wo2JLodak
	c290ON19kLjUG+u/t9wQlbcRfUKk9zo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-KKQgqdNSNICJbuuPIDQ9qw-1; Tue, 28 Nov 2023 14:11:18 -0500
X-MC-Unique: KKQgqdNSNICJbuuPIDQ9qw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54554ea191bso3911477a12.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 11:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198677; x=1701803477;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icVcrPvb7mhccbOxNNk26SEmQa+m5qfERMbDOHpAP2Q=;
        b=nA0Jf1YTF3snigWtvr1F2Esspr9QJilcCs3xGwiGg+4CgJ//XfA1tFls+cOp55TZN8
         RTsPXj5fLsMoRwtVomjAP7C3/5B6DemYDo83jRvReb+5+ok071kUk+fiKKrOocoE6g7p
         lRsAXxxKYDklfUA6eNYI9svQQQ9pNOrxBhKjbbju/YQULmrlZgppRwG5E83uegtPcWs4
         NrmSec2XghzFSdzZ8N+UtVM/ovcTQG5Jrr6lgVHS1GyyxRd3O72sYWx4ys9oEFHtQLG2
         wIvbTrfNYOHE4UYf2cjl5lMw75pCJpyFEkNBcQTSHBJ7NtC9sT/4ENLTt10Iv27UTxoF
         RGAw==
X-Gm-Message-State: AOJu0YzcG7huhHr6ZqFsl+RcchnbqOjsN68wBwuXs7mQjwbiTlMBO/c/
	rlsIbfDSidWx+KtgGHquJ1ski3r1VvqAxprvhn7YsFQOT2+RNxxNlajcHLocVVi5xneviqr6nRi
	MsI1RF02avLsJmP/8K29Cb5LCJuR3LsxI
X-Received: by 2002:a05:6402:1c1c:b0:54a:f68d:6e00 with SMTP id ck28-20020a0564021c1c00b0054af68d6e00mr11350774edb.24.1701198677131;
        Tue, 28 Nov 2023 11:11:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbEdsvwTVe7ku0tG0izZhoBbAbFCBGxukHxiauiZ2EH0eLYsUx1QWibPCq/Rl/+2DQq+FEeg1uG4tU7qSIvU0=
X-Received: by 2002:a05:6402:1c1c:b0:54a:f68d:6e00 with SMTP id
 ck28-20020a0564021c1c00b0054af68d6e00mr11350761edb.24.1701198676838; Tue, 28
 Nov 2023 11:11:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Nov 2023 11:11:15 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20231128160631.663351-1-pctammela@mojatatu.com> <20231128160631.663351-4-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231128160631.663351-4-pctammela@mojatatu.com>
Date: Tue, 28 Nov 2023 11:11:15 -0800
Message-ID: <CALnP8Zbh1Jep5daNKZhBAKBZ3Y1R2MZgzapa1r=9ZmKhei1Qcg@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 3/4] net/sched: act_api: stop loop over ops
 array on NULL in tcf_action_init
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, vladbu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 28, 2023 at 01:06:30PM -0300, Pedro Tammela wrote:
> @@ -1510,10 +1510,8 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
>  err:
>  	tcf_action_destroy(actions, flags & TCA_ACT_FLAGS_BIND);
>  err_mod:
> -	for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
> -		if (ops[i])
> -			module_put(ops[i]->owner);
> -	}
> +	for (i = 0; i < TCA_ACT_MAX_PRIO && ops[i]; i++)
> +		module_put(ops[i]->owner);
>  	return err;

I was going to say:
Maybe it's time for a helper macro for this.

$ git grep TCA_ACT_MAX_PRIO
include/net/pkt_cls.h:  for (i = 0; i < TCA_ACT_MAX_PRIO && ((a) =
(exts)->actions[i]); i++)
include/net/pkt_cls.h:  for (i = 0; i < TCA_ACT_MAX_PRIO && ((a) =
actions[i]); i++)
...
net/sched/act_api.c:    for (i = 0; i < TCA_ACT_MAX_PRIO && actions[i]; i++) {
net/sched/act_api.c:    for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
net/sched/act_api.c:    for (i = 0; i < TCA_ACT_MAX_PRIO && actions[i]; i++) {
net/sched/act_api.c:    for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
...
net/sched/act_api.c:    for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
net/sched/act_api.c:    for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
net/sched/act_api.c:    for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
net/sched/act_api.c:    for (i = 0; i < TCA_ACT_MAX_PRIO && actions[i]; i++) {
...

But then, that's exactly what the first 2 hits are :)
So AFAICT this loop can be written as:

struct struct tc_action_ops *op;
tcf_act_for_each_action(i, op, ops)
	module_put(op->owner);

Thoughts? It would be iterating over struct tc_action_ops and not
tc_action, as in tcf_act_for_each_action() (which is the only user of
this macro today), but that seems okay.

  Marcelo


