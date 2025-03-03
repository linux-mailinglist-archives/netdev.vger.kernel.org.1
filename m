Return-Path: <netdev+bounces-171318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1576AA4C855
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0413AAA7F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BEA267707;
	Mon,  3 Mar 2025 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bx2wj7gW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C8267397
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019520; cv=none; b=LhG2Z0iPIl0H3mBFjtPe3J8l/JOxX5dxXRXbSsGvXcOeqLYPxj9dRe4i+mJux4Xt36q0skjMpWCOXjBz+o6Gp2BSfcSmZ7wA8+UepvtUZ1sqtTgBEeVgQmSIfQeWwfDJ7umB/Lvh+PjGTyqBuPAID2gr4kWLZhkvW9h7seRQdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019520; c=relaxed/simple;
	bh=ogk7ICgun509icSqfv3LLhxK0HyJB1uO830+G92khgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2/WGlPGjGtJHqiHRV6wlyw8Az8e8P5bt4572jZ4HKUkpC7lRVWwnoLZPxgIIkDS8NBpGRq9KXFpi5p+eYvYPjZ7me7+rWEhnEB3IQvOOPgtD8xJbN/eZKreQfVOwSys0XDEtQ+YWleJyYHosiy/vhKJoRDNHbwvl5d0+6hcYj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bx2wj7gW; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-855a8c1ffe9so126405639f.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 08:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741019518; x=1741624318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wol95raGQMZ+MJi1v3glm6RiUeoeTIMsXPnEu7OKMU=;
        b=bx2wj7gWhpiU8uP108NfbP7nsUURr2KOCr80ZeyviR6AF/Ef7hoxft/m+tq1w2A/fD
         +j8eQamotrAfAd21+q0kMTM0Q61ksePMIy/WtZ+VbzGJEF6n4mIc0wZRbKAYmzcQnCSl
         lyjsJjE6g10chmE6CnmGVhyfbtd3LIBccdUHJig0cC9+F8E5NarYNNpgIgiNhWkSBcoJ
         0xqLL7+v0AmZqv5Ap0RFVtYJ/yIEE7Wne1dIlrVwxVYyV4lGlwVmZzr1Z/ocqbZGmqpC
         AWX0KnjblyfrbX6dGdhZCX81SQqBlGbWyXxAb6E3MYXzODgoygbZGqD1khj+0nrHTHpO
         /EBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019518; x=1741624318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wol95raGQMZ+MJi1v3glm6RiUeoeTIMsXPnEu7OKMU=;
        b=AsnJOBhXmGWtUlDD7DoVkQYmcG6zwEbwXMp/ypT5hMtvb7rSZkhG+TYnzHFV2UKLMW
         HDr3WYbPbTCr3axDGyvrrq1dtLCnlRMFoNcP0+Y/n509xKCwV8GGXzrMXBe9A6DRM4+q
         Ia1+EW6uglFYBBM2jtnvJGqnGXoFizQ87ULwqBgLYEIJAYmY/mUuBKjMSS6RwxSG+Zs9
         BoUybpq7MdEhyQHT9ETCmUhvZv1KtBAz3kWTbC6BVse+dcofQUw+z48hvxrFI7dz72Bt
         gI1REBNaVyL3xmyf/bLig/yW2hhqi4zuo8IS5ZK0UrrTVhBQEBMfK15tizcmUKtnfk4w
         uaaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1VT0+Izq2Vidt9wJj5h34GoQiXxBDJ4mU9NicuLZeg3xJrBQd8CLz+cKBQ4dPgFYUkWHT9mM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ZX0Bas3xIsP4M2SzshDdwuAYcOPpql6ydDuyWG5fbqeYqiEw
	wnFGZ1mQ6ZIaZJ/Sa2rbHHjHl6wn/wEqLqxUmOtWUHln3p9ZJkqIjMC4R6eEOOm2oK2gC0Uah8R
	VltQRqvKi9pfp/c4OxytW6srpG2Y=
X-Gm-Gg: ASbGncs/Z3rL4UyjJUJgpWJ3Ynj0Ma5ySy8O9sAUOZv/XIzk0Jlk1bqq/IBQbtn1qcH
	brdmAVw+B3uNz8mIQN931zaTvRoO/sNIe/XG6TuhZ4bkPVbwC1Y5+awvWm0h/yIEDpk2Rw4IdtP
	lf5aMi2x8eOw+t07lYsfRhhIoa
X-Google-Smtp-Source: AGHT+IGleWaqyn7dvsPTOSRIMXE0ap/2CnnVzK7hAIjBZOHgdCegiILOxo/7SlGFxnfsvHQwBSYeOh8SGq8yiEXhpQU=
X-Received: by 2002:a05:6e02:1705:b0:3d3:fdb8:17a7 with SMTP id
 e9e14a558f8ab-3d3fdb81a82mr49390095ab.6.1741019518337; Mon, 03 Mar 2025
 08:31:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303080404.70042-1-kerneljasonxing@gmail.com> <20250303074105.0b562205@kernel.org>
In-Reply-To: <20250303074105.0b562205@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Mar 2025 00:31:22 +0800
X-Gm-Features: AQ5f1JpnxhJG-Sum7lE2HVpQMUurCO5DL8XtZivhs6h2DcyETzAfRRUsQXggLcY
Message-ID: <CAL+tcoCV-SbnMuJetKVuMpAhf_zuD5_+eHC_HLhdq-Jfp3H_+w@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: txtimestamp: ignore the old skb from ERRQUEUE
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 11:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  3 Mar 2025 16:04:04 +0800 Jason Xing wrote:
> > When I was playing with txtimestamp.c to see how kernel behaves,
> > I saw the following error outputs if I adjusted the loopback mtu to
> > 1500 and then ran './txtimestamp -4 -L 127.0.0.1 -l 30000 -t 100000':
> >
> > test SND
> >     USR: 1740877371 s 488712 us (seq=3D0, len=3D0)
> >     SND: 1740877371 s 489519 us (seq=3D29999, len=3D1106)  (USR +806 us=
)
> >     USR: 1740877371 s 581251 us (seq=3D0, len=3D0)
> >     SND: 1740877371 s 581970 us (seq=3D59999, len=3D8346)  (USR +719 us=
)
> >     USR: 1740877371 s 673855 us (seq=3D0, len=3D0)
> >     SND: 1740877371 s 674651 us (seq=3D89999, len=3D30000)  (USR +795 u=
s)
> >     USR: 1740877371 s 765715 us (seq=3D0, len=3D0)
> > ERROR: key 89999, expected 119999
> > ERROR: -12665 us expected between 0 and 100000
> >     SND: 1740877371 s 753050 us (seq=3D89999, len=3D1106)  (USR +-12665=
 us)
> >     SND: 1740877371 s 800783 us (seq=3D119999, len=3D30000)  (USR +3506=
8 us)
> >     USR-SND: count=3D5, avg=3D4945 us, min=3D-12665 us, max=3D35068 us
> >
> > Actually, the kernel behaved correctly after I did the analysis. The
> > second skb carrying 1106 payload was generated due to tail loss probe,
> > leading to the wrong estimation of tskey in this C program.
> >
> > This patch does:
> > - Neglect the old tskey skb received from ERRQUEUE.
> > - Add a new test to count how many valid skbs received to compare with
> > cfg_num_pkts.
>
> This appears to break some UDP test cases when running in the CI:
>
> https://netdev-3.bots.linux.dev/vmksft-net/results/16721/41-txtimestamp-s=
h/stdout

Thanks for catching this. I did break this testcase: run_test_v4v6
${args} -u -o 42.

Will take a deep look into it tomorrow morning.

Thanks,
Jason

