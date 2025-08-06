Return-Path: <netdev+bounces-211849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 877F5B1BE33
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 03:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C1418A63A8
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 01:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC27F16A95B;
	Wed,  6 Aug 2025 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TV6xxwRk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0C2AE97
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 01:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442694; cv=none; b=kxeLENr+uqJqU+T33nWbojEMa0nz1w54suR5/hDgnvpUi29dbujKO4LUWXjVGX0MzuUwA8Y/jj3g3gh6Po9/x1lXrUs/lnJEHSyyuXAYoJsUARjk36A/lqzACEdbv9n2lC8+oKRv7yvfQh8+JclrlBhf440PS2xgRRj5A4hLHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442694; c=relaxed/simple;
	bh=E/w+DRqXb2jFxDHaU6euhPt7TOxgsKSFsApi1bZjEcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/YpPReQn+LRKEEWqRIQNNeZ1RqjxhiyeTuO5opDMJRnrlHQq++EdjBYeAhApapTBUnX+oHZNe/0hh2Ih9gpH1BDRZORGqekQpSSVaohpMh128jOUrjuRNlBhVtcDdmxYkR4xwBYlGNbiIbPjpBHPZzwNaBdGl39B38OUZPjxfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TV6xxwRk; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6155e75a9acso9148339a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 18:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754442691; x=1755047491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d2GKUutMb+CTg/SBIA+X4H18S3n8qy8/RVR5pHccndQ=;
        b=TV6xxwRkIg+yv2/GlIo7VjrUjDygDS0OepvQzt4wtDbe7SQM8IInGiUpuWak1Kvql0
         R7hJplKZuY0LSGrsMJi4YMVTLxAh36vJSIlFnKwXaBoVV69UFRFNY+e1g9U2iFfMP6zD
         OUylYtOC/dYY0S4WRyWVp1v9SXfHfNnAZIckI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754442691; x=1755047491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2GKUutMb+CTg/SBIA+X4H18S3n8qy8/RVR5pHccndQ=;
        b=To+UFrY3qWy0HICPByqYzf9PxXk5qqQmwDurqlbJeVCantEDDL7cSyo2Q3PrF6WlVZ
         WoQR4QjDJzh3xsigQ7F61trBG2ffYVxSNptJU+57VxUJwVPCp4zSUXtwNPCla0Cbt9ch
         Vo4/nxi2Hasq/a5xc3ZDIc2U/CC883cAYOtX7BsHO1Fo15HcgMfZTwfAyh2vgWwMNASv
         gLtQHlkGtiQ8FNe2XKdVgYOCbSlLv+z+Ngt701c8qbXKMIvNOnZCwnjM7Gg2twiiZ7gI
         mUfdBqWND83pyPmDoGsHpYLlhWfyYd9PRuLtrv0VwOIkEOwaHO91nMEl2HB5Emz+EoAL
         MAOw==
X-Forwarded-Encrypted: i=1; AJvYcCW/0b/DYii/59P0qpYl90QtEqC9Yc/dZr4f1VqGmh4OEy9MUXJ6WkYspPRD31Z3BjkcwR5y/Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxloQOjNe1vsn1GXCm94hADRy28LmIGgAmUuB/mt0GWzC+Na8IY
	G+rrmQ78LIgcZ8U5Mcc8Ij4N0Z2+n9wWygBS0KwHX0ARbD7KwB7wzXUCws4nfXqvxgy8a9Nwnww
	W6QnR87fWPA==
X-Gm-Gg: ASbGncsNCT1h+yWvKblhbvlWVLuVx+ivceXMvRdibfWKXTARpaIFU/0lunmQluRR8Jo
	tJpaIJU0qVLEOOHITjofhiQ5F18zZyj+WtRUDUhU77KNond+5J36z2qawAxFa5ekWcLhQ1tFOL7
	vN8DaHRMocRfBWdONK6zS94fshgeoIvdAEnNFZUy3eRNHxErUsQG6pbfVwCEvAIT35w7TTntm/G
	W+/bdMZRw+sHEM17qtVzuOuFLPfLTH93a1b8CZiOQcsSEK3S3xqbYVRLa7L9YVz5l7eFIha68Ae
	wZ8JUnjZeayRXinLOys56vbu9NqpmZBOaoaowtQR792mZk32PsPG4HU+zUQbc27kIqXPHh6gmrH
	WHyAfwWfq3mU/Pmil25RR+g2f56fdBeIHJ/9DHQ9ZtE9zVeGk37uBnemFYSUCL+TZUEvS8Uxv
X-Google-Smtp-Source: AGHT+IG3M3AqKSqDZVyGbssPXNDm2lgr5DIhTOZpm21V4Yg0PQFk2ZTcVVlwjJY6Mv0b/UC9WI8+Mw==
X-Received: by 2002:a17:907:7b9d:b0:af9:34de:e4a1 with SMTP id a640c23a62f3a-af9902e4aacmr103330166b.33.1754442690775;
        Tue, 05 Aug 2025 18:11:30 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e820asm993343966b.90.2025.08.05.18.11.26
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 18:11:26 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af9618282a5so648037866b.2
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 18:11:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvtkHdbbU0Kykx5a13dXJ4mv5ZYSCrOckh9hUT2IdXoSEOAgFtzSaX0BzELWxCKDLEjmCwC9s=@vger.kernel.org
X-Received: by 2002:a17:907:9703:b0:ae3:6651:58ba with SMTP id
 a640c23a62f3a-af9902dffaemr94719466b.35.1754442686168; Tue, 05 Aug 2025
 18:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org> <20250805202848.GC61519@horms.kernel.org>
 <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Aug 2025 04:11:09 +0300
X-Gmail-Original-Message-ID: <CAHk-=wh+bnqPjL=9oq3uEkyZ7WB8=F_QMOHsGjHLj98oYk-X3Q@mail.gmail.com>
X-Gm-Features: Ac12FXx151gZKxn5F0B-h1oNAfMmrkA84RTvsrxwBVO-1UWY7oBd7NqVoQGVGt8
Message-ID: <CAHk-=wh+bnqPjL=9oq3uEkyZ7WB8=F_QMOHsGjHLj98oYk-X3Q@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on() call placement
To: Simon Horman <horms@kernel.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, Oliver Neukum <oneukum@suse.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux Netdev Mailing List <netdev@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org, 
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Content-Type: multipart/mixed; boundary="00000000000016f79a063ba80507"

--00000000000016f79a063ba80507
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 01:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And no, I didn't actually test that version, because I was hoping that
> somebody who actually knows this code better would pipe up.

Bah. Since I'm obviously horribly jetlagged, I decided to just test to
make sure I understand the code.

And yeah, the attached patch also fixes the problem for me and makes
more sense to me.

But again, it would be good to get comments from people who *actually*
know the code.


              Linus

--00000000000016f79a063ba80507
Content-Type: application/x-patch; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mdz5fpf80>
X-Attachment-Id: f_mdz5fpf80

IGRyaXZlcnMvbmV0L3VzYi91c2JuZXQuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3Vz
Yi91c2JuZXQuYyBiL2RyaXZlcnMvbmV0L3VzYi91c2JuZXQuYwppbmRleCBhMzhmZmJmNGIzZjAu
LjUxMWM0MTU0Y2Y3NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvdXNiL3VzYm5ldC5jCisrKyBi
L2RyaXZlcnMvbmV0L3VzYi91c2JuZXQuYwpAQCAtMTEyMCw2ICsxMTIwLDkgQEAgc3RhdGljIHZv
aWQgX19oYW5kbGVfbGlua19jaGFuZ2Uoc3RydWN0IHVzYm5ldCAqZGV2KQogCWlmICghdGVzdF9i
aXQoRVZFTlRfREVWX09QRU4sICZkZXYtPmZsYWdzKSkKIAkJcmV0dXJuOwogCisJaWYgKHRlc3Rf
YW5kX2NsZWFyX2JpdChFVkVOVF9MSU5LX0NBUlJJRVJfT04sICZkZXYtPmZsYWdzKSkKKwkJbmV0
aWZfY2Fycmllcl9vbihkZXYtPm5ldCk7CisKIAlpZiAoIW5ldGlmX2NhcnJpZXJfb2soZGV2LT5u
ZXQpKSB7CiAJCS8qIGtpbGwgVVJCcyBmb3IgcmVhZGluZyBwYWNrZXRzIHRvIHNhdmUgYnVzIGJh
bmR3aWR0aCAqLwogCQl1bmxpbmtfdXJicyhkZXYsICZkZXYtPnJ4cSk7CkBAIC0xMTI5LDkgKzEx
MzIsNiBAQCBzdGF0aWMgdm9pZCBfX2hhbmRsZV9saW5rX2NoYW5nZShzdHJ1Y3QgdXNibmV0ICpk
ZXYpCiAJCSAqIHR4IHF1ZXVlIGlzIHN0b3BwZWQgYnkgbmV0Y29yZSBhZnRlciBsaW5rIGJlY29t
ZXMgb2ZmCiAJCSAqLwogCX0gZWxzZSB7Ci0JCWlmICh0ZXN0X2FuZF9jbGVhcl9iaXQoRVZFTlRf
TElOS19DQVJSSUVSX09OLCAmZGV2LT5mbGFncykpCi0JCQluZXRpZl9jYXJyaWVyX29uKGRldi0+
bmV0KTsKLQogCQkvKiBzdWJtaXR0aW5nIFVSQnMgZm9yIHJlYWRpbmcgcGFja2V0cyAqLwogCQlx
dWV1ZV93b3JrKHN5c3RlbV9iaF93cSwgJmRldi0+Ymhfd29yayk7CiAJfQo=
--00000000000016f79a063ba80507--

