Return-Path: <netdev+bounces-20520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0A775FE80
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68F2281579
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDF0FBED;
	Mon, 24 Jul 2023 17:50:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104C9F9E1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:50:56 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD051993
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:50:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992ca792065so783745166b.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690220991; x=1690825791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AYN964hrT/NuYjnAYmM/il9vZxwpnJ5tC+uiPVyfoow=;
        b=Q5cHbCJEfP2MMGtnlk1W7ovcki5vpfCuBRyr0WmA5pL2iCqORkTVT/+8w6S5IRU4AY
         gGbZodrMT+ZhAxvyasfCkRaXxJkl8Xe7GBgM1GZ0q1wplu62sPxxz3rOYIZnzpdwK0Dc
         mkRdqBoh0Kj5CyWM9oowhACg2nwBM41+TQQpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690220991; x=1690825791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYN964hrT/NuYjnAYmM/il9vZxwpnJ5tC+uiPVyfoow=;
        b=HMe4ObZw04OspurZYVXCywpQpQ09FzfeV67EihG1BkHxq9nlhUo/2heb6AzKpUKFfg
         1Cvzma7pXMtJg6rktRN1aYAcJELk5XGtxcQzaAqKR+tD+L4k3wkdj/Zg16X/lyRBCsTJ
         JX2EyeTU9utr5F5ioy3p2JZrxQ1rtgUA36TkLhN4B7i4QYjKuoSz/IFEemx/vWWMhka/
         LTvlykrv+U02P92xHhAFZ3NVv0GzkGp5q8I012J43Y57P1k+iBsYiaIAD4qdPiexmRLK
         o6buT/tTylLD2OKMIusiC9007gOk4fe5QVLU1nJjzXbT+1Zt6sgTfxCk1rzXt5m/NNWj
         2UrQ==
X-Gm-Message-State: ABy/qLYoHqq9BbEZzAlj3GbQlVG66je0/WeVnsjHP43sI/Qzu3cLKCrz
	kdleTPEkJM/Hqtx85o99PyYJA37gLMUQNqa4k1Vf6EDL
X-Google-Smtp-Source: APBJJlFT5sWgVZKcMl0WT5GwYfLiL+FC8wrZnMTvNTTHlO5jBqzE8DYxN/NaKLmK6bjqf2QsHa9MRw==
X-Received: by 2002:a17:906:304f:b0:98e:1156:1a35 with SMTP id d15-20020a170906304f00b0098e11561a35mr10702601ejd.74.1690220990795;
        Mon, 24 Jul 2023 10:49:50 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id gs18-20020a170906f19200b00993150e5325sm7024633ejb.60.2023.07.24.10.49.50
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 10:49:50 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-992ca792065so783742566b.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:49:50 -0700 (PDT)
X-Received: by 2002:a17:906:64cf:b0:992:a9c3:244f with SMTP id
 p15-20020a17090664cf00b00992a9c3244fmr11648139ejn.4.1690220989918; Mon, 24
 Jul 2023 10:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724151849.323497-1-jhs@mojatatu.com>
In-Reply-To: <20230724151849.323497-1-jhs@mojatatu.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 24 Jul 2023 10:49:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiH27m7UeddwD8JPUxjxXHMs=kv8x1WrLAho=dZ8CUhyg@mail.gmail.com>
Message-ID: <CAHk-=wiH27m7UeddwD8JPUxjxXHMs=kv8x1WrLAho=dZ8CUhyg@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: sched: cls_u32: Fix match key mis-addressing
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	netdev@vger.kernel.org, mgcho.minic@gmail.com, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 24 Jul 2023 at 08:19, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> +               /* The tableid from handle and tableid from htid must match */
>                 if (TC_U32_HTID(handle) && TC_U32_HTID(handle ^ htid)) {

Well, I guess the comment at least talks about matching.

I still do think that most people aren't going to read

    "Oh, TC_U32_HTID(handle ^ htid) being non-zero means that they
they differ in the hash table bits".

because the whole trick depends on bit op details, and depends on the
fact that TC_U32_HTID() is purely a bit masking operation.

But whatever.

I would also like to see some explanation of this pattern

                handle = htid | TC_U32_NODE(handle);

and why that "binary or" makes sense. Are the node bits in 'htid'
guaranteed to be zero?

Because if 'htid' can have node bits set, what's the logical reason
for or'ing things together?

And why is that variable called 'htid', when clearly it also has the
bucket ID, and the comment even says we have a valid bucket id?

So I do still find this code to be explicitly written to be confusing.
It's literally using variable names *designed* to not make sense, and
have other meanings.

Hmm?

I'm not hating the patch, but when I look at that code I just go "this
is confusing". And I don't think it's because I'm confused. I think
it's the code.

               Linus

