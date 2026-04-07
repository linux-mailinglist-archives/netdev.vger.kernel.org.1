Return-Path: <netdev+bounces-276130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJtkOi5M1Wm94QcAu9opvQ
	(envelope-from <netdev+bounces-276130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:25:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 550C23B2E77
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02F27301E7D6
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 18:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443502D7DC8;
	Tue,  7 Apr 2026 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRa74Wlu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E52C326D
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775586346; cv=none; b=aQE+Yvby0tDvyFHbUVIT2IN4fW8fVUbRBvMDGZaWeCXFl7QsbRtB3q/kl9BV2bm5NvdSY359JOKa77fXevtypst02H2BAF+w/zR/ZFrNdEW6gny+1gEiUZMNaFSPYHDL5miefzZ7uLbB7ArPTjBf/k6tQ3k6ZUMW7elRq6VJZJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775586346; c=relaxed/simple;
	bh=fIHQNLFLDXKvJ2osiz+LzV3miWUwwvX0QAPWHwWNNAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=It9H/KEizmyBL13zHZVOIYIMXKerZ8JRjwEO1JQoQ+Rq3Xa64dJVHHbLN7HMYFfQ07f7iFWrAx+ZOFDznNGqKJ3FsgyBK4LV+eu5Pdlc18uymG0hzPHGP8fki+T0pxzafaK12A++dHvmE2kOMbqi3kM03//R8gYhLsc9c91jyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRa74Wlu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso2166915e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 11:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775586343; x=1776191143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WrARU3H5Z199x4U5Iol6cO9B4Dhw+DXctb8Kf3HRm4=;
        b=kRa74Wlu6aG4Sip5EczaQzNGeewYSQ6i7GdMN3mquapbuqbeAUzvG1JCHLN8999Aom
         lZRg69kAZjRrMo7sRWRTf6bdeRsmHCfgKkgIiuUzpD/82ihJ/twHmNoc/EkuISlxF8+8
         Jtis57CBGhrU6oSZPgHEHV0vcBFl+vQPizOsP8/6mZspDk+PY5xIL+qZ5Op23U+UcTPb
         gP7/wG2zrFEPGXX+BKIU9GZNTmitB58fGobCO9QFPlC/WUKZGUXuT2qQPDvRxTxtjhzT
         qxWvq1szvQ0wDqvvJ1ZN+gX5rL0sTJX6oLPI4mqGTHiQRHfIOatTHeBP752T2nUc1MQt
         rRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775586343; x=1776191143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+WrARU3H5Z199x4U5Iol6cO9B4Dhw+DXctb8Kf3HRm4=;
        b=Nf3k02uhE4/QQQW/D6fT9D7CodqaCYePOjGYimiVyM7eapxxWrGHOJGVjIbtkx25gI
         Ot5mfF79ZmLho+F4lRnvk8fRQiXqI3xCfEuG07tvjcaYYS1hamz/44PXMd4f6TsWk+yR
         UbyPweHJskOmXwbwK+Mq3d5yLhkGaKHqqoUFLDT9qzPrnEKgHoOVIMHhFJFnw4vE+oF9
         tnhalaUAGo/wiRxv1BJv9s0CHBDcvvsQYPp8KRMM1yh1mMv4O6S8UtnFZDHA7U+S/tY8
         VLGp5APMR/qWE5hiSx7RlwB15c9aStVtIynPBTAyJw0xCfduPAWGKab2MHYpy+pzCjPl
         LsrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW//dQuKwQswT3WGuZDOsA7+LeZeWdELTg2oMCU9oaZAOjo4byFvzm0jo5L5qQ0ZWV3mwCrSvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxhnL+b418URsTibpCxqXh1yq6cqS7V70jJuZn9yyR3Roy4wZN
	aNBAOtXZkp4LB7qFiCq0+9PNub/ymnbW2gDei0PNfl9ApzLq84CCNl0W
X-Gm-Gg: AeBDieukZ2fM0PcnPG1+1Oy5/EGARN/mrgJFzWc6avqGE0bpujyXA25LzBhJRktlJtc
	mw18G6ih4IQZcvo67ZUr24KEnfxJmCUp72zmK0QkrFKjczAwOb5/sSG1/GNOXk18WN11vaBCUsx
	Y5RpXSpIGfQOasWs8ULBUxjGByDFNQ4UHj1Oi0i64b38MqCeTe7mR4Lpqx84ILdFBJkD9R6jWh7
	HGZxjfZSFfzRVOm1py487uiZjHoQzd+0de28lTRqKyGNTAXV3T8A4y+aWu65guu3pc50jlv84Z1
	p6WvXAZByNQAkcmCjtfuDG1UobAxQ/hC4ILH0tPEvJbYKo6SBzpdy2j7TN1xHBsoLgss4j7l9aK
	VwfswEV4itVQXxuiyQfO6zGI2vl/vHR7NaOm4t1hpk927r7Rkp9egC3Lz9Ri+zG0WC4lGsB3O0b
	R/0j0c38xyqRUX7aMPJc4gl3sfNwgFcSZ3bgPoxWuWd4r+xjA5w7WpHRhDctF0pieT
X-Received: by 2002:a05:600c:4930:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-488aa33dd7bmr93707555e9.0.1775586342522;
        Tue, 07 Apr 2026 11:25:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b6ff70bcsm256033525e9.14.2026.04.07.11.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:25:42 -0700 (PDT)
Date: Tue, 7 Apr 2026 19:25:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Dmitry Safonov <dima@arista.com>, Francesco Ruggeri <fruggeri@arista.com>,
 Salam Noureddine <noureddine@arista.com>, David Ahern <dsahern@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Michal Luczaj <mhal@rbox.co>,
 David Wei <dw@davidwei.uk>, Luiz Augusto von Dentz
 <luiz.von.dentz@intel.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, Xin Long <lucien.xin@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Neal Cardwell <ncardwell@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>,
 netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/5] uaccess: add copy_struct_{from,to}_bounce_buffer()
 helpers
Message-ID: <20260407192540.321f3879@pumpkin>
In-Reply-To: <f29570914590c50b9b6f451eb3a38d0fe1d954df.1775576651.git.metze@samba.org>
References: <cover.1775576651.git.metze@samba.org>
	<f29570914590c50b9b6f451eb3a38d0fe1d954df.1775576651.git.metze@samba.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276130-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,arista.com,kernel.org,davemloft.net,rbox.co,davidwei.uk,intel.com,holtmann.org,google.com,redhat.com,cyphar.com,chromium.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 550C23B2E77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue,  7 Apr 2026 18:03:15 +0200
Stefan Metzmacher <metze@samba.org> wrote:

> These are similar to copy_struct_{from,to}_user() but operate
> on kernel buffers instead of user buffers.
> 
> They can be used when there is a temporary bounce buffer used,
> e.g. in msg_control or similar places.
> 
> It allows us to have the same logic to handle old vs. current
> and current vs. new structures in the same compatible way.
> 
> copy_struct_from_sockptr() will also be able to
> use copy_struct_from_bounce_buffer() for the kernel
> case as follow us patch.
> 
> I'll use this in my IPPROTO_SMBDIRECT work,
> but maybe it will also be useful for others...
> IPPROTO_QUIC will likely also use it.
> 
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Francesco Ruggeri <fruggeri@arista.com>
> Cc: Salam Noureddine <noureddine@arista.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Michal Luczaj <mhal@rbox.co>
> Cc: David Wei <dw@davidwei.uk>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Xin Long <lucien.xin@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Christian Brauner <brauner@kernel.org>
> CC: Kees Cook <keescook@chromium.org>
> Cc: netdev@vger.kernel.org
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> ---
>  include/linux/uaccess.h | 63 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 1234b5fa4761..a6cd4f48bb99 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -513,6 +513,69 @@ copy_struct_to_user(void __user *dst, size_t usize, const void *src,
>  	return 0;
>  }
>  
> +static __always_inline void
> +__copy_struct_generic_bounce_buffer(void *dst, size_t dstsize,
> +				    const void *src, size_t srcsize,
> +				    bool *ignored_trailing)
> +{
> +	size_t size = min(dstsize, srcsize);
> +	size_t rest = max(dstsize, srcsize) - size;
> +
> +	/* Deal with trailing bytes. */
> +	if (dstsize > srcsize)
> +		memset(dst + size, 0, rest);
> +	if (ignored_trailing)
> +		*ignored_trailing = dstsize < srcsize &&
> +			memchr_inv(src + size, 0, rest) != NULL;
> +	/* Copy the interoperable parts of the struct. */
> +	memcpy(dst, src, size);
> +}

Return 'ignored_trailing' rather than pass by reference.
And this is probably too big to inline.

	David

> +
> +/**
> + * This is like copy_struct_from_user(), but the
> + * src buffer was already copied into a kernel
> + * bounce buffer, so it will never return -EFAULT.
> + */
> +static __always_inline __must_check int
> +copy_struct_from_bounce_buffer(void *dst, size_t dstsize,
> +			       const void *src, size_t srcsize)
> +{
> +	bool ignored_trailing;
> +
> +	/* Double check if ksize is larger than a known object size. */
> +	if (WARN_ON_ONCE(dstsize > __builtin_object_size(dst, 1)))
> +		return -E2BIG;
> +
> +	__copy_struct_generic_bounce_buffer(dst, dstsize,
> +					    src, srcsize,
> +					    &ignored_trailing);
> +	if (unlikely(ignored_trailing))
> +		return -E2BIG;
> +
> +	return 0;
> +}
> +
> +/**
> + * This is like copy_struct_to_user(), but the
> + * dst buffer is a kernel bounce buffer instead
> + * of a direct userspace buffer, so it will never return -EFAULT.
> + */
> +static __always_inline __must_check int
> +copy_struct_to_bounce_buffer(void *dst, size_t dstsize,
> +			     const void *src,
> +			     size_t srcsize,
> +			     bool *ignored_trailing)
> +{
> +	/* Double check if srcsize is larger than a known object size. */
> +	if (WARN_ON_ONCE(srcsize > __builtin_object_size(src, 1)))
> +		return -E2BIG;
> +
> +	__copy_struct_generic_bounce_buffer(dst, dstsize,
> +					    src, srcsize,
> +					    ignored_trailing);
> +	return 0;
> +}
> +
>  bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size);
>  
>  long copy_from_kernel_nofault(void *dst, const void *src, size_t size);


