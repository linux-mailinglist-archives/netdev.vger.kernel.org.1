Return-Path: <netdev+bounces-195814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2173AD252B
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9707A405E
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915BF1E3DE8;
	Mon,  9 Jun 2025 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xke9XMiO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8FA174EF0
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749491133; cv=none; b=ZuZr5fvTgDB4HeOn17Y3H+wL0Jdn3wll6GERTcOEfZy4y5rvMQ6g6jeoCgqsTKQRZCiWVxlbe7XayxKPFU4toIaOlUnj5GsOzjJmmLyQEQDLk2NmkH1CQmu18AI3hUjdaWqdMWy6zyHT6V2Mj8n8/2CkiSYpM02sNiuXAajxuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749491133; c=relaxed/simple;
	bh=IQdum0Pw65jk6aO+nV7DhaTTxtnF9+l412oEm7dAG1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAljWGn1ym4i1uUCRECFI+V/JDAMwGcSrGp7dFCzkfK/I+eTUAMTRcOMPbvUeGScnnePTCJU/FUWbEohPx3nGDaDvWVU113QmWAkVmHNnmQbS8pKhWhR1ST9GfPYxyhqIH9mXsGVpVIft4grs7/W6ThxQBT1nSIUPdyZu27NPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xke9XMiO; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a5ac8fae12so50011cf.0
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749491130; x=1750095930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BirudlXHFvTGQVgieOvFHqXFek81s+1J3CQCi3zByQs=;
        b=Xke9XMiOanWUdMjCQ8ThSIK2+ZSRZf8VlKWn9jLpp7ujuUrrdE0skyt2iLYcrEbKu4
         g8WTSrcOYKtIjqDHBcBlqDFC25ZQsodsGnNWW9qhxbOcehxr0bfJlfAdEvZ+FH3KLhi4
         0qzKQuS60/nZGOg/2ZkwgtwcU0BI8yo7aDZv9y3tDDcQJDrMa659XwlD/+5HqMIalbZK
         LEdZSlqvYUUNWpwaxa/I8YP1TZCTZSYvVAZf5NnFH3HdI7qXEhyFR7U6SvWcBqZd5OJt
         ypphwzlO6IfYL/9WFTGT+DRV3t7ZJmd6EGUxq5SMDdk3R6RRJI03pZ/fAsn1SVD0dlFW
         zqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749491130; x=1750095930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BirudlXHFvTGQVgieOvFHqXFek81s+1J3CQCi3zByQs=;
        b=fjdtya22ripXZqSQoGMzxSXTVq7hpdAgrTxaqSSE1qxywlU9AeewPLGp1XVZUQNOCT
         WkYhiUMcaDmRlqvvEtgDMOm9JiapImdbuNm+wbl85MOvpReq6OiYgBUse512oTDE+lyY
         3/Xlp6eeyrEDuwnTT9x2WAyRlEh2FAmHOiLC64KnUvq4NeLbh488WOQEYuh4RBzXPtxT
         2DeUfMxSxVFAHt6GLNiLopdgNc7QQVkCud0hUYKnxGECBeQDJUEdA0OfyR9Drpc+cC6d
         Hoa6S2WB/g11A3mBFXRwPEQNYXjBO/Iqd00U4SPIKlBRRYZAcNE0lbPbL/XMbCH+VXV+
         2LhQ==
X-Gm-Message-State: AOJu0Yzr/fzgWN4gAfmfif+savGyeOgJ01125CaAAJwjlS22XzRUeHgX
	iUfEF8UXOHaWBLWKD+2f8VvH8iy64NPwSumwv0XUyQBp6/jYu1dNQR2mAdFX27oIagInDycHiZI
	d6+RHpCfanTuiuI/9aHXX81UBEP0Ts6JJOuax2VRm
X-Gm-Gg: ASbGncu9Qq+vEhukorOT30/tJ3bdqJTk5qxr9LtoqynWCx3hPfL+MVDepI6WE+/FEm/
	VfUQcpE/yKiMiialTeA2cuR/1VyXFx2LfTEfhANqsp7lHKHsyyrujFTeboz7DCD5NiJle9Dc3q1
	swZbUtZC6T75IecmD/GRfrph5MIyYZA3sodeD6tKhjptWWZ2E9xCeyDIUX+12KGRVV6qEBicmx3
	2em
X-Google-Smtp-Source: AGHT+IH7NFXMKNmSBj6wXOVqMTX0YMznpUOwkN16dMvCAWbj8CLiTHc3j+FB18geJE1ng/bwF7yEZfELn6EwBM2z6rI=
X-Received: by 2002:a05:622a:11c5:b0:4a4:ead0:92c4 with SMTP id
 d75a77b69052e-4a6f06bbd37mr7791871cf.5.1749491129807; Mon, 09 Jun 2025
 10:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64ea9333-e7f9-0df-b0f2-8d566143acab@ewheeler.net>
 <CADVnQykCiDvzqgGU5NO9744V2P+umCdDQjduDWV0-xeLE0ey0Q@mail.gmail.com>
 <d7421eff-7e61-16ec-e1ca-e969b267f44d@ewheeler.net> <CADVnQy=SLM6vyWr5-UGg6TFU+b0g4s=A0h2ujRpphTyuxDYXKA@mail.gmail.com>
 <CADVnQy=kB-B-9rAOgSjBAh+KHx4pkz-VoTnBZ0ye+Fp4hjicPA@mail.gmail.com> <CADVnQyna9cMvJf9Mp5jLR1vryAY1rEbAjZC_ef=Q8HRM4tNFzQ@mail.gmail.com>
In-Reply-To: <CADVnQyna9cMvJf9Mp5jLR1vryAY1rEbAjZC_ef=Q8HRM4tNFzQ@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 9 Jun 2025 13:45:13 -0400
X-Gm-Features: AX0GCFu6gdLRN52v7KiDP4pFT-Vze7IzKfyQmp5UCtMGJpWY8JOqJhV4zycAwmY
Message-ID: <CADVnQyk0bsGJrcA13xEaDmVo_6S94FuK68T0_iiTLyAKoVVPyA@mail.gmail.com>
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
To: Eric Wheeler <netdev@lists.ewheeler.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, stable@kernel.org
Content-Type: multipart/mixed; boundary="000000000000554890063727251c"

--000000000000554890063727251c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 7:26=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Sat, Jun 7, 2025 at 6:54=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
> >
> > On Sat, Jun 7, 2025 at 3:13=E2=80=AFPM Neal Cardwell <ncardwell@google.=
com> wrote:
> > >
> > > On Fri, Jun 6, 2025 at 6:34=E2=80=AFPM Eric Wheeler <netdev@lists.ewh=
eeler.net> wrote:
> > > >
> > > > On Fri, 6 Jun 2025, Neal Cardwell wrote:
> > > > > On Thu, Jun 5, 2025 at 9:33=E2=80=AFPM Eric Wheeler <netdev@lists=
.ewheeler.net> wrote:
> > > > > >
> > > > > > Hello Neal,
> > > > > >
> > > > > > After upgrading to Linux v6.6.85 on an older Supermicro SYS-202=
6T-6RFT+
> > > > > > with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Netgear GS7=
28TXS at
> > > > > > 10GbE via one SFP+ DAC (no bonding), we found TCP performance w=
ith
> > > > > > existing devices on 1Gbit ports was <60Mbit; however, TCP with =
devices
> > > > > > across the switch on 10Gbit ports runs at full 10GbE.
> > > > > >
> > > > > > Interestingly, the problem only presents itself when transmitti=
ng
> > > > > > from Linux; receive traffic (to Linux) performs just fine:
> > > > > >         ~60Mbit: Linux v6.6.85 =3DTX=3D> 10GbE -> switch -> 1Gb=
E  -> device
> > > > > >          ~1Gbit: device        =3DTX=3D>  1GbE -> switch -> 10G=
bE -> Linux v6.6.85
> > > > > >
> > > > > > Through bisection, we found this first-bad commit:
> > > > > >
> > > > > >         tcp: fix to allow timestamp undo if no retransmits were=
 sent
> > > > > >                 upstream:       e37ab7373696e650d3b6262a5b882aa=
dad69bb9e
> > > > > >                 stable 6.6.y:   e676ca60ad2a6fdeb718b5e7a337a8f=
b1591d45f
> > > > > >
> > > > >
> > > > > Thank you for your detailed report and your offer to run some mor=
e tests!
> > > > >
> > > > > I don't have any good theories yet. It is striking that the appar=
ent
> > > > > retransmit rate is more than 100x higher in your "Before Revert" =
case
> > > > > than in your "After Revert" case. It seems like something very od=
d is
> > > > > going on. :-)
> > > >
> > > > good point, I wonder what that might imply...
> > > >
> > > > > If you could re-run tests while gathering more information, and s=
hare
> > > > > that information, that would be very useful.
> > > > >
> > > > > What would be very useful would be the following information, for=
 both
> > > > > (a) Before Revert, and (b) After Revert kernels:
> > > > >
> > > > > # as root, before the test starts, start instrumentation
> > > > > # and leave it running in the background; something like:
> > > > > (while true; do date +%s.%N; ss -tenmoi; sleep 0.050; done) > /tm=
p/ss.txt &
> > > > > nstat -n; (while true; do date +%s.%N; nstat; sleep 0.050; done) =
 >
> > > > > /tmp/nstat.txt &
> > > > > tcpdump -w /tmp/tcpdump.${eth}.pcap -n -s 116 -c 1000000  &
> > > > >
> > > > > # then run the test
> > > > >
> > > > > # then kill the instrumentation loops running in the background:
> > > > > kill %1 %2 %3
> > > >
> > > > Sure, here they are:
> > > >
> > > >         https://www.linuxglobal.com/out/for-neal/
> > >
> > > Hi Eric,
> > >
> > > Many thanks for the traces! These traces clearly show the buggy
> > > behavior. The problem is an interaction between the non-SACK behavior
> > > on these connections (due to the non-Linux "device" not supporting
> > > SACK) and the undo logic. The problem is that, for non-SACK
> > > connections, tcp_is_non_sack_preventing_reopen() holds steady in
> > > CA_Recovery or CA_Loss at the end of a loss recovery episode but
> > > clears tp->retrans_stamp to 0. So that upon the next ACK the "tcp: fi=
x
> > > to allow timestamp undo if no retransmits were sent" sees the
> > > tp->retrans_stamp at 0 and erroneously concludes that no data was
> > > retransmitted, and erroneously performs an undo of the cwnd reduction=
,
> > > restoring cwnd immediately to the value it had before loss recovery.
> > > This causes an immediate build-up of queues and another immediate los=
s
> > > recovery episode. Thus the higher retransmit rate in the buggy
> > > scenario.
> > >
> > > I will work on a packetdrill reproducer, test a fix, and post a patch
> > > for testing. I think the simplest fix would be to have
> > > tcp_packet_delayed(), when tp->retrans_stamp is zero, check for the
> > > (tp->snd_una =3D=3D tp->high_seq && tcp_is_reno(tp)) condition and no=
t
> > > allow tcp_packet_delayed() to return true in that case. That should b=
e
> > > a precise fix for this scenario and does not risk changing behavior
> > > for the much more common case of loss recovery with SACK support.
> >
> > Indeed, I'm able to reproduce this issue with erroneous undo events on
> > non-SACK connections at the end of loss recovery with the attached
> > packetdrill script.
> >
> > When you run that script on a kernel with the "tcp: fix to allow
> > timestamp undo if no retransmits were sent" patch, we see:
> >
> > + nstat shows an erroneous TcpExtTCPFullUndo event
> >
> > + the loss recovery reduces cwnd from the initial 10 to the correct 7
> > (from CUBIC) but then the erroneous undo event restores the pre-loss
> > cwnd of 10 and leads to a final cwnd value of 11
> >
> > I will test a patch with the proposed fix and report back.

And the attached packetdrill script (which "passes" on kernel with
"tcp: fix to allow timestamp undo if no retransmits were sent") shows
that a similar erroneous undo (TcpExtTCPLossUndo in this case) happens
at the end of RTO recovery (CA_Loss) if there is an ACK that makes
snd_una exactly equal high_seq. This is expected, given that both fast
recovery and RTO recovery use tcp_is_non_sack_preventing_reopen().

neal

--000000000000554890063727251c
Content-Type: application/octet-stream; 
	name="frto-real-timeout-nonsack-hold-at-high-seq.pkt"
Content-Disposition: attachment; 
	filename="frto-real-timeout-nonsack-hold-at-high-seq.pkt"
Content-Transfer-Encoding: base64
Content-ID: <f_mbpds1vy0>
X-Attachment-Id: f_mbpds1vy0

Ly8gVGVzdCBGLVJUTyBvbiBhIHJlYWwgdGltZW91dCB3aXRob3V0IFNBQ0suCi8vIElkZW50aWNh
bCB0byBmcnRvLXJlYWwtdGltZW91dC1ub25zYWNrLnBrdAovLyBleGNlcHQgdGhhdCB0aGVyZSBp
cyBhbiBBQ0sgdGhhdCBhZHZhbmNlcyBzbmRfdW5hCi8vIHRvIGV4YWN0bHkgZXF1YWwgaGlnaF9z
ZXEsIHRvIHRlc3QgdGhpcyB0cmlja3kgY2FzZS4KCi8vIFNldCB1cCBjb25maWcuCmAuLi9jb21t
b24vZGVmYXVsdHMuc2hgCgogICAgMCBzb2NrZXQoLi4uLCBTT0NLX1NUUkVBTSwgSVBQUk9UT19U
Q1ApID0gMwogICArMCBzZXRzb2Nrb3B0KDMsIFNPTF9TT0NLRVQsIFNPX1JFVVNFQUREUiwgWzFd
LCA0KSA9IDAKICAgKzAgYmluZCgzLCAuLi4sIC4uLikgPSAwCiAgICswIGxpc3RlbigzLCAxKSA9
IDAKCiAgICswIGBuc3RhdCAtbmAKCiAgICswIDwgUyAwOjAoMCkgd2luIDMyNzkyIDxtc3MgMTAw
MCxub3Asd3NjYWxlIDc+CiAgICswID4gUy4gMDowKDApIGFjayAxIDxtc3MgMTQ2MCxub3Asd3Nj
YWxlIDg+CiArLjAyIDwgLiAxOjEoMCkgYWNrIDEgd2luIDI1NwogICArMCBhY2NlcHQoMywgLi4u
LCAuLi4pID0gNAogICArMCB3cml0ZSg0LCAuLi4sIDE1MDAwKSA9IDE1MDAwCiAgICswID4gUC4g
MToxMDAwMSgxMDAwMCkgYWNrIDEKCi8vIFJUTyBhbmQgcmV0cmFuc21pdCBoZWFkCiArLjIyID4g
LiAxOjEwMDEoMTAwMCkgYWNrIDEKCi8vIEYtUlRPIHByb2JlcwogKy4wMSA8IC4gMToxKDApIGFj
ayAxMDAxIHdpbiAyNTcKICAgKzAgPiBQLiAxMDAwMToxMjAwMSgyMDAwKSBhY2sgMQoKLy8gVGhl
IHByb2JlcyBhcmUgYWNrZWQgc28gdGhlIHRpbWVvdXQgaXMgcmVhbC4KICsuMDUgPCAuIDE6MSgw
KSBhY2sgMTAwMSB3aW4gMjU3CiAgICswID4gLiAxMDAxOjIwMDEoMTAwMCkgYWNrIDEKICAgKzAg
JXsgYXNzZXJ0IHRjcGlfY2Ffc3RhdGUgPT0gVENQX0NBX0xvc3MsIHRjcGlfY2Ffc3RhdGUgfSUK
ICAgKzAgJXsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gMiwgdGNwaV9zbmRfY3duZCB9JQogICAr
MCAleyBhc3NlcnQgdGNwaV9zbmRfc3N0aHJlc2ggPT0gNywgdGNwaV9zbmRfc3N0aHJlc2ggfSUK
Ky4wMDIgPCAuIDE6MSgwKSBhY2sgMTAwMSB3aW4gMjU3CiAgICswID4gLiAyMDAxOjMwMDEoMTAw
MCkgYWNrIDEKCiArLjA1IDwgLiAxOjEoMCkgYWNrIDMwMDEgd2luIDI1NwogICArMCA+IC4gMzAw
MTo0MDAxKDEwMDApIGFjayAxCgogKy4wNSA8IC4gMToxKDApIGFjayA0MDAxIHdpbiAyNTcKICAg
KzAgPiBQLiA0MDAxOjYwMDEoMjAwMCkgYWNrIDEKCiArLjA1IDwgLiAxOjEoMCkgYWNrIDYwMDEg
d2luIDI1NwogICArMCA+IFAuIDYwMDE6MTAwMDEoNDAwMCkgYWNrIDEKCi8vIFJlY2VpdmUgYWNr
IGFuZCBhZHZhbmNlIHNuZF91bmEgdG8gbWF0Y2ggaGlnaF9zZXEuCiArLjA1IDwgLiAxOjEoMCkg
YWNrIDEwMDAxIHdpbiAyNTcKICAgKzAgJXsgYXNzZXJ0IHRjcGlfY2Ffc3RhdGUgPT0gVENQX0NB
X0xvc3MsIHRjcGlfY2Ffc3RhdGUgfSUKICAgKzAgJXsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0g
NywgdGNwaV9zbmRfY3duZCB9JQogICArMCAleyBhc3NlcnQgdGNwaV9zbmRfc3N0aHJlc2ggPT0g
NywgdGNwaV9zbmRfc3N0aHJlc2ggfSUKCi8vIFJlY2VpdmUgYWNrIGFuZCBhZHZhbmNlIHNuZF91
bmEgYmV5b25kIGhpZ2hfc2VxLgogICArMCA8IC4gMToxKDApIGFjayAxMjAwMSB3aW4gMjU3CiAg
ICswID4gUC4gMTIwMDE6MTUwMDEoMzAwMCkgYWNrIDEKICAgKzAgJXsgYXNzZXJ0IHRjcGlfY2Ff
c3RhdGUgPT0gVENQX0NBX0xvc3MsIHRjcGlfY2Ffc3RhdGUgfSUKICAgKzAgJXsgYXNzZXJ0IHRj
cGlfc25kX2N3bmQgPT0gMTIsIHRjcGlfc25kX2N3bmQgfSUKCiArLjA1IDwgLiAxOjEoMCkgYWNr
IDE1MDAxIHdpbiAyNTcKICAgKzAgJXsgYXNzZXJ0IHRjcGlfY2Ffc3RhdGUgPT0gVENQX0NBX09w
ZW4sIHRjcGlfY2Ffc3RhdGUgfSUKICAgKzAgJXsgYXNzZXJ0IHRjcGlfc25kX2N3bmQgPT0gMTUs
IHRjcGlfc25kX2N3bmQgfSUKCiAgICswIGBuc3RhdGAK
--000000000000554890063727251c--

