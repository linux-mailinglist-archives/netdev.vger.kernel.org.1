Return-Path: <netdev+bounces-103294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166B69076BB
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4B028347A
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CB55BACF;
	Thu, 13 Jun 2024 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvu5oPWw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F991A23
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292749; cv=none; b=SJ2DkgGf9JK65T+b16rF6rC7SjQ/WTQZkmILzQp2HwHD9CwWAzhjp3nlnZiNWanqP6aFlGh5CV+79eM8W74/mDYHCxjhkwolzwIx9y50W9fbM07mTlMz6f00/HPcZtIAJqw1eHbY88lXWrDGdVwCovVdgr0PJXBwCOUD/TUiEcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292749; c=relaxed/simple;
	bh=1X8+9M5BD/72FkXFPFdAYJaYuT5mcl9ox54njuONLgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ry9dE8JpLHfc9FsRilkggNWzRYi8P1LlIRkKStAapvOyoJd1NW1tLK3And44MbmwLi1MJz3PqItjwR6EU3DnFSKG+eOlAiKRC3e7/ZiNS2cYkHJDAa8baoGNslkzi+C2ySg2WRcGBY7N6V9fDvuvcxZjYcxHTPBR01PUyiR6Rgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xvu5oPWw; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57ca578ce8dso1314641a12.2
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718292746; x=1718897546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1X8+9M5BD/72FkXFPFdAYJaYuT5mcl9ox54njuONLgU=;
        b=Xvu5oPWwSZo6K4lvAI+1hH4f0/S2HNlalpYgYOij8/73JFSWNrQhGwTC7gcbcVcbWz
         Q8LqoOg5CDm25nx6ghnU8ECEFXNUKhDBKnSx+mi028unH+P7vYlQ5w4AMIs6m5jpBmJR
         MWNSDoIQbyp6oBs3IPQxicwSt539Kz7xzhj62+oU9g0KSRzp1lsvz8fE/3ylXj+f1Wqb
         DivUACq877qg8pkhOYCj6FdTPmUxOVi90b24BRW14dlwi/zM8v3mi9GW+l4RnWQGMegw
         9lonLYfnKNadXry3NuORpaiCWDoUTCs9V3dOIpt3gYlbF1ZyzAO/XJCEGePVZHz+KoMN
         rA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718292746; x=1718897546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1X8+9M5BD/72FkXFPFdAYJaYuT5mcl9ox54njuONLgU=;
        b=YOmnQNhquQ+63i2R2GqiQ0fKZWHSzgP8Dj1VMiYPxo6LR/zP7jpdHrV9S4yuhS+VS8
         GbEQO864bBz0Gt+HdH0rV7zsTwlUKaAIrxrFsceNu9f4uu10eeeVbMnBgsEjRR6WqGwc
         48CixCw29ljJvIo0BSDqXGZ8CdnwhqXpjfyjwaiXYs1JgvFYnjEfZyM4fmWFBxaVHqdt
         ngS3YKFoVA/pwlwLBCuDuftKCQqYhFSMjSDSX522ZuAa3lc/rJnT51+jgRT2pH992/hi
         quvlfFg4JqGHfTXZDrvIOvQMH3510AqyHRYz/VWJrZ5f7knKoa/9KNbZiYwppIASMPnC
         AltA==
X-Forwarded-Encrypted: i=1; AJvYcCUtZW2HyMcndiS/z+FOmUtWfHugEEN3wBIG5Z9c4aiv3gSMvSpFJ4w5yhiCfH7mYsC7XHUGFl7r+RNqONZhAt4qyPA57D5e
X-Gm-Message-State: AOJu0YxQEUBgTzZG+HGJKvAEWZEtV+Slkxj96llq7S0JRuraRt/v1YO0
	AUo3l8HP7sd/dc0ZqqWsOxs3KrwYhEbnDt1lKCprAfM+RQUWyefDeR6ocX+iraMcr4cuL89Xv8o
	i1HihGz5plgliqtWBI1JSicq1lSY=
X-Google-Smtp-Source: AGHT+IFLJnKUdn5MSuiY4MatB7R/2MgFlkbZqfZUcy/xq4ooC3Qg7uvHRXO2MNFoqWrmhsCDDL/+LibTVOs3y4SdgpE=
X-Received: by 2002:a17:906:3859:b0:a6f:2206:99ae with SMTP id
 a640c23a62f3a-a6f60d4144cmr8003266b.41.1718292746103; Thu, 13 Jun 2024
 08:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <CAL+tcoAP=Jg3pXO-_46w5CbrGnGVzHf4woqg3bQNCrb8SMhnrw@mail.gmail.com> <20240613080234.36d61880@kernel.org>
In-Reply-To: <20240613080234.36d61880@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Jun 2024 23:31:48 +0800
Message-ID: <CAL+tcoANZB=n+E3gg_3ZdNUjgO1kcgNTeZfg0Lcq9n_xg+d6gQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 11:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 13 Jun 2024 22:55:16 +0800 Jason Xing wrote:
> > I wonder why the status of this patch was changed to 'Changes
> > Requested'? Is there anything else I should adjust?
>
> Sorry to flip the question on you, but do you think the patch should
> be merged as is? Given Jiri is adding BQL support to virtio?

I think we should, but you are the maintainer :)

One of the previous emails I wrote: ENA driver also uses no-BQL mode
by default. I believe there are other drivers like this, so the
purpose of this patch aims at those missing drivers.

