Return-Path: <netdev+bounces-93188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFBD8BA766
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 09:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568011F21A59
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 07:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22CF1465AD;
	Fri,  3 May 2024 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHdgRgSD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617214658F
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720110; cv=none; b=bLO0qWNVwJIgxSl3jXL58oH27DtZxv9ejFjRrhHBnWXQLpLRzDJdOn0jARmWuxKvdO2Sjy1A8IhI8gV2szFucpyCrEK9uYPBU7nxrkrFSLjYrHKVb4qHVjdu4zcfIx0apKVU/gO0Os6DZMzOa5MteqfOV2b25g3bHbFTY2W0F7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720110; c=relaxed/simple;
	bh=sJYYwD7qX3n7pMgl2AuVzEKADgLG7LTcHS4rth1sWOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duhc/Hx8fUlw+jZumMJkiMeSJwSv4ZlAYmssMGQXMzbipgos0nie8EX4icSwgfUepvxILraHB+DDnBEfVLxZOnpiHF/YswK19Us9ajuLYDaBpyahbJCBStwK3AqjhluLJ2OlRyAGHOpHmXehyWCF0SLEt2TDDfOmnOLQ/tPUhvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHdgRgSD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso4629a12.1
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 00:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714720107; x=1715324907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJYYwD7qX3n7pMgl2AuVzEKADgLG7LTcHS4rth1sWOE=;
        b=CHdgRgSDL6k3eaSMAJ+QqnLqC+naEQ2rxRxaNzXeRGWsxKvXDNybBzliyFc9DVnuyK
         tzTwp3Wk5uC52gGDY1AKW0DFJuWe6kwiJg16YR1INYdOAOGAiCQEccQJijmA63mOZqqI
         DW1AGe0LeQtLo2GCVq7iEgLQeNDqvsymyQi4vDBRUFC9p2GUejBhnOtlRpyM3LbAxmOd
         XpBXt1Cqo2Mv/AMMOZbtGav+452woh+6PkIdw0gjRoj6jAZIrDE2L5A7wbF+bwHClMgx
         uBVIUeTbGOoluGK2loCqSg89Kpsul3RAL3ixJC+h3+TzIrgx3ZZ14dP4DsOsBiVpO3w8
         2HhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714720107; x=1715324907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJYYwD7qX3n7pMgl2AuVzEKADgLG7LTcHS4rth1sWOE=;
        b=Cvwe1IqC4bp7kM3T3MoKxbFxyLbap8MnX0xB2IbwYerjxC5BIHgHL3uVrlSNJYBm0C
         o3bbnAnrwlWPPeOBOFpe6d9en5/d414k6gUGM5MP12cx/mA/Go94oD5v0FMiU62tASIg
         W6oRnr8q8zFRgywgYoQcz2bSEKebwJKon5ZSGjGXT01Fx91bin8SLCQCO8lskr3u701u
         6YTrDfOmEgg+qU4MoNd9YSS/CI3f3Hp/N/Ds538fsJWjyuJtevHeLKMP+0bwHR+Ua/eq
         I3UTFKOXrkO3RxAYBNwqkriz79N987oE8oG/TJb9eBEBs+ps+LvIR6xPDEk5Ywwpirb2
         UsmQ==
X-Gm-Message-State: AOJu0YyqbtmN9KtdVDNzYYKZgARIdv2NyyPb5f5Iq0Flla5uctRAn3QJ
	9kMduIAqFafE5dVG8FwFAmEjtLvXh22LTBPNzGdqnHPsPzYmB/6RsFSH6lw97D8Sesx1KLnxHsT
	zvl/PocYhlEIRDdwsXCSlX8jyrCwYCJO9++Di
X-Google-Smtp-Source: AGHT+IHL3jKYtpiB36FT9zRk2xFPo+tNlXHeet9ueXCXfzCYhc0JkzBEEUh5cQPb4YCMDlLGEIeG+Ly7G+ZCv6OhhNQ=
X-Received: by 2002:a05:6402:3187:b0:572:9960:c21 with SMTP id
 4fb4d7f45d1cf-572d1051bb5mr64899a12.7.1714720106759; Fri, 03 May 2024
 00:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502183436.117117-1-marex@denx.de>
In-Reply-To: <20240502183436.117117-1-marex@denx.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 May 2024 09:08:15 +0200
Message-ID: <CANn89iJvQnjSm0wCQVyX+Q3VKSEHB1c=RVr11dSLoRUMPG-BzA@mail.gmail.com>
Subject: Re: [net,PATCH v3] net: ks8851: Queue RX packets in IRQ handler
 instead of disabling BHs
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, Ronald Wahl <ronald.wahl@raritan.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 8:34=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Currently the driver uses local_bh_disable()/local_bh_enable() in its
> IRQ handler to avoid triggering net_rx_action() softirq on exit from
> netif_rx(). The net_rx_action() could trigger this driver .start_xmit
> callback, which is protected by the same lock as the IRQ handler, so
> calling the .start_xmit from netif_rx() from the IRQ handler critical
> section protected by the lock could lead to an attempt to claim the
> already claimed lock, and a hang.
>
> The local_bh_disable()/local_bh_enable() approach works only in case
> the IRQ handler is protected by a spinlock, but does not work if the
> IRQ handler is protected by mutex, i.e. this works for KS8851 with
> Parallel bus interface, but not for KS8851 with SPI bus interface.
>
> Remove the BH manipulation and instead of calling netif_rx() inside
> the IRQ handler code protected by the lock, queue all the received
> SKBs in the IRQ handler into a queue first, and once the IRQ handler
> exits the critical section protected by the lock, dequeue all the
> queued SKBs and push them all into netif_rx(). At this point, it is
> safe to trigger the net_rx_action() softirq, since the netif_rx()
> call is outside of the lock that protects the IRQ handler.
>
> Fixes: be0384bf599c ("net: ks8851: Handle softirqs at the end of IRQ thre=
ad to fix hang")
> Tested-by: Ronald Wahl <ronald.wahl@raritan.com> # KS8851 SPI
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Eric Dumazet <edumazet@google.com>

