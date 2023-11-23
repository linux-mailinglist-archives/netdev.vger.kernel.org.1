Return-Path: <netdev+bounces-50627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6287F65FF
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA81B20CE2
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D368405FD;
	Thu, 23 Nov 2023 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iA0GdCRf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9CF10D0
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:09:27 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00f67f120aso149755666b.2
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700762966; x=1701367766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8PoS77Z9JkureBJlYC2LtoCnhbJ8qY8D9dKa58I6fkU=;
        b=iA0GdCRfJFYqzTlVkaXyHqzuwPpc1SPfWLuWsxOqbnL0CHCrS6N2XEV3RbqV2NCcLq
         2Yc32VGqt0ldVeT4bcDT2udkj7IlLBq1p3MfxJ/M5NGb4yMCjIkxEfP497OLqtSnTvYa
         J3U3BUxOhscjhSCWmbiangCzcSvtW71w/VS6sRFPnpuiYsINgjmlSAhKoFsL0BP0wy8/
         KsPsMne5ReKpST4gHKaw1vv4vQZq5AbTh/JDZhdprEOOZiBxXc2VhHfhmpWtSaB7jSLl
         7cJkFDneRjchgh1GVTLNzujIu95kxhMpBcoVxEVHU2P20AtOEh3u6pM+U2OuK5DMEtH2
         mUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700762966; x=1701367766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PoS77Z9JkureBJlYC2LtoCnhbJ8qY8D9dKa58I6fkU=;
        b=Vp40afFelQqIAILB+IeN6yEqNjNcLFifnwPJKXzFCkT/F3+i4uYSKOfG/OH3U195b9
         yuKbtw7Ht8G+HZd65RyvCBxYUPoM+0ENYtnNJyHEyPm4ZJ89IKGRDYtDBxo3K0ztN+0Q
         ck5XM1qKTjz7N28F04aowPfCKnKnlBQ+1jgPvoTJcI4rTOvTNvHYTwDsfxkYor5Fu+6Z
         /j+ldxSnEuKSd1w4zZ3diSkWzCUgLsqmQsFkUGVtKIcgcipM+02ka4t2POISJsk0nWWM
         jyk2+YiPTIOcuvUNYVA4R4POZemroSdH4QfxR6IYWDSLDbG8Ogft+JdftUKfdE9+zmhR
         wdGg==
X-Gm-Message-State: AOJu0YzvddEgcRriEHpiCMVU690AJQf5q/CzaaRJAUQTqWD+Kz++fwR9
	OUGf11JZbbAyZNFuhBJ6MH8EUQ==
X-Google-Smtp-Source: AGHT+IH61IjcX0UIbXIDTesrdOX1OBc5ieaVpkan88YfWHSIBhoczFnyaS1L4mnG3NFfjlvUNKCLCw==
X-Received: by 2002:a17:906:590e:b0:a04:837e:a955 with SMTP id h14-20020a170906590e00b00a04837ea955mr83581ejq.32.1700762965683;
        Thu, 23 Nov 2023 10:09:25 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ck16-20020a170906c45000b00a0029289961sm1055139ejb.190.2023.11.23.10.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:09:25 -0800 (PST)
Date: Thu, 23 Nov 2023 19:09:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
Message-ID: <ZV+VVLWzL/j4ayAt@nanopsycho>
References: <CAM0EoM=RR6kcdHsGhFNUeDc96rSDa8S7SP7GQOeXrZBN_P7jtQ@mail.gmail.com>
 <ZV7y9JG0d4id8GeG@nanopsycho>
 <CAM0EoMkOvEnPmw=0qye9gWAqgbZjaTYZhiho=qmG1x4WiQxkxA@mail.gmail.com>
 <ZV9U+zsMM5YqL8Cx@nanopsycho>
 <CAM0EoMnFB0hgcVFj3=QN4114HiQy46uvYJKqa7=p2VqJTwqBsg@mail.gmail.com>
 <ZV9csgFAurzm+j3/@nanopsycho>
 <CAM0EoMkgD10dFvgtueDn7wjJTFTQX6_mkA4Kwr04Dnwp+S-u-A@mail.gmail.com>
 <ZV9vfYy42G0Fk6m4@nanopsycho>
 <CAM0EoMkC6+hJ0fb9zCU8bcKDjpnz5M0kbKZ=4GGAMmXH4_W8rg@mail.gmail.com>
 <0d1d37f9-1ef1-4622-409e-a976c8061a41@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d1d37f9-1ef1-4622-409e-a976c8061a41@gmail.com>

Thu, Nov 23, 2023 at 06:53:42PM CET, ecree.xilinx@gmail.com wrote:
>On 23/11/2023 16:30, Jamal Hadi Salim wrote:
>> I was hoping not to say anything but my fingers couldnt help themselves:
>> So "unoffloadable" means there is a binary blob and this doesnt work
>> per your design idea of how it should work?
>> Not that it cant be implemented (clearly it has been implemented), it
>> is just not how _you_ would implement it? All along I thought this was
>> an issue with your hardware.
>
>The kernel doesn't like to trust offload blobs from a userspace compiler,
> because it has no way to be sure that what comes out of the compiler
> matches the rules/tables/whatever it has in the SW datapath.
>It's also a support nightmare because it's basically like each user
> compiling their own device firmware.  At least normally with device
> firmware the driver side is talking to something with narrow/fixed
> semantics and went through upstream review, even if the firmware side is
> still a black box.
>Just to prove I'm not playing favourites: this is *also* a problem with
> eBPF offloads like Nanotubes, and I'm not convinced we have a viable
> solution yet.

Just for the record, I'm not aware of anyone suggesting p4 eBPF offload
in this thread.


>
>The only way I can see to handle it is something analogous to proof-
> carrying code, where the kernel (driver, since the blob is likely to be
> wholly vendor-specific) can inspect the binary blob and verify somehow
> that (assuming the HW behaves according to its datasheet) it implements
> the same thing that exists in SW.
>Or simplify the hardware design enough that the compiler can be small
> and tight enough to live in-kernel, but that's often impossible.

Yeah, that would solve the offloading problem. From what I'm hearing
from multiple sides, not going to happen.

>
>-ed

