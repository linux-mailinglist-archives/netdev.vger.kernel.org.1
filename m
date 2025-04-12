Return-Path: <netdev+bounces-181857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CA1A86A19
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 03:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4D37AA121
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A142367C6;
	Sat, 12 Apr 2025 01:31:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA625F4ED;
	Sat, 12 Apr 2025 01:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744421501; cv=none; b=oe5/XIP6U5sqythDcicQOtgRXFYY/IZegsUTKzKpregiASl4LF+5y30F4Ip6aw4LvUMzjFkE4QTeH+dImPR1ZIMpTSsCMzWgmvB2WrKF/Wj3Gi0VRNQc2ulAsoVXGaFtiDjclh4vLMxCraRYSrVRZJPCQ2zVHVezrOw9ufccdig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744421501; c=relaxed/simple;
	bh=wdfhgLAKF0XQ/SWRigNLTl6LPPORJ/PXEZEHW8rdH4E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s5U1fptDl9MqwSTLYLSx4rLbPhRKI92B0yzZUEtBy9aUi9Ej0qrlGyfU9cnw7cOEsq0zFoxUv4ZqN9Res086Wsjmt5ND38mRdDy4SS7rSjA96O60L/V9srrj/Nk4XWUQOi4iKPLaLVlTxmHuSejVBvNi5jlmNrr90cZRr94yGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-acacb8743a7so297350966b.1;
        Fri, 11 Apr 2025 18:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744421498; x=1745026298;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOiDyjHQN21i1dF9nmEh6ABpVyg391P9Z34V42IDnXM=;
        b=aEX5JiRgiyrM1hJQtEniHybRGIw38fFXbvaTeDffvxh2TRGdAeaIe/ZRNZLoeVuerl
         0s+MPplqac+nFaRb5oPTfpNILslmUT1Iiaisf0OrN6PvfFhVcOjYdQaqZUajNRw7TCuZ
         aM/5lNdjNN0fpExmPRXlmWw/0VaJX+tnMH2p7IgvWikxTnIRx6RDmN2z2C5F8ftGuaQk
         B2Kt+KfN07LuBc3ieiGkCKvKvn9UNJ8fa/KjI78ISc9URYn096nmrwuZSJLzsiY96i32
         VSLAkqrFEwhmMvfIn436DjzQkS3/q24EhT8pyzPpjcpN/1oPKOXLFmw+zimp2ihKOq5r
         EBgA==
X-Forwarded-Encrypted: i=1; AJvYcCV04dx/P51WM7VShx/N6W4V8ZB5svu23FL61FfeNgfEKl2oduc9CS+tsJzG98us4JLPeKWPrGVCeu+q7ao=@vger.kernel.org, AJvYcCV9E8WQWJ8/TtGdTG+0+SILSL+/ImiF/44Tcs9KvR4kFz5DN5WdGTzp4fPAXYbQ0x72HULMIC6k@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRFaN7rDfKPDE5BZGAyqHv0kxStSRqrcD1+idd04NZewbRgKE
	FxUJ95isX18GGkDA7nd5eV37qPyUJ4e5l+bRZEYTdQyZowf6o2Z8
X-Gm-Gg: ASbGncs0hj1MRwZJyOrvn3kKkc9fvS38eohOJDp5pQhiUOKOAIlTCK/P9WXu1HgTL5z
	xijHeyS8rmEqVKivHQQ/Qft/l+2y129sfcNUIiwOld6S7y1yw+6XU74qlM9f3ecKR5Z+AFH3Q2x
	jLspx4RTQwskc0LDYfcnd5fs3e03qt9dG19wMgzFm2gfS0jOlykP8tbDYbjEaaJ/d/m9Sqp8cpR
	NYlHjq26H04WCPSyS5wmw72gkWUo77/lkUlCJ7SSQI5qdQOrgnlSpvg/xdMutpNhD5rmSYDjqPI
	rHDKeLkXcot8WgK+Za8RrVuHedAK5NxIhCPePl5rGPHQyVO30rEOuroPswsqmxXuldFfNN677A=
	=
X-Google-Smtp-Source: AGHT+IF6uOXfqVH2vhHaQUcO/ldFAH1J35rJhBFF4DJEfgSvRefNvQeFectdQ6OZE4SbNKRRpEcvLA==
X-Received: by 2002:a17:907:6d0d:b0:ac7:3929:25fa with SMTP id a640c23a62f3a-acabcac8d7cmr732254366b.30.1744421497699;
        Fri, 11 Apr 2025 18:31:37 -0700 (PDT)
Received: from [192.168.0.234] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1c0227bsm521200666b.82.2025.04.11.18.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 18:31:37 -0700 (PDT)
Message-ID: <d16ba399-8ddb-4d4e-9c1c-3f657ea86abe@ovn.org>
Date: Sat, 12 Apr 2025 03:31:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org
Subject: Re: [syzbot] [openvswitch?] KMSAN: uninit-value in validate_set (2)
To: syzbot <syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com>,
 aconole@redhat.com, davem@davemloft.net, dev@openvswitch.org,
 echaudro@redhat.com, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 pshelar@ovn.org, syzkaller-bugs@googlegroups.com
References: <67f9767f.050a0220.379d84.0003.GAE@google.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <67f9767f.050a0220.379d84.0003.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 10:07 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0af2f6be1b42 Linux 6.15-rc1
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14e26d78580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7cfe1169d7fc8523
> dashboard link: https://syzkaller.appspot.com/bug?extid=b07a9da40df1576b8048
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1367bb4c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1495d23f980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7526e189e315/disk-0af2f6be.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/60a25cc98e41/vmlinux-0af2f6be.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2d7bf8af0faf/bzImage-0af2f6be.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com
> 
> =====================================================

#syz test: https://github.com/igsilya/linux.git tmp-validate-set


