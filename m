Return-Path: <netdev+bounces-232134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B126C01B0E
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAA825647DF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE6C328609;
	Thu, 23 Oct 2025 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="ZX3m06/1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F531BCB8
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228496; cv=none; b=lJ3Eu8Isb/KiTwZXntG0L5s7TxLWQdL0nrhJ++9cG3RA2gCJgGQBU/y3Uq42qqY3qAtAPF7Ai1gbAjADmpoAYXqUVEvxBXPcUBIbBEkwzw2W41TG+ueuBTFYjlNBewLdC+YsKNe2xD3/Yi+Y6jScn8jXYviCU01SFDceFxrgrOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228496; c=relaxed/simple;
	bh=n4X4X7SUyozPZ0bqAovQu3/scLwKjNDRu2a99yczp54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L82STYRr8NvlplHBUQcmq8eyBzpFcObJ2VhWUqZStwvWKChgBC42CKP7XL6qwFM0mzcubx/eu3Wab/pFgosiXj13m61PPUYBcp3ar9VjNJdJmn4To+WMdJo6Gkj/S1q+JxpdrAdPijm5LcxWSR3mUuNxqAj1sIFd6sSsFgZ9Av8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=ZX3m06/1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso514509b3a.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761228491; x=1761833291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNQ7dzjI4p/gbkTSgLFIgujWu/iSPV8tz3wRWmntWfM=;
        b=ZX3m06/1bRnovFp8NUYLBc718CHb1wXSmXpAANcmPS8DCiqgZ7rctp/2yrwz1TE4C+
         rXHiDHSmb9JQnQ2++g8O5dhYtKRcn8jCbv59wWzWXk2x/N/wu6vuL4DM7+7Okr6acvxw
         IDMv2c66wm3voWzC2N0tCVd/Seae0hGWTjGS5rad90+emxbr5Fge7K5BDIP3lmPJ4RD2
         dEdT/cC992aH2+wHJy/tFofCe8lJKm58mDMo6B6KT9+II+ypQBLZ0SyyARl6A65fp/IM
         qCDdGlEQ0kCq4JHxCmmrW4ND/7ChSkeD1etukhAJHrJvUgJebPF2rPlvn1cl1b56iiMO
         ALPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228491; x=1761833291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNQ7dzjI4p/gbkTSgLFIgujWu/iSPV8tz3wRWmntWfM=;
        b=YIvCm9gyyB58ZpycGfEA8qVufCNwP+cw0jlq3lSvT9lbRFzcaONMEesciZ3BlhumAK
         wDTPR7Suu4pqrbU4MeCkIwAlvpaaTUl7PTmJ243b4IrVYSM+1SP0/YlKubE13C0jRomm
         MNDGCXqEVy/HV2HOAFZoareuyAUM9luGoWhBAEd6h5Ve0OaSgFopj/FtnO8JCEeKIbnD
         7fUg7831Cfm6htEaqE5c38+dEuQBQdarrZW5Z1p/sv9wJ6FoJINgFESa7kP9BnO+jeNQ
         990ut0pJVrX0oUEaqMaz+RlW3zXJQnfAy+PZkIwpdFC7lANQWygTv8PJ3cH9Xp0gfWAi
         e1Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWUj/kSbGMQHQ0d4ykySTZkkJlGrnLIA/YRQKvH/v7YwWDOjE/aWJgTFzCTavACSvCD6oLuhmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF3+WuX8KJ7MZ8mS6ceySh/HQ8zIVHUI45v6dF2ngHU01gHgS5
	zF+MGFg2vzLndh6iKXPjkrcFGNxDF4VOWAYJmoctHM1ib7IlYkQej7BV33gMcmjftJw=
X-Gm-Gg: ASbGnctHH/yog0eipCwp+Dv2RhKB+l7gSXaZh1l9XUxGSO2p+6CdcrzqQ1OUTyJngl+
	ND//0sj8VqMzffTEZpT0PS+5ljZrNMCGVB7GGEn08Cyxnu9fQihjLx70a2Ppt2o8sytLbyW6a2d
	QfA/h6GbYRMJJkj57D51fYfA7Ub3oSxUCD8c3YYvNG0AKG5U2H9NIYm3OMvjzftRDoQ1IF5PMMa
	WjY9/OrVTGlsL63gPen8GCmaClp1C4x8k1UcJyJSdfKtWu5+8bPRRwu9WcaFgWqdPnGR9xcqkJE
	3ttbHzRa0bR2ZiR38o9mX3F14pM705TIVIf5PMfyAHspdRrMujJtpS+qjUOhMG+1XB1nlQrrzZm
	E3PUv1WKSrcaGDQxUfKiKZt2v3cmh4Y8ScldneTssb6ALpUYUgIqO9c4G/82R3sP8
X-Google-Smtp-Source: AGHT+IFIk1AEgNDS635FrgFPUtF0AK+SRPzmZol9htufxZ0vVKc560nqGu/0gFmh5PqFsYkr17F4Sg==
X-Received: by 2002:a05:6a21:328a:b0:334:97a1:36af with SMTP id adf61e73a8af0-334a8523ebbmr31319934637.13.1761228491245;
        Thu, 23 Oct 2025 07:08:11 -0700 (PDT)
Received: from essd ([49.37.223.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e0a3f0sm2213697a12.20.2025.10.23.07.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:08:10 -0700 (PDT)
Date: Thu, 23 Oct 2025 19:38:02 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, alejandro.lucero-palau@amd.com, 
	habetsm.xilinx@gmail.com, netdev@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] sfc: fix potential memory leak in
 efx_mae_process_mport()
Message-ID: <3r4emi6jl3nswdh3tq6krikg4ecxci7mpbmjrxlqhgrv77fnrd@a5blbfyjmjtr>
References: <20251022163525.86362-1-nihaal@cse.iitm.ac.in>
 <bf3d9390-f1f6-428d-b47f-81d2ed1707e9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf3d9390-f1f6-428d-b47f-81d2ed1707e9@gmail.com>

On Thu, Oct 23, 2025 at 12:27:19PM +0100, Edward Cree wrote:
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> 
> It might be nice to also add a comment on top of efx_mae_process_mport()
>  stating that it takes ownership of @desc from the caller.

Sure, I'll add the comment and send a v2 patch.

