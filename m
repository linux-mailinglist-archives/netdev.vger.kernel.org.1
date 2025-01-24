Return-Path: <netdev+bounces-160686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84ABA1ADF9
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 01:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA12167718
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 00:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B591CAA72;
	Fri, 24 Jan 2025 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blE8CLRD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7851B1C1AAA
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737679148; cv=none; b=IKFevYVKUEGX9gTHCmYmmp933cycD+KhdUSBvbCQLtyJs5VFab3u9njGrlUSQtiVvZ5hVX9ZjxlxfVevNofk7AgTmcHZnGaAQuqS9bbBqT5I1PyM08yqRoWiQSapI9Ia66ZLS9qT+74DijoGMOP2EUtWqfc+EO83DAbaYE+4G54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737679148; c=relaxed/simple;
	bh=o3Jv1AxUgpQlG5mJGOIuy5qwkYSWgkeIRxu+tGAsvdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJTZE2XI1sAVmAlZya2VHzJq839QJGuD3pzBf7ae6YhG8LK3ZYEdnFaG/KHbc/yKDxnrrjFHmfOKjFXFYG0uqgQv8OkdN/YnxN6jcVnQHbEePzkl/LUadkTBgQ2t98yyyuZxyLA/16mvWasPTgYjyblXBErd/RGJQspDVlEzh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blE8CLRD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21670dce0a7so31358875ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 16:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737679146; x=1738283946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dr4kxokhtZlr1CwUYsj3V61KWwb6PSjIwBmkh4aWAA=;
        b=blE8CLRD6qWnhktH6ePEYVkLzRHY0+LSASOEdCwqzicEnBUj1imF1wXqU7Je9Cc3jM
         l8A21dQfbedBVf6x7zLNyziwlxVu0Bcxfl+SwxB3Bl4YWGaD/UQ7bNjghJiPnRcrm9Q6
         iZL1n5vDsKmgo1fB0oGFdICLyU9OENZLR9FxHC7KvX3prtMUruAAFlm7s1tOft0dZGu0
         4lOdkd+bQ3v1grBygLup06nigoYUMNBW028uf4XekA4ZrWdX+SRPfTys6ZJDTibeERZw
         y56e2u2B0q0/x8S2LqGFGoRIgB/+BVm6j1EKxxKM4IJ1g5dVCusvXZwt2QXcltX8jm0u
         7VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737679146; x=1738283946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Dr4kxokhtZlr1CwUYsj3V61KWwb6PSjIwBmkh4aWAA=;
        b=QyW4jjlxKgPF2CvZl5chPWq3/Y45bxlZzU4UGIrGs3bpCn9h317cPwxuw0egXMMjcG
         YX5D7AxVvDoxYNxfyy/hHCgL3kRFSi1tIOZUrQ6/7B9hvnjgphKQZAA8xb6dtNBu3S1l
         meQlNZXL3r24tjfxs3x1UqP/70JLrb/hhz2ZIsMHu35SI9p01ESfCnRrXwtw2M9gTnMv
         Vq4V5L8fQyuEB4OW0kqiUYHwTUrYA2RR1Iv1Pgk30cl3RAooodfUuTVrXksdiCI98/WH
         a2AWrbiGLxJikkOzJVzbWfwNAdkl53RdAK4de/uiKZhnduP4V98dnuRvCFqLmkrrVxUr
         Sbww==
X-Forwarded-Encrypted: i=1; AJvYcCX0WjwBEHO3EhxFNX4LegDvcKGTt/dh7YFFTVoKjLf5jqAemuAiBUYzN0/Iz305ZFf7YrBkk3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtkMKXW/XaIPgqvdK5q5S4tE1feecSUDpRY+IGMB5I24PZ8uj
	5pGERo5N0SpIR88uVi9DwbFOEBB8mEOJfvpzVieSbvf0D20rH/M=
X-Gm-Gg: ASbGnctmclRlDr70g+Qw290pg/e2SexUgkFOQ46MIl+6Qn0bEk6AS/ciG8iRn291e7A
	I0e7d+/td/UbjMP95VQSAtidhTH4IpoMhwT4Xfnhz2nw7vPvKOk+8Nlozxa0AxZzZhYSDmItSOR
	HdB3jJMBAu+ASY3bJxJbc2sydsGBVt/751aVpfOmkzY+59sQgIgF3q/TDDQrbrbxGbU9KC3iqUc
	VZ7fL1N/nTnbOz4digOAT6TMNfHbq7uoaiydpAWjLk+N7rpPuBMScDdrOPSZ3XIvvMKvyi6Gwpb
	GVJJ
X-Google-Smtp-Source: AGHT+IEiaTTPo1xX82SyZ9A4vZyXNped0D+x6tVje48SJ0NB6+cRVzX239t0enq2qvq4odLyGrvgyA==
X-Received: by 2002:a05:6a20:9144:b0:1e1:a9dd:5a58 with SMTP id adf61e73a8af0-1eb215ec11cmr52027854637.30.1737679146439;
        Thu, 23 Jan 2025 16:39:06 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac48f897339sm384272a12.19.2025.01.23.16.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 16:39:06 -0800 (PST)
Date: Thu, 23 Jan 2025 16:39:05 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [net-next 10/11] net/mlx5e: Implement queue mgmt ops and single
 channel swap
Message-ID: <Z5LhKdNMO5CvAvZf@mini-arch>
References: <20250116215530.158886-1-saeed@kernel.org>
 <20250116215530.158886-11-saeed@kernel.org>
 <20250116152136.53f16ecb@kernel.org>
 <Z4maY9r3tuHVoqAM@x130>
 <20250116155450.46ba772a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116155450.46ba772a@kernel.org>

On 01/16, Jakub Kicinski wrote:
> On Thu, 16 Jan 2025 15:46:43 -0800 Saeed Mahameed wrote:
> > >We need to pay off some technical debt we accrued before we merge more
> > >queue ops implementations. Specifically the locking needs to move from
> > >under rtnl. Sorry, this is not going in for 6.14.  
> > 
> > What technical debt accrued ? I haven't seen any changes in queue API since
> > bnxt and gve got merged, what changed since then ?
> > 
> > mlx5 doesn't require rtnl if this is because of the assert, I can remove
> > it. I don't understand what this series is being deferred for, please
> > elaborate, what do I need to do to get it accepted ?
> 
> Remove the dependency on rtnl_lock _in the core kernel_.

IIUC, we want queue API to move away from rtnl and use only (new) netdev
lock. Otherwise, removing this dependency in the future might be
complicated. I'll talk to Jakub so can we can maybe get something out early
in the next merge window so you can retest the mlx5 changes on top.
Will that work? (unless, Saeed, you want to look into that core locking part
yourself)

