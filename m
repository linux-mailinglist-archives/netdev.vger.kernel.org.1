Return-Path: <netdev+bounces-98145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7758CFB11
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 10:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6FD1C20BC2
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 08:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B8A3B298;
	Mon, 27 May 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LItawHWf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BBE3A1B6;
	Mon, 27 May 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797539; cv=none; b=Wc8/1FgnjmGyBU/6uQ1efGzPdqubYlxWeAoZnSL87z0PH48PqNHUDwP9zMhwxBFe72aabzA2YgPw746pAIRiEduqM6Ls6KGZDd1gUjzLlpcHPV0isUiLK0SESrN6u8/JXjtzWjAcR3Uwo03YoE998HLt4q9PglqtTFx9pS9H4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797539; c=relaxed/simple;
	bh=DnffnjZWcHu4JiYm2SYUWE4UGpP9nxdaY19x94n8oNw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZP3n8fHgrM43CayfACMINrqx/zpHinA7aCG+x/jcnjpQ+FXeCHdpOCIAywUI+dsaZOmjY6JGGEmY1nTmWxLgog4fjm1sbIBh/yzjyi//L9ZOcSAy7SEEnUGe04gLrDeWsxRHh4oDLOAEynIxbBj6wSDrnjfvEz9w5tgAd5wdUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LItawHWf; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5785d466c82so3064507a12.3;
        Mon, 27 May 2024 01:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716797536; x=1717402336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JXj6Gs0WiMRx9/YzdkPHLxRsj8ywCL8Wm/tVU0R/6tE=;
        b=LItawHWfh9F7GYKqAgtN3ACV7ubDIYrNUNA29px25rl10wgRpGnFMiOxJIbj9WQyE0
         9CCBjGrQY4yRkc9WLk89u1gJIsrujxdNkB33RgAdoHxojIz/C4kCZOuRBUGls1RnPEKg
         sBz/gd1/ig05BWVeVlpJlXajzFxz8e2t5b7x0Fjd0dlHPAt6GcB6PsFzc1BABHuUt8Ul
         l+M2MZLekEYYJBXM5OKqv6CfnRDDagFoNXen2ND4BbKOsAHjqf5s5wrrRNASKrY2xLmy
         mnvycJsiEeDL1ly3bc56yBwxCyYJxivGFUIlRHO9HJc/wfBDcUZ4/wHXB0nUpdRe5teW
         1Dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797536; x=1717402336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXj6Gs0WiMRx9/YzdkPHLxRsj8ywCL8Wm/tVU0R/6tE=;
        b=flqMzjAKuwRVEnnumNrXz4NE2zLAN+4vf7eAOsaQnplvs22pRpa8FmqS51SJfT6jgp
         /fWa0V7rCqUGtUN35Qw/qKTEcDoTZAiC+yzE9DanGNXMvmB8SCghjF1hmzILyujewQaf
         nrpzn8oA6aZs19Xm2by/iLRK0MqbGVAnRqZ4tdMkE+GzdMVLgP5G4qNuXPbvt0DRN4+X
         7tO4vz5w37yxHMWt7pOscs5d6U9tg2GC4ZO3ED9vzF/1tRNavx9Zbcrj6/rI5fnKNP3K
         qPy8LHQrxS1abg47diFYe1zUUz1wJFAFwS6+7G8d0I+MbDc/tRgbBwRRDEVC8Hhee3w+
         9kdg==
X-Forwarded-Encrypted: i=1; AJvYcCWMhPEAEoHABb58lPh2dvAk6CKpL328G0kbX1qlOtTYFQ57PM+GyRoXCrjXNHuOCUZyCzDhfR5gDTgTHCToZwsoZVVt7hC1ZtO2xcondQ1WPpSWiTnoZxRlvD0S+SOTRQKaRIl+
X-Gm-Message-State: AOJu0YzlXTKKLOYl7Phv74ynW6o4Dg+BHGqRoVhkWYwv3KCG1sgq/9YC
	WKSsa8CVhTCpHzURbWz8rzumk0fJwMEfKKMRZCou8wh9W9C9yR4d
X-Google-Smtp-Source: AGHT+IGdRUKtL76kiOcvmA89d4tbbJQdFJw82hEb/XDn9qZUDdEHFvZ8kUkC7nFAyWuAygR1HAyWvg==
X-Received: by 2002:a17:906:1945:b0:a59:b807:330a with SMTP id a640c23a62f3a-a62641cf941mr592321766b.32.1716797535554;
        Mon, 27 May 2024 01:12:15 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda54c9sm460189566b.202.2024.05.27.01.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:12:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 27 May 2024 10:12:12 +0200
To: syzbot <syzbot+2459c1b9fcd39be822b1@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	laoar.shao@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [net?] WARNING in inet_csk_get_port (3)
Message-ID: <ZlRAXJRLmr3Qu9ru@krava>
References: <0000000000005736990617c4fa63@google.com>
 <000000000000c53d3206195a6b38@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c53d3206195a6b38@google.com>

On Sun, May 26, 2024 at 05:20:06AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 3505cb9fa26cfec9512744466e754a8cbc2365b0
> Author: Jiri Olsa <jolsa@kernel.org>
> Date:   Wed Aug 9 08:34:14 2023 +0000
> 
>     bpf: Add attach_type checks under bpf_prog_attach_check_attach_type

hum, scratching my head how this change could cause network warning
will try the reproducer

jirka

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15dbe672980000
> start commit:   977b1ef51866 Merge tag 'block-6.9-20240420' of git://git.k..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17dbe672980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13dbe672980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=85dbe39cf8e4f599
> dashboard link: https://syzkaller.appspot.com/bug?extid=2459c1b9fcd39be822b1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126c6080980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11135520980000
> 
> Reported-by: syzbot+2459c1b9fcd39be822b1@syzkaller.appspotmail.com
> Fixes: 3505cb9fa26c ("bpf: Add attach_type checks under bpf_prog_attach_check_attach_type")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

