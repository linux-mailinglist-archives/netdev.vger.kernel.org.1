Return-Path: <netdev+bounces-237939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A6C51C4F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE8E1896288
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2A530748A;
	Wed, 12 Nov 2025 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AdMfaWN0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7313081DE
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944649; cv=none; b=pOPKKDWGuA+le33iRhiBFp8Mcfr8Q4FTHMovLDOaAKAw5uJyOijPCtg50LLEQ/JZU1peGbu+2sVypn4R3Pb74PmvGJOqLeqouyiIAh6oJ3Cm3hQ0i9ZdZTv+aWNWVz40llrsfCSBewOfp3F5Isr4t4TDndXGMnwn7x3OUlOGt0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944649; c=relaxed/simple;
	bh=5Z/Sel55XGLWWt0Or4aaEmOg0nRkE2Q24yyei396xO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qs90oj5UnLwFuRm1ASjUoL/EAaAgRb31AlUnT/nKAWlqcmpfSKxNuGUVbFjFWlDHaBrLVwXPxygFMyJcyFkh5V2W66dHxEy8CeaSXv6kS1KBbpMLhvjZI8VZzRX9z3cWi45CZzx/Nh5p74lJ5ZFrSzddD6MkXgoGrBmvi5GfdyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=AdMfaWN0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34101107cc8so558201a91.0
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 02:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1762944648; x=1763549448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDt+PkPIFcOkoVGyNRXMinYtQG6IfGLG4Ne73L8xsnI=;
        b=AdMfaWN0ZjdHij6ofGKOD8OBBKiPKyuvvgTfm3jsNmNTvQ4qb4qXIBBBanbRne34hI
         NT99UrkWhkdIwSdY+953owV57Rb1Mm0Br7tNtIok59OCrB6xsxsI6zRHPvv9JT8n0YME
         XHgpG9gfl6o0D8oghrQaRVKq0SaCzejGX0pTxxJky5VO29pBf4O/vOwoLvhvLAXkBVDp
         e19cbbnw+3Byp0HAeJcTSzKLPK6sYfiy35FT0cGmIuOC5Jzj7WCooirEQ/vv6VfDM1jC
         RqCSE8fDES84x3Y4GPmzzrDgIZpgBqvkwMeyiBcX4zCsUxNrMAQVCszaGP+E9knx0pyp
         m1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944648; x=1763549448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDt+PkPIFcOkoVGyNRXMinYtQG6IfGLG4Ne73L8xsnI=;
        b=kfnlksZ7N7E//enulkzShFhky22cznW/lE/vXREQczJtlN/o3U2fL739arV9d4kgIc
         pF/PUFQg+/hOJ87tBhdrdhXPfn2hhZ9kODlmLaBS7d90cbYHTTmCosQNpWJPBN55g1cC
         Q9t/Dq59fqrM0RsjP0c1ystxB17XZ2ykEXAgPhEqKLQr2e1Pv7RkXcf6iBObQIhOAYg9
         H0yc53atQKhQMEiDPE4+sftZ6FRw32IOR6srwxyygO4BckxQr+N8qnWCFeW5SIpakw54
         FW9rF2rLGZCJVHdh8r+HFYmZ17Rldw7zAy0DID5GO4WECNYoC7YCMnauXreoz6t/mJu7
         beSA==
X-Forwarded-Encrypted: i=1; AJvYcCXdic+GdbIILvUFaK/XYRZ034o+/9NfL5DnjaMt+wrtOCfvychl5ETkVbHhzj06I3eAYmZeBdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGTgeCXG+UDcZ/CpmgDnZ+Oyn/OzmhIfarRufMcW/yFVHqF6rW
	rJs/Ag7o/Dqp0qMuEhdEFkO3dn5Cbrj1zKxuXBcrvBiDQS2Ev2LHhYAbgZSCh6EUeSQdcNq+6wz
	mqV9eDPcGX/95tgVN7uMxHHsyhPwSM2mtGibGDMvk
X-Gm-Gg: ASbGnctuCQW36CZJ4JKLo/QIeDGV2+QzNtb0ehGLavLpFZGt80FMyPFmT/xe28JX1n8
	qwFzZ07G+ArcjTTd0bcaZaufNhdZC+kSiPIClofFeNxxZOPxvflNxbWMZTPKidjxwU/0SW8cOqk
	YmMz6NZZMHygVTYXI02tWT33gzX9OTva4ogaT6Nlze4B1HxkfQhEF2bNhV9INKwgbdep9IlF5zt
	qDdxq/qkh068pkVW+mFu3kzYdu975lQ9T1k9NHkL32/PVXlE29h+iyY202yYXEq5Zwm
X-Google-Smtp-Source: AGHT+IFd1GAEDD22DSqeZAERmGI0Yy3shnOdbYrZoI4SJAFw9T2NTCYWO4NIIVgty2SrgCXz2TzubvGJOTr/RLGjLss=
X-Received: by 2002:a17:90b:3e8d:b0:339:ec9c:b275 with SMTP id
 98e67ed59e1d1-343dde10f3emr3441534a91.6.1762944647817; Wed, 12 Nov 2025
 02:50:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112072709.73755-1-nichen@iscas.ac.cn>
In-Reply-To: <20251112072709.73755-1-nichen@iscas.ac.cn>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 12 Nov 2025 05:50:36 -0500
X-Gm-Features: AWmQ_bnhAIJldRZySXFM6YMLqOMoeHsLxRw20K50W9oAJgt68RFCpe5Bg9f-mmQ
Message-ID: <CAM0EoMnQqNwkdUec0tX4cznZk8teiPRx9iBv5Ff-MeSDASj-zQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_ife: convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 2:28=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> Replace comma between expressions with semicolons.
>
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
>

IIRC, Simon brought this up in the review as well...

> Found by inspection.
> No functional change intended.
> Compile tested only.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/act_ife.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> index 7c6975632fc2..1dfdda6c2d4c 100644
> --- a/net/sched/act_ife.c
> +++ b/net/sched/act_ife.c
> @@ -649,9 +649,9 @@ static int tcf_ife_dump(struct sk_buff *skb, struct t=
c_action *a, int bind,
>
>         memset(&opt, 0, sizeof(opt));
>
> -       opt.index =3D ife->tcf_index,
> -       opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> -       opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> +       opt.index =3D ife->tcf_index;
> +       opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref;
> +       opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind;
>
>         spin_lock_bh(&ife->tcf_lock);
>         opt.action =3D ife->tcf_action;
> --
> 2.25.1
>

