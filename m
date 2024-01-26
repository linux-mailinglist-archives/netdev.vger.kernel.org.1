Return-Path: <netdev+bounces-66184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665AD83DCFD
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 16:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E834281897
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ABB1CA9C;
	Fri, 26 Jan 2024 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsrRc/qs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890D1C29B
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281305; cv=none; b=JGKCC1C4y7McfNfGdnf+HRstBILL84A8zMqCjznl2+anpMGeLPn+1Pvhaxn6je1YpzWxNU6FNhWb5lPmBPmruv3+QqY6+eMO9cc+xyXD2vXWCrObeXQnk/YKjyKFNuLk5s+psO2kXcR0J3f0xDrlubGEvahq9yy9DttA0gta4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281305; c=relaxed/simple;
	bh=mch118Egy+c0/5fcHzKnIUBEQE6hvM6wsht86vzekuU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iyKqQP9eu4k7DQdZrCW1clxxRxcG2TLJuMN2Mm/MTYXDtBB2/8psoyCEtNPIr4t60ZWsQnC40hkaUCfhr0OLSWIRmAMYTIFu1yuPNw77NadXdpm7MiOgnMFNJMEnhoyVIC+hM5EfN0+TO0mhTCBQaotyPLOrMOC5twQJG79Z/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsrRc/qs; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50f11e3ba3aso800785e87.1
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 07:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706281302; x=1706886102; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9c1LLSQ/32TVCCdUunJf0+XJx1x6vqstR/taqLvPUk=;
        b=gsrRc/qsKsK520YLfbWv4QvLYQoLwMv5HIklHTYwNFW1NNtWNHRjTYQ/EUDXJeFDMk
         PPbOLp/RA49Svwt27bSLz/AVvhPFy0wLcXu9uYNRasqGv0WyLmwA6C3X5M8bdh+cF1Dc
         0+SttEqE5bfgY49qx2mAFu0Q3bjfWGy75pyXVCgeABSfs8xlcYKM+Bo/C5G7rKFN3kmt
         t7QvWa3+6S36atFs+t8zWtjmbq56dyQziWSGc4vWg8vrFgbAb0fbYu8GCJfZwiV8nnGi
         t0Kb9wR29HTDinZoyYEo205ljbw56Lc8jIBTxOwyraKuYiPqL5E6TD/GIBmeQV0Fipra
         KqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706281302; x=1706886102;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9c1LLSQ/32TVCCdUunJf0+XJx1x6vqstR/taqLvPUk=;
        b=IXWjOoISWpW3WZ9RdHYd4vfd4mWcQSDX7yg/swfiIx7kXbO+sCQVSFNK6O15VPeU6D
         FULPUDVIqbVyhXVY80WTZJzWsWmMis4LdK8pmHOVK+hkmZxUuHvDKHtmkIQ585fobky6
         eeq27VUEL5LhibihDM8QS1QrVAhnIEIdA6N4dfUNVU6ryHFDH9qnVYGFYCOPwweuksO6
         UCNdjfI8T81j5R/PwES6k5iQAuEfta/w5pshv66wdmOT2nX0+T4rh89yZ98El1q4KWMb
         c+BS3dLWeu6FcphhEHAooMQFbtTnVOryocy7nA24p9upEMFHK68doy6+g1EPU8jquxw3
         zvyw==
X-Gm-Message-State: AOJu0YyK9aOHJd+yS30h1Tt+f0odWLcEDvX4W34BFn+j9mktOEwhiBDo
	/tpDcamY/rRtYxban9BorvL7zsrHnIHVbMWoN952CIbevWD+iJkm
X-Google-Smtp-Source: AGHT+IFAj8+U+qC0yWoKYeYoVPZj9NjR8RQOgTxGbm4gwnBkdQgq8/8yduTukPzyyZXX2Y8usHVanw==
X-Received: by 2002:ac2:550d:0:b0:50f:ffc5:5cda with SMTP id j13-20020ac2550d000000b0050fffc55cdamr1817370lfk.57.1706281301325;
        Fri, 26 Jan 2024 07:01:41 -0800 (PST)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c138b00b0040e76b60235sm5996415wmf.8.2024.01.26.07.01.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2024 07:01:40 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [RFC,net-next] tcp: add support for read with offset when using
 MSG_PEEK
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <9522107c-90bd-e803-4397-16a357613a22@redhat.com>
Date: Fri, 26 Jan 2024 17:01:30 +0200
Cc: netdev <netdev@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <04E4B322-2179-4734-AA7D-E628526D6615@gmail.com>
References: <F0655F8D-EBEB-403E-BA89-0C8AAAE56E1D@gmail.com>
 <b17a1cda-2a3e-2a79-ff88-7f7fe3c30f37@redhat.com>
 <BDDD81F3-146F-4DCB-9B47-3BF0618607CD@gmail.com>
 <9522107c-90bd-e803-4397-16a357613a22@redhat.com>
To: Jon Maloy <jmaloy@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)

Hi Jon

For now run release v2 : =
https://patchwork.kernel.org/project/netdevbpf/patch/20240120165218.228330=
2-1-jmaloy@redhat.com/

and work without any problem.
If i see any will update you.

Thanks
Martin

> On 17 Jan 2024, at 18:33, Jon Maloy <jmaloy@redhat.com> wrote:
>=20
>=20
>=20
> On 2024-01-15 23:59, Martin Zaharinov wrote:
>> Hi Jon,
>>=20
>> yes same here in our test lab where have one test user all is fine .
>>=20
>> But when install kernel on production server with 500 users (ppp) and =
400-500mbit/s traffic machine crash with this bug log.
>> Its run as isp router firewall + shapers =E2=80=A6
> Just to get it straight, does it crash when you are running your test =
program on top of that heavily loaded machine, or does it just happen =
randomly when the patch is present?
>=20
> ////jon
>=20
>=20
>=20
>=20
>>=20
>> m.
>>=20
>>> On 16 Jan 2024, at 0:41, Jon Maloy <jmaloy@redhat.com> wrote:
>>>=20
>>>=20
>>>=20
>>> On 2024-01-15 16:51, Martin Zaharinov wrote:
>>>> Hi Jon
>>>>=20
>>>> After apply the patch on kernel 6.7.0 system hang with this bug =
report :
>>> Hmm,
>>> I have been running this for weeks without any problems, on x86_64 =
with current net and net-next.
>>> There must be some difference between our kernels.
>>> Which configuration are you using?
>>> It would also be interesting to see your test program.
>>>=20
>>> Regards
>>> ///jon
>>>=20
>>>=20
>>>> Jan 15 22:27:39 6.7.0,1,863,194879739,-,caller=3DT3523;BUG: unable =
to handle page fault for address: 00007fff333174e0
>>>> Jan 15 22:27:39 6.7.0,1,864,194879876,-,caller=3DT3523;#PF: =
supervisor read access in kernel mode
>>>> Jan 15 22:27:39 6.7.0,1,865,194879976,-,caller=3DT3523;#PF: =
error_code(0x0001) - permissions violation
>>>> Jan 15 22:27:39 6.7.0,6,866,194880075,-,caller=3DT3523;PGD =
107cbd067 P4D 107cbd067 PUD 22055d067 PMD 10a384067 PTE 8000000228b00067
>>>> Jan 15 22:27:39 6.7.0,4,867,194880202,-,caller=3DT3523;Oops: 0001 =
[#1] SMP
>>>> Jan 15 22:27:39 6.7.0,4,868,194880297,-,caller=3DT3523;CPU: 12 PID: =
3523 Comm: server-nft Tainted: G           O       6.7.0 #1
>>>> Jan 15 22:27:39 6.7.0,4,869,194880420,-,caller=3DT3523;Hardware =
name: To Be Filled By O.E.M. To Be Filled By O.E.M./EP2C612D8, BIOS =
P2.30 04/30/2018
>>>> Jan 15 22:27:39 6.7.0,4,870,194880547,-,caller=3DT3523;RIP: =
0010:tcp_recvmsg_locked+0x498/0xea0
>>>> Jan 15 22:27:39 6.7.0,4,871,194880709,-,caller=3DT3523;Code: a3 07 =
00 00 80 fa 02 0f 84 88 07 00 00 84 d2 0f 84 f1 04 00 00 41 8b 8c 24 d8 =
05 00 00 49 8b 53 20 4c 8d 7c 24 44 89 4c 24 44 <48> 83 3a 00 0f 85 e5 =
fb ff ff 49 8b 73 30 48 83 fe 01 0f 86 c4 04
>>>> Jan 15 22:27:39 6.7.0,4,872,194880876,-,caller=3DT3523;RSP: =
0018:ffffa47b01307d00 EFLAGS: 00010202
>>>> Jan 15 22:27:39 6.7.0,4,873,194880975,-,caller=3DT3523;RAX: =
0000000000000002 RBX: ffff8cf8c3209800 RCX: 00000000a87ac03c
>>>> Jan 15 22:27:39 6.7.0,4,874,194881096,-,caller=3DT3523;RDX: =
00007fff333174e0 RSI: ffffa47b01307e18 RDI: ffff8cf8c3209800
>>>> Jan 15 22:27:39 6.7.0,4,875,194881217,-,caller=3DT3523;RBP: =
ffffa47b01307d78 R08: ffffa47b01307d90 R09: ffffa47b01307d8c
>>>> Jan 15 22:27:39 6.7.0,4,876,194881338,-,caller=3DT3523;R10: =
0000000000000002 R11: ffffa47b01307e18 R12: ffff8cf8c3209800
>>>> Jan 15 22:27:39 6.7.0,4,877,194881458,-,caller=3DT3523;R13: =
0000000000000000 R14: 0000000000000000 R15: ffffa47b01307d44
>>>> Jan 15 22:27:39 6.7.0,4,878,194881579,-,caller=3DT3523;FS:  =
00007f4941b0ad80(0000) GS:ffff8d001f900000(0000) knlGS:0000000000000000
>>>> Jan 15 22:27:39 6.7.0,4,879,194881703,-,caller=3DT3523;CS:  0010 =
DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> Jan 15 22:27:39 6.7.0,4,880,194881802,-,caller=3DT3523;CR2: =
00007fff333174e0 CR3: 000000010df04002 CR4: 00000000003706f0
>>>> Jan 15 22:27:39 6.7.0,4,881,194881922,-,caller=3DT3523;DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> Jan 15 22:27:39 6.7.0,4,882,194882043,-,caller=3DT3523;DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> Jan 15 22:27:39 6.7.0,4,883,194882164,-,caller=3DT3523;Call Trace:
>>>> Jan 15 22:27:39 6.7.0,4,884,194882257,-,caller=3DT3523; <TASK>
>>>> Jan 15 22:27:39 6.7.0,4,885,194882347,-,caller=3DT3523; ? =
__die+0xe4/0xf0
>>>> Jan 15 22:27:39 6.7.0,4,886,194882442,-,caller=3DT3523; ? =
page_fault_oops+0x144/0x3e0
>>>> Jan 15 22:27:39 6.7.0,4,887,194882539,-,caller=3DT3523; ? =
zap_pte_range+0x6a4/0xdc0
>>>> Jan 15 22:27:39 6.7.0,4,888,194882638,-,caller=3DT3523; ? =
exc_page_fault+0x5d/0xa0
>>>> Jan 15 22:27:39 6.7.0,4,889,194882736,-,caller=3DT3523; ? =
asm_exc_page_fault+0x22/0x30
>>>> Jan 15 22:27:39 6.7.0,4,890,194882834,-,caller=3DT3523; ? =
tcp_recvmsg_locked+0x498/0xea0
>>>> Jan 15 22:27:39 6.7.0,4,891,194882931,-,caller=3DT3523; ? =
__call_rcu_common.constprop.0+0xbc/0x770
>>>> Jan 15 22:27:39 6.7.0,4,892,194883031,-,caller=3DT3523; ? =
rcu_nocb_flush_bypass.part.0+0xec/0x120
>>>> Jan 15 22:27:39 6.7.0,4,893,194883133,-,caller=3DT3523; =
tcp_recvmsg+0x5c/0x1e0
>>>> Jan 15 22:27:39 6.7.0,4,894,194883228,-,caller=3DT3523; =
inet_recvmsg+0x2a/0x90
>>>> Jan 15 22:27:39 6.7.0,4,895,194883325,-,caller=3DT3523; =
__sys_recvfrom+0x15e/0x200
>>>> Jan 15 22:27:39 6.7.0,4,896,194883423,-,caller=3DT3523; ? =
wait_task_zombie+0xee/0x410
>>>> Jan 15 22:27:39 6.7.0,4,897,194883539,-,caller=3DT3523; ? =
remove_wait_queue+0x1b/0x60
>>>> Jan 15 22:27:39 6.7.0,4,898,194883635,-,caller=3DT3523; ? =
do_wait+0x93/0xa0
>>>> Jan 15 22:27:39 6.7.0,4,899,194883729,-,caller=3DT3523; ? =
__x64_sys_poll+0xa7/0x170
>>>> Jan 15 22:27:39 6.7.0,4,900,194883825,-,caller=3DT3523; =
__x64_sys_recvfrom+0x1b/0x20
>>>> Jan 15 22:27:39 6.7.0,4,901,194883921,-,caller=3DT3523; =
do_syscall_64+0x2c/0xa0
>>>> Jan 15 22:27:39 6.7.0,4,902,194884018,-,caller=3DT3523; =
entry_SYSCALL_64_after_hwframe+0x46/0x4e
>>>> Jan 15 22:27:39 6.7.0,4,903,194884116,-,caller=3DT3523;RIP: =
0033:0x7f4941fe92a9
>>>> Jan 15 22:27:39 6.7.0,4,904,194884210,-,caller=3DT3523;Code: 0c 00 =
64 c7 02 02 00 00 00 eb bf 66 0f 1f 44 00 00 80 3d a9 e0 0c 00 00 41 89 =
ca 74 1c 45 31 c9 45 31 c0 b8 2d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 =
67 c3 66 0f 1f 44 00 00 55 48 83 ec 20 48 89
>>>> Jan 15 22:27:39 6.7.0,4,905,194884377,-,caller=3DT3523;RSP: =
002b:00007fff33317468 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
>>>> Jan 15 22:27:39 6.7.0,4,906,194884499,-,caller=3DT3523;RAX: =
ffffffffffffffda RBX: 00007fff333174e0 RCX: 00007f4941fe92a9
>>>> Jan 15 22:27:39 6.7.0,4,907,194884620,-,caller=3DT3523;RDX: =
0000000000000001 RSI: 00007fff333174e0 RDI: 0000000000000005
>>>> Jan 15 22:27:39 6.7.0,4,908,194884740,-,caller=3DT3523;RBP: =
00007fff33317550 R08: 0000000000000000 R09: 0000000000000000
>>>> Jan 15 22:27:39 6.7.0,4,909,194884860,-,caller=3DT3523;R10: =
0000000000000002 R11: 0000000000000246 R12: 0000000000000000
>>>> Jan 15 22:27:39 6.7.0,4,910,194884980,-,caller=3DT3523;R13: =
0000000000000000 R14: 0000000000000000 R15: 00007f49418850a0
>>>> Jan 15 22:27:39 6.7.0,4,911,194885101,-,caller=3DT3523; </TASK>
>>>> Jan 15 22:27:39 6.7.0,4,912,194885191,-,caller=3DT3523;Modules =
linked in: nft_limit pppoe pppox ppp_generic slhc nft_ct nft_nat =
nft_chain_nat nf_tables netconsole coretemp bonding igb i2c_algo_bit =
i40e ixgbe mdio nf_nat_sip nf_conntrack_sip nf_nat_pptp =
nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp =
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos aesni_intel crypto_simd =
cryptd
>>>> Jan 15 22:27:39 6.7.0,4,913,194885507,-,caller=3DT3523;CR2: =
00007fff333174e0
>>>> Jan 15 22:27:39 6.7.0,4,914,194885602,-,caller=3DT3523;---[ end =
trace 0000000000000000 ]---
>>>> Jan 15 22:27:39 6.7.0,4,915,194885698,-,caller=3DT3523;RIP: =
0010:tcp_recvmsg_locked+0x498/0xea0
>>>> Jan 15 22:27:39 6.7.0,4,916,194885797,-,caller=3DT3523;Code: a3 07 =
00 00 80 fa 02 0f 84 88 07 00 00 84 d2 0f 84 f1 04 00 00 41 8b 8c 24 d8 =
05 00 00 49 8b 53 20 4c 8d 7c 24 44 89 4c 24 44 <48> 83 3a 00 0f 85 e5 =
fb ff ff 49 8b 73 30 48 83 fe 01 0f 86 c4 04
>>>> Jan 15 22:27:39 6.7.0,4,917,194887079,-,caller=3DT3523;RSP: =
0018:ffffa47b01307d00 EFLAGS: 00010202
>>>> Jan 15 22:27:39 6.7.0,4,918,194887177,-,caller=3DT3523;RAX: =
0000000000000002 RBX: ffff8cf8c3209800 RCX: 00000000a87ac03c
>>>> Jan 15 22:27:39 6.7.0,4,919,194887298,-,caller=3DT3523;RDX: =
00007fff333174e0 RSI: ffffa47b01307e18 RDI: ffff8cf8c3209800
>>>> Jan 15 22:27:39 6.7.0,4,920,194887418,-,caller=3DT3523;RBP: =
ffffa47b01307d78 R08: ffffa47b01307d90 R09: ffffa47b01307d8c
>>>> Jan 15 22:27:39 6.7.0,4,921,194887538,-,caller=3DT3523;R10: =
0000000000000002 R11: ffffa47b01307e18 R12: ffff8cf8c3209800
>>>> Jan 15 22:27:39 6.7.0,4,922,194887658,-,caller=3DT3523;R13: =
0000000000000000 R14: 0000000000000000 R15: ffffa47b01307d44
>>>> Jan 15 22:27:39 6.7.0,4,923,194887779,-,caller=3DT3523;FS:  =
00007f4941b0ad80(0000) GS:ffff8d001f900000(0000) knlGS:0000000000000000
>>>> Jan 15 22:27:39 6.7.0,4,924,194887901,-,caller=3DT3523;CS:  0010 =
DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> Jan 15 22:27:39 6.7.0,4,925,194888000,-,caller=3DT3523;CR2: =
00007fff333174e0 CR3: 000000010df04002 CR4: 00000000003706f0
>>>> Jan 15 22:27:39 6.7.0,4,926,194888120,-,caller=3DT3523;DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> Jan 15 22:27:39 6.7.0,4,927,194888240,-,caller=3DT3523;DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> Jan 15 22:27:39 6.7.0,0,928,194888360,-,caller=3DT3523;Kernel panic =
- not syncing: Fatal exception
>>>> Jan 15 22:27:40 6.7.0,0,929,195391096,-,caller=3DT3523;Kernel =
Offset: 0x1f000000 from 0xffffffff81000000 (relocation range: =
0xffffffff80000000-0xffffffffbfffffff)
>>>> Jan 15 22:27:40 6.7.0,0,930,195391224,-,caller=3DT3523;Rebooting in =
10 seconds..
>>>>=20
>>>>=20
>>>>=20
>>>> m.
>>>>=20
>=20


