Return-Path: <netdev+bounces-38733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286577BC498
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 06:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDAD1C2096D
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 04:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B201FB7;
	Sat,  7 Oct 2023 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="liIlPkM8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B41C3E
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 04:11:08 +0000 (UTC)
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5139CBE;
	Fri,  6 Oct 2023 21:11:06 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1696651863;
	bh=Sze3HJLbn7xdtgjzi29J/nVOnk5kP/6WiEVjB+3iJxI=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=liIlPkM8z2giTnNMwT+WR9Do9o/z0Jg2MAr/Ol4PGYnKxcNImres49KQHmBL6bJBO
	 yZu+Me6LbkNL1nAuylr4UZvqfs7yIxyK9v/BqmUHSfZS8nZ7jPAiGP4K3EC1cO5LCr
	 k+9zC+cL2hoYqdoa5iZlEu7ei7DAsxfsvtJ7yF8A=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com>
Date: Sat, 7 Oct 2023 06:10:42 +0200
Cc: stable@vger.kernel.org,
 netdev@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

> On 7. Oct 2023, at 00:12, Pedro Tammela <pctammela@mojatatu.com> =
wrote:
>=20
> On 06/10/2023 05:37, Christian Theune wrote:
>> Hi,
>> (prefix, I was not aware of the regression reporting process and =
incorrectly reported this informally with the developers mentioned in =
the change)
>> I upgraded from 6.1.38 to 6.1.55 this morning and it broke my traffic =
shaping script, leaving me with a non-functional uplink on a remote =
router.
>> The script errors out like this:
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ext=3DispA
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + =
ext_ingress=3Difb0
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + modprobe ifb
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + modprobe =
act_mirred
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del =
dev ispA root
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2061]: Error: Cannot =
delete qdisc with handle of zero.
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del =
dev ispA ingress
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2064]: Error: Cannot =
find specified qdisc on specified device.
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del =
dev ifb0 root
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2066]: Error: Cannot =
delete qdisc with handle of zero.
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del =
dev ifb0 ingress
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2067]: Error: Cannot =
find specified qdisc on specified device.
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc add =
dev ispA handle ffff: ingress
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ifconfig =
ifb0 up
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc filter =
add dev ispA parent ffff: protocol all u32 match u32 0 0 action mirred =
egress redirect dev ifb0
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc add =
dev ifb0 root handle 1: hfsc default 1
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc class add =
dev ifb0 parent 1: classid 1:999 hfsc rt m2 2.5gbit
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc class add =
dev ifb0 parent 1:999 classid 1:1 hfsc sc rate 50mbit
>> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2077]: Error: Invalid =
parent - parent class must have FSC.
>> The error message is also a bit weird (but that=E2=80=99s likely due =
to iproute2 being weird) as the CLI interface for `tc` and the error =
message do not map well. (I think I would have to choose `hfsc sc` on =
the parent to enable the FSC option which isn=E2=80=99t mentioned =
anywhere in the hfsc manpage).
>> The breaking change was introduced in 6.1.53[1] and a multitude of =
other currently supported kernels:
>=20
> Hi,
>=20
> Your script is actually incorrect.
> `man 7 tc-hfsc` goes in depth into why, but I just wanna highlight =
this section:
> SEPARATE LS / RT SCs
>       Another difference from the original HFSC paper is that RT and =
LS SCs can be specified separately. Moreover, leaf classes are
>       allowed to have only either RT SC or LS SC. For interior =
classes, only LS SCs make sense: any RT SC will be ignored.
>=20
> The last part ("For interior classes...") was what the referenced =
patch fixed. We were mistakenly allowing RTs into "interior classes" =
which the implementation never accounted for and this was a source of =
crashes. I'm surprised you were lucky enough to never crash the kernel =
;)
> -=3D
> I believe the script could be updated to the following and still =
achieve the same results:
> tc class add dev ifb0 parent 1: classid 1:999 hfsc ls m2 2.5gbit
> tc class add dev ifb0 parent 1:999 classid 1:1 hfsc rt rate 50mbit

I=E2=80=99m absolutely with you on this point and I=E2=80=99m very sure =
that I may have gotten the configuration wrong. I was already diving =
into fixing the script. Nevertheless, this end of the system is =
definitely not my strongest discipline and I tried get it right when =
setting this up initially scrambling through the man pages and the =
complexities of this topic. Unfortunately trying to learn this stuff is =
really hard and if the system finally accepts your config and does what =
you want and doesn=E2=80=99t complain in any way, then it=E2=80=99s hard =
to try and track down whether anything else could have been missed - =
somewhat a case of the halting problem. ;)

Point in case: I didn=E2=80=99t even notice tc-hfsc(7) was there and =
that I was only reading tc-hfsc(8).=20

Nevertheless, I=E2=80=99m curious and registered this as a regression, =
because it seems to fit the description and broke a running system. =
Looking at the change I=E2=80=99m wondering whether the kernel stability =
rule implies that the change has to be more forgiving towards user land, =
even if the user(land) might be wrong?=20

The idea of not bricking your system by upgrading the Linux kernel seems =
to apply here. IMHO the change could maybe done in a way that keeps the =
system running but informs the user that something isn=E2=80=99t working =
as intended?

Liebe Gr=C3=BC=C3=9Fe,
Christian Theune

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


