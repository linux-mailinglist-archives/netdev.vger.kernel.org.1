Return-Path: <netdev+bounces-157428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E9DA0A44C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC00188AD89
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778B31AF0B5;
	Sat, 11 Jan 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zG0t6Mea"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75F1F16B
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736607003; cv=none; b=D5ljsV/ZCIXJTKiB+TRzB2+cayY8zrXapv2NXqeGtVssZnoFHZa9NL5hWh75cVTBxQKikVr28zEgOST422IocBURG2JCHyAWWNB5HV3W8PIZD7SeMeXM3UwYlrxwIMMVIhLySan15SQz4irH42HFP6J0L3gClfY7pNzeYG361J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736607003; c=relaxed/simple;
	bh=Z2veQnl3GZ0xw7GbPP0M3mkyYPZQKE8ts7WK0672EFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vm+6KFlWQtAF4wfwjDqLI/cZYEQStbodY5aR8aC9qp3edXsXXvkYpFfbOUrot8fLQzvgVi+2v9IABmy8xyNtsGGAEgWByPhfc3JnvZJrcKuqowg8fDdeJ4g6sIX8DaQjYja8I/fFjUgpvSCjNiYaUCzh2gJHv8iHLEEOenAV86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zG0t6Mea; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2163b0c09afso52300475ad.0
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 06:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736607001; x=1737211801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OffuVC76PBQtLNst+NoTj3k+WlHStXWK3dUsL9+ew/8=;
        b=zG0t6Meao1NCEaGK5Cf1xC3c23aa7lndX6YCDasaM6cg2IdfHtZIrXCQ9xeLkfCmjw
         9iI/E0k4UmawWkU3gRxFV92oLH25Mis4rPRE3b6tR5yhxuTOrvAp04IZ1u2+lhydlYvv
         Am/3d0BXPtklJLJlfJWSuStibvHHHwAtZ8jbsAG62kzHv/A4Cyi0SiLxQHAu4qkVrtcn
         0WGj17GTIMFQt2nSerJjFZstmzhPBWo1Hafttw4Jbqwix6LsvufDaRsnysRPWLMGmlhW
         qsOY0f/RTTW6KSgRRc378QecCvqtK+kkzB27ykQpu34CBiJEJR0LVMCn0Pc5OuWu9iHH
         mUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736607001; x=1737211801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OffuVC76PBQtLNst+NoTj3k+WlHStXWK3dUsL9+ew/8=;
        b=JEsT0P8HOjV0ryBEU8Rfu5pVtUlalQGnLxxOJ90OTU5mNRUxJ2bdO6K61GiChWVYuY
         hqFsyDm2CFHA2KjuqkgUM8guNiOuNoP3gPB+1OWAY1s6rOU5UWHKrA8VHfJfnIQQRPsZ
         e+OiNiua6mzWL8Lu8RoyL7RKDnSWgBy4tztfbm98z9S1rCZLF68blLk7Wmrc3Cty5lph
         0YHPmpnqX2z30p8xrTZpcRpEmb0JYy9JXzVpwzLYh/tZZ9a/rlQjAHbj/OwhrhgYz0et
         X9Al1OkDM+xwQK6l9ZuqxMr0LciPQNoEV+dzSsqjUDBn3HTGcGNOlP0QGoFDarmZDUoX
         SfDg==
X-Gm-Message-State: AOJu0YxG2ubbWPoHoXiA0MuDcfJzZDXtCQiHDGaiSuUdmqowMkAHaNSy
	8aTG5eSpqv9p3dPscUa7dDHmfjs5SjgbwsASVTGoYoP110974/VkQMbmrdbFjD3LRHgtz9EUVbs
	5iaGenDrZLSeXpnP6TiMzKMenK4phvfiOItMP
X-Gm-Gg: ASbGnct+g3yrWweH3PXX+rnrgV/5+MXl29cPjzW3vgGbTzNZXcH+u4wBMoI4mED8gHu
	ivvIYhNtUQVvYo8sG3HP6vpgNxX2Q7+qw70bf
X-Google-Smtp-Source: AGHT+IEQpgwsdPDnrVjBCw+HDFMGlk0GiZ4b5kDA+ewxPQ2xfg5Pyzhaq8Co/zzApCfFa5tsPxBOkOEnk+uEQPlWR80=
X-Received: by 2002:a17:903:18a:b0:218:a5a8:431a with SMTP id
 d9443c01a7336-21a83fcc47dmr225437885ad.49.1736607001237; Sat, 11 Jan 2025
 06:50:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109143319.26433-1-jhs@mojatatu.com> <20250109102902.3fd9b57d@kernel.org>
 <CAM0EoMn7uADZkTQkg48VP7K7KD=ZVHPLfZheAwXSumqFWommNg@mail.gmail.com> <20250110183307.4bfba412@kernel.org>
In-Reply-To: <20250110183307.4bfba412@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 11 Jan 2025 09:49:50 -0500
X-Gm-Features: AbW1kvZIx23k_wZZ3K2RFkze_p_QQ3v6sXQhVVt4oapU1iF8YCd4KpHklJY35gM
Message-ID: <CAM0EoMk9jye5Q2Q-3XcFMhwFZ6U9q9UNrUqqU6B+ndwoUstU=g@mail.gmail.com>
Subject: Re: [PATCH net 1/1 v2] net: sched: Disallow replacing of child qdisc
 from one parent to another
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, security@kernel.org, 
	nnamrec@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 9:33=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
[..]
> >  It could be you just wanted to ensure some grafting happened, in
> > which case we can adjust the test case.
>
> Yes, adjusting the test sounds good. I was testing visibility after
> supported operations. If the operation is no longer supported there's
> nothing to test :)
>

Ok, sending V2 with the Fixes tag, test case fix will follow later
today after some testing.

cheers,
jamal

