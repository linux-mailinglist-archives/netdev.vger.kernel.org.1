Return-Path: <netdev+bounces-206767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7CEB04525
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EA84A06C0
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2682C25EFB6;
	Mon, 14 Jul 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKoox0cX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5E25DB0B
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509458; cv=none; b=tUas50b2QL3SPP3QT/GR3I6EAdUmKESvXr6Czf+wAWJA6ZOs/UnZFmdxrCNasmQEPQVeXt58wF5bIB2x/vFfV72+n6w/YkpWRC/05IR4TeFhIXGaIOJRzJvCoFnxvN7qr2oJjMrsQl+khRzbUzWUPDovv/ZmQe9fWCoWnjnBe9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509458; c=relaxed/simple;
	bh=TXBhF2hsvFF6n7aCSxrTP5ln0Far7SI/YRoW6S4tmUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2IrSBNJqaBB5A5Jc7azYLifviQjxSlYisohVq9742GptgjlybuLLaCFMP9aazC6nprFK8OCUyxT8rfYmkvI+fzHY0bHR9gWN+KhsB9Nyxb5ZBn7jUD0Omp3njoqcHDp3Adic3+mFYR1IE4BqO2HSlf22QjqZJhD1JP5b2L8y/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKoox0cX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752509455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJded38NkCminVRmf+Vkk9veSOaA59XspWkWKEaxDxE=;
	b=BKoox0cXnA4zT6zAgBsdaAyPkmDrDmoM+bE0jT81BHvhneMnKPhv5ZqpAoIRqKPCbGmjus
	fK9564sCmaP60B9yQkp+fLZ4+fM6qNWNfyN+p4hJIBDrGdlRGq4hYIiAYBv/00Iie67MsB
	5OV559h8lmkoo59UtNsaLAzNi9VpWtQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-5Z9iEOFfMXWSyR9_nV2YpQ-1; Mon, 14 Jul 2025 12:10:54 -0400
X-MC-Unique: 5Z9iEOFfMXWSyR9_nV2YpQ-1
X-Mimecast-MFC-AGG-ID: 5Z9iEOFfMXWSyR9_nV2YpQ_1752509452
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso29294265e9.0
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509452; x=1753114252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJded38NkCminVRmf+Vkk9veSOaA59XspWkWKEaxDxE=;
        b=glyAcTRKWXTjHqDdFhOZdUM85PX2T/IFHEHqcZzcxiIJiwqslhIjUk74my1qMZft9x
         uBNEgJqTY9zY389mbDSN0ME3HE8I6s4nUGz4ixu1UvONc1pwFq9QRK2gWYTCZq5h6b4n
         sghRjj+xCDhDwme3Xvwoc7QhkBEuXDmbSqimu8YNsN+/5k7hRSe5x18zTaWfhzwhpNzL
         HOpcdLo+T92fbt5xgnX7CH5CECuTfQI0Kr/Vl/qUU49+vIpJ5cUmX99FTlVql+W1VLnW
         S8U+LCb0YeSqvjNxkvdmsQYFM/i1WQXgr8zoe6KuGTdOoJNP5T9g6eD2SAsDaMkOSXxH
         o9yQ==
X-Gm-Message-State: AOJu0YykPslg3Ys1DqiKskx2dAaEMhCmKzWWpcK+LlnNW+5wqZ8MdEj/
	Ywo+NZBtOYhVwdpgKS9dnSunL6SRIyhK/ai87Q3uEqi/vo04DRogxeJPgULqj/jCunkqK6hcvRF
	u8tglapQJdlBXX96kd2Hx3EwG5YHnwW9j17a9gRxJ3wOnZQwbbbeTKUaZZw==
X-Gm-Gg: ASbGncvr8eFhsMvE1X1Tn+6Wp7D9XzdXH6Sb9eEoKrQVjXhMbrO8FDYBbp9bRIILPty
	Cw8e+m5XcZGSkxs5E33cb/yFlMr9GjUMT07c0v7RF5vQsd8FQ6X8Z+viffrVSRM5I5USdVpLXLE
	KgIog2VqWurllH8EnZT/38bRisKvAAVCH4JZdJ6xw0uiFBhWIg9C7/T+MMzNX4ujtAZBQLwcV0t
	CO4E46JQFoP4v+Ot2KlSO/K0+bet9aiiCC7qfrN5fuHgLl+s0l8kLOT9bj/wispz70LW0gNRVuV
	QnWq5B2K39Gc1KBJeiM3EsXmmes=
X-Received: by 2002:a05:600c:1e04:b0:456:c48:491f with SMTP id 5b1f17b1804b1-4560c484fbbmr93343605e9.10.1752509451781;
        Mon, 14 Jul 2025 09:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu0KDsL3bCGkwFYj1hHtAGF4TYYoQuLK07nUMMS0J4mW+mZWbbAYRS4px+NSDCrvU4TmUMTA==
X-Received: by 2002:a05:600c:1e04:b0:456:c48:491f with SMTP id 5b1f17b1804b1-4560c484fbbmr93343185e9.10.1752509451327;
        Mon, 14 Jul 2025 09:10:51 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45623f4f838sm5268045e9.1.2025.07.14.09.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:10:50 -0700 (PDT)
Date: Mon, 14 Jul 2025 18:10:47 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-ppp@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Williams <clrkwllms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next v2 1/1] ppp: Replace per-CPU recursion counter
 with lock-owner field
Message-ID: <aHUsB04j+uFrUkpd@debian>
References: <20250710162403.402739-1-bigeasy@linutronix.de>
 <20250710162403.402739-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710162403.402739-2-bigeasy@linutronix.de>

On Thu, Jul 10, 2025 at 06:24:03PM +0200, Sebastian Andrzej Siewior wrote:
> The per-CPU variable ppp::xmit_recursion is protecting against recursion
> due to wrong configuration of the ppp channels. The per-CPU variable

I'd rather say that it's the ppp unit that is badly configured: it's
the ppp unit that can creates the loop (as it creates a networking
interface).

> relies on disabled BH for its locking. Without per-CPU locking in
> local_bh_disable() on PREEMPT_RT this data structure requires explicit
> locking.
> 
> The ppp::xmit_recursion is used as a per-CPU boolean. The counter is
> checked early in the send routing and the transmit path is only entered
> if the counter is zero. Then the counter is incremented to avoid
> recursion. It used to detect recursion on channel::downl and
> ppp::wlock.
> 
> Create a struct ppp_xmit_recursion and move the counter into it.
> Add local_lock_t to the struct and use local_lock_nested_bh() for
> locking. Due to possible nesting, the lock cannot be acquired
> unconditionally but it requires an owner field to identify recursion
> before attempting to acquire the lock.
> 
> The counter is incremented and checked only after the lock is acquired.
> Since it functions as a boolean rather than a count, and its role is now
> superseded by the owner field, it can be safely removed.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/net/ppp/ppp_generic.c | 38 ++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index def84e87e05b2..0edc916e0a411 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -119,6 +119,11 @@ struct ppp_link_stats {
>  	u64 tx_bytes;
>  };
>  
> +struct ppp_xmit_recursion {
> +	struct task_struct *owner;
> +	local_lock_t bh_lock;
> +};
> +

This hunk conflicts with latest changes in net-next.

Apart from the two minor comments above, the patch looks good to me.
Thanks!


