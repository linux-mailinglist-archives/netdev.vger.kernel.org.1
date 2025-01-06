Return-Path: <netdev+bounces-155323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DCAA01E1D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 04:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BE61638BE
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 03:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC22199391;
	Mon,  6 Jan 2025 03:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jC3JqQk1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CB41990AB;
	Mon,  6 Jan 2025 03:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736133384; cv=none; b=Wcthzeaxi599rSJ6kAMqF48GX0LdKOyg3wZnR4Se7FZZ94OJ1N+mjzJBx2I5Nfw5J63wTWrjTrtGyS3QxvwGUHpF2e9zQSS4Kcsd+yFcJHc/enaYJRXK3GJYPz1P8PoXgutQAkKEoyDD2hLXOniB82BylhJQY0EXknuGDnzOf7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736133384; c=relaxed/simple;
	bh=6IPWHaTOrczDxSlQFL6QestAhVQahIMinIrBHhFSfRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BY8L87iIcFuobF3GRQoCBTB/VZ3+RYZG3xgr8viGoeTH0hM78lW0mjk3DFQgnskKEJx7f5910YjJ33CX17QoTVgTNvpj++2kVzsG1vCeyM6JfVk+jMyZ/ViHExYUqvenWvilE86A64W0mPRN9SwRBsHaOB8USUNFOPCZqlBqMZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jC3JqQk1; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a8ed4c8647so105474185ab.1;
        Sun, 05 Jan 2025 19:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736133382; x=1736738182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IPWHaTOrczDxSlQFL6QestAhVQahIMinIrBHhFSfRA=;
        b=jC3JqQk1/ckUmXeD1e/BWyEfyWWjuykaiiQ74MXNeZDIag3o7nDQ5F0QCUk5HoN/k4
         RAoR+tI1ovVTzOaQbCXJRrSVf1Nf3Cob7PvE3ZOYH6HMMGDJvpcTFG4t5Z9t9VGRmBT/
         5oIKxN60rmPFJ/kEg4KA6jaRFK65gSXk3FTmU3F2yNSFZA13TfWQLB2pMoMo7VS7jy+e
         SMCELMCylCfQ6hgEgpX5p7g+PrStD02YR6V71trlimHNBWI4SvFam4B76xL0WTwCktKQ
         59wrr8IIhYS9W4FcTmgzwZF7eYA9EqljPIG+wih2EAW9f5HkWKlWg3YpN6k3kpW5E3P2
         QKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736133382; x=1736738182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IPWHaTOrczDxSlQFL6QestAhVQahIMinIrBHhFSfRA=;
        b=vr7vAEaV6/Z3ODFOsyTW/c3V/CU9m8FuYiiRL9l173iHitLpvZwvFh2TxqQxChCWhP
         Nd6UNLDA1t6pW57+U60jP8N7xJjcguT63nj1wu3UKreoUCS/lSzBOMY0Q9gZycccyT0u
         e2TJTs3/BlIdsK0qjFvrHP2CTo81ddUw6qcgW6bUKb714dgD16JEhzfn3TY3Tbmxpjiw
         Bqj26p53oUgOvUXYje3a/QaHm+zru8+oMzsqOGiB1DALGbkLg5Kl2ulOXFe2ouU2iDHm
         DaOlrYYDfVUZz0vWt99QseUWe/9S/Z762O9qx/cwHp7rKeP0VqkHX3/XNFrzbJnLkh1w
         4sCA==
X-Forwarded-Encrypted: i=1; AJvYcCWGzmFka52ShJQayee8ILIgCU9JEHQtCmPk4nmWJ5g4YCDtMAv0MdYd1IwOKIc20RmNmDaBZblLag/XDIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9EbnpzBxsiC+hHJlAom6eW6qDdHX+xoiceAfG5xuh2aw+szxk
	EsH/s5ejre0dwC4xR1jhy3rzOM2zBEiYbm6KFGZTcKRp0Yh1fIClmS8YPLt+CZmZyniT2dp0PNl
	vV7q+N3iYmopM/yIOM4bUVf2CY3A=
X-Gm-Gg: ASbGncvmwpCrm/zcAXjuVNPXmBXzKBjMhJyQWMcqTEboVcN7rkhxRMcSf5UyoBXDqu+
	73PHLIyfqDtRbt3ScS53uN8FJMWOpcfcSN5Msjg==
X-Google-Smtp-Source: AGHT+IGXboJXMwfx0rrriBV0xsxJbVey8ckt5iqNuLoh+FsBNvzgzRld6hEUHARjG1K/AQLmQcG87WFiYGVanf6Ci+8=
X-Received: by 2002:a05:6e02:20e9:b0:3a3:4175:79da with SMTP id
 e9e14a558f8ab-3c2d2d5164bmr468531885ab.13.1736133381715; Sun, 05 Jan 2025
 19:16:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106030225.3901305-1-0x1207@gmail.com>
In-Reply-To: <20250106030225.3901305-1-0x1207@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 6 Jan 2025 11:15:45 +0800
X-Gm-Features: AbW1kvZQ6a5EpV4TcNsAjFSkeiP1jduHSeGmkIy_rqzwbIc02KBaanmFnhgLH90
Message-ID: <CAL+tcoBfZRNrHarZzmRh0ep+QrfZOntm82hECNb=aMO-FdmH8g@mail.gmail.com>
Subject: Re: [PATCH net-next v3] page_pool: check for dma_sync_size earlier
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 11:02=E2=80=AFAM Furong Xu <0x1207@gmail.com> wrote:
>
> Setting dma_sync_size to 0 is not illegal, fec_main.c and ravb_main.c
> already did.
> We can save a couple of function calls if check for dma_sync_size earlier=
.
>
> This is a micro optimization, about 0.6% PPS performance improvement
> has been observed on a single Cortex-A53 CPU core with 64 bytes UDP RX
> traffic test.
>
> Before this patch:
> The average of packets per second is 234026 in one minute.
>
> After this patch:
> The average of packets per second is 235537 in one minute.

Sorry, I keep skeptical that this small improvement can be statically
observed? What exact tool or benchmark are you using, I wonder?

Thanks,
Jason

