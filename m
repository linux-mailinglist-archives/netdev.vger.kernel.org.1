Return-Path: <netdev+bounces-128732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E153B97B43E
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 21:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6166D281724
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 19:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2A8188CB0;
	Tue, 17 Sep 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXYeyebo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F711165F13
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726599876; cv=none; b=RhyKT5Jm/Q0JD8PauZaYQo8yNbwkmqJJwA6/uz8Ya+Ynlnu6TtTfvtOc5ak6FK67ZBrBwSGDOyOFKYZKM2FH0/tdWco+TDEHs8RNiu7YNXI6cL2r/qOct4Bd+zDF+xjbCU34weHnfoBHoRskdTKh6cdbkUdhO0I3VznkWpyVxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726599876; c=relaxed/simple;
	bh=/T/wYacxPbGQElSY0wpDTroRlXLPyMVSqBZGcLXADTk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HwYkUOas4uOGw6jrNRrG0RpXixc+18w9fkq9hg2CjoPB/h4lM9K0kjbzOGRavashMxFeu93NEWYg3PcGpJyxNuy2Y0AzOVJnDYLdWzgfX0HVrR1o+sGfFk9iUTN6Al91G4Sc08RgtuOL0SlitNCEtjpV+T+axpdHgLWEfYkysCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXYeyebo; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c3d209db94so784136a12.3
        for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726599873; x=1727204673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/T/wYacxPbGQElSY0wpDTroRlXLPyMVSqBZGcLXADTk=;
        b=GXYeyeboN+W+qpVbt2rFScE7tg4OqKFx27l/b2qQFOIRDBlR4jFix6l4yLSyCkxoRW
         q19B2cE0xC0vk08XYKYKWZA2GySnCWQc2eMcTYT4y8wtO0d3TCxwA3z5PSF7lhpRVQyo
         YvBwhBAVNGub8Qua4R06JILhZExP3rbtxFNlyFP0n37WERXqbUTvmsvz12VufqJ59mzc
         Zf+i1GibygE4K8vviiVdXkDpq7FVNXRtvCVRfA+66jEplJOmjaiqRdx2iI8637m0L0yE
         T9eFgqq5VktKL+18ToEMbPWI/8ONS6ZHKeTh/d8FLuB4XMVa1U44Kw7J80EMftJn1JGW
         u9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726599873; x=1727204673;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/T/wYacxPbGQElSY0wpDTroRlXLPyMVSqBZGcLXADTk=;
        b=gkNdqkjmIl4t7D91TsJjCsl+X3ifSU1MrvalrcyBA//41FfjaVVAYQkrEFJfMqED1U
         dAYzWR+q2oHrfRl75uQoxKrhSTa1j25xuZifT12YRuyOlw3fQRvLh1Zw8DFpUpcfB1zj
         Gyh4XUQjGehB5nnqjNUbN4VuGx2Bu8OFvZ1+4ESf/zOgp2uMJ9mphUfszKfOaLJsPPtf
         7z2yTel20/4UbGhl4LwIGOQZGqU+6eEb1+Kt+Q+RQfbZ3fwBy8Tj0t8bXnGue4xIBvhz
         9D0qRUkZTYE76RFR2/3FshaTC9unyZ5xNJkaw7fCUr5zgq+rBjmHRx1Bb/5f8cmphOt+
         RCSw==
X-Forwarded-Encrypted: i=1; AJvYcCXPL4U/sX42vpWj360KGuBAvFhWHy+54i5k8Kw3CmsFx2Z64dJMeXqKJLzWfCr5AK31Kh1NzTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmVu7Q+dfaglBWQpfVfqaoZCvZl5GrtZu8aizFs22LpK1dy/H5
	7gT/Gwb6afJm7YiHFCJW+p5lJ2e0qnr+VRx1C9abxKS29JJe1sDr
X-Google-Smtp-Source: AGHT+IFiZlzmQoy0PdrXcsZeQOYu+NWK9q7XzKl76DUKR8DZxkjQ8rAgu73+gU6992dn65+BPSsbLA==
X-Received: by 2002:a17:907:1b13:b0:a8a:78bb:1e2 with SMTP id a640c23a62f3a-a90293b15e6mr2372417566b.6.1726599872533;
        Tue, 17 Sep 2024 12:04:32 -0700 (PDT)
Received: from [127.0.0.1] ([193.252.226.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3f62sm480715266b.137.2024.09.17.12.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 12:04:31 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <e261cce8-bd41-4f7b-b035-2480fe0e36c5@orange.com>
Date: Tue, 17 Sep 2024 21:04:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH iproute2] iplink: fix fd leak when playing with netns
To: nicolas.dichtel@6wind.com, Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org
References: <20240917065158.2828026-1-nicolas.dichtel@6wind.com>
 <20240917081102.4c00792f@hermes.local>
 <bfe6f4f8-b7a3-4ea1-886b-9929c7bf366f@6wind.com>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <bfe6f4f8-b7a3-4ea1-886b-9929c7bf366f@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 17/09/2024 17:17, Nicolas Dichtel wrote:
> Le 17/09/2024 =C3=A0 17:11, Stephen Hemminger a =C3=A9crit=C2=A0:
>> On Tue, 17 Sep 2024 08:51:58 +0200
>> Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
>>=20
>>> The command 'ip link set foo netns mynetns' opens a file descriptor t=
o fill
>>> the netlink attribute IFLA_NET_NS_FD. This file descriptor is never c=
losed.
>>> When batch mode is used, the number of file descriptor may grow great=
ly and
>>> reach the maximum file descriptor number that can be opened.
>>>
>>> This fd can be closed only after the netlink answer. Let's pass a new=

>>> argument to iplink_parse() to remember this fd and close it.
>>>
>>> Fixes: 0dc34c7713bb ("iproute2: Add processless network namespace sup=
port")
>>> Reported-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
>>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>>> Tested-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
>>> ---
>>=20
>> Maybe netns_fd should be a global variable rather than having to pass
>> to change all the unrelated function calls.
> I hesitated with this option. I don't have any strong opinion on this.
>=20
> Note that two variables are needed, because the link_util->parse_opt ma=
y call
> again iplink_parse().
>=20
> Another note that I forgot to mention: I didn't fix devlink which has t=
he same
> problem. I was waiting for the conclusion of this fix first.

Another option would be to append "cleanup tasks" (a function pointer and=
 a
single arg) to a global linked list; and call the chain at the end of the=

execution of each single batch command. This allows for as many fds as ar=
e
needed, and other cleanups as well.

My $.02 ;)

