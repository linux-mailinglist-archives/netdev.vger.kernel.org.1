Return-Path: <netdev+bounces-250942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE4D39C19
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E59633001824
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 01:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACC91DF723;
	Mon, 19 Jan 2026 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoUDXfYd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548D6BB5B
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787140; cv=none; b=nh+5AUFIoqsy2B4XK3cYMtX2gHEexfzDRKHK7GEbQecF82e2kwXpSiweQ+k3zmpMkeHLFIF4T/G3BmM1Mir3xIRCheIHrwidAfWbcHxCMRA5as/UGqKSQHgjro+GWXF1/ONbwQYnMrit6Wj7pzvxSaOKDPOY6SU84jYtAeBj4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787140; c=relaxed/simple;
	bh=7ZLTOzeksxEPo2l2v3dDm/2Abty3Gbxin0k2GNGZEeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ififUlyV3U8hpFJECVmDceXvgdgxcrI3sc2prwwmKkuoznrOiHAxmyKRAmP76sQmQw96jsRyNXWzbgELFUy9TNj8AFv0RX+BWhTvRRqqnD5Xnjm5Vi9bkIdu9Op4OyJP8lDP+eDF8anaNuRt2Hrws+vjLbBLXaH7Y2wFAe4hAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoUDXfYd; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b04fcfc0daso4462392eec.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787138; x=1769391938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLNuYLeQh7kmecjdwrL3iJaysp/c6/WIw7e3NiVC8xs=;
        b=IoUDXfYdAJ24BvCs+j7zrAr0cYnUFJGwKihgNt1fuPQHpykI3AfeY5GUVxf8IaagRI
         eK1m2h7HYdeTZ7JCxpzy5cmEctL+Th1gRTP78I1seUivIwQbTG3ElndybC45NYtc+Whi
         +uqXP6zfjqaNl/M0e49u36zXU4OKWAVl0BOUyuzoiwaUg0vH6a8quEnHdujyxhIdRYKq
         ci0eu2dpw0AM/bdEPq9w7WfdBgQEBI1pJnbpDTOQokbpXryKqhqsOMWhhOmPk2gtCNOr
         p11Kzvx6gX1wvDC2PF53Kpum9KRv7lHFukRiZh+Lz8rRlqxWDAPKe4Mt6Rw9u6Rrk0HB
         qkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787138; x=1769391938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLNuYLeQh7kmecjdwrL3iJaysp/c6/WIw7e3NiVC8xs=;
        b=YkrG/rf2z8qm1Gmdl7dHCdyS3/oHZd4J8d48tDVompOvJPL+2gX0s3UsRfnCiBzxbT
         ZMjYoJihWqCiDjKXxNiSnOzuXdhMOiNpkK9GyJinUtjhgUtno8oTLEMZYcXLDZfh036n
         a/p538ZFdI61VmrN9ahqFny3pXAvhQJBMWHgWz8NWbuaxKtZYTN4+hm6lOARzSfhFssG
         UxPArswU5N3HAht/r3NwYU/IinR+HkmK2ZTcyngkd235LQL6Tm/c9Eq21XzjqaKHJgxE
         x4dIH3k/VsrkhDVp17R0sbhKXwGJMV4djFCGnxDVQnHZ10qP1QUIlLVtbkZmBnuGI0wp
         BUFg==
X-Gm-Message-State: AOJu0YytfNheZeLW2Xz8tXLJPTAgi6irboPEwPq/wX/a/nmGHBvzk7te
	gSWPxq+cXskJfmwGlLuSSvJJPBbQH059ttaoVCCyv9rX5WXiltIktqc=
X-Gm-Gg: AY/fxX7XN62Xh7r12tEYwUVsNSyMt+h4gBjaNKbhpcVLbwHdvQY3CHC3gj2ZlXP1tYH
	+lJUIAkUcXpnRWWjJiaLlUxcmL50vXH9x/isQH3TEr0QcQ3YQMJdaMiyXvwR+BdTf6pGiYKo98k
	vcBHS6/FvkcTMDdeEn3LuOdZHfH7Q4gitr3TuZqikQtCJAQe7fCDo7CZpFRTxgNL6Q+ORW1ydbf
	r7NYOb4ayPLmhwsa4btEamu2j5a2J6xfVC3WUtXh5K2EnbidEWbjtLnt0109ZZSZiEgaO+8/vpe
	ZStMYr4DMu15NztdzEVGKIM3FkXdVEpFWyFHD44l86Z2Iwd9zrDOtO4FeKY3xg0W/N1ZjtO8Dj/
	96mTf7AHFBeFqx1S2KYtU6GQxOL7yFwW9mGKONW/Tdt5hJtX5YCyrTQMX9euO+5ZTsg2F7Nq9S5
	0Ikmnc/PM6k2Qs3PjouJh+9teK6qGmHed6UFSr799Fb6reKvtkdbPndieqLBdMEOXMyAoFuMk6m
	8xGbg==
X-Received: by 2002:a05:7022:b98:b0:11a:273c:dd98 with SMTP id a92af1059eb24-1244a724cacmr7685802c88.20.1768787137840;
        Sun, 18 Jan 2026 17:45:37 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefa7c5sm14340229c88.10.2026.01.18.17.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:45:37 -0800 (PST)
Date: Sun, 18 Jan 2026 17:45:36 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 08/16] xsk: Proxy pool management for leased
 queues
Message-ID: <aW2MwPYcBosCvdg6@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-9-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-9-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> Similarly to the net_mp_{open,close}_rxq handling for leased queues, proxy
> the xsk_{reg,clear}_pool_at_qid via netif_get_rx_queue_lease_locked such
> that in case a virtual netdev picked a leased rxq, the request gets through
> to the real rxq in the physical netdev. The proxying is only relevant for
> queue_id < dev->real_num_rx_queues since right now its only supported for
> rxqs.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

