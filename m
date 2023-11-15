Return-Path: <netdev+bounces-48197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5659E7ED350
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 21:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5D2281037
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDFE43AC2;
	Wed, 15 Nov 2023 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtnnQkcY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770718F;
	Wed, 15 Nov 2023 12:49:09 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ce1603f5cdso1031855ad.3;
        Wed, 15 Nov 2023 12:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700081344; x=1700686144; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/b24oZBDOyviv88keLNJvELffPgYkOMIvr7ryRw2UM=;
        b=XtnnQkcYX//AJrZRlO5YN8J+hjsp0qNlm1BtvIKVM5cBv/ajaJhVoDsXkkr/HecJBA
         OwDEuntKH8xCW15vl4tPiQIFk+r1Gm0rI5y85xd9GuRzKWdbao2F+52fhFLXWwkPZFXU
         o3UL0rwbfX8IJzC5KbAu8Ht3OBW2mAsSg7YQEOnqPUUAUt1zxbOeCXQy/iL3IMlGEQTN
         K4HdFvgd6L0S9jPZ+IDeXFAB4ftFeW8HDNDayX4FkbjpgLVZSNeemr6wQ3FJ4k1FgSoc
         nFM7+9pemHZbVgT4THwo8UBnbYDnnBtC8xwrxGbMgCdIggAUdHIG8UBaYui3aUM6PN4+
         UsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700081344; x=1700686144;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/b24oZBDOyviv88keLNJvELffPgYkOMIvr7ryRw2UM=;
        b=i37moZ2hBKwDhUH8XAwmEHWvd7yPDhpaZ29rQFg8OZgFbXw/bAen6/gX5i56bhDj9n
         GQJIC5yAOvQRDNqcYxopnZ36RXmjcjmSYW3KOnZG8XojJGMS0EeELly8vZwRYyen9H11
         b7Dlclpln20iwQoHKTWbISyAIwXDk659Cvhwys8iX2Gu41kelVyHC7rIomd5RZDm9c1K
         wOjsgkN3jgpR4/2n73Ei685SULF04Ppx1Z4cX2u6zvpezMfMWsAIKSf2RbseImAJ5HNk
         SF6FsMKCBbnH9NVpbdsspcUivtQCmVuUHBDhqHBlCy1irb/+Nhm+h/Bc/AvDVly+dJkc
         neuQ==
X-Gm-Message-State: AOJu0Yw+NURbdRYSLetBa40rux+mGB3vf0hXP8eGXeGYaVRdpy7SoLQ/
	EkJb3RecrBSEA3O84FtcGWQ=
X-Google-Smtp-Source: AGHT+IFcg6wRPt2wGlOlDs7bsLg5pKynCaCBOiBofUa2G4WFh1uKKgFi0RVSnyPH4Z6hYwgeTh3C2A==
X-Received: by 2002:a17:902:ec84:b0:1c8:9d32:339e with SMTP id x4-20020a170902ec8400b001c89d32339emr7774092plg.50.1700081343562;
        Wed, 15 Nov 2023 12:49:03 -0800 (PST)
Received: from smtpclient.apple ([2601:600:967f:6b00:30f7:e7fd:e49d:14a0])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b001cc46240491sm7991640pln.136.2023.11.15.12.49.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Nov 2023 12:49:03 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: sr-iov related bonding regression (two regressions in one report)
From: Anil Choudhary <anilchabba@gmail.com>
In-Reply-To: <CC024511-980A-4508-8ABF-659A04367C2B@gmail.com>
Date: Wed, 15 Nov 2023 12:48:51 -0800
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>,
 Linux Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Andy Gospodarek <andy@greyhouse.net>,
 Ivan Vecera <ivecera@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7AC9E8F6-B229-47AA-84CE-1149F45D7E0F@gmail.com>
References: <986716ed-f898-4a02-a8f6-94f85b355a05@gmail.com>
 <32716.1700009673@famine>
 <0f97acf9-012d-4bb2-a766-0c2737e32b2c@leemhuis.info>
 <CC024511-980A-4508-8ABF-659A04367C2B@gmail.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
X-Mailer: Apple Mail (2.3731.700.6)

We are getting errorError subscribing to SWID 0x0000.
 from following code
root@us-ash-r1-c2-m1:~/linux# grep -rn -e "subscribing to " .
grep: =
./debian/linux-image/lib/modules/6.6.1-vdx/kernel/drivers/net/ethernet/int=
el/ice/ice.ko: binary file matches
./samples/connector/ucon.c:149: ulog("subscribing to %u.%u\n", =
CN_TEST_IDX, CN_TEST_VAL);
./Documentation/driver-api/media/v4l2-event.rst:117:add      called when =
a new listener gets added (subscribing to the same
./Documentation/driver-api/media/v4l2-event.rst:130:Unsubscribing to an =
event is via:
./Documentation/maintainer/feature-and-driver-maintainers.rst:44:mailing =
list. Either by subscribing to the whole list or using more
grep: ./drivers/net/ethernet/intel/ice/ice_lag.o: binary file matches
grep: ./drivers/net/ethernet/intel/ice/ice.o: binary file matches
grep: ./drivers/net/ethernet/intel/ice/ice.ko: binary file matches
./drivers/net/ethernet/intel/ice/ice_lag.c:1007:                =
dev_err(ice_pf_to_dev(local_lag->pf), "Error subscribing to SWID =
0x%04X\n",
root@us-ash-r1-c2-m1:~/linux#


Thanks,
Anil



> On Nov 14, 2023, at 10:19 PM, Anil Choudhary <anilchabba@gmail.com> =
wrote:
>=20
> <PastedGraphic-1.png>
>=20
>=20
> Following error error scribing to said is also new
>=20
>> On Nov 14, 2023, at 9:50 PM, Linux regression tracking (Thorsten =
Leemhuis) <regressions@leemhuis.info> wrote:
>>=20
>> On 15.11.23 01:54, Jay Vosburgh wrote:
>>> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>>=20
>>>> I come across LACP bonding regression on Bugzilla [1].
>>=20
>> Side note: Stephen forwards some (all?) network regressions to the =
right
>> people:
>> https://lore.kernel.org/all/20231113083746.5e02f8b0@hermes.local/
>>=20
>> Would be best to check for that, no need to forward things twice, =
that
>> just results in a mess.
>>=20
>>>> The reporter
>>>> (Cc'ed) has two regressions. The first is actual LACP bonding
>>>> regression (but terse):
>>>>=20
>>>>> Till linkx kernel 6.5.7 it is working fine, but after upgrading to =
6.6.1 ping stop working with LACP bonding.
>>>>> When we disable SR-IOV from bios , everything working fine
>>=20
>> Makes me wonder if things have been working with or without the OOT
>> module on 6.5.7, as strictly speaking it's only considered a kernel
>> regression if thing worked with a vanilla kernel (e.g. without OOT
>> modules) beforehand and broke when switching to a newer vanilla =
kernel.
>> If that's the case it would be okay to add to regzbot.
>>=20
>>>> And the second is out-of-tree module FTBFS:
>>> [... skip OOT stuff ...]
>>>=20
>>>> Should I add the first regression to regzbot (since the second one
>>>> is obviously out-of-tree problem), or should I asked detailed =
regression
>>>> info to the reporter?
>>>=20
>>> 	My vote is to get additional information.  Given the nature of
>>> the workaround ("When we disable SR-IOV from bios , everything =
working
>>> fine"), it's plausible that the underlying cause is something
>>> platform-specific.
>>=20
>> Maybe, but when it comes to the "no regressions" rule that likely =
makes
>> no difference from Linus perspective.
>>=20
>> But I guess unless the intel folks or someone else has an idea what
>> might be wrong here we likely need a bisection (with vanilla kernels =
of
>> course) to get anywhere.
>>=20
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' =
hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>=20


