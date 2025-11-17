Return-Path: <netdev+bounces-239045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1035AC62E5F
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C2E3B103C
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615CA25FA0E;
	Mon, 17 Nov 2025 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pUrsFyLW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A383727B32C
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763368332; cv=none; b=pd/OOCQ0/g/JFkr2pZhyWQqOho2PD8vIh7c3A6lAjt7/X7PLWf2fYscCoetVEqmYOd1aFU2RnRiwJrY1CB/sIyQ0JgEebkup2hH7ThuIkfToHfa0jHllzHjeJlwxAwE158LptN1D/u4TXIXr7S3qPL3jZUHTYZqZAytG9xFHCpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763368332; c=relaxed/simple;
	bh=AUlAivcEHi5L6wRavWTe9ZXTTU+8BH4fDz/miIiqsPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0QqPVKBo1Ozc/X4Pw/0ZzCWaE3aYNU52hyZnJjEl2xTrNqUPzqa3Kj5zDiJ/dOSxEkaa3ilwdxDquz0Kq3/Q9Dgt8SfWYZAgHMD4j/TmPTDg8xpaLU9L0qOS5DYxMhuDd8QXdBFFf+ixVux5mSMN2n387I45hjDGIXerVMBx9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pUrsFyLW; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8804ca2a730so56403966d6.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 00:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763368329; x=1763973129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NFjawquwtBKi9dRPXkr3le19aibIbXrAivqnHmuCQ0=;
        b=pUrsFyLWEmV5IaEm2AhW92jODG94bTaFpxZqHq6OTv6Rz0XFGIV8V+FjYhq+j0FIHw
         zAnfys9su7eiIW+MvWXXULZ+IpZztLXUte5ulNWN+WZYn/YATHgi0SQLZpjWYAospkbE
         Wig3h9Gba3KssGlQsOI8CGRFfCdwmyF5450O7JWVG2fcBMvZ9QZffx8sZm3g8d2YhHLK
         GvrMpBDejQxZNcax9UesDlQxeX/7gEyaU6eR/SmNP8j4OfXeIdpTGQGHz9VJEe8KfDgz
         MlPQYF+vbFnfvzFoq7yVjZe7Ee4aZoIN3qK6Mm9TGIXwuJ66vyV9PNSHIXAvaDo7hiMA
         cOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763368329; x=1763973129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9NFjawquwtBKi9dRPXkr3le19aibIbXrAivqnHmuCQ0=;
        b=TP4EkpJQVZvf2pHQC5vkqQvXNQT7ij+53+er4rmL+1VZttAJvmmI3NDiikWQVh+h3V
         KUG1r+9MqVd7YAEUk961fWfO+ImKKstzvJKid+82sUnGbDWVXbpOGgbEhE7Xan3RMRSv
         KfRpBxiEZAXizeHfDleO8hkZg3nGZSsWysq6PRdSl+Pnb2fbePISs2zAjHJKpFWOaGza
         pObSl6rLQUq8Zt67fH+uKQ1QEghrwOwPDq4wTFuNfQ7tQckR1mSDDFI9i5hdcW1Na3ZN
         27dE5U8RsGCHb4uJFvylYbS9/0kOJJ70+ykct/xq+F4aYVKD1uyLctcf01IRbb8rObR9
         q5qg==
X-Forwarded-Encrypted: i=1; AJvYcCWjP8KCDumOnljwHwnk4aCEWAPGdKcJRfK3RYLHVjsxzPxcUDTjOuho+6OSC/jpel05Bj5yK50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4EKn8shKXwPUmXcE34KvQO6nV3f1V6GwdsZuTzNJKyRDOzsBE
	SrSjORIcd+idqKhXXbbBW60gEL8drR8VwBERPWdvtphw8YLOnq5HXsm0rbDjRtdihvxZ8RJ+EMx
	ocO1EyynF7cxmMzeV7A+zi9GILrm3YB8fu+7+dOjw
X-Gm-Gg: ASbGnct0fhtq+fCD4snQ6VkTsJUxWAihG26j6JD3+2QaopQStOoTMX1avu8GHQxWubM
	aEFgWfWQSxLtTAqjvvLPIUG3d78Sw8Bg2DxIdqqbOBiVKiFTU/1iiIWXyIALvNGhsPgypg10dRo
	hdri9+D+tE22OGs95lgzcSZIUGEjvkmU1aAmzs34lFqJ/3kQO5NWk3wdfnFibirHVcMaHjH+wvG
	G950rkSu2+pqJWJvwCgigG0SlroyF/fBKqo6Gs4D+TnPlh98V13aiGpYPEepS3c/rGN//w=
X-Google-Smtp-Source: AGHT+IEp6BfXepOVS6/t8BlYEU9QQqZs/Z5E/+w6lk14z6d9MriVg8ZmUeHwF81lEkJ0EJjNohlhk96VO7ReWhiaznw=
X-Received: by 2002:ac8:7f91:0:b0:4dd:7572:216f with SMTP id
 d75a77b69052e-4edf208640dmr135520951cf.32.1763368329152; Mon, 17 Nov 2025
 00:32:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <691ad3c3.a70a0220.f6df1.0004.GAE@google.com>
In-Reply-To: <691ad3c3.a70a0220.f6df1.0004.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Nov 2025 00:31:57 -0800
X-Gm-Features: AWmQ_blmoUn12CUhwP5gywrP_yV8V1eZfjn35erz9AxT71V-1mWZ2YI5vSZvd0w
Message-ID: <CANn89iJmyNNQEmy714JqYey=P5JKgzmPvOSaZVV4OUfy5e1xGw@mail.gmail.com>
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in mptcp_pm_del_add_timer
To: syzbot <syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, geliang@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 11:50=E2=80=AFPM syzbot
<syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    98ac9cc4b445 Merge tag 'f2fs-fix-6.18-rc2' of git://git.k=
e..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1712bdcd98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Daf9170887d81d=
ea1
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2a6fbf0f0530375=
968df
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/aa708867a71c/dis=
k-98ac9cc4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5d853b65c8dc/vmlinu=
x-98ac9cc4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f0f012153d60/b=
zImage-98ac9cc4.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com

I can post a V2 of
https://lore.kernel.org/netdev/20251114223136.113011-1-edumazet@google.com/=
T/#u
including two more tags.

