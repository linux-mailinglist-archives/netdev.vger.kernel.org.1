Return-Path: <netdev+bounces-241546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6127EC85935
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAEBD3517B9
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EB1327BF5;
	Tue, 25 Nov 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABQRGpbL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfcFu2mT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AFB13AD05
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082476; cv=none; b=RnYT4STFBQmNOCbG/miBAkp0k4oA/aaxedxPMJQN9T6MHKrbwD5vlpXkVg94kYOUM+IXTDtVh24KFxs9dz6jDKdNzn70OBVnSE3qPap2y8akDPgxytdvUBuJCxPZRDmUgtNs64Z9J/wI/4rODqhx3uRJGBDRBYfvcQWPXPv7GBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082476; c=relaxed/simple;
	bh=8xC7HaADQYW3D+KtCunFe74uUCqkHpl2Q0DkBJIPChA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEBL4sAwjIz6D2y7fdQhP/55Dvht/z3PO8FmOS2vD/64fHv0JtxnXt7T8aHLGBpAys+d4jw8SM0UO6bxnUMF05OrthmEYVWG/tF620JWH7BG0wW5/U3dOcP+SBbR0/pgw0WE4e0JoUFrl9H9AWsIIdFQbJdwO8sH4/xvkFFNvEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ABQRGpbL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfcFu2mT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764082474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vUrStbCWzacPZeRn/CeAW92WYQYkVd+P3AlUH3cXvno=;
	b=ABQRGpbL3GrR1YpqoHIq879WeEhlpbPOgBwprtY8Zx00sZ7sqQ41oLSeMv3hvD7u3I9x+x
	Ycdj40ZyZXboS+FzES+iSLZgYJKBN5/55lc6NF4x+mu/1QW2D1TEMLEV9111weofHbVkss
	7b58/rVB0BSdf2M8zcsjQhBne/ECuBY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-WAoEv2GiMgW25xcD2TWODw-1; Tue, 25 Nov 2025 09:54:31 -0500
X-MC-Unique: WAoEv2GiMgW25xcD2TWODw-1
X-Mimecast-MFC-AGG-ID: WAoEv2GiMgW25xcD2TWODw_1764082469
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b3c965ce5so4602488f8f.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 06:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764082469; x=1764687269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUrStbCWzacPZeRn/CeAW92WYQYkVd+P3AlUH3cXvno=;
        b=cfcFu2mT/kKAEmorPEqCPxak8/pldhwbINDn/xrL4io3ji1L4N4klw8sgrqUATvU1f
         HNN2w2V2bh9KiKb/yJj3csEINNzl+zAvXZF7vTPLzkmzVGygrT6biiEbATDCfXDSsRU3
         qqz0wtqaSQoasNM+ScGRDNjv/jUB3Y9Ax8NhlSXiuo9eqIgwqkjrc+wGj+Tfkgf/bz4b
         h7pRuAi+/cJE44PPQQNaBvDFOayQURYMhD2v9gR4vck0gj9yG7H+P6DJwuuF415S4n/S
         yMbWSDwaDkK2xid8MWiFlSdlV8rbLrYOnK7cDKzFg53BcdYiB2Vt113w4wIEJ7WxzSF7
         +jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764082469; x=1764687269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUrStbCWzacPZeRn/CeAW92WYQYkVd+P3AlUH3cXvno=;
        b=K0M0fu1XFlWLR6xDUsyw/+tvELaYGexUySJ59WHRYmHq9AMnXRuWVmO8NF0vvRqg/C
         Cvz78jOVxiOtLdxsG0eLjQ+1DE4Ga06KTWmTJmzP2t85dHGlKhiU04EyY1ilnWxPbSCS
         jlDJpVf2OYOJ37kWb68kopPWDGpJ7QY1v6I2fEeJZBZVLdT2bTY22xSAacOHKBJ7CRNu
         8+PKLTa+Rgg+njtKwNarZP6bWcjBd1Og4uVabZBIwXw6dEE46LlsQGwI1joxo3UMt+ZM
         78i6jU3UjorncEi7VmdvBYVWxd4oi7+SJg/Ar7Mfx2WpDe5RIkHkHKB5R4krtnZrZxXK
         iYNw==
X-Forwarded-Encrypted: i=1; AJvYcCXMeTg0+b+v6S9et4G82iwRCieKP4EAKsHfDoSHg1+x+2bvMOaRKGjvkCX145C9i4396nfSfGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykG/pFVeiDipFTiQl6aSn8dcmFPPOde+R/jiFf2ylH/yECoO9A
	4/eSm4ZcrAz/I6QRlnJadCtp4Eu3+D2TX70mVHVZLkx1NzpL9gcILtMT6Y3HDBEOXu0c6AiOAjO
	SyFoNXcCoJZGvAsp1ijnlahjw+eQIvR7+EC/1Mkbuk2Xy7H/BWc7OW3Axvw==
X-Gm-Gg: ASbGnct25bl8JKj0KzRmzJFtqaor4JuR3aebOYOv7v8a3SZxEym5Z59X5fujk3yUgPG
	/23COgDjLkCOQ6ZiLlfMKPaZDqMMiA9TUXSqge7h2hnpejAR8XFcsNDvIwkrLgWZXYdbqbUhuA4
	HeJvRmAPmZvMDq+FctdIoamop51r89qsgAZzzV2FHyjw4jCt42uSTnYUkd+4juzcX/Kf98f1mHB
	7BBw80TDhJ+dK/1Os12S+abnnMRJfkGmxpDOV9Fyk5uEkj60hyJPWS8Uv/Esq4hhw1Hh/9nCpa/
	BvFVXCKq5NTr+1+kGnGvM5WpH6IE7x8WZWJSYQ7aTb+HVP0+9T3FseYSWpXhmLR+yzcm6gD0Qgl
	N1BoFOewJZKq+rrY=
X-Received: by 2002:a05:6000:1841:b0:429:b525:6df5 with SMTP id ffacd0b85a97d-42e0f1fc3f8mr3305590f8f.3.1764082469383;
        Tue, 25 Nov 2025 06:54:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7rvJRNZU8Dcdx4PHJxDxhuM/oczmqfkFeajyK44cHiOkIrlaShhTGgJMJROx6QVQcGeq/5w==
X-Received: by 2002:a05:6000:1841:b0:429:b525:6df5 with SMTP id ffacd0b85a97d-42e0f1fc3f8mr3305550f8f.3.1764082468871;
        Tue, 25 Nov 2025 06:54:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f3635bsm35190453f8f.17.2025.11.25.06.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 06:54:28 -0800 (PST)
Date: Tue, 25 Nov 2025 09:54:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	jon@nutanix.com, tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v6 1/8] ptr_ring: add __ptr_ring_full_next() to
 predict imminent fullness
Message-ID: <20251125092904-mutt-send-email-mst@kernel.org>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <20251120152914.1127975-2-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120152914.1127975-2-simon.schippers@tu-dortmund.de>

On Thu, Nov 20, 2025 at 04:29:06PM +0100, Simon Schippers wrote:
> Introduce the __ptr_ring_full_next() helper, which lets callers check
> if the ptr_ring will become full after the next insertion. This is useful
> for proactively managing capacity before the ring is actually full.
> Callers must ensure the ring is not already full before using this
> helper. This is because __ptr_ring_discard_one() may zero entries in
> reverse order, the slot after the current producer position may be
> cleared before the current one. This must be considered when using this
> check.
> 
> Note: This function is especially relevant when paired with the memory
> ordering guarantees of __ptr_ring_produce() (smp_wmb()), allowing for
> safe producer/consumer coordination.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Co-developed-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 534531807d95..da141cc8b075 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -96,6 +96,31 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
>  	return ret;
>  }
>  
> +/*
> + * Checks if the ptr_ring will become full after the next insertion.

Is this for the producer or the consumer? A better name would
reflect that.

> + *
> + * Note: Callers must ensure that the ptr_ring is not full before calling
> + * this function,

how?

> as __ptr_ring_discard_one invalidates entries in
> + * reverse order. Because the next entry (rather than the current one)
> + * may be zeroed after an insertion, failing to account for this can
> + * cause false negatives when checking whether the ring will become full
> + * on the next insertion.

this part confuses more than it clarifies.

> + */
> +static inline bool __ptr_ring_full_next(struct ptr_ring *r)
> +{
> +	int p;
> +
> +	if (unlikely(r->size <= 1))
> +		return true;
> +
> +	p = r->producer + 1;
> +
> +	if (unlikely(p >= r->size))
> +		p = 0;
> +
> +	return r->queue[p];
> +}
> +
>  /* Note: callers invoking this in a loop must use a compiler barrier,
>   * for example cpu_relax(). Callers must hold producer_lock.
>   * Callers are responsible for making sure pointer that is being queued
> -- 
> 2.43.0


