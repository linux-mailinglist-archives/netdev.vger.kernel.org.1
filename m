Return-Path: <netdev+bounces-53974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9318057DD
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C59E1C210C9
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443B565EC7;
	Tue,  5 Dec 2023 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="o3SQAZHH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52507AF
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 06:49:31 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d06d4d685aso18453695ad.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 06:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701787770; x=1702392570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVYOR8jA95NNNe7YfVCBpfpMAnbWfQZLL5xaB25MIA4=;
        b=o3SQAZHHPM7w2AmRFKLTUHTGAtIQgfebuSlVtVWC1cDEb7UeVEj5rA1KnA82/haCra
         vGJLlLTY7z/PvbjQilOSBB5VFB3SdlBg61pGukIl4ku+XI01nnDgxQTcP+Xi22I0ZX6w
         I+GWOs3sOcqJxoCygivlRDmmiML7l/0qDUlz13NaD5X0Nj0OrnmscWWm4yQWIXkFqkEO
         CXEdPBMfEhz3HQOhk/96aBIiEmTeGPqk5An1eMgLRP7wKfp0AJyqu/iJ6l5Ou9AxmsC9
         uNqGaY5yLov6ZryHV2XvjwatyUNk+lAA8Qct0wvkP35jAHIU+j+QdTJrquNuoo3hKAt6
         JCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787770; x=1702392570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVYOR8jA95NNNe7YfVCBpfpMAnbWfQZLL5xaB25MIA4=;
        b=HYzg+u0e8gPxkHFVRCbqHhhZjCjShHDGdWYZJ3PhAC4O8orSI5AMLlADXtjDTCWNG2
         fUdYgn3OxxXdFCE0a6qmvtmcPbmtscTel1vR8G+3nE9GgfUQqvJDK0dw4ssW8SXTMTX0
         fuoJ2yP5zlDgOzemfY1XP2bIWC9awz1x+p5H7W7iTVZdLYfNeCmdicK6kMNiNdIUGIfU
         NK0/IGDrirHyOwETImZWYFaFyHBe81cNJkEZQVTaa/QLkHw3YAi1eEHPTqCCYVTQagDr
         AArVnuOsaJrUTj96GwnsZ/vq5vWMsXmhEag5vgGyUFfo+AgVFyGdyMAO7Tdgi7iQw5ok
         9sdg==
X-Gm-Message-State: AOJu0YwDIwUqP+Cw45z+7zmf7Rc9d+Eh45NDgER8uLJlUwMP5Jh/N8Ok
	JGwUNCSZPWQ0TAV2AvIzTiPvievDXaicuSEptQA=
X-Google-Smtp-Source: AGHT+IFAC5724CkXDdrcLK7C6Z2Lq2mfUhhcWgbybFJBPZB4VcGPZ3GNXQUL0Dbr8sN4xK3L6uNoeg==
X-Received: by 2002:a17:902:e845:b0:1d0:afd5:1e93 with SMTP id t5-20020a170902e84500b001d0afd51e93mr2305287plg.8.1701787770599;
        Tue, 05 Dec 2023 06:49:30 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b001d072365b87sm6458751plf.106.2023.12.05.06.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 06:49:30 -0800 (PST)
Message-ID: <e0724326-834f-4651-bb0b-d8fa9226b909@mojatatu.com>
Date: Tue, 5 Dec 2023 11:49:26 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/5] net/sched: conditional notification of
 events for cls and act
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, marcelo.leitner@gmail.com, vladbu@nvidia.com
References: <20231204203907.413435-1-pctammela@mojatatu.com>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231204203907.413435-1-pctammela@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/12/2023 17:39, Pedro Tammela wrote:
> This is an optimization we have been leveraging on P4TC but we believe
> it will benefit rtnl users in general.
> 
> It's common to allocate an skb, build a notification message and then
> broadcast an event. In the absence of any user space listeners, these
> resources (cpu and memory operations) are wasted. In cases where the subsystem
> is lockless (such as in tc-flower) this waste is more prominent. For the
> scenarios where the rtnl_lock is held it is not as prominent.
> 
> The idea is simple. Build and send the notification iif:
>     - The user requests via NLM_F_ECHO or
>     - Someone is listening to the rtnl group (tc mon)
> 
> On a simple test with tc-flower adding 1M entries, using just a single core,
> there's already a noticeable difference in the cycles spent in tc_new_tfilter
> with this patchset.
> 
> before:
>     - 43.68% tc_new_tfilter
>        + 31.73% fl_change
>        + 6.35% tfilter_notify
>        + 1.62% nlmsg_notify
>          0.66% __tcf_qdisc_find.part.0
>          0.64% __tcf_chain_get
>          0.54% fl_get
>        + 0.53% tcf_proto_lookup_ops
> 
> after:
>     - 39.20% tc_new_tfilter
>        + 34.58% fl_change
>          0.69% __tcf_qdisc_find.part.0
>          0.67% __tcf_chain_get
>        + 0.61% tcf_proto_lookup_ops
> 
> Note, the above test is using iproute2:tc which execs a shell.
> We expect people using netlink directly to observe even greater
> reductions.
> 
> The qdisc side needs some refactoring of the notification routines to fit in
> this new model, so they will be sent in a later patchset.
> 
> v1->v2:
> - Address Jakub comments
> 
> Jamal Hadi Salim (1):
>    rtnl: add helper to check if rtnl group has listeners
> 
> Pedro Tammela (3):
>    rtnl: add helper to send if skb is not null
>    net/sched: act_api: conditional notification of events
>    net/sched: cls_api: conditional notification of events

I just noticed some commits are still referencing the now non-existent 
function 'tc_should_notify'.I will post a v3.
--
pw-bot: cr


