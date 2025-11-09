Return-Path: <netdev+bounces-237027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C161C43AB9
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 10:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003BE188A821
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 09:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253A02D3220;
	Sun,  9 Nov 2025 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khN+CnoG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844A42D0283
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762680635; cv=none; b=cyuq/dOas5V9lFSb9LB+7Ljfgf7mtW7XLhVMjP7NfOFqqhE4LklMcHFeWSBXKLfBKCbVjt9D0qavgZxK1GcTTBCrH74ZvDPFwoBBPkmJEVnCSk8DT+GmJTBHdJyKUJP7/wkJnai51y824kLKwAM6c0FUoCmIhuYRBzqzWtXbTUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762680635; c=relaxed/simple;
	bh=pvWRPE72f40c7vbjMbihtTq6zbZEeEjjJRM9awt+iQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpQ1H0NJcWG0FtapBzBFw8iyJIr8dR13GSdjSnC5w+otOGmH1rjmQHQFUdmfE/X2MPrM598pgAUbZ9mseB4CCilwMRw2JgX4edFzFfPNie3Oi8HCpF0U7SXUQQGzquGCXiawzsJNtnzc0S5yMGrDPxnTorxix0pyT/S3oIS4iaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khN+CnoG; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso1570402d50.0
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 01:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762680632; x=1763285432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvWRPE72f40c7vbjMbihtTq6zbZEeEjjJRM9awt+iQ4=;
        b=khN+CnoGm3vz/K3mwxzrzDgWwJB6MrWmi76SW3PVSbymhaS+EvNLV5WfZtyrwnw0Ve
         N3gRikJ2+15/a9W1HNnTMnU25s01G2ikAV/LKjTY4fiQ+YZ97Pr8wRUxCHH+uVVMfnpj
         4MzdtaLOzmWSCf6DiZyVVd0ZDmR13oyICzLnJFh8YCHq8CU/LKHcN9CFKyVVDmRlp681
         CPAeeB4tZVUdHodBf05EmW9xnFwkyJgCY2NvT1iJ6WYm4bZjOqC1AiyEMji42CxeMkci
         96Bf9p1EUveLGHrPs+ag9cCEE0A3ZPSjEFnEKtGPs14CztFWv5OwNclNBkL9OayWN8bC
         SGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762680632; x=1763285432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pvWRPE72f40c7vbjMbihtTq6zbZEeEjjJRM9awt+iQ4=;
        b=Ox69ph4BQ2X9K9MLxYewgxZn+d1rDeAc9q1lk7U0ZgzP5cVVvCXhFGGd5oFuKczSgw
         Q/QWhUJb1yZFFi9IAHJ2M8ZcBl5F9j+dUOQ3lEq0/sWkdJxzyfWLd24LPqIQ11A5ndPo
         XVZNLzJMbCiWGGEOJ3gEsXjIIYo8LTUBYXoqt3pBcw8wRseXvC6vyqi/0WHyxisaECJy
         FL9bbhP9QsI3l/dtKuztdrqM3H0fG5qY4Ml4ockKwlefQZRkZLskkBMl+QBE1qcaPy34
         JKZVCIV3LG8YEeqAmOzWYufdXlcNevAbdEfHXLMkMpciZs2N5gHBOQbgXIzI09Q5xYv1
         FKIA==
X-Forwarded-Encrypted: i=1; AJvYcCUUjeHEOIMB1NtxEJwCbgjjyBFPHLs/9aU7kWvDWYLPljjZyQAw/tv1XSMQqbxzqxMASHeZeVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu6sa+aVgAgsmoyO0yC0i2d8jeJO4vcxXlZsgdDiEIyBmkv1ex
	aY7kZOgV0DB5HKkURUs4eeOHwfDDEIew9O+VKgtag6PCcKjkA30ZJr3vbvZuIOuS2dbVIV5ss0o
	SVqmKKYcA7jQzCDafqE+yEBTG+Otzr965K/QXgF8X
X-Gm-Gg: ASbGnctUPL0Z7bShd8vI5WZ9OqyGU/8xJlmfL66EqsO3sgSlAyTecRmmVZg5XfYlDZ8
	dz3R2UtdPRAPmlcXq3p2JSpFFCo8oe/B1GOJpMcqhwNnPNtixS0a+WC5s/IfFXFmHsaiKwOZeFC
	By9CfTt5nqx4dzAC/S9kvxdwmcgadNstD3A+lqM2uAzKT1H2pMNMxI0xL+DuYo8qBqsnN09lfIY
	E+j+bz1D5RsZY05i3btad9CsP4xBIb3cbZ11BNrBonxvKB8NSFS5ntvqig=
X-Google-Smtp-Source: AGHT+IE5Lz5Z8TvHu/XPQZ7xcW35xLYMK4BSsLRb4ZXHHryfbWTXxcK+3KOErSSKFwSY3Qpa/b+Dwb6scgyk4w7oYOA=
X-Received: by 2002:a05:690c:3341:b0:786:61c6:7e71 with SMTP id
 00721157ae682-787d54000e5mr44006727b3.33.1762680632121; Sun, 09 Nov 2025
 01:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109091336.9277-1-vnranganath.20@gmail.com> <20251109091336.9277-2-vnranganath.20@gmail.com>
In-Reply-To: <20251109091336.9277-2-vnranganath.20@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 9 Nov 2025 01:30:20 -0800
X-Gm-Features: AWmQ_bkbRtNWGfCqQhtiyR-WwP60coqAmrQ2s_Ti-H7itEOnkdEhbjX53fOS4EE
Message-ID: <CANn89i+zVr6RwHPgDLcqovYXYwXHA_zHZ8i_1fq0idsN83MHuQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] net: sched: act_connmark: initialize struct
 tc_ife to fix kernel leak
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: davem@davemloft.net, david.hunter.linux@gmail.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, khalid@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, xiyou.wangcong@gmail.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, skhan@linuxfoundation.org, 
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 1:13=E2=80=AFAM Ranganath V N <vnranganath.20@gmail.=
com> wrote:
>
> In tcf_connmark_dump(), the variable 'opt' was partially initialized usin=
g a
> designatied initializer. While the padding bytes are reamined
> uninitialized. nla_put() copies the entire structure into a
> netlink message, these uninitialized bytes leaked to userspace.
>
> Initialize the structure with memset before assigning its fields
> to ensure all members and padding are cleared prior to beign copied.
>
> Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D0c85cae3350b7d486aee
> Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> Fixes: 22a5dc0e5e3e ("net: sched: Introduce connmark action")
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

