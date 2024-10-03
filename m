Return-Path: <netdev+bounces-131662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0FA98F31C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 409FDB23C62
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544001A4F35;
	Thu,  3 Oct 2024 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bH7ch1Uv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91FC1A0722
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970376; cv=none; b=bQB/M2QRdR5IiBZWG2EDNCadolVQOXjRvoonffuzpG4CXuxQjjUnyWrccuZwpFgfMg6nFyFKoH0326d53zt0vpEwIYdQjtzIy98sm820tpHmbdxteBVwMZvlyyCAP1jLiEBK0aVNZFnxlFF+zd1X1HTlRIzH3vEk6e+TXBAfAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970376; c=relaxed/simple;
	bh=c24CSpB9u0bQiRjmqj4Py3erZup2Nm7AdiMa7TDZqlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyDNjaf+U0yp5p1b3Y3JWa1Ugx8l71CjoxZdBAForCteMEu1se88ZmWt5xz0mfD+aESR+Ox1gdGNdP+1XyRal14WDP7sqxK4EJgh3b+j0OnZy6T9G+SPfJfVeDwWOFucVJ7b077ETkmLeSvVkSrSWhtJEMDuQ+PwFE3Eu07KbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bH7ch1Uv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b4a0940e3so10284345ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727970374; x=1728575174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vg9O2bmhocfO75+5ltClKdx7MUK6nTYdplQZgbhltGY=;
        b=bH7ch1UvbPWdf0yI/yx4DtUYaJPGbkMnUJOB00qULLvwiSl4PwbV7YXaXDIT9XFb4s
         cKsmjLCYzzMVqXLzCOhIrPtv5PgxI3E5ETiqBi9X7PUguxCA9sM/Ma08SkwOFaqm6q70
         mDtwK+WbmXrTQbTCUgC7ZEz54ENXm1jiPdGjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970374; x=1728575174;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vg9O2bmhocfO75+5ltClKdx7MUK6nTYdplQZgbhltGY=;
        b=VDanjo76uQGsKE2iy7jIHhyfDPPWnIRYosZehbnqENMVI1t3VrimyU31d3gS9G9JgP
         oN/Z14+7e+ykkBes8Peee5AFxqp+io7g4DP6EHysu7asnlhpMiot3jx6SpNPLTSyKzfw
         YmaGboQatxMvxaCtApPMUHhgy2HAWnGJ8HNO/Va8cfDPeIyhTSTr32kQ2Wvgr/uXzBzV
         wzgxAY7LNnXcCejE+viDuE/7FJaL27aMxHQrm7BY28ZqgYn1v039MEnI8qj6WEQpyNhl
         w5RbgJWVein4W03uUz/83UHMAXrxhF6qDQaU6ndQPgaeBGEm9rlDIAICZc9hiev01ggn
         M0yg==
X-Forwarded-Encrypted: i=1; AJvYcCVxusX6dPSQB2NC52EZTncqGMwgqyb6ArlsS5E7AibMrubnQMvwsPb8Y6cf//xYrjOpFxyVlTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvhGiLtRbzLml/OQSOPicDdeSMPAq4A5xncDpFaKJztND/HKry
	2nctnadKVSxhZhH0i2eZ4FEh2skLy0zUNy2cVuS93pNg8q+OuiAxOgYI15hPAkk=
X-Google-Smtp-Source: AGHT+IHJZ2Cva6weRJymSIYfRl+TvfkC3DsPe7+bV+X6mtLTATN118ZY6+JXSzlo5Pl23BKacVdE6A==
X-Received: by 2002:a17:902:e84b:b0:20b:937e:ca1e with SMTP id d9443c01a7336-20bc5a0a801mr103188475ad.18.1727970374142;
        Thu, 03 Oct 2024 08:46:14 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca2256sm10523285ad.91.2024.10.03.08.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:46:13 -0700 (PDT)
Date: Thu, 3 Oct 2024 08:46:11 -0700
From: Joe Damato <jdamato@fastly.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 1/1] idpf: Don't hard code napi_struct size
Message-ID: <Zv68Q4ur4-ZVTmaL@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@kernel.org>
References: <20240925180017.82891-1-jdamato@fastly.com>
 <20240925180017.82891-2-jdamato@fastly.com>
 <6a440baa-fd9b-4d00-a15e-1cdbfce52168@intel.com>
 <c32620a8-2497-432a-8958-b9b59b769498@intel.com>
 <9f86b27c-8d5c-4df9-8d8c-91edb01b0b79@intel.com>
 <Zvsjitl-SANM81Mk@LQ3V64L9R2>
 <a2d7ef07-a3a8-4427-857f-3477eb48af11@intel.com>
 <ZvwK1PnvREjf_wvK@LQ3V64L9R2>
 <20241002101727.349fc146@kernel.org>
 <b7228426-1f70-4e36-9622-c9b69bfe5be9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7228426-1f70-4e36-9622-c9b69bfe5be9@intel.com>

On Thu, Oct 03, 2024 at 03:35:54PM +0200, Alexander Lobakin wrote:
[...]
> napi_struct is the only generic struct whichs size is hardcoded in the
> macros (struct dim is already sizeof()ed, as well as cpumask_var_t), so
> I'm fine with the change you proposed in your first RFC -- I mean
> 
>  libeth_cacheline_set_assert(struct idpf_q_vector, 112,
> -			    424 + 2 * sizeof(struct dim),
> +			    24 + sizeof(struct napi_struct) +
> +			    2 * sizeof(struct dim),
>  			    8 + sizeof(cpumask_var_t));

So you are saying to drop the other #defines I added in the RFC and
just embed a sizeof? I just want to be clear so that I send a v2
that'll be correct.

