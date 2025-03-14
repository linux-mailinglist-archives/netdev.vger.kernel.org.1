Return-Path: <netdev+bounces-174898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E52A612BB
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 14:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2598C3BA4AA
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A513200115;
	Fri, 14 Mar 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MAv53ZR3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044F1FF5EB
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959221; cv=none; b=V3eiZ5kOJicveKc/4KtlaMR7rwSdFWNkbCw/miYfpIESw2QsywHoFeKlyJncBxS/LjEvZ+mdFZpNAPGVZF9wZDpUmrJHYIaeZPgB+R5nLtUBAdx8fYbzA71RiGlfyTN1rKQtIvVBnDmi4UEvEOCTd3mRkHfAwTGoTU11EvSuXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959221; c=relaxed/simple;
	bh=d6nYAOnyH3aLgSpmuVXmLZid46Z4Vs8LPCpivYexe3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx/hpo6u2DKL40Ms0LIfBIZ0RVnJayIw65W6pdPSetpfrPJp/RSXu1+5YR5HdN8qd4JKmzqsJe8H0QGU3PRVBhuCWnF6bhuZJViNuLYPUTNVkDx20b2306TYvCOD2RDyg5wpLvJcFnfg0Yt7Uoatqjn+8mS2AF5uSBC8TeCml9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MAv53ZR3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0782d787so19789075e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741959217; x=1742564017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6nYAOnyH3aLgSpmuVXmLZid46Z4Vs8LPCpivYexe3o=;
        b=MAv53ZR3lZ/ZO6x1DeH2JRnBsyBPUenJYKKufVEbYK+DnGywsllTDgbqmO7BCYUxqD
         vD+41JFOTWcUpbFhbrcNb+Zb6Qxp1HlL86NtD8HAta6ksYjW7sDAyihmLgDsPcwTZKoh
         LaH5gH1OrxzvF0sDeaGigorT9oq2hLjyF7GmcvLyrzIuc3EWhIcATwm4jmh5qJuNQl/E
         clmexCjdM2ubay2Vid/JNkqKs5q+vL7iD9d9hxUJs8L9Gx+0OgL+6Zq9finVrASnFbIz
         FX9FFvG6pHBfjm1YGtVMYw5XYVv8Ly3T3iCF58ATxRFfKoSwFAHKB3y4FCius25Ypcn9
         xqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741959217; x=1742564017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6nYAOnyH3aLgSpmuVXmLZid46Z4Vs8LPCpivYexe3o=;
        b=f3Tb0bmg5kca5FR/8snBSecqcjkFFk4NUKOLw1zGk5N0zP49/DXDImaXiGbvBcOe3W
         SA8aWtHmxsdtQ0uJyUA62vvacTCfmA5GT+d2Bd5TgNR4y2fiMY5al6Du1CNNeKGTcbF2
         6pyi2bntWI1UPfiOW/oc2Hd5tIKNrLhUX3g+DuNIgrsiTNWgRZdAEqYQVOJKQ3EtV8o8
         pCtFeYEum/DwISWlGdul6nyhc6flqi6TpLhpL7/Z626Aw+/daChugtt9oPeT9IU2xRh0
         mEOpbGngIsF0NFBCRKn2YXFmrliRJERnTVh43NFiALQj34fQ5PBK2jZHaMYtyul7TiVv
         +v3g==
X-Gm-Message-State: AOJu0YzXxGXNhLdDKr5KYSbsnYc3wnlVE2qKMtVF5xiAPQgdYgp58JP6
	RG2rDvnpq7/HMuD6qlvq2+it6nk5RqJGTXPranlSEF2cbo8R0zzftrSO21e2C0+MNI+SylyjgGw
	iP8E=
X-Gm-Gg: ASbGncv1Yp4qx4kejfZ+e8+2zhiDFUXCNHLs1dIG+FrshG2jHLqgrL36QL+IP8iLAw4
	ARW9Mi6Pw0DTdcUFVXkWQcQAh8HgedKuFWRQ7Q9dguHG8HML2suqTaHgI7l49G7JYetDW3Gx0Z0
	qtjK829feKd+MnZN1RpCviD54FJJMjTNK/46eVwEJQFPM+pxVAYrCeP3CfuZv/2zefjXmiFgraI
	nDkZMChTKDY3crjH4nKl1IOrDfYsuHecbIh9x7RYYPEpdOjrJO2bZ5y9+UsPgNJhNDAHG/fDRVb
	rT+JFsvkClj77WBTy4rU8agLGe9tCLXvJI771IoD4TUM/JquRbBcdBMVyAHAhtryYVSiyOg=
X-Google-Smtp-Source: AGHT+IHeiFdb+fGNS1uaaT2H0pTVVcW+JUyfwYRQMXXnCE3skTEHOmterqOB9lWfJE0h/oSaHvq0mg==
X-Received: by 2002:a05:600c:511f:b0:43c:f63c:babb with SMTP id 5b1f17b1804b1-43d1ec72a6emr25542775e9.1.1741959217224;
        Fri, 14 Mar 2025 06:33:37 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe609a2sm17581465e9.30.2025.03.14.06.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:33:36 -0700 (PDT)
Date: Fri, 14 Mar 2025 14:33:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, pierre@stackhpc.com, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, maxime.chevallier@bootlin.com, 
	christophe.leroy@csgroup.eu, arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v2 1/3] devlink: fix xa_alloc_cyclic() error handling
Message-ID: <fzsgorzowhkvegirdyqtum23fchn3ayicl54mg53n7tnrum2s4@fgidqht6kzvh>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
 <20250312095251.2554708-2-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312095251.2554708-2-michal.swiatkowski@linux.intel.com>

Wed, Mar 12, 2025 at 10:52:49AM +0100, michal.swiatkowski@linux.intel.com wrote:
>In case of returning 1 from xa_alloc_cyclic() (wrapping) ERR_PTR(1) will
>be returned, which will cause IS_ERR() to be false. Which can lead to
>dereference not allocated pointer (rel).
>
>Fix it by checking if err is lower than zero.
>
>This wasn't found in real usecase, only noticed. Credit to Pierre.
>
>Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

