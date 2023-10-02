Return-Path: <netdev+bounces-37492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4997B5A79
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 20:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CC2EC281E4F
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E786B1F175;
	Mon,  2 Oct 2023 18:50:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7899F1F166
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 18:50:41 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36BDB3
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 11:50:38 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7741c5bac51so8383585a.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696272638; x=1696877438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWhlgKqTrjbQF0dckh+X6aNFF9b4rYOB+cG0XKPis4I=;
        b=zlArfdiUOOxnp1vq1Hx3NKuLZfLXCQdi/Ozh5tIFy1ae8ry0jd0EMxSMkpfw5uO5m9
         C4qUxCDdYoMPd6kWJHQ70J5PySuJBmph66CZZ+O+H0qZgwYmmyhb47EuXAS9vg8NLzON
         bH5K6jfLGhf0+pIzTFerUDX0c06eaJnNGuM7T+uGfQolcekk+NzaesbsPFNA1cs5kCuF
         BWjrEM6kcsFRQ84wX8M7GpJHTVtljMjv18KCbVfYPpee1nQH4Fs6qWWvALrnTXrFIuic
         2WBSpUnG32h7KJkBx6bI/LBGyB7W6Oe3mNXawZSbIeZojEyS1+m/XyKWTz3lkz6RTG7l
         nW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696272638; x=1696877438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWhlgKqTrjbQF0dckh+X6aNFF9b4rYOB+cG0XKPis4I=;
        b=TWhUZ8UqqeXwZvwXASgE6y6AWi+Q3WJfVbLhK3WUYDxW7H/F+ZVgsdki9ZFEyUAfU/
         UWmYE0sQ6c/LZ3FjPNNX0uvB6Gz6Nv1wTM0+q0+Qq32qNKIn9oDTqJFdincdfoFPIR33
         k4RCey617XM2K1rBzoZN/5nlG+8qK1YRN+aWkGuIOpZcy10fMIadi/e6CgAw05G+8He6
         eRScQ4SIjhR3k/avIZg9RKP+zw1cujYzZdK4zDBQmvRX2aphTq/v4CVNw+s6Zu9ZwUu2
         CY4VJuIYBP9M9jFlpX1PaQ0lYpcViIasxtw5J7dehui4lCaAdgf0kbRZF7nd7X2Erbvu
         BDAQ==
X-Gm-Message-State: AOJu0Ywai/UgrBQHuDrQPaXCqBy4gB7nqogPZ+xwsYC6GtZemhG1uOov
	XP7jVgQgBBmiA6nQFQ1YHJOo1g==
X-Google-Smtp-Source: AGHT+IE8dGMTkW1zzanpZHGg8oyg+mTfR48kvxmCI7TXQHg7zAjDrWq6zBxZfRbqzs4TqU6JV8F+iA==
X-Received: by 2002:a05:620a:2905:b0:773:ca55:e836 with SMTP id m5-20020a05620a290500b00773ca55e836mr12333975qkp.8.1696272637762;
        Mon, 02 Oct 2023 11:50:37 -0700 (PDT)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id v15-20020ae9e30f000000b0077263636a95sm4611503qkf.93.2023.10.02.11.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 11:50:37 -0700 (PDT)
Message-ID: <235e7365-2fe3-4bfa-ab11-1dc955d70042@google.com>
Date: Mon, 2 Oct 2023 14:50:34 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bpf indirect calls
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, Marek Majkowski <marek@cloudflare.com>,
 Lorenz Bauer <lmb@cloudflare.com>, Alan Maguire <alan.maguire@oracle.com>,
 Jesper Dangaard Brouer <brouer@redhat.com>,
 David Miller <davem@davemloft.net>,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <157046883614.2092443.9861796174814370924.stgit@alrua-x1>
 <20191007204234.p2bh6sul2uakpmnp@ast-mbp.dhcp.thefacebook.com>
 <87sgo3lkx9.fsf@toke.dk>
 <20191009015117.pldowv6n3k5p3ghr@ast-mbp.dhcp.thefacebook.com>
 <87o8yqjqg0.fsf@toke.dk>
 <20191010044156.2hno4sszysu3c35g@ast-mbp.dhcp.thefacebook.com>
 <87v9srijxa.fsf@toke.dk> <20191016022849.weomgfdtep4aojpm@ast-mbp>
 <8736fshk7b.fsf@toke.dk> <20191019200939.kiwuaj7c4bg25vqs@ast-mbp>
 <ZRQtsyYM810Oh4px@google.com>
 <CAADnVQJpCe9e2Qrnsaj4+ab47z00-bEYyHhN_mmpCh4+9i17vQ@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <CAADnVQJpCe9e2Qrnsaj4+ab47z00-bEYyHhN_mmpCh4+9i17vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/29/23 17:06, Alexei Starovoitov wrote:
> For certain cases like your example above it's relatively easy to add 
> such support, but before we do that please describe the full use case 
> that you wanted to implement with indirect calls.

I'll likely want some sort of indirect call for nesting schedulers in 
sched_ext / ghost.  Specifically, when we're running pick_next_task or 
any thread event handler (e.g. wakeup), we're picturing having a 
dispatch layer that picks which bpf agent to pass that off to, *and* get 
a response from the call.  Based on that response, we could possibly 
call someone else.

In this scenario, there'd be a 'base layer' BPF prog that handles 
pick_next_task from the kernel.  That base layer would choose which 
subprogram to query for its pick_next_task.  Depending on whether or not 
that subprogram has a task to run, the base layer may or may not want to 
run some other BPF program.

I'm not sure if an indirect call is what I'm looking for here, but it 
sounds somewhat related.  The difference might be that I'd like to call 
a function from a different BPF program, if that's possible.

Thanks,
Barret


