Return-Path: <netdev+bounces-164045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40917A2C6FD
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0596169F37
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3932238D52;
	Fri,  7 Feb 2025 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKfNU98S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A83E1E1A33
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941985; cv=none; b=lMCeJZcGkQE1v+boBR8trOaZ/pzFhUBXqXRIYiR0vWhXxeXYFFHF8k6C87vkvQ4lxPl2xLt0jQEkTCjybb1f/ShgWDycz+C9LuFFDKHMkuZAR1qf9/0iHok4CdaNSOUlBDFjChKbhGpKt5HArB6VfSpbsYKYoV6QtD66V5+p+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941985; c=relaxed/simple;
	bh=zBPng1Z4j+81ATLBfANiXTDWRv36O4arqIEJVNuWWlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/G2kwsQRglEYwyFNwlU6r6aqxrJ3H1NKkTAA84PvoFND0/Sv+opeqAFRhJPJiGe3HvfN7x+vQGP1NYDQu4jSSOeJZNATn3xRDjFe5z+b2ODHGrotAGZDFqX0nLjX8zlxdHW7tB6xROrel896mbGajYtaK08Dagc8zZraQ3UwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKfNU98S; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f62cc4088so5726035ad.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 07:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738941984; x=1739546784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qH6MgQZPIzzSoBMXCHCLrvEEYKIOfyFbSbgbL4VCw/U=;
        b=VKfNU98SD7iSrugfVW2zfhrs5c4WZHn7N97Vc7ERNO51kbWdx8HcpGHVYj+hPSw1+W
         Otc2s+AUsUJHHxA5Gdh2YmPE4crmvs28hVg6H3j538aAUzggwknm3BW+nKtMjcHwSbO9
         kZ2IwG8j0zCG6mJtsoZArx2EIDxrIC//aTOaRszXA4YQJ6hDkYS5zSXRx8AlpT7KyHKI
         cSXSfMgouxMBiYJKAT7MB3jXcW33etohDT9W9aYzDBEpqbOU38qr3WS4mje3SMNmyNZA
         sEQzsaNIo4TVu7Wje8uUZEMNNko5GFD3lhANw42GL3+n96gQQjB0KrkPsw/bPSN4Iqad
         1yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738941984; x=1739546784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qH6MgQZPIzzSoBMXCHCLrvEEYKIOfyFbSbgbL4VCw/U=;
        b=gEStCZLDpiMY3HY9Yn2sxvVmPekcSalu71KCr0/yUpEAMiUJ4GPGhcNzuPfwlc0N9Q
         9ECN+1JqtlKpCovNgqvI+6T6XnWeGm+BMPfxT6PMVaP5TWFtNlNNenCR6OWTvxs1dum6
         slRPTe9bdoUf3z76DI6Czj7QNp8RFL3C67lsG6PXo+IB/PCB+CzsJgZuTjo58toQ5CTn
         c3cpM1fXTgogfLMFxXPux5WiUquLv+pKYjmqUxbEUjqWbPl8UX6/GVnWaZnJBXiVBs5o
         f2/GYMGY8DbybdcuW6AyoxpaKAhxVm9hhmo4AjAoCYcOxj+udxIVNnWwGG3MPO95uvbj
         Yk6Q==
X-Gm-Message-State: AOJu0Yy6GRFvOZdcrbYJz6S/kQIiTqp3nS3qHL8pF2H7dJqcHnhjipXB
	KhK92Pd07VpibRCMg0iqmzhf5s4vw9SfcitVq5RDkr/J1zqhqVGN
X-Gm-Gg: ASbGncuNR/i3ogcm2HrL31wpc2cl/5HHwgHmgcgNjBzo0qZKQN0o4RSa7PARSJWCBh/
	PJl3hQA3AjxfZezBRvemUxQfayThCF/DtPIqlXRgKqZNL39P5HeA27cmoQXJfnxMp2Eu/TUQue9
	s3dMXK8AP2j9ugn7Nyimb2jhpO1Zvt+6VVqHn4dBx0cf4dtXc5ZTivewaa1HzCbLPMOM/GCmoKN
	ZKd0cf1ahQc6ag8dZwAuQ3sxxzT1ajDFMPcCc+vfqxctW+PMdsdR0Qnypt0iU+rGYrzwl+82suT
	YW1aKCrgWZ3fpebLnjpcM36TM5RAmH3FtZeP6feJXsFOrbmBSpCIBCQ9MQ9cDqpiKnCivC3bPZr
	nNjnRfw==
X-Google-Smtp-Source: AGHT+IET/VYTm8OrZN2I0IjS8UXDbg+GcdA+zSWgjB+J+oXZhYuiZY9xu2Cf7Wv4bPD8jhAS74xncg==
X-Received: by 2002:a05:6a00:420b:b0:71e:e4f:3e58 with SMTP id d2e1a72fcca58-7305d4e7461mr5666053b3a.17.1738941983079;
        Fri, 07 Feb 2025 07:26:23 -0800 (PST)
Received: from hoboy.vegasvil.org (108-78-253-96.lightspeed.sntcca.sbcglobal.net. [108.78.253.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730574176e5sm2322542b3a.63.2025.02.07.07.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 07:26:22 -0800 (PST)
Date: Fri, 7 Feb 2025 07:26:20 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Wojtek Wasko <wwasko@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net-next] ptp: Add file permission checks on PHC
Message-ID: <Z6YmHF6AeOwYkg8p@hoboy.vegasvil.org>
References: <DM4PR12MB8558CE01707ED1DD3305A9FCBEF62@DM4PR12MB8558.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR12MB8558CE01707ED1DD3305A9FCBEF62@DM4PR12MB8558.namprd12.prod.outlook.com>

Wojtek,

The commit message is much impoved, thanks.

On Thu, Feb 06, 2025 at 11:03:35AM +0000, Wojtek Wasko wrote:
> Many devices implement highly accurate clocks, which the kernel manages
> as PTP Hardware Clocks (PHCs). Userspace applications rely on these
> clocks to timestamp events, trace workload execution, correlate
> timescales across devices, and keep various clocks in sync.
> 
> The kernel’s current implementation of PTP clocks does not enforce file
> permissions checks for most device operations except for POSIX clock
> operations, where file mode is verified in the POSIX layer before forwarding
> the call to the PTP subsystem. Consequently, it is common practice to not give
> unprivileged userspace applications any access to PTP clocks whatsoever by
> giving the PTP chardevs 600 permissions. An example of users running into this
> limitation is documented in [1].
> 
> This patch adds permission checks for functions that modify the state of

Can you change the wording to imperative voice please?
(grep for "this patch" under Documentation)

> a PTP device. POSIX clock operations (settime, adjtime) continue to be
> checked in the POSIX layer. One limitation remains: querying the
> adjusted frequency of a PTP device (using adjtime() with an empty modes
> field) is not supported for chardevs opened without WRITE permissions,
> as the POSIX layer mandates WRITE access for any adjtime operation.

> @@ -108,16 +108,20 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>  {
>  	struct ptp_clock *ptp =
>  		container_of(pccontext->clk, struct ptp_clock, clock);
> +	struct ptp_private_ctxdata *ctxdata;
>  	struct timestamp_event_queue *queue;
>  	char debugfsname[32];
>  	unsigned long flags;
>  
> -	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
> -	if (!queue)
> +	ctxdata = kzalloc(sizeof(*ctxdata), GFP_KERNEL);
> +	if (!ctxdata)
>  		return -EINVAL;
> +	ctxdata->fmode = fmode;

This will fix the issue only for the PTP "sub-class" of posix clock...

> +struct ptp_private_ctxdata {
> +	struct timestamp_event_queue queue;
> +	fmode_t fmode;
> +};

Can you please move the `fmode` into `posix_clock_context` ?
(or maybe even the whole `struct file`)
(the change to posix-clock.c can be a separate patch)

In that way,

1) Future implementations of posix clock ops will not repeat the same bug.

2) Less churn in ptp_open()


Thanks,
Richard

