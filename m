Return-Path: <netdev+bounces-138231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE8B9ACA91
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A061C24A1B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3F1ABEC2;
	Wed, 23 Oct 2024 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dO+uRDE9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE51AAE3A
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687895; cv=none; b=SnKMZUeANL5XzNTkIjVJe5SMJwdnXP3SobHJpX3Pm75Xr1Pyi0fbJr35N6Y/q6CSSjmU5uTmqh0fiBcpyuIVzJm78rY8b/kfo5dt96sZZ8Fg2ecnIgbDnbhRPeVLY3D9WBWS2gO+scHdNCjhW1+pnnEU1T0JQRsZ0GQwoajUhVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687895; c=relaxed/simple;
	bh=TovBOQATkiwwKIxO4H3TUcSLMe8jpyrG3L3TRxI6sN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ptGw+o7uhAXGvXgoQyZizpW18syUGr84DUCB2/K2jn5JKQhIKF7+yxESr+4PsMHXD7lBigwdDUJURaL1RNvoQhwXgST7qo1i4LHYOICKRBrzOapCVZiqDpmKAdrIWGFIqVdumqQKHfn9/NKi3y9+meue3CSedDnQIg24Xldnhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dO+uRDE9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so824022366b.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 05:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1729687892; x=1730292692; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TovBOQATkiwwKIxO4H3TUcSLMe8jpyrG3L3TRxI6sN0=;
        b=dO+uRDE9xNiDQO7H7Reu+TWtK++ZdJ2olE1jOGob5rlsM9Oh0zgo/BGHl8jMxySy/C
         juDOeV/zGF0bt1/lRkKTiTkprgy61FLAOezhxALpTM2fjuOXIznwwIo4xTBl8Icyj0L+
         qd0f7sOWe6tFsVrZO4P4uXOccxBfxeOyfQJQVw84QJuBs8+I8IvZIWJ4JPbalsIMsVX/
         tM2G4jCoDzilRK0Ysb2r29sCIcJhKLxbmT8BymHo708NLHOMxk1tSIcSGJ6m4zMAeCGS
         1AC0LbEp3iUevvCp8E6pBvaTSHv70y7Gc572BquLp50mBLydcAAXxjveMRok4vg0yBSy
         4EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729687892; x=1730292692;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TovBOQATkiwwKIxO4H3TUcSLMe8jpyrG3L3TRxI6sN0=;
        b=i4bYOoew/06XZMtZbSnb6D1Xo8n+LX7jn//J9FQVPcjXWKiR0CXm+7jYdEJhGg1729
         Exr0U8IP2BBOeH7lXfO5Sj3pJvrDWkOgcUWdmF+Pb71EnlaXJ7nbmLTK00BFK5qTVIHA
         Z1bcOOYTvt8vLC58LkzFzlgy50vobVZyzN6jvRNaF0+tUnIUB43FF/JAL25XAJI8vC1s
         aTrqDTtHtbn42rRkx+9RxsA5SIv4b8S0xh1Lgp2sxk6oUI2YtgRdGQIpEu1qayG0ss/p
         4+Or/K0sQsQ0R+XnoNVJm4AdbNOCnnCjNPXSEL0XpHgEjzLRoG0fjZLkx+5x9Nmi8244
         WjPw==
X-Forwarded-Encrypted: i=1; AJvYcCXpicGLUj2iR2QHyfQ6msPWbXZD4xMXwm7BMT79GqclA5FiShspaFuHU7FswPnoDnOGmTfI4Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzidjIkjz9BGtYSdBjAQf2ZG/hY6dHM5wafwvOAdtrAoMiWSnWf
	AEPrsFhYkUCkUYcrUm65iWK0t9vRIz4iT/lFt57eXuHMhs5zTu4ypWyyuU/yqS4=
X-Google-Smtp-Source: AGHT+IHrjgt4Dkx3BECaxc7v3qZRq6Rtql9zV1QQu5ZkLvd+JW8V+GyN3sCO1/kMf+Iws8Ie9m0gSA==
X-Received: by 2002:a17:907:7b85:b0:a99:7676:ceb7 with SMTP id a640c23a62f3a-a9abf86e15emr233239366b.26.1729687892600;
        Wed, 23 Oct 2024 05:51:32 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6597sm486590666b.14.2024.10.23.05.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:51:31 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Ruan Bonan <bonan.ruan@u.nus.edu>
Cc: "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
  "davem@davemloft.net" <davem@davemloft.net>,  "edumazet@google.com"
 <edumazet@google.com>,  "kuba@kernel.org" <kuba@kernel.org>,
  "pabeni@redhat.com" <pabeni@redhat.com>,  "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Re: [BUG] general protection fault in sock_map_link_update_prog -
 Reproducible with Syzkaller
In-Reply-To: <TYZPR06MB680739AC616DD61587BE380AD94C2@TYZPR06MB6807.apcprd06.prod.outlook.com>
	(Ruan Bonan's message of "Tue, 22 Oct 2024 02:36:23 +0000")
References: <TYZPR06MB680739AC616DD61587BE380AD94C2@TYZPR06MB6807.apcprd06.prod.outlook.com>
Date: Wed, 23 Oct 2024 14:51:30 +0200
Message-ID: <877c9z9e3x.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 22, 2024 at 02:36 AM GMT, Ruan Bonan wrote:
> I used Syzkaller and found that there is KASAN: null-ptr-deref (general protection fault in
> sock_map_link_update_prog) in net/core/sock_map.c in v6.12.0-rc2, which also causes a KASAN:
> slab-use-after-free at the same time. It looks like a concurrency bug in the BPF related subsystems. The
> reproducer is available, and I have reproduced this bug with it manually. Currently I can only reproduce this
> bug with root privilege.
>
> The detailed reports, config file, and reproducer program are attached in this e-mail. If you need further
> details, please let me know.

Thanks for the report. I was also able to reproduce the KASAN splat with
the attached repro locally and will investigate futher.

I have a small ask - please use plain text for mailing the list in the
future - https://useplaintext.email/

-jkbs

