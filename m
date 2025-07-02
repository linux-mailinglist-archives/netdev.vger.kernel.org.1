Return-Path: <netdev+bounces-203397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 398B1AF5C28
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7CD17D14A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CEA28030C;
	Wed,  2 Jul 2025 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="FmvgCXrG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1B19CD17
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468677; cv=none; b=fpBETn2Zc6BaaULxR1j7lzvP6c1NBmY+V/dFn+ZftS3eJBm5GaDRYInmUlu4C7g6//uzzFatLJXX6CKEp23vmgRitoM0owzrJoOVqM8UpEXAQScCqxtpulm8H8XKkvHnr3bimXB79F3XuCuC/LYtlnjOuYe79j/AvU7jPYy+CGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468677; c=relaxed/simple;
	bh=F3emk38gypg0rK9oAQGxcR7XH6tUjX9Z1QNIVaO5tUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJwvchTwC/4wt4cloTdXYkKIE1Z6NDO+qYip0HFxHykHW2b/pEhRq+zljzyMxbz8LhjzXYaqQiPJiVuvaoJ3UNphMS6ICy32xMp3H17QCD5oE+Zou9PkTwowffhE5vAHocVpspdyJlYf4IP3Qq7W3fKsWVaqJS0ZnDR5yXtj/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=FmvgCXrG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c7a52e97so6862267b3a.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 08:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751468675; x=1752073475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zTP4KZygCICu9wNvcUAw8KN/K96BIXVWTfCQFr/Wu3U=;
        b=FmvgCXrGu1rtbRWmjWE0mXR2Zjp65Vzi5ujo3AHznoldmKQSPdSt54bHi4S63iwvsx
         7K+nAL8BPXlwi5M8hq4k5aPFiS4pmiiIcA7LP/T9BePP+8cSLCTAT1IlxBMz4QUruB7G
         6ajnz8KQFTZtA0qahshv/YbnY5v1bPd6esR/2mUXYOgM9nt5CloEeAVtv43nQ9MnuCgK
         8+EliB2eajy76UN0s7hZFxMckeVQhKPM/vEdMh3upsCWxbn+4XFhzswKXHL0PGsjBYpC
         rc0h7hSfdzFSDaXy1xBf2D/G8t5/Q9PqTptoEtzLjhpnz4RMdPz6HY9XSmgI+yNopEW/
         fHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751468675; x=1752073475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTP4KZygCICu9wNvcUAw8KN/K96BIXVWTfCQFr/Wu3U=;
        b=a0W47qgrDxh+OL7hw32QeAVENArd2WUDCl3klKqJc1oNhVyU/7aW5LZbkoG6oRfzYO
         CRqbdIE4uxYlgIkQ6VLko8yDjy+FDHP2fDLHCHmmEtIYla9Ssl0qp2+5Pw0nsFMN529P
         GWi5MPbIuoaYsLgZJhqE7zVNlUBI/X04ThgVvCSHWDL8leTuUOwof+4UAk38kek7ZZ7S
         2sIWWH7uzuqR8iMCH+VopmWEud6rAx7lvTj0Z9ne6JwlmEu6ezMDKvbWEFuwMfOvEgiY
         b5hzTNAjpoiBrJoKGBk2d9QVoL0SmgqgSR/P/A02c06hqeb4tySAjmM947PPwAAQtqI/
         Lr2A==
X-Gm-Message-State: AOJu0Yx+WTMCOI03lwxcItWR9u4MDUsin+fXSzEt/JY2brqOhx369FJ0
	2VyuAUjh8taTMznYAYxBip94ZO8MaAoIqGjAiS4uQ42oxy+wKMNq/CQf9O8U70BSmeSbeNygmcl
	aUXAIIMebrIOWO37wesZqdehwE/X8N0Qh/jvcQv0vS4V9/6TwmK3FoQ==
X-Gm-Gg: ASbGnctUos5Q4ghFUKLeHRbRM8rKW/5Aw2/+nK9yrdgDyRI+j7s9IyagqJYXrCoBzUF
	Nw7GOL5iKOm+Ng1aWOiPpCy0agx6h0sgFky8cFFtpEcwMLSdwiRbG1fQ+tdBQ3lOgweCj/nAp7y
	CTEl6lv5eHYZQmWgvSXlMm3J6rxhsQ0IgmviQfPueJPw==
X-Google-Smtp-Source: AGHT+IH/HyBP4snRKVHlUBzgkoRWOLe00X5d7p2j40WCTTSmEjyIlZpJbGEQYSPrYjmuNKE9fvw39CBI6jVLsYJA63w=
X-Received: by 2002:a05:6a20:4304:b0:1ee:e20f:f14e with SMTP id
 adf61e73a8af0-222d7f30909mr5403764637.38.1751468674293; Wed, 02 Jul 2025
 08:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
 <20250701231306.376762-2-xiyou.wangcong@gmail.com> <aGSSF7K/M81Pjbyz@pop-os.localdomain>
 <CAM0EoMmDj9TOafynkjVPaBw-9s7UDuS5DoQ_K3kAtioEdJa1-g@mail.gmail.com>
In-Reply-To: <CAM0EoMmDj9TOafynkjVPaBw-9s7UDuS5DoQ_K3kAtioEdJa1-g@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 2 Jul 2025 11:04:22 -0400
X-Gm-Features: Ac12FXxOTZl0b7nN8QEFggL-iSbSe584yj5RApiGhb5TeLXswLDnZog5WeoWMEg
Message-ID: <CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com>
Subject: Re: [Patch net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, will@willsroot.io, stephen@networkplumber.org, 
	Savino Dicanosa <savy@syst3mfailure.io>
Content-Type: multipart/mixed; boundary="0000000000002ad4cf0638f394f3"

--0000000000002ad4cf0638f394f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 10:12=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Jul 1, 2025 at 9:57=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.co=
m> wrote:
> >
> > On Tue, Jul 01, 2025 at 04:13:05PM -0700, Cong Wang wrote:
> > > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > > index fdd79d3ccd8c..33de9c3e4d1b 100644
> > > --- a/net/sched/sch_netem.c
> > > +++ b/net/sched/sch_netem.c
> > > @@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *skb, str=
uct Qdisc *sch,
> > >       skb->prev =3D NULL;
> > >
> > >       /* Random duplication */
> > > -     if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, =
&q->prng))
> > > +     if (tc_skb_cb(skb)->duplicate &&
> >
> > Oops, this is clearly should be !duplicate... It was lost during my
> > stupid copy-n-paste... Sorry for this mistake.
> >
>
> I understood you earlier, Cong. My view still stands:
> You are adding logic to a common data structure for a use case that
> really makes no sense. The ROI is not good.
> BTW: I am almost certain you will hit other issues when this goes out
> or when you actually start to test and then you will have to fix more
> spots.
>
Here's an example that breaks it:

sudo tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0
sudo tc filter add dev lo parent 1:0 protocol ip bpf obj
netem_bug_test.o sec classifier/pass classid 1:1
sudo tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%
sudo tc qdisc add dev lo parent 10: handle 30: netem gap 1 limit 4
duplicate 100% delay 1us reorder 100%

And the ping 127.0.0.1 -c 1
I had to fix your patch for correctness (attached)


the ebpf prog is trivial - make it just return the classid or even zero.

William, as a middle ground can you take a crack at using cb_ext -
take a look for example at struct tc_skb_ext_alloc in cls_api.c (that
one is safe to extend).


cheers
jamal

> cheers,
> jamal

--0000000000002ad4cf0638f394f3
Content-Type: application/octet-stream; name=p1
Content-Disposition: attachment; filename=p1
Content-Transfer-Encoding: base64
Content-ID: <f_mcm33vvt0>
X-Attachment-Id: f_mcm33vvt0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3NjaF9nZW5lcmljLmggYi9pbmNsdWRlL25ldC9zY2hf
Z2VuZXJpYy5oCmluZGV4IDYzODk0OGJlNGM1MC4uNTk1YjI0MTgwZDYyIDEwMDY0NAotLS0gYS9p
bmNsdWRlL25ldC9zY2hfZ2VuZXJpYy5oCisrKyBiL2luY2x1ZGUvbmV0L3NjaF9nZW5lcmljLmgK
QEAgLTEwNjcsNiArMTA2Nyw3IEBAIHN0cnVjdCB0Y19za2JfY2IgewogCXU4IHBvc3RfY3Q6MTsK
IAl1OCBwb3N0X2N0X3NuYXQ6MTsKIAl1OCBwb3N0X2N0X2RuYXQ6MTsKKwl1OCBkdXBsaWNhdGU6
MTsKIH07CiAKIHN0YXRpYyBpbmxpbmUgc3RydWN0IHRjX3NrYl9jYiAqdGNfc2tiX2NiKGNvbnN0
IHN0cnVjdCBza19idWZmICpza2IpCmRpZmYgLS1naXQgYS9uZXQvc2NoZWQvc2NoX25ldGVtLmMg
Yi9uZXQvc2NoZWQvc2NoX25ldGVtLmMKaW5kZXggZmRkNzlkM2NjZDhjLi5kNWI5NjlkZjkxNDMg
MTAwNjQ0Ci0tLSBhL25ldC9zY2hlZC9zY2hfbmV0ZW0uYworKysgYi9uZXQvc2NoZWQvc2NoX25l
dGVtLmMKQEAgLTQ2MCw3ICs0NjAsOCBAQCBzdGF0aWMgaW50IG5ldGVtX2VucXVldWUoc3RydWN0
IHNrX2J1ZmYgKnNrYiwgc3RydWN0IFFkaXNjICpzY2gsCiAJc2tiLT5wcmV2ID0gTlVMTDsKIAog
CS8qIFJhbmRvbSBkdXBsaWNhdGlvbiAqLwotCWlmIChxLT5kdXBsaWNhdGUgJiYgcS0+ZHVwbGlj
YXRlID49IGdldF9jcmFuZG9tKCZxLT5kdXBfY29yLCAmcS0+cHJuZykpCisJaWYgKHRjX3NrYl9j
Yihza2IpLT5kdXBsaWNhdGUgPT0gMCAmJgorCSAgICBxLT5kdXBsaWNhdGUgPj0gZ2V0X2NyYW5k
b20oJnEtPmR1cF9jb3IsICZxLT5wcm5nKSkKIAkJKytjb3VudDsKIAogCS8qIERyb3AgcGFja2V0
PyAqLwpAQCAtNTM4LDExICs1MzksOSBAQCBzdGF0aWMgaW50IG5ldGVtX2VucXVldWUoc3RydWN0
IHNrX2J1ZmYgKnNrYiwgc3RydWN0IFFkaXNjICpzY2gsCiAJICovCiAJaWYgKHNrYjIpIHsKIAkJ
c3RydWN0IFFkaXNjICpyb290cSA9IHFkaXNjX3Jvb3RfYmgoc2NoKTsKLQkJdTMyIGR1cHNhdmUg
PSBxLT5kdXBsaWNhdGU7IC8qIHByZXZlbnQgZHVwbGljYXRpbmcgYSBkdXAuLi4gKi8KIAotCQlx
LT5kdXBsaWNhdGUgPSAwOworCQl0Y19za2JfY2Ioc2tiMiktPmR1cGxpY2F0ZSA9IDE7CiAJCXJv
b3RxLT5lbnF1ZXVlKHNrYjIsIHJvb3RxLCB0b19mcmVlKTsKLQkJcS0+ZHVwbGljYXRlID0gZHVw
c2F2ZTsKIAkJc2tiMiA9IE5VTEw7CiAJfQogCg==
--0000000000002ad4cf0638f394f3--

