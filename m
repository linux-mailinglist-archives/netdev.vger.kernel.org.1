Return-Path: <netdev+bounces-155279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68CBA01AB0
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 17:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BF2162BCC
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 16:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F936155359;
	Sun,  5 Jan 2025 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="davCCZ/l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380414D2A7
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736095954; cv=none; b=SYI+0WbssrNE/9a7/EXDqnTbTWLlUMQmgfVvtqFmQQNdisK9ZlzXiR3MgRpQ2gAGEUzvXIqcJpl4afnswrUaRcD9juinZqp118pmCHYlVN3H0+S82e0aFbRextUxzv5MtlHbx5tFllN6tN+Zs9sl3P9M3dys3Mcr/GKimFm0h0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736095954; c=relaxed/simple;
	bh=Dtugm41CHFmw25wsp1PeXN9gbITuWzhW/lNcqTncoqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgJxOT7d6ptKmGI/SOgjDKXiudZAFv181EnU4KXpg6u6lpfrp/KIfnCC3DsWoveGqZ9FPKMrXr8sEhbv/9Nx8tPWoSwZ2I6wlxavqziOpXqgbAv7eQGBOuCBUIfjt0M9MOIveHQJuQhsdJezlIidCW/qu7YUpx8JPpxlQRtp1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=davCCZ/l; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaec61d0f65so2277771566b.1
        for <netdev@vger.kernel.org>; Sun, 05 Jan 2025 08:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736095951; x=1736700751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dtugm41CHFmw25wsp1PeXN9gbITuWzhW/lNcqTncoqg=;
        b=davCCZ/lZHd0EvLWNMtzQnDbaD/CHvEY6hRu5ojfSe0W1W8zyLU98ycrz3IRabSjP4
         dvchcWUqOIhSfWBpXcfakmNG+Nu+bGikgbm8vBbhGVMX32OE2NjdsucXL5NAI53RVBCZ
         s+xsGGVaWl+F/3UcqiDTPp67++bJUvxqjDVJr/0sU5kvdXgRKa2UaYcwpSdFFmILg5yC
         ksMCtwkZVN3dd/t2IWMkKpmfxGtdClNwoNUAmOBhO9nOPCpsB9+UoCyCJ11uvzFhNiZl
         3naXf0T0kdmSP4RDgs7Ka3Gs1MHay5uCdG3t3JONZ1JU6yMIFF5WopxzL/+Oxhkrqygm
         HbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736095951; x=1736700751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dtugm41CHFmw25wsp1PeXN9gbITuWzhW/lNcqTncoqg=;
        b=UeCDOMfjQGugy/Y0huaA0Ypnroxmqb0B3HP9dy2ctRNMt32GWMFlW/ME2YFf+sLi83
         VripXUYZTwgs0Yke/ww2cKp4A2D9qjs714Av5relLRfU+tmGrb/OF1sWr+dxeheZbojz
         onOPcYKJWhTZKt8rrbmSQINgyh/IHUUsf2jZ9psV7JnPTbytLyUll/xu49u70q4CQouL
         rQyGpOTeYfTqhf6NkfajFzJ7XFb2kcAY5zacWcjbaJ/VZy6FSGDKs6EnMTWrYDfDNBHK
         fq1SYq2VtYLUJ/LCxpaMBgx5w7HLC+LINn+5O2jp5yqp2soFlfg3NkSv/uikTbH7bNSs
         X0GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAn61qrS5B+GJhXYz+j69Yi8YDZMLwbvCnXgXtn03LRWONIhddYOpX53/jJWHlVpZcWWAuwPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGrvpjzUJmPdgMzVdHLwKcJNnQ+W7EKEnxLHAAW0FF72wGDx6h
	X/7qbjIm0VDy7qjJ7ECM4yZ/dRB/nqQLko68ABD1OPLWna5C9df7Bew64BVIeDJcZL1QRbfqDN+
	v62O2SSnse/CXAkxVdR/L7Q38T6nYSBdT67v9
X-Gm-Gg: ASbGncsWuYgPDaKMlEXyPw0nA0oNmzZ9W0YhLtT5s2IK4taK4gFTRWJyCdZpClwcXO/
	RAxcl7D3VIowiJwO5hvrah+E7agqO1ic/z7U6
X-Google-Smtp-Source: AGHT+IFpVe57pf6uqdx1jNk+2HFr/fDmVd030sEXi/vTLW2PwQOIIktibZHMK/bEEbPc0zMwr/a5yGRXKHTGw866Yxw=
X-Received: by 2002:a17:906:7311:b0:aac:278:98fd with SMTP id
 a640c23a62f3a-aac2ad80073mr5265928566b.17.1736095950991; Sun, 05 Jan 2025
 08:52:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67769ecb.050a0220.3a8527.003f.GAE@google.com> <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
 <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org> <CANn89iJEMGYt4YVdGkyb-q81TQU+UBOQaX7jH-2zOqv-4SjZGg@mail.gmail.com>
 <20250104190010.GF1977892@ZenIV> <89c2208c-fe23-43eb-89ef-876e55731a50@kernel.org>
 <20250104202126.GH1977892@ZenIV> <CANn89i+GUGLQSFp3a2qwH+zOsR-46CyWevjhAQQMmO5K9tmkUg@mail.gmail.com>
 <20250105112948.GI1977892@ZenIV>
In-Reply-To: <20250105112948.GI1977892@ZenIV>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 5 Jan 2025 17:52:19 +0100
Message-ID: <CANn89i+L619t94EybXKsGFGQjPS7k-Qra_vXG-AcLJ=oiU2yYQ@mail.gmail.com>
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthieu Baerts <matttbe@kernel.org>, davem@davemloft.net, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 12:29=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sun, Jan 05, 2025 at 09:32:36AM +0100, Eric Dumazet wrote:
>
> > According to grep, we have many other places directly reading
> > current->nsproxy->net_ns
> > For instance in net/sctp/sysctl.c
> > Should we change them all ?
>
> Depends - do you want their contents match the netns of opener (as,
> AFAICS, for ipv4 sysctls) or that of the reader?

I am only worried that a malicious user could crash the host with
current kernels,
not about this MPTP crash, but all unaware users of current->nsproxy
in sysctl handlers.

Back to MPTCP :

Using the convention used in other mptcp sysctls like (enabled,
add_addr_timeout,
checksum_enabled, allow_join_initial_addr_port...) is better for consistenc=
y.

