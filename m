Return-Path: <netdev+bounces-146816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26999D60BA
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 15:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881821F215E1
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF4884D13;
	Fri, 22 Nov 2024 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DAYea4vJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED1876036
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286792; cv=none; b=ePPYBpqmm/cjXlKR5EM69n4vwt8m5H4KX3Q4T0veVjVtCqnFZXCOH+iTQeVTJckAOzLtpl1WSPXlDv7kM50VDlYfgRHuiz8LBayqwbMakhNBA1VwR54rGP+W6uVatHoSOelzUlcsxj3fpBxZcu3Z1lWnTZ4w+1GWUy23wBJ8UB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286792; c=relaxed/simple;
	bh=YuCDyXzpAPEp7yzMQsq89fFqbxrywM3WLDg46780FWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m32XneI6WvYhxY2WFvbYUYucIDu3BbNS7KKsa49XUJ7IMPpR1aCeJhZCddFn0xEVY3D2DMGklbROprulXyxs5LiSb3xCTIlu9uYnbY4MY8eFi/aQ5+y8EhVuVl9HNfJ7Hhrc6zOpwR/K+7gyhvTZlK9YEXhTbhgmLkaOw1tfEgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DAYea4vJ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53dd0cb9ce3so1742896e87.3
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 06:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732286789; x=1732891589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuCDyXzpAPEp7yzMQsq89fFqbxrywM3WLDg46780FWU=;
        b=DAYea4vJaqkKrZqK3Q0YE2LV/P2qx8pLec7qBLcV/WkUN8sSKyKt9K8eokpTXhiQId
         XYXlKIsFArZESQGX97zkGLQXbuutL3+vw+28nH1n9h7He2tYe6OEtjPM92kR6tsX5r/6
         BjQjmbnCTofZO0vYlKPElN5Aj21cyakOe7VEMfXTItXPUAaF40OMKdRXPJnaeDjbe4pR
         H4c58/jKm4Sa53MujbVHiSgPxjLkv7r97KQ+l8iUHCFjvzjGs5sgAJ3wzZsIfzUxNieR
         83fr4w3UVpbWcA4ffHeyf7dp4VMjeP/RW/K8sFpKim9gDLyK3RT2wSUQFDgarPWApKWd
         dPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732286789; x=1732891589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuCDyXzpAPEp7yzMQsq89fFqbxrywM3WLDg46780FWU=;
        b=QstOM1REdjaZQuAkiQ5Bzk/8l6oJH0UKKgQ+6Yr3fzrYOa+NhGny8to8/xyfzlJUc/
         C+vnMBFmDTSmElsEDOkE1UX5TsKGCBFbIGhGkO2u6wPEyIk5Cwxyxk6n7aQkfCoArrfj
         Me0MbimXQcUzcRcrOtLA2vb3LmLqlTElXygdHJipFk/Q/T+lp4o2uW9PR3x2CnSsxxbG
         DXJLtxzbFKsG11dLGY3L6+CDjwJlF7QxiPxmiftRhBEVyINjG6OauJXdEpoQjcz911CK
         taFBFKI/PUQfoKRegCXwfSUSg5uCUG1z24JtU1KaHdw/60qGf6AUaP4/Sjq1Xz5TEw3y
         EXqA==
X-Forwarded-Encrypted: i=1; AJvYcCXnqklA8hoIsR+dR29E/hVpYvqLasO4u76wrUF/FHmQCFIKe5i4xzgPwJ0gytsOg2kzvlfgdLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmPtVYvFJBcN3G3gh2CImNnW7wQPWbWMs686Sv26GXTN8yaTTQ
	VNR7lDh7Z1+SAPeJJlCnHwwXbp4EQmlGYHPO+k62WtSAppYIsD+auvkJd0HfpUHphHQFSdLSMLf
	KHafABU0htOE7lZd+oDB2PEam8LAplr+4kGrC
X-Gm-Gg: ASbGncvKR2baM3ov2Mk/EiHrffAkAEc+xQwwD5PpAtr4NOy0i+DcCq3YwXShFrJnvg3
	cI0FWMNhRzJfzlnohErppigZxsCxzOg==
X-Google-Smtp-Source: AGHT+IEO0g02B7hMsc6G7E1jh2onw8QqpwRT1leD0anvYgIAvIwpEwDCFZIzyZF/av/qeAHbuQ0CCwLwxb2LPehfcBo=
X-Received: by 2002:ac2:4d8b:0:b0:53d:d3bc:cc11 with SMTP id
 2adb3069b0e04-53dd3bccc70mr1525350e87.48.1732286788623; Fri, 22 Nov 2024
 06:46:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-netpoll_rcu_herbet_fix-v2-1-93a41fdbb19a@debian.org>
In-Reply-To: <20241122-netpoll_rcu_herbet_fix-v2-1-93a41fdbb19a@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Nov 2024 15:46:17 +0100
Message-ID: <CANn89i+iQJ70z2P-ZVYq9vbas16wDnBPQdp8fZT6X8qONeovGw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netpoll: Use rtnl_dereference() for npinfo
 pointer access
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michal Kubiak <michal.kubiak@intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 2:18=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> In the __netpoll_setup() function, when accessing the device's npinfo
> pointer, replace rcu_access_pointer() with rtnl_dereference(). This
> change is more appropriate, as suggested by Herbert Xu[1].
>
> The function is called with the RTNL mutex held, and the pointer is
> being dereferenced later, so, dereference earlier and just reuse the
> pointer for the if/else.
>
> The replacement ensures correct pointer access while maintaining
> the existing locking and RCU semantics of the netpoll subsystem.
>
> Link: https://lore.kernel.org/lkml/Zz1cKZYt1e7elibV@gondor.apana.org.au/ =
[1]
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Okay, but net-next is currently closed.

