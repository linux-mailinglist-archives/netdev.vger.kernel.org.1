Return-Path: <netdev+bounces-241622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8D6C86E7F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F250D4E1809
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8B327991E;
	Tue, 25 Nov 2025 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHr6Yjr9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121223ED6A
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101036; cv=none; b=b2mpmxinGQdGdQTXz7ts+g1Ji8UEWaY/L6WEptPce1pHHELDX0FUHasDP8EEnqtR+pqATPQKv17u9iqh9dAMIJ0dUCot1Vuw4Wrv4J01ratAAvj8/Jn/i41VMhxqMldOoaauIypQe5cdu9OV9WEtZ4XrvtlXb3WeJEo08l41m7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101036; c=relaxed/simple;
	bh=C8jg7cw88VrjTTSzHfQFbtAOY+Ta6vQREkrhHnqNSk0=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To; b=h/qt2jHkstGHQC3n4+ZFRAY55qcDYvsDoDS0ZRuKQk89F8qtrHx+CWuTyWCBYFC+45U3LnH6ktF4CDG4RiyipZwmk7ddO4R+yDTLdAwOGQknllQToX+LIepNUdDKm5/3oRaZtb72MTegdqJECYreTU/RnwoWldnakn/alRL1lSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHr6Yjr9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-340e525487eso4053331a91.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 12:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764101034; x=1764705834; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8jg7cw88VrjTTSzHfQFbtAOY+Ta6vQREkrhHnqNSk0=;
        b=HHr6Yjr9oI2s2PpCUx0m678HdPuwXCK5/YGHkx96Ktn8XhAvFuSqAFJpnoc22Tey6M
         5NqdfOSbbUUj4HSE+X1tvHGNOD+OGnXsJW9bj+d4LG1u3Jg3fnz0r5n6EtduFrePN+WQ
         JVtCwCKlgBWgEBUY/32U5WIsOHwBZ21xZMlHxGcytN7pJSW/XmIbcHDW9qjAX/IBrxDR
         tXcqbsc3QH4dxfEhSyqgYqzAO2Sjr47ZQF+8vfZY6cnx3e+6cbDNjh6OBIzcWyjkfBJg
         +LMnXcjgCcqI3EE1HP9Wz2f4Jk2ZzwB5ZDYUvWJkZFI+4Agu2+fnj1332/3dlNniB8ZB
         R6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764101034; x=1764705834;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8jg7cw88VrjTTSzHfQFbtAOY+Ta6vQREkrhHnqNSk0=;
        b=opt1t1xDf1v7OuPG+obamdNSdqBIvg7cwSwMzcoVQ26OTYNKohIvQCx6jasckcVKf/
         u7wy35qgj+uhODuzhWgG81DmUImRRyfysHMiN+kqoyMi30G79jTHCqFX45zVcb3JKY/3
         Slmzv4iDcNdI/q/snx+4bTXRzgZGhHWUJ5EkMNhb3BL8OuKRkquLWAPRKTHMTvKB4oXX
         CCu+OQNC38mwp531dyau6u++tq0ceqPnlzKBtM5LhPeoBPQyUIGfNPd3biStSg7s4DGG
         Xu9pF6YS2HvlKzJdQPsuM1+B5vrsC2fjUhAxTRoyn0RyulPabelrLln4lUCOK+XldCKK
         3DBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhH2jTSRJXgQdO4M/m8lRNkRx7degoHIsTDmXG4yjReEK1mJ76KESvt2cTfTL+41fO+5i2nDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx/9zdqX7toRg4HJh1ece267ZH8MENEENE33XduRB+F1Ts7rtn
	DFKLHdhboayO3DqjDLId7i2Nkw9h98r6TcWA/lDP+fiDAPOfdN0t+VtG
X-Gm-Gg: ASbGncuek/zkOTa090XLZXZb7ns8BBUscM8r4Wh7nGcFJQnO9a+yUOS4i8YaC6K/i26
	SsWzlkA7wLz4vjWevN7vtbvgYAIc6AJnRtG0bbcIbPm6mZPJ7LQO1T+ikoQGkysXibxWFpbaeST
	L5tA864MXF+GzP3FKeDuw3cYHXVTtTbWwxR4+oLITj8batjZqT2UXcKcXfb3TUfsVaFmUrHSVP4
	rCothVKU59XA3lkz671BTijEkwJ8ChtEFwhQpEyKxCmviGFGapKtPkwqBlTqagllvttI4d/UT0i
	johqJUj4l3p9EsPQlOfIY2QGZ7DdL85ZL6HAzYc47/5cnM/yc8VwIB/3EH/2ijGwW6I05V3sVOR
	CgyyMTmB8FRUE7k1CdkhhVrVLIy+haWz8s5VbqIbzBvMZvAy5gTLVqGGsdZneezE5t0fJnbmR4+
	NbVjHy4dNBSbH677s5Xa+MJzZr9UHrRKVNvN6dx6V3z9/wPHQb4Eq4HxE=
X-Google-Smtp-Source: AGHT+IGLRcweSJnktR2EtMTpKvxQPqdgie3fjOemL6smjB+hPEZlOzIfRl0bqSfIDRhhqUbwHrxyGw==
X-Received: by 2002:a17:90b:5588:b0:341:8ac6:2244 with SMTP id 98e67ed59e1d1-34733e7677amr15330166a91.9.1764101033885;
        Tue, 25 Nov 2025 12:03:53 -0800 (PST)
Received: from ?IPV6:2405:201:31:d869:2a74:b29f:f7bf:865c? ([2405:201:31:d869:2a74:b29f:f7bf:865c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476004dc3dsm1233033a91.9.2025.11.25.12.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 12:03:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------tuNW2XxNaqyyWBk1xGlWGOZ3"
Message-ID: <38778a8e-ddd2-44a6-8d45-d6871de34f30@gmail.com>
Date: Wed, 26 Nov 2025 01:33:41 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6925da1b.a70a0220.d98e3.00af.GAE@google.com>
Subject: Re: [syzbot] [batman?] KMSAN: uninit-value in skb_clone
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <6925da1b.a70a0220.d98e3.00af.GAE@google.com>

This is a multi-part message in MIME format.
--------------tuNW2XxNaqyyWBk1xGlWGOZ3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

--------------tuNW2XxNaqyyWBk1xGlWGOZ3
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-hsr-fix-NULL-pointer-dereference-in-skb_clone-with-h.patch"
Content-Disposition: attachment;
 filename*0="0001-hsr-fix-NULL-pointer-dereference-in-skb_clone-with-h.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmZjY2ZGQ4NDBkOTNlZmU1OTE0YTgyNGIwZDRkNTgwMzExMTVkNzg4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaGF1cnlhIFJhbmUgPHNzcmFuZV9iMjNAZWUudmp0
aS5hYy5pbj4KRGF0ZTogV2VkLCAyNiBOb3YgMjAyNSAwMToyNTowMyArMDUzMApTdWJqZWN0
OiBbUEFUQ0hdIGhzcjogZml4IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiBza2JfY2xv
bmUgd2l0aCBodyB0YWcKIGluc2VydGlvbgoKV2hlbiBoYXJkd2FyZSBIU1IgdGFnIGluc2Vy
dGlvbiBpcyBlbmFibGVkIChORVRJRl9GX0hXX0hTUl9UQUdfSU5TKSBhbmQKZnJhbWUtPnNr
Yl9zdGQgaXMgTlVMTCwgYm90aCBoc3JfY3JlYXRlX3RhZ2dlZF9mcmFtZSgpIGFuZApwcnBf
Y3JlYXRlX3RhZ2dlZF9mcmFtZSgpIHdpbGwgY2FsbCBza2JfY2xvbmUoKSB3aXRoIGEgTlVM
TCBza2IgcG9pbnRlciwKY2F1c2luZyBhIGtlcm5lbCBjcmFzaC4KCkZpeCB0aGlzIGJ5IGFk
ZGluZyBOVUxMIGNoZWNrcyBmb3IgZnJhbWUtPnNrYl9zdGQgYmVmb3JlIGNhbGxpbmcKc2ti
X2Nsb25lKCkgaW4gdGhlIGZ1bmN0aW9ucy4KClJlcG9ydGVkLWJ5OiBzeXpib3QrMmZhMzQ0
MzQ4YTU3OWI3NzllMDVAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpGaXhlczogZjI2NmE2
ODNhNDgwIChcIm5ldC9oc3I6IEJldHRlciBmcmFtZSBkaXNwYXRjaFwiKQoKU2lnbmVkLW9m
Zi1ieTogU2hhdXJ5YSBSYW5lIDxzc3JhbmVfYjIzQGVlLnZqdGkuYWMuaW4+Ci0tLQogbmV0
L2hzci9oc3JfZm9yd2FyZC5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbmV0L2hzci9oc3JfZm9yd2FyZC5jIGIvbmV0L2hz
ci9oc3JfZm9yd2FyZC5jCmluZGV4IDMzOWYwZDIyMDIxMi4uNGMxYTMxMWI5MDBmIDEwMDY0
NAotLS0gYS9uZXQvaHNyL2hzcl9mb3J3YXJkLmMKKysrIGIvbmV0L2hzci9oc3JfZm9yd2Fy
ZC5jCkBAIC0yMTEsNiArMjExLDkgQEAgc3RydWN0IHNrX2J1ZmYgKnBycF9nZXRfdW50YWdn
ZWRfZnJhbWUoc3RydWN0IGhzcl9mcmFtZV9pbmZvICpmcmFtZSwKIAkJCQkgIF9fRklMRV9f
LCBfX0xJTkVfXywgcG9ydC0+ZGV2LT5uYW1lKTsKIAkJCXJldHVybiBOVUxMOwogCQl9CisK
KwkJaWYgKCFmcmFtZS0+c2tiX3N0ZCkKKwkJCXJldHVybiBOVUxMOwogCX0KIAogCXJldHVy
biBza2JfY2xvbmUoZnJhbWUtPnNrYl9zdGQsIEdGUF9BVE9NSUMpOwpAQCAtMzQxLDYgKzM0
NCw4IEBAIHN0cnVjdCBza19idWZmICpoc3JfY3JlYXRlX3RhZ2dlZF9mcmFtZShzdHJ1Y3Qg
aHNyX2ZyYW1lX2luZm8gKmZyYW1lLAogCQloc3Jfc2V0X3BhdGhfaWQoZnJhbWUsIGhzcl9l
dGhoZHIsIHBvcnQpOwogCQlyZXR1cm4gc2tiX2Nsb25lKGZyYW1lLT5za2JfaHNyLCBHRlBf
QVRPTUlDKTsKIAl9IGVsc2UgaWYgKHBvcnQtPmRldi0+ZmVhdHVyZXMgJiBORVRJRl9GX0hX
X0hTUl9UQUdfSU5TKSB7CisJCWlmICghZnJhbWUtPnNrYl9zdGQpCisJCQlyZXR1cm4gTlVM
TDsKIAkJcmV0dXJuIHNrYl9jbG9uZShmcmFtZS0+c2tiX3N0ZCwgR0ZQX0FUT01JQyk7CiAJ
fQogCkBAIC0zODUsNiArMzkwLDggQEAgc3RydWN0IHNrX2J1ZmYgKnBycF9jcmVhdGVfdGFn
Z2VkX2ZyYW1lKHN0cnVjdCBoc3JfZnJhbWVfaW5mbyAqZnJhbWUsCiAJCX0KIAkJcmV0dXJu
IHNrYl9jbG9uZShmcmFtZS0+c2tiX3BycCwgR0ZQX0FUT01JQyk7CiAJfSBlbHNlIGlmIChw
b3J0LT5kZXYtPmZlYXR1cmVzICYgTkVUSUZfRl9IV19IU1JfVEFHX0lOUykgeworCQlpZiAo
IWZyYW1lLT5za2Jfc3RkKQorCQkJcmV0dXJuIE5VTEw7CiAJCXJldHVybiBza2JfY2xvbmUo
ZnJhbWUtPnNrYl9zdGQsIEdGUF9BVE9NSUMpOwogCX0KIAotLSAKMi4zNC4xCgo=

--------------tuNW2XxNaqyyWBk1xGlWGOZ3--

