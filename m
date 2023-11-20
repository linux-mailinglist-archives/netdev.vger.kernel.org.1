Return-Path: <netdev+bounces-49104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D0F7F0D69
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5651E1C2090D
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF0FE563;
	Mon, 20 Nov 2023 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MZtYqKAQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B452494
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:22:05 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5488bf9e193so1728364a12.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700468524; x=1701073324; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oXAuh+L11JnCxh1EYT4wbERdY/t9kT2yS7CUEUV/8/Y=;
        b=MZtYqKAQ16NsQJF9fqQEUfQlKh35wS1gvmAWBP4CSoP5CrlyhH+7Un6T3ifO646opS
         8aKcJPMLcnt/vwWmeQWyAHGapBce2ACfVa5UDnSZsUJy3V+qNbBw7KRjprgC9I1sMg2t
         oLah94XXOOnBCmv7qJ0jNOTs4XY2yvVry6CjZaZK1sLh1kPJ68PleTyjO17jn4ivU/0r
         tupJL4mV4DF61Skij7UIRQkyanDQnZNvVWqbWjJY7oPlUgKFY7atagYOFgsrFv4fap0+
         Lm6HyEjJ9ClbxszJnm0Xo8P2/+S8yLRi4A7ne1Fkd6AaNjRlV3Jz0WkW9PbYabtTCD2m
         dYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700468524; x=1701073324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXAuh+L11JnCxh1EYT4wbERdY/t9kT2yS7CUEUV/8/Y=;
        b=ECAPNy7GfOXrXgFtUb03gNysH/cU49gs21mE0TWQ6B7kPxDW0usxVV7kfAiqaXeiGt
         ObXKAEt50d08IscplkwIfPARsKR4+QC6YiJOZE8WWxIh4I5K0aj8+VtL+p6iFuPx2OgS
         5/R3x+4AzxwYgfCMYLC4bAo6rd8fOCjlfbFEQrLiMzyARyG+P1MlbIP+W85cYD9U4+2+
         HzBm7IpovohgyNpsXODJcMsIZdHh6mptyIoxdL4pn1mNo7yVR+FGkE/CgyNKLSrK67ez
         iLjpo+7YUUdrAe7JOyNYaWVu5eR2rBbKE2mNdL5Pijdboau8htKj/1W5+r8nJZ/cPMFr
         QHOg==
X-Gm-Message-State: AOJu0YzMglgsFQNQIswgIzZZJIyaqEdKrsBTd+OpJUgBhDhscn5xCr9D
	+A1Rb/kLUzgyl7bopXOCMN50zw==
X-Google-Smtp-Source: AGHT+IHgeGoHa+jEPO8LiL7XXG88uPcDbrBUkD7jJ6c45ygN3IOIHqCJsEt9YF5RDT/QKBn1mLUUpA==
X-Received: by 2002:a05:6402:4411:b0:530:77e6:849f with SMTP id y17-20020a056402441100b0053077e6849fmr6892861eda.27.1700468524066;
        Mon, 20 Nov 2023 00:22:04 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f2-20020a50ee82000000b00548c4c4b8d5sm700495edr.13.2023.11.20.00.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:22:03 -0800 (PST)
Date: Mon, 20 Nov 2023 09:22:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
	anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, xiyou.wangcong@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org, khalidm@nvidia.com,
	toke@redhat.com, mattyk@nvidia.com
Subject: Re: [PATCH net-next v8 15/15] p4tc: Add P4 extern interface
Message-ID: <ZVsXKkD6ts+XcfE6@nanopsycho>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-16-jhs@mojatatu.com>
 <ZVZGYQDk/LyC7+8z@nanopsycho>
 <CAM0EoMkW1-a8yuxjEsqSnrmUx+ozn3CxvXTTwvEEPUrpk5UPRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkW1-a8yuxjEsqSnrmUx+ozn3CxvXTTwvEEPUrpk5UPRA@mail.gmail.com>

Fri, Nov 17, 2023 at 01:14:43PM CET, jhs@mojatatu.com wrote:
>On Thu, Nov 16, 2023 at 11:42 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Nov 16, 2023 at 03:59:48PM CET, jhs@mojatatu.com wrote:
>>
>> [...]
>>
>> > include/net/p4tc.h                |  161 +++
>> > include/net/p4tc_ext_api.h        |  199 +++
>> > include/uapi/linux/p4tc.h         |   61 +
>> > include/uapi/linux/p4tc_ext.h     |   36 +
>> > net/sched/p4tc/Makefile           |    2 +-
>> > net/sched/p4tc/p4tc_bpf.c         |   79 +-
>> > net/sched/p4tc/p4tc_ext.c         | 2204 ++++++++++++++++++++++++++++
>> > net/sched/p4tc/p4tc_pipeline.c    |   34 +-
>> > net/sched/p4tc/p4tc_runtime_api.c |   10 +-
>> > net/sched/p4tc/p4tc_table.c       |   57 +-
>> > net/sched/p4tc/p4tc_tbl_entry.c   |   25 +-
>> > net/sched/p4tc/p4tc_tmpl_api.c    |    4 +
>> > net/sched/p4tc/p4tc_tmpl_ext.c    | 2221 +++++++++++++++++++++++++++++
>> > 13 files changed, 5083 insertions(+), 10 deletions(-)
>>
>> This is for this patch. Now for the whole patchset you have:
>>  30 files changed, 16676 insertions(+), 39 deletions(-)
>>
>> I understand that you want to fit into 15 patches with all the work.
>> But sorry, patches like this are unreviewable. My suggestion is to split
>> the patchset into multiple ones including smaller patches and allow
>> people to digest this. I don't believe that anyone can seriously stand
>> to review a patch with more than 200 lines changes.
>
>This specific patch is not difficult to split into two. I can do that
>and send out minus the first 8 trivial patches - but not familiar with
>how to do "here's part 1 of the patches" and "here's patchset two".

Split into multiple patchsets and send one by one. No need to have all
in at once.


>There's dependency between them so not clear how patchwork and

What dependency. It should compile. Introduce some basic functionality
first and extend it incrementally with other patchsets. The usual way.


>reviewers would deal with it. Thoughts?
>
>Note: The code machinery is really repeatable; for example if you look
>at the tables control you will see very similar patterns to actions
>etc. i.e spending time to review one will make it easy for the rest.
>
>cheers,
>jamal
>
>> [...]

