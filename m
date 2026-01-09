Return-Path: <netdev+bounces-248382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323DD078B3
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 08:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC4843012C79
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 07:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA42EC08C;
	Fri,  9 Jan 2026 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHmOEDk4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+PxUuWI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47072EBBB3
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943373; cv=none; b=NaHf2tcjcsSqTWhyYLlwC8Ar3kWUyU2MUzVJXfASMKz7gZW5Eyuajj3Fn+hxWClWrbNuvGG/fE+7Je21v4CGzzE+YZjdmXdvP49rRAomPJ+DfE5QWC+d83lHiMeW6Dm1hUVcLcofv6tdXUTQ151OcqjIoY2Ah+pDwHmpJ5Kq82g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943373; c=relaxed/simple;
	bh=j1W235feRg0KN6FKcAZabBql8JsWIHtShwbmzD/a/pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8HRNjtgHmx7dv7FBnyWH2e4CXmsbTkPfOraiAIAHyWofoYC/dCQVF8WJx2kazBUZf97Xj0W8cl4Bt7si5Ylntb/v/xtdyBawFg9ecSRGeLEF8S4UbefttptxxVarIhwR57GVJuBJ4fltEGfo/HxJQZqnyO1vuET7A6GnHdZ9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHmOEDk4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+PxUuWI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767943370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCNBeC55dwFkYuH90UgwaJbtMoG2cmT0emKakpEw6rI=;
	b=bHmOEDk4WTx99tib5hmS58Yz3DXmAH+o5LNZBDCMIKk+k6ciaDyr7IXFVQJx+UQQiSHpHG
	OQKiX+Q3r56Y4XUdvfxiZU5hyMtgtLdcmxyy7AIC5AwxqtCz1LjBeRIiSTK+Sj5eFwrEve
	qUfxAIzFN7fyuwfNKl25Jv11ngdomro=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-pvrKkQtBNZGwNZvanrGKKw-1; Fri, 09 Jan 2026 02:22:49 -0500
X-MC-Unique: pvrKkQtBNZGwNZvanrGKKw-1
X-Mimecast-MFC-AGG-ID: pvrKkQtBNZGwNZvanrGKKw_1767943368
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d4029340aso39413935e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 23:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767943368; x=1768548168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qCNBeC55dwFkYuH90UgwaJbtMoG2cmT0emKakpEw6rI=;
        b=R+PxUuWIRXIrRgrq1h3TXojF5Qdslf4k8kqVo1et1koqF8PkFGflgODSx6j2GPoEs4
         z+5gYKngwhNgbZjGBTkdwqs2iBOJUMqhOB5SJ56ZdfWfZFOGyQw2w81Et+uXoFZei9RK
         5Jsf2uHqjr9s40DhGBdo10pvkPbYvI+WdI3iJTefWTwZo6mIdOyPJXDoMQ56ESGvhPWb
         5Cv44qQkv6QZV/GQlCMFNl1uCACh2+5RwdSr6wYMNzZzxM9U2BQgx5jKWM15BPJ2/hEs
         cDCwWQrfmxpRvwyljqijri/2OWLJV8rzsZU+uBXJT7NrkIBPdR3WaciZoiXckSHKb29s
         bn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767943368; x=1768548168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCNBeC55dwFkYuH90UgwaJbtMoG2cmT0emKakpEw6rI=;
        b=TbhaiG98mom2SbzK/zHZhKIPtF2M6MOM6R5oM6mRHsf9MKxniud/GehjDHVSK1lgsp
         SCM3RfYKN4Ta6hl8euHVSKsb7yr/ljyf5T7erGeW0jJsYj2Tysl61bdgfBEWPhzp5Qjd
         4FhZ9a0xTy4pltt+kn+mVzX8aLDI4VeBJAdBBjZpA943gY4RjO5h85It6HhX/homdZMS
         utAmgWPfHAQcnot3dSxzH4VCQXHOhJmvVZ5qNwOSb4vaRXl8YYnRRWYqY5X3jQVWEB9d
         AFvUtVhisIJOioarwHSo/OdKXAM8U9XIxM7DTlUyQ8esaI1/VdqEQTsoxPKxqS3pOdqP
         azgA==
X-Forwarded-Encrypted: i=1; AJvYcCVWvAwWMEG1rV6HdkkEiiZtxDkC/oSqIat66UasbvpYjSy0QMfoqLjQxXHt+OKJgjTrsYHADc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwDZ4yVdLMBWbYLHgAcZpHh69U0iVuQm2MFVtaMjA79+EHt+t
	f1qaqPzbo6rK+oEe3QJNd/gfXjtcEbn135JHGQIVzmcrTjzohTLQE52aZhErH1HTvtT1xo0lLNE
	7mivUrlthSrDVkZMam+yryw7MHOZkN3O9n5MRnSezVReMdESTx4hqWZIJkA==
X-Gm-Gg: AY/fxX7W5LVB3Jhl4CJmcizPyMzPII0l+AN8wZOnDI6eV178XnpL6owrZMJ+PAvrm74
	PO90POdpp4PsJCwe6+EMqB5WBU5Fp8fNYy9/CNQiHwbsdWDTdd6KDNmIAhnO2rerrp9rL8hSNW4
	lFkFD2nf89TxILJ9PmKaF6SZfEDsP9+3lc9jeRYHJD2u7Lk6g2tzIHAHUIECNP6nPAFnYB0wEil
	eO/MMOs3H1o9k/iQv8Fl8mPBXbLS0cP/ZafhDp9mnccUYP8S19dKrZKQooYr8m3PMfCoJK+Z1vK
	IFwL5SEnry5kumwrmxDoUN0NviwhDs2hiC4NfmuaQSrZxe4A+H1wOukUpvtcSbj8QF1f5ntZKIy
	7sM4ASQSt1RBcYT7kyaCw9P5mmiadpZrPdA==
X-Received: by 2002:a05:6000:4201:b0:430:f40f:61ba with SMTP id ffacd0b85a97d-432c3798349mr11114924f8f.41.1767943368380;
        Thu, 08 Jan 2026 23:22:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHdWMIJxf4esvBI4hULstTggLuOtGp39Tkn3cxYuG9NjEAkGwtcZDffJ90hcLBXgcBNIrf8w==
X-Received: by 2002:a05:6000:4201:b0:430:f40f:61ba with SMTP id ffacd0b85a97d-432c3798349mr11114886f8f.41.1767943367815;
        Thu, 08 Jan 2026 23:22:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0daa84sm20705982f8f.2.2026.01.08.23.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 23:22:47 -0800 (PST)
Date: Fri, 9 Jan 2026 02:22:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v7 2/9] ptr_ring: add helper to detect newly
 freed space on consume
Message-ID: <20260109021023-mutt-send-email-mst@kernel.org>
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-3-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107210448.37851-3-simon.schippers@tu-dortmund.de>

On Wed, Jan 07, 2026 at 10:04:41PM +0100, Simon Schippers wrote:
> This proposed function checks whether __ptr_ring_zero_tail() was invoked
> within the last n calls to __ptr_ring_consume(), which indicates that new
> free space was created. Since __ptr_ring_zero_tail() moves the tail to
> the head - and no other function modifies either the head or the tail,
> aside from the wrap-around case described below - detecting such a
> movement is sufficient to detect the invocation of
> __ptr_ring_zero_tail().
> 
> The implementation detects this movement by checking whether the tail is
> at most n positions behind the head. If this condition holds, the shift
> of the tail to its current position must have occurred within the last n
> calls to __ptr_ring_consume(), indicating that __ptr_ring_zero_tail() was
> invoked and that new free space was created.
> 
> This logic also correctly handles the wrap-around case in which
> __ptr_ring_zero_tail() is invoked and the head and the tail are reset
> to 0. Since this reset likewise moves the tail to the head, the same
> detection logic applies.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index a5a3fa4916d3..7cdae6d1d400 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -438,6 +438,19 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
>  	return ret;
>  }
>  
> +/* Returns true if the consume of the last n elements has created space
> + * in the ring buffer (i.e., a new element can be produced).
> + *
> + * Note: Because of batching, a successful call to __ptr_ring_consume() /
> + * __ptr_ring_consume_batched() does not guarantee that the next call to
> + * __ptr_ring_produce() will succeed.


I think the issue is it does not say what is the actual guarantee.

Another issue is that the "Note" really should be more prominent,
it really is part of explaining what the functions does.

Hmm. Maybe we should tell it how many entries have been consumed and
get back an indication of how much space this created?

fundamentally
	 n - (r->consumer_head - r->consumer_tail)?


does the below sound good maybe?

/* Returns the amound of space (number of new elements that can be
 * produced) that calls to ptr_ring_consume created.
 *
 * Getting n entries from calls to ptr_ring_consume() /
 * ptr_ring_consume_batched() does *not* guarantee that the next n calls to
 * ptr_ring_produce() will succeed.
 *
 * Use this function after consuming n entries to get a hint about
 * how much space was actually created.





> + */
> +static inline bool __ptr_ring_consume_created_space(struct ptr_ring *r,
> +						    int n)
> +{
> +	return r->consumer_head - r->consumer_tail < n;
> +}
> +
>  /* Cast to structure type and call a function without discarding from FIFO.
>   * Function must return a value.
>   * Callers must take consumer_lock.
> -- 
> 2.43.0


