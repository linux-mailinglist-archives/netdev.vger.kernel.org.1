Return-Path: <netdev+bounces-125213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6DE96C4D7
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E771F25F1E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A161DCB31;
	Wed,  4 Sep 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXlkCmlq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76F1E00B0
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469470; cv=none; b=trmHUJDPf+19U7in9Nsrh67gVn8o2Pni1D/Sxf9VkPpLMvfXyPplUubAS1UzXac8YmHszT84mQYHo93YohYZBatfzJbqpB7CYnCgE6P2e0i0w1Ql1KWMhcAlEU60YmfYajJN3g3F4yUIygXRbTo7eDHUdUo8wqriRR1FZP4PIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469470; c=relaxed/simple;
	bh=ljhbzx+k3bGCVd229wdwNgYsFTQeKAD41+zF550qPvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYhlKUuJgqFAk+wJHnRyjApeWfqe6VK6Gsb9X6bFVj0hcmoBfnCRKHfxANkgANoTqFjd6JAAzNvL4Gbdm98eX0SblvT8T1boQP/zGD1OUVwgTJsn7aYfKkMLfe4h3oEFOqh8PCypviiDoSuU07deS0vO4r5LTIcfF82WXplir38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bXlkCmlq; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53345dcd377so9440199e87.2
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725469467; x=1726074267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhRoNkL0Avzx5/KKEvsyPl06PAUtVfx20ocZRJCz2l8=;
        b=bXlkCmlq0pOfP7B7SetykuV9zL/P4VDe2wXdWNCCCHdjM23c2WiHxFPPTQPhFNd6td
         thV+OMboHxDEwHDQ/JZ/3izvEb68wBFkOPSclxMRsJP6uiygOVDnh8m2aEw9ogbqwknu
         g0m06qLHVLhFURyRV3WkW7sQrnw9T51C1eUXZRzhSkBtlVR6V+uUWc1NUQm2YBs1T6iS
         +Zj/bsWcaxIi2UhntVz4IckvPj0umhfcuA7jTtX4vVBPRirVki1mBP87oyn0hALx0ykL
         u4UGa2tWgg5u77+1StIgPudvNbe+OM/c6LCnM6VwNRqKuWZaHJBn8+Yi2GXZPmhHJliG
         ex6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469467; x=1726074267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhRoNkL0Avzx5/KKEvsyPl06PAUtVfx20ocZRJCz2l8=;
        b=JVanLtT6O8jt4g4c4MF2IvowBq9PWrBD8OWXabbEwSY/Qv8bJO3nMFRfByvOkPwBSN
         Xg+yGmqh36erlssQ9YyQbkBwlpjphaL6B0mz35h/aUGWqW70oQ9MQJvBMmiLsKKNfZAd
         yUgwxPN819ZeBSegdiEQnT0gqgrGZ/pH6XuppHkSdjZXaMLSEOmN24We0o5XgsHYsUZW
         OIHiP/M1jsnZ0/qRvodkMWttIpq6wzC8awVyxtNa+M3OM0aQobKd9hV+OcnYKPl/5xWl
         RVgc7Cehsv8oqEdn5kg1FkCpEVcuEr3gMzD/nRKudiJNurepoe4VqQXkhUCB5eeq9l7i
         aEPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Q7biK8He+emeZQZ9FcblmVmp8NDP0WnXhDeSAqwkYDLy5rtTAwdoVt3tCccBfsqcndukyEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrvi/A2y3SszIZpkkD9F26kvArn2Doq0d7dv47KI6HwHw1RQOq
	p7UHJRvD0Iw/2T3wzDT1IOHDbV2i7OhUsMs31Rq0XVOa0Hzi4apgruC5uy+cRFHoeN8Y15tghte
	Q9nbjoCz9DxL2DWsGSYec/0gPqhuVVaG3cTwk
X-Google-Smtp-Source: AGHT+IF0AadLqa9ZD/bM7M4MW5HdZ8I6rbTRcWNvhpQRijDHnb9gFn5sXNDG6NA7E4HxGeH0JOvT0dIbgCNjO6GgEzU=
X-Received: by 2002:a05:6512:1043:b0:52b:bf8e:ffea with SMTP id
 2adb3069b0e04-53546b93f60mr11839455e87.40.1725469466208; Wed, 04 Sep 2024
 10:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903192524.4158713-1-sean.anderson@linux.dev> <20240903192524.4158713-3-sean.anderson@linux.dev>
In-Reply-To: <20240903192524.4158713-3-sean.anderson@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Sep 2024 19:04:15 +0200
Message-ID: <CANn89iJki26SoevkdvcFO8HBCDbXR4-0nyZ55fFb2B66Pk63qA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: xilinx: axienet: Enable adaptive IRQ
 coalescing with DIM
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Michal Simek <michal.simek@amd.com>, Heng Qi <hengqi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 9:25=E2=80=AFPM Sean Anderson <sean.anderson@linux.d=
ev> wrote:
>

> +
> +/**
> + * axienet_rx_dim_work() - Adjust RX DIM settings
> + * @work: The work struct
> + */
> +static void axienet_rx_dim_work(struct work_struct *work)
> +{
> +       struct axienet_local *lp =3D
> +               container_of(work, struct axienet_local, rx_dim.work);
> +
> +       rtnl_lock();

Why do you need rtnl ?

This is very dangerous, because cancel_work_sync(&lp->rx_dim.work)
might deadlock.


> +       axienet_dim_coalesce_rx(lp);
> +       axienet_update_coalesce_rx(lp);
> +       rtnl_unlock();
> +
> +       lp->rx_dim.state =3D DIM_START_MEASURE;
> +}
>

