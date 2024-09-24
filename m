Return-Path: <netdev+bounces-129430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326D0983D18
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE6D281DDA
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 06:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C483EA83;
	Tue, 24 Sep 2024 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba9SbJDj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89401CFBC
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159055; cv=none; b=K5DembT92dOiEjkRUu7+hcDDp3nKlMgGKwGB5PaGVcjBZ1mU6Mf3iTpEw+cZn2Hv3LNeg/LlAfTmfqFFa4Wff08o9zWZ/aHovDDeNEL/6p7i8/ANGjcTmZkoGXRlv+6LBz+kB85ZVDpRb+gX22dZszgiYgwlXvles2T0Ci+XIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159055; c=relaxed/simple;
	bh=qntyfx9867ks684IncXrgi2RBueD+3EQo3GK4vKPQso=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BdkGjONCcLu4bi39JZtPsvNluQz46REnLVdx2L3B8giGhHXSJyY7YTyGYw5UkRuI3AXHYj6LWsdNdyj9c0yUvNfCcivxo9ji1JiHvnU7O9YGTIgJ4+u92bf13xWVcvoDdXoVYuMDUijexBUFR0Qy3oiwJCoGPLtDZlSIJXVd7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba9SbJDj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718e0421143so1031827b3a.0
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 23:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727159053; x=1727763853; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qntyfx9867ks684IncXrgi2RBueD+3EQo3GK4vKPQso=;
        b=ba9SbJDjz8gohbVam/RFlvRMcRxKfsJjLvCWepI8WSCVA6D9fpcGALOaD0jHEC+D2m
         zyNdT/URxXBtlSgLHh/SaEZoz7E836/8Oo9gSRqNKrd4i8yXBJcWFn9BS/XZ8qnNKr49
         6tL/nc1b3/xocEeDNmu/31cU4OlS6+X98OX2v//uDjuHXYVfvnhshjNAtvkRvhZgdHZc
         fzczA+ptkFBNnItEIPXEMqqIhPcvWbQeZ+H0oU3WflVX/rZNcwcyIjSK+5Wo+3wgouzq
         o0SmOQTKJpsJmJ/k/gzbMpc/0WmswzMD2tI9KLpf5QWRSrB73OrOiTWPOqtY/gxBJJc7
         gmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727159053; x=1727763853;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qntyfx9867ks684IncXrgi2RBueD+3EQo3GK4vKPQso=;
        b=GVnZ+F5IGascSqgEBFd9hBVObWTd0UQvATy2XvIwJTMVEv/H5tLAbs+ruk1GB++z7S
         vVH3a4GEhmFK2RCEZ82hP+seEe46RDpTC6sl/+uVgb2cvA6Vk9LMK6OisDjQQolulhwe
         EQT57RPln8QplVLyTkgbJTyuSwWhtBY5S5YmmSz4k9jCT6Cd4fjm42vK5VboS9VaL4lm
         mk7An/XPE//j1BP+RoAD1bQ08VY5vKTEr9CkRrLWIWfWsCXzereCmsX/zeeYtjtIpPtu
         3uuz+5K5m35/aNORcf/W6LCANgNJv2NHg/N4KtTtQlYqp8lOsYVRa8FcYaeFtl2wNiw6
         8WwA==
X-Gm-Message-State: AOJu0YyCQj7JmmsBb4tPR22xYaA9TjzGTacjM/oLQfMN7oKdFcfcC4yI
	2EPgQ2pcSKpJUkUc5pNKPaCpFy5go4CQDCr+U22jpUdqyqRX2khA
X-Google-Smtp-Source: AGHT+IHDSXIG+2+Zgkdu7DhpJaRiMPgLbMH/l/zvhNsAPn/+snHryhsio4KiJRrViM+cTICBPKAEnw==
X-Received: by 2002:a05:6a00:2d25:b0:714:2198:26ae with SMTP id d2e1a72fcca58-71afb6f89b9mr1042400b3a.5.1727159052771;
        Mon, 23 Sep 2024 23:24:12 -0700 (PDT)
Received: from smtpclient.apple (v133-130-115-230.a046.g.tyo1.static.cnode.io. [133.130.115.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc844471sm553604b3a.77.2024.09.23.23.24.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2024 23:24:12 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [BUG Report] hns3: tx_timeout on high memory pressure
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <3346a456-48f7-44e4-b9f4-c7f13032d820@huawei.com>
Date: Tue, 24 Sep 2024 14:23:55 +0800
Cc: netdev@vger.kernel.org,
 Shengqi Chen <harry-chen@outlook.com>,
 Yuxiang Zhang <zz593141477@gmail.com>,
 Jiajie Chen <jiegec@qq.com>,
 Mirror Admin Tuna <mirroradmin@tuna.tsinghua.edu.cn>,
 Salil Mehta <salil.mehta@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC72134F-DF4F-4CC5-90B8-D2DC037AAAD0@gmail.com>
References: <4068C110-62E5-4EAA-937C-D298805C56AE@gmail.com>
 <56bbcfbd-149f-4f78-ae73-3bba3bbdd146@huawei.com>
 <F90EE18D-1B5D-4FB2-ADEB-EF02A2922B7F@gmail.com>
 <fb813399-b1a5-489f-9801-f9f468e2beb0@huawei.com>
 <A8918103-4A1D-43FF-9490-1E26ABEDA748@gmail.com>
 <3346a456-48f7-44e4-b9f4-c7f13032d820@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)



> 2024=E5=B9=B49=E6=9C=8824=E6=97=A5 10:06=EF=BC=8CJijie Shao =
<shaojijie@huawei.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
> on 2024/9/24 0:12, Miao Wang wrote:
>>> 2024=E5=B9=B49=E6=9C=8823=E6=97=A5 21:37=EF=BC=8CJijie Shao =
<shaojijie@huawei.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>>=20
>>> our analysis. I wonder how can I verify the scheduling of NAPI.
>>> You can use napi trace to verify it:
>>> echo 1 > /sys/kernel/debug/tracing/events/napi/napi_poll/enable
>>> cat /sys/kernel/debug/tracing/trace
>> I managed to make a reproduce. Attached is the dmesg and the trace =
log. It seems
>> that in the trace log, napi_poll() is kept called.
>>=20
>> My reproducing environment is a smart git http server, which is using =
nginx as
>> the frontend, git-http-backend as the CGI server and fastcgiwrapper =
for
>> connecting them, running on a Taishan server. The served git repo is =
linux.git.
>> At the same time, start some programs taking up about 70% of the =
system memory.
>> Using several other hosts as git client, start as many git clone =
processes as
>> possible on the client hosts, about 2000 in total, at the same time, =
pointing
>> to the git server, letting the forked git processes on the server =
side take up
>> all the memory left, and causing OOM on the server.
>>=20
> Hi Miao,
> Thanks for the reproduce. I checked the dmesg and trace log of napi.
> We can see the first tx timeout occured at the time [19555675.553853], =
and we
> can see the napi poll seems keep being called all the time. Exactly =
the trace
> log is for all the napi context, and we can differentiate the napis by =
the
> address of napi struct.
>=20
> For we can't direct map the queue id with the napi poll, so I just =
searched
> several poll records of them.
> We can see some napi poll haven't been called for more than 5s, exceed =
the tx tiemout interval. It may caused by CPU busy, or no tx traffic for =
the queue during
> the time.

Thanks for your analysis. There are network interfaces driven by hns3, =
tuntap,
bonding, vxlan and veth on that machine. As I can find in the source =
code, only
hns3 and veth are using napi interfaces, but I cannot find a way to map =
the
struct address with a specific interface.=20

It is also strange that why the stall happens, since I've never seen =
stalls
like this happening on x86 machines with the i40e driver. Currently, I'm =
lack
of testing resources to see whether this only happens on the hns3 driver =
or it
can happen on other drivers on the arm64 platform. It would be nice if =
you can
also reproduce this symptom.

Cheers,

Miao Wang=

