Return-Path: <netdev+bounces-54862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E368089FD
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 15:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC7E1C20C0B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172E41849;
	Thu,  7 Dec 2023 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5uvD8TY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C5A10D1
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 06:15:34 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-33349b3f99aso1004784f8f.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 06:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701958533; x=1702563333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOWUB+gryR0TwBFnM8jRyxzuLGSZFI6NALJA9ueIn9g=;
        b=I5uvD8TYHrHdmFGveCBW46FS1oix6v7GvZaGlYyG1MXMb5uXayWVua+/jDEjcdrmCH
         Ie89ynVSHeUAeXwXekrkpCqq0kPrad19JMNML7EPk0BhEAGwurIofL4t79nkUesfnDfM
         OVLF4LARCEstUelnkb5vgqN1+Bd3w5KEUoBZHX27/Gp1oBopX2KzJ2n+UQuHFze+8JR8
         CCcmufqiFq5ktThQyarm53Msz+OwK0tQlYrFghJg5tDa0nUZuDxZmJhNmb1O72OMx3P1
         cLxaOyRzBQChf8Qxy5ZUBnNEZZ2pm9c/Af0v8bS6vTCuSMuGrO2iuHMlc5k0PakQQq7A
         ldTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958533; x=1702563333;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOWUB+gryR0TwBFnM8jRyxzuLGSZFI6NALJA9ueIn9g=;
        b=rP1CwpWUTo/Z38m6Lv6qeOnytA63b6YOxV32VrKYAP5KIIP3GYSayiyWWgFItkQjBe
         dMFyCLJ83PSHZyV5zJPgUdUuDAWQzgw6SW+7DjXRtXVeTxI/FJKmLUWFas6hye46kato
         Bxr4Vt9EqfyFNBdCYmb34hm6dDJY1Fm2CHlQZxf2HBSH/JWP5Whpfg8Oh9J43uB2oYg4
         UuphTsMKg5JxUp0VdtujCEm8lXTTmE9zgsRH0U93/hMg7KPZEMIwCdARFllJxTZY13v2
         xQe1M5zYfGik+ME5C+eF/YivKIlhFjFzXhzEiIaa6p1tMTqSWc8sp2DxyWxl62oPCV8R
         pgEw==
X-Gm-Message-State: AOJu0YyBvysi0P/noAcUEPp2rPmTBNpuPwW04cliQiYolyOqgDVr5JG7
	cLQ1icaVt7nErBK4w33vJgE=
X-Google-Smtp-Source: AGHT+IH5TUvyx7lXeDEUz+2QgYPGvDBZogVbSnKJuebvruJICUw0NHCUC5Dpb3gCznTvosz4SUYF0Q==
X-Received: by 2002:a05:600c:470e:b0:40b:5e59:c57d with SMTP id v14-20020a05600c470e00b0040b5e59c57dmr1773238wmo.167.1701958532603;
        Thu, 07 Dec 2023 06:15:32 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b0040b42df75fcsm2061104wmq.39.2023.12.07.06.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 06:15:32 -0800 (PST)
Subject: Re: [PATCH v4 net-next 6/7] net: ethtool: add a mutex protecting RSS
 contexts
To: Jakub Kicinski <kuba@kernel.org>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 sudheer.mogilappagari@intel.com, jdamato@fastly.com, andrew@lunn.ch,
 mw@semihalf.com, linux@armlinux.org.uk, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 saeedm@nvidia.com, leon@kernel.org
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <b5d7b8e243178d63643c8efc1f1c48b3b2468dc7.1695838185.git.ecree.xilinx@gmail.com>
 <20231004161651.76f686f3@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <2ea45188-5554-8067-820d-378cada735ee@gmail.com>
Date: Thu, 7 Dec 2023 14:15:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231004161651.76f686f3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 05/10/2023 00:16, Jakub Kicinski wrote:
> On Wed, 27 Sep 2023 19:13:37 +0100 edward.cree@amd.com wrote:
>> While this is not needed to serialise the ethtool entry points (which
>>  are all under RTNL), drivers may have cause to asynchronously access
>>  dev->ethtool->rss_ctx; taking dev->ethtool->rss_lock allows them to
>>  do this safely without needing to take the RTNL.
> 
> Can we use a replay mechanism, like we do in TC offloads and VxLAN/UDP
> ports? The driver which lost config can ask for the rss contexts to be
> "replayed" and the core will issue a series of ->create calls for all
> existing entries?
So I tried to prototype this, and unfortunately I ran into a problem.
While we can replay the contexts alright, that still leaves the ntuple
 filters which we also want to restore, and which might depend on the
 contexts, so that can't be done until after context restore is done.
So to do this we'd need to *also* have the core replay the filters,
 which would mean adding a filter array to the core similar to this
 context array.  Now that's a thing that might be useful to have,
 enabling netlink dumps and so on, but it would considerably extend
 the scope of this work, in which case who knows if it'll ever be
 ready to merge :S
Moreover, at least in the case of sfc (as usual, no idea about other
 NICs), the filter table on the device contains more than just ntuple
 filters; stuff like the device's unicast address list, PTP filters
 and representor filters, some of which are required for correct
 operation, live in the same table.
When coming up after a reset, currently we:
1) restore RSS contexts
2) restore all filters (both driver-internal and ethtool ntuple) from
   the software shadow filter table into the hardware
3) bring up the NIC datapath.
Instead we would need to:
1) restore all the 'internal' filters (which do not, and after these
   changes could not ever, use custom RSS contexts), and discard all
   ntuple filters from the software shadow filter table in the driver
2) request RSS+ntuple replay
3) bring up the NIC datapath
4) the replay workitem runs, and reinserts RSS contexts and ntuple
   filters.
This would also mean that the default RSS context, which is used by
 the unicast/multicast address and Ethernet broadcast filters, could
 not ever migrate to be tracked in the XArray (otherwise a desirable
 simplification).

tl;dr: none of this is impossible, but it'd be a lot of work just to
 get rid of one mutex, and would paint us into a bit of a corner.
So I propose to stick with the locking scheme for now; I'll post v5
 with the other review comments addressed; and if at some point in
 the future core tracking of ntuple filters gets added, we can
 revisit then whether moving to a replay scheme is viable.  Okay?

-ed

