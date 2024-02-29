Return-Path: <netdev+bounces-76267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41DA86D0B7
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282DC1F24A5E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7230370AD3;
	Thu, 29 Feb 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UkPwfEB4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73B6CBF3
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227973; cv=none; b=asDbuaOSdjpyrH28qRYFVNVvqeTgrV2EOFyOrOhuJ4ffi9gMWCojbsjPfhGVOslIt7Kmd0s1yo4hjFgUfmwMx3SqcuE0bsCO0N5i96PGbEj4iBqZwDU5t1R9Az6wN/upiISraRjsuVW5XGVB0OxQF6Eteuf5VshZSoyJaCmbPzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227973; c=relaxed/simple;
	bh=jzGj5I4LRuYklOQyJfNOnG7oivOkxoCVa97TajgQgCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BitHi7aGA8+Y+lvSXv7S+ctoMSv5axEHKSrsoVUIIqyxXnGjr4OgQd3mt0Q/dM9DzuTmSCreKXSWYs5+3i5HGZ5KgHzFGKiBDIWaHmpyRmfdQnKLfIdns5EA6CsVmdxFzQIYgqQVJyJwwGooDe9asRV6zbjNRHvPQNLyw1WeA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UkPwfEB4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a26fa294e56so231258766b.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709227969; x=1709832769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JQrqXSOy2jKpIC5hjgybMDfk5pI8gvMKo0UOhxnaCp0=;
        b=UkPwfEB4O6Y6ht2USoBSG/iMVrIqf1j5RMbMgxabuAJkeVL8qQLd3VEOJrEp93s8pu
         Lh8Ssf+TE3jpPEtTfzCN9mC/qbm04xvvUsmhPghUtWBelhS5yDBWEEpy4BZJZnOgG7Eu
         NbSQved5jtliTlseHJSmjtSjjSOOLVFXZOZ+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227969; x=1709832769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQrqXSOy2jKpIC5hjgybMDfk5pI8gvMKo0UOhxnaCp0=;
        b=IlrdzsObrEUVaRZgImfTIUMUNGFa1vDYXJ9yF6Zism8xjvK+rXi/B2ycp/p+7nhi8d
         NTldKqnYyyghz6UZLnEBpnV4als7D8lJJ5YKD4fPANQZ32f20B/eNxwcQAqg3T1tY2Y1
         oxjPn9JURW3jDU3lfZJbps0NuiVFO6rzA0xQPRbQ3qikf7iRVqziviMntI5fs6Bi9aDF
         g6eWJ8cv89xEAnYXkTqxEDHnh+8R2+AHRB/YP8mwmLfX9NAX3Lh5DBowegd6/t3pz2Ld
         X57SdTPaTuFu2Vaw+uZIEMaDV41vc+rt7B8nlakmLNYAqkM9AeTyBwCqec4/0NgjLulZ
         ZKHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoA3Bh0Ob+TO1DX0wurTNo7EDFsVDofDmtEISBEvGaHxiaMnRk18DlxLHUaoaxyy/rnCIbPnayIYW/TM4Iwe+7NP5jkDVH
X-Gm-Message-State: AOJu0YxqCYIE8FIEautYMcpAO6uGonP81y7AHKRn0QWmKMKsaPWHA/En
	5ENak2MT0/5FIMxwN+Mrrtid1+GKeSlP/EkXiPl7JbhJQT2gQMoLI+0aNB/FQzOIyrnKpSnejEV
	9ya7QkQ==
X-Google-Smtp-Source: AGHT+IFvBmRzSCOD6JchFFoswMbegUCQMwB/LD7jbDUaj0Icr1waDbqGxWOZdJoA/ZS0IvriX+gRBg==
X-Received: by 2002:a17:906:6848:b0:a44:235:9b31 with SMTP id a8-20020a170906684800b00a4402359b31mr1967774ejs.50.1709227969222;
        Thu, 29 Feb 2024 09:32:49 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090699cc00b00a43e573146asm875663ejn.100.2024.02.29.09.32.48
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:32:48 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so1906970a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:32:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/vwSZU9+P8J+WRChfczP8GovXY52+GMFbDaVDhXVf+ch1S04jwnvMlrNG9ajliEVPB0f+Leif8lXBP721RY7qAPXiRVmu
X-Received: by 2002:a17:906:b78e:b0:a44:176e:410c with SMTP id
 dt14-20020a170906b78e00b00a44176e410cmr2046490ejb.5.1709227968058; Thu, 29
 Feb 2024 09:32:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com> <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com>
In-Reply-To: <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 Feb 2024 09:32:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
Message-ID: <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>, Al Viro <viro@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <christian@brauner.io>, David Laight <David.Laight@aculab.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: multipart/mixed; boundary="000000000000e07d49061288a5ca"

--000000000000e07d49061288a5ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Feb 2024 at 00:13, Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> See the logic before this patch, always success (((void)(K),0)) is
> returned for three types: ITER_BVEC, ITER_KVEC and ITER_XARRAY.

No, look closer.

Yes, the iterate_and_advance() macro does that "((void)(K),0)" to make
the compiler generate better code for those cases (because then the
compiler can see that the return value is a compile-time zero), but
notice how _copy_mc_to_iter() didn't use that macro back then. It used
the unvarnished __iterate_and_advance() exactly so that the MC copy
case would *not* get that "always return zero" behavior.

That goes back to (in a different form) at least commit 1b4fb5ffd79b
("iov_iter: teach iterate_{bvec,xarray}() about possible short
copies").

But hardly anybody ever tests this machine-check special case code, so
who knows when it broke again.

I'm just looking at the source code, and with all the macro games it's
*really* hard to follow, so I may well be missing something.

> Maybe we're all gonna fix it back? as follows=EF=BC=9A

No. We could do it for the kvec and xarray case, just to get better
code generation again (not that I looked at it, so who knows), but the
one case that actually uses memcpy_from_iter_mc() needs to react to a
short write.

One option might be to make a failed memcpy_from_iter_mc() set another
flag in the iter, and then make fault_in_iov_iter_readable() test that
flag and return 'len' if that flag is set.

Something like that (wild handwaving) should get the right error handling.

The simpler alternative is maybe something like the attached.
COMPLETELY UNTESTED. Maybe I've confused myself with all the different
indiraction mazes in the iov_iter code.

                     Linus

--000000000000e07d49061288a5ca
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lt7i5gtw0>
X-Attachment-Id: f_lt7i5gtw0

IGxpYi9pb3ZfaXRlci5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2xpYi9pb3ZfaXRlci5jIGIvbGliL2lvdl9p
dGVyLmMKaW5kZXggZTBhYTZiNDQwY2E1Li41MjM2YzE2NzM0ZTAgMTAwNjQ0Ci0tLSBhL2xpYi9p
b3ZfaXRlci5jCisrKyBiL2xpYi9pb3ZfaXRlci5jCkBAIC0yNDgsNyArMjQ4LDEwIEBAIHN0YXRp
YyBfX2Fsd2F5c19pbmxpbmUKIHNpemVfdCBtZW1jcHlfZnJvbV9pdGVyX21jKHZvaWQgKml0ZXJf
ZnJvbSwgc2l6ZV90IHByb2dyZXNzLAogCQkJICAgc2l6ZV90IGxlbiwgdm9pZCAqdG8sIHZvaWQg
KnByaXYyKQogewotCXJldHVybiBjb3B5X21jX3RvX2tlcm5lbCh0byArIHByb2dyZXNzLCBpdGVy
X2Zyb20sIGxlbik7CisJc2l6ZV90IG4gPSBjb3B5X21jX3RvX2tlcm5lbCh0byArIHByb2dyZXNz
LCBpdGVyX2Zyb20sIGxlbik7CisJaWYgKG4pCisJCW1lbXNldCh0byArIHByb2dyZXNzIC0gbiwg
MCwgbik7CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBzaXplX3QgX19jb3B5X2Zyb21faXRlcl9t
Yyh2b2lkICphZGRyLCBzaXplX3QgYnl0ZXMsIHN0cnVjdCBpb3ZfaXRlciAqaSkK
--000000000000e07d49061288a5ca--

