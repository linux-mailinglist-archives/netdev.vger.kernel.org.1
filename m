Return-Path: <netdev+bounces-206235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B8AB0242E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 20:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C39657BED64
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 18:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32841DE3C8;
	Fri, 11 Jul 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="akjxkGsS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5361DC994
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752260075; cv=none; b=O6j2+87E7k58T2EnaeqJ3q+YogOuAsSKiUfvYPGHWqTeMhsj96qUUsF4N5zf696XBw4E5rV2RAVEFrC+nJo8F3lYmKODPOffRhiBWFLojrFy4Pk6cc6PCBSKMBQPmVDvIk3U7NxnhhbyZru+K0OEH4KnSWSudrG3NknHbWbkrI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752260075; c=relaxed/simple;
	bh=NK5BNgE/WS+Rnbr3Oglk6axm+5znEKQ09/LeulVtaY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gb4NASUKdsVWqv9J1mPkw2IvwO7ZY26c7rM8cinumziyrcNlBkH3TJpR52SCFTX+KBnBoJBvNjNGVdrfo6G0gPCrodj3y2Ej1W3eATkNe05rGTaQ3vuFTYVk1ud9T1H0uiI57i4y0zVTBW1S82PdH8oKAtzD9iblg9v1gtrC1kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=akjxkGsS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so4016743a12.3
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752260072; x=1752864872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h8DF3TN4LDXw2ml6xO8e2jD+Euu91yv1fKkxI9RSJ/c=;
        b=akjxkGsSmHAdd61yv4oP1c5FcdD8W0gyvkoQUR7mJUgz7Qmx4pULHpfRnAaQdnTVbe
         7W6ZqFn8U+zRYidl+t/F2hPuNdEF1c0S6qa0S9mxWO8xQ5sPi9dtTfXHsx/qcJU7Os6q
         n8MbsHF9h2yOsd0zmQr4zaS29EytveAp1pOM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752260072; x=1752864872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8DF3TN4LDXw2ml6xO8e2jD+Euu91yv1fKkxI9RSJ/c=;
        b=JNeCxDXEb0Izgmy8omXGcJkg30aOraAsxeh7uG1zHkpluWDjSCFLzbkfY7isYs3gQt
         95beLNiwylwr6Eo7joThUIX9qsAkIV4DnzSWHCWJ4lxf2kZyh4GmvgldW1c8ILcBsffT
         OoySN0xOKuvSeRTyzQQzkJP+xZoq6iKJY7/tmjcz1VARdnjsrRiy7Hp67Nf4mHjYNipr
         p8OM8kVGoEgzqlB6pYSQXmu0BnTXyuh6b/FrEgqV+G5PIDZ/GQujoZT+iYLSHiVTNzKZ
         jJ0NrFbn6i2uqyXjztR5+Xs4t7Xh+rYQfRRlsLXV5Ums7X2Wt2otupbzlojWQs9Fuhxj
         HTsA==
X-Forwarded-Encrypted: i=1; AJvYcCUoaC8hKRTvKjamxfvzL1iRg87oc+dRYSD+ct+8rnCt281TRu5vZJU4/8lsNMDN3ZyMmcdks0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE+lB2u3DkOaIUPEERUT/GEbYcZkUQlV9YYmnn/FcxkqI8WyeV
	UIWkBwFxqIrFgRMR5IQ/lDHQknWdAbDBegrR/P+HpGsPTgodnD9e5YePwh1zymQlD1FGr2HmhS7
	rpH+UMurlWw==
X-Gm-Gg: ASbGncs0owVLLvgK1Gvp/bfl2QiMfHALx9Jeq5oVcw+7ynfuz1RpGgwgjhOC3QhRBxi
	KrD4bXoMcGvRp6iSu36s2gemHKARVSAdrvgmhFnidHe4RDjeZ3tZEGWJjqX/gQ1Pb6YTYlllXJp
	guBxJQ19djUwwDO9E61PTRZr2LA2aYlkmReJENG8xXhuURaScpnA4z1MwLM2J912IqjDX0Eghr7
	bJxdHZ2vW5MI6nutfhpMgGeHnbrotLHs1blumj41MRudZ2chdtLrbsk8/qbafL8RISEp0p0pj4b
	G2u2oj5HhseWKI9D6H0wg20W+RxskTuGkCIx5e10dDAWauCPhAdK5/hyaPU6dxCvPj17o8FM7I8
	1I/EcC0X75tB7kbiRqjclNE64GIsXnxAxg3Gles8JMZJAv+gtdg7H67ohpQu9Z8sRvv/QAW9yn6
	L7/EdewzI=
X-Google-Smtp-Source: AGHT+IGlDYjHQpbwF3eASbtJl3fAl6qRnfvXLZ11MHjh9niqAl8OUO9Ufpexmp8X8TZlnkOa2CmA3Q==
X-Received: by 2002:a05:6402:5d88:b0:604:5bba:61a0 with SMTP id 4fb4d7f45d1cf-611e849ffffmr2434579a12.23.1752260071726;
        Fri, 11 Jul 2025 11:54:31 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c97978e4sm2504431a12.79.2025.07.11.11.54.30
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 11:54:31 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso3424844a12.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:54:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWt7rdn3Nwj00sdBE9F/leZrYPqJ0wKo9Ot8NywNVLW2KdcRdiYYW+AMTDv0wT4vLkMUHjCIQ=@vger.kernel.org
X-Received: by 2002:a05:6402:909:b0:609:9115:60f8 with SMTP id
 4fb4d7f45d1cf-611e847f9e0mr3480426a12.21.1752260070618; Fri, 11 Jul 2025
 11:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org> <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
 <20250711114642.2664f28a@kernel.org>
In-Reply-To: <20250711114642.2664f28a@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 11:54:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
X-Gm-Features: Ac12FXz6F4j9YIJKyGAUwYcgpVBje1DHMNB65HFrbPl9F9fpay_RiZxgMldk13w
Message-ID: <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 11:46, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Hm. I'm definitely okay with reverting. So if you revert these three:
>
> a3c4a125ec72 ("netlink: Fix rmem check in netlink_broadcast_deliver().")
> a3c4a125ec72 ("netlink: Fix rmem check in netlink_broadcast_deliver().")
> ae8f160e7eb2 ("netlink: Fix wraparounds of sk->sk_rmem_alloc.")
>
> everything is just fine?

I'm assuming you mean

  a215b5723922 netlink: make sure we allow at least one dump skb
  a3c4a125ec72 netlink: Fix rmem check in netlink_broadcast_deliver().
  ae8f160e7eb2 netlink: Fix wraparounds of sk->sk_rmem_alloc.

Will do more testing.

             Linus

