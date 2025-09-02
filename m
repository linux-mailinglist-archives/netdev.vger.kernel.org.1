Return-Path: <netdev+bounces-219118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A8AB40037
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E2A5E67D4
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD5F2F744C;
	Tue,  2 Sep 2025 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4HEKZuz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B021F0E32
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815183; cv=none; b=MRE7hl4JlWcCPEdxB/v67cYOrY/nZaSdFgpaflJVUZQtyhvwzyMQiXApA3c/Ou7YegwAObUzDo3payrlQ/kRbdF+oV42QZreHUVMTpt3H13B6wOdt7X172yRZ8k7pspqHO1Eajj2uVZx200IG2e1Ydmry9RQ1D8x08G8ia/gzmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815183; c=relaxed/simple;
	bh=VMYVwfGsnGVQABXdPnw7aeNqUaLQbhnf+xDMSkA9wPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6oSDI8d2dM+nE9AZrWSTJp5jaJsnC0NcQjwiWtFsWItQT/u+BfNn9hRZPUgWo/ehq2cVhJliuJ7ppwls/4DiVGDnxrv7up31N2guggWrQF5cQcZQkbtfhkHrIxdFlR1zkdPWjXwxqIpOGM8ggswg+wuU0qQrMQYLNB3bYoVIHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4HEKZuz; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b32384ce83so17347291cf.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 05:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756815179; x=1757419979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMYVwfGsnGVQABXdPnw7aeNqUaLQbhnf+xDMSkA9wPs=;
        b=d4HEKZuzObRmXObhtnEdoc8APJI/0fBbxtSyIHIHO+H0Tl1jyi4c0p8TAldWJxWOn+
         J+D0FhQf48n3kelV7G1RVlbuNcjlv/tvL0iBBuMRBxoYoSLqTJ4YOWvECNqL3zoDlY6d
         QkNVfL1iFMaNCmt1pCBJRRrlbGam+KvURiS89vwDeM1L29MFNOWagVijjKzTKbCaVmKW
         034GqSmRRbFc+bc8NTBeWnna7HhKu6M2QtRHRVi/7u1j2a2aowK6uG5IqhXZQ24gB412
         IJ9Ea985pCJGlV9Wa6QPzB2pu7bjHk7GaAKhZjoDhDFg1M/Hgmon3HWRr3xpKDS7XUm9
         j7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815179; x=1757419979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMYVwfGsnGVQABXdPnw7aeNqUaLQbhnf+xDMSkA9wPs=;
        b=Y7qnXtURMo4C4ksoi7z2/A23Ab3L9zAxrCEv9Sdv/7uXQ85AHU3VY/ZzurnI1KuWq/
         cQI2bJZgHf3J+c9fTnVJCmNZd/6ZxmVTQnA8z1cO/ddeQVeAy0gxLJZJmy9nWrFkqMN7
         wZtXg7IB4P+CXtv32bADYmZ+uBLKGFbBx4M42WRgbFSyMADxqlpqCrouWDFcOBD+sDa5
         wtRoxpFnzbLay9Jch7eOfy6zm9sxvzyDb9SXoxmAHSk56vQkR498FZ7Vp2P2JLjQWbX8
         tRZpk+saIf58Z4vZz3bhjumdaAyaBTSJeayXehC8vmMk32Xs3682q8leSZeYtiBbGDGt
         N+1w==
X-Forwarded-Encrypted: i=1; AJvYcCVjVLgfrRXxyfeaJWmEXiUj0MgLaNTIpKJ59oGQNU+Lv9Hp9uKyO5YOpgZIzn/Zb8nvFlzhdto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ06duD3Cdb4xPMMt3ZOKOuC6do2zuftcH1hqjw/tDKpBDUicK
	nxjg1t8FCI/oyykQs9oViFv3buLccL0WI5DU+RZ9cXwWeW6Zyck+ZTB4IvuOfgmQFBGBbUdeHCX
	U9AHliABUpUUol8Fi+/fLPe5U/Dfqz1g9vUkRgpah
X-Gm-Gg: ASbGncvZe+KO9q0rITj5wp3iyuGDn1bbRL3rbMtD4gx7Gnc+SBXibbMihDM/vmd+r8W
	si4z9cJXo+qLPbd3XkAndRoI6e0a1g+zbEvL4OXY3+cy8ot53pgGpx6kOgjvbQpUFuAgD6Xbr5h
	aoNy70ii7FYTCtouAFQ7V7PKp5W+cO2p9t5mdZRvSyOaRkZ3GTIp3jz7Sq+e4IT9O9So6uKyMP7
	Xyij4OLPK94sYq48cCe4T1w
X-Google-Smtp-Source: AGHT+IGsHQurZQac69JSKpu/U5IUjnHDo84UKmyd9yYsAbj2vDGmxshd4kzeDY6Y6jxcmTxE1Sk70xmx0qQGLtlXo+o=
X-Received: by 2002:a05:622a:82:b0:4b3:709d:1f1f with SMTP id
 d75a77b69052e-4b3709d28a7mr3785651cf.75.1756815179020; Tue, 02 Sep 2025
 05:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901092608.2032473-1-edumazet@google.com> <CAM0EoMk6e-qyXZsONXx0awDcQ-r+X30hsB9uqqFhd=12k9pOcQ@mail.gmail.com>
In-Reply-To: <CAM0EoMk6e-qyXZsONXx0awDcQ-r+X30hsB9uqqFhd=12k9pOcQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Sep 2025 05:12:47 -0700
X-Gm-Features: Ac12FXyRPEZXtM3R1ZQI3bl5ACnvzBh5msDfne8VRGIaIqU8ktUoPBJNZ49MpiE
Message-ID: <CANn89iLHz+dVuOv7p4LG00FqCe2tnKom3hAT=Hum8G15OePxuw@mail.gmail.com>
Subject: Re: [PATCH net-next] net_sched: add back BH safety to tcf_lock
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 4:56=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Mon, Sep 1, 2025 at 5:26=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > Jamal reported that we had to use BH safety after all,
> > because stats can be updated from BH handler.
> >
> > Fixes: 3133d5c15cb5 ("net_sched: remove BH blocking in eight actions")
> > Fixes: 53df77e78590 ("net_sched: act_skbmod: use RCU in tcf_skbmod_dump=
()")
> > Fixes: e97ae742972f ("net_sched: act_tunnel_key: use RCU in tunnel_key_=
dump()")
> > Fixes: 48b5e5dbdb23 ("net_sched: act_vlan: use RCU in tcf_vlan_dump()")
> > Reported-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Closes: https://lore.kernel.org/netdev/CAM0EoMmhq66EtVqDEuNik8MVFZqkgxF=
bMu=3DfJtbNoYD7YXg4bA@mail.gmail.com/
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Eric - i dont think this will fix that lockdep splat i was referring
> to though, no?

It should since we go back to the situation before
3133d5c15cb5 ("net_sched: remove BH blocking in eight actions")
as far as locking is concerned ?

Do you have a lockdep splat to share ?

