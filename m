Return-Path: <netdev+bounces-201638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21042AEA2DB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5870D163003
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D782EAD0B;
	Thu, 26 Jun 2025 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCAQCbVy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DE2EBDFB
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952447; cv=none; b=qwKdB158BmOKC/Z/8GL15HLE8//rQqpgxsdXisWz7/HhZPIYd5BPPLi5WFjZ1MDrpctbkJcWhex3JgO5BKci1XPhrmw9Fx2VmCVO5tRV71EeQM1NiDHqtxwaiCkf0T0wiIq0ZIRkcaA3nuNOnu73z244DV/bXQ6lkZsaNPeiA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952447; c=relaxed/simple;
	bh=VzOvxiaNvVN/DNjhadVayi6gO440kDiGNwdAH3oy5jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svbc0OBkaNKTg+2ZbFGaNNqTh84cXfsLVIwBi85bzWcw7esk/fBwY5/TXWmkjrxyR+/T4N7n9bTLLCAmsccoFNVKI8qW0SbjMvEPmZ7RvKvNS1cCG/FZBQApQN3OZtwhhsI/jsuoHuKf6N0qq+V1KFE0sYurZLi5dVeYr4Yb/S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wCAQCbVy; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a5ac8fae12so482901cf.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750952445; x=1751557245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzOvxiaNvVN/DNjhadVayi6gO440kDiGNwdAH3oy5jU=;
        b=wCAQCbVyzLioqy8qftXP/K23v37oR/2H2ZE9q29eOjb+21LM3KDEapx3hr9P+n9yKz
         Hg7FubH7TtMqoUSfEk/vWgmj3slr1xHVoM4c3y0Nhn3FC9OJ0eISGleSaI6Ei9qsfdHK
         1b3DlaPNSIh/X1XQszGLsurdvl9cTkcacPfyLdb3G+e1q/WUBcusffeUYLXmVhS62zbK
         xKYaWkdRkxAQxUcCRB30Kx3NGmuxetE4WPHPk8HfzkvWHEd5twy4WYklNqpddyFDU46B
         V8fzWhmRVM2e1BfXyv8dX4/jAOH7z+ecYKSz8d8HCrqw7iBBuryb6R9yTQvPVpWPxsDx
         S0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750952445; x=1751557245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzOvxiaNvVN/DNjhadVayi6gO440kDiGNwdAH3oy5jU=;
        b=QzOcryJhmQ1yYooO6SmDqDUBFVO/ep9rSxqpsu8q0vvctpVkG0OxmjeIS2i8SHstWF
         V51yI/1wDanmlTcK9Frd2QXIHew7I6YDDWhOjVX8Bh3Ssut20CBZa5w8kOP4VsWljfN4
         H0SOE6H0zqR+0ekD/YraPhol+DW6HK5nkHoYgUDJwe8ihjK+IB157+i9NqxIzDUwqeVc
         E3r0sTVucl0PE6QERIMePHG8ImgEpVfPmhXUyKbeMNbG5GSUzUrmtHquX9qYmqW9to4v
         NaMYM+iCk3YxBv05vEz5RCLj0uodY77nuw5lGrxaRDWXsnJiM6H9NagK0Y9RLSeJ37kQ
         R/9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmRcwf63flNClDL9TDXnUO/zmx04pyn56nLbyXz7eoT7mU33wdziC89GIjqdgi0+Yu0kPP9mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiTik0A3VUyIsZXVFA5qHJxOByO9qXuCq0F8P1lSde+2l395uy
	wDRvc1Iktptruq90pMbkScjw9AZsCY4ksd62aVcBa4Y5Kne/f/nYXSNP9w48Vi7FNicd/qgj2Hz
	wBOlXQBgeFkGYseqn5qDsviVFEx5+VBfFdfrXTF+i
X-Gm-Gg: ASbGncui9tplycVuktrkW0j9rz/2/chWYcpo5PEdcpF16taNumEogqUQit6B4UslM5M
	I8k10pwvFl6NhEmmBadEJxZ39zWbeaSUr6I20CWWU44khCdkWiTQEUIhaamUIQmotzbbQxB3osj
	0Km3zIWECX0ncKGQC+EIY/s6i5bY0+fnH3KnfVxsI7bY4=
X-Google-Smtp-Source: AGHT+IEvmVR4gOKw+B7S8fL1BvQqTLDaLWL0LCwIMF954xS97H96Yl31YJxzXbP3DgSqK36WHgHxt4ZJk7UFYLpI9d8=
X-Received: by 2002:a05:622a:d12:b0:4a5:9b0f:9a54 with SMTP id
 d75a77b69052e-4a7fc9b8a2dmr5341cf.18.1750952444490; Thu, 26 Jun 2025 08:40:44
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626153017.2156274-1-edumazet@google.com> <20250626153017.2156274-2-edumazet@google.com>
In-Reply-To: <20250626153017.2156274-2-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 26 Jun 2025 11:40:26 -0400
X-Gm-Features: Ac12FXwd3OFwybFZVPXdsAjCCr-yAPF290F0qKg-6LVRLA7dY4kOnNcSHEI4nC8
Message-ID: <CADVnQykJFF=Z_PdZi=hsq_wok5bRPchr1YQQ_QQq7ERMJi6Mpw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: remove rtx_syn_ack field
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 11:30=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Now inet_rtx_syn_ack() is only used by TCP, it can directly
> call tcp_rtx_synack() instead of using an indirect call
> to req->rsk_ops->rtx_syn_ack().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

