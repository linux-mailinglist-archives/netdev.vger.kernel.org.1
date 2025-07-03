Return-Path: <netdev+bounces-203931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC08AF826B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 23:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8271B1BC681B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 21:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172C229DB6A;
	Thu,  3 Jul 2025 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="CmCclJQf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4859A277C9E
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751576781; cv=none; b=CNIcHhPvEURENiY15Vwiv8/SOdkIZS1SZcNYuTSgxSywq4tbmtnaePxaXUw4ARHPm4WTKnSErba9gmVdNO0Djx2q+hCr+ceeDnMuYVIG68Cwz2l5MBoof8o72TyH0bDHoCVExVVxvL2RWMo+T/kd86xmjY2w8TJ1uPFvAGv+Lqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751576781; c=relaxed/simple;
	bh=uQGt9Zk0RzkKtkDZjjxX1yLFuZ9XcpAlSiDmgdoA8NY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=WBZP4x7G+KuG7CZpOMicEgTyaD2qGz76bzJfxGX4ChgXWkrYnolbYWUlLmaXiQZDcqbEbEQzU9kA8A7wc/PpcGjT+1SVGF29Rt6rzxXzD9YurxdMlfu9t1ruQQW0adW48DJI9TJ1k/rXrXdWRiIt2qk/JcIK5derION39rTKxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=CmCclJQf; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d5d1feca18so29679785a.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 14:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751576776; x=1752181576; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWkZxfkZ0Htc4RbWuuAsVTXRzJPmLe/St2Y2SzAth4A=;
        b=CmCclJQfEeaXSGegIZRSIPq5IcWNESqz/sG03wSBW0tr/GH8H63HAuKg9k2K/4BNpk
         8VUCWmtAPvA4GXW1+BTAYrrh6Tu+Qo5uO5rtaDeaXGhcYg6J/qdWqXD2W56WPh0miPTj
         pDyeaYoLJgQvIJNVTChUTzAwhDzDHXkZKj48O/EW6rxrvGotfsyzO9olk2PkBVqJKIpu
         8IaX74YRcQd+0jwytRWnjzw9PvcaQGF+lgXg0dCe3ViwAhUQSq6mJSmGvagxcAuE/cgu
         FbRvdUko2D6S61SYILOE+J35SPRsNP8esYhsAzBJzdzH+EnXU/MFyPi2YkeNGjFj18Gg
         SbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751576776; x=1752181576;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zWkZxfkZ0Htc4RbWuuAsVTXRzJPmLe/St2Y2SzAth4A=;
        b=bUECnFRHakpsj/uxWWrEfFM2Nu40DdnL4mTf1KtYDTGnRvCL5La5DIix1JFPuC540v
         Mzf6HBdCcZAtVeIqtVABanmuWiZngqCOBlR21eMFvAugJgPc/R7+BETIQjbJHk1r6wPc
         vBJSDBMhH8OyqKv+xyR6UTlL6uDxM/CfrMp2PmPJGdB0L2aCs3pjNoC+fKcHYVmYmoRN
         mwDyOVsT9o1LeJD05eadVjxbisS0jgpuD4QhPwqy3GkPiV5RYxEKUOSAt7LbmzS3CXyn
         K9NvZu8c8xU18R72gD0ueoOIqMdp5xorAyC0wWm8hj8vxYj2JlutGTZ/4qv1w1pjs5jq
         jdwA==
X-Forwarded-Encrypted: i=1; AJvYcCWpVVQVXoXY+thfjwwEzRdLDFqUjUAmHY1gyWr3RmuoVXkwcVK6jUfZrppwpXSuLA9pFYxBANo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNQ1Iz+IxTG11AvtA4puOc7OW+sfgO5z+w8CT2jFaWc5Rcc1n
	IKZeSFkNr2PzPaDwTAQE+9Ulu/VmsrkJtyX7mvkBrdYPFb00qy0BmKN0LwEm8p7Xtw==
X-Gm-Gg: ASbGncsB83oI75AqlbqCLqnVDLBDwh+p2GUg+p9x4qpRy2mAt4+t1tmcshceK3QAqI4
	+SwYpf0LBquuG4X2txNWwwBbrjgWjAZjvD+Gj35dUs0m11two16GYQN5LlI/TZ6B8RnV6l2hcNp
	FDkNKpd1h8prgv5Cuz3lGoUaoTMizy/44ndDN6y855K2V553ueAnNov0gRr2vKUgR6qcFsWPys6
	mtSPnKBeVSuFBta7nTFJCBRDoXJsSVkefkbjkpRFu6fh/NzoazxET3uxKeuDp4U7XOThNaJcBt4
	c06sgiNqpqbTiDYHQXJKg4Cafcz4lhYFNH8cAwS+p7NRejU3F0eek+wR37jOP+yGMENlGoBOME3
	T0TPw4NVRfsRhyAqHd+5iznlnxr5DZw8XqG4yh8o9
X-Google-Smtp-Source: AGHT+IGpL3CQYrQI7E6p7zbnmQqLnVMLDfg3F4iR9KEGXrFGQDVPrO6ilb+9pB3Fwk/dt1vEFpvL/g==
X-Received: by 2002:a05:620a:170b:b0:7d4:3811:84b6 with SMTP id af79cd13be357-7d5dccf4a25mr76983185a.32.1751576776032;
        Thu, 03 Jul 2025 14:06:16 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c1:ca4a:289:b941:38b9:cf01? ([2804:7f1:e2c1:ca4a:289:b941:38b9:cf01])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe7c477sm50051585a.75.2025.07.03.14.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 14:06:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------l5XmQQGS9Ad3RpFyn26aEMqN"
Message-ID: <f14f4c0f-dc5d-454e-b5ef-1143b5a8f512@mojatatu.com>
Date: Thu, 3 Jul 2025 18:06:11 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] general protection fault in htb_qlen_notify
To: syzbot <syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
References: <68666a48.a00a0220.c7b3.0003.GAE@google.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <68666a48.a00a0220.c7b3.0003.GAE@google.com>

This is a multi-part message in MIME format.
--------------l5XmQQGS9Ad3RpFyn26aEMqN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/25 08:32, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    bd475eeaaf3c Merge branch '200GbE' of git://git.kernel.org..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=15cc0582580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=36b0e72cad5298f8
> dashboard link: https://syzkaller.appspot.com/bug?extid=d8b58d7b0ad89a678a16
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1113748c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10909ebc580000

#syz test
--------------l5XmQQGS9Ad3RpFyn26aEMqN
Content-Type: text/x-patch; charset=UTF-8; name="htb_null_deref_fix.patch"
Content-Disposition: attachment; filename="htb_null_deref_fix.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9zY2hfYXBpLmMgYi9uZXQvc2NoZWQvc2NoX2FwaS5j
CmluZGV4IGQ4YTMzNDg2YzUxMS4uODQ3MTA5ZGM1ZmE1IDEwMDY0NAotLS0gYS9uZXQvc2No
ZWQvc2NoX2FwaS5jCisrKyBiL25ldC9zY2hlZC9zY2hfYXBpLmMKQEAgLTM0MiwxMSArMzQy
LDExIEBAIHN0YXRpYyBzdHJ1Y3QgUWRpc2MgKnFkaXNjX2xlYWYoc3RydWN0IFFkaXNjICpw
LCB1MzIgY2xhc3NpZCkKIAljb25zdCBzdHJ1Y3QgUWRpc2NfY2xhc3Nfb3BzICpjb3BzID0g
cC0+b3BzLT5jbF9vcHM7CiAKIAlpZiAoY29wcyA9PSBOVUxMKQotCQlyZXR1cm4gTlVMTDsK
KwkJcmV0dXJuIEVSUl9QVFIoLUVPUE5PVFNVUFApOwogCWNsID0gY29wcy0+ZmluZChwLCBj
bGFzc2lkKTsKIAogCWlmIChjbCA9PSAwKQotCQlyZXR1cm4gTlVMTDsKKwkJcmV0dXJuIEVS
Ul9QVFIoLUVOT0VOVCk7CiAJcmV0dXJuIGNvcHMtPmxlYWYocCwgY2wpOwogfQogCkBAIC0x
NDk3LDcgKzE0OTcsNyBAQCBzdGF0aWMgaW50IF9fdGNfZ2V0X3FkaXNjKHN0cnVjdCBza19i
dWZmICpza2IsIHN0cnVjdCBubG1zZ2hkciAqbiwKIAkJfSBlbHNlIHsKIAkJCXEgPSBydG5s
X2RlcmVmZXJlbmNlKGRldi0+cWRpc2MpOwogCQl9Ci0JCWlmICghcSkgeworCQlpZiAoSVNf
RVJSX09SX05VTEwocSkpIHsKIAkJCU5MX1NFVF9FUlJfTVNHKGV4dGFjaywgIkNhbm5vdCBm
aW5kIHNwZWNpZmllZCBxZGlzYyBvbiBzcGVjaWZpZWQgZGV2aWNlIik7CiAJCQlyZXR1cm4g
LUVOT0VOVDsKIAkJfQpAQCAtMTYwMiw3ICsxNjAyLDEyIEBAIHN0YXRpYyBpbnQgX190Y19t
b2RpZnlfcWRpc2Moc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5sbXNnaGRyICpuLAog
CQkJCQlOTF9TRVRfRVJSX01TRyhleHRhY2ssICJGYWlsZWQgdG8gZmluZCBzcGVjaWZpZWQg
cWRpc2MiKTsKIAkJCQkJcmV0dXJuIC1FTk9FTlQ7CiAJCQkJfQorCiAJCQkJcSA9IHFkaXNj
X2xlYWYocCwgY2xpZCk7CisJCQkJaWYgKElTX0VSUihxKSkgeworCQkJCQlOTF9TRVRfRVJS
X01TRyhleHRhY2ssICJTcGVjaWZpZWQgY2xhc3Mgbm90IGZvdW5kIik7CisJCQkJCXJldHVy
biBQVFJfRVJSKHEpOworCQkJCX0KIAkJCX0gZWxzZSBpZiAoZGV2X2luZ3Jlc3NfcXVldWVf
Y3JlYXRlKGRldikpIHsKIAkJCQlxID0gcnRubF9kZXJlZmVyZW5jZShkZXZfaW5ncmVzc19x
dWV1ZShkZXYpLT5xZGlzY19zbGVlcGluZyk7CiAJCQl9Cg==

--------------l5XmQQGS9Ad3RpFyn26aEMqN--

