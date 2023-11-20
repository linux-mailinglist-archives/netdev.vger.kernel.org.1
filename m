Return-Path: <netdev+bounces-49295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41817F1897
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E79282723
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439E41E520;
	Mon, 20 Nov 2023 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="De/++ONq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283289E
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 08:25:07 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9fcfd2a069aso194730866b.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 08:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700497505; x=1701102305; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=05bMz1p0Fi/+YX/jxDw/4veLDbvcbQxCb13Sp+DJpjw=;
        b=De/++ONqSf+xvhuUkV66g1CMuqty5bct7LiDMLP39/MUA4SMPJZ+ebGTbflZVeg9w5
         RBoBQbZqFRFXggtBLlLBLD9PUJN1BF1bmhO5sTB/J6yc76p9L5KKc0DzPQtcrrG6dKxR
         y4a4tdhFt/ovQB5wwmv0f3Ak+UaPZa0Qug1QHQbTGmkCZt3TixdRNYcgdV8SZBcb0QDs
         XmwVAcm5hHnx7j2FGK5AY6sY/G7qrgm+ek9KKn/O/beWXiWquLLKkpVRs5PGCT6LL5lo
         X44ppugfIH5ty4oKPaTrfeJ1FWst+fEDoxgRW3lTESoODRp56T5LKsPRbO8K0AvvCtTw
         aCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700497505; x=1701102305;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05bMz1p0Fi/+YX/jxDw/4veLDbvcbQxCb13Sp+DJpjw=;
        b=T+oo6deCMNlLMtBef8jmvTT4Hn0vrT6NTP5SBQZEknfhwQlzSnAFBkHhRKmNW2dQEU
         3yJcsBTjVAb86Cq1PSR21xxY8Q0medeogjP4AiMO7KiS7bAd5/IOgLQF6shwj3osXSbl
         rGLsCrvsfczolVClaBzKYJV6QXYX7Xy4OKRMtnZMRzEQZ8e3rfxCXbX+yrAVjfwTmcR1
         tsXvyg4ouzc/IWN7P8OeqmoQr3M/XR2R6stCchar1f76MgB4bRYG6jzUjlsHbsBwlEH7
         Sv8TUI25zSB7E598QwRwMXsO2iXtQcOnueQpIzs6HX4cMW+EKU40FB38G0/FK8/nhJeH
         ZqlQ==
X-Gm-Message-State: AOJu0YzESPorFLHexNG2I0ADCdDxdaanfzL6em14JWg56lFs05xB4A/K
	AXlZIYuf1yAzj4UIFf4Xu2ga03ZbQB1cfgQgjbqo8g==
X-Google-Smtp-Source: AGHT+IGZRGBnDSW+NQTH9AzT4r/wlJ/w4V9cEQQYCaU4Y+r5Niofi6cCDI3BdC7s1Sr1VFkeF0xtRA==
X-Received: by 2002:a17:906:1015:b0:9fe:3b2c:d044 with SMTP id 21-20020a170906101500b009fe3b2cd044mr2741169ejm.44.1700497505458;
        Mon, 20 Nov 2023 08:25:05 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u18-20020a170906c41200b00992f2befcbcsm4036727ejz.180.2023.11.20.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 08:25:04 -0800 (PST)
Date: Mon, 20 Nov 2023 17:25:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
	anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, xiyou.wangcong@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org, khalidm@nvidia.com,
	toke@redhat.com, mattyk@nvidia.com, David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v8 09/15] p4tc: add template pipeline create,
 get, update, delete
Message-ID: <ZVuIX06VKvrsmm1S@nanopsycho>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-10-jhs@mojatatu.com>
 <ZVY/GBIC4ckerGSc@nanopsycho>
 <CAM0EoMkdOnvzK3J1caSeKzVj+h-XrkLPfsfwRCS_udHem-C29g@mail.gmail.com>
 <ZVsWP29UyIzg4Jwq@nanopsycho>
 <CAM0EoM=nANF_-HaMKmk0j6JXqGeuEUZVU3fxZp4VoB9GzZwjUQ@mail.gmail.com>
 <ZVtcEwICZHsTtija@nanopsycho>
 <CAM0EoM=EFJTqeEsJHQZw-3x6TnEMFYT1+Rsm7f4aSKh0QLqBnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoM=EFJTqeEsJHQZw-3x6TnEMFYT1+Rsm7f4aSKh0QLqBnA@mail.gmail.com>

Mon, Nov 20, 2023 at 04:30:11PM CET, jhs@mojatatu.com wrote:
>On Mon, Nov 20, 2023 at 8:16 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Mon, Nov 20, 2023 at 01:48:14PM CET, jhs@mojatatu.com wrote:
>> >On Mon, Nov 20, 2023 at 3:18 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Fri, Nov 17, 2023 at 01:09:45PM CET, jhs@mojatatu.com wrote:
>> >> >On Thu, Nov 16, 2023 at 11:11 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >>
>> >> >> Thu, Nov 16, 2023 at 03:59:42PM CET, jhs@mojatatu.com wrote:
>> >> >>
>> >> >> [...]
>> >> >>
>> >> >>
>> >> >> >diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
>> >> >> >index ba32dba66..4d33f44c1 100644
>> >> >> >--- a/include/uapi/linux/p4tc.h
>> >> >> >+++ b/include/uapi/linux/p4tc.h
>> >> >> >@@ -2,8 +2,71 @@
>> >> >> > #ifndef __LINUX_P4TC_H
>> >> >> > #define __LINUX_P4TC_H
>> >> >> >
>> >> >> >+#include <linux/types.h>
>> >> >> >+#include <linux/pkt_sched.h>
>> >> >> >+
>> >> >> >+/* pipeline header */
>> >> >> >+struct p4tcmsg {
>> >> >> >+      __u32 pipeid;
>> >> >> >+      __u32 obj;
>> >> >> >+};
>> >> >>
>> >> >> I don't follow. Is there any sane reason to use header instead of normal
>> >> >> netlink attribute? Moveover, you extend the existing RT netlink with
>> >> >> a huge amout of p4 things. Isn't this the good time to finally introduce
>> >> >> generic netlink TC family with proper yaml spec with all the benefits it
>> >> >> brings and implement p4 tc uapi there? Please?
>> >> >>
>> >> >
>> >> >Several reasons:
>> >> >a) We are similar to current tc messaging with the subheader being
>> >> >there for multiplexing.
>> >>
>> >> Yeah, you don't need to carry 20year old burden in newly introduced
>> >> interface. That's my point.
>> >
>> >Having a demux sub header is 20 year old burden? I didnt follow.
>>
>> You don't need the header, that's my point.
>>
>
>Let me see if i understand you:
>We have multiple object types per pipeline - this info is _omni
>present and it is never going to change_.
>Your view is, have a hierarchy of attributes and put this subheader in
>probably one attribute at the root.

That or use genetlink to have per-cmd attributes.


>You parse the root, you find the obj and pipeid and then you use that
>to parse the rest of the per-object specific
>attributes?
>
>I dont know if a hierarchical attribute layout gives you any advantage
>over the subheader approach - unless we figure a way to annotate
>attributes as "optional" vs "must be present". I agree that getting
>the validation for free is a bonus ..
>
>
>> >
>> >>
>> >> >b) Where does this leave iproute2? +Cc David and Stephen. Do other
>> >> >generic netlink conversions get contributed back to iproute2?
>> >>
>> >> There is no conversion afaik, only extensions. And they has to be,
>> >> otherwise the user would not be able to use the newly introduced
>> >> features.
>> >
>> >The big question is does the collective who use iproute2 still get to
>> >use the same tooling or now they have to go and learn some new
>> >tooling. I understand the value of the new approach but is it a
>> >revolution or an evolution? We opted to put thing in iproute2 instead
>> >for example because that is widely available (and used).
>>
>> I don't see why iproute2 user facing interface would be any different
>> depending on if you user RTnetlink or genetlink as backend channel...
>>
>
>iproute2 supports plenty of genetlink already.
>We need to find a way to have the best of both worlds.
>
>>
>> >
>> >>
>> >> >c) note: Our API is CRUD-ish instead of RPC(per generic netlink)
>> >> >based. i.e you have:
>> >> > COMMAND <PATH/TO/OBJECT> [optional data]  so we can support arbitrary
>> >> >P4 programs from the control plane.
>> >>
>> >> I'm pretty sure you can achieve the same over genetlink.
>> >>
>> >
>> >I think you are right.
>> >
>> >>
>> >> >d) we have spent many hours optimizing the control to the kernel so i
>> >> >am not sure what it would buy us to switch to generic netlink..
>> >>
>> >> All the benefits of ynl yaml tooling, at least.
>> >>
>> >
>> >Did you pay close attention to what we have? The user space code is
>> >written once into iproute2 and subsequent to that there is no
>> >recompilation  of any iproute2 code. The compiler generates a json
>> >file specific to a P4 program which is then introspected by the
>> >iproute2 code.
>>
>> Right, but in real life, netlink is used directly by many apps. I don't
>> see why this is any different.
>>
>
>Not sure if you were referring to what i said about the json file or
>something else. The main value is not just kernel independence but
>also iproute2 independence i.e not need to compile any code.
>
>> Plus, the very best part of yaml from user perpective I see is,
>> you just need the kernel-git yaml file and you can submit all commands.
>> No userspace implementation needed.
>
>Two different tacts: i can see this as being developer friendly (and
>we are more trying to be operator friendly).
>I need to take a closer look. Sounds like it should be polyglot
>friendly as well. If i am not mistaken you still have to compile code
>as a result of generation from the yaml?

Nope, you can run ynl.py and let it parse the yaml on fly.


>
>cheers,
>jamal
>
>>
>> >
>> >
>> >cheers,
>> >jamal
>> >
>> >>
>> >> >
>> >> >cheers,
>> >> >jamal
>> >> >
>> >> >>
>> >> >> >+
>> >> >> >+#define P4TC_MAXPIPELINE_COUNT 32
>> >> >> >+#define P4TC_MAXTABLES_COUNT 32
>> >> >> >+#define P4TC_MINTABLES_COUNT 0
>> >> >> >+#define P4TC_MSGBATCH_SIZE 16
>> >> >> >+
>> >> >> > #define P4TC_MAX_KEYSZ 512
>> >> >> >
>> >> >> >+#define TEMPLATENAMSZ 32
>> >> >> >+#define PIPELINENAMSIZ TEMPLATENAMSZ
>> >> >>
>> >> >> ugh. A prefix please?
>> >> >>
>> >> >> pw-bot: cr
>> >> >>
>> >> >> [...]

