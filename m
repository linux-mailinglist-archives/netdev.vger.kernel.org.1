Return-Path: <netdev+bounces-129302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E8697EC0F
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5AF1C2132C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 13:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C56319923F;
	Mon, 23 Sep 2024 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMte35bR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE82197A7F
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727097123; cv=none; b=kiF7v9WfLQJw4MFcmcoZWJ6s4TdjoS2D1IN1yGnC0e6Kt683pg+zQSSrENRPBLpPYZN+vHqv7t6KO3Yznyodkoag95HJfihNsWP4XAG3OayH+hRrxXJsll2y4gc/ugHz1RBaxLAU2ulKc1aicQHZO6lXB6ZkfYNsAy7YeR2LorM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727097123; c=relaxed/simple;
	bh=PVko/03uJhOuekVNS68hKjs7Zi++mtXcGg9D0OwjVCE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=X2RMftrDxPKBJgHNCxvMoSLtJiFSU2KRBHCZwt0QUbcfiM92IHAcqzjn0HM27/SXHEkQMo4ICr7sr8IZrqYcy7mjxvF16OkdZKq9DhSjOmfc2uL3kcLNqfJyUafxHZ2l99cTo+DbAKMh/gOZVsI583y4SeZe+53u229gbXB7VYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMte35bR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d883286bd2so319677a91.2
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727097121; x=1727701921; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YsCYE29OlECVOjROSH9S9XssuhzXXNiKT0BJorJu7M=;
        b=VMte35bRS99UTR7RFPYPj7bfBVvwJCYgSUZXxu/w+rzbmFE2yxtAkZCBfAHt3n29W2
         9hfmp7gjICeBtq0eFSeQQuGDawpXG12g/N/YyHy5e1VuYlEwipIcSDfDtz4cYtUH/z6k
         tW0be/QWKbDHE6Fs+LVrGYT7BUDWqCGq13q4pyJvibi5o7UTqTQkKef5qdKUR7gn4K18
         I3FkKHw0L8RIkT1+WC6jUWTa6zu6fH/8oxOlzJbcuomSTV4CwO7F21huaxcqqx6n+54f
         mN76uJOCiyBgJbkDMcs3IZRICWFtMYmnCIAj1URiFzLlLF6IdpaVn8K0DPjznK274rRN
         oOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727097121; x=1727701921;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YsCYE29OlECVOjROSH9S9XssuhzXXNiKT0BJorJu7M=;
        b=w4GbjrbYTQMMqem6jwAuwRvplrVpp/+fLABSqLvH0ENLygdNImA/ES92q3KSR4quIP
         57vJS+s314C0s3Y6Cx+OM5LBLhh8fQHOVNutW3nR9CvMHo8o8pDlIuG8TvinMANGTb3q
         QAcXw0PCF560dnlu8Bj4pjneM8dAZU3K6MG9RQ7TTRUAAKlOf7pl7w3cF0gty4u/PY16
         UJlJ6/89DJGQsSVRhNtbm4xFBROx9ADGnx1ymyTHhdxcPv1YHJ1giLYOdZFBNyDKZ6Ic
         wxMv7jhW1ddxx7hVDTQ5iEmbmwpXBchGZTQm89ATmQKsuOWoHAo80nIxk3kmgRVXgcK6
         kXXQ==
X-Gm-Message-State: AOJu0YyqNfZ8/3i/uWUMLnjYBEmGVZguJ57H/Oxx+92EOfhMKQPSOmdj
	ELd21nKJGLjTFdSV7/S9idXvEq4qmiSqXhi0elmnHDh19Pa+Xcbc
X-Google-Smtp-Source: AGHT+IHRD+JnD4rDliR/9PKxpFYluB7R4ukm+m8cMT7kTitDaCCNfKKiFszPw+RE+6kyYuoCtN/iBg==
X-Received: by 2002:a17:90b:3a8e:b0:2d8:9ce8:f4e0 with SMTP id 98e67ed59e1d1-2dd7f7008c5mr5570084a91.5.1727097120746;
        Mon, 23 Sep 2024 06:12:00 -0700 (PDT)
Received: from smtpclient.apple (v133-130-115-230.a046.g.tyo1.static.cnode.io. [133.130.115.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f7b9e80sm7231763a91.10.2024.09.23.06.11.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2024 06:12:00 -0700 (PDT)
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
In-Reply-To: <56bbcfbd-149f-4f78-ae73-3bba3bbdd146@huawei.com>
Date: Mon, 23 Sep 2024 21:11:42 +0800
Cc: netdev@vger.kernel.org,
 =?utf-8?B?6ZmI5pmf56W6?= <harry-chen@outlook.com>,
 =?utf-8?B?5byg5a6H57+U?= <zz593141477@gmail.com>,
 =?utf-8?B?6ZmI5ZiJ5p2w?= <jiegec@qq.com>,
 Mirror Admin Tuna <mirroradmin@tuna.tsinghua.edu.cn>,
 Salil Mehta <salil.mehta@huawei.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F90EE18D-1B5D-4FB2-ADEB-EF02A2922B7F@gmail.com>
References: <4068C110-62E5-4EAA-937C-D298805C56AE@gmail.com>
 <56bbcfbd-149f-4f78-ae73-3bba3bbdd146@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)



> 2024=E5=B9=B49=E6=9C=8823=E6=97=A5 20:58=EF=BC=8CJijie Shao =
<shaojijie@huawei.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
> on 2024/9/23 0:38, Miao Wang wrote:
>> It seems that hns3 driver is trying to allocating 16 continuous pages =
of memory
>> when initializing, which could fail when the system is under high =
memory
>> pressure.
>>=20
>> I have two questions about this:
>>=20
>> 1. Is it expected that tx timeout really related to the high memory =
pressure,
>>    or the driver does not work properly under such condition?
>>=20
>> 2. Can allocating continuous pages of memory on initialization can be =
avoided?
>>    I previously met similar problem on the veth driver, which was =
latter fixed
>>    by commit  1ce7d306ea63 ("veth: try harder when allocating queue =
memory"),
>>    where the memory allocating was changed to kvcalloc() to reduces =
the
>>    possibility of allocation failure. I wonder if similar changes can =
be applied
>>    to hns3 when allocating memory regions for non-DMA usage.
>>   =20
>=20
> Hi:
>=20
> in dmesg, we can see:
> tx_timeout count: 35, queue id: 1, SW_NTU: 0x346, SW_NTC: 0x334, napi =
state: 17
> BD_NUM: 0x7f HW_HEAD: 0x346, HW_TAIL: 0x346, BD_ERR: 0x0, INT: 0x0
>=20
> Because HW_HEAD=3D=3DHW_TAIL, the hardware has sent all the packets.
> napi state: 17, Therefore, the TX interrupt is received and npai =
scheduling is triggered.
> However, napi scheduling is not complete, Maybe napi.poll() is not =
executed.
> Is npai not scheduled in time due to high CPU load in the environment?

Thanks for your analysis. I wonder how can I verify the scheduling of =
NAPI.

>=20
> To solve the memory allocating failure problem,
> you can use kvcalloc to prevent continuous page memory allocating and
> reduce the probability of failure in OOM.

I'm not so familiar with the hns3 driver. I can see several places of =
memory
allocations and I have no idea which can be replaced and which is =
required to
be continuous physically. I'll be very happy to test if you can propose =
a patch.

Cheers,

Miao Wang=

