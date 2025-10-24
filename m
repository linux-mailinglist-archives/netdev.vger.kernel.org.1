Return-Path: <netdev+bounces-232556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17400C068BA
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A803B52F0
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3938D31D36B;
	Fri, 24 Oct 2025 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVRytX6l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954E8255F31
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313170; cv=none; b=qJybVhjxaoiZiSI0OlbSq5g6jMhQ9cSlYYSr8ciu7tg0kx9v2RBu+xJbY5uJgB5KsrzUz3olWscUkwO+gJqtpfbk8EO3bUVrboV34W1vn1X4NLrMphI0uXsKjEcxAAPFD+YL/jpgPGdTyJGNo4CXJy3e9CCBIoiOrnyGxKVm5pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313170; c=relaxed/simple;
	bh=0a2kqt6iVxlZdKDlZmDEyPfN7lXlndVaRP9a7YHS/HI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mCDt8LLkOOOPvPvSupLWsOqzYMB1jtXLgjPNERBc2FApsHdjQsP7g0z1cS8cSB25bKxcbi5XvsaGYK0oC+TXQkQs4MdfdMW77i0E3U6hbihkSS6OdVmzSlQnnrbYuhENWonNeQS/LPB9h6vmCeusmgYHcxpdyAg2t8/+/e8TBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVRytX6l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761313167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fG1DHSPbDkPo2/41ZMex3EtNSlx98sY6rv/jsEJLq4g=;
	b=OVRytX6lHH6GTDXQFkcWn68qjy3z+YMvHdunCXP/kOz5Y9Dy6xLtJas6uGxwHYjAS4krhx
	MGKhWaL1RFT/lfXN4h0J+HChLTnSWbOA+amNaCB57Ypdh1iVwXxR5uA4Xoljs5l5qN5cTD
	UrFnqRIgDWrJPX/2B9GT22nZBhLlkjA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-Vdxt0q63PmuWoobL4KF_Fw-1; Fri, 24 Oct 2025 09:39:25 -0400
X-MC-Unique: Vdxt0q63PmuWoobL4KF_Fw-1
X-Mimecast-MFC-AGG-ID: Vdxt0q63PmuWoobL4KF_Fw_1761313161
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b479e43ad46so151105966b.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 06:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761313161; x=1761917961;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fG1DHSPbDkPo2/41ZMex3EtNSlx98sY6rv/jsEJLq4g=;
        b=pBCtZrfX8hGIPR4l+hu/OpDYoStpxrsTMVdyG4SY1s1Zi4UlNYbQcqU9ct8V3IKGTj
         FGC9Ezo5gb+6k53+5lRHMkimyBPR4uCi48dSWWk3OrdvWFORtRxiSl5FGVVFj0p/t5r4
         ETvEkkgrcj26USLkz/Rr8QYw6pAeVpsl8venLxgJFzHe4I8vbz54Wl2yWnyg0XlvN7Nb
         f/m42Ohz0oBOVO5gdCicGUS1atBrE2UucfARXuiJon9ufhfhwHwWNQnKZe+70T+EsIdH
         sWajGfhZM+ORvAvZc1zulnlfasIPR2DkHkn4cwcUrortNRge0L8gKJEiYAwCNr6lKKuQ
         l/KA==
X-Forwarded-Encrypted: i=1; AJvYcCXLY8CE4uyWMK+2oFXZMGn6eeOQlDdMR+xrIfGe2ZlYkws7irrcz/BT/rdjD2x95HgNqiyP84g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuHcAdnFck6QLN+URWw6Hh9hVauUBX4hiYPSnE86hNoIO8AXMg
	AWi+6TbJngfeWNejfyr2LqbAIfMcR9QNAkfUaUuO4DkZVwCIhAjDsMYyOIzgzJZWBi/ywsBzIA0
	YLQsvJCgrnKzfmXeJUM/n+Bca4pLsialXxYbQNHVfpzBHll6lp4R93dxpag==
X-Gm-Gg: ASbGncuJLErC5LniQ9X/IT1Mo+rvYW9HO+owFx80VtCJGbFUBM3yG+TdbK/aAaWUwxp
	KLfwR9MNs+BJA8ycZRcLIVzffWORSMWtVe1wKx4r3cUlXbRc1w+kc/fhhjDR/iM1yb3p9QHGXxi
	3mdx4XUSCNpaWHY3xIwPxtE9HFTro1yNaYFeVOCgQLY046Qz2AxThW6MV17q4kQgNeNfv9emhKX
	Ee3JtENyqjCbrOALCeUfJhnvbhLVzRXEUtEGrkPAXHB1PvKJRY1U55jVbwe/IPp2f3QWqLfnO4X
	MwdL4JNipHW/m5pvvKKWcITCa4Yr1v6SJ+TagPUCdM/vVJNGqU2UmFI310MgjxpEClUe18nSQoL
	tK/nOTbzedYHe3ghPy+6uWsRUEw==
X-Received: by 2002:a17:907:3e90:b0:b3f:ccac:af47 with SMTP id a640c23a62f3a-b6d6ffa8aedmr262717666b.31.1761313159946;
        Fri, 24 Oct 2025 06:39:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1Mowrct2anncqbgqXnkT9wHJ5bHC9THXx7DoXugw/+p5rNYtBxKqachux7PP31bYCorHybA==
X-Received: by 2002:a17:907:3e90:b0:b3f:ccac:af47 with SMTP id a640c23a62f3a-b6d6ffa8aedmr262714066b.31.1761313159376;
        Fri, 24 Oct 2025 06:39:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d514172besm534099066b.46.2025.10.24.06.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 06:39:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6ECCE2EA565; Fri, 24 Oct 2025 15:39:16 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 makita.toshiaki@lab.ntt.co.jp
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 ihor.solodrai@linux.dev, toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net V1 1/3] veth: enable dev_watchdog for detecting
 stalled TXQs
In-Reply-To: <176123157173.2281302.7040578942230212638.stgit@firesoul>
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
 <176123157173.2281302.7040578942230212638.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 24 Oct 2025 15:39:16 +0200
Message-ID: <877bwkfmgr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> The changes introduced in commit dc82a33297fc ("veth: apply qdisc
> backpressure on full ptr_ring to reduce TX drops") have been found to cause
> a race condition in production environments.
>
> Under specific circumstances, observed exclusively on ARM64 (aarch64)
> systems with Ampere Altra Max CPUs, a transmit queue (TXQ) can become
> permanently stalled. This happens when the race condition leads to the TXQ
> entering the QUEUE_STATE_DRV_XOFF state without a corresponding queue wake-up,
> preventing the attached qdisc from dequeueing packets and causing the
> network link to halt.
>
> As a first step towards resolving this issue, this patch introduces a
> failsafe mechanism. It enables the net device watchdog by setting a timeout
> value and implements the .ndo_tx_timeout callback.
>
> If a TXQ stalls, the watchdog will trigger the veth_tx_timeout() function,
> which logs a warning and calls netif_tx_wake_queue() to unstall the queue
> and allow traffic to resume.
>
> The log message will look like this:
>
>  veth42: NETDEV WATCHDOG: CPU: 34: transmit queue 0 timed out 5393 ms
>  veth42: veth backpressure stalled(n:1) TXQ(0) re-enable
>
> This provides a necessary recovery mechanism while the underlying race
> condition is investigated further. Subsequent patches will address the root
> cause and add more robust state handling in ndo_open/ndo_stop.
>
> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  drivers/net/veth.c |   16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index a3046142cb8e..7b1a9805b270 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -959,8 +959,10 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  	rq->stats.vs.xdp_packets += done;
>  	u64_stats_update_end(&rq->stats.syncp);
>  
> -	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq)))
> +	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq))) {
> +		txq_trans_cond_update(peer_txq);
>  		netif_tx_wake_queue(peer_txq);
> +	}

Hmm, seems a bit weird that this call to txq_trans_cond_update() is only
in veth_xdp_recv(). Shouldn't there (also?) be one in veth_xmit()?

-Toke


