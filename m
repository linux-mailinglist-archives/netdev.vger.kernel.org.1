Return-Path: <netdev+bounces-158335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C76A116B9
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E891621E1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114C16F2F2;
	Wed, 15 Jan 2025 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ooeuhSGX"
X-Original-To: netdev@vger.kernel.org
Received: from sonic322-27.consmr.mail.bf2.yahoo.com (sonic322-27.consmr.mail.bf2.yahoo.com [74.6.132.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B16134B0
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736905204; cv=none; b=YO9iB6crsOfnVAtdMwP7aWrWyydCVp7TxGZi3GuVMStf6rIn5DcozcnGuSBGPHj482ZTpQ5IPK53paRD7R5rFRgsW5boceVw5ULo9lgNgIWIIR5QzOHtWi8ZxLv+BU2wXHAzorB3KidKbiB8rhlw1omxdn0RhcQvJeg+k6ODD30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736905204; c=relaxed/simple;
	bh=sYdJJFVtZPzHyAeJ9I6eM8lsFddGeNY5ajrG/2/eHoI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=T5ZRyD+1M1BrX35bbF9TrhK2Mbg+rf1v11W5Q9pYLYORpoIs5HZIS1ouaDCnYFKGpPgKZx74lxcfOA/LPqf23sxj1o7WiUaxDc0bSLI5AIE1lcnvd6jIS1TBExsx9ilXKJmZ8DNapa46+Va7N8Wax8hAXTeP0Tt/g29BB+ymM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ooeuhSGX; arc=none smtp.client-ip=74.6.132.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1736905194; bh=sYdJJFVtZPzHyAeJ9I6eM8lsFddGeNY5ajrG/2/eHoI=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=ooeuhSGXl4tloobO/NB1mpfiv5hlSzDAceg9Txdmwi0K0uM7kR+7qfLAl7RCvGHOWCcf5kTdFzhefk1TSmMLFYMCj9TxyldCyPDQktoNf6kt9PXJ4e5f1UmvlqEiyXvdPqWPY+vGf0j8/rt2CfKSLOVSVLWaIz0tAMcxaO5cSgOR4QhBf4D9hOwYiwuCu8MGY90SczWCpX/b7ym2A5303igYN1hJSHMGuZwu1b8e2q5qBWKzOt6GFm4cy+63OaXiIMq0IczELPNQprVEd1dmmOIm4csb9DRPSvyeCHpY6JQ0j3tNzvIpqp+snlEA0yxqnqxUinEotowRRnuYVt73dQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1736905194; bh=6flD7cucXRRMhQs3d5jGM5AC0CB1+L9PhFTke8iFKcf=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=ltvxXZqu+CCo0CruUw7m+ZR+DrhARjQLJZxzQY9f2szLqL+R7VCsB4SdQHqLRdbq5mqJbgwpgE5rZhXdasKFrIOFmCrZm3+EHWfom0Surkb9E0M1R6VsdY5Xaj0fOk29OcAJANzffPY+IuX41dine01bsyMIUBaxRIihvhagiUx2q+p+S65pi0RJpXAqXodoojmE6SzgEPu55IdZe+QR93kOGk5IbfjT5ZDuxXt3II9BTWBFHirIWTKlDrWjnvlpDqspCbFJbsvVcoe822jAL8dylOiZ8pqY5HW+RaecZFi7n064zbhHZEhT9QPVHz2BZWh1410tNR0cL0Y8n3Ut3w==
X-YMail-OSG: g62upwsVM1mOjtA0TRLQe6f4rFp3.hLPqnamrxiAATuD03t8mS.YcTuW6eWf3ku
 53Z6VRPTtmFNQUzrdvf3cd15DQu_mCrV0SMAhQ5C5oRCEtjYf9uiXwkWi1D5LAOkZtuBHKhdf7Aa
 9H8xW3Q0bLl5t4V1jyBntXkhNrGC49dz_6oD.laYG3OSemOrDW89xluxQ5fSoaRHCjvtLVUrD1id
 3xdhqzwlqUmUhgke0.l8dcsrPHQgUXda4vtosnsbTIsH3_QEv.uX1uBcSweRG3KfcW1.3RySXik1
 dg0lW6g9kDlmBXaTNYrNeHDZKbMuT7qLUTtKD7GALrbpFI7Qw1U7pAmKQVis64lb8z9Jw8q9sHDX
 _K7oYvQrR6903NTMPoaQfE7EWiHGy9vV0tTFNFmvD8ev5i8mAz9nXK0X0dEVULqfcWHqgY_vFJbY
 asJ_odYTvU7gEHSADGH4s4QvmyqPtV8MR_4bKof7CKTzt7oEdKfVlyO7m2aQFCq9E2QEy_sKp6Hs
 n1mUb2p0NdVI3mI.vfoe1KzSjc7jJKwhxt9EVIZhFFw9kTX9OZPl5rMApH0TkWRphHdqnBN.4bS3
 ywi1xVXsbLzBGoPoqiAhtzHTq6EMvHOgHFIjW3F_emKK7zqh26w.Z0ZvgyTdpOmk.lKiULmIGYba
 _bCxX6MsdG59c7QMXj.k4ocxNjeQSEJ_3UV_ID3n48kcah3CAwa9JpvWoLYR4h4M_m96wyA7e4dk
 _tcyHY6VqnTWT_KRKtKa_ZWEHYXrIQ0MwBT6pS.0LTwXdnduJehwa_jJmeItafhWFL05QLQwtrZ6
 ckimawMf3oRetIri.WDqSjbWcnCfBXEIBhmntxHOsiQiIKmy13UEgHoRdYg77duOjIB45TLgK2Lj
 Hz_hrzYU.Nckr96SMugmANiGOGrjGLMxuF6Fm1L_QM6eCQMEZLsMpGa4WeeS4J73U8ZkH.yJnpiv
 SfVtviz.p6AsFNxC_Rmk0lRR_kfL80GV2hsHa3EW3cRFZ4GPfXPSOIDuqa9G5kgfQFcfbYHyG3hd
 onue24fNjyNkBUQRsakzYl5equlRm0VRp5vkvgeZzmi69VczVRFrYVRc1ImBFFXjLVSXeQrNf0Pt
 GErYjNPePSlyYyO0DqP1caqSuc2l9GJTju19fARTRyGxChiltjYCGI9tDSn3BQIU5o6UfFnSNrKf
 0XlCS0K7kjuoaYd18thFG8XGw0enmPD_BUGiCZbt9qB2TOynuK0p.vSmXooJr1PMuJraZc_oLnxu
 M9KqEZBuNh3V7Odop4x__BQ7vby2326Pu6Qe58ql7MlB2jcEr_bqCusrISu7P6tvE5ck1dXVRLQ2
 qLce_hOu1RYosQkKPSA_awSp0QczmIu7PUH3ytCYrjTmyZA6sKulUFIAa5UPgI4CDuLQFXoPY7SP
 dytS.TYlgfUcjtOgpe0gdZ3tmxy2ArpW3tYOdMTzSyNMi5Sjucia1N_i0pNmINJYrivD0HEomZOU
 fLtxqVwsb2LKLNLPzRUMbtAMXtOWK9SK012SPsljlQ.7N4DUzsdek00v09jMku9p.eNW07an2N4p
 Me4tEG8bisphDsPKkej2paVjJKteISBMZYRiaLcewztqYpDSLX.e2vLoj2.T6B7mlSTJPZtS8lU0
 k5ZBNHjDrXQuiM2i.yG7_PemDGY3n0cz.9RWDwY2WaNK.ntakHFFadCtWkol52SqIrUZ48iXMyCX
 v3SGssOvx6HpW.HBZ6cNvG5.beIPPcy46dWCEKyuPCLoj7GccWLSPsSGmliiE9xcSHHGauryP6_Q
 YITpOylgcbYqcZqQPO4GUarL0m1XoaADxBvXxAIBObT70XDyhd2c2Hqty4geW_HSaSa76p3vsu7K
 aITijXytjpqUp.e6H56AX.gliSGzkzeVJ74nQWTUs3dceafL0McRpl5_pcoeq4IdsN0izwNspzRC
 eTOuxgu94N4uERXqc2XLcuy1md7IHYv5yCGRFD0df.yDyQkO382vA39IRes2vDZbH3gYXXZK3fzg
 r3VKnORBlX6qqQwlhM1LAAPlzWtmdVqB6LpRpZi3TR1aAELV2lNa936lIvBmflD5FvwVfjuqtEVB
 GgZl3GbkUTQ5YP4V4DS4BYZ25v5ipsvV_qxvjBRvTPODDJsT09V2Rlw8pPD27Hs72_dC.HtYxMkr
 I4ajFTKz.WPPDbXocxtI1oxhVoO.5u3fZkl0M9xx3nEZ5PlajcaQKO8vLZWTiDuzXKHvejczcWjn
 XiybMnOnYRBFKnQ--
X-Sonic-MF: <ma.arghavani@yahoo.com>
X-Sonic-ID: 9562df70-6d7a-460a-a22f-6a88b2daad7b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.bf2.yahoo.com with HTTP; Wed, 15 Jan 2025 01:39:54 +0000
Date: Wed, 15 Jan 2025 01:18:57 +0000 (UTC)
From: Mahdi Arghavani <ma.arghavani@yahoo.com>
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Haibo Zhang <haibo.zhang@otago.ac.nz>, 
	David Eyers <david.eyers@otago.ac.nz>, 
	Abbas Arghavani <abbas.arghavani@mdu.se>
Message-ID: <979088118.32930.1736903937403@mail.yahoo.com>
In-Reply-To: <CADVnQy=J+mse5Zx2gfctxDa4h-JHjW885RjtfVZ7DbSr_Hy9Lw@mail.gmail.com>
References: <408334417.4436448.1736139157134.ref@mail.yahoo.com> <408334417.4436448.1736139157134@mail.yahoo.com> <CANn89iLzo0Wk7p=dtUQ4Q2-pCAsjSxXZw71ngNTw6NZbEEvoDA@mail.gmail.com> <2046438615.4484034.1736328888690@mail.yahoo.com> <CADVnQymzCpJozeF-wMPbppizg0SUAUufgyQEeD7AB5DZDNBTEw@mail.gmail.com> <1815460239.6961054.1736660842181@mail.yahoo.com> <CADVnQy=J+mse5Zx2gfctxDa4h-JHjW885RjtfVZ7DbSr_Hy9Lw@mail.gmail.com>
Subject: Re: [PATCH net] tcp_cubic: Fix for bug in HyStart implementation in
 the Linux kernel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_32929_406650583.1736903937402"
X-Mailer: WebService/1.1.23187 YMailNorrin

------=_Part_32929_406650583.1736903937402
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Neal,
I appreciate your guidance in submitting the bug fix.
 Attached are my updated packetdrill tests.

Best wishes,
Mahdi






On Monday, January 13, 2025 at 04:59:15 AM GMT+13, Neal Cardwell <ncardwell=
@google.com> wrote:=20





On Sun, Jan 12, 2025 at 12:47=E2=80=AFAM Mahdi Arghavani <ma.arghavani@yaho=
o.com> wrote:
>
>=C2=A0 Hi,
> Thank you for your email.
> Following your suggestion, I downloaded the latest packetdrill tests for =
CUBIC. Attached is a new script to test the HYSTART-ACK-TRAIN detection mec=
hanism.

Great. Thanks for attaching your test.

> Additionally, it=E2=80=99s a good idea to set the hystart_detect paramete=
r to 2 (instead of 3) in the "cubic-hystart-delay-*.pkt" files.

I would argue that:

(1) Ideally, Hystart-delay tests should be run with both of the
following configurations: (a)
/sys/module/tcp_cubic/parameters/hystart_detect set to only enable
Hystart-delay; (b) /sys/module/tcp_cubic/parameters/hystart_detect set
to enable both Hystart-delay and Hystart-ack-train. (Since those are
both supported configurations of the kernel, and we want to make sure
they function correctly (the two flavors of Hystart don't interfere
with each other, and don't crash or have races or violate memory
safety invariants, etc). Running both (a) and (b) is how we run them
internally, but there's no support yet in the public packetdrill test
harness to run tests in two different configurations like that.

(2) If Hystart-delay tests are only run in one configuration, then
IMHO they should be run with
/sys/module/tcp_cubic/parameters/hystart_detect set to enable both
Hystart-delay and Hystart-ack-train, since that is the default
configuration of the kernel, and the one that the vast majority of
users will thus use.

> I recompiled the Linux kernel with the patch we both agreed on in the pre=
vious emails. However, I found that the fix passes all tests except for the=
 following:
> 1) tcp/cubic/cubic-bulk-166k-idle-restart.pkt
> 2) tcp/cubic/cubic-bulk-166k.pkt
>
> This is because these two tests assume that slow-start ends when cwnd =3D=
 48, which is not correct. I will work on these two tests and get back to y=
ou soon.

Sounds great.

Do you mind sharing your patch as well (either as an attachment or
directly to the list via "git send-email", whichever you prefer at
this stage)? That way we can start offering feedback on the kernel
patch itself.

thanks,
neal




> Best Wishes,
> Mahdi Arghavani
>
>
>
> On Friday, January 10, 2025 at 06:23:58 AM GMT+13, Neal Cardwell <ncardwe=
ll@google.com> wrote:
>
>
> On Wed, Jan 8, 2025 at 4:36=E2=80=AFAM Mahdi Arghavani <ma.arghavani@yaho=
o.com> wrote:
> >
> > Dear Eric and Neal,
> >
> > Thank you for the email.
>
> Please use plain text email so that your emails will be forwarded by
> the netdev mail server. :-)
>
> > >>> Am I right to say you are referring to
> > commit 8165a96f6b7122f25bf809aecf06f17b0ec37b58
> >
> > Yes. The issue arises as a side effect of the changes introduced in thi=
s commit.
> >
> > >>> Please provide a packetdrill test, this will be the most efficient =
way to demonstrate the issue.
> >
> > Below are two different methods of demonstrating the issue:
> > A) Demonstrating via the source code
> > The changes introduced in commit 8165a9 move the caller of the `bictcp_=
hystart_reset` function inside the `hystart_update` function.
> > This modification adds an additional condition for triggering the calle=
r, requiring that (tcp_snd_cwnd(tp) >=3D hystart_low_window) must also be s=
atisfied before invoking `bictcp_hystart_reset`.
>
> Thanks for the nice analysis.
>
> Looks like 8165a96f6b7122f25bf809aecf06f17b0ec37b58=C2=A0 is a stable
> branch fix, and the original commit is:
> 4e1fddc98d2585ddd4792b5e44433dcee7ece001
>
> So the ultimate patch to fix this can use a Fixes tag like:
>
> Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train
> detections for not-cwnd-limited flows")
>
> Please also move the "hystart triggers when cwnd is larger than some
> threshold" comment to the line above where you have moved the logic:
>
> So the patch reads something like:
>
> @@ -392,6 +392,9 @@ static void hystart_update(struct sock *sk, u32 delay=
)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (after(tp->snd_una, ca->end_seq))
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bictcp_hystart_res=
et(sk);
>
> +=C2=A0 =C2=A0 =C2=A0 /* hystart triggers when cwnd is larger than some t=
hreshold */
> +=C2=A0 =C2=A0 =C2=A0 if (tcp_snd_cwnd(tp) < hystart_low_window)
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> ...
> -=C2=A0 =C2=A0 =C2=A0 /* hystart triggers when cwnd is larger than some t=
hreshold */
> -=C2=A0 =C2=A0 =C2=A0 if (!ca->found && tcp_in_slow_start(tp) && hystart =
&&
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcp_snd_cwnd(tp) >=3D hystart_low_win=
dow)
> +=C2=A0 =C2=A0 =C2=A0 if (!ca->found && tcp_in_slow_start(tp) && hystart)
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hystart_update(sk,=
 delay);
> }
>
> > B) Demonstrating via a test
> > Unfortunately, I was unable to directly print the value of `ca->round_s=
tart` (a variable defined in `tcp_cubic.c`) using packetdrill and provide y=
ou with the requested script.
> > Instead, I added a few lines of code to log the status of TCP variables=
 upon packet transmission and ACK reception.
> > To reproduce the same output on your Linux system, you need to apply th=
e changes I made to `tcp_cubic.c` and `tcp_output.c` (see the attached file=
s) and recompile the kernel.
> > I used the attached packetdrill script "only" to emulate data transmiss=
ion for the test.
> > Below are the logs accumulated in kern.log after running the packetdril=
l script:
> >
> > In Line01, the start of the first round is marked by the cubictcp_init =
function. However, the second round is marked by the reception of the 7th A=
CK when cwnd is 16 (see Line20).
> > This is incorrect because the 2nd round is started upon receiving the f=
irst ACK.
> > This means that `ca->round_start` is updated at t=3D720994842, while it=
 should have been updated 15.5 ms earlier, at t=3D720979320.
> > In this test, the length of the ACK train in the second round is calcul=
ated to be 15.5 ms shorter, which renders one of HyStart's criteria ineffec=
tive.
> >
> > Line01. 2025-01-08T08:16:23.321839+00:00 h1a kernel: New round is start=
ed. t=3D720873683 Sport=3D36895 cwnd=3D10 inflight=3D0 RTT=3D100300
> > Line02. 2025-01-08T08:16:23.321842+00:00 h1a kernel: Pkt sending. t=3D7=
20873878 Sport=3D36895 cwnd=3D10 inflight=3D0 RTT=3D100300 nextSeq=3D391518=
3479
> > Line03. 2025-01-08T08:16:23.321845+00:00 h1a kernel: Pkt sending. t=3D7=
20873896 Sport=3D36895 cwnd=3D10 inflight=3D2 RTT=3D100300 nextSeq=3D391518=
5479
> > Line04. 2025-01-08T08:16:23.321847+00:00 h1a kernel: Pkt sending. t=3D7=
20873896 Sport=3D36895 cwnd=3D10 inflight=3D4 RTT=3D100300 nextSeq=3D391518=
7479
> > Line05. 2025-01-08T08:16:23.321849+00:00 h1a kernel: Pkt sending. t=3D7=
20873896 Sport=3D36895 cwnd=3D10 inflight=3D6 RTT=3D100300 nextSeq=3D391518=
9479
> > Line06. 2025-01-08T08:16:23.427777+00:00 h1a kernel: Pkt sending. t=3D7=
20873896 Sport=3D36895 cwnd=3D10 inflight=3D8 RTT=3D100300 nextSeq=3D391519=
1479
> > Line07. 2025-01-08T08:16:23.427787+00:00 h1a kernel: Ack receiving. t=
=3D720979320 Sport=3D36895 cwnd=3D10 inflight=3D9 RTT=3D100942 acked=3D1
> > Line08. 2025-01-08T08:16:23.427790+00:00 h1a kernel: Pkt sending. t=3D7=
20979335 Sport=3D36895 cwnd=3D11 inflight=3D9 RTT=3D100942 nextSeq=3D391519=
3479
> > Line09. 2025-01-08T08:16:23.427792+00:00 h1a kernel: Ack receiving. t=
=3D720979421 Sport=3D36895 cwnd=3D11 inflight=3D10 RTT=3D101517 acked=3D1
> > Line10. 2025-01-08T08:16:23.432773+00:00 h1a kernel: Pkt sending. t=3D7=
20979431 Sport=3D36895 cwnd=3D12 inflight=3D10 RTT=3D101517 nextSeq=3D39151=
95479
> > Line11. 2025-01-08T08:16:23.432785+00:00 h1a kernel: Ack receiving. t=
=3D720984502 Sport=3D36895 cwnd=3D12 inflight=3D11 RTT=3D102654 acked=3D1
> > Line12. 2025-01-08T08:16:23.432788+00:00 h1a kernel: Pkt sending. t=3D7=
20984514 Sport=3D36895 cwnd=3D13 inflight=3D11 RTT=3D102654 nextSeq=3D39151=
97479
> > Line13. 2025-01-08T08:16:23.432790+00:00 h1a kernel: Ack receiving. t=
=3D720984585 Sport=3D36895 cwnd=3D13 inflight=3D12 RTT=3D103658 acked=3D1
> > Line14. 2025-01-08T08:16:23.437774+00:00 h1a kernel: Pkt sending. t=3D7=
20984594 Sport=3D36895 cwnd=3D14 inflight=3D12 RTT=3D103658 nextSeq=3D39151=
99479
> > Line15. 2025-01-08T08:16:23.437783+00:00 h1a kernel: Ack receiving. t=
=3D720989668 Sport=3D36895 cwnd=3D14 inflight=3D13 RTT=3D105172 acked=3D1
> > Line16. 2025-01-08T08:16:23.437785+00:00 h1a kernel: Pkt sending. t=3D7=
20989679 Sport=3D36895 cwnd=3D15 inflight=3D13 RTT=3D105172 nextSeq=3D39152=
01479
> > Line17. 2025-01-08T08:16:23.437787+00:00 h1a kernel: Ack receiving. t=
=3D720989747 Sport=3D36895 cwnd=3D15 inflight=3D14 RTT=3D106507 acked=3D1
> > Line18. 2025-01-08T08:16:23.442773+00:00 h1a kernel: Pkt sending. t=3D7=
20989757 Sport=3D36895 cwnd=3D16 inflight=3D14 RTT=3D106507 nextSeq=3D39152=
03479
> > Line19. 2025-01-08T08:16:23.442780+00:00 h1a kernel: Ack receiving. t=
=3D720994842 Sport=3D36895 cwnd=3D16 inflight=3D15 RTT=3D108312 acked=3D1
> >
> > Line20. 2025-01-08T08:16:23.442782+00:00 h1a kernel: New round is start=
ed. t=3D720994842 Sport=3D36895 cwnd=3D16 inflight=3D15 RTT=3D108312
> >
> > Line21. 2025-01-08T08:16:23.442783+00:00 h1a kernel: Pkt sending. t=3D7=
20994857 Sport=3D36895 cwnd=3D17 inflight=3D15 RTT=3D108312 nextSeq=3D39152=
05479
> > Line22. 2025-01-08T08:16:23.442785+00:00 h1a kernel: Ack receiving. t=
=3D720994927 Sport=3D36895 cwnd=3D17 inflight=3D16 RTT=3D109902 acked=3D1
> > Line23. 2025-01-08T08:16:23.448788+00:00 h1a kernel: Pkt sending. t=3D7=
20994936 Sport=3D36895 cwnd=3D18 inflight=3D16 RTT=3D109902 nextSeq=3D39152=
07479
> > Line24. 2025-01-08T08:16:23.448805+00:00 h1a kernel: Ack receiving. t=
=3D721000016 Sport=3D36895 cwnd=3D18 inflight=3D17 RTT=3D111929 acked=3D1
> > Line25. 2025-01-08T08:16:23.448807+00:00 h1a kernel: Pkt sending. t=3D7=
21000026 Sport=3D36895 cwnd=3D19 inflight=3D17 RTT=3D111929 nextSeq=3D39152=
09479
> > Line26. 2025-01-08T08:16:23.448808+00:00 h1a kernel: Ack receiving. t=
=3D721000100 Sport=3D36895 cwnd=3D19 inflight=3D18 RTT=3D113713 acked=3D1
> > Line27. 2025-01-08T08:16:23.496807+00:00 h1a kernel: Pkt sending. t=3D7=
21000110 Sport=3D36895 cwnd=3D20 inflight=3D18 RTT=3D113713 nextSeq=3D39152=
11479
>
> To create a packetdrill test, you don't need to print round_start. You
> can simply construct a packetdrill scenario and assert that
> tcpi_snd_cwnd and tcpi_snd_ssthresh change in the expected ways over
> the course of the test, as packetdrill injects ACKs into your kernel
> under test.
>
> I have upstreamed our packetdrill tests for TCP CUBIC today, so you
> can have some examples to look at. I recommend looking at the
> gtests/net/tcp/cubic/cubic-hystart-delay-rtt-jumps-upward.pkt file in
> this patch:
>
> https://github.com/google/packetdrill/commit/8d63bbc7d6273f86e826ac16dbc3=
c38d4a41b129#diff-d7a68a37bc59309d374f8b97abcd406e263980415dd5af5c68db23f90=
f2d21a6
>
> Before sending your patch to the list, please:
>
> + Download and build packetdrill. For tips on using packetdrill, you
> can start with:
>
> https://github.com/google/packetdrill
>
> + run all cubic packetdrill tests, to help test that your commit does
> not introduce any bugs:
>
> cd ~/packetdrill/gtests/net/
> ./packetdrill/run_all.py -S -v -L -l tcp/cubic/
>
> + read: https://www.kernel.org/doc/html/v6.11/process/maintainer-netdev.h=
tml
>
> + run something like the following to verify the format of the patch
>
> git format-patch --subject-prefix=3D'PATCH net' HEAD~1..HEAD
> ./scripts/checkpatch.pl 00*patch
>
> When all the warnings have been resolved, you can send the patch to
> the list. :-)
>
> > >>> Note that we are still waiting for an HyStart++ implementation for =
linux, you may be interested in working on it.
> >
> > Thank you for the suggestion. I would be happy to work on the HyStart++=
 implementation for Linux. Could you kindly provide more details on the spe=
cific requirements, workflow, and expected outcomes to help me get started?
>
> The specific requirements are in the Hystart++ RFC:
>=C2=A0 https://datatracker.ietf.org/doc/html/rfc9406
>
> The workflow would be to develop the code, run your kernel to test it
> with packetdrill and test transfers in a controlled setting, then send
> the patches to the netdev list for review.
>
> The expected outcome would be to come up with working patches that are
> readable, pass ./scripts/checkpatch.pl, compile and pass packetdrill
> cubic tests, and produce improved behavior in at least some test
> (probably a test where the Hystart++ implementation prevents a
> spurious exit of slow-start when min_rtt jumps upward, which is common
> in cellular/wifi cases).
>
> thanks,
> neal
>
>
> > Best wishes,
> > Mahdi Arghavani
> >
> > On Monday, January 6, 2025 at 09:24:49 PM GMT+13, Eric Dumazet <edumaze=
t@google.com> wrote:
> >
> >
> > On Mon, Jan 6, 2025 at 5:53=E2=80=AFAM Mahdi Arghavani <ma.arghavani@ya=
hoo.com> wrote:
> > >
> > > Hi,
> > >
> > > While refining the source code for our project (SUSS), I discovered a=
 bug in the implementation of HyStart in the Linux kernel, starting from ve=
rsion v5.15.6. The issue, caused by incorrect marking of round starts, resu=
lts in inaccurate measurement of the length of each ACK train. Since HyStar=
t relies on the length of ACK trains as one of two key criteria to stop exp=
onential cwnd growth during Slow-Start, this inaccuracy renders the criteri=
on ineffective, potentially degrading TCP performance.
> > >
> >
> > Hi Mahdi
> >
> > netdev@ mailing list does not accept HTML messages.
> >
> > Am I right to say you are referring to
> >
> > commit 8165a96f6b7122f25bf809aecf06f17b0ec37b58
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:=C2=A0 Tue Nov 23 12:25:35 2021 -0800
> >
> >=C2=A0 =C2=A0 tcp_cubic: fix spurious Hystart ACK train detections for
> > not-cwnd-limited flows
> >
> >=C2=A0 =C2=A0 [ Upstream commit 4e1fddc98d2585ddd4792b5e44433dcee7ece001=
 ]
> >
> >
> >
> > > Issue Description: The problem arises because the hystart_reset funct=
ion is not called upon receiving the first ACK (when cwnd=3Diw=3D10, see th=
e attached figure). Instead, its invocation is delayed until the condition =
cwnd >=3D hystart_low_window is satisfied. In each round, this delay causes=
:
> > >
> > > 1) A postponed marking of the start of a new round.
> > >
> > > 2) An incorrect update of ca->end_seq, leading to incorrect marking o=
f the subsequent round.
> > >
> > > As a result, the ACK train length is underestimated, which adversely =
affects HyStart=E2=80=99s first criterion for stopping cwnd exponential gro=
wth.
> > >
> > > Proposed Solution: Below is a tested patch that addresses the issue b=
y ensuring hystart_reset is triggered appropriately:
> > >
> >
> >
> >
> > Please provide a packetdrill test, this will be the most efficient way
> > to demonstrate the issue.
> >
> > In general, ACK trains detection is not useful in modern networks,
> > because of TSO and GRO.
> >
> > Reference : https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3Dede656e8465839530c3287c7f54adf75dc2b9563
> >
> > Note that we are still waiting for an HyStart++ implementation for linu=
x,
> > you may be interested in working on it.
> >
> > Thank you.
> >
> >
> > >
> > >
> > > diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> > >
> > > index 5dbed91c6178..78d9cf493ace 100644
> > >
> > > --- a/net/ipv4/tcp_cubic.c
> > >
> > > +++ b/net/ipv4/tcp_cubic.c
> > >
> > > @@ -392,6 +392,9 @@ static void hystart_update(struct sock *sk, u32 d=
elay)
> > >
> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (after(tp->snd_una, ca->end_seq))
> > >
> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bictcp_hystart=
_reset(sk);
> > >
> > >
> > >
> > > +=C2=A0 =C2=A0 =C2=A0 if (tcp_snd_cwnd(tp) < hystart_low_window)
> > >
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > >
> > > +
> > >
> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hystart_detect & HYSTART_ACK_TRAIN) {
> > >
> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 now =3D bi=
ctcp_clock_us(sk);
> > >
> > >
> > >
> > > @@ -468,8 +471,7 @@ __bpf_kfunc static void cubictcp_acked(struct soc=
k *sk, const struct ack_sample
> > >
> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ca->delay_min =
=3D delay;
> > >
> > >
> > >
> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* hystart triggers when cwnd is larger th=
an some threshold */
> > >
> > > -=C2=A0 =C2=A0 =C2=A0 if (!ca->found && tcp_in_slow_start(tp) && hyst=
art &&
> > >
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcp_snd_cwnd(tp) >=3D hystart_low=
_window)
> > >
> > > +=C2=A0 =C2=A0 =C2=A0 if (!ca->found && tcp_in_slow_start(tp) && hyst=
art)
> > >
> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hystart_update=
(sk, delay);
> > >
> > >=C2=A0 }
> > >
> > > Best wishes,
> > > Mahdi Arghavani
------=_Part_32929_406650583.1736903937402
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="=?UTF-8?b?Y3ViaWMtaHlzdGFydC1sZW5ndGgtb2YtYWNrLXRyYWluLnBrdA==?="
Content-ID: <8c896bbd-a507-3497-32d2-a9ac18626ae5@yahoo.com>

Ly8gVGVzdCBvZiB0aGUgQ1VCSUMgSFlTVEFSVF9BQ0tfVFJBSU4gbWVjaGFuaXNtLgovLyBWZXJp
ZnkgdGhhdCBpdCBjb3JyZWN0bHkgZXhpdHMgc2xvdyBzdGFydCBpZiB0aGUgbGVuZ3RoIG9mCi8v
IEFDSyB0cmFpbiA+IGhhbGYgb2YgdGhlIGNvbm5lY3Rpb24ncyBtaW5fcnR0LgoKYC4uL2NvbW1v
bi9kZWZhdWx0cy5zaAojIFRvIG9ubHkgcmVseSBvbiBIWVNUQVJULUFDSy1UUkFJTiBkZXRlY3Rp
b24gbWVjaGFuaXNtOgplY2hvIDEgPiAvc3lzL21vZHVsZS90Y3BfY3ViaWMvcGFyYW1ldGVycy9o
eXN0YXJ0X2RldGVjdApgCgogICAgMCBzb2NrZXQoLi4uLCBTT0NLX1NUUkVBTSwgSVBQUk9UT19U
Q1ApID0gMwogICArMCBzZXRzb2Nrb3B0KDMsIFNPTF9TT0NLRVQsIFNPX1JFVVNFQUREUiwgWzFd
LCA0KSA9IDAKICAgKzAgYmluZCgzLCAuLi4sIC4uLikgPSAwCiAgICswIGxpc3RlbigzLCAxKSA9
IDAKCiAgICswIDwgUyAwOjAoMCkgd2luIDMyNzkyIDxtc3MgMTAwMCxzYWNrT0ssbm9wLG5vcCxu
b3Asd3NjYWxlIDc+CiAgICswID4gUy4gMDowKDApIGFjayAxIDxtc3MgMTQ2MCxub3Asbm9wLHNh
Y2tPSyxub3Asd3NjYWxlIDg+CisuMDMwIDwgLiAxOjEoMCkgYWNrIDEgd2luIDI1NwogICArMCBh
Y2NlcHQoMywgLi4uLCAuLi4pID0gNAogICArMCBzZXRzb2Nrb3B0KDQsIFNPTF9TT0NLRVQsIFNP
X1NOREJVRiwgWzIwMDAwMF0sIDQpID0gMAoKICAgKzAgJXsgVENQX0lORklOSVRFX1NTVEhSRVNI
ID0gMHg3ZmZmZmZmZiB9JQoKICAgKzAgd3JpdGUoNCwgLi4uLCAzMDAwMCkgPSAzMDAwMAogICAr
MCA+IFAuIDE6MTAwMDEoMTAwMDApIGFjayAxCiAgICswICV7IGFzc2VydCB0Y3BpX3NuZF9jd25k
ID09IDEwLCB0Y3BpX3NuZF9jd25kIH0lCgorLjAzMCA8IC4gMToxKDApIGFjayAxMDAxIHdpbiAy
NTcKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMjAwMSB3aW4gMjU3CisuMDAxIDwgLiAxOjEoMCkgYWNr
IDMwMDEgd2luIDI1NworLjAwMSA8IC4gMToxKDApIGFjayA0MDAxIHdpbiAyNTcKKy4wMDEgPCAu
IDE6MSgwKSBhY2sgNTAwMSB3aW4gMjU3CisuMDAxIDwgLiAxOjEoMCkgYWNrIDYwMDEgd2luIDI1
NworLjAwMSA8IC4gMToxKDApIGFjayA3MDAxIHdpbiAyNTcKKy4wMDEgPCAuIDE6MSgwKSBhY2sg
ODAwMSB3aW4gMjU3CisuMDAxIDwgLiAxOjEoMCkgYWNrIDkwMDEgd2luIDI1NworLjAwMSA8IC4g
MToxKDApIGFjayAxMDAwMSB3aW4gMjU3CgogICArMCA+IFAuIDEwMDAxOjMwMDAxKDIwMDAwKSBh
Y2sgMQogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAyMCwgdGNwaV9zbmRfY3duZCB9
JQoKKy4wMzAgPCAuIDE6MSgwKSBhY2sgMTEwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNw
aV9zbmRfY3duZCA9PSAyMSwgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sg
MTIwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAyMiwgdGNwaV9z
bmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMTMwMDEgd2luIDI1NwogICArMCAleyBh
c3NlcnQgdGNwaV9zbmRfY3duZCA9PSAyMywgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6
MSgwKSBhY2sgMTQwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAy
NCwgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMTUwMDEgd2luIDI1Nwog
ICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAyNSwgdGNwaV9zbmRfY3duZCB9JQoKKy4w
MDEgPCAuIDE6MSgwKSBhY2sgMTYwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRf
Y3duZCA9PSAyNiwgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMTcwMDEg
d2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAyNywgdGNwaV9zbmRfY3du
ZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMTgwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQg
dGNwaV9zbmRfY3duZCA9PSAyOCwgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBh
Y2sgMTkwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAyOSwgdGNw
aV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMjAwMDEgd2luIDI1NwogICArMCAl
eyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAzMCwgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAu
IDE6MSgwKSBhY2sgMjEwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9
PSAzMSwgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMjIwMDEgd2luIDI1
NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAzMiwgdGNwaV9zbmRfY3duZCB9JQoK
Ky4wMDEgPCAuIDE6MSgwKSBhY2sgMjMwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9z
bmRfY3duZCA9PSAzMywgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMjQw
MDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAzNCwgdGNwaV9zbmRf
Y3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMjUwMDEgd2luIDI1NwogICArMCAleyBhc3Nl
cnQgdGNwaV9zbmRfY3duZCA9PSAzNSwgdGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgw
KSBhY2sgMjYwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAzNiwg
dGNwaV9zbmRfY3duZCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMjcwMDEgd2luIDI1NwovLyBI
eXN0YXJ0IGV4aXRzIHNsb3cgc3RhcnQgaGVyZSBhdCBhIGN3bmQgb2YgMzY6CiAgICswICV7IHBy
aW50KHRjcGlfc25kX2N3bmQpOyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAzNiwgdGNwaV9zbmRf
Y3duZCB9JQogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfc3N0aHJlc2ggIT0gVENQX0lORklOSVRF
X1NTVEhSRVNILCB0Y3BpX3NuZF9zc3RocmVzaCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sgMjgw
MDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfc3N0aHJlc2ggIT0gVENQX0lORklO
SVRFX1NTVEhSRVNILCB0Y3BpX3NuZF9zc3RocmVzaCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBhY2sg
MjkwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfc3N0aHJlc2ggIT0gVENQX0lO
RklOSVRFX1NTVEhSRVNILCB0Y3BpX3NuZF9zc3RocmVzaCB9JQoKKy4wMDEgPCAuIDE6MSgwKSBh
Y2sgMzAwMDEgd2luIDI1NwogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfc3N0aHJlc2ggIT0gVENQ
X0lORklOSVRFX1NTVEhSRVNILCB0Y3BpX3NuZF9zc3RocmVzaCB9JQo=

------=_Part_32929_406650583.1736903937402
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="=?UTF-8?b?bmV3LWN1YmljLWJ1bGstMTY2ay1pZGxlLXJlc3RhcnQucGt0?="
Content-ID: <7bc553ba-069b-2fe0-c95b-61427550ce21@yahoo.com>

Ly8gVGVzdCBidWxrIENVQklDIGZsb3cgYXQgMTY2IGtiaXQvc2VjICgyIDEwMDAtYnl0ZSBwYXls
b2FkcyBlYWNoIDEwMG1zCi8vIG1lYW5zIDIgKiAxMDQwICogOCAvIC4xID0gMTY2NDAwIGJpdHMv
c2VjKS4KLy8gVmVyaWZpZXMgdGhhdCBDVUJJQyBpbmNyZWFzZXMgaXRzIGN3bmQgYnkgYXQgbW9z
dCAxIHBhY2tldAovLyBmb3IgZXZlcnkgMiBwYWNrZXRzIEFDS2VkLgovLyBBbHNvIHRlc3RzIHRo
ZSBDVUJJQyBIeXN0YXJ0IGFsZ29yaXRobSBmb3IgZXhpdGluZyBzbG93IHN0YXJ0LgoKLy8gRm9y
IHRoaXMgdGVzdCBXZSBtb3N0bHkganVzdCBjYXJlIGFib3V0IGN3bmQgdmFsdWVzLCBub3QgZXhh
Y3QgdGltaW5nLgovLyBTbyB0byByZWR1Y2UgZmxha2VzIGFsbG93IH4yMG1zIG9mIHRpbWluZyB2
YXJpYXRpb246Ci0tdG9sZXJhbmNlX3VzZWNzPTIwMDAwCgpgLi4vLi4vY29tbW9uL2RlZmF1bHRz
LnNoCnRjIHFkaXNjIHJlcGxhY2UgZGV2IHR1bjAgcm9vdCBmcQpzeXNjdGwgLXEgbmV0LmlwdjQu
dGNwX2Nvbmdlc3Rpb25fY29udHJvbD1jdWJpYwpzeXNjdGwgLXEgbmV0LmlwdjQudGNwX21pbl90
c29fc2Vncz00CiMgRGlzYWJsZSBUTFAgdG8gYXZvaWQgZmxha2VzIGZyb20gc3B1cmlvdXMgcmV0
cmFuc21pdHM6CnN5c2N0bCAtcSBuZXQuaXB2NC50Y3BfZWFybHlfcmV0cmFucz0wYAoKLy8gSW5p
dGlhbGl6ZSBjb25uZWN0aW9uCiAgICAwIHNvY2tldCguLi4sIFNPQ0tfU1RSRUFNLCBJUFBST1RP
X1RDUCkgPSAzCiAgICswIHNldHNvY2tvcHQoMywgU09MX1NPQ0tFVCwgU09fUkVVU0VBRERSLCBb
MV0sIDQpID0gMAogICArMCBiaW5kKDMsIC4uLiwgLi4uKSA9IDAKICAgKzAgbGlzdGVuKDMsIDEp
ID0gMAoKICAgKzAgPCBTIDA6MCgwKSB3aW4gMzI3OTIgPG1zcyAxMDAwLHNhY2tPSyxub3Asbm9w
LG5vcCx3c2NhbGUgMTA+CiAgICswID4gUy4gMDowKDApIGFjayAxIDxtc3MgMTQ2MCxub3Asbm9w
LHNhY2tPSyxub3Asd3NjYWxlIDg+CiAgKy4xIDwgLiAxOjEoMCkgYWNrIDEgd2luIDUxNAoKICAg
KzAgYWNjZXB0KDMsIC4uLiwgLi4uKSA9IDQKCi8vIFNPX1NOREJVRiBpcyBkb3VibGVkLCBzbyB3
ZSBjYW4gd3JpdGUgdGhlIGZ1bGwgYW1vdW50IGJlbG93OgogICArMCBzZXRzb2Nrb3B0KDQsIFNP
TF9TT0NLRVQsIFNPX1NOREJVRiwgWzIwMDAwMF0sIDQpID0gMAogICArMCAleyBhc3NlcnQgdGNw
aV9zbmRfY3duZCA9PSAxMCwgdGNwaV9zbmRfY3duZCB9JQogICArMCB3cml0ZSg0LCAuLi4sIDEx
MjAwMCkgPSAxMTIwMDAKCiAgKy4xIDwgLiAgMToxKDApIGFjayAyMDAxIHdpbiA1MTQKICArLjEg
PCAuICAxOjEoMCkgYWNrIDQwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNjAwMSB3
aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayA4MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEo
MCkgYWNrIDEwMDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGFzc2Vy
dCB0Y3BpX3NuZF9jd25kID09IDIwLCB0Y3BpX3NuZF9jd25kIH0lCiAgKy4xIDwgLiAgMToxKDAp
IGFjayAxMjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAxNDAwMSB3aW4gNTE0CiAg
Ky4xIDwgLiAgMToxKDApIGFjayAxNjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAx
ODAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAyMDAwMSB3aW4gNTE0CiAgICswICV7
IHByaW50KHRjcGlfc25kX2N3bmQpOyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAzMCwgdGNwaV9z
bmRfY3duZCB9JQoKICArLjEgPCAuICAxOjEoMCkgYWNrIDIyMDAxIHdpbiA1MTQKICArLjEgPCAu
ICAxOjEoMCkgYWNrIDI0MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDI2MDAxIHdp
biA1MTQKCi8vIEh5c3RhcnQgZXhpdHMgc2xvdyBzdGFydCBoZXJlIGF0IGEgY3duZCBvZiAzNjoK
ICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGFzc2VydCB0Y3BpX3NuZF9jd25kID09IDM2
LCB0Y3BpX3NuZF9jd25kIH0lCgogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjgwMDEgd2luIDUxNAog
ICsuMSA8IC4gIDE6MSgwKSBhY2sgMzAwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sg
MzIwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzQwMDEgd2luIDUxNAogICsuMSA8
IC4gIDE6MSgwKSBhY2sgMzYwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzgwMDEg
d2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNDAwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6
MSgwKSBhY2sgNDIwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNDQwMDEgd2luIDUx
NAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNDYwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3Bp
X3NuZF9jd25kKTsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gMzcsIHRjcGlfc25kX2N3bmQgfSUK
CgogICsuMSA8IC4gIDE6MSgwKSBhY2sgNDgwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBh
Y2sgNTAwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNTIwMDEgd2luIDUxNAogICsu
MSA8IC4gIDE6MSgwKSBhY2sgNTQwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNTYw
MDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNTgwMDEgd2luIDUxNAogICsuMSA8IC4g
IDE6MSgwKSBhY2sgNjAwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNjIwMDEgd2lu
IDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNjQwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgw
KSBhY2sgNjYwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsgYXNzZXJ0
IHRjcGlfc25kX2N3bmQgPT0gMzgsIHRjcGlfc25kX2N3bmQgfSUKCgoKCgoKCiAgKy4xIDwgLiAg
MToxKDApIGFjayA2ODAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayA3MDAwMSB3aW4g
NTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayA3MjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDAp
IGFjayA3NDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayA3NjAwMSB3aW4gNTE0CiAg
ICswICV7IHByaW50KHRjcGlfc25kX2N3bmQpOyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAzOSwg
dGNwaV9zbmRfY3duZCB9JQoKICArLjEgPCAuICAxOjEoMCkgYWNrIDc4MDAxIHdpbiA1MTQKICAr
LjEgPCAuICAxOjEoMCkgYWNrIDgwMDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDgy
MDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGFzc2VydCB0Y3BpX3Nu
ZF9jd25kID09IDQwLCB0Y3BpX3NuZF9jd25kIH0lCgogICsuMSA8IC4gIDE6MSgwKSBhY2sgODQw
MDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgODYwMDEgd2luIDUxNAogICsuMSA8IC4g
IDE6MSgwKSBhY2sgODgwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsg
YXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gNDEsIHRjcGlfc25kX2N3bmQgfSUKCgogICsuMSA8IC4g
IDE6MSgwKSBhY2sgOTAwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgOTIwMDEgd2lu
IDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsgYXNzZXJ0IHRjcGlfc25kX2N3bmQg
PT0gNDIsIHRjcGlfc25kX2N3bmQgfSUKCiAgKy4xIDwgLiAgMToxKDApIGFjayA5NDAwMSB3aW4g
NTE0CiAgICswICV7IHByaW50KHRjcGlfc25kX2N3bmQpOyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9
PSA0MywgdGNwaV9zbmRfY3duZCB9JQoKICArLjEgPCAuICAxOjEoMCkgYWNrIDk2MDAxIHdpbiA1
MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDk4MDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNw
aV9zbmRfY3duZCk7IGFzc2VydCB0Y3BpX3NuZF9jd25kID09IDQ0LCB0Y3BpX3NuZF9jd25kIH0l
CgogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTAwMDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNw
aV9zbmRfY3duZCk7IGFzc2VydCB0Y3BpX3NuZF9jd25kID09IDQ1LCB0Y3BpX3NuZF9jd25kIH0l
CgogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTAyMDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkg
YWNrIDEwNDAwMSB3aW4gNTE0CiAgICswICV7IHByaW50KHRjcGlfc25kX2N3bmQpOyBhc3NlcnQg
dGNwaV9zbmRfY3duZCA9PSA0NiwgdGNwaV9zbmRfY3duZCB9JQoKCi8vIEZyb20gdGhpcyBwb2lu
dCBvbndhcmQsIHdlIHZlcmlmeSB0aGF0IGZvciBldmVyeSAyIHBhY2tldHMgQUNLZWQsCi8vIENV
QklDIGluY3JlYXNlcyBpdHMgY3duZCBieSAxIHBhY2tldC4KCiAgKy4xIDwgLiAgMToxKDApIGFj
ayAxMDYwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsgYXNzZXJ0IHRj
cGlfc25kX2N3bmQgPT0gNDcsIHRjcGlfc25kX2N3bmQgfSUKCiAgKy4xIDwgLiAgMToxKDApIGFj
ayAxMDgwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsgYXNzZXJ0IHRj
cGlfc25kX2N3bmQgPT0gNDgsIHRjcGlfc25kX2N3bmQgfSUKCiAgKy4xIDwgLiAgMToxKDApIGFj
ayAxMTAwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsgYXNzZXJ0IHRj
cGlfc25kX2N3bmQgPT0gNDksIHRjcGlfc25kX2N3bmQgfSUKCiAgKy4xIDwgLiAgMToxKDApIGFj
ayAxMTIwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsgYXNzZXJ0IHRj
cGlfc25kX2N3bmQgPT0gNTAsIHRjcGlfc25kX2N3bmQgfSUKCgoKCgovLyBHbyBpZGxlIGZvciBh
IHdoaWxlIGluIG9yZGVyIHRvIHZlcmlmeSB0aGF0IHRoaXMgZG9lc24ndCBsZXQgdXMKLy8gYWNj
dW11bGF0ZSAiY3JlZGl0IiB0b3dhcmQgaW5jcmVhc2luZyBjd25kIHF1aWNrbHkgd2hlbiB3ZSBn
bwovLyBjd25kLWxpbWl0ZWQgYWdhaW4uCiAgICswIHdyaXRlKDQsIC4uLiwgMTEyMDAwKSA9IDEx
MjAwMAoKCiAgICswICV7IHByaW50KHRjcGlfc25kX2N3bmQpOyBhc3NlcnQgdGNwaV9zbmRfY3du
ZCA9PSA1MCwgdGNwaV9zbmRfY3duZCB9JQogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTE0MDAxIHdp
biA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDExNjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMTox
KDApIGFjayAxMTgwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTIwMDAxIHdpbiA1
MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDEyMjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDAp
IGFjayAxMjQwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTI2MDAxIHdpbiA1MTQK
ICArLjEgPCAuICAxOjEoMCkgYWNrIDEyODAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFj
ayAxMzAwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTMyMDAxIHdpbiA1MTQKICAr
LjEgPCAuICAxOjEoMCkgYWNrIDEzNDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAx
MzYwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTM4MDAxIHdpbiA1MTQKICArLjEg
PCAuICAxOjEoMCkgYWNrIDE0MDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAxNDIw
MDEgd2luIDUxNAoKCiAgICswICV7IHByaW50KHRjcGlfc25kX2N3bmQpOyBhc3NlcnQgdGNwaV9z
bmRfY3duZCA9PSA1MSwgdGNwaV9zbmRfY3duZCB9JQogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTQ0
MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDE0NjAwMSB3aW4gNTE0CgoKICAgKzAg
JXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGFzc2VydCB0Y3BpX3NuZF9jd25kID09IDUyLCB0Y3Bp
X3NuZF9jd25kIH0lCiAgKy4xIDwgLiAgMToxKDApIGFjayAxNDgwMDEgd2luIDUxNAogICArMCAl
eyBwcmludCh0Y3BpX3NuZF9jd25kKTsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gNTMsIHRjcGlf
c25kX2N3bmQgfSUKICArLjEgPCAuICAxOjEoMCkgYWNrIDE1MDAwMSB3aW4gNTE0CiAgKy4xIDwg
LiAgMToxKDApIGFjayAxNTIwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25k
KTsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gNTQsIHRjcGlfc25kX2N3bmQgfSUKICArLjEgPCAu
ICAxOjEoMCkgYWNrIDE1NDAwMSB3aW4gNTE0CiAgICswICV7IHByaW50KHRjcGlfc25kX2N3bmQp
OyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSA1NSwgdGNwaV9zbmRfY3duZCB9JQogICsuMSA8IC4g
IDE6MSgwKSBhY2sgMTU2MDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7
IGFzc2VydCB0Y3BpX3NuZF9jd25kID09IDU2LCB0Y3BpX3NuZF9jd25kIH0lCiAgKy4xIDwgLiAg
MToxKDApIGFjayAxNTgwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsg
YXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gNTcsIHRjcGlfc25kX2N3bmQgfSUKICArLjEgPCAuICAx
OjEoMCkgYWNrIDE2MDAwMSB3aW4gNTE0CiAgICswICV7IHByaW50KHRjcGlfc25kX2N3bmQpOyBh
c3NlcnQgdGNwaV9zbmRfY3duZCA9PSA1OCwgdGNwaV9zbmRfY3duZCB9JQogICsuMSA8IC4gIDE6
MSgwKSBhY2sgMTYyMDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGFz
c2VydCB0Y3BpX3NuZF9jd25kID09IDU5LCB0Y3BpX3NuZF9jd25kIH0lCiAgKy4xIDwgLiAgMTox
KDApIGFjayAxNjQwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsgY3du
ZCA9IDYwOyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSBjd25kLCB0Y3BpX3NuZF9jd25kIH0lCgoK
ICArLjEgPCAuICAxOjEoMCkgYWNrIDE2NjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFj
ayAxNjgwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTcwMDAxIHdpbiA1MTQKICAr
LjEgPCAuICAxOjEoMCkgYWNrIDE3MjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAx
NzQwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTc2MDAxIHdpbiA1MTQKICArLjEg
PCAuICAxOjEoMCkgYWNrIDE3ODAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAxODAw
MDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTgyMDAxIHdpbiA1MTQKICArLjEgPCAu
ICAxOjEoMCkgYWNrIDE4NDAwMSB3aW4gNTE0CiAgICswICV7IHByaW50KHRjcGlfc25kX2N3bmQp
OyBjd25kICs9IDEwOyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSBjd25kLCB0Y3BpX3NuZF9jd25k
IH0lCgogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTg2MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEo
MCkgYWNrIDE4ODAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAxOTAwMDEgd2luIDUx
NAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTkyMDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkg
YWNrIDE5NDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAxOTYwMDEgd2luIDUxNAog
ICsuMSA8IC4gIDE6MSgwKSBhY2sgMTk4MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNr
IDIwMDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAyMDIwMDEgd2luIDUxNAogICsu
MSA8IC4gIDE6MSgwKSBhY2sgMjA0MDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRf
Y3duZCk7IGN3bmQgKz0gMTA7IGFzc2VydCB0Y3BpX3NuZF9jd25kID09IGN3bmQsIHRjcGlfc25k
X2N3bmQgfSUKCgogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjA2MDAxIHdpbiA1MTQKICArLjEgPCAu
ICAxOjEoMCkgYWNrIDIwODAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAyMTAwMDEg
d2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjEyMDAxIHdpbiA1MTQKICArLjEgPCAuICAx
OjEoMCkgYWNrIDIxNDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAyMTYwMDEgd2lu
IDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjE4MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEo
MCkgYWNrIDIyMDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAyMjIwMDEgd2luIDUx
NAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjI0MDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNw
aV9zbmRfY3duZCk7IGN3bmQgKz0gMTA7IGFzc2VydCB0Y3BpX3NuZF9jd25kID09IGN3bmQsIHRj
cGlfc25kX2N3bmQgfSUK

------=_Part_32929_406650583.1736903937402
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="=?UTF-8?b?bmV3LWN1YmljLWJ1bGstMTY2ay5wa3Q=?="
Content-ID: <ea78b961-ce9a-5977-62e3-787c2ff04e76@yahoo.com>

Ly8gVGVzdCBidWxrIENVQklDIGZsb3cgYXQgMTY2IGtiaXQvc2VjICgyIDEwMDAtYnl0ZSBwYXls
b2FkcyBlYWNoIDEwMG1zCi8vIG1lYW5zIDIgKiAxMDQwICogOCAvIC4xID0gMTY2NDAwIGJpdHMv
c2VjKS4KLy8gVmVyaWZpZXMgdGhhdCBDVUJJQyBpbmNyZWFzZXMgaXRzIGN3bmQgYnkgYXQgbW9z
dCAxIHBhY2tldAovLyBmb3IgZXZlcnkgMiBwYWNrZXRzIEFDS2VkLgovLyBBbHNvIHRlc3RzIHRo
ZSBDVUJJQyBIeXN0YXJ0IGFsZ29yaXRobSBmb3IgZXhpdGluZyBzbG93IHN0YXJ0LgoKLy8gRm9y
IHRoaXMgdGVzdCBXZSBtb3N0bHkganVzdCBjYXJlIGFib3V0IGN3bmQgdmFsdWVzLCBub3QgZXhh
Y3QgdGltaW5nLgovLyBTbyB0byByZWR1Y2UgZmxha2VzIGFsbG93IH4yMG1zIG9mIHRpbWluZyB2
YXJpYXRpb246Ci0tdG9sZXJhbmNlX3VzZWNzPTIwMDAwCgpgLi4vLi4vY29tbW9uL2RlZmF1bHRz
LnNoCnRjIHFkaXNjIHJlcGxhY2UgZGV2IHR1bjAgcm9vdCBmcQpzeXNjdGwgLXEgbmV0LmlwdjQu
dGNwX2Nvbmdlc3Rpb25fY29udHJvbD1jdWJpYwpzeXNjdGwgLXEgbmV0LmlwdjQudGNwX21pbl90
c29fc2Vncz00CiMgRGlzYWJsZSBUTFAgdG8gYXZvaWQgZmxha2VzIGZyb20gc3B1cmlvdXMgcmV0
cmFuc21pdHM6CnN5c2N0bCAtcSBuZXQuaXB2NC50Y3BfZWFybHlfcmV0cmFucz0wYAoKLy8gSW5p
dGlhbGl6ZSBjb25uZWN0aW9uCiAgICAwIHNvY2tldCguLi4sIFNPQ0tfU1RSRUFNLCBJUFBST1RP
X1RDUCkgPSAzCiAgICswIHNldHNvY2tvcHQoMywgU09MX1NPQ0tFVCwgU09fUkVVU0VBRERSLCBb
MV0sIDQpID0gMAogICArMCBiaW5kKDMsIC4uLiwgLi4uKSA9IDAKICAgKzAgbGlzdGVuKDMsIDEp
ID0gMAoKICAgKzAgPCBTIDA6MCgwKSB3aW4gMzI3OTIgPG1zcyAxMDAwLHNhY2tPSyxub3Asbm9w
LG5vcCx3c2NhbGUgMTA+CiAgICswID4gUy4gMDowKDApIGFjayAxIDxtc3MgMTQ2MCxub3Asbm9w
LHNhY2tPSyxub3Asd3NjYWxlIDg+CiAgKy4xIDwgLiAxOjEoMCkgYWNrIDEgd2luIDUxNAoKICAg
KzAgYWNjZXB0KDMsIC4uLiwgLi4uKSA9IDQKCi8vIFNPX1NOREJVRiBpcyBkb3VibGVkLCBzbyB3
ZSBjYW4gd3JpdGUgdGhlIGZ1bGwgYW1vdW50IGJlbG93OgogICArMCBzZXRzb2Nrb3B0KDQsIFNP
TF9TT0NLRVQsIFNPX1NOREJVRiwgWzIwMDAwMF0sIDQpID0gMAogICArMCAleyBhc3NlcnQgdGNw
aV9zbmRfY3duZCA9PSAxMCwgdGNwaV9zbmRfY3duZCB9JQogICArMCB3cml0ZSg0LCAuLi4sIDQw
MDAwMCkgPSA0MDAwMDAKCiAgKy4xIDwgLiAgMToxKDApIGFjayAyMDAxIHdpbiA1MTQKICArLjEg
PCAuICAxOjEoMCkgYWNrIDQwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNjAwMSB3
aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayA4MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEo
MCkgYWNrIDEwMDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGFzc2Vy
dCB0Y3BpX3NuZF9jd25kID09IDIwLCB0Y3BpX3NuZF9jd25kIH0lCiAgKy4xIDwgLiAgMToxKDAp
IGFjayAxMjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAxNDAwMSB3aW4gNTE0CiAg
Ky4xIDwgLiAgMToxKDApIGFjayAxNjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAx
ODAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAyMDAwMSB3aW4gNTE0CiAgICswICV7
IHByaW50KHRjcGlfc25kX2N3bmQpOyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAzMCwgdGNwaV9z
bmRfY3duZCB9JQoKICArLjEgPCAuICAxOjEoMCkgYWNrIDIyMDAxIHdpbiA1MTQKICArLjEgPCAu
ICAxOjEoMCkgYWNrIDI0MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDI2MDAxIHdp
biA1MTQKCi8vIEh5c3RhcnQgZXhpdHMgc2xvdyBzdGFydCBoZXJlIGF0IGEgY3duZCBvZiAzNjoK
ICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGFzc2VydCB0Y3BpX3NuZF9jd25kID09IDM2
LCB0Y3BpX3NuZF9jd25kIH0lCgogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjgwMDEgd2luIDUxNAog
ICsuMSA8IC4gIDE6MSgwKSBhY2sgMzAwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sg
MzIwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzQwMDEgd2luIDUxNAogICsuMSA8
IC4gIDE6MSgwKSBhY2sgMzYwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzgwMDEg
d2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNDAwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6
MSgwKSBhY2sgNDIwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNDQwMDEgd2luIDUx
NAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNDYwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3Bp
X3NuZF9jd25kKTsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gMzcsIHRjcGlfc25kX2N3bmQgfSUK
CgogICsuMSA8IC4gIDE6MSgwKSBhY2sgNDgwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBh
Y2sgNTAwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNTIwMDEgd2luIDUxNAogICsu
MSA8IC4gIDE6MSgwKSBhY2sgNTQwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNTYw
MDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNTgwMDEgd2luIDUxNAogICsuMSA8IC4g
IDE6MSgwKSBhY2sgNjAwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNjIwMDEgd2lu
IDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgNjQwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgw
KSBhY2sgNjYwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsgYXNzZXJ0
IHRjcGlfc25kX2N3bmQgPT0gMzgsIHRjcGlfc25kX2N3bmQgfSUKCgoKCgoKCiAgKy4xIDwgLiAg
MToxKDApIGFjayA2ODAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayA3MDAwMSB3aW4g
NTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayA3MjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDAp
IGFjayA3NDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayA3NjAwMSB3aW4gNTE0CiAg
ICswICV7IHByaW50KHRjcGlfc25kX2N3bmQpOyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAzOSwg
dGNwaV9zbmRfY3duZCB9JQoKICArLjEgPCAuICAxOjEoMCkgYWNrIDc4MDAxIHdpbiA1MTQKICAr
LjEgPCAuICAxOjEoMCkgYWNrIDgwMDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDgy
MDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGFzc2VydCB0Y3BpX3Nu
ZF9jd25kID09IDQwLCB0Y3BpX3NuZF9jd25kIH0lCgogICsuMSA8IC4gIDE6MSgwKSBhY2sgODQw
MDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgODYwMDEgd2luIDUxNAogICsuMSA8IC4g
IDE6MSgwKSBhY2sgODgwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsg
YXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gNDEsIHRjcGlfc25kX2N3bmQgfSUKCgogICsuMSA8IC4g
IDE6MSgwKSBhY2sgOTAwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgOTIwMDEgd2lu
IDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsgYXNzZXJ0IHRjcGlfc25kX2N3bmQg
PT0gNDIsIHRjcGlfc25kX2N3bmQgfSUKCiAgKy4xIDwgLiAgMToxKDApIGFjayA5NDAwMSB3aW4g
NTE0CiAgICswICV7IHByaW50KHRjcGlfc25kX2N3bmQpOyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9
PSA0MywgdGNwaV9zbmRfY3duZCB9JQoKICArLjEgPCAuICAxOjEoMCkgYWNrIDk2MDAxIHdpbiA1
MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDk4MDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNw
aV9zbmRfY3duZCk7IGFzc2VydCB0Y3BpX3NuZF9jd25kID09IDQ0LCB0Y3BpX3NuZF9jd25kIH0l
CgogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTAwMDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNw
aV9zbmRfY3duZCk7IGFzc2VydCB0Y3BpX3NuZF9jd25kID09IDQ1LCB0Y3BpX3NuZF9jd25kIH0l
CgogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTAyMDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkg
YWNrIDEwNDAwMSB3aW4gNTE0CiAgICswICV7IHByaW50KHRjcGlfc25kX2N3bmQpOyBhc3NlcnQg
dGNwaV9zbmRfY3duZCA9PSA0NiwgdGNwaV9zbmRfY3duZCB9JQoKCi8vIEZyb20gdGhpcyBwb2lu
dCBvbndhcmQsIHdlIHZlcmlmeSB0aGF0IGZvciBldmVyeSAyIHBhY2tldHMgQUNLZWQsCi8vIENV
QklDIGluY3JlYXNlcyBpdHMgY3duZCBieSAxIHBhY2tldC4KCiAgKy4xIDwgLiAgMToxKDApIGFj
ayAxMDYwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsgYXNzZXJ0IHRj
cGlfc25kX2N3bmQgPT0gNDcsIHRjcGlfc25kX2N3bmQgfSUKCiAgKy4xIDwgLiAgMToxKDApIGFj
ayAxMDgwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsgYXNzZXJ0IHRj
cGlfc25kX2N3bmQgPT0gNDgsIHRjcGlfc25kX2N3bmQgfSUKCiAgKy4xIDwgLiAgMToxKDApIGFj
ayAxMTAwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsgYXNzZXJ0IHRj
cGlfc25kX2N3bmQgPT0gNDksIHRjcGlfc25kX2N3bmQgfSUKCgogICsuMSA8IC4gIDE6MSgwKSBh
Y2sgMTEyMDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGN3bmQgPSA1
MDsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gY3duZCwgdGNwaV9zbmRfY3duZCB9JQogICsuMSA8
IC4gIDE6MSgwKSBhY2sgMTE0MDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3du
ZCk7IGN3bmQgKz0gMTsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gY3duZCwgdGNwaV9zbmRfY3du
ZCB9JQogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTE2MDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQo
dGNwaV9zbmRfY3duZCk7IGN3bmQgKz0gMTsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gY3duZCwg
dGNwaV9zbmRfY3duZCB9JQogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTE4MDAxIHdpbiA1MTQKICAg
KzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGN3bmQgKz0gMTsgYXNzZXJ0IHRjcGlfc25kX2N3
bmQgPT0gY3duZCwgdGNwaV9zbmRfY3duZCB9JQogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTIwMDAx
IHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGN3bmQgKz0gMTsgYXNzZXJ0
IHRjcGlfc25kX2N3bmQgPT0gY3duZCwgdGNwaV9zbmRfY3duZCB9JQogICsuMSA8IC4gIDE6MSgw
KSBhY2sgMTIyMDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGN3bmQg
Kz0gMTsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gY3duZCwgdGNwaV9zbmRfY3duZCB9JQogICsu
MSA8IC4gIDE6MSgwKSBhY2sgMTI0MDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRf
Y3duZCk7IGN3bmQgKz0gMTsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gY3duZCwgdGNwaV9zbmRf
Y3duZCB9JQogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTI2MDAxIHdpbiA1MTQKICAgKzAgJXsgcHJp
bnQodGNwaV9zbmRfY3duZCk7IGN3bmQgKz0gMTsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gY3du
ZCwgdGNwaV9zbmRfY3duZCB9JQogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTI4MDAxIHdpbiA1MTQK
ICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGN3bmQgKz0gMTsgYXNzZXJ0IHRjcGlfc25k
X2N3bmQgPT0gY3duZCwgdGNwaV9zbmRfY3duZCB9JQogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTMw
MDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGN3bmQgKz0gMTsgYXNz
ZXJ0IHRjcGlfc25kX2N3bmQgPT0gY3duZCwgdGNwaV9zbmRfY3duZCB9JQogICsuMSA8IC4gIDE6
MSgwKSBhY2sgMTMyMDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGN3
bmQgKz0gMTsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gY3duZCwgdGNwaV9zbmRfY3duZCB9JQog
ICsuMSA8IC4gIDE6MSgwKSBhY2sgMTM0MDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9z
bmRfY3duZCk7IGN3bmQgKz0gMTsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gY3duZCwgdGNwaV9z
bmRfY3duZCB9JQogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTM2MDAxIHdpbiA1MTQKICAgKzAgJXsg
cHJpbnQodGNwaV9zbmRfY3duZCk7IGN3bmQgKz0gMTsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0g
Y3duZCwgdGNwaV9zbmRfY3duZCB9JQogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTM4MDAxIHdpbiA1
MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGN3bmQgKz0gMTsgYXNzZXJ0IHRjcGlf
c25kX2N3bmQgPT0gY3duZCwgdGNwaV9zbmRfY3duZCB9JQogICsuMSA8IC4gIDE6MSgwKSBhY2sg
MTQwMDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGN3bmQgKz0gMTsg
YXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gY3duZCwgdGNwaV9zbmRfY3duZCB9JQoKICArLjEgPCAu
ICAxOjEoMCkgYWNrIDE0MjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAxNDQwMDEg
d2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTQ2MDAxIHdpbiA1MTQKICArLjEgPCAuICAx
OjEoMCkgYWNrIDE0ODAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAxNTAwMDEgd2lu
IDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTUyMDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEo
MCkgYWNrIDE1NDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAxNTYwMDEgd2luIDUx
NAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTU4MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkg
YWNrIDE2MDAwMSB3aW4gNTE0CiAgICswICV7IHByaW50KHRjcGlfc25kX2N3bmQpOyBjd25kICs9
IDEwOyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSBjd25kLCB0Y3BpX3NuZF9jd25kIH0lCgogICsu
MSA8IC4gIDE6MSgwKSBhY2sgMTYyMDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDE2
NDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAxNjYwMDEgd2luIDUxNAogICsuMSA8
IC4gIDE6MSgwKSBhY2sgMTY4MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDE3MDAw
MSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAxNzIwMDEgd2luIDUxNAogICsuMSA8IC4g
IDE6MSgwKSBhY2sgMTc0MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDE3NjAwMSB3
aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAxNzgwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6
MSgwKSBhY2sgMTgwMDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGN3
bmQgKz0gMTA7IGFzc2VydCB0Y3BpX3NuZF9jd25kID09IGN3bmQsIHRjcGlfc25kX2N3bmQgfSUK
CiAgKy4xIDwgLiAgMToxKDApIGFjayAxODIwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBh
Y2sgMTg0MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDE4NjAwMSB3aW4gNTE0CiAg
Ky4xIDwgLiAgMToxKDApIGFjayAxODgwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sg
MTkwMDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDE5MjAwMSB3aW4gNTE0CiAgKy4x
IDwgLiAgMToxKDApIGFjayAxOTQwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMTk2
MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDE5ODAwMSB3aW4gNTE0CiAgKy4xIDwg
LiAgMToxKDApIGFjayAyMDAwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25k
KTsgY3duZCArPSAxMDsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gY3duZCwgdGNwaV9zbmRfY3du
ZCB9JQoKICArLjEgPCAuICAxOjEoMCkgYWNrIDIwMjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMTox
KDApIGFjayAyMDQwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjA2MDAxIHdpbiA1
MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDIwODAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDAp
IGFjayAyMTAwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjEyMDAxIHdpbiA1MTQK
ICArLjEgPCAuICAxOjEoMCkgYWNrIDIxNDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFj
ayAyMTYwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjE4MDAxIHdpbiA1MTQKICAr
LjEgPCAuICAxOjEoMCkgYWNrIDIyMDAwMSB3aW4gNTE0CiAgICswICV7IHByaW50KHRjcGlfc25k
X2N3bmQpOyBjd25kICs9IDEwOyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSBjd25kLCB0Y3BpX3Nu
ZF9jd25kIH0lCgogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjIyMDAxIHdpbiA1MTQKICArLjEgPCAu
ICAxOjEoMCkgYWNrIDIyNDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAyMjYwMDEg
d2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjI4MDAxIHdpbiA1MTQKICArLjEgPCAuICAx
OjEoMCkgYWNrIDIzMDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAyMzIwMDEgd2lu
IDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjM0MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEo
MCkgYWNrIDIzNjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAyMzgwMDEgd2luIDUx
NAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjQwMDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNw
aV9zbmRfY3duZCk7IGN3bmQgKz0gMTA7IGFzc2VydCB0Y3BpX3NuZF9jd25kID09IGN3bmQsIHRj
cGlfc25kX2N3bmQgfSUKCiAgKy4xIDwgLiAgMToxKDApIGFjayAyNDIwMDEgd2luIDUxNAogICsu
MSA8IC4gIDE6MSgwKSBhY2sgMjQ0MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDI0
NjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAyNDgwMDEgd2luIDUxNAogICsuMSA8
IC4gIDE6MSgwKSBhY2sgMjUwMDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDI1MjAw
MSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAyNTQwMDEgd2luIDUxNAogICsuMSA8IC4g
IDE6MSgwKSBhY2sgMjU2MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDI1ODAwMSB3
aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAyNjAwMDEgd2luIDUxNAogICArMCAleyBwcmlu
dCh0Y3BpX3NuZF9jd25kKTsgY3duZCArPSAxMDsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gY3du
ZCwgdGNwaV9zbmRfY3duZCB9JQoKICArLjEgPCAuICAxOjEoMCkgYWNrIDI2MjAwMSB3aW4gNTE0
CiAgKy4xIDwgLiAgMToxKDApIGFjayAyNjQwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBh
Y2sgMjY2MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDI2ODAwMSB3aW4gNTE0CiAg
Ky4xIDwgLiAgMToxKDApIGFjayAyNzAwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sg
MjcyMDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDI3NDAwMSB3aW4gNTE0CiAgKy4x
IDwgLiAgMToxKDApIGFjayAyNzYwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjc4
MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDI4MDAwMSB3aW4gNTE0CiAgICswICV7
IHByaW50KHRjcGlfc25kX2N3bmQpOyBjd25kICs9IDEwOyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9
PSBjd25kLCB0Y3BpX3NuZF9jd25kIH0lCgogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjgyMDAxIHdp
biA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDI4NDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMTox
KDApIGFjayAyODYwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjg4MDAxIHdpbiA1
MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDI5MDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDAp
IGFjayAyOTIwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMjk0MDAxIHdpbiA1MTQK
ICArLjEgPCAuICAxOjEoMCkgYWNrIDI5NjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFj
ayAyOTgwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzAwMDAxIHdpbiA1MTQKICAg
KzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGN3bmQgKz0gMTA7IGFzc2VydCB0Y3BpX3NuZF9j
d25kID09IGN3bmQsIHRjcGlfc25kX2N3bmQgfSUKCiAgKy4xIDwgLiAgMToxKDApIGFjayAzMDIw
MDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzA0MDAxIHdpbiA1MTQKICArLjEgPCAu
ICAxOjEoMCkgYWNrIDMwNjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAzMDgwMDEg
d2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzEwMDAxIHdpbiA1MTQKICArLjEgPCAuICAx
OjEoMCkgYWNrIDMxMjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAzMTQwMDEgd2lu
IDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzE2MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEo
MCkgYWNrIDMxODAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAzMjAwMDEgd2luIDUx
NAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsgY3duZCArPSAxMDsgYXNzZXJ0IHRjcGlf
c25kX2N3bmQgPT0gY3duZCwgdGNwaV9zbmRfY3duZCB9JQoKICArLjEgPCAuICAxOjEoMCkgYWNr
IDMyMjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAzMjQwMDEgd2luIDUxNAogICsu
MSA8IC4gIDE6MSgwKSBhY2sgMzI2MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDMy
ODAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAzMzAwMDEgd2luIDUxNAogICsuMSA8
IC4gIDE6MSgwKSBhY2sgMzMyMDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDMzNDAw
MSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAzMzYwMDEgd2luIDUxNAogICsuMSA8IC4g
IDE6MSgwKSBhY2sgMzM4MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDM0MDAwMSB3
aW4gNTE0CiAgICswICV7IHByaW50KHRjcGlfc25kX2N3bmQpOyBjd25kICs9IDEwOyBhc3NlcnQg
dGNwaV9zbmRfY3duZCA9PSBjd25kLCB0Y3BpX3NuZF9jd25kIH0lCgogICsuMSA8IC4gIDE6MSgw
KSBhY2sgMzQyMDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDM0NDAwMSB3aW4gNTE0
CiAgKy4xIDwgLiAgMToxKDApIGFjayAzNDYwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBh
Y2sgMzQ4MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDM1MDAwMSB3aW4gNTE0CiAg
Ky4xIDwgLiAgMToxKDApIGFjayAzNTIwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sg
MzU0MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDM1NjAwMSB3aW4gNTE0CiAgKy4x
IDwgLiAgMToxKDApIGFjayAzNTgwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzYw
MDAxIHdpbiA1MTQKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCk7IGN3bmQgKz0gMTA7IGFz
c2VydCB0Y3BpX3NuZF9jd25kID09IGN3bmQsIHRjcGlfc25kX2N3bmQgfSUKCiAgKy4xIDwgLiAg
MToxKDApIGFjayAzNjIwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzY0MDAxIHdp
biA1MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDM2NjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMTox
KDApIGFjayAzNjgwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzcwMDAxIHdpbiA1
MTQKICArLjEgPCAuICAxOjEoMCkgYWNrIDM3MjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDAp
IGFjayAzNzQwMDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzc2MDAxIHdpbiA1MTQK
ICArLjEgPCAuICAxOjEoMCkgYWNrIDM3ODAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFj
ayAzODAwMDEgd2luIDUxNAogICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKTsgY3duZCArPSAx
MDsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gY3duZCwgdGNwaV9zbmRfY3duZCB9JQoKICArLjEg
PCAuICAxOjEoMCkgYWNrIDM4MjAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAzODQw
MDEgd2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzg2MDAxIHdpbiA1MTQKICArLjEgPCAu
ICAxOjEoMCkgYWNrIDM4ODAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAzOTAwMDEg
d2luIDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzkyMDAxIHdpbiA1MTQKICArLjEgPCAuICAx
OjEoMCkgYWNrIDM5NDAwMSB3aW4gNTE0CiAgKy4xIDwgLiAgMToxKDApIGFjayAzOTYwMDEgd2lu
IDUxNAogICsuMSA8IC4gIDE6MSgwKSBhY2sgMzk4MDAxIHdpbiA1MTQKICArLjEgPCAuICAxOjEo
MCkgYWNrIDQwMDAwMSB3aW4gNTE0CiAgICswICV7IHByaW50KHRjcGlfc25kX2N3bmQpOyBjd25k
ICs9IDEwOyBhc3NlcnQgdGNwaV9zbmRfY3duZCA9PSBjd25kLCB0Y3BpX3NuZF9jd25kIH0lCg==

------=_Part_32929_406650583.1736903937402--

