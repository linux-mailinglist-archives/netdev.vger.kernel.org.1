Return-Path: <netdev+bounces-248015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F11D02031
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 11:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB965310ABA1
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CB542C3F7;
	Thu,  8 Jan 2026 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gh5nmJmh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E94366FC
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864195; cv=none; b=fKj2PmL0npsY/CpzjNPXJiNm+stVFPX6FVue5aoHWi92FnHCT1sWxb1bi4nK8pP860oKXR/8F4NprgYP4Z8R+LaZJLaw40at0lzII/UGN0D4DpmQqQTQkiAeGQiiA852ptI3b1zNAnGzxzyHCEjriDA2O/hwRJmC8SeDUM1wbPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864195; c=relaxed/simple;
	bh=pfSA6BFLcq+T+Czfs8ZmyisuGlZDzt+vthInVmHVXG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNqBYos8VXWq6XMExFTDGV1Eskv8+JpWBdZoZZlUUbXJQ5Dtd4p6UHETyNY/QcrDohP+HHYAPGHJnxXYp5RrIAGAb4gviLpP9//V2dex4/iCFygxNFQ8kyNk9a7SvkjZrkR/PZKI0Tb0rRb5TxxBKMAcPMM4d6LHJRoIla1XUdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gh5nmJmh; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88a2d21427dso30291696d6.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 01:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767864186; x=1768468986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gioCXq6nTAkg2YLHxtZAgY/YHH9fRIxqTnJ/8upycr8=;
        b=Gh5nmJmhz9M6odxQa5EpD7iq6Pshq0xVvhaYZzNcTXCRz5ld/LYhTlFcRb5fugetAT
         b47ogarod6tTyPCJPFwwjNOqvbv65BWLDMGwCMxV7+wHTMIYrhqLm6J7Vvh2aFPxmZu2
         Wp7YPV2BP9+HkAQw4iGdZzbJGvJ8R2TSJac30UXhaRWmYmpEpOzoQJXN1chp3wxA8fXa
         oJ1JTbrH8ENWs4Y430xRbG376D91fZeT+s+mLJ+XdK3QtMFkJ65JZTRfJJxnH5zXGpzY
         alM6y8P5EiD9u5hJJNDVsZ0AC50JaHgntmtkFuSzddQKTKMB9ENZhx80oxcJWvBgl8ie
         MB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864186; x=1768468986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gioCXq6nTAkg2YLHxtZAgY/YHH9fRIxqTnJ/8upycr8=;
        b=k5MqjDceNOwKZY2/IdKCj5TtrQj6t3nD2ZYxFnVoPsNCH4jJGbdpWDoih1jhK7LTiw
         LaaPJSYzWaKnedn4o3W4igOn44czEfGJwPZcgpa5uPj+p6INiCxGi7h6I8YIJ8XV1tW5
         jV/iXSWZwali1u8KlEQ5yenWRDBh/R5TePqphV32Ewo8AGd6Ne6Geu7uzDRDEvKD2Db3
         5rzBHQ3MFnlpJ9GstmfcUT6zk3YZn6CMq1aF/w3JWowsyvhy2KYlDZhzXTc5CJzPyMvq
         7siqEJK6UI1v+psQn34Yjr8iU+EkwBsxFqK6mrSnrb3FZDSf1Z3PAWQ+V0Uszt4Ah2tn
         beDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpEWgu4IrLVGu1MCHULJViOrS6bqhd0yWuv8hGR2u9BF7IFMyI+VGVv75jQ48cpCRsoSgM31Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvQU9vKt83unB+yrY5VKGQJ9cYFMDAMdL9OxUVnPXRV7uGlGh2
	TrGDe7b3dFX4JOxmz0exj+Bqqi7kwuHkGaHw9G/oIzGnsG7gLN/HJLF+jbITx6H0+7YrMswGp7t
	1qowNkGEoUQ7YeiJm6gixvB0ZV7NIS354mbhu1OUU
X-Gm-Gg: AY/fxX7ePnfrpZ9pK1C++HSXEXKdYAhTkGYPRMjq8kl/R33vFzChuL7HKYf0Sgxl9AF
	by2HR14dgX8nsbaXlvA1qdtOZtOKpUxvt0UNSIC6u64ySv8z2DxxHhfO0hjYRw3UPYSfuKFd5cg
	GDdBCL3bmjz3nDzaWbsnADWsm33HnW7GLUqcA6MO0GbDpWFQ/yScchIR7/AnGrN27B+DI/Yvm4Y
	uqJtgZBccEQP7zJ1qBQEv4Z8PDnWs++gwgRUaXANAx2T7gKY3PW9xyr5WmX0ejqqhBaOA==
X-Google-Smtp-Source: AGHT+IGZX/gylyILRvYSQ0dm8ryNutv8QBrmfiAv3BMoc3OEcbsbCfeav9AV9q+DZxg3mXV6vgEHhKixrPWBHdVB6ao=
X-Received: by 2002:ad4:5cab:0:b0:88a:4391:59cc with SMTP id
 6a1803df08f44-890842710a6mr71766116d6.50.1767864186233; Thu, 08 Jan 2026
 01:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107125423.4031241-1-edumazet@google.com> <695f50c2.050a0220.1c677c.038a.GAE@google.com>
In-Reply-To: <695f50c2.050a0220.1c677c.038a.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Jan 2026 10:22:55 +0100
X-Gm-Features: AQt7F2oZg3GBnUBPbwDdGZXDIWMS1CdfEALaFbRmvnvamEMsnCsdn0bQH2w6kC8
Message-ID: <CANn89i+Z3ELnxMJdRqsUy-afppMot7Otezu3BiheH+wtOvgscg@mail.gmail.com>
Subject: Re: [syzbot ci] Re: net: update netdev_lock_{type,name}
To: syzbot ci <syzbot+ci131adae482253910@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, eric.dumazet@gmail.com, horms@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 7:37=E2=80=AFAM syzbot ci
<syzbot+ci131adae482253910@syzkaller.appspotmail.com> wrote:
>
> syzbot ci has tested the following series
>
> [v2] net: update netdev_lock_{type,name}
> https://lore.kernel.org/all/20260107125423.4031241-1-edumazet@google.com
> * [PATCH v2 net] net: update netdev_lock_{type,name}
>
> and found the following issue:
> WARNING in register_netdevice
>
> Full report is available here:
> https://ci.syzbot.org/series/07a2abd3-8dbc-43d0-a5d9-cdbb1a35d769
>
> ***
>
> WARNING in register_netdevice
>
> tree:      net
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netde=
v/net.git
> base:      1806d210e5a8f431ad4711766ae4a333d407d972
> arch:      amd64
> compiler:  Debian clang version 21.1.8 (++20251202083448+f68f64eb8130-1~e=
xp1~20251202083504.46), Debian LLD 21.1.8
> config:    https://ci.syzbot.org/builds/f4fb7576-ea1f-485d-9ef1-c3270f156=
0d9/config
> C repro:   https://ci.syzbot.org/findings/e4767ea9-6be5-4bce-9523-40ab12d=
29b67/c_repro
> syz repro: https://ci.syzbot.org/findings/e4767ea9-6be5-4bce-9523-40ab12d=
29b67/syz_repro
>
> ------------[ cut here ]------------
> netdev_lock_pos() could not find dev_type=3D805

OK, 805 is ARPHRD_IEEE802154_MONITOR, I am adding it to V3

