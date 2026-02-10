Return-Path: <netdev+bounces-258058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIImAcYLi2lXPQAAu9opvQ
	(envelope-from <netdev+bounces-258058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:43:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDC3119BD1
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C76F83014C77
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16135C1A6;
	Tue, 10 Feb 2026 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjkeQXv5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjLmWxS3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E63164A5
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720193; cv=none; b=pM+XoHVY9/Y6GlWwFeQwoNyhwxhqh5Nimq86PLEkPZzW7FTm9De5X0AbkSm5OtSDtXT+9id0TjXFL7CSIfvRcR8/fm2NAJN1krbpyMPIEQFbXq2bkl4UvJgflvt8zzK6fQtE3tn+wm0+xhNdhmB4a+R8+Cm7MYIkf+p8idlAc4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720193; c=relaxed/simple;
	bh=vHPy9K6nokN5ud3vsHqsnfz5aMNvYf7p1Fjjl5JuZl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcYbLQzMlmeTmVY8Yidaks+Tw0WEvW4+1sSZ1y1Wx7xUQGLl+uAft4LS35NnU/DBimC4smiF0YF01oy3sXplHtXNrsoVeRSCL5gTyA82IQpg0pAGcYHj/q/KZKVECC3HpnWcWKuIaEubOlRB1ChUbpYBNm+pSolWdIg9sBvI0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjkeQXv5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjLmWxS3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770720190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fmh15d1w5jSmpFxvJDonnQ9HoIg4ckFkxRJYSCGgMUo=;
	b=RjkeQXv5yxtKt6J80wP1q7vd3TeHejtnQjHYdsR/DilO4uJ6MYA4UucKTrTmAEP8P4kk12
	FILD1Yko8JkUybUwOWjgOqEhUgwrYQez2En5RMZpy6LqOe8sRhcXJXsyLn9e19kL3NbOWj
	yIVmwmzNIUjHe4s648ej+YIqYqJJwf0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-jiHf9gMiP2GUXs0zVkVxhw-1; Tue, 10 Feb 2026 05:43:08 -0500
X-MC-Unique: jiHf9gMiP2GUXs0zVkVxhw-1
X-Mimecast-MFC-AGG-ID: jiHf9gMiP2GUXs0zVkVxhw_1770720187
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4832c4621c2so31405335e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 02:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770720187; x=1771324987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fmh15d1w5jSmpFxvJDonnQ9HoIg4ckFkxRJYSCGgMUo=;
        b=cjLmWxS3rvNWcQRyuoZSEmNtfPCgWKWwhQefWCRGW1KWUCIbdqYuzLqH3utruLC62d
         ShNSuGs8LvHexACHDJcLes+DGh/zjeO68iiXf/r3GaHzi9RHlpV3xuaMtTUixX6upfF/
         8d9erq2kuQh+/x4+aOME+ycO1PDn2oeZC1Rsbp+oudCTLuxXwxlod5bUPO0JDzrUbEYu
         qVBnXtljOWZ+vp1PQtJLiKMZleyU5IJkG3lC5DWxYNljV1W4xGI4SDH3gqn5BgViwu2S
         5buo3Yx3Tb58Dmx1o3NI3gJuBO40IdtBPvm+HLy8dX6kwxT8mEmF/FDQ6B06w1GnTpmr
         z8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770720187; x=1771324987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fmh15d1w5jSmpFxvJDonnQ9HoIg4ckFkxRJYSCGgMUo=;
        b=o85Qyh574HVQMl5RPKu0eNyUf4zJXVakD9v46AP9SkgnxxY44DgxHvqKJPCZS5o4Ey
         xeuJr12oJoA/ovp2R2R3yL0U22oVHKEb56oEBSEzx/x88WqIRsumei/uKhZfI4Qh7uRw
         4k/ZguIFyM6yIy28CIZ/Gris9AZZF0QBCotKqz24QkeRO3yuoZl9P+9v9U6Eqgoi5pqb
         p8Hz7p+Ug9A7FKUEQ5q+vbTVGEbmWobAC/KjlLVZlOFLILUKk1O6odiwUPAlzOiJv88J
         whW53+2hjlp6K7odsvizhmFe7wSv/Wl/r/zg5sew1WpQK1fkPnAKLhO+DyLhwLGrJ5ho
         bUWg==
X-Gm-Message-State: AOJu0YxjTcsZG7NKnLot4ygRWisGTqxyvqFLx5IyD3WQ1FxQEnIAgUzC
	eaYU7WR5e4jJ4i4mR7jz/lrxPtIa0UvMjBQTl196WhnzEPBrUHh69Zpy3+63v8FZLLuvRULno4c
	R4M4ZdVppo4Sq4glmhMx97gim75Y+e9k6vyTwKvgFk1238Hmv9k2dv4cHwQ==
X-Gm-Gg: AZuq6aKsEdZqD4m13O5MOdHAAupfkiQq9zHvKUNBnZZMna+bQlcv/qxdbKnimLH3g5q
	C8l1nxlrg0ESyiYJ3WER8+rx1cG2azd4uD8yVOprGXEqgNZB+7/bjKddGq3TEMiUsIg9pZ6iNBT
	HY+1fCLC7goMJNTqTP1OyFkJdQKm0o/IJN8iJpYP4tl1D9bKXBBVP22hSgTdoVAv4bAm1Z7J4qZ
	qhdttk99GSnflsxxkitsyVxUSdbtuDfJhyoyUwy7QyYhOA4jubQNvpfe8RJ06DPWUpceip63YcQ
	3ivIHO3eIPkGW1qB0x+5lGR45g1ptSMOrxxSnrGxnrZaFa9xio6xUaG4ZbqTusjHi3uhlogA8Q7
	dbgJaH3Yg3qTTnh7yA7D5aXU=
X-Received: by 2002:a05:600c:3b87:b0:47d:4047:f377 with SMTP id 5b1f17b1804b1-48350836495mr29815965e9.36.1770720187349;
        Tue, 10 Feb 2026 02:43:07 -0800 (PST)
X-Received: by 2002:a05:600c:3b87:b0:47d:4047:f377 with SMTP id 5b1f17b1804b1-48350836495mr29815545e9.36.1770720186881;
        Tue, 10 Feb 2026 02:43:06 -0800 (PST)
Received: from [192.168.88.32] ([150.228.25.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d8334a8sm50734615e9.12.2026.02.10.02.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 02:43:06 -0800 (PST)
Message-ID: <59e7518f-65b2-4d97-ab81-bf64af758d00@redhat.com>
Date: Tue, 10 Feb 2026 11:43:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] net: mhi: Enable Ethernet interface support
To: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 Vivek Pernamitta <vpernami@qti.qualcomm.com>
References: <20260205-eth_vdev_next-20260204_eth-v7-0-f85645210f81@qti.qualcomm.com>
 <20260205-eth_vdev_next-20260204_eth-v7-1-f85645210f81@qti.qualcomm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260205-eth_vdev_next-20260204_eth-v7-1-f85645210f81@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258058-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 6CDC3119BD1
X-Rspamd-Action: no action

On 2/5/26 11:34 AM, Vivek Pernamitta wrote:
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2020 Linaro Ltd <loic.poulain@linaro.org>
>   */
>  
> +#include <linux/etherdevice.h>
>  #include <linux/if_arp.h>
>  #include <linux/mhi.h>
>  #include <linux/mod_devicetable.h>
> @@ -38,10 +39,12 @@ struct mhi_net_dev {
>  	u32 rx_queue_sz;
>  	int msg_enable;
>  	unsigned int mru;
> +	bool ethernet_if;

This is not needed, instead you could check !!dev->header_ops

/P


