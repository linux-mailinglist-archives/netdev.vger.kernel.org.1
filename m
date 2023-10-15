Return-Path: <netdev+bounces-41069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E377C98A7
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 12:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66579B20BA0
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09A2290B;
	Sun, 15 Oct 2023 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="TkAPP05i"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B918259C
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 10:24:04 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7318CDC
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 03:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1697365432; x=1697970232; i=wahrenst@gmx.net;
 bh=2B8oYyDg+OVZfEw6PWsS3AD8AFFKnn9I323uKdrVAzA=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=TkAPP05i38zEAltUWZ6f0cDYA4pFlxHDry6st+u7uwBO5C4AlNgi4sy/h9DKK/Hqor3UKoJ1rkH
 8KVu0NfEHJk0sZxuZMZ6E9W8r966oNRNhhQf81UvGktZZxGWgba2FczZIq1HwOE2zsQvT0xwUbi9B
 kw+6tmtFJoKBC/7Oc9mUMi2XW+iAssSoadH9fcWG9WTyH+nMh7cvl9kFF2hUC1ydEoDaY4UzSdr7g
 4dcDPyzjy/VAG6MTYPwn4cBRWAoAw5gVIbhdCqVmmDLAGDFFRPUo42HdF0UyuOvgpW43n/+TyqCp+
 7OqNY+Sq4ZB0d9BnPIv8R6Ti3HxXnotuXwJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mirng-1rWVdE1N12-00ey1p; Sun, 15
 Oct 2023 12:23:52 +0200
Message-ID: <a94b00d9-8bbc-4c54-b5c9-4a7902220312@gmx.net>
Date: Sun, 15 Oct 2023 12:23:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iperf performance regression since Linux 5.18
From: Stefan Wahren <wahrenst@gmx.net>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 linux-imx@nxp.com, Stefan Wahren <stefan.wahren@chargebyte.com>,
 Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org,
 Yuchung Cheng <ycheng@google.com>
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net>
 <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
 <CADVnQymV=nv53YaC8kLC1qT1ufhJL9+w_wcZ+8AHwPRG+JRdnw@mail.gmail.com>
 <a35b1a27-575f-4d19-ad2d-95bf4ded40e9@gmx.net>
 <CADVnQymM2HrGrMGyJX2QQ9PpgQT8JqsRz_0U8_WvdvzteqsfEQ@mail.gmail.com>
 <CANn89iL97hLAyHx9ee1VKTnLEgJeEVPrf_8-wf0BEBKAPQitPA@mail.gmail.com>
 <1ac3ea60-81d8-4501-b983-cb22b046f2ea@gmx.net>
Content-Language: en-US
In-Reply-To: <1ac3ea60-81d8-4501-b983-cb22b046f2ea@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zQjQpcR5NbgVl1Wvbljb7aYHzrAsub2BPwuz8aLOZlzNkXxCLyp
 YCxihjN15LCRl4/AO7EXbP9dJw/FcMMOJnGDz3WhwmUSqOLkZy5e8eqahQxzgruXyexIpIR
 YmbtB6l5s02kZpPVWqxqMthfi3ex5xnxM0mcJkYq40nZkTy8rdRKSvvMvNN2JSqNN45M+UH
 J6NxsF94UvAX96ZQzUOSw==
UI-OutboundReport: notjunk:1;M01:P0:RJEZ5Ev+dbQ=;U8wZZhIuxoHVLwd59uYCBJjEVU4
 vKpuAQPK4M+MyKXq9pDfC48Ky7sYV4EwoRojpKZm+d6v+gLVcZh54SzwG357/wpVdEcxJyCoQ
 dDu7pvlvMYWnhHQSoJxJGw2wq+GUsxqqt5xBtLSjzE1O9YccMD065HKvOAM4uiqaDJ22acYL4
 JvYRskciJGapWvjONMAb5z/mw8Dr1vSxa7Fu7kI2zTXfUGipdLl450YvhpgwfoN1eDcivb4br
 fXyFYZCmOvl0oQwDDpTp9E5MgLgI0o6NjYBj3WmtoJtHJxtnUNh5g52zXkIygNYsi7KTsFSfK
 k2cy57MNpmGyojCPZ+IZl8tILc3oZWk6gyy9nMEEzBq4/ZxZm000PFxBglXBNvOaencAKBjMk
 i2zfJYXQv2a4MEyevskped0Bsfxl11q8cMEo5KNQZ5KYXNRGzTF9OZYY4lnIs2yJld8pCtTpm
 UE9QxIcoamDshSmyRV9de/7KBY58Q01Z5YcX5RoMK9u5sQp15qx3rA4jqqB8Q8hVbbA2tXC7T
 PzOUkVXrUA2kDniigLqzhVl+YI4772jhD5MW7OcHlappnT5+bZIW1Dth8xYncBBEOZ+iCTa46
 LfMNZcNIPfRCGPItYKzYWBJV6KNglnnW2G7229HQjaJ4tDeC5jRCjUpWTDk0SUGveE9DAwkv8
 9Rmu5vsKJaWfKNkXoGjJJ9VWUBXY0DyAJ9KRRj1ng+uYbULNLUb32PyvA1p7VQ9sKV+bq3iL2
 qTZu/pO2vgJLMbhaNqGEX+IBtmFSTlkklpUsm0yV+0gyjggPYbYvAPN7wL1pbo5rm1eu8jaos
 0G5tdmMWfqydvnOgSmyYDrMxHVHVCrXW/gRQCj3aNXyI/E/khFyXiuELLZxAXZmsVm71Mp+wH
 V3RNCYnaoYyYppg9QR1on5iSdefpYLc1fsAtBlx2uUxnkT57ucqJ3NT26yIK9rkpw2MmA7rE3
 qhDncs4NeJ8HZ8FR2UPNqq/xRec=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

Am 15.10.23 um 01:26 schrieb Stefan Wahren:
> Hi Eric,
>
> Am 15.10.23 um 00:51 schrieb Eric Dumazet:
>> On Sat, Oct 14, 2023 at 9:40=E2=80=AFPM Neal Cardwell <ncardwell@google=
.com>
>> wrote:
...
>> Hmm, we receive ~3200 acks per second, I am not sure the
>> tcp_tso_should_defer() logic
>> would hurt ?
>>
>> Also the ss binary on the client seems very old, or its output has
>> been mangled perhaps ?
> this binary is from Yocto kirkstone:
>
> # ss --version
> ss utility, iproute2-5.17.0
>
> This shouldn't be too old. Maybe some missing kernel settings?
>
i think i was able to fix the issue by enable the proper kernel
settings. I rerun initial bad and good case again and overwrote the log
files:

https://github.com/lategoodbye/tcp_tso_rtt_log_regress/commit/93615c94ba1b=
f36bd47cc2b91dd44a3f58c601bc

