Return-Path: <netdev+bounces-241295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 619D2C8272F
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 489604E0719
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 20:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1319F2BDC17;
	Mon, 24 Nov 2025 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="yavHB9Un"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E518258ECC
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764017699; cv=none; b=iZIn2phjFbWA/n0tdeq4ftmTdShq2fjbcwCyLC4tn+Oo4uTnRwDneCZ2kJ06bcM/NuaPCme25/8+YRZkLlRzvHAn/f99eWk7JVnfmyrGBulHRPUucLK9lNPk0WaOmnHBPW/6f+cU3l4UtsJQDklafP7lvBd3cEvjCPVUGIlUjYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764017699; c=relaxed/simple;
	bh=K1a3+HOrSUCs/GuNClTDn5ZdPIhnEk8yVdo1MsAC+YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rw0SwWgJQhCf52yv0kSO08G9ZIz+CrsVguaZJq13WqtHmFAavg24692U1tzzmNeIMmYgXS9w7To4YnfoTCRMNblq5ivehuj3f6FRRnAl8t9KqUvmhshRPiMXMinfxvKCtbEEBwL+dex2cMzb0wHUN3f+XGUjJK2tBfEF55/idKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=yavHB9Un; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so5279446a91.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 12:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764017696; x=1764622496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txp/6sDDr/nBaH4fj2XxwLJxlcNL7N6bsQHh70oQCmo=;
        b=yavHB9Unhz98sbr+exdEN2SGduzCiuD+8Zvre9mzyImxDB6bc9wA8ziwGb1vJkp2bY
         cgT8PdTRK1PbehnQDLxu/q7uX4obhVAngo/952gRv4tARiSDOKuGshXAJkxfT5UpqUjZ
         XIlmMxEI+VQbuGip9KxSUaZ310ovUbeMUS56lIWvouZoqrPZ/J6o3kdtl+ZMcd+/9lxz
         NK7cvNGMV3paf7jN06COXHZUgRbk+0Zom4iotdfGrEH1szv2tKegND2EprZsl0ofp7Di
         GA7EV8DBa+5ZspuwuCMVEXfTgMat5zqevp+3CbseMIaD9jXIAPjdbG1mTIz/oH7Kxw0V
         L4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764017696; x=1764622496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txp/6sDDr/nBaH4fj2XxwLJxlcNL7N6bsQHh70oQCmo=;
        b=RB2pgnxtMI9FP9C9dJXXPYgWmt8JQjk+wGmIVoNjmexWEs74IPmlIoaON0ww5N/zAV
         xIYsnjfbP2PZ+rSkDftoPXTieInHvE/7SQvyl+HcnNgcy2t8PHumJYgmLKAjL7AjC5jI
         jD0K5t0YIp2YBmtYpUfEVC/4/0GbrL665FK3GlL56XFr7xljGYnn5OTyTcTeJaizh6Hg
         BAcovtW8vz1mtYd+OPncvMR61lbkimNf3/HnH7UoZXo7ldSYQW8Ehz3dWQoz4G2+b0zD
         aAwwzUdeaok2SgK/QGsTXmPG9cQJ+y//D90LpOBTjH0Oj3S2r2chjXXqI9hax+5GckZ+
         CP2A==
X-Forwarded-Encrypted: i=1; AJvYcCX1TE1xFg8QpbJwG0iWdHO+6D91lHWSRqF1R+9TW09zJ7Qj5ynVn3sH2cP0XepsKpol4RKbPwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmEMAmSAAecvuDZVcyR2tUBhyZTU5yKgyUR+Nqr4sIeZAg0BEH
	oJcw5AnwrtGd/AAbRTQ+NyHe0xFHPNdLb5VdyS21I6MKYo+lnBqKbqdhEIQCRlZZoL66XDTVuTh
	Mt0WqzOA9DZDfEMYgEWkldnTNfhnHmqDqJ74jz4iv
X-Gm-Gg: ASbGncv9K+yDWRsX/rZCfcRQluhAPF+Tgn9+ZR8xXHQkVAbbap1jdRM+IUfdQee21f+
	uvFOW1BbPxwOy6DdmA2xcbb2IQK2AvlkDaZz1FjPXkvASHCgWeJXiw24O+jqcU51lgcxB4RI8jH
	QcTF68ge16qFVYqDvvh4rWGMyfxJUVfo9cT11Ec7PtAZ7NRxcw+6NoCt/XQyixHzHMUA5widIvV
	rSUH6vqr6oZPgLtouXCpuUehVna4sDOTIaPm0e7uniGL+S1yv8w458rB5e+DbmPV38og2JRH4XC
	I+gWSMU1ZAngAA==
X-Google-Smtp-Source: AGHT+IE7Ap7iaok63M1k3FuV41+3o3+bFo8SnCtg318bZ6zgUNc5bq50oQfFXj0eJwBtba8CpdF3Xwp4dh6+O/WRbus=
X-Received: by 2002:a17:90a:d00c:b0:340:e529:5572 with SMTP id
 98e67ed59e1d1-34733e6cac7mr11892908a91.8.1764017696374; Mon, 24 Nov 2025
 12:54:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bug-220774-17063@https.bugzilla.kernel.org/> <bug-220774-17063-qOQ3KbbRZE@https.bugzilla.kernel.org/>
 <CAM_iQpW7WE17Xad_YVsOpz5_+uJzB2_7zOPQE3xOoT-nt4UAXQ@mail.gmail.com>
In-Reply-To: <CAM_iQpW7WE17Xad_YVsOpz5_+uJzB2_7zOPQE3xOoT-nt4UAXQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 24 Nov 2025 15:54:44 -0500
X-Gm-Features: AWmQ_bmg30VNsZqHcgMDDKOTgAHgnm9s8-xb62AgKHLRt9zQx_yiKYlMdL3HDUE
Message-ID: <CAM0EoMmpuCdD6LpSOPuy0cXEvr7aJhSRDOhqzQ5mrq8-zjJaxQ@mail.gmail.com>
Subject: Re: [Bug 220774] netem is broken in 6.18
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: William Liu <will@willsroot.io>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, lrGerlinde@mailfence.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi lrGerlinde@mailfence.com (sorry, no name on that email!),

On Sun, Nov 23, 2025 at 8:33=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> ---------- Forwarded message ---------
> From: <bugzilla-daemon@kernel.org>
> Date: Fri, Nov 21, 2025 at 3:39=E2=80=AFPM
> Subject: [Bug 220774] netem is broken in 6.18
> To: <xiyou.wangcong@gmail.com>
>
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D220774
>
> Gerlinde (lrGerlinde@mailfence.com) changed:
>
>            What    |Removed                     |Added
> -------------------------------------------------------------------------=
---
>                  CC|                            |lrGerlinde@mailfence.com
>
> --- Comment #2 from Gerlinde (lrGerlinde@mailfence.com) ---
> You know, in our HA and ECMP setup we sometimes get this strange thing: p=
ackets
> are not lost, but some flows get duplicated for a few hundert millisecond=
s. Not
> all flows, only the unlucky ones that get hashed through the broken path.=
 And
> this makes debugging really a pain, because all metrics say =E2=80=9Cno l=
oss=E2=80=9D, but the
> application still behave stupid.
>
> So we use netem duplicate on a single mq-queue to copy exactly this situa=
tion.


I may be misunderstanding: You seem to be using a single mq-queue with
netem and your requirement seems to be replicating the packet on that
single mq-queue? You mention "flow" - how do you map these to the
queues?
BTW, you may be aware of this, but you should also be able to mirror
arbitrary flows of choice without resorting to using netem.
Can you share your config?

cheers,
jamal


> --
> You may reply to this email to add a comment.
>
> You are receiving this mail because:
> You are on the CC list for the bug.

