Return-Path: <netdev+bounces-229449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BE7BDC62B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFBF34E12B0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 03:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4282D9EE2;
	Wed, 15 Oct 2025 03:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ouM8/gn1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E22C17B2
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 03:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760500641; cv=none; b=OLZHIYqlD+JDYnA/zjMgEbx8kGRZrIOwd+1c5V3e0W/xbi+IddsOlSnmrRHa2nLTzbgmVXfXeoxxBl5Cw8vpqQRRBiGLzYBQ6kNLlKyTxgkaWJAYFS6BTZ9ysyjpop3qH9PeCkCpNm6nT2WqETdjsM4SEqaDEPdPEdQd8hHRxOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760500641; c=relaxed/simple;
	bh=ZuQ5E1sxEvAmUhV1Iyd2GFPccsUPwEZTzYenaOMPeio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvcvDrj+mpAIoEmgz81qDorfBQH+RSFC0869gK5rLgqlgca2OcVx7ViWGugwGQiAyC48A+OOIbsDu4BmyME0P5TGYzAx9kaXL/K+/wlKdo2tSHzJh+6XsGNQ0RmS2d0UtIhDe3gMwuALsOqTSBtPjNRLEfQKGkEI4nvib7U0svg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ouM8/gn1; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b631b435d59so3915318a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 20:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760500639; x=1761105439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuQ5E1sxEvAmUhV1Iyd2GFPccsUPwEZTzYenaOMPeio=;
        b=ouM8/gn1Gem4E5OG8eddD5EGVajEX+xmw2hdupknYHGDE8+eEeVZe5Uqsk2W8LQ2VI
         UCN7BAPoodBTAq+PT5zUUZwjV8l8ZTtVyqB53k9nx4Ao7odDs4s2TisIKHxQxDXQmTkk
         NZKe3AMRLHtH8tULb+VQR/DNDjy+062KzSjFT4Eegf2o5EWQdX/b8HtenGiUQWV+LcDD
         bFiwLpw9C+mCzRlu/F9mLLJHcBYuf6p1tZ222nycz6jdBsD8Qt5qnPCx51KMkpj7TIoq
         2HomSQy0oh2ddMc9iuSucvop+7rq9Z9mFcb6/2UncxxRrmqWzDmBjHC7bdLJWFb6XExW
         15hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760500639; x=1761105439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuQ5E1sxEvAmUhV1Iyd2GFPccsUPwEZTzYenaOMPeio=;
        b=ZImO7p7pOIp60LW5L8nfi21jBguc8c/YIN7gBOSJTk6rQAPjILRdgy+K/hZY2Om/s0
         1kzDYf71SDGlEGvCAuPheEYWEmas/+vbLuv2P81LRs0BSMTQ8ftcKua/+Se4+1jAMBfb
         rO+2ulbLYgUdSJxP4dI5Ro6/yXFMieqq2MMDNha5PtUvx4utWUGXuNeuO1H4tqOu8nXM
         J/O8Pszis5CijskMBnTWM6hFuuytFfpQMrICdM1n/P4McIEOY6iSoPQLxfKDuxnmzr6v
         xSojMyAVmqBmNMR4C+Bu4lPhIWDTHSXNSTrz8SZ66cfCemvXxo50m8rPI3QK0/rrpzs3
         ueJw==
X-Forwarded-Encrypted: i=1; AJvYcCXIiHqg1ySwojKwyD17C3eHoxoOq5DraUszS53s40iKhYzJwxqGAkLkMOkNocGXYWYEHEy72ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxttX43kFBo/d/kB0IULWRndMLsSYVcKp2lLvqBUvXJvaT/T5Rg
	8P59/GfaXUvsoEe/Tb7esyFskL51WoInZrx4i0UYgpc4e70tII9E2hrkj/QLvbhvJXrMsP0EqOg
	g4YOsXqeUNcfegd+8lohg0hLG/yns2Qo1oQT/A0/S
X-Gm-Gg: ASbGncuLNMtaXUD7zM4D2EddKqRsKeA6Z32kWA1lytubt1/kPrzWecrfI8QcOgBhCts
	NlrwePUnWj3HlfjMaRpWmsDTY9rsYRTQ4sOSJ+zyWMOV+9tOgJw/0Xvtarm2wU6xNukqgeq7AT7
	+H+llrXqNj3DnGlhDfz1IHwigJENwK+CxX6z5Z5RbWi0LAGFSDVAzB5TFgOxFGP3PE07gROmRWp
	NGRKF0VuGhQwYmVgOkAzMgIHWWCbRIBA14uVBWIK+Z+FAbvPkeoNDQHrG07Ec0C
X-Google-Smtp-Source: AGHT+IGXbBjUBrkLpbupAXZiO7YMpo0lDq8szWGnwGYnO7iRfvHiRQLPqNdOrz5xJ+JgH/20PmCFtm+eL7cBMgi2gfc=
X-Received: by 2002:a17:903:3c65:b0:269:ed31:6c50 with SMTP id
 d9443c01a7336-29027356b55mr323456165ad.10.1760500639341; Tue, 14 Oct 2025
 20:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <20251014171907.3554413-3-edumazet@google.com>
In-Reply-To: <20251014171907.3554413-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Oct 2025 20:57:08 -0700
X-Gm-Features: AS18NWDhOtz0GV4OMNNDJptIbe9Zo5Ycxb6jnMR4w-SrSz4pVzLS_Cm05_KF-Hc
Message-ID: <CAAVpQUC7cCBtne69RSrwqZSg7ZHWy7-wB2w6hR3vb=NDXc5A6A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in skb_release_head_state()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:19=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> While stress testing UDP senders on a host with expensive indirect
> calls, I found cpus processing TX completions where showing
> a very high cost (20%) in sock_wfree() due to
> CONFIG_MITIGATION_RETPOLINE=3Dy.
>
> Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() macro.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

