Return-Path: <netdev+bounces-98080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0BA8CF28F
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 07:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A1A28135D
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 05:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE231A2C1F;
	Sun, 26 May 2024 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q04vE/Nn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA417D2
	for <netdev@vger.kernel.org>; Sun, 26 May 2024 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716700083; cv=none; b=d3WXF8rtYYq4wbrzoBhzXhaspMtu3YzW/pu+H/Ren8Ulqg7XJUU2efMZVNWb1KWb7nw1gDkyUe5y28+8Gr8iCHTR4JGkY9YzUJAXCi6KfZXNVych/eCxlhc8/Z/Y+SIofKuS3kCfUkWW8z1GZuDlQfad1KxkRA6mPYd9zG3bL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716700083; c=relaxed/simple;
	bh=6TpbQGOzm1TK1AWkb7x1al1XxOWPdbLNGq+G4FKAa2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhZMm5Fw2Un9/HZ1MpjUCQ2fx8hTe/uLeFubwCe0UccKdiivIiNf2P5gVJUluHQMz58x7wGq8Mth9+Zx7ZBYvzIfuxDzJt6sEtDRbGBUn4TqP2wJbopXLXmaSDgAtXxjLFcb5EaQL0rvBQO9W94cl5JOMRY3KSlp5t8ww4z7s+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q04vE/Nn; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5295eb47b48so2246974e87.1
        for <netdev@vger.kernel.org>; Sat, 25 May 2024 22:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716700079; x=1717304879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W9v3n21tw1t78rmDeyKZUV+aOEclcFgn/2PUfzT+BoM=;
        b=Q04vE/Nnj+16ipLa2upSwj47oto6kxUqiM1xNpD3IZSWAr/H3Cta7/l4WI2M+rSDhB
         gf2OHUXLUkGtY17Kb/eglxxJy+0+0WwCNdXUaM99+f5NUuUfp+0hzmTyoGNfqsHoa9JM
         pq/69JS9lIA0eojHNZBDviceiL6lI9G8UbKjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716700079; x=1717304879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9v3n21tw1t78rmDeyKZUV+aOEclcFgn/2PUfzT+BoM=;
        b=NXM76ab1oVVfzPnuJBnUIwMSC/sXu8WbPEqt/Aq7RjneisfMO6y4/dsoFQUXBWIYuG
         Mp+UwCQlTC35DtaAA4Ts2O1gv8TRIWn73mRNsP5JLlz4ae/W9VdOPG4x4qVRChe6K3Rh
         v1Tad+PkaEQ+cUVWKDtyW0K0SqUNL11H4/WnRzycdEtjGmK9CksOshzjTCo4RFDiSuru
         EJxD9syOT1mQVBPt/SACENxiKkKPR8ZDLMEyJWrvvMVI53NO4ABM0FoE3gkhw2lmJvx6
         shYSt4/8ovGLTQrPqW5CI99cFJdil6TO8E/um+4IsZgorWxy9wnPtqARY8qQvNPZYVnu
         HxTQ==
X-Gm-Message-State: AOJu0YxmQ+PmkqHgoa89DX1Kb3izSLKpYiGYn41GDmdn2bl6Shzp5jhA
	30DK6vaEx8MMhcZGCFem2TG3EJguunB1ZddiJhy/7JlA/ibS0Bf/AxkKEDkoWrF05cf8Lm5zaJF
	8AgWfzg==
X-Google-Smtp-Source: AGHT+IHNDW47OPqaqwxG4ugUSBHrCYugr8VYrjNle3k9A+aRm7oUPdHMjCCXoPTr6v03ohWn+evr8g==
X-Received: by 2002:a05:6512:2208:b0:522:4062:6e79 with SMTP id 2adb3069b0e04-5296519a4f5mr3642688e87.31.1716700078859;
        Sat, 25 May 2024 22:07:58 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578523d5e8bsm4043928a12.41.2024.05.25.22.07.57
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 22:07:57 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6265d3ccf7so255092366b.0
        for <netdev@vger.kernel.org>; Sat, 25 May 2024 22:07:57 -0700 (PDT)
X-Received: by 2002:a17:906:d18d:b0:a59:ab57:741e with SMTP id
 a640c23a62f3a-a6265112305mr426487966b.76.1716700077223; Sat, 25 May 2024
 22:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526034506.GZ2118490@ZenIV>
In-Reply-To: <20240526034506.GZ2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 May 2024 22:07:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
Message-ID: <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight fdget/fdput (resend)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004a2ad90619546221"

--0000000000004a2ad90619546221
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 May 2024 at 20:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Checking the theory that the important part in sockfd_lookup_light() is
> avoiding needless file refcount operations, not the marginal reduction
> of the register pressure from not keeping a struct file pointer in the
> caller.

Yeah, the register pressure thing is not likely an issue. That said, I
think we can fix it.

> If that's true, we should get the same benefits from straight fdget()/fdput().

Agreed.

That said, your patch is just horrendous.

> +static inline bool fd_empty(struct fd f)
> +{
> +       // better code with gcc that way
> +       return unlikely(!(f.flags | (unsigned long)f.file));
> +}

Ok, this is disgusting. I went all "WTF?"

And then looked at why you would say that testing two different fields
in a 'struct fd' would possibly be better than just checking one.

And I see why that's the case - it basically short-circuits the
(inlined) __to_fd() logic, and the compiler can undo it and look at
the original single-word value.

But it's still disgusting. If there is anything else in between, the
compiler wouldn't then notice any more.

What we *really* should do is have 'struct fd' just *be* that
single-word value, never expand it to two words at all, and instead of
doing "fd.file" we'd do "fd_file(fd)" and "fd_flags(fd)".

Maybe it's not too late to do that?

This is *particularly* true for the socket code that doesn't even want
the 'struct file *' at all outside of that "check that it's a socket,
then turn it into a socket pointer". So _particularly_ in that
context, having a "fd_file()" helper to do the (trivial) unpacking
would work very well.

But even without changing 'struct fd', maybe we could just have
"__fdget()" and friends not return a "unsigned long", but a "struct
rawfd".

Which would is a struct with an unsigned long.

There's actually a possible future standard C++ extension for what we
want to do ("C++ tagged pointers") and while it might make it into C
eventually, we'd have to do it manully with ugly inline helpers (LLVM
does it manually in C++ with a PointerIntPair class).

IOW, we could do something like the attached. I think it's actually
almost a cleanup, and now your socket things can use "struct rawfd"
and that fd_empty() becomes

   static inline bool rawfd_empty(struct rawfd raw)
   { return !raw.word; }

instead. Still somewhat disgusting, but now it's a "C doesn't have
tagged pointers, so we do this by hand" _understandable_ disgusting.

Hmm? The attached patch compiles. It looks "ObviouslyCorrect(tm)". But
it might be "TotallyBroken(tm)". You get the idea.

               Linus

--0000000000004a2ad90619546221
Content-Type: application/x-patch; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lwn2kuaq0>
X-Attachment-Id: f_lwn2kuaq0

IGZzL2ZpbGUuYyAgICAgICAgICAgIHwgMjIgKysrKysrKysrKystLS0tLS0tLS0tLQogaW5jbHVk
ZS9saW51eC9maWxlLmggfCAyMiArKysrKysrKysrKysrKysrKy0tLS0tCiAyIGZpbGVzIGNoYW5n
ZWQsIDI4IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2Zp
bGUuYyBiL2ZzL2ZpbGUuYwppbmRleCA4MDc2YWVmOWMyMTAuLmExZjQ0NzYwZGRiZiAxMDA2NDQK
LS0tIGEvZnMvZmlsZS5jCisrKyBiL2ZzL2ZpbGUuYwpAQCAtMTEyOCw3ICsxMTI4LDcgQEAgRVhQ
T1JUX1NZTUJPTCh0YXNrX2xvb2t1cF9uZXh0X2ZkZ2V0X3JjdSk7CiAgKiBUaGUgZnB1dF9uZWVk
ZWQgZmxhZyByZXR1cm5lZCBieSBmZ2V0X2xpZ2h0IHNob3VsZCBiZSBwYXNzZWQgdG8gdGhlCiAg
KiBjb3JyZXNwb25kaW5nIGZwdXRfbGlnaHQuCiAgKi8KLXN0YXRpYyB1bnNpZ25lZCBsb25nIF9f
ZmdldF9saWdodCh1bnNpZ25lZCBpbnQgZmQsIGZtb2RlX3QgbWFzaykKK3N0YXRpYyBzdHJ1Y3Qg
cmF3ZmQgX19mZ2V0X2xpZ2h0KHVuc2lnbmVkIGludCBmZCwgZm1vZGVfdCBtYXNrKQogewogCXN0
cnVjdCBmaWxlc19zdHJ1Y3QgKmZpbGVzID0gY3VycmVudC0+ZmlsZXM7CiAJc3RydWN0IGZpbGUg
KmZpbGU7CkBAIC0xMTQ1LDIyICsxMTQ1LDIyIEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIF9fZmdl
dF9saWdodCh1bnNpZ25lZCBpbnQgZmQsIGZtb2RlX3QgbWFzaykKIAlpZiAobGlrZWx5KGF0b21p
Y19yZWFkX2FjcXVpcmUoJmZpbGVzLT5jb3VudCkgPT0gMSkpIHsKIAkJZmlsZSA9IGZpbGVzX2xv
b2t1cF9mZF9yYXcoZmlsZXMsIGZkKTsKIAkJaWYgKCFmaWxlIHx8IHVubGlrZWx5KGZpbGUtPmZf
bW9kZSAmIG1hc2spKQotCQkJcmV0dXJuIDA7Ci0JCXJldHVybiAodW5zaWduZWQgbG9uZylmaWxl
OworCQkJcmV0dXJuIEVNUFRZX1JBV0ZEOworCQlyZXR1cm4gKHN0cnVjdCByYXdmZCkgeyAodW5z
aWduZWQgbG9uZylmaWxlIH07CiAJfSBlbHNlIHsKIAkJZmlsZSA9IF9fZmdldF9maWxlcyhmaWxl
cywgZmQsIG1hc2spOwogCQlpZiAoIWZpbGUpCi0JCQlyZXR1cm4gMDsKLQkJcmV0dXJuIEZEUFVU
X0ZQVVQgfCAodW5zaWduZWQgbG9uZylmaWxlOworCQkJcmV0dXJuIEVNUFRZX1JBV0ZEOworCQly
ZXR1cm4gKHN0cnVjdCByYXdmZCkgeyBGRFBVVF9GUFVUIHwgKHVuc2lnbmVkIGxvbmcpZmlsZSB9
OwogCX0KIH0KLXVuc2lnbmVkIGxvbmcgX19mZGdldCh1bnNpZ25lZCBpbnQgZmQpCitzdHJ1Y3Qg
cmF3ZmQgX19mZGdldCh1bnNpZ25lZCBpbnQgZmQpCiB7CiAJcmV0dXJuIF9fZmdldF9saWdodChm
ZCwgRk1PREVfUEFUSCk7CiB9CiBFWFBPUlRfU1lNQk9MKF9fZmRnZXQpOwogCi11bnNpZ25lZCBs
b25nIF9fZmRnZXRfcmF3KHVuc2lnbmVkIGludCBmZCkKK3N0cnVjdCByYXdmZCBfX2ZkZ2V0X3Jh
dyh1bnNpZ25lZCBpbnQgZmQpCiB7CiAJcmV0dXJuIF9fZmdldF9saWdodChmZCwgMCk7CiB9CkBA
IC0xMTgxLDEzICsxMTgxLDEzIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBmaWxlX25lZWRzX2ZfcG9z
X2xvY2soc3RydWN0IGZpbGUgKmZpbGUpCiAJCShmaWxlX2NvdW50KGZpbGUpID4gMSB8fCBmaWxl
LT5mX29wLT5pdGVyYXRlX3NoYXJlZCk7CiB9CiAKLXVuc2lnbmVkIGxvbmcgX19mZGdldF9wb3Mo
dW5zaWduZWQgaW50IGZkKQorc3RydWN0IHJhd2ZkIF9fZmRnZXRfcG9zKHVuc2lnbmVkIGludCBm
ZCkKIHsKLQl1bnNpZ25lZCBsb25nIHYgPSBfX2ZkZ2V0KGZkKTsKLQlzdHJ1Y3QgZmlsZSAqZmls
ZSA9IChzdHJ1Y3QgZmlsZSAqKSh2ICYgfjMpOworCXN0cnVjdCByYXdmZCB2ID0gX19mZGdldChm
ZCk7CisJc3RydWN0IGZpbGUgKmZpbGUgPSBmZGZpbGUodik7CiAKIAlpZiAoZmlsZSAmJiBmaWxl
X25lZWRzX2ZfcG9zX2xvY2soZmlsZSkpIHsKLQkJdiB8PSBGRFBVVF9QT1NfVU5MT0NLOworCQl2
LndvcmQgfD0gRkRQVVRfUE9TX1VOTE9DSzsKIAkJbXV0ZXhfbG9jaygmZmlsZS0+Zl9wb3NfbG9j
ayk7CiAJfQogCXJldHVybiB2OwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9maWxlLmggYi9p
bmNsdWRlL2xpbnV4L2ZpbGUuaAppbmRleCA0NWQwZjQ4MDBhYmQuLjYwM2FhMzJmOTg1YyAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC9maWxlLmgKKysrIGIvaW5jbHVkZS9saW51eC9maWxlLmgK
QEAgLTQyLDYgKzQyLDE4IEBAIHN0cnVjdCBmZCB7CiAjZGVmaW5lIEZEUFVUX0ZQVVQgICAgICAg
MQogI2RlZmluZSBGRFBVVF9QT1NfVU5MT0NLIDIKIAorLyogIlRhZ2dlZCBmaWxlIHBvaW50ZXIi
ICovCitzdHJ1Y3QgcmF3ZmQgeworCXVuc2lnbmVkIGxvbmcgd29yZDsKK307CisjZGVmaW5lIEVN
UFRZX1JBV0ZEIChzdHJ1Y3QgcmF3ZmQpIHsgMCB9CisKK3N0YXRpYyBpbmxpbmUgc3RydWN0IGZp
bGUgKmZkZmlsZShzdHJ1Y3QgcmF3ZmQgcmF3KQoreyByZXR1cm4gKHN0cnVjdCBmaWxlICopIChy
YXcud29yZCAmIH4zKTsgfQorCitzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBmZGZsYWdzKHN0
cnVjdCByYXdmZCByYXcpCit7IHJldHVybiByYXcud29yZCAmIDM7IH0KKwogc3RhdGljIGlubGlu
ZSB2b2lkIGZkcHV0KHN0cnVjdCBmZCBmZCkKIHsKIAlpZiAoZmQuZmxhZ3MgJiBGRFBVVF9GUFVU
KQpAQCAtNTEsMTQgKzYzLDE0IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBmZHB1dChzdHJ1Y3QgZmQg
ZmQpCiBleHRlcm4gc3RydWN0IGZpbGUgKmZnZXQodW5zaWduZWQgaW50IGZkKTsKIGV4dGVybiBz
dHJ1Y3QgZmlsZSAqZmdldF9yYXcodW5zaWduZWQgaW50IGZkKTsKIGV4dGVybiBzdHJ1Y3QgZmls
ZSAqZmdldF90YXNrKHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywgdW5zaWduZWQgaW50IGZkKTsK
LWV4dGVybiB1bnNpZ25lZCBsb25nIF9fZmRnZXQodW5zaWduZWQgaW50IGZkKTsKLWV4dGVybiB1
bnNpZ25lZCBsb25nIF9fZmRnZXRfcmF3KHVuc2lnbmVkIGludCBmZCk7Ci1leHRlcm4gdW5zaWdu
ZWQgbG9uZyBfX2ZkZ2V0X3Bvcyh1bnNpZ25lZCBpbnQgZmQpOworZXh0ZXJuIHN0cnVjdCByYXdm
ZCBfX2ZkZ2V0KHVuc2lnbmVkIGludCBmZCk7CitleHRlcm4gc3RydWN0IHJhd2ZkIF9fZmRnZXRf
cmF3KHVuc2lnbmVkIGludCBmZCk7CitleHRlcm4gc3RydWN0IHJhd2ZkIF9fZmRnZXRfcG9zKHVu
c2lnbmVkIGludCBmZCk7CiBleHRlcm4gdm9pZCBfX2ZfdW5sb2NrX3BvcyhzdHJ1Y3QgZmlsZSAq
KTsKIAotc3RhdGljIGlubGluZSBzdHJ1Y3QgZmQgX190b19mZCh1bnNpZ25lZCBsb25nIHYpCitz
dGF0aWMgaW5saW5lIHN0cnVjdCBmZCBfX3RvX2ZkKHN0cnVjdCByYXdmZCByYXcpCiB7Ci0JcmV0
dXJuIChzdHJ1Y3QgZmQpeyhzdHJ1Y3QgZmlsZSAqKSh2ICYgfjMpLHYgJiAzfTsKKwlyZXR1cm4g
KHN0cnVjdCBmZCl7ZmRmaWxlKHJhdyksZmRmbGFncyhyYXcpfTsKIH0KIAogc3RhdGljIGlubGlu
ZSBzdHJ1Y3QgZmQgZmRnZXQodW5zaWduZWQgaW50IGZkKQo=
--0000000000004a2ad90619546221--

