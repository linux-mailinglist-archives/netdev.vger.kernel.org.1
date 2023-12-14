Return-Path: <netdev+bounces-57247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB51E8128B9
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 08:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07316B210A0
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 07:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E2D52C;
	Thu, 14 Dec 2023 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHkUWt3x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A61FBD
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 23:06:54 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ce7c1b07e1so6932323b3a.2
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 23:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702537614; x=1703142414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nV9io2uZNuWIe6Es1+OwTSTABNTqgnyb2vdsEw09Ve4=;
        b=jHkUWt3x0ZVH30hMV+ruoLzKmDkYR3LqKF066BvPcx64NuAY2MUL06NcK/7BEioaDQ
         z1Pil2yIfEBmhWpBc/lQBy1L9p24XvZ0XLRGYSGkhEk3xwDRF3+MiMX9k1JMT9iis8w6
         D4zT+psxD32AR6IWiyvB0Wd46/kMNvJgRWMaXDyWTlaeKc2yl9Oi09Zc570ICIcDIX27
         PnNoQje/FgEKOWTT3le5vctKw9a0tfJlJAyGV1Fj8SIJnyZ/SfvVCWvLNHDLfXr4lmeq
         BXCf7IHSFAK7GgYfEUW2NGeEXLOneXj8bqucQQ8fvwzpxIp6LZYJzYf0GzX1iS+jkOGO
         6Pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702537614; x=1703142414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nV9io2uZNuWIe6Es1+OwTSTABNTqgnyb2vdsEw09Ve4=;
        b=Qdf21ZuO20AOPkS9cXAnFnaTqrW1ndGOQlh9PTxp01TxpFDefogWAwttka65JGusJT
         Sb6hTky2e0cK6CNS9Yy7FlIMvo4ECeRVS3+HTYEcoaXOsaTArr441v99YNyt/dVBRjpc
         lzf6XU5YlXaC91hLL0wdlmjhEDEm8FA1WERG3RluFHfPGKRlzID1TZMonKq+uXG8Ik1l
         a0/SL99ombOdtCAC+QijZiva2cEtBXm7NnTiMozjAmojLrAs4q2TtXMd6XqZaG3cTqIK
         oKXXrDVyylSYf0t7bJZpqnYO8QLvaK+gf9lyZ/75jy7feE1/USxW0b7T2whqlzlyscRH
         ejJg==
X-Gm-Message-State: AOJu0Yz17HeRG0vXMDV0upSGKA2RA7lFzUeyQObktOGUI0wGJTo/hgvM
	V6KWV/RTmkjYwYyY8HYPZ2s=
X-Google-Smtp-Source: AGHT+IE9G8hOFTGkHGfBBx6kSGkrNp9DHSQE6heKaYLV75LHcuQQKCUwxL0SojpiFJduzAZbRpMvCg==
X-Received: by 2002:a05:6a00:27a1:b0:6ce:79b3:b28a with SMTP id bd33-20020a056a0027a100b006ce79b3b28amr9824479pfb.60.1702537613832;
        Wed, 13 Dec 2023 23:06:53 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o73-20020a62cd4c000000b006c875abecbcsm11500114pfg.121.2023.12.13.23.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 23:06:53 -0800 (PST)
Date: Thu, 14 Dec 2023 15:06:49 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	mlxsw@nvidia.com, Jay Vosburgh <j.vosburgh@gmail.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Import top-level lib.sh
 through $lib_dir
Message-ID: <ZXqpieBoynMk0U-Z@Laptop-X1>
References: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
 <ZXcERjbKl2JFClEz@Laptop-X1>
 <87fs07mi0w.fsf@nvidia.com>
 <ZXi_veDs_NMDsFrD@d3>
 <ZXlIew7PbTglpUmV@Laptop-X1>
 <ZXok5cRZDKdjX1nj@d3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXok5cRZDKdjX1nj@d3>

Hi Benjamin,

On Wed, Dec 13, 2023 at 04:40:53PM -0500, Benjamin Poirier wrote:
> > Hmm.. Is it possible to write a rule in the Makefile to create the net/
> > and net/forwarding folder so we can source the relative path directly. e.g.
> > 
> > ]# tree
> > .
> > ├── drivers
> > │   └── net
> > │       └── bonding
> > │           ├── bond-arp-interval-causes-panic.sh
> > │           ├── ...
> > │           └── settings
> > ├── kselftest
> > │   ├── module.sh
> > │   ├── prefix.pl
> > │   └── runner.sh
> > ├── kselftest-list.txt
> > ├── net
> > │   ├── forwarding
> > │   │   └── lib.sh
> > │   └── lib.sh
> > └── run_kselftest.sh
> 
> That sounds like a good idea. I started to work on that approach but I'm
> missing recursive inclusion. For instance
> 
> cd tools/testing/selftests
> make install TARGETS="drivers/net/bonding"
> ./kselftest_install/run_kselftest.sh -t drivers/net/bonding:dev_addr_lists.sh
> 
> includes net/forwarding/lib.sh but is missing net/lib.sh. I feel that my
> 'make' skills are rusty but I guess that with enough make code, it could
> be done. A workaround is simply to manually list the transitive
> dependencies in TEST_SH_LIBS:
>  TEST_SH_LIBS := \
> -	net/forwarding/lib.sh
> +	net/forwarding/lib.sh \
> +	net/lib.sh

Yes, this makes the user need to make sure all the recursive inclusions listed
here. A little inconvenient. But I "make" skill is worse than you...

> 
> I only converted a few files to validate that the approach is viable. I
> used the following tests:
> drivers/net/bonding/dev_addr_lists.sh
> net/test_vxlan_vnifiltering.sh
> net/forwarding/pedit_ip.sh
> 
> Let me know what you think.

Thanks! This works for me.

Cheers
Hangbin

