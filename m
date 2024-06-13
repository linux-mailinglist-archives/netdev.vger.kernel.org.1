Return-Path: <netdev+bounces-103292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87A290768C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FC6283717
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C99314883C;
	Thu, 13 Jun 2024 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7l+Sg4x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2C143724
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292364; cv=none; b=K8MWnOLNvevZEsjkBghxT7qi0ZzA3m8oBt14NzBqgRqrUg2s5FtcTCBjsKHjZmH9jFO6WgfBtnhZ/IXleaGAj95xANgK398rF2bDZDU5E97NHzJ+VsvsIrnw/wn4m/htQ/ALFYTN7Y+7ZLST9NGRbEzZ3JvWUf4avUktv9UH1oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292364; c=relaxed/simple;
	bh=y4tLowWGLnRh0zy1hMKmGQFhWzeY8uQ84EiQimSmoQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebHdF6VIGvN5oMvOomqBw82UzPdGQgeh8+OU4xogPhhksRkcG+P/U+N2v4QvmqTxfFbPBGex/wackTdkfYiBYgEjt2aZdyb1hTtNoqY2YSRdv/EtOcAELhZ+gSDW2hyvLz3ii6a37CZ8Ja4zIt0YgR7QOsFMXO65444vnoEbFgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J7l+Sg4x; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57c6cb1a76fso14143a12.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718292361; x=1718897161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4tLowWGLnRh0zy1hMKmGQFhWzeY8uQ84EiQimSmoQg=;
        b=J7l+Sg4x1NpvRuTph5PESynmzajq/HmXYw1CkZcnmalS3Rq0mgSvxdNC5GwtnTeIGh
         /bwoVhrZowgWSucPkqr7cbNmHUAC7tAOCcMkePo/EqJUufjoo7scJtcCQr8sjwYPOFGK
         1ovrgCXdI576zedgB1RFv1HvgmOBXvk4qq1qvPtUYEbFPjx0xpvN8jWpwmWtfscTu2mP
         OClAc22sCKVjEEMKcuTBRV6stHIT2CXY6ItrJHrqO5+qhyZloYJa+UuKm/eX8EXzlWDJ
         1M43Zse/eG1WL5k1FrPEgzb0vHGtcTQgY9FD1a90yuzuJMqv7mSNPQkDQRuBl9MKXbJ7
         wn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718292361; x=1718897161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4tLowWGLnRh0zy1hMKmGQFhWzeY8uQ84EiQimSmoQg=;
        b=w18KwkXhd5vKmBlOqnDiFx9ZBl1yMyWvwxZY1+CSUKzsaI2SkMYziMCrtS++/9xeRQ
         yl/ycNzOwBBE6XmAQOPOcCsy/u3ftqwGdLsJPVduS+WVhHZGwRwQG0pojzH71C4glab3
         lC668wJskd9bS/bheSALgrvBPd1AJ9LhAhmoxAl7oCI5zGv9frbsRiITWoNclg2etfzN
         5XcxP2yDnXuFPzNq2eXnYAvdkGoXCwj84S4DyIvAp0D8DhA34iHVpeEooxv8ugLHOQJl
         Vk38+Ef24YiIo1DdW/1ORY1cs332zuIZi582QgTODVrRfMe2da3+XMMZFd42qEHJeECW
         V4NA==
X-Forwarded-Encrypted: i=1; AJvYcCWsg+0kBUZQSrOxC3atWPDtoWiC7DBcfk0VbCmdM7sCpjnAKQZv1RSujGu9R9wWF97WoHXHBVr2gZH/KdaUq2Kpf+uaYuB3
X-Gm-Message-State: AOJu0YzIjQCCd5kHiM/UXFO9HBl9wg3xuHRurmN06mP4W5ClQrqbKwSo
	sNQz7lxu4vZjlvhH2GDWjsdIe5p9F816SRdaYlynAHEanMQPCxsQL+wJDRSB6HRxM9FyS/vNcF8
	gKwxV/ZhS+aoEtcm/TwwR1wanBXvX3Q0pcWP/
X-Google-Smtp-Source: AGHT+IGicFlIpFTvgi823hXHZoB9s5JMDVKGHlL11+rUnNbowGhqpTDd3a6n6dfopvj7EG4elIMuG35pqXg8qt8vS/4=
X-Received: by 2002:a05:6402:348f:b0:57c:bb0d:5e48 with SMTP id
 4fb4d7f45d1cf-57cbb0d6413mr113273a12.2.1718292360906; Thu, 13 Jun 2024
 08:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <CAL+tcoAP=Jg3pXO-_46w5CbrGnGVzHf4woqg3bQNCrb8SMhnrw@mail.gmail.com> <20240613080234.36d61880@kernel.org>
In-Reply-To: <20240613080234.36d61880@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Jun 2024 17:25:47 +0200
Message-ID: <CANn89iJj=ZBBLxgRQia_ttE1afxGSbJJxG_17NemZB_8OL6LaA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 13 Jun 2024 22:55:16 +0800 Jason Xing wrote:
> > I wonder why the status of this patch was changed to 'Changes
> > Requested'? Is there anything else I should adjust?
>
> Sorry to flip the question on you, but do you think the patch should
> be merged as is? Given Jiri is adding BQL support to virtio?

Also what is the rationale for all this discussion ?

Don't we have many sys files that are never used anyway ?

