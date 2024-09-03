Return-Path: <netdev+bounces-124421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A7596966E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0643281053
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 08:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CB41D54D3;
	Tue,  3 Sep 2024 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3Jw46/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD6815573A
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350561; cv=none; b=DpfvzOhLneKtpENjCKr13eW9M1PpI0B67isPGTQZDwSZeDd0rRpcDqCklOyWD7b80QiW+x2mEJHnwXDkpyPaSP/eghctLc3SFjycM4cANaAzRxxnZTc87ztXCUPhUepkN+Km9cye6BJzMAtA5EVH0MZ7keEhOmOYZmY/vz4+OLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350561; c=relaxed/simple;
	bh=k9n4C0oZYeBWDhcob07knRQNHHDONQqXi2UEnyIap+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkZo1b343fwtpR9B5odpMfFiDpA0BY5fwVCNFFgJ3haRdNMwjNRni/FsM6N+Bmsg7rzqhDPvqkMNv0fC62a7Xl+yjjWVjH4xwo7yUXW3LGwUqpnZOCin17+YEP/pXTR9WicSlYO0Z01/ltaPV2sCLYsP7FnOtg3P5ZSNzYLSM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v3Jw46/E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bb4f8a4bfso26803435e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 01:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725350558; x=1725955358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WaDZMPlhusgv+D7EkN0Bnlr03mHZskDfKHQFtMBCp4o=;
        b=v3Jw46/EG12E0rchRBbkiNOD0kNofhghClC2ENoF7rE6cci71d2IiBD/E9M/uACrtj
         RNXuWEtvwaDSEutF5YgLSSx/ttGILQtC9pP+LU2uKWokJizeW6vA6PBcvbpJ8xviYl1z
         L3WNJ2wy0PVemXccokOK/WP1pFrhkx1jvey/jbj5KG/vgcpU7eHGHu/ysbkzt8mB8xGp
         DTay84knH/FO1IaOUOsKp6J3pTX0+CgxfQjsrlroNqUgK5WDw+zx6GggyfTkbgSS7RTF
         +lhjDURVpVa4p1ksjjwtOFm1QQLoAyqPDiCvMw16aojQWyfaBVLnBMchiw11jiYykG9/
         MZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725350558; x=1725955358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaDZMPlhusgv+D7EkN0Bnlr03mHZskDfKHQFtMBCp4o=;
        b=cKXsC6uumgcYjEcPAL4wr2i/orPoiS7mw+1ZlFYZRSiK57X5CnCO9WcZTtqVpM1VZH
         YDuRUFKyZ4DnpPbec4AFPvq1xTcNlFSpM/EhTPv4ZjJWSEJ5CopmjmbvP8jT6PDAa6e2
         ghGl730fAffnQkGFLbfcrAJDwtRUp/reij76GILSy43HHjEmtatpCCqYaM3PagXg90Dp
         KnDaiFy4pVnI9Lv/TtNZMb7KuJJFzq12Ls72jlVqrh9e9kS9d3Os6ORasdz04+j2tGes
         Od/kxfvmmlqOFt52gq+NWcTbnyFE/KzdYCRmBfh72pOwLfctAapS3/peaec3i4rinDP/
         TwqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSlek8PaGalDiyXSj1jiAn6yimSMnGWmuIeu0yVkQAsuImh2hV6sl24SZVjFoD6yHsoQOw75I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGzhOO60Z6mKwhqmAsln1GFj6oY41XN/mvGGfEt02O9bBBkZCo
	ZgeuUZ9UmMi6Y2Dx6+EtASujzw3r8U3Q7QD9/oZ8Sr4o+3EdT06MeE0NfC3UOtk=
X-Google-Smtp-Source: AGHT+IH6ywIVrbCarewFxpSi+q748WVruJR6oGhogvAuoGcgYd3YXzYkagFJrlFQa5K3pVSwc8RSng==
X-Received: by 2002:a05:600c:1c83:b0:424:8dbe:817d with SMTP id 5b1f17b1804b1-42bb4c5e500mr98478905e9.10.1725350557604;
        Tue, 03 Sep 2024 01:02:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbc87773fsm125707815e9.0.2024.09.03.01.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:02:37 -0700 (PDT)
Date: Tue, 3 Sep 2024 11:02:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: James Chapman <jchapman@katalix.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next] l2tp: remove unneeded null check in
 l2tp_v2_session_get_next
Message-ID: <332ef891-510e-4382-804c-bc2245276ea7@stanley.mountain>
References: <20240902142953.926891-1-jchapman@katalix.com>
 <20240903072417.GN23170@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903072417.GN23170@kernel.org>

On Tue, Sep 03, 2024 at 08:24:17AM +0100, Simon Horman wrote:
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202408111407.HtON8jqa-lkp@intel.com/
> > CC: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: James Chapman <jchapman@katalix.com>
> > Signed-off-by: Tom Parkin <tparkin@katalix.com>
> 
> And as you posted the patch, it would be slightly more intuitive
> if your SoB line came last. But I've seen conflicting advice about
> the order of tags within the past weeks.

It should be in chronological order.

People generally aren't going to get too fussed about the order except the
Signed-off-by tags.  Everyone who handles the patch adds their Signed-off-by to
the end.  Right now it looks like James wrote the patch and then Tom is the
maintainer who merged it.  Co-developed-by?

regards,
dan carpenter


