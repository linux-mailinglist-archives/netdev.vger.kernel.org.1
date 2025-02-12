Return-Path: <netdev+bounces-165552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC30A327A4
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 834C77A18D5
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32C720E6F0;
	Wed, 12 Feb 2025 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y870yYJw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8D20E33B
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368494; cv=none; b=hthcUObwzOogQhT5RwMcrpCMRYk+0n3/EfsZ1fYzS8CKeEWVFMZJbn51u6SLn4IjYGw+eAu+nw5Czy90po9FPHh0ibdNhSjJX8EPBZcAjAzzt4j9Sa0sVtigyQYlPRXznzwEF2qfgosbg8vGMUa0OyVMsNe/ClvtRMGEfHjpTgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368494; c=relaxed/simple;
	bh=TOvQi1+sXJcK/jg/cyABC3m6eaSx4wI6HbWaJ4Ko9QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEl9xtbTi6FB5gEwr0E5vah79pZvRPAV+nBcAjjZ/MRb5C9iMTsZf1agUcYO6GeRp0PfdGk3bneXQ4zh4bgn/RdtvnnDmlJpcBg/xPM/gCsVDoHy+Sl4I5YvkuaCDkgaqezv22KH7R/6INYWB0SLWGsXBfdRUQDY7Xu15iQZU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y870yYJw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de4f4b0e31so8849269a12.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739368491; x=1739973291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z3+i0mdzrQqWHhjSAJC2ynCdcr+/VjMwagK4zQTXjk=;
        b=Y870yYJww010BEqxpaVkZM6JWuTEdNJf3sZT60INsCqccT5A+69AQ8MBaDMQmHN9r6
         p7Y20367Kzj6e98rpVIcZi/gTwhBVIOwHuGf8ZV+ES6+d29hB7KddWXhbygaj1PB3zv/
         vXRjOPyGwtjpvHNmCgIyM+Zb/sBF/QKlI8Kg+H1ytWUr1zF2jDz38AGwj02A4gKDnRRS
         z8IRIdL3U1pRig9fdWpFaaMs0qheB/udogR3089ZtphWoC0+Bw2ANKmjjTntpfw7Lp9J
         kw6/qtW6cIQwaa8p4sGD3EFH1LJ7+pZ3sPyT1Ik8Tqyg1SsfjAecmnBpMOF5C6sYk6C7
         OqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368491; x=1739973291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Z3+i0mdzrQqWHhjSAJC2ynCdcr+/VjMwagK4zQTXjk=;
        b=Csze6yiyKVK9Cb1sARoQtvWYQsNT60YRtWygjptIq1JBD6Hsoxvyv+Som1KcT63UhE
         peCJ6VHAkWd8FoQ3gdqkOiRE6/b7xN0MhNXR1mxT6Jz3w9SJIUnkIt3t4/ydq/if2efe
         qon72tRcgvJkLmt6Qx2u7MEyMliJT/CQlgPDbKTfcexWJQCYZDI2lKVhn+y7nzRT/z79
         X8crRh24t4KzFxY3NcJLGWoippUqiXpZoB2CHJsTa7dFX9mPbuc7VU+UIvJB2a4KMAIM
         WcN4vrmgx8XNOYA56WR2lnDbx0f4D4DX0lZ1EH3r16hG479PQH3dbHzw/ySr4hf030pW
         ZdjA==
X-Forwarded-Encrypted: i=1; AJvYcCWhrZUk0d3C76EL5kxDglnjiobxGW/IvJZvGL9khV47cgefl9ARXOwdaTRTlfRWsa46W5Um4rA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ZxJ7XfHAlqvCpnkRoLS3Q6rCf0ksEtyX36Z7YPbK7nl1lSbz
	20piCt+zIL8yQ0MMHkYiRtsfskA7D6sIJ42xrjM31OtT2Thz2OmOY8mVXHwvwuqfJe74IMn8IY1
	FPt/R2duhUnsXBLq9z8vTtxtgDMTHXWcmuv+U
X-Gm-Gg: ASbGncumq+lQ8nkKDl3HtcIECziZC5xXzBabM3tNoBnG8N78sO/dj8wRnKmkswk3tnH
	VfO+0/LGIL/Qnyv7uGnoWgpbJ9GUYAQCmy+Trab6a3ftZdBOzF2AFAHQq6WB/ksCiV0zG2/6P8g
	==
X-Google-Smtp-Source: AGHT+IHlPeUhxYhZBcFkjbeKWSIyxoh9o25ZeisXxPohVA2GGaWa/WYxngRpjJuzwSflgEokv2XjRISyK15u9JEA1to=
X-Received: by 2002:a05:6402:50cc:b0:5d9:fc81:e197 with SMTP id
 4fb4d7f45d1cf-5deadd8e4a1mr2774916a12.8.1739368491088; Wed, 12 Feb 2025
 05:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212064206.18159-1-kuniyu@amazon.com> <20250212064206.18159-3-kuniyu@amazon.com>
In-Reply-To: <20250212064206.18159-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 14:54:40 +0100
X-Gm-Features: AWEUYZkdL-fjbmsF0jI7qMpOKJLBSTHyTHUWseaz_kJnjd_0tI5b7WRG_6a-Wts
Message-ID: <CANn89iKOYktLb19QvyWgkSeJe7XyS2J+O04MR7U0B=VpTcSu6w@mail.gmail.com>
Subject: Re: [PATCH v4 net 2/3] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Yael Chemla <ychemla@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:43=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> After the cited commit, dev_net(dev) is fetched before holding RTNL
> and passed to __unregister_netdevice_notifier_net().
>
> However, dev_net(dev) might be different after holding RTNL.
>
> In the reported case [0], while removing a VF device, its netns was
> being dismantled and the VF was moved to init_net.
>
> So the following sequence is basically illegal when dev was fetched
> without lookup:
>
>   net =3D dev_net(dev);
>   rtnl_net_lock(net);
>
> Let's use a new helper rtnl_net_dev_lock() to fix the race.
>
> It fetches dev_net_rcu(dev), bumps its net->passive, and checks if
> dev_net_rcu(dev) is changed after rtnl_net_lock().
>
>

> Fixes: 7fb1073300a2 ("net: Hold rtnl_net_lock() in (un)?register_netdevic=
e_notifier_dev_net().")
> Reported-by: Yael Chemla <ychemla@nvidia.com>
> Closes: https://lore.kernel.org/netdev/146eabfe-123c-4970-901e-e961b4c09b=
c3@nvidia.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

