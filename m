Return-Path: <netdev+bounces-88115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597DF8A5CBD
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 23:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E371C21255
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 21:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C7782D93;
	Mon, 15 Apr 2024 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="joUIctqR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C173C70CDB
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215709; cv=none; b=XhXzygzkR/qir9ZIansiMVSU4rpAZUFP15kZ6ae2WUwhD1TgdXIF72apGz8ym/F260Wlwk3gYRN7aN56Pd0Va05CbKxWxDwx9pf4RKMHCX+E7xrjxU1qjalSd4aIhVi909CN0WszJUG7hAMfJx5r4x08RAYLSdaAx+PaetUzPUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215709; c=relaxed/simple;
	bh=JBU7CENdHjPyUIzJHGKwNf0KIGbYeqbb22smov3UWPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvrbUCf4KgXuJiX7onTsD0kLzTP0kEX9ksLtn98U45ujU5sPYXZVie0qQWt8AmnAKnUiq5vb0ur7hQjF584K5j8XO4c2uySTgQcF2S73H8PvvLexDlPWqszSl+pUWR1LSsK2h5V6WEDmy8qCthfi0Fh0W64q7tBeXwC6rPgEExw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=joUIctqR; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61acfd3fd3fso16643297b3.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1713215707; x=1713820507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf2R2fsTNBlVuNbUwgugov4ABpOXp3LFN5BlqsrzAe8=;
        b=joUIctqRS7JmneA6orwTmJqfjbjIlQo8YtB1Nyt1vwLH9ZLaPROm7ERjiYp5wB4peU
         vJFV6GVp4Z5oxMaCiPo1foyGS6bOsTE+mCYtmwKBpOdC3oSdV4c4Wz8BpE/kSZvAPII3
         GLAKAZSQ06ZmwBqcAcebDLcmdCX/cCNaCx9LnKIx4XwyfxdMSOEBAUtyKYs+sRs1y8p8
         Iu1d/oBNvQAE1/uURSSS8St8kl8B7LIaulfKeIkuAhmSVDxJEwUkW6GzXV2zlUYSFSXp
         UwU6H/odXIzCEST1s0F5fH6tdFxFb2yvU8PGhrAI7V707ZTLHSKIdu8V63kTRN4LRqzA
         Tajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713215707; x=1713820507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zf2R2fsTNBlVuNbUwgugov4ABpOXp3LFN5BlqsrzAe8=;
        b=RY6ZfxxPWErhFoqn+qPeJVoOOaKwOdyK1+2ZGm9nl/cTQOlpvV4PZrmnCplZHhsWM/
         15/9aWPiLTjiWx0NrLEgTbdzsxRBdq3uw20mEbtU5AGULXoG/qXjZ7XrVml/zkTzHpDJ
         CZ3UMigPF+8xVvNoe6FBUBF+e5xjfWlwHov4RJw0VM/78TrST3p9y/pblN7jr/HNC/1s
         rQxplaMP+fhTVNQB+GK8AcwBOyDQ4poriG3wR4lMNlXBu0m2eb2pvLtIot46EMTGPKK7
         G5fJVYwjw79VtJv/V3Bii11Dj9u+buEa0dq2xRjKM7HyjyRcORcZZeaN84jECsVCawIN
         NRpg==
X-Forwarded-Encrypted: i=1; AJvYcCWapHm7AXITelL1w0jxB4ljkK46Pi+/ExuKL5GpZoJs2ClaoPuwYOZW/yFjmS5Hcp5pt80OAyMREXVGjzuLlUpr93sI0n/c
X-Gm-Message-State: AOJu0YwfJzs2lv4ZVMiKhM5vx1mWL7GeSTwPtpTDwwLwJT7br8Yt5swN
	h6dxP+Xm9BqoAFyauIp4gMe7yZbahwHtMWqMM6QhVLmNdgUTIAj3up3X9NynkB7ps/6lw0gnHlL
	hIC5AY/288PLqBFyPiRXsUqQ/3WlFnQxIne8q
X-Google-Smtp-Source: AGHT+IFJJiH9a6rrsmcDjbp0G2BlBm/CyMLA9O5ZNeH79Lb9ftFFJl54j6lLWVxilBsVh9GK32vG8Y4uVXaZR72aRpk=
X-Received: by 2002:a0d:c406:0:b0:61a:b7c8:ea05 with SMTP id
 g6-20020a0dc406000000b0061ab7c8ea05mr6033168ywd.35.1713215706660; Mon, 15 Apr
 2024 14:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326230319.190117-1-jhs@mojatatu.com> <CANn89iLhd4iD-pDVJHzKqWbf16u9KyNtgV41X3sd=iy15jDQtQ@mail.gmail.com>
 <CAM0EoMmQHsucU6n1O3XEd50zUB4TENkEH0+J-cZ=5Bbv9298mA@mail.gmail.com>
 <CANn89iKaMKeY7pR7=RH1NMBpYiYFmBRfAWmbZ61PdJ2VYoUJ9g@mail.gmail.com>
 <CAM0EoM=s_MvUa32kUyt=VfeiAwxOm2OUJ3H=i0ARO1xupM2_Xg@mail.gmail.com>
 <CAM0EoMk33ga5dh12ViZz8QeFwjwNQBvykM53VQo1B3BdfAZtaQ@mail.gmail.com>
 <CANn89iLmhaC8fuu4UpPdELOAapBzLv0+S50gr0Rs+J+=4+9j=g@mail.gmail.com>
 <CAM0EoMm+cqkY9tQC6+jpvLJrRxw43Gzffgw85Q3Fe2tBgA7k2Q@mail.gmail.com>
 <CAM0EoMmdp_ik6EA2q8vhr+gGh=OcxUkvBOsxPHFWjn1eDX_33Q@mail.gmail.com> <CANn89iLsV8sj1cJJ8VJmBwZvsD5PoV_NXfXYSCXTjaYCRm6gmA@mail.gmail.com>
In-Reply-To: <CANn89iLsV8sj1cJJ8VJmBwZvsD5PoV_NXfXYSCXTjaYCRm6gmA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 15 Apr 2024 17:14:55 -0400
Message-ID: <CAM0EoMnKh67wGo5XV1vdUd8p8LhxrT5mtbioPOLr=sVprYNKjA@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: multipart/mixed; boundary="0000000000009eb0410616291d4d"

--0000000000009eb0410616291d4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 10:11=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Apr 15, 2024 at 4:01=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
>
> > Sorry - shows Victor's name but this is your patch, so feel free if
> > you send to add your name as author.
>
> Sure go ahead, but I would rather put the sch->owner init in
> qdisc_alloc() so that qdisc_create_dflt() is covered.

Victor sent the patch. As i mentioned earlier, we found a lockdep
false positive for the case of redirect from eth0->eth1->eth0
(potential fix attached)

[   75.691724] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   75.691964] WARNING: possible recursive locking detected
[   75.691964] 6.9.0-rc3-00861-g0a7d3ab066ff #60 Not tainted
[   75.691964] --------------------------------------------
[   75.691964] ping/421 is trying to acquire lock:
[   75.691964] ffff88800568e110 (&sch->q.lock){+.-.}-{3:3}, at:
__dev_queue_xmit+0x1828/0x3580
[   75.691964]
[   75.691964] but task is already holding lock:
[   75.691964] ffff88800bd2c110 (&sch->q.lock){+.-.}-{3:3}, at:
__dev_queue_xmit+0x1828/0x3580
[   75.691964]
[   75.691964] other info that might help us debug this:
[   75.691964]  Possible unsafe locking scenario:
[   75.691964]
[   75.691964]        CPU0
[   75.691964]        ----
[   75.691964]   lock(&sch->q.lock);
[   75.691964]   lock(&sch->q.lock);
[   75.691964]
[   75.691964]  *** DEADLOCK ***
[   75.691964]
[   75.691964]  May be due to missing lock nesting notation
[   75.691964]
[   75.691964] 9 locks held by ping/421:
[   75.691964]  #0: ffff888002564ff8 (sk_lock-AF_INET){+.+.}-{0:0},
at: raw_sendmsg+0xa32/0x2d80
[   75.691964]  #1: ffffffffa7233540 (rcu_read_lock){....}-{1:3}, at:
ip_finish_output2+0x284/0x1f80
[   75.691964]  #2: ffffffffa7233540 (rcu_read_lock){....}-{1:3}, at:
process_backlog+0x210/0x660
[   75.691964]  #3: ffffffffa7233540 (rcu_read_lock){....}-{1:3}, at:
ip_local_deliver_finish+0x21e/0x4d0
[   75.691964]  #4: ffff8880025648a8 (k-slock-AF_INET){+...}-{3:3},
at: icmp_reply+0x2e6/0xa20
[   75.691964]  #5: ffffffffa7233540 (rcu_read_lock){....}-{1:3}, at:
ip_finish_output2+0x284/0x1f80
[   75.691964]  #6: ffffffffa72334e0 (rcu_read_lock_bh){....}-{1:3},
at: __dev_queue_xmit+0x224/0x3580
[   75.691964]  #7: ffff88800bd2c110 (&sch->q.lock){+.-.}-{3:3}, at:
__dev_queue_xmit+0x1828/0x3580
[   75.691964]  #8: ffffffffa72334e0 (rcu_read_lock_bh){....}-{1:3},
at: __dev_queue_xmit+0x224/0x3580

cheers,
jamal

--0000000000009eb0410616291d4d
Content-Type: text/x-patch; charset="US-ASCII"; name="lockdep-fix.patch"
Content-Disposition: attachment; filename="lockdep-fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lv1gbw3v0>
X-Attachment-Id: f_lv1gbw3v0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3NjaF9nZW5lcmljLmggYi9pbmNsdWRlL25ldC9zY2hf
Z2VuZXJpYy5oCmluZGV4IGY1NjFkZmI3OTc0My4uNGRkYzQ2ZjEwNmI5IDEwMDY0NAotLS0gYS9p
bmNsdWRlL25ldC9zY2hfZ2VuZXJpYy5oCisrKyBiL2luY2x1ZGUvbmV0L3NjaF9nZW5lcmljLmgK
QEAgLTEyNiw2ICsxMjYsNyBAQCBzdHJ1Y3QgUWRpc2MgewogCXNwaW5sb2NrX3QJCWJ1c3lsb2Nr
IF9fX19jYWNoZWxpbmVfYWxpZ25lZF9pbl9zbXA7CiAJc3BpbmxvY2tfdAkJc2VxbG9jazsKIAor
CXN0cnVjdCBsb2NrX2NsYXNzX2tleSAgIHFkaXNjX3R4X3Jvb3Rsb2NrOwogCXN0cnVjdCByY3Vf
aGVhZAkJcmN1OwogCW5ldGRldmljZV90cmFja2VyCWRldl90cmFja2VyOwogCS8qIHByaXZhdGUg
ZGF0YSAqLwpkaWZmIC0tZ2l0IGEvbmV0L3NjaGVkL3NjaF9nZW5lcmljLmMgYi9uZXQvc2NoZWQv
c2NoX2dlbmVyaWMuYwppbmRleCA0YTJjNzYzZTJkMTEuLjgwOWU5NzQyMDRmOCAxMDA2NDQKLS0t
IGEvbmV0L3NjaGVkL3NjaF9nZW5lcmljLmMKKysrIGIvbmV0L3NjaGVkL3NjaF9nZW5lcmljLmMK
QEAgLTk0NSw3ICs5NDUsOSBAQCBzdHJ1Y3QgUWRpc2MgKnFkaXNjX2FsbG9jKHN0cnVjdCBuZXRk
ZXZfcXVldWUgKmRldl9xdWV1ZSwKIAlfX3NrYl9xdWV1ZV9oZWFkX2luaXQoJnNjaC0+Z3NvX3Nr
Yik7CiAJX19za2JfcXVldWVfaGVhZF9pbml0KCZzY2gtPnNrYl9iYWRfdHhxKTsKIAlnbmV0X3N0
YXRzX2Jhc2ljX3N5bmNfaW5pdCgmc2NoLT5ic3RhdHMpOworCWxvY2tkZXBfcmVnaXN0ZXJfa2V5
KCZzY2gtPnFkaXNjX3R4X3Jvb3Rsb2NrKTsKIAlzcGluX2xvY2tfaW5pdCgmc2NoLT5xLmxvY2sp
OworCWxvY2tkZXBfc2V0X2NsYXNzKCZzY2gtPnEubG9jaywgJnNjaC0+cWRpc2NfdHhfcm9vdGxv
Y2spOwogCiAJaWYgKG9wcy0+c3RhdGljX2ZsYWdzICYgVENRX0ZfQ1BVU1RBVFMpIHsKIAkJc2No
LT5jcHVfYnN0YXRzID0KQEAgLTEwNzAsNiArMTA3Miw3IEBAIHN0YXRpYyB2b2lkIF9fcWRpc2Nf
ZGVzdHJveShzdHJ1Y3QgUWRpc2MgKnFkaXNjKQogCiAJbW9kdWxlX3B1dChvcHMtPm93bmVyKTsK
IAluZXRkZXZfcHV0KGRldiwgJnFkaXNjLT5kZXZfdHJhY2tlcik7CisJbG9ja2RlcF91bnJlZ2lz
dGVyX2tleSgmcWRpc2MtPnFkaXNjX3R4X3Jvb3Rsb2NrKTsKIAogCXRyYWNlX3FkaXNjX2Rlc3Ry
b3kocWRpc2MpOwogCg==
--0000000000009eb0410616291d4d--

