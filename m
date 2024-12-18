Return-Path: <netdev+bounces-152826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F399F5D9E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545381671AE
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B713C82E;
	Wed, 18 Dec 2024 03:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6FRQOFq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF2381AF
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 03:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734493943; cv=none; b=fNQD6vOXLqN+GDopx0ZgdfM4FufM+sBlDX1SjIE1Sxtl9ghlbDEttCrbuzqDd+Q/sz7ZlRrBz1B4eV6AGAQZpMzla84psTe3iHF5MmYi6JHlS6FlOSC6GjbqD4ITtW7ICG4qBOOqLvrpl18C8irSfCdpb44oX2ysXomuUAJ0kuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734493943; c=relaxed/simple;
	bh=wGoYs5FAOG1SEg4NCX25E1Yk558bxmea9qyw2NuRZaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sirwmy4gStcgz9k76GA9/UHqh6FInMb1X3O4yQHWoMGHOSXBtJVx7kyCG5EuopG6wpZaivG29+bH6CixV/QNt+X5WWQ5rt1pl21TE4c/xBK++AoXHbnGvrcKDbaNvRNdnj8wiMei0y6Afi9oOPAWMkxa5bstUpTpyfThbiM53sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6FRQOFq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so5286169b3a.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 19:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734493940; x=1735098740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=guxvXOqo66pedh51HnpxJJ+QT0AzkgPjJT2ZqUAbNLE=;
        b=f6FRQOFqMzzowS2WBOW09KI8NkyslZvW2l2IjoaNFsrr70KhL2CpuvsGf7rdbwmvNF
         lkeugp8rZMED/n8z7xwHI795wsgz8eJKlEortoMq4whFyQGwo79yR7Hr6hIt+w0d+uID
         VOuAdgttSgsQtkn3JgU62lQuNXWbvHVxDmsdwRULMYILjfrdYaeE4O2I21luqmmtEoIB
         7Z2U5Tmb/KP2zyIL7FJBGClijiDCvDdpPsXbUkOpLpRNLY15abNWjzZPSDfOFPCdh6cq
         9Gw0D8WpmRXTnN6Wg7u18ksFNfaozVRYpx3g6ycZIIeM7riW34+E9DIuhhMFz0puQe2p
         JpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734493940; x=1735098740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guxvXOqo66pedh51HnpxJJ+QT0AzkgPjJT2ZqUAbNLE=;
        b=QbrWhIEikFIcQt8EGVdYD5SV91ty23KTzDNrpaYpjz+N/BgSphGojA4m9Pq8/R+1eb
         im5CSLOuaZLI7bUpfOSiEfZIBVoEoIjtHe7ZNlOYTAeZJaOxqnuZcImUOBmTQGifiAtB
         8CtEN3WhWQ2ZR3LNxOcYmBrRIDoo1YVBSJGzOJoBb+WMQBZwh3eIcGcXpNKJZTg6EF5h
         1MWWzkZZ3LTVyRqnyY1yiQ2XTTkOhx1QtgGCFfCPAApbUuT7EsrNxWNgsqQJ/8aPpB29
         as6auBO70ebcm44L1igAuMEfM1wkwJUFz4WN8UIoo4C5+oNtb8g33iMWGZ33qaVXg8ej
         LlLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5CzN/cNCX//WE6EO/2iDsKICzCWONRCE/7Wm2R5TeKn40AU0JnRZZpdQMGno07wN5Uj+Hy2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzwDe0NIGz/F3vUu7G6S3HqJkYyQzSQOBogiWcXwHOyRoDTLVk
	UFHzOgQR2+UshA1IGJs2a6/jEQHFCH8u6YE+JQArnFWa4PpLLv+E
X-Gm-Gg: ASbGnctMIWTKhxC6lj39RWVxoEGFSuOs9dmsvlKpSKJkuusy+vW+Ql4b7RyPE7WxM3k
	9jDZYW+/LOtECClQrTws+54sbllw8tdAIi5FJzzz+8wOOwgszKuvRsm5SWpIuf7B+VhsKBbqKpe
	ri2DWiKE4g+tkvydQ7s082mtCgzUS0I9hRrT3mwSy/sPD8H1/6PGd0/iK4VpJIZ+hgViGJdqzAj
	pgAC5wF5hl0Uw9aQ1e4IV8A/HoQWMFYkoefl8eaas3bCtlUKE/463mUB2IP5Xi4Om3309jgMywE
	CGKjNRnFjn/uhu7/Q9MxbavotfVKpNMR6lEhj5T7Tv8yeYc=
X-Google-Smtp-Source: AGHT+IEu8Raz0MhrS9gQm7RLrXj+bpX9P5fAnIUip4wZkTfUepAouoAzS+oQ6to04Pyx0X9UKaEAwg==
X-Received: by 2002:a05:6a00:2408:b0:728:e2cc:bfd6 with SMTP id d2e1a72fcca58-72a8d2c4793mr1744735b3a.18.1734493939929;
        Tue, 17 Dec 2024 19:52:19 -0800 (PST)
Received: from hoboy.vegasvil.org (108-78-253-96.lightspeed.sntcca.sbcglobal.net. [108.78.253.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b77290sm7476237b3a.113.2024.12.17.19.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:52:19 -0800 (PST)
Date: Tue, 17 Dec 2024 19:52:17 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Dragos Tatulea <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Bar Shapira <bshapira@nvidia.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5: use do_aux_work for PHC overflow
 checks
Message-ID: <Z2JG8RGcsQXxP-mS@hoboy.vegasvil.org>
References: <20241217195738.743391-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217195738.743391-1-vadfed@meta.com>

On Tue, Dec 17, 2024 at 11:57:38AM -0800, Vadim Fedorenko wrote:
> The overflow_work is using system wq to do overflow checks and updates
> for PHC device timecounter, which might be overhelmed by other tasks.
> But there is dedicated kthread in PTP subsystem designed for such
> things. This patch changes the work queue to proper align with PTP
> subsystem and to avoid overloading system work queue.

Yes, and you can configure that thread with chrt to ensure timely
invocation of the callback.

> @@ -1188,7 +1192,6 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
>  	}
>  
>  	cancel_work_sync(&clock->pps_info.out_work);
> -	cancel_delayed_work_sync(&clock->timer.overflow_work);

Do you need ptp_cancel_worker_sync() ?

Thanks,
Richard

