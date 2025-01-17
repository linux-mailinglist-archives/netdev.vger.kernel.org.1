Return-Path: <netdev+bounces-159376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788ABA1552E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B740D1885580
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DE919E979;
	Fri, 17 Jan 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H237JfPk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD251993B7
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133308; cv=none; b=eL85DjzNf6I0S6/d8AkZRcFKdfcSTT6nsgbe+YnBbElqBIn6UD9yE+bzrrSsEvnU5MHGeaXT/F0+KPDLHhWdK7meKfAflIbKaMbmRr8bqwM4lu3oNpTBH0K8YFuhkj7Ta4oajsVH7Qpcid45l53mHoPiMPxn/w846RYRdDsQHnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133308; c=relaxed/simple;
	bh=Zo0noal+6+Q9ZtmdrtFRVcNRZ95mLntQN2uOZfZWOiA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=cc9ewlDuuVbyJe9IPMvT5EG9sWgizYGBcqsN50Ju6kujwC6tldmYO9yd6ps1+Fhq8FIp08DWAn+TbeMrKnkl2uX7REoca8dOIYHdd1q0WD+IiuPYMn7PtIptoK53LvzRSvpuGksd5APuqlu0owCBR/8SpmZP1jFQE8NI+PWmXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H237JfPk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737133306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Q0ZXxkC4N2O25sLExzL9biJmOen8eY0G6kLH2oNAlw=;
	b=H237JfPkSYCgyhwjx0Qa27Ft3QFbkEPWTf+L/tmiTWKnDmJMmMuRtWrqpl4YzcI28e7nye
	I0wLS9A7iMxTyzT7yb8lNTsPuM/5wlIq2cifP5eeksRKksiAoyRSxsV2KfpvVdLa2o71NI
	bYFlASThsIiajxUbOsc6ySMWjFcH6yA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-jzA7V6P1MGSas36gzgfFKg-1; Fri, 17 Jan 2025 12:01:44 -0500
X-MC-Unique: jzA7V6P1MGSas36gzgfFKg-1
X-Mimecast-MFC-AGG-ID: jzA7V6P1MGSas36gzgfFKg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43582d49dacso16883815e9.2
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 09:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737133303; x=1737738103;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Q0ZXxkC4N2O25sLExzL9biJmOen8eY0G6kLH2oNAlw=;
        b=eLuQ1rfPrGi1MxNj+YcjIJ75p5hMIWfHCy6K+ZC8uAXjnxhm1JjuyrVfaA7qIGJJFi
         y9Un5s1iTojoLm1EptADyABJyzWPyjZ6H8NMWNyPlStca/hhbMmmPNPi+/Mz/P9nng3p
         NFR8vZt0a7JUvOnVP+JDvamPjwDhS0QFzjA19rLD7cyodG7FCIYnRYN5uNtC+H9Db7zL
         pweIFbsrTb3GEli9vXqhfEebSpz592Tdqn1ar+kE+SOhnUdf/4/GogPdrI/phGv+N/yB
         ZraWKiw7LiV/kNMCZ3SioX1Vly7UoY3wDZ2lz4JmeAS2kRNVy2NLS99JDjBLcQMyK8CI
         p3PQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+sAIf9kfp+goMH9i30Pm5UY7SrMpMNHNf5xNdiXSSDW/Ho5rWhEb9XVFNP7TZ8JHGTv+gzSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPos46zhicX1QtF9TfMIeG3zfjR+ADvDpWJyxWqcOZkDYDGgjk
	F6O1eUKm2rcCCzd2Lm3ffUSuj3SySpIIVdRZ9kUxPUYxolmN5OLTH7xirDWVQ6LtPJDaEqR8dnR
	FUduKGevYuaSXvLXK+wXVpsyBV7XmTXor3xrUUOLXYOwdZmG/XJOew+zgC635Kw==
X-Gm-Gg: ASbGnctzUr9DEtra96qJ9hXBKFePsLOQubztWt6ciyBFVDTr7Dn5g2s74mk9pbOfErJ
	bghg6+C5+BeGd5/8L0vkhqiUMkD0HhVwZFDKanPQvk0v1q4lXsUykW2b9wYAwDy+djNu4AccNYP
	wWyo4MjwClvb1v0SNcpyxLkIXlOhOUNoB00XEGI1tV3WWyox6xaXl4DRX/FUOzpDwpyXPRaejrt
	gwYO939qd1YJZwPFaOw7g+7YKfW8oVCZfDIQQ7k497Kn82kbpvfihosqevk2tCcYpilznZ0YQ3Y
	H5QytEFfYNE=
X-Received: by 2002:a05:6000:1acd:b0:38a:88be:bcb5 with SMTP id ffacd0b85a97d-38bf56555f4mr3168325f8f.5.1737133302968;
        Fri, 17 Jan 2025 09:01:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+gWUxs0A9tdilaf0k8FT76TRqrqIZ7JEg82rVAPlJvSGlBWlxaUaRbuHG+WKr2Qsbxygt/g==
X-Received: by 2002:a05:6000:1acd:b0:38a:88be:bcb5 with SMTP id ffacd0b85a97d-38bf56555f4mr3168126f8f.5.1737133300908;
        Fri, 17 Jan 2025 09:01:40 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3214c5csm2971915f8f.8.2025.01.17.09.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 09:01:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------V0dHquHNhoNq0Eokc4Xl32xm"
Message-ID: <66fa6c80-4383-479d-b17e-234bee6ed7ad@redhat.com>
Date: Fri, 17 Jan 2025 18:01:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mptcp?] WARNING in __mptcp_clean_una (2)
To: syzbot <syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com>,
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67605870.050a0220.37aaf.0137.GAE@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67605870.050a0220.37aaf.0137.GAE@google.com>

This is a multi-part message in MIME format.
--------------V0dHquHNhoNq0Eokc4Xl32xm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/24 5:42 PM, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    00a5acdbf398 bpf: Fix configuration-dependent BTF function..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=148de730580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
> dashboard link: https://syzkaller.appspot.com/bug?extid=ebc0b8ae5d3590b2c074
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d82344580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179654f8580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fc306c95490c/disk-00a5acdb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e17d5125ee77/vmlinux-00a5acdb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/65f791a7fd14/bzImage-00a5acdb.xz

Trying again... Mat noted I actually forgot the actual command

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main


--------------V0dHquHNhoNq0Eokc4Xl32xm
Content-Type: text/x-patch; charset=UTF-8;
 name="mptcp_clean_una_splat_debug_disc.patch"
Content-Disposition: attachment;
 filename="mptcp_clean_una_splat_debug_disc.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL25ldC9tcHRjcC9wcm90b2NvbC5jIGIvbmV0L21wdGNwL3Byb3RvY29s
LmMKaW5kZXggMWIyZTdjYmI1NzdmLi5mYzhkOWZjMzY5NDIgMTAwNjQ0Ci0tLSBhL25ldC9t
cHRjcC9wcm90b2NvbC5jCisrKyBiL25ldC9tcHRjcC9wcm90b2NvbC5jCkBAIC0xMDIyLDgg
KzEwMjIsMTggQEAgc3RhdGljIHZvaWQgX19tcHRjcF9jbGVhbl91bmEoc3RydWN0IHNvY2sg
KnNrKQogCiAJCWlmICh1bmxpa2VseShkZnJhZyA9PSBtc2stPmZpcnN0X3BlbmRpbmcpKSB7
CiAJCQkvKiBpbiByZWNvdmVyeSBtb2RlIGNhbiBzZWUgYWNrIGFmdGVyIHRoZSBjdXJyZW50
IHNuZCBoZWFkICovCi0JCQlpZiAoV0FSTl9PTl9PTkNFKCFtc2stPnJlY292ZXJ5KSkKKwkJ
CWlmICghbXNrLT5yZWNvdmVyeSkgeworCQkJCXByX2Vycigic25kX3VuYSAlbGx4IHNuZF9u
eHQgJWxseCB3cml0ZV9zZXEgJWxseCAiCisJCQkJICAgICAgICJpZHNuICVsbHggZGZyYWcg
c2VxICVsbHggbGVuICVkIGRpc2Nvbm5lY3RzICVkOiVkICIKKwkJCQkJInN0YXRlICVkICVk
XG4iLAorCQkJCSAgICAgICBzbmRfdW5hLCBtc2stPnNuZF9ueHQsIG1zay0+d3JpdGVfc2Vx
LAorCQkJCSAgICAgICBtcHRjcF9zdWJmbG93X2N0eChtc2stPmZpcnN0KS0+aWRzbiwKKwkJ
CQkgICAgICAgZGZyYWctPmRhdGFfc2VxLCBkZnJhZy0+ZGF0YV9sZW4sCisJCQkJICAgICAg
IHNrLT5za19kaXNjb25uZWN0cywgbXNrLT5kaXNjb25uZWN0cywKKwkJCQkgICAgICAgc2st
PnNrX3N0YXRlLCBzay0+c2tfc29ja2V0ID8gc2stPnNrX3NvY2tldC0+c3RhdGU6IC0xKTsK
KwkJCQlXQVJOX09OKDEpOwogCQkJCWJyZWFrOworCQkJfQogCiAJCQlXUklURV9PTkNFKG1z
ay0+Zmlyc3RfcGVuZGluZywgbXB0Y3Bfc2VuZF9uZXh0KHNrKSk7CiAJCX0KQEAgLTE3Njcs
OCArMTc3NywxMCBAQCBzdGF0aWMgaW50IG1wdGNwX3NlbmRtc2dfZmFzdG9wZW4oc3RydWN0
IHNvY2sgKnNrLCBzdHJ1Y3QgbXNnaGRyICptc2csCiAJCSAqIHNlZSBtcHRjcF9kaXNjb25u
ZWN0KCkuCiAJCSAqIEF0dGVtcHQgaXQgYWdhaW4gb3V0c2lkZSB0aGUgcHJvYmxlbWF0aWMg
c2NvcGUuCiAJCSAqLwotCQlpZiAoIW1wdGNwX2Rpc2Nvbm5lY3Qoc2ssIDApKQorCQlpZiAo
IW1wdGNwX2Rpc2Nvbm5lY3Qoc2ssIDApKSB7CisJCQlzay0+c2tfZGlzY29ubmVjdHMrKzsK
IAkJCXNrLT5za19zb2NrZXQtPnN0YXRlID0gU1NfVU5DT05ORUNURUQ7CisJCX0KIAl9CiAJ
aW5ldF9jbGVhcl9iaXQoREVGRVJfQ09OTkVDVCwgc2spOwogCkBAIC0zMjA4LDYgKzMyMjAs
NyBAQCBzdGF0aWMgaW50IG1wdGNwX2Rpc2Nvbm5lY3Qoc3RydWN0IHNvY2sgKnNrLCBpbnQg
ZmxhZ3MpCiAJaWYgKG1zay0+ZmFzdG9wZW5pbmcpCiAJCXJldHVybiAtRUJVU1k7CiAKKwlt
c2stPmRpc2Nvbm5lY3RzKys7CiAJbXB0Y3BfY2hlY2tfbGlzdGVuX3N0b3Aoc2spOwogCW1w
dGNwX3NldF9zdGF0ZShzaywgVENQX0NMT1NFKTsKIApkaWZmIC0tZ2l0IGEvbmV0L21wdGNw
L3Byb3RvY29sLmggYi9uZXQvbXB0Y3AvcHJvdG9jb2wuaAppbmRleCA3MzUyNmYxZDc2OGYu
LjU5YTZlNTJmMDJhNCAxMDA2NDQKLS0tIGEvbmV0L21wdGNwL3Byb3RvY29sLmgKKysrIGIv
bmV0L21wdGNwL3Byb3RvY29sLmgKQEAgLTM0MCw2ICszNDAsNyBAQCBzdHJ1Y3QgbXB0Y3Bf
c29jayB7CiAJCXU2NAlydHRfdXM7IC8qIGxhc3QgbWF4aW11bSBydHQgb2Ygc3ViZmxvd3Mg
Ki8KIAl9IHJjdnFfc3BhY2U7CiAJdTgJCXNjYWxpbmdfcmF0aW87CisJdTE2CQlkaXNjb25u
ZWN0czsKIAogCXUzMgkJc3ViZmxvd19pZDsKIAl1MzIJCXNldHNvY2tvcHRfc2VxOwo=

--------------V0dHquHNhoNq0Eokc4Xl32xm--


