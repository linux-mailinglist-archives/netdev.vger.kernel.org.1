Return-Path: <netdev+bounces-145110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE03A9CD4B8
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBC1B242D0
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32FF38DC0;
	Fri, 15 Nov 2024 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="B7R47H+c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301182C697
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 00:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731631326; cv=none; b=kc1FgFzngRReBD1cJF9uV0sY9KGrB9gohVQPik/4W/3Zqpb4kCbMjgh5pevjP7JEsEjosdKhvKydqYFZhutzGsUFpeSTMrtBdAdzxsucxpOtCcrmQ80CWBc2IeTOsw0lYpdXZqPOzXS54lOfragW345kMQZ7oNmNd6BqZ5mD7Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731631326; c=relaxed/simple;
	bh=wNWjS1w+AL5XBvjuZ2qv8OYKCN44FLliVjmUsq8W9SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7cpAx/sXkFnGXWIRRiJi+Fu2wVPFkAY3rHiW/0TppvS96n/iDM4jvmq8cOr52WNAwOvs8RvJQRe6T5AVeaIy0qukP/ESzt7GQlOqxdFftvJbbotyI52vOd7AftLWzxs85lbT0zCCOk+w9EWaUM1d9DP17J9QWJaZ8+4kepBcog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=B7R47H+c; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c9978a221so14282555ad.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 16:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1731631324; x=1732236124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHYyJiPL1uVix6sXcBSVhUMJXzftDKX8AxtiCADtdRg=;
        b=B7R47H+cM70KKWYzHJv1k8LqmufpNEVHnWAbSATUQ5qjM6NiuU2ofnsOnh75zByWeU
         TALFWRJyjLgaJKxYR9heQ1IU0bv4mdDP92U4OvKXygPLSltNkqziqSLoDxcHBTxcpENj
         laCgkKXpuO+yl1QNGQkfl3t9+SqUDk2YRnDLk0/bO+iSK20BFTX27v1czR9e/7UyRXRO
         mrEdiOCwbEy6WVTEpLcrmu3FY91EPrpugdnFtT0QLhum9szmrV7M4E++wYaUd8Uel8NR
         IBKYVdxNMP+OusW3X0NaqBrhF3YPzCvhRRpAJNZfHqUO9HSM4oxUzlZZEhAAXxA1rs2R
         Nraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731631324; x=1732236124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHYyJiPL1uVix6sXcBSVhUMJXzftDKX8AxtiCADtdRg=;
        b=o8Sm90TQSJE3iZSPY35n76/Dty17lBJ7bKZXDXGx6XMN+gZXcSKv55zuJ1C4n+RFVS
         Xuhn9vGchdZ93G7Ra/jJWjE5F3uhqRkecobVCdTH0nchTi0yy/RYNBgX2nu8vf2xgNm0
         CgtwVrChX02RKsAkDxG9YrezjQ0RjgLOOFNkrB0pSStvTYc/HArxym2IssM5IzvvwyYH
         7mjY3TaCi2MRQwe0q0dNbJWtK+SeqO6TpoEfL6HbNSqYs/AXD2QqnRsFnHDwINOkaXIq
         jLhcU80/CE+J84VH0COLBllPYHGY0FVKbjp2mlmWL5fLwIht28rZMIg/H6ImhgfmZ1hx
         VSQg==
X-Forwarded-Encrypted: i=1; AJvYcCUr7/2CLwK35fAqNAdX27M0feAjcdKZ1xvZKhhwihnzVr3ktxG+8KRlfVxsuUWjfjs1Id+NynU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkxRvitTOukKK9a0mQq2/vqvWUZ0RqHMzmtD1e/Q6Ys9h17pIH
	rL6mDRrvFY124JREhxSa0H4rwB4N7SdBQUL3R6yztWq2jZ9/mV+i7vC/aFpmE6M=
X-Google-Smtp-Source: AGHT+IE7Do7E26R9csxUvunCbYmDAxnBlmmxHkrIkRFyVqSZXRT0PlbFTltbjGaMph4d9Vfrgfn0dQ==
X-Received: by 2002:a17:903:234e:b0:20c:5cdd:a9e with SMTP id d9443c01a7336-211d0d77b21mr13206615ad.28.1731631324502;
        Thu, 14 Nov 2024 16:42:04 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::5:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc5d70sm2305715ad.29.2024.11.14.16.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 16:42:04 -0800 (PST)
Message-ID: <156ce25b-4344-40cd-9c72-1a45e8f77b38@davidwei.uk>
Date: Thu, 14 Nov 2024 16:42:01 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] bluetooth: Improve setsockopt() handling of
 malformed user input
To: Michal Luczaj <mhal@rbox.co>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 David Wei <dw@davidwei.uk>
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
 <20241115-sockptr-copy-fixes-v1-1-d183c87fcbd5@rbox.co>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20241115-sockptr-copy-fixes-v1-1-d183c87fcbd5@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-11-14 15:27, Michal Luczaj wrote:
> The bt_copy_from_sockptr() return value is being misinterpreted by most
> users: a non-zero result is mistakenly assumed to represent an error code,
> but actually indicates the number of bytes that could not be copied.
> 
> Remove bt_copy_from_sockptr() and adapt callers to use
> copy_safe_from_sockptr().
> 
> For sco_sock_setsockopt() (case BT_CODEC) use copy_struct_from_sockptr() to
> scrub parts of uninitialized buffer.
> 
> Opportunistically, rename `len` to `optlen` in hci_sock_setsockopt_old()
> and hci_sock_setsockopt().
> 
> Fixes: 51eda36d33e4 ("Bluetooth: SCO: Fix not validating setsockopt user input")
> Fixes: a97de7bff13b ("Bluetooth: RFCOMM: Fix not validating setsockopt user input")
> Fixes: 4f3951242ace ("Bluetooth: L2CAP: Fix not validating setsockopt user input")
> Fixes: 9e8742cdfc4b ("Bluetooth: ISO: Fix not validating setsockopt user input")
> Fixes: b2186061d604 ("Bluetooth: hci_sock: Fix not validating setsockopt user input")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  include/net/bluetooth/bluetooth.h |  9 ---------
>  net/bluetooth/hci_sock.c          | 14 +++++++-------
>  net/bluetooth/iso.c               | 10 +++++-----
>  net/bluetooth/l2cap_sock.c        | 20 +++++++++++---------
>  net/bluetooth/rfcomm/sock.c       |  9 ++++-----
>  net/bluetooth/sco.c               | 11 ++++++-----
>  6 files changed, 33 insertions(+), 40 deletions(-)
> 
...
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index f48250e3f2e103c75d5937e1608e43c123aa3297..1001fb4cc21c0ecc7bcdd3ea9041770ede4f27b8 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -629,10 +629,9 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
>  
>  	switch (optname) {
>  	case RFCOMM_LM:
> -		if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
> -			err = -EFAULT;
> +		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
> +		if (err)
>  			break;
> -		}

This will return a positive integer if copy_safe_from_sockptr() fails.
Shouldn't this be:

err = -EFAULT;
if (copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen))
	break;

