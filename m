Return-Path: <netdev+bounces-289102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHaSGTowC2plEQUAu9opvQ
	(envelope-from <netdev+bounces-289102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:28:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 079EE56FF3D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F44E3059A75
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063063793DF;
	Mon, 18 May 2026 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwaTKkA5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E971B275B1A
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117957; cv=none; b=IT3eHgA7cVC+LuqxwX378hmSxsbpVMJqa9nHOkxQ5YPUURr6ZNiMK50NNGs8z06VkMArDheLm1RbHRHD+EQk8RUxajP7TVkNN5I5SJXKgSVQPwGyLi/UJULCLxCvPFtJ5tJPp3AfK2swNyf+k/X2HmJmN68cYFXuU6sd7EQdsY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117957; c=relaxed/simple;
	bh=CD/xOi+hOcIPjr+saxVI036C8iZNK7iKuvD4q/eLfYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDdBf/L4sywx1Vo4/oLi08bSgrf3uABd7OMo7DfsBADlgLtbgjhVA6qHTEVQ71fOV8pyPvom9wbcDU+3+/LgP5h9AcZVrgHWr8bZmlbb37dDvd13vlvnyN1U3v7bFu/sapML3zEGmriWPNffUGoEqOlVbCLYjW0XxwEWiF/WzpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwaTKkA5; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7c58e6eb2c8so17690187b3.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779117955; x=1779722755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bj+KewWFQLB4l2VEmceKCACQWaYnSld3fnpus3EQoQg=;
        b=EwaTKkA5rRtrW7OpHaVz7gz5OdDcQseGwlIbJPyCUPLA+uDvSQmERHx9gZPT5Az9Jp
         /WkIEyKItrqZ54kKS97L1HiV+MN/7X4KeN9H1LtImJmrunrjO91f1ZECHTAyPUTzV4BE
         XfdxPiudnBqrDiONp3U65OW5H6pjdYfsEXSHDkgU5sM1Ym3Sx2gxTRtSWlGrVfyzd2q7
         CxVacEtLz7TjC2hYkxdw3P2jNyZoaNr4dCOdjArbV0uU8rBAtIj6hrz/hvUWJfzVbjcl
         UwvGF0azFBPqViUHkAV5gc894Fa9xgeqNDB9PUv9dT1fNMEJeDyOQ+txe0yK7v2gx0a3
         H/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117955; x=1779722755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bj+KewWFQLB4l2VEmceKCACQWaYnSld3fnpus3EQoQg=;
        b=HQa2OHpfW1oTHv0RC2t25kqm61TFIXEeDPztyNh1SW/OGZHOQISPQwlA06lrvl2qP0
         yhXQoMhSA1bD+Pp3hInHoC88HcCUu/gX2TqTPHdhrmzzoATcnnRCRdmcgJZ/P/lycuO8
         AQ+LlLND55yYnsFl72MVQBllpwS7JIym7KhsSjLNXqzC5Z72QqlILH4viu70Bp/fUL56
         nIM2Q9Kb5hnWHMPO8tSuP9zWJt0DmHHFGebHN80YoT88gRQkqbYxLCpstUBFmMboY9/y
         1jA1R/AOIyzkrEjCP8rQQdVsIPLCgKzwsXnGF2t2vkJx/82nCOkceIXOhv+uLPapmP5v
         JaqQ==
X-Gm-Message-State: AOJu0YzZ4Vqv7/AObyJeO9RLOVdVt4WwleO7ppARJMV68/NU6waG3qHv
	95VZZhgLUjjNsLJiWrkYdfqcjKVLKCq+m4OXgh3YmiQQH8TE7XSGPxN1
X-Gm-Gg: Acq92OEQN15SEum02ClZCCzGUoacGpotJ4TI6ZVkMan1KyHWkOr7hPgLBlpYjLApdmO
	TRwt+tTCMJWvi2ZZ5Ax7v2lWl5DlO4x4rfhpxCnv8YMQwQkHkR83UonjzeyY8kthaOOsQ7dE4W3
	Ze9oHCVlyissMOrcsbjnajZEzXdiZ68HI5E0Hemzp59L467k44qmGrjVPKfL1Yn0Mv/Rq4wFXCZ
	rNAhJ8mDUT+IaCfm9x8PL713KUjTIpuSBt+bZXFzVJSMjFH5+2YgIU6A8q8gmq2gFzOjp9D4CHt
	DtaYCabFNmPSO5PuAO3mcJGxA4jiLPMwXGhOWWXqNuYC6POIvuJKnunOgRTTLqOWTxhglq+UsU8
	uH5GOe4H+/o/poRFfsby1M4lofuXM5yhd/Ecqm339ZSDRPzatZCcrKmFB59u3XnH4zP9XHefnas
	2rp1t3eSRU7I+QePWO8MuGc7yuqYk=
X-Received: by 2002:a05:690c:e3ce:b0:7bd:d4f4:261e with SMTP id 00721157ae682-7c95b33f043mr158034857b3.31.1779117954983;
        Mon, 18 May 2026 08:25:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cd0bfdc094sm18551377b3.32.2026.05.18.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:25:54 -0700 (PDT)
Date: Mon, 18 May 2026 08:25:53 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: reject TX dma-buf with non-page-aligned
 size or SG length
Message-ID: <agsu4MoBYWPFEmpZ@devvm7509.cco0.facebook.com>
References: <20260517201814.222563-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260517201814.222563-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289102-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 079EE56FF3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/17, David Carlier wrote:
> The TX dma-buf bind assumes dmabuf->size and every sg_dma_len() are
> PAGE_SIZE multiples: tx_vec is sized dmabuf->size / PAGE_SIZE and
> indexed by virt_addr / PAGE_SIZE, with only a virt_addr < dmabuf->size
> bound check. A non-page-aligned size lets sendmsg() reach the tail
> region past the last populated slot and read one past tx_vec[]. A
> non-page-aligned, non-final SG entry causes the same OOB indirectly
> by desyncing later slots.

[..]

> Reject both up front. Real exporters (udmabuf, dma-buf heaps, GPU
> drivers) already page-align, so this only refuses layouts the TX path
> can't back correctly.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

If the real exported already export page-aligned, why does it need
to go into net/stable?

> ---
>  net/core/devmem.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 468344739db2..e72f48ff9094 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -193,6 +193,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  	struct dma_buf *dmabuf;
>  	unsigned int sg_idx, i;
>  	unsigned long virtual;
> +	bool todevice;
>  	int err;
>  
>  	if (!dma_dev) {
> @@ -240,7 +241,14 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  		goto err_detach;
>  	}
>  
> -	if (direction == DMA_TO_DEVICE) {
> +	todevice = direction == DMA_TO_DEVICE;

If you're being defensive here with "real exporters already page-align",
why not do this check on both rx and tx? Why single out tx side?

