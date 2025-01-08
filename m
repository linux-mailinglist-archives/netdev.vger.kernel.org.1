Return-Path: <netdev+bounces-156199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6C0A05797
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 11:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69773A5595
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657081D932F;
	Wed,  8 Jan 2025 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="D2mVv+LD"
X-Original-To: netdev@vger.kernel.org
Received: from sonic322-28.consmr.mail.bf2.yahoo.com (sonic322-28.consmr.mail.bf2.yahoo.com [74.6.132.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26617C7B1
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736330837; cv=none; b=cWpvb8Ya1bdP08ho/6ypl2sKxvS+oN8XNCGoA09wYgYLSFk5Z0aU7aYhlyFzXz33YQdoBumwRB8gVJ4A56RJWEQaep0dOMVuA0Fur5C3xAxT2hZMj7RNQ02/TwIFvkSCuPhOrrgN6ARQ9Uqjrqgg/+SKzEScRLtS+i76Xd3fe4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736330837; c=relaxed/simple;
	bh=Bko2VKMNX2wZfDEctX4V+jxiH9ABZTeSE+lbSo92qNs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=FJxfn9ctkY4zrUklMf9xJoBQRvxAirc9GDiF6i8Ok47p9if7l7HrGl7x7p13FRYd4jaM+Wz+rJu2JMi65qTqwoCtTASDVErlLwXRLK++qXL0KSc4/b9ttjn1L7yb6BJHN+Gl+sDHRUu05cu8YU2Nj7aDxWOvPWn3+5Y4agcVF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=D2mVv+LD; arc=none smtp.client-ip=74.6.132.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1736330833; bh=ZkQI/bDLTKnaM7MZMlBswLZc3CaPyI/jMRrGLuw/0+g=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=D2mVv+LDtRovb+Yhcv8TCBQDBG3U7KYvoASx86gWVWs+rPxcDUdAUPjASpmho2hQg9+gvko8ipiHsWxtD00J7J8fFwU1TbDASIozzrHAeAG3amI1+S8rdRtJxjPjUmqkjYZiDo5ywxtOyS3+n5T8ZCsDs7fWZGToOuDvEyB7sxe395hwFFypZAro3zN/GpzFGMUJP/9UN6SrXjDuHXZ7g787zAnu5cVtvWFlbqHCpexXnJcN9uTJa0EpltALQ4Z6U4ED8enZHymtrRELgKf11Bz8DMajuEP/l2b8wCZtvaiaqgpaC1uKiyq9G7XS4X5/B3Wds2sML1Zz/VATJChNsA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1736330833; bh=229+KVhHmGiU4N4JraRkFibcY6Hcoo9ILioL6tj+Soo=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=rjAA9MsbZPSm8HVmaOC6RnmJGl5X51wG65sQDCcyR/txMQ8alR2M/o7qop41/ghRuBII0Ji5u6SfKmILvgbFaHhd68sGuakxmpj8CnzJ3vfM9n6zouTF2e7go2XzgLCePz/30gNX6IKiE3lWfSj3qosokGx5nYFI03Bn9ZR3h8TZhfVAiFl2YV8G1VKNvsYecqfBYTkVGgujQMaIhoQ9j4dAMEIj5Lzwnja3dv3kufeNNN/ydjIc3b2vzud/IY2yYdTn45AY2sll7Gl3HnzMVMMQvtPZqobRwladbO428ZM+lZb2yIUhUsK2FWZJiQ6TkLUL0NPYYKWSXmp0E54VSA==
X-YMail-OSG: Ypl_zFsVM1mDUiGmRckHaclphdAsLbBDSuuCdldaxcnFY74OhKtX2F4J15z29tV
 2hxVJgg271yNgYfrGqKzTYgi0ym747inCPwmSb0jujwI9DAc9pKrlst.6MfV_rUoNvNr6CHyvDWx
 bJJjxgykaVduwl8_aqhR6.e7GBCnwOU6HR4Q1mnwrjZnKZIHRp9cO3EszX93EajBaCqP0O7wOD8N
 1pBM3qtthAa0qyQM7Ls46a6cOE9zOSaoLZEZGp3kHIs2htqcjYxFxTSV8TQmDOVLlFjaSI_067eP
 SsAln0phdr_918AFvMJX39c.pP872Z0UvwJjJr0MMlbEN1_my9JBpP8AWAD52YzewCndgaJtVJkG
 _23WdMNfB7aO6JUdHmPGeXedo0tOTv9sHp8KydkJKGYgSQDz9E9Fd5zoOuO7qX9Z5z6TcTFWK3C8
 ioioCqpXm8luliy.N6J0UuG5cN0EhODfgdtTWLOaDs76HVF6Zw1nj7WdCg3op4FKj7z68e2807WW
 kpFJCz95PUrX7GPoxfXNoooEh9hbUUfpLFBNIKHUXunaK3UgDcCPUK3SylQ7hAi5V7aEhcIf0K25
 cnilYn5pRCMoDKg1cEdOegYqC.r9gsWQbw.WIYx2vUuaLXnQFJvwXfanJGQJFJ2aubzuewDQqgLs
 jYY_oDYJH5fl4YVEO1aWOcWRvklWZfL5CI1yw923m1UJaN9ZtArADrcOrVEdaJ0h1ZhTUt4jANks
 Dceh7IcxQ0tmwPU6kmoZ2elp3UQoGlMfAcG0bUQ04BoauBA3qmJO91ChzokKKf1tmG_5F5hI35Y4
 FWgoFZ0J6EkDN2ZmgJAqWkPAy4axDnPuYltfZ4d8xL8JediyJJARgZI45CSUGOZH8G7mNvOFA2O7
 Hsci_.Y3VlOsK6z2l2RDc4bhO.RuwoEbR7bBBXmDpwJ0Hn.gKJ3WuPtCDJOyHTRKf5UAm08YYWW9
 u0UJ237vaDx1n6HphaWfMBWVzDIGkB_zoNb9gHx9igbsknD9aghGybnE_GDhDtvIbhZOaktaKPT9
 PhcmVEcxUODzscY.Q8Wgt66RepDhu3Zde1xNh45_CnuZbpUTM.NOOqo9CtNKysKWg6H4E3HAe3Y0
 Y2cGynmQ0GRJHVyNX6LCHYlkvsryEgTjytqrPDPmHNNsmhVV5Z9bO6bH0IbqZenDs6c.AO8R2Uxo
 Cfd6cMcmA.cwM8mbwVH6jMKxbmmQbvthOgqVV7eZqOsOb2auDQBe8Vf5u6eFYkV0pD8QueUELDIX
 xWxjtKA4qE7gqoghm9n.LHLc2qwQm60E.TQjrJuHPuuLWBxs_QbuTQi5Y8eyrdqRsTn6eDz9LrXb
 bAuHbngQy5yPVi24Ur__nL3MGnX43OGcQSu.b_MWpkFq0tR72RHRb3Nd48GrXVvSt1tcdr.RVj5E
 EphZPkNBqTtaMoInMNaXqprct9SiobsCljX3TFgMozHQTjIu1qmDmJaDI_hqvXQIfVidnWRufxEd
 gSarMIXnAS7w2B1zsH1Ng_GvqaJevE_KVvose5vFNDcUUD9ahcwhCjNNw23idDkmdfiomGTFE5hi
 S_HeUWsU6FtiGRri75fGf0fx0ZXWe0j0M9I4A_gJYoXcjlw9Fu_zbwuj.uGr1On9T47tIsE9vg_K
 XZLwzp0GgLY8iRY0PWBh0XgP8YQ72mDk3pBppdrvEJS4n48c_b3HUwi2vrEuRz.NvoAdykYHYiSS
 fSqmq8rqqQU7KSuNN1gREvqGsvqg0SLYh9cVQW5lBsuWvML.rsekoYNF7g.rIroGqNMfClDeRaUK
 I4LY3XKTIv7fRMTHGAzRGlfUuB7ffkam5gQ4fnTSqkoEIelOrBvyC0v7n4uaNWGnAm_wh1Rg6a43
 ZL8G.mUvxq_JYbcIsw0yrjxuoKkCiBia1GvnCpWTQvCPMSVBwL5Y9.b7Z4o5zY4DKSUiSvUqz0Xw
 _ajQWusxbiMfZ_cCMgEd_sHGhLBpllE5V1AnCqna6xGKJAMPIlWj04T4A8savU_cytxDAKGT0v3a
 QF46nK0eibw9xg8hk0IU5XkNpL9w285lpwu2RvHxAFwoGua9.X2zcfq5z6rsf11XWkYX_TqruEI0
 sbDcnK8opHugD8BzbjscVtDMaprCa8YEclhKhkPCxQDCdpqEk7hNdk5Hnsuw64NEHiGBgCNiOX4t
 jDWglo5AuU9yCdd3eZn_FysMeu6F2Atd_1rAviacF8Hvqkhe2gPgEAol4Cv86X4ZwfBdQI45dWx1
 hWNj3Nd9.i6.hRKqIohTDcv1eX2Kh5uF9r4_2YDpRJsDoMdwCkPqJ1hL9
X-Sonic-MF: <ma.arghavani@yahoo.com>
X-Sonic-ID: da5ed14e-eeb6-44be-8bbb-29e393c6440d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.bf2.yahoo.com with HTTP; Wed, 8 Jan 2025 10:07:13 +0000
Date: Wed, 8 Jan 2025 09:34:48 +0000 (UTC)
From: Mahdi Arghavani <ma.arghavani@yahoo.com>
To: Neal Cardwell <ncardwell@google.com>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Haibo Zhang <haibo.zhang@otago.ac.nz>, 
	David Eyers <david.eyers@otago.ac.nz>, 
	Abbas Arghavani <abbas.arghavani@mdu.se>
Message-ID: <2046438615.4484034.1736328888690@mail.yahoo.com>
In-Reply-To: <CANn89iLzo0Wk7p=dtUQ4Q2-pCAsjSxXZw71ngNTw6NZbEEvoDA@mail.gmail.com>
References: <408334417.4436448.1736139157134.ref@mail.yahoo.com> <408334417.4436448.1736139157134@mail.yahoo.com> <CANn89iLzo0Wk7p=dtUQ4Q2-pCAsjSxXZw71ngNTw6NZbEEvoDA@mail.gmail.com>
Subject: Re: [PATCH net] tcp_cubic: Fix for bug in HyStart implementation in
 the Linux kernel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4484033_245042213.1736328888690"
X-Mailer: WebService/1.1.23040 YMailNorrin

------=_Part_4484033_245042213.1736328888690
Content-Type: multipart/alternative; 
	boundary="----=_Part_4484032_1675460777.1736328888521"

------=_Part_4484032_1675460777.1736328888521
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 Dear Eric and Neal,

Thank you for the email.
>>> Am I right to say you are referring to
commit 8165a96f6b7122f25bf809aecf06f17b0ec37b58
Yes. The issue arises as a side effect of the changes introduced in this co=
mmit.

>>> Please provide a packetdrill test, this will be the most efficient way =
to demonstrate the issue.
Below are two different methods of demonstrating the issue:A) Demonstrating=
 via the source codeThe changes introduced in commit 8165a9 move the caller=
 of the `bictcp_hystart_reset` function inside the `hystart_update` functio=
n.This modification adds an additional condition for triggering the caller,=
 requiring that (tcp_snd_cwnd(tp) >=3D hystart_low_window) must also be sat=
isfied before invoking `bictcp_hystart_reset`.
B) Demonstrating via a testUnfortunately, I was unable to directly print th=
e value of `ca->round_start` (a variable defined in `tcp_cubic.c`) using pa=
cketdrill and provide you with the requested script.Instead, I added a few =
lines of code to log the status of TCP variables upon packet transmission a=
nd ACK reception.To reproduce the same output on your Linux system, you nee=
d to apply the changes I made to `tcp_cubic.c` and `tcp_output.c` (see the =
attached files) and recompile the kernel.I used the attached packetdrill sc=
ript "only" to emulate data transmission for the test.Below are the logs ac=
cumulated in kern.log after running the packetdrill script:
In Line01, the start of the first round is marked by the cubictcp_init func=
tion. However, the second round is marked by the reception of the 7th ACK w=
hen cwnd is 16 (see Line20).This is incorrect because the 2nd round is star=
ted upon receiving the first ACK.This means that `ca->round_start` is updat=
ed at t=3D720994842, while it should have been updated 15.5 ms earlier, at =
t=3D720979320.In this test, the length of the ACK train in the second round=
 is calculated to be 15.5 ms shorter, which renders one of HyStart's criter=
ia ineffective.
Line01. 2025-01-08T08:16:23.321839+00:00 h1a kernel: New round is started. =
t=3D720873683 Sport=3D36895 cwnd=3D10 inflight=3D0 RTT=3D100300Line02. 2025=
-01-08T08:16:23.321842+00:00 h1a kernel: Pkt sending. t=3D720873878 Sport=
=3D36895 cwnd=3D10 inflight=3D0 RTT=3D100300 nextSeq=3D3915183479Line03. 20=
25-01-08T08:16:23.321845+00:00 h1a kernel: Pkt sending. t=3D720873896 Sport=
=3D36895 cwnd=3D10 inflight=3D2 RTT=3D100300 nextSeq=3D3915185479Line04. 20=
25-01-08T08:16:23.321847+00:00 h1a kernel: Pkt sending. t=3D720873896 Sport=
=3D36895 cwnd=3D10 inflight=3D4 RTT=3D100300 nextSeq=3D3915187479Line05. 20=
25-01-08T08:16:23.321849+00:00 h1a kernel: Pkt sending. t=3D720873896 Sport=
=3D36895 cwnd=3D10 inflight=3D6 RTT=3D100300 nextSeq=3D3915189479Line06. 20=
25-01-08T08:16:23.427777+00:00 h1a kernel: Pkt sending. t=3D720873896 Sport=
=3D36895 cwnd=3D10 inflight=3D8 RTT=3D100300 nextSeq=3D3915191479Line07. 20=
25-01-08T08:16:23.427787+00:00 h1a kernel: Ack receiving. t=3D720979320 Spo=
rt=3D36895 cwnd=3D10 inflight=3D9 RTT=3D100942 acked=3D1Line08. 2025-01-08T=
08:16:23.427790+00:00 h1a kernel: Pkt sending. t=3D720979335 Sport=3D36895 =
cwnd=3D11 inflight=3D9 RTT=3D100942 nextSeq=3D3915193479Line09. 2025-01-08T=
08:16:23.427792+00:00 h1a kernel: Ack receiving. t=3D720979421 Sport=3D3689=
5 cwnd=3D11 inflight=3D10 RTT=3D101517 acked=3D1Line10. 2025-01-08T08:16:23=
.432773+00:00 h1a kernel: Pkt sending. t=3D720979431 Sport=3D36895 cwnd=3D1=
2 inflight=3D10 RTT=3D101517 nextSeq=3D3915195479Line11. 2025-01-08T08:16:2=
3.432785+00:00 h1a kernel: Ack receiving. t=3D720984502 Sport=3D36895 cwnd=
=3D12 inflight=3D11 RTT=3D102654 acked=3D1Line12. 2025-01-08T08:16:23.43278=
8+00:00 h1a kernel: Pkt sending. t=3D720984514 Sport=3D36895 cwnd=3D13 infl=
ight=3D11 RTT=3D102654 nextSeq=3D3915197479Line13. 2025-01-08T08:16:23.4327=
90+00:00 h1a kernel: Ack receiving. t=3D720984585 Sport=3D36895 cwnd=3D13 i=
nflight=3D12 RTT=3D103658 acked=3D1Line14. 2025-01-08T08:16:23.437774+00:00=
 h1a kernel: Pkt sending. t=3D720984594 Sport=3D36895 cwnd=3D14 inflight=3D=
12 RTT=3D103658 nextSeq=3D3915199479Line15. 2025-01-08T08:16:23.437783+00:0=
0 h1a kernel: Ack receiving. t=3D720989668 Sport=3D36895 cwnd=3D14 inflight=
=3D13 RTT=3D105172 acked=3D1Line16. 2025-01-08T08:16:23.437785+00:00 h1a ke=
rnel: Pkt sending. t=3D720989679 Sport=3D36895 cwnd=3D15 inflight=3D13 RTT=
=3D105172 nextSeq=3D3915201479Line17. 2025-01-08T08:16:23.437787+00:00 h1a =
kernel: Ack receiving. t=3D720989747 Sport=3D36895 cwnd=3D15 inflight=3D14 =
RTT=3D106507 acked=3D1Line18. 2025-01-08T08:16:23.442773+00:00 h1a kernel: =
Pkt sending. t=3D720989757 Sport=3D36895 cwnd=3D16 inflight=3D14 RTT=3D1065=
07 nextSeq=3D3915203479Line19. 2025-01-08T08:16:23.442780+00:00 h1a kernel:=
 Ack receiving. t=3D720994842 Sport=3D36895 cwnd=3D16 inflight=3D15 RTT=3D1=
08312 acked=3D1
Line20. 2025-01-08T08:16:23.442782+00:00 h1a kernel: New round is started. =
t=3D720994842 Sport=3D36895 cwnd=3D16 inflight=3D15 RTT=3D108312
Line21. 2025-01-08T08:16:23.442783+00:00 h1a kernel: Pkt sending. t=3D72099=
4857 Sport=3D36895 cwnd=3D17 inflight=3D15 RTT=3D108312 nextSeq=3D391520547=
9Line22. 2025-01-08T08:16:23.442785+00:00 h1a kernel: Ack receiving. t=3D72=
0994927 Sport=3D36895 cwnd=3D17 inflight=3D16 RTT=3D109902 acked=3D1Line23.=
 2025-01-08T08:16:23.448788+00:00 h1a kernel: Pkt sending. t=3D720994936 Sp=
ort=3D36895 cwnd=3D18 inflight=3D16 RTT=3D109902 nextSeq=3D3915207479Line24=
. 2025-01-08T08:16:23.448805+00:00 h1a kernel: Ack receiving. t=3D721000016=
 Sport=3D36895 cwnd=3D18 inflight=3D17 RTT=3D111929 acked=3D1Line25. 2025-0=
1-08T08:16:23.448807+00:00 h1a kernel: Pkt sending. t=3D721000026 Sport=3D3=
6895 cwnd=3D19 inflight=3D17 RTT=3D111929 nextSeq=3D3915209479Line26. 2025-=
01-08T08:16:23.448808+00:00 h1a kernel: Ack receiving. t=3D721000100 Sport=
=3D36895 cwnd=3D19 inflight=3D18 RTT=3D113713 acked=3D1Line27. 2025-01-08T0=
8:16:23.496807+00:00 h1a kernel: Pkt sending. t=3D721000110 Sport=3D36895 c=
wnd=3D20 inflight=3D18 RTT=3D113713 nextSeq=3D3915211479

 >>> Note that we are still waiting for an HyStart++ implementation for lin=
ux, you may be interested in working on it.
Thank you for the suggestion. I would be happy to work on the HyStart++ imp=
lementation for Linux. Could you kindly provide more details on the specifi=
c requirements, workflow, and expected outcomes to help me get started?
Best wishes,Mahdi Arghavani
    On Monday, January 6, 2025 at 09:24:49 PM GMT+13, Eric Dumazet <edumaze=
t@google.com> wrote: =20
=20
 On Mon, Jan 6, 2025 at 5:53=E2=80=AFAM Mahdi Arghavani <ma.arghavani@yahoo=
.com> wrote:
>
> Hi,
>
> While refining the source code for our project (SUSS), I discovered a bug=
 in the implementation of HyStart in the Linux kernel, starting from versio=
n v5.15.6. The issue, caused by incorrect marking of round starts, results =
in inaccurate measurement of the length of each ACK train. Since HyStart re=
lies on the length of ACK trains as one of two key criteria to stop exponen=
tial cwnd growth during Slow-Start, this inaccuracy renders the criterion i=
neffective, potentially degrading TCP performance.
>

Hi Mahdi

netdev@ mailing list does not accept HTML messages.

Am I right to say you are referring to

commit 8165a96f6b7122f25bf809aecf06f17b0ec37b58
Author: Eric Dumazet <edumazet@google.com>
Date:=C2=A0 Tue Nov 23 12:25:35 2021 -0800

=C2=A0 =C2=A0 tcp_cubic: fix spurious Hystart ACK train detections for
not-cwnd-limited flows

=C2=A0 =C2=A0 [ Upstream commit 4e1fddc98d2585ddd4792b5e44433dcee7ece001 ]



> Issue Description: The problem arises because the hystart_reset function =
is not called upon receiving the first ACK (when cwnd=3Diw=3D10, see the at=
tached figure). Instead, its invocation is delayed until the condition cwnd=
 >=3D hystart_low_window is satisfied. In each round, this delay causes:
>
> 1) A postponed marking of the start of a new round.
>
> 2) An incorrect update of ca->end_seq, leading to incorrect marking of th=
e subsequent round.
>
> As a result, the ACK train length is underestimated, which adversely affe=
cts HyStart=E2=80=99s first criterion for stopping cwnd exponential growth.
>
> Proposed Solution: Below is a tested patch that addresses the issue by en=
suring hystart_reset is triggered appropriately:
>



Please provide a packetdrill test, this will be the most efficient way
to demonstrate the issue.

In general, ACK trains detection is not useful in modern networks,
because of TSO and GRO.

Reference : https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3Dede656e8465839530c3287c7f54adf75dc2b9563

Note that we are still waiting for an HyStart++ implementation for linux,
you may be interested in working on it.

Thank you.

>
>
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
>
> index 5dbed91c6178..78d9cf493ace 100644
>
> --- a/net/ipv4/tcp_cubic.c
>
> +++ b/net/ipv4/tcp_cubic.c
>
> @@ -392,6 +392,9 @@ static void hystart_update(struct sock *sk, u32 delay=
)
>
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (after(tp->snd_una, ca->end_seq))
>
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bictcp_hystart_res=
et(sk);
>
>
>
> +=C2=A0 =C2=A0 =C2=A0 if (tcp_snd_cwnd(tp) < hystart_low_window)
>
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>
> +
>
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hystart_detect & HYSTART_ACK_TRAIN) {
>
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 now =3D bictcp=
_clock_us(sk);
>
>
>
> @@ -468,8 +471,7 @@ __bpf_kfunc static void cubictcp_acked(struct sock *s=
k, const struct ack_sample
>
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ca->delay_min =3D =
delay;
>
>
>
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* hystart triggers when cwnd is larger than s=
ome threshold */
>
> -=C2=A0 =C2=A0 =C2=A0 if (!ca->found && tcp_in_slow_start(tp) && hystart =
&&
>
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcp_snd_cwnd(tp) >=3D hystart_low_win=
dow)
>
> +=C2=A0 =C2=A0 =C2=A0 if (!ca->found && tcp_in_slow_start(tp) && hystart)
>
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hystart_update(sk,=
 delay);
>
>=C2=A0 }
>
> Best wishes,
> Mahdi Arghavani
 =20
------=_Part_4484032_1675460777.1736328888521
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div class=3D"ydp57a11320yahoo-style-wrap" style=
=3D"font-family:times new roman, new york, times, serif;font-size:16px;"><d=
iv></div>
        <div dir=3D"ltr" data-setdir=3D"false"><div><div dir=3D"ltr" data-s=
etdir=3D"false">Dear Eric and Neal,<br></div><div><br></div><div>Thank you =
for the email.</div><div><br></div><div>&gt;&gt;&gt; Am I right to say you =
are referring to<br></div><div>commit 8165a96f6b7122f25bf809aecf06f17b0ec37=
b58</div><div><br></div><div>Yes. The issue arises as a side effect of the =
changes introduced in this commit.<br></div><div><br></div><div>&gt;&gt;&gt=
; Please provide a packetdrill test, this will be the most efficient way to=
 demonstrate the issue.</div><div><br></div><div>Below are two different me=
thods of demonstrating the issue:</div><div>A) Demonstrating via the source=
 code</div><div>The changes introduced in commit 8165a9 move the caller of =
the `bictcp_hystart_reset` function inside the `hystart_update` function.</=
div><div>This modification adds an additional condition for triggering the =
caller, requiring that (tcp_snd_cwnd(tp) &gt;=3D hystart_low_window) must a=
lso be satisfied before invoking `bictcp_hystart_reset`.</div><div><br></di=
v><div>B) Demonstrating via a test</div><div>Unfortunately, I was unable to=
 directly print the value of `ca-&gt;round_start` (a variable defined in `t=
cp_cubic.c`) using packetdrill and provide you with the requested script.</=
div><div>Instead, I added a few lines of code to log the status of TCP vari=
ables upon packet transmission and ACK reception.</div><div>To reproduce th=
e same output on your Linux system, you need to apply the changes I made to=
 `tcp_cubic.c` and `tcp_output.c` (see the attached files) and recompile th=
e kernel.</div><div>I used the attached packetdrill script "only" to emulat=
e data transmission for the test.</div><div>Below are the logs accumulated =
in kern.log after running the packetdrill script:</div><div><br></div><div>=
In Line01, the start of the first round is marked by the cubictcp_init func=
tion. However, the second round is marked by the reception of the 7th ACK w=
hen cwnd is 16 (see Line20).</div><div>This is incorrect because the 2nd ro=
und is started upon receiving the first ACK.</div><div>This means that `ca-=
&gt;round_start` is updated at t=3D720994842, while it should have been upd=
ated 15.5 ms earlier, at t=3D720979320.</div><div>In this test, the length =
of the ACK train in the second round is calculated to be 15.5 ms shorter, w=
hich renders one of HyStart's criteria ineffective.</div><div><br></div><di=
v>Line01. 2025-01-08T08:16:23.321839+00:00 h1a kernel: New round is started=
. t=3D720873683 Sport=3D36895 cwnd=3D10 inflight=3D0 RTT=3D100300</div><div=
>Line02. 2025-01-08T08:16:23.321842+00:00 h1a kernel: Pkt sending. t=3D7208=
73878 Sport=3D36895 cwnd=3D10 inflight=3D0 RTT=3D100300 nextSeq=3D391518347=
9</div><div>Line03. 2025-01-08T08:16:23.321845+00:00 h1a kernel: Pkt sendin=
g. t=3D720873896 Sport=3D36895 cwnd=3D10 inflight=3D2 RTT=3D100300 nextSeq=
=3D3915185479</div><div>Line04. 2025-01-08T08:16:23.321847+00:00 h1a kernel=
: Pkt sending. t=3D720873896 Sport=3D36895 cwnd=3D10 inflight=3D4 RTT=3D100=
300 nextSeq=3D3915187479</div><div>Line05. 2025-01-08T08:16:23.321849+00:00=
 h1a kernel: Pkt sending. t=3D720873896 Sport=3D36895 cwnd=3D10 inflight=3D=
6 RTT=3D100300 nextSeq=3D3915189479</div><div>Line06. 2025-01-08T08:16:23.4=
27777+00:00 h1a kernel: Pkt sending. t=3D720873896 Sport=3D36895 cwnd=3D10 =
inflight=3D8 RTT=3D100300 nextSeq=3D3915191479</div><div>Line07. 2025-01-08=
T08:16:23.427787+00:00 h1a kernel: Ack receiving. t=3D720979320 Sport=3D368=
95 cwnd=3D10 inflight=3D9 RTT=3D100942 acked=3D1</div><div>Line08. 2025-01-=
08T08:16:23.427790+00:00 h1a kernel: Pkt sending. t=3D720979335 Sport=3D368=
95 cwnd=3D11 inflight=3D9 RTT=3D100942 nextSeq=3D3915193479</div><div>Line0=
9. 2025-01-08T08:16:23.427792+00:00 h1a kernel: Ack receiving. t=3D72097942=
1 Sport=3D36895 cwnd=3D11 inflight=3D10 RTT=3D101517 acked=3D1</div><div>Li=
ne10. 2025-01-08T08:16:23.432773+00:00 h1a kernel: Pkt sending. t=3D7209794=
31 Sport=3D36895 cwnd=3D12 inflight=3D10 RTT=3D101517 nextSeq=3D3915195479<=
/div><div>Line11. 2025-01-08T08:16:23.432785+00:00 h1a kernel: Ack receivin=
g. t=3D720984502 Sport=3D36895 cwnd=3D12 inflight=3D11 RTT=3D102654 acked=
=3D1</div><div>Line12. 2025-01-08T08:16:23.432788+00:00 h1a kernel: Pkt sen=
ding. t=3D720984514 Sport=3D36895 cwnd=3D13 inflight=3D11 RTT=3D102654 next=
Seq=3D3915197479</div><div>Line13. 2025-01-08T08:16:23.432790+00:00 h1a ker=
nel: Ack receiving. t=3D720984585 Sport=3D36895 cwnd=3D13 inflight=3D12 RTT=
=3D103658 acked=3D1</div><div>Line14. 2025-01-08T08:16:23.437774+00:00 h1a =
kernel: Pkt sending. t=3D720984594 Sport=3D36895 cwnd=3D14 inflight=3D12 RT=
T=3D103658 nextSeq=3D3915199479</div><div>Line15. 2025-01-08T08:16:23.43778=
3+00:00 h1a kernel: Ack receiving. t=3D720989668 Sport=3D36895 cwnd=3D14 in=
flight=3D13 RTT=3D105172 acked=3D1</div><div>Line16. 2025-01-08T08:16:23.43=
7785+00:00 h1a kernel: Pkt sending. t=3D720989679 Sport=3D36895 cwnd=3D15 i=
nflight=3D13 RTT=3D105172 nextSeq=3D3915201479</div><div>Line17. 2025-01-08=
T08:16:23.437787+00:00 h1a kernel: Ack receiving. t=3D720989747 Sport=3D368=
95 cwnd=3D15 inflight=3D14 RTT=3D106507 acked=3D1</div><div>Line18. 2025-01=
-08T08:16:23.442773+00:00 h1a kernel: Pkt sending. t=3D720989757 Sport=3D36=
895 cwnd=3D16 inflight=3D14 RTT=3D106507 nextSeq=3D3915203479</div><div>Lin=
e19. 2025-01-08T08:16:23.442780+00:00 h1a kernel: Ack receiving. t=3D720994=
842 Sport=3D36895 cwnd=3D16 inflight=3D15 RTT=3D108312 acked=3D1</div><div>=
<br></div><div>Line20. 2025-01-08T08:16:23.442782+00:00 h1a kernel: New rou=
nd is started. t=3D720994842 Sport=3D36895 cwnd=3D16 inflight=3D15 RTT=3D10=
8312</div><div><br></div><div>Line21. 2025-01-08T08:16:23.442783+00:00 h1a =
kernel: Pkt sending. t=3D720994857 Sport=3D36895 cwnd=3D17 inflight=3D15 RT=
T=3D108312 nextSeq=3D3915205479</div><div>Line22. 2025-01-08T08:16:23.44278=
5+00:00 h1a kernel: Ack receiving. t=3D720994927 Sport=3D36895 cwnd=3D17 in=
flight=3D16 RTT=3D109902 acked=3D1</div><div>Line23. 2025-01-08T08:16:23.44=
8788+00:00 h1a kernel: Pkt sending. t=3D720994936 Sport=3D36895 cwnd=3D18 i=
nflight=3D16 RTT=3D109902 nextSeq=3D3915207479</div><div>Line24. 2025-01-08=
T08:16:23.448805+00:00 h1a kernel: Ack receiving. t=3D721000016 Sport=3D368=
95 cwnd=3D18 inflight=3D17 RTT=3D111929 acked=3D1</div><div>Line25. 2025-01=
-08T08:16:23.448807+00:00 h1a kernel: Pkt sending. t=3D721000026 Sport=3D36=
895 cwnd=3D19 inflight=3D17 RTT=3D111929 nextSeq=3D3915209479</div><div>Lin=
e26. 2025-01-08T08:16:23.448808+00:00 h1a kernel: Ack receiving. t=3D721000=
100 Sport=3D36895 cwnd=3D19 inflight=3D18 RTT=3D113713 acked=3D1</div><div>=
Line27. 2025-01-08T08:16:23.496807+00:00 h1a kernel: Pkt sending. t=3D72100=
0110 Sport=3D36895 cwnd=3D20 inflight=3D18 RTT=3D113713 nextSeq=3D391521147=
9</div></div><br></div><div><br></div><div dir=3D"ltr" data-setdir=3D"false=
"> <div><div>&gt;&gt;&gt; Note that we are still waiting for an HyStart++ i=
mplementation for linux, you may be interested in working on it.</div><div>=
<br></div><div>Thank you for the suggestion. I would be happy to work on th=
e HyStart++ implementation for Linux. Could you kindly provide more details=
 on the specific requirements, workflow, and expected outcomes to help me g=
et started?</div><div><br></div><div>Best wishes,</div><div>Mahdi Arghavani=
</div></div><br></div>
       =20
        </div><div id=3D"yahoo_quoted_6851716305" class=3D"yahoo_quoted">
            <div style=3D"font-family:'Helvetica Neue', Helvetica, Arial, s=
ans-serif;font-size:13px;color:#26282a;">
               =20
                <div>
                        On Monday, January 6, 2025 at 09:24:49 PM GMT+13, E=
ric Dumazet &lt;edumazet@google.com&gt; wrote:
                    </div>
                    <div><br></div>
                    <div><br></div>
               =20
               =20
                <div><div dir=3D"ltr">On Mon, Jan 6, 2025 at 5:53=E2=80=AFA=
M Mahdi Arghavani &lt;<a shape=3D"rect" ymailto=3D"mailto:ma.arghavani@yaho=
o.com" href=3D"mailto:ma.arghavani@yahoo.com">ma.arghavani@yahoo.com</a>&gt=
; wrote:<br clear=3D"none">&gt;<br clear=3D"none">&gt; Hi,<br clear=3D"none=
">&gt;<br clear=3D"none">&gt; While refining the source code for our projec=
t (SUSS), I discovered a bug in the implementation of HyStart in the Linux =
kernel, starting from version v5.15.6. The issue, caused by incorrect marki=
ng of round starts, results in inaccurate measurement of the length of each=
 ACK train. Since HyStart relies on the length of ACK trains as one of two =
key criteria to stop exponential cwnd growth during Slow-Start, this inaccu=
racy renders the criterion ineffective, potentially degrading TCP performan=
ce.<br clear=3D"none">&gt;<br clear=3D"none"><br clear=3D"none">Hi Mahdi<br=
 clear=3D"none"><br clear=3D"none">netdev@ mailing list does not accept HTM=
L messages.<br clear=3D"none"><br clear=3D"none">Am I right to say you are =
referring to<br clear=3D"none"><br clear=3D"none">commit 8165a96f6b7122f25b=
f809aecf06f17b0ec37b58<br clear=3D"none">Author: Eric Dumazet &lt;<a shape=
=3D"rect" ymailto=3D"mailto:edumazet@google.com" href=3D"mailto:edumazet@go=
ogle.com">edumazet@google.com</a>&gt;<br clear=3D"none">Date:&nbsp;  Tue No=
v 23 12:25:35 2021 -0800<br clear=3D"none"><br clear=3D"none">&nbsp; &nbsp;=
 tcp_cubic: fix spurious Hystart ACK train detections for<br clear=3D"none"=
>not-cwnd-limited flows<br clear=3D"none"><br clear=3D"none">&nbsp; &nbsp; =
[ Upstream commit 4e1fddc98d2585ddd4792b5e44433dcee7ece001 ]<br clear=3D"no=
ne"><br clear=3D"none"><br clear=3D"none"><br clear=3D"none">&gt; Issue Des=
cription: The problem arises because the hystart_reset function is not call=
ed upon receiving the first ACK (when cwnd=3Diw=3D10, see the attached figu=
re). Instead, its invocation is delayed until the condition cwnd &gt;=3D hy=
start_low_window is satisfied. In each round, this delay causes:<br clear=
=3D"none">&gt;<br clear=3D"none">&gt; 1) A postponed marking of the start o=
f a new round.<br clear=3D"none">&gt;<br clear=3D"none">&gt; 2) An incorrec=
t update of ca-&gt;end_seq, leading to incorrect marking of the subsequent =
round.<br clear=3D"none">&gt;<br clear=3D"none">&gt; As a result, the ACK t=
rain length is underestimated, which adversely affects HyStart=E2=80=99s fi=
rst criterion for stopping cwnd exponential growth.<br clear=3D"none">&gt;<=
br clear=3D"none">&gt; Proposed Solution: Below is a tested patch that addr=
esses the issue by ensuring hystart_reset is triggered appropriately:<br cl=
ear=3D"none">&gt;<br clear=3D"none"><br clear=3D"none"><br clear=3D"none"><=
br clear=3D"none">Please provide a packetdrill test, this will be the most =
efficient way<br clear=3D"none">to demonstrate the issue.<br clear=3D"none"=
><br clear=3D"none">In general, ACK trains detection is not useful in moder=
n networks,<br clear=3D"none">because of TSO and GRO.<br clear=3D"none"><br=
 clear=3D"none">Reference : <a shape=3D"rect" href=3D"https://git.kernel.or=
g/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3Dede656e846583953=
0c3287c7f54adf75dc2b9563" target=3D"_blank">https://git.kernel.org/pub/scm/=
linux/kernel/git/torvalds/linux.git/commit/?id=3Dede656e8465839530c3287c7f5=
4adf75dc2b9563</a><br clear=3D"none"><br clear=3D"none">Note that we are st=
ill waiting for an HyStart++ implementation for linux,<br clear=3D"none">yo=
u may be interested in working on it.<br clear=3D"none"><br clear=3D"none">=
Thank you.<div class=3D"yqt4041069213" id=3D"yqtfd59579"><br clear=3D"none"=
><br clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt; diff=
 --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c<br clear=3D"none">&gt;=
<br clear=3D"none">&gt; index 5dbed91c6178..78d9cf493ace 100644<br clear=3D=
"none">&gt;<br clear=3D"none">&gt; --- a/net/ipv4/tcp_cubic.c<br clear=3D"n=
one">&gt;<br clear=3D"none">&gt; +++ b/net/ipv4/tcp_cubic.c<br clear=3D"non=
e">&gt;<br clear=3D"none">&gt; @@ -392,6 +392,9 @@ static void hystart_upda=
te(struct sock *sk, u32 delay)<br clear=3D"none">&gt;<br clear=3D"none">&gt=
;&nbsp; &nbsp; &nbsp; &nbsp;  if (after(tp-&gt;snd_una, ca-&gt;end_seq))<br=
 clear=3D"none">&gt;<br clear=3D"none">&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;  bictcp_hystart_reset(sk);<br clear=3D"none">&gt;<b=
r clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt; +&nbsp;=
 &nbsp; &nbsp;  if (tcp_snd_cwnd(tp) &lt; hystart_low_window)<br clear=3D"n=
one">&gt;<br clear=3D"none">&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp;  return;<br clear=3D"none">&gt;<br clear=3D"none">&gt; +<br clear=
=3D"none">&gt;<br clear=3D"none">&gt;&nbsp; &nbsp; &nbsp; &nbsp;  if (hysta=
rt_detect &amp; HYSTART_ACK_TRAIN) {<br clear=3D"none">&gt;<br clear=3D"non=
e">&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  u32 now =3D=
 bictcp_clock_us(sk);<br clear=3D"none">&gt;<br clear=3D"none">&gt;<br clea=
r=3D"none">&gt;<br clear=3D"none">&gt; @@ -468,8 +471,7 @@ __bpf_kfunc stat=
ic void cubictcp_acked(struct sock *sk, const struct ack_sample<br clear=3D=
"none">&gt;<br clear=3D"none">&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp;  ca-&gt;delay_min =3D delay;<br clear=3D"none">&gt;<br clear=
=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt;&nbsp; &nbsp; &=
nbsp; &nbsp;  /* hystart triggers when cwnd is larger than some threshold *=
/<br clear=3D"none">&gt;<br clear=3D"none">&gt; -&nbsp; &nbsp; &nbsp;  if (=
!ca-&gt;found &amp;&amp; tcp_in_slow_start(tp) &amp;&amp; hystart &amp;&amp=
;<br clear=3D"none">&gt;<br clear=3D"none">&gt; -&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;  tcp_snd_cwnd(tp) &gt;=3D hystart_low_window)<br clear=3D"none">&g=
t;<br clear=3D"none">&gt; +&nbsp; &nbsp; &nbsp;  if (!ca-&gt;found &amp;&am=
p; tcp_in_slow_start(tp) &amp;&amp; hystart)<br clear=3D"none">&gt;<br clea=
r=3D"none">&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  hys=
tart_update(sk, delay);<br clear=3D"none">&gt;<br clear=3D"none">&gt;&nbsp;=
 }<br clear=3D"none">&gt;<br clear=3D"none">&gt; Best wishes,<br clear=3D"n=
one">&gt; Mahdi Arghavani<br clear=3D"none"></div></div></div>
            </div>
        </div></body></html>
------=_Part_4484032_1675460777.1736328888521--

------=_Part_4484033_245042213.1736328888690
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="log.txt"
Content-ID: <d6e3d995-5d33-898f-63d3-c4569f60e261@yahoo.com>

TGluZTAxLiAyMDI1LTAxLTA4VDA4OjE2OjIzLjMyMTgzOSswMDowMCBoMWEga2VybmVsOiBOZXcg
cm91bmQgaXMgc3RhcnRlZC4gdD03MjA4NzM2ODMgU3BvcnQ9MzY4OTUgY3duZD0xMCBpbmZsaWdo
dD0wIFJUVD0xMDAzMDAKTGluZTAyLiAyMDI1LTAxLTA4VDA4OjE2OjIzLjMyMTg0MiswMDowMCBo
MWEga2VybmVsOiBQa3Qgc2VuZGluZy4gdD03MjA4NzM4NzggU3BvcnQ9MzY4OTUgY3duZD0xMCBp
bmZsaWdodD0wIFJUVD0xMDAzMDAgbmV4dFNlcT0zOTE1MTgzNDc5CkxpbmUwMy4gMjAyNS0wMS0w
OFQwODoxNjoyMy4zMjE4NDUrMDA6MDAgaDFhIGtlcm5lbDogUGt0IHNlbmRpbmcuIHQ9NzIwODcz
ODk2IFNwb3J0PTM2ODk1IGN3bmQ9MTAgaW5mbGlnaHQ9MiBSVFQ9MTAwMzAwIG5leHRTZXE9Mzkx
NTE4NTQ3OQpMaW5lMDQuIDIwMjUtMDEtMDhUMDg6MTY6MjMuMzIxODQ3KzAwOjAwIGgxYSBrZXJu
ZWw6IFBrdCBzZW5kaW5nLiB0PTcyMDg3Mzg5NiBTcG9ydD0zNjg5NSBjd25kPTEwIGluZmxpZ2h0
PTQgUlRUPTEwMDMwMCBuZXh0U2VxPTM5MTUxODc0NzkKTGluZTA1LiAyMDI1LTAxLTA4VDA4OjE2
OjIzLjMyMTg0OSswMDowMCBoMWEga2VybmVsOiBQa3Qgc2VuZGluZy4gdD03MjA4NzM4OTYgU3Bv
cnQ9MzY4OTUgY3duZD0xMCBpbmZsaWdodD02IFJUVD0xMDAzMDAgbmV4dFNlcT0zOTE1MTg5NDc5
CkxpbmUwNi4gMjAyNS0wMS0wOFQwODoxNjoyMy40Mjc3NzcrMDA6MDAgaDFhIGtlcm5lbDogUGt0
IHNlbmRpbmcuIHQ9NzIwODczODk2IFNwb3J0PTM2ODk1IGN3bmQ9MTAgaW5mbGlnaHQ9OCBSVFQ9
MTAwMzAwIG5leHRTZXE9MzkxNTE5MTQ3OQpMaW5lMDcuIDIwMjUtMDEtMDhUMDg6MTY6MjMuNDI3
Nzg3KzAwOjAwIGgxYSBrZXJuZWw6IEFjayByZWNlaXZpbmcuIHQ9NzIwOTc5MzIwIFNwb3J0PTM2
ODk1IGN3bmQ9MTAgaW5mbGlnaHQ9OSBSVFQ9MTAwOTQyIGFja2VkPTEKTGluZTA4LiAyMDI1LTAx
LTA4VDA4OjE2OjIzLjQyNzc5MCswMDowMCBoMWEga2VybmVsOiBQa3Qgc2VuZGluZy4gdD03MjA5
NzkzMzUgU3BvcnQ9MzY4OTUgY3duZD0xMSBpbmZsaWdodD05IFJUVD0xMDA5NDIgbmV4dFNlcT0z
OTE1MTkzNDc5CkxpbmUwOS4gMjAyNS0wMS0wOFQwODoxNjoyMy40Mjc3OTIrMDA6MDAgaDFhIGtl
cm5lbDogQWNrIHJlY2VpdmluZy4gdD03MjA5Nzk0MjEgU3BvcnQ9MzY4OTUgY3duZD0xMSBpbmZs
aWdodD0xMCBSVFQ9MTAxNTE3IGFja2VkPTEKTGluZTEwLiAyMDI1LTAxLTA4VDA4OjE2OjIzLjQz
Mjc3MyswMDowMCBoMWEga2VybmVsOiBQa3Qgc2VuZGluZy4gdD03MjA5Nzk0MzEgU3BvcnQ9MzY4
OTUgY3duZD0xMiBpbmZsaWdodD0xMCBSVFQ9MTAxNTE3IG5leHRTZXE9MzkxNTE5NTQ3OQpMaW5l
MTEuIDIwMjUtMDEtMDhUMDg6MTY6MjMuNDMyNzg1KzAwOjAwIGgxYSBrZXJuZWw6IEFjayByZWNl
aXZpbmcuIHQ9NzIwOTg0NTAyIFNwb3J0PTM2ODk1IGN3bmQ9MTIgaW5mbGlnaHQ9MTEgUlRUPTEw
MjY1NCBhY2tlZD0xCkxpbmUxMi4gMjAyNS0wMS0wOFQwODoxNjoyMy40MzI3ODgrMDA6MDAgaDFh
IGtlcm5lbDogUGt0IHNlbmRpbmcuIHQ9NzIwOTg0NTE0IFNwb3J0PTM2ODk1IGN3bmQ9MTMgaW5m
bGlnaHQ9MTEgUlRUPTEwMjY1NCBuZXh0U2VxPTM5MTUxOTc0NzkKTGluZTEzLiAyMDI1LTAxLTA4
VDA4OjE2OjIzLjQzMjc5MCswMDowMCBoMWEga2VybmVsOiBBY2sgcmVjZWl2aW5nLiB0PTcyMDk4
NDU4NSBTcG9ydD0zNjg5NSBjd25kPTEzIGluZmxpZ2h0PTEyIFJUVD0xMDM2NTggYWNrZWQ9MQpM
aW5lMTQuIDIwMjUtMDEtMDhUMDg6MTY6MjMuNDM3Nzc0KzAwOjAwIGgxYSBrZXJuZWw6IFBrdCBz
ZW5kaW5nLiB0PTcyMDk4NDU5NCBTcG9ydD0zNjg5NSBjd25kPTE0IGluZmxpZ2h0PTEyIFJUVD0x
MDM2NTggbmV4dFNlcT0zOTE1MTk5NDc5CkxpbmUxNS4gMjAyNS0wMS0wOFQwODoxNjoyMy40Mzc3
ODMrMDA6MDAgaDFhIGtlcm5lbDogQWNrIHJlY2VpdmluZy4gdD03MjA5ODk2NjggU3BvcnQ9MzY4
OTUgY3duZD0xNCBpbmZsaWdodD0xMyBSVFQ9MTA1MTcyIGFja2VkPTEKTGluZTE2LiAyMDI1LTAx
LTA4VDA4OjE2OjIzLjQzNzc4NSswMDowMCBoMWEga2VybmVsOiBQa3Qgc2VuZGluZy4gdD03MjA5
ODk2NzkgU3BvcnQ9MzY4OTUgY3duZD0xNSBpbmZsaWdodD0xMyBSVFQ9MTA1MTcyIG5leHRTZXE9
MzkxNTIwMTQ3OQpMaW5lMTcuIDIwMjUtMDEtMDhUMDg6MTY6MjMuNDM3Nzg3KzAwOjAwIGgxYSBr
ZXJuZWw6IEFjayByZWNlaXZpbmcuIHQ9NzIwOTg5NzQ3IFNwb3J0PTM2ODk1IGN3bmQ9MTUgaW5m
bGlnaHQ9MTQgUlRUPTEwNjUwNyBhY2tlZD0xCkxpbmUxOC4gMjAyNS0wMS0wOFQwODoxNjoyMy40
NDI3NzMrMDA6MDAgaDFhIGtlcm5lbDogUGt0IHNlbmRpbmcuIHQ9NzIwOTg5NzU3IFNwb3J0PTM2
ODk1IGN3bmQ9MTYgaW5mbGlnaHQ9MTQgUlRUPTEwNjUwNyBuZXh0U2VxPTM5MTUyMDM0NzkKTGlu
ZTE5LiAyMDI1LTAxLTA4VDA4OjE2OjIzLjQ0Mjc4MCswMDowMCBoMWEga2VybmVsOiBBY2sgcmVj
ZWl2aW5nLiB0PTcyMDk5NDg0MiBTcG9ydD0zNjg5NSBjd25kPTE2IGluZmxpZ2h0PTE1IFJUVD0x
MDgzMTIgYWNrZWQ9MQoKTGluZTIwLiAyMDI1LTAxLTA4VDA4OjE2OjIzLjQ0Mjc4MiswMDowMCBo
MWEga2VybmVsOiBOZXcgcm91bmQgaXMgc3RhcnRlZC4gdD03MjA5OTQ4NDIgU3BvcnQ9MzY4OTUg
Y3duZD0xNiBpbmZsaWdodD0xNSBSVFQ9MTA4MzEyCgpMaW5lMjEuIDIwMjUtMDEtMDhUMDg6MTY6
MjMuNDQyNzgzKzAwOjAwIGgxYSBrZXJuZWw6IFBrdCBzZW5kaW5nLiB0PTcyMDk5NDg1NyBTcG9y
dD0zNjg5NSBjd25kPTE3IGluZmxpZ2h0PTE1IFJUVD0xMDgzMTIgbmV4dFNlcT0zOTE1MjA1NDc5
CkxpbmUyMi4gMjAyNS0wMS0wOFQwODoxNjoyMy40NDI3ODUrMDA6MDAgaDFhIGtlcm5lbDogQWNr
IHJlY2VpdmluZy4gdD03MjA5OTQ5MjcgU3BvcnQ9MzY4OTUgY3duZD0xNyBpbmZsaWdodD0xNiBS
VFQ9MTA5OTAyIGFja2VkPTEKTGluZTIzLiAyMDI1LTAxLTA4VDA4OjE2OjIzLjQ0ODc4OCswMDow
MCBoMWEga2VybmVsOiBQa3Qgc2VuZGluZy4gdD03MjA5OTQ5MzYgU3BvcnQ9MzY4OTUgY3duZD0x
OCBpbmZsaWdodD0xNiBSVFQ9MTA5OTAyIG5leHRTZXE9MzkxNTIwNzQ3OQpMaW5lMjQuIDIwMjUt
MDEtMDhUMDg6MTY6MjMuNDQ4ODA1KzAwOjAwIGgxYSBrZXJuZWw6IEFjayByZWNlaXZpbmcuIHQ9
NzIxMDAwMDE2IFNwb3J0PTM2ODk1IGN3bmQ9MTggaW5mbGlnaHQ9MTcgUlRUPTExMTkyOSBhY2tl
ZD0xCkxpbmUyNS4gMjAyNS0wMS0wOFQwODoxNjoyMy40NDg4MDcrMDA6MDAgaDFhIGtlcm5lbDog
UGt0IHNlbmRpbmcuIHQ9NzIxMDAwMDI2IFNwb3J0PTM2ODk1IGN3bmQ9MTkgaW5mbGlnaHQ9MTcg
UlRUPTExMTkyOSBuZXh0U2VxPTM5MTUyMDk0NzkKTGluZTI2LiAyMDI1LTAxLTA4VDA4OjE2OjIz
LjQ0ODgwOCswMDowMCBoMWEga2VybmVsOiBBY2sgcmVjZWl2aW5nLiB0PTcyMTAwMDEwMCBTcG9y
dD0zNjg5NSBjd25kPTE5IGluZmxpZ2h0PTE4IFJUVD0xMTM3MTMgYWNrZWQ9MQpMaW5lMjcuIDIw
MjUtMDEtMDhUMDg6MTY6MjMuNDk2ODA3KzAwOjAwIGgxYSBrZXJuZWw6IFBrdCBzZW5kaW5nLiB0
PTcyMTAwMDExMCBTcG9ydD0zNjg5NSBjd25kPTIwIGluZmxpZ2h0PTE4IFJUVD0xMTM3MTMgbmV4
dFNlcT0zOTE1MjExNDc5Cg==

------=_Part_4484033_245042213.1736328888690
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="tcp_cubic.c"
Content-ID: <57d3b17f-9368-f570-5060-f0dec4ab05a0@yahoo.com>

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQovKgogKiBUQ1AgQ1VCSUM6
IEJpbmFyeSBJbmNyZWFzZSBDb25nZXN0aW9uIGNvbnRyb2wgZm9yIFRDUCB2Mi4zCiAqIEhvbWUg
cGFnZToKICogICAgICBodHRwOi8vbmV0c3J2LmNzYy5uY3N1LmVkdS90d2lraS9iaW4vdmlldy9N
YWluL0JJQwogKiBUaGlzIGlzIGZyb20gdGhlIGltcGxlbWVudGF0aW9uIG9mIENVQklDIFRDUCBp
bgogKiBTYW5ndGFlIEhhLCBJbmpvbmcgUmhlZSBhbmQgTGlzb25nIFh1LAogKiAgIkNVQklDOiBB
IE5ldyBUQ1AtRnJpZW5kbHkgSGlnaC1TcGVlZCBUQ1AgVmFyaWFudCIKICogIGluIEFDTSBTSUdP
UFMgT3BlcmF0aW5nIFN5c3RlbSBSZXZpZXcsIEp1bHkgMjAwOC4KICogQXZhaWxhYmxlIGZyb206
CiAqICBodHRwOi8vbmV0c3J2LmNzYy5uY3N1LmVkdS9leHBvcnQvY3ViaWNfYV9uZXdfdGNwXzIw
MDgucGRmCiAqCiAqIENVQklDIGludGVncmF0ZXMgYSBuZXcgc2xvdyBzdGFydCBhbGdvcml0aG0s
IGNhbGxlZCBIeVN0YXJ0LgogKiBUaGUgZGV0YWlscyBvZiBIeVN0YXJ0IGFyZSBwcmVzZW50ZWQg
aW4KICogIFNhbmd0YWUgSGEgYW5kIEluam9uZyBSaGVlLAogKiAgIlRhbWluZyB0aGUgRWxlcGhh
bnRzOiBOZXcgVENQIFNsb3cgU3RhcnQiLCBOQ1NVIFRlY2hSZXBvcnQgMjAwOC4KICogQXZhaWxh
YmxlIGZyb206CiAqICBodHRwOi8vbmV0c3J2LmNzYy5uY3N1LmVkdS9leHBvcnQvaHlzdGFydF90
ZWNocmVwb3J0XzIwMDgucGRmCiAqCiAqIEFsbCB0ZXN0aW5nIHJlc3VsdHMgYXJlIGF2YWlsYWJs
ZSBmcm9tOgogKiBodHRwOi8vbmV0c3J2LmNzYy5uY3N1LmVkdS93aWtpL2luZGV4LnBocC9UQ1Bf
VGVzdGluZwogKgogKiBVbmxlc3MgQ1VCSUMgaXMgZW5hYmxlZCBhbmQgY29uZ2VzdGlvbiB3aW5k
b3cgaXMgbGFyZ2UKICogdGhpcyBiZWhhdmVzIHRoZSBzYW1lIGFzIHRoZSBvcmlnaW5hbCBSZW5v
LgogKi8KCiNpbmNsdWRlIDxsaW51eC9tbS5oPgojaW5jbHVkZSA8bGludXgvYnRmLmg+CiNpbmNs
dWRlIDxsaW51eC9idGZfaWRzLmg+CiNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KI2luY2x1ZGUg
PGxpbnV4L21hdGg2NC5oPgojaW5jbHVkZSA8bmV0L3RjcC5oPgoKI2RlZmluZSBCSUNUQ1BfQkVU
QV9TQ0FMRSAgICAxMDI0CS8qIFNjYWxlIGZhY3RvciBiZXRhIGNhbGN1bGF0aW9uCgkJCQkJICog
bWF4X2N3bmQgPSBzbmRfY3duZCAqIGJldGEKCQkJCQkgKi8KI2RlZmluZQlCSUNUQ1BfSFoJCTEw
CS8qIEJJQyBIWiAyXjEwID0gMTAyNCAqLwoKLyogVHdvIG1ldGhvZHMgb2YgaHlicmlkIHNsb3cg
c3RhcnQgKi8KI2RlZmluZSBIWVNUQVJUX0FDS19UUkFJTgkweDEKI2RlZmluZSBIWVNUQVJUX0RF
TEFZCQkweDIKCi8qIE51bWJlciBvZiBkZWxheSBzYW1wbGVzIGZvciBkZXRlY3RpbmcgdGhlIGlu
Y3JlYXNlIG9mIGRlbGF5ICovCiNkZWZpbmUgSFlTVEFSVF9NSU5fU0FNUExFUwk4CiNkZWZpbmUg
SFlTVEFSVF9ERUxBWV9NSU4JKDQwMDBVKQkvKiA0IG1zICovCiNkZWZpbmUgSFlTVEFSVF9ERUxB
WV9NQVgJKDE2MDAwVSkJLyogMTYgbXMgKi8KI2RlZmluZSBIWVNUQVJUX0RFTEFZX1RIUkVTSCh4
KQljbGFtcCh4LCBIWVNUQVJUX0RFTEFZX01JTiwgSFlTVEFSVF9ERUxBWV9NQVgpCgpzdGF0aWMg
aW50IGZhc3RfY29udmVyZ2VuY2UgX19yZWFkX21vc3RseSA9IDE7CnN0YXRpYyBpbnQgYmV0YSBf
X3JlYWRfbW9zdGx5ID0gNzE3OwkvKiA9IDcxNy8xMDI0IChCSUNUQ1BfQkVUQV9TQ0FMRSkgKi8K
c3RhdGljIGludCBpbml0aWFsX3NzdGhyZXNoIF9fcmVhZF9tb3N0bHk7CnN0YXRpYyBpbnQgYmlj
X3NjYWxlIF9fcmVhZF9tb3N0bHkgPSA0MTsKc3RhdGljIGludCB0Y3BfZnJpZW5kbGluZXNzIF9f
cmVhZF9tb3N0bHkgPSAxOwoKc3RhdGljIGludCBoeXN0YXJ0IF9fcmVhZF9tb3N0bHkgPSAxOwpz
dGF0aWMgaW50IGh5c3RhcnRfZGV0ZWN0IF9fcmVhZF9tb3N0bHkgPSBIWVNUQVJUX0FDS19UUkFJ
TiB8IEhZU1RBUlRfREVMQVk7CnN0YXRpYyBpbnQgaHlzdGFydF9sb3dfd2luZG93IF9fcmVhZF9t
b3N0bHkgPSAxNjsKc3RhdGljIGludCBoeXN0YXJ0X2Fja19kZWx0YV91cyBfX3JlYWRfbW9zdGx5
ID0gMjAwMDsKCnN0YXRpYyB1MzIgY3ViZV9ydHRfc2NhbGUgX19yZWFkX21vc3RseTsKc3RhdGlj
IHUzMiBiZXRhX3NjYWxlIF9fcmVhZF9tb3N0bHk7CnN0YXRpYyB1NjQgY3ViZV9mYWN0b3IgX19y
ZWFkX21vc3RseTsKCi8qIE5vdGUgcGFyYW1ldGVycyB0aGF0IGFyZSB1c2VkIGZvciBwcmVjb21w
dXRpbmcgc2NhbGUgZmFjdG9ycyBhcmUgcmVhZC1vbmx5ICovCm1vZHVsZV9wYXJhbShmYXN0X2Nv
bnZlcmdlbmNlLCBpbnQsIDA2NDQpOwpNT0RVTEVfUEFSTV9ERVNDKGZhc3RfY29udmVyZ2VuY2Us
ICJ0dXJuIG9uL29mZiBmYXN0IGNvbnZlcmdlbmNlIik7Cm1vZHVsZV9wYXJhbShiZXRhLCBpbnQs
IDA2NDQpOwpNT0RVTEVfUEFSTV9ERVNDKGJldGEsICJiZXRhIGZvciBtdWx0aXBsaWNhdGl2ZSBp
bmNyZWFzZSIpOwptb2R1bGVfcGFyYW0oaW5pdGlhbF9zc3RocmVzaCwgaW50LCAwNjQ0KTsKTU9E
VUxFX1BBUk1fREVTQyhpbml0aWFsX3NzdGhyZXNoLCAiaW5pdGlhbCB2YWx1ZSBvZiBzbG93IHN0
YXJ0IHRocmVzaG9sZCIpOwptb2R1bGVfcGFyYW0oYmljX3NjYWxlLCBpbnQsIDA0NDQpOwpNT0RV
TEVfUEFSTV9ERVNDKGJpY19zY2FsZSwgInNjYWxlIChzY2FsZWQgYnkgMTAyNCkgdmFsdWUgZm9y
IGJpYyBmdW5jdGlvbiAoYmljX3NjYWxlLzEwMjQpIik7Cm1vZHVsZV9wYXJhbSh0Y3BfZnJpZW5k
bGluZXNzLCBpbnQsIDA2NDQpOwpNT0RVTEVfUEFSTV9ERVNDKHRjcF9mcmllbmRsaW5lc3MsICJ0
dXJuIG9uL29mZiB0Y3AgZnJpZW5kbGluZXNzIik7Cm1vZHVsZV9wYXJhbShoeXN0YXJ0LCBpbnQs
IDA2NDQpOwpNT0RVTEVfUEFSTV9ERVNDKGh5c3RhcnQsICJ0dXJuIG9uL29mZiBoeWJyaWQgc2xv
dyBzdGFydCBhbGdvcml0aG0iKTsKbW9kdWxlX3BhcmFtKGh5c3RhcnRfZGV0ZWN0LCBpbnQsIDA2
NDQpOwpNT0RVTEVfUEFSTV9ERVNDKGh5c3RhcnRfZGV0ZWN0LCAiaHlicmlkIHNsb3cgc3RhcnQg
ZGV0ZWN0aW9uIG1lY2hhbmlzbXMiCgkJICIgMTogcGFja2V0LXRyYWluIDI6IGRlbGF5IDM6IGJv
dGggcGFja2V0LXRyYWluIGFuZCBkZWxheSIpOwptb2R1bGVfcGFyYW0oaHlzdGFydF9sb3dfd2lu
ZG93LCBpbnQsIDA2NDQpOwpNT0RVTEVfUEFSTV9ERVNDKGh5c3RhcnRfbG93X3dpbmRvdywgImxv
d2VyIGJvdW5kIGN3bmQgZm9yIGh5YnJpZCBzbG93IHN0YXJ0Iik7Cm1vZHVsZV9wYXJhbShoeXN0
YXJ0X2Fja19kZWx0YV91cywgaW50LCAwNjQ0KTsKTU9EVUxFX1BBUk1fREVTQyhoeXN0YXJ0X2Fj
a19kZWx0YV91cywgInNwYWNpbmcgYmV0d2VlbiBhY2sncyBpbmRpY2F0aW5nIHRyYWluICh1c2Vj
cykiKTsKCi8qIEJJQyBUQ1AgUGFyYW1ldGVycyAqLwpzdHJ1Y3QgYmljdGNwIHsKCXUzMgljbnQ7
CQkvKiBpbmNyZWFzZSBjd25kIGJ5IDEgYWZ0ZXIgQUNLcyAqLwoJdTMyCWxhc3RfbWF4X2N3bmQ7
CS8qIGxhc3QgbWF4aW11bSBzbmRfY3duZCAqLwoJdTMyCWxhc3RfY3duZDsJLyogdGhlIGxhc3Qg
c25kX2N3bmQgKi8KCXUzMglsYXN0X3RpbWU7CS8qIHRpbWUgd2hlbiB1cGRhdGVkIGxhc3RfY3du
ZCAqLwoJdTMyCWJpY19vcmlnaW5fcG9pbnQ7Lyogb3JpZ2luIHBvaW50IG9mIGJpYyBmdW5jdGlv
biAqLwoJdTMyCWJpY19LOwkJLyogdGltZSB0byBvcmlnaW4gcG9pbnQKCQkJCSAgIGZyb20gdGhl
IGJlZ2lubmluZyBvZiB0aGUgY3VycmVudCBlcG9jaCAqLwoJdTMyCWRlbGF5X21pbjsJLyogbWlu
IGRlbGF5ICh1c2VjKSAqLwoJdTMyCWVwb2NoX3N0YXJ0OwkvKiBiZWdpbm5pbmcgb2YgYW4gZXBv
Y2ggKi8KCXUzMglhY2tfY250OwkvKiBudW1iZXIgb2YgYWNrcyAqLwoJdTMyCXRjcF9jd25kOwkv
KiBlc3RpbWF0ZWQgdGNwIGN3bmQgKi8KCXUxNgl1bnVzZWQ7Cgl1OAlzYW1wbGVfY250OwkvKiBu
dW1iZXIgb2Ygc2FtcGxlcyB0byBkZWNpZGUgY3Vycl9ydHQgKi8KCXU4CWZvdW5kOwkJLyogdGhl
IGV4aXQgcG9pbnQgaXMgZm91bmQ/ICovCgl1MzIJcm91bmRfc3RhcnQ7CS8qIGJlZ2lubmluZyBv
ZiBlYWNoIHJvdW5kICovCgl1MzIJZW5kX3NlcTsJLyogZW5kX3NlcSBvZiB0aGUgcm91bmQgKi8K
CXUzMglsYXN0X2FjazsJLyogbGFzdCB0aW1lIHdoZW4gdGhlIEFDSyBzcGFjaW5nIGlzIGNsb3Nl
ICovCgl1MzIJY3Vycl9ydHQ7CS8qIHRoZSBtaW5pbXVtIHJ0dCBvZiBjdXJyZW50IHJvdW5kICov
Cn07CgpzdGF0aWMgaW5saW5lIHZvaWQgYmljdGNwX3Jlc2V0KHN0cnVjdCBiaWN0Y3AgKmNhKQp7
CgltZW1zZXQoY2EsIDAsIG9mZnNldG9mKHN0cnVjdCBiaWN0Y3AsIHVudXNlZCkpOwoJY2EtPmZv
dW5kID0gMDsKfQoKc3RhdGljIGlubGluZSB1MzIgYmljdGNwX2Nsb2NrX3VzKGNvbnN0IHN0cnVj
dCBzb2NrICpzaykKewoJcmV0dXJuIHRjcF9zayhzayktPnRjcF9tc3RhbXA7Cn0KCnN0YXRpYyBp
bmxpbmUgdm9pZCBiaWN0Y3BfaHlzdGFydF9yZXNldChzdHJ1Y3Qgc29jayAqc2spCnsKCXN0cnVj
dCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOwoJc3RydWN0IGJpY3RjcCAqY2EgPSBpbmV0X2Nz
a19jYShzayk7CgoJY2EtPnJvdW5kX3N0YXJ0ID0gY2EtPmxhc3RfYWNrID0gYmljdGNwX2Nsb2Nr
X3VzKHNrKTsKCgl0cC0+Y3ViaWNfcm91bmRfc3RhcnQgPSBjYS0+cm91bmRfc3RhcnQ7Cglwcmlu
dGsoS0VSTl9JTkZPICJOZXcgcm91bmQgaXMgc3RhcnRlZC4gdD0lbGx1IFNwb3J0PSV1IGN3bmQ9
JXUgaW5mbGlnaHQ9JXUgUlRUPSV1IiwKCSB0Y3Bfc2soc2spLT50Y3BfbXN0YW1wLCBpbmV0X3Nr
KHNrKS0+aW5ldF9zcG9ydCwgdHAtPnNuZF9jd25kLCB0Y3BfcGFja2V0c19pbl9mbGlnaHQodHAp
LCAodHAtPnNydHRfdXMgPj4gMykpOwoKCWNhLT5lbmRfc2VxID0gdHAtPnNuZF9ueHQ7CgljYS0+
Y3Vycl9ydHQgPSB+MFU7CgljYS0+c2FtcGxlX2NudCA9IDA7Cn0KCl9fYnBmX2tmdW5jIHN0YXRp
YyB2b2lkIGN1YmljdGNwX2luaXQoc3RydWN0IHNvY2sgKnNrKQp7CglzdHJ1Y3QgYmljdGNwICpj
YSA9IGluZXRfY3NrX2NhKHNrKTsKCgliaWN0Y3BfcmVzZXQoY2EpOwoKCWlmIChoeXN0YXJ0KQoJ
CWJpY3RjcF9oeXN0YXJ0X3Jlc2V0KHNrKTsKCglpZiAoIWh5c3RhcnQgJiYgaW5pdGlhbF9zc3Ro
cmVzaCkKCQl0Y3Bfc2soc2spLT5zbmRfc3N0aHJlc2ggPSBpbml0aWFsX3NzdGhyZXNoOwp9Cgpf
X2JwZl9rZnVuYyBzdGF0aWMgdm9pZCBjdWJpY3RjcF9jd25kX2V2ZW50KHN0cnVjdCBzb2NrICpz
aywgZW51bSB0Y3BfY2FfZXZlbnQgZXZlbnQpCnsKCWlmIChldmVudCA9PSBDQV9FVkVOVF9UWF9T
VEFSVCkgewoJCXN0cnVjdCBiaWN0Y3AgKmNhID0gaW5ldF9jc2tfY2Eoc2spOwoJCXUzMiBub3cg
PSB0Y3BfamlmZmllczMyOwoJCXMzMiBkZWx0YTsKCgkJZGVsdGEgPSBub3cgLSB0Y3Bfc2soc2sp
LT5sc25kdGltZTsKCgkJLyogV2Ugd2VyZSBhcHBsaWNhdGlvbiBsaW1pdGVkIChpZGxlKSBmb3Ig
YSB3aGlsZS4KCQkgKiBTaGlmdCBlcG9jaF9zdGFydCB0byBrZWVwIGN3bmQgZ3Jvd3RoIHRvIGN1
YmljIGN1cnZlLgoJCSAqLwoJCWlmIChjYS0+ZXBvY2hfc3RhcnQgJiYgZGVsdGEgPiAwKSB7CgkJ
CWNhLT5lcG9jaF9zdGFydCArPSBkZWx0YTsKCQkJaWYgKGFmdGVyKGNhLT5lcG9jaF9zdGFydCwg
bm93KSkKCQkJCWNhLT5lcG9jaF9zdGFydCA9IG5vdzsKCQl9CgkJcmV0dXJuOwoJfQp9CgovKiBj
YWxjdWxhdGUgdGhlIGN1YmljIHJvb3Qgb2YgeCB1c2luZyBhIHRhYmxlIGxvb2t1cCBmb2xsb3dl
ZCBieSBvbmUKICogTmV3dG9uLVJhcGhzb24gaXRlcmF0aW9uLgogKiBBdmcgZXJyIH49IDAuMTk1
JQogKi8Kc3RhdGljIHUzMiBjdWJpY19yb290KHU2NCBhKQp7Cgl1MzIgeCwgYiwgc2hpZnQ7Cgkv
KgoJICogY2JydCh4KSBNU0IgdmFsdWVzIGZvciB4IE1TQiB2YWx1ZXMgaW4gWzAuLjYzXS4KCSAq
IFByZWNvbXB1dGVkIHRoZW4gcmVmaW5lZCBieSBoYW5kIC0gV2lsbHkgVGFycmVhdQoJICoKCSAq
IEZvciB4IGluIFswLi42M10sCgkgKiAgIHYgPSBjYnJ0KHggPDwgMTgpIC0gMQoJICogICBjYnJ0
KHgpID0gKHZbeF0gKyAxMCkgPj4gNgoJICovCglzdGF0aWMgY29uc3QgdTggdltdID0gewoJCS8q
IDB4MDAgKi8gICAgMCwgICA1NCwgICA1NCwgICA1NCwgIDExOCwgIDExOCwgIDExOCwgIDExOCwK
CQkvKiAweDA4ICovICAxMjMsICAxMjksICAxMzQsICAxMzgsICAxNDMsICAxNDcsICAxNTEsICAx
NTYsCgkJLyogMHgxMCAqLyAgMTU3LCAgMTYxLCAgMTY0LCAgMTY4LCAgMTcwLCAgMTczLCAgMTc2
LCAgMTc5LAoJCS8qIDB4MTggKi8gIDE4MSwgIDE4NSwgIDE4NywgIDE5MCwgIDE5MiwgIDE5NCwg
IDE5NywgIDE5OSwKCQkvKiAweDIwICovICAyMDAsICAyMDIsICAyMDQsICAyMDYsICAyMDksICAy
MTEsICAyMTMsICAyMTUsCgkJLyogMHgyOCAqLyAgMjE3LCAgMjE5LCAgMjIxLCAgMjIyLCAgMjI0
LCAgMjI1LCAgMjI3LCAgMjI5LAoJCS8qIDB4MzAgKi8gIDIzMSwgIDIzMiwgIDIzNCwgIDIzNiwg
IDIzNywgIDIzOSwgIDI0MCwgIDI0MiwKCQkvKiAweDM4ICovICAyNDQsICAyNDUsICAyNDYsICAy
NDgsICAyNTAsICAyNTEsICAyNTIsICAyNTQsCgl9OwoKCWIgPSBmbHM2NChhKTsKCWlmIChiIDwg
NykgewoJCS8qIGEgaW4gWzAuLjYzXSAqLwoJCXJldHVybiAoKHUzMil2Wyh1MzIpYV0gKyAzNSkg
Pj4gNjsKCX0KCgliID0gKChiICogODQpID4+IDgpIC0gMTsKCXNoaWZ0ID0gKGEgPj4gKGIgKiAz
KSk7CgoJeCA9ICgodTMyKSgoKHUzMil2W3NoaWZ0XSArIDEwKSA8PCBiKSkgPj4gNjsKCgkvKgoJ
ICogTmV3dG9uLVJhcGhzb24gaXRlcmF0aW9uCgkgKiAgICAgICAgICAgICAgICAgICAgICAgICAy
CgkgKiB4ICAgID0gKCAyICogeCAgKyAgYSAvIHggICkgLyAzCgkgKiAgaysxICAgICAgICAgIGsg
ICAgICAgICBrCgkgKi8KCXggPSAoMiAqIHggKyAodTMyKWRpdjY0X3U2NChhLCAodTY0KXggKiAo
dTY0KSh4IC0gMSkpKTsKCXggPSAoKHggKiAzNDEpID4+IDEwKTsKCXJldHVybiB4Owp9CgovKgog
KiBDb21wdXRlIGNvbmdlc3Rpb24gd2luZG93IHRvIHVzZS4KICovCnN0YXRpYyBpbmxpbmUgdm9p
ZCBiaWN0Y3BfdXBkYXRlKHN0cnVjdCBiaWN0Y3AgKmNhLCB1MzIgY3duZCwgdTMyIGFja2VkKQp7
Cgl1MzIgZGVsdGEsIGJpY190YXJnZXQsIG1heF9jbnQ7Cgl1NjQgb2ZmcywgdDsKCgljYS0+YWNr
X2NudCArPSBhY2tlZDsJLyogY291bnQgdGhlIG51bWJlciBvZiBBQ0tlZCBwYWNrZXRzICovCgoJ
aWYgKGNhLT5sYXN0X2N3bmQgPT0gY3duZCAmJgoJICAgIChzMzIpKHRjcF9qaWZmaWVzMzIgLSBj
YS0+bGFzdF90aW1lKSA8PSBIWiAvIDMyKQoJCXJldHVybjsKCgkvKiBUaGUgQ1VCSUMgZnVuY3Rp
b24gY2FuIHVwZGF0ZSBjYS0+Y250IGF0IG1vc3Qgb25jZSBwZXIgamlmZnkuCgkgKiBPbiBhbGwg
Y3duZCByZWR1Y3Rpb24gZXZlbnRzLCBjYS0+ZXBvY2hfc3RhcnQgaXMgc2V0IHRvIDAsCgkgKiB3
aGljaCB3aWxsIGZvcmNlIGEgcmVjYWxjdWxhdGlvbiBvZiBjYS0+Y250LgoJICovCglpZiAoY2Et
PmVwb2NoX3N0YXJ0ICYmIHRjcF9qaWZmaWVzMzIgPT0gY2EtPmxhc3RfdGltZSkKCQlnb3RvIHRj
cF9mcmllbmRsaW5lc3M7CgoJY2EtPmxhc3RfY3duZCA9IGN3bmQ7CgljYS0+bGFzdF90aW1lID0g
dGNwX2ppZmZpZXMzMjsKCglpZiAoY2EtPmVwb2NoX3N0YXJ0ID09IDApIHsKCQljYS0+ZXBvY2hf
c3RhcnQgPSB0Y3BfamlmZmllczMyOwkvKiByZWNvcmQgYmVnaW5uaW5nICovCgkJY2EtPmFja19j
bnQgPSBhY2tlZDsJCQkvKiBzdGFydCBjb3VudGluZyAqLwoJCWNhLT50Y3BfY3duZCA9IGN3bmQ7
CQkJLyogc3luIHdpdGggY3ViaWMgKi8KCgkJaWYgKGNhLT5sYXN0X21heF9jd25kIDw9IGN3bmQp
IHsKCQkJY2EtPmJpY19LID0gMDsKCQkJY2EtPmJpY19vcmlnaW5fcG9pbnQgPSBjd25kOwoJCX0g
ZWxzZSB7CgkJCS8qIENvbXB1dGUgbmV3IEsgYmFzZWQgb24KCQkJICogKHdtYXgtY3duZCkgKiAo
c3J0dD4+MyAvIEhaKSAvIGMgKiAyXigzKmJpY3RjcF9IWikKCQkJICovCgkJCWNhLT5iaWNfSyA9
IGN1YmljX3Jvb3QoY3ViZV9mYWN0b3IKCQkJCQkgICAgICAgKiAoY2EtPmxhc3RfbWF4X2N3bmQg
LSBjd25kKSk7CgkJCWNhLT5iaWNfb3JpZ2luX3BvaW50ID0gY2EtPmxhc3RfbWF4X2N3bmQ7CgkJ
fQoJfQoKCS8qIGN1YmljIGZ1bmN0aW9uIC0gY2FsYyovCgkvKiBjYWxjdWxhdGUgYyAqIHRpbWVe
MyAvIHJ0dCwKCSAqICB3aGlsZSBjb25zaWRlcmluZyBvdmVyZmxvdyBpbiBjYWxjdWxhdGlvbiBv
ZiB0aW1lXjMKCSAqIChzbyB0aW1lXjMgaXMgZG9uZSBieSB1c2luZyA2NCBiaXQpCgkgKiBhbmQg
d2l0aG91dCB0aGUgc3VwcG9ydCBvZiBkaXZpc2lvbiBvZiA2NGJpdCBudW1iZXJzCgkgKiAoc28g
YWxsIGRpdmlzaW9ucyBhcmUgZG9uZSBieSB1c2luZyAzMiBiaXQpCgkgKiAgYWxzbyBOT1RFIHRo
ZSB1bml0IG9mIHRob3NlIHZlcmlhYmxlcwoJICoJICB0aW1lICA9ICh0IC0gSykgLyAyXmJpY3Rj
cF9IWgoJICoJICBjID0gYmljX3NjYWxlID4+IDEwCgkgKiBydHQgID0gKHNydHQgPj4gMykgLyBI
WgoJICogISEhIFRoZSBmb2xsb3dpbmcgY29kZSBkb2VzIG5vdCBoYXZlIG92ZXJmbG93IHByb2Js
ZW1zLAoJICogaWYgdGhlIGN3bmQgPCAxIG1pbGxpb24gcGFja2V0cyAhISEKCSAqLwoKCXQgPSAo
czMyKSh0Y3BfamlmZmllczMyIC0gY2EtPmVwb2NoX3N0YXJ0KTsKCXQgKz0gdXNlY3NfdG9famlm
ZmllcyhjYS0+ZGVsYXlfbWluKTsKCS8qIGNoYW5nZSB0aGUgdW5pdCBmcm9tIEhaIHRvIGJpY3Rj
cF9IWiAqLwoJdCA8PD0gQklDVENQX0haOwoJZG9fZGl2KHQsIEhaKTsKCglpZiAodCA8IGNhLT5i
aWNfSykJCS8qIHQgLSBLICovCgkJb2ZmcyA9IGNhLT5iaWNfSyAtIHQ7CgllbHNlCgkJb2ZmcyA9
IHQgLSBjYS0+YmljX0s7CgoJLyogYy9ydHQgKiAodC1LKV4zICovCglkZWx0YSA9IChjdWJlX3J0
dF9zY2FsZSAqIG9mZnMgKiBvZmZzICogb2ZmcykgPj4gKDEwKzMqQklDVENQX0haKTsKCWlmICh0
IDwgY2EtPmJpY19LKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBiZWxvdyBvcmlnaW4q
LwoJCWJpY190YXJnZXQgPSBjYS0+YmljX29yaWdpbl9wb2ludCAtIGRlbHRhOwoJZWxzZSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIGFib3ZlIG9yaWdpbiovCgkJ
YmljX3RhcmdldCA9IGNhLT5iaWNfb3JpZ2luX3BvaW50ICsgZGVsdGE7CgoJLyogY3ViaWMgZnVu
Y3Rpb24gLSBjYWxjIGJpY3RjcF9jbnQqLwoJaWYgKGJpY190YXJnZXQgPiBjd25kKSB7CgkJY2Et
PmNudCA9IGN3bmQgLyAoYmljX3RhcmdldCAtIGN3bmQpOwoJfSBlbHNlIHsKCQljYS0+Y250ID0g
MTAwICogY3duZDsgICAgICAgICAgICAgIC8qIHZlcnkgc21hbGwgaW5jcmVtZW50Ki8KCX0KCgkv
KgoJICogVGhlIGluaXRpYWwgZ3Jvd3RoIG9mIGN1YmljIGZ1bmN0aW9uIG1heSBiZSB0b28gY29u
c2VydmF0aXZlCgkgKiB3aGVuIHRoZSBhdmFpbGFibGUgYmFuZHdpZHRoIGlzIHN0aWxsIHVua25v
d24uCgkgKi8KCWlmIChjYS0+bGFzdF9tYXhfY3duZCA9PSAwICYmIGNhLT5jbnQgPiAyMCkKCQlj
YS0+Y250ID0gMjA7CS8qIGluY3JlYXNlIGN3bmQgNSUgcGVyIFJUVCAqLwoKdGNwX2ZyaWVuZGxp
bmVzczoKCS8qIFRDUCBGcmllbmRseSAqLwoJaWYgKHRjcF9mcmllbmRsaW5lc3MpIHsKCQl1MzIg
c2NhbGUgPSBiZXRhX3NjYWxlOwoKCQlkZWx0YSA9IChjd25kICogc2NhbGUpID4+IDM7CgkJd2hp
bGUgKGNhLT5hY2tfY250ID4gZGVsdGEpIHsJCS8qIHVwZGF0ZSB0Y3AgY3duZCAqLwoJCQljYS0+
YWNrX2NudCAtPSBkZWx0YTsKCQkJY2EtPnRjcF9jd25kKys7CgkJfQoKCQlpZiAoY2EtPnRjcF9j
d25kID4gY3duZCkgewkvKiBpZiBiaWMgaXMgc2xvd2VyIHRoYW4gdGNwICovCgkJCWRlbHRhID0g
Y2EtPnRjcF9jd25kIC0gY3duZDsKCQkJbWF4X2NudCA9IGN3bmQgLyBkZWx0YTsKCQkJaWYgKGNh
LT5jbnQgPiBtYXhfY250KQoJCQkJY2EtPmNudCA9IG1heF9jbnQ7CgkJfQoJfQoKCS8qIFRoZSBt
YXhpbXVtIHJhdGUgb2YgY3duZCBpbmNyZWFzZSBDVUJJQyBhbGxvd3MgaXMgMSBwYWNrZXQgcGVy
CgkgKiAyIHBhY2tldHMgQUNLZWQsIG1lYW5pbmcgY3duZCBncm93cyBhdCAxLjV4IHBlciBSVFQu
CgkgKi8KCWNhLT5jbnQgPSBtYXgoY2EtPmNudCwgMlUpOwp9CgpfX2JwZl9rZnVuYyBzdGF0aWMg
dm9pZCBjdWJpY3RjcF9jb25nX2F2b2lkKHN0cnVjdCBzb2NrICpzaywgdTMyIGFjaywgdTMyIGFj
a2VkKQp7CglzdHJ1Y3QgdGNwX3NvY2sgKnRwID0gdGNwX3NrKHNrKTsKCXN0cnVjdCBiaWN0Y3Ag
KmNhID0gaW5ldF9jc2tfY2Eoc2spOwoKCWlmICghdGNwX2lzX2N3bmRfbGltaXRlZChzaykpCgkJ
cmV0dXJuOwoKCWlmICh0Y3BfaW5fc2xvd19zdGFydCh0cCkpIHsKCQlhY2tlZCA9IHRjcF9zbG93
X3N0YXJ0KHRwLCBhY2tlZCk7CgkJaWYgKCFhY2tlZCkKCQkJcmV0dXJuOwoJfQoJYmljdGNwX3Vw
ZGF0ZShjYSwgdGNwX3NuZF9jd25kKHRwKSwgYWNrZWQpOwoJdGNwX2NvbmdfYXZvaWRfYWkodHAs
IGNhLT5jbnQsIGFja2VkKTsKfQoKX19icGZfa2Z1bmMgc3RhdGljIHUzMiBjdWJpY3RjcF9yZWNh
bGNfc3N0aHJlc2goc3RydWN0IHNvY2sgKnNrKQp7Cgljb25zdCBzdHJ1Y3QgdGNwX3NvY2sgKnRw
ID0gdGNwX3NrKHNrKTsKCXN0cnVjdCBiaWN0Y3AgKmNhID0gaW5ldF9jc2tfY2Eoc2spOwoKCWNh
LT5lcG9jaF9zdGFydCA9IDA7CS8qIGVuZCBvZiBlcG9jaCAqLwoKCS8qIFdtYXggYW5kIGZhc3Qg
Y29udmVyZ2VuY2UgKi8KCWlmICh0Y3Bfc25kX2N3bmQodHApIDwgY2EtPmxhc3RfbWF4X2N3bmQg
JiYgZmFzdF9jb252ZXJnZW5jZSkKCQljYS0+bGFzdF9tYXhfY3duZCA9ICh0Y3Bfc25kX2N3bmQo
dHApICogKEJJQ1RDUF9CRVRBX1NDQUxFICsgYmV0YSkpCgkJCS8gKDIgKiBCSUNUQ1BfQkVUQV9T
Q0FMRSk7CgllbHNlCgkJY2EtPmxhc3RfbWF4X2N3bmQgPSB0Y3Bfc25kX2N3bmQodHApOwoKCXJl
dHVybiBtYXgoKHRjcF9zbmRfY3duZCh0cCkgKiBiZXRhKSAvIEJJQ1RDUF9CRVRBX1NDQUxFLCAy
VSk7Cn0KCl9fYnBmX2tmdW5jIHN0YXRpYyB2b2lkIGN1YmljdGNwX3N0YXRlKHN0cnVjdCBzb2Nr
ICpzaywgdTggbmV3X3N0YXRlKQp7CglpZiAobmV3X3N0YXRlID09IFRDUF9DQV9Mb3NzKSB7CgkJ
YmljdGNwX3Jlc2V0KGluZXRfY3NrX2NhKHNrKSk7CgkJYmljdGNwX2h5c3RhcnRfcmVzZXQoc2sp
OwoJfQp9CgovKiBBY2NvdW50IGZvciBUU08vR1JPIGRlbGF5cy4KICogT3RoZXJ3aXNlIHNob3J0
IFJUVCBmbG93cyBjb3VsZCBnZXQgdG9vIHNtYWxsIHNzdGhyZXNoLCBzaW5jZSBkdXJpbmcKICog
c2xvdyBzdGFydCB3ZSBiZWdpbiB3aXRoIHNtYWxsIFRTTyBwYWNrZXRzIGFuZCBjYS0+ZGVsYXlf
bWluIHdvdWxkCiAqIG5vdCBhY2NvdW50IGZvciBsb25nIGFnZ3JlZ2F0aW9uIGRlbGF5IHdoZW4g
VFNPIHBhY2tldHMgZ2V0IGJpZ2dlci4KICogSWRlYWxseSBldmVuIHdpdGggYSB2ZXJ5IHNtYWxs
IFJUVCB3ZSB3b3VsZCBsaWtlIHRvIGhhdmUgYXQgbGVhc3Qgb25lCiAqIFRTTyBwYWNrZXQgYmVp
bmcgc2VudCBhbmQgcmVjZWl2ZWQgYnkgR1JPLCBhbmQgYW5vdGhlciBvbmUgaW4gcWRpc2MgbGF5
ZXIuCiAqIFdlIGFwcGx5IGFub3RoZXIgMTAwJSBmYWN0b3IgYmVjYXVzZSBAcmF0ZSBpcyBkb3Vi
bGVkIGF0IHRoaXMgcG9pbnQuCiAqIFdlIGNhcCB0aGUgY3VzaGlvbiB0byAxbXMuCiAqLwpzdGF0
aWMgdTMyIGh5c3RhcnRfYWNrX2RlbGF5KGNvbnN0IHN0cnVjdCBzb2NrICpzaykKewoJdW5zaWdu
ZWQgbG9uZyByYXRlOwoKCXJhdGUgPSBSRUFEX09OQ0Uoc2stPnNrX3BhY2luZ19yYXRlKTsKCWlm
ICghcmF0ZSkKCQlyZXR1cm4gMDsKCXJldHVybiBtaW5fdCh1NjQsIFVTRUNfUEVSX01TRUMsCgkJ
ICAgICBkaXY2NF91bCgodTY0KXNrLT5za19nc29fbWF4X3NpemUgKiA0ICogVVNFQ19QRVJfU0VD
LCByYXRlKSk7Cn0KCnN0YXRpYyB2b2lkIGh5c3RhcnRfdXBkYXRlKHN0cnVjdCBzb2NrICpzaywg
dTMyIGRlbGF5KQp7CglzdHJ1Y3QgdGNwX3NvY2sgKnRwID0gdGNwX3NrKHNrKTsKCXN0cnVjdCBi
aWN0Y3AgKmNhID0gaW5ldF9jc2tfY2Eoc2spOwoJdTMyIHRocmVzaG9sZDsKCglpZiAoYWZ0ZXIo
dHAtPnNuZF91bmEsIGNhLT5lbmRfc2VxKSkKCQliaWN0Y3BfaHlzdGFydF9yZXNldChzayk7CgoJ
aWYgKGh5c3RhcnRfZGV0ZWN0ICYgSFlTVEFSVF9BQ0tfVFJBSU4pIHsKCQl1MzIgbm93ID0gYmlj
dGNwX2Nsb2NrX3VzKHNrKTsKCgkJLyogZmlyc3QgZGV0ZWN0aW9uIHBhcmFtZXRlciAtIGFjay10
cmFpbiBkZXRlY3Rpb24gKi8KCQlpZiAoKHMzMikobm93IC0gY2EtPmxhc3RfYWNrKSA8PSBoeXN0
YXJ0X2Fja19kZWx0YV91cykgewoJCQljYS0+bGFzdF9hY2sgPSBub3c7CgoJCQl0aHJlc2hvbGQg
PSBjYS0+ZGVsYXlfbWluICsgaHlzdGFydF9hY2tfZGVsYXkoc2spOwoKCQkJLyogSHlzdGFydCBh
Y2sgdHJhaW4gdHJpZ2dlcnMgaWYgd2UgZ2V0IGFjayBwYXN0CgkJCSAqIGNhLT5kZWxheV9taW4v
Mi4KCQkJICogUGFjaW5nIG1pZ2h0IGhhdmUgZGVsYXllZCBwYWNrZXRzIHVwIHRvIFJUVC8yCgkJ
CSAqIGR1cmluZyBzbG93IHN0YXJ0LgoJCQkgKi8KCQkJaWYgKHNrLT5za19wYWNpbmdfc3RhdHVz
ID09IFNLX1BBQ0lOR19OT05FKQoJCQkJdGhyZXNob2xkID4+PSAxOwoKCQkJaWYgKChzMzIpKG5v
dyAtIGNhLT5yb3VuZF9zdGFydCkgPiB0aHJlc2hvbGQpIHsKCQkJCWNhLT5mb3VuZCA9IDE7CgkJ
CQlwcl9kZWJ1ZygiaHlzdGFydF9hY2tfdHJhaW4gKCV1ID4gJXUpIGRlbGF5X21pbiAldSAoKyBh
Y2tfZGVsYXkgJXUpIGN3bmQgJXVcbiIsCgkJCQkJIG5vdyAtIGNhLT5yb3VuZF9zdGFydCwgdGhy
ZXNob2xkLAoJCQkJCSBjYS0+ZGVsYXlfbWluLCBoeXN0YXJ0X2Fja19kZWxheShzayksIHRjcF9z
bmRfY3duZCh0cCkpOwoJCQkJTkVUX0lOQ19TVEFUUyhzb2NrX25ldChzayksCgkJCQkJICAgICAg
TElOVVhfTUlCX1RDUEhZU1RBUlRUUkFJTkRFVEVDVCk7CgkJCQlORVRfQUREX1NUQVRTKHNvY2tf
bmV0KHNrKSwKCQkJCQkgICAgICBMSU5VWF9NSUJfVENQSFlTVEFSVFRSQUlOQ1dORCwKCQkJCQkg
ICAgICB0Y3Bfc25kX2N3bmQodHApKTsKCQkJCXRwLT5zbmRfc3N0aHJlc2ggPSB0Y3Bfc25kX2N3
bmQodHApOwoJCQl9CgkJfQoJfQoKCWlmIChoeXN0YXJ0X2RldGVjdCAmIEhZU1RBUlRfREVMQVkp
IHsKCQkvKiBvYnRhaW4gdGhlIG1pbmltdW0gZGVsYXkgb2YgbW9yZSB0aGFuIHNhbXBsaW5nIHBh
Y2tldHMgKi8KCQlpZiAoY2EtPmN1cnJfcnR0ID4gZGVsYXkpCgkJCWNhLT5jdXJyX3J0dCA9IGRl
bGF5OwoJCWlmIChjYS0+c2FtcGxlX2NudCA8IEhZU1RBUlRfTUlOX1NBTVBMRVMpIHsKCQkJY2Et
PnNhbXBsZV9jbnQrKzsKCQl9IGVsc2UgewoJCQlpZiAoY2EtPmN1cnJfcnR0ID4gY2EtPmRlbGF5
X21pbiArCgkJCSAgICBIWVNUQVJUX0RFTEFZX1RIUkVTSChjYS0+ZGVsYXlfbWluID4+IDMpKSB7
CgkJCQljYS0+Zm91bmQgPSAxOwoJCQkJTkVUX0lOQ19TVEFUUyhzb2NrX25ldChzayksCgkJCQkJ
ICAgICAgTElOVVhfTUlCX1RDUEhZU1RBUlRERUxBWURFVEVDVCk7CgkJCQlORVRfQUREX1NUQVRT
KHNvY2tfbmV0KHNrKSwKCQkJCQkgICAgICBMSU5VWF9NSUJfVENQSFlTVEFSVERFTEFZQ1dORCwK
CQkJCQkgICAgICB0Y3Bfc25kX2N3bmQodHApKTsKCQkJCXRwLT5zbmRfc3N0aHJlc2ggPSB0Y3Bf
c25kX2N3bmQodHApOwoJCQl9CgkJfQoJfQp9CgpfX2JwZl9rZnVuYyBzdGF0aWMgdm9pZCBjdWJp
Y3RjcF9hY2tlZChzdHJ1Y3Qgc29jayAqc2ssIGNvbnN0IHN0cnVjdCBhY2tfc2FtcGxlICpzYW1w
bGUpCnsKCWNvbnN0IHN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOwoJc3RydWN0IGJp
Y3RjcCAqY2EgPSBpbmV0X2Nza19jYShzayk7Cgl1MzIgZGVsYXk7CgoJLyogU29tZSBjYWxscyBh
cmUgZm9yIGR1cGxpY2F0ZXMgd2l0aG91dCB0aW1ldGFtcHMgKi8KCWlmIChzYW1wbGUtPnJ0dF91
cyA8IDApCgkJcmV0dXJuOwoKCS8qIERpc2NhcmQgZGVsYXkgc2FtcGxlcyByaWdodCBhZnRlciBm
YXN0IHJlY292ZXJ5ICovCglpZiAoY2EtPmVwb2NoX3N0YXJ0ICYmIChzMzIpKHRjcF9qaWZmaWVz
MzIgLSBjYS0+ZXBvY2hfc3RhcnQpIDwgSFopCgkJcmV0dXJuOwoKCWRlbGF5ID0gc2FtcGxlLT5y
dHRfdXM7CglpZiAoZGVsYXkgPT0gMCkKCQlkZWxheSA9IDE7CgoJLyogZmlyc3QgdGltZSBjYWxs
IG9yIGxpbmsgZGVsYXkgZGVjcmVhc2VzICovCglpZiAoY2EtPmRlbGF5X21pbiA9PSAwIHx8IGNh
LT5kZWxheV9taW4gPiBkZWxheSkKCQljYS0+ZGVsYXlfbWluID0gZGVsYXk7CgoJcHJpbnRrKEtF
Uk5fSU5GTyAiQWNrIHJlY2VpdmluZy4gdD0lbGx1IFNwb3J0PSV1IGN3bmQ9JXUgaW5mbGlnaHQ9
JXUgUlRUPSV1IGFja2VkPSV1IiwKCSB0Y3Bfc2soc2spLT50Y3BfbXN0YW1wLCBpbmV0X3NrKHNr
KS0+aW5ldF9zcG9ydCwgdHAtPnNuZF9jd25kLCB0Y3BfcGFja2V0c19pbl9mbGlnaHQodHApLCAo
dHAtPnNydHRfdXMgPj4gMyksIHNhbXBsZS0+cGt0c19hY2tlZCk7CgoJLyogaHlzdGFydCB0cmln
Z2VycyB3aGVuIGN3bmQgaXMgbGFyZ2VyIHRoYW4gc29tZSB0aHJlc2hvbGQgKi8KCWlmICghY2Et
PmZvdW5kICYmIHRjcF9pbl9zbG93X3N0YXJ0KHRwKSAmJiBoeXN0YXJ0ICYmCgkgICAgdGNwX3Nu
ZF9jd25kKHRwKSA+PSBoeXN0YXJ0X2xvd193aW5kb3cpCgkJaHlzdGFydF91cGRhdGUoc2ssIGRl
bGF5KTsKfQoKc3RhdGljIHN0cnVjdCB0Y3BfY29uZ2VzdGlvbl9vcHMgY3ViaWN0Y3AgX19yZWFk
X21vc3RseSA9IHsKCS5pbml0CQk9IGN1YmljdGNwX2luaXQsCgkuc3N0aHJlc2gJPSBjdWJpY3Rj
cF9yZWNhbGNfc3N0aHJlc2gsCgkuY29uZ19hdm9pZAk9IGN1YmljdGNwX2NvbmdfYXZvaWQsCgku
c2V0X3N0YXRlCT0gY3ViaWN0Y3Bfc3RhdGUsCgkudW5kb19jd25kCT0gdGNwX3Jlbm9fdW5kb19j
d25kLAoJLmN3bmRfZXZlbnQJPSBjdWJpY3RjcF9jd25kX2V2ZW50LAoJLnBrdHNfYWNrZWQgICAg
ID0gY3ViaWN0Y3BfYWNrZWQsCgkub3duZXIJCT0gVEhJU19NT0RVTEUsCgkubmFtZQkJPSAiY3Vi
aWMiLAp9OwoKQlRGX1NFVDhfU1RBUlQodGNwX2N1YmljX2NoZWNrX2tmdW5jX2lkcykKI2lmZGVm
IENPTkZJR19YODYKI2lmZGVmIENPTkZJR19EWU5BTUlDX0ZUUkFDRQpCVEZfSURfRkxBR1MoZnVu
YywgY3ViaWN0Y3BfaW5pdCkKQlRGX0lEX0ZMQUdTKGZ1bmMsIGN1YmljdGNwX3JlY2FsY19zc3Ro
cmVzaCkKQlRGX0lEX0ZMQUdTKGZ1bmMsIGN1YmljdGNwX2NvbmdfYXZvaWQpCkJURl9JRF9GTEFH
UyhmdW5jLCBjdWJpY3RjcF9zdGF0ZSkKQlRGX0lEX0ZMQUdTKGZ1bmMsIGN1YmljdGNwX2N3bmRf
ZXZlbnQpCkJURl9JRF9GTEFHUyhmdW5jLCBjdWJpY3RjcF9hY2tlZCkKI2VuZGlmCiNlbmRpZgpC
VEZfU0VUOF9FTkQodGNwX2N1YmljX2NoZWNrX2tmdW5jX2lkcykKCnN0YXRpYyBjb25zdCBzdHJ1
Y3QgYnRmX2tmdW5jX2lkX3NldCB0Y3BfY3ViaWNfa2Z1bmNfc2V0ID0gewoJLm93bmVyID0gVEhJ
U19NT0RVTEUsCgkuc2V0ICAgPSAmdGNwX2N1YmljX2NoZWNrX2tmdW5jX2lkcywKfTsKCnN0YXRp
YyBpbnQgX19pbml0IGN1YmljdGNwX3JlZ2lzdGVyKHZvaWQpCnsKCWludCByZXQ7CgoJQlVJTERf
QlVHX09OKHNpemVvZihzdHJ1Y3QgYmljdGNwKSA+IElDU0tfQ0FfUFJJVl9TSVpFKTsKCgkvKiBQ
cmVjb21wdXRlIGEgYnVuY2ggb2YgdGhlIHNjYWxpbmcgZmFjdG9ycyB0aGF0IGFyZSB1c2VkIHBl
ci1wYWNrZXQKCSAqIGJhc2VkIG9uIFNSVFQgb2YgMTAwbXMKCSAqLwoKCWJldGFfc2NhbGUgPSA4
KihCSUNUQ1BfQkVUQV9TQ0FMRStiZXRhKSAvIDMKCQkvIChCSUNUQ1BfQkVUQV9TQ0FMRSAtIGJl
dGEpOwoKCWN1YmVfcnR0X3NjYWxlID0gKGJpY19zY2FsZSAqIDEwKTsJLyogMTAyNCpjL3J0dCAq
LwoKCS8qIGNhbGN1bGF0ZSB0aGUgIksiIGZvciAod21heC1jd25kKSA9IGMvcnR0ICogS14zCgkg
KiAgc28gSyA9IGN1YmljX3Jvb3QoICh3bWF4LWN3bmQpKnJ0dC9jICkKCSAqIHRoZSB1bml0IG9m
IEsgaXMgYmljdGNwX0haPTJeMTAsIG5vdCBIWgoJICoKCSAqICBjID0gYmljX3NjYWxlID4+IDEw
CgkgKiAgcnR0ID0gMTAwbXMKCSAqCgkgKiB0aGUgZm9sbG93aW5nIGNvZGUgaGFzIGJlZW4gZGVz
aWduZWQgYW5kIHRlc3RlZCBmb3IKCSAqIGN3bmQgPCAxIG1pbGxpb24gcGFja2V0cwoJICogUlRU
IDwgMTAwIHNlY29uZHMKCSAqIEhaIDwgMSwwMDAsMDAgIChjb3JyZXNwb25kaW5nIHRvIDEwIG5h
bm8tc2Vjb25kKQoJICovCgoJLyogMS9jICogMl4yKmJpY3RjcF9IWiAqIHNydHQgKi8KCWN1YmVf
ZmFjdG9yID0gMXVsbCA8PCAoMTArMypCSUNUQ1BfSFopOyAvKiAyXjQwICovCgoJLyogZGl2aWRl
IGJ5IGJpY19zY2FsZSBhbmQgYnkgY29uc3RhbnQgU3J0dCAoMTAwbXMpICovCglkb19kaXYoY3Vi
ZV9mYWN0b3IsIGJpY19zY2FsZSAqIDEwKTsKCglyZXQgPSByZWdpc3Rlcl9idGZfa2Z1bmNfaWRf
c2V0KEJQRl9QUk9HX1RZUEVfU1RSVUNUX09QUywgJnRjcF9jdWJpY19rZnVuY19zZXQpOwoJaWYg
KHJldCA8IDApCgkJcmV0dXJuIHJldDsKCXJldHVybiB0Y3BfcmVnaXN0ZXJfY29uZ2VzdGlvbl9j
b250cm9sKCZjdWJpY3RjcCk7Cn0KCnN0YXRpYyB2b2lkIF9fZXhpdCBjdWJpY3RjcF91bnJlZ2lz
dGVyKHZvaWQpCnsKCXRjcF91bnJlZ2lzdGVyX2Nvbmdlc3Rpb25fY29udHJvbCgmY3ViaWN0Y3Ap
Owp9Cgptb2R1bGVfaW5pdChjdWJpY3RjcF9yZWdpc3Rlcik7Cm1vZHVsZV9leGl0KGN1YmljdGNw
X3VucmVnaXN0ZXIpOwoKTU9EVUxFX0FVVEhPUigiU2FuZ3RhZSBIYSwgU3RlcGhlbiBIZW1taW5n
ZXIiKTsKTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOwpNT0RVTEVfREVTQ1JJUFRJT04oIkNVQklDIFRD
UCIpOwpNT0RVTEVfVkVSU0lPTigiMi4zIik7Cg==

------=_Part_4484033_245042213.1736328888690
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="tcp_output.c"
Content-ID: <0ab9050c-b5d0-42df-eaaf-01d747d560d7@yahoo.com>

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQovKgogKiBJTkVUCQlBbiBp
bXBsZW1lbnRhdGlvbiBvZiB0aGUgVENQL0lQIHByb3RvY29sIHN1aXRlIGZvciB0aGUgTElOVVgK
ICoJCW9wZXJhdGluZyBzeXN0ZW0uICBJTkVUIGlzIGltcGxlbWVudGVkIHVzaW5nIHRoZSAgQlNE
IFNvY2tldAogKgkJaW50ZXJmYWNlIGFzIHRoZSBtZWFucyBvZiBjb21tdW5pY2F0aW9uIHdpdGgg
dGhlIHVzZXIgbGV2ZWwuCiAqCiAqCQlJbXBsZW1lbnRhdGlvbiBvZiB0aGUgVHJhbnNtaXNzaW9u
IENvbnRyb2wgUHJvdG9jb2woVENQKS4KICoKICogQXV0aG9yczoJUm9zcyBCaXJvCiAqCQlGcmVk
IE4uIHZhbiBLZW1wZW4sIDx3YWx0amVAdVdhbHQuTkwuTXVnbmV0Lk9SRz4KICoJCU1hcmsgRXZh
bnMsIDxldmFuc21wQHVodXJhLmFzdG9uLmFjLnVrPgogKgkJQ29yZXkgTWlueWFyZCA8d2YtcmNo
IW1pbnlhcmRAcmVsYXkuRVUubmV0PgogKgkJRmxvcmlhbiBMYSBSb2NoZSwgPGZsbGFAc3R1ZC51
bmktc2IuZGU+CiAqCQlDaGFybGVzIEhlZHJpY2ssIDxoZWRyaWNrQGtsaW56aGFpLnJ1dGdlcnMu
ZWR1PgogKgkJTGludXMgVG9ydmFsZHMsIDx0b3J2YWxkc0Bjcy5oZWxzaW5raS5maT4KICoJCUFs
YW4gQ294LCA8Z3c0cHRzQGd3NHB0cy5hbXByLm9yZz4KICoJCU1hdHRoZXcgRGlsbG9uLCA8ZGls
bG9uQGFwb2xsby53ZXN0Lm9pYy5jb20+CiAqCQlBcm50IEd1bGJyYW5kc2VuLCA8YWd1bGJyYUBu
dmcudW5pdC5ubz4KICoJCUpvcmdlIEN3aWssIDxqb3JnZUBsYXNlci5zYXRsaW5rLm5ldD4KICov
CgovKgogKiBDaGFuZ2VzOglQZWRybyBSb3F1ZQk6CVJldHJhbnNtaXQgcXVldWUgaGFuZGxlZCBi
eSBUQ1AuCiAqCQkJCToJRnJhZ21lbnRhdGlvbiBvbiBtdHUgZGVjcmVhc2UKICoJCQkJOglTZWdt
ZW50IGNvbGxhcHNlIG9uIHJldHJhbnNtaXQKICoJCQkJOglBRiBpbmRlcGVuZGVuY2UKICoKICoJ
CUxpbnVzIFRvcnZhbGRzCToJc2VuZF9kZWxheWVkX2FjawogKgkJRGF2aWQgUy4gTWlsbGVyCToJ
Q2hhcmdlIG1lbW9yeSB1c2luZyB0aGUgcmlnaHQgc2tiCiAqCQkJCQlkdXJpbmcgc3luL2FjayBw
cm9jZXNzaW5nLgogKgkJRGF2aWQgUy4gTWlsbGVyIDoJT3V0cHV0IGVuZ2luZSBjb21wbGV0ZWx5
IHJld3JpdHRlbi4KICoJCUFuZHJlYSBBcmNhbmdlbGk6CVNZTkFDSyBjYXJyeSB0c19yZWNlbnQg
aW4gdHNlY3IuCiAqCQlDYWNvcGhvbml4IEdhdWwgOglkcmFmdC1taW5zaGFsbC1uYWdsZS0wMQog
KgkJSiBIYWRpIFNhbGltCToJRUNOIHN1cHBvcnQKICoKICovCgojZGVmaW5lIHByX2ZtdChmbXQp
ICJUQ1A6ICIgZm10CgojaW5jbHVkZSA8bmV0L3RjcC5oPgojaW5jbHVkZSA8bmV0L21wdGNwLmg+
CgojaW5jbHVkZSA8bGludXgvY29tcGlsZXIuaD4KI2luY2x1ZGUgPGxpbnV4L2dmcC5oPgojaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+CiNpbmNsdWRlIDxsaW51eC9zdGF0aWNfa2V5Lmg+CgojaW5j
bHVkZSA8dHJhY2UvZXZlbnRzL3RjcC5oPgoKLyogUmVmcmVzaCBjbG9ja3Mgb2YgYSBUQ1Agc29j
a2V0LAogKiBlbnN1cmluZyBtb25vdGljYWxseSBpbmNyZWFzaW5nIHZhbHVlcy4KICovCnZvaWQg
dGNwX21zdGFtcF9yZWZyZXNoKHN0cnVjdCB0Y3Bfc29jayAqdHApCnsKCXU2NCB2YWwgPSB0Y3Bf
Y2xvY2tfbnMoKTsKCgl0cC0+dGNwX2Nsb2NrX2NhY2hlID0gdmFsOwoJdHAtPnRjcF9tc3RhbXAg
PSBkaXZfdTY0KHZhbCwgTlNFQ19QRVJfVVNFQyk7Cn0KCnN0YXRpYyBib29sIHRjcF93cml0ZV94
bWl0KHN0cnVjdCBzb2NrICpzaywgdW5zaWduZWQgaW50IG1zc19ub3csIGludCBub25hZ2xlLAoJ
CQkgICBpbnQgcHVzaF9vbmUsIGdmcF90IGdmcCk7CgovKiBBY2NvdW50IGZvciBuZXcgZGF0YSB0
aGF0IGhhcyBiZWVuIHNlbnQgdG8gdGhlIG5ldHdvcmsuICovCnN0YXRpYyB2b2lkIHRjcF9ldmVu
dF9uZXdfZGF0YV9zZW50KHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYgKnNrYikKewoJ
c3RydWN0IGluZXRfY29ubmVjdGlvbl9zb2NrICppY3NrID0gaW5ldF9jc2soc2spOwoJc3RydWN0
IHRjcF9zb2NrICp0cCA9IHRjcF9zayhzayk7Cgl1bnNpZ25lZCBpbnQgcHJpb3JfcGFja2V0cyA9
IHRwLT5wYWNrZXRzX291dDsKCglXUklURV9PTkNFKHRwLT5zbmRfbnh0LCBUQ1BfU0tCX0NCKHNr
YiktPmVuZF9zZXEpOwoKCV9fc2tiX3VubGluayhza2IsICZzay0+c2tfd3JpdGVfcXVldWUpOwoJ
dGNwX3JidHJlZV9pbnNlcnQoJnNrLT50Y3BfcnR4X3F1ZXVlLCBza2IpOwoKCWlmICh0cC0+aGln
aGVzdF9zYWNrID09IE5VTEwpCgkJdHAtPmhpZ2hlc3Rfc2FjayA9IHNrYjsKCgl0cC0+cGFja2V0
c19vdXQgKz0gdGNwX3NrYl9wY291bnQoc2tiKTsKCWlmICghcHJpb3JfcGFja2V0cyB8fCBpY3Nr
LT5pY3NrX3BlbmRpbmcgPT0gSUNTS19USU1FX0xPU1NfUFJPQkUpCgkJdGNwX3JlYXJtX3J0byhz
ayk7CgoJTkVUX0FERF9TVEFUUyhzb2NrX25ldChzayksIExJTlVYX01JQl9UQ1BPUklHREFUQVNF
TlQsCgkJICAgICAgdGNwX3NrYl9wY291bnQoc2tiKSk7Cgl0Y3BfY2hlY2tfc3BhY2Uoc2spOwp9
CgovKiBTTkQuTlhULCBpZiB3aW5kb3cgd2FzIG5vdCBzaHJ1bmsgb3IgdGhlIGFtb3VudCBvZiBz
aHJ1bmsgd2FzIGxlc3MgdGhhbiBvbmUKICogd2luZG93IHNjYWxpbmcgZmFjdG9yIGR1ZSB0byBs
b3NzIG9mIHByZWNpc2lvbi4KICogSWYgd2luZG93IGhhcyBiZWVuIHNocnVuaywgd2hhdCBzaG91
bGQgd2UgbWFrZT8gSXQgaXMgbm90IGNsZWFyIGF0IGFsbC4KICogVXNpbmcgU05ELlVOQSB3ZSB3
aWxsIGZhaWwgdG8gb3BlbiB3aW5kb3csIFNORC5OWFQgaXMgb3V0IG9mIHdpbmRvdy4gOi0oCiAq
IEFueXRoaW5nIGluIGJldHdlZW4gU05ELlVOQS4uLlNORC5VTkErU05ELldORCBhbHNvIGNhbiBi
ZSBhbHJlYWR5CiAqIGludmFsaWQuIE9LLCBsZXQncyBtYWtlIHRoaXMgZm9yIG5vdzoKICovCnN0
YXRpYyBpbmxpbmUgX191MzIgdGNwX2FjY2VwdGFibGVfc2VxKGNvbnN0IHN0cnVjdCBzb2NrICpz
aykKewoJY29uc3Qgc3RydWN0IHRjcF9zb2NrICp0cCA9IHRjcF9zayhzayk7CgoJaWYgKCFiZWZv
cmUodGNwX3duZF9lbmQodHApLCB0cC0+c25kX254dCkgfHwKCSAgICAodHAtPnJ4X29wdC53c2Nh
bGVfb2sgJiYKCSAgICAgKCh0cC0+c25kX254dCAtIHRjcF93bmRfZW5kKHRwKSkgPCAoMSA8PCB0
cC0+cnhfb3B0LnJjdl93c2NhbGUpKSkpCgkJcmV0dXJuIHRwLT5zbmRfbnh0OwoJZWxzZQoJCXJl
dHVybiB0Y3Bfd25kX2VuZCh0cCk7Cn0KCi8qIENhbGN1bGF0ZSBtc3MgdG8gYWR2ZXJ0aXNlIGlu
IFNZTiBzZWdtZW50LgogKiBSRkMxMTIyLCBSRkMxMDYzLCBkcmFmdC1pZXRmLXRjcGltcGwtcG10
dWQtMDEgc3RhdGUgdGhhdDoKICoKICogMS4gSXQgaXMgaW5kZXBlbmRlbnQgb2YgcGF0aCBtdHUu
CiAqIDIuIElkZWFsbHksIGl0IGlzIG1heGltYWwgcG9zc2libGUgc2VnbWVudCBzaXplIGkuZS4g
NjU1MzUtNDAuCiAqIDMuIEZvciBJUHY0IGl0IGlzIHJlYXNvbmFibGUgdG8gY2FsY3VsYXRlIGl0
IGZyb20gbWF4aW1hbCBNVFUgb2YKICogICAgYXR0YWNoZWQgZGV2aWNlcywgYmVjYXVzZSBzb21l
IGJ1Z2d5IGhvc3RzIGFyZSBjb25mdXNlZCBieQogKiAgICBsYXJnZSBNU1MuCiAqIDQuIFdlIGRv
IG5vdCBtYWtlIDMsIHdlIGFkdmVydGlzZSBNU1MsIGNhbGN1bGF0ZWQgZnJvbSBmaXJzdAogKiAg
ICBob3AgZGV2aWNlIG10dSwgYnV0IGFsbG93IHRvIHJhaXNlIGl0IHRvIGlwX3J0X21pbl9hZHZt
c3MuCiAqICAgIFRoaXMgbWF5IGJlIG92ZXJyaWRkZW4gdmlhIGluZm9ybWF0aW9uIHN0b3JlZCBp
biByb3V0aW5nIHRhYmxlLgogKiA1LiBWYWx1ZSA2NTUzNSBmb3IgTVNTIGlzIHZhbGlkIGluIElQ
djYgYW5kIG1lYW5zICJhcyBsYXJnZSBhcyBwb3NzaWJsZSwKICogICAgcHJvYmFibHkgZXZlbiBK
dW1ibyIuCiAqLwpzdGF0aWMgX191MTYgdGNwX2FkdmVydGlzZV9tc3Moc3RydWN0IHNvY2sgKnNr
KQp7CglzdHJ1Y3QgdGNwX3NvY2sgKnRwID0gdGNwX3NrKHNrKTsKCWNvbnN0IHN0cnVjdCBkc3Rf
ZW50cnkgKmRzdCA9IF9fc2tfZHN0X2dldChzayk7CglpbnQgbXNzID0gdHAtPmFkdm1zczsKCglp
ZiAoZHN0KSB7CgkJdW5zaWduZWQgaW50IG1ldHJpYyA9IGRzdF9tZXRyaWNfYWR2bXNzKGRzdCk7
CgoJCWlmIChtZXRyaWMgPCBtc3MpIHsKCQkJbXNzID0gbWV0cmljOwoJCQl0cC0+YWR2bXNzID0g
bXNzOwoJCX0KCX0KCglyZXR1cm4gKF9fdTE2KW1zczsKfQoKLyogUkZDMjg2MS4gUmVzZXQgQ1dO
RCBhZnRlciBpZGxlIHBlcmlvZCBsb25nZXIgUlRPIHRvICJyZXN0YXJ0IHdpbmRvdyIuCiAqIFRo
aXMgaXMgdGhlIGZpcnN0IHBhcnQgb2YgY3duZCB2YWxpZGF0aW9uIG1lY2hhbmlzbS4KICovCnZv
aWQgdGNwX2N3bmRfcmVzdGFydChzdHJ1Y3Qgc29jayAqc2ssIHMzMiBkZWx0YSkKewoJc3RydWN0
IHRjcF9zb2NrICp0cCA9IHRjcF9zayhzayk7Cgl1MzIgcmVzdGFydF9jd25kID0gdGNwX2luaXRf
Y3duZCh0cCwgX19za19kc3RfZ2V0KHNrKSk7Cgl1MzIgY3duZCA9IHRjcF9zbmRfY3duZCh0cCk7
CgoJdGNwX2NhX2V2ZW50KHNrLCBDQV9FVkVOVF9DV05EX1JFU1RBUlQpOwoKCXRwLT5zbmRfc3N0
aHJlc2ggPSB0Y3BfY3VycmVudF9zc3RocmVzaChzayk7CglyZXN0YXJ0X2N3bmQgPSBtaW4ocmVz
dGFydF9jd25kLCBjd25kKTsKCgl3aGlsZSAoKGRlbHRhIC09IGluZXRfY3NrKHNrKS0+aWNza19y
dG8pID4gMCAmJiBjd25kID4gcmVzdGFydF9jd25kKQoJCWN3bmQgPj49IDE7Cgl0Y3Bfc25kX2N3
bmRfc2V0KHRwLCBtYXgoY3duZCwgcmVzdGFydF9jd25kKSk7Cgl0cC0+c25kX2N3bmRfc3RhbXAg
PSB0Y3BfamlmZmllczMyOwoJdHAtPnNuZF9jd25kX3VzZWQgPSAwOwp9CgovKiBDb25nZXN0aW9u
IHN0YXRlIGFjY291bnRpbmcgYWZ0ZXIgYSBwYWNrZXQgaGFzIGJlZW4gc2VudC4gKi8Kc3RhdGlj
IHZvaWQgdGNwX2V2ZW50X2RhdGFfc2VudChzdHJ1Y3QgdGNwX3NvY2sgKnRwLAoJCQkJc3RydWN0
IHNvY2sgKnNrKQp7CglzdHJ1Y3QgaW5ldF9jb25uZWN0aW9uX3NvY2sgKmljc2sgPSBpbmV0X2Nz
ayhzayk7Cgljb25zdCB1MzIgbm93ID0gdGNwX2ppZmZpZXMzMjsKCglpZiAodGNwX3BhY2tldHNf
aW5fZmxpZ2h0KHRwKSA9PSAwKQoJCXRjcF9jYV9ldmVudChzaywgQ0FfRVZFTlRfVFhfU1RBUlQp
OwoKCXRwLT5sc25kdGltZSA9IG5vdzsKCgkvKiBJZiBpdCBpcyBhIHJlcGx5IGZvciBhdG8gYWZ0
ZXIgbGFzdCByZWNlaXZlZAoJICogcGFja2V0LCBpbmNyZWFzZSBwaW5ncG9uZyBjb3VudC4KCSAq
LwoJaWYgKCh1MzIpKG5vdyAtIGljc2stPmljc2tfYWNrLmxyY3Z0aW1lKSA8IGljc2stPmljc2tf
YWNrLmF0bykKCQlpbmV0X2Nza19pbmNfcGluZ3BvbmdfY250KHNrKTsKfQoKLyogQWNjb3VudCBm
b3IgYW4gQUNLIHdlIHNlbnQuICovCnN0YXRpYyBpbmxpbmUgdm9pZCB0Y3BfZXZlbnRfYWNrX3Nl
bnQoc3RydWN0IHNvY2sgKnNrLCB1MzIgcmN2X254dCkKewoJc3RydWN0IHRjcF9zb2NrICp0cCA9
IHRjcF9zayhzayk7CgoJaWYgKHVubGlrZWx5KHRwLT5jb21wcmVzc2VkX2FjaykpIHsKCQlORVRf
QUREX1NUQVRTKHNvY2tfbmV0KHNrKSwgTElOVVhfTUlCX1RDUEFDS0NPTVBSRVNTRUQsCgkJCSAg
ICAgIHRwLT5jb21wcmVzc2VkX2Fjayk7CgkJdHAtPmNvbXByZXNzZWRfYWNrID0gMDsKCQlpZiAo
aHJ0aW1lcl90cnlfdG9fY2FuY2VsKCZ0cC0+Y29tcHJlc3NlZF9hY2tfdGltZXIpID09IDEpCgkJ
CV9fc29ja19wdXQoc2spOwoJfQoKCWlmICh1bmxpa2VseShyY3Zfbnh0ICE9IHRwLT5yY3Zfbnh0
KSkKCQlyZXR1cm47ICAvKiBTcGVjaWFsIEFDSyBzZW50IGJ5IERDVENQIHRvIHJlZmxlY3QgRUNO
ICovCgl0Y3BfZGVjX3F1aWNrYWNrX21vZGUoc2spOwoJaW5ldF9jc2tfY2xlYXJfeG1pdF90aW1l
cihzaywgSUNTS19USU1FX0RBQ0spOwp9CgovKiBEZXRlcm1pbmUgYSB3aW5kb3cgc2NhbGluZyBh
bmQgaW5pdGlhbCB3aW5kb3cgdG8gb2ZmZXIuCiAqIEJhc2VkIG9uIHRoZSBhc3N1bXB0aW9uIHRo
YXQgdGhlIGdpdmVuIGFtb3VudCBvZiBzcGFjZQogKiB3aWxsIGJlIG9mZmVyZWQuIFN0b3JlIHRo
ZSByZXN1bHRzIGluIHRoZSB0cCBzdHJ1Y3R1cmUuCiAqIE5PVEU6IGZvciBzbW9vdGggb3BlcmF0
aW9uIGluaXRpYWwgc3BhY2Ugb2ZmZXJpbmcgc2hvdWxkCiAqIGJlIGEgbXVsdGlwbGUgb2YgbXNz
IGlmIHBvc3NpYmxlLiBXZSBhc3N1bWUgaGVyZSB0aGF0IG1zcyA+PSAxLgogKiBUaGlzIE1VU1Qg
YmUgZW5mb3JjZWQgYnkgYWxsIGNhbGxlcnMuCiAqLwp2b2lkIHRjcF9zZWxlY3RfaW5pdGlhbF93
aW5kb3coY29uc3Qgc3RydWN0IHNvY2sgKnNrLCBpbnQgX19zcGFjZSwgX191MzIgbXNzLAoJCQkg
ICAgICAgX191MzIgKnJjdl93bmQsIF9fdTMyICpfX3dpbmRvd19jbGFtcCwKCQkJICAgICAgIGlu
dCB3c2NhbGVfb2ssIF9fdTggKnJjdl93c2NhbGUsCgkJCSAgICAgICBfX3UzMiBpbml0X3Jjdl93
bmQpCnsKCXVuc2lnbmVkIGludCBzcGFjZSA9IChfX3NwYWNlIDwgMCA/IDAgOiBfX3NwYWNlKTsK
CXUzMiB3aW5kb3dfY2xhbXAgPSBSRUFEX09OQ0UoKl9fd2luZG93X2NsYW1wKTsKCgkvKiBJZiBu
byBjbGFtcCBzZXQgdGhlIGNsYW1wIHRvIHRoZSBtYXggcG9zc2libGUgc2NhbGVkIHdpbmRvdyAq
LwoJaWYgKHdpbmRvd19jbGFtcCA9PSAwKQoJCXdpbmRvd19jbGFtcCA9IChVMTZfTUFYIDw8IFRD
UF9NQVhfV1NDQUxFKTsKCXNwYWNlID0gbWluKHdpbmRvd19jbGFtcCwgc3BhY2UpOwoKCS8qIFF1
YW50aXplIHNwYWNlIG9mZmVyaW5nIHRvIGEgbXVsdGlwbGUgb2YgbXNzIGlmIHBvc3NpYmxlLiAq
LwoJaWYgKHNwYWNlID4gbXNzKQoJCXNwYWNlID0gcm91bmRkb3duKHNwYWNlLCBtc3MpOwoKCS8q
IE5PVEU6IG9mZmVyaW5nIGFuIGluaXRpYWwgd2luZG93IGxhcmdlciB0aGFuIDMyNzY3CgkgKiB3
aWxsIGJyZWFrIHNvbWUgYnVnZ3kgVENQIHN0YWNrcy4gSWYgdGhlIGFkbWluIHRlbGxzIHVzCgkg
KiBpdCBpcyBsaWtlbHkgd2UgY291bGQgYmUgc3BlYWtpbmcgd2l0aCBzdWNoIGEgYnVnZ3kgc3Rh
Y2sKCSAqIHdlIHdpbGwgdHJ1bmNhdGUgb3VyIGluaXRpYWwgd2luZG93IG9mZmVyaW5nIHRvIDMy
Sy0xCgkgKiB1bmxlc3MgdGhlIHJlbW90ZSBoYXMgc2VudCB1cyBhIHdpbmRvdyBzY2FsaW5nIG9w
dGlvbiwKCSAqIHdoaWNoIHdlIGludGVycHJldCBhcyBhIHNpZ24gdGhlIHJlbW90ZSBUQ1AgaXMg
bm90CgkgKiBtaXNpbnRlcnByZXRpbmcgdGhlIHdpbmRvdyBmaWVsZCBhcyBhIHNpZ25lZCBxdWFu
dGl0eS4KCSAqLwoJaWYgKFJFQURfT05DRShzb2NrX25ldChzayktPmlwdjQuc3lzY3RsX3RjcF93
b3JrYXJvdW5kX3NpZ25lZF93aW5kb3dzKSkKCQkoKnJjdl93bmQpID0gbWluKHNwYWNlLCBNQVhf
VENQX1dJTkRPVyk7CgllbHNlCgkJKCpyY3Zfd25kKSA9IG1pbl90KHUzMiwgc3BhY2UsIFUxNl9N
QVgpOwoKCWlmIChpbml0X3Jjdl93bmQpCgkJKnJjdl93bmQgPSBtaW4oKnJjdl93bmQsIGluaXRf
cmN2X3duZCAqIG1zcyk7CgoJKnJjdl93c2NhbGUgPSAwOwoJaWYgKHdzY2FsZV9vaykgewoJCS8q
IFNldCB3aW5kb3cgc2NhbGluZyBvbiBtYXggcG9zc2libGUgd2luZG93ICovCgkJc3BhY2UgPSBt
YXhfdCh1MzIsIHNwYWNlLCBSRUFEX09OQ0Uoc29ja19uZXQoc2spLT5pcHY0LnN5c2N0bF90Y3Bf
cm1lbVsyXSkpOwoJCXNwYWNlID0gbWF4X3QodTMyLCBzcGFjZSwgUkVBRF9PTkNFKHN5c2N0bF9y
bWVtX21heCkpOwoJCXNwYWNlID0gbWluX3QodTMyLCBzcGFjZSwgd2luZG93X2NsYW1wKTsKCQkq
cmN2X3dzY2FsZSA9IGNsYW1wX3QoaW50LCBpbG9nMihzcGFjZSkgLSAxNSwKCQkJCSAgICAgIDAs
IFRDUF9NQVhfV1NDQUxFKTsKCX0KCS8qIFNldCB0aGUgY2xhbXAgbm8gaGlnaGVyIHRoYW4gbWF4
IHJlcHJlc2VudGFibGUgdmFsdWUgKi8KCVdSSVRFX09OQ0UoKl9fd2luZG93X2NsYW1wLAoJCSAg
IG1pbl90KF9fdTMyLCBVMTZfTUFYIDw8ICgqcmN2X3dzY2FsZSksIHdpbmRvd19jbGFtcCkpOwp9
CkVYUE9SVF9TWU1CT0wodGNwX3NlbGVjdF9pbml0aWFsX3dpbmRvdyk7CgovKiBDaG9zZSBhIG5l
dyB3aW5kb3cgdG8gYWR2ZXJ0aXNlLCB1cGRhdGUgc3RhdGUgaW4gdGNwX3NvY2sgZm9yIHRoZQog
KiBzb2NrZXQsIGFuZCByZXR1cm4gcmVzdWx0IHdpdGggUkZDMTMyMyBzY2FsaW5nIGFwcGxpZWQu
ICBUaGUgcmV0dXJuCiAqIHZhbHVlIGNhbiBiZSBzdHVmZmVkIGRpcmVjdGx5IGludG8gdGgtPndp
bmRvdyBmb3IgYW4gb3V0Z29pbmcKICogZnJhbWUuCiAqLwpzdGF0aWMgdTE2IHRjcF9zZWxlY3Rf
d2luZG93KHN0cnVjdCBzb2NrICpzaykKewoJc3RydWN0IHRjcF9zb2NrICp0cCA9IHRjcF9zayhz
ayk7CglzdHJ1Y3QgbmV0ICpuZXQgPSBzb2NrX25ldChzayk7Cgl1MzIgb2xkX3dpbiA9IHRwLT5y
Y3Zfd25kOwoJdTMyIGN1cl93aW4sIG5ld193aW47CgoJLyogTWFrZSB0aGUgd2luZG93IDAgaWYg
d2UgZmFpbGVkIHRvIHF1ZXVlIHRoZSBkYXRhIGJlY2F1c2Ugd2UKCSAqIGFyZSBvdXQgb2YgbWVt
b3J5LiBUaGUgd2luZG93IGlzIHRlbXBvcmFyeSwgc28gd2UgZG9uJ3Qgc3RvcmUKCSAqIGl0IG9u
IHRoZSBzb2NrZXQuCgkgKi8KCWlmICh1bmxpa2VseShpbmV0X2NzayhzayktPmljc2tfYWNrLnBl
bmRpbmcgJiBJQ1NLX0FDS19OT01FTSkpCgkJcmV0dXJuIDA7CgoJY3VyX3dpbiA9IHRjcF9yZWNl
aXZlX3dpbmRvdyh0cCk7CgluZXdfd2luID0gX190Y3Bfc2VsZWN0X3dpbmRvdyhzayk7CglpZiAo
bmV3X3dpbiA8IGN1cl93aW4pIHsKCQkvKiBEYW5nZXIgV2lsbCBSb2JpbnNvbiEKCQkgKiBEb24n
dCB1cGRhdGUgcmN2X3d1cC9yY3Zfd25kIGhlcmUgb3IgZWxzZQoJCSAqIHdlIHdpbGwgbm90IGJl
IGFibGUgdG8gYWR2ZXJ0aXNlIGEgemVybwoJCSAqIHdpbmRvdyBpbiB0aW1lLiAgLS1EYXZlTQoJ
CSAqCgkJICogUmVsYXggV2lsbCBSb2JpbnNvbi4KCQkgKi8KCQlpZiAoIVJFQURfT05DRShuZXQt
PmlwdjQuc3lzY3RsX3RjcF9zaHJpbmtfd2luZG93KSB8fCAhdHAtPnJ4X29wdC5yY3Zfd3NjYWxl
KSB7CgkJCS8qIE5ldmVyIHNocmluayB0aGUgb2ZmZXJlZCB3aW5kb3cgKi8KCQkJaWYgKG5ld193
aW4gPT0gMCkKCQkJCU5FVF9JTkNfU1RBVFMobmV0LCBMSU5VWF9NSUJfVENQV0FOVFpFUk9XSU5E
T1dBRFYpOwoJCQluZXdfd2luID0gQUxJR04oY3VyX3dpbiwgMSA8PCB0cC0+cnhfb3B0LnJjdl93
c2NhbGUpOwoJCX0KCX0KCgl0cC0+cmN2X3duZCA9IG5ld193aW47Cgl0cC0+cmN2X3d1cCA9IHRw
LT5yY3Zfbnh0OwoKCS8qIE1ha2Ugc3VyZSB3ZSBkbyBub3QgZXhjZWVkIHRoZSBtYXhpbXVtIHBv
c3NpYmxlCgkgKiBzY2FsZWQgd2luZG93LgoJICovCglpZiAoIXRwLT5yeF9vcHQucmN2X3dzY2Fs
ZSAmJgoJICAgIFJFQURfT05DRShuZXQtPmlwdjQuc3lzY3RsX3RjcF93b3JrYXJvdW5kX3NpZ25l
ZF93aW5kb3dzKSkKCQluZXdfd2luID0gbWluKG5ld193aW4sIE1BWF9UQ1BfV0lORE9XKTsKCWVs
c2UKCQluZXdfd2luID0gbWluKG5ld193aW4sICg2NTUzNVUgPDwgdHAtPnJ4X29wdC5yY3Zfd3Nj
YWxlKSk7CgoJLyogUkZDMTMyMyBzY2FsaW5nIGFwcGxpZWQgKi8KCW5ld193aW4gPj49IHRwLT5y
eF9vcHQucmN2X3dzY2FsZTsKCgkvKiBJZiB3ZSBhZHZlcnRpc2UgemVybyB3aW5kb3csIGRpc2Fi
bGUgZmFzdCBwYXRoLiAqLwoJaWYgKG5ld193aW4gPT0gMCkgewoJCXRwLT5wcmVkX2ZsYWdzID0g
MDsKCQlpZiAob2xkX3dpbikKCQkJTkVUX0lOQ19TVEFUUyhuZXQsIExJTlVYX01JQl9UQ1BUT1pF
Uk9XSU5ET1dBRFYpOwoJfSBlbHNlIGlmIChvbGRfd2luID09IDApIHsKCQlORVRfSU5DX1NUQVRT
KG5ldCwgTElOVVhfTUlCX1RDUEZST01aRVJPV0lORE9XQURWKTsKCX0KCglyZXR1cm4gbmV3X3dp
bjsKfQoKLyogUGFja2V0IEVDTiBzdGF0ZSBmb3IgYSBTWU4tQUNLICovCnN0YXRpYyB2b2lkIHRj
cF9lY25fc2VuZF9zeW5hY2soc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQp7
Cgljb25zdCBzdHJ1Y3QgdGNwX3NvY2sgKnRwID0gdGNwX3NrKHNrKTsKCglUQ1BfU0tCX0NCKHNr
YiktPnRjcF9mbGFncyAmPSB+VENQSERSX0NXUjsKCWlmICghKHRwLT5lY25fZmxhZ3MgJiBUQ1Bf
RUNOX09LKSkKCQlUQ1BfU0tCX0NCKHNrYiktPnRjcF9mbGFncyAmPSB+VENQSERSX0VDRTsKCWVs
c2UgaWYgKHRjcF9jYV9uZWVkc19lY24oc2spIHx8CgkJIHRjcF9icGZfY2FfbmVlZHNfZWNuKHNr
KSkKCQlJTkVUX0VDTl94bWl0KHNrKTsKfQoKLyogUGFja2V0IEVDTiBzdGF0ZSBmb3IgYSBTWU4u
ICAqLwpzdGF0aWMgdm9pZCB0Y3BfZWNuX3NlbmRfc3luKHN0cnVjdCBzb2NrICpzaywgc3RydWN0
IHNrX2J1ZmYgKnNrYikKewoJc3RydWN0IHRjcF9zb2NrICp0cCA9IHRjcF9zayhzayk7Cglib29s
IGJwZl9uZWVkc19lY24gPSB0Y3BfYnBmX2NhX25lZWRzX2Vjbihzayk7Cglib29sIHVzZV9lY24g
PSBSRUFEX09OQ0Uoc29ja19uZXQoc2spLT5pcHY0LnN5c2N0bF90Y3BfZWNuKSA9PSAxIHx8CgkJ
dGNwX2NhX25lZWRzX2VjbihzaykgfHwgYnBmX25lZWRzX2VjbjsKCglpZiAoIXVzZV9lY24pIHsK
CQljb25zdCBzdHJ1Y3QgZHN0X2VudHJ5ICpkc3QgPSBfX3NrX2RzdF9nZXQoc2spOwoKCQlpZiAo
ZHN0ICYmIGRzdF9mZWF0dXJlKGRzdCwgUlRBWF9GRUFUVVJFX0VDTikpCgkJCXVzZV9lY24gPSB0
cnVlOwoJfQoKCXRwLT5lY25fZmxhZ3MgPSAwOwoKCWlmICh1c2VfZWNuKSB7CgkJVENQX1NLQl9D
Qihza2IpLT50Y3BfZmxhZ3MgfD0gVENQSERSX0VDRSB8IFRDUEhEUl9DV1I7CgkJdHAtPmVjbl9m
bGFncyA9IFRDUF9FQ05fT0s7CgkJaWYgKHRjcF9jYV9uZWVkc19lY24oc2spIHx8IGJwZl9uZWVk
c19lY24pCgkJCUlORVRfRUNOX3htaXQoc2spOwoJfQp9CgpzdGF0aWMgdm9pZCB0Y3BfZWNuX2Ns
ZWFyX3N5bihzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBza19idWZmICpza2IpCnsKCWlmIChSRUFE
X09OQ0Uoc29ja19uZXQoc2spLT5pcHY0LnN5c2N0bF90Y3BfZWNuX2ZhbGxiYWNrKSkKCQkvKiB0
cC0+ZWNuX2ZsYWdzIGFyZSBjbGVhcmVkIGF0IGEgbGF0ZXIgcG9pbnQgaW4gdGltZSB3aGVuCgkJ
ICogU1lOIEFDSyBpcyB1bHRpbWF0aXZlbHkgYmVpbmcgcmVjZWl2ZWQuCgkJICovCgkJVENQX1NL
Ql9DQihza2IpLT50Y3BfZmxhZ3MgJj0gfihUQ1BIRFJfRUNFIHwgVENQSERSX0NXUik7Cn0KCnN0
YXRpYyB2b2lkCnRjcF9lY25fbWFrZV9zeW5hY2soY29uc3Qgc3RydWN0IHJlcXVlc3Rfc29jayAq
cmVxLCBzdHJ1Y3QgdGNwaGRyICp0aCkKewoJaWYgKGluZXRfcnNrKHJlcSktPmVjbl9vaykKCQl0
aC0+ZWNlID0gMTsKfQoKLyogU2V0IHVwIEVDTiBzdGF0ZSBmb3IgYSBwYWNrZXQgb24gYSBFU1RB
QkxJU0hFRCBzb2NrZXQgdGhhdCBpcyBhYm91dCB0bwogKiBiZSBzZW50LgogKi8Kc3RhdGljIHZv
aWQgdGNwX2Vjbl9zZW5kKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYgKnNrYiwKCQkJ
IHN0cnVjdCB0Y3BoZHIgKnRoLCBpbnQgdGNwX2hlYWRlcl9sZW4pCnsKCXN0cnVjdCB0Y3Bfc29j
ayAqdHAgPSB0Y3Bfc2soc2spOwoKCWlmICh0cC0+ZWNuX2ZsYWdzICYgVENQX0VDTl9PSykgewoJ
CS8qIE5vdC1yZXRyYW5zbWl0dGVkIGRhdGEgc2VnbWVudDogc2V0IEVDVCBhbmQgaW5qZWN0IENX
Ui4gKi8KCQlpZiAoc2tiLT5sZW4gIT0gdGNwX2hlYWRlcl9sZW4gJiYKCQkgICAgIWJlZm9yZShU
Q1BfU0tCX0NCKHNrYiktPnNlcSwgdHAtPnNuZF9ueHQpKSB7CgkJCUlORVRfRUNOX3htaXQoc2sp
OwoJCQlpZiAodHAtPmVjbl9mbGFncyAmIFRDUF9FQ05fUVVFVUVfQ1dSKSB7CgkJCQl0cC0+ZWNu
X2ZsYWdzICY9IH5UQ1BfRUNOX1FVRVVFX0NXUjsKCQkJCXRoLT5jd3IgPSAxOwoJCQkJc2tiX3No
aW5mbyhza2IpLT5nc29fdHlwZSB8PSBTS0JfR1NPX1RDUF9FQ047CgkJCX0KCQl9IGVsc2UgaWYg
KCF0Y3BfY2FfbmVlZHNfZWNuKHNrKSkgewoJCQkvKiBBQ0sgb3IgcmV0cmFuc21pdHRlZCBzZWdt
ZW50OiBjbGVhciBFQ1R8Q0UgKi8KCQkJSU5FVF9FQ05fZG9udHhtaXQoc2spOwoJCX0KCQlpZiAo
dHAtPmVjbl9mbGFncyAmIFRDUF9FQ05fREVNQU5EX0NXUikKCQkJdGgtPmVjZSA9IDE7Cgl9Cn0K
Ci8qIENvbnN0cnVjdHMgY29tbW9uIGNvbnRyb2wgYml0cyBvZiBub24tZGF0YSBza2IuIElmIFNZ
Ti9GSU4gaXMgcHJlc2VudCwKICogYXV0byBpbmNyZW1lbnQgZW5kIHNlcW5vLgogKi8Kc3RhdGlj
IHZvaWQgdGNwX2luaXRfbm9uZGF0YV9za2Ioc3RydWN0IHNrX2J1ZmYgKnNrYiwgdTMyIHNlcSwg
dTggZmxhZ3MpCnsKCXNrYi0+aXBfc3VtbWVkID0gQ0hFQ0tTVU1fUEFSVElBTDsKCglUQ1BfU0tC
X0NCKHNrYiktPnRjcF9mbGFncyA9IGZsYWdzOwoKCXRjcF9za2JfcGNvdW50X3NldChza2IsIDEp
OwoKCVRDUF9TS0JfQ0Ioc2tiKS0+c2VxID0gc2VxOwoJaWYgKGZsYWdzICYgKFRDUEhEUl9TWU4g
fCBUQ1BIRFJfRklOKSkKCQlzZXErKzsKCVRDUF9TS0JfQ0Ioc2tiKS0+ZW5kX3NlcSA9IHNlcTsK
fQoKc3RhdGljIGlubGluZSBib29sIHRjcF91cmdfbW9kZShjb25zdCBzdHJ1Y3QgdGNwX3NvY2sg
KnRwKQp7CglyZXR1cm4gdHAtPnNuZF91bmEgIT0gdHAtPnNuZF91cDsKfQoKI2RlZmluZSBPUFRJ
T05fU0FDS19BRFZFUlRJU0UJQklUKDApCiNkZWZpbmUgT1BUSU9OX1RTCQlCSVQoMSkKI2RlZmlu
ZSBPUFRJT05fTUQ1CQlCSVQoMikKI2RlZmluZSBPUFRJT05fV1NDQUxFCQlCSVQoMykKI2RlZmlu
ZSBPUFRJT05fRkFTVF9PUEVOX0NPT0tJRQlCSVQoOCkKI2RlZmluZSBPUFRJT05fU01DCQlCSVQo
OSkKI2RlZmluZSBPUFRJT05fTVBUQ1AJCUJJVCgxMCkKI2RlZmluZSBPUFRJT05fQU8JCUJJVCgx
MSkKCnN0YXRpYyB2b2lkIHNtY19vcHRpb25zX3dyaXRlKF9fYmUzMiAqcHRyLCB1MTYgKm9wdGlv
bnMpCnsKI2lmIElTX0VOQUJMRUQoQ09ORklHX1NNQykKCWlmIChzdGF0aWNfYnJhbmNoX3VubGlr
ZWx5KCZ0Y3BfaGF2ZV9zbWMpKSB7CgkJaWYgKHVubGlrZWx5KE9QVElPTl9TTUMgJiAqb3B0aW9u
cykpIHsKCQkJKnB0cisrID0gaHRvbmwoKFRDUE9QVF9OT1AgIDw8IDI0KSB8CgkJCQkgICAgICAg
KFRDUE9QVF9OT1AgIDw8IDE2KSB8CgkJCQkgICAgICAgKFRDUE9QVF9FWFAgPDwgIDgpIHwKCQkJ
CSAgICAgICAoVENQT0xFTl9FWFBfU01DX0JBU0UpKTsKCQkJKnB0cisrID0gaHRvbmwoVENQT1BU
X1NNQ19NQUdJQyk7CgkJfQoJfQojZW5kaWYKfQoKc3RydWN0IHRjcF9vdXRfb3B0aW9ucyB7Cgl1
MTYgb3B0aW9uczsJCS8qIGJpdCBmaWVsZCBvZiBPUFRJT05fKiAqLwoJdTE2IG1zczsJCS8qIDAg
dG8gZGlzYWJsZSAqLwoJdTggd3M7CQkJLyogd2luZG93IHNjYWxlLCAwIHRvIGRpc2FibGUgKi8K
CXU4IG51bV9zYWNrX2Jsb2NrczsJLyogbnVtYmVyIG9mIFNBQ0sgYmxvY2tzIHRvIGluY2x1ZGUg
Ki8KCXU4IGhhc2hfc2l6ZTsJCS8qIGJ5dGVzIGluIGhhc2hfbG9jYXRpb24gKi8KCXU4IGJwZl9v
cHRfbGVuOwkJLyogbGVuZ3RoIG9mIEJQRiBoZHIgb3B0aW9uICovCglfX3U4ICpoYXNoX2xvY2F0
aW9uOwkvKiB0ZW1wb3JhcnkgcG9pbnRlciwgb3ZlcmxvYWRlZCAqLwoJX191MzIgdHN2YWwsIHRz
ZWNyOwkvKiBuZWVkIHRvIGluY2x1ZGUgT1BUSU9OX1RTICovCglzdHJ1Y3QgdGNwX2Zhc3RvcGVu
X2Nvb2tpZSAqZmFzdG9wZW5fY29va2llOwkvKiBGYXN0IG9wZW4gY29va2llICovCglzdHJ1Y3Qg
bXB0Y3Bfb3V0X29wdGlvbnMgbXB0Y3A7Cn07CgpzdGF0aWMgdm9pZCBtcHRjcF9vcHRpb25zX3dy
aXRlKHN0cnVjdCB0Y3BoZHIgKnRoLCBfX2JlMzIgKnB0ciwKCQkJCXN0cnVjdCB0Y3Bfc29jayAq
dHAsCgkJCQlzdHJ1Y3QgdGNwX291dF9vcHRpb25zICpvcHRzKQp7CiNpZiBJU19FTkFCTEVEKENP
TkZJR19NUFRDUCkKCWlmICh1bmxpa2VseShPUFRJT05fTVBUQ1AgJiBvcHRzLT5vcHRpb25zKSkK
CQltcHRjcF93cml0ZV9vcHRpb25zKHRoLCBwdHIsIHRwLCAmb3B0cy0+bXB0Y3ApOwojZW5kaWYK
fQoKI2lmZGVmIENPTkZJR19DR1JPVVBfQlBGCnN0YXRpYyBpbnQgYnBmX3Nrb3BzX3dyaXRlX2hk
cl9vcHRfYXJnMChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAoJCQkJCWVudW0gdGNwX3N5bmFja190eXBl
IHN5bmFja190eXBlKQp7CglpZiAodW5saWtlbHkoIXNrYikpCgkJcmV0dXJuIEJQRl9XUklURV9I
RFJfVENQX0NVUlJFTlRfTVNTOwoKCWlmICh1bmxpa2VseShzeW5hY2tfdHlwZSA9PSBUQ1BfU1lO
QUNLX0NPT0tJRSkpCgkJcmV0dXJuIEJQRl9XUklURV9IRFJfVENQX1NZTkFDS19DT09LSUU7CgoJ
cmV0dXJuIDA7Cn0KCi8qIHJlcSwgc3luX3NrYiBhbmQgc3luYWNrX3R5cGUgYXJlIHVzZWQgd2hl
biB3cml0aW5nIHN5bmFjayAqLwpzdGF0aWMgdm9pZCBicGZfc2tvcHNfaGRyX29wdF9sZW4oc3Ry
dWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAoJCQkJICBzdHJ1Y3QgcmVxdWVzdF9z
b2NrICpyZXEsCgkJCQkgIHN0cnVjdCBza19idWZmICpzeW5fc2tiLAoJCQkJICBlbnVtIHRjcF9z
eW5hY2tfdHlwZSBzeW5hY2tfdHlwZSwKCQkJCSAgc3RydWN0IHRjcF9vdXRfb3B0aW9ucyAqb3B0
cywKCQkJCSAgdW5zaWduZWQgaW50ICpyZW1haW5pbmcpCnsKCXN0cnVjdCBicGZfc29ja19vcHNf
a2VybiBzb2NrX29wczsKCWludCBlcnI7CgoJaWYgKGxpa2VseSghQlBGX1NPQ0tfT1BTX1RFU1Rf
RkxBRyh0Y3Bfc2soc2spLAoJCQkJCSAgIEJQRl9TT0NLX09QU19XUklURV9IRFJfT1BUX0NCX0ZM
QUcpKSB8fAoJICAgICEqcmVtYWluaW5nKQoJCXJldHVybjsKCgkvKiAqcmVtYWluaW5nIGhhcyBh
bHJlYWR5IGJlZW4gYWxpZ25lZCB0byA0IGJ5dGVzLCBzbyAqcmVtYWluaW5nID49IDQgKi8KCgkv
KiBpbml0IHNvY2tfb3BzICovCgltZW1zZXQoJnNvY2tfb3BzLCAwLCBvZmZzZXRvZihzdHJ1Y3Qg
YnBmX3NvY2tfb3BzX2tlcm4sIHRlbXApKTsKCglzb2NrX29wcy5vcCA9IEJQRl9TT0NLX09QU19I
RFJfT1BUX0xFTl9DQjsKCglpZiAocmVxKSB7CgkJLyogVGhlIGxpc3RlbiAic2siIGNhbm5vdCBi
ZSBwYXNzZWQgaGVyZSBiZWNhdXNlCgkJICogaXQgaXMgbm90IGxvY2tlZC4gIEl0IHdvdWxkIG5v
dCBtYWtlIHRvbyBtdWNoCgkJICogc2Vuc2UgdG8gZG8gYnBmX3NldHNvY2tvcHQobGlzdGVuX3Nr
KSBiYXNlZAoJCSAqIG9uIGluZGl2aWR1YWwgY29ubmVjdGlvbiByZXF1ZXN0IGFsc28uCgkJICoK
CQkgKiBUaHVzLCAicmVxIiBpcyBwYXNzZWQgaGVyZSBhbmQgdGhlIGNncm91cC1icGYtcHJvZ3MK
CQkgKiBvZiB0aGUgbGlzdGVuICJzayIgd2lsbCBiZSBydW4uCgkJICoKCQkgKiAicmVxIiBpcyBh
bHNvIHVzZWQgaGVyZSBmb3IgZmFzdG9wZW4gZXZlbiB0aGUgInNrIiBoZXJlIGlzCgkJICogYSBm
dWxsc29jayAiY2hpbGQiIHNrLiAgSXQgaXMgdG8ga2VlcCB0aGUgYmVoYXZpb3IKCQkgKiBjb25z
aXN0ZW50IGJldHdlZW4gZmFzdG9wZW4gYW5kIG5vbi1mYXN0b3BlbiBvbgoJCSAqIHRoZSBicGYg
cHJvZ3JhbW1pbmcgc2lkZS4KCQkgKi8KCQlzb2NrX29wcy5zayA9IChzdHJ1Y3Qgc29jayAqKXJl
cTsKCQlzb2NrX29wcy5zeW5fc2tiID0gc3luX3NrYjsKCX0gZWxzZSB7CgkJc29ja19vd25lZF9i
eV9tZShzayk7CgoJCXNvY2tfb3BzLmlzX2Z1bGxzb2NrID0gMTsKCQlzb2NrX29wcy5zayA9IHNr
OwoJfQoKCXNvY2tfb3BzLmFyZ3NbMF0gPSBicGZfc2tvcHNfd3JpdGVfaGRyX29wdF9hcmcwKHNr
Yiwgc3luYWNrX3R5cGUpOwoJc29ja19vcHMucmVtYWluaW5nX29wdF9sZW4gPSAqcmVtYWluaW5n
OwoJLyogdGNwX2N1cnJlbnRfbXNzKCkgZG9lcyBub3QgcGFzcyBhIHNrYiAqLwoJaWYgKHNrYikK
CQlicGZfc2tvcHNfaW5pdF9za2IoJnNvY2tfb3BzLCBza2IsIDApOwoKCWVyciA9IEJQRl9DR1JP
VVBfUlVOX1BST0dfU09DS19PUFNfU0soJnNvY2tfb3BzLCBzayk7CgoJaWYgKGVyciB8fCBzb2Nr
X29wcy5yZW1haW5pbmdfb3B0X2xlbiA9PSAqcmVtYWluaW5nKQoJCXJldHVybjsKCglvcHRzLT5i
cGZfb3B0X2xlbiA9ICpyZW1haW5pbmcgLSBzb2NrX29wcy5yZW1haW5pbmdfb3B0X2xlbjsKCS8q
IHJvdW5kIHVwIHRvIDQgYnl0ZXMgKi8KCW9wdHMtPmJwZl9vcHRfbGVuID0gKG9wdHMtPmJwZl9v
cHRfbGVuICsgMykgJiB+MzsKCgkqcmVtYWluaW5nIC09IG9wdHMtPmJwZl9vcHRfbGVuOwp9Cgpz
dGF0aWMgdm9pZCBicGZfc2tvcHNfd3JpdGVfaGRyX29wdChzdHJ1Y3Qgc29jayAqc2ssIHN0cnVj
dCBza19idWZmICpza2IsCgkJCQkgICAgc3RydWN0IHJlcXVlc3Rfc29jayAqcmVxLAoJCQkJICAg
IHN0cnVjdCBza19idWZmICpzeW5fc2tiLAoJCQkJICAgIGVudW0gdGNwX3N5bmFja190eXBlIHN5
bmFja190eXBlLAoJCQkJICAgIHN0cnVjdCB0Y3Bfb3V0X29wdGlvbnMgKm9wdHMpCnsKCXU4IGZp
cnN0X29wdF9vZmYsIG5yX3dyaXR0ZW4sIG1heF9vcHRfbGVuID0gb3B0cy0+YnBmX29wdF9sZW47
CglzdHJ1Y3QgYnBmX3NvY2tfb3BzX2tlcm4gc29ja19vcHM7CglpbnQgZXJyOwoKCWlmIChsaWtl
bHkoIW1heF9vcHRfbGVuKSkKCQlyZXR1cm47CgoJbWVtc2V0KCZzb2NrX29wcywgMCwgb2Zmc2V0
b2Yoc3RydWN0IGJwZl9zb2NrX29wc19rZXJuLCB0ZW1wKSk7CgoJc29ja19vcHMub3AgPSBCUEZf
U09DS19PUFNfV1JJVEVfSERSX09QVF9DQjsKCglpZiAocmVxKSB7CgkJc29ja19vcHMuc2sgPSAo
c3RydWN0IHNvY2sgKilyZXE7CgkJc29ja19vcHMuc3luX3NrYiA9IHN5bl9za2I7Cgl9IGVsc2Ug
ewoJCXNvY2tfb3duZWRfYnlfbWUoc2spOwoKCQlzb2NrX29wcy5pc19mdWxsc29jayA9IDE7CgkJ
c29ja19vcHMuc2sgPSBzazsKCX0KCglzb2NrX29wcy5hcmdzWzBdID0gYnBmX3Nrb3BzX3dyaXRl
X2hkcl9vcHRfYXJnMChza2IsIHN5bmFja190eXBlKTsKCXNvY2tfb3BzLnJlbWFpbmluZ19vcHRf
bGVuID0gbWF4X29wdF9sZW47CglmaXJzdF9vcHRfb2ZmID0gdGNwX2hkcmxlbihza2IpIC0gbWF4
X29wdF9sZW47CglicGZfc2tvcHNfaW5pdF9za2IoJnNvY2tfb3BzLCBza2IsIGZpcnN0X29wdF9v
ZmYpOwoKCWVyciA9IEJQRl9DR1JPVVBfUlVOX1BST0dfU09DS19PUFNfU0soJnNvY2tfb3BzLCBz
ayk7CgoJaWYgKGVycikKCQlucl93cml0dGVuID0gMDsKCWVsc2UKCQlucl93cml0dGVuID0gbWF4
X29wdF9sZW4gLSBzb2NrX29wcy5yZW1haW5pbmdfb3B0X2xlbjsKCglpZiAobnJfd3JpdHRlbiA8
IG1heF9vcHRfbGVuKQoJCW1lbXNldChza2ItPmRhdGEgKyBmaXJzdF9vcHRfb2ZmICsgbnJfd3Jp
dHRlbiwgVENQT1BUX05PUCwKCQkgICAgICAgbWF4X29wdF9sZW4gLSBucl93cml0dGVuKTsKfQoj
ZWxzZQpzdGF0aWMgdm9pZCBicGZfc2tvcHNfaGRyX29wdF9sZW4oc3RydWN0IHNvY2sgKnNrLCBz
dHJ1Y3Qgc2tfYnVmZiAqc2tiLAoJCQkJICBzdHJ1Y3QgcmVxdWVzdF9zb2NrICpyZXEsCgkJCQkg
IHN0cnVjdCBza19idWZmICpzeW5fc2tiLAoJCQkJICBlbnVtIHRjcF9zeW5hY2tfdHlwZSBzeW5h
Y2tfdHlwZSwKCQkJCSAgc3RydWN0IHRjcF9vdXRfb3B0aW9ucyAqb3B0cywKCQkJCSAgdW5zaWdu
ZWQgaW50ICpyZW1haW5pbmcpCnsKfQoKc3RhdGljIHZvaWQgYnBmX3Nrb3BzX3dyaXRlX2hkcl9v
cHQoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAoJCQkJICAgIHN0cnVjdCBy
ZXF1ZXN0X3NvY2sgKnJlcSwKCQkJCSAgICBzdHJ1Y3Qgc2tfYnVmZiAqc3luX3NrYiwKCQkJCSAg
ICBlbnVtIHRjcF9zeW5hY2tfdHlwZSBzeW5hY2tfdHlwZSwKCQkJCSAgICBzdHJ1Y3QgdGNwX291
dF9vcHRpb25zICpvcHRzKQp7Cn0KI2VuZGlmCgpzdGF0aWMgX19iZTMyICpwcm9jZXNzX3RjcF9h
b19vcHRpb25zKHN0cnVjdCB0Y3Bfc29jayAqdHAsCgkJCQkgICAgICBjb25zdCBzdHJ1Y3QgdGNw
X3JlcXVlc3Rfc29jayAqdGNwcnNrLAoJCQkJICAgICAgc3RydWN0IHRjcF9vdXRfb3B0aW9ucyAq
b3B0cywKCQkJCSAgICAgIHN0cnVjdCB0Y3Bfa2V5ICprZXksIF9fYmUzMiAqcHRyKQp7CiNpZmRl
ZiBDT05GSUdfVENQX0FPCgl1OCBtYWNsZW4gPSB0Y3BfYW9fbWFjbGVuKGtleS0+YW9fa2V5KTsK
CglpZiAodGNwcnNrKSB7CgkJdTggYW9sZW4gPSBtYWNsZW4gKyBzaXplb2Yoc3RydWN0IHRjcF9h
b19oZHIpOwoKCQkqcHRyKysgPSBodG9ubCgoVENQT1BUX0FPIDw8IDI0KSB8IChhb2xlbiA8PCAx
NikgfAoJCQkgICAgICAgKHRjcHJzay0+YW9fa2V5aWQgPDwgOCkgfAoJCQkgICAgICAgKHRjcHJz
ay0+YW9fcmN2X25leHQpKTsKCX0gZWxzZSB7CgkJc3RydWN0IHRjcF9hb19rZXkgKnJuZXh0X2tl
eTsKCQlzdHJ1Y3QgdGNwX2FvX2luZm8gKmFvX2luZm87CgoJCWFvX2luZm8gPSByY3VfZGVyZWZl
cmVuY2VfY2hlY2sodHAtPmFvX2luZm8sCgkJCWxvY2tkZXBfc29ja19pc19oZWxkKCZ0cC0+aW5l
dF9jb25uLmljc2tfaW5ldC5zaykpOwoJCXJuZXh0X2tleSA9IFJFQURfT05DRShhb19pbmZvLT5y
bmV4dF9rZXkpOwoJCWlmIChXQVJOX09OX09OQ0UoIXJuZXh0X2tleSkpCgkJCXJldHVybiBwdHI7
CgkJKnB0cisrID0gaHRvbmwoKFRDUE9QVF9BTyA8PCAyNCkgfAoJCQkgICAgICAgKHRjcF9hb19s
ZW4oa2V5LT5hb19rZXkpIDw8IDE2KSB8CgkJCSAgICAgICAoa2V5LT5hb19rZXktPnNuZGlkIDw8
IDgpIHwKCQkJICAgICAgIChybmV4dF9rZXktPnJjdmlkKSk7Cgl9CglvcHRzLT5oYXNoX2xvY2F0
aW9uID0gKF9fdTggKilwdHI7CglwdHIgKz0gbWFjbGVuIC8gc2l6ZW9mKCpwdHIpOwoJaWYgKHVu
bGlrZWx5KG1hY2xlbiAlIHNpemVvZigqcHRyKSkpIHsKCQltZW1zZXQocHRyLCBUQ1BPUFRfTk9Q
LCBzaXplb2YoKnB0cikpOwoJCXB0cisrOwoJfQojZW5kaWYKCXJldHVybiBwdHI7Cn0KCi8qIFdy
aXRlIHByZXZpb3VzbHkgY29tcHV0ZWQgVENQIG9wdGlvbnMgdG8gdGhlIHBhY2tldC4KICoKICog
QmV3YXJlOiBTb21ldGhpbmcgaW4gdGhlIEludGVybmV0IGlzIHZlcnkgc2Vuc2l0aXZlIHRvIHRo
ZSBvcmRlcmluZyBvZgogKiBUQ1Agb3B0aW9ucywgd2UgbGVhcm5lZCB0aGlzIHRocm91Z2ggdGhl
IGhhcmQgd2F5LCBzbyBiZSBjYXJlZnVsIGhlcmUuCiAqIEx1Y2tpbHkgd2UgY2FuIGF0IGxlYXN0
IGJsYW1lIG90aGVycyBmb3IgdGhlaXIgbm9uLWNvbXBsaWFuY2UgYnV0IGZyb20KICogaW50ZXIt
b3BlcmFiaWxpdHkgcGVyc3BlY3RpdmUgaXQgc2VlbXMgdGhhdCB3ZSdyZSBzb21ld2hhdCBzdHVj
ayB3aXRoCiAqIHRoZSBvcmRlcmluZyB3aGljaCB3ZSBoYXZlIGJlZW4gdXNpbmcgaWYgd2Ugd2Fu
dCB0byBrZWVwIHdvcmtpbmcgd2l0aAogKiB0aG9zZSBicm9rZW4gdGhpbmdzIChub3QgdGhhdCBp
dCBjdXJyZW50bHkgaHVydHMgYW55Ym9keSBhcyB0aGVyZSBpc24ndAogKiBwYXJ0aWN1bGFyIHJl
YXNvbiB3aHkgdGhlIG9yZGVyaW5nIHdvdWxkIG5lZWQgdG8gYmUgY2hhbmdlZCkuCiAqCiAqIEF0
IGxlYXN0IFNBQ0tfUEVSTSBhcyB0aGUgZmlyc3Qgb3B0aW9uIGlzIGtub3duIHRvIGxlYWQgdG8g
YSBkaXNhc3RlcgogKiAoYnV0IGl0IG1heSB3ZWxsIGJlIHRoYXQgb3RoZXIgc2NlbmFyaW9zIGZh
aWwgc2ltaWxhcmx5KS4KICovCnN0YXRpYyB2b2lkIHRjcF9vcHRpb25zX3dyaXRlKHN0cnVjdCB0
Y3BoZHIgKnRoLCBzdHJ1Y3QgdGNwX3NvY2sgKnRwLAoJCQkgICAgICBjb25zdCBzdHJ1Y3QgdGNw
X3JlcXVlc3Rfc29jayAqdGNwcnNrLAoJCQkgICAgICBzdHJ1Y3QgdGNwX291dF9vcHRpb25zICpv
cHRzLAoJCQkgICAgICBzdHJ1Y3QgdGNwX2tleSAqa2V5KQp7CglfX2JlMzIgKnB0ciA9IChfX2Jl
MzIgKikodGggKyAxKTsKCXUxNiBvcHRpb25zID0gb3B0cy0+b3B0aW9uczsJLyogbXVuZ2FibGUg
Y29weSAqLwoKCWlmICh0Y3Bfa2V5X2lzX21kNShrZXkpKSB7CgkJKnB0cisrID0gaHRvbmwoKFRD
UE9QVF9OT1AgPDwgMjQpIHwgKFRDUE9QVF9OT1AgPDwgMTYpIHwKCQkJICAgICAgIChUQ1BPUFRf
TUQ1U0lHIDw8IDgpIHwgVENQT0xFTl9NRDVTSUcpOwoJCS8qIG92ZXJsb2FkIGNvb2tpZSBoYXNo
IGxvY2F0aW9uICovCgkJb3B0cy0+aGFzaF9sb2NhdGlvbiA9IChfX3U4ICopcHRyOwoJCXB0ciAr
PSA0OwoJfSBlbHNlIGlmICh0Y3Bfa2V5X2lzX2FvKGtleSkpIHsKCQlwdHIgPSBwcm9jZXNzX3Rj
cF9hb19vcHRpb25zKHRwLCB0Y3Byc2ssIG9wdHMsIGtleSwgcHRyKTsKCX0KCWlmICh1bmxpa2Vs
eShvcHRzLT5tc3MpKSB7CgkJKnB0cisrID0gaHRvbmwoKFRDUE9QVF9NU1MgPDwgMjQpIHwKCQkJ
ICAgICAgIChUQ1BPTEVOX01TUyA8PCAxNikgfAoJCQkgICAgICAgb3B0cy0+bXNzKTsKCX0KCglp
ZiAobGlrZWx5KE9QVElPTl9UUyAmIG9wdGlvbnMpKSB7CgkJaWYgKHVubGlrZWx5KE9QVElPTl9T
QUNLX0FEVkVSVElTRSAmIG9wdGlvbnMpKSB7CgkJCSpwdHIrKyA9IGh0b25sKChUQ1BPUFRfU0FD
S19QRVJNIDw8IDI0KSB8CgkJCQkgICAgICAgKFRDUE9MRU5fU0FDS19QRVJNIDw8IDE2KSB8CgkJ
CQkgICAgICAgKFRDUE9QVF9USU1FU1RBTVAgPDwgOCkgfAoJCQkJICAgICAgIFRDUE9MRU5fVElN
RVNUQU1QKTsKCQkJb3B0aW9ucyAmPSB+T1BUSU9OX1NBQ0tfQURWRVJUSVNFOwoJCX0gZWxzZSB7
CgkJCSpwdHIrKyA9IGh0b25sKChUQ1BPUFRfTk9QIDw8IDI0KSB8CgkJCQkgICAgICAgKFRDUE9Q
VF9OT1AgPDwgMTYpIHwKCQkJCSAgICAgICAoVENQT1BUX1RJTUVTVEFNUCA8PCA4KSB8CgkJCQkg
ICAgICAgVENQT0xFTl9USU1FU1RBTVApOwoJCX0KCQkqcHRyKysgPSBodG9ubChvcHRzLT50c3Zh
bCk7CgkJKnB0cisrID0gaHRvbmwob3B0cy0+dHNlY3IpOwoJfQoKCWlmICh1bmxpa2VseShPUFRJ
T05fU0FDS19BRFZFUlRJU0UgJiBvcHRpb25zKSkgewoJCSpwdHIrKyA9IGh0b25sKChUQ1BPUFRf
Tk9QIDw8IDI0KSB8CgkJCSAgICAgICAoVENQT1BUX05PUCA8PCAxNikgfAoJCQkgICAgICAgKFRD
UE9QVF9TQUNLX1BFUk0gPDwgOCkgfAoJCQkgICAgICAgVENQT0xFTl9TQUNLX1BFUk0pOwoJfQoK
CWlmICh1bmxpa2VseShPUFRJT05fV1NDQUxFICYgb3B0aW9ucykpIHsKCQkqcHRyKysgPSBodG9u
bCgoVENQT1BUX05PUCA8PCAyNCkgfAoJCQkgICAgICAgKFRDUE9QVF9XSU5ET1cgPDwgMTYpIHwK
CQkJICAgICAgIChUQ1BPTEVOX1dJTkRPVyA8PCA4KSB8CgkJCSAgICAgICBvcHRzLT53cyk7Cgl9
CgoJaWYgKHVubGlrZWx5KG9wdHMtPm51bV9zYWNrX2Jsb2NrcykpIHsKCQlzdHJ1Y3QgdGNwX3Nh
Y2tfYmxvY2sgKnNwID0gdHAtPnJ4X29wdC5kc2FjayA/CgkJCXRwLT5kdXBsaWNhdGVfc2FjayA6
IHRwLT5zZWxlY3RpdmVfYWNrczsKCQlpbnQgdGhpc19zYWNrOwoKCQkqcHRyKysgPSBodG9ubCgo
VENQT1BUX05PUCAgPDwgMjQpIHwKCQkJICAgICAgIChUQ1BPUFRfTk9QICA8PCAxNikgfAoJCQkg
ICAgICAgKFRDUE9QVF9TQUNLIDw8ICA4KSB8CgkJCSAgICAgICAoVENQT0xFTl9TQUNLX0JBU0Ug
KyAob3B0cy0+bnVtX3NhY2tfYmxvY2tzICoKCQkJCQkJICAgICBUQ1BPTEVOX1NBQ0tfUEVSQkxP
Q0spKSk7CgoJCWZvciAodGhpc19zYWNrID0gMDsgdGhpc19zYWNrIDwgb3B0cy0+bnVtX3NhY2tf
YmxvY2tzOwoJCSAgICAgKyt0aGlzX3NhY2spIHsKCQkJKnB0cisrID0gaHRvbmwoc3BbdGhpc19z
YWNrXS5zdGFydF9zZXEpOwoJCQkqcHRyKysgPSBodG9ubChzcFt0aGlzX3NhY2tdLmVuZF9zZXEp
OwoJCX0KCgkJdHAtPnJ4X29wdC5kc2FjayA9IDA7Cgl9CgoJaWYgKHVubGlrZWx5KE9QVElPTl9G
QVNUX09QRU5fQ09PS0lFICYgb3B0aW9ucykpIHsKCQlzdHJ1Y3QgdGNwX2Zhc3RvcGVuX2Nvb2tp
ZSAqZm9jID0gb3B0cy0+ZmFzdG9wZW5fY29va2llOwoJCXU4ICpwID0gKHU4ICopcHRyOwoJCXUz
MiBsZW47IC8qIEZhc3QgT3BlbiBvcHRpb24gbGVuZ3RoICovCgoJCWlmIChmb2MtPmV4cCkgewoJ
CQlsZW4gPSBUQ1BPTEVOX0VYUF9GQVNUT1BFTl9CQVNFICsgZm9jLT5sZW47CgkJCSpwdHIgPSBo
dG9ubCgoVENQT1BUX0VYUCA8PCAyNCkgfCAobGVuIDw8IDE2KSB8CgkJCQkgICAgIFRDUE9QVF9G
QVNUT1BFTl9NQUdJQyk7CgkJCXAgKz0gVENQT0xFTl9FWFBfRkFTVE9QRU5fQkFTRTsKCQl9IGVs
c2UgewoJCQlsZW4gPSBUQ1BPTEVOX0ZBU1RPUEVOX0JBU0UgKyBmb2MtPmxlbjsKCQkJKnArKyA9
IFRDUE9QVF9GQVNUT1BFTjsKCQkJKnArKyA9IGxlbjsKCQl9CgoJCW1lbWNweShwLCBmb2MtPnZh
bCwgZm9jLT5sZW4pOwoJCWlmICgobGVuICYgMykgPT0gMikgewoJCQlwW2ZvYy0+bGVuXSA9IFRD
UE9QVF9OT1A7CgkJCXBbZm9jLT5sZW4gKyAxXSA9IFRDUE9QVF9OT1A7CgkJfQoJCXB0ciArPSAo
bGVuICsgMykgPj4gMjsKCX0KCglzbWNfb3B0aW9uc193cml0ZShwdHIsICZvcHRpb25zKTsKCglt
cHRjcF9vcHRpb25zX3dyaXRlKHRoLCBwdHIsIHRwLCBvcHRzKTsKfQoKc3RhdGljIHZvaWQgc21j
X3NldF9vcHRpb24oY29uc3Qgc3RydWN0IHRjcF9zb2NrICp0cCwKCQkJICAgc3RydWN0IHRjcF9v
dXRfb3B0aW9ucyAqb3B0cywKCQkJICAgdW5zaWduZWQgaW50ICpyZW1haW5pbmcpCnsKI2lmIElT
X0VOQUJMRUQoQ09ORklHX1NNQykKCWlmIChzdGF0aWNfYnJhbmNoX3VubGlrZWx5KCZ0Y3BfaGF2
ZV9zbWMpKSB7CgkJaWYgKHRwLT5zeW5fc21jKSB7CgkJCWlmICgqcmVtYWluaW5nID49IFRDUE9M
RU5fRVhQX1NNQ19CQVNFX0FMSUdORUQpIHsKCQkJCW9wdHMtPm9wdGlvbnMgfD0gT1BUSU9OX1NN
QzsKCQkJCSpyZW1haW5pbmcgLT0gVENQT0xFTl9FWFBfU01DX0JBU0VfQUxJR05FRDsKCQkJfQoJ
CX0KCX0KI2VuZGlmCn0KCnN0YXRpYyB2b2lkIHNtY19zZXRfb3B0aW9uX2NvbmQoY29uc3Qgc3Ry
dWN0IHRjcF9zb2NrICp0cCwKCQkJCWNvbnN0IHN0cnVjdCBpbmV0X3JlcXVlc3Rfc29jayAqaXJl
cSwKCQkJCXN0cnVjdCB0Y3Bfb3V0X29wdGlvbnMgKm9wdHMsCgkJCQl1bnNpZ25lZCBpbnQgKnJl
bWFpbmluZykKewojaWYgSVNfRU5BQkxFRChDT05GSUdfU01DKQoJaWYgKHN0YXRpY19icmFuY2hf
dW5saWtlbHkoJnRjcF9oYXZlX3NtYykpIHsKCQlpZiAodHAtPnN5bl9zbWMgJiYgaXJlcS0+c21j
X29rKSB7CgkJCWlmICgqcmVtYWluaW5nID49IFRDUE9MRU5fRVhQX1NNQ19CQVNFX0FMSUdORUQp
IHsKCQkJCW9wdHMtPm9wdGlvbnMgfD0gT1BUSU9OX1NNQzsKCQkJCSpyZW1haW5pbmcgLT0gVENQ
T0xFTl9FWFBfU01DX0JBU0VfQUxJR05FRDsKCQkJfQoJCX0KCX0KI2VuZGlmCn0KCnN0YXRpYyB2
b2lkIG1wdGNwX3NldF9vcHRpb25fY29uZChjb25zdCBzdHJ1Y3QgcmVxdWVzdF9zb2NrICpyZXEs
CgkJCQkgIHN0cnVjdCB0Y3Bfb3V0X29wdGlvbnMgKm9wdHMsCgkJCQkgIHVuc2lnbmVkIGludCAq
cmVtYWluaW5nKQp7CglpZiAocnNrX2lzX21wdGNwKHJlcSkpIHsKCQl1bnNpZ25lZCBpbnQgc2l6
ZTsKCgkJaWYgKG1wdGNwX3N5bmFja19vcHRpb25zKHJlcSwgJnNpemUsICZvcHRzLT5tcHRjcCkp
IHsKCQkJaWYgKCpyZW1haW5pbmcgPj0gc2l6ZSkgewoJCQkJb3B0cy0+b3B0aW9ucyB8PSBPUFRJ
T05fTVBUQ1A7CgkJCQkqcmVtYWluaW5nIC09IHNpemU7CgkJCX0KCQl9Cgl9Cn0KCi8qIENvbXB1
dGUgVENQIG9wdGlvbnMgZm9yIFNZTiBwYWNrZXRzLiBUaGlzIGlzIG5vdCB0aGUgZmluYWwKICog
bmV0d29yayB3aXJlIGZvcm1hdCB5ZXQuCiAqLwpzdGF0aWMgdW5zaWduZWQgaW50IHRjcF9zeW5f
b3B0aW9ucyhzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBza19idWZmICpza2IsCgkJCQlzdHJ1Y3Qg
dGNwX291dF9vcHRpb25zICpvcHRzLAoJCQkJc3RydWN0IHRjcF9rZXkgKmtleSkKewoJc3RydWN0
IHRjcF9zb2NrICp0cCA9IHRjcF9zayhzayk7Cgl1bnNpZ25lZCBpbnQgcmVtYWluaW5nID0gTUFY
X1RDUF9PUFRJT05fU1BBQ0U7CglzdHJ1Y3QgdGNwX2Zhc3RvcGVuX3JlcXVlc3QgKmZhc3RvcGVu
ID0gdHAtPmZhc3RvcGVuX3JlcTsKCWJvb2wgdGltZXN0YW1wczsKCgkvKiBCZXR0ZXIgdGhhbiBz
d2l0Y2ggKGtleS50eXBlKSBhcyBpdCBoYXMgc3RhdGljIGJyYW5jaGVzICovCglpZiAodGNwX2tl
eV9pc19tZDUoa2V5KSkgewoJCXRpbWVzdGFtcHMgPSBmYWxzZTsKCQlvcHRzLT5vcHRpb25zIHw9
IE9QVElPTl9NRDU7CgkJcmVtYWluaW5nIC09IFRDUE9MRU5fTUQ1U0lHX0FMSUdORUQ7Cgl9IGVs
c2UgewoJCXRpbWVzdGFtcHMgPSBSRUFEX09OQ0Uoc29ja19uZXQoc2spLT5pcHY0LnN5c2N0bF90
Y3BfdGltZXN0YW1wcyk7CgkJaWYgKHRjcF9rZXlfaXNfYW8oa2V5KSkgewoJCQlvcHRzLT5vcHRp
b25zIHw9IE9QVElPTl9BTzsKCQkJcmVtYWluaW5nIC09IHRjcF9hb19sZW5fYWxpZ25lZChrZXkt
PmFvX2tleSk7CgkJfQoJfQoKCS8qIFdlIGFsd2F5cyBnZXQgYW4gTVNTIG9wdGlvbi4gIFRoZSBv
cHRpb24gYnl0ZXMgd2hpY2ggd2lsbCBiZSBzZWVuIGluCgkgKiBub3JtYWwgZGF0YSBwYWNrZXRz
IHNob3VsZCB0aW1lc3RhbXBzIGJlIHVzZWQsIG11c3QgYmUgaW4gdGhlIE1TUwoJICogYWR2ZXJ0
aXNlZC4gIEJ1dCB3ZSBzdWJ0cmFjdCB0aGVtIGZyb20gdHAtPm1zc19jYWNoZSBzbyB0aGF0Cgkg
KiBjYWxjdWxhdGlvbnMgaW4gdGNwX3NlbmRtc2cgYXJlIHNpbXBsZXIgZXRjLiAgU28gYWNjb3Vu
dCBmb3IgdGhpcwoJICogZmFjdCBoZXJlIGlmIG5lY2Vzc2FyeS4gIElmIHdlIGRvbid0IGRvIHRo
aXMgY29ycmVjdGx5LCBhcyBhCgkgKiByZWNlaXZlciB3ZSB3b24ndCByZWNvZ25pemUgZGF0YSBw
YWNrZXRzIGFzIGJlaW5nIGZ1bGwgc2l6ZWQgd2hlbiB3ZQoJICogc2hvdWxkLCBhbmQgdGh1cyB3
ZSB3b24ndCBhYmlkZSBieSB0aGUgZGVsYXllZCBBQ0sgcnVsZXMgY29ycmVjdGx5LgoJICogU0FD
S3MgZG9uJ3QgbWF0dGVyLCB3ZSBuZXZlciBkZWxheSBhbiBBQ0sgd2hlbiB3ZSBoYXZlIGFueSBv
ZiB0aG9zZQoJICogZ29pbmcgb3V0LiAgKi8KCW9wdHMtPm1zcyA9IHRjcF9hZHZlcnRpc2VfbXNz
KHNrKTsKCXJlbWFpbmluZyAtPSBUQ1BPTEVOX01TU19BTElHTkVEOwoKCWlmIChsaWtlbHkodGlt
ZXN0YW1wcykpIHsKCQlvcHRzLT5vcHRpb25zIHw9IE9QVElPTl9UUzsKCQlvcHRzLT50c3ZhbCA9
IHRjcF9za2JfdGltZXN0YW1wX3RzKHRwLT50Y3BfdXNlY190cywgc2tiKSArIHRwLT50c29mZnNl
dDsKCQlvcHRzLT50c2VjciA9IHRwLT5yeF9vcHQudHNfcmVjZW50OwoJCXJlbWFpbmluZyAtPSBU
Q1BPTEVOX1RTVEFNUF9BTElHTkVEOwoJfQoJaWYgKGxpa2VseShSRUFEX09OQ0Uoc29ja19uZXQo
c2spLT5pcHY0LnN5c2N0bF90Y3Bfd2luZG93X3NjYWxpbmcpKSkgewoJCW9wdHMtPndzID0gdHAt
PnJ4X29wdC5yY3Zfd3NjYWxlOwoJCW9wdHMtPm9wdGlvbnMgfD0gT1BUSU9OX1dTQ0FMRTsKCQly
ZW1haW5pbmcgLT0gVENQT0xFTl9XU0NBTEVfQUxJR05FRDsKCX0KCWlmIChsaWtlbHkoUkVBRF9P
TkNFKHNvY2tfbmV0KHNrKS0+aXB2NC5zeXNjdGxfdGNwX3NhY2spKSkgewoJCW9wdHMtPm9wdGlv
bnMgfD0gT1BUSU9OX1NBQ0tfQURWRVJUSVNFOwoJCWlmICh1bmxpa2VseSghKE9QVElPTl9UUyAm
IG9wdHMtPm9wdGlvbnMpKSkKCQkJcmVtYWluaW5nIC09IFRDUE9MRU5fU0FDS1BFUk1fQUxJR05F
RDsKCX0KCglpZiAoZmFzdG9wZW4gJiYgZmFzdG9wZW4tPmNvb2tpZS5sZW4gPj0gMCkgewoJCXUz
MiBuZWVkID0gZmFzdG9wZW4tPmNvb2tpZS5sZW47CgoJCW5lZWQgKz0gZmFzdG9wZW4tPmNvb2tp
ZS5leHAgPyBUQ1BPTEVOX0VYUF9GQVNUT1BFTl9CQVNFIDoKCQkJCQkgICAgICAgVENQT0xFTl9G
QVNUT1BFTl9CQVNFOwoJCW5lZWQgPSAobmVlZCArIDMpICYgfjNVOyAgLyogQWxpZ24gdG8gMzIg
Yml0cyAqLwoJCWlmIChyZW1haW5pbmcgPj0gbmVlZCkgewoJCQlvcHRzLT5vcHRpb25zIHw9IE9Q
VElPTl9GQVNUX09QRU5fQ09PS0lFOwoJCQlvcHRzLT5mYXN0b3Blbl9jb29raWUgPSAmZmFzdG9w
ZW4tPmNvb2tpZTsKCQkJcmVtYWluaW5nIC09IG5lZWQ7CgkJCXRwLT5zeW5fZmFzdG9wZW4gPSAx
OwoJCQl0cC0+c3luX2Zhc3RvcGVuX2V4cCA9IGZhc3RvcGVuLT5jb29raWUuZXhwID8gMSA6IDA7
CgkJfQoJfQoKCXNtY19zZXRfb3B0aW9uKHRwLCBvcHRzLCAmcmVtYWluaW5nKTsKCglpZiAoc2tf
aXNfbXB0Y3Aoc2spKSB7CgkJdW5zaWduZWQgaW50IHNpemU7CgoJCWlmIChtcHRjcF9zeW5fb3B0
aW9ucyhzaywgc2tiLCAmc2l6ZSwgJm9wdHMtPm1wdGNwKSkgewoJCQlvcHRzLT5vcHRpb25zIHw9
IE9QVElPTl9NUFRDUDsKCQkJcmVtYWluaW5nIC09IHNpemU7CgkJfQoJfQoKCWJwZl9za29wc19o
ZHJfb3B0X2xlbihzaywgc2tiLCBOVUxMLCBOVUxMLCAwLCBvcHRzLCAmcmVtYWluaW5nKTsKCgly
ZXR1cm4gTUFYX1RDUF9PUFRJT05fU1BBQ0UgLSByZW1haW5pbmc7Cn0KCi8qIFNldCB1cCBUQ1Ag
b3B0aW9ucyBmb3IgU1lOLUFDS3MuICovCnN0YXRpYyB1bnNpZ25lZCBpbnQgdGNwX3N5bmFja19v
cHRpb25zKGNvbnN0IHN0cnVjdCBzb2NrICpzaywKCQkJCSAgICAgICBzdHJ1Y3QgcmVxdWVzdF9z
b2NrICpyZXEsCgkJCQkgICAgICAgdW5zaWduZWQgaW50IG1zcywgc3RydWN0IHNrX2J1ZmYgKnNr
YiwKCQkJCSAgICAgICBzdHJ1Y3QgdGNwX291dF9vcHRpb25zICpvcHRzLAoJCQkJICAgICAgIGNv
bnN0IHN0cnVjdCB0Y3Bfa2V5ICprZXksCgkJCQkgICAgICAgc3RydWN0IHRjcF9mYXN0b3Blbl9j
b29raWUgKmZvYywKCQkJCSAgICAgICBlbnVtIHRjcF9zeW5hY2tfdHlwZSBzeW5hY2tfdHlwZSwK
CQkJCSAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc3luX3NrYikKewoJc3RydWN0IGluZXRfcmVxdWVz
dF9zb2NrICppcmVxID0gaW5ldF9yc2socmVxKTsKCXVuc2lnbmVkIGludCByZW1haW5pbmcgPSBN
QVhfVENQX09QVElPTl9TUEFDRTsKCglpZiAodGNwX2tleV9pc19tZDUoa2V5KSkgewoJCW9wdHMt
Pm9wdGlvbnMgfD0gT1BUSU9OX01ENTsKCQlyZW1haW5pbmcgLT0gVENQT0xFTl9NRDVTSUdfQUxJ
R05FRDsKCgkJLyogV2UgY2FuJ3QgZml0IGFueSBTQUNLIGJsb2NrcyBpbiBhIHBhY2tldCB3aXRo
IE1ENSArIFRTCgkJICogb3B0aW9ucy4gVGhlcmUgd2FzIGRpc2N1c3Npb24gYWJvdXQgZGlzYWJs
aW5nIFNBQ0sKCQkgKiByYXRoZXIgdGhhbiBUUyBpbiBvcmRlciB0byBmaXQgaW4gYmV0dGVyIHdp
dGggb2xkLAoJCSAqIGJ1Z2d5IGtlcm5lbHMsIGJ1dCB0aGF0IHdhcyBkZWVtZWQgdG8gYmUgdW5u
ZWNlc3NhcnkuCgkJICovCgkJaWYgKHN5bmFja190eXBlICE9IFRDUF9TWU5BQ0tfQ09PS0lFKQoJ
CQlpcmVxLT50c3RhbXBfb2sgJj0gIWlyZXEtPnNhY2tfb2s7Cgl9IGVsc2UgaWYgKHRjcF9rZXlf
aXNfYW8oa2V5KSkgewoJCW9wdHMtPm9wdGlvbnMgfD0gT1BUSU9OX0FPOwoJCXJlbWFpbmluZyAt
PSB0Y3BfYW9fbGVuX2FsaWduZWQoa2V5LT5hb19rZXkpOwoJCWlyZXEtPnRzdGFtcF9vayAmPSAh
aXJlcS0+c2Fja19vazsKCX0KCgkvKiBXZSBhbHdheXMgc2VuZCBhbiBNU1Mgb3B0aW9uLiAqLwoJ
b3B0cy0+bXNzID0gbXNzOwoJcmVtYWluaW5nIC09IFRDUE9MRU5fTVNTX0FMSUdORUQ7CgoJaWYg
KGxpa2VseShpcmVxLT53c2NhbGVfb2spKSB7CgkJb3B0cy0+d3MgPSBpcmVxLT5yY3Zfd3NjYWxl
OwoJCW9wdHMtPm9wdGlvbnMgfD0gT1BUSU9OX1dTQ0FMRTsKCQlyZW1haW5pbmcgLT0gVENQT0xF
Tl9XU0NBTEVfQUxJR05FRDsKCX0KCWlmIChsaWtlbHkoaXJlcS0+dHN0YW1wX29rKSkgewoJCW9w
dHMtPm9wdGlvbnMgfD0gT1BUSU9OX1RTOwoJCW9wdHMtPnRzdmFsID0gdGNwX3NrYl90aW1lc3Rh
bXBfdHModGNwX3JzayhyZXEpLT5yZXFfdXNlY190cywgc2tiKSArCgkJCSAgICAgIHRjcF9yc2so
cmVxKS0+dHNfb2ZmOwoJCW9wdHMtPnRzZWNyID0gUkVBRF9PTkNFKHJlcS0+dHNfcmVjZW50KTsK
CQlyZW1haW5pbmcgLT0gVENQT0xFTl9UU1RBTVBfQUxJR05FRDsKCX0KCWlmIChsaWtlbHkoaXJl
cS0+c2Fja19vaykpIHsKCQlvcHRzLT5vcHRpb25zIHw9IE9QVElPTl9TQUNLX0FEVkVSVElTRTsK
CQlpZiAodW5saWtlbHkoIWlyZXEtPnRzdGFtcF9vaykpCgkJCXJlbWFpbmluZyAtPSBUQ1BPTEVO
X1NBQ0tQRVJNX0FMSUdORUQ7Cgl9CglpZiAoZm9jICE9IE5VTEwgJiYgZm9jLT5sZW4gPj0gMCkg
ewoJCXUzMiBuZWVkID0gZm9jLT5sZW47CgoJCW5lZWQgKz0gZm9jLT5leHAgPyBUQ1BPTEVOX0VY
UF9GQVNUT1BFTl9CQVNFIDoKCQkJCSAgIFRDUE9MRU5fRkFTVE9QRU5fQkFTRTsKCQluZWVkID0g
KG5lZWQgKyAzKSAmIH4zVTsgIC8qIEFsaWduIHRvIDMyIGJpdHMgKi8KCQlpZiAocmVtYWluaW5n
ID49IG5lZWQpIHsKCQkJb3B0cy0+b3B0aW9ucyB8PSBPUFRJT05fRkFTVF9PUEVOX0NPT0tJRTsK
CQkJb3B0cy0+ZmFzdG9wZW5fY29va2llID0gZm9jOwoJCQlyZW1haW5pbmcgLT0gbmVlZDsKCQl9
Cgl9CgoJbXB0Y3Bfc2V0X29wdGlvbl9jb25kKHJlcSwgb3B0cywgJnJlbWFpbmluZyk7CgoJc21j
X3NldF9vcHRpb25fY29uZCh0Y3Bfc2soc2spLCBpcmVxLCBvcHRzLCAmcmVtYWluaW5nKTsKCgli
cGZfc2tvcHNfaGRyX29wdF9sZW4oKHN0cnVjdCBzb2NrICopc2ssIHNrYiwgcmVxLCBzeW5fc2ti
LAoJCQkgICAgICBzeW5hY2tfdHlwZSwgb3B0cywgJnJlbWFpbmluZyk7CgoJcmV0dXJuIE1BWF9U
Q1BfT1BUSU9OX1NQQUNFIC0gcmVtYWluaW5nOwp9CgovKiBDb21wdXRlIFRDUCBvcHRpb25zIGZv
ciBFU1RBQkxJU0hFRCBzb2NrZXRzLiBUaGlzIGlzIG5vdCB0aGUKICogZmluYWwgd2lyZSBmb3Jt
YXQgeWV0LgogKi8Kc3RhdGljIHVuc2lnbmVkIGludCB0Y3BfZXN0YWJsaXNoZWRfb3B0aW9ucyhz
dHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBza19idWZmICpza2IsCgkJCQkJc3RydWN0IHRjcF9vdXRf
b3B0aW9ucyAqb3B0cywKCQkJCQlzdHJ1Y3QgdGNwX2tleSAqa2V5KQp7CglzdHJ1Y3QgdGNwX3Nv
Y2sgKnRwID0gdGNwX3NrKHNrKTsKCXVuc2lnbmVkIGludCBzaXplID0gMDsKCXVuc2lnbmVkIGlu
dCBlZmZfc2Fja3M7CgoJb3B0cy0+b3B0aW9ucyA9IDA7CgoJLyogQmV0dGVyIHRoYW4gc3dpdGNo
IChrZXkudHlwZSkgYXMgaXQgaGFzIHN0YXRpYyBicmFuY2hlcyAqLwoJaWYgKHRjcF9rZXlfaXNf
bWQ1KGtleSkpIHsKCQlvcHRzLT5vcHRpb25zIHw9IE9QVElPTl9NRDU7CgkJc2l6ZSArPSBUQ1BP
TEVOX01ENVNJR19BTElHTkVEOwoJfSBlbHNlIGlmICh0Y3Bfa2V5X2lzX2FvKGtleSkpIHsKCQlv
cHRzLT5vcHRpb25zIHw9IE9QVElPTl9BTzsKCQlzaXplICs9IHRjcF9hb19sZW5fYWxpZ25lZChr
ZXktPmFvX2tleSk7Cgl9CgoJaWYgKGxpa2VseSh0cC0+cnhfb3B0LnRzdGFtcF9vaykpIHsKCQlv
cHRzLT5vcHRpb25zIHw9IE9QVElPTl9UUzsKCQlvcHRzLT50c3ZhbCA9IHNrYiA/IHRjcF9za2Jf
dGltZXN0YW1wX3RzKHRwLT50Y3BfdXNlY190cywgc2tiKSArCgkJCQl0cC0+dHNvZmZzZXQgOiAw
OwoJCW9wdHMtPnRzZWNyID0gdHAtPnJ4X29wdC50c19yZWNlbnQ7CgkJc2l6ZSArPSBUQ1BPTEVO
X1RTVEFNUF9BTElHTkVEOwoJfQoKCS8qIE1QVENQIG9wdGlvbnMgaGF2ZSBwcmVjZWRlbmNlIG92
ZXIgU0FDSyBmb3IgdGhlIGxpbWl0ZWQgVENQCgkgKiBvcHRpb24gc3BhY2UgYmVjYXVzZSBhIE1Q
VENQIGNvbm5lY3Rpb24gd291bGQgYmUgZm9yY2VkIHRvCgkgKiBmYWxsIGJhY2sgdG8gcmVndWxh
ciBUQ1AgaWYgYSByZXF1aXJlZCBtdWx0aXBhdGggb3B0aW9uIGlzCgkgKiBtaXNzaW5nLiBTQUNL
IHN0aWxsIGdldHMgYSBjaGFuY2UgdG8gdXNlIHdoYXRldmVyIHNwYWNlIGlzCgkgKiBsZWZ0LgoJ
ICovCglpZiAoc2tfaXNfbXB0Y3Aoc2spKSB7CgkJdW5zaWduZWQgaW50IHJlbWFpbmluZyA9IE1B
WF9UQ1BfT1BUSU9OX1NQQUNFIC0gc2l6ZTsKCQl1bnNpZ25lZCBpbnQgb3B0X3NpemUgPSAwOwoK
CQlpZiAobXB0Y3BfZXN0YWJsaXNoZWRfb3B0aW9ucyhzaywgc2tiLCAmb3B0X3NpemUsIHJlbWFp
bmluZywKCQkJCQkgICAgICAmb3B0cy0+bXB0Y3ApKSB7CgkJCW9wdHMtPm9wdGlvbnMgfD0gT1BU
SU9OX01QVENQOwoJCQlzaXplICs9IG9wdF9zaXplOwoJCX0KCX0KCgllZmZfc2Fja3MgPSB0cC0+
cnhfb3B0Lm51bV9zYWNrcyArIHRwLT5yeF9vcHQuZHNhY2s7CglpZiAodW5saWtlbHkoZWZmX3Nh
Y2tzKSkgewoJCWNvbnN0IHVuc2lnbmVkIGludCByZW1haW5pbmcgPSBNQVhfVENQX09QVElPTl9T
UEFDRSAtIHNpemU7CgkJaWYgKHVubGlrZWx5KHJlbWFpbmluZyA8IFRDUE9MRU5fU0FDS19CQVNF
X0FMSUdORUQgKwoJCQkJCSBUQ1BPTEVOX1NBQ0tfUEVSQkxPQ0spKQoJCQlyZXR1cm4gc2l6ZTsK
CgkJb3B0cy0+bnVtX3NhY2tfYmxvY2tzID0KCQkJbWluX3QodW5zaWduZWQgaW50LCBlZmZfc2Fj
a3MsCgkJCSAgICAgIChyZW1haW5pbmcgLSBUQ1BPTEVOX1NBQ0tfQkFTRV9BTElHTkVEKSAvCgkJ
CSAgICAgIFRDUE9MRU5fU0FDS19QRVJCTE9DSyk7CgoJCXNpemUgKz0gVENQT0xFTl9TQUNLX0JB
U0VfQUxJR05FRCArCgkJCW9wdHMtPm51bV9zYWNrX2Jsb2NrcyAqIFRDUE9MRU5fU0FDS19QRVJC
TE9DSzsKCX0KCglpZiAodW5saWtlbHkoQlBGX1NPQ0tfT1BTX1RFU1RfRkxBRyh0cCwKCQkJCQkg
ICAgQlBGX1NPQ0tfT1BTX1dSSVRFX0hEUl9PUFRfQ0JfRkxBRykpKSB7CgkJdW5zaWduZWQgaW50
IHJlbWFpbmluZyA9IE1BWF9UQ1BfT1BUSU9OX1NQQUNFIC0gc2l6ZTsKCgkJYnBmX3Nrb3BzX2hk
cl9vcHRfbGVuKHNrLCBza2IsIE5VTEwsIE5VTEwsIDAsIG9wdHMsICZyZW1haW5pbmcpOwoKCQlz
aXplID0gTUFYX1RDUF9PUFRJT05fU1BBQ0UgLSByZW1haW5pbmc7Cgl9CgoJcmV0dXJuIHNpemU7
Cn0KCgovKiBUQ1AgU01BTEwgUVVFVUVTIChUU1EpCiAqCiAqIFRTUSBnb2FsIGlzIHRvIGtlZXAg
c21hbGwgYW1vdW50IG9mIHNrYnMgcGVyIHRjcCBmbG93IGluIHR4IHF1ZXVlcyAocWRpc2MrZGV2
KQogKiB0byByZWR1Y2UgUlRUIGFuZCBidWZmZXJibG9hdC4KICogV2UgZG8gdGhpcyB1c2luZyBh
IHNwZWNpYWwgc2tiIGRlc3RydWN0b3IgKHRjcF93ZnJlZSkuCiAqCiAqIEl0cyBpbXBvcnRhbnQg
dGNwX3dmcmVlKCkgY2FuIGJlIHJlcGxhY2VkIGJ5IHNvY2tfd2ZyZWUoKSBpbiB0aGUgZXZlbnQg
c2tiCiAqIG5lZWRzIHRvIGJlIHJlYWxsb2NhdGVkIGluIGEgZHJpdmVyLgogKiBUaGUgaW52YXJp
YW50IGJlaW5nIHNrYi0+dHJ1ZXNpemUgc3VidHJhY3RlZCBmcm9tIHNrLT5za193bWVtX2FsbG9j
CiAqCiAqIFNpbmNlIHRyYW5zbWl0IGZyb20gc2tiIGRlc3RydWN0b3IgaXMgZm9yYmlkZGVuLCB3
ZSB1c2UgYSB0YXNrbGV0CiAqIHRvIHByb2Nlc3MgYWxsIHNvY2tldHMgdGhhdCBldmVudHVhbGx5
IG5lZWQgdG8gc2VuZCBtb3JlIHNrYnMuCiAqIFdlIHVzZSBvbmUgdGFza2xldCBwZXIgY3B1LCB3
aXRoIGl0cyBvd24gcXVldWUgb2Ygc29ja2V0cy4KICovCnN0cnVjdCB0c3FfdGFza2xldCB7Cglz
dHJ1Y3QgdGFza2xldF9zdHJ1Y3QJdGFza2xldDsKCXN0cnVjdCBsaXN0X2hlYWQJaGVhZDsgLyog
cXVldWUgb2YgdGNwIHNvY2tldHMgKi8KfTsKc3RhdGljIERFRklORV9QRVJfQ1BVKHN0cnVjdCB0
c3FfdGFza2xldCwgdHNxX3Rhc2tsZXQpOwoKc3RhdGljIHZvaWQgdGNwX3RzcV93cml0ZShzdHJ1
Y3Qgc29jayAqc2spCnsKCWlmICgoMSA8PCBzay0+c2tfc3RhdGUpICYKCSAgICAoVENQRl9FU1RB
QkxJU0hFRCB8IFRDUEZfRklOX1dBSVQxIHwgVENQRl9DTE9TSU5HIHwKCSAgICAgVENQRl9DTE9T
RV9XQUlUICB8IFRDUEZfTEFTVF9BQ0spKSB7CgkJc3RydWN0IHRjcF9zb2NrICp0cCA9IHRjcF9z
ayhzayk7CgoJCWlmICh0cC0+bG9zdF9vdXQgPiB0cC0+cmV0cmFuc19vdXQgJiYKCQkgICAgdGNw
X3NuZF9jd25kKHRwKSA+IHRjcF9wYWNrZXRzX2luX2ZsaWdodCh0cCkpIHsKCQkJdGNwX21zdGFt
cF9yZWZyZXNoKHRwKTsKCQkJdGNwX3htaXRfcmV0cmFuc21pdF9xdWV1ZShzayk7CgkJfQoKCQl0
Y3Bfd3JpdGVfeG1pdChzaywgdGNwX2N1cnJlbnRfbXNzKHNrKSwgdHAtPm5vbmFnbGUsCgkJCSAg
ICAgICAwLCBHRlBfQVRPTUlDKTsKCX0KfQoKc3RhdGljIHZvaWQgdGNwX3RzcV9oYW5kbGVyKHN0
cnVjdCBzb2NrICpzaykKewoJYmhfbG9ja19zb2NrKHNrKTsKCWlmICghc29ja19vd25lZF9ieV91
c2VyKHNrKSkKCQl0Y3BfdHNxX3dyaXRlKHNrKTsKCWVsc2UgaWYgKCF0ZXN0X2FuZF9zZXRfYml0
KFRDUF9UU1FfREVGRVJSRUQsICZzay0+c2tfdHNxX2ZsYWdzKSkKCQlzb2NrX2hvbGQoc2spOwoJ
YmhfdW5sb2NrX3NvY2soc2spOwp9Ci8qCiAqIE9uZSB0YXNrbGV0IHBlciBjcHUgdHJpZXMgdG8g
c2VuZCBtb3JlIHNrYnMuCiAqIFdlIHJ1biBpbiB0YXNrbGV0IGNvbnRleHQgYnV0IG5lZWQgdG8g
ZGlzYWJsZSBpcnFzIHdoZW4KICogdHJhbnNmZXJyaW5nIHRzcS0+aGVhZCBiZWNhdXNlIHRjcF93
ZnJlZSgpIG1pZ2h0CiAqIGludGVycnVwdCB1cyAobm9uIE5BUEkgZHJpdmVycykKICovCnN0YXRp
YyB2b2lkIHRjcF90YXNrbGV0X2Z1bmMoc3RydWN0IHRhc2tsZXRfc3RydWN0ICp0KQp7CglzdHJ1
Y3QgdHNxX3Rhc2tsZXQgKnRzcSA9IGZyb21fdGFza2xldCh0c3EsICB0LCB0YXNrbGV0KTsKCUxJ
U1RfSEVBRChsaXN0KTsKCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CglzdHJ1Y3QgbGlzdF9oZWFkICpx
LCAqbjsKCXN0cnVjdCB0Y3Bfc29jayAqdHA7CglzdHJ1Y3Qgc29jayAqc2s7CgoJbG9jYWxfaXJx
X3NhdmUoZmxhZ3MpOwoJbGlzdF9zcGxpY2VfaW5pdCgmdHNxLT5oZWFkLCAmbGlzdCk7Cglsb2Nh
bF9pcnFfcmVzdG9yZShmbGFncyk7CgoJbGlzdF9mb3JfZWFjaF9zYWZlKHEsIG4sICZsaXN0KSB7
CgkJdHAgPSBsaXN0X2VudHJ5KHEsIHN0cnVjdCB0Y3Bfc29jaywgdHNxX25vZGUpOwoJCWxpc3Rf
ZGVsKCZ0cC0+dHNxX25vZGUpOwoKCQlzayA9IChzdHJ1Y3Qgc29jayAqKXRwOwoJCXNtcF9tYl9f
YmVmb3JlX2F0b21pYygpOwoJCWNsZWFyX2JpdChUU1FfUVVFVUVELCAmc2stPnNrX3RzcV9mbGFn
cyk7CgoJCXRjcF90c3FfaGFuZGxlcihzayk7CgkJc2tfZnJlZShzayk7Cgl9Cn0KCiNkZWZpbmUg
VENQX0RFRkVSUkVEX0FMTCAoVENQRl9UU1FfREVGRVJSRUQgfAkJXAoJCQkgIFRDUEZfV1JJVEVf
VElNRVJfREVGRVJSRUQgfAlcCgkJCSAgVENQRl9ERUxBQ0tfVElNRVJfREVGRVJSRUQgfAlcCgkJ
CSAgVENQRl9NVFVfUkVEVUNFRF9ERUZFUlJFRCB8CVwKCQkJICBUQ1BGX0FDS19ERUZFUlJFRCkK
LyoqCiAqIHRjcF9yZWxlYXNlX2NiIC0gdGNwIHJlbGVhc2Vfc29jaygpIGNhbGxiYWNrCiAqIEBz
azogc29ja2V0CiAqCiAqIGNhbGxlZCBmcm9tIHJlbGVhc2Vfc29jaygpIHRvIHBlcmZvcm0gcHJv
dG9jb2wgZGVwZW5kZW50CiAqIGFjdGlvbnMgYmVmb3JlIHNvY2tldCByZWxlYXNlLgogKi8Kdm9p
ZCB0Y3BfcmVsZWFzZV9jYihzdHJ1Y3Qgc29jayAqc2spCnsKCXVuc2lnbmVkIGxvbmcgZmxhZ3Mg
PSBzbXBfbG9hZF9hY3F1aXJlKCZzay0+c2tfdHNxX2ZsYWdzKTsKCXVuc2lnbmVkIGxvbmcgbmZs
YWdzOwoKCS8qIHBlcmZvcm0gYW4gYXRvbWljIG9wZXJhdGlvbiBvbmx5IGlmIGF0IGxlYXN0IG9u
ZSBmbGFnIGlzIHNldCAqLwoJZG8gewoJCWlmICghKGZsYWdzICYgVENQX0RFRkVSUkVEX0FMTCkp
CgkJCXJldHVybjsKCQluZmxhZ3MgPSBmbGFncyAmIH5UQ1BfREVGRVJSRURfQUxMOwoJfSB3aGls
ZSAoIXRyeV9jbXB4Y2hnKCZzay0+c2tfdHNxX2ZsYWdzLCAmZmxhZ3MsIG5mbGFncykpOwoKCWlm
IChmbGFncyAmIFRDUEZfVFNRX0RFRkVSUkVEKSB7CgkJdGNwX3RzcV93cml0ZShzayk7CgkJX19z
b2NrX3B1dChzayk7Cgl9CgoJaWYgKGZsYWdzICYgVENQRl9XUklURV9USU1FUl9ERUZFUlJFRCkg
ewoJCXRjcF93cml0ZV90aW1lcl9oYW5kbGVyKHNrKTsKCQlfX3NvY2tfcHV0KHNrKTsKCX0KCWlm
IChmbGFncyAmIFRDUEZfREVMQUNLX1RJTUVSX0RFRkVSUkVEKSB7CgkJdGNwX2RlbGFja190aW1l
cl9oYW5kbGVyKHNrKTsKCQlfX3NvY2tfcHV0KHNrKTsKCX0KCWlmIChmbGFncyAmIFRDUEZfTVRV
X1JFRFVDRURfREVGRVJSRUQpIHsKCQlpbmV0X2NzayhzayktPmljc2tfYWZfb3BzLT5tdHVfcmVk
dWNlZChzayk7CgkJX19zb2NrX3B1dChzayk7Cgl9CglpZiAoKGZsYWdzICYgVENQRl9BQ0tfREVG
RVJSRUQpICYmIGluZXRfY3NrX2Fja19zY2hlZHVsZWQoc2spKQoJCXRjcF9zZW5kX2Fjayhzayk7
Cn0KRVhQT1JUX1NZTUJPTCh0Y3BfcmVsZWFzZV9jYik7Cgp2b2lkIF9faW5pdCB0Y3BfdGFza2xl
dF9pbml0KHZvaWQpCnsKCWludCBpOwoKCWZvcl9lYWNoX3Bvc3NpYmxlX2NwdShpKSB7CgkJc3Ry
dWN0IHRzcV90YXNrbGV0ICp0c3EgPSAmcGVyX2NwdSh0c3FfdGFza2xldCwgaSk7CgoJCUlOSVRf
TElTVF9IRUFEKCZ0c3EtPmhlYWQpOwoJCXRhc2tsZXRfc2V0dXAoJnRzcS0+dGFza2xldCwgdGNw
X3Rhc2tsZXRfZnVuYyk7Cgl9Cn0KCi8qCiAqIFdyaXRlIGJ1ZmZlciBkZXN0cnVjdG9yIGF1dG9t
YXRpY2FsbHkgY2FsbGVkIGZyb20ga2ZyZWVfc2tiLgogKiBXZSBjYW4ndCB4bWl0IG5ldyBza2Jz
IGZyb20gdGhpcyBjb250ZXh0LCBhcyB3ZSBtaWdodCBhbHJlYWR5CiAqIGhvbGQgcWRpc2MgbG9j
ay4KICovCnZvaWQgdGNwX3dmcmVlKHN0cnVjdCBza19idWZmICpza2IpCnsKCXN0cnVjdCBzb2Nr
ICpzayA9IHNrYi0+c2s7CglzdHJ1Y3QgdGNwX3NvY2sgKnRwID0gdGNwX3NrKHNrKTsKCXVuc2ln
bmVkIGxvbmcgZmxhZ3MsIG52YWwsIG92YWw7CglzdHJ1Y3QgdHNxX3Rhc2tsZXQgKnRzcTsKCWJv
b2wgZW1wdHk7CgoJLyogS2VlcCBvbmUgcmVmZXJlbmNlIG9uIHNrX3dtZW1fYWxsb2MuCgkgKiBX
aWxsIGJlIHJlbGVhc2VkIGJ5IHNrX2ZyZWUoKSBmcm9tIGhlcmUgb3IgdGNwX3Rhc2tsZXRfZnVu
YygpCgkgKi8KCVdBUk5fT04ocmVmY291bnRfc3ViX2FuZF90ZXN0KHNrYi0+dHJ1ZXNpemUgLSAx
LCAmc2stPnNrX3dtZW1fYWxsb2MpKTsKCgkvKiBJZiB0aGlzIHNvZnRpcnEgaXMgc2VydmljZWQg
Ynkga3NvZnRpcnFkLCB3ZSBhcmUgbGlrZWx5IHVuZGVyIHN0cmVzcy4KCSAqIFdhaXQgdW50aWwg
b3VyIHF1ZXVlcyAocWRpc2MgKyBkZXZpY2VzKSBhcmUgZHJhaW5lZC4KCSAqIFRoaXMgZ2l2ZXMg
OgoJICogLSBsZXNzIGNhbGxiYWNrcyB0byB0Y3Bfd3JpdGVfeG1pdCgpLCByZWR1Y2luZyBzdHJl
c3MgKGJhdGNoZXMpCgkgKiAtIGNoYW5jZSBmb3IgaW5jb21pbmcgQUNLIChwcm9jZXNzZWQgYnkg
YW5vdGhlciBjcHUgbWF5YmUpCgkgKiAgIHRvIG1pZ3JhdGUgdGhpcyBmbG93IChza2ItPm9vb19v
a2F5IHdpbGwgYmUgZXZlbnR1YWxseSBzZXQpCgkgKi8KCWlmIChyZWZjb3VudF9yZWFkKCZzay0+
c2tfd21lbV9hbGxvYykgPj0gU0tCX1RSVUVTSVpFKDEpICYmIHRoaXNfY3B1X2tzb2Z0aXJxZCgp
ID09IGN1cnJlbnQpCgkJZ290byBvdXQ7CgoJb3ZhbCA9IHNtcF9sb2FkX2FjcXVpcmUoJnNrLT5z
a190c3FfZmxhZ3MpOwoJZG8gewoJCWlmICghKG92YWwgJiBUU1FGX1RIUk9UVExFRCkgfHwgKG92
YWwgJiBUU1FGX1FVRVVFRCkpCgkJCWdvdG8gb3V0OwoKCQludmFsID0gKG92YWwgJiB+VFNRRl9U
SFJPVFRMRUQpIHwgVFNRRl9RVUVVRUQ7Cgl9IHdoaWxlICghdHJ5X2NtcHhjaGcoJnNrLT5za190
c3FfZmxhZ3MsICZvdmFsLCBudmFsKSk7CgoJLyogcXVldWUgdGhpcyBzb2NrZXQgdG8gdGFza2xl
dCBxdWV1ZSAqLwoJbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOwoJdHNxID0gdGhpc19jcHVfcHRyKCZ0
c3FfdGFza2xldCk7CgllbXB0eSA9IGxpc3RfZW1wdHkoJnRzcS0+aGVhZCk7CglsaXN0X2FkZCgm
dHAtPnRzcV9ub2RlLCAmdHNxLT5oZWFkKTsKCWlmIChlbXB0eSkKCQl0YXNrbGV0X3NjaGVkdWxl
KCZ0c3EtPnRhc2tsZXQpOwoJbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOwoJcmV0dXJuOwpvdXQ6
Cglza19mcmVlKHNrKTsKfQoKLyogTm90ZTogQ2FsbGVkIHVuZGVyIHNvZnQgaXJxLgogKiBXZSBj
YW4gY2FsbCBUQ1Agc3RhY2sgcmlnaHQgYXdheSwgdW5sZXNzIHNvY2tldCBpcyBvd25lZCBieSB1
c2VyLgogKi8KZW51bSBocnRpbWVyX3Jlc3RhcnQgdGNwX3BhY2Vfa2ljayhzdHJ1Y3QgaHJ0aW1l
ciAqdGltZXIpCnsKCXN0cnVjdCB0Y3Bfc29jayAqdHAgPSBjb250YWluZXJfb2YodGltZXIsIHN0
cnVjdCB0Y3Bfc29jaywgcGFjaW5nX3RpbWVyKTsKCXN0cnVjdCBzb2NrICpzayA9IChzdHJ1Y3Qg
c29jayAqKXRwOwoKCXRjcF90c3FfaGFuZGxlcihzayk7Cglzb2NrX3B1dChzayk7CgoJcmV0dXJu
IEhSVElNRVJfTk9SRVNUQVJUOwp9CgpzdGF0aWMgdm9pZCB0Y3BfdXBkYXRlX3NrYl9hZnRlcl9z
ZW5kKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYgKnNrYiwKCQkJCSAgICAgIHU2NCBw
cmlvcl93c3RhbXApCnsKCXN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOwoKCWlmIChz
ay0+c2tfcGFjaW5nX3N0YXR1cyAhPSBTS19QQUNJTkdfTk9ORSkgewoJCXVuc2lnbmVkIGxvbmcg
cmF0ZSA9IFJFQURfT05DRShzay0+c2tfcGFjaW5nX3JhdGUpOwoKCQkvKiBPcmlnaW5hbCBzY2hf
ZnEgZG9lcyBub3QgcGFjZSBmaXJzdCAxMCBNU1MKCQkgKiBOb3RlIHRoYXQgdHAtPmRhdGFfc2Vn
c19vdXQgb3ZlcmZsb3dzIGFmdGVyIDJeMzIgcGFja2V0cywKCQkgKiB0aGlzIGlzIGEgbWlub3Ig
YW5ub3lhbmNlLgoJCSAqLwoJCWlmIChyYXRlICE9IH4wVUwgJiYgcmF0ZSAmJiB0cC0+ZGF0YV9z
ZWdzX291dCA+PSAxMCkgewoJCQl1NjQgbGVuX25zID0gZGl2NjRfdWwoKHU2NClza2ItPmxlbiAq
IE5TRUNfUEVSX1NFQywgcmF0ZSk7CgkJCXU2NCBjcmVkaXQgPSB0cC0+dGNwX3dzdGFtcF9ucyAt
IHByaW9yX3dzdGFtcDsKCgkJCS8qIHRha2UgaW50byBhY2NvdW50IE9TIGppdHRlciAqLwoJCQls
ZW5fbnMgLT0gbWluX3QodTY0LCBsZW5fbnMgLyAyLCBjcmVkaXQpOwoJCQl0cC0+dGNwX3dzdGFt
cF9ucyArPSBsZW5fbnM7CgkJfQoJfQoJbGlzdF9tb3ZlX3RhaWwoJnNrYi0+dGNwX3Rzb3J0ZWRf
YW5jaG9yLCAmdHAtPnRzb3J0ZWRfc2VudF9xdWV1ZSk7CgoJcHJpbnRrKEtFUk5fSU5GTyAiUGt0
IHNlbmRpbmcuIHQ9JWxsdSBTcG9ydD0ldSBjd25kPSV1IGluZmxpZ2h0PSV1IFJUVD0ldSBuZXh0
U2VxPSV1IiwKCSB0Y3Bfc2soc2spLT50Y3BfbXN0YW1wLCBpbmV0X3NrKHNrKS0+aW5ldF9zcG9y
dCwgdHAtPnNuZF9jd25kLCB0Y3BfcGFja2V0c19pbl9mbGlnaHQodHApLCAodHAtPnNydHRfdXMg
Pj4gMyksIHRwLT5zbmRfbnh0KTsKfQoKSU5ESVJFQ1RfQ0FMTEFCTEVfREVDTEFSRShpbnQgaXBf
cXVldWVfeG1pdChzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBm
bG93aSAqZmwpKTsKSU5ESVJFQ1RfQ0FMTEFCTEVfREVDTEFSRShpbnQgaW5ldDZfY3NrX3htaXQo
c3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgZmxvd2kgKmZsKSk7
CklORElSRUNUX0NBTExBQkxFX0RFQ0xBUkUodm9pZCB0Y3BfdjRfc2VuZF9jaGVjayhzdHJ1Y3Qg
c29jayAqc2ssIHN0cnVjdCBza19idWZmICpza2IpKTsKCi8qIFRoaXMgcm91dGluZSBhY3R1YWxs
eSB0cmFuc21pdHMgVENQIHBhY2tldHMgcXVldWVkIGluIGJ5CiAqIHRjcF9kb19zZW5kbXNnKCku
ICBUaGlzIGlzIHVzZWQgYnkgYm90aCB0aGUgaW5pdGlhbAogKiB0cmFuc21pc3Npb24gYW5kIHBv
c3NpYmxlIGxhdGVyIHJldHJhbnNtaXNzaW9ucy4KICogQWxsIFNLQidzIHNlZW4gaGVyZSBhcmUg
Y29tcGxldGVseSBoZWFkZXJsZXNzLiAgSXQgaXMgb3VyCiAqIGpvYiB0byBidWlsZCB0aGUgVENQ
IGhlYWRlciwgYW5kIHBhc3MgdGhlIHBhY2tldCBkb3duIHRvCiAqIElQIHNvIGl0IGNhbiBkbyB0
aGUgc2FtZSBwbHVzIHBhc3MgdGhlIHBhY2tldCBvZmYgdG8gdGhlCiAqIGRldmljZS4KICoKICog
V2UgYXJlIHdvcmtpbmcgaGVyZSB3aXRoIGVpdGhlciBhIGNsb25lIG9mIHRoZSBvcmlnaW5hbAog
KiBTS0IsIG9yIGEgZnJlc2ggdW5pcXVlIGNvcHkgbWFkZSBieSB0aGUgcmV0cmFuc21pdCBlbmdp
bmUuCiAqLwpzdGF0aWMgaW50IF9fdGNwX3RyYW5zbWl0X3NrYihzdHJ1Y3Qgc29jayAqc2ssIHN0
cnVjdCBza19idWZmICpza2IsCgkJCSAgICAgIGludCBjbG9uZV9pdCwgZ2ZwX3QgZ2ZwX21hc2ss
IHUzMiByY3Zfbnh0KQp7Cgljb25zdCBzdHJ1Y3QgaW5ldF9jb25uZWN0aW9uX3NvY2sgKmljc2sg
PSBpbmV0X2Nzayhzayk7CglzdHJ1Y3QgaW5ldF9zb2NrICppbmV0OwoJc3RydWN0IHRjcF9zb2Nr
ICp0cDsKCXN0cnVjdCB0Y3Bfc2tiX2NiICp0Y2I7CglzdHJ1Y3QgdGNwX291dF9vcHRpb25zIG9w
dHM7Cgl1bnNpZ25lZCBpbnQgdGNwX29wdGlvbnNfc2l6ZSwgdGNwX2hlYWRlcl9zaXplOwoJc3Ry
dWN0IHNrX2J1ZmYgKm9za2IgPSBOVUxMOwoJc3RydWN0IHRjcF9rZXkga2V5OwoJc3RydWN0IHRj
cGhkciAqdGg7Cgl1NjQgcHJpb3Jfd3N0YW1wOwoJaW50IGVycjsKCglCVUdfT04oIXNrYiB8fCAh
dGNwX3NrYl9wY291bnQoc2tiKSk7Cgl0cCA9IHRjcF9zayhzayk7Cglwcmlvcl93c3RhbXAgPSB0
cC0+dGNwX3dzdGFtcF9uczsKCXRwLT50Y3Bfd3N0YW1wX25zID0gbWF4KHRwLT50Y3Bfd3N0YW1w
X25zLCB0cC0+dGNwX2Nsb2NrX2NhY2hlKTsKCXNrYl9zZXRfZGVsaXZlcnlfdGltZShza2IsIHRw
LT50Y3Bfd3N0YW1wX25zLCB0cnVlKTsKCWlmIChjbG9uZV9pdCkgewoJCW9za2IgPSBza2I7CgoJ
CXRjcF9za2JfdHNvcnRlZF9zYXZlKG9za2IpIHsKCQkJaWYgKHVubGlrZWx5KHNrYl9jbG9uZWQo
b3NrYikpKQoJCQkJc2tiID0gcHNrYl9jb3B5KG9za2IsIGdmcF9tYXNrKTsKCQkJZWxzZQoJCQkJ
c2tiID0gc2tiX2Nsb25lKG9za2IsIGdmcF9tYXNrKTsKCQl9IHRjcF9za2JfdHNvcnRlZF9yZXN0
b3JlKG9za2IpOwoKCQlpZiAodW5saWtlbHkoIXNrYikpCgkJCXJldHVybiAtRU5PQlVGUzsKCQkv
KiByZXRyYW5zbWl0IHNrYnMgbWlnaHQgaGF2ZSBhIG5vbiB6ZXJvIHZhbHVlIGluIHNrYi0+ZGV2
CgkJICogYmVjYXVzZSBza2ItPmRldiBpcyBhbGlhc2VkIHdpdGggc2tiLT5yYm5vZGUucmJfbGVm
dAoJCSAqLwoJCXNrYi0+ZGV2ID0gTlVMTDsKCX0KCglpbmV0ID0gaW5ldF9zayhzayk7Cgl0Y2Ig
PSBUQ1BfU0tCX0NCKHNrYik7CgltZW1zZXQoJm9wdHMsIDAsIHNpemVvZihvcHRzKSk7CgoJdGNw
X2dldF9jdXJyZW50X2tleShzaywgJmtleSk7CglpZiAodW5saWtlbHkodGNiLT50Y3BfZmxhZ3Mg
JiBUQ1BIRFJfU1lOKSkgewoJCXRjcF9vcHRpb25zX3NpemUgPSB0Y3Bfc3luX29wdGlvbnMoc2ss
IHNrYiwgJm9wdHMsICZrZXkpOwoJfSBlbHNlIHsKCQl0Y3Bfb3B0aW9uc19zaXplID0gdGNwX2Vz
dGFibGlzaGVkX29wdGlvbnMoc2ssIHNrYiwgJm9wdHMsICZrZXkpOwoJCS8qIEZvcmNlIGEgUFNI
IGZsYWcgb24gYWxsIChHU08pIHBhY2tldHMgdG8gZXhwZWRpdGUgR1JPIGZsdXNoCgkJICogYXQg
cmVjZWl2ZXIgOiBUaGlzIHNsaWdodGx5IGltcHJvdmUgR1JPIHBlcmZvcm1hbmNlLgoJCSAqIE5v
dGUgdGhhdCB3ZSBkbyBub3QgZm9yY2UgdGhlIFBTSCBmbGFnIGZvciBub24gR1NPIHBhY2tldHMs
CgkJICogYmVjYXVzZSB0aGV5IG1pZ2h0IGJlIHNlbnQgdW5kZXIgaGlnaCBjb25nZXN0aW9uIGV2
ZW50cywKCQkgKiBhbmQgaW4gdGhpcyBjYXNlIGl0IGlzIGJldHRlciB0byBkZWxheSB0aGUgZGVs
aXZlcnkgb2YgMS1NU1MKCQkgKiBwYWNrZXRzIGFuZCB0aHVzIHRoZSBjb3JyZXNwb25kaW5nIEFD
SyBwYWNrZXQgdGhhdCB3b3VsZAoJCSAqIHJlbGVhc2UgdGhlIGZvbGxvd2luZyBwYWNrZXQuCgkJ
ICovCgkJaWYgKHRjcF9za2JfcGNvdW50KHNrYikgPiAxKQoJCQl0Y2ItPnRjcF9mbGFncyB8PSBU
Q1BIRFJfUFNIOwoJfQoJdGNwX2hlYWRlcl9zaXplID0gdGNwX29wdGlvbnNfc2l6ZSArIHNpemVv
ZihzdHJ1Y3QgdGNwaGRyKTsKCgkvKiBXZSBzZXQgc2tiLT5vb29fb2theSB0byBvbmUgaWYgdGhp
cyBwYWNrZXQgY2FuIHNlbGVjdAoJICogYSBkaWZmZXJlbnQgVFggcXVldWUgdGhhbiBwcmlvciBw
YWNrZXRzIG9mIHRoaXMgZmxvdywKCSAqIHRvIGF2b2lkIHNlbGYgaW5mbGljdGVkIHJlb3JkZXJz
LgoJICogVGhlICdvdGhlcicgcXVldWUgZGVjaXNpb24gaXMgYmFzZWQgb24gY3VycmVudCBjcHUg
bnVtYmVyCgkgKiBpZiBYUFMgaXMgZW5hYmxlZCwgb3Igc2stPnNrX3R4aGFzaCBvdGhlcndpc2Uu
CgkgKiBXZSBjYW4gc3dpdGNoIHRvIGFub3RoZXIgKGFuZCBiZXR0ZXIpIHF1ZXVlIGlmOgoJICog
MSkgTm8gcGFja2V0IHdpdGggcGF5bG9hZCBpcyBpbiBxZGlzYy9kZXZpY2UgcXVldWVzLgoJICog
ICAgRGVsYXlzIGluIFRYIGNvbXBsZXRpb24gY2FuIGRlZmVhdCB0aGUgdGVzdAoJICogICAgZXZl
biBpZiBwYWNrZXRzIHdlcmUgYWxyZWFkeSBzZW50LgoJICogMikgT3IgcnR4IHF1ZXVlIGlzIGVt
cHR5LgoJICogICAgVGhpcyBtaXRpZ2F0ZXMgYWJvdmUgY2FzZSBpZiBBQ0sgcGFja2V0cyBmb3IK
CSAqICAgIGFsbCBwcmlvciBwYWNrZXRzIHdlcmUgYWxyZWFkeSBwcm9jZXNzZWQuCgkgKi8KCXNr
Yi0+b29vX29rYXkgPSBza193bWVtX2FsbG9jX2dldChzaykgPCBTS0JfVFJVRVNJWkUoMSkgfHwK
CQkJdGNwX3J0eF9xdWV1ZV9lbXB0eShzayk7CgoJLyogSWYgd2UgaGFkIHRvIHVzZSBtZW1vcnkg
cmVzZXJ2ZSB0byBhbGxvY2F0ZSB0aGlzIHNrYiwKCSAqIHRoaXMgbWlnaHQgY2F1c2UgZHJvcHMg
aWYgcGFja2V0IGlzIGxvb3BlZCBiYWNrIDoKCSAqIE90aGVyIHNvY2tldCBtaWdodCBub3QgaGF2
ZSBTT0NLX01FTUFMTE9DLgoJICogUGFja2V0cyBub3QgbG9vcGVkIGJhY2sgZG8gbm90IGNhcmUg
YWJvdXQgcGZtZW1hbGxvYy4KCSAqLwoJc2tiLT5wZm1lbWFsbG9jID0gMDsKCglza2JfcHVzaChz
a2IsIHRjcF9oZWFkZXJfc2l6ZSk7Cglza2JfcmVzZXRfdHJhbnNwb3J0X2hlYWRlcihza2IpOwoK
CXNrYl9vcnBoYW4oc2tiKTsKCXNrYi0+c2sgPSBzazsKCXNrYi0+ZGVzdHJ1Y3RvciA9IHNrYl9p
c190Y3BfcHVyZV9hY2soc2tiKSA/IF9fc29ja193ZnJlZSA6IHRjcF93ZnJlZTsKCXJlZmNvdW50
X2FkZChza2ItPnRydWVzaXplLCAmc2stPnNrX3dtZW1fYWxsb2MpOwoKCXNrYl9zZXRfZHN0X3Bl
bmRpbmdfY29uZmlybShza2IsIFJFQURfT05DRShzay0+c2tfZHN0X3BlbmRpbmdfY29uZmlybSkp
OwoKCS8qIEJ1aWxkIFRDUCBoZWFkZXIgYW5kIGNoZWNrc3VtIGl0LiAqLwoJdGggPSAoc3RydWN0
IHRjcGhkciAqKXNrYi0+ZGF0YTsKCXRoLT5zb3VyY2UJCT0gaW5ldC0+aW5ldF9zcG9ydDsKCXRo
LT5kZXN0CQk9IGluZXQtPmluZXRfZHBvcnQ7Cgl0aC0+c2VxCQkJPSBodG9ubCh0Y2ItPnNlcSk7
Cgl0aC0+YWNrX3NlcQkJPSBodG9ubChyY3Zfbnh0KTsKCSooKChfX2JlMTYgKil0aCkgKyA2KQk9
IGh0b25zKCgodGNwX2hlYWRlcl9zaXplID4+IDIpIDw8IDEyKSB8CgkJCQkJdGNiLT50Y3BfZmxh
Z3MpOwoKCXRoLT5jaGVjawkJPSAwOwoJdGgtPnVyZ19wdHIJCT0gMDsKCgkvKiBUaGUgdXJnX21v
ZGUgY2hlY2sgaXMgbmVjZXNzYXJ5IGR1cmluZyBhIGJlbG93IHNuZF91bmEgd2luIHByb2JlICov
CglpZiAodW5saWtlbHkodGNwX3VyZ19tb2RlKHRwKSAmJiBiZWZvcmUodGNiLT5zZXEsIHRwLT5z
bmRfdXApKSkgewoJCWlmIChiZWZvcmUodHAtPnNuZF91cCwgdGNiLT5zZXEgKyAweDEwMDAwKSkg
ewoJCQl0aC0+dXJnX3B0ciA9IGh0b25zKHRwLT5zbmRfdXAgLSB0Y2ItPnNlcSk7CgkJCXRoLT51
cmcgPSAxOwoJCX0gZWxzZSBpZiAoYWZ0ZXIodGNiLT5zZXEgKyAweEZGRkYsIHRwLT5zbmRfbnh0
KSkgewoJCQl0aC0+dXJnX3B0ciA9IGh0b25zKDB4RkZGRik7CgkJCXRoLT51cmcgPSAxOwoJCX0K
CX0KCglza2Jfc2hpbmZvKHNrYiktPmdzb190eXBlID0gc2stPnNrX2dzb190eXBlOwoJaWYgKGxp
a2VseSghKHRjYi0+dGNwX2ZsYWdzICYgVENQSERSX1NZTikpKSB7CgkJdGgtPndpbmRvdyAgICAg
ID0gaHRvbnModGNwX3NlbGVjdF93aW5kb3coc2spKTsKCQl0Y3BfZWNuX3NlbmQoc2ssIHNrYiwg
dGgsIHRjcF9oZWFkZXJfc2l6ZSk7Cgl9IGVsc2UgewoJCS8qIFJGQzEzMjM6IFRoZSB3aW5kb3cg
aW4gU1lOICYgU1lOL0FDSyBzZWdtZW50cwoJCSAqIGlzIG5ldmVyIHNjYWxlZC4KCQkgKi8KCQl0
aC0+d2luZG93CT0gaHRvbnMobWluKHRwLT5yY3Zfd25kLCA2NTUzNVUpKTsKCX0KCgl0Y3Bfb3B0
aW9uc193cml0ZSh0aCwgdHAsIE5VTEwsICZvcHRzLCAma2V5KTsKCglpZiAodGNwX2tleV9pc19t
ZDUoJmtleSkpIHsKI2lmZGVmIENPTkZJR19UQ1BfTUQ1U0lHCgkJLyogQ2FsY3VsYXRlIHRoZSBN
RDUgaGFzaCwgYXMgd2UgaGF2ZSBhbGwgd2UgbmVlZCBub3cgKi8KCQlza19nc29fZGlzYWJsZShz
ayk7CgkJdHAtPmFmX3NwZWNpZmljLT5jYWxjX21kNV9oYXNoKG9wdHMuaGFzaF9sb2NhdGlvbiwK
CQkJCQkgICAgICAga2V5Lm1kNV9rZXksIHNrLCBza2IpOwojZW5kaWYKCX0gZWxzZSBpZiAodGNw
X2tleV9pc19hbygma2V5KSkgewoJCWludCBlcnI7CgoJCWVyciA9IHRjcF9hb190cmFuc21pdF9z
a2Ioc2ssIHNrYiwga2V5LmFvX2tleSwgdGgsCgkJCQkJICBvcHRzLmhhc2hfbG9jYXRpb24pOwoJ
CWlmIChlcnIpIHsKCQkJa2ZyZWVfc2tiX3JlYXNvbihza2IsIFNLQl9EUk9QX1JFQVNPTl9OT1Rf
U1BFQ0lGSUVEKTsKCQkJcmV0dXJuIC1FTk9NRU07CgkJfQoJfQoKCS8qIEJQRiBwcm9nIGlzIHRo
ZSBsYXN0IG9uZSB3cml0aW5nIGhlYWRlciBvcHRpb24gKi8KCWJwZl9za29wc193cml0ZV9oZHJf
b3B0KHNrLCBza2IsIE5VTEwsIE5VTEwsIDAsICZvcHRzKTsKCglJTkRJUkVDVF9DQUxMX0lORVQo
aWNzay0+aWNza19hZl9vcHMtPnNlbmRfY2hlY2ssCgkJCSAgIHRjcF92Nl9zZW5kX2NoZWNrLCB0
Y3BfdjRfc2VuZF9jaGVjaywKCQkJICAgc2ssIHNrYik7CgoJaWYgKGxpa2VseSh0Y2ItPnRjcF9m
bGFncyAmIFRDUEhEUl9BQ0spKQoJCXRjcF9ldmVudF9hY2tfc2VudChzaywgcmN2X254dCk7CgoJ
aWYgKHNrYi0+bGVuICE9IHRjcF9oZWFkZXJfc2l6ZSkgewoJCXRjcF9ldmVudF9kYXRhX3NlbnQo
dHAsIHNrKTsKCQl0cC0+ZGF0YV9zZWdzX291dCArPSB0Y3Bfc2tiX3Bjb3VudChza2IpOwoJCXRw
LT5ieXRlc19zZW50ICs9IHNrYi0+bGVuIC0gdGNwX2hlYWRlcl9zaXplOwoJfQoKCWlmIChhZnRl
cih0Y2ItPmVuZF9zZXEsIHRwLT5zbmRfbnh0KSB8fCB0Y2ItPnNlcSA9PSB0Y2ItPmVuZF9zZXEp
CgkJVENQX0FERF9TVEFUUyhzb2NrX25ldChzayksIFRDUF9NSUJfT1VUU0VHUywKCQkJICAgICAg
dGNwX3NrYl9wY291bnQoc2tiKSk7CgoJdHAtPnNlZ3Nfb3V0ICs9IHRjcF9za2JfcGNvdW50KHNr
Yik7Cglza2Jfc2V0X2hhc2hfZnJvbV9zayhza2IsIHNrKTsKCS8qIE9LLCBpdHMgdGltZSB0byBm
aWxsIHNrYl9zaGluZm8oc2tiKS0+Z3NvX3tzZWdzfHNpemV9ICovCglza2Jfc2hpbmZvKHNrYikt
Pmdzb19zZWdzID0gdGNwX3NrYl9wY291bnQoc2tiKTsKCXNrYl9zaGluZm8oc2tiKS0+Z3NvX3Np
emUgPSB0Y3Bfc2tiX21zcyhza2IpOwoKCS8qIExlYXZlIGVhcmxpZXN0IGRlcGFydHVyZSB0aW1l
IGluIHNrYi0+dHN0YW1wIChza2ItPnNrYl9tc3RhbXBfbnMpICovCgoJLyogQ2xlYW51cCBvdXIg
ZGVicmlzIGZvciBJUCBzdGFja3MgKi8KCW1lbXNldChza2ItPmNiLCAwLCBtYXgoc2l6ZW9mKHN0
cnVjdCBpbmV0X3NrYl9wYXJtKSwKCQkJICAgICAgIHNpemVvZihzdHJ1Y3QgaW5ldDZfc2tiX3Bh
cm0pKSk7CgoJdGNwX2FkZF90eF9kZWxheShza2IsIHRwKTsKCgllcnIgPSBJTkRJUkVDVF9DQUxM
X0lORVQoaWNzay0+aWNza19hZl9vcHMtPnF1ZXVlX3htaXQsCgkJCQkgaW5ldDZfY3NrX3htaXQs
IGlwX3F1ZXVlX3htaXQsCgkJCQkgc2ssIHNrYiwgJmluZXQtPmNvcmsuZmwpOwoKCWlmICh1bmxp
a2VseShlcnIgPiAwKSkgewoJCXRjcF9lbnRlcl9jd3Ioc2spOwoJCWVyciA9IG5ldF94bWl0X2V2
YWwoZXJyKTsKCX0KCWlmICghZXJyICYmIG9za2IpIHsKCQl0Y3BfdXBkYXRlX3NrYl9hZnRlcl9z
ZW5kKHNrLCBvc2tiLCBwcmlvcl93c3RhbXApOwoJCXRjcF9yYXRlX3NrYl9zZW50KHNrLCBvc2ti
KTsKCX0KCXJldHVybiBlcnI7Cn0KCnN0YXRpYyBpbnQgdGNwX3RyYW5zbWl0X3NrYihzdHJ1Y3Qg
c29jayAqc2ssIHN0cnVjdCBza19idWZmICpza2IsIGludCBjbG9uZV9pdCwKCQkJICAgIGdmcF90
IGdmcF9tYXNrKQp7CglyZXR1cm4gX190Y3BfdHJhbnNtaXRfc2tiKHNrLCBza2IsIGNsb25lX2l0
LCBnZnBfbWFzaywKCQkJCSAgdGNwX3NrKHNrKS0+cmN2X254dCk7Cn0KCi8qIFRoaXMgcm91dGlu
ZSBqdXN0IHF1ZXVlcyB0aGUgYnVmZmVyIGZvciBzZW5kaW5nLgogKgogKiBOT1RFOiBwcm9iZTAg
dGltZXIgaXMgbm90IGNoZWNrZWQsIGRvIG5vdCBmb3JnZXQgdGNwX3B1c2hfcGVuZGluZ19mcmFt
ZXMsCiAqIG90aGVyd2lzZSBzb2NrZXQgY2FuIHN0YWxsLgogKi8Kc3RhdGljIHZvaWQgdGNwX3F1
ZXVlX3NrYihzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBza19idWZmICpza2IpCnsKCXN0cnVjdCB0
Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOwoKCS8qIEFkdmFuY2Ugd3JpdGVfc2VxIGFuZCBwbGFj
ZSBvbnRvIHRoZSB3cml0ZV9xdWV1ZS4gKi8KCVdSSVRFX09OQ0UodHAtPndyaXRlX3NlcSwgVENQ
X1NLQl9DQihza2IpLT5lbmRfc2VxKTsKCV9fc2tiX2hlYWRlcl9yZWxlYXNlKHNrYik7Cgl0Y3Bf
YWRkX3dyaXRlX3F1ZXVlX3RhaWwoc2ssIHNrYik7Cglza193bWVtX3F1ZXVlZF9hZGQoc2ssIHNr
Yi0+dHJ1ZXNpemUpOwoJc2tfbWVtX2NoYXJnZShzaywgc2tiLT50cnVlc2l6ZSk7Cn0KCi8qIElu
aXRpYWxpemUgVFNPIHNlZ21lbnRzIGZvciBhIHBhY2tldC4gKi8Kc3RhdGljIHZvaWQgdGNwX3Nl
dF9za2JfdHNvX3NlZ3Moc3RydWN0IHNrX2J1ZmYgKnNrYiwgdW5zaWduZWQgaW50IG1zc19ub3cp
CnsKCWlmIChza2ItPmxlbiA8PSBtc3Nfbm93KSB7CgkJLyogQXZvaWQgdGhlIGNvc3RseSBkaXZp
ZGUgaW4gdGhlIG5vcm1hbAoJCSAqIG5vbi1UU08gY2FzZS4KCQkgKi8KCQl0Y3Bfc2tiX3Bjb3Vu
dF9zZXQoc2tiLCAxKTsKCQlUQ1BfU0tCX0NCKHNrYiktPnRjcF9nc29fc2l6ZSA9IDA7Cgl9IGVs
c2UgewoJCXRjcF9za2JfcGNvdW50X3NldChza2IsIERJVl9ST1VORF9VUChza2ItPmxlbiwgbXNz
X25vdykpOwoJCVRDUF9TS0JfQ0Ioc2tiKS0+dGNwX2dzb19zaXplID0gbXNzX25vdzsKCX0KfQoK
LyogUGNvdW50IGluIHRoZSBtaWRkbGUgb2YgdGhlIHdyaXRlIHF1ZXVlIGdvdCBjaGFuZ2VkLCB3
ZSBuZWVkIHRvIGRvIHZhcmlvdXMKICogdHdlYWtzIHRvIGZpeCBjb3VudGVycwogKi8Kc3RhdGlj
IHZvaWQgdGNwX2FkanVzdF9wY291bnQoc3RydWN0IHNvY2sgKnNrLCBjb25zdCBzdHJ1Y3Qgc2tf
YnVmZiAqc2tiLCBpbnQgZGVjcikKewoJc3RydWN0IHRjcF9zb2NrICp0cCA9IHRjcF9zayhzayk7
CgoJdHAtPnBhY2tldHNfb3V0IC09IGRlY3I7CgoJaWYgKFRDUF9TS0JfQ0Ioc2tiKS0+c2Fja2Vk
ICYgVENQQ0JfU0FDS0VEX0FDS0VEKQoJCXRwLT5zYWNrZWRfb3V0IC09IGRlY3I7CglpZiAoVENQ
X1NLQl9DQihza2IpLT5zYWNrZWQgJiBUQ1BDQl9TQUNLRURfUkVUUkFOUykKCQl0cC0+cmV0cmFu
c19vdXQgLT0gZGVjcjsKCWlmIChUQ1BfU0tCX0NCKHNrYiktPnNhY2tlZCAmIFRDUENCX0xPU1Qp
CgkJdHAtPmxvc3Rfb3V0IC09IGRlY3I7CgoJLyogUmVubyBjYXNlIGlzIHNwZWNpYWwuIFNpZ2gu
Li4gKi8KCWlmICh0Y3BfaXNfcmVubyh0cCkgJiYgZGVjciA+IDApCgkJdHAtPnNhY2tlZF9vdXQg
LT0gbWluX3QodTMyLCB0cC0+c2Fja2VkX291dCwgZGVjcik7CgoJaWYgKHRwLT5sb3N0X3NrYl9o
aW50ICYmCgkgICAgYmVmb3JlKFRDUF9TS0JfQ0Ioc2tiKS0+c2VxLCBUQ1BfU0tCX0NCKHRwLT5s
b3N0X3NrYl9oaW50KS0+c2VxKSAmJgoJICAgIChUQ1BfU0tCX0NCKHNrYiktPnNhY2tlZCAmIFRD
UENCX1NBQ0tFRF9BQ0tFRCkpCgkJdHAtPmxvc3RfY250X2hpbnQgLT0gZGVjcjsKCgl0Y3BfdmVy
aWZ5X2xlZnRfb3V0KHRwKTsKfQoKc3RhdGljIGJvb2wgdGNwX2hhc190eF90c3RhbXAoY29uc3Qg
c3RydWN0IHNrX2J1ZmYgKnNrYikKewoJcmV0dXJuIFRDUF9TS0JfQ0Ioc2tiKS0+dHhzdGFtcF9h
Y2sgfHwKCQkoc2tiX3NoaW5mbyhza2IpLT50eF9mbGFncyAmIFNLQlRYX0FOWV9UU1RBTVApOwp9
CgpzdGF0aWMgdm9pZCB0Y3BfZnJhZ21lbnRfdHN0YW1wKHN0cnVjdCBza19idWZmICpza2IsIHN0
cnVjdCBza19idWZmICpza2IyKQp7CglzdHJ1Y3Qgc2tiX3NoYXJlZF9pbmZvICpzaGluZm8gPSBz
a2Jfc2hpbmZvKHNrYik7CgoJaWYgKHVubGlrZWx5KHRjcF9oYXNfdHhfdHN0YW1wKHNrYikpICYm
CgkgICAgIWJlZm9yZShzaGluZm8tPnRza2V5LCBUQ1BfU0tCX0NCKHNrYjIpLT5zZXEpKSB7CgkJ
c3RydWN0IHNrYl9zaGFyZWRfaW5mbyAqc2hpbmZvMiA9IHNrYl9zaGluZm8oc2tiMik7CgkJdTgg
dHNmbGFncyA9IHNoaW5mby0+dHhfZmxhZ3MgJiBTS0JUWF9BTllfVFNUQU1QOwoKCQlzaGluZm8t
PnR4X2ZsYWdzICY9IH50c2ZsYWdzOwoJCXNoaW5mbzItPnR4X2ZsYWdzIHw9IHRzZmxhZ3M7CgkJ
c3dhcChzaGluZm8tPnRza2V5LCBzaGluZm8yLT50c2tleSk7CgkJVENQX1NLQl9DQihza2IyKS0+
dHhzdGFtcF9hY2sgPSBUQ1BfU0tCX0NCKHNrYiktPnR4c3RhbXBfYWNrOwoJCVRDUF9TS0JfQ0Io
c2tiKS0+dHhzdGFtcF9hY2sgPSAwOwoJfQp9CgpzdGF0aWMgdm9pZCB0Y3Bfc2tiX2ZyYWdtZW50
X2VvcihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiMikKewoJVENQX1NL
Ql9DQihza2IyKS0+ZW9yID0gVENQX1NLQl9DQihza2IpLT5lb3I7CglUQ1BfU0tCX0NCKHNrYikt
PmVvciA9IDA7Cn0KCi8qIEluc2VydCBidWZmIGFmdGVyIHNrYiBvbiB0aGUgd3JpdGUgb3IgcnR4
IHF1ZXVlIG9mIHNrLiAgKi8Kc3RhdGljIHZvaWQgdGNwX2luc2VydF93cml0ZV9xdWV1ZV9hZnRl
cihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAoJCQkJCSBzdHJ1Y3Qgc2tfYnVmZiAqYnVmZiwKCQkJCQkg
c3RydWN0IHNvY2sgKnNrLAoJCQkJCSBlbnVtIHRjcF9xdWV1ZSB0Y3BfcXVldWUpCnsKCWlmICh0
Y3BfcXVldWUgPT0gVENQX0ZSQUdfSU5fV1JJVEVfUVVFVUUpCgkJX19za2JfcXVldWVfYWZ0ZXIo
JnNrLT5za193cml0ZV9xdWV1ZSwgc2tiLCBidWZmKTsKCWVsc2UKCQl0Y3BfcmJ0cmVlX2luc2Vy
dCgmc2stPnRjcF9ydHhfcXVldWUsIGJ1ZmYpOwp9CgovKiBGdW5jdGlvbiB0byBjcmVhdGUgdHdv
IG5ldyBUQ1Agc2VnbWVudHMuICBTaHJpbmtzIHRoZSBnaXZlbiBzZWdtZW50CiAqIHRvIHRoZSBz
cGVjaWZpZWQgc2l6ZSBhbmQgYXBwZW5kcyBhIG5ldyBzZWdtZW50IHdpdGggdGhlIHJlc3Qgb2Yg
dGhlCiAqIHBhY2tldCB0byB0aGUgbGlzdC4gIFRoaXMgd29uJ3QgYmUgY2FsbGVkIGZyZXF1ZW50
bHksIEkgaG9wZS4KICogUmVtZW1iZXIsIHRoZXNlIGFyZSBzdGlsbCBoZWFkZXJsZXNzIFNLQnMg
YXQgdGhpcyBwb2ludC4KICovCmludCB0Y3BfZnJhZ21lbnQoc3RydWN0IHNvY2sgKnNrLCBlbnVt
IHRjcF9xdWV1ZSB0Y3BfcXVldWUsCgkJIHN0cnVjdCBza19idWZmICpza2IsIHUzMiBsZW4sCgkJ
IHVuc2lnbmVkIGludCBtc3Nfbm93LCBnZnBfdCBnZnApCnsKCXN0cnVjdCB0Y3Bfc29jayAqdHAg
PSB0Y3Bfc2soc2spOwoJc3RydWN0IHNrX2J1ZmYgKmJ1ZmY7CglpbnQgb2xkX2ZhY3RvcjsKCWxv
bmcgbGltaXQ7CglpbnQgbmxlbjsKCXU4IGZsYWdzOwoKCWlmIChXQVJOX09OKGxlbiA+IHNrYi0+
bGVuKSkKCQlyZXR1cm4gLUVJTlZBTDsKCglERUJVR19ORVRfV0FSTl9PTl9PTkNFKHNrYl9oZWFk
bGVuKHNrYikpOwoKCS8qIHRjcF9zZW5kbXNnKCkgY2FuIG92ZXJzaG9vdCBza193bWVtX3F1ZXVl
ZCBieSBvbmUgZnVsbCBzaXplIHNrYi4KCSAqIFdlIG5lZWQgc29tZSBhbGxvd2FuY2UgdG8gbm90
IHBlbmFsaXplIGFwcGxpY2F0aW9ucyBzZXR0aW5nIHNtYWxsCgkgKiBTT19TTkRCVUYgdmFsdWVz
LgoJICogQWxzbyBhbGxvdyBmaXJzdCBhbmQgbGFzdCBza2IgaW4gcmV0cmFuc21pdCBxdWV1ZSB0
byBiZSBzcGxpdC4KCSAqLwoJbGltaXQgPSBzay0+c2tfc25kYnVmICsgMiAqIFNLQl9UUlVFU0la
RShHU09fTEVHQUNZX01BWF9TSVpFKTsKCWlmICh1bmxpa2VseSgoc2stPnNrX3dtZW1fcXVldWVk
ID4+IDEpID4gbGltaXQgJiYKCQkgICAgIHRjcF9xdWV1ZSAhPSBUQ1BfRlJBR19JTl9XUklURV9R
VUVVRSAmJgoJCSAgICAgc2tiICE9IHRjcF9ydHhfcXVldWVfaGVhZChzaykgJiYKCQkgICAgIHNr
YiAhPSB0Y3BfcnR4X3F1ZXVlX3RhaWwoc2spKSkgewoJCU5FVF9JTkNfU1RBVFMoc29ja19uZXQo
c2spLCBMSU5VWF9NSUJfVENQV1FVRVVFVE9PQklHKTsKCQlyZXR1cm4gLUVOT01FTTsKCX0KCglp
ZiAoc2tiX3VuY2xvbmVfa2VlcHRydWVzaXplKHNrYiwgZ2ZwKSkKCQlyZXR1cm4gLUVOT01FTTsK
CgkvKiBHZXQgYSBuZXcgc2tiLi4uIGZvcmNlIGZsYWcgb24uICovCglidWZmID0gdGNwX3N0cmVh
bV9hbGxvY19za2Ioc2ssIGdmcCwgdHJ1ZSk7CglpZiAoIWJ1ZmYpCgkJcmV0dXJuIC1FTk9NRU07
IC8qIFdlJ2xsIGp1c3QgdHJ5IGFnYWluIGxhdGVyLiAqLwoJc2tiX2NvcHlfZGVjcnlwdGVkKGJ1
ZmYsIHNrYik7CgltcHRjcF9za2JfZXh0X2NvcHkoYnVmZiwgc2tiKTsKCglza193bWVtX3F1ZXVl
ZF9hZGQoc2ssIGJ1ZmYtPnRydWVzaXplKTsKCXNrX21lbV9jaGFyZ2Uoc2ssIGJ1ZmYtPnRydWVz
aXplKTsKCW5sZW4gPSBza2ItPmxlbiAtIGxlbjsKCWJ1ZmYtPnRydWVzaXplICs9IG5sZW47Cglz
a2ItPnRydWVzaXplIC09IG5sZW47CgoJLyogQ29ycmVjdCB0aGUgc2VxdWVuY2UgbnVtYmVycy4g
Ki8KCVRDUF9TS0JfQ0IoYnVmZiktPnNlcSA9IFRDUF9TS0JfQ0Ioc2tiKS0+c2VxICsgbGVuOwoJ
VENQX1NLQl9DQihidWZmKS0+ZW5kX3NlcSA9IFRDUF9TS0JfQ0Ioc2tiKS0+ZW5kX3NlcTsKCVRD
UF9TS0JfQ0Ioc2tiKS0+ZW5kX3NlcSA9IFRDUF9TS0JfQ0IoYnVmZiktPnNlcTsKCgkvKiBQU0gg
YW5kIEZJTiBzaG91bGQgb25seSBiZSBzZXQgaW4gdGhlIHNlY29uZCBwYWNrZXQuICovCglmbGFn
cyA9IFRDUF9TS0JfQ0Ioc2tiKS0+dGNwX2ZsYWdzOwoJVENQX1NLQl9DQihza2IpLT50Y3BfZmxh
Z3MgPSBmbGFncyAmIH4oVENQSERSX0ZJTiB8IFRDUEhEUl9QU0gpOwoJVENQX1NLQl9DQihidWZm
KS0+dGNwX2ZsYWdzID0gZmxhZ3M7CglUQ1BfU0tCX0NCKGJ1ZmYpLT5zYWNrZWQgPSBUQ1BfU0tC
X0NCKHNrYiktPnNhY2tlZDsKCXRjcF9za2JfZnJhZ21lbnRfZW9yKHNrYiwgYnVmZik7CgoJc2ti
X3NwbGl0KHNrYiwgYnVmZiwgbGVuKTsKCglza2Jfc2V0X2RlbGl2ZXJ5X3RpbWUoYnVmZiwgc2ti
LT50c3RhbXAsIHRydWUpOwoJdGNwX2ZyYWdtZW50X3RzdGFtcChza2IsIGJ1ZmYpOwoKCW9sZF9m
YWN0b3IgPSB0Y3Bfc2tiX3Bjb3VudChza2IpOwoKCS8qIEZpeCB1cCB0c29fZmFjdG9yIGZvciBi
b3RoIG9yaWdpbmFsIGFuZCBuZXcgU0tCLiAgKi8KCXRjcF9zZXRfc2tiX3Rzb19zZWdzKHNrYiwg
bXNzX25vdyk7Cgl0Y3Bfc2V0X3NrYl90c29fc2VncyhidWZmLCBtc3Nfbm93KTsKCgkvKiBVcGRh
dGUgZGVsaXZlcmVkIGluZm8gZm9yIHRoZSBuZXcgc2VnbWVudCAqLwoJVENQX1NLQl9DQihidWZm
KS0+dHggPSBUQ1BfU0tCX0NCKHNrYiktPnR4OwoKCS8qIElmIHRoaXMgcGFja2V0IGhhcyBiZWVu
IHNlbnQgb3V0IGFscmVhZHksIHdlIG11c3QKCSAqIGFkanVzdCB0aGUgdmFyaW91cyBwYWNrZXQg
Y291bnRlcnMuCgkgKi8KCWlmICghYmVmb3JlKHRwLT5zbmRfbnh0LCBUQ1BfU0tCX0NCKGJ1ZmYp
LT5lbmRfc2VxKSkgewoJCWludCBkaWZmID0gb2xkX2ZhY3RvciAtIHRjcF9za2JfcGNvdW50KHNr
YikgLQoJCQl0Y3Bfc2tiX3Bjb3VudChidWZmKTsKCgkJaWYgKGRpZmYpCgkJCXRjcF9hZGp1c3Rf
cGNvdW50KHNrLCBza2IsIGRpZmYpOwoJfQoKCS8qIExpbmsgQlVGRiBpbnRvIHRoZSBzZW5kIHF1
ZXVlLiAqLwoJX19za2JfaGVhZGVyX3JlbGVhc2UoYnVmZik7Cgl0Y3BfaW5zZXJ0X3dyaXRlX3F1
ZXVlX2FmdGVyKHNrYiwgYnVmZiwgc2ssIHRjcF9xdWV1ZSk7CglpZiAodGNwX3F1ZXVlID09IFRD
UF9GUkFHX0lOX1JUWF9RVUVVRSkKCQlsaXN0X2FkZCgmYnVmZi0+dGNwX3Rzb3J0ZWRfYW5jaG9y
LCAmc2tiLT50Y3BfdHNvcnRlZF9hbmNob3IpOwoKCXJldHVybiAwOwp9CgovKiBUaGlzIGlzIHNp
bWlsYXIgdG8gX19wc2tiX3B1bGxfdGFpbCgpLiBUaGUgZGlmZmVyZW5jZSBpcyB0aGF0IHB1bGxl
ZAogKiBkYXRhIGlzIG5vdCBjb3BpZWQsIGJ1dCBpbW1lZGlhdGVseSBkaXNjYXJkZWQuCiAqLwpz
dGF0aWMgaW50IF9fcHNrYl90cmltX2hlYWQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgaW50IGxlbikK
ewoJc3RydWN0IHNrYl9zaGFyZWRfaW5mbyAqc2hpbmZvOwoJaW50IGksIGssIGVhdDsKCglERUJV
R19ORVRfV0FSTl9PTl9PTkNFKHNrYl9oZWFkbGVuKHNrYikpOwoJZWF0ID0gbGVuOwoJayA9IDA7
CglzaGluZm8gPSBza2Jfc2hpbmZvKHNrYik7Cglmb3IgKGkgPSAwOyBpIDwgc2hpbmZvLT5ucl9m
cmFnczsgaSsrKSB7CgkJaW50IHNpemUgPSBza2JfZnJhZ19zaXplKCZzaGluZm8tPmZyYWdzW2ld
KTsKCgkJaWYgKHNpemUgPD0gZWF0KSB7CgkJCXNrYl9mcmFnX3VucmVmKHNrYiwgaSk7CgkJCWVh
dCAtPSBzaXplOwoJCX0gZWxzZSB7CgkJCXNoaW5mby0+ZnJhZ3Nba10gPSBzaGluZm8tPmZyYWdz
W2ldOwoJCQlpZiAoZWF0KSB7CgkJCQlza2JfZnJhZ19vZmZfYWRkKCZzaGluZm8tPmZyYWdzW2td
LCBlYXQpOwoJCQkJc2tiX2ZyYWdfc2l6ZV9zdWIoJnNoaW5mby0+ZnJhZ3Nba10sIGVhdCk7CgkJ
CQllYXQgPSAwOwoJCQl9CgkJCWsrKzsKCQl9Cgl9CglzaGluZm8tPm5yX2ZyYWdzID0gazsKCglz
a2ItPmRhdGFfbGVuIC09IGxlbjsKCXNrYi0+bGVuID0gc2tiLT5kYXRhX2xlbjsKCXJldHVybiBs
ZW47Cn0KCi8qIFJlbW92ZSBhY2tlZCBkYXRhIGZyb20gYSBwYWNrZXQgaW4gdGhlIHRyYW5zbWl0
IHF1ZXVlLiAqLwppbnQgdGNwX3RyaW1faGVhZChzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBza19i
dWZmICpza2IsIHUzMiBsZW4pCnsKCXUzMiBkZWx0YV90cnVlc2l6ZTsKCglpZiAoc2tiX3VuY2xv
bmVfa2VlcHRydWVzaXplKHNrYiwgR0ZQX0FUT01JQykpCgkJcmV0dXJuIC1FTk9NRU07CgoJZGVs
dGFfdHJ1ZXNpemUgPSBfX3Bza2JfdHJpbV9oZWFkKHNrYiwgbGVuKTsKCglUQ1BfU0tCX0NCKHNr
YiktPnNlcSArPSBsZW47CgoJc2tiLT50cnVlc2l6ZQkgICAtPSBkZWx0YV90cnVlc2l6ZTsKCXNr
X3dtZW1fcXVldWVkX2FkZChzaywgLWRlbHRhX3RydWVzaXplKTsKCWlmICghc2tiX3pjb3B5X3B1
cmUoc2tiKSkKCQlza19tZW1fdW5jaGFyZ2Uoc2ssIGRlbHRhX3RydWVzaXplKTsKCgkvKiBBbnkg
Y2hhbmdlIG9mIHNrYi0+bGVuIHJlcXVpcmVzIHJlY2FsY3VsYXRpb24gb2YgdHNvIGZhY3Rvci4g
Ki8KCWlmICh0Y3Bfc2tiX3Bjb3VudChza2IpID4gMSkKCQl0Y3Bfc2V0X3NrYl90c29fc2Vncyhz
a2IsIHRjcF9za2JfbXNzKHNrYikpOwoKCXJldHVybiAwOwp9CgovKiBDYWxjdWxhdGUgTVNTIG5v
dCBhY2NvdW50aW5nIGFueSBUQ1Agb3B0aW9ucy4gICovCnN0YXRpYyBpbmxpbmUgaW50IF9fdGNw
X210dV90b19tc3Moc3RydWN0IHNvY2sgKnNrLCBpbnQgcG10dSkKewoJY29uc3Qgc3RydWN0IHRj
cF9zb2NrICp0cCA9IHRjcF9zayhzayk7Cgljb25zdCBzdHJ1Y3QgaW5ldF9jb25uZWN0aW9uX3Nv
Y2sgKmljc2sgPSBpbmV0X2Nzayhzayk7CglpbnQgbXNzX25vdzsKCgkvKiBDYWxjdWxhdGUgYmFz
ZSBtc3Mgd2l0aG91dCBUQ1Agb3B0aW9uczoKCSAgIEl0IGlzIE1NU19TIC0gc2l6ZW9mKHRjcGhk
cikgb2YgcmZjMTEyMgoJICovCgltc3Nfbm93ID0gcG10dSAtIGljc2stPmljc2tfYWZfb3BzLT5u
ZXRfaGVhZGVyX2xlbiAtIHNpemVvZihzdHJ1Y3QgdGNwaGRyKTsKCgkvKiBDbGFtcCBpdCAobXNz
X2NsYW1wIGRvZXMgbm90IGluY2x1ZGUgdGNwIG9wdGlvbnMpICovCglpZiAobXNzX25vdyA+IHRw
LT5yeF9vcHQubXNzX2NsYW1wKQoJCW1zc19ub3cgPSB0cC0+cnhfb3B0Lm1zc19jbGFtcDsKCgkv
KiBOb3cgc3VidHJhY3Qgb3B0aW9uYWwgdHJhbnNwb3J0IG92ZXJoZWFkICovCgltc3Nfbm93IC09
IGljc2stPmljc2tfZXh0X2hkcl9sZW47CgoJLyogVGhlbiByZXNlcnZlIHJvb20gZm9yIGZ1bGwg
c2V0IG9mIFRDUCBvcHRpb25zIGFuZCA4IGJ5dGVzIG9mIGRhdGEgKi8KCW1zc19ub3cgPSBtYXgo
bXNzX25vdywKCQkgICAgICBSRUFEX09OQ0Uoc29ja19uZXQoc2spLT5pcHY0LnN5c2N0bF90Y3Bf
bWluX3NuZF9tc3MpKTsKCXJldHVybiBtc3Nfbm93Owp9CgovKiBDYWxjdWxhdGUgTVNTLiBOb3Qg
YWNjb3VudGluZyBmb3IgU0FDS3MgaGVyZS4gICovCmludCB0Y3BfbXR1X3RvX21zcyhzdHJ1Y3Qg
c29jayAqc2ssIGludCBwbXR1KQp7CgkvKiBTdWJ0cmFjdCBUQ1Agb3B0aW9ucyBzaXplLCBub3Qg
aW5jbHVkaW5nIFNBQ0tzICovCglyZXR1cm4gX190Y3BfbXR1X3RvX21zcyhzaywgcG10dSkgLQoJ
ICAgICAgICh0Y3Bfc2soc2spLT50Y3BfaGVhZGVyX2xlbiAtIHNpemVvZihzdHJ1Y3QgdGNwaGRy
KSk7Cn0KRVhQT1JUX1NZTUJPTCh0Y3BfbXR1X3RvX21zcyk7CgovKiBJbnZlcnNlIG9mIGFib3Zl
ICovCmludCB0Y3BfbXNzX3RvX210dShzdHJ1Y3Qgc29jayAqc2ssIGludCBtc3MpCnsKCWNvbnN0
IHN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOwoJY29uc3Qgc3RydWN0IGluZXRfY29u
bmVjdGlvbl9zb2NrICppY3NrID0gaW5ldF9jc2soc2spOwoKCXJldHVybiBtc3MgKwoJICAgICAg
dHAtPnRjcF9oZWFkZXJfbGVuICsKCSAgICAgIGljc2stPmljc2tfZXh0X2hkcl9sZW4gKwoJICAg
ICAgaWNzay0+aWNza19hZl9vcHMtPm5ldF9oZWFkZXJfbGVuOwp9CkVYUE9SVF9TWU1CT0wodGNw
X21zc190b19tdHUpOwoKLyogTVRVIHByb2JpbmcgaW5pdCBwZXIgc29ja2V0ICovCnZvaWQgdGNw
X210dXBfaW5pdChzdHJ1Y3Qgc29jayAqc2spCnsKCXN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bf
c2soc2spOwoJc3RydWN0IGluZXRfY29ubmVjdGlvbl9zb2NrICppY3NrID0gaW5ldF9jc2soc2sp
OwoJc3RydWN0IG5ldCAqbmV0ID0gc29ja19uZXQoc2spOwoKCWljc2stPmljc2tfbXR1cC5lbmFi
bGVkID0gUkVBRF9PTkNFKG5ldC0+aXB2NC5zeXNjdGxfdGNwX210dV9wcm9iaW5nKSA+IDE7Cglp
Y3NrLT5pY3NrX210dXAuc2VhcmNoX2hpZ2ggPSB0cC0+cnhfb3B0Lm1zc19jbGFtcCArIHNpemVv
ZihzdHJ1Y3QgdGNwaGRyKSArCgkJCSAgICAgICBpY3NrLT5pY3NrX2FmX29wcy0+bmV0X2hlYWRl
cl9sZW47CglpY3NrLT5pY3NrX210dXAuc2VhcmNoX2xvdyA9IHRjcF9tc3NfdG9fbXR1KHNrLCBS
RUFEX09OQ0UobmV0LT5pcHY0LnN5c2N0bF90Y3BfYmFzZV9tc3MpKTsKCWljc2stPmljc2tfbXR1
cC5wcm9iZV9zaXplID0gMDsKCWlmIChpY3NrLT5pY3NrX210dXAuZW5hYmxlZCkKCQlpY3NrLT5p
Y3NrX210dXAucHJvYmVfdGltZXN0YW1wID0gdGNwX2ppZmZpZXMzMjsKfQpFWFBPUlRfU1lNQk9M
KHRjcF9tdHVwX2luaXQpOwoKLyogVGhpcyBmdW5jdGlvbiBzeW5jaHJvbml6ZSBzbmQgbXNzIHRv
IGN1cnJlbnQgcG10dS9leHRoZHIgc2V0LgoKICAgdHAtPnJ4X29wdC51c2VyX21zcyBpcyBtc3Mg
c2V0IGJ5IHVzZXIgYnkgVENQX01BWFNFRy4gSXQgZG9lcyBOT1QgY291bnRzCiAgIGZvciBUQ1Ag
b3B0aW9ucywgYnV0IGluY2x1ZGVzIG9ubHkgYmFyZSBUQ1AgaGVhZGVyLgoKICAgdHAtPnJ4X29w
dC5tc3NfY2xhbXAgaXMgbXNzIG5lZ290aWF0ZWQgYXQgY29ubmVjdGlvbiBzZXR1cC4KICAgSXQg
aXMgbWluaW11bSBvZiB1c2VyX21zcyBhbmQgbXNzIHJlY2VpdmVkIHdpdGggU1lOLgogICBJdCBh
bHNvIGRvZXMgbm90IGluY2x1ZGUgVENQIG9wdGlvbnMuCgogICBpbmV0X2NzayhzayktPmljc2tf
cG10dV9jb29raWUgaXMgbGFzdCBwbXR1LCBzZWVuIGJ5IHRoaXMgZnVuY3Rpb24uCgogICB0cC0+
bXNzX2NhY2hlIGlzIGN1cnJlbnQgZWZmZWN0aXZlIHNlbmRpbmcgbXNzLCBpbmNsdWRpbmcKICAg
YWxsIHRjcCBvcHRpb25zIGV4Y2VwdCBmb3IgU0FDS3MuIEl0IGlzIGV2YWx1YXRlZCwKICAgdGFr
aW5nIGludG8gYWNjb3VudCBjdXJyZW50IHBtdHUsIGJ1dCBuZXZlciBleGNlZWRzCiAgIHRwLT5y
eF9vcHQubXNzX2NsYW1wLgoKICAgTk9URTEuIHJmYzExMjIgY2xlYXJseSBzdGF0ZXMgdGhhdCBh
ZHZlcnRpc2VkIE1TUwogICBET0VTIE5PVCBpbmNsdWRlIGVpdGhlciB0Y3Agb3IgaXAgb3B0aW9u
cy4KCiAgIE5PVEUyLiBpbmV0X2NzayhzayktPmljc2tfcG10dV9jb29raWUgYW5kIHRwLT5tc3Nf
Y2FjaGUKICAgYXJlIFJFQUQgT05MWSBvdXRzaWRlIHRoaXMgZnVuY3Rpb24uCQktLUFOSyAoOTgw
NzMxKQogKi8KdW5zaWduZWQgaW50IHRjcF9zeW5jX21zcyhzdHJ1Y3Qgc29jayAqc2ssIHUzMiBw
bXR1KQp7CglzdHJ1Y3QgdGNwX3NvY2sgKnRwID0gdGNwX3NrKHNrKTsKCXN0cnVjdCBpbmV0X2Nv
bm5lY3Rpb25fc29jayAqaWNzayA9IGluZXRfY3NrKHNrKTsKCWludCBtc3Nfbm93OwoKCWlmIChp
Y3NrLT5pY3NrX210dXAuc2VhcmNoX2hpZ2ggPiBwbXR1KQoJCWljc2stPmljc2tfbXR1cC5zZWFy
Y2hfaGlnaCA9IHBtdHU7CgoJbXNzX25vdyA9IHRjcF9tdHVfdG9fbXNzKHNrLCBwbXR1KTsKCW1z
c19ub3cgPSB0Y3BfYm91bmRfdG9faGFsZl93bmQodHAsIG1zc19ub3cpOwoKCS8qIEFuZCBzdG9y
ZSBjYWNoZWQgcmVzdWx0cyAqLwoJaWNzay0+aWNza19wbXR1X2Nvb2tpZSA9IHBtdHU7CglpZiAo
aWNzay0+aWNza19tdHVwLmVuYWJsZWQpCgkJbXNzX25vdyA9IG1pbihtc3Nfbm93LCB0Y3BfbXR1
X3RvX21zcyhzaywgaWNzay0+aWNza19tdHVwLnNlYXJjaF9sb3cpKTsKCXRwLT5tc3NfY2FjaGUg
PSBtc3Nfbm93OwoKCXJldHVybiBtc3Nfbm93Owp9CkVYUE9SVF9TWU1CT0wodGNwX3N5bmNfbXNz
KTsKCi8qIENvbXB1dGUgdGhlIGN1cnJlbnQgZWZmZWN0aXZlIE1TUywgdGFraW5nIFNBQ0tzIGFu
ZCBJUCBvcHRpb25zLAogKiBhbmQgZXZlbiBQTVRVIGRpc2NvdmVyeSBldmVudHMgaW50byBhY2Nv
dW50LgogKi8KdW5zaWduZWQgaW50IHRjcF9jdXJyZW50X21zcyhzdHJ1Y3Qgc29jayAqc2spCnsK
CWNvbnN0IHN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOwoJY29uc3Qgc3RydWN0IGRz
dF9lbnRyeSAqZHN0ID0gX19za19kc3RfZ2V0KHNrKTsKCXUzMiBtc3Nfbm93OwoJdW5zaWduZWQg
aW50IGhlYWRlcl9sZW47CglzdHJ1Y3QgdGNwX291dF9vcHRpb25zIG9wdHM7CglzdHJ1Y3QgdGNw
X2tleSBrZXk7CgoJbXNzX25vdyA9IHRwLT5tc3NfY2FjaGU7CgoJaWYgKGRzdCkgewoJCXUzMiBt
dHUgPSBkc3RfbXR1KGRzdCk7CgkJaWYgKG10dSAhPSBpbmV0X2NzayhzayktPmljc2tfcG10dV9j
b29raWUpCgkJCW1zc19ub3cgPSB0Y3Bfc3luY19tc3Moc2ssIG10dSk7Cgl9Cgl0Y3BfZ2V0X2N1
cnJlbnRfa2V5KHNrLCAma2V5KTsKCWhlYWRlcl9sZW4gPSB0Y3BfZXN0YWJsaXNoZWRfb3B0aW9u
cyhzaywgTlVMTCwgJm9wdHMsICZrZXkpICsKCQkgICAgIHNpemVvZihzdHJ1Y3QgdGNwaGRyKTsK
CS8qIFRoZSBtc3NfY2FjaGUgaXMgc2l6ZWQgYmFzZWQgb24gdHAtPnRjcF9oZWFkZXJfbGVuLCB3
aGljaCBhc3N1bWVzCgkgKiBzb21lIGNvbW1vbiBvcHRpb25zLiBJZiB0aGlzIGlzIGFuIG9kZCBw
YWNrZXQgKGJlY2F1c2Ugd2UgaGF2ZSBTQUNLCgkgKiBibG9ja3MgZXRjKSB0aGVuIG91ciBjYWxj
dWxhdGVkIGhlYWRlcl9sZW4gd2lsbCBiZSBkaWZmZXJlbnQsIGFuZAoJICogd2UgaGF2ZSB0byBh
ZGp1c3QgbXNzX25vdyBjb3JyZXNwb25kaW5nbHkgKi8KCWlmIChoZWFkZXJfbGVuICE9IHRwLT50
Y3BfaGVhZGVyX2xlbikgewoJCWludCBkZWx0YSA9IChpbnQpIGhlYWRlcl9sZW4gLSB0cC0+dGNw
X2hlYWRlcl9sZW47CgkJbXNzX25vdyAtPSBkZWx0YTsKCX0KCglyZXR1cm4gbXNzX25vdzsKfQoK
LyogUkZDMjg2MSwgc2xvdyBwYXJ0LiBBZGp1c3QgY3duZCwgYWZ0ZXIgaXQgd2FzIG5vdCBmdWxs
IGR1cmluZyBvbmUgcnRvLgogKiBBcyBhZGRpdGlvbmFsIHByb3RlY3Rpb25zLCB3ZSBkbyBub3Qg
dG91Y2ggY3duZCBpbiByZXRyYW5zbWlzc2lvbiBwaGFzZXMsCiAqIGFuZCBpZiBhcHBsaWNhdGlv
biBoaXQgaXRzIHNuZGJ1ZiBsaW1pdCByZWNlbnRseS4KICovCnN0YXRpYyB2b2lkIHRjcF9jd25k
X2FwcGxpY2F0aW9uX2xpbWl0ZWQoc3RydWN0IHNvY2sgKnNrKQp7CglzdHJ1Y3QgdGNwX3NvY2sg
KnRwID0gdGNwX3NrKHNrKTsKCglpZiAoaW5ldF9jc2soc2spLT5pY3NrX2NhX3N0YXRlID09IFRD
UF9DQV9PcGVuICYmCgkgICAgc2stPnNrX3NvY2tldCAmJiAhdGVzdF9iaXQoU09DS19OT1NQQUNF
LCAmc2stPnNrX3NvY2tldC0+ZmxhZ3MpKSB7CgkJLyogTGltaXRlZCBieSBhcHBsaWNhdGlvbiBv
ciByZWNlaXZlciB3aW5kb3cuICovCgkJdTMyIGluaXRfd2luID0gdGNwX2luaXRfY3duZCh0cCwg
X19za19kc3RfZ2V0KHNrKSk7CgkJdTMyIHdpbl91c2VkID0gbWF4KHRwLT5zbmRfY3duZF91c2Vk
LCBpbml0X3dpbik7CgkJaWYgKHdpbl91c2VkIDwgdGNwX3NuZF9jd25kKHRwKSkgewoJCQl0cC0+
c25kX3NzdGhyZXNoID0gdGNwX2N1cnJlbnRfc3N0aHJlc2goc2spOwoJCQl0Y3Bfc25kX2N3bmRf
c2V0KHRwLCAodGNwX3NuZF9jd25kKHRwKSArIHdpbl91c2VkKSA+PiAxKTsKCQl9CgkJdHAtPnNu
ZF9jd25kX3VzZWQgPSAwOwoJfQoJdHAtPnNuZF9jd25kX3N0YW1wID0gdGNwX2ppZmZpZXMzMjsK
fQoKc3RhdGljIHZvaWQgdGNwX2N3bmRfdmFsaWRhdGUoc3RydWN0IHNvY2sgKnNrLCBib29sIGlz
X2N3bmRfbGltaXRlZCkKewoJY29uc3Qgc3RydWN0IHRjcF9jb25nZXN0aW9uX29wcyAqY2Ffb3Bz
ID0gaW5ldF9jc2soc2spLT5pY3NrX2NhX29wczsKCXN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bf
c2soc2spOwoKCS8qIFRyYWNrIHRoZSBzdHJvbmdlc3QgYXZhaWxhYmxlIHNpZ25hbCBvZiB0aGUg
ZGVncmVlIHRvIHdoaWNoIHRoZSBjd25kCgkgKiBpcyBmdWxseSB1dGlsaXplZC4gSWYgY3duZC1s
aW1pdGVkIHRoZW4gcmVtZW1iZXIgdGhhdCBmYWN0IGZvciB0aGUKCSAqIGN1cnJlbnQgd2luZG93
LiBJZiBub3QgY3duZC1saW1pdGVkIHRoZW4gdHJhY2sgdGhlIG1heGltdW0gbnVtYmVyIG9mCgkg
KiBvdXRzdGFuZGluZyBwYWNrZXRzIGluIHRoZSBjdXJyZW50IHdpbmRvdy4gKElmIGN3bmQtbGlt
aXRlZCB0aGVuIHdlCgkgKiBjaG9zZSB0byBub3QgdXBkYXRlIHRwLT5tYXhfcGFja2V0c19vdXQg
dG8gYXZvaWQgYW4gZXh0cmEgZWxzZQoJICogY2xhdXNlIHdpdGggbm8gZnVuY3Rpb25hbCBpbXBh
Y3QuKQoJICovCglpZiAoIWJlZm9yZSh0cC0+c25kX3VuYSwgdHAtPmN3bmRfdXNhZ2Vfc2VxKSB8
fAoJICAgIGlzX2N3bmRfbGltaXRlZCB8fAoJICAgICghdHAtPmlzX2N3bmRfbGltaXRlZCAmJgoJ
ICAgICB0cC0+cGFja2V0c19vdXQgPiB0cC0+bWF4X3BhY2tldHNfb3V0KSkgewoJCXRwLT5pc19j
d25kX2xpbWl0ZWQgPSBpc19jd25kX2xpbWl0ZWQ7CgkJdHAtPm1heF9wYWNrZXRzX291dCA9IHRw
LT5wYWNrZXRzX291dDsKCQl0cC0+Y3duZF91c2FnZV9zZXEgPSB0cC0+c25kX254dDsKCX0KCglp
ZiAodGNwX2lzX2N3bmRfbGltaXRlZChzaykpIHsKCQkvKiBOZXR3b3JrIGlzIGZlZWQgZnVsbHku
ICovCgkJdHAtPnNuZF9jd25kX3VzZWQgPSAwOwoJCXRwLT5zbmRfY3duZF9zdGFtcCA9IHRjcF9q
aWZmaWVzMzI7Cgl9IGVsc2UgewoJCS8qIE5ldHdvcmsgc3RhcnZlcy4gKi8KCQlpZiAodHAtPnBh
Y2tldHNfb3V0ID4gdHAtPnNuZF9jd25kX3VzZWQpCgkJCXRwLT5zbmRfY3duZF91c2VkID0gdHAt
PnBhY2tldHNfb3V0OwoKCQlpZiAoUkVBRF9PTkNFKHNvY2tfbmV0KHNrKS0+aXB2NC5zeXNjdGxf
dGNwX3Nsb3dfc3RhcnRfYWZ0ZXJfaWRsZSkgJiYKCQkgICAgKHMzMikodGNwX2ppZmZpZXMzMiAt
IHRwLT5zbmRfY3duZF9zdGFtcCkgPj0gaW5ldF9jc2soc2spLT5pY3NrX3J0byAmJgoJCSAgICAh
Y2Ffb3BzLT5jb25nX2NvbnRyb2wpCgkJCXRjcF9jd25kX2FwcGxpY2F0aW9uX2xpbWl0ZWQoc2sp
OwoKCQkvKiBUaGUgZm9sbG93aW5nIGNvbmRpdGlvbnMgdG9nZXRoZXIgaW5kaWNhdGUgdGhlIHN0
YXJ2YXRpb24KCQkgKiBpcyBjYXVzZWQgYnkgaW5zdWZmaWNpZW50IHNlbmRlciBidWZmZXI6CgkJ
ICogMSkganVzdCBzZW50IHNvbWUgZGF0YSAoc2VlIHRjcF93cml0ZV94bWl0KQoJCSAqIDIpIG5v
dCBjd25kIGxpbWl0ZWQgKHRoaXMgZWxzZSBjb25kaXRpb24pCgkJICogMykgbm8gbW9yZSBkYXRh
IHRvIHNlbmQgKHRjcF93cml0ZV9xdWV1ZV9lbXB0eSgpKQoJCSAqIDQpIGFwcGxpY2F0aW9uIGlz
IGhpdHRpbmcgYnVmZmVyIGxpbWl0IChTT0NLX05PU1BBQ0UpCgkJICovCgkJaWYgKHRjcF93cml0
ZV9xdWV1ZV9lbXB0eShzaykgJiYgc2stPnNrX3NvY2tldCAmJgoJCSAgICB0ZXN0X2JpdChTT0NL
X05PU1BBQ0UsICZzay0+c2tfc29ja2V0LT5mbGFncykgJiYKCQkgICAgKDEgPDwgc2stPnNrX3N0
YXRlKSAmIChUQ1BGX0VTVEFCTElTSEVEIHwgVENQRl9DTE9TRV9XQUlUKSkKCQkJdGNwX2Nocm9u
b19zdGFydChzaywgVENQX0NIUk9OT19TTkRCVUZfTElNSVRFRCk7Cgl9Cn0KCi8qIE1pbnNoYWxs
J3MgdmFyaWFudCBvZiB0aGUgTmFnbGUgc2VuZCBjaGVjay4gKi8Kc3RhdGljIGJvb2wgdGNwX21p
bnNoYWxsX2NoZWNrKGNvbnN0IHN0cnVjdCB0Y3Bfc29jayAqdHApCnsKCXJldHVybiBhZnRlcih0
cC0+c25kX3NtbCwgdHAtPnNuZF91bmEpICYmCgkJIWFmdGVyKHRwLT5zbmRfc21sLCB0cC0+c25k
X254dCk7Cn0KCi8qIFVwZGF0ZSBzbmRfc21sIGlmIHRoaXMgc2tiIGlzIHVuZGVyIG1zcwogKiBO
b3RlIHRoYXQgYSBUU08gcGFja2V0IG1pZ2h0IGVuZCB3aXRoIGEgc3ViLW1zcyBzZWdtZW50CiAq
IFRoZSB0ZXN0IGlzIHJlYWxseSA6CiAqIGlmICgoc2tiLT5sZW4gJSBtc3MpICE9IDApCiAqICAg
ICAgICB0cC0+c25kX3NtbCA9IFRDUF9TS0JfQ0Ioc2tiKS0+ZW5kX3NlcTsKICogQnV0IHdlIGNh
biBhdm9pZCBkb2luZyB0aGUgZGl2aWRlIGFnYWluIGdpdmVuIHdlIGFscmVhZHkgaGF2ZQogKiAg
c2tiX3Bjb3VudCA9IHNrYi0+bGVuIC8gbXNzX25vdwogKi8Kc3RhdGljIHZvaWQgdGNwX21pbnNo
YWxsX3VwZGF0ZShzdHJ1Y3QgdGNwX3NvY2sgKnRwLCB1bnNpZ25lZCBpbnQgbXNzX25vdywKCQkJ
CWNvbnN0IHN0cnVjdCBza19idWZmICpza2IpCnsKCWlmIChza2ItPmxlbiA8IHRjcF9za2JfcGNv
dW50KHNrYikgKiBtc3Nfbm93KQoJCXRwLT5zbmRfc21sID0gVENQX1NLQl9DQihza2IpLT5lbmRf
c2VxOwp9CgovKiBSZXR1cm4gZmFsc2UsIGlmIHBhY2tldCBjYW4gYmUgc2VudCBub3cgd2l0aG91
dCB2aW9sYXRpb24gTmFnbGUncyBydWxlczoKICogMS4gSXQgaXMgZnVsbCBzaXplZC4gKHByb3Zp
ZGVkIGJ5IGNhbGxlciBpbiAlcGFydGlhbCBib29sKQogKiAyLiBPciBpdCBjb250YWlucyBGSU4u
IChhbHJlYWR5IGNoZWNrZWQgYnkgY2FsbGVyKQogKiAzLiBPciBUQ1BfQ09SSyBpcyBub3Qgc2V0
LCBhbmQgVENQX05PREVMQVkgaXMgc2V0LgogKiA0LiBPciBUQ1BfQ09SSyBpcyBub3Qgc2V0LCBh
bmQgYWxsIHNlbnQgcGFja2V0cyBhcmUgQUNLZWQuCiAqICAgIFdpdGggTWluc2hhbGwncyBtb2Rp
ZmljYXRpb246IGFsbCBzZW50IHNtYWxsIHBhY2tldHMgYXJlIEFDS2VkLgogKi8Kc3RhdGljIGJv
b2wgdGNwX25hZ2xlX2NoZWNrKGJvb2wgcGFydGlhbCwgY29uc3Qgc3RydWN0IHRjcF9zb2NrICp0
cCwKCQkJICAgIGludCBub25hZ2xlKQp7CglyZXR1cm4gcGFydGlhbCAmJgoJCSgobm9uYWdsZSAm
IFRDUF9OQUdMRV9DT1JLKSB8fAoJCSAoIW5vbmFnbGUgJiYgdHAtPnBhY2tldHNfb3V0ICYmIHRj
cF9taW5zaGFsbF9jaGVjayh0cCkpKTsKfQoKLyogUmV0dXJuIGhvdyBtYW55IHNlZ3Mgd2UnZCBs
aWtlIG9uIGEgVFNPIHBhY2tldCwKICogZGVwZW5kaW5nIG9uIGN1cnJlbnQgcGFjaW5nIHJhdGUs
IGFuZCBob3cgY2xvc2UgdGhlIHBlZXIgaXMuCiAqCiAqIFJhdGlvbmFsZSBpczoKICogLSBGb3Ig
Y2xvc2UgcGVlcnMsIHdlIHJhdGhlciBzZW5kIGJpZ2dlciBwYWNrZXRzIHRvIHJlZHVjZQogKiAg
IGNwdSBjb3N0cywgYmVjYXVzZSBvY2Nhc2lvbmFsIGxvc3NlcyB3aWxsIGJlIHJlcGFpcmVkIGZh
c3QuCiAqIC0gRm9yIGxvbmcgZGlzdGFuY2UvcnR0IGZsb3dzLCB3ZSB3b3VsZCBsaWtlIHRvIGdl
dCBBQ0sgY2xvY2tpbmcKICogICB3aXRoIDEgQUNLIHBlciBtcy4KICoKICogVXNlIG1pbl9ydHQg
dG8gaGVscCBhZGFwdCBUU08gYnVyc3Qgc2l6ZSwgd2l0aCBzbWFsbGVyIG1pbl9ydHQgcmVzdWx0
aW5nCiAqIGluIGJpZ2dlciBUU08gYnVyc3RzLiBXZSB3ZSBjdXQgdGhlIFJUVC1iYXNlZCBhbGxv
d2FuY2UgaW4gaGFsZgogKiBmb3IgZXZlcnkgMl45IHVzZWMgKGFrYSA1MTIgdXMpIG9mIFJUVCwg
c28gdGhhdCB0aGUgUlRULWJhc2VkIGFsbG93YW5jZQogKiBpcyBiZWxvdyAxNTAwIGJ5dGVzIGFm
dGVyIDYgKiB+NTAwIHVzZWMgPSAzbXMuCiAqLwpzdGF0aWMgdTMyIHRjcF90c29fYXV0b3NpemUo
Y29uc3Qgc3RydWN0IHNvY2sgKnNrLCB1bnNpZ25lZCBpbnQgbXNzX25vdywKCQkJICAgIGludCBt
aW5fdHNvX3NlZ3MpCnsKCXVuc2lnbmVkIGxvbmcgYnl0ZXM7Cgl1MzIgcjsKCglieXRlcyA9IFJF
QURfT05DRShzay0+c2tfcGFjaW5nX3JhdGUpID4+IFJFQURfT05DRShzay0+c2tfcGFjaW5nX3No
aWZ0KTsKCglyID0gdGNwX21pbl9ydHQodGNwX3NrKHNrKSkgPj4gUkVBRF9PTkNFKHNvY2tfbmV0
KHNrKS0+aXB2NC5zeXNjdGxfdGNwX3Rzb19ydHRfbG9nKTsKCWlmIChyIDwgQklUU19QRVJfVFlQ
RShzay0+c2tfZ3NvX21heF9zaXplKSkKCQlieXRlcyArPSBzay0+c2tfZ3NvX21heF9zaXplID4+
IHI7CgoJYnl0ZXMgPSBtaW5fdCh1bnNpZ25lZCBsb25nLCBieXRlcywgc2stPnNrX2dzb19tYXhf
c2l6ZSk7CgoJcmV0dXJuIG1heF90KHUzMiwgYnl0ZXMgLyBtc3Nfbm93LCBtaW5fdHNvX3NlZ3Mp
Owp9CgovKiBSZXR1cm4gdGhlIG51bWJlciBvZiBzZWdtZW50cyB3ZSB3YW50IGluIHRoZSBza2Ig
d2UgYXJlIHRyYW5zbWl0dGluZy4KICogU2VlIGlmIGNvbmdlc3Rpb24gY29udHJvbCBtb2R1bGUg
d2FudHMgdG8gZGVjaWRlOyBvdGhlcndpc2UsIGF1dG9zaXplLgogKi8Kc3RhdGljIHUzMiB0Y3Bf
dHNvX3NlZ3Moc3RydWN0IHNvY2sgKnNrLCB1bnNpZ25lZCBpbnQgbXNzX25vdykKewoJY29uc3Qg
c3RydWN0IHRjcF9jb25nZXN0aW9uX29wcyAqY2Ffb3BzID0gaW5ldF9jc2soc2spLT5pY3NrX2Nh
X29wczsKCXUzMiBtaW5fdHNvLCB0c29fc2VnczsKCgltaW5fdHNvID0gY2Ffb3BzLT5taW5fdHNv
X3NlZ3MgPwoJCQljYV9vcHMtPm1pbl90c29fc2VncyhzaykgOgoJCQlSRUFEX09OQ0Uoc29ja19u
ZXQoc2spLT5pcHY0LnN5c2N0bF90Y3BfbWluX3Rzb19zZWdzKTsKCgl0c29fc2VncyA9IHRjcF90
c29fYXV0b3NpemUoc2ssIG1zc19ub3csIG1pbl90c28pOwoJcmV0dXJuIG1pbl90KHUzMiwgdHNv
X3NlZ3MsIHNrLT5za19nc29fbWF4X3NlZ3MpOwp9CgovKiBSZXR1cm5zIHRoZSBwb3J0aW9uIG9m
IHNrYiB3aGljaCBjYW4gYmUgc2VudCByaWdodCBhd2F5ICovCnN0YXRpYyB1bnNpZ25lZCBpbnQg
dGNwX21zc19zcGxpdF9wb2ludChjb25zdCBzdHJ1Y3Qgc29jayAqc2ssCgkJCQkJY29uc3Qgc3Ry
dWN0IHNrX2J1ZmYgKnNrYiwKCQkJCQl1bnNpZ25lZCBpbnQgbXNzX25vdywKCQkJCQl1bnNpZ25l
ZCBpbnQgbWF4X3NlZ3MsCgkJCQkJaW50IG5vbmFnbGUpCnsKCWNvbnN0IHN0cnVjdCB0Y3Bfc29j
ayAqdHAgPSB0Y3Bfc2soc2spOwoJdTMyIHBhcnRpYWwsIG5lZWRlZCwgd2luZG93LCBtYXhfbGVu
OwoKCXdpbmRvdyA9IHRjcF93bmRfZW5kKHRwKSAtIFRDUF9TS0JfQ0Ioc2tiKS0+c2VxOwoJbWF4
X2xlbiA9IG1zc19ub3cgKiBtYXhfc2VnczsKCglpZiAobGlrZWx5KG1heF9sZW4gPD0gd2luZG93
ICYmIHNrYiAhPSB0Y3Bfd3JpdGVfcXVldWVfdGFpbChzaykpKQoJCXJldHVybiBtYXhfbGVuOwoK
CW5lZWRlZCA9IG1pbihza2ItPmxlbiwgd2luZG93KTsKCglpZiAobWF4X2xlbiA8PSBuZWVkZWQp
CgkJcmV0dXJuIG1heF9sZW47CgoJcGFydGlhbCA9IG5lZWRlZCAlIG1zc19ub3c7CgkvKiBJZiBs
YXN0IHNlZ21lbnQgaXMgbm90IGEgZnVsbCBNU1MsIGNoZWNrIGlmIE5hZ2xlIHJ1bGVzIGFsbG93
IHVzCgkgKiB0byBpbmNsdWRlIHRoaXMgbGFzdCBzZWdtZW50IGluIHRoaXMgc2tiLgoJICogT3Ro
ZXJ3aXNlLCB3ZSdsbCBzcGxpdCB0aGUgc2tiIGF0IGxhc3QgTVNTIGJvdW5kYXJ5CgkgKi8KCWlm
ICh0Y3BfbmFnbGVfY2hlY2socGFydGlhbCAhPSAwLCB0cCwgbm9uYWdsZSkpCgkJcmV0dXJuIG5l
ZWRlZCAtIHBhcnRpYWw7CgoJcmV0dXJuIG5lZWRlZDsKfQoKLyogQ2FuIGF0IGxlYXN0IG9uZSBz
ZWdtZW50IG9mIFNLQiBiZSBzZW50IHJpZ2h0IG5vdywgYWNjb3JkaW5nIHRvIHRoZQogKiBjb25n
ZXN0aW9uIHdpbmRvdyBydWxlcz8gIElmIHNvLCByZXR1cm4gaG93IG1hbnkgc2VnbWVudHMgYXJl
IGFsbG93ZWQuCiAqLwpzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCB0Y3BfY3duZF90ZXN0KGNv
bnN0IHN0cnVjdCB0Y3Bfc29jayAqdHAsCgkJCQkJIGNvbnN0IHN0cnVjdCBza19idWZmICpza2Ip
CnsKCXUzMiBpbl9mbGlnaHQsIGN3bmQsIGhhbGZjd25kOwoKCS8qIERvbid0IGJlIHN0cmljdCBh
Ym91dCB0aGUgY29uZ2VzdGlvbiB3aW5kb3cgZm9yIHRoZSBmaW5hbCBGSU4uICAqLwoJaWYgKChU
Q1BfU0tCX0NCKHNrYiktPnRjcF9mbGFncyAmIFRDUEhEUl9GSU4pICYmCgkgICAgdGNwX3NrYl9w
Y291bnQoc2tiKSA9PSAxKQoJCXJldHVybiAxOwoKCWluX2ZsaWdodCA9IHRjcF9wYWNrZXRzX2lu
X2ZsaWdodCh0cCk7Cgljd25kID0gdGNwX3NuZF9jd25kKHRwKTsKCWlmIChpbl9mbGlnaHQgPj0g
Y3duZCkKCQlyZXR1cm4gMDsKCgkvKiBGb3IgYmV0dGVyIHNjaGVkdWxpbmcsIGVuc3VyZSB3ZSBo
YXZlIGF0IGxlYXN0CgkgKiAyIEdTTyBwYWNrZXRzIGluIGZsaWdodC4KCSAqLwoJaGFsZmN3bmQg
PSBtYXgoY3duZCA+PiAxLCAxVSk7CglyZXR1cm4gbWluKGhhbGZjd25kLCBjd25kIC0gaW5fZmxp
Z2h0KTsKfQoKLyogSW5pdGlhbGl6ZSBUU08gc3RhdGUgb2YgYSBza2IuCiAqIFRoaXMgbXVzdCBi
ZSBpbnZva2VkIHRoZSBmaXJzdCB0aW1lIHdlIGNvbnNpZGVyIHRyYW5zbWl0dGluZwogKiBTS0Ig
b250byB0aGUgd2lyZS4KICovCnN0YXRpYyBpbnQgdGNwX2luaXRfdHNvX3NlZ3Moc3RydWN0IHNr
X2J1ZmYgKnNrYiwgdW5zaWduZWQgaW50IG1zc19ub3cpCnsKCWludCB0c29fc2VncyA9IHRjcF9z
a2JfcGNvdW50KHNrYik7CgoJaWYgKCF0c29fc2VncyB8fCAodHNvX3NlZ3MgPiAxICYmIHRjcF9z
a2JfbXNzKHNrYikgIT0gbXNzX25vdykpIHsKCQl0Y3Bfc2V0X3NrYl90c29fc2Vncyhza2IsIG1z
c19ub3cpOwoJCXRzb19zZWdzID0gdGNwX3NrYl9wY291bnQoc2tiKTsKCX0KCXJldHVybiB0c29f
c2VnczsKfQoKCi8qIFJldHVybiB0cnVlIGlmIHRoZSBOYWdsZSB0ZXN0IGFsbG93cyB0aGlzIHBh
Y2tldCB0byBiZQogKiBzZW50IG5vdy4KICovCnN0YXRpYyBpbmxpbmUgYm9vbCB0Y3BfbmFnbGVf
dGVzdChjb25zdCBzdHJ1Y3QgdGNwX3NvY2sgKnRwLCBjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2ti
LAoJCQkJICB1bnNpZ25lZCBpbnQgY3VyX21zcywgaW50IG5vbmFnbGUpCnsKCS8qIE5hZ2xlIHJ1
bGUgZG9lcyBub3QgYXBwbHkgdG8gZnJhbWVzLCB3aGljaCBzaXQgaW4gdGhlIG1pZGRsZSBvZiB0
aGUKCSAqIHdyaXRlX3F1ZXVlICh0aGV5IGhhdmUgbm8gY2hhbmNlcyB0byBnZXQgbmV3IGRhdGEp
LgoJICoKCSAqIFRoaXMgaXMgaW1wbGVtZW50ZWQgaW4gdGhlIGNhbGxlcnMsIHdoZXJlIHRoZXkg
bW9kaWZ5IHRoZSAnbm9uYWdsZScKCSAqIGFyZ3VtZW50IGJhc2VkIHVwb24gdGhlIGxvY2F0aW9u
IG9mIFNLQiBpbiB0aGUgc2VuZCBxdWV1ZS4KCSAqLwoJaWYgKG5vbmFnbGUgJiBUQ1BfTkFHTEVf
UFVTSCkKCQlyZXR1cm4gdHJ1ZTsKCgkvKiBEb24ndCB1c2UgdGhlIG5hZ2xlIHJ1bGUgZm9yIHVy
Z2VudCBkYXRhIChvciBmb3IgdGhlIGZpbmFsIEZJTikuICovCglpZiAodGNwX3VyZ19tb2RlKHRw
KSB8fCAoVENQX1NLQl9DQihza2IpLT50Y3BfZmxhZ3MgJiBUQ1BIRFJfRklOKSkKCQlyZXR1cm4g
dHJ1ZTsKCglpZiAoIXRjcF9uYWdsZV9jaGVjayhza2ItPmxlbiA8IGN1cl9tc3MsIHRwLCBub25h
Z2xlKSkKCQlyZXR1cm4gdHJ1ZTsKCglyZXR1cm4gZmFsc2U7Cn0KCi8qIERvZXMgYXQgbGVhc3Qg
dGhlIGZpcnN0IHNlZ21lbnQgb2YgU0tCIGZpdCBpbnRvIHRoZSBzZW5kIHdpbmRvdz8gKi8Kc3Rh
dGljIGJvb2wgdGNwX3NuZF93bmRfdGVzdChjb25zdCBzdHJ1Y3QgdGNwX3NvY2sgKnRwLAoJCQkg
ICAgIGNvbnN0IHN0cnVjdCBza19idWZmICpza2IsCgkJCSAgICAgdW5zaWduZWQgaW50IGN1cl9t
c3MpCnsKCXUzMiBlbmRfc2VxID0gVENQX1NLQl9DQihza2IpLT5lbmRfc2VxOwoKCWlmIChza2It
PmxlbiA+IGN1cl9tc3MpCgkJZW5kX3NlcSA9IFRDUF9TS0JfQ0Ioc2tiKS0+c2VxICsgY3VyX21z
czsKCglyZXR1cm4gIWFmdGVyKGVuZF9zZXEsIHRjcF93bmRfZW5kKHRwKSk7Cn0KCi8qIFRyaW0g
VFNPIFNLQiB0byBMRU4gYnl0ZXMsIHB1dCB0aGUgcmVtYWluaW5nIGRhdGEgaW50byBhIG5ldyBw
YWNrZXQKICogd2hpY2ggaXMgcHV0IGFmdGVyIFNLQiBvbiB0aGUgbGlzdC4gIEl0IGlzIHZlcnkg
bXVjaCBsaWtlCiAqIHRjcF9mcmFnbWVudCgpIGV4Y2VwdCB0aGF0IGl0IG1heSBtYWtlIHNldmVy
YWwga2luZHMgb2YgYXNzdW1wdGlvbnMKICogaW4gb3JkZXIgdG8gc3BlZWQgdXAgdGhlIHNwbGl0
dGluZyBvcGVyYXRpb24uICBJbiBwYXJ0aWN1bGFyLCB3ZQogKiBrbm93IHRoYXQgYWxsIHRoZSBk
YXRhIGlzIGluIHNjYXR0ZXItZ2F0aGVyIHBhZ2VzLCBhbmQgdGhhdCB0aGUKICogcGFja2V0IGhh
cyBuZXZlciBiZWVuIHNlbnQgb3V0IGJlZm9yZSAoYW5kIHRodXMgaXMgbm90IGNsb25lZCkuCiAq
LwpzdGF0aWMgaW50IHRzb19mcmFnbWVudChzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBza19idWZm
ICpza2IsIHVuc2lnbmVkIGludCBsZW4sCgkJCXVuc2lnbmVkIGludCBtc3Nfbm93LCBnZnBfdCBn
ZnApCnsKCWludCBubGVuID0gc2tiLT5sZW4gLSBsZW47CglzdHJ1Y3Qgc2tfYnVmZiAqYnVmZjsK
CXU4IGZsYWdzOwoKCS8qIEFsbCBvZiBhIFRTTyBmcmFtZSBtdXN0IGJlIGNvbXBvc2VkIG9mIHBh
Z2VkIGRhdGEuICAqLwoJREVCVUdfTkVUX1dBUk5fT05fT05DRShza2ItPmxlbiAhPSBza2ItPmRh
dGFfbGVuKTsKCglidWZmID0gdGNwX3N0cmVhbV9hbGxvY19za2Ioc2ssIGdmcCwgdHJ1ZSk7Cglp
ZiAodW5saWtlbHkoIWJ1ZmYpKQoJCXJldHVybiAtRU5PTUVNOwoJc2tiX2NvcHlfZGVjcnlwdGVk
KGJ1ZmYsIHNrYik7CgltcHRjcF9za2JfZXh0X2NvcHkoYnVmZiwgc2tiKTsKCglza193bWVtX3F1
ZXVlZF9hZGQoc2ssIGJ1ZmYtPnRydWVzaXplKTsKCXNrX21lbV9jaGFyZ2Uoc2ssIGJ1ZmYtPnRy
dWVzaXplKTsKCWJ1ZmYtPnRydWVzaXplICs9IG5sZW47Cglza2ItPnRydWVzaXplIC09IG5sZW47
CgoJLyogQ29ycmVjdCB0aGUgc2VxdWVuY2UgbnVtYmVycy4gKi8KCVRDUF9TS0JfQ0IoYnVmZikt
PnNlcSA9IFRDUF9TS0JfQ0Ioc2tiKS0+c2VxICsgbGVuOwoJVENQX1NLQl9DQihidWZmKS0+ZW5k
X3NlcSA9IFRDUF9TS0JfQ0Ioc2tiKS0+ZW5kX3NlcTsKCVRDUF9TS0JfQ0Ioc2tiKS0+ZW5kX3Nl
cSA9IFRDUF9TS0JfQ0IoYnVmZiktPnNlcTsKCgkvKiBQU0ggYW5kIEZJTiBzaG91bGQgb25seSBi
ZSBzZXQgaW4gdGhlIHNlY29uZCBwYWNrZXQuICovCglmbGFncyA9IFRDUF9TS0JfQ0Ioc2tiKS0+
dGNwX2ZsYWdzOwoJVENQX1NLQl9DQihza2IpLT50Y3BfZmxhZ3MgPSBmbGFncyAmIH4oVENQSERS
X0ZJTiB8IFRDUEhEUl9QU0gpOwoJVENQX1NLQl9DQihidWZmKS0+dGNwX2ZsYWdzID0gZmxhZ3M7
CgoJdGNwX3NrYl9mcmFnbWVudF9lb3Ioc2tiLCBidWZmKTsKCglza2Jfc3BsaXQoc2tiLCBidWZm
LCBsZW4pOwoJdGNwX2ZyYWdtZW50X3RzdGFtcChza2IsIGJ1ZmYpOwoKCS8qIEZpeCB1cCB0c29f
ZmFjdG9yIGZvciBib3RoIG9yaWdpbmFsIGFuZCBuZXcgU0tCLiAgKi8KCXRjcF9zZXRfc2tiX3Rz
b19zZWdzKHNrYiwgbXNzX25vdyk7Cgl0Y3Bfc2V0X3NrYl90c29fc2VncyhidWZmLCBtc3Nfbm93
KTsKCgkvKiBMaW5rIEJVRkYgaW50byB0aGUgc2VuZCBxdWV1ZS4gKi8KCV9fc2tiX2hlYWRlcl9y
ZWxlYXNlKGJ1ZmYpOwoJdGNwX2luc2VydF93cml0ZV9xdWV1ZV9hZnRlcihza2IsIGJ1ZmYsIHNr
LCBUQ1BfRlJBR19JTl9XUklURV9RVUVVRSk7CgoJcmV0dXJuIDA7Cn0KCi8qIFRyeSB0byBkZWZl
ciBzZW5kaW5nLCBpZiBwb3NzaWJsZSwgaW4gb3JkZXIgdG8gbWluaW1pemUgdGhlIGFtb3VudAog
KiBvZiBUU08gc3BsaXR0aW5nIHdlIGRvLiAgVmlldyBpdCBhcyBhIGtpbmQgb2YgVFNPIE5hZ2xl
IHRlc3QuCiAqCiAqIFRoaXMgYWxnb3JpdGhtIGlzIGZyb20gSm9obiBIZWZmbmVyLgogKi8Kc3Rh
dGljIGJvb2wgdGNwX3Rzb19zaG91bGRfZGVmZXIoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tf
YnVmZiAqc2tiLAoJCQkJIGJvb2wgKmlzX2N3bmRfbGltaXRlZCwKCQkJCSBib29sICppc19yd25k
X2xpbWl0ZWQsCgkJCQkgdTMyIG1heF9zZWdzKQp7Cgljb25zdCBzdHJ1Y3QgaW5ldF9jb25uZWN0
aW9uX3NvY2sgKmljc2sgPSBpbmV0X2Nzayhzayk7Cgl1MzIgc2VuZF93aW4sIGNvbmdfd2luLCBs
aW1pdCwgaW5fZmxpZ2h0OwoJc3RydWN0IHRjcF9zb2NrICp0cCA9IHRjcF9zayhzayk7CglzdHJ1
Y3Qgc2tfYnVmZiAqaGVhZDsKCWludCB3aW5fZGl2aXNvcjsKCXM2NCBkZWx0YTsKCglpZiAoaWNz
ay0+aWNza19jYV9zdGF0ZSA+PSBUQ1BfQ0FfUmVjb3ZlcnkpCgkJZ290byBzZW5kX25vdzsKCgkv
KiBBdm9pZCBidXJzdHkgYmVoYXZpb3IgYnkgYWxsb3dpbmcgZGVmZXIKCSAqIG9ubHkgaWYgdGhl
IGxhc3Qgd3JpdGUgd2FzIHJlY2VudCAoMSBtcykuCgkgKiBOb3RlIHRoYXQgdHAtPnRjcF93c3Rh
bXBfbnMgY2FuIGJlIGluIHRoZSBmdXR1cmUgaWYgd2UgaGF2ZQoJICogcGFja2V0cyB3YWl0aW5n
IGluIGEgcWRpc2Mgb3IgZGV2aWNlIGZvciBFRFQgZGVsaXZlcnkuCgkgKi8KCWRlbHRhID0gdHAt
PnRjcF9jbG9ja19jYWNoZSAtIHRwLT50Y3Bfd3N0YW1wX25zIC0gTlNFQ19QRVJfTVNFQzsKCWlm
IChkZWx0YSA+IDApCgkJZ290byBzZW5kX25vdzsKCglpbl9mbGlnaHQgPSB0Y3BfcGFja2V0c19p
bl9mbGlnaHQodHApOwoKCUJVR19PTih0Y3Bfc2tiX3Bjb3VudChza2IpIDw9IDEpOwoJQlVHX09O
KHRjcF9zbmRfY3duZCh0cCkgPD0gaW5fZmxpZ2h0KTsKCglzZW5kX3dpbiA9IHRjcF93bmRfZW5k
KHRwKSAtIFRDUF9TS0JfQ0Ioc2tiKS0+c2VxOwoKCS8qIEZyb20gaW5fZmxpZ2h0IHRlc3QgYWJv
dmUsIHdlIGtub3cgdGhhdCBjd25kID4gaW5fZmxpZ2h0LiAgKi8KCWNvbmdfd2luID0gKHRjcF9z
bmRfY3duZCh0cCkgLSBpbl9mbGlnaHQpICogdHAtPm1zc19jYWNoZTsKCglsaW1pdCA9IG1pbihz
ZW5kX3dpbiwgY29uZ193aW4pOwoKCS8qIElmIGEgZnVsbC1zaXplZCBUU08gc2tiIGNhbiBiZSBz
ZW50LCBkbyBpdC4gKi8KCWlmIChsaW1pdCA+PSBtYXhfc2VncyAqIHRwLT5tc3NfY2FjaGUpCgkJ
Z290byBzZW5kX25vdzsKCgkvKiBNaWRkbGUgaW4gcXVldWUgd29uJ3QgZ2V0IGFueSBtb3JlIGRh
dGEsIGZ1bGwgc2VuZGFibGUgYWxyZWFkeT8gKi8KCWlmICgoc2tiICE9IHRjcF93cml0ZV9xdWV1
ZV90YWlsKHNrKSkgJiYgKGxpbWl0ID49IHNrYi0+bGVuKSkKCQlnb3RvIHNlbmRfbm93OwoKCXdp
bl9kaXZpc29yID0gUkVBRF9PTkNFKHNvY2tfbmV0KHNrKS0+aXB2NC5zeXNjdGxfdGNwX3Rzb193
aW5fZGl2aXNvcik7CglpZiAod2luX2Rpdmlzb3IpIHsKCQl1MzIgY2h1bmsgPSBtaW4odHAtPnNu
ZF93bmQsIHRjcF9zbmRfY3duZCh0cCkgKiB0cC0+bXNzX2NhY2hlKTsKCgkJLyogSWYgYXQgbGVh
c3Qgc29tZSBmcmFjdGlvbiBvZiBhIHdpbmRvdyBpcyBhdmFpbGFibGUsCgkJICoganVzdCB1c2Ug
aXQuCgkJICovCgkJY2h1bmsgLz0gd2luX2Rpdmlzb3I7CgkJaWYgKGxpbWl0ID49IGNodW5rKQoJ
CQlnb3RvIHNlbmRfbm93OwoJfSBlbHNlIHsKCQkvKiBEaWZmZXJlbnQgYXBwcm9hY2gsIHRyeSBu
b3QgdG8gZGVmZXIgcGFzdCBhIHNpbmdsZQoJCSAqIEFDSy4gIFJlY2VpdmVyIHNob3VsZCBBQ0sg
ZXZlcnkgb3RoZXIgZnVsbCBzaXplZAoJCSAqIGZyYW1lLCBzbyBpZiB3ZSBoYXZlIHNwYWNlIGZv
ciBtb3JlIHRoYW4gMyBmcmFtZXMKCQkgKiB0aGVuIHNlbmQgbm93LgoJCSAqLwoJCWlmIChsaW1p
dCA+IHRjcF9tYXhfdHNvX2RlZmVycmVkX21zcyh0cCkgKiB0cC0+bXNzX2NhY2hlKQoJCQlnb3Rv
IHNlbmRfbm93OwoJfQoKCS8qIFRPRE8gOiB1c2UgdHNvcnRlZF9zZW50X3F1ZXVlID8gKi8KCWhl
YWQgPSB0Y3BfcnR4X3F1ZXVlX2hlYWQoc2spOwoJaWYgKCFoZWFkKQoJCWdvdG8gc2VuZF9ub3c7
CglkZWx0YSA9IHRwLT50Y3BfY2xvY2tfY2FjaGUgLSBoZWFkLT50c3RhbXA7CgkvKiBJZiBuZXh0
IEFDSyBpcyBsaWtlbHkgdG8gY29tZSB0b28gbGF0ZSAoaGFsZiBzcnR0KSwgZG8gbm90IGRlZmVy
ICovCglpZiAoKHM2NCkoZGVsdGEgLSAodTY0KU5TRUNfUEVSX1VTRUMgKiAodHAtPnNydHRfdXMg
Pj4gNCkpIDwgMCkKCQlnb3RvIHNlbmRfbm93OwoKCS8qIE9rLCBpdCBsb29rcyBsaWtlIGl0IGlz
IGFkdmlzYWJsZSB0byBkZWZlci4KCSAqIFRocmVlIGNhc2VzIGFyZSB0cmFja2VkIDoKCSAqIDEp
IFdlIGFyZSBjd25kLWxpbWl0ZWQKCSAqIDIpIFdlIGFyZSByd25kLWxpbWl0ZWQKCSAqIDMpIFdl
IGFyZSBhcHBsaWNhdGlvbiBsaW1pdGVkLgoJICovCglpZiAoY29uZ193aW4gPCBzZW5kX3dpbikg
ewoJCWlmIChjb25nX3dpbiA8PSBza2ItPmxlbikgewoJCQkqaXNfY3duZF9saW1pdGVkID0gdHJ1
ZTsKCQkJcmV0dXJuIHRydWU7CgkJfQoJfSBlbHNlIHsKCQlpZiAoc2VuZF93aW4gPD0gc2tiLT5s
ZW4pIHsKCQkJKmlzX3J3bmRfbGltaXRlZCA9IHRydWU7CgkJCXJldHVybiB0cnVlOwoJCX0KCX0K
CgkvKiBJZiB0aGlzIHBhY2tldCB3b24ndCBnZXQgbW9yZSBkYXRhLCBkbyBub3Qgd2FpdC4gKi8K
CWlmICgoVENQX1NLQl9DQihza2IpLT50Y3BfZmxhZ3MgJiBUQ1BIRFJfRklOKSB8fAoJICAgIFRD
UF9TS0JfQ0Ioc2tiKS0+ZW9yKQoJCWdvdG8gc2VuZF9ub3c7CgoJcmV0dXJuIHRydWU7CgpzZW5k
X25vdzoKCXJldHVybiBmYWxzZTsKfQoKc3RhdGljIGlubGluZSB2b2lkIHRjcF9tdHVfY2hlY2tf
cmVwcm9iZShzdHJ1Y3Qgc29jayAqc2spCnsKCXN0cnVjdCBpbmV0X2Nvbm5lY3Rpb25fc29jayAq
aWNzayA9IGluZXRfY3NrKHNrKTsKCXN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOwoJ
c3RydWN0IG5ldCAqbmV0ID0gc29ja19uZXQoc2spOwoJdTMyIGludGVydmFsOwoJczMyIGRlbHRh
OwoKCWludGVydmFsID0gUkVBRF9PTkNFKG5ldC0+aXB2NC5zeXNjdGxfdGNwX3Byb2JlX2ludGVy
dmFsKTsKCWRlbHRhID0gdGNwX2ppZmZpZXMzMiAtIGljc2stPmljc2tfbXR1cC5wcm9iZV90aW1l
c3RhbXA7CglpZiAodW5saWtlbHkoZGVsdGEgPj0gaW50ZXJ2YWwgKiBIWikpIHsKCQlpbnQgbXNz
ID0gdGNwX2N1cnJlbnRfbXNzKHNrKTsKCgkJLyogVXBkYXRlIGN1cnJlbnQgc2VhcmNoIHJhbmdl
ICovCgkJaWNzay0+aWNza19tdHVwLnByb2JlX3NpemUgPSAwOwoJCWljc2stPmljc2tfbXR1cC5z
ZWFyY2hfaGlnaCA9IHRwLT5yeF9vcHQubXNzX2NsYW1wICsKCQkJc2l6ZW9mKHN0cnVjdCB0Y3Bo
ZHIpICsKCQkJaWNzay0+aWNza19hZl9vcHMtPm5ldF9oZWFkZXJfbGVuOwoJCWljc2stPmljc2tf
bXR1cC5zZWFyY2hfbG93ID0gdGNwX21zc190b19tdHUoc2ssIG1zcyk7CgoJCS8qIFVwZGF0ZSBw
cm9iZSB0aW1lIHN0YW1wICovCgkJaWNzay0+aWNza19tdHVwLnByb2JlX3RpbWVzdGFtcCA9IHRj
cF9qaWZmaWVzMzI7Cgl9Cn0KCnN0YXRpYyBib29sIHRjcF9jYW5fY29hbGVzY2Vfc2VuZF9xdWV1
ZV9oZWFkKHN0cnVjdCBzb2NrICpzaywgaW50IGxlbikKewoJc3RydWN0IHNrX2J1ZmYgKnNrYiwg
Km5leHQ7CgoJc2tiID0gdGNwX3NlbmRfaGVhZChzayk7Cgl0Y3BfZm9yX3dyaXRlX3F1ZXVlX2Zy
b21fc2FmZShza2IsIG5leHQsIHNrKSB7CgkJaWYgKGxlbiA8PSBza2ItPmxlbikKCQkJYnJlYWs7
CgoJCWlmICh1bmxpa2VseShUQ1BfU0tCX0NCKHNrYiktPmVvcikgfHwKCQkgICAgdGNwX2hhc190
eF90c3RhbXAoc2tiKSB8fAoJCSAgICAhc2tiX3B1cmVfemNvcHlfc2FtZShza2IsIG5leHQpKQoJ
CQlyZXR1cm4gZmFsc2U7CgoJCWxlbiAtPSBza2ItPmxlbjsKCX0KCglyZXR1cm4gdHJ1ZTsKfQoK
c3RhdGljIGludCB0Y3BfY2xvbmVfcGF5bG9hZChzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBza19i
dWZmICp0bywKCQkJICAgICBpbnQgcHJvYmVfc2l6ZSkKewoJc2tiX2ZyYWdfdCAqbGFzdGZyYWcg
PSBOVUxMLCAqZnJhZ3RvID0gc2tiX3NoaW5mbyh0byktPmZyYWdzOwoJaW50IGksIHRvZG8sIGxl
biA9IDAsIG5yX2ZyYWdzID0gMDsKCWNvbnN0IHN0cnVjdCBza19idWZmICpza2I7CgoJaWYgKCFz
a193bWVtX3NjaGVkdWxlKHNrLCB0by0+dHJ1ZXNpemUgKyBwcm9iZV9zaXplKSkKCQlyZXR1cm4g
LUVOT01FTTsKCglza2JfcXVldWVfd2Fsaygmc2stPnNrX3dyaXRlX3F1ZXVlLCBza2IpIHsKCQlj
b25zdCBza2JfZnJhZ190ICpmcmFnZnJvbSA9IHNrYl9zaGluZm8oc2tiKS0+ZnJhZ3M7CgoJCWlm
IChza2JfaGVhZGxlbihza2IpKQoJCQlyZXR1cm4gLUVJTlZBTDsKCgkJZm9yIChpID0gMDsgaSA8
IHNrYl9zaGluZm8oc2tiKS0+bnJfZnJhZ3M7IGkrKywgZnJhZ2Zyb20rKykgewoJCQlpZiAobGVu
ID49IHByb2JlX3NpemUpCgkJCQlnb3RvIGNvbW1pdDsKCQkJdG9kbyA9IG1pbl90KGludCwgc2ti
X2ZyYWdfc2l6ZShmcmFnZnJvbSksCgkJCQkgICAgIHByb2JlX3NpemUgLSBsZW4pOwoJCQlsZW4g
Kz0gdG9kbzsKCQkJaWYgKGxhc3RmcmFnICYmCgkJCSAgICBza2JfZnJhZ19wYWdlKGZyYWdmcm9t
KSA9PSBza2JfZnJhZ19wYWdlKGxhc3RmcmFnKSAmJgoJCQkgICAgc2tiX2ZyYWdfb2ZmKGZyYWdm
cm9tKSA9PSBza2JfZnJhZ19vZmYobGFzdGZyYWcpICsKCQkJCQkJICAgICAgc2tiX2ZyYWdfc2l6
ZShsYXN0ZnJhZykpIHsKCQkJCXNrYl9mcmFnX3NpemVfYWRkKGxhc3RmcmFnLCB0b2RvKTsKCQkJ
CWNvbnRpbnVlOwoJCQl9CgkJCWlmICh1bmxpa2VseShucl9mcmFncyA9PSBNQVhfU0tCX0ZSQUdT
KSkKCQkJCXJldHVybiAtRTJCSUc7CgkJCXNrYl9mcmFnX3BhZ2VfY29weShmcmFndG8sIGZyYWdm
cm9tKTsKCQkJc2tiX2ZyYWdfb2ZmX2NvcHkoZnJhZ3RvLCBmcmFnZnJvbSk7CgkJCXNrYl9mcmFn
X3NpemVfc2V0KGZyYWd0bywgdG9kbyk7CgkJCW5yX2ZyYWdzKys7CgkJCWxhc3RmcmFnID0gZnJh
Z3RvKys7CgkJfQoJfQpjb21taXQ6CglXQVJOX09OX09OQ0UobGVuICE9IHByb2JlX3NpemUpOwoJ
Zm9yIChpID0gMDsgaSA8IG5yX2ZyYWdzOyBpKyspCgkJc2tiX2ZyYWdfcmVmKHRvLCBpKTsKCglz
a2Jfc2hpbmZvKHRvKS0+bnJfZnJhZ3MgPSBucl9mcmFnczsKCXRvLT50cnVlc2l6ZSArPSBwcm9i
ZV9zaXplOwoJdG8tPmxlbiArPSBwcm9iZV9zaXplOwoJdG8tPmRhdGFfbGVuICs9IHByb2JlX3Np
emU7CglfX3NrYl9oZWFkZXJfcmVsZWFzZSh0byk7CglyZXR1cm4gMDsKfQoKLyogQ3JlYXRlIGEg
bmV3IE1UVSBwcm9iZSBpZiB3ZSBhcmUgcmVhZHkuCiAqIE1UVSBwcm9iZSBpcyByZWd1bGFybHkg
YXR0ZW1wdGluZyB0byBpbmNyZWFzZSB0aGUgcGF0aCBNVFUgYnkKICogZGVsaWJlcmF0ZWx5IHNl
bmRpbmcgbGFyZ2VyIHBhY2tldHMuICBUaGlzIGRpc2NvdmVycyByb3V0aW5nCiAqIGNoYW5nZXMg
cmVzdWx0aW5nIGluIGxhcmdlciBwYXRoIE1UVXMuCiAqCiAqIFJldHVybnMgMCBpZiB3ZSBzaG91
bGQgd2FpdCB0byBwcm9iZSAobm8gY3duZCBhdmFpbGFibGUpLAogKiAgICAgICAgIDEgaWYgYSBw
cm9iZSB3YXMgc2VudCwKICogICAgICAgICAtMSBvdGhlcndpc2UKICovCnN0YXRpYyBpbnQgdGNw
X210dV9wcm9iZShzdHJ1Y3Qgc29jayAqc2spCnsKCXN0cnVjdCBpbmV0X2Nvbm5lY3Rpb25fc29j
ayAqaWNzayA9IGluZXRfY3NrKHNrKTsKCXN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2sp
OwoJc3RydWN0IHNrX2J1ZmYgKnNrYiwgKm5za2IsICpuZXh0OwoJc3RydWN0IG5ldCAqbmV0ID0g
c29ja19uZXQoc2spOwoJaW50IHByb2JlX3NpemU7CglpbnQgc2l6ZV9uZWVkZWQ7CglpbnQgY29w
eSwgbGVuOwoJaW50IG1zc19ub3c7CglpbnQgaW50ZXJ2YWw7CgoJLyogTm90IGN1cnJlbnRseSBw
cm9iaW5nL3ZlcmlmeWluZywKCSAqIG5vdCBpbiByZWNvdmVyeSwKCSAqIGhhdmUgZW5vdWdoIGN3
bmQsIGFuZAoJICogbm90IFNBQ0tpbmcgKHRoZSB2YXJpYWJsZSBoZWFkZXJzIHRocm93IHRoaW5n
cyBvZmYpCgkgKi8KCWlmIChsaWtlbHkoIWljc2stPmljc2tfbXR1cC5lbmFibGVkIHx8CgkJICAg
aWNzay0+aWNza19tdHVwLnByb2JlX3NpemUgfHwKCQkgICBpbmV0X2NzayhzayktPmljc2tfY2Ff
c3RhdGUgIT0gVENQX0NBX09wZW4gfHwKCQkgICB0Y3Bfc25kX2N3bmQodHApIDwgMTEgfHwKCQkg
ICB0cC0+cnhfb3B0Lm51bV9zYWNrcyB8fCB0cC0+cnhfb3B0LmRzYWNrKSkKCQlyZXR1cm4gLTE7
CgoJLyogVXNlIGJpbmFyeSBzZWFyY2ggZm9yIHByb2JlX3NpemUgYmV0d2VlbiB0Y3BfbXNzX2Jh
c2UsCgkgKiBhbmQgY3VycmVudCBtc3NfY2xhbXAuIGlmIChzZWFyY2hfaGlnaCAtIHNlYXJjaF9s
b3cpCgkgKiBzbWFsbGVyIHRoYW4gYSB0aHJlc2hvbGQsIGJhY2tvZmYgZnJvbSBwcm9iaW5nLgoJ
ICovCgltc3Nfbm93ID0gdGNwX2N1cnJlbnRfbXNzKHNrKTsKCXByb2JlX3NpemUgPSB0Y3BfbXR1
X3RvX21zcyhzaywgKGljc2stPmljc2tfbXR1cC5zZWFyY2hfaGlnaCArCgkJCQkgICAgaWNzay0+
aWNza19tdHVwLnNlYXJjaF9sb3cpID4+IDEpOwoJc2l6ZV9uZWVkZWQgPSBwcm9iZV9zaXplICsg
KHRwLT5yZW9yZGVyaW5nICsgMSkgKiB0cC0+bXNzX2NhY2hlOwoJaW50ZXJ2YWwgPSBpY3NrLT5p
Y3NrX210dXAuc2VhcmNoX2hpZ2ggLSBpY3NrLT5pY3NrX210dXAuc2VhcmNoX2xvdzsKCS8qIFdo
ZW4gbWlzZm9ydHVuZSBoYXBwZW5zLCB3ZSBhcmUgcmVwcm9iaW5nIGFjdGl2ZWx5LAoJICogYW5k
IHRoZW4gcmVwcm9iZSB0aW1lciBoYXMgZXhwaXJlZC4gV2Ugc3RpY2sgd2l0aCBjdXJyZW50Cgkg
KiBwcm9iaW5nIHByb2Nlc3MgYnkgbm90IHJlc2V0dGluZyBzZWFyY2ggcmFuZ2UgdG8gaXRzIG9y
aWduYWwuCgkgKi8KCWlmIChwcm9iZV9zaXplID4gdGNwX210dV90b19tc3Moc2ssIGljc2stPmlj
c2tfbXR1cC5zZWFyY2hfaGlnaCkgfHwKCSAgICBpbnRlcnZhbCA8IFJFQURfT05DRShuZXQtPmlw
djQuc3lzY3RsX3RjcF9wcm9iZV90aHJlc2hvbGQpKSB7CgkJLyogQ2hlY2sgd2hldGhlciBlbm91
Z2ggdGltZSBoYXMgZWxhcGxhc2VkIGZvcgoJCSAqIGFub3RoZXIgcm91bmQgb2YgcHJvYmluZy4K
CQkgKi8KCQl0Y3BfbXR1X2NoZWNrX3JlcHJvYmUoc2spOwoJCXJldHVybiAtMTsKCX0KCgkvKiBI
YXZlIGVub3VnaCBkYXRhIGluIHRoZSBzZW5kIHF1ZXVlIHRvIHByb2JlPyAqLwoJaWYgKHRwLT53
cml0ZV9zZXEgLSB0cC0+c25kX254dCA8IHNpemVfbmVlZGVkKQoJCXJldHVybiAtMTsKCglpZiAo
dHAtPnNuZF93bmQgPCBzaXplX25lZWRlZCkKCQlyZXR1cm4gLTE7CglpZiAoYWZ0ZXIodHAtPnNu
ZF9ueHQgKyBzaXplX25lZWRlZCwgdGNwX3duZF9lbmQodHApKSkKCQlyZXR1cm4gMDsKCgkvKiBE
byB3ZSBuZWVkIHRvIHdhaXQgdG8gZHJhaW4gY3duZD8gV2l0aCBub25lIGluIGZsaWdodCwgZG9u
J3Qgc3RhbGwgKi8KCWlmICh0Y3BfcGFja2V0c19pbl9mbGlnaHQodHApICsgMiA+IHRjcF9zbmRf
Y3duZCh0cCkpIHsKCQlpZiAoIXRjcF9wYWNrZXRzX2luX2ZsaWdodCh0cCkpCgkJCXJldHVybiAt
MTsKCQllbHNlCgkJCXJldHVybiAwOwoJfQoKCWlmICghdGNwX2Nhbl9jb2FsZXNjZV9zZW5kX3F1
ZXVlX2hlYWQoc2ssIHByb2JlX3NpemUpKQoJCXJldHVybiAtMTsKCgkvKiBXZSdyZSBhbGxvd2Vk
IHRvIHByb2JlLiAgQnVpbGQgaXQgbm93LiAqLwoJbnNrYiA9IHRjcF9zdHJlYW1fYWxsb2Nfc2ti
KHNrLCBHRlBfQVRPTUlDLCBmYWxzZSk7CglpZiAoIW5za2IpCgkJcmV0dXJuIC0xOwoKCS8qIGJ1
aWxkIHRoZSBwYXlsb2FkLCBhbmQgYmUgcHJlcGFyZWQgdG8gYWJvcnQgaWYgdGhpcyBmYWlscy4g
Ki8KCWlmICh0Y3BfY2xvbmVfcGF5bG9hZChzaywgbnNrYiwgcHJvYmVfc2l6ZSkpIHsKCQl0Y3Bf
c2tiX3Rzb3J0ZWRfYW5jaG9yX2NsZWFudXAobnNrYik7CgkJY29uc3VtZV9za2IobnNrYik7CgkJ
cmV0dXJuIC0xOwoJfQoJc2tfd21lbV9xdWV1ZWRfYWRkKHNrLCBuc2tiLT50cnVlc2l6ZSk7Cglz
a19tZW1fY2hhcmdlKHNrLCBuc2tiLT50cnVlc2l6ZSk7CgoJc2tiID0gdGNwX3NlbmRfaGVhZChz
ayk7Cglza2JfY29weV9kZWNyeXB0ZWQobnNrYiwgc2tiKTsKCW1wdGNwX3NrYl9leHRfY29weShu
c2tiLCBza2IpOwoKCVRDUF9TS0JfQ0IobnNrYiktPnNlcSA9IFRDUF9TS0JfQ0Ioc2tiKS0+c2Vx
OwoJVENQX1NLQl9DQihuc2tiKS0+ZW5kX3NlcSA9IFRDUF9TS0JfQ0Ioc2tiKS0+c2VxICsgcHJv
YmVfc2l6ZTsKCVRDUF9TS0JfQ0IobnNrYiktPnRjcF9mbGFncyA9IFRDUEhEUl9BQ0s7CgoJdGNw
X2luc2VydF93cml0ZV9xdWV1ZV9iZWZvcmUobnNrYiwgc2tiLCBzayk7Cgl0Y3BfaGlnaGVzdF9z
YWNrX3JlcGxhY2Uoc2ssIHNrYiwgbnNrYik7CgoJbGVuID0gMDsKCXRjcF9mb3Jfd3JpdGVfcXVl
dWVfZnJvbV9zYWZlKHNrYiwgbmV4dCwgc2spIHsKCQljb3B5ID0gbWluX3QoaW50LCBza2ItPmxl
biwgcHJvYmVfc2l6ZSAtIGxlbik7CgoJCWlmIChza2ItPmxlbiA8PSBjb3B5KSB7CgkJCS8qIFdl
J3ZlIGVhdGVuIGFsbCB0aGUgZGF0YSBmcm9tIHRoaXMgc2tiLgoJCQkgKiBUaHJvdyBpdCBhd2F5
LiAqLwoJCQlUQ1BfU0tCX0NCKG5za2IpLT50Y3BfZmxhZ3MgfD0gVENQX1NLQl9DQihza2IpLT50
Y3BfZmxhZ3M7CgkJCS8qIElmIHRoaXMgaXMgdGhlIGxhc3QgU0tCIHdlIGNvcHkgYW5kIGVvciBp
cyBzZXQKCQkJICogd2UgbmVlZCB0byBwcm9wYWdhdGUgaXQgdG8gdGhlIG5ldyBza2IuCgkJCSAq
LwoJCQlUQ1BfU0tCX0NCKG5za2IpLT5lb3IgPSBUQ1BfU0tCX0NCKHNrYiktPmVvcjsKCQkJdGNw
X3NrYl9jb2xsYXBzZV90c3RhbXAobnNrYiwgc2tiKTsKCQkJdGNwX3VubGlua193cml0ZV9xdWV1
ZShza2IsIHNrKTsKCQkJdGNwX3dtZW1fZnJlZV9za2Ioc2ssIHNrYik7CgkJfSBlbHNlIHsKCQkJ
VENQX1NLQl9DQihuc2tiKS0+dGNwX2ZsYWdzIHw9IFRDUF9TS0JfQ0Ioc2tiKS0+dGNwX2ZsYWdz
ICYKCQkJCQkJICAgfihUQ1BIRFJfRklOfFRDUEhEUl9QU0gpOwoJCQlfX3Bza2JfdHJpbV9oZWFk
KHNrYiwgY29weSk7CgkJCXRjcF9zZXRfc2tiX3Rzb19zZWdzKHNrYiwgbXNzX25vdyk7CgkJCVRD
UF9TS0JfQ0Ioc2tiKS0+c2VxICs9IGNvcHk7CgkJfQoKCQlsZW4gKz0gY29weTsKCgkJaWYgKGxl
biA+PSBwcm9iZV9zaXplKQoJCQlicmVhazsKCX0KCXRjcF9pbml0X3Rzb19zZWdzKG5za2IsIG5z
a2ItPmxlbik7CgoJLyogV2UncmUgcmVhZHkgdG8gc2VuZC4gIElmIHRoaXMgZmFpbHMsIHRoZSBw
cm9iZSB3aWxsCgkgKiBiZSByZXNlZ21lbnRlZCBpbnRvIG1zcy1zaXplZCBwaWVjZXMgYnkgdGNw
X3dyaXRlX3htaXQoKS4KCSAqLwoJaWYgKCF0Y3BfdHJhbnNtaXRfc2tiKHNrLCBuc2tiLCAxLCBH
RlBfQVRPTUlDKSkgewoJCS8qIERlY3JlbWVudCBjd25kIGhlcmUgYmVjYXVzZSB3ZSBhcmUgc2Vu
ZGluZwoJCSAqIGVmZmVjdGl2ZWx5IHR3byBwYWNrZXRzLiAqLwoJCXRjcF9zbmRfY3duZF9zZXQo
dHAsIHRjcF9zbmRfY3duZCh0cCkgLSAxKTsKCQl0Y3BfZXZlbnRfbmV3X2RhdGFfc2VudChzaywg
bnNrYik7CgoJCWljc2stPmljc2tfbXR1cC5wcm9iZV9zaXplID0gdGNwX21zc190b19tdHUoc2ss
IG5za2ItPmxlbik7CgkJdHAtPm10dV9wcm9iZS5wcm9iZV9zZXFfc3RhcnQgPSBUQ1BfU0tCX0NC
KG5za2IpLT5zZXE7CgkJdHAtPm10dV9wcm9iZS5wcm9iZV9zZXFfZW5kID0gVENQX1NLQl9DQihu
c2tiKS0+ZW5kX3NlcTsKCgkJcmV0dXJuIDE7Cgl9CgoJcmV0dXJuIC0xOwp9CgpzdGF0aWMgYm9v
bCB0Y3BfcGFjaW5nX2NoZWNrKHN0cnVjdCBzb2NrICpzaykKewoJc3RydWN0IHRjcF9zb2NrICp0
cCA9IHRjcF9zayhzayk7CgoJaWYgKCF0Y3BfbmVlZHNfaW50ZXJuYWxfcGFjaW5nKHNrKSkKCQly
ZXR1cm4gZmFsc2U7CgoJaWYgKHRwLT50Y3Bfd3N0YW1wX25zIDw9IHRwLT50Y3BfY2xvY2tfY2Fj
aGUpCgkJcmV0dXJuIGZhbHNlOwoKCWlmICghaHJ0aW1lcl9pc19xdWV1ZWQoJnRwLT5wYWNpbmdf
dGltZXIpKSB7CgkJaHJ0aW1lcl9zdGFydCgmdHAtPnBhY2luZ190aW1lciwKCQkJICAgICAgbnNf
dG9fa3RpbWUodHAtPnRjcF93c3RhbXBfbnMpLAoJCQkgICAgICBIUlRJTUVSX01PREVfQUJTX1BJ
Tk5FRF9TT0ZUKTsKCQlzb2NrX2hvbGQoc2spOwoJfQoJcmV0dXJuIHRydWU7Cn0KCnN0YXRpYyBi
b29sIHRjcF9ydHhfcXVldWVfZW1wdHlfb3Jfc2luZ2xlX3NrYihjb25zdCBzdHJ1Y3Qgc29jayAq
c2spCnsKCWNvbnN0IHN0cnVjdCByYl9ub2RlICpub2RlID0gc2stPnRjcF9ydHhfcXVldWUucmJf
bm9kZTsKCgkvKiBObyBza2IgaW4gdGhlIHJ0eCBxdWV1ZS4gKi8KCWlmICghbm9kZSkKCQlyZXR1
cm4gdHJ1ZTsKCgkvKiBPbmx5IG9uZSBza2IgaW4gcnR4IHF1ZXVlLiAqLwoJcmV0dXJuICFub2Rl
LT5yYl9sZWZ0ICYmICFub2RlLT5yYl9yaWdodDsKfQoKLyogVENQIFNtYWxsIFF1ZXVlcyA6CiAq
IENvbnRyb2wgbnVtYmVyIG9mIHBhY2tldHMgaW4gcWRpc2MvZGV2aWNlcyB0byB0d28gcGFja2V0
cyAvIG9yIH4xIG1zLgogKiAoVGhlc2UgbGltaXRzIGFyZSBkb3VibGVkIGZvciByZXRyYW5zbWl0
cykKICogVGhpcyBhbGxvd3MgZm9yIDoKICogIC0gYmV0dGVyIFJUVCBlc3RpbWF0aW9uIGFuZCBB
Q0sgc2NoZWR1bGluZwogKiAgLSBmYXN0ZXIgcmVjb3ZlcnkKICogIC0gaGlnaCByYXRlcwogKiBB
bGFzLCBzb21lIGRyaXZlcnMgLyBzdWJzeXN0ZW1zIHJlcXVpcmUgYSBmYWlyIGFtb3VudAogKiBv
ZiBxdWV1ZWQgYnl0ZXMgdG8gZW5zdXJlIGxpbmUgcmF0ZS4KICogT25lIGV4YW1wbGUgaXMgd2lm
aSBhZ2dyZWdhdGlvbiAoODAyLjExIEFNUERVKQogKi8Kc3RhdGljIGJvb2wgdGNwX3NtYWxsX3F1
ZXVlX2NoZWNrKHN0cnVjdCBzb2NrICpzaywgY29uc3Qgc3RydWN0IHNrX2J1ZmYgKnNrYiwKCQkJ
CSAgdW5zaWduZWQgaW50IGZhY3RvcikKewoJdW5zaWduZWQgbG9uZyBsaW1pdDsKCglsaW1pdCA9
IG1heF90KHVuc2lnbmVkIGxvbmcsCgkJICAgICAgMiAqIHNrYi0+dHJ1ZXNpemUsCgkJICAgICAg
UkVBRF9PTkNFKHNrLT5za19wYWNpbmdfcmF0ZSkgPj4gUkVBRF9PTkNFKHNrLT5za19wYWNpbmdf
c2hpZnQpKTsKCWlmIChzay0+c2tfcGFjaW5nX3N0YXR1cyA9PSBTS19QQUNJTkdfTk9ORSkKCQls
aW1pdCA9IG1pbl90KHVuc2lnbmVkIGxvbmcsIGxpbWl0LAoJCQkgICAgICBSRUFEX09OQ0Uoc29j
a19uZXQoc2spLT5pcHY0LnN5c2N0bF90Y3BfbGltaXRfb3V0cHV0X2J5dGVzKSk7CglsaW1pdCA8
PD0gZmFjdG9yOwoKCWlmIChzdGF0aWNfYnJhbmNoX3VubGlrZWx5KCZ0Y3BfdHhfZGVsYXlfZW5h
YmxlZCkgJiYKCSAgICB0Y3Bfc2soc2spLT50Y3BfdHhfZGVsYXkpIHsKCQl1NjQgZXh0cmFfYnl0
ZXMgPSAodTY0KVJFQURfT05DRShzay0+c2tfcGFjaW5nX3JhdGUpICoKCQkJCSAgdGNwX3NrKHNr
KS0+dGNwX3R4X2RlbGF5OwoKCQkvKiBUU1EgaXMgYmFzZWQgb24gc2tiIHRydWVzaXplIHN1bSAo
c2tfd21lbV9hbGxvYyksIHNvIHdlCgkJICogYXBwcm94aW1hdGUgb3VyIG5lZWRzIGFzc3VtaW5n
IGFuIH4xMDAlIHNrYi0+dHJ1ZXNpemUgb3ZlcmhlYWQuCgkJICogVVNFQ19QRVJfU0VDIGlzIGFw
cHJveGltYXRlZCBieSAyXjIwLgoJCSAqIGRvX2RpdihleHRyYV9ieXRlcywgVVNFQ19QRVJfU0VD
LzIpIGlzIHJlcGxhY2VkIGJ5IGEgcmlnaHQgc2hpZnQuCgkJICovCgkJZXh0cmFfYnl0ZXMgPj49
ICgyMCAtIDEpOwoJCWxpbWl0ICs9IGV4dHJhX2J5dGVzOwoJfQoJaWYgKHJlZmNvdW50X3JlYWQo
JnNrLT5za193bWVtX2FsbG9jKSA+IGxpbWl0KSB7CgkJLyogQWx3YXlzIHNlbmQgc2tiIGlmIHJ0
eCBxdWV1ZSBpcyBlbXB0eSBvciBoYXMgb25lIHNrYi4KCQkgKiBObyBuZWVkIHRvIHdhaXQgZm9y
IFRYIGNvbXBsZXRpb24gdG8gY2FsbCB1cyBiYWNrLAoJCSAqIGFmdGVyIHNvZnRpcnEvdGFza2xl
dCBzY2hlZHVsZS4KCQkgKiBUaGlzIGhlbHBzIHdoZW4gVFggY29tcGxldGlvbnMgYXJlIGRlbGF5
ZWQgdG9vIG11Y2guCgkJICovCgkJaWYgKHRjcF9ydHhfcXVldWVfZW1wdHlfb3Jfc2luZ2xlX3Nr
YihzaykpCgkJCXJldHVybiBmYWxzZTsKCgkJc2V0X2JpdChUU1FfVEhST1RUTEVELCAmc2stPnNr
X3RzcV9mbGFncyk7CgkJLyogSXQgaXMgcG9zc2libGUgVFggY29tcGxldGlvbiBhbHJlYWR5IGhh
cHBlbmVkCgkJICogYmVmb3JlIHdlIHNldCBUU1FfVEhST1RUTEVELCBzbyB3ZSBtdXN0CgkJICog
dGVzdCBhZ2FpbiB0aGUgY29uZGl0aW9uLgoJCSAqLwoJCXNtcF9tYl9fYWZ0ZXJfYXRvbWljKCk7
CgkJaWYgKHJlZmNvdW50X3JlYWQoJnNrLT5za193bWVtX2FsbG9jKSA+IGxpbWl0KQoJCQlyZXR1
cm4gdHJ1ZTsKCX0KCXJldHVybiBmYWxzZTsKfQoKc3RhdGljIHZvaWQgdGNwX2Nocm9ub19zZXQo
c3RydWN0IHRjcF9zb2NrICp0cCwgY29uc3QgZW51bSB0Y3BfY2hyb25vIG5ldykKewoJY29uc3Qg
dTMyIG5vdyA9IHRjcF9qaWZmaWVzMzI7CgllbnVtIHRjcF9jaHJvbm8gb2xkID0gdHAtPmNocm9u
b190eXBlOwoKCWlmIChvbGQgPiBUQ1BfQ0hST05PX1VOU1BFQykKCQl0cC0+Y2hyb25vX3N0YXRb
b2xkIC0gMV0gKz0gbm93IC0gdHAtPmNocm9ub19zdGFydDsKCXRwLT5jaHJvbm9fc3RhcnQgPSBu
b3c7Cgl0cC0+Y2hyb25vX3R5cGUgPSBuZXc7Cn0KCnZvaWQgdGNwX2Nocm9ub19zdGFydChzdHJ1
Y3Qgc29jayAqc2ssIGNvbnN0IGVudW0gdGNwX2Nocm9ubyB0eXBlKQp7CglzdHJ1Y3QgdGNwX3Nv
Y2sgKnRwID0gdGNwX3NrKHNrKTsKCgkvKiBJZiB0aGVyZSBhcmUgbXVsdGlwbGUgY29uZGl0aW9u
cyB3b3J0aHkgb2YgdHJhY2tpbmcgaW4gYQoJICogY2hyb25vZ3JhcGggdGhlbiB0aGUgaGlnaGVz
dCBwcmlvcml0eSBlbnVtIHRha2VzIHByZWNlZGVuY2UKCSAqIG92ZXIgdGhlIG90aGVyIGNvbmRp
dGlvbnMuIFNvIHRoYXQgaWYgc29tZXRoaW5nICJtb3JlIGludGVyZXN0aW5nIgoJICogc3RhcnRz
IGhhcHBlbmluZywgc3RvcCB0aGUgcHJldmlvdXMgY2hyb25vIGFuZCBzdGFydCBhIG5ldyBvbmUu
CgkgKi8KCWlmICh0eXBlID4gdHAtPmNocm9ub190eXBlKQoJCXRjcF9jaHJvbm9fc2V0KHRwLCB0
eXBlKTsKfQoKdm9pZCB0Y3BfY2hyb25vX3N0b3Aoc3RydWN0IHNvY2sgKnNrLCBjb25zdCBlbnVt
IHRjcF9jaHJvbm8gdHlwZSkKewoJc3RydWN0IHRjcF9zb2NrICp0cCA9IHRjcF9zayhzayk7CgoK
CS8qIFRoZXJlIGFyZSBtdWx0aXBsZSBjb25kaXRpb25zIHdvcnRoeSBvZiB0cmFja2luZyBpbiBh
CgkgKiBjaHJvbm9ncmFwaCwgc28gdGhhdCB0aGUgaGlnaGVzdCBwcmlvcml0eSBlbnVtIHRha2Vz
CgkgKiBwcmVjZWRlbmNlIG92ZXIgdGhlIG90aGVyIGNvbmRpdGlvbnMgKHNlZSB0Y3BfY2hyb25v
X3N0YXJ0KS4KCSAqIElmIGEgY29uZGl0aW9uIHN0b3BzLCB3ZSBvbmx5IHN0b3AgY2hyb25vIHRy
YWNraW5nIGlmCgkgKiBpdCdzIHRoZSAibW9zdCBpbnRlcmVzdGluZyIgb3IgY3VycmVudCBjaHJv
bm8gd2UgYXJlCgkgKiB0cmFja2luZyBhbmQgc3RhcnRzIGJ1c3kgY2hyb25vIGlmIHdlIGhhdmUg
cGVuZGluZyBkYXRhLgoJICovCglpZiAodGNwX3J0eF9hbmRfd3JpdGVfcXVldWVzX2VtcHR5KHNr
KSkKCQl0Y3BfY2hyb25vX3NldCh0cCwgVENQX0NIUk9OT19VTlNQRUMpOwoJZWxzZSBpZiAodHlw
ZSA9PSB0cC0+Y2hyb25vX3R5cGUpCgkJdGNwX2Nocm9ub19zZXQodHAsIFRDUF9DSFJPTk9fQlVT
WSk7Cn0KCi8qIFRoaXMgcm91dGluZSB3cml0ZXMgcGFja2V0cyB0byB0aGUgbmV0d29yay4gIEl0
IGFkdmFuY2VzIHRoZQogKiBzZW5kX2hlYWQuICBUaGlzIGhhcHBlbnMgYXMgaW5jb21pbmcgYWNr
cyBvcGVuIHVwIHRoZSByZW1vdGUKICogd2luZG93IGZvciB1cy4KICoKICogTEFSR0VTRU5EIG5v
dGU6ICF0Y3BfdXJnX21vZGUgaXMgb3ZlcmtpbGwsIG9ubHkgZnJhbWVzIGJldHdlZW4KICogc25k
X3VwLTY0ay1tc3MgLi4gc25kX3VwIGNhbm5vdCBiZSBsYXJnZS4gSG93ZXZlciwgdGFraW5nIGlu
dG8KICogYWNjb3VudCByYXJlIHVzZSBvZiBVUkcsIHRoaXMgaXMgbm90IGEgYmlnIGZsYXcuCiAq
CiAqIFNlbmQgYXQgbW9zdCBvbmUgcGFja2V0IHdoZW4gcHVzaF9vbmUgPiAwLiBUZW1wb3Jhcmls
eSBpZ25vcmUKICogY3duZCBsaW1pdCB0byBmb3JjZSBhdCBtb3N0IG9uZSBwYWNrZXQgb3V0IHdo
ZW4gcHVzaF9vbmUgPT0gMi4KCiAqIFJldHVybnMgdHJ1ZSwgaWYgbm8gc2VnbWVudHMgYXJlIGlu
IGZsaWdodCBhbmQgd2UgaGF2ZSBxdWV1ZWQgc2VnbWVudHMsCiAqIGJ1dCBjYW5ub3Qgc2VuZCBh
bnl0aGluZyBub3cgYmVjYXVzZSBvZiBTV1Mgb3IgYW5vdGhlciBwcm9ibGVtLgogKi8Kc3RhdGlj
IGJvb2wgdGNwX3dyaXRlX3htaXQoc3RydWN0IHNvY2sgKnNrLCB1bnNpZ25lZCBpbnQgbXNzX25v
dywgaW50IG5vbmFnbGUsCgkJCSAgIGludCBwdXNoX29uZSwgZ2ZwX3QgZ2ZwKQp7CglzdHJ1Y3Qg
dGNwX3NvY2sgKnRwID0gdGNwX3NrKHNrKTsKCXN0cnVjdCBza19idWZmICpza2I7Cgl1bnNpZ25l
ZCBpbnQgdHNvX3NlZ3MsIHNlbnRfcGt0czsKCWludCBjd25kX3F1b3RhOwoJaW50IHJlc3VsdDsK
CWJvb2wgaXNfY3duZF9saW1pdGVkID0gZmFsc2UsIGlzX3J3bmRfbGltaXRlZCA9IGZhbHNlOwoJ
dTMyIG1heF9zZWdzOwoKCXNlbnRfcGt0cyA9IDA7CgoJdGNwX21zdGFtcF9yZWZyZXNoKHRwKTsK
CWlmICghcHVzaF9vbmUpIHsKCQkvKiBEbyBNVFUgcHJvYmluZy4gKi8KCQlyZXN1bHQgPSB0Y3Bf
bXR1X3Byb2JlKHNrKTsKCQlpZiAoIXJlc3VsdCkgewoJCQlyZXR1cm4gZmFsc2U7CgkJfSBlbHNl
IGlmIChyZXN1bHQgPiAwKSB7CgkJCXNlbnRfcGt0cyA9IDE7CgkJfQoJfQoKCW1heF9zZWdzID0g
dGNwX3Rzb19zZWdzKHNrLCBtc3Nfbm93KTsKCXdoaWxlICgoc2tiID0gdGNwX3NlbmRfaGVhZChz
aykpKSB7CgkJdW5zaWduZWQgaW50IGxpbWl0OwoKCQlpZiAodW5saWtlbHkodHAtPnJlcGFpcikg
JiYgdHAtPnJlcGFpcl9xdWV1ZSA9PSBUQ1BfU0VORF9RVUVVRSkgewoJCQkvKiAic2tiX21zdGFt
cF9ucyIgaXMgdXNlZCBhcyBhIHN0YXJ0IHBvaW50IGZvciB0aGUgcmV0cmFuc21pdCB0aW1lciAq
LwoJCQl0cC0+dGNwX3dzdGFtcF9ucyA9IHRwLT50Y3BfY2xvY2tfY2FjaGU7CgkJCXNrYl9zZXRf
ZGVsaXZlcnlfdGltZShza2IsIHRwLT50Y3Bfd3N0YW1wX25zLCB0cnVlKTsKCQkJbGlzdF9tb3Zl
X3RhaWwoJnNrYi0+dGNwX3Rzb3J0ZWRfYW5jaG9yLCAmdHAtPnRzb3J0ZWRfc2VudF9xdWV1ZSk7
CgkJCXRjcF9pbml0X3Rzb19zZWdzKHNrYiwgbXNzX25vdyk7CgkJCWdvdG8gcmVwYWlyOyAvKiBT
a2lwIG5ldHdvcmsgdHJhbnNtaXNzaW9uICovCgkJfQoKCQlpZiAodGNwX3BhY2luZ19jaGVjayhz
aykpCgkJCWJyZWFrOwoKCQl0c29fc2VncyA9IHRjcF9pbml0X3Rzb19zZWdzKHNrYiwgbXNzX25v
dyk7CgkJQlVHX09OKCF0c29fc2Vncyk7CgoJCWN3bmRfcXVvdGEgPSB0Y3BfY3duZF90ZXN0KHRw
LCBza2IpOwoJCWlmICghY3duZF9xdW90YSkgewoJCQlpZiAocHVzaF9vbmUgPT0gMikKCQkJCS8q
IEZvcmNlIG91dCBhIGxvc3MgcHJvYmUgcGt0LiAqLwoJCQkJY3duZF9xdW90YSA9IDE7CgkJCWVs
c2UKCQkJCWJyZWFrOwoJCX0KCgkJaWYgKHVubGlrZWx5KCF0Y3Bfc25kX3duZF90ZXN0KHRwLCBz
a2IsIG1zc19ub3cpKSkgewoJCQlpc19yd25kX2xpbWl0ZWQgPSB0cnVlOwoJCQlicmVhazsKCQl9
CgoJCWlmICh0c29fc2VncyA9PSAxKSB7CgkJCWlmICh1bmxpa2VseSghdGNwX25hZ2xlX3Rlc3Qo
dHAsIHNrYiwgbXNzX25vdywKCQkJCQkJICAgICAodGNwX3NrYl9pc19sYXN0KHNrLCBza2IpID8K
CQkJCQkJICAgICAgbm9uYWdsZSA6IFRDUF9OQUdMRV9QVVNIKSkpKQoJCQkJYnJlYWs7CgkJfSBl
bHNlIHsKCQkJaWYgKCFwdXNoX29uZSAmJgoJCQkgICAgdGNwX3Rzb19zaG91bGRfZGVmZXIoc2ss
IHNrYiwgJmlzX2N3bmRfbGltaXRlZCwKCQkJCQkJICZpc19yd25kX2xpbWl0ZWQsIG1heF9zZWdz
KSkKCQkJCWJyZWFrOwoJCX0KCgkJbGltaXQgPSBtc3Nfbm93OwoJCWlmICh0c29fc2VncyA+IDEg
JiYgIXRjcF91cmdfbW9kZSh0cCkpCgkJCWxpbWl0ID0gdGNwX21zc19zcGxpdF9wb2ludChzaywg
c2tiLCBtc3Nfbm93LAoJCQkJCQkgICAgbWluX3QodW5zaWduZWQgaW50LAoJCQkJCQkJICBjd25k
X3F1b3RhLAoJCQkJCQkJICBtYXhfc2VncyksCgkJCQkJCSAgICBub25hZ2xlKTsKCgkJaWYgKHNr
Yi0+bGVuID4gbGltaXQgJiYKCQkgICAgdW5saWtlbHkodHNvX2ZyYWdtZW50KHNrLCBza2IsIGxp
bWl0LCBtc3Nfbm93LCBnZnApKSkKCQkJYnJlYWs7CgoJCWlmICh0Y3Bfc21hbGxfcXVldWVfY2hl
Y2soc2ssIHNrYiwgMCkpCgkJCWJyZWFrOwoKCQkvKiBBcmdoLCB3ZSBoaXQgYW4gZW1wdHkgc2ti
KCksIHByZXN1bWFibHkgYSB0aHJlYWQKCQkgKiBpcyBzbGVlcGluZyBpbiBzZW5kbXNnKCkvc2tf
c3RyZWFtX3dhaXRfbWVtb3J5KCkuCgkJICogV2UgZG8gbm90IHdhbnQgdG8gc2VuZCBhIHB1cmUt
YWNrIHBhY2tldCBhbmQgaGF2ZQoJCSAqIGEgc3RyYW5nZSBsb29raW5nIHJ0eCBxdWV1ZSB3aXRo
IGVtcHR5IHBhY2tldChzKS4KCQkgKi8KCQlpZiAoVENQX1NLQl9DQihza2IpLT5lbmRfc2VxID09
IFRDUF9TS0JfQ0Ioc2tiKS0+c2VxKQoJCQlicmVhazsKCgkJaWYgKHVubGlrZWx5KHRjcF90cmFu
c21pdF9za2Ioc2ssIHNrYiwgMSwgZ2ZwKSkpCgkJCWJyZWFrOwoKcmVwYWlyOgoJCS8qIEFkdmFu
Y2UgdGhlIHNlbmRfaGVhZC4gIFRoaXMgb25lIGlzIHNlbnQgb3V0LgoJCSAqIFRoaXMgY2FsbCB3
aWxsIGluY3JlbWVudCBwYWNrZXRzX291dC4KCQkgKi8KCQl0Y3BfZXZlbnRfbmV3X2RhdGFfc2Vu
dChzaywgc2tiKTsKCgkJdGNwX21pbnNoYWxsX3VwZGF0ZSh0cCwgbXNzX25vdywgc2tiKTsKCQlz
ZW50X3BrdHMgKz0gdGNwX3NrYl9wY291bnQoc2tiKTsKCgkJaWYgKHB1c2hfb25lKQoJCQlicmVh
azsKCX0KCglpZiAoaXNfcnduZF9saW1pdGVkKQoJCXRjcF9jaHJvbm9fc3RhcnQoc2ssIFRDUF9D
SFJPTk9fUldORF9MSU1JVEVEKTsKCWVsc2UKCQl0Y3BfY2hyb25vX3N0b3Aoc2ssIFRDUF9DSFJP
Tk9fUldORF9MSU1JVEVEKTsKCglpc19jd25kX2xpbWl0ZWQgfD0gKHRjcF9wYWNrZXRzX2luX2Zs
aWdodCh0cCkgPj0gdGNwX3NuZF9jd25kKHRwKSk7CglpZiAobGlrZWx5KHNlbnRfcGt0cyB8fCBp
c19jd25kX2xpbWl0ZWQpKQoJCXRjcF9jd25kX3ZhbGlkYXRlKHNrLCBpc19jd25kX2xpbWl0ZWQp
OwoKCWlmIChsaWtlbHkoc2VudF9wa3RzKSkgewoJCWlmICh0Y3BfaW5fY3duZF9yZWR1Y3Rpb24o
c2spKQoJCQl0cC0+cHJyX291dCArPSBzZW50X3BrdHM7CgoJCS8qIFNlbmQgb25lIGxvc3MgcHJv
YmUgcGVyIHRhaWwgbG9zcyBlcGlzb2RlLiAqLwoJCWlmIChwdXNoX29uZSAhPSAyKQoJCQl0Y3Bf
c2NoZWR1bGVfbG9zc19wcm9iZShzaywgZmFsc2UpOwoJCXJldHVybiBmYWxzZTsKCX0KCXJldHVy
biAhdHAtPnBhY2tldHNfb3V0ICYmICF0Y3Bfd3JpdGVfcXVldWVfZW1wdHkoc2spOwp9Cgpib29s
IHRjcF9zY2hlZHVsZV9sb3NzX3Byb2JlKHN0cnVjdCBzb2NrICpzaywgYm9vbCBhZHZhbmNpbmdf
cnRvKQp7CglzdHJ1Y3QgaW5ldF9jb25uZWN0aW9uX3NvY2sgKmljc2sgPSBpbmV0X2Nzayhzayk7
CglzdHJ1Y3QgdGNwX3NvY2sgKnRwID0gdGNwX3NrKHNrKTsKCXUzMiB0aW1lb3V0LCB0aW1lb3V0
X3VzLCBydG9fZGVsdGFfdXM7CglpbnQgZWFybHlfcmV0cmFuczsKCgkvKiBEb24ndCBkbyBhbnkg
bG9zcyBwcm9iZSBvbiBhIEZhc3QgT3BlbiBjb25uZWN0aW9uIGJlZm9yZSAzV0hTCgkgKiBmaW5p
c2hlcy4KCSAqLwoJaWYgKHJjdV9hY2Nlc3NfcG9pbnRlcih0cC0+ZmFzdG9wZW5fcnNrKSkKCQly
ZXR1cm4gZmFsc2U7CgoJZWFybHlfcmV0cmFucyA9IFJFQURfT05DRShzb2NrX25ldChzayktPmlw
djQuc3lzY3RsX3RjcF9lYXJseV9yZXRyYW5zKTsKCS8qIFNjaGVkdWxlIGEgbG9zcyBwcm9iZSBp
biAyKlJUVCBmb3IgU0FDSyBjYXBhYmxlIGNvbm5lY3Rpb25zCgkgKiBub3QgaW4gbG9zcyByZWNv
dmVyeSwgdGhhdCBhcmUgZWl0aGVyIGxpbWl0ZWQgYnkgY3duZCBvciBhcHBsaWNhdGlvbi4KCSAq
LwoJaWYgKChlYXJseV9yZXRyYW5zICE9IDMgJiYgZWFybHlfcmV0cmFucyAhPSA0KSB8fAoJICAg
ICF0cC0+cGFja2V0c19vdXQgfHwgIXRjcF9pc19zYWNrKHRwKSB8fAoJICAgIChpY3NrLT5pY3Nr
X2NhX3N0YXRlICE9IFRDUF9DQV9PcGVuICYmCgkgICAgIGljc2stPmljc2tfY2Ffc3RhdGUgIT0g
VENQX0NBX0NXUikpCgkJcmV0dXJuIGZhbHNlOwoKCS8qIFByb2JlIHRpbWVvdXQgaXMgMipydHQu
IEFkZCBtaW5pbXVtIFJUTyB0byBhY2NvdW50CgkgKiBmb3IgZGVsYXllZCBhY2sgd2hlbiB0aGVy
ZSdzIG9uZSBvdXRzdGFuZGluZyBwYWNrZXQuIElmIG5vIFJUVAoJICogc2FtcGxlIGlzIGF2YWls
YWJsZSB0aGVuIHByb2JlIGFmdGVyIFRDUF9USU1FT1VUX0lOSVQuCgkgKi8KCWlmICh0cC0+c3J0
dF91cykgewoJCXRpbWVvdXRfdXMgPSB0cC0+c3J0dF91cyA+PiAyOwoJCWlmICh0cC0+cGFja2V0
c19vdXQgPT0gMSkKCQkJdGltZW91dF91cyArPSB0Y3BfcnRvX21pbl91cyhzayk7CgkJZWxzZQoJ
CQl0aW1lb3V0X3VzICs9IFRDUF9USU1FT1VUX01JTl9VUzsKCQl0aW1lb3V0ID0gdXNlY3NfdG9f
amlmZmllcyh0aW1lb3V0X3VzKTsKCX0gZWxzZSB7CgkJdGltZW91dCA9IFRDUF9USU1FT1VUX0lO
SVQ7Cgl9CgoJLyogSWYgdGhlIFJUTyBmb3JtdWxhIHlpZWxkcyBhbiBlYXJsaWVyIHRpbWUsIHRo
ZW4gdXNlIHRoYXQgdGltZS4gKi8KCXJ0b19kZWx0YV91cyA9IGFkdmFuY2luZ19ydG8gPwoJCQlq
aWZmaWVzX3RvX3VzZWNzKGluZXRfY3NrKHNrKS0+aWNza19ydG8pIDoKCQkJdGNwX3J0b19kZWx0
YV91cyhzayk7ICAvKiBIb3cgZmFyIGluIGZ1dHVyZSBpcyBSVE8/ICovCglpZiAocnRvX2RlbHRh
X3VzID4gMCkKCQl0aW1lb3V0ID0gbWluX3QodTMyLCB0aW1lb3V0LCB1c2Vjc190b19qaWZmaWVz
KHJ0b19kZWx0YV91cykpOwoKCXRjcF9yZXNldF94bWl0X3RpbWVyKHNrLCBJQ1NLX1RJTUVfTE9T
U19QUk9CRSwgdGltZW91dCwgVENQX1JUT19NQVgpOwoJcmV0dXJuIHRydWU7Cn0KCi8qIFRoYW5r
cyB0byBza2IgZmFzdCBjbG9uZXMsIHdlIGNhbiBkZXRlY3QgaWYgYSBwcmlvciB0cmFuc21pdCBv
ZgogKiBhIHBhY2tldCBpcyBzdGlsbCBpbiBhIHFkaXNjIG9yIGRyaXZlciBxdWV1ZS4KICogSW4g
dGhpcyBjYXNlLCB0aGVyZSBpcyB2ZXJ5IGxpdHRsZSBwb2ludCBkb2luZyBhIHJldHJhbnNtaXQg
IQogKi8Kc3RhdGljIGJvb2wgc2tiX3N0aWxsX2luX2hvc3RfcXVldWUoc3RydWN0IHNvY2sgKnNr
LAoJCQkJICAgIGNvbnN0IHN0cnVjdCBza19idWZmICpza2IpCnsKCWlmICh1bmxpa2VseShza2Jf
ZmNsb25lX2J1c3koc2ssIHNrYikpKSB7CgkJc2V0X2JpdChUU1FfVEhST1RUTEVELCAmc2stPnNr
X3RzcV9mbGFncyk7CgkJc21wX21iX19hZnRlcl9hdG9taWMoKTsKCQlpZiAoc2tiX2ZjbG9uZV9i
dXN5KHNrLCBza2IpKSB7CgkJCU5FVF9JTkNfU1RBVFMoc29ja19uZXQoc2spLAoJCQkJICAgICAg
TElOVVhfTUlCX1RDUFNQVVJJT1VTX1JUWF9IT1NUUVVFVUVTKTsKCQkJcmV0dXJuIHRydWU7CgkJ
fQoJfQoJcmV0dXJuIGZhbHNlOwp9CgovKiBXaGVuIHByb2JlIHRpbWVvdXQgKFBUTykgZmlyZXMs
IHRyeSBzZW5kIGEgbmV3IHNlZ21lbnQgaWYgcG9zc2libGUsIGVsc2UKICogcmV0cmFuc21pdCB0
aGUgbGFzdCBzZWdtZW50LgogKi8Kdm9pZCB0Y3Bfc2VuZF9sb3NzX3Byb2JlKHN0cnVjdCBzb2Nr
ICpzaykKewoJc3RydWN0IHRjcF9zb2NrICp0cCA9IHRjcF9zayhzayk7CglzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiOwoJaW50IHBjb3VudDsKCWludCBtc3MgPSB0Y3BfY3VycmVudF9tc3Moc2spOwoKCS8q
IEF0IG1vc3Qgb25lIG91dHN0YW5kaW5nIFRMUCAqLwoJaWYgKHRwLT50bHBfaGlnaF9zZXEpCgkJ
Z290byByZWFybV90aW1lcjsKCgl0cC0+dGxwX3JldHJhbnMgPSAwOwoJc2tiID0gdGNwX3NlbmRf
aGVhZChzayk7CglpZiAoc2tiICYmIHRjcF9zbmRfd25kX3Rlc3QodHAsIHNrYiwgbXNzKSkgewoJ
CXBjb3VudCA9IHRwLT5wYWNrZXRzX291dDsKCQl0Y3Bfd3JpdGVfeG1pdChzaywgbXNzLCBUQ1Bf
TkFHTEVfT0ZGLCAyLCBHRlBfQVRPTUlDKTsKCQlpZiAodHAtPnBhY2tldHNfb3V0ID4gcGNvdW50
KQoJCQlnb3RvIHByb2JlX3NlbnQ7CgkJZ290byByZWFybV90aW1lcjsKCX0KCXNrYiA9IHNrYl9y
Yl9sYXN0KCZzay0+dGNwX3J0eF9xdWV1ZSk7CglpZiAodW5saWtlbHkoIXNrYikpIHsKCQlXQVJO
X09OQ0UodHAtPnBhY2tldHNfb3V0LAoJCQkgICJpbnZhbGlkIGluZmxpZ2h0OiAldSBzdGF0ZSAl
dSBjd25kICV1IG1zcyAlZFxuIiwKCQkJICB0cC0+cGFja2V0c19vdXQsIHNrLT5za19zdGF0ZSwg
dGNwX3NuZF9jd25kKHRwKSwgbXNzKTsKCQlpbmV0X2NzayhzayktPmljc2tfcGVuZGluZyA9IDA7
CgkJcmV0dXJuOwoJfQoKCWlmIChza2Jfc3RpbGxfaW5faG9zdF9xdWV1ZShzaywgc2tiKSkKCQln
b3RvIHJlYXJtX3RpbWVyOwoKCXBjb3VudCA9IHRjcF9za2JfcGNvdW50KHNrYik7CglpZiAoV0FS
Tl9PTighcGNvdW50KSkKCQlnb3RvIHJlYXJtX3RpbWVyOwoKCWlmICgocGNvdW50ID4gMSkgJiYg
KHNrYi0+bGVuID4gKHBjb3VudCAtIDEpICogbXNzKSkgewoJCWlmICh1bmxpa2VseSh0Y3BfZnJh
Z21lbnQoc2ssIFRDUF9GUkFHX0lOX1JUWF9RVUVVRSwgc2tiLAoJCQkJCSAgKHBjb3VudCAtIDEp
ICogbXNzLCBtc3MsCgkJCQkJICBHRlBfQVRPTUlDKSkpCgkJCWdvdG8gcmVhcm1fdGltZXI7CgkJ
c2tiID0gc2tiX3JiX25leHQoc2tiKTsKCX0KCglpZiAoV0FSTl9PTighc2tiIHx8ICF0Y3Bfc2ti
X3Bjb3VudChza2IpKSkKCQlnb3RvIHJlYXJtX3RpbWVyOwoKCWlmIChfX3RjcF9yZXRyYW5zbWl0
X3NrYihzaywgc2tiLCAxKSkKCQlnb3RvIHJlYXJtX3RpbWVyOwoKCXRwLT50bHBfcmV0cmFucyA9
IDE7Cgpwcm9iZV9zZW50OgoJLyogUmVjb3JkIHNuZF9ueHQgZm9yIGxvc3MgZGV0ZWN0aW9uLiAq
LwoJdHAtPnRscF9oaWdoX3NlcSA9IHRwLT5zbmRfbnh0OwoKCU5FVF9JTkNfU1RBVFMoc29ja19u
ZXQoc2spLCBMSU5VWF9NSUJfVENQTE9TU1BST0JFUyk7CgkvKiBSZXNldCBzLnQuIHRjcF9yZWFy
bV9ydG8gd2lsbCByZXN0YXJ0IHRpbWVyIGZyb20gbm93ICovCglpbmV0X2NzayhzayktPmljc2tf
cGVuZGluZyA9IDA7CnJlYXJtX3RpbWVyOgoJdGNwX3JlYXJtX3J0byhzayk7Cn0KCi8qIFB1c2gg
b3V0IGFueSBwZW5kaW5nIGZyYW1lcyB3aGljaCB3ZXJlIGhlbGQgYmFjayBkdWUgdG8KICogVENQ
X0NPUksgb3IgYXR0ZW1wdCBhdCBjb2FsZXNjaW5nIHRpbnkgcGFja2V0cy4KICogVGhlIHNvY2tl
dCBtdXN0IGJlIGxvY2tlZCBieSB0aGUgY2FsbGVyLgogKi8Kdm9pZCBfX3RjcF9wdXNoX3BlbmRp
bmdfZnJhbWVzKHN0cnVjdCBzb2NrICpzaywgdW5zaWduZWQgaW50IGN1cl9tc3MsCgkJCSAgICAg
ICBpbnQgbm9uYWdsZSkKewoJLyogSWYgd2UgYXJlIGNsb3NlZCwgdGhlIGJ5dGVzIHdpbGwgaGF2
ZSB0byByZW1haW4gaGVyZS4KCSAqIEluIHRpbWUgY2xvc2Vkb3duIHdpbGwgZmluaXNoLCB3ZSBl
bXB0eSB0aGUgd3JpdGUgcXVldWUgYW5kCgkgKiBhbGwgd2lsbCBiZSBoYXBweS4KCSAqLwoJaWYg
KHVubGlrZWx5KHNrLT5za19zdGF0ZSA9PSBUQ1BfQ0xPU0UpKQoJCXJldHVybjsKCglpZiAodGNw
X3dyaXRlX3htaXQoc2ssIGN1cl9tc3MsIG5vbmFnbGUsIDAsCgkJCSAgIHNrX2dmcF9tYXNrKHNr
LCBHRlBfQVRPTUlDKSkpCgkJdGNwX2NoZWNrX3Byb2JlX3RpbWVyKHNrKTsKfQoKLyogU2VuZCBf
c2luZ2xlXyBza2Igc2l0dGluZyBhdCB0aGUgc2VuZCBoZWFkLiBUaGlzIGZ1bmN0aW9uIHJlcXVp
cmVzCiAqIHRydWUgcHVzaCBwZW5kaW5nIGZyYW1lcyB0byBzZXR1cCBwcm9iZSB0aW1lciBldGMu
CiAqLwp2b2lkIHRjcF9wdXNoX29uZShzdHJ1Y3Qgc29jayAqc2ssIHVuc2lnbmVkIGludCBtc3Nf
bm93KQp7CglzdHJ1Y3Qgc2tfYnVmZiAqc2tiID0gdGNwX3NlbmRfaGVhZChzayk7CgoJQlVHX09O
KCFza2IgfHwgc2tiLT5sZW4gPCBtc3Nfbm93KTsKCgl0Y3Bfd3JpdGVfeG1pdChzaywgbXNzX25v
dywgVENQX05BR0xFX1BVU0gsIDEsIHNrLT5za19hbGxvY2F0aW9uKTsKfQoKLyogVGhpcyBmdW5j
dGlvbiByZXR1cm5zIHRoZSBhbW91bnQgdGhhdCB3ZSBjYW4gcmFpc2UgdGhlCiAqIHVzYWJsZSB3
aW5kb3cgYmFzZWQgb24gdGhlIGZvbGxvd2luZyBjb25zdHJhaW50cwogKgogKiAxLiBUaGUgd2lu
ZG93IGNhbiBuZXZlciBiZSBzaHJ1bmsgb25jZSBpdCBpcyBvZmZlcmVkIChSRkMgNzkzKQogKiAy
LiBXZSBsaW1pdCBtZW1vcnkgcGVyIHNvY2tldAogKgogKiBSRkMgMTEyMjoKICogInRoZSBzdWdn
ZXN0ZWQgW1NXU10gYXZvaWRhbmNlIGFsZ29yaXRobSBmb3IgdGhlIHJlY2VpdmVyIGlzIHRvIGtl
ZXAKICogIFJFQ1YuTkVYVCArIFJDVi5XSU4gZml4ZWQgdW50aWw6CiAqICBSQ1YuQlVGRiAtIFJD
Vi5VU0VSIC0gUkNWLldJTkRPVyA+PSBtaW4oMS8yIFJDVi5CVUZGLCBNU1MpIgogKgogKiBpLmUu
IGRvbid0IHJhaXNlIHRoZSByaWdodCBlZGdlIG9mIHRoZSB3aW5kb3cgdW50aWwgeW91IGNhbiBy
YWlzZQogKiBpdCBhdCBsZWFzdCBNU1MgYnl0ZXMuCiAqCiAqIFVuZm9ydHVuYXRlbHksIHRoZSBy
ZWNvbW1lbmRlZCBhbGdvcml0aG0gYnJlYWtzIGhlYWRlciBwcmVkaWN0aW9uLAogKiBzaW5jZSBo
ZWFkZXIgcHJlZGljdGlvbiBhc3N1bWVzIHRoLT53aW5kb3cgc3RheXMgZml4ZWQuCiAqCiAqIFN0
cmljdGx5IHNwZWFraW5nLCBrZWVwaW5nIHRoLT53aW5kb3cgZml4ZWQgdmlvbGF0ZXMgdGhlIHJl
Y2VpdmVyCiAqIHNpZGUgU1dTIHByZXZlbnRpb24gY3JpdGVyaWEuIFRoZSBwcm9ibGVtIGlzIHRo
YXQgdW5kZXIgdGhpcyBydWxlCiAqIGEgc3RyZWFtIG9mIHNpbmdsZSBieXRlIHBhY2tldHMgd2ls
bCBjYXVzZSB0aGUgcmlnaHQgc2lkZSBvZiB0aGUKICogd2luZG93IHRvIGFsd2F5cyBhZHZhbmNl
IGJ5IGEgc2luZ2xlIGJ5dGUuCiAqCiAqIE9mIGNvdXJzZSwgaWYgdGhlIHNlbmRlciBpbXBsZW1l
bnRzIHNlbmRlciBzaWRlIFNXUyBwcmV2ZW50aW9uCiAqIHRoZW4gdGhpcyB3aWxsIG5vdCBiZSBh
IHByb2JsZW0uCiAqCiAqIEJTRCBzZWVtcyB0byBtYWtlIHRoZSBmb2xsb3dpbmcgY29tcHJvbWlz
ZToKICoKICoJSWYgdGhlIGZyZWUgc3BhY2UgaXMgbGVzcyB0aGFuIHRoZSAxLzQgb2YgdGhlIG1h
eGltdW0KICoJc3BhY2UgYXZhaWxhYmxlIGFuZCB0aGUgZnJlZSBzcGFjZSBpcyBsZXNzIHRoYW4g
MS8yIG1zcywKICoJdGhlbiBzZXQgdGhlIHdpbmRvdyB0byAwLgogKglbIEFjdHVhbGx5LCBic2Qg
dXNlcyBNU1MgYW5kIDEvNCBvZiBtYXhpbWFsIF93aW5kb3dfIF0KICoJT3RoZXJ3aXNlLCBqdXN0
IHByZXZlbnQgdGhlIHdpbmRvdyBmcm9tIHNocmlua2luZwogKglhbmQgZnJvbSBiZWluZyBsYXJn
ZXIgdGhhbiB0aGUgbGFyZ2VzdCByZXByZXNlbnRhYmxlIHZhbHVlLgogKgogKiBUaGlzIHByZXZl
bnRzIGluY3JlbWVudGFsIG9wZW5pbmcgb2YgdGhlIHdpbmRvdyBpbiB0aGUgcmVnaW1lCiAqIHdo
ZXJlIFRDUCBpcyBsaW1pdGVkIGJ5IHRoZSBzcGVlZCBvZiB0aGUgcmVhZGVyIHNpZGUgdGFraW5n
CiAqIGRhdGEgb3V0IG9mIHRoZSBUQ1AgcmVjZWl2ZSBxdWV1ZS4gSXQgZG9lcyBub3RoaW5nIGFi
b3V0CiAqIHRob3NlIGNhc2VzIHdoZXJlIHRoZSB3aW5kb3cgaXMgY29uc3RyYWluZWQgb24gdGhl
IHNlbmRlciBzaWRlCiAqIGJlY2F1c2UgdGhlIHBpcGVsaW5lIGlzIGZ1bGwuCiAqCiAqIEJTRCBh
bHNvIHNlZW1zIHRvICJhY2NpZGVudGFsbHkiIGxpbWl0IGl0c2VsZiB0byB3aW5kb3dzIHRoYXQg
YXJlIGEKICogbXVsdGlwbGUgb2YgTVNTLCBhdCBsZWFzdCB1bnRpbCB0aGUgZnJlZSBzcGFjZSBn
ZXRzIHF1aXRlIHNtYWxsLgogKiBUaGlzIHdvdWxkIGFwcGVhciB0byBiZSBhIHNpZGUgZWZmZWN0
IG9mIHRoZSBtYnVmIGltcGxlbWVudGF0aW9uLgogKiBDb21iaW5pbmcgdGhlc2UgdHdvIGFsZ29y
aXRobXMgcmVzdWx0cyBpbiB0aGUgb2JzZXJ2ZWQgYmVoYXZpb3IKICogb2YgaGF2aW5nIGEgZml4
ZWQgd2luZG93IHNpemUgYXQgYWxtb3N0IGFsbCB0aW1lcy4KICoKICogQmVsb3cgd2Ugb2J0YWlu
IHNpbWlsYXIgYmVoYXZpb3IgYnkgZm9yY2luZyB0aGUgb2ZmZXJlZCB3aW5kb3cgdG8KICogYSBt
dWx0aXBsZSBvZiB0aGUgbXNzIHdoZW4gaXQgaXMgZmVhc2libGUgdG8gZG8gc28uCiAqCiAqIE5v
dGUsIHdlIGRvbid0ICJhZGp1c3QiIGZvciBUSU1FU1RBTVAgb3IgU0FDSyBvcHRpb24gYnl0ZXMu
CiAqIFJlZ3VsYXIgb3B0aW9ucyBsaWtlIFRJTUVTVEFNUCBhcmUgdGFrZW4gaW50byBhY2NvdW50
LgogKi8KdTMyIF9fdGNwX3NlbGVjdF93aW5kb3coc3RydWN0IHNvY2sgKnNrKQp7CglzdHJ1Y3Qg
aW5ldF9jb25uZWN0aW9uX3NvY2sgKmljc2sgPSBpbmV0X2Nzayhzayk7CglzdHJ1Y3QgdGNwX3Nv
Y2sgKnRwID0gdGNwX3NrKHNrKTsKCXN0cnVjdCBuZXQgKm5ldCA9IHNvY2tfbmV0KHNrKTsKCS8q
IE1TUyBmb3IgdGhlIHBlZXIncyBkYXRhLiAgUHJldmlvdXMgdmVyc2lvbnMgdXNlZCBtc3NfY2xh
bXAKCSAqIGhlcmUuICBJIGRvbid0IGtub3cgaWYgdGhlIHZhbHVlIGJhc2VkIG9uIG91ciBndWVz
c2VzCgkgKiBvZiBwZWVyJ3MgTVNTIGlzIGJldHRlciBmb3IgdGhlIHBlcmZvcm1hbmNlLiAgSXQn
cyBtb3JlIGNvcnJlY3QKCSAqIGJ1dCBtYXkgYmUgd29yc2UgZm9yIHRoZSBwZXJmb3JtYW5jZSBi
ZWNhdXNlIG9mIHJjdl9tc3MKCSAqIGZsdWN0dWF0aW9ucy4gIC0tU0FXICAxOTk4LzExLzEKCSAq
LwoJaW50IG1zcyA9IGljc2stPmljc2tfYWNrLnJjdl9tc3M7CglpbnQgZnJlZV9zcGFjZSA9IHRj
cF9zcGFjZShzayk7CglpbnQgYWxsb3dlZF9zcGFjZSA9IHRjcF9mdWxsX3NwYWNlKHNrKTsKCWlu
dCBmdWxsX3NwYWNlLCB3aW5kb3c7CgoJaWYgKHNrX2lzX21wdGNwKHNrKSkKCQltcHRjcF9zcGFj
ZShzaywgJmZyZWVfc3BhY2UsICZhbGxvd2VkX3NwYWNlKTsKCglmdWxsX3NwYWNlID0gbWluX3Qo
aW50LCB0cC0+d2luZG93X2NsYW1wLCBhbGxvd2VkX3NwYWNlKTsKCglpZiAodW5saWtlbHkobXNz
ID4gZnVsbF9zcGFjZSkpIHsKCQltc3MgPSBmdWxsX3NwYWNlOwoJCWlmIChtc3MgPD0gMCkKCQkJ
cmV0dXJuIDA7Cgl9CgoJLyogT25seSBhbGxvdyB3aW5kb3cgc2hyaW5rIGlmIHRoZSBzeXNjdGwg
aXMgZW5hYmxlZCBhbmQgd2UgaGF2ZQoJICogYSBub24temVybyBzY2FsaW5nIGZhY3RvciBpbiBl
ZmZlY3QuCgkgKi8KCWlmIChSRUFEX09OQ0UobmV0LT5pcHY0LnN5c2N0bF90Y3Bfc2hyaW5rX3dp
bmRvdykgJiYgdHAtPnJ4X29wdC5yY3Zfd3NjYWxlKQoJCWdvdG8gc2hyaW5rX3dpbmRvd19hbGxv
d2VkOwoKCS8qIGRvIG5vdCBhbGxvdyB3aW5kb3cgdG8gc2hyaW5rICovCgoJaWYgKGZyZWVfc3Bh
Y2UgPCAoZnVsbF9zcGFjZSA+PiAxKSkgewoJCWljc2stPmljc2tfYWNrLnF1aWNrID0gMDsKCgkJ
aWYgKHRjcF91bmRlcl9tZW1vcnlfcHJlc3N1cmUoc2spKQoJCQl0Y3BfYWRqdXN0X3Jjdl9zc3Ro
cmVzaChzayk7CgoJCS8qIGZyZWVfc3BhY2UgbWlnaHQgYmVjb21lIG91ciBuZXcgd2luZG93LCBt
YWtlIHN1cmUgd2UgZG9uJ3QKCQkgKiBpbmNyZWFzZSBpdCBkdWUgdG8gd3NjYWxlLgoJCSAqLwoJ
CWZyZWVfc3BhY2UgPSByb3VuZF9kb3duKGZyZWVfc3BhY2UsIDEgPDwgdHAtPnJ4X29wdC5yY3Zf
d3NjYWxlKTsKCgkJLyogaWYgZnJlZSBzcGFjZSBpcyBsZXNzIHRoYW4gbXNzIGVzdGltYXRlLCBv
ciBpcyBiZWxvdyAxLzE2dGgKCQkgKiBvZiB0aGUgbWF4aW11bSBhbGxvd2VkLCB0cnkgdG8gbW92
ZSB0byB6ZXJvLXdpbmRvdywgZWxzZQoJCSAqIHRjcF9jbGFtcF93aW5kb3coKSB3aWxsIGdyb3cg
cmN2IGJ1ZiB1cCB0byB0Y3Bfcm1lbVsyXSwgYW5kCgkJICogbmV3IGluY29taW5nIGRhdGEgaXMg
ZHJvcHBlZCBkdWUgdG8gbWVtb3J5IGxpbWl0cy4KCQkgKiBXaXRoIGxhcmdlIHdpbmRvdywgbXNz
IHRlc3QgdHJpZ2dlcnMgd2F5IHRvbyBsYXRlIGluIG9yZGVyCgkJICogdG8gYW5ub3VuY2UgemVy
byB3aW5kb3cgaW4gdGltZSBiZWZvcmUgcm1lbSBsaW1pdCBraWNrcyBpbi4KCQkgKi8KCQlpZiAo
ZnJlZV9zcGFjZSA8IChhbGxvd2VkX3NwYWNlID4+IDQpIHx8IGZyZWVfc3BhY2UgPCBtc3MpCgkJ
CXJldHVybiAwOwoJfQoKCWlmIChmcmVlX3NwYWNlID4gdHAtPnJjdl9zc3RocmVzaCkKCQlmcmVl
X3NwYWNlID0gdHAtPnJjdl9zc3RocmVzaDsKCgkvKiBEb24ndCBkbyByb3VuZGluZyBpZiB3ZSBh
cmUgdXNpbmcgd2luZG93IHNjYWxpbmcsIHNpbmNlIHRoZQoJICogc2NhbGVkIHdpbmRvdyB3aWxs
IG5vdCBsaW5lIHVwIHdpdGggdGhlIE1TUyBib3VuZGFyeSBhbnl3YXkuCgkgKi8KCWlmICh0cC0+
cnhfb3B0LnJjdl93c2NhbGUpIHsKCQl3aW5kb3cgPSBmcmVlX3NwYWNlOwoKCQkvKiBBZHZlcnRp
c2UgZW5vdWdoIHNwYWNlIHNvIHRoYXQgaXQgd29uJ3QgZ2V0IHNjYWxlZCBhd2F5LgoJCSAqIElt
cG9ydCBjYXNlOiBwcmV2ZW50IHplcm8gd2luZG93IGFubm91bmNlbWVudCBpZgoJCSAqIDE8PHJj
dl93c2NhbGUgPiBtc3MuCgkJICovCgkJd2luZG93ID0gQUxJR04od2luZG93LCAoMSA8PCB0cC0+
cnhfb3B0LnJjdl93c2NhbGUpKTsKCX0gZWxzZSB7CgkJd2luZG93ID0gdHAtPnJjdl93bmQ7CgkJ
LyogR2V0IHRoZSBsYXJnZXN0IHdpbmRvdyB0aGF0IGlzIGEgbmljZSBtdWx0aXBsZSBvZiBtc3Mu
CgkJICogV2luZG93IGNsYW1wIGFscmVhZHkgYXBwbGllZCBhYm92ZS4KCQkgKiBJZiBvdXIgY3Vy
cmVudCB3aW5kb3cgb2ZmZXJpbmcgaXMgd2l0aGluIDEgbXNzIG9mIHRoZQoJCSAqIGZyZWUgc3Bh
Y2Ugd2UganVzdCBrZWVwIGl0LiBUaGlzIHByZXZlbnRzIHRoZSBkaXZpZGUKCQkgKiBhbmQgbXVs
dGlwbHkgZnJvbSBoYXBwZW5pbmcgbW9zdCBvZiB0aGUgdGltZS4KCQkgKiBXZSBhbHNvIGRvbid0
IGRvIGFueSB3aW5kb3cgcm91bmRpbmcgd2hlbiB0aGUgZnJlZSBzcGFjZQoJCSAqIGlzIHRvbyBz
bWFsbC4KCQkgKi8KCQlpZiAod2luZG93IDw9IGZyZWVfc3BhY2UgLSBtc3MgfHwgd2luZG93ID4g
ZnJlZV9zcGFjZSkKCQkJd2luZG93ID0gcm91bmRkb3duKGZyZWVfc3BhY2UsIG1zcyk7CgkJZWxz
ZSBpZiAobXNzID09IGZ1bGxfc3BhY2UgJiYKCQkJIGZyZWVfc3BhY2UgPiB3aW5kb3cgKyAoZnVs
bF9zcGFjZSA+PiAxKSkKCQkJd2luZG93ID0gZnJlZV9zcGFjZTsKCX0KCglyZXR1cm4gd2luZG93
OwoKc2hyaW5rX3dpbmRvd19hbGxvd2VkOgoJLyogbmV3IHdpbmRvdyBzaG91bGQgYWx3YXlzIGJl
IGFuIGV4YWN0IG11bHRpcGxlIG9mIHNjYWxpbmcgZmFjdG9yICovCglmcmVlX3NwYWNlID0gcm91
bmRfZG93bihmcmVlX3NwYWNlLCAxIDw8IHRwLT5yeF9vcHQucmN2X3dzY2FsZSk7CgoJaWYgKGZy
ZWVfc3BhY2UgPCAoZnVsbF9zcGFjZSA+PiAxKSkgewoJCWljc2stPmljc2tfYWNrLnF1aWNrID0g
MDsKCgkJaWYgKHRjcF91bmRlcl9tZW1vcnlfcHJlc3N1cmUoc2spKQoJCQl0Y3BfYWRqdXN0X3Jj
dl9zc3RocmVzaChzayk7CgoJCS8qIGlmIGZyZWUgc3BhY2UgaXMgdG9vIGxvdywgcmV0dXJuIGEg
emVybyB3aW5kb3cgKi8KCQlpZiAoZnJlZV9zcGFjZSA8IChhbGxvd2VkX3NwYWNlID4+IDQpIHx8
IGZyZWVfc3BhY2UgPCBtc3MgfHwKCQkJZnJlZV9zcGFjZSA8ICgxIDw8IHRwLT5yeF9vcHQucmN2
X3dzY2FsZSkpCgkJCXJldHVybiAwOwoJfQoKCWlmIChmcmVlX3NwYWNlID4gdHAtPnJjdl9zc3Ro
cmVzaCkgewoJCWZyZWVfc3BhY2UgPSB0cC0+cmN2X3NzdGhyZXNoOwoJCS8qIG5ldyB3aW5kb3cg
c2hvdWxkIGFsd2F5cyBiZSBhbiBleGFjdCBtdWx0aXBsZSBvZiBzY2FsaW5nIGZhY3RvcgoJCSAq
CgkJICogRm9yIHRoaXMgY2FzZSwgd2UgQUxJR04gInVwIiAoaW5jcmVhc2UgZnJlZV9zcGFjZSkg
YmVjYXVzZQoJCSAqIHdlIGtub3cgZnJlZV9zcGFjZSBpcyBub3QgemVybyBoZXJlLCBpdCBoYXMg
YmVlbiByZWR1Y2VkIGZyb20KCQkgKiB0aGUgbWVtb3J5LWJhc2VkIGxpbWl0LCBhbmQgcmN2X3Nz
dGhyZXNoIGlzIG5vdCBhIGhhcmQgbGltaXQKCQkgKiAodW5saWtlIHNrX3JjdmJ1ZikuCgkJICov
CgkJZnJlZV9zcGFjZSA9IEFMSUdOKGZyZWVfc3BhY2UsICgxIDw8IHRwLT5yeF9vcHQucmN2X3dz
Y2FsZSkpOwoJfQoKCXJldHVybiBmcmVlX3NwYWNlOwp9Cgp2b2lkIHRjcF9za2JfY29sbGFwc2Vf
dHN0YW1wKHN0cnVjdCBza19idWZmICpza2IsCgkJCSAgICAgY29uc3Qgc3RydWN0IHNrX2J1ZmYg
Km5leHRfc2tiKQp7CglpZiAodW5saWtlbHkodGNwX2hhc190eF90c3RhbXAobmV4dF9za2IpKSkg
ewoJCWNvbnN0IHN0cnVjdCBza2Jfc2hhcmVkX2luZm8gKm5leHRfc2hpbmZvID0KCQkJc2tiX3No
aW5mbyhuZXh0X3NrYik7CgkJc3RydWN0IHNrYl9zaGFyZWRfaW5mbyAqc2hpbmZvID0gc2tiX3No
aW5mbyhza2IpOwoKCQlzaGluZm8tPnR4X2ZsYWdzIHw9IG5leHRfc2hpbmZvLT50eF9mbGFncyAm
IFNLQlRYX0FOWV9UU1RBTVA7CgkJc2hpbmZvLT50c2tleSA9IG5leHRfc2hpbmZvLT50c2tleTsK
CQlUQ1BfU0tCX0NCKHNrYiktPnR4c3RhbXBfYWNrIHw9CgkJCVRDUF9TS0JfQ0IobmV4dF9za2Ip
LT50eHN0YW1wX2FjazsKCX0KfQoKLyogQ29sbGFwc2VzIHR3byBhZGphY2VudCBTS0IncyBkdXJp
bmcgcmV0cmFuc21pc3Npb24uICovCnN0YXRpYyBib29sIHRjcF9jb2xsYXBzZV9yZXRyYW5zKHN0
cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYgKnNrYikKewoJc3RydWN0IHRjcF9zb2NrICp0
cCA9IHRjcF9zayhzayk7CglzdHJ1Y3Qgc2tfYnVmZiAqbmV4dF9za2IgPSBza2JfcmJfbmV4dChz
a2IpOwoJaW50IG5leHRfc2tiX3NpemU7CgoJbmV4dF9za2Jfc2l6ZSA9IG5leHRfc2tiLT5sZW47
CgoJQlVHX09OKHRjcF9za2JfcGNvdW50KHNrYikgIT0gMSB8fCB0Y3Bfc2tiX3Bjb3VudChuZXh0
X3NrYikgIT0gMSk7CgoJaWYgKG5leHRfc2tiX3NpemUgJiYgIXRjcF9za2Jfc2hpZnQoc2tiLCBu
ZXh0X3NrYiwgMSwgbmV4dF9za2Jfc2l6ZSkpCgkJcmV0dXJuIGZhbHNlOwoKCXRjcF9oaWdoZXN0
X3NhY2tfcmVwbGFjZShzaywgbmV4dF9za2IsIHNrYik7CgoJLyogVXBkYXRlIHNlcXVlbmNlIHJh
bmdlIG9uIG9yaWdpbmFsIHNrYi4gKi8KCVRDUF9TS0JfQ0Ioc2tiKS0+ZW5kX3NlcSA9IFRDUF9T
S0JfQ0IobmV4dF9za2IpLT5lbmRfc2VxOwoKCS8qIE1lcmdlIG92ZXIgY29udHJvbCBpbmZvcm1h
dGlvbi4gVGhpcyBtb3ZlcyBQU0gvRklOIGV0Yy4gb3ZlciAqLwoJVENQX1NLQl9DQihza2IpLT50
Y3BfZmxhZ3MgfD0gVENQX1NLQl9DQihuZXh0X3NrYiktPnRjcF9mbGFnczsKCgkvKiBBbGwgZG9u
ZSwgZ2V0IHJpZCBvZiBzZWNvbmQgU0tCIGFuZCBhY2NvdW50IGZvciBpdCBzbwoJICogcGFja2V0
IGNvdW50aW5nIGRvZXMgbm90IGJyZWFrLgoJICovCglUQ1BfU0tCX0NCKHNrYiktPnNhY2tlZCB8
PSBUQ1BfU0tCX0NCKG5leHRfc2tiKS0+c2Fja2VkICYgVENQQ0JfRVZFUl9SRVRSQU5TOwoJVENQ
X1NLQl9DQihza2IpLT5lb3IgPSBUQ1BfU0tCX0NCKG5leHRfc2tiKS0+ZW9yOwoKCS8qIGNoYW5n
ZWQgdHJhbnNtaXQgcXVldWUgdW5kZXIgdXMgc28gY2xlYXIgaGludHMgKi8KCXRjcF9jbGVhcl9y
ZXRyYW5zX2hpbnRzX3BhcnRpYWwodHApOwoJaWYgKG5leHRfc2tiID09IHRwLT5yZXRyYW5zbWl0
X3NrYl9oaW50KQoJCXRwLT5yZXRyYW5zbWl0X3NrYl9oaW50ID0gc2tiOwoKCXRjcF9hZGp1c3Rf
cGNvdW50KHNrLCBuZXh0X3NrYiwgdGNwX3NrYl9wY291bnQobmV4dF9za2IpKTsKCgl0Y3Bfc2ti
X2NvbGxhcHNlX3RzdGFtcChza2IsIG5leHRfc2tiKTsKCgl0Y3BfcnR4X3F1ZXVlX3VubGlua19h
bmRfZnJlZShuZXh0X3NrYiwgc2spOwoJcmV0dXJuIHRydWU7Cn0KCi8qIENoZWNrIGlmIGNvYWxl
c2NpbmcgU0tCcyBpcyBsZWdhbC4gKi8Kc3RhdGljIGJvb2wgdGNwX2Nhbl9jb2xsYXBzZShjb25z
dCBzdHJ1Y3Qgc29jayAqc2ssIGNvbnN0IHN0cnVjdCBza19idWZmICpza2IpCnsKCWlmICh0Y3Bf
c2tiX3Bjb3VudChza2IpID4gMSkKCQlyZXR1cm4gZmFsc2U7CglpZiAoc2tiX2Nsb25lZChza2Ip
KQoJCXJldHVybiBmYWxzZTsKCS8qIFNvbWUgaGV1cmlzdGljcyBmb3IgY29sbGFwc2luZyBvdmVy
IFNBQ0snZCBjb3VsZCBiZSBpbnZlbnRlZCAqLwoJaWYgKFRDUF9TS0JfQ0Ioc2tiKS0+c2Fja2Vk
ICYgVENQQ0JfU0FDS0VEX0FDS0VEKQoJCXJldHVybiBmYWxzZTsKCglyZXR1cm4gdHJ1ZTsKfQoK
LyogQ29sbGFwc2UgcGFja2V0cyBpbiB0aGUgcmV0cmFuc21pdCBxdWV1ZSB0byBtYWtlIHRvIGNy
ZWF0ZQogKiBsZXNzIHBhY2tldHMgb24gdGhlIHdpcmUuIFRoaXMgaXMgb25seSBkb25lIG9uIHJl
dHJhbnNtaXNzaW9uLgogKi8Kc3RhdGljIHZvaWQgdGNwX3JldHJhbnNfdHJ5X2NvbGxhcHNlKHN0
cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYgKnRvLAoJCQkJICAgICBpbnQgc3BhY2UpCnsK
CXN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOwoJc3RydWN0IHNrX2J1ZmYgKnNrYiA9
IHRvLCAqdG1wOwoJYm9vbCBmaXJzdCA9IHRydWU7CgoJaWYgKCFSRUFEX09OQ0Uoc29ja19uZXQo
c2spLT5pcHY0LnN5c2N0bF90Y3BfcmV0cmFuc19jb2xsYXBzZSkpCgkJcmV0dXJuOwoJaWYgKFRD
UF9TS0JfQ0Ioc2tiKS0+dGNwX2ZsYWdzICYgVENQSERSX1NZTikKCQlyZXR1cm47CgoJc2tiX3Ji
dHJlZV93YWxrX2Zyb21fc2FmZShza2IsIHRtcCkgewoJCWlmICghdGNwX2Nhbl9jb2xsYXBzZShz
aywgc2tiKSkKCQkJYnJlYWs7CgoJCWlmICghdGNwX3NrYl9jYW5fY29sbGFwc2UodG8sIHNrYikp
CgkJCWJyZWFrOwoKCQlzcGFjZSAtPSBza2ItPmxlbjsKCgkJaWYgKGZpcnN0KSB7CgkJCWZpcnN0
ID0gZmFsc2U7CgkJCWNvbnRpbnVlOwoJCX0KCgkJaWYgKHNwYWNlIDwgMCkKCQkJYnJlYWs7CgoJ
CWlmIChhZnRlcihUQ1BfU0tCX0NCKHNrYiktPmVuZF9zZXEsIHRjcF93bmRfZW5kKHRwKSkpCgkJ
CWJyZWFrOwoKCQlpZiAoIXRjcF9jb2xsYXBzZV9yZXRyYW5zKHNrLCB0bykpCgkJCWJyZWFrOwoJ
fQp9CgovKiBUaGlzIHJldHJhbnNtaXRzIG9uZSBTS0IuICBQb2xpY3kgZGVjaXNpb25zIGFuZCBy
ZXRyYW5zbWl0IHF1ZXVlCiAqIHN0YXRlIHVwZGF0ZXMgYXJlIGRvbmUgYnkgdGhlIGNhbGxlci4g
IFJldHVybnMgbm9uLXplcm8gaWYgYW4KICogZXJyb3Igb2NjdXJyZWQgd2hpY2ggcHJldmVudGVk
IHRoZSBzZW5kLgogKi8KaW50IF9fdGNwX3JldHJhbnNtaXRfc2tiKHN0cnVjdCBzb2NrICpzaywg
c3RydWN0IHNrX2J1ZmYgKnNrYiwgaW50IHNlZ3MpCnsKCXN0cnVjdCBpbmV0X2Nvbm5lY3Rpb25f
c29jayAqaWNzayA9IGluZXRfY3NrKHNrKTsKCXN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2so
c2spOwoJdW5zaWduZWQgaW50IGN1cl9tc3M7CglpbnQgZGlmZiwgbGVuLCBlcnI7CglpbnQgYXZh
aWxfd25kOwoKCS8qIEluY29uY2x1c2l2ZSBNVFUgcHJvYmUgKi8KCWlmIChpY3NrLT5pY3NrX210
dXAucHJvYmVfc2l6ZSkKCQlpY3NrLT5pY3NrX210dXAucHJvYmVfc2l6ZSA9IDA7CgoJaWYgKHNr
Yl9zdGlsbF9pbl9ob3N0X3F1ZXVlKHNrLCBza2IpKQoJCXJldHVybiAtRUJVU1k7CgpzdGFydDoK
CWlmIChiZWZvcmUoVENQX1NLQl9DQihza2IpLT5zZXEsIHRwLT5zbmRfdW5hKSkgewoJCWlmICh1
bmxpa2VseShUQ1BfU0tCX0NCKHNrYiktPnRjcF9mbGFncyAmIFRDUEhEUl9TWU4pKSB7CgkJCVRD
UF9TS0JfQ0Ioc2tiKS0+dGNwX2ZsYWdzICY9IH5UQ1BIRFJfU1lOOwoJCQlUQ1BfU0tCX0NCKHNr
YiktPnNlcSsrOwoJCQlnb3RvIHN0YXJ0OwoJCX0KCQlpZiAodW5saWtlbHkoYmVmb3JlKFRDUF9T
S0JfQ0Ioc2tiKS0+ZW5kX3NlcSwgdHAtPnNuZF91bmEpKSkgewoJCQlXQVJOX09OX09OQ0UoMSk7
CgkJCXJldHVybiAtRUlOVkFMOwoJCX0KCQlpZiAodGNwX3RyaW1faGVhZChzaywgc2tiLCB0cC0+
c25kX3VuYSAtIFRDUF9TS0JfQ0Ioc2tiKS0+c2VxKSkKCQkJcmV0dXJuIC1FTk9NRU07Cgl9CgoJ
aWYgKGluZXRfY3NrKHNrKS0+aWNza19hZl9vcHMtPnJlYnVpbGRfaGVhZGVyKHNrKSkKCQlyZXR1
cm4gLUVIT1NUVU5SRUFDSDsgLyogUm91dGluZyBmYWlsdXJlIG9yIHNpbWlsYXIuICovCgoJY3Vy
X21zcyA9IHRjcF9jdXJyZW50X21zcyhzayk7CglhdmFpbF93bmQgPSB0Y3Bfd25kX2VuZCh0cCkg
LSBUQ1BfU0tCX0NCKHNrYiktPnNlcTsKCgkvKiBJZiByZWNlaXZlciBoYXMgc2hydW5rIGhpcyB3
aW5kb3csIGFuZCBza2IgaXMgb3V0IG9mCgkgKiBuZXcgd2luZG93LCBkbyBub3QgcmV0cmFuc21p
dCBpdC4gVGhlIGV4Y2VwdGlvbiBpcyB0aGUKCSAqIGNhc2UsIHdoZW4gd2luZG93IGlzIHNocnVu
ayB0byB6ZXJvLiBJbiB0aGlzIGNhc2UKCSAqIG91ciByZXRyYW5zbWl0IG9mIG9uZSBzZWdtZW50
IHNlcnZlcyBhcyBhIHplcm8gd2luZG93IHByb2JlLgoJICovCglpZiAoYXZhaWxfd25kIDw9IDAp
IHsKCQlpZiAoVENQX1NLQl9DQihza2IpLT5zZXEgIT0gdHAtPnNuZF91bmEpCgkJCXJldHVybiAt
RUFHQUlOOwoJCWF2YWlsX3duZCA9IGN1cl9tc3M7Cgl9CgoJbGVuID0gY3VyX21zcyAqIHNlZ3M7
CglpZiAobGVuID4gYXZhaWxfd25kKSB7CgkJbGVuID0gcm91bmRkb3duKGF2YWlsX3duZCwgY3Vy
X21zcyk7CgkJaWYgKCFsZW4pCgkJCWxlbiA9IGF2YWlsX3duZDsKCX0KCWlmIChza2ItPmxlbiA+
IGxlbikgewoJCWlmICh0Y3BfZnJhZ21lbnQoc2ssIFRDUF9GUkFHX0lOX1JUWF9RVUVVRSwgc2ti
LCBsZW4sCgkJCQkgY3VyX21zcywgR0ZQX0FUT01JQykpCgkJCXJldHVybiAtRU5PTUVNOyAvKiBX
ZSdsbCB0cnkgYWdhaW4gbGF0ZXIuICovCgl9IGVsc2UgewoJCWlmIChza2JfdW5jbG9uZV9rZWVw
dHJ1ZXNpemUoc2tiLCBHRlBfQVRPTUlDKSkKCQkJcmV0dXJuIC1FTk9NRU07CgoJCWRpZmYgPSB0
Y3Bfc2tiX3Bjb3VudChza2IpOwoJCXRjcF9zZXRfc2tiX3Rzb19zZWdzKHNrYiwgY3VyX21zcyk7
CgkJZGlmZiAtPSB0Y3Bfc2tiX3Bjb3VudChza2IpOwoJCWlmIChkaWZmKQoJCQl0Y3BfYWRqdXN0
X3Bjb3VudChzaywgc2tiLCBkaWZmKTsKCQlhdmFpbF93bmQgPSBtaW5fdChpbnQsIGF2YWlsX3du
ZCwgY3VyX21zcyk7CgkJaWYgKHNrYi0+bGVuIDwgYXZhaWxfd25kKQoJCQl0Y3BfcmV0cmFuc190
cnlfY29sbGFwc2Uoc2ssIHNrYiwgYXZhaWxfd25kKTsKCX0KCgkvKiBSRkMzMTY4LCBzZWN0aW9u
IDYuMS4xLjEuIEVDTiBmYWxsYmFjayAqLwoJaWYgKChUQ1BfU0tCX0NCKHNrYiktPnRjcF9mbGFn
cyAmIFRDUEhEUl9TWU5fRUNOKSA9PSBUQ1BIRFJfU1lOX0VDTikKCQl0Y3BfZWNuX2NsZWFyX3N5
bihzaywgc2tiKTsKCgkvKiBVcGRhdGUgZ2xvYmFsIGFuZCBsb2NhbCBUQ1Agc3RhdGlzdGljcy4g
Ki8KCXNlZ3MgPSB0Y3Bfc2tiX3Bjb3VudChza2IpOwoJVENQX0FERF9TVEFUUyhzb2NrX25ldChz
ayksIFRDUF9NSUJfUkVUUkFOU1NFR1MsIHNlZ3MpOwoJaWYgKFRDUF9TS0JfQ0Ioc2tiKS0+dGNw
X2ZsYWdzICYgVENQSERSX1NZTikKCQlfX05FVF9JTkNfU1RBVFMoc29ja19uZXQoc2spLCBMSU5V
WF9NSUJfVENQU1lOUkVUUkFOUyk7Cgl0cC0+dG90YWxfcmV0cmFucyArPSBzZWdzOwoJdHAtPmJ5
dGVzX3JldHJhbnMgKz0gc2tiLT5sZW47CgoJLyogbWFrZSBzdXJlIHNrYi0+ZGF0YSBpcyBhbGln
bmVkIG9uIGFyY2hlcyB0aGF0IHJlcXVpcmUgaXQKCSAqIGFuZCBjaGVjayBpZiBhY2stdHJpbW1p
bmcgJiBjb2xsYXBzaW5nIGV4dGVuZGVkIHRoZSBoZWFkcm9vbQoJICogYmV5b25kIHdoYXQgY3N1
bV9zdGFydCBjYW4gY292ZXIuCgkgKi8KCWlmICh1bmxpa2VseSgoTkVUX0lQX0FMSUdOICYmICgo
dW5zaWduZWQgbG9uZylza2ItPmRhdGEgJiAzKSkgfHwKCQkgICAgIHNrYl9oZWFkcm9vbShza2Ip
ID49IDB4RkZGRikpIHsKCQlzdHJ1Y3Qgc2tfYnVmZiAqbnNrYjsKCgkJdGNwX3NrYl90c29ydGVk
X3NhdmUoc2tiKSB7CgkJCW5za2IgPSBfX3Bza2JfY29weShza2IsIE1BWF9UQ1BfSEVBREVSLCBH
RlBfQVRPTUlDKTsKCQkJaWYgKG5za2IpIHsKCQkJCW5za2ItPmRldiA9IE5VTEw7CgkJCQllcnIg
PSB0Y3BfdHJhbnNtaXRfc2tiKHNrLCBuc2tiLCAwLCBHRlBfQVRPTUlDKTsKCQkJfSBlbHNlIHsK
CQkJCWVyciA9IC1FTk9CVUZTOwoJCQl9CgkJfSB0Y3Bfc2tiX3Rzb3J0ZWRfcmVzdG9yZShza2Ip
OwoKCQlpZiAoIWVycikgewoJCQl0Y3BfdXBkYXRlX3NrYl9hZnRlcl9zZW5kKHNrLCBza2IsIHRw
LT50Y3Bfd3N0YW1wX25zKTsKCQkJdGNwX3JhdGVfc2tiX3NlbnQoc2ssIHNrYik7CgkJfQoJfSBl
bHNlIHsKCQllcnIgPSB0Y3BfdHJhbnNtaXRfc2tiKHNrLCBza2IsIDEsIEdGUF9BVE9NSUMpOwoJ
fQoKCS8qIFRvIGF2b2lkIHRha2luZyBzcHVyaW91c2x5IGxvdyBSVFQgc2FtcGxlcyBiYXNlZCBv
biBhIHRpbWVzdGFtcAoJICogZm9yIGEgdHJhbnNtaXQgdGhhdCBuZXZlciBoYXBwZW5lZCwgYWx3
YXlzIG1hcmsgRVZFUl9SRVRSQU5TCgkgKi8KCVRDUF9TS0JfQ0Ioc2tiKS0+c2Fja2VkIHw9IFRD
UENCX0VWRVJfUkVUUkFOUzsKCglpZiAoQlBGX1NPQ0tfT1BTX1RFU1RfRkxBRyh0cCwgQlBGX1NP
Q0tfT1BTX1JFVFJBTlNfQ0JfRkxBRykpCgkJdGNwX2NhbGxfYnBmXzNhcmcoc2ssIEJQRl9TT0NL
X09QU19SRVRSQU5TX0NCLAoJCQkJICBUQ1BfU0tCX0NCKHNrYiktPnNlcSwgc2VncywgZXJyKTsK
CglpZiAobGlrZWx5KCFlcnIpKSB7CgkJdHJhY2VfdGNwX3JldHJhbnNtaXRfc2tiKHNrLCBza2Ip
OwoJfSBlbHNlIGlmIChlcnIgIT0gLUVCVVNZKSB7CgkJTkVUX0FERF9TVEFUUyhzb2NrX25ldChz
ayksIExJTlVYX01JQl9UQ1BSRVRSQU5TRkFJTCwgc2Vncyk7Cgl9CglyZXR1cm4gZXJyOwp9Cgpp
bnQgdGNwX3JldHJhbnNtaXRfc2tiKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYgKnNr
YiwgaW50IHNlZ3MpCnsKCXN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOwoJaW50IGVy
ciA9IF9fdGNwX3JldHJhbnNtaXRfc2tiKHNrLCBza2IsIHNlZ3MpOwoKCWlmIChlcnIgPT0gMCkg
ewojaWYgRkFTVFJFVFJBTlNfREVCVUcgPiAwCgkJaWYgKFRDUF9TS0JfQ0Ioc2tiKS0+c2Fja2Vk
ICYgVENQQ0JfU0FDS0VEX1JFVFJBTlMpIHsKCQkJbmV0X2RiZ19yYXRlbGltaXRlZCgicmV0cmFu
c19vdXQgbGVha2VkXG4iKTsKCQl9CiNlbmRpZgoJCVRDUF9TS0JfQ0Ioc2tiKS0+c2Fja2VkIHw9
IFRDUENCX1JFVFJBTlM7CgkJdHAtPnJldHJhbnNfb3V0ICs9IHRjcF9za2JfcGNvdW50KHNrYik7
Cgl9CgoJLyogU2F2ZSBzdGFtcCBvZiB0aGUgZmlyc3QgKGF0dGVtcHRlZCkgcmV0cmFuc21pdC4g
Ki8KCWlmICghdHAtPnJldHJhbnNfc3RhbXApCgkJdHAtPnJldHJhbnNfc3RhbXAgPSB0Y3Bfc2ti
X3RpbWVzdGFtcF90cyh0cC0+dGNwX3VzZWNfdHMsIHNrYik7CgoJaWYgKHRwLT51bmRvX3JldHJh
bnMgPCAwKQoJCXRwLT51bmRvX3JldHJhbnMgPSAwOwoJdHAtPnVuZG9fcmV0cmFucyArPSB0Y3Bf
c2tiX3Bjb3VudChza2IpOwoJcmV0dXJuIGVycjsKfQoKLyogVGhpcyBnZXRzIGNhbGxlZCBhZnRl
ciBhIHJldHJhbnNtaXQgdGltZW91dCwgYW5kIHRoZSBpbml0aWFsbHkKICogcmV0cmFuc21pdHRl
ZCBkYXRhIGlzIGFja25vd2xlZGdlZC4gIEl0IHRyaWVzIHRvIGNvbnRpbnVlCiAqIHJlc2VuZGlu
ZyB0aGUgcmVzdCBvZiB0aGUgcmV0cmFuc21pdCBxdWV1ZSwgdW50aWwgZWl0aGVyCiAqIHdlJ3Zl
IHNlbnQgaXQgYWxsIG9yIHRoZSBjb25nZXN0aW9uIHdpbmRvdyBsaW1pdCBpcyByZWFjaGVkLgog
Ki8Kdm9pZCB0Y3BfeG1pdF9yZXRyYW5zbWl0X3F1ZXVlKHN0cnVjdCBzb2NrICpzaykKewoJY29u
c3Qgc3RydWN0IGluZXRfY29ubmVjdGlvbl9zb2NrICppY3NrID0gaW5ldF9jc2soc2spOwoJc3Ry
dWN0IHNrX2J1ZmYgKnNrYiwgKnJ0eF9oZWFkLCAqaG9sZSA9IE5VTEw7CglzdHJ1Y3QgdGNwX3Nv
Y2sgKnRwID0gdGNwX3NrKHNrKTsKCWJvb2wgcmVhcm1fdGltZXIgPSBmYWxzZTsKCXUzMiBtYXhf
c2VnczsKCWludCBtaWJfaWR4OwoKCWlmICghdHAtPnBhY2tldHNfb3V0KQoJCXJldHVybjsKCgly
dHhfaGVhZCA9IHRjcF9ydHhfcXVldWVfaGVhZChzayk7Cglza2IgPSB0cC0+cmV0cmFuc21pdF9z
a2JfaGludCA/OiBydHhfaGVhZDsKCW1heF9zZWdzID0gdGNwX3Rzb19zZWdzKHNrLCB0Y3BfY3Vy
cmVudF9tc3Moc2spKTsKCXNrYl9yYnRyZWVfd2Fsa19mcm9tKHNrYikgewoJCV9fdTggc2Fja2Vk
OwoJCWludCBzZWdzOwoKCQlpZiAodGNwX3BhY2luZ19jaGVjayhzaykpCgkJCWJyZWFrOwoKCQkv
KiB3ZSBjb3VsZCBkbyBiZXR0ZXIgdGhhbiB0byBhc3NpZ24gZWFjaCB0aW1lICovCgkJaWYgKCFo
b2xlKQoJCQl0cC0+cmV0cmFuc21pdF9za2JfaGludCA9IHNrYjsKCgkJc2VncyA9IHRjcF9zbmRf
Y3duZCh0cCkgLSB0Y3BfcGFja2V0c19pbl9mbGlnaHQodHApOwoJCWlmIChzZWdzIDw9IDApCgkJ
CWJyZWFrOwoJCXNhY2tlZCA9IFRDUF9TS0JfQ0Ioc2tiKS0+c2Fja2VkOwoJCS8qIEluIGNhc2Ug
dGNwX3NoaWZ0X3NrYl9kYXRhKCkgaGF2ZSBhZ2dyZWdhdGVkIGxhcmdlIHNrYnMsCgkJICogd2Ug
bmVlZCB0byBtYWtlIHN1cmUgbm90IHNlbmRpbmcgdG9vIGJpZ3MgVFNPIHBhY2tldHMKCQkgKi8K
CQlzZWdzID0gbWluX3QoaW50LCBzZWdzLCBtYXhfc2Vncyk7CgoJCWlmICh0cC0+cmV0cmFuc19v
dXQgPj0gdHAtPmxvc3Rfb3V0KSB7CgkJCWJyZWFrOwoJCX0gZWxzZSBpZiAoIShzYWNrZWQgJiBU
Q1BDQl9MT1NUKSkgewoJCQlpZiAoIWhvbGUgJiYgIShzYWNrZWQgJiAoVENQQ0JfU0FDS0VEX1JF
VFJBTlN8VENQQ0JfU0FDS0VEX0FDS0VEKSkpCgkJCQlob2xlID0gc2tiOwoJCQljb250aW51ZTsK
CgkJfSBlbHNlIHsKCQkJaWYgKGljc2stPmljc2tfY2Ffc3RhdGUgIT0gVENQX0NBX0xvc3MpCgkJ
CQltaWJfaWR4ID0gTElOVVhfTUlCX1RDUEZBU1RSRVRSQU5TOwoJCQllbHNlCgkJCQltaWJfaWR4
ID0gTElOVVhfTUlCX1RDUFNMT1dTVEFSVFJFVFJBTlM7CgkJfQoKCQlpZiAoc2Fja2VkICYgKFRD
UENCX1NBQ0tFRF9BQ0tFRHxUQ1BDQl9TQUNLRURfUkVUUkFOUykpCgkJCWNvbnRpbnVlOwoKCQlp
ZiAodGNwX3NtYWxsX3F1ZXVlX2NoZWNrKHNrLCBza2IsIDEpKQoJCQlicmVhazsKCgkJaWYgKHRj
cF9yZXRyYW5zbWl0X3NrYihzaywgc2tiLCBzZWdzKSkKCQkJYnJlYWs7CgoJCU5FVF9BRERfU1RB
VFMoc29ja19uZXQoc2spLCBtaWJfaWR4LCB0Y3Bfc2tiX3Bjb3VudChza2IpKTsKCgkJaWYgKHRj
cF9pbl9jd25kX3JlZHVjdGlvbihzaykpCgkJCXRwLT5wcnJfb3V0ICs9IHRjcF9za2JfcGNvdW50
KHNrYik7CgoJCWlmIChza2IgPT0gcnR4X2hlYWQgJiYKCQkgICAgaWNzay0+aWNza19wZW5kaW5n
ICE9IElDU0tfVElNRV9SRU9fVElNRU9VVCkKCQkJcmVhcm1fdGltZXIgPSB0cnVlOwoKCX0KCWlm
IChyZWFybV90aW1lcikKCQl0Y3BfcmVzZXRfeG1pdF90aW1lcihzaywgSUNTS19USU1FX1JFVFJB
TlMsCgkJCQkgICAgIGluZXRfY3NrKHNrKS0+aWNza19ydG8sCgkJCQkgICAgIFRDUF9SVE9fTUFY
KTsKfQoKLyogV2UgYWxsb3cgdG8gZXhjZWVkIG1lbW9yeSBsaW1pdHMgZm9yIEZJTiBwYWNrZXRz
IHRvIGV4cGVkaXRlCiAqIGNvbm5lY3Rpb24gdGVhciBkb3duIGFuZCAobWVtb3J5KSByZWNvdmVy
eS4KICogT3RoZXJ3aXNlIHRjcF9zZW5kX2ZpbigpIGNvdWxkIGJlIHRlbXB0ZWQgdG8gZWl0aGVy
IGRlbGF5IEZJTgogKiBvciBldmVuIGJlIGZvcmNlZCB0byBjbG9zZSBmbG93IHdpdGhvdXQgYW55
IEZJTi4KICogSW4gZ2VuZXJhbCwgd2Ugd2FudCB0byBhbGxvdyBvbmUgc2tiIHBlciBzb2NrZXQg
dG8gYXZvaWQgaGFuZ3MKICogd2l0aCBlZGdlIHRyaWdnZXIgZXBvbGwoKQogKi8Kdm9pZCBza19m
b3JjZWRfbWVtX3NjaGVkdWxlKHN0cnVjdCBzb2NrICpzaywgaW50IHNpemUpCnsKCWludCBkZWx0
YSwgYW10OwoKCWRlbHRhID0gc2l6ZSAtIHNrLT5za19mb3J3YXJkX2FsbG9jOwoJaWYgKGRlbHRh
IDw9IDApCgkJcmV0dXJuOwoJYW10ID0gc2tfbWVtX3BhZ2VzKGRlbHRhKTsKCXNrX2ZvcndhcmRf
YWxsb2NfYWRkKHNrLCBhbXQgPDwgUEFHRV9TSElGVCk7Cglza19tZW1vcnlfYWxsb2NhdGVkX2Fk
ZChzaywgYW10KTsKCglpZiAobWVtX2Nncm91cF9zb2NrZXRzX2VuYWJsZWQgJiYgc2stPnNrX21l
bWNnKQoJCW1lbV9jZ3JvdXBfY2hhcmdlX3NrbWVtKHNrLT5za19tZW1jZywgYW10LAoJCQkJCWdm
cF9tZW1jZ19jaGFyZ2UoKSB8IF9fR0ZQX05PRkFJTCk7Cn0KCi8qIFNlbmQgYSBGSU4uIFRoZSBj
YWxsZXIgbG9ja3MgdGhlIHNvY2tldCBmb3IgdXMuCiAqIFdlIHNob3VsZCB0cnkgdG8gc2VuZCBh
IEZJTiBwYWNrZXQgcmVhbGx5IGhhcmQsIGJ1dCBldmVudHVhbGx5IGdpdmUgdXAuCiAqLwp2b2lk
IHRjcF9zZW5kX2ZpbihzdHJ1Y3Qgc29jayAqc2spCnsKCXN0cnVjdCBza19idWZmICpza2IsICp0
c2tiLCAqdGFpbCA9IHRjcF93cml0ZV9xdWV1ZV90YWlsKHNrKTsKCXN0cnVjdCB0Y3Bfc29jayAq
dHAgPSB0Y3Bfc2soc2spOwoKCS8qIE9wdGltaXphdGlvbiwgdGFjayBvbiB0aGUgRklOIGlmIHdl
IGhhdmUgb25lIHNrYiBpbiB3cml0ZSBxdWV1ZSBhbmQKCSAqIHRoaXMgc2tiIHdhcyBub3QgeWV0
IHNlbnQsIG9yIHdlIGFyZSB1bmRlciBtZW1vcnkgcHJlc3N1cmUuCgkgKiBOb3RlOiBpbiB0aGUg
bGF0dGVyIGNhc2UsIEZJTiBwYWNrZXQgd2lsbCBiZSBzZW50IGFmdGVyIGEgdGltZW91dCwKCSAq
IGFzIFRDUCBzdGFjayB0aGlua3MgaXQgaGFzIGFscmVhZHkgYmVlbiB0cmFuc21pdHRlZC4KCSAq
LwoJdHNrYiA9IHRhaWw7CglpZiAoIXRza2IgJiYgdGNwX3VuZGVyX21lbW9yeV9wcmVzc3VyZShz
aykpCgkJdHNrYiA9IHNrYl9yYl9sYXN0KCZzay0+dGNwX3J0eF9xdWV1ZSk7CgoJaWYgKHRza2Ip
IHsKCQlUQ1BfU0tCX0NCKHRza2IpLT50Y3BfZmxhZ3MgfD0gVENQSERSX0ZJTjsKCQlUQ1BfU0tC
X0NCKHRza2IpLT5lbmRfc2VxKys7CgkJdHAtPndyaXRlX3NlcSsrOwoJCWlmICghdGFpbCkgewoJ
CQkvKiBUaGlzIG1lYW5zIHRza2Igd2FzIGFscmVhZHkgc2VudC4KCQkJICogUHJldGVuZCB3ZSBp
bmNsdWRlZCB0aGUgRklOIG9uIHByZXZpb3VzIHRyYW5zbWl0LgoJCQkgKiBXZSBuZWVkIHRvIHNl
dCB0cC0+c25kX254dCB0byB0aGUgdmFsdWUgaXQgd291bGQgaGF2ZQoJCQkgKiBpZiBGSU4gaGFk
IGJlZW4gc2VudC4gVGhpcyBpcyBiZWNhdXNlIHJldHJhbnNtaXQgcGF0aAoJCQkgKiBkb2VzIG5v
dCBjaGFuZ2UgdHAtPnNuZF9ueHQuCgkJCSAqLwoJCQlXUklURV9PTkNFKHRwLT5zbmRfbnh0LCB0
cC0+c25kX254dCArIDEpOwoJCQlyZXR1cm47CgkJfQoJfSBlbHNlIHsKCQlza2IgPSBhbGxvY19z
a2JfZmNsb25lKE1BWF9UQ1BfSEVBREVSLAoJCQkJICAgICAgIHNrX2dmcF9tYXNrKHNrLCBHRlBf
QVRPTUlDIHwKCQkJCQkJICAgICAgIF9fR0ZQX05PV0FSTikpOwoJCWlmICh1bmxpa2VseSghc2ti
KSkKCQkJcmV0dXJuOwoKCQlJTklUX0xJU1RfSEVBRCgmc2tiLT50Y3BfdHNvcnRlZF9hbmNob3Ip
OwoJCXNrYl9yZXNlcnZlKHNrYiwgTUFYX1RDUF9IRUFERVIpOwoJCXNrX2ZvcmNlZF9tZW1fc2No
ZWR1bGUoc2ssIHNrYi0+dHJ1ZXNpemUpOwoJCS8qIEZJTiBlYXRzIGEgc2VxdWVuY2UgYnl0ZSwg
d3JpdGVfc2VxIGFkdmFuY2VkIGJ5IHRjcF9xdWV1ZV9za2IoKS4gKi8KCQl0Y3BfaW5pdF9ub25k
YXRhX3NrYihza2IsIHRwLT53cml0ZV9zZXEsCgkJCQkgICAgIFRDUEhEUl9BQ0sgfCBUQ1BIRFJf
RklOKTsKCQl0Y3BfcXVldWVfc2tiKHNrLCBza2IpOwoJfQoJX190Y3BfcHVzaF9wZW5kaW5nX2Zy
YW1lcyhzaywgdGNwX2N1cnJlbnRfbXNzKHNrKSwgVENQX05BR0xFX09GRik7Cn0KCi8qIFdlIGdl
dCBoZXJlIHdoZW4gYSBwcm9jZXNzIGNsb3NlcyBhIGZpbGUgZGVzY3JpcHRvciAoZWl0aGVyIGR1
ZSB0bwogKiBhbiBleHBsaWNpdCBjbG9zZSgpIG9yIGFzIGEgYnlwcm9kdWN0IG9mIGV4aXQoKSdp
bmcpIGFuZCB0aGVyZQogKiB3YXMgdW5yZWFkIGRhdGEgaW4gdGhlIHJlY2VpdmUgcXVldWUuICBU
aGlzIGJlaGF2aW9yIGlzIHJlY29tbWVuZGVkCiAqIGJ5IFJGQyAyNTI1LCBzZWN0aW9uIDIuMTcu
ICAtRGF2ZU0KICovCnZvaWQgdGNwX3NlbmRfYWN0aXZlX3Jlc2V0KHN0cnVjdCBzb2NrICpzaywg
Z2ZwX3QgcHJpb3JpdHkpCnsKCXN0cnVjdCBza19idWZmICpza2I7CgoJVENQX0lOQ19TVEFUUyhz
b2NrX25ldChzayksIFRDUF9NSUJfT1VUUlNUUyk7CgoJLyogTk9URTogTm8gVENQIG9wdGlvbnMg
YXR0YWNoZWQgYW5kIHdlIG5ldmVyIHJldHJhbnNtaXQgdGhpcy4gKi8KCXNrYiA9IGFsbG9jX3Nr
YihNQVhfVENQX0hFQURFUiwgcHJpb3JpdHkpOwoJaWYgKCFza2IpIHsKCQlORVRfSU5DX1NUQVRT
KHNvY2tfbmV0KHNrKSwgTElOVVhfTUlCX1RDUEFCT1JURkFJTEVEKTsKCQlyZXR1cm47Cgl9CgoJ
LyogUmVzZXJ2ZSBzcGFjZSBmb3IgaGVhZGVycyBhbmQgcHJlcGFyZSBjb250cm9sIGJpdHMuICov
Cglza2JfcmVzZXJ2ZShza2IsIE1BWF9UQ1BfSEVBREVSKTsKCXRjcF9pbml0X25vbmRhdGFfc2ti
KHNrYiwgdGNwX2FjY2VwdGFibGVfc2VxKHNrKSwKCQkJICAgICBUQ1BIRFJfQUNLIHwgVENQSERS
X1JTVCk7Cgl0Y3BfbXN0YW1wX3JlZnJlc2godGNwX3NrKHNrKSk7CgkvKiBTZW5kIGl0IG9mZi4g
Ki8KCWlmICh0Y3BfdHJhbnNtaXRfc2tiKHNrLCBza2IsIDAsIHByaW9yaXR5KSkKCQlORVRfSU5D
X1NUQVRTKHNvY2tfbmV0KHNrKSwgTElOVVhfTUlCX1RDUEFCT1JURkFJTEVEKTsKCgkvKiBza2Ig
b2YgdHJhY2VfdGNwX3NlbmRfcmVzZXQoKSBrZWVwcyB0aGUgc2tiIHRoYXQgY2F1c2VkIFJTVCwK
CSAqIHNrYiBoZXJlIGlzIGRpZmZlcmVudCB0byB0aGUgdHJvdWJsZXNvbWUgc2tiLCBzbyB1c2Ug
TlVMTAoJICovCgl0cmFjZV90Y3Bfc2VuZF9yZXNldChzaywgTlVMTCk7Cn0KCi8qIFNlbmQgYSBj
cm9zc2VkIFNZTi1BQ0sgZHVyaW5nIHNvY2tldCBlc3RhYmxpc2htZW50LgogKiBXQVJOSU5HOiBU
aGlzIHJvdXRpbmUgbXVzdCBvbmx5IGJlIGNhbGxlZCB3aGVuIHdlIGhhdmUgYWxyZWFkeSBzZW50
CiAqIGEgU1lOIHBhY2tldCB0aGF0IGNyb3NzZWQgdGhlIGluY29taW5nIFNZTiB0aGF0IGNhdXNl
ZCB0aGlzIHJvdXRpbmUKICogdG8gZ2V0IGNhbGxlZC4gSWYgdGhpcyBhc3N1bXB0aW9uIGZhaWxz
IHRoZW4gdGhlIGluaXRpYWwgcmN2X3duZAogKiBhbmQgcmN2X3dzY2FsZSB2YWx1ZXMgd2lsbCBu
b3QgYmUgY29ycmVjdC4KICovCmludCB0Y3Bfc2VuZF9zeW5hY2soc3RydWN0IHNvY2sgKnNrKQp7
CglzdHJ1Y3Qgc2tfYnVmZiAqc2tiOwoKCXNrYiA9IHRjcF9ydHhfcXVldWVfaGVhZChzayk7Cglp
ZiAoIXNrYiB8fCAhKFRDUF9TS0JfQ0Ioc2tiKS0+dGNwX2ZsYWdzICYgVENQSERSX1NZTikpIHsK
CQlwcl9lcnIoIiVzOiB3cm9uZyBxdWV1ZSBzdGF0ZVxuIiwgX19mdW5jX18pOwoJCXJldHVybiAt
RUZBVUxUOwoJfQoJaWYgKCEoVENQX1NLQl9DQihza2IpLT50Y3BfZmxhZ3MgJiBUQ1BIRFJfQUNL
KSkgewoJCWlmIChza2JfY2xvbmVkKHNrYikpIHsKCQkJc3RydWN0IHNrX2J1ZmYgKm5za2I7CgoJ
CQl0Y3Bfc2tiX3Rzb3J0ZWRfc2F2ZShza2IpIHsKCQkJCW5za2IgPSBza2JfY29weShza2IsIEdG
UF9BVE9NSUMpOwoJCQl9IHRjcF9za2JfdHNvcnRlZF9yZXN0b3JlKHNrYik7CgkJCWlmICghbnNr
YikKCQkJCXJldHVybiAtRU5PTUVNOwoJCQlJTklUX0xJU1RfSEVBRCgmbnNrYi0+dGNwX3Rzb3J0
ZWRfYW5jaG9yKTsKCQkJdGNwX2hpZ2hlc3Rfc2Fja19yZXBsYWNlKHNrLCBza2IsIG5za2IpOwoJ
CQl0Y3BfcnR4X3F1ZXVlX3VubGlua19hbmRfZnJlZShza2IsIHNrKTsKCQkJX19za2JfaGVhZGVy
X3JlbGVhc2UobnNrYik7CgkJCXRjcF9yYnRyZWVfaW5zZXJ0KCZzay0+dGNwX3J0eF9xdWV1ZSwg
bnNrYik7CgkJCXNrX3dtZW1fcXVldWVkX2FkZChzaywgbnNrYi0+dHJ1ZXNpemUpOwoJCQlza19t
ZW1fY2hhcmdlKHNrLCBuc2tiLT50cnVlc2l6ZSk7CgkJCXNrYiA9IG5za2I7CgkJfQoKCQlUQ1Bf
U0tCX0NCKHNrYiktPnRjcF9mbGFncyB8PSBUQ1BIRFJfQUNLOwoJCXRjcF9lY25fc2VuZF9zeW5h
Y2soc2ssIHNrYik7Cgl9CglyZXR1cm4gdGNwX3RyYW5zbWl0X3NrYihzaywgc2tiLCAxLCBHRlBf
QVRPTUlDKTsKfQoKLyoqCiAqIHRjcF9tYWtlX3N5bmFjayAtIEFsbG9jYXRlIG9uZSBza2IgYW5k
IGJ1aWxkIGEgU1lOQUNLIHBhY2tldC4KICogQHNrOiBsaXN0ZW5lciBzb2NrZXQKICogQGRzdDog
ZHN0IGVudHJ5IGF0dGFjaGVkIHRvIHRoZSBTWU5BQ0suIEl0IGlzIGNvbnN1bWVkIGFuZCBjYWxs
ZXIKICogICAgICAgc2hvdWxkIG5vdCB1c2UgaXQgYWdhaW4uCiAqIEByZXE6IHJlcXVlc3Rfc29j
ayBwb2ludGVyCiAqIEBmb2M6IGNvb2tpZSBmb3IgdGNwIGZhc3Qgb3BlbgogKiBAc3luYWNrX3R5
cGU6IFR5cGUgb2Ygc3luYWNrIHRvIHByZXBhcmUKICogQHN5bl9za2I6IFNZTiBwYWNrZXQganVz
dCByZWNlaXZlZC4gIEl0IGNvdWxkIGJlIE5VTEwgZm9yIHJ0eCBjYXNlLgogKi8Kc3RydWN0IHNr
X2J1ZmYgKnRjcF9tYWtlX3N5bmFjayhjb25zdCBzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBkc3Rf
ZW50cnkgKmRzdCwKCQkJCXN0cnVjdCByZXF1ZXN0X3NvY2sgKnJlcSwKCQkJCXN0cnVjdCB0Y3Bf
ZmFzdG9wZW5fY29va2llICpmb2MsCgkJCQllbnVtIHRjcF9zeW5hY2tfdHlwZSBzeW5hY2tfdHlw
ZSwKCQkJCXN0cnVjdCBza19idWZmICpzeW5fc2tiKQp7CglzdHJ1Y3QgaW5ldF9yZXF1ZXN0X3Nv
Y2sgKmlyZXEgPSBpbmV0X3JzayhyZXEpOwoJY29uc3Qgc3RydWN0IHRjcF9zb2NrICp0cCA9IHRj
cF9zayhzayk7CglzdHJ1Y3QgdGNwX291dF9vcHRpb25zIG9wdHM7CglzdHJ1Y3QgdGNwX2tleSBr
ZXkgPSB7fTsKCXN0cnVjdCBza19idWZmICpza2I7CglpbnQgdGNwX2hlYWRlcl9zaXplOwoJc3Ry
dWN0IHRjcGhkciAqdGg7CglpbnQgbXNzOwoJdTY0IG5vdzsKCglza2IgPSBhbGxvY19za2IoTUFY
X1RDUF9IRUFERVIsIEdGUF9BVE9NSUMpOwoJaWYgKHVubGlrZWx5KCFza2IpKSB7CgkJZHN0X3Jl
bGVhc2UoZHN0KTsKCQlyZXR1cm4gTlVMTDsKCX0KCS8qIFJlc2VydmUgc3BhY2UgZm9yIGhlYWRl
cnMuICovCglza2JfcmVzZXJ2ZShza2IsIE1BWF9UQ1BfSEVBREVSKTsKCglzd2l0Y2ggKHN5bmFj
a190eXBlKSB7CgljYXNlIFRDUF9TWU5BQ0tfTk9STUFMOgoJCXNrYl9zZXRfb3duZXJfdyhza2Is
IHJlcV90b19zayhyZXEpKTsKCQlicmVhazsKCWNhc2UgVENQX1NZTkFDS19DT09LSUU6CgkJLyog
VW5kZXIgc3luZmxvb2QsIHdlIGRvIG5vdCBhdHRhY2ggc2tiIHRvIGEgc29ja2V0LAoJCSAqIHRv
IGF2b2lkIGZhbHNlIHNoYXJpbmcuCgkJICovCgkJYnJlYWs7CgljYXNlIFRDUF9TWU5BQ0tfRkFT
VE9QRU46CgkJLyogc2sgaXMgYSBjb25zdCBwb2ludGVyLCBiZWNhdXNlIHdlIHdhbnQgdG8gZXhw
cmVzcyBtdWx0aXBsZQoJCSAqIGNwdSBtaWdodCBjYWxsIHVzIGNvbmN1cnJlbnRseS4KCQkgKiBz
ay0+c2tfd21lbV9hbGxvYyBpbiBhbiBhdG9taWMsIHdlIGNhbiBwcm9tb3RlIHRvIHJ3LgoJCSAq
LwoJCXNrYl9zZXRfb3duZXJfdyhza2IsIChzdHJ1Y3Qgc29jayAqKXNrKTsKCQlicmVhazsKCX0K
CXNrYl9kc3Rfc2V0KHNrYiwgZHN0KTsKCgltc3MgPSB0Y3BfbXNzX2NsYW1wKHRwLCBkc3RfbWV0
cmljX2Fkdm1zcyhkc3QpKTsKCgltZW1zZXQoJm9wdHMsIDAsIHNpemVvZihvcHRzKSk7Cglub3cg
PSB0Y3BfY2xvY2tfbnMoKTsKI2lmZGVmIENPTkZJR19TWU5fQ09PS0lFUwoJaWYgKHVubGlrZWx5
KHN5bmFja190eXBlID09IFRDUF9TWU5BQ0tfQ09PS0lFICYmIGlyZXEtPnRzdGFtcF9vaykpCgkJ
c2tiX3NldF9kZWxpdmVyeV90aW1lKHNrYiwgY29va2llX2luaXRfdGltZXN0YW1wKHJlcSwgbm93
KSwKCQkJCSAgICAgIHRydWUpOwoJZWxzZQojZW5kaWYKCXsKCQlza2Jfc2V0X2RlbGl2ZXJ5X3Rp
bWUoc2tiLCBub3csIHRydWUpOwoJCWlmICghdGNwX3JzayhyZXEpLT5zbnRfc3luYWNrKSAvKiBU
aW1lc3RhbXAgZmlyc3QgU1lOQUNLICovCgkJCXRjcF9yc2socmVxKS0+c250X3N5bmFjayA9IHRj
cF9za2JfdGltZXN0YW1wX3VzKHNrYik7Cgl9CgojaWYgZGVmaW5lZChDT05GSUdfVENQX01ENVNJ
RykgfHwgZGVmaW5lZChDT05GSUdfVENQX0FPKQoJcmN1X3JlYWRfbG9jaygpOwojZW5kaWYKCWlm
ICh0Y3BfcnNrX3VzZWRfYW8ocmVxKSkgewojaWZkZWYgQ09ORklHX1RDUF9BTwoJCXN0cnVjdCB0
Y3BfYW9fa2V5ICphb19rZXkgPSBOVUxMOwoJCXU4IGtleWlkID0gdGNwX3JzayhyZXEpLT5hb19r
ZXlpZDsKCgkJYW9fa2V5ID0gdGNwX3NrKHNrKS0+YWZfc3BlY2lmaWMtPmFvX2xvb2t1cChzaywg
cmVxX3RvX3NrKHJlcSksCgkJCQkJCQkgICAga2V5aWQsIC0xKTsKCQkvKiBJZiB0aGVyZSBpcyBu
byBtYXRjaGluZyBrZXkgLSBhdm9pZCBzZW5kaW5nIGFueXRoaW5nLAoJCSAqIGVzcGVjaWFsbHkg
dXNpZ25lZCBzZWdtZW50cy4gSXQgY291bGQgdHJ5IGhhcmRlciBhbmQgbG9va3VwCgkJICogZm9y
IGFub3RoZXIgcGVlci1tYXRjaGluZyBrZXksIGJ1dCB0aGUgcGVlciBoYXMgcmVxdWVzdGVkCgkJ
ICogYW9fa2V5aWQgKFJGQzU5MjUgUk5leHRLZXlJRCksIHNvIGxldCdzIGtlZXAgaXQgc2ltcGxl
IGhlcmUuCgkJICovCgkJaWYgKHVubGlrZWx5KCFhb19rZXkpKSB7CgkJCXJjdV9yZWFkX3VubG9j
aygpOwoJCQlrZnJlZV9za2Ioc2tiKTsKCQkJbmV0X3dhcm5fcmF0ZWxpbWl0ZWQoIlRDUC1BTzog
dGhlIGtleWlkICV1IGZyb20gU1lOIHBhY2tldCBpcyBub3QgcHJlc2VudCAtIG5vdCBzZW5kaW5n
IFNZTkFDS1xuIiwKCQkJCQkgICAgIGtleWlkKTsKCQkJcmV0dXJuIE5VTEw7CgkJfQoJCWtleS5h
b19rZXkgPSBhb19rZXk7CgkJa2V5LnR5cGUgPSBUQ1BfS0VZX0FPOwojZW5kaWYKCX0gZWxzZSB7
CiNpZmRlZiBDT05GSUdfVENQX01ENVNJRwoJCWtleS5tZDVfa2V5ID0gdGNwX3JzayhyZXEpLT5h
Zl9zcGVjaWZpYy0+cmVxX21kNV9sb29rdXAoc2ssCgkJCQkJcmVxX3RvX3NrKHJlcSkpOwoJCWlm
IChrZXkubWQ1X2tleSkKCQkJa2V5LnR5cGUgPSBUQ1BfS0VZX01ENTsKI2VuZGlmCgl9Cglza2Jf
c2V0X2hhc2goc2tiLCBSRUFEX09OQ0UodGNwX3JzayhyZXEpLT50eGhhc2gpLCBQS1RfSEFTSF9U
WVBFX0w0KTsKCS8qIGJwZiBwcm9ncmFtIHdpbGwgYmUgaW50ZXJlc3RlZCBpbiB0aGUgdGNwX2Zs
YWdzICovCglUQ1BfU0tCX0NCKHNrYiktPnRjcF9mbGFncyA9IFRDUEhEUl9TWU4gfCBUQ1BIRFJf
QUNLOwoJdGNwX2hlYWRlcl9zaXplID0gdGNwX3N5bmFja19vcHRpb25zKHNrLCByZXEsIG1zcywg
c2tiLCAmb3B0cywKCQkJCQkgICAgICZrZXksIGZvYywgc3luYWNrX3R5cGUsIHN5bl9za2IpCgkJ
CQkJKyBzaXplb2YoKnRoKTsKCglza2JfcHVzaChza2IsIHRjcF9oZWFkZXJfc2l6ZSk7Cglza2Jf
cmVzZXRfdHJhbnNwb3J0X2hlYWRlcihza2IpOwoKCXRoID0gKHN0cnVjdCB0Y3BoZHIgKilza2It
PmRhdGE7CgltZW1zZXQodGgsIDAsIHNpemVvZihzdHJ1Y3QgdGNwaGRyKSk7Cgl0aC0+c3luID0g
MTsKCXRoLT5hY2sgPSAxOwoJdGNwX2Vjbl9tYWtlX3N5bmFjayhyZXEsIHRoKTsKCXRoLT5zb3Vy
Y2UgPSBodG9ucyhpcmVxLT5pcl9udW0pOwoJdGgtPmRlc3QgPSBpcmVxLT5pcl9ybXRfcG9ydDsK
CXNrYi0+bWFyayA9IGlyZXEtPmlyX21hcms7Cglza2ItPmlwX3N1bW1lZCA9IENIRUNLU1VNX1BB
UlRJQUw7Cgl0aC0+c2VxID0gaHRvbmwodGNwX3JzayhyZXEpLT5zbnRfaXNuKTsKCS8qIFhYWCBk
YXRhIGlzIHF1ZXVlZCBhbmQgYWNrZWQgYXMgaXMuIE5vIGJ1ZmZlci93aW5kb3cgY2hlY2sgKi8K
CXRoLT5hY2tfc2VxID0gaHRvbmwodGNwX3JzayhyZXEpLT5yY3Zfbnh0KTsKCgkvKiBSRkMxMzIz
OiBUaGUgd2luZG93IGluIFNZTiAmIFNZTi9BQ0sgc2VnbWVudHMgaXMgbmV2ZXIgc2NhbGVkLiAq
LwoJdGgtPndpbmRvdyA9IGh0b25zKG1pbihyZXEtPnJza19yY3Zfd25kLCA2NTUzNVUpKTsKCXRj
cF9vcHRpb25zX3dyaXRlKHRoLCBOVUxMLCB0Y3BfcnNrKHJlcSksICZvcHRzLCAma2V5KTsKCXRo
LT5kb2ZmID0gKHRjcF9oZWFkZXJfc2l6ZSA+PiAyKTsKCVRDUF9JTkNfU1RBVFMoc29ja19uZXQo
c2spLCBUQ1BfTUlCX09VVFNFR1MpOwoKCS8qIE9rYXksIHdlIGhhdmUgYWxsIHdlIG5lZWQgLSBk
byB0aGUgbWQ1IGhhc2ggaWYgbmVlZGVkICovCglpZiAodGNwX2tleV9pc19tZDUoJmtleSkpIHsK
I2lmZGVmIENPTkZJR19UQ1BfTUQ1U0lHCgkJdGNwX3JzayhyZXEpLT5hZl9zcGVjaWZpYy0+Y2Fs
Y19tZDVfaGFzaChvcHRzLmhhc2hfbG9jYXRpb24sCgkJCQkJa2V5Lm1kNV9rZXksIHJlcV90b19z
ayhyZXEpLCBza2IpOwojZW5kaWYKCX0gZWxzZSBpZiAodGNwX2tleV9pc19hbygma2V5KSkgewoj
aWZkZWYgQ09ORklHX1RDUF9BTwoJCXRjcF9yc2socmVxKS0+YWZfc3BlY2lmaWMtPmFvX3N5bmFj
a19oYXNoKG9wdHMuaGFzaF9sb2NhdGlvbiwKCQkJCQlrZXkuYW9fa2V5LCByZXEsIHNrYiwKCQkJ
CQlvcHRzLmhhc2hfbG9jYXRpb24gLSAodTggKil0aCwgMCk7CiNlbmRpZgoJfQojaWYgZGVmaW5l
ZChDT05GSUdfVENQX01ENVNJRykgfHwgZGVmaW5lZChDT05GSUdfVENQX0FPKQoJcmN1X3JlYWRf
dW5sb2NrKCk7CiNlbmRpZgoKCWJwZl9za29wc193cml0ZV9oZHJfb3B0KChzdHJ1Y3Qgc29jayAq
KXNrLCBza2IsIHJlcSwgc3luX3NrYiwKCQkJCXN5bmFja190eXBlLCAmb3B0cyk7CgoJc2tiX3Nl
dF9kZWxpdmVyeV90aW1lKHNrYiwgbm93LCB0cnVlKTsKCXRjcF9hZGRfdHhfZGVsYXkoc2tiLCB0
cCk7CgoJcmV0dXJuIHNrYjsKfQpFWFBPUlRfU1lNQk9MKHRjcF9tYWtlX3N5bmFjayk7CgpzdGF0
aWMgdm9pZCB0Y3BfY2FfZHN0X2luaXQoc3RydWN0IHNvY2sgKnNrLCBjb25zdCBzdHJ1Y3QgZHN0
X2VudHJ5ICpkc3QpCnsKCXN0cnVjdCBpbmV0X2Nvbm5lY3Rpb25fc29jayAqaWNzayA9IGluZXRf
Y3NrKHNrKTsKCWNvbnN0IHN0cnVjdCB0Y3BfY29uZ2VzdGlvbl9vcHMgKmNhOwoJdTMyIGNhX2tl
eSA9IGRzdF9tZXRyaWMoZHN0LCBSVEFYX0NDX0FMR08pOwoKCWlmIChjYV9rZXkgPT0gVENQX0NB
X1VOU1BFQykKCQlyZXR1cm47CgoJcmN1X3JlYWRfbG9jaygpOwoJY2EgPSB0Y3BfY2FfZmluZF9r
ZXkoY2Ffa2V5KTsKCWlmIChsaWtlbHkoY2EgJiYgYnBmX3RyeV9tb2R1bGVfZ2V0KGNhLCBjYS0+
b3duZXIpKSkgewoJCWJwZl9tb2R1bGVfcHV0KGljc2stPmljc2tfY2Ffb3BzLCBpY3NrLT5pY3Nr
X2NhX29wcy0+b3duZXIpOwoJCWljc2stPmljc2tfY2FfZHN0X2xvY2tlZCA9IHRjcF9jYV9kc3Rf
bG9ja2VkKGRzdCk7CgkJaWNzay0+aWNza19jYV9vcHMgPSBjYTsKCX0KCXJjdV9yZWFkX3VubG9j
aygpOwp9CgovKiBEbyBhbGwgY29ubmVjdCBzb2NrZXQgc2V0dXBzIHRoYXQgY2FuIGJlIGRvbmUg
QUYgaW5kZXBlbmRlbnQuICovCnN0YXRpYyB2b2lkIHRjcF9jb25uZWN0X2luaXQoc3RydWN0IHNv
Y2sgKnNrKQp7Cgljb25zdCBzdHJ1Y3QgZHN0X2VudHJ5ICpkc3QgPSBfX3NrX2RzdF9nZXQoc2sp
OwoJc3RydWN0IHRjcF9zb2NrICp0cCA9IHRjcF9zayhzayk7CglfX3U4IHJjdl93c2NhbGU7Cgl1
MzIgcmN2X3duZDsKCgkvKiBXZSdsbCBmaXggdGhpcyB1cCB3aGVuIHdlIGdldCBhIHJlc3BvbnNl
IGZyb20gdGhlIG90aGVyIGVuZC4KCSAqIFNlZSB0Y3BfaW5wdXQuYzp0Y3BfcmN2X3N0YXRlX3By
b2Nlc3MgY2FzZSBUQ1BfU1lOX1NFTlQuCgkgKi8KCXRwLT50Y3BfaGVhZGVyX2xlbiA9IHNpemVv
ZihzdHJ1Y3QgdGNwaGRyKTsKCWlmIChSRUFEX09OQ0Uoc29ja19uZXQoc2spLT5pcHY0LnN5c2N0
bF90Y3BfdGltZXN0YW1wcykpCgkJdHAtPnRjcF9oZWFkZXJfbGVuICs9IFRDUE9MRU5fVFNUQU1Q
X0FMSUdORUQ7CgoJdGNwX2FvX2Nvbm5lY3RfaW5pdChzayk7CgoJLyogSWYgdXNlciBnYXZlIGhp
cyBUQ1BfTUFYU0VHLCByZWNvcmQgaXQgdG8gY2xhbXAgKi8KCWlmICh0cC0+cnhfb3B0LnVzZXJf
bXNzKQoJCXRwLT5yeF9vcHQubXNzX2NsYW1wID0gdHAtPnJ4X29wdC51c2VyX21zczsKCXRwLT5t
YXhfd2luZG93ID0gMDsKCXRjcF9tdHVwX2luaXQoc2spOwoJdGNwX3N5bmNfbXNzKHNrLCBkc3Rf
bXR1KGRzdCkpOwoKCXRjcF9jYV9kc3RfaW5pdChzaywgZHN0KTsKCglpZiAoIXRwLT53aW5kb3df
Y2xhbXApCgkJV1JJVEVfT05DRSh0cC0+d2luZG93X2NsYW1wLCBkc3RfbWV0cmljKGRzdCwgUlRB
WF9XSU5ET1cpKTsKCXRwLT5hZHZtc3MgPSB0Y3BfbXNzX2NsYW1wKHRwLCBkc3RfbWV0cmljX2Fk
dm1zcyhkc3QpKTsKCgl0Y3BfaW5pdGlhbGl6ZV9yY3ZfbXNzKHNrKTsKCgkvKiBsaW1pdCB0aGUg
d2luZG93IHNlbGVjdGlvbiBpZiB0aGUgdXNlciBlbmZvcmNlIGEgc21hbGxlciByeCBidWZmZXIg
Ki8KCWlmIChzay0+c2tfdXNlcmxvY2tzICYgU09DS19SQ1ZCVUZfTE9DSyAmJgoJICAgICh0cC0+
d2luZG93X2NsYW1wID4gdGNwX2Z1bGxfc3BhY2Uoc2spIHx8IHRwLT53aW5kb3dfY2xhbXAgPT0g
MCkpCgkJV1JJVEVfT05DRSh0cC0+d2luZG93X2NsYW1wLCB0Y3BfZnVsbF9zcGFjZShzaykpOwoK
CXJjdl93bmQgPSB0Y3BfcnduZF9pbml0X2JwZihzayk7CglpZiAocmN2X3duZCA9PSAwKQoJCXJj
dl93bmQgPSBkc3RfbWV0cmljKGRzdCwgUlRBWF9JTklUUldORCk7CgoJdGNwX3NlbGVjdF9pbml0
aWFsX3dpbmRvdyhzaywgdGNwX2Z1bGxfc3BhY2Uoc2spLAoJCQkJICB0cC0+YWR2bXNzIC0gKHRw
LT5yeF9vcHQudHNfcmVjZW50X3N0YW1wID8gdHAtPnRjcF9oZWFkZXJfbGVuIC0gc2l6ZW9mKHN0
cnVjdCB0Y3BoZHIpIDogMCksCgkJCQkgICZ0cC0+cmN2X3duZCwKCQkJCSAgJnRwLT53aW5kb3df
Y2xhbXAsCgkJCQkgIFJFQURfT05DRShzb2NrX25ldChzayktPmlwdjQuc3lzY3RsX3RjcF93aW5k
b3dfc2NhbGluZyksCgkJCQkgICZyY3Zfd3NjYWxlLAoJCQkJICByY3Zfd25kKTsKCgl0cC0+cnhf
b3B0LnJjdl93c2NhbGUgPSByY3Zfd3NjYWxlOwoJdHAtPnJjdl9zc3RocmVzaCA9IHRwLT5yY3Zf
d25kOwoKCVdSSVRFX09OQ0Uoc2stPnNrX2VyciwgMCk7Cglzb2NrX3Jlc2V0X2ZsYWcoc2ssIFNP
Q0tfRE9ORSk7Cgl0cC0+c25kX3duZCA9IDA7Cgl0Y3BfaW5pdF93bCh0cCwgMCk7Cgl0Y3Bfd3Jp
dGVfcXVldWVfcHVyZ2Uoc2spOwoJdHAtPnNuZF91bmEgPSB0cC0+d3JpdGVfc2VxOwoJdHAtPnNu
ZF9zbWwgPSB0cC0+d3JpdGVfc2VxOwoJdHAtPnNuZF91cCA9IHRwLT53cml0ZV9zZXE7CglXUklU
RV9PTkNFKHRwLT5zbmRfbnh0LCB0cC0+d3JpdGVfc2VxKTsKCglpZiAobGlrZWx5KCF0cC0+cmVw
YWlyKSkKCQl0cC0+cmN2X254dCA9IDA7CgllbHNlCgkJdHAtPnJjdl90c3RhbXAgPSB0Y3Bfamlm
ZmllczMyOwoJdHAtPnJjdl93dXAgPSB0cC0+cmN2X254dDsKCVdSSVRFX09OQ0UodHAtPmNvcGll
ZF9zZXEsIHRwLT5yY3Zfbnh0KTsKCglpbmV0X2NzayhzayktPmljc2tfcnRvID0gdGNwX3RpbWVv
dXRfaW5pdChzayk7CglpbmV0X2NzayhzayktPmljc2tfcmV0cmFuc21pdHMgPSAwOwoJdGNwX2Ns
ZWFyX3JldHJhbnModHApOwp9CgpzdGF0aWMgdm9pZCB0Y3BfY29ubmVjdF9xdWV1ZV9za2Ioc3Ry
dWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQp7CglzdHJ1Y3QgdGNwX3NvY2sgKnRw
ID0gdGNwX3NrKHNrKTsKCXN0cnVjdCB0Y3Bfc2tiX2NiICp0Y2IgPSBUQ1BfU0tCX0NCKHNrYik7
CgoJdGNiLT5lbmRfc2VxICs9IHNrYi0+bGVuOwoJX19za2JfaGVhZGVyX3JlbGVhc2Uoc2tiKTsK
CXNrX3dtZW1fcXVldWVkX2FkZChzaywgc2tiLT50cnVlc2l6ZSk7Cglza19tZW1fY2hhcmdlKHNr
LCBza2ItPnRydWVzaXplKTsKCVdSSVRFX09OQ0UodHAtPndyaXRlX3NlcSwgdGNiLT5lbmRfc2Vx
KTsKCXRwLT5wYWNrZXRzX291dCArPSB0Y3Bfc2tiX3Bjb3VudChza2IpOwp9CgovKiBCdWlsZCBh
bmQgc2VuZCBhIFNZTiB3aXRoIGRhdGEgYW5kIChjYWNoZWQpIEZhc3QgT3BlbiBjb29raWUuIEhv
d2V2ZXIsCiAqIHF1ZXVlIGEgZGF0YS1vbmx5IHBhY2tldCBhZnRlciB0aGUgcmVndWxhciBTWU4s
IHN1Y2ggdGhhdCByZWd1bGFyIFNZTnMKICogYXJlIHJldHJhbnNtaXR0ZWQgb24gdGltZW91dHMu
IEFsc28gaWYgdGhlIHJlbW90ZSBTWU4tQUNLIGFja25vd2xlZGdlcwogKiBvbmx5IHRoZSBTWU4g
c2VxdWVuY2UsIHRoZSBkYXRhIGFyZSByZXRyYW5zbWl0dGVkIGluIHRoZSBmaXJzdCBBQ0suCiAq
IElmIGNvb2tpZSBpcyBub3QgY2FjaGVkIG9yIG90aGVyIGVycm9yIG9jY3VycywgZmFsbHMgYmFj
ayB0byBzZW5kIGEKICogcmVndWxhciBTWU4gd2l0aCBGYXN0IE9wZW4gY29va2llIHJlcXVlc3Qg
b3B0aW9uLgogKi8Kc3RhdGljIGludCB0Y3Bfc2VuZF9zeW5fZGF0YShzdHJ1Y3Qgc29jayAqc2ss
IHN0cnVjdCBza19idWZmICpzeW4pCnsKCXN0cnVjdCBpbmV0X2Nvbm5lY3Rpb25fc29jayAqaWNz
ayA9IGluZXRfY3NrKHNrKTsKCXN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOwoJc3Ry
dWN0IHRjcF9mYXN0b3Blbl9yZXF1ZXN0ICpmbyA9IHRwLT5mYXN0b3Blbl9yZXE7CglzdHJ1Y3Qg
cGFnZV9mcmFnICpwZnJhZyA9IHNrX3BhZ2VfZnJhZyhzayk7CglzdHJ1Y3Qgc2tfYnVmZiAqc3lu
X2RhdGE7CglpbnQgc3BhY2UsIGVyciA9IDA7CgoJdHAtPnJ4X29wdC5tc3NfY2xhbXAgPSB0cC0+
YWR2bXNzOyAgLyogSWYgTVNTIGlzIG5vdCBjYWNoZWQgKi8KCWlmICghdGNwX2Zhc3RvcGVuX2Nv
b2tpZV9jaGVjayhzaywgJnRwLT5yeF9vcHQubXNzX2NsYW1wLCAmZm8tPmNvb2tpZSkpCgkJZ290
byBmYWxsYmFjazsKCgkvKiBNU1MgZm9yIFNZTi1kYXRhIGlzIGJhc2VkIG9uIGNhY2hlZCBNU1Mg
YW5kIGJvdW5kZWQgYnkgUE1UVSBhbmQKCSAqIHVzZXItTVNTLiBSZXNlcnZlIG1heGltdW0gb3B0
aW9uIHNwYWNlIGZvciBtaWRkbGVib3hlcyB0aGF0IGFkZAoJICogcHJpdmF0ZSBUQ1Agb3B0aW9u
cy4gVGhlIGNvc3QgaXMgcmVkdWNlZCBkYXRhIHNwYWNlIGluIFNZTiA6KAoJICovCgl0cC0+cnhf
b3B0Lm1zc19jbGFtcCA9IHRjcF9tc3NfY2xhbXAodHAsIHRwLT5yeF9vcHQubXNzX2NsYW1wKTsK
CS8qIFN5bmMgbXNzX2NhY2hlIGFmdGVyIHVwZGF0aW5nIHRoZSBtc3NfY2xhbXAgKi8KCXRjcF9z
eW5jX21zcyhzaywgaWNzay0+aWNza19wbXR1X2Nvb2tpZSk7CgoJc3BhY2UgPSBfX3RjcF9tdHVf
dG9fbXNzKHNrLCBpY3NrLT5pY3NrX3BtdHVfY29va2llKSAtCgkJTUFYX1RDUF9PUFRJT05fU1BB
Q0U7CgoJc3BhY2UgPSBtaW5fdChzaXplX3QsIHNwYWNlLCBmby0+c2l6ZSk7CgoJaWYgKHNwYWNl
ICYmCgkgICAgIXNrYl9wYWdlX2ZyYWdfcmVmaWxsKG1pbl90KHNpemVfdCwgc3BhY2UsIFBBR0Vf
U0laRSksCgkJCQkgIHBmcmFnLCBzay0+c2tfYWxsb2NhdGlvbikpCgkJZ290byBmYWxsYmFjazsK
CXN5bl9kYXRhID0gdGNwX3N0cmVhbV9hbGxvY19za2Ioc2ssIHNrLT5za19hbGxvY2F0aW9uLCBm
YWxzZSk7CglpZiAoIXN5bl9kYXRhKQoJCWdvdG8gZmFsbGJhY2s7CgltZW1jcHkoc3luX2RhdGEt
PmNiLCBzeW4tPmNiLCBzaXplb2Yoc3luLT5jYikpOwoJaWYgKHNwYWNlKSB7CgkJc3BhY2UgPSBt
aW5fdChzaXplX3QsIHNwYWNlLCBwZnJhZy0+c2l6ZSAtIHBmcmFnLT5vZmZzZXQpOwoJCXNwYWNl
ID0gdGNwX3dtZW1fc2NoZWR1bGUoc2ssIHNwYWNlKTsKCX0KCWlmIChzcGFjZSkgewoJCXNwYWNl
ID0gY29weV9wYWdlX2Zyb21faXRlcihwZnJhZy0+cGFnZSwgcGZyYWctPm9mZnNldCwKCQkJCQkg
ICAgc3BhY2UsICZmby0+ZGF0YS0+bXNnX2l0ZXIpOwoJCWlmICh1bmxpa2VseSghc3BhY2UpKSB7
CgkJCXRjcF9za2JfdHNvcnRlZF9hbmNob3JfY2xlYW51cChzeW5fZGF0YSk7CgkJCWtmcmVlX3Nr
YihzeW5fZGF0YSk7CgkJCWdvdG8gZmFsbGJhY2s7CgkJfQoJCXNrYl9maWxsX3BhZ2VfZGVzYyhz
eW5fZGF0YSwgMCwgcGZyYWctPnBhZ2UsCgkJCQkgICBwZnJhZy0+b2Zmc2V0LCBzcGFjZSk7CgkJ
cGFnZV9yZWZfaW5jKHBmcmFnLT5wYWdlKTsKCQlwZnJhZy0+b2Zmc2V0ICs9IHNwYWNlOwoJCXNr
Yl9sZW5fYWRkKHN5bl9kYXRhLCBzcGFjZSk7CgkJc2tiX3pjb3B5X3NldChzeW5fZGF0YSwgZm8t
PnVhcmcsIE5VTEwpOwoJfQoJLyogTm8gbW9yZSBkYXRhIHBlbmRpbmcgaW4gaW5ldF93YWl0X2Zv
cl9jb25uZWN0KCkgKi8KCWlmIChzcGFjZSA9PSBmby0+c2l6ZSkKCQlmby0+ZGF0YSA9IE5VTEw7
Cglmby0+Y29waWVkID0gc3BhY2U7CgoJdGNwX2Nvbm5lY3RfcXVldWVfc2tiKHNrLCBzeW5fZGF0
YSk7CglpZiAoc3luX2RhdGEtPmxlbikKCQl0Y3BfY2hyb25vX3N0YXJ0KHNrLCBUQ1BfQ0hST05P
X0JVU1kpOwoKCWVyciA9IHRjcF90cmFuc21pdF9za2Ioc2ssIHN5bl9kYXRhLCAxLCBzay0+c2tf
YWxsb2NhdGlvbik7CgoJc2tiX3NldF9kZWxpdmVyeV90aW1lKHN5biwgc3luX2RhdGEtPnNrYl9t
c3RhbXBfbnMsIHRydWUpOwoKCS8qIE5vdyBmdWxsIFNZTitEQVRBIHdhcyBjbG9uZWQgYW5kIHNl
bnQgKG9yIG5vdCksCgkgKiByZW1vdmUgdGhlIFNZTiBmcm9tIHRoZSBvcmlnaW5hbCBza2IgKHN5
bl9kYXRhKQoJICogd2Uga2VlcCBpbiB3cml0ZSBxdWV1ZSBpbiBjYXNlIG9mIGEgcmV0cmFuc21p
dCwgYXMgd2UKCSAqIGFsc28gaGF2ZSB0aGUgU1lOIHBhY2tldCAod2l0aCBubyBkYXRhKSBpbiB0
aGUgc2FtZSBxdWV1ZS4KCSAqLwoJVENQX1NLQl9DQihzeW5fZGF0YSktPnNlcSsrOwoJVENQX1NL
Ql9DQihzeW5fZGF0YSktPnRjcF9mbGFncyA9IFRDUEhEUl9BQ0sgfCBUQ1BIRFJfUFNIOwoJaWYg
KCFlcnIpIHsKCQl0cC0+c3luX2RhdGEgPSAoZm8tPmNvcGllZCA+IDApOwoJCXRjcF9yYnRyZWVf
aW5zZXJ0KCZzay0+dGNwX3J0eF9xdWV1ZSwgc3luX2RhdGEpOwoJCU5FVF9JTkNfU1RBVFMoc29j
a19uZXQoc2spLCBMSU5VWF9NSUJfVENQT1JJR0RBVEFTRU5UKTsKCQlnb3RvIGRvbmU7Cgl9CgoJ
LyogZGF0YSB3YXMgbm90IHNlbnQsIHB1dCBpdCBpbiB3cml0ZV9xdWV1ZSAqLwoJX19za2JfcXVl
dWVfdGFpbCgmc2stPnNrX3dyaXRlX3F1ZXVlLCBzeW5fZGF0YSk7Cgl0cC0+cGFja2V0c19vdXQg
LT0gdGNwX3NrYl9wY291bnQoc3luX2RhdGEpOwoKZmFsbGJhY2s6CgkvKiBTZW5kIGEgcmVndWxh
ciBTWU4gd2l0aCBGYXN0IE9wZW4gY29va2llIHJlcXVlc3Qgb3B0aW9uICovCglpZiAoZm8tPmNv
b2tpZS5sZW4gPiAwKQoJCWZvLT5jb29raWUubGVuID0gMDsKCWVyciA9IHRjcF90cmFuc21pdF9z
a2Ioc2ssIHN5biwgMSwgc2stPnNrX2FsbG9jYXRpb24pOwoJaWYgKGVycikKCQl0cC0+c3luX2Zh
c3RvcGVuID0gMDsKZG9uZToKCWZvLT5jb29raWUubGVuID0gLTE7ICAvKiBFeGNsdWRlIEZhc3Qg
T3BlbiBvcHRpb24gZm9yIFNZTiByZXRyaWVzICovCglyZXR1cm4gZXJyOwp9CgovKiBCdWlsZCBh
IFNZTiBhbmQgc2VuZCBpdCBvZmYuICovCmludCB0Y3BfY29ubmVjdChzdHJ1Y3Qgc29jayAqc2sp
CnsKCXN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOwoJc3RydWN0IHNrX2J1ZmYgKmJ1
ZmY7CglpbnQgZXJyOwoKCXRjcF9jYWxsX2JwZihzaywgQlBGX1NPQ0tfT1BTX1RDUF9DT05ORUNU
X0NCLCAwLCBOVUxMKTsKCiNpZiBkZWZpbmVkKENPTkZJR19UQ1BfTUQ1U0lHKSAmJiBkZWZpbmVk
KENPTkZJR19UQ1BfQU8pCgkvKiBIYXMgdG8gYmUgY2hlY2tlZCBsYXRlLCBhZnRlciBzZXR0aW5n
IGRhZGRyL3NhZGRyL29wcy4KCSAqIFJldHVybiBlcnJvciBpZiB0aGUgcGVlciBoYXMgYm90aCBh
IG1kNSBhbmQgYSB0Y3AtYW8ga2V5CgkgKiBjb25maWd1cmVkIGFzIHRoaXMgaXMgYW1iaWd1b3Vz
LgoJICovCglpZiAodW5saWtlbHkocmN1X2RlcmVmZXJlbmNlX3Byb3RlY3RlZCh0cC0+bWQ1c2ln
X2luZm8sCgkJCQkJICAgICAgIGxvY2tkZXBfc29ja19pc19oZWxkKHNrKSkpKSB7CgkJYm9vbCBu
ZWVkc19hbyA9ICEhdHAtPmFmX3NwZWNpZmljLT5hb19sb29rdXAoc2ssIHNrLCAtMSwgLTEpOwoJ
CWJvb2wgbmVlZHNfbWQ1ID0gISF0cC0+YWZfc3BlY2lmaWMtPm1kNV9sb29rdXAoc2ssIHNrKTsK
CQlzdHJ1Y3QgdGNwX2FvX2luZm8gKmFvX2luZm87CgoJCWFvX2luZm8gPSByY3VfZGVyZWZlcmVu
Y2VfY2hlY2sodHAtPmFvX2luZm8sCgkJCQkJCWxvY2tkZXBfc29ja19pc19oZWxkKHNrKSk7CgkJ
aWYgKGFvX2luZm8pIHsKCQkJLyogVGhpcyBpcyBhbiBleHRyYSBjaGVjazogdGNwX2FvX3JlcXVp
cmVkKCkgaW4KCQkJICogdGNwX3Z7NCw2fV9wYXJzZV9tZDVfa2V5cygpIHNob3VsZCBwcmV2ZW50
IGFkZGluZwoJCQkgKiBtZDUga2V5cyBvbiBhb19yZXF1aXJlZCBzb2NrZXQuCgkJCSAqLwoJCQlu
ZWVkc19hbyB8PSBhb19pbmZvLT5hb19yZXF1aXJlZDsKCQkJV0FSTl9PTl9PTkNFKGFvX2luZm8t
PmFvX3JlcXVpcmVkICYmIG5lZWRzX21kNSk7CgkJfQoJCWlmIChuZWVkc19tZDUgJiYgbmVlZHNf
YW8pCgkJCXJldHVybiAtRUtFWVJFSkVDVEVEOwoKCQkvKiBJZiB3ZSBoYXZlIGEgbWF0Y2hpbmcg
bWQ1IGtleSBhbmQgbm8gbWF0Y2hpbmcgdGNwLWFvIGtleQoJCSAqIHRoZW4gZnJlZSB1cCBhb19p
bmZvIGlmIGFsbG9jYXRlZC4KCQkgKi8KCQlpZiAobmVlZHNfbWQ1KSB7CgkJCXRjcF9hb19kZXN0
cm95X3NvY2soc2ssIGZhbHNlKTsKCQl9IGVsc2UgaWYgKG5lZWRzX2FvKSB7CgkJCXRjcF9jbGVh
cl9tZDVfbGlzdChzayk7CgkJCWtmcmVlKHJjdV9yZXBsYWNlX3BvaW50ZXIodHAtPm1kNXNpZ19p
bmZvLCBOVUxMLAoJCQkJCQkgIGxvY2tkZXBfc29ja19pc19oZWxkKHNrKSkpOwoJCX0KCX0KI2Vu
ZGlmCiNpZmRlZiBDT05GSUdfVENQX0FPCglpZiAodW5saWtlbHkocmN1X2RlcmVmZXJlbmNlX3By
b3RlY3RlZCh0cC0+YW9faW5mbywKCQkJCQkgICAgICAgbG9ja2RlcF9zb2NrX2lzX2hlbGQoc2sp
KSkpIHsKCQkvKiBEb24ndCBhbGxvdyBjb25uZWN0aW5nIGlmIGFvIGlzIGNvbmZpZ3VyZWQgYnV0
IG5vCgkJICogbWF0Y2hpbmcga2V5IGlzIGZvdW5kLgoJCSAqLwoJCWlmICghdHAtPmFmX3NwZWNp
ZmljLT5hb19sb29rdXAoc2ssIHNrLCAtMSwgLTEpKQoJCQlyZXR1cm4gLUVLRVlSRUpFQ1RFRDsK
CX0KI2VuZGlmCgoJaWYgKGluZXRfY3NrKHNrKS0+aWNza19hZl9vcHMtPnJlYnVpbGRfaGVhZGVy
KHNrKSkKCQlyZXR1cm4gLUVIT1NUVU5SRUFDSDsgLyogUm91dGluZyBmYWlsdXJlIG9yIHNpbWls
YXIuICovCgoJdGNwX2Nvbm5lY3RfaW5pdChzayk7CgoJaWYgKHVubGlrZWx5KHRwLT5yZXBhaXIp
KSB7CgkJdGNwX2ZpbmlzaF9jb25uZWN0KHNrLCBOVUxMKTsKCQlyZXR1cm4gMDsKCX0KCglidWZm
ID0gdGNwX3N0cmVhbV9hbGxvY19za2Ioc2ssIHNrLT5za19hbGxvY2F0aW9uLCB0cnVlKTsKCWlm
ICh1bmxpa2VseSghYnVmZikpCgkJcmV0dXJuIC1FTk9CVUZTOwoKCXRjcF9pbml0X25vbmRhdGFf
c2tiKGJ1ZmYsIHRwLT53cml0ZV9zZXErKywgVENQSERSX1NZTik7Cgl0Y3BfbXN0YW1wX3JlZnJl
c2godHApOwoJdHAtPnJldHJhbnNfc3RhbXAgPSB0Y3BfdGltZV9zdGFtcF90cyh0cCk7Cgl0Y3Bf
Y29ubmVjdF9xdWV1ZV9za2Ioc2ssIGJ1ZmYpOwoJdGNwX2Vjbl9zZW5kX3N5bihzaywgYnVmZik7
Cgl0Y3BfcmJ0cmVlX2luc2VydCgmc2stPnRjcF9ydHhfcXVldWUsIGJ1ZmYpOwoKCS8qIFNlbmQg
b2ZmIFNZTjsgaW5jbHVkZSBkYXRhIGluIEZhc3QgT3Blbi4gKi8KCWVyciA9IHRwLT5mYXN0b3Bl
bl9yZXEgPyB0Y3Bfc2VuZF9zeW5fZGF0YShzaywgYnVmZikgOgoJICAgICAgdGNwX3RyYW5zbWl0
X3NrYihzaywgYnVmZiwgMSwgc2stPnNrX2FsbG9jYXRpb24pOwoJaWYgKGVyciA9PSAtRUNPTk5S
RUZVU0VEKQoJCXJldHVybiBlcnI7CgoJLyogV2UgY2hhbmdlIHRwLT5zbmRfbnh0IGFmdGVyIHRo
ZSB0Y3BfdHJhbnNtaXRfc2tiKCkgY2FsbAoJICogaW4gb3JkZXIgdG8gbWFrZSB0aGlzIHBhY2tl
dCBnZXQgY291bnRlZCBpbiB0Y3BPdXRTZWdzLgoJICovCglXUklURV9PTkNFKHRwLT5zbmRfbnh0
LCB0cC0+d3JpdGVfc2VxKTsKCXRwLT5wdXNoZWRfc2VxID0gdHAtPndyaXRlX3NlcTsKCWJ1ZmYg
PSB0Y3Bfc2VuZF9oZWFkKHNrKTsKCWlmICh1bmxpa2VseShidWZmKSkgewoJCVdSSVRFX09OQ0Uo
dHAtPnNuZF9ueHQsIFRDUF9TS0JfQ0IoYnVmZiktPnNlcSk7CgkJdHAtPnB1c2hlZF9zZXEJPSBU
Q1BfU0tCX0NCKGJ1ZmYpLT5zZXE7Cgl9CglUQ1BfSU5DX1NUQVRTKHNvY2tfbmV0KHNrKSwgVENQ
X01JQl9BQ1RJVkVPUEVOUyk7CgoJLyogVGltZXIgZm9yIHJlcGVhdGluZyB0aGUgU1lOIHVudGls
IGFuIGFuc3dlci4gKi8KCWluZXRfY3NrX3Jlc2V0X3htaXRfdGltZXIoc2ssIElDU0tfVElNRV9S
RVRSQU5TLAoJCQkJICBpbmV0X2NzayhzayktPmljc2tfcnRvLCBUQ1BfUlRPX01BWCk7CglyZXR1
cm4gMDsKfQpFWFBPUlRfU1lNQk9MKHRjcF9jb25uZWN0KTsKCnUzMiB0Y3BfZGVsYWNrX21heChj
b25zdCBzdHJ1Y3Qgc29jayAqc2spCnsKCWNvbnN0IHN0cnVjdCBkc3RfZW50cnkgKmRzdCA9IF9f
c2tfZHN0X2dldChzayk7Cgl1MzIgZGVsYWNrX21heCA9IGluZXRfY3NrKHNrKS0+aWNza19kZWxh
Y2tfbWF4OwoKCWlmIChkc3QgJiYgZHN0X21ldHJpY19sb2NrZWQoZHN0LCBSVEFYX1JUT19NSU4p
KSB7CgkJdTMyIHJ0b19taW4gPSBkc3RfbWV0cmljX3J0dChkc3QsIFJUQVhfUlRPX01JTik7CgkJ
dTMyIGRlbGFja19mcm9tX3J0b19taW4gPSBtYXhfdChpbnQsIDEsIHJ0b19taW4gLSAxKTsKCgkJ
ZGVsYWNrX21heCA9IG1pbl90KHUzMiwgZGVsYWNrX21heCwgZGVsYWNrX2Zyb21fcnRvX21pbik7
Cgl9CglyZXR1cm4gZGVsYWNrX21heDsKfQoKLyogU2VuZCBvdXQgYSBkZWxheWVkIGFjaywgdGhl
IGNhbGxlciBkb2VzIHRoZSBwb2xpY3kgY2hlY2tpbmcKICogdG8gc2VlIGlmIHdlIHNob3VsZCBl
dmVuIGJlIGhlcmUuICBTZWUgdGNwX2lucHV0LmM6dGNwX2Fja19zbmRfY2hlY2soKQogKiBmb3Ig
ZGV0YWlscy4KICovCnZvaWQgdGNwX3NlbmRfZGVsYXllZF9hY2soc3RydWN0IHNvY2sgKnNrKQp7
CglzdHJ1Y3QgaW5ldF9jb25uZWN0aW9uX3NvY2sgKmljc2sgPSBpbmV0X2Nzayhzayk7CglpbnQg
YXRvID0gaWNzay0+aWNza19hY2suYXRvOwoJdW5zaWduZWQgbG9uZyB0aW1lb3V0OwoKCWlmIChh
dG8gPiBUQ1BfREVMQUNLX01JTikgewoJCWNvbnN0IHN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bf
c2soc2spOwoJCWludCBtYXhfYXRvID0gSFogLyAyOwoKCQlpZiAoaW5ldF9jc2tfaW5fcGluZ3Bv
bmdfbW9kZShzaykgfHwKCQkgICAgKGljc2stPmljc2tfYWNrLnBlbmRpbmcgJiBJQ1NLX0FDS19Q
VVNIRUQpKQoJCQltYXhfYXRvID0gVENQX0RFTEFDS19NQVg7CgoJCS8qIFNsb3cgcGF0aCwgaW50
ZXJzZWdtZW50IGludGVydmFsIGlzICJoaWdoIi4gKi8KCgkJLyogSWYgc29tZSBydHQgZXN0aW1h
dGUgaXMga25vd24sIHVzZSBpdCB0byBib3VuZCBkZWxheWVkIGFjay4KCQkgKiBEbyBub3QgdXNl
IGluZXRfY3NrKHNrKS0+aWNza19ydG8gaGVyZSwgdXNlIHJlc3VsdHMgb2YgcnR0IG1lYXN1cmVt
ZW50cwoJCSAqIGRpcmVjdGx5LgoJCSAqLwoJCWlmICh0cC0+c3J0dF91cykgewoJCQlpbnQgcnR0
ID0gbWF4X3QoaW50LCB1c2Vjc190b19qaWZmaWVzKHRwLT5zcnR0X3VzID4+IDMpLAoJCQkJCVRD
UF9ERUxBQ0tfTUlOKTsKCgkJCWlmIChydHQgPCBtYXhfYXRvKQoJCQkJbWF4X2F0byA9IHJ0dDsK
CQl9CgoJCWF0byA9IG1pbihhdG8sIG1heF9hdG8pOwoJfQoKCWF0byA9IG1pbl90KHUzMiwgYXRv
LCB0Y3BfZGVsYWNrX21heChzaykpOwoKCS8qIFN0YXkgd2l0aGluIHRoZSBsaW1pdCB3ZSB3ZXJl
IGdpdmVuICovCgl0aW1lb3V0ID0gamlmZmllcyArIGF0bzsKCgkvKiBVc2UgbmV3IHRpbWVvdXQg
b25seSBpZiB0aGVyZSB3YXNuJ3QgYSBvbGRlciBvbmUgZWFybGllci4gKi8KCWlmIChpY3NrLT5p
Y3NrX2Fjay5wZW5kaW5nICYgSUNTS19BQ0tfVElNRVIpIHsKCQkvKiBJZiBkZWxhY2sgdGltZXIg
aXMgYWJvdXQgdG8gZXhwaXJlLCBzZW5kIEFDSyBub3cuICovCgkJaWYgKHRpbWVfYmVmb3JlX2Vx
KGljc2stPmljc2tfYWNrLnRpbWVvdXQsIGppZmZpZXMgKyAoYXRvID4+IDIpKSkgewoJCQl0Y3Bf
c2VuZF9hY2soc2spOwoJCQlyZXR1cm47CgkJfQoKCQlpZiAoIXRpbWVfYmVmb3JlKHRpbWVvdXQs
IGljc2stPmljc2tfYWNrLnRpbWVvdXQpKQoJCQl0aW1lb3V0ID0gaWNzay0+aWNza19hY2sudGlt
ZW91dDsKCX0KCWljc2stPmljc2tfYWNrLnBlbmRpbmcgfD0gSUNTS19BQ0tfU0NIRUQgfCBJQ1NL
X0FDS19USU1FUjsKCWljc2stPmljc2tfYWNrLnRpbWVvdXQgPSB0aW1lb3V0OwoJc2tfcmVzZXRf
dGltZXIoc2ssICZpY3NrLT5pY3NrX2RlbGFja190aW1lciwgdGltZW91dCk7Cn0KCi8qIFRoaXMg
cm91dGluZSBzZW5kcyBhbiBhY2sgYW5kIGFsc28gdXBkYXRlcyB0aGUgd2luZG93LiAqLwp2b2lk
IF9fdGNwX3NlbmRfYWNrKHN0cnVjdCBzb2NrICpzaywgdTMyIHJjdl9ueHQpCnsKCXN0cnVjdCBz
a19idWZmICpidWZmOwoKCS8qIElmIHdlIGhhdmUgYmVlbiByZXNldCwgd2UgbWF5IG5vdCBzZW5k
IGFnYWluLiAqLwoJaWYgKHNrLT5za19zdGF0ZSA9PSBUQ1BfQ0xPU0UpCgkJcmV0dXJuOwoKCS8q
IFdlIGFyZSBub3QgcHV0dGluZyB0aGlzIG9uIHRoZSB3cml0ZSBxdWV1ZSwgc28KCSAqIHRjcF90
cmFuc21pdF9za2IoKSB3aWxsIHNldCB0aGUgb3duZXJzaGlwIHRvIHRoaXMKCSAqIHNvY2suCgkg
Ki8KCWJ1ZmYgPSBhbGxvY19za2IoTUFYX1RDUF9IRUFERVIsCgkJCSBza19nZnBfbWFzayhzaywg
R0ZQX0FUT01JQyB8IF9fR0ZQX05PV0FSTikpOwoJaWYgKHVubGlrZWx5KCFidWZmKSkgewoJCXN0
cnVjdCBpbmV0X2Nvbm5lY3Rpb25fc29jayAqaWNzayA9IGluZXRfY3NrKHNrKTsKCQl1bnNpZ25l
ZCBsb25nIGRlbGF5OwoKCQlkZWxheSA9IFRDUF9ERUxBQ0tfTUFYIDw8IGljc2stPmljc2tfYWNr
LnJldHJ5OwoJCWlmIChkZWxheSA8IFRDUF9SVE9fTUFYKQoJCQlpY3NrLT5pY3NrX2Fjay5yZXRy
eSsrOwoJCWluZXRfY3NrX3NjaGVkdWxlX2Fjayhzayk7CgkJaWNzay0+aWNza19hY2suYXRvID0g
VENQX0FUT19NSU47CgkJaW5ldF9jc2tfcmVzZXRfeG1pdF90aW1lcihzaywgSUNTS19USU1FX0RB
Q0ssIGRlbGF5LCBUQ1BfUlRPX01BWCk7CgkJcmV0dXJuOwoJfQoKCS8qIFJlc2VydmUgc3BhY2Ug
Zm9yIGhlYWRlcnMgYW5kIHByZXBhcmUgY29udHJvbCBiaXRzLiAqLwoJc2tiX3Jlc2VydmUoYnVm
ZiwgTUFYX1RDUF9IRUFERVIpOwoJdGNwX2luaXRfbm9uZGF0YV9za2IoYnVmZiwgdGNwX2FjY2Vw
dGFibGVfc2VxKHNrKSwgVENQSERSX0FDSyk7CgoJLyogV2UgZG8gbm90IHdhbnQgcHVyZSBhY2tz
IGluZmx1ZW5jaW5nIFRDUCBTbWFsbCBRdWV1ZXMgb3IgZnEvcGFjaW5nCgkgKiB0b28gbXVjaC4K
CSAqIFNLQl9UUlVFU0laRShtYXgoMSAuLiA2NiwgTUFYX1RDUF9IRUFERVIpKSBpcyB1bmZvcnR1
bmF0ZWx5IH43ODQKCSAqLwoJc2tiX3NldF90Y3BfcHVyZV9hY2soYnVmZik7CgoJLyogU2VuZCBp
dCBvZmYsIHRoaXMgY2xlYXJzIGRlbGF5ZWQgYWNrcyBmb3IgdXMuICovCglfX3RjcF90cmFuc21p
dF9za2Ioc2ssIGJ1ZmYsIDAsIChfX2ZvcmNlIGdmcF90KTAsIHJjdl9ueHQpOwp9CkVYUE9SVF9T
WU1CT0xfR1BMKF9fdGNwX3NlbmRfYWNrKTsKCnZvaWQgdGNwX3NlbmRfYWNrKHN0cnVjdCBzb2Nr
ICpzaykKewoJX190Y3Bfc2VuZF9hY2soc2ssIHRjcF9zayhzayktPnJjdl9ueHQpOwp9CgovKiBU
aGlzIHJvdXRpbmUgc2VuZHMgYSBwYWNrZXQgd2l0aCBhbiBvdXQgb2YgZGF0ZSBzZXF1ZW5jZQog
KiBudW1iZXIuIEl0IGFzc3VtZXMgdGhlIG90aGVyIGVuZCB3aWxsIHRyeSB0byBhY2sgaXQuCiAq
CiAqIFF1ZXN0aW9uOiB3aGF0IHNob3VsZCB3ZSBtYWtlIHdoaWxlIHVyZ2VudCBtb2RlPwogKiA0
LjRCU0QgZm9yY2VzIHNlbmRpbmcgc2luZ2xlIGJ5dGUgb2YgZGF0YS4gV2UgY2Fubm90IHNlbmQK
ICogb3V0IG9mIHdpbmRvdyBkYXRhLCBiZWNhdXNlIHdlIGhhdmUgU05ELk5YVD09U05ELk1BWC4u
LgogKgogKiBDdXJyZW50IHNvbHV0aW9uOiB0byBzZW5kIFRXTyB6ZXJvLWxlbmd0aCBzZWdtZW50
cyBpbiB1cmdlbnQgbW9kZToKICogb25lIGlzIHdpdGggU0VHLlNFUT1TTkQuVU5BIHRvIGRlbGl2
ZXIgdXJnZW50IHBvaW50ZXIsIGFub3RoZXIgaXMKICogb3V0LW9mLWRhdGUgd2l0aCBTTkQuVU5B
LTEgdG8gcHJvYmUgd2luZG93LgogKi8Kc3RhdGljIGludCB0Y3BfeG1pdF9wcm9iZV9za2Ioc3Ry
dWN0IHNvY2sgKnNrLCBpbnQgdXJnZW50LCBpbnQgbWliKQp7CglzdHJ1Y3QgdGNwX3NvY2sgKnRw
ID0gdGNwX3NrKHNrKTsKCXN0cnVjdCBza19idWZmICpza2I7CgoJLyogV2UgZG9uJ3QgcXVldWUg
aXQsIHRjcF90cmFuc21pdF9za2IoKSBzZXRzIG93bmVyc2hpcC4gKi8KCXNrYiA9IGFsbG9jX3Nr
YihNQVhfVENQX0hFQURFUiwKCQkJc2tfZ2ZwX21hc2soc2ssIEdGUF9BVE9NSUMgfCBfX0dGUF9O
T1dBUk4pKTsKCWlmICghc2tiKQoJCXJldHVybiAtMTsKCgkvKiBSZXNlcnZlIHNwYWNlIGZvciBo
ZWFkZXJzIGFuZCBzZXQgY29udHJvbCBiaXRzLiAqLwoJc2tiX3Jlc2VydmUoc2tiLCBNQVhfVENQ
X0hFQURFUik7CgkvKiBVc2UgYSBwcmV2aW91cyBzZXF1ZW5jZS4gIFRoaXMgc2hvdWxkIGNhdXNl
IHRoZSBvdGhlcgoJICogZW5kIHRvIHNlbmQgYW4gYWNrLiAgRG9uJ3QgcXVldWUgb3IgY2xvbmUg
U0tCLCBqdXN0CgkgKiBzZW5kIGl0LgoJICovCgl0Y3BfaW5pdF9ub25kYXRhX3NrYihza2IsIHRw
LT5zbmRfdW5hIC0gIXVyZ2VudCwgVENQSERSX0FDSyk7CglORVRfSU5DX1NUQVRTKHNvY2tfbmV0
KHNrKSwgbWliKTsKCXJldHVybiB0Y3BfdHJhbnNtaXRfc2tiKHNrLCBza2IsIDAsIChfX2ZvcmNl
IGdmcF90KTApOwp9CgovKiBDYWxsZWQgZnJvbSBzZXRzb2Nrb3B0KCAuLi4gVENQX1JFUEFJUiAp
ICovCnZvaWQgdGNwX3NlbmRfd2luZG93X3Byb2JlKHN0cnVjdCBzb2NrICpzaykKewoJaWYgKHNr
LT5za19zdGF0ZSA9PSBUQ1BfRVNUQUJMSVNIRUQpIHsKCQl0Y3Bfc2soc2spLT5zbmRfd2wxID0g
dGNwX3NrKHNrKS0+cmN2X254dCAtIDE7CgkJdGNwX21zdGFtcF9yZWZyZXNoKHRjcF9zayhzaykp
OwoJCXRjcF94bWl0X3Byb2JlX3NrYihzaywgMCwgTElOVVhfTUlCX1RDUFdJTlBST0JFKTsKCX0K
fQoKLyogSW5pdGlhdGUga2VlcGFsaXZlIG9yIHdpbmRvdyBwcm9iZSBmcm9tIHRpbWVyLiAqLwpp
bnQgdGNwX3dyaXRlX3dha2V1cChzdHJ1Y3Qgc29jayAqc2ssIGludCBtaWIpCnsKCXN0cnVjdCB0
Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOwoJc3RydWN0IHNrX2J1ZmYgKnNrYjsKCglpZiAoc2st
PnNrX3N0YXRlID09IFRDUF9DTE9TRSkKCQlyZXR1cm4gLTE7CgoJc2tiID0gdGNwX3NlbmRfaGVh
ZChzayk7CglpZiAoc2tiICYmIGJlZm9yZShUQ1BfU0tCX0NCKHNrYiktPnNlcSwgdGNwX3duZF9l
bmQodHApKSkgewoJCWludCBlcnI7CgkJdW5zaWduZWQgaW50IG1zcyA9IHRjcF9jdXJyZW50X21z
cyhzayk7CgkJdW5zaWduZWQgaW50IHNlZ19zaXplID0gdGNwX3duZF9lbmQodHApIC0gVENQX1NL
Ql9DQihza2IpLT5zZXE7CgoJCWlmIChiZWZvcmUodHAtPnB1c2hlZF9zZXEsIFRDUF9TS0JfQ0Io
c2tiKS0+ZW5kX3NlcSkpCgkJCXRwLT5wdXNoZWRfc2VxID0gVENQX1NLQl9DQihza2IpLT5lbmRf
c2VxOwoKCQkvKiBXZSBhcmUgcHJvYmluZyB0aGUgb3BlbmluZyBvZiBhIHdpbmRvdwoJCSAqIGJ1
dCB0aGUgd2luZG93IHNpemUgaXMgIT0gMAoJCSAqIG11c3QgaGF2ZSBiZWVuIGEgcmVzdWx0IFNX
UyBhdm9pZGFuY2UgKCBzZW5kZXIgKQoJCSAqLwoJCWlmIChzZWdfc2l6ZSA8IFRDUF9TS0JfQ0Io
c2tiKS0+ZW5kX3NlcSAtIFRDUF9TS0JfQ0Ioc2tiKS0+c2VxIHx8CgkJICAgIHNrYi0+bGVuID4g
bXNzKSB7CgkJCXNlZ19zaXplID0gbWluKHNlZ19zaXplLCBtc3MpOwoJCQlUQ1BfU0tCX0NCKHNr
YiktPnRjcF9mbGFncyB8PSBUQ1BIRFJfUFNIOwoJCQlpZiAodGNwX2ZyYWdtZW50KHNrLCBUQ1Bf
RlJBR19JTl9XUklURV9RVUVVRSwKCQkJCQkgc2tiLCBzZWdfc2l6ZSwgbXNzLCBHRlBfQVRPTUlD
KSkKCQkJCXJldHVybiAtMTsKCQl9IGVsc2UgaWYgKCF0Y3Bfc2tiX3Bjb3VudChza2IpKQoJCQl0
Y3Bfc2V0X3NrYl90c29fc2Vncyhza2IsIG1zcyk7CgoJCVRDUF9TS0JfQ0Ioc2tiKS0+dGNwX2Zs
YWdzIHw9IFRDUEhEUl9QU0g7CgkJZXJyID0gdGNwX3RyYW5zbWl0X3NrYihzaywgc2tiLCAxLCBH
RlBfQVRPTUlDKTsKCQlpZiAoIWVycikKCQkJdGNwX2V2ZW50X25ld19kYXRhX3NlbnQoc2ssIHNr
Yik7CgkJcmV0dXJuIGVycjsKCX0gZWxzZSB7CgkJaWYgKGJldHdlZW4odHAtPnNuZF91cCwgdHAt
PnNuZF91bmEgKyAxLCB0cC0+c25kX3VuYSArIDB4RkZGRikpCgkJCXRjcF94bWl0X3Byb2JlX3Nr
YihzaywgMSwgbWliKTsKCQlyZXR1cm4gdGNwX3htaXRfcHJvYmVfc2tiKHNrLCAwLCBtaWIpOwoJ
fQp9CgovKiBBIHdpbmRvdyBwcm9iZSB0aW1lb3V0IGhhcyBvY2N1cnJlZC4gIElmIHdpbmRvdyBp
cyBub3QgY2xvc2VkIHNlbmQKICogYSBwYXJ0aWFsIHBhY2tldCBlbHNlIGEgemVybyBwcm9iZS4K
ICovCnZvaWQgdGNwX3NlbmRfcHJvYmUwKHN0cnVjdCBzb2NrICpzaykKewoJc3RydWN0IGluZXRf
Y29ubmVjdGlvbl9zb2NrICppY3NrID0gaW5ldF9jc2soc2spOwoJc3RydWN0IHRjcF9zb2NrICp0
cCA9IHRjcF9zayhzayk7CglzdHJ1Y3QgbmV0ICpuZXQgPSBzb2NrX25ldChzayk7Cgl1bnNpZ25l
ZCBsb25nIHRpbWVvdXQ7CglpbnQgZXJyOwoKCWVyciA9IHRjcF93cml0ZV93YWtldXAoc2ssIExJ
TlVYX01JQl9UQ1BXSU5QUk9CRSk7CgoJaWYgKHRwLT5wYWNrZXRzX291dCB8fCB0Y3Bfd3JpdGVf
cXVldWVfZW1wdHkoc2spKSB7CgkJLyogQ2FuY2VsIHByb2JlIHRpbWVyLCBpZiBpdCBpcyBub3Qg
cmVxdWlyZWQuICovCgkJaWNzay0+aWNza19wcm9iZXNfb3V0ID0gMDsKCQlpY3NrLT5pY3NrX2Jh
Y2tvZmYgPSAwOwoJCWljc2stPmljc2tfcHJvYmVzX3RzdGFtcCA9IDA7CgkJcmV0dXJuOwoJfQoK
CWljc2stPmljc2tfcHJvYmVzX291dCsrOwoJaWYgKGVyciA8PSAwKSB7CgkJaWYgKGljc2stPmlj
c2tfYmFja29mZiA8IFJFQURfT05DRShuZXQtPmlwdjQuc3lzY3RsX3RjcF9yZXRyaWVzMikpCgkJ
CWljc2stPmljc2tfYmFja29mZisrOwoJCXRpbWVvdXQgPSB0Y3BfcHJvYmUwX3doZW4oc2ssIFRD
UF9SVE9fTUFYKTsKCX0gZWxzZSB7CgkJLyogSWYgcGFja2V0IHdhcyBub3Qgc2VudCBkdWUgdG8g
bG9jYWwgY29uZ2VzdGlvbiwKCQkgKiBMZXQgc2VuZGVycyBmaWdodCBmb3IgbG9jYWwgcmVzb3Vy
Y2VzIGNvbnNlcnZhdGl2ZWx5LgoJCSAqLwoJCXRpbWVvdXQgPSBUQ1BfUkVTT1VSQ0VfUFJPQkVf
SU5URVJWQUw7Cgl9CgoJdGltZW91dCA9IHRjcF9jbGFtcF9wcm9iZTBfdG9fdXNlcl90aW1lb3V0
KHNrLCB0aW1lb3V0KTsKCXRjcF9yZXNldF94bWl0X3RpbWVyKHNrLCBJQ1NLX1RJTUVfUFJPQkUw
LCB0aW1lb3V0LCBUQ1BfUlRPX01BWCk7Cn0KCmludCB0Y3BfcnR4X3N5bmFjayhjb25zdCBzdHJ1
Y3Qgc29jayAqc2ssIHN0cnVjdCByZXF1ZXN0X3NvY2sgKnJlcSkKewoJY29uc3Qgc3RydWN0IHRj
cF9yZXF1ZXN0X3NvY2tfb3BzICphZl9vcHMgPSB0Y3BfcnNrKHJlcSktPmFmX3NwZWNpZmljOwoJ
c3RydWN0IGZsb3dpIGZsOwoJaW50IHJlczsKCgkvKiBQYWlyZWQgd2l0aCBXUklURV9PTkNFKCkg
aW4gc29ja19zZXRzb2Nrb3B0KCkgKi8KCWlmIChSRUFEX09OQ0Uoc2stPnNrX3R4cmVoYXNoKSA9
PSBTT0NLX1RYUkVIQVNIX0VOQUJMRUQpCgkJV1JJVEVfT05DRSh0Y3BfcnNrKHJlcSktPnR4aGFz
aCwgbmV0X3R4X3JuZGhhc2goKSk7CglyZXMgPSBhZl9vcHMtPnNlbmRfc3luYWNrKHNrLCBOVUxM
LCAmZmwsIHJlcSwgTlVMTCwgVENQX1NZTkFDS19OT1JNQUwsCgkJCQkgIE5VTEwpOwoJaWYgKCFy
ZXMpIHsKCQlUQ1BfSU5DX1NUQVRTKHNvY2tfbmV0KHNrKSwgVENQX01JQl9SRVRSQU5TU0VHUyk7
CgkJTkVUX0lOQ19TVEFUUyhzb2NrX25ldChzayksIExJTlVYX01JQl9UQ1BTWU5SRVRSQU5TKTsK
CQlpZiAodW5saWtlbHkodGNwX3Bhc3NpdmVfZmFzdG9wZW4oc2spKSkgewoJCQkvKiBzayBoYXMg
Y29uc3QgYXR0cmlidXRlIGJlY2F1c2UgbGlzdGVuZXJzIGFyZSBsb2NrbGVzcy4KCQkJICogSG93
ZXZlciBpbiB0aGlzIGNhc2UsIHdlIGFyZSBkZWFsaW5nIHdpdGggYSBwYXNzaXZlIGZhc3RvcGVu
CgkJCSAqIHNvY2tldCB0aHVzIHdlIGNhbiBjaGFuZ2UgdG90YWxfcmV0cmFucyB2YWx1ZS4KCQkJ
ICovCgkJCXRjcF9za19ydyhzayktPnRvdGFsX3JldHJhbnMrKzsKCQl9CgkJdHJhY2VfdGNwX3Jl
dHJhbnNtaXRfc3luYWNrKHNrLCByZXEpOwoJfQoJcmV0dXJuIHJlczsKfQpFWFBPUlRfU1lNQk9M
KHRjcF9ydHhfc3luYWNrKTsK

------=_Part_4484033_245042213.1736328888690
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="test.pkt"
Content-ID: <76541d1a-470f-bfaf-d1e2-cb6e4eff8234@yahoo.com>

Ly8gVGVzdCBvZiBtYXJraW5nIHRoZSBzdGFydCBvZiBhIG5ldyByb3VuZCwgZXNzZW50aWFsIGZv
ciBtZWFzdXJpbmcgdGhlIGxlbmd0aCBvZiB0aGUgQUNLIHRyYWluIGFuZCB1c2VkIGluIENVQklD
IEh5U3RhcnQKCQpgLi4vY29tbW9uL2RlZmF1bHRzLnNoYAoKICAgIDAgc29ja2V0KC4uLiwgU09D
S19TVFJFQU0sIElQUFJPVE9fVENQKSA9IDMKICAgKzAgc2V0c29ja29wdCgzLCBTT0xfU09DS0VU
LCBTT19SRVVTRUFERFIsIFsxXSwgNCkgPSAwCiAgICswIGJpbmQoMywgLi4uLCAuLi4pID0gMAog
ICArMCBsaXN0ZW4oMywgMSkgPSAwCgogICsuMSA8IFMgMDowKDApIHdpbiAzMjc5MiA8bXNzIDEw
MDAsc2Fja09LLG5vcCxub3Asbm9wLHdzY2FsZSA3PgogICArMCA+IFMuIDA6MCgwKSBhY2sgMSA8
bXNzIDE0NjAsbm9wLG5vcCxzYWNrT0ssbm9wLHdzY2FsZSA4PgogICsuMSA8IC4gMToxKDApIGFj
ayAxIHdpbiAyNTcKICAgKzAgYWNjZXB0KDMsIC4uLiwgLi4uKSA9IDQKICAgKzAgc2V0c29ja29w
dCg0LCBTT0xfU09DS0VULCBTT19TTkRCVUYsIFsyMDAwMDBdLCA0KSA9IDAKCiAgICswICV7IHBy
aW50KCJpbml0aWFsIHdpbmRvdyAoSVcpID0iLHRjcGlfc25kX2N3bmQpIH0lCgogICArMCB3cml0
ZSg0LCAuLi4sIDEwMDAwMCkgPSAxMDAwMDAKICAgKzAgPiBQLiAxOjEwMDAxKDEwMDAwKSBhY2sg
MQoKCisuMTA1IDwgLiAxOjEoMCkgYWNrIDEwMDEgd2luIDI1NwogICArMCA+IFAuIDEwMDAxOjEy
MDAxKDIwMDApIGFjayAxCgogICArMCA8IC4gMToxKDApIGFjayAyMDAxIHdpbiAyNTcKICAgKzAg
PiBQLiAxMjAwMToxNDAwMSgyMDAwKSBhY2sgMQoKKy4wMDUgPCAuIDE6MSgwKSBhY2sgMzAwMSB3
aW4gMjU3CiAgICswID4gUC4gMTQwMDE6MTYwMDEoMjAwMCkgYWNrIDEKCiAgICswIDwgLiAxOjEo
MCkgYWNrIDQwMDEgd2luIDI1NwogICArMCA+IFAuIDE2MDAxOjE4MDAxKDIwMDApIGFjayAxCgor
LjAwNSA8IC4gMToxKDApIGFjayA1MDAxIHdpbiAyNTcKICAgKzAgPiBQLiAxODAwMToyMDAwMSgy
MDAwKSBhY2sgMQoKICAgKzAgPCAuIDE6MSgwKSBhY2sgNjAwMSB3aW4gMjU3CiAgICswID4gUC4g
MjAwMDE6MjIwMDEoMjAwMCkgYWNrIDEKCisuMDA1IDwgLiAxOjEoMCkgYWNrIDcwMDEgd2luIDI1
NwogICArMCA+IFAuIDIyMDAxOjI0MDAxKDIwMDApIGFjayAxCgogICArMCA8IC4gMToxKDApIGFj
ayA4MDAxIHdpbiAyNTcKICAgKzAgPiBQLiAyNDAwMToyNjAwMSgyMDAwKSBhY2sgMQoKKy4wMDUg
PCAuIDE6MSgwKSBhY2sgOTAwMSB3aW4gMjU3CiAgICswID4gUC4gMjYwMDE6MjgwMDEoMjAwMCkg
YWNrIDEKCiAgICswIDwgLiAxOjEoMCkgYWNrIDEwMDAxIHdpbiAyNTcKICAgKzAgPiBQLiAyODAw
MTozMDAwMSgyMDAwKSBhY2sgMQo=

------=_Part_4484033_245042213.1736328888690--

