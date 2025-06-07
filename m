Return-Path: <netdev+bounces-195532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A27AD1070
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 01:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CE9188ECF6
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 23:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3CC2192FA;
	Sat,  7 Jun 2025 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uk4r28pQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3CE21ABBD
	for <netdev@vger.kernel.org>; Sat,  7 Jun 2025 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749338805; cv=none; b=VA2BHUJVfBDUS+IB29Fl8MTbuT7tzR0a09KD/+tRTOOcEWdb7zjBX4v72XJqjLPwUyJ188sq2bT/Z7lf8guJjJkWW2K41N6qn17YMNA3hdWEsY4aDIqff3GVwQRxclTZPYC5ihIG9xaP1VVrulK30+m1FZCEebLbVTpf9yclso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749338805; c=relaxed/simple;
	bh=TWwBFTC8u4yTjNRC4+6jc++9DASoCCEgz8Ctn2z2dbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDOuz3wokJyl6XGKq/4CKq8XDaeWq6a2UFqOAQFiqvf5MhwRekcDso3gpDJrfukIiSqDhouW1q5CgKTU36ML4pItWM2a67JeND8cJTdSSu6ydL79YWi3bVc999tS9MW0PfGGrVshKImDZy7deprUHtbzx4qw7dfMEfD1sqQvPRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uk4r28pQ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a5ac8fae12so332711cf.0
        for <netdev@vger.kernel.org>; Sat, 07 Jun 2025 16:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749338803; x=1749943603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u7tbyib6CZQtOoG5oWNgudUl2/i8n48ZFHnOyVgbmA8=;
        b=uk4r28pQBjeeN/uiS7FpOK1LKfunHaw5RIxostBmP2PklXWXyZ51qgkTJFR8Ztfoxt
         TereWdmaAfysjhkcfXjXx1sPb0OzfZ55tywfJ6qKC+h7O2CSrU9V+KDge3r8cXnBo+SO
         N20Z+AottyAJEAQlkFoVRZH7ME5TDHSyCng9yJr5bduf9ZjaGhnyo/eDh1x7XhDXAeP0
         1YuCR9lco9fdKBTPelJzQb7Z6aBJChrqvMdAy4uowT1HBmhkTNxTHaGROuRYeHH1yCTX
         MdNfBKRUIvQQsNRwjw9INHttO0SFwoal+ZaeoK31qS+0IdYfKYU0HC+3Lh24YrmDsn2b
         i0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749338803; x=1749943603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7tbyib6CZQtOoG5oWNgudUl2/i8n48ZFHnOyVgbmA8=;
        b=m/N1LLmZ7XNDV2feYtKUoY32lr1xikjA8F09avkyEqApAmlr6xCK1b50uaRQ+nujHu
         KnrPubl2zBsJNgcwdSYNE+5xwVtlvs48VrBC/gYbe+sPrb18pN6RDjHXaAV19PbL0Cct
         dIFRSIvbYFF3Dwhof0D5Rj40CaPcJZtgez5thOsXRwB5qA4K3cK/JwWRKNCiTTe+1VQt
         ivdVmnKfWRWZ0yxS5o+hDeHLZFRGAMRHkWG2+DqUZYzZ212+modgx8d3raHAIZeOTmNk
         FqxXs2hzm2zGrsQRfo+SHAPd//sSdSXanJ4g73Opy+UJRAtml4t4XMTaVb75bTMYrm/g
         VcPg==
X-Gm-Message-State: AOJu0YyFFm6eZXW4OXzdLHCfPX/biXzg1dr9fkMqIdTzs3o1Zp6P8Kpw
	f9nEI0VSGgQcCU2VyFLzJINZHAjz2XW/ZA4hlEre3C7kmj4qXOsc9jTNGMLiGOmjLMFSLtdezHc
	PQNrgi9pAKdIttkjRNXjd/MsR8IF0vdXnbr3Tam83
X-Gm-Gg: ASbGncvz4wrfAUm9DXPJh7cHCdFLm27j049uyn3GUdPK/AEUEigO7e8ZYdzs5VBD9To
	imA+8eZ9dmNIhyyMXfe5rxy8nctocKvcxZaRc2m2396fTzMjLgMS9rVS0eVYnfK4GlI+34xRugu
	Pg7retEyOfvfDmC0yKQFNvmbZ8m/IuuoPOoc2V9yLwnqy45TYEqdF3vWw7cdjM1ElBd7SKUKtBA
	eTd
X-Google-Smtp-Source: AGHT+IFic17hA6ooelgZOTWeixWOevdVa9gbqk11H5lAG5HRNNGSzW8eHZDFGcLqRKyaGceCEKRC2tYmAoHF0TTLklY=
X-Received: by 2002:a05:622a:348:b0:498:e884:7ca9 with SMTP id
 d75a77b69052e-4a6f0717bcdmr2499771cf.13.1749338802726; Sat, 07 Jun 2025
 16:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64ea9333-e7f9-0df-b0f2-8d566143acab@ewheeler.net>
 <CADVnQykCiDvzqgGU5NO9744V2P+umCdDQjduDWV0-xeLE0ey0Q@mail.gmail.com>
 <d7421eff-7e61-16ec-e1ca-e969b267f44d@ewheeler.net> <CADVnQy=SLM6vyWr5-UGg6TFU+b0g4s=A0h2ujRpphTyuxDYXKA@mail.gmail.com>
 <CADVnQy=kB-B-9rAOgSjBAh+KHx4pkz-VoTnBZ0ye+Fp4hjicPA@mail.gmail.com>
In-Reply-To: <CADVnQy=kB-B-9rAOgSjBAh+KHx4pkz-VoTnBZ0ye+Fp4hjicPA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 7 Jun 2025 19:26:26 -0400
X-Gm-Features: AX0GCFtz0gqq7D2jXs_5MolnWFbwdVVv7F-Zsn7GuT8mx0vBV1aJ2u98Jng368s
Message-ID: <CADVnQyna9cMvJf9Mp5jLR1vryAY1rEbAjZC_ef=Q8HRM4tNFzQ@mail.gmail.com>
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
To: Eric Wheeler <netdev@lists.ewheeler.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, stable@kernel.org
Content-Type: multipart/mixed; boundary="000000000000ee6ed6063703ad85"

--000000000000ee6ed6063703ad85
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 6:54=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Sat, Jun 7, 2025 at 3:13=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
> >
> > On Fri, Jun 6, 2025 at 6:34=E2=80=AFPM Eric Wheeler <netdev@lists.ewhee=
ler.net> wrote:
> > >
> > > On Fri, 6 Jun 2025, Neal Cardwell wrote:
> > > > On Thu, Jun 5, 2025 at 9:33=E2=80=AFPM Eric Wheeler <netdev@lists.e=
wheeler.net> wrote:
> > > > >
> > > > > Hello Neal,
> > > > >
> > > > > After upgrading to Linux v6.6.85 on an older Supermicro SYS-2026T=
-6RFT+
> > > > > with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Netgear GS728=
TXS at
> > > > > 10GbE via one SFP+ DAC (no bonding), we found TCP performance wit=
h
> > > > > existing devices on 1Gbit ports was <60Mbit; however, TCP with de=
vices
> > > > > across the switch on 10Gbit ports runs at full 10GbE.
> > > > >
> > > > > Interestingly, the problem only presents itself when transmitting
> > > > > from Linux; receive traffic (to Linux) performs just fine:
> > > > >         ~60Mbit: Linux v6.6.85 =3DTX=3D> 10GbE -> switch -> 1GbE =
 -> device
> > > > >          ~1Gbit: device        =3DTX=3D>  1GbE -> switch -> 10GbE=
 -> Linux v6.6.85
> > > > >
> > > > > Through bisection, we found this first-bad commit:
> > > > >
> > > > >         tcp: fix to allow timestamp undo if no retransmits were s=
ent
> > > > >                 upstream:       e37ab7373696e650d3b6262a5b882aada=
d69bb9e
> > > > >                 stable 6.6.y:   e676ca60ad2a6fdeb718b5e7a337a8fb1=
591d45f
> > > > >
> > > >
> > > > Thank you for your detailed report and your offer to run some more =
tests!
> > > >
> > > > I don't have any good theories yet. It is striking that the apparen=
t
> > > > retransmit rate is more than 100x higher in your "Before Revert" ca=
se
> > > > than in your "After Revert" case. It seems like something very odd =
is
> > > > going on. :-)
> > >
> > > good point, I wonder what that might imply...
> > >
> > > > If you could re-run tests while gathering more information, and sha=
re
> > > > that information, that would be very useful.
> > > >
> > > > What would be very useful would be the following information, for b=
oth
> > > > (a) Before Revert, and (b) After Revert kernels:
> > > >
> > > > # as root, before the test starts, start instrumentation
> > > > # and leave it running in the background; something like:
> > > > (while true; do date +%s.%N; ss -tenmoi; sleep 0.050; done) > /tmp/=
ss.txt &
> > > > nstat -n; (while true; do date +%s.%N; nstat; sleep 0.050; done)  >
> > > > /tmp/nstat.txt &
> > > > tcpdump -w /tmp/tcpdump.${eth}.pcap -n -s 116 -c 1000000  &
> > > >
> > > > # then run the test
> > > >
> > > > # then kill the instrumentation loops running in the background:
> > > > kill %1 %2 %3
> > >
> > > Sure, here they are:
> > >
> > >         https://www.linuxglobal.com/out/for-neal/
> >
> > Hi Eric,
> >
> > Many thanks for the traces! These traces clearly show the buggy
> > behavior. The problem is an interaction between the non-SACK behavior
> > on these connections (due to the non-Linux "device" not supporting
> > SACK) and the undo logic. The problem is that, for non-SACK
> > connections, tcp_is_non_sack_preventing_reopen() holds steady in
> > CA_Recovery or CA_Loss at the end of a loss recovery episode but
> > clears tp->retrans_stamp to 0. So that upon the next ACK the "tcp: fix
> > to allow timestamp undo if no retransmits were sent" sees the
> > tp->retrans_stamp at 0 and erroneously concludes that no data was
> > retransmitted, and erroneously performs an undo of the cwnd reduction,
> > restoring cwnd immediately to the value it had before loss recovery.
> > This causes an immediate build-up of queues and another immediate loss
> > recovery episode. Thus the higher retransmit rate in the buggy
> > scenario.
> >
> > I will work on a packetdrill reproducer, test a fix, and post a patch
> > for testing. I think the simplest fix would be to have
> > tcp_packet_delayed(), when tp->retrans_stamp is zero, check for the
> > (tp->snd_una =3D=3D tp->high_seq && tcp_is_reno(tp)) condition and not
> > allow tcp_packet_delayed() to return true in that case. That should be
> > a precise fix for this scenario and does not risk changing behavior
> > for the much more common case of loss recovery with SACK support.
>
> Indeed, I'm able to reproduce this issue with erroneous undo events on
> non-SACK connections at the end of loss recovery with the attached
> packetdrill script.
>
> When you run that script on a kernel with the "tcp: fix to allow
> timestamp undo if no retransmits were sent" patch, we see:
>
> + nstat shows an erroneous TcpExtTCPFullUndo event
>
> + the loss recovery reduces cwnd from the initial 10 to the correct 7
> (from CUBIC) but then the erroneous undo event restores the pre-loss
> cwnd of 10 and leads to a final cwnd value of 11
>
> I will test a patch with the proposed fix and report back.

Oops, forgot to attach the packetdrill script! Let's try again...

neal

--000000000000ee6ed6063703ad85
Content-Type: application/octet-stream; 
	name="fr-non-sack-hold-at-high-seq.pkt"
Content-Disposition: attachment; filename="fr-non-sack-hold-at-high-seq.pkt"
Content-Transfer-Encoding: base64
Content-ID: <f_mbmv4qkx0>
X-Attachment-Id: f_mbmv4qkx0

Ly8gVGVzdCB0aGF0IGluIG5vbi1TQUNLIGZhc3QgcmVjb3ZlcnksIHdlIHN0YXkgaW4gQ0FfUmVj
b3Zlcnkgd2hlbgovLyBzbmRfdW5hID09IGhpZ2hfc2VxLCBhbmQgY29ycmVjdGx5IGxlYXZlIHdo
ZW4gc25kX3VuYSA+IGhpZ2hfc2VxLgovLyBBbmQgdGhhdCB0aGlzIGRvZXMgbm90IGNhdXNlIGEg
c3B1cmlvdXMgdW5kby4KCi8vIFNldCB1cCBjb25maWcuCmAuLi9jb21tb24vZGVmYXVsdHMuc2hg
CgovLyBFc3RhYmxpc2ggYSBjb25uZWN0aW9uLgogICAgMCBzb2NrZXQoLi4uLCBTT0NLX1NUUkVB
TSwgSVBQUk9UT19UQ1ApID0gMwogICArMCBzZXRzb2Nrb3B0KDMsIFNPTF9TT0NLRVQsIFNPX1JF
VVNFQUREUiwgWzFdLCA0KSA9IDAKICAgKzAgYmluZCgzLCAuLi4sIC4uLikgPSAwCiAgICswIGxp
c3RlbigzLCAxKSA9IDAKCiAgKzAgYG5zdGF0IC1uYAoKICAgKzAgPCBTIDA6MCgwKSB3aW4gMzI3
OTIgPG1zcyAxMDAwLG5vcCx3c2NhbGUgNz4KICAgKzAgPiBTLiAwOjAoMCkgYWNrIDEgPG1zcyAx
NDYwLG5vcCx3c2NhbGUgOD4KKy4wMjAgPCAuIDE6MSgwKSBhY2sgMSB3aW4gMzIwCiAgICswIGFj
Y2VwdCgzLCAuLi4sIC4uLikgPSA0CgovLyBXcml0ZSBzb21lIGRhdGEsIGFuZCBzZW5kIHRoZSBp
bml0aWFsIGNvbmdlc3Rpb24gd2luZG93LgogICArMCB3cml0ZSg0LCAuLi4sIDE1MDAwKSA9IDE1
MDAwCiAgICswID4gUC4gMToxMDAwMSgxMDAwMCkgYWNrIDEKCi8vIExpbWl0ZWQgdHJhbnNtaXQ6
IG9uIGZpcnN0IGR1cGFjayAoZm9yIHBrdCAyKSwgc2VuZCBhIG5ldyBkYXRhIHNlZ21lbnQuCisu
MDIwIDwgLiAxOjEoMCkgYWNrIDEgd2luIDMyMAogICArMCA+IC4gMTAwMDE6MTEwMDEoMTAwMCkg
YWNrIDEKICArMCAleyBwcmludCh0Y3BpX3NuZF9jd25kKSB9JQogICswICV7IHByaW50KHRjcGlf
c2Fja2VkKSB9JQoKLy8gTGltaXRlZCB0cmFuc21pdDogb24gc2Vjb25kIGR1cGFjayAoZm9yIHBr
dCAzKSwgc2VuZCBhIG5ldyBkYXRhIHNlZ21lbnQuCisuMDAyIDwgLiAxOjEoMCkgYWNrIDEgd2lu
IDMyMAogICArMCA+IC4gMTEwMDE6MTIwMDEoMTAwMCkgYWNrIDEKICArMCAleyBhc3NlcnQgdGNw
aV9zbmRfY3duZCA9PSAxMCwgIHRjcGlfc25kX2N3bmQgfSUKICArMCAleyBwcmludCh0Y3BpX3Nh
Y2tlZCkgfSUKCgovLyBPbiB0aGlyZCBkdXBhY2sgKGZvciBwa3QgNCksIGVudGVyIGZhc3QgcmVj
b3ZlcnkuCiAgICswIDwgLiAxOjEoMCkgYWNrIDEgd2luIDMyMAogICArMCA+IC4gMToxMDAxKDEw
MDApIGFjayAxCiAgICswICV7IGFzc2VydCB0Y3BpX2NhX3N0YXRlID09IFRDUF9DQV9SZWNvdmVy
eSwgdGNwaV9jYV9zdGF0ZSB9JQoKLy8gUmVjZWl2ZSBkdXBhY2sgZm9yIHBrdCA1OgorLjAwMiA8
IC4gMToxKDApIGFjayAxIHdpbiAzMjAKCi8vIFJlY2VpdmUgZHVwYWNrIGZvciBwa3QgNjoKKy4w
MDIgPCAuIDE6MSgwKSBhY2sgMSB3aW4gMzIwCgovLyBSZWNlaXZlIGR1cGFjayBmb3IgcGt0IDc6
CisuMDAyIDwgLiAxOjEoMCkgYWNrIDEgd2luIDMyMAoKLy8gUmVjZWl2ZSBkdXBhY2sgZm9yIHBr
dCA4OgorLjAwMiA8IC4gMToxKDApIGFjayAxIHdpbiAzMjAKCi8vIFJlY2VpdmUgZHVwYWNrIGZv
ciBwa3QgOToKKy4wMDIgPCAuIDE6MSgwKSBhY2sgMSB3aW4gMzIwCgovLyBSZWNlaXZlIGR1cGFj
ayBmb3IgcGt0IDEwOgorLjAwMiA8IC4gMToxKDApIGFjayAxIHdpbiAzMjAKCi8vIFJlY2VpdmUg
ZHVwYWNrIGZvciBsaW1pdGVkIHRyYW5zbWl0IG9mIHBrdCAxMToKKy4wMDIgPCAuIDE6MSgwKSBh
Y2sgMSB3aW4gMzIwCgovLyBSZWNlaXZlIGR1cGFjayBmb3IgbGltaXRlZCB0cmFuc21pdCBvZiBw
a3QgMTI6CisuMDAyIDwgLiAxOjEoMCkgYWNrIDEgd2luIDMyMAoKLy8gUmVjZWl2ZSBjdW11bGF0
aXZlIEFDSyBmb3IgZmFzdCByZXRyYW5zbWl0IHRoYXQgcGx1Z2dlZCB0aGUgc2VxdWVuY2UgaG9s
ZS4KLy8gQmVjYXVzZSB0aGlzIGlzIGEgbm9uLVNBQ0sgY29ubmVjdGlvbiBhbmQgc25kX3VuYSA9
PSBoaWdoX3NlcSwKLy8gd2Ugc3RheSBpbiBDQV9SZWNvdmVyeS4KKy4wMjAgPCAuIDE6MSgwKSBh
Y2sgMTIwMDEgd2luIDMyMAogICArMCAleyBhc3NlcnQgdGNwaV9jYV9zdGF0ZSA9PSBUQ1BfQ0Ff
UmVjb3ZlcnksIHRjcGlfY2Ffc3RhdGUgfSUKICAgKzAgJXsgcHJpbnQodGNwaV9zbmRfY3duZCkg
fSUKCi8vIFJlY2VpdmUgQUNLIGFkdmFuY2luZyBzbmRfdW5hIHBhc3QgaGlnaF9zZXEKKy4wMDIg
PCAuIDE6MSgwKSBhY2sgMTMwMDEgd2luIDMyMAogICArMCAleyBhc3NlcnQgdGNwaV9jYV9zdGF0
ZSA9PSBUQ1BfQ0FfT3BlbiwgdGNwaV9jYV9zdGF0ZSB9JQogICArMCAleyBwcmludCh0Y3BpX3Nu
ZF9jd25kKSB9JQogICArMCBgbnN0YXRgCg==
--000000000000ee6ed6063703ad85--

