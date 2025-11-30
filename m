Return-Path: <netdev+bounces-242831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FC7C95335
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 19:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD31A3421B9
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 18:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E092C0260;
	Sun, 30 Nov 2025 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkkABKgO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE59B285C99
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764526610; cv=none; b=tnznti78i9Pn34fCxoX7NGho1C+pujJKnMjVjO1SLJwO1rMh6Qz0Ugt8BPSFt3mPAG0YiqiXkxqK9wWzMJ+Lzj2ZQqDE+89sR0jmsbg0wpwtH2ayf741HUmQSSdabrqWhXLloUBfzwI071VfQJzS0ZBAPBZ3VhFDFhxKwELzjVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764526610; c=relaxed/simple;
	bh=KvguCsz4pFutF0DfQ4yn73w4b9PB3j46YC5jFCOIPbI=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZV5FTjSma1GFFllob/9p9sLUm10wPXFsBzaH5JLL3/iYFet8TOeOiOzxIgZBhH6jNFLt4VfrOW04fuWxk8p0bSmHKBzHdg3+ebZEPSzAdsS4kCzK/+kggmEJbJPXhrt6bML8J/JRWhFxP0OBWtQIw67vCoMEjWjdOmXJUaT8OEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkkABKgO; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-640d0895d7cso4299465d50.1
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 10:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764526608; x=1765131408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyAdI2hiDQd5HiIOsukC026FiEA0dW/JcjYmFaMww+Q=;
        b=KkkABKgO3i88qTaPEM8l4qF0qVQb2Oc83BM9rlYPGe6aEwWoQk123eSP/qOL5VkvoT
         E4dmxtIWk/0xbe+d+bzyYeGwnhpcpHZsoEGPmH5hySMmmJzY2Bgnp7D7BRW5mClEBjOT
         sRLDyOA0f+VmAPmyWKsCLRMXNOvjWG00sZIJHX5/XTu1EfDgvx7CbpXsOsHXUdu83Zaq
         bdwvnjyz9ZW6ZBEg6GC3ThYkdExYlDGb4aqnNL8olod4IdW8CDxGT+0eMdzGBduAvJMN
         1dlUee4gJ7YdZ9jtpFDb/pxtjAaQIO+Z27wL4RZSrsedGsly/OeAqaR0cKNjMQ+qVfL0
         Jw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764526608; x=1765131408;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JyAdI2hiDQd5HiIOsukC026FiEA0dW/JcjYmFaMww+Q=;
        b=GDEBwzOK9DpF1FXGaXkOxVx4bt1elWacjvPc/C9oKJ8QKQNh7LSyO3Sj7rbRXAT5hi
         wFshOhKm4H3NjMWUEmjJrUuLde3EFMEPnAz/aXS62vgwSN/SXrDDG/HHdnCKnQK0gbGp
         F6Yoo4PC2fdB9tJHDbkNAD8KCzBTK9ihDQUiPrphM3fSZ50tcOr38U6iCbEKTObQhk++
         4tA1PJZ/5/+lAMwEGrhtKj9St8nwlyW2/lEVDXDnbbtK03+YbtfUql/RlYweMbfr/47H
         35LFFVyUcE//dTNmTdwF3z5BC5gsOjAVKjOx6PFxJ1MmdimIu/QgcAxtIMfBibDbsBdN
         nDFA==
X-Forwarded-Encrypted: i=1; AJvYcCXFxfZWfcZhvYfsOdcuC1EVLlAEwRiEyoOCOlVnM7vw357X1TZ9+KqZS5JOrmY65qNBirs1tIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMgGEcN2jBjcMBdx5rPDxqzWBnVCPXtxPWELeCrF9WH0UKn3vY
	9BKgXrvlegtg1r62wzWT4kqYGhp8VLwY6AcwHLEFlCkrGe05ho0XIj+r
X-Gm-Gg: ASbGncvuKqOluX03dWSau990XdUiUHX3ZEmcmrn7zmBfOeZ3fd+0pdKM9YZGe7PD4le
	KU+U2vpF+6mDOLLFWUlYgXMmO5vgpttkrwGs0MrvZkoDG4aXHoNwy7CHzyHuZLc0j2v2HONLDmH
	Z7q2siJ7OYoHx7fJO0tKGhWL7afmsm6sOJtTIWcFn2adMc7m87lkDYkGGmJDjbgFWVYxX/6+8vP
	b0DiPP0pi/5ooVit8nQraAa19/h2RYM/GFjnb3thWiycx7/Ubvb6syo1JnTYpkVwhXgvmvcnlOv
	biBou2LNz+wLnZml3bB5oJGnQqZSxXLXVoIoQVqx3a0Zi8Xczs0tWSEOutKlPW60Ag28DZzX+SU
	gAiJVPs1/px61qH9PzxROHeWmK7aIHiQuSUp8J1louluGRrL2zX4x4A1gS4YWU+5V7RcYH0eyS5
	huhvHPyRSGwuJQyJ+OK/G9oTx1gWGFMy/UUIajvqeMPyK9h6Zqbme6/bfC/ovvFDRLkQ4=
X-Google-Smtp-Source: AGHT+IGjUNSaNMlSY1qlNbQudRZSgfRbmbbf/B0rphetUkGqwnK/CkPwKVh/ASYpHjSaXoMyaE9Zng==
X-Received: by 2002:a05:690e:1489:b0:63f:b1fd:3850 with SMTP id 956f58d0204a3-64302631797mr26472073d50.33.1764526607842;
        Sun, 30 Nov 2025 10:16:47 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78ad1045723sm39215937b3.55.2025.11.30.10.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 10:16:47 -0800 (PST)
Date: Sun, 30 Nov 2025 13:16:46 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 jon@nutanix.com, 
 tim.gebauer@tu-dortmund.de, 
 simon.schippers@tu-dortmund.de, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.2ef79a77ca3ec@gmail.com>
In-Reply-To: <20251120152914.1127975-3-simon.schippers@tu-dortmund.de>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <20251120152914.1127975-3-simon.schippers@tu-dortmund.de>
Subject: Re: [PATCH net-next v6 2/8] ptr_ring: add helper to check if consume
 created space
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Simon Schippers wrote:
> Add __ptr_ring_consume_created_space() to check whether the previous
> __ptr_ring_consume() call successfully consumed an element and created
> space in the ring buffer. This enables callers to conditionally notify
> producers when space becomes available.
> 
> The function is only valid immediately after a single consume operation
> and should not be used after calling __ptr_ring_consume_batched().

Please explain why it is only valid in that case.
 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Co-developed by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index da141cc8b075..76d6840b45a3 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -453,6 +453,23 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
>  	return ret;
>  }
>  
> +/*
> + * Check if the previous consume operation created space
> + *
> + * Returns true if the last call to __ptr_ring_consume() has created
> + * space in the ring buffer (i.e., an element was consumed).
> + *
> + * Note: This function is only valid immediately after a single call to
> + * __ptr_ring_consume(). If multiple calls to ptr_ring_consume*() have
> + * been made, this check must be performed after each call individually.
> + * Likewise, do not use this function after calling
> + * __ptr_ring_consume_batched().
> + */
> +static inline bool __ptr_ring_consume_created_space(struct ptr_ring *r)
> +{
> +	return r->consumer_tail >= r->consumer_head;
> +}
> +
>  /* Cast to structure type and call a function without discarding from FIFO.
>   * Function must return a value.
>   * Callers must take consumer_lock.
> -- 
> 2.43.0
> 



