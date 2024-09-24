Return-Path: <netdev+bounces-129472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E9998412D
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025C81C227E1
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B720154425;
	Tue, 24 Sep 2024 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFJqQoqb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6451531F2;
	Tue, 24 Sep 2024 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168150; cv=none; b=D99RrQakD3BDEc6LmLVqXlQGoyX5hlpZiZP0QM92OFIGYdHu9jD0FIqfj3QyhSSQPhJIrUn/uegLpu6WgcrXzCs2YQMe5dsri891TFPHFkFK51aoPECeE0ZFZOgowKVVsV5ahhq1IOjenTMk2oLd92FmIOhMGQhyl8HWez1D4E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168150; c=relaxed/simple;
	bh=bATSXFqL6T8do1lhg0d9NOdryJRWHAJDdTkrl1QEg0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRagLfwZfBbocoVueae8wjLEvNtHiHgllfYNSBij7MjWnb3PJCWg8LYZCAlmBD3AaHltK/q3PZpkdIosrMqbxt12oS9XKjiLYa8rhXhmS1sj4nGNyLQ5M5B6F/5QFzRFpRjhYGfyYdGvJrOdK1ZeN5/CIvC1abS3B8BpX7WQ6vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFJqQoqb; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82d24e18dfcso264223939f.3;
        Tue, 24 Sep 2024 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727168148; x=1727772948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bATSXFqL6T8do1lhg0d9NOdryJRWHAJDdTkrl1QEg0o=;
        b=iFJqQoqb1Pk712vZBPmLHaTd08lb1pJwjy1qsZaloTa8/ILjpZlrQ1kem20IYGZKHP
         RNkyvPL3/CTCewII6FqbSVTjMyOyb6le2udSnvx/eQy4xpGEumLGLdj+l3xnPahWTlcX
         uEyY3PNEtad3T1l6xYxPeKwqDv/zTnUUl471hs2Zx/bwd29sYUTHAwCI8VBcbM1WSwMD
         x3F6hqJ/THUvtGO4xNWNFpEeZQ406YvjUMpTq2GNycX744wEWYc/K9ITVNz1b1fwHJwT
         6Whk9w/J4suEqDnDP9tBrhPNQKOPy77T3ozNazv5Dsort90dMPleHJs29pv2uAJTy12g
         LMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168148; x=1727772948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bATSXFqL6T8do1lhg0d9NOdryJRWHAJDdTkrl1QEg0o=;
        b=YHv5ajxm6dWvH5ztAhQtRg8vWUFRL+FXJm7BhyJCfgntoPpbZ7h6EjWaGDW924+g6x
         oMXR79a7s1+xhVGvDHjxJWfANDR0STjLbW2HAMxsKyiV8IVv3ENuBbZsVOEdNnyKNWi6
         b+lwRT1t/mTOzL0TSTWA+ZkP7fpAhJI1rF/QTbDDtweFI/itoWIWb0/1lAbpymH2cDMy
         9X+Uqlx9bOVxLJ9R+agoSGv8dTHF5fLeOdxApH/jTWk6NRaAI/c8lWkGyG3iNvzHoIZF
         CLr+9T6ivp2RXEGRbPyVEM3zYmA14JJ9qVA70isupQQXgEDE5BY7i7hajbJZnDL4MLgw
         xjyA==
X-Forwarded-Encrypted: i=1; AJvYcCUVFzQ/iKx4BWVuMmUyChsEAqONwI4zeMe0Yj/+XqE2+ugBgjw3GR7cr8tPAZPsWsLTpCBaHxXiL2v7+zgrpRE=@vger.kernel.org, AJvYcCXN5u1WmKnLzaILOQtfSYW951q7uVF/+wHmV9P7JNO63QT9s4gxC2aK6+q7bnMMgtiT8oYTGgcQ@vger.kernel.org, AJvYcCXPzx/s7nuFIKBLu1s1bw/ZkRWRuGJeiH8DqB5WzE8QFCMuwT/WUleBtsrrMYlbs9seMl+8K3DS6XFKOuY+@vger.kernel.org
X-Gm-Message-State: AOJu0YyWf3QleqMp9Xv9s5D4vlZPImVSYAiuaC40q4ugP8M1oD2kquuL
	YnWSjsqeuje7spgup2kTpP7vRsK3VvJltjTKX+pBlZ26NUqYJm83Rvefhqu8DZqHnhT4ckG6GAu
	sPIsRVwK5yeLKCccAhxczIY6RH8k=
X-Google-Smtp-Source: AGHT+IFTZ4WucGv/zeWWzd3zcbMqcM7PdSjpemuDh/UaeOWaU6wHkbwQ3vV2E8UvE0tdUBJLN2bWoTZxWramU4cXD24=
X-Received: by 2002:a05:6e02:1521:b0:3a0:8d8a:47c with SMTP id
 e9e14a558f8ab-3a0c8cd7f8amr134979285ab.14.1727168147785; Tue, 24 Sep 2024
 01:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924080545.1324962-1-colin.i.king@gmail.com>
In-Reply-To: <20240924080545.1324962-1-colin.i.king@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 24 Sep 2024 16:55:11 +0800
Message-ID: <CAL+tcoBmccFW1VVPQhG4=aLx8XwqAv=oR+VELBr3Zuwc=6BGfQ@mail.gmail.com>
Subject: Re: [PATCH][next] tcp: Fix spelling mistake "emtpy" -> "empty"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 4:06=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in a WARN_ONCE message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Is it supposed to be landed in net git? See the link below:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3Dc8770db2d544

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks.

