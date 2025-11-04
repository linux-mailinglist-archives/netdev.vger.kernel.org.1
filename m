Return-Path: <netdev+bounces-235379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06276C2F932
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 08:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5327A3B6762
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 07:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E28D305971;
	Tue,  4 Nov 2025 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfnX4izk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6PyCRtt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5FB30595C
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762240813; cv=none; b=W9iyUlAUWfSHI9LLw0bZd1fxDTaqz4BphWL+OBRaC8cXKbI7EXvaC/E3jWlx+CGn6lClCDhBmIhU12CpfESy9o8obuXwjGUaRPpDVD4mnUu7ooXH51wYbo5pjhF7uY+a3iY1LuSwxUZ1Q9Zmy94+vgTIMd28TZ5wMygG5ejKyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762240813; c=relaxed/simple;
	bh=v7mUg8o5d4YbnHuWnnfU7f+zdxtoURTUi+W59zuTfOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CutPmUtqF7Fhh8O37LkPyE41UPPsI0pgVKgADIJZnK0Yyu6lM6XRU7i02Of37YsOGNnwyX8dvkaJgU3+Th2azq1CRIUss0Niq1UeKyrndhcWEvJg1GprTpLNvblab/HCT4Teb1OjM4BZVgrMqNIOzx/o/NV6d7E7YWgYV6+9TmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfnX4izk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6PyCRtt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762240810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73YCUBj4jfpBlE2x+0rguaM2jWl3OFSkZTRKpIlgxow=;
	b=DfnX4izk23fzRgiV+dhemWzTSYr5UBTRGGlI6/a2mRTbuLibd32mngw4VLM5aIgbngsteb
	yHBcrbzmql4mHjjrw1bPa6m4faHZfyyOmrB83DyMVrRpTCcA1qiIjBYdOOJNgw0mE7sWJm
	UB72yHnkEUVAtvvD1Vws0jcK4Vz8SN0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-Ma6Ta67cMDKEI9FlJ6izGQ-1; Tue, 04 Nov 2025 02:20:09 -0500
X-MC-Unique: Ma6Ta67cMDKEI9FlJ6izGQ-1
X-Mimecast-MFC-AGG-ID: Ma6Ta67cMDKEI9FlJ6izGQ_1762240808
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c61b0ef7so1341163f8f.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 23:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762240808; x=1762845608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=73YCUBj4jfpBlE2x+0rguaM2jWl3OFSkZTRKpIlgxow=;
        b=e6PyCRtt5C1VhvTRVBO6Q/prkVQjdng5byQzZCuypWBH9gquG6+bbsOFgYqBLXo9vA
         OiJh70i7tHKng9ZGoYEvbXYbOTYjMTJIL+A7u+tupzn6pk22c6pDAtFRH5pvIUd/QOTK
         4kyMsWX0KsCP0P8ntOKAH/uDXlyU6LofFa2aJ/mew7twHAhg/f++hgdY7aMjsqtvWjN0
         3dcSHJoPfrv47WsrQiSxRz7Gtiw/jAVc1i3Y+MxnI7d++V/xkIUBn2UG0Xm1FzXOfQne
         Q+2+qKEoYeWRFGzwOEEEU99zUA9pzQm/iRplrYqqkpIOBk1pjK1Lv1YjVaGA/rk24AY6
         BnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762240808; x=1762845608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73YCUBj4jfpBlE2x+0rguaM2jWl3OFSkZTRKpIlgxow=;
        b=xHqkIVrYTlyP7c9z/0qbk7sEKEULgc96Dv8EPQP5EM/R0XhodKzfw8FcQe1KP/e69j
         +jM+FyQIG1llXVHA/w1uoUlLxLLG4Rjz6hl1hAcCQD+1GcVRKlWvUqrV2NjsvfWZi+8W
         6gHmjCl9lXPgu2Yt7fGFczEXzVi7UwdVyNm6g7+L3cEQvXfcD9lRdLnm+75Py2hY+WH5
         gSAoffH0BNEKF3QQncrmzmZqfVuxEuGN++AVWqNWL6DXMBoShcbseuz4P/fwjmVzg7nK
         LDjka0lm7o8u85YeBUJLjb/Pl3fkwpAIMf1+FyvBorBUMx0YojfgwvrxS2jV54I3oWvT
         wwVw==
X-Forwarded-Encrypted: i=1; AJvYcCUzvj8I439koK6UmV7IKhkmaKvajNlDgG7eZRaAr13Z4S/3hWlvD2jl1cOIF4EILYvNPKYFOcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Nl2IA/VC4Ygy02atPeq4vC6mCLq8kovivanPZZhL3vyw3cIA
	Piz6KL9PN9xjS3BlN/bq9g4/4PsuQEjqCbXnloxXj51735/CVdRARjotwOoo0UJc4F/4mTjrymB
	cZZVUYDLIZN3lYKSjUZnt7wVhaCMfEkdBBzPG5Ca0gjg7LwqD7FDC/SN0ng==
X-Gm-Gg: ASbGncvtomvKahvhW43vHCj11mhLC/DfsnABw0mgub1rNg7qH2kkg5xLM9nMyKRsdKA
	iSTscDrWIkrJASs6bEhD8So3cn23ROBCF/0Pf8WwsBSEuclTopIYrEWZ8gEHExXk11VfKmiEHeW
	NUEa4SiAJOvQsL4SrHcQLW1C5h15NbRCW/pZxaml6mMp+zcqxS70JUYKefxfDrFedHphSOm7Ec7
	nNFbHNFtMzd9mU8D03g0iJvwaUYZt4AOsKsFwIdzbvZ1MhSYnQbIcIcrjCXqI/A+j09CAW0o3ax
	J7A4/o7j61auJ69/qMgBs/I6SSp6nYOW+y6fo461xhienf6k1I1MtpFEED+ZheU=
X-Received: by 2002:a5d:5888:0:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-429bd676a88mr13671419f8f.10.1762240807873;
        Mon, 03 Nov 2025 23:20:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9No17j+8sKvTu81QHfZyLpwKipzhcNFRu6WF9IdUgkLA/8mjSFSLTp3MyIpE+dprvQRAAig==
X-Received: by 2002:a5d:5888:0:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-429bd676a88mr13671379f8f.10.1762240807302;
        Mon, 03 Nov 2025 23:20:07 -0800 (PST)
Received: from redhat.com ([31.187.78.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fbeadsm2857277f8f.37.2025.11.03.23.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:20:06 -0800 (PST)
Date: Tue, 4 Nov 2025 02:20:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Fix a typo error in virtio_net
Message-ID: <20251104021953-mutt-send-email-mst@kernel.org>
References: <20251103074305.4727-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103074305.4727-1-chuguangqing@inspur.com>

On Mon, Nov 03, 2025 at 03:43:05PM +0800, Chu Guangqing wrote:
> Fix the spelling error of "separate".
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---

Acked-by: Michael S. Tsirkin <mst@redhat.com>

>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..1e6f5e650f11 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3760,7 +3760,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	 * (2) no user configuration.
>  	 *
>  	 * During rss command processing, device updates queue_pairs using rss.max_tx_vq. That is,
> -	 * the device updates queue_pairs together with rss, so we can skip the sperate queue_pairs
> +	 * the device updates queue_pairs together with rss, so we can skip the separate queue_pairs
>  	 * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
>  	 */
>  	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
> -- 
> 2.43.7


