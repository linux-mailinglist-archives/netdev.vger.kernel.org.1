Return-Path: <netdev+bounces-187679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98542AA8D9B
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 09:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DDB18954A8
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69D21DF993;
	Mon,  5 May 2025 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWNbdEjZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F61E5B7D
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431706; cv=none; b=lh11ChV5lJyAcGBNNEfYlyNo7eqCDEH37q9YLW/WksD7x4AoqgCyZ/9KdL/MzxZcdKYDoNSyuhPkD3gUsOyVo39WyVcoagVjNNBYbpuDV2lBcwY0EMK9wKqBNr9WjSRAIrTq4UV9jmE5WyCkuFlwRg1bD9rJVlVQ5epzpDQUXr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431706; c=relaxed/simple;
	bh=29MHSk9j1fF0Pk/+yqzxVPNn3x/SQEJdwgmdSN3wYSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amNFuy03Kp5qAbWPOCxnCsEB1YvcF9S9s6TxJF3tN/EeLJHcYaahnmSBkJcqSCH5iShnaPQDBVBNDJ6S9OVAclPuKzb7QOSDL79l7lfBTqj2jrzwMJbGM6u9T8Ls5imtt5134+twr4bbNBQuFrDISuihaY2/m5RkWBxuS7EwFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWNbdEjZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746431702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AyPnMBIWgVsfptMubHyY1kpECsuir2FcGrasPWJztWc=;
	b=dWNbdEjZdbl3ijMO995sgf6NNhAbJUUfePBeZy5c2Cb4XStkiY8wBtvAGwFj+SDoR2CTOP
	lEadegvFYwMiYT2/Ysvh7qMoTmu3ofwdpaUXmnATMVZ7uPFyLwkkn2mFVKIX5dDASMHsu/
	sqR/cYikmO3uTogyp+XI99P9TJCoAN0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-Nc6Xf8Y1MjSq8qGbF0viWw-1; Mon, 05 May 2025 03:55:00 -0400
X-MC-Unique: Nc6Xf8Y1MjSq8qGbF0viWw-1
X-Mimecast-MFC-AGG-ID: Nc6Xf8Y1MjSq8qGbF0viWw_1746431699
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cec217977so24173245e9.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 00:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746431699; x=1747036499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyPnMBIWgVsfptMubHyY1kpECsuir2FcGrasPWJztWc=;
        b=f4xsIRwYFy0Q8QCpxRTMRr9uuzuuoYAhYCIOOhoucJY9x5fXep3JaPtD8BpLBZTUY0
         zKrOk31Wj8gSG9hIzi3MGmmweK5sxhtRfZQfsaJ64ywCITWiVyFKPd5cgi0cM7FdXT4L
         waxGZ/ERor4uRhLTwBmAzRq2Z4VSW80nxua+huVJKWEHTQ6tJTd+y0lz+32Li/fnHThm
         34v6WOnxo1N9hVBnYduQ81hYGjSyXJBnISiR25dDlvvtiO4Y3T1i2B4TnKRD4BDlnrH2
         B3ma+LfNvkvRrDct7TP3UBVN00w9O+t/jZIXzz/Eq6WZjEQrP/0Ep2HNOfIqtPDCS0PL
         JuDg==
X-Forwarded-Encrypted: i=1; AJvYcCVK8hIPjfDjfCOgydknlENoEA4W2YxRlYl/pbgyTeRgQNF+M35HSau2nHVaHHXhs8eslERUpEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9FTPWHoEYldcwc7nbSxCRQa5wSXLihiETd5TGLycZKytJV/uw
	7+jnMhnYg1ebo0H3pBLFzz+2bFhMv7Wnv03y3Tb+OhtWBRt9gfUd11pWghTcsf3RJlvJCr/euJI
	mOB+0GgY5ckYK2AEOy1owvlEmiupsZdkbc64qtw4+kQPa0Titglyugw==
X-Gm-Gg: ASbGncun24XYEVMZgd9H/MWZABbjA8FKZHtmteATwANwbXnkZ6riAJ+r8EGzSBUE1Jq
	o+xJIwgdLcQt53Ns4wKqr31/2Y8XbLViXqXpvDi1VHSFxz4Obc2s638YrnAEi3USmtpN8y5AN+X
	g3N8uaJXaVYfvJDVu56pv20jDUa9s7/+vpz1N8zAzmMI+uhjXvSIBvCAqW1hR7rT3103LUch6HV
	Ek7HkBrWGQ4Ztzj0r8vCkbAzdsDvQMlIRpmWlDwKWn1AHnpKHBbaOXGAxlxDgqPvsiuLEiXij3n
	KLrEhc7/bvD9KNM/t/6E2e+f9Tcdv4OKG3NJwlUKby1l7kjrNS0S8kJMEdI=
X-Received: by 2002:a05:600c:34c7:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-441c491fcb6mr43207825e9.22.1746431699235;
        Mon, 05 May 2025 00:54:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNLaCwYHeYTkMx81M6FyXUvxVr3xyEW0QbrIaAS4GAXKQPyyDpTBLFaX32PbanmKErhnsgWQ==
X-Received: by 2002:a05:600c:34c7:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-441c491fcb6mr43207645e9.22.1746431698893;
        Mon, 05 May 2025 00:54:58 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010:b099:aac6:4e70:6198? ([2a0d:3344:2706:e010:b099:aac6:4e70:6198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b8a315fdsm123337385e9.34.2025.05.05.00.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 00:54:58 -0700 (PDT)
Message-ID: <938931dc-2157-44c8-b192-f6737b69f317@redhat.com>
Date: Mon, 5 May 2025 09:54:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 01/15] net: homa: define user-visible API for
 Homa
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-2-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250502233729.64220-2-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/25 1:37 AM, John Ousterhout wrote:
> +/**
> + * define HOMA_MAX_BPAGES - The largest number of bpages that will be required
> + * to store an incoming message.
> + */
> +#define HOMA_MAX_BPAGES ((HOMA_MAX_MESSAGE_LENGTH + HOMA_BPAGE_SIZE - 1) \
> +		>> HOMA_BPAGE_SHIFT)

Minor nit: the above indentation is somewhat uncommon, the preferred
style is:

#define HOMA_MAX_BPAGES ((HOMA_MAX_MESSAGE_LENGTH + HOMA_BPAGE_SIZE - 1)
>> \
			 HOMA_BPAGE_SHIFT)
> +
> +/**
> + * define HOMA_MIN_DEFAULT_PORT - The 16 bit port space is divided into
> + * two nonoverlapping regions. Ports 1-32767 are reserved exclusively
> + * for well-defined server ports. The remaining ports are used for client
> + * ports; these are allocated automatically by Homa. Port 0 is reserved.
> + */
> +#define HOMA_MIN_DEFAULT_PORT 0x8000
> +
> +/**
> + * struct homa_sendmsg_args - Provides information needed by Homa's
> + * sendmsg; passed to sendmsg using the msg_control field.
> + */
> +struct homa_sendmsg_args {
> +	/**
> +	 * @id: (in/out) An initial value of 0 means a new request is
> +	 * being sent; nonzero means the message is a reply to the given
> +	 * id. If the message is a request, then the value is modified to
> +	 * hold the id of the new RPC.
> +	 */
> +	__u64 id;
> +
> +	/**
> +	 * @completion_cookie: (in) Used only for request messages; will be
> +	 * returned by recvmsg when the RPC completes. Typically used to
> +	 * locate app-specific info about the RPC.
> +	 */
> +	__u64 completion_cookie;
> +
> +	/**
> +	 * @flags: (in) OR-ed combination of bits that control the operation.
> +	 * See below for values.
> +	 */
> +	__u32 flags;
> +
> +	/** @reserved: Not currently used. */
> +	__u32 reserved;
> +};
> +
> +#if !defined(__cplusplus)
> +_Static_assert(sizeof(struct homa_sendmsg_args) >= 24,
> +	       "homa_sendmsg_args shrunk");
> +_Static_assert(sizeof(struct homa_sendmsg_args) <= 24,
> +	       "homa_sendmsg_args grew");
> +#endif

I think this assertions don't belong here, should be BUILD_BUG_ON() in c
files. Even better could be avoided with explicit alignment on the
message struct.

[...]
> +int     homa_send(int sockfd, const void *message_buf,
> +		  size_t length, const struct sockaddr *dest_addr,
> +		  __u32 addrlen,  __u64 *id, __u64 completion_cookie,
> +		  int flags);
> +int     homa_sendv(int sockfd, const struct iovec *iov,
> +		   int iovcnt, const struct sockaddr *dest_addr,
> +		   __u32 addrlen,  __u64 *id, __u64 completion_cookie,
> +		   int flags);
> +ssize_t homa_reply(int sockfd, const void *message_buf,
> +		   size_t length, const struct sockaddr *dest_addr,
> +		   __u32 addrlen,  __u64 id);
> +ssize_t homa_replyv(int sockfd, const struct iovec *iov,
> +		    int iovcnt, const struct sockaddr *dest_addr,
> +		    __u32 addrlen,  __u64 id);

I assume the above are user-space functions definition ??? If so, they
don't belong here.

/P


