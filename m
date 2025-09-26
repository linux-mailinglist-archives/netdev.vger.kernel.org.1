Return-Path: <netdev+bounces-226646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F66BA3869
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 13:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B26D328035
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 11:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DD02DC798;
	Fri, 26 Sep 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePS03jgo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8B2DC784
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887162; cv=none; b=OljJD7k/XnIEJqCRAaexS/ls4uzB8FEIuMaPtY74m32Uw3/+0k2+OXDZekjweE4opD8Y7XOfXE973m91wCcOe+Cm4blIZy5MGhYRobsr10Op+sAHnCojINbOSf3HQ03xXyDDulf4p7QU4gJTvTnpg8HKe/o1zRUi5JxSstp28sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887162; c=relaxed/simple;
	bh=1id3B6Wi8UowOcZ+9wbUIN5SOAeHkmeYMI59q8iHO5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSD0fxEGlu3gA1xc3UJbahX4TvOjo9XWW3NNpFnQ2E8yuWLN9BPo3owvFpKqYJmxgNosssu2/0MbhiaSXne2xdkjCPuWRkXfOAec9rZUTKVp7gqDVKRJ05mWquxIR66707wxfuevE/iuM427qqoZR1y1pZD/LokADTi4geguLHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePS03jgo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e430494ccso593295e9.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 04:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758887159; x=1759491959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkRDFqbG55HD/5PHsPObmdh+Ov28CTpaGeY2bB6QWYU=;
        b=ePS03jgodCHcncw6WdQZN97PFUkWxHq37GAd30XqRk4VEJoIJRQ2uMoCR64F50xUKF
         k89OFyAVcAimFUApqNSsDTTXVMnH+BeuVBjSUiQl8/8QXNM0EYavxKwM50ugiiDd+NLb
         lM+420BVEJSxyYqNYibfWXSsE995hYieW86zH4/De0VUm8ByI9441jcAlT43shGqq9T4
         aX+P/6PN59HRmHIgCc8yQ9PN7VBQnW0nQvz9zFX74mBGa5ey9NKIXYyOZGYGpVkjGE09
         0uCLv3rWZB7LlgRZkxmCDtZjg01SWg8Kj1rHpDFEjv2xBE4Mbc4S6Op3vSsWQeZo/W04
         kdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758887159; x=1759491959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkRDFqbG55HD/5PHsPObmdh+Ov28CTpaGeY2bB6QWYU=;
        b=vtlOZzlyyKEAFDiiqQbrASG8vjD8hp6NZr+YXL/pyiR0dhjxGIeJ0rz3u5Gg4ktFMm
         ldRFeKD1rKWBPyg5cCtX0QxdLX2Gc7MoaOryAl/o2nOHB1yRSVE/hv4OP2+Veelsly9G
         fXzAw2dc+ZvQ1/BKJzg+T9iIrKEYGaQBncCqKI5zN9+DDq4x1JzVnXfOJj34veNPO0hm
         9loWIx0fTHsX+rtLPGKLr+a4tje+IpifjO+Efc28+Pp5OeI/t6t7Hm9TUAf1HvjQbMOK
         J261lbt1BLZiQHbbQt/YanRQNx7N2qLWwJxq2uLf3qzHQX9/HC4gjlmxpfDDYrdNdRRk
         kiaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNVLKYL6s15eckNmJSI25F8HnrcTZvl9HXV5beKx0pQB+2At/29SuT8EYXn1qDqza7byQxGZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw62Wtb4q082uW0VxI+eb8tgegwPuVac6thtb4+tWOweuXHWes
	sc8JNmbClFnDRNFLqWtoCOru6JHoja80QO9E+3ks9+lZeYwlVHK28RYe
X-Gm-Gg: ASbGnct26iQ8oMVS38KnyvQoa0yFXFva+KeFDAjEuLF3hrx9vJTDQ7ijLTmKsByEBiA
	SgndLhNOuZiNMhu0UPFyLhcoWCEfh3f3iABX0n6aeW0h8GqjJkUYRZWubAq6YIBQiG4nxS1b97m
	gRZdcgWwaVALHbr0JUDMPbaCHu28FUwxeqVRz0Qgq8Sn40yPBVxuuEDGXgbXKHT4bhW2HISlU3q
	eFZwfg5IjOr6cWCXZ8UJIs9BMwmlOLrfHmb+sRB/egJRp877hDxxk9bW1SqpXxT9O6fTr296qPA
	1+3t+X1pN7lKuFc4HoLQ0TCoE1m09hiuibiOcOtDzgk3vBbVYpOsrs3W7TXb8rSZZh8BZIocg52
	HppiIf6BLaAVb+i/FflV7423o1o2E37/NqJdoZIpivqfDWkfo1zSyIMVadeuhHN0K
X-Google-Smtp-Source: AGHT+IEPTFDb685fmiqtI/zbxG32d7v3MRP+VRk71KQ8OOHsQCWx3c0SFbrsAeMCnBPznWcIWNgGnA==
X-Received: by 2002:a05:600d:15a:20b0:46e:1e31:8d06 with SMTP id 5b1f17b1804b1-46e329f62b4mr74383735e9.16.1758887158355;
        Fri, 26 Sep 2025 04:45:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33105e0bsm37380245e9.5.2025.09.26.04.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 04:45:58 -0700 (PDT)
Date: Fri, 26 Sep 2025 12:45:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 linux@jordanrome.com, ameryhung@gmail.com, toke@redhat.com,
 houtao1@huawei.com, emil@etsalapatis.com, yatsenko@meta.com,
 isolodrai@meta.com, a.s.protopopov@gmail.com, dxu@dxuuu.xyz,
 memxor@gmail.com, vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org,
 gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
 mrpre@163.com, jakub@cloudflare.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
Subject: Re: [PATCH] selftests/bpf: Add -Wsign-compare C compilation flag
Message-ID: <20250926124555.009bfcd6@pumpkin>
In-Reply-To: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 17:23:49 +0100
Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> wrote:

> -Change all the source files and the corresponding headers 
> to having matching sign comparisons.

'Fixing' -Wsign-compare by adding loads of casts doesn't seem right.
The only real way is to change all the types to unsigned ones.
But it is of questionable benefit and make the code harder to read.

Consider the following:
	int x = read(fd, buf, len);
	if (x < 0)
		return -1;
	if (x > sizeof (struct fubar))
		return -1;
That will generate a 'sign-compare' error, but min(x, sizeof (struct fubar))
doesn't generate an error because the compiler knows 'x' isn't negative.

A well known compiler also rejects:
	unsigned char a;
	unsigned int b;
	if (b > a)
		return;
because 'a' is promoted to 'signed int' before it does the check.

So until the compilers start looking at the known domain of the value
(not just the type) I enabling -Wsign-compare' is pretty pointless.

As a matter of interest did you actually find any bugs?

	David


> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
> As suggested by the TODO, -Wsign-compare was added to the C compilation
> flags for the selftests/bpf/Makefile and all corresponding files in
> selftests and a single file under tools/lib/bpf/usdt.bpf.h have been
> carefully changed to account for correct sign comparisons either by
> explicit casting or changing the variable type.Only local variables
> and variables which are in limited scope have been changed in cases
> where it doesn't break the code.Other struct variables or global ones 
> have left untouched to avoid other conflicts and opted to explicit 
> casting in this case.This change will help avoid implicit type 
> conversions and have predictable behavior.
> 
> I have already compiled all bpf tests with no errors as well as the
> kernel and have ran all the selftests with no obvious side effects.
> I would like to know if it's more convinient to have all changes as
> a single patch like here or if it needs to be divided in some way 
> and sent as a patch series.
> 
> Best Regards,
> Mehdi Ben Hadj Khelifa
...

