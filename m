Return-Path: <netdev+bounces-147980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297669DF9E5
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 05:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34162818F7
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 04:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C2928399;
	Mon,  2 Dec 2024 04:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTXYoaZA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40211157A48;
	Mon,  2 Dec 2024 04:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113866; cv=none; b=Rqf5iafGVYtAx4zr/a/xr2J6Pyzf1wGOANfMpxllTbPWuydt7nRO37HJRdtexRxieATvg7a8KSmHjIEB36vRIACIeW3caIVuNvFwaJ3VpbceiKb9lZLRrf7D2gLKGGwS+tWheymzijmVVGS0Yx7KW4A6SwX2VHqli1UaI03dHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113866; c=relaxed/simple;
	bh=K6UgDs4HorfecSV/hYW59+LYMss1zGZPmdnr7iHl4XU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qtz9PpuF2xv4+fhpXK3yLfVjnZWkOjdOKmwyrpWFxZl99zzKaf8lwoPbwtywtCrYM24e+lOSjVbmHB8mQ8N12qNPDiLXQZNtWSAxqYRsR+Wtz7z8C3BZShidPgw77uy0np8Hcw4rP8r8I73m6uQsbX81Ky+xL3KFSp3bBk6lQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTXYoaZA; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa530a94c0eso621618166b.2;
        Sun, 01 Dec 2024 20:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733113863; x=1733718663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K6UgDs4HorfecSV/hYW59+LYMss1zGZPmdnr7iHl4XU=;
        b=gTXYoaZAgbI8eZRuDDwEIalI5hoO4ttL9fQXH5j8Iw/mdtEOcXCym9z8xXy5XRT4IL
         6AXN1fMHq9o7zA2tfg/6voSNVfo/gFT9EHVGHQQs5IR22JP+LjM6wmbNCliy8nTzzswv
         9kK0BmYzff3JQ/pqjq9J/uJjKFdoRWN7+WiMgJ/G3iF51g6cIbTBqq0m9o1RJ/piC17D
         RS0Rf77SkKTbdKDexDRKSZYhMm/B60dp/6iJj5FAUMA/z1ZdjfqRMtdafz8MeNkIpHlX
         HRjDXOzeq2d/YSYKltmKTVXGUtbOUM12ESiUnhI7XS+VQ0D4buQEEtY9OgiMcFGPW0cW
         ffSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733113863; x=1733718663;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6UgDs4HorfecSV/hYW59+LYMss1zGZPmdnr7iHl4XU=;
        b=CfGpqZNLJZC0k9bo0pJLOjfKGDmaat55uyc+QG/IOcr/mUHq8X/syxtCIQ+jfxmhZs
         xwkLZqu/6M1MUKqevoR5tR02Jp8ws/qp1qFJLESDYd9Ei0p/aTsZvZkh4Zd02xPP9yeP
         LuFo5RHCfiUmUSr6eK+03HJU3wp/B/TAOc6XVABj0CibVMDLg80WLJRt2+FvUg5pEBps
         GHrpUQ+qwJvkyYF/UUsbYdVfCqKDa9zFoDrHoNmcSIL/IQ3iPdK8EVyIA+cCfDjK546y
         Bi/msz/4A5EX7cC07V33vPLq8eOhL8MSigp+r9QltD64kyHpup/zGlOyvCNJQ+sdVmNS
         CpNw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Mn1KJyVHJaBcDcTtI+68nSaAQ5Sh0iItwCnmc6kWn9bEkslNEZnajebEv9t35u0n3kCxcrnSSS/T/4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhFluc4Wo3eQulMqqioV0vz4SU8TZY8XHPrl34dXDOKhn1UEn0
	eh3PjhxTax/dSk+kCYHCWoL29rVkjtylJNgICIKKXJhEafHikN9o+aci4kRPfN887mg6PfTA/LN
	Wd6JAL5Sl0/KtsVB60CE4KzgnpSY=
X-Gm-Gg: ASbGncsJH/ZjHj2Y88DqVE5ysrTpKS05QIjMvOBS1E5drLAX+4j/cXzp1g98a66eW6k
	urV+ZkkUsIMCjU4HwRo0PTNiTi2mXWKAH
X-Google-Smtp-Source: AGHT+IEoaq/NKSx0tuWQwZGWY2YU/1vNW2n4kt7wGRWgCI7kgRh+EHhnv6tlt6vhtoevbnGhz8btrWfPWWITownTtdY=
X-Received: by 2002:a17:906:4590:b0:a99:4136:5b07 with SMTP id
 a640c23a62f3a-aa581093831mr1619697666b.60.1733113863293; Sun, 01 Dec 2024
 20:31:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Mon, 2 Dec 2024 12:30:51 +0800
Message-ID: <CAKHoSAtVJ=oycBBrcdxrTqZ8yW9dS=dWUU=mxQitJ+f73mGWcQ@mail.gmail.com>
Subject: "Kernel Warn in af_inet" in Linux Kernel Version 2.6.26
To: "David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, pekkas@netcore.fi, 
	jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@trash.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 2.6.26.
This issue was discovered using our custom vulnerability discovery
tool.

Affected File:

File: net/ipv4/af_inet.c

Detailed call trace:

[ 1788.473836] KERNEL: assertion (!atomic_read(&sk->sk_wmem_alloc))
failed at net/ipv4/af_inet.c (155)
[ 1788.473836] KERNEL: assertion (!sk->sk_wmem_queued) failed at
net/ipv4/af_inet.c (156)
[ 1788.473836] KERNEL: assertion (!sk->sk_forward_alloc) failed at
net/ipv4/af_inet.c (157)
[ 1788.473836] KERNEL: assertion (!atomic_read(&sk->sk_wmem_alloc))
failed at net/ipv4/af_inet.c (155)
[ 1788.473836] KERNEL: assertion (!sk->sk_wmem_queued) failed at
net/ipv4/af_inet.c (156)
[ 1788.473862] KERNEL: assertion (!sk->sk_forward_alloc) failed at
net/ipv4/af_inet.c (157)

Repro C Source Code: https://pastebin.com/qs5y6Bcy

Root Cause:

The root cause of this bug lies in the improper handling of socket
write memory management in the IPv4 stack, specifically in the
assertions within net/ipv4/af_inet.c. The PoC triggers a sequence of
socket operations, including socket, sendto, listen, and accept, with
crafted input data and parameters. These operations result in
inconsistent states of the sock structure, where critical fields like
sk_wmem_alloc, sk_wmem_queued, and sk_forward_alloc are not properly
cleared or synchronized. The kernel fails to maintain the expected
invariants for these fields, leading to assertion failures that
indicate a logical inconsistency in memory allocation or deallocation
for socket operations. This issue highlights a potential lack of
proper cleanup or state transition checks in the network stack.

Thank you for your time and attention.

Best regards

Wall

