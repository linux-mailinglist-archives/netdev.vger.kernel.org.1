Return-Path: <netdev+bounces-136205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DEC9A105F
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C5A280C69
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1DC20F5D8;
	Wed, 16 Oct 2024 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpeJ0y4Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045D720E03C
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098677; cv=none; b=aHYGuQBHmHFXP4+0XJkPmFQVQfFeY4BgzAUKKl5yy19g8SFYmfXLOAcX2oCG00aeHQfm+6aFiMCTFjktYCzdhRySnC071HFQUWTMjeSpbUWfI/fqAfKbJc+TanwjXBWbTPwX7ecsVhR/THFDrFXmBDmdCrJt9JFnparTBIra6/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098677; c=relaxed/simple;
	bh=GSmwtgIGd2AQod4ZEe/if66I+p1+s7zg/X9x4fhDg18=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ky0808yp5uyZ/5yUmFuqFCozNiFZipdeyAeHDg0gvWwnWxhrIEVLrR/aymrthUhPj1C9nuHykgsPocVDKaa6ePPjG/OIDneLCC//HQjYAxWlR/oHPiKr6TKaVx4pMVuxW7mCqiMIu6P7nEIoGXWQ+e0fk2aPVOjjGKBJWTDElng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpeJ0y4Y; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460464090d5so540331cf.2
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729098675; x=1729703475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IDTGl7ID+OS970QPQhf7kT5Iyj/qpFDJxQuA6nUc7k=;
        b=jpeJ0y4Y6uswCYQeDWY5DRCK8wLndwfbjhBISZ4a1zpDgsY+Wwxh0ZtoNyxi88zw8J
         OXxsahVNYMvChTuLxxQECLw7lTSh22OLlE4Ksp5U7cRpbBJfG+Xy27hUp64YgF+lsyH3
         uGk4b8Hts1acpP20TAXWJq6QGvFw9Mt4J9zptStS7uPDG28qcmkmlcgF25sbgLnCcKuc
         sCM2Xflhbp21B9ryr/fJHhvRDtwFgpoLw+of+lHq0NfCO/eWAY47P2Ccsxq8wQNcPcYA
         z2mltEDPeAxLblrCMYJDuIMw0nGxSGiK0qScGwIwKO8yvB8ImeC3ws/YTx3z90qDVaPG
         HXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729098675; x=1729703475;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7IDTGl7ID+OS970QPQhf7kT5Iyj/qpFDJxQuA6nUc7k=;
        b=WqLUmRCXqaS3yvHpwTKX2+Q2Ul3LKHIFU3k2ZhkM01ch4MNf8jAnjrYmWGrM9Z/7Ed
         yYDQzY3PhT5EhOInQf5jX23Jz5/PNyPqQr0Mm3WmIKNP5SI8ML+Y/3incbCt8miYRoCL
         EI3bQzxM0h0tUTM4LCCKCBb7C4YJGYKWkLsKdRI4wNbeTdudILjn99A1+h3R1qL/qK1m
         QA1X9/0WH/iEFpCMuapLUO4zfRncY4BihxNVoTSzgYF73jjqVd0cJgCggk3e5KrzoTUd
         rjo2cCNgXTZiDW4Q5jLVntg/+hO7YxG/4Uzn/rq4CNnNPts/u9s1HMWlO4IxlAzjFZIA
         ygSw==
X-Gm-Message-State: AOJu0YzPwHj+Qaima/XFQyJRfIUDz+1q6xg42bZp/+9Om+LCkGItqkgT
	YIP9A0A4BA7TtdAePrdu4dzR94y//fyNAOU0+o4aWBDRMpdtJtsV
X-Google-Smtp-Source: AGHT+IEkR4gdtGrOmZ/q3qXC8Gx4N5DqdYOFpHNmgK7B7S0R2fbQiIy3N4aJRFNgknvOpGvZ+ATlow==
X-Received: by 2002:a05:622a:518e:b0:460:8360:bf2f with SMTP id d75a77b69052e-4608a68a345mr78795351cf.40.1729098674715;
        Wed, 16 Oct 2024 10:11:14 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4608b95b8a1sm12515441cf.77.2024.10.16.10.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 10:11:13 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:11:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <670ff3b19b7f4_34b350294fc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241015194118.3951657-1-edumazet@google.com>
References: <20241015194118.3951657-1-edumazet@google.com>
Subject: Re: [PATCH net] net: fix races in
 netdev_tx_sent_queue()/dev_watchdog()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
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
>     if (rc == NETDEV_TX_OK)
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
> Fixes: bec251bc8b6a ("net: no longer stop all TX queues in dev_watchdog()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

