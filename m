Return-Path: <netdev+bounces-242722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5D9C941D2
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 17:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08C03A5A60
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5722D1D86FF;
	Sat, 29 Nov 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfzzl5Ch"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C926D17AE1D
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432091; cv=none; b=ojXeNu7UrycmIcHkSHAKET/6EjZBEFs0hv//JeCihxR4E8QfnTHKJpI7NJ4MYM2IqeDQx2UiuxfE285dYQw+y+cgpn7+JVhkhefrsznHYAx10EcynQRPRifzEnnKl1EyAa2ACUaTlHROePpa87Koo9g8GyJnYEJfwhL60WocGSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432091; c=relaxed/simple;
	bh=zgH0FJJ3DJnP1JOlINt6NUH8FRV0T+lvF+94r5ojo3c=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To; b=QBUYH9CIa1fOoPIZVXNCDMz8X1CjHMAqzle4xZ0+gFCW8Q8S7gLpeh3ZhOJ9ZBnCwW8OZR4F1SeqW8VWyjqv+ivIEDB+G3GkD9OIV0eBG/Rwkj+7ZiFWTwDfx2hdj2wP/lSu8ATJDG1OeQOUkV7FTun78RUjZS5Scm2Q4VJLRlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfzzl5Ch; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2956d816c10so31413855ad.1
        for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 08:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764432089; x=1765036889; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgH0FJJ3DJnP1JOlINt6NUH8FRV0T+lvF+94r5ojo3c=;
        b=gfzzl5ChEOatZN+XdijF62czzXRTJeqZDX5dB7ZNBLrYLKBFZyH83MoI/S/la146vL
         2f27kj4c1yvrFhDPllcXwJkN5wCOm/iRypiZjt6PgBJSbLcSxpIa+g3+wEka34xTq9g0
         V9bIPvCPvuRtqM29Zzi8w/rQ3OCE3YYqHZa+psRYbxk50bBFwKmTtdXY92H8WCx77Wm1
         dZGL8sayaGRENck+5PMnZDVrxAMQzISklw3iyPjAVhbhHOMDGexrGX0CInOMQ0e+ldaY
         wwbxOFg7RdOCs90fgrpcnY58OBAXVOpXSSMVSaR/AmF0e75Mvl2GMjHfP7eE8GP/2i3N
         xUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764432089; x=1765036889;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgH0FJJ3DJnP1JOlINt6NUH8FRV0T+lvF+94r5ojo3c=;
        b=ojmTrHlS6U2aceC+1ESq6aG8LGLT72SvS2GD1cJmb7Y9Hsm7pKEF1RO/mtAmlU4KGi
         OOGAQ3QqtZ4Eb3zuIMn94DmSwqmetOxKAHMrVjGKwg8p111+wkNGzjJkvCVtjjgkkIPj
         Bd+tHnTjPdp7aF7WHi6EkMr2oOb/IJ5wNXkEnFnAl/mqaNloZTFZzyowxduHtCD0EBbP
         Q7f6CIhjZncF5hEF1uZSG62Rv3X9LeLew3N6H0j8OOTpKy4Jrvi9j5085PCbRV2OyMVz
         iKcIDMPn8FLBGD055gFoRxuWxxYXAQOA1BItAc8b82gq5Qt6mOTBeRf0IE6lNzVICt6P
         S6lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJwhfrkrJTcy9bv0IaFU4chuIiTz1CAvco8FBxKj0WSMFSv2dQ6Y/57uHup/G/pyeYRGJXTXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0nZC21M080A7wtg91hNX4Qg5ZKtugR94nrDfl7aVcqhma7+f
	X6CFwqO0t7uFHz+z+FkcLInAqrk/29ZQwrE+UrvcBFJGEN9YfzKASNVr
X-Gm-Gg: ASbGncsGWIczr1QkOABgj0u6Rus8GUfwup+El7w7RyNTTyBSWquf30csG/jR/aaoAv9
	Qwog3JYnWJ2TLAXpGdTl1g0K8vNIjEhXKYUrEsxKNb03ssfXiZPRjV5osQshT5soISpvc17TKBz
	UIBDn42Oz12oin12NdVdqmrx5lsFDZjd018jAHIutvMA+gfglzpMTPC3b6YyKxp/e6tT82XfT7E
	pyB7izXFzo7s3WqxqRxb/Rutg0KGhCqpJlPo9M8AFRSph9q0ZRZxE/RcL/t/C9AAemB3xJ5gBkW
	WqvM66Q/z88DlhYZzdsZoAsHSIRtuMmthZh/5Z8UZcFxwZa6rbww9A4NT12vtJLmNVXCCOq2F0+
	prQQIY2Ma0r1SVX+gF3wb3AadERMveXn0gQAaIdemAP3FD77myFZwT0L1Gl2G3FhWp4SXmCI50n
	ikhgC51QMkfMWaLzTUKTNDrgwYxMrsD21cJjc8mLZrM2LcQ/V9Iw==
X-Google-Smtp-Source: AGHT+IHM0FuLobgALrNTAPkT0PnBzi9HTgk7b0AXrs0KCK994AY8v5pHAHNyTOzUF5phgQl8OYcmHA==
X-Received: by 2002:a17:902:d541:b0:295:9db1:ff32 with SMTP id d9443c01a7336-29b6bf5d676mr365614665ad.48.1764432088748;
        Sat, 29 Nov 2025 08:01:28 -0800 (PST)
Received: from ?IPV6:2405:201:31:d869:a02b:2bd8:146e:5b? ([2405:201:31:d869:a02b:2bd8:146e:5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40acbbsm78368475ad.11.2025.11.29.08.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Nov 2025 08:01:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------JkTKKsczXKjzUZf2jaJrMDRd"
Message-ID: <c732819e-3871-46c8-aaee-ca2ba75a28d1@gmail.com>
Date: Sat, 29 Nov 2025 21:31:19 +0530
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
--------------JkTKKsczXKjzUZf2jaJrMDRd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

--------------JkTKKsczXKjzUZf2jaJrMDRd
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-net-hsr-fix-NULL-pointer-dereference-in-prp_get_unta.patch"
Content-Disposition: attachment;
 filename*0="0001-net-hsr-fix-NULL-pointer-dereference-in-prp_get_unta.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1NTY2MWM4N2E4NDdlZDIwYmFmYTA3MmVhNmJhOTBlMzQ1ZmNmYjU4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaGF1cnlhIFJhbmUgPHNzcmFuZV9iMjNAZWUudmp0
aS5hYy5pbj4KRGF0ZTogU2F0LCAyOSBOb3YgMjAyNSAyMToyOToxNyArMDUzMApTdWJqZWN0
OiBbUEFUQ0ggbmV0IHYzXSBuZXQ6IGhzcjogZml4IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5j
ZSBpbgogcHJwX2dldF91bnRhZ2dlZF9mcmFtZSgpCgpfX3Bza2JfY29weSgpIGNhbiByZXR1
cm4gTlVMTCBpZiBtZW1vcnkgYWxsb2NhdGlvbiBmYWlscy4gV2hlbiB0aGlzCmhhcHBlbnMg
aW4gcHJwX2dldF91bnRhZ2dlZF9mcmFtZSgpLCBmcmFtZS0+c2tiX3N0ZCByZW1haW5zIE5V
TEwgYW5kCmlzIHBhc3NlZCB0byBza2JfY2xvbmUoKSwgY2F1c2luZyBhIE5VTEwgcG9pbnRl
ciBkZXJlZmVyZW5jZS4KCkFkZCBhIE5VTEwgY2hlY2sgaW1tZWRpYXRlbHkgYWZ0ZXIgX19w
c2tiX2NvcHkoKSB0byByZXR1cm4gZWFybHkKd2hlbiBhbGxvY2F0aW9uIGZhaWxzLgoKIEJV
RzogS01TQU46IHVuaW5pdC12YWx1ZSBpbiBza2JfY2xvbmUrMHgxZTAvMHg0MjAgbmV0L2Nv
cmUvc2tidWZmLmM6MjEyOQogIHNrYl9jbG9uZSsweDFlMC8weDQyMCBuZXQvY29yZS9za2J1
ZmYuYzoyMTI5CiAgcHJwX2dldF91bnRhZ2dlZF9mcmFtZSBuZXQvaHNyL2hzcl9mb3J3YXJk
LmM6MjE3IFtpbmxpbmVdCiAgaHNyX2ZvcndhcmRfZG8rMHgyZmUwLzB4NTlkMCBuZXQvaHNy
L2hzcl9mb3J3YXJkLmM6NjYzCiAgaHNyX2ZvcndhcmRfc2tiKzB4MzMwLzB4NDYwIG5ldC9o
c3IvaHNyX2ZvcndhcmQuYzo3MjAKICBoc3JfZGV2X3htaXQrMHg0YS8weDgwIG5ldC9oc3Iv
aHNyX2RldmljZS5jOjE5OQoKUmVwb3J0ZWQtYnk6IHN5emJvdCtlMmNhMWVmMjZkYzFjNzM4
NzY1OEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9zeXprYWxs
ZXIuYXBwc3BvdC5jb20vYnVnXD9leHRpZFw9ZTJjYTFlZjI2ZGMxYzczODc2NTgKRml4ZXM6
IDQ1MWQ4MTIzZjg5NyAoIm5ldDogcHJwOiBhZGQgcGFja2V0IGhhbmRsaW5nIHN1cHBvcnQi
KQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBTaGF1cnlhIFJh
bmUgPHNzcmFuZV9iMjNAZWUudmp0aS5hYy5pbj4KLS0tCiBuZXQvaHNyL2hzcl9mb3J3YXJk
LmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvbmV0L2hzci9oc3JfZm9yd2FyZC5jIGIvbmV0L2hzci9oc3JfZm9yd2FyZC5jCmluZGV4
IDMzOWYwZDIyMDIxMi4uYWVmYzliNjkzNmJhIDEwMDY0NAotLS0gYS9uZXQvaHNyL2hzcl9m
b3J3YXJkLmMKKysrIGIvbmV0L2hzci9oc3JfZm9yd2FyZC5jCkBAIC0yMDUsNiArMjA1LDgg
QEAgc3RydWN0IHNrX2J1ZmYgKnBycF9nZXRfdW50YWdnZWRfZnJhbWUoc3RydWN0IGhzcl9m
cmFtZV9pbmZvICpmcmFtZSwKIAkJCQlfX3Bza2JfY29weShmcmFtZS0+c2tiX3BycCwKIAkJ
CQkJICAgIHNrYl9oZWFkcm9vbShmcmFtZS0+c2tiX3BycCksCiAJCQkJCSAgICBHRlBfQVRP
TUlDKTsKKwkJCWlmICghZnJhbWUtPnNrYl9zdGQpCisJCQkJcmV0dXJuIE5VTEw7CiAJCX0g
ZWxzZSB7CiAJCQkvKiBVbmV4cGVjdGVkICovCiAJCQlXQVJOX09OQ0UoMSwgIiVzOiVkOiBV
bmV4cGVjdGVkIGZyYW1lIHJlY2VpdmVkIChwb3J0X3NyYyAlcylcbiIsCi0tIAoyLjM0LjEK
Cg==

--------------JkTKKsczXKjzUZf2jaJrMDRd--

