Return-Path: <netdev+bounces-96099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03918C4541
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D286B2397B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D61D17C95;
	Mon, 13 May 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CT6uWHye"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF28A1B812
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618875; cv=none; b=cS9fsZI2IhjLUPvhvcgHaweK3DMQPXFAEHvlJSLKO5OLOOcUGylXYzTLkvhvpIbi/EwlAaEdCUEHOInDRJE8F7D8nIvysCyTMJkYtZamhiQITJLKTsD4PIocIfKuFDfHarY4w0VFV+0lab1lpOzYoNKpSCvOeLthE70JNr/ocf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618875; c=relaxed/simple;
	bh=s8IABxquNN82B4Xu9DV5YC8zIRR2xm8Fe3dsJQpGZVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G35a6FnDz3ASeXI2xrMOPgVedxBQReaKjq55wZ2gEAwBqYZOSWp/or53v0AEE0n8yFp+dwiAcOz0vstnHbpqm86F9phK+xYuPyr5sjKe4GNjesM2ALjdoQ41QUSM9Dw85rs0qxE0j4ptOHkIWzfr2NvYm7Vy42SuY8UrMSYd+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CT6uWHye; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so3271982a12.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715618873; x=1716223673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8IABxquNN82B4Xu9DV5YC8zIRR2xm8Fe3dsJQpGZVM=;
        b=CT6uWHyeibfKOwqMaVBaC0WmPFy/VE5zWHqUnDudBURyGPEvgO2n7mzi039LivJiQJ
         dqG9IzHMPxTVZwcslhmSw0cCXxHllbZQbjIbSAdOwGRjP5bgtEBw9J7UJfSBsrEtFvma
         raftasaNJjXwjGgsWsUWkzC2jBIWu2zAwsZn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715618873; x=1716223673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8IABxquNN82B4Xu9DV5YC8zIRR2xm8Fe3dsJQpGZVM=;
        b=r0G6KbfrxU2q6E55AhMsh6eOjKM8YNVjzBlfuHUFqlCOn0c3NTIpTu2WNQ9OU49U4T
         /Bih/tP4R9eEWdtOnBEv4M85ZI9XDakqbgvIdKFfDa/u6loFTso/Gqgnv1avkBn82pQe
         WlcgLUh0RZN2EsZengKvsVjf2djKLHolTbE1VVP8mZcQzv0ZzJAxpQyMMCqGQ9QTvfNE
         /+hoPybHi+zLdqWOeD34yoBwBoAerDcv/gLafNE1qSn7czjx98neGx5WqIuEQwJY+K8h
         UtKCt+vvQZAnYXH1CQychPZpQztM1IiLBa83Cydh7hGf+qVtIForQg2RHbqNj3Mvcjzc
         TurA==
X-Gm-Message-State: AOJu0Yx2Qv0FzIXgcjq8QmpelT5Ytb5vxeuFV4C30gd68JBtIZKwDkOi
	IK0C6byThX4cryOtZYbXBjq2ciswRv3xmP+8yr03CcYbP8hwD/nmxJG1qWTjVI8x2RCtJjTePlM
	z2T3/hEJJ/QibYILyyIxRVK4fA3w72bKYMaeP
X-Google-Smtp-Source: AGHT+IGLX8YyMQWNC2w5RpKY7qMMS2Qj8enHy3NsQmRbp9Nky6fT7t9O5Kidzevyld4hoT1P6kK1OijrTCyqfgIWG1g=
X-Received: by 2002:a17:90a:df91:b0:2b6:228a:213a with SMTP id
 98e67ed59e1d1-2b6cc14b7d5mr8862682a91.4.1715618873160; Mon, 13 May 2024
 09:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com> <20240510190830.54671849@kernel.org>
In-Reply-To: <20240510190830.54671849@kernel.org>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 13 May 2024 09:47:41 -0700
Message-ID: <CAMdnO-JUKU_f9-weHpkOH=NTpp-ZV1mm6rvp0r91kz3M844tHA@mail.gmail.com>
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X SoC
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, mcoquelin.stm32@gmail.com, 
	richardcochran@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I will review the process before sending next patch update.
Thank you for the link.

On Fri, May 10, 2024 at 7:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 10 May 2024 18:59:24 -0700 Jitendra Vegiraju wrote:
> > v2: code cleanup to address patchwork reports.
>
> Please read:
>
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

