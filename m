Return-Path: <netdev+bounces-185623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFB5A9B298
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CD53BC223
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB8E226D11;
	Thu, 24 Apr 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="JOCCm0no"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139051FC7D2
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509166; cv=none; b=MhXoP3YZAUodv/DWHdCo9yKlAsJ8QAQ+FDAHfPqtNjQ32zBWc6O2LGPeqM+bEmTmhfzazVgH3yszanQgLiEPU3DlckEivj3oX9JaBYyEn1QvQL1xaLeKjhCNMLLITEjG93dYAAL49vRh1Aaw3WlPBGH6cIkIvhyw55k/Z7FagxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509166; c=relaxed/simple;
	bh=6Syfv68ya2kxhhOlKYpJGON8W4kq7aWIngNghhx0etM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgnQk6XpVElBCRu3h5YfOzghJCqYlsnBlBBWu6tNSYTLzjjrRpWMbaGv41YbYILKjKpwETg0YVDxmWnJ7LSrQiwMgjqOvX/FE/7bzgORyb8fjRmF7s6T2RjXml91ZtZerzeRlZyqsDlr20J2Y4kG5Pt21TWM526SvLD09MX3f/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=JOCCm0no; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c50beb0d5so2069555ad.3
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745509164; x=1746113964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Syfv68ya2kxhhOlKYpJGON8W4kq7aWIngNghhx0etM=;
        b=JOCCm0no35J0/hVKUoJ6AZze/D9CAEb5oGpbB9bMc8DnYsX0Qa7Dk3+axtSeIO40xw
         FGyeT+6INTX/wvNINKxdT7I34y0d5coTzAxQffroiW73DbiJzKJi9cgcv50hiIWGD4Oe
         ob5oqR+xu2iu/YIsNrjnKxBKFwC2ZC+oP2J0UQKkcyb/JcJ1I9T8d7Cb2pnT2ZJCWa8x
         saEhxI+cboCzAXmsc+L9Ue4A4Xzckpkk70qUMtE82Mmm5G9Tg8kFM73mwh1nnsg013TB
         tq6WVFFCQq0TupqY3fCCXf3e605ufCTrA1jHGzcffeSDBEPwmt3YHaFIWBzc+SnbwJoZ
         rthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509164; x=1746113964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Syfv68ya2kxhhOlKYpJGON8W4kq7aWIngNghhx0etM=;
        b=J5HhbjgmzS6PUdQmndMIRJ4Fb4v43Wl0j3izEJXK4gSZZ9QTjf6jl4e5st+cJMgbPy
         XsiUHlG5fAtIvFXAudnmX7x6svWNDOSvd6qcBOtJN1yOQi/dm3Wo569YmOmZo2DK+Vo5
         OO9moSIK5I3o+jKLDLD3Btfq8bt7JSYmRm0iKdoqkDgPfwsS3PIX09CsFnxR+4W1Fk7+
         u5CZZ/rIRWmmGhX0b8zdhKJplfQd4IPoOjXqMps361q12DXNBCfZ15ES44GgHvyqsek1
         7Jp9Hs1YbWEGf+zYbmoHzikA4aiBggcdMR5AhsLj1MmDWJZXRaTKWmQ71Q7EIF0gI1yi
         tg5w==
X-Gm-Message-State: AOJu0YxSIOXCAlam+vui8FEJup31F2T5KvdWpzGIE1G8CtlMvEchm7rp
	Em/c3aoUKKK9vUuBslRg8h/3fJnm8y4QdNPPvXr+ytpbAS5X4StAooY/7vKGiro=
X-Gm-Gg: ASbGnctmk44Bmd0woJrgOoUlIL3kM3LEdGgmHcJcxsqrNrQpchj0zlWryxcXGznIhxR
	GfFwmYSqWS9CH4+HOx5Jot0me3rUO4LFy23Bh/LjK5admERfJfEwzze/n5jO6l30t8cxJpEBS1g
	OvkGRpidDjmZLFwRE5bG8OmAAGiVdvpVSj0LPX4FLjHt4mPpL2RYeQe4JIPZvbVvfnlyWn8Q1Ep
	da8GJDiiJ09VQabtH5dt8xFAODmXYR82XpscYAZRNJsxmqlxUjrEj4LNX9VDWTi7iasoOPDRnFl
	2ZPMbm3vc4zbJc9nSarcrujkfK4=
X-Google-Smtp-Source: AGHT+IEl/I2tNTHCTuDgjtLrO3THCbXJ8y1SjnxJHINYfNLGwjnowhM0VX+Irll3a++T9633lTd+oQ==
X-Received: by 2002:a17:903:90e:b0:220:e98e:4f17 with SMTP id d9443c01a7336-22db3bb70f7mr15215245ad.2.1745509164237;
        Thu, 24 Apr 2025 08:39:24 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:f4b1:8a64:c239:dca3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7636sm14977335ad.117.2025.04.24.08.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:39:23 -0700 (PDT)
Date: Thu, 24 Apr 2025 08:39:21 -0700
From: Jordan Rife <jordan@jrife.io>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Aditi Ghag <aditi.ghag@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v5 bpf-next 2/6] bpf: udp: Make sure iter->batch always
 contains a full bucket snapshot
Message-ID: <kjcasjtjil6br6qton7uz52ql25udddmzbraaw6qmjadbqj5xm@3o5c2rgdt5bt>
References: <20250423235115.1885611-1-jordan@jrife.io>
 <20250423235115.1885611-3-jordan@jrife.io>
 <CAADnVQLTJt5zxuuuF9WZBd9Ui8r0ixvo37ohySX8X9U4kk9XbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLTJt5zxuuuF9WZBd9Ui8r0ixvo37ohySX8X9U4kk9XbA@mail.gmail.com>

> It looks like overdesign.
> I think it would be much simpler to do GFP_USER once,

Martin expressed a preference for retrying GFP_USER, so I'll let him
chime in here, but I'm fine the simpler approach. There were some
concerns about maximizing the chances that allocation succeeds, but
this situation should be be rare anyway, so yeah retries are probably
overkill.

> grab the lock and follow with GFP_NOWAIT|__GFP_NOWARN.
> GFP_ATOMIC will deplete memory reserves.
> bpf iterator is certainly not a critical operation, so use GFP_NOWAIT.

Yeah, GFP_NOWAIT makes sense. Will do.

Jordan

