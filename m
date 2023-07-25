Return-Path: <netdev+bounces-20971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73BC762068
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAC5281984
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025582591F;
	Tue, 25 Jul 2023 17:44:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8525140
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:44:51 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1501BE2
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:44:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5222bc91838so3861231a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690307088; x=1690911888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f8Lnh2cN2fCwNiMV2rli+hamhX5V5blCl9Mb/T4hAT8=;
        b=ZdWQQuCOEbZslxacmZ9uIrdSmPA1M7KRTfmkFreCeiQb7D/CtXtgpNAhgOXamKDgKG
         4i1ag7fgSuYaAzc5jj4SJUpcXy6PX9t3LiKV6gzC7qvvS2rABKKK9o0qLsnVhL3ayfvS
         w95WEgqdhoPBqXhsD0ctSLtRLmFd307WO/Spo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690307088; x=1690911888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8Lnh2cN2fCwNiMV2rli+hamhX5V5blCl9Mb/T4hAT8=;
        b=dlkA1Tz/oIE3v0djBLn4IaG6k9d0P7DkuDWruJ9AbpX7g29fKhCmKs0/2qVtqzKpMX
         ricpxCQqtnvZ4wT9uwwomBQcnPR6G+eKjrLead06Z/ohtw29xWPpwzcr/ZVywSAKCpsF
         IxFlHDGlcsMFVil2CyDrTiHSZEqz7TdYzrdg281U5A9l1TstviWHl13Z2vqvh+kcApOS
         uZbnO983hSkL5RUVGeYzAPvCQ9mTvztiwkpbmkXc+RTgPb34tVEDfwpt0rSudw0yxptl
         8D3YLE5asZRx1jb0tl2PZkgNkcc+cAnLHNM641fOn2gdMToJYnm0fAiToIgQ/C519Gnu
         dC4A==
X-Gm-Message-State: ABy/qLaQXttv1y3VDR4yA2W43nKscqeXgsLbAS//oTzIvuin3nplfp3a
	h0Q52DK+CUvWtPFTw5O0XTnl+LeRbVbiJiv72VPb1nTJ
X-Google-Smtp-Source: APBJJlF2wTjNpBQsDYx0Q8dg/d/S0BDekj4xdhMf9dX2N8Vr/QthatLU5b7EoAfUCys1YtyI/CXyPA==
X-Received: by 2002:aa7:d14d:0:b0:522:4200:e20b with SMTP id r13-20020aa7d14d000000b005224200e20bmr3213142edo.36.1690307088614;
        Tue, 25 Jul 2023 10:44:48 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id h19-20020aa7c613000000b0052237839229sm2541159edq.21.2023.07.25.10.44.47
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 10:44:47 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-991da766865so969295666b.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:44:47 -0700 (PDT)
X-Received: by 2002:a17:906:2012:b0:992:d013:1135 with SMTP id
 18-20020a170906201200b00992d0131135mr11627983ejo.63.1690307087439; Tue, 25
 Jul 2023 10:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724151849.323497-1-jhs@mojatatu.com> <CAHk-=wiH27m7UeddwD8JPUxjxXHMs=kv8x1WrLAho=dZ8CUhyg@mail.gmail.com>
 <CAM0EoMmKa1U8nOKNnuXZ4UYB3S+eR+Xyt7VfmjSoCnR9xBBWYw@mail.gmail.com>
In-Reply-To: <CAM0EoMmKa1U8nOKNnuXZ4UYB3S+eR+Xyt7VfmjSoCnR9xBBWYw@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 25 Jul 2023 10:44:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi43Y7Osoa2NYr2FFxsajLjJUJSgAUdJmVPJfV8ggFYRg@mail.gmail.com>
Message-ID: <CAHk-=wi43Y7Osoa2NYr2FFxsajLjJUJSgAUdJmVPJfV8ggFYRg@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: sched: cls_u32: Fix match key mis-addressing
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	netdev@vger.kernel.org, mgcho.minic@gmail.com, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 25 Jul 2023 at 10:04, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > I would also like to see some explanation of this pattern
> >
> >                 handle = htid | TC_U32_NODE(handle);
> >
> > and why that "binary or" makes sense. Are the node bits in 'htid'
> > guaranteed to be zero?
>
> Per existing user space tools, yes - they are guaranteed to be zero
> (per my gitchelogy of both kernel +  iproute2 since inception this has
> been the behavior);

Ok, if the htid bits are zero, it's all good.  It's fine to use a
binary 'or' as a way to 'insert bits in the word', but only if the old
bits were zero, and that wasn't obvious to me.

The *normal* pattern would be to explicitly mask off the bits you want
to use, so that you don't get some random mixing of bits of the
fields.

Of course, that's a bit inconvenient here, since you don't have the
obvious accessors.

And while using bitfields would make the source code look fine,
bitfields are *horrible* for any ABI, since they have very weakly
defined semantics (ie litte-endian vs big-endian, and the *bit* order
is not at all guaranteed to match the *byte* order).

> > Because if 'htid' can have node bits set, what's the logical reason
> > for or'ing things together?
>
> Hrm. I am not sure if this is what you are getting to: but you caught
> a different bug there.

So what I'm getting at was just that *if* you can have mixing of bits
of that NODE part of the variable, I think the end result doesn't end
up being very sensible.

It's not that 'binary or' isn't a valid operation. But it normally
isn't all that sane to randomly just mix bits in these kinds of
things. What would it mean to mix node bits from an old value with the
user-supplied one?

So that pattern just looked odd to me.

                     Linus

