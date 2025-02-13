Return-Path: <netdev+bounces-165999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE2A33E38
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C407A0F92
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50802227EB6;
	Thu, 13 Feb 2025 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8zs1dNf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB01227E8D
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446671; cv=none; b=G8+edQw3G1ZPh7hwEhgYnTL7ZQsb5i0XjnpxqlH43LWUfSsLab7W+BW2SBQvFeAE1RYLoWDOaeHP63SXm5S7ttHb3vJa/+1Y4sBBLucw0vpCxL/vwXiIcLjVm0Th88Q/Rj11d5iZsj+uqUFtE78ocC1WzwBuPIJDSJ/Rtr1Bka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446671; c=relaxed/simple;
	bh=sEjVcKabIC5q5CXCl0Zc3jOe4AF5dToYVjvV7OxKEAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnEnVo9Js4uFgrhdxetxVmxn+PiBlPo77BRORNf4q78RSHM8+am50TSika6nrNMyFkYpUsd+ugC7OjYcWYXe4s+yCo9e8fmaOylwni+/quQFgUDh4eJshnazCPGHNe76nNzTqdA1z2PIxwNdkb7zk0CQqfSukCn5h+kiXxFc+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8zs1dNf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739446668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4OijfIsJy9yRvlkFW7fHaLrYrkAJ4i+aY9VG5Q1Rm0=;
	b=A8zs1dNfttt5LQOzF4OpiCmtJdpimExT0ERBq5qRhsR32i7Xd7cCAhm7KllxsfR0gm8aUA
	h5WkgundCmQIPLvQNv5N1Yo0SRRxy9l4VTRRcDUi17UVgeTNrcMqPhxREq70xs2xfTr30f
	WesW5dNkNe/ZUW8mrdasWPfKAy0SimQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-X5NCLHlBMd23yBfwk_K0dw-1; Thu, 13 Feb 2025 06:37:47 -0500
X-MC-Unique: X5NCLHlBMd23yBfwk_K0dw-1
X-Mimecast-MFC-AGG-ID: X5NCLHlBMd23yBfwk_K0dw_1739446666
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43935bcec74so4223515e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 03:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739446665; x=1740051465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4OijfIsJy9yRvlkFW7fHaLrYrkAJ4i+aY9VG5Q1Rm0=;
        b=MVLdVNqb4FDrfE4O0CghaX2yqsWjS4jxBm8xrI4Qu+MUXwoc2y+zc7d1KXyHRJjGJV
         j17WSFxDjMLfZF/g+/4lzgqFDdyNx+UJXd8DxAtuyPGHkIN/x9QBIniDSEyWYL9e2YAr
         kO+Q6r6vjHDvKU/qhqBLxYY/MqEwUk3wXdUuu2b3+RIepyl1fCJfEgg6xm3N4pKGcynA
         a4cwrhNxncXljnukOzE/ATZdk/dauLTKEUlI5tiLCwwLlv+RZ3kpoERv86rzVhGLRPEQ
         RTOzy0FvnL4pJSeoI6hMCPNjoWHZHku5MpIAhX9p55m6HGhJTncjKwGMHVkWhZMPk0FS
         6wkg==
X-Forwarded-Encrypted: i=1; AJvYcCV5IzNdTGE+liZsK58m+30prziZqf3ifbN694CMTIJYS2oM6acYsFWepjD0FHuZIcWedIe8LVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlR++8jyQ7sYKEAevgofu1PjwhpuDauulNdaYbhJMutPcXkZSO
	vyuQ+HMPN4B2BZIyhhqgRyxebBm8iKzbngLILdC8+30yx9IeFsu68wAtNY9d3euiZDrJ9ofA1GO
	B9cwEzgNF7gsSzl96FcaUplI3TUT9BQmIM5SZ9V+l74k9iY5hTfRDvZvkeS0/jQ==
X-Gm-Gg: ASbGncvQPksZPCMfmEu0S/lt0tUlNp9iukr2fzoRGn2IrcWoMPl2IkJxhLZBD/lVQlv
	aYBZoJXotauMgqjRqeQZOQIlF+JT8mvTyzmySJbyrxteEVG1TmRxWSd6QUNYZgp2kEHv0VQj08s
	ZL69cDqsbRxKvR8tOFBh6YiNAZp7iSLprQiwqmzowUkSudmHXkJM0/U/a87bI1TB1lzZJBn10+j
	Gaw8XQojzRSZDnxGbVe7CP4bienJ40B9AKR8G9wDmsKUA3gA0/1EBTtHZrS+xteLM7cbkknn2Jk
	cDQ44BWGrS7LijC6JkXIhrPDzqENRXqh77U=
X-Received: by 2002:a05:600c:1991:b0:434:a929:42bb with SMTP id 5b1f17b1804b1-43959a5290fmr62880805e9.18.1739446665524;
        Thu, 13 Feb 2025 03:37:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/qJS/I9WQnlC47h7CMBYrw7MSkEivmYUNWNnliL5vRPpLogYMVyAbPyyhwNJJe7crdnyk4g==
X-Received: by 2002:a05:600c:1991:b0:434:a929:42bb with SMTP id 5b1f17b1804b1-43959a5290fmr62880515e9.18.1739446665141;
        Thu, 13 Feb 2025 03:37:45 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06cf2fsm46009225e9.19.2025.02.13.03.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 03:37:44 -0800 (PST)
Message-ID: <a360c048-96f3-486e-a097-e3456a6243a8@redhat.com>
Date: Thu, 13 Feb 2025 12:37:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] posix clocks: Store file pointer in clock
 context
To: Wojtek Wasko <wwasko@nvidia.com>, netdev@vger.kernel.org
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 horms@kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250211150913.772545-1-wwasko@nvidia.com>
 <20250211150913.772545-2-wwasko@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250211150913.772545-2-wwasko@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Posix clock maintainers have not being CC-ed, adding them.

The whole series is available at:

https://lore.kernel.org/all/20250211150913.772545-1-wwasko@nvidia.com/

On 2/11/25 4:09 PM, Wojtek Wasko wrote:
> Dynamic clocks (e.g. PTP clocks) need access to the permissions with
> which the clock was opened to enforce proper access control.
> 
> Native POSIX clocks have access to this information via
> posix_clock_desc. However, it is not accessible from the implementation
> of dynamic clocks.
> 
> Add struct file* to POSIX clock context for access from dynamic clocks.
> 
> Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
> ---
>  include/linux/posix-clock.h | 6 +++++-
>  kernel/time/posix-clock.c   | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/posix-clock.h b/include/linux/posix-clock.h
> index ef8619f48920..40fa204baafc 100644
> --- a/include/linux/posix-clock.h
> +++ b/include/linux/posix-clock.h
> @@ -95,10 +95,13 @@ struct posix_clock {
>   * struct posix_clock_context - represents clock file operations context
>   *
>   * @clk:              Pointer to the clock
> + * @fp:               Pointer to the file used for opening the clock
>   * @private_clkdata:  Pointer to user data
>   *
>   * Drivers should use struct posix_clock_context during specific character
> - * device file operation methods to access the posix clock.
> + * device file operation methods to access the posix clock. In particular,
> + * the file pointer can be used to verify correct access mode for custom
> + * ioctl calls.
>   *
>   * Drivers can store a private data structure during the open operation
>   * if they have specific information that is required in other file
> @@ -106,6 +109,7 @@ struct posix_clock {
>   */
>  struct posix_clock_context {
>  	struct posix_clock *clk;
> +	struct file *fp;
>  	void *private_clkdata;
>  };
>  
> diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
> index 1af0bb2cc45c..4e114e34a6e0 100644
> --- a/kernel/time/posix-clock.c
> +++ b/kernel/time/posix-clock.c
> @@ -129,6 +129,7 @@ static int posix_clock_open(struct inode *inode, struct file *fp)
>  		goto out;
>  	}
>  	pccontext->clk = clk;
> +	pccontext->fp = fp;
>  	if (clk->ops.open) {
>  		err = clk->ops.open(pccontext, fp->f_mode);
>  		if (err) {




