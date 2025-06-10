Return-Path: <netdev+bounces-196249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06740AD4046
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9C11797AE
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB7424466E;
	Tue, 10 Jun 2025 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNT4WAQG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608424468A
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575745; cv=none; b=SbvAP0BEKy80P0Z7gb4H08zk7K5X6Md6v7YvAaJpiaEq5iuvougC0zHsbZ/TMS9HqOW082E+2F/mQdy5HbXkRbTG+cXdOTJ3P3TzQ4qtJXNNiNL4+sqbYEYGGghyra8fDHXIpPbf6wVx+9CxOHEI7pXhazgx0J84GqSYhWnWzzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575745; c=relaxed/simple;
	bh=mUmUDl3je1dnEc5ihiVf0iufivI4sPd4zu9zdD0Zug4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHOD+aTPA9UzVnB3hZ9GXipudaqc9QfUVorePRcFQGBiq/q1+W9jLgJWpEEJqDtUUpzPJ8UIzDmxuoecmW40w56xdUhnrYbmiDKhCLYPgqLyqjIwaD5ooN9CC3+X5JjJdbPg4lXs0DRe7Ou6O2v4TFmEC26sR7rNRBzm7QDXYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNT4WAQG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a5ac8fae12so31211cf.0
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749575743; x=1750180543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wb++WhyR9CFpIKYX7kxtYIOpbnq0jwB8FKYegpI7yOY=;
        b=WNT4WAQGBx/G979OkDroso73lHsAPF91rE6ki+fkEPUZG2SM0GzTKxnNvpoQFw6JB5
         v1tFAPEyM1x7SjkydIhP+rznREMlrhPzK68XlfRrJT4TcixP5Cxe7EVQdsfrKO3Kw9OR
         oohqjDAXLmPXzepddgP1ttZz4zpIte2i4PmbG3l4SCibaIc7n6UPsGtEC/4eql+/VZQN
         P9JQl3qDypVF8aeEiE5Wuv7fwTzl/D9UWn9ofiTTVuxf3sNYGnH0bdW8fwJHlfA3MRaE
         4olD31NmJfSiN9uEV8N+/I7OlirQ/J4I+uNS1nbQcU1G3k9I8MubdaBUwySmZMTe1Oxe
         OXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749575743; x=1750180543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wb++WhyR9CFpIKYX7kxtYIOpbnq0jwB8FKYegpI7yOY=;
        b=HwfIZTgi8wr+qVupof+dA/7ZoKE/l+zx87PEOoSOkHGh9cqJmd1qi5f/HHWPrI38rP
         axFJITnfYWf9rBGf+FgAijMmu2cK28MMgGwPb/HqQVvBjuGOJs5OObOII3tZrHCB6bmi
         HvbZw7r7TyQPhVOwhi6G5cripHJ5R+vANI3BgqbpdVNr/PLjx9+tPpjox4LGPfS/XBJj
         cm29XsWWIFO40/ZefNP9rstJqaChnZKuRnBbz0Wd92IHInuFXk0//3keOsrNTojO97q6
         TqZ7layrp8QIExgYPg1HfXSxlsenzRC6I2zz1jr9+grMygBcbSJ0WLSc/aH/yeqZ3lha
         SLbw==
X-Gm-Message-State: AOJu0YxdU9l2AjWdgz4o31pkPYBK/VtUczltNV1LpNAaVbKSHId5DS1i
	bm0JgGAa0mW1pYOs+RqE30v8y7dxExxfkNeSeFM5kSeemG3x3XO798y+rXIo8kblqGBxUW7WO1L
	fbbB2pVgXHnitaDepH2zyflLgolQtatfAjog+2pGn
X-Gm-Gg: ASbGncsay2lWJJe6AJMRX8fczESD6iSODmtQANULhLgmYh8ARRFr8lSxXud8hX51iJf
	9Slsa2bKSy6j1pQD+oyPVZE0IVFjhIlzNHgoRKi1ISEQSG5jamWfUcWCAIdMy64aRQMps8IpftP
	5GyAybt1C5z7jr1trL5OsI3PSZeJdzo45RngNglOq2U2QL9lsPNepLNVl4bMNMfZKBTsXsEUVVP
	faQ
X-Google-Smtp-Source: AGHT+IGCdrK/tXR/mRs4os9YIDSASSehkLUVd/860DkkUZ+X64VME47DwptyaPHwPyFRChClhcK+X7U7nvuIiFyLxRM=
X-Received: by 2002:ac8:6682:0:b0:4a6:f68e:900 with SMTP id
 d75a77b69052e-4a713b19ec1mr234731cf.25.1749575742605; Tue, 10 Jun 2025
 10:15:42 -0700 (PDT)
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
 <CADVnQyna9cMvJf9Mp5jLR1vryAY1rEbAjZC_ef=Q8HRM4tNFzQ@mail.gmail.com> <CADVnQyk0bsGJrcA13xEaDmVo_6S94FuK68T0_iiTLyAKoVVPyA@mail.gmail.com>
In-Reply-To: <CADVnQyk0bsGJrcA13xEaDmVo_6S94FuK68T0_iiTLyAKoVVPyA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 10 Jun 2025 13:15:24 -0400
X-Gm-Features: AX0GCFtjAiWOSwLArykMacPpE6B0yCMJFZrKOtrhRQ5v_XuZIFXomJy5CAZJjyI
Message-ID: <CADVnQyktk+XpvLuc6jZa5CpqoGyjzzzYJ5iJk3=Eh5JAGyNyVQ@mail.gmail.com>
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
To: Eric Wheeler <netdev@lists.ewheeler.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, stable@kernel.org
Content-Type: multipart/mixed; boundary="000000000000a5d12506373ad8b4"

--000000000000a5d12506373ad8b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 1:45=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Sat, Jun 7, 2025 at 7:26=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
> >
> > On Sat, Jun 7, 2025 at 6:54=E2=80=AFPM Neal Cardwell <ncardwell@google.=
com> wrote:
> > >
> > > On Sat, Jun 7, 2025 at 3:13=E2=80=AFPM Neal Cardwell <ncardwell@googl=
e.com> wrote:
> > > >
> > > > On Fri, Jun 6, 2025 at 6:34=E2=80=AFPM Eric Wheeler <netdev@lists.e=
wheeler.net> wrote:
> > > > >
> > > > > On Fri, 6 Jun 2025, Neal Cardwell wrote:
> > > > > > On Thu, Jun 5, 2025 at 9:33=E2=80=AFPM Eric Wheeler <netdev@lis=
ts.ewheeler.net> wrote:
> > > > > > >
> > > > > > > Hello Neal,
> > > > > > >
> > > > > > > After upgrading to Linux v6.6.85 on an older Supermicro SYS-2=
026T-6RFT+
> > > > > > > with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Netgear G=
S728TXS at
> > > > > > > 10GbE via one SFP+ DAC (no bonding), we found TCP performance=
 with
> > > > > > > existing devices on 1Gbit ports was <60Mbit; however, TCP wit=
h devices
> > > > > > > across the switch on 10Gbit ports runs at full 10GbE.
> > > > > > >
> > > > > > > Interestingly, the problem only presents itself when transmit=
ting
> > > > > > > from Linux; receive traffic (to Linux) performs just fine:
> > > > > > >         ~60Mbit: Linux v6.6.85 =3DTX=3D> 10GbE -> switch -> 1=
GbE  -> device
> > > > > > >          ~1Gbit: device        =3DTX=3D>  1GbE -> switch -> 1=
0GbE -> Linux v6.6.85
> > > > > > >
> > > > > > > Through bisection, we found this first-bad commit:
> > > > > > >
> > > > > > >         tcp: fix to allow timestamp undo if no retransmits we=
re sent
> > > > > > >                 upstream:       e37ab7373696e650d3b6262a5b882=
aadad69bb9e
> > > > > > >                 stable 6.6.y:   e676ca60ad2a6fdeb718b5e7a337a=
8fb1591d45f

Hi Eric,

Do you have cycles to test a proposed fix patch developed by our team?

The attached patch should apply (with "git am") for any recent kernel
that has the "tcp: fix to allow timestamp undo if no retransmits were
sent" patch it is fixing. So you should be able to test it on top of
the 6.6 stable or 6.15 stable kernels you used earlier. Whichever is
easier.

If you have cycles to rerun your iperf test, with  tcpdump, nstat, and
ss instrumentation, that would be fantastic!

The patch passes our internal packetdrill test suite, including new
tests for this issue (based on the packetdrill scripts posted earlier
in this thread.

But it would be fantastic to directly confirm that this fixes your issue.

Thanks!
neal

--000000000000a5d12506373ad8b4
Content-Type: application/octet-stream; 
	name="0001-tcp-fix-tcp_packet_delayed-for-tcp_is_non_sack_preve.patch"
Content-Disposition: attachment; 
	filename="0001-tcp-fix-tcp_packet_delayed-for-tcp_is_non_sack_preve.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mbqrzqoe0>
X-Attachment-Id: f_mbqrzqoe0

RnJvbSAzY2MzZWZjYzA1MWIyN2NlZDQxMmM3ZDAyZTc3ODRkYTg4MTA3NTFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xlLmNvbT4K
RGF0ZTogU2F0LCA3IEp1biAyMDI1IDIzOjA4OjI2ICswMDAwClN1YmplY3Q6IFtQQVRDSF0gdGNw
OiBmaXggdGNwX3BhY2tldF9kZWxheWVkKCkgZm9yCiB0Y3BfaXNfbm9uX3NhY2tfcHJldmVudGlu
Z19yZW9wZW4oKSBiZWhhdmlvcgoKQWZ0ZXIgdGhlIGZvbGxvd2luZyBjb21taXQgZnJvbSAyMDI0
OgoKY29tbWl0IGUzN2FiNzM3MzY5NiAoInRjcDogZml4IHRvIGFsbG93IHRpbWVzdGFtcCB1bmRv
IGlmIG5vIHJldHJhbnNtaXRzIHdlcmUgc2VudCIpCgouLi50aGVyZSB3YXMgYnVnZ3kgYmVoYXZp
b3Igd2hlcmUgVENQIGNvbm5lY3Rpb25zIHdpdGhvdXQgU0FDSyBzdXBwb3J0CmNvdWxkIGVhc2ls
eSBzZWUgZXJyb25lb3VzIHVuZG8gZXZlbnRzIGF0IHRoZSBlbmQgb2YgZmFzdCByZWNvdmVyeSBv
cgpSVE8gcmVjb3ZlcnkgZXBpc29kZXMuIFRoZSBlcnJvbmVvdXMgdW5kbyBldmVudHMgY291bGQg
Y2F1c2UgdGhvc2UKY29ubmVjdGlvbnMgdG8gYmUgc3VmZmVyIHJlcGVhdGVkIGxvc3MgcmVjb3Zl
cnkgZXBpc29kZXMgYW5kIGhpZ2gKcmV0cmFuc21pdCByYXRlcy4KClRoZSBwcm9ibGVtIHdhcyBh
biBpbnRlcmFjdGlvbiBiZXR3ZWVuIHRoZSBub24tU0FDSyBiZWhhdmlvciBvbiB0aGVzZQpjb25u
ZWN0aW9ucyBhbmQgdGhlIHVuZG8gbG9naWMuIFRoZSBwcm9ibGVtIGlzIHRoYXQsIGZvciBub24t
U0FDSwpjb25uZWN0aW9ucyBhdCB0aGUgZW5kIG9mIGEgbG9zcyByZWNvdmVyeSBlcGlzb2RlLCBp
ZiBzbmRfdW5hID09CmhpZ2hfc2VxLCB0aGVuIHRjcF9pc19ub25fc2Fja19wcmV2ZW50aW5nX3Jl
b3BlbigpIGhvbGRzIHN0ZWFkeSBpbgpDQV9SZWNvdmVyeSBvciBDQV9Mb3NzLCBidXQgY2xlYXJz
IHRwLT5yZXRyYW5zX3N0YW1wIHRvIDAuIFRoZW4gdXBvbgp0aGUgbmV4dCBBQ0sgdGhlICJ0Y3A6
IGZpeCB0byBhbGxvdyB0aW1lc3RhbXAgdW5kbyBpZiBubyByZXRyYW5zbWl0cwp3ZXJlIHNlbnQi
IGxvZ2ljIHNhdyB0aGUgdHAtPnJldHJhbnNfc3RhbXAgYXQgMCBhbmQgZXJyb25lb3VzbHkKY29u
Y2x1ZGVkIHRoYXQgbm8gZGF0YSB3YXMgcmV0cmFuc21pdHRlZCwgYW5kIGVycm9uZW91c2x5IHBl
cmZvcm1lZCBhbgp1bmRvIG9mIHRoZSBjd25kIHJlZHVjdGlvbiwgcmVzdG9yaW5nIGN3bmQgaW1t
ZWRpYXRlbHkgdG8gdGhlIHZhbHVlIGl0CmhhZCBiZWZvcmUgbG9zcyByZWNvdmVyeS4gIFRoaXMg
Y2F1c2VkIGFuIGltbWVkaWF0ZSBidXJzdCBvZiB0cmFmZmljCmFuZCBidWlsZC11cCBvZiBxdWV1
ZXMgYW5kIGxpa2VseSBhbm90aGVyIGltbWVkaWF0ZSBsb3NzIHJlY292ZXJ5CmVwaXNvZGUuCgpU
aGlzIGNvbW1pdCBmaXhlcyB0Y3BfcGFja2V0X2RlbGF5ZWQoKSB0byBpZ25vcmUgemVybyByZXRy
YW5zX3N0YW1wCnZhbHVlcyBmb3Igbm9uLVNBQ0sgY29ubmVjdGlvbnMgd2hlbiBzbmRfdW5hIGlz
IGF0IG9yIGFib3ZlIGhpZ2hfc2VxLApiZWNhdXNlIHRjcF9pc19ub25fc2Fja19wcmV2ZW50aW5n
X3Jlb3BlbigpIGNsZWFycyByZXRyYW5zX3N0YW1wIGluCnRoaXMgY2FzZSwgc28gaXQncyBub3Qg
YSB2YWxpZCBzaWduYWwgdGhhdCB3ZSBjYW4gdW5kby4KCk5vdGUgdGhhdCB0aGUgY29tbWl0IG5h
bWVkIGluIHRoZSBGaXhlcyBmb290ZXIgcmVzdG9yZWQgbG9uZy1wcmVzZW50CmJlaGF2aW9yIGZy
b20gcm91Z2hseSAyMDA1LTIwMTksIHNvIGFwcGFyZW50bHkgdGhpcyBidWcgd2FzIHByZXNlbnQK
Zm9yIGEgd2hpbGUgZHVyaW5nIHRoYXQgZXJhLCBhbmQgdGhpcyB3YXMgc2ltcGx5IG5vdCBjYXVn
aHQuCgpGaXhlczogZTM3YWI3MzczNjk2ICgidGNwOiBmaXggdG8gYWxsb3cgdGltZXN0YW1wIHVu
ZG8gaWYgbm8gcmV0cmFuc21pdHMgd2VyZSBzZW50IikKUmVwb3J0ZWQtYnk6IEVyaWMgV2hlZWxl
ciA8bmV0ZGV2QGxpc3RzLmV3aGVlbGVyLm5ldD4KQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9uZXRkZXYvNjRlYTkzMzMtZTdmOS0wZGYtYjBmMi04ZDU2NjE0M2FjYWJAZXdoZWVsZXIu
bmV0LwpTaWduZWQtb2ZmLWJ5OiBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xlLmNvbT4K
Q28tZGV2ZWxvcGVkLWJ5OiBZdWNodW5nIENoZW5nIDx5Y2hlbmdAZ29vZ2xlLmNvbT4KU2lnbmVk
LW9mZi1ieTogWXVjaHVuZyBDaGVuZyA8eWNoZW5nQGdvb2dsZS5jb20+Ci0tLQogbmV0L2lwdjQv
dGNwX2lucHV0LmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvbmV0L2lwdjQvdGNwX2lucHV0LmMgYi9uZXQvaXB2NC90Y3BfaW5wdXQuYwppbmRleCBh
MzUwMThlMmQwYmEyLi41NWU4NjI3NWM4MjNkIDEwMDY0NAotLS0gYS9uZXQvaXB2NC90Y3BfaW5w
dXQuYworKysgYi9uZXQvaXB2NC90Y3BfaW5wdXQuYwpAQCAtMjQ4NCwyMCArMjQ4NCwzMyBAQCBz
dGF0aWMgaW5saW5lIGJvb2wgdGNwX3BhY2tldF9kZWxheWVkKGNvbnN0IHN0cnVjdCB0Y3Bfc29j
ayAqdHApCiB7CiAJY29uc3Qgc3RydWN0IHNvY2sgKnNrID0gKGNvbnN0IHN0cnVjdCBzb2NrICop
dHA7CiAKLQlpZiAodHAtPnJldHJhbnNfc3RhbXAgJiYKLQkgICAgdGNwX3Rzb3B0X2Vjcl9iZWZv
cmUodHAsIHRwLT5yZXRyYW5zX3N0YW1wKSkKLQkJcmV0dXJuIHRydWU7ICAvKiBnb3QgZWNob2Vk
IFRTIGJlZm9yZSBmaXJzdCByZXRyYW5zbWlzc2lvbiAqLwotCi0JLyogQ2hlY2sgaWYgbm90aGlu
ZyB3YXMgcmV0cmFuc21pdHRlZCAocmV0cmFuc19zdGFtcD09MCksIHdoaWNoIG1heQotCSAqIGhh
cHBlbiBpbiBmYXN0IHJlY292ZXJ5IGR1ZSB0byBUU1EuIEJ1dCB3ZSBpZ25vcmUgemVybyByZXRy
YW5zX3N0YW1wCi0JICogaW4gVENQX1NZTl9TRU5ULCBzaW5jZSB3aGVuIHdlIHNldCBGTEFHX1NZ
Tl9BQ0tFRCB3ZSBhbHNvIGNsZWFyCi0JICogcmV0cmFuc19zdGFtcCBldmVuIGlmIHdlIGhhZCBy
ZXRyYW5zbWl0dGVkIHRoZSBTWU4uCisJLyogUmVjZWl2ZWQgYW4gZWNob2VkIHRpbWVzdGFtcCBi
ZWZvcmUgdGhlIGZpcnN0IHJldHJhbnNtaXNzaW9uPyAqLworCWlmICh0cC0+cmV0cmFuc19zdGFt
cCkKKwkJcmV0dXJuIHRjcF90c29wdF9lY3JfYmVmb3JlKHRwLCB0cC0+cmV0cmFuc19zdGFtcCk7
CisKKwkvKiBXZSBzZXQgdHAtPnJldHJhbnNfc3RhbXAgdXBvbiB0aGUgZmlyc3QgcmV0cmFuc21p
c3Npb24gb2YgYSBsb3NzCisJICogcmVjb3ZlcnkgZXBpc29kZSwgc28gbm9ybWFsbHkgaWYgdHAt
PnJldHJhbnNfc3RhbXAgaXMgMCB0aGVuIG5vCisJICogcmV0cmFuc21pc3Npb24gaGFzIGhhcHBl
bmVkIHlldCAobGlrZWx5IGR1ZSB0byBUU1EsIHdoaWNoIGNhbiBjYXVzZQorCSAqIGZhc3QgcmV0
cmFuc21pdHMgdG8gYmUgZGVsYXllZCkuIFNvIGlmIHNuZF91bmEgYWR2YW5jZWQgd2hpbGUKKwkg
KiAodHAtPnJldHJhbnNfc3RhbXAgaXMgMCB0aGVuIGFwcGFyZW50bHkgYSBwYWNrZXQgd2FzIG1l
cmVseSBkZWxheWVkLAorCSAqIG5vdCBsb3N0LiBCdXQgdGhlcmUgYXJlIGV4Y2VwdGlvbnMgd2hl
cmUgd2UgcmV0cmFuc21pdCBidXQgdGhlbgorCSAqIGNsZWFyIHRwLT5yZXRyYW5zX3N0YW1wLCBz
byB3ZSBjaGVjayBmb3IgdGhvc2UgZXhjZXB0aW9ucy4KIAkgKi8KLQlpZiAoIXRwLT5yZXRyYW5z
X3N0YW1wICYmCSAgIC8qIG5vIHJlY29yZCBvZiBhIHJldHJhbnNtaXQvU1lOPyAqLwotCSAgICBz
ay0+c2tfc3RhdGUgIT0gVENQX1NZTl9TRU5UKSAgLyogbm90IHRoZSBGTEFHX1NZTl9BQ0tFRCBj
YXNlPyAqLwotCQlyZXR1cm4gdHJ1ZTsgIC8qIG5vdGhpbmcgd2FzIHJldHJhbnNtaXR0ZWQgKi8K
IAotCXJldHVybiBmYWxzZTsKKwkvKiAoMSkgRm9yIG5vbi1TQUNLIGNvbm5lY3Rpb25zLCB0Y3Bf
aXNfbm9uX3NhY2tfcHJldmVudGluZ19yZW9wZW4oKQorCSAqIGNsZWFycyB0cC0+cmV0cmFuc19z
dGFtcCB3aGVuIHNuZF91bmEgPT0gaGlnaF9zZXEuCisJICovCisJaWYgKCF0Y3BfaXNfc2Fjayh0
cCkgJiYgIWJlZm9yZSh0cC0+c25kX3VuYSwgdHAtPmhpZ2hfc2VxKSkKKwkJcmV0dXJuIGZhbHNl
OworCisJLyogKDIpIEluIFRDUF9TWU5fU0VOVCB0Y3BfY2xlYW5fcnR4X3F1ZXVlKCkgY2xlYXJz
IHRwLT5yZXRyYW5zX3N0YW1wCisJICogd2hlbiBzZXR0aW5nIEZMQUdfU1lOX0FDS0VEIGlzIHNl
dCwgZXZlbiBpZiB0aGUgU1lOIHdhcworCSAqIHJldHJhbnNtaXR0ZWQuCisJICovCisJaWYgKHNr
LT5za19zdGF0ZSA9PSBUQ1BfU1lOX1NFTlQpCisJCXJldHVybiBmYWxzZTsKKworCXJldHVybiB0
cnVlOwkvKiB0cC0+cmV0cmFuc19zdGFtcCBpcyB6ZXJvOyBubyByZXRyYW5zbWl0IHlldCAqLwog
fQogCiAvKiBVbmRvIHByb2NlZHVyZXMuICovCi0tIAoyLjUwLjAucmMwLjY0Mi5nODAwYTJiMjIy
Mi1nb29nCgo=
--000000000000a5d12506373ad8b4--

