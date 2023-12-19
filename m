Return-Path: <netdev+bounces-58975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BA9818BD6
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 17:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923EE2878DD
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7034E1D13C;
	Tue, 19 Dec 2023 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i27H6yyj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F77F2031C
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso13844a12.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 08:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703002011; x=1703606811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h4dwVtQO63lQFVRgdgpluJBGC54ZTO1zN+DQfSJ1G8=;
        b=i27H6yyjrkm5+0s1S+L3w9npS7li2G8lSv8FlufRsKE2+q14iUBpHwyGbwM89R8i2r
         N7adJWkkNVNHgyDjPa7ciXK0uSvq7hdLlpCdnKIX7oAP8I+vuP2BYFCKZ4BYdABfCMQD
         7E0CfTL3m88sBje80tqFgudfd2kyNxySrG4kdb45lqH9+UqlqKr0glPFpeNBHbbJFjWn
         bmDXBnSDZVzh+jaClBRKxcxlHJsGWQPU5f4L3q4yk/T0y6U2rqtDT8SvUO9pFvnX3Gzs
         oav8YfnezB7bDIvdO75E2GywSr8GZLFgVoNaH43UAqPU/uc678dowAJGiwQbI2lFp0/c
         C44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002011; x=1703606811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8h4dwVtQO63lQFVRgdgpluJBGC54ZTO1zN+DQfSJ1G8=;
        b=OMtRaTPQ0RRPfR2N230yNk95Q4g58YIx5PvcpYisExk8DsfqsmF1jCMxrSOMR7D+jD
         vzKFIEn9MPswySLpu0HI5Z37u3sT0yEDdlqn+2GADhltE56ZBfPITQWFUBs++Wm61FHA
         vI1AUxobpM4jVhCoLOzhjNZWUgoz1YQ1I/K3EOzMpjpvYvXggJeoRdyfpIsGN2Dmi0rL
         fdEMwUUC/FON1FrgFuA05VWQ5mPzpFrHPsTeq5DMWlZ0GtLgTNjpxFurSuyhhDhAvkja
         nHrcQaOVotzuLTi+gfUqXUMiotWR/jzg+vNWcmZYAseuqnBbksR9gfgH4mY/xsad48ap
         xTUQ==
X-Gm-Message-State: AOJu0YzWKIb75+X0J0cp/Tbp7o3cQLUudl3Nrv9BT315o4DokEgyHA3f
	Viybs1n4WlltOCoGMobDXdgkgUAQn1NzleUwUUmAe1L1sv0B
X-Google-Smtp-Source: AGHT+IGbhPcpBonml+vXQtU57M44KBDeyYHi/RvyEVgu0bbQBBah3MMaGLpZSJzi7f44UBVKSjJgYCAB4CfgK0FJEgI=
X-Received: by 2002:a50:8acf:0:b0:553:3864:53 with SMTP id k15-20020a508acf000000b0055338640053mr193702edk.0.1703002011305;
 Tue, 19 Dec 2023 08:06:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219001833.10122-1-kuniyu@amazon.com> <20231219001833.10122-13-kuniyu@amazon.com>
In-Reply-To: <20231219001833.10122-13-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 17:06:37 +0100
Message-ID: <CANn89iL3SvkVZcS+daH9ASWmYzO9WiVuuAXKB07saZ+NT34Jtg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 net-next 12/12] tcp: Remove dead code and fields
 for bhash2.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:24=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Now all sockets including TIME_WAIT are linked to bhash2 using
> sock_common.skc_bind_node.
>
> We no longer use inet_bind2_bucket.deathrow, sock.sk_bind2_node,
> and inet_timewait_sock.tw_bind2_node.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

