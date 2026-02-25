Return-Path: <netdev+bounces-260998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPQyEVIMn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-260998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:50:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4EE198FDB
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D20493015853
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DA53B8BCA;
	Wed, 25 Feb 2026 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8F/n5Ab"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE0627A45C
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031032; cv=none; b=PJURIMloIPzLq7TxTwFkHL8ZCrWH2uoqkC4w8eeKV0eeWHLv4+d97jT2AsKCbXe134/kLn8yxoBvyT2RVTYNZpSvwUl9ntJ+bXVE51suWgaL4UwAW+CQ8xK4xT4KtIR75mQjmsYCLRdc/MttFPjp7y84PR+g59RYODJyZFrAL1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031032; c=relaxed/simple;
	bh=9cOn+icfMwJvWMpM83O2pGeAdt2CDV53l+nZGfUDC80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgQjy9DYcYTq/MdjtD6QMPXCZ/pST6X8TgGfoTpDyorObIZO092iKaOX8PUi/RkOnJB1+WRMgc8tqlsCzxYH9cAJFgBijfDeGuq6wSQDgUk6xuqMmuFVjPH0TeBmCk2GXxv+LjdThjNgaicbvxNTY+luKpKnqIq+l/kJC9I13AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8F/n5Ab; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4398d9a12c6so893199f8f.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 06:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772031029; x=1772635829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pReYA+QjnSS0jJEBr+XFghFAyZTC7b05jHSUp2QiLn8=;
        b=g8F/n5AbNhLpICuWZlwvCbY1wV6oulDzTSyJe6lBB/4+qIXAuJvs5Fbmo09yrWnPV+
         N/OmAVQPXRNaQs9LyqFv5e1eUryGUZd/M/OcyxALeT3L8vOlPgxGq96FafqBLBurj3QE
         Fa/WII7BRd8KX93hqWky8vCLKVCbV7PHcnLNKAP9QIWoErwS4Rvq1FSCdTC2TrMmdro9
         NS9YqZBfaETZ5MWoxJYwpimUqX1n/yG6+ts/YIYB3P1wEjTNlyeC6SqMXS3I9+B9Mb7a
         E/dPjHgRQxKvhtRYJ7dOTq7+gP2pQVSn3Z9KUjsfM/ci1F88AWVd98+ACjGCKc6MsR3N
         NY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772031029; x=1772635829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pReYA+QjnSS0jJEBr+XFghFAyZTC7b05jHSUp2QiLn8=;
        b=oC2t9gzFtInlqWyfc3G12Qgx6Ualfdy5wCVRQtQezSKjzHfCzZAYqjnp8VXzQv28Kl
         vCAZqjr0aH8UUbexpByF/947bhRLzBIP0Op4exOFsY5YGy71qEGBSgdcCJHY4qTPqwgy
         yyq80xcHavbBr9tLYV/vxU+u9If708k6p/YSpEiOZAC8QN2vNV7/uQXWmXiq+Nx9Nohv
         S8SgKjKKwfMFBt+kniVuFjwgyBJrIlKeqpURmlJ2+H4Xe6oEqSOBbR1WtiDbRHS3RQYg
         Iv3djvyxECYfcEVcxxmUDwLntmpwe/7fN+194RUmePV6kCsHIR8EZEnveoNdeMn60fOf
         eN+A==
X-Gm-Message-State: AOJu0YxpTEaXWl3LpPUsmLuHwJmDSTSJo7WpszVM10B05tGY8JVcbp0p
	cU+YZHCTw/ABuVv0QxNdxFByUWwLnQeQoUXWFBWqHtHBSWb+6rpqDnVG
X-Gm-Gg: ATEYQzzD0DhzueTQHQMaXXbsTPDMbK+8q758WXFb6ToOHR57ax64+bgF0w9t5P5V2J7
	VxSGZcH0S4vCXo/bWOjSXNFUaLh/cIITLvVXCzuVZ7NQnNUm/5p1Oda49SYuIgx2Q/tFcwbdmsw
	q1FkmAgGEq0jbdFSFoM00YDkjCP/qCKqEwqljMCP87oa4V92rIQUknAJroBMdI30r7tXrCgsgCz
	GfXD/x+d0PyP2sleqFUTDUT1lNkmWJEo3HpcSddYLQxN2BAsNnuFwBcbZ4Yvswj/h/0rZKNHltC
	pppV3xf+aSxRtuZMmYgfVIwrJPicDsqeoFVrmlogT3yVRvhr/yoIWmPVjreINx80ZHZAeQKc395
	4R0a7b6MAFWO5ML+ODs6AE6eNhz6AKDCw59HtM8gmN3GmtQ0YCIXShviaFfOlMP02qFYNW40Iav
	cOkZ2jhlplG4dsgTHmVDvxKX7Z69tIA9qi17NXnNkKkTi8dQEeJTSGEQ3bfRNuQS3LrsARTY3xL
	V4=
X-Received: by 2002:a05:6000:3105:b0:439:94ac:9d9b with SMTP id ffacd0b85a97d-43994aca6c4mr945744f8f.55.1772031028962;
        Wed, 25 Feb 2026 06:50:28 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00d95sm32981718f8f.13.2026.02.25.06.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 06:50:28 -0800 (PST)
Date: Wed, 25 Feb 2026 14:50:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Srujana Challa <schalla@marvell.com>
Cc: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <pabeni@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <ndabilpuram@marvell.com>,
 <kshankar@marvell.com>
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check
 with BUILD_BUG_ON
Message-ID: <20260225145027.29d666ac@pumpkin>
In-Reply-To: <20260224065850.962826-2-schalla@marvell.com>
References: <20260224065850.962826-1-schalla@marvell.com>
	<20260224065850.962826-2-schalla@marvell.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260998-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD4EE198FDB
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 12:28:50 +0530
Srujana Challa <schalla@marvell.com> wrote:

> Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> BUILD_BUG_ON to enforce the limit at compile time and remove the
> redundant runtime max check.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> ---
>  drivers/net/virtio_net.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index eeefe8abc122..768ad5523dfa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
>  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
>  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
>  		}
> -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> -			dev_warn(&vdev->dev,
> -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> -				 key_sz, NETDEV_RSS_KEY_LEN);
> -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> -		}
> +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);

type_max is horrid.
I did read the later discussion (but it has fallen out of my brain)
but isn't that check broken and/or backwards anyway?

I'd also question why you are using u8 for a local (I didn't find this
version of the file), it will generate worse code that [unsigned] int.

	David

>  	}
>  
>  	return 0;


