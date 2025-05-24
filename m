Return-Path: <netdev+bounces-193223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88AAAC2FD1
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 15:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9E43BFE9B
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 13:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD661BC3F;
	Sat, 24 May 2025 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="aGJn6qeK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B33C465
	for <netdev@vger.kernel.org>; Sat, 24 May 2025 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748092075; cv=none; b=MtA8exHhufq3OzXQnfJvYZvtpW+aKStZw9Fli+y6B0t2phSRP7BjpMWazjDKanKZlpdud6qCEIdbBujCQrXU3Zxm3nhAzcwE7pAeDuxxV61/rQg2BKumHr/MSWvA1CZobBNAvkEzjE41Fglyml9DkRX3GgK+ZXP0IUohDzmDHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748092075; c=relaxed/simple;
	bh=GWrESh9yMoNHAEk91NuVqThB+ekIXMfzP+2flufZQh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6Ojagg0Pmws3r+uwPniQatlfYCXCxSQ7Rgqhm2/IPMjtcsvWCfgW03VOmW2l+SPMBZI53MSH/kvQ+8xuoUXxcBPiB6hTKSt/f8Evkb8XkHY+Q27JW/mFzf25gfdXpCV9fDsWsQNWHe4HlaMhY1oO5LAGYH+iKksIYzQCB0dq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=aGJn6qeK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c9563fd9so549474b3a.3
        for <netdev@vger.kernel.org>; Sat, 24 May 2025 06:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1748092073; x=1748696873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GWrESh9yMoNHAEk91NuVqThB+ekIXMfzP+2flufZQh4=;
        b=aGJn6qeK3/dXo6FZHtqrcgNBSEqwcY4kyh9sDnSjC/2uWT8BevgD9B0iZOacIroCKa
         qsUAfz7LlU+QUtIVBkfE5xR4a8fwXXX2IgJfGI6/3vwqg94+RTQOiwLX3Y9Rg5xtqkho
         zOs7b5mi39A6wTQhXqJqfjrNMkaNjgqvDUxQjJzeLqED5/0wAIyg4DzxyfrWTxIppq23
         uo5uK3/JyR7ZoF9q2cHVTXl5LCfTgxOtM1e29PiKBvCP523nhE1+eLOXgXOE35Dcu85a
         UmT5oh3C5TfvNUwwOarahEU1wCg5P9rw8B3ZsWVWNR7+WnV7p31V07hN8wO7tu6j+KtW
         AKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748092073; x=1748696873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWrESh9yMoNHAEk91NuVqThB+ekIXMfzP+2flufZQh4=;
        b=iXCrCcW77H/uK0cgrTa5Zm6pxKlu6jCNcNG4BaeADKMNm7blilMcRIKHHGkFaBCMTc
         +/DuRi/GCXE4rXg5vt8YH+yHMdSqQvvsjmAky+DCDRzouFc50m+CcoHWdZmBK5vGXcwB
         g1hqD2OE29cAx90wIHJbPy0obr0NIHicJx32iUxx2pFS42Dt/8U/De/2IWXNpi/K+s+V
         aMvAiBroDuR3z1qZZ0En8f7u4iXt0yhJDUnV3XqVEa6KJVS2teSifW5/3DsQOVf+j45S
         oeneKXmCoNLVCPGOa0vw93FlAUS4XkdvW4nXwKZkv4vq/KOcynIFpNi0ZJOUOW5BkItP
         bvEg==
X-Gm-Message-State: AOJu0YxCaFDSqG24a0m7dxhOmzsE9W1Lbzda1fhisXYnua94Wna+D176
	DVzTFws8mqeWDog8qOeiiySQcAZYEPeXQaHIgiHVjCC3DfI9C742Ccr35tv0beHRUZPj+oszaAc
	bTqXRyTvzSCHv9IS9RFJojeiMr7scL5qDeaZlmErpFzYBCUvYnYZzlw==
X-Gm-Gg: ASbGncviq8jMiBwMu5xDJ+OXsCAcGb8UPPqGywHMcgKWRuEAHR6tUJkX5T/OdanoHMl
	M55okkqtH2Vr0mhH7NCrvz5K7eVoCtk+7FrFaA0ze2hqRnIRRBIMowRV179xSOW59Y9k7uNHMU3
	D7b6cf9DbAdnhm/9EKb7I0IaHN3bWNGhQ=
X-Google-Smtp-Source: AGHT+IFYnEVTHy2wSpCz9qfs1cyHqQtF+pSg1uL77CyTVnCFqkBtza8H8/92k52zpNDMgcV6RsdaTVpyITLFvw32ZNY=
X-Received: by 2002:a05:6a21:3399:b0:216:185c:af0b with SMTP id
 adf61e73a8af0-2188c3b494amr4713087637.39.1748092072886; Sat, 24 May 2025
 06:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
 <CAM0EoMmKL68r_b1T4zHJTmdZPdCwS69F-Hh+0_ev+-5xPGy2=w@mail.gmail.com>
 <DglTO9NHmtFTRrCJf07R16_tYUUqoTV7M0hID_k-ryn5mAhe4ADq1mBpAuxNK24ZTnzIPaPq4x1woAtqZGXgAQS4k64C4SGRCfupe3H3dRs=@willsroot.io>
 <CAM0EoMmQau9+uXVm-vpuWqYjh=51a_CCS6orS6VrK6qBdddxrQ@mail.gmail.com>
 <iEqzQsC-O2kAXqH1_58I59DIhBjRgebyGym2ZqyMEI3DaMtgsKSYR0KUsbxj5xqvfzf-4XzpM8dXvATHJhVVw3NedRdL3j1FJaqiXPlNWeE=@willsroot.io>
 <ggSxq-NP-LDpev4N-rvkgs0Rrd0qOrbwtGRjcu4j4y3SuZth9k5RxTg2tFvhriQu4w_GxRPYjnkKN6VqFP6Q6FCyqWudz7_5iuOV06IEzgY=@willsroot.io>
 <CAM0EoMkd87-6ZJ5PWsV8K+Pn+dVNEOP9NcfGAjXVrzAH70F4YA@mail.gmail.com>
 <Ppi6ol0VaHrqJs9Rp0-SGp0J1Y0K8hki_jbNZ8sjNOmtEq0mD4f0IozBxxX-m4535QPJonGFYmiPmB643yd4SOpd1HDDYyMeGQuASuFHl-E=@willsroot.io>
 <CAM0EoM==m_f3_DNgSEKODQzHgE_zyRpXKweNGw1mxz-e3u6+Hg@mail.gmail.com> <8fcsX7qgyK6tCGCqfi8RN7a-hMGfmh0K2wOpqXayxNM0lKgbjttNfpYkZHA29D0SN5WJ5h3-auiaClAq1nGw5BulC8wOzfa_lqR4bx73phM=@willsroot.io>
In-Reply-To: <8fcsX7qgyK6tCGCqfi8RN7a-hMGfmh0K2wOpqXayxNM0lKgbjttNfpYkZHA29D0SN5WJ5h3-auiaClAq1nGw5BulC8wOzfa_lqR4bx73phM=@willsroot.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 24 May 2025 09:07:41 -0400
X-Gm-Features: AX0GCFuP32k56UeLZK425T7wIiEnlrd4dv3YDw7z0e_S6gtAq6OKxxcWEG4Gd5A
Message-ID: <CAM0EoMkO0vZ4ZtODLJEBP5FiA0+ofVNOSf-BxCOGOyWAZDHdTg@mail.gmail.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
To: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000000a400c0635e167c2"

--0000000000000a400c0635e167c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 11:23=E2=80=AFAM William Liu <will@willsroot.io> wr=
ote:
>
>
> On Friday, May 23rd, 2025 at 11:01 AM, Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> >
> >
> > looks ok from 30k feet. Comments:
> > You dont need a count variable anymore because the per-cpu variable
> > serves the same goal - so please get rid of it.
> > Submit a formal patchset - including at least one tdc test(your
> > validation tests are sufficient) then we can do a better review.
> > And no netdev comments are complete if we dont talk about the xmas
> > tree variable layout. Not your fault on the state of the lights on
> > that tree but dont make it worse;-> move the nest_level assignment as
> >
> > the first line in the function.
> >
> > cheers,
> > jamal
>
> Ok will do. Can you clarify the count variable issue? My understanding of=
 the count variable is that it accounts for both the possibility of simulat=
ed duplication or loss. The nest_level I added is to prevent against duplic=
ation of a duplicate due to re-entrancy.

"count =3D=3D 0" seems to be only needed for the loss when a drop decision =
is made.
Slight tangent: Looking at init() the setup does allow for both to be
on (i.e could be "and" not just "or" as you state above). It feels
sensible to me that if the loss function decided the packet is to be
dropped then that would override the duplication. Stephen? IOW, I
highly doubt anyone is using a setup with both on - but doesnt mean
someone wouldnt set both if the system allows it.
Would be useful to test with loss probability of 100% and set
duplication on to see what kind of smoke comes out.

In any case - here's what i had in mind, of course not even compile tested.

cheers,
jamal

--0000000000000a400c0635e167c2
Content-Type: application/octet-stream; name=netem-patchlet
Content-Disposition: attachment; filename=netem-patchlet
Content-Transfer-Encoding: base64
Content-ID: <f_mb28rwyz0>
X-Attachment-Id: f_mb28rwyz0

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9zY2hfbmV0ZW0uYyBiL25ldC9zY2hlZC9zY2hfbmV0ZW0u
YwppbmRleCBmZGQ3OWQzY2NkOGMuLjc0NjJhOGJlZmE4NyAxMDA2NDQKLS0tIGEvbmV0L3NjaGVk
L3NjaF9uZXRlbS5jCisrKyBiL25ldC9zY2hlZC9zY2hfbmV0ZW0uYwpAQCAtMTY3LDYgKzE2Nyw4
IEBAIHN0cnVjdCBuZXRlbV9za2JfY2IgewogCXU2NAkgICAgICAgIHRpbWVfdG9fc2VuZDsKIH07
CiAKK3N0YXRpYyBERUZJTkVfUEVSX0NQVSh1bnNpZ25lZCBpbnQsIGVucXVldWVfbmVzdF9sZXZl
bCk7CisKIHN0YXRpYyBpbmxpbmUgc3RydWN0IG5ldGVtX3NrYl9jYiAqbmV0ZW1fc2tiX2NiKHN0
cnVjdCBza19idWZmICpza2IpCiB7CiAJLyogd2UgYXNzdW1lIHdlIGNhbiB1c2Ugc2tiIG5leHQv
cHJldi90c3RhbXAgYXMgc3RvcmFnZSBmb3IgcmJfbm9kZSAqLwpAQCAtNDQ4LDMyICs0NTAsNDAg
QEAgc3RhdGljIHN0cnVjdCBza19idWZmICpuZXRlbV9zZWdtZW50KHN0cnVjdCBza19idWZmICpz
a2IsIHN0cnVjdCBRZGlzYyAqc2NoLAogc3RhdGljIGludCBuZXRlbV9lbnF1ZXVlKHN0cnVjdCBz
a19idWZmICpza2IsIHN0cnVjdCBRZGlzYyAqc2NoLAogCQkJIHN0cnVjdCBza19idWZmICoqdG9f
ZnJlZSkKIHsKKwl1bnNpZ25lZCBpbnQgbmVzdF9sZXZlbCA9IF9fdGhpc19jcHVfaW5jX3JldHVy
bihlbnF1ZXVlX25lc3RfbGV2ZWwpOwogCXN0cnVjdCBuZXRlbV9zY2hlZF9kYXRhICpxID0gcWRp
c2NfcHJpdihzY2gpOwogCS8qIFdlIGRvbid0IGZpbGwgY2Igbm93IGFzIHNrYl91bnNoYXJlKCkg
bWF5IGludmFsaWRhdGUgaXQgKi8KIAlzdHJ1Y3QgbmV0ZW1fc2tiX2NiICpjYjsKIAlzdHJ1Y3Qg
c2tfYnVmZiAqc2tiMiA9IE5VTEw7CiAJc3RydWN0IHNrX2J1ZmYgKnNlZ3MgPSBOVUxMOwogCXVu
c2lnbmVkIGludCBwcmV2X2xlbiA9IHFkaXNjX3BrdF9sZW4oc2tiKTsKLQlpbnQgY291bnQgPSAx
OworCWludCByZXR2YWw7CisKKwlpZiAodW5saWtlbHkobmVzdF9sZXZlbCA+IDIpKSB7CisJCW5l
dF93YXJuX3JhdGVsaW1pdGVkKCJFeGNlZWRlZCBuZXRlbSByZWN1cnNpb24gJWQgPiAxIG9uIGRl
diAlc1xuIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZXN0X2xldmVs
LCBuZXRkZXZfbmFtZShza2ItPmRldikpOworCQlxZGlzY19xc3RhdHNfZHJvcChzY2gpOyAvKiA/
PyB0Ki8KKwkJcWRpc2NfcXN0YXRzX292ZXJsaW1pdChzY2gpOyAvKiBGYWlyIHRvIGFzc3VtZSBv
dmVybGltaXQ/PyAqLworCQlyZXR2YWwgPSBORVRfWE1JVF9EUk9QOworCQlnb3RvIGRlY19uZXN0
X2xldmVsOworCX0KIAogCS8qIERvIG5vdCBmb29sIHFkaXNjX2Ryb3BfYWxsKCkgKi8KIAlza2It
PnByZXYgPSBOVUxMOwogCiAJLyogUmFuZG9tIGR1cGxpY2F0aW9uICovCiAJaWYgKHEtPmR1cGxp
Y2F0ZSAmJiBxLT5kdXBsaWNhdGUgPj0gZ2V0X2NyYW5kb20oJnEtPmR1cF9jb3IsICZxLT5wcm5n
KSkKLQkJKytjb3VudDsKKwkJbmVzdF9sZXZlbCA9IF9fdGhpc19jcHVfaW5jX3JldHVybihlbnF1
ZXVlX25lc3RfbGV2ZWwpOwogCiAJLyogRHJvcCBwYWNrZXQ/ICovCiAJaWYgKGxvc3NfZXZlbnQo
cSkpIHsKIAkJaWYgKHEtPmVjbiAmJiBJTkVUX0VDTl9zZXRfY2Uoc2tiKSkKIAkJCXFkaXNjX3Fz
dGF0c19kcm9wKHNjaCk7IC8qIG1hcmsgcGFja2V0ICovCiAJCWVsc2UKLQkJCS0tY291bnQ7Ci0J
fQotCWlmIChjb3VudCA9PSAwKSB7Ci0JCXFkaXNjX3FzdGF0c19kcm9wKHNjaCk7Ci0JCV9fcWRp
c2NfZHJvcChza2IsIHRvX2ZyZWUpOwotCQlyZXR1cm4gTkVUX1hNSVRfU1VDQ0VTUyB8IF9fTkVU
X1hNSVRfQllQQVNTOworCQkJcWRpc2NfcXN0YXRzX2Ryb3Aoc2NoKTsKKwkJCV9fcWRpc2NfZHJv
cChza2IsIHRvX2ZyZWUpOworCQkJcmV0dmFsID0gTkVUX1hNSVRfU1VDQ0VTUyB8IF9fTkVUX1hN
SVRfQllQQVNTOworCQkJZ290byBkZWNfbmVzdF9sZXZlbDsKIAl9CiAKIAkvKiBJZiBhIGRlbGF5
IGlzIGV4cGVjdGVkLCBvcnBoYW4gdGhlIHNrYi4gKG9ycGhhbmluZyB1c3VhbGx5IHRha2VzCkBA
IC00ODYsNyArNDk2LDcgQEAgc3RhdGljIGludCBuZXRlbV9lbnF1ZXVlKHN0cnVjdCBza19idWZm
ICpza2IsIHN0cnVjdCBRZGlzYyAqc2NoLAogCSAqIElmIHdlIG5lZWQgdG8gZHVwbGljYXRlIHBh
Y2tldCwgdGhlbiBjbG9uZSBpdCBiZWZvcmUKIAkgKiBvcmlnaW5hbCBpcyBtb2RpZmllZC4KIAkg
Ki8KLQlpZiAoY291bnQgPiAxKQorCWlmIChuZXN0X2xldmVsID4gMSkKIAkJc2tiMiA9IHNrYl9j
bG9uZShza2IsIEdGUF9BVE9NSUMpOwogCiAJLyoKQEAgLTUyOCw3ICs1MzgsOCBAQCBzdGF0aWMg
aW50IG5ldGVtX2VucXVldWUoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IFFkaXNjICpzY2gs
CiAJCXFkaXNjX2Ryb3BfYWxsKHNrYiwgc2NoLCB0b19mcmVlKTsKIAkJaWYgKHNrYjIpCiAJCQlf
X3FkaXNjX2Ryb3Aoc2tiMiwgdG9fZnJlZSk7Ci0JCXJldHVybiBORVRfWE1JVF9EUk9QOworCQly
ZXR2YWwgPSBORVRfWE1JVF9EUk9QOworCQlnb3RvIGRlY19uZXN0X2xldmVsOwogCX0KIAogCS8q
CkBAIC02NDIsOSArNjUzLDE1IEBAIHN0YXRpYyBpbnQgbmV0ZW1fZW5xdWV1ZShzdHJ1Y3Qgc2tf
YnVmZiAqc2tiLCBzdHJ1Y3QgUWRpc2MgKnNjaCwKIAkJLyogUGFyZW50IHFkaXNjcyBhY2NvdW50
ZWQgZm9yIDEgc2tiIG9mIHNpemUgQHByZXZfbGVuICovCiAJCXFkaXNjX3RyZWVfcmVkdWNlX2Jh
Y2tsb2coc2NoLCAtKG5iIC0gMSksIC0obGVuIC0gcHJldl9sZW4pKTsKIAl9IGVsc2UgaWYgKCFz
a2IpIHsKLQkJcmV0dXJuIE5FVF9YTUlUX0RST1A7CisJCXJldHZhbCA9IE5FVF9YTUlUX0RST1A7
CisJCWdvdG8gZGVjX25lc3RfbGV2ZWw7CiAJfQotCXJldHVybiBORVRfWE1JVF9TVUNDRVNTOwor
CXJldHZhbCA9IE5FVF9YTUlUX1NVQ0NFU1M7CisKK2RlY19uZXN0X2xldmVsOgorCXdoaWxlIChu
ZXN0X2xldmVsKQorCQluZXN0X2xldmVsID0gX190aGlzX2NwdV9kZWMoZW5xdWV1ZV9uZXN0X2xl
dmVsKTsKKwlyZXR1cm4gcmV0dmFsOwogfQogCiAvKiBEZWxheSB0aGUgbmV4dCByb3VuZCB3aXRo
IGEgbmV3IGZ1dHVyZSBzbG90IHdpdGggYQo=
--0000000000000a400c0635e167c2--

