Return-Path: <netdev+bounces-121918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D40C095F3A9
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2C01F21C43
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 14:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0FF18D624;
	Mon, 26 Aug 2024 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPBan3rk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D77BB15
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681795; cv=none; b=llpFDYpNvt27LHFsDNrtLnbROn+zJ4DFs2dPB4pzCr0GW4FAreNltKd/06CmjSLbwzY5UTw2k4QQtmjD946+AeEvo8hbZGMKXEIUbo/cIsHYvTH7ArjBwwZGa4/7bNOsg9XAhC9J3lWFBrYwUOsEfGc62lV97RUUQbvmVdOFZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681795; c=relaxed/simple;
	bh=v1Xe3susNIUP6eTSfkqJrSP1V8+XilN7nn1ic9qhbf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQRSvTPtnJg/GwmFS/E+4Z3u+Om7PECNmWBL0/uYaJwNfW8IlDLXtE5O8dLQZGB4/JWdMR516U7hnpqFxRnjhZjX6dRT8mpPbgfdRDaakCtwJrmE5n02LTBwn7yAA7r0igITNPLWUo/jNZ32XNe3+3P7q+TN9oAshMzxzZjI+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iPBan3rk; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86cc0d10aaso143802466b.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724681791; x=1725286591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1Xe3susNIUP6eTSfkqJrSP1V8+XilN7nn1ic9qhbf4=;
        b=iPBan3rkVGcAedYb88rylUcF+hhpvwTiuzpsDb7YFHmWeCGHeaaVfwaZr0O3gUt2fX
         R+GkWSOCEVfbx+N0qeB2ndD+6P3ToZHhRWj0hl+eXbSV3n3G3QncaoNbSZinvawtYk8K
         QGZ0pm/ak3h7ECxtRwKFiRYuWJzDE3ZF/CxVXXlqyDokTr+/v1RV0X/fYhsTPVpy2rx5
         ufQ6UhdWs1460U5ujMTjJaKLJLJoYNyAT8SUUQBhSbwJd1RoqZzssCL1Rb91yCP7oZkf
         GUpemHMqK297ZovYTme4g5wTtEGXXPqieh1AkZNoPMrZI44WGQu0JXJliS1l9aw62eMN
         8Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681791; x=1725286591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1Xe3susNIUP6eTSfkqJrSP1V8+XilN7nn1ic9qhbf4=;
        b=c/8Abu3mAWM78MGK4Jd++1NjsyZ+w2WHewR1gJFAUxTD+j9aK58dUNyl3ptdetkrPi
         hKjRxcd9FMe8XbYpT+MiP4HGZ1OCrpksmLSni9l1vCTy2SHYcvtMYX/w2nQyMa0l2m7W
         b6g4TPyaUr6Mq78ApWh/6Jp53Re1D4IZAE1xVRPv1PlXANHaSRh29s18faz1Spgg7dp/
         BFXOzVYF76rNA2kR/KMlPFVYcnXjMcpOZYVrPZdad7U+DEnTKwnPFqAHtRfzJc3KRWje
         pJnPZlm8uClm/MHy7+3NqvSCUOpFme4xOSNrtW+KRkLsVREVuQr+KInf+GXNOcdFGjM1
         np+w==
X-Forwarded-Encrypted: i=1; AJvYcCUZt0lcHtCapTdbwyPNPCgl9+Crs30MNum9S56SN77CDimrAw1cHOgeGSgfH3i+FjhDgn6N4VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYagS+E23CxfrrFIDgE/PVVK25UlOQQW7glL6QLOaIHobATbq4
	6M/xjqBwaQR030JkfY4vL7JRiy9zGJdaGPBukhKAGo1YSIb0YU58Zln4s2LuNqDg3setZRX8WbL
	8VthcR9XemyVa1dOrXK8kPlFgRVy4TeLZDLKt
X-Google-Smtp-Source: AGHT+IHc1AVF/HZHw0p/eGvidrZmazV7XPNxl3Yz5fKQoiTUfqWqxNNdSA3m8Ngw+wN2jEEGvwjeklKa00kNbFG6d8w=
X-Received: by 2002:a17:907:8688:b0:a86:7af3:8299 with SMTP id
 a640c23a62f3a-a86a519896amr687802866b.25.1724681790338; Mon, 26 Aug 2024
 07:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHOo4gJRxYjEmQmCv7HRq4yB-AX_0f=ojLmU8PWrmjEhkO+srg@mail.gmail.com>
In-Reply-To: <CAHOo4gJRxYjEmQmCv7HRq4yB-AX_0f=ojLmU8PWrmjEhkO+srg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Aug 2024 16:16:19 +0200
Message-ID: <CANn89iK6rq0XWO5-R5CzA5YAv2ygaTA==EVh+O74VHGDBNqUoA@mail.gmail.com>
Subject: Re: INFO: task hung in unregister_nexthop_notifier
To: Hui Guo <guohui.study@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 4:13=E2=80=AFPM Hui Guo <guohui.study@gmail.com> wr=
ote:
>
> Hi Kernel Maintainers,
> Our tool found the following kernel bug INFO: task hung in
> unregister_nexthop_notifier on:
> HEAD Commit: 6e4436539ae182dc86d57d13849862bcafaa4709 Merge tag
> 'hid-for-linus-2024081901' of
> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
> console output:
> https://github.com/androidAppGuard/KernelBugs/blob/main/6e4436539ae182dc8=
6d57d13849862bcafaa4709/6548016d46a859fa33565086216fc61c6696a59e/log0
> kernel config: https://github.com/androidAppGuard/KernelBugs/blob/main/6b=
0f8db921abf0520081d779876d3a41069dab95/.config
> repro log: https://github.com/androidAppGuard/KernelBugs/blob/main/6e4436=
539ae182dc86d57d13849862bcafaa4709/6548016d46a859fa33565086216fc61c6696a59e=
/repro0
> syz repro: no
> C reproducer: no
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Please let me know if there is anything I can help.
>
> Best,
> HuiGuo

I would ask you to stop sending these reports, we already have syzbot
with a more complete infrastructure.

