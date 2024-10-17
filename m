Return-Path: <netdev+bounces-136637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286679A2825
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD501C20F47
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BF51DEFD9;
	Thu, 17 Oct 2024 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpDGxdFa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF41DED7F
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181491; cv=none; b=ObxaeGtXv8R11d70/E73CfTF/5nxymX6HxFtysD0oBoPyaZAuTY/j1Wnj6yEPtWaipwuN+SSMKHh3EJAf62s2GDh3WlCyBw8j1zbz1P0eOICEjJdHajxVwcGolYrZ2DAf0YSAECHKBN0PVaLM+rq4Ce/ZXpDJdgpVSddY2oQFBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181491; c=relaxed/simple;
	bh=0pBm7rQzaMPTigngJ+hwgHXrPycZtgfrvv64BY5evx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W1sIeu5BeoH3ImRMb8+XNlbVGVio+j80pjSoiaDekEVKVJorFSnAEdZyi0ouQQ09zZy8xw+ZuFW+H1DokZlSxIKfPsCtqISNiUrfDYgfjY5uxKv8zkCMKbRcRom5sFq0cgWPWrccu/RBjCWnN2GWrh8PNxMeLvNGxxw+KGU59gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZpDGxdFa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729181489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4Uhe04F+CB5X/0gvS9yaWb5vSmMB1SmOWJ+vfRDeUU=;
	b=ZpDGxdFavk12W8x0VLpP0c8VmGxZDvp0NxnvQLVmZQRpeDwq2WRi9GKCgnpZ+/hmLMk6wa
	4h+GENuJdH/qJEkRTRTLCuMJbCVssUrIU5CGxkV9UelqGipfiEcKCr78u2hh7IxrD9qbtv
	JclxJ9hX6Bz9uMwnZ9DLbtNm7odOxkw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-QR1sx1UcOEiIqvh1IgkJ4Q-1; Thu, 17 Oct 2024 12:11:26 -0400
X-MC-Unique: QR1sx1UcOEiIqvh1IgkJ4Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315cefda02so4708105e9.0
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 09:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181485; x=1729786285;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4Uhe04F+CB5X/0gvS9yaWb5vSmMB1SmOWJ+vfRDeUU=;
        b=lXCKXvB8/JU1sjErD6DS/v3zwc/9pHuNyThD2Ntfw/J1cBTyCiNOhx7UpG67W9aSES
         JAPPNItcGMghcCtPrOE3fdQCPfL4sfabIiBRMfAo4BjdWMXXoahCZ6kSMZhg4FkmXbyi
         Tti//kqR48Wn0QPmb/8qQ07IpCV0nq+DqV2GyxCiY41skbE5WpQJpuYsv9ZQ2ESB5nUV
         cK2xgZqlK3+5IUY6YeqltQm2Wo0KXLHIKkFi6hL0/1Jstu55RNvbX9eRkjk/6Cc0oM1W
         5MsXIakqdV17wrVTQVJ29+V29/3utIHb6dcCkYCYcNSc+mH8z1Oc4iFm1L8OSQfyRhA8
         lJtA==
X-Gm-Message-State: AOJu0YzhzebBwugUXzk++NJVEAYSVgLTK3KNAcCjsWXh/tQVnjb42jVy
	2l2SeVHE/RPcisqBa+zzcv5rjQLXrNye3Epru3Xure27VA22TSig0jKlEriDzhSfjCTtAURwykL
	Y/Cj70Jy2v0pPEe8HmH4tThAfnDaE/fKBfcjsG24TR19V+VWwtQ/pAg==
X-Received: by 2002:a05:600c:470e:b0:42c:acb0:dda5 with SMTP id 5b1f17b1804b1-4311dea3c39mr211368555e9.1.1729181484885;
        Thu, 17 Oct 2024 09:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV+j0Ro2owMfOqgHJXavkMpOiVpms1ot72juIouD+L7tJoeldzwxRfIqxiee0Yjvbfxl7/qg==
X-Received: by 2002:a05:600c:470e:b0:42c:acb0:dda5 with SMTP id 5b1f17b1804b1-4311dea3c39mr211368255e9.1.1729181484338;
        Thu, 17 Oct 2024 09:11:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c3dfe5sm30953895e9.22.2024.10.17.09.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:11:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E6599160AB6C; Thu, 17 Oct 2024 18:11:22 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH net] net: fix races in
 netdev_tx_sent_queue()/dev_watchdog()
In-Reply-To: <20241015194118.3951657-1-edumazet@google.com>
References: <20241015194118.3951657-1-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 17 Oct 2024 18:11:22 +0200
Message-ID: <87y12myaj9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> Some workloads hit the infamous dev_watchdog() message:
>
> "NETDEV WATCHDOG: eth0 (xxxx): transmit queue XX timed out"
>
> It seems possible to hit this even for perfectly normal
> BQL enabled drivers:
>
> 1) Assume a TX queue was idle for more than dev->watchdog_timeo
>    (5 seconds unless changed by the driver)
>
> 2) Assume a big packet is sent, exceeding current BQL limit.
>
> 3) Driver ndo_start_xmit() puts the packet in TX ring,
>    and netdev_tx_sent_queue() is called.
>
> 4) QUEUE_STATE_STACK_XOFF could be set from netdev_tx_sent_queue()
>    before txq->trans_start has been written.
>
> 5) txq->trans_start is written later, from netdev_start_xmit()
>
>     if (rc =3D=3D NETDEV_TX_OK)
>           txq_trans_update(txq)
>
> dev_watchdog() running on another cpu could read the old
> txq->trans_start, and then see QUEUE_STATE_STACK_XOFF, because 5)
> did not happen yet.
>
> To solve the issue, write txq->trans_start right before one XOFF bit
> is set :
>
> - _QUEUE_STATE_DRV_XOFF from netif_tx_stop_queue()
> - __QUEUE_STATE_STACK_XOFF from netdev_tx_sent_queue()
>
> From dev_watchdog(), we have to read txq->state before txq->trans_start.
>
> Add memory barriers to enforce correct ordering.
>
> In the future, we could avoid writing over txq->trans_start for normal
> operations, and rename this field to txq->xoff_start_time.
>
> Fixes: bec251bc8b6a ("net: no longer stop all TX queues in dev_watchdog()=
")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


