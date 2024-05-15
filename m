Return-Path: <netdev+bounces-96615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B998C6AC9
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 18:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AB8282A63
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC732D052;
	Wed, 15 May 2024 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W3VNK8gK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE71802B
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791191; cv=none; b=R38W/Q1j1SBsZXTw+JgBQJr+7l3iUSiOA3MBGD1vNhnd1d2OI7F8Gt3DEvbg8sLrrAv0i3vZpP/jXhGdrEyUtFLamEALOuj9ElYLfEzPLRF03yQ6GqK/NwB/fdhcOoHG3/rM0XH/vripbtWQrYgJ4vKyCAOuqD7j5yYz0kofwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791191; c=relaxed/simple;
	bh=9bENYGurmFD+lyWhpF/h4fT2q9KBBedL30ubdo6nPzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+NwM6cuvZY11eWUhFygeKNPG5Du/h5655hBt5lqXJyDAkBmJ3ily8+kXelkM0lSS8YXj+KNNNwesbPTqO8YJsoVAxOr9CoTkvux5RqtixHQJE93DeNSAzxwLiwZjUkN3M5nqEwK0ip+C4+PvVtP2gmGzwBhlcsO3/o/Fk8myyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W3VNK8gK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso34356a12.0
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715791188; x=1716395988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bENYGurmFD+lyWhpF/h4fT2q9KBBedL30ubdo6nPzc=;
        b=W3VNK8gK8TB+ouuDoLgTR42egFHtm5rVtEupP6aSFyIAqw5wIIOwmIXEM98EwNru80
         +kUO3W6xLWXhsjyZtcydm51/xfAslKthWdOblSSKIbXb0jg02ECCO2nQjCHSFgJCmler
         900PvFJvWWGyekO01B5JBHRwVC2eFbMQIsmbziaxA9w65dLyrtkBDWeA8EiyTarg9/i1
         ggij9SosP9b3kgNwKKtjVAzgaB2DRFu4c7K/O1zGak9QlTfBlMRF1UkGSck+6tGtu/iX
         ubCPPOHMEESkj1qe45sAdETrPzCn3Ok7RNc/pln+ggGmCgoRe5YV4Gp8bwAXayMbtPaI
         6rYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715791188; x=1716395988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bENYGurmFD+lyWhpF/h4fT2q9KBBedL30ubdo6nPzc=;
        b=lxXfy1zubOG0jbnKxAo2U8sTup4knYL0p5qMYJC/x4MAOMtmnP6xTy6FZT+HrwiraV
         bYRM57J3U/5V22zOYCzyd/kGmZrmY4husDwf/O9aKVi4T8xymdp7Gy6SgXOYZ+87V64/
         Ol3wbE2eDrECGJb6mWqAJ3XkMylg6Hpj3ISTA+7iCxt4J4FzGg5pq5wX2gjIV+z8ybmc
         NjCvbv0ocki86pw9+NoDE+DqHAIEzWA8/83w+yLgJNdxPWacxzi0/GLR3w3FbEd2uuaV
         q8KpfuSQ7ZfmjId4t50eecoIXhlxd8cTCyUJMcbkPvYymWUhvaeYNL9ryc+K2dCp+J5s
         3Iow==
X-Gm-Message-State: AOJu0YyVObdw+eRqLgxIQK3W3jKsnR9s/sZxAALOpiT41248Q/sS+SDa
	0L8f27knKxEYTu+naBtEHTBgRvYBenzbDMIe2tIMTqEGS0dWzUyTN14yUBbSQJAfEqvMAH0tLqw
	fDJqQnWNq6sm9WbwPmRNVCxa6eD7FjqAGDB6/
X-Google-Smtp-Source: AGHT+IEDnTHxBXJDLOhQK3N6fY2vO+8C2/vNtru0HF39N6eQumAGvn9Z4FrV0M/FJATLFj/wu3KVHCz/8jxBsqCnSBk=
X-Received: by 2002:a05:6402:222a:b0:572:554b:ec66 with SMTP id
 4fb4d7f45d1cf-574ae571da7mr797614a12.3.1715791188198; Wed, 15 May 2024
 09:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515163125.569743-1-danielj@nvidia.com>
In-Reply-To: <20240515163125.569743-1-danielj@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 May 2024 18:39:34 +0200
Message-ID: <CANn89iJjMcZ74eCWqBdTferLtZ1AwyMSiGBkdqMNFMV2t0AREw@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_net: Fix missed rtnl_unlock
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com, 
	Eric Dumazet <edumaset@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 6:32=E2=80=AFPM Daniel Jurgens <danielj@nvidia.com>=
 wrote:
>
> The rtnl_lock would stay locked if allocating promisc_allmulti failed.
> Also changed the allocation to GFP_KERNEL.
>
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Eric Dumazet <edumaset@google.com>
> Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fh=
c8d60gV-65ad3WQ@mail.gmail.com/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

