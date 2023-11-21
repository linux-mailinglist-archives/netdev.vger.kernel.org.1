Return-Path: <netdev+bounces-49668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E797F3085
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 15:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 903F0B21310
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE154FA5;
	Tue, 21 Nov 2023 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VN45qNfN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01685D51
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 06:19:31 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-548b54ed16eso3226975a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 06:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700576370; x=1701181170; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e8K28uZW8oyz1ITv5WcBkYgFfeOANX2aUzq122lE7GA=;
        b=VN45qNfNGcNHoDxD5j8uCly2RipTyAeev6DlWGyrBAk99kuiIGdXJQbQUB1Sd3owYi
         SrMCgVjO9q7Kt92H5kM8x6Lj7pyh1f8WzLHkUEU5xJDNIHj335g7FyhTJdQ3UvpSaUhR
         pVgvmDUiOBqomRxQwB1WD2dtg6ug4LQcIocqwCAvi8tW76TW6dSBKDo+xkmZ7jZutHih
         +M4G+b3J+hrdJFJb3R90+SANREJ8CapMrrRnxf3p1jYikrCgo2hR3vX3GlB6QWtny/6/
         RUNeInCjZIw9LZFFf6BXpWFmagRhbE363g3OftKS1zNneC5JmwESQSj1pfD4/0HiyxH+
         Q0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700576370; x=1701181170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8K28uZW8oyz1ITv5WcBkYgFfeOANX2aUzq122lE7GA=;
        b=L6mpFytRFKJYwAQ/z0ssXuRPmXmWGfGuuUiEPn01UuX7wdD1qH+wZpyBGtJQD7wGQ1
         vW/qXoBmttBcUoMERQdSsLqDS//+0WzUpMC2Wyjk/BX1b8WajS8Vepv7ifQ771aP10SF
         3SdoIiO3c5FcYTKw97jWhqhN0x97lFa65aSthzLtDN8P9TtwSnUOTtU6kSVTO+wIuaqM
         xoxAYyyQ/znIi82o3s/asBWAzxtVHaQlbFe0hfpgy1On8Fk1hPl/fKZCi2ZKoJuUeqjz
         0xean+k2j/vKAQ5/Q6NRqaPSTorNw+c9NWCrLDGjn6ihrzgGydanFlXlSJ1JH1Lf505J
         alEg==
X-Gm-Message-State: AOJu0YyEqHdIkJpdDjr6Gif6VForcGJCFASrWjT6PTJt8dshQy7Bols/
	XoO9NF5IW2lORN4cm6tBiBXpdg==
X-Google-Smtp-Source: AGHT+IFo4FFvmi6KsXzD1NJWuPO/XLIm3WToMarTRXfcWRSX8leZtAiBb/g8iXyJjqnpqgwWpiSwlg==
X-Received: by 2002:a17:906:4712:b0:a00:2686:6b42 with SMTP id y18-20020a170906471200b00a0026866b42mr3644355ejq.10.1700576370253;
        Tue, 21 Nov 2023 06:19:30 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k26-20020a170906681a00b009dd678d7d3fsm5314093ejr.211.2023.11.21.06.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:19:29 -0800 (PST)
Date: Tue, 21 Nov 2023 15:19:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	deb.chatterjee@intel.com, anjali.singhai@intel.com,
	Vipin.Jain@amd.com, namrata.limaye@intel.com, tom@sipanda.io,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, xiyou.wangcong@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
	bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com,
	mattyk@nvidia.com, dan.daly@intel.com, chris.sommers@keysight.com,
	john.andy.fingerhut@intel.com
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
Message-ID: <ZVy8cEjs9VK2OVxE@nanopsycho>
References: <6557b2e5f3489_5ada920871@john.notmuch>
 <CAM0EoMkrb4kv+bjQqrFKFo9mxGFs6tjQtq4D-FtcemBV_WYNUQ@mail.gmail.com>
 <ZVspOBmzrwm8isiD@nanopsycho>
 <CAM0EoMm3whh6xaAdKcT=a9FcSE4EMn=xJxkXY5ked=nwGaGFeQ@mail.gmail.com>
 <ZVuhBlYRwi8eGiSF@nanopsycho>
 <CAM0EoMknA01gmGX-XLH4fT_yW9H82bN3iNYEvFRypvTwARiNqg@mail.gmail.com>
 <2a7d6f27-3464-c57b-b09d-55c03bc5eae6@iogearbox.net>
 <CAM0EoMkBHqRU9tprJ-SK3tKMfcGsnydp0UA9cH2ALjpSNyJhig@mail.gmail.com>
 <ZVyrRFDrVqluD9k/@nanopsycho>
 <CAM0EoMkUFzZ=Qnk3kWCGw83apANybjvNUZHHAi5is4ewag5xOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkUFzZ=Qnk3kWCGw83apANybjvNUZHHAi5is4ewag5xOA@mail.gmail.com>

Tue, Nov 21, 2023 at 02:47:40PM CET, jhs@mojatatu.com wrote:
>On Tue, Nov 21, 2023 at 8:06 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Mon, Nov 20, 2023 at 11:56:50PM CET, jhs@mojatatu.com wrote:
>> >On Mon, Nov 20, 2023 at 4:49 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> >>
>> >> On 11/20/23 8:56 PM, Jamal Hadi Salim wrote:
>> >> > On Mon, Nov 20, 2023 at 1:10 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >> Mon, Nov 20, 2023 at 03:23:59PM CET, jhs@mojatatu.com wrote:
>>
>> [...]
>>
>> >
>> >> tc BPF and XDP already have widely used infrastructure and can be developed
>> >> against libbpf or other user space libraries for a user space control plane.
>> >> With 'control plane' you refer here to the tc / netlink shim you've built,
>> >> but looking at the tc command line examples, this doesn't really provide a
>> >> good user experience (you call it p4 but people load bpf obj files). If the
>> >> expectation is that an operator should run tc commands, then neither it's
>> >> a nice experience for p4 nor for BPF folks. From a BPF PoV, we moved over
>> >> to bpf_mprog and plan to also extend this for XDP to have a common look and
>> >> feel wrt networking for developers. Why can't this be reused?
>> >
>> >The filter loading which loads the program is considered pipeline
>> >instantiation - consider it as "provisioning" more than "control"
>> >which runs at runtime. "control" is purely netlink based. The iproute2
>> >code we use links libbpf for example for the filter. If we can achieve
>> >the same with bpf_mprog then sure - we just dont want to loose
>> >functionality though.  off top of my head, some sample space:
>> >- we could have multiple pipelines with different priorities (which tc
>> >provides to us) - and each pipeline may have its own logic with many
>> >tables etc (and the choice to iterate the next one is essentially
>> >encoded in the tc action codes)
>> >- we use tc block to map groups of ports (which i dont think bpf has
>> >internal access of)
>> >
>> >In regards to usability: no i dont expect someone doing things at
>> >scale to use command line tc. The APIs are via netlink. But the tc cli
>> >is must for the rest of the masses per our traditions. Also i really
>>
>> I don't follow. You repeatedly mention "the must of the traditional tc
>> cli", but what of the existing traditional cli you use for p4tc?
>> If I look at the examples, pretty much everything looks new to me.
>> Example:
>>
>>   tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
>>     action send_to_port param port eno1
>>
>> This is just TC/RTnetlink used as a channel to pass new things over. If
>> that is the case, what's traditional here?
>>
>
>
>What is not traditional about it?

Okay, so in that case, the following example communitating with
userspace deamon using imaginary "p4ctrl" app is equally traditional:
  $ p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
     action send_to_port param port eno1


>
>>
>> >didnt even want to use ebpf at all for operator experience reasons -
>> >it requires a compilation of the code and an extra loading compared to
>> >what our original u32/pedit code offered.
>> >
>> >> I don't quite follow why not most of this could be implemented entirely in
>> >> user space without the detour of this and you would provide a developer
>> >> library which could then be integrated into a p4 runtime/frontend? This
>> >> way users never interface with ebpf parts nor tc given they also shouldn't
>> >> have to - it's an implementation detail. This is what John was also pointing
>> >> out earlier.
>> >>
>> >
>> >Netlink is the API. We will provide a library for object manipulation
>> >which abstracts away the need to know netlink. Someone who for their
>> >own reasons wants to use p4runtime or TDI could write on top of this.
>> >I would not design a kernel interface to just meet p4runtime (we
>> >already have TDI which came later which does things differently). So i
>> >expect us to support both those two. And if i was to do something on
>> >SDN that was more robust i would write my own that still uses these
>> >netlink interfaces.
>>
>> Actually, what Daniel says about the p4 library used as a backend to p4
>> frontend is pretty much aligned what I claimed on the p4 calls couple of
>> times. If you have this p4 userspace tooling, it is easy for offloads to
>> replace the backed by vendor-specific library which allows p4 offload
>> suitable for all vendors (your plan of p4tc offload does not work well
>> for our hw, as we repeatedly claimed).
>>
>
>That's you - NVIDIA. You have chosen a path away from the kernel
>towards DOCA. I understand NVIDIA's frustration with dealing with
>upstream process (which has been cited to me as a good reason for
>DOCA) but please dont impose these values and your politics on other
>vendors(Intel, AMD for example) who are more than willing to invest
>into making the kernel interfaces the path forward. Your choice.

No, you are missing the point. This has nothing to do with DOCA. This
has to do with the simple limitation of your offload assuming there are
no runtime changes in the compiled pipeline. For Intel, maybe they
aren't, and it's a good fit for them. All I say is, that it is not the
good fit for everyone.


>Nobody is stopping you from offering your customers proprietary
>solutions which include a specific ebpf approach alongside DOCA. We
>believe that a singular interface regardless of the vendor is the
>right way forward. IMHO, this siloing that unfortunately is also added
>by eBPF being a double edged sword is not good for the community.
>
>> As I also said on the p4 call couple of times, I don't see the kernel
>> as the correct place to do the p4 abstractions. Why don't you do it in
>> userspace and give vendors possiblity to have p4 backends with compilers,
>> runtime optimizations etc in userspace, talking to the HW in the
>> vendor-suitable way too. Then the SW implementation could be easily eBPF
>> and the main reason (I believe) why you need to have this is TC
>> (offload) is then void.
>>
>> The "everyone wants to use TC/netlink" claim does not seem correct
>> to me. Why not to have one Linux p4 solution that fits everyones needs?
>
>You mean more fitting to the DOCA world? no, because iam a kernel

Again, this has 0 relation to DOCA.


>first person and kernel interfaces are good for everyone.

Yeah, not really. Not always the kernel is the right answer. Your/Intel
plan to handle the offload by:
1) abuse devlink to flash p4 binary
2) parse the binary in kernel to match to the table ids of rules coming
   from p4tc ndo_setup_tc
3) abuse devlink to flash p4 binary for tc-flower
4) parse the binary in kernel to match to the table ids of rules coming
   from tc-flower ndo_setup_tc
is really something that is making me a little bit nauseous.

If you don't have a feasible plan to do the offload, p4tc does not make
sense to me to be honest.


>
>cheers,
>jamal

