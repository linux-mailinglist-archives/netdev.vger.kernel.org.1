Return-Path: <netdev+bounces-57584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B158813853
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453471F21474
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172D765EB0;
	Thu, 14 Dec 2023 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJGmeuHd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8795DD54
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 09:18:20 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6d0985c70ffso3154480b3a.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 09:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702574300; x=1703179100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vWpDgoXyZ38lbgHyxbeCNHfQoRy1dptMeEz6eTAkxKw=;
        b=jJGmeuHdQ2+O9xPdkCRxk5J5L+RoANt5m1/+kMcbvSIZ+n5Mf0qXc6I9JNZW8XYoxT
         7pn6RF3F1YZBQaXPvrVEqE9EBNIvMff18igl11cGjO5X1hOxJc1pVFGGdiVqdn5y2zKo
         aitFXZ1mwjHimXkN0oR2qJjiNzl/ti2uxwc33lLjpLORrrEvahGSFDB026IZkJrTtZtQ
         XdKNMatwf5yLZlWYSarNN361vrWxDVJdox4IBlVslwLJ2BAClWGAE9XTGpYC0nsQRTbL
         2Qs+RFFUYqTwlQL2KfJeYQnRIjkLumU81iGxUUYZSz92p+i0EJxgE4kE3b9KBEU0hURe
         Yw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702574300; x=1703179100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWpDgoXyZ38lbgHyxbeCNHfQoRy1dptMeEz6eTAkxKw=;
        b=AiH0mtRpA0e5jG/xb3G8zq1c22n+OKTIyRwH14Yp/DM4RJ6Pj8ET37JOxW/wXS4Iru
         /ATg7VvDD+MQ6Ozzm3PKUm1gTfmSZDS8s4yhpk5aiKGTTzApwGWKGNsH1mfUiHjbE3AJ
         b5bV1lNkjDCNY5T0BBJtdLPpC1hBZNYv48hsJHR8ZURXntMf8Yj3QmnH9DhErEQzHjU+
         IfgrZeYiOLJ7SJ+Dq9nN8TQ2mnYspdQov2N2nPB6rVmeVO+TcDtv804axSJrUQWV+NEZ
         uXK8U9ccf5KQkuJ5ObdPaIGcOqYfWCs25g60KDykO/wKw5olRns5/LaG1iByi12F+zd9
         9usg==
X-Gm-Message-State: AOJu0YwHqOGt1mEjEt8v6YIh9knh4vZu/8umiiR3q5ruWszWjsx+Yhed
	1e+sVhqbuwuFEkAMg6X3W0E=
X-Google-Smtp-Source: AGHT+IE9VYLx+UKX0IIMDnQEqGHo6l3Mddv9YB3HkaxnVwqUZ1LOPq0RBKDBll5/gv0PisXdwSHE8w==
X-Received: by 2002:a05:6a00:18a3:b0:6ce:b86f:1b02 with SMTP id x35-20020a056a0018a300b006ceb86f1b02mr6508730pfh.54.1702574299847;
        Thu, 14 Dec 2023 09:18:19 -0800 (PST)
Received: from [192.168.0.4] ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7814f000000b006cdd00f91fdsm5753112pfn.185.2023.12.14.09.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 09:18:19 -0800 (PST)
Message-ID: <fecd5da8-4657-3454-b64d-d3f07b071a5d@gmail.com>
Date: Fri, 15 Dec 2023 02:18:13 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v3 2/3] net: sched: Make tc-related drop reason
 more flexible for remaining qdiscs
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <hadi@mojatatu.com>, Eric Dumazet <edumazet@google.com>,
 Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, pabeni@redhat.com,
 daniel@iogearbox.net, dcaratti@redhat.com, netdev@vger.kernel.org,
 kernel@mojatatu.com
References: <20231205205030.3119672-1-victor@mojatatu.com>
 <20231205205030.3119672-3-victor@mojatatu.com>
 <20231211182534.09392034@kernel.org>
 <CAM0EoMkYq+qqO6pwMy_G58_+PCT6A6EGtpPJXPkvQ1=aVvY=Sw@mail.gmail.com>
 <CANn89i+-G0gTF=Vmr5NprYizdqXqpoQC5OvnXbc-7dA47tcdyQ@mail.gmail.com>
 <CAAFAkD8X-EXt4K+9Jp4P_f607zd=HxB6WCEF_4BGcCm_hSbv_A@mail.gmail.com>
 <CAM0EoMk9cA0qCGNa181QkGjRHr=4oZhvfMGEWoTRS-kHXFWt7g@mail.gmail.com>
 <20231213130807.503e1332@kernel.org>
 <CAM0EoM=+zoLNc2JihS4Xyz77YciKCywXdtr8N3cDuwYRxc8TcQ@mail.gmail.com>
Content-Language: en-US
From: Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <CAM0EoM=+zoLNc2JihS4Xyz77YciKCywXdtr8N3cDuwYRxc8TcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/15/23 00:31, Jamal Hadi Salim wrote:

Hi Jamal,

 > On Wed, Dec 13, 2023 at 4:08 PM Jakub Kicinski <kuba@kernel.org> wrote:
 >>
 >> On Wed, 13 Dec 2023 13:36:31 -0500 Jamal Hadi Salim wrote:
 >>> Putting this to rest:
 >>> Other than fq codel, the others that deal with multiple skbs due to
 >>> gso segments. So the conclusion is: if we have a bunch in the list
 >>> then they all suffer the same fate. So a single reason for the list is
 >>> sufficient.
 >>
 >> Alright.
 >>
 >> I'm still a bit confused about the cb, tho.
 >>
 >> struct qdisc_skb_cb is the state struct.
 >
 > Per packet state within tc though, no? Once it leaves tc whatever sits
 > in that space cant be trusted to be valid.
 > To answer your earlier question tcf_result is not available at the
 > qdisc level (when we call free_skb_list() but cb is and thats why we
 > used it)
 >
 >> But we put the drop reason in struct tc_skb_cb.
 >> How does that work. Qdiscs will assume they own all of
 >> qdisc_skb_cb::data ?
 >>
 >
 > Short answer, yes. Anyone can scribble over that. And multiple
 > consumers have a food fight going on - but it is expected behavior:
 > ebpf's skb->cb, cake, fq_codel etc - all use qdisc_skb_cb::data.
 > Out of the 48B in skb->cb qdisc_skb_cb redefined the first 28B and
 > left in qdisc_skb_cb::data as free-for-all space. I think,
 > unfortunately, that is now cast in stone.
 > Which still leaves us 20 bytes which is now being squatered by
 > tc_skb_cb where the drop reason was placed. Shit, i just noticed this
 > is not exclusive - seems like
 > drivers/net/amt.c is using this space - not sure why it is even using
 > tc space. I am wondering if we can make it use the 20B scratch pad.
 > +Cc author Taehee Yoo - it doesnt seem to conflict but strange that it
 > is considering qdisc_skb_cb

The reason why amt considers qdisc_skb_cb is to not use CB area the TC 
is using.
When amt driver send igmp/mld packet, it stores tunnel data in CB before 
calling dev_queue_xmit().
Then, it uses that tunnel data from CB in the amt_dev_xmit().
So, amt CB area should not be used by TC, this is the reason why it 
considers qdisc_skb_cb size.
But It looks wrong, it should use tc_skb_cb instead of qdisc_skb_cb to 
fully avoid CB area of TC, right?

 >
 >> Maybe some documentation about the lifetimes of these things
 >> would clarify things?
 >
 > What text do you think makes sense and where should it go?
 >
 > cheers,
 > jamal

