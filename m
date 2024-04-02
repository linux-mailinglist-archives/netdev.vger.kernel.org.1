Return-Path: <netdev+bounces-83927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DA4894E2B
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 11:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D2B1F23734
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795B156444;
	Tue,  2 Apr 2024 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Bk19R7NC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0AD4C601
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048517; cv=none; b=lQgrd2KkGwqaqV2NmqRsLsWp02Ks163bO4eRiswUhN6DDf2/Sp0ePzW/Y8R7C9f5beYCmOWkX++9Sne1+uHLSB3e3WCYJVswuzpSC5wNuAcIgu8zZL5/RJLaJrZ8oylESAkJENW5DNJAVB22xphrIBGRJakxDUVHaOpNqW+m7OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048517; c=relaxed/simple;
	bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUgM3HagOX8oE+7bhAkvOp4cc0EPzTTGdVIoV5lV8FGcUCtzGhWeGmAIjDG9xdPWQi0jeOTa7ceMkK82ZE0JmQPDXoxRVnuf9pyXvESISOs4ZxXDDcUDQmnSDkrGbMJ293yogquuyIoPX6UZy8plH9rVCUHnfbaxfL7MNfh6LYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Bk19R7NC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ea7f2d093aso4553844b3a.3
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712048515; x=1712653315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=Bk19R7NCRilf8WwJf6SywRpuAyZDEFpDBtBCK5rekyy0uuleQ5WMQcRhZ8fBsDXwY2
         eN6WCyBETWAT6OGyu1TgAuwh1WgwEAxqXfKwwQy0fG7vm6REIaF21C3fo+tiMQKJlz4/
         pXsjkjWcoVvHTsnLaEi3noMjKvgfVlFgCOHZgQKoIIw4CTva74HZm2PeSeLLtDJ3k1tF
         9wqdzXtib6rEVcz9XCKDpCzimC0Due/nC1nskaXO7i7bWSVL9GRVA0uIv8ZiPauooHDm
         fGnP5w4RiAOz+0lPjdBZm0wotuxuPRVk5Voq4qpj1doXn2hrplSGn1P/GZilokAqMLal
         pE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048515; x=1712653315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=a3kryzpxtAkxGI4laR1Z1/WzSK/M6ll2+pnNY4HInPzu4/JtEsalZc7ruFcPo0360e
         JoIcMH3ldeaQDppHlADVSiAfaMGZ3hCgHQlzSudEztaxluurI5/54Azgibfjdixrnyca
         e9DOYpNxKIh2hy3wyoF8aMvVonbeGFoZEBrpF0aOFYWPc7w6w1N9d3vV/+GnQYapAWQN
         swdgjy4rsipK14i4B8w3DtjN/V7ljAQ3cbtmfPz6fPDAimIzeO1NDli6SoJFHoK84V3g
         J1YvXutkKaaTY0M+EdgkVvbDgU3KwMMuw+X/om50vInaVRLSksyBZOvtp6XU3kfHUp3a
         EY3A==
X-Forwarded-Encrypted: i=1; AJvYcCXrWsuLLUlRWgX2BbZH2vQQ44YUXyQ4PmTdmbxl/LsOSp8TBdU6wBG/INgyPwu9wcMzFWoZHmehNPBnSkR0v8QmqzwZclhQ
X-Gm-Message-State: AOJu0YyApDBfbeEt6adB1/xUD9ote5jBDwNMAszU6MAfzAkPm8OccZ9F
	j6XoXxCgGsxNBouRe9VDPLaPjM8VhtjIfWuOi6PrzKfJJi2lxZUihhNCQT+TXuQb4DU+m1aY+5V
	Fp70ejaK2reAwHeG5ypGoNYns38GKUE92TpZQ0g==
X-Google-Smtp-Source: AGHT+IE115Sfhw75rH/JpVYlQIiEI1B1wUChGJ0wfRlxcJzODhoGWe53bZKJEIgJGp2HAJPfhytgtQBkvg8e1LvxiSw=
X-Received: by 2002:a05:6a20:8f05:b0:1a3:d515:ff2e with SMTP id
 b5-20020a056a208f0500b001a3d515ff2emr10978527pzk.37.1712048514640; Tue, 02
 Apr 2024 02:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a803d606150e375c@google.com>
In-Reply-To: <000000000000a803d606150e375c@google.com>
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 2 Apr 2024 11:01:43 +0200
Message-ID: <CAGn+7TWYLnYRRNJfPPRtrNL3E7DDkf0X6RBAxszYfMKx1=EeoQ@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in sched_tick
To: syzbot <syzbot+a1d7495c905fa16bea17@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr

