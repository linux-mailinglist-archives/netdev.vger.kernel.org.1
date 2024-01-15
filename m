Return-Path: <netdev+bounces-63538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8881C82DACC
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 15:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B861C219F6
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 14:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF6E17573;
	Mon, 15 Jan 2024 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0TTcY2I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FDC1755A
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e7662621dso11780795e9.2
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 06:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705327206; x=1705932006; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gyo9FuekjQ+9Dbjyoupjim+AL3N8CXgj5TUN75dzeaM=;
        b=I0TTcY2IwKzHZsNekqro8bjj9Bz1+BG7iEA8YubjSDUHC6VDD0s77zsjGx9qoIlnjK
         xo/uBFRLLnCtqb5GIFOz7Vyv8vUNLInQTxus55VJPdEbIQU2e+v0KNHwksZEDzgo9wHa
         bSAf+dJPjKfWCiTb/VLBgy/sufWscH1GwB89KYS55LUmRTqgKwMsH32EMT4cPlRBMsMh
         jLJcENb1zVKvcTSw+NSwLhkDRA4Q3qfjoACLdVs0V032Bqb3hivhM1wlzdNfLNQV42BU
         XdatTsejBmqoiNWecV9HIdEooMLiC39tHDZP1hoNzm6c4/rNjcYk5ZC1STGLKAF2lPOv
         GwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705327206; x=1705932006;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gyo9FuekjQ+9Dbjyoupjim+AL3N8CXgj5TUN75dzeaM=;
        b=FTgywullNcfTry+h93UTq0GjeK0lWYkDFNxwMR06pc+VmHxAUcrUwEFAVvSotrBiXY
         a/4l6+D5SwABVrNTcMye5e10gO68rD/GSdrWmz6kXgX/WA9MR0U3zGKz++CGzFjkWKYc
         MdlOcK251/vPNY0xJprFiaFFwn+uPTRFPdY2VNTMulGverRMOrIPmb705FTa4my0SgpV
         jTfIT+XWEya+blz3P+R8pvOJEMUGU/r3aYVbYNCMlynNzYQtUQkRLVqTNgdU/vYUPmfH
         5as9Kmcn1f6H4N7mAnb7H+haLnqGl4PaiEsJVyg6clUzgMBtNJ6c7NNL9AF6ynM0IlOf
         rwJA==
X-Gm-Message-State: AOJu0YxWpvK3VrOdwfVvVwweObYN16sO4p+93U1GCBS0ARGeUherf5Rk
	gRpsQbgrJF8oAAYYCYF+FEHXtuoPa2HIQQZK1pGi7iuine4=
X-Google-Smtp-Source: AGHT+IFX9k5pdasipnrhZNVtpUtYorWl610YCWIl/rWTmaxEGdsADI7/Z3brzSnSI86aDWAi7JWBUzIbNo9fiRMAna4=
X-Received: by 2002:a05:600c:4e90:b0:40e:44c4:c4ae with SMTP id
 f16-20020a05600c4e9000b0040e44c4c4aemr2705822wmq.48.1705327206008; Mon, 15
 Jan 2024 06:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= <socketpair@gmail.com>
Date: Mon, 15 Jan 2024 18:59:54 +0500
Message-ID: <CAEmTpZFZ4Sv3KwqFOY2WKDHeZYdi0O7N5H1nTvcGp=SAEavtDg@mail.gmail.com>
Subject: Kernel BUG on network namespace deletion
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Kernel 6.6.9-200.fc39.x86_64

The following bash script demonstrates the problem (run under root):

```
#!/bin/bash

set -e -u -x

# Some cleanups
ip netns delete myspace || :
ip link del qweqwe1 || :

# The bug happens only with physical interfaces, not with, say, dummy one
ip link property add dev enp0s20f0u2 altname myname
ip netns add myspace
ip link set enp0s20f0u2 netns myspace

# add dummy interface + set the same altname as in background namespace.
ip link add name qweqwe1 type dummy
ip link property add dev qweqwe1 altname myname

# Trigger the bug. The kernel will try to return ethernet interface
# back to root namespace, but it can not, because of conflicting
# altnames.
ip netns delete myspace

# now `ip link` will hang forever !!!!!
```

I think, the problem is obvious. Although I don't know how to fix.
Remove conflicting altnames for interfaces that returns from killed
namespaces ?

On kernel 6.3.8 (at least) was another bug, that allows duplicate
altnames, and it was fixed mainline somewhere. I have another script
to trigger the bug on these old kernels. I did not bisect.

````
[  494.473906] default_device_exit_net: failed to move enp0s20f0u2 to
init_net: -17
[  494.473926] ------------[ cut here ]------------
[  494.473927] kernel BUG at net/core/dev.c:11520!
[  494.473932] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  494.473935] CPU: 3 PID: 3852 Comm: kworker/u32:17 Not tainted
6.6.9-200.fc39.x86_64 #1
[  494.473938] Workqueue: netns cleanup_net
[  494.473944] RIP: 0010:default_device_exit_batch+0x295/0x2a0
```

-- 
Segmentation fault

