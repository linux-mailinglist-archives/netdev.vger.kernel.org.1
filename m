Return-Path: <netdev+bounces-155522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FF6A02E2A
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D7A7A0385
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2038F14AD3D;
	Mon,  6 Jan 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT+mo1aD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831221DB360
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182030; cv=none; b=uNKFys1xvSkdbEZWAuPGrDf6koBEoj/yXgbUBCR6EjPhcoPtfiZ59jw4Zo6BuNkfQwYVswZJD9NEYWR2wMx+sTGs64o/GwSSK48t4OFWzyah5Z8QbkEHgDV1aKEf8XafKr2R0MFq776nqTFanjAAuRK45zdLR8/GAeYYLphY52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182030; c=relaxed/simple;
	bh=ubzfkcK539cueIPyMs/N/UeMM/K2GzhiTAnUc0ZjYZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFH9/4nzw3JgjqdvZI3nMTdgJqVcTBlmN1hNWJXqjhfUeJUDKsmF1cgicoQ48gim5vgw+01x9vj8NC/lLnbxMHgsUBdTplShH8UFwpXDpTevLKIqQODkkOEZ81aEwkt18Ly+YGCto5wvBpHhC2aJ1gBa9JEva9PWOyATxq+SzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT+mo1aD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21631789fcdso154919675ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 08:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736182028; x=1736786828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=heuAMaMLBTPOz16YVRo4A/lMN+b9MXO3Uy992HyqcmM=;
        b=FT+mo1aD9g1NT6fGi7WgyaDA6d8GLhlCqOCPLO7mAOKztoiGCFFWATQnetABwHjmET
         i6eFWcnlwM+AP1ZRqzQhuRtKZQG6+DmLyYGjiVxv2p8PSBGPZlN2c4ROqI9tqhbnk4Ee
         TdfzMW14zbd7ded/m2LemJdzqa2Ulufyi5beVqRDMDvUBzNELQw8D7AtNbmlyhBbe2eR
         brPLdWwj/nHoJE5HmwQWw6p3kgqJG3bMT9ghjincCNsFWW7o/PhnWzTWN5S5Q1MWO9D/
         aQ15k4OYHjrV3zdSkN2BKPfltOq2ZxWC3hc1b70MHfIjNywmxr4YDq+Kj850JAiOCv5T
         IpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736182028; x=1736786828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heuAMaMLBTPOz16YVRo4A/lMN+b9MXO3Uy992HyqcmM=;
        b=SMAorVpGYEr0oN5QPcsMCWpy06tCnd0UdbYFXT9ldhHpXsfCgrFBJDQbYAme+1BdoJ
         Z3rm56GsnfLCzcjZgvfzQLLH74mh+QJLC8fIKCoy4nirwvWaKmjuSzqZiBWTZLUcK6as
         Nh4FGCpnYCHA6/EOTtmh+8Yr5wkUBrm0sg79LMDPoNqdQxyobifHoJANH4dpQDLXRbjl
         2D6pgpkkgOX3vK8louJKXoYlKN1cbxegRHLUTjJrCkPBoW+oLi9eQ6OOViWv0ECuhX+F
         7Qxjd78fSR0bhCrQ0BAkG/UsbBXt+SlbgALcWG6/qlwpwVuBy3DyMpCXnf8lv8vASbau
         fNJA==
X-Forwarded-Encrypted: i=1; AJvYcCWTBmBZ4pfySLMoJuarbXTtsXDyBAAtIJ6ynOXdxYzQlmNrOQFU+5NAMeVzxdh63zoyZ9j7Kl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3Dtj/Bl0lqhi9/B255RylkJoju/pipNpoBwyX77JHmP8rw0f
	gkMoqEm2cw5OeVUpbxhS72jbg/WRkYVNnKS6NV3V0KXVnJvEXEk=
X-Gm-Gg: ASbGncssvFs+sOm/cBlW5HbBFNszT4oRnXNwiooMY7ZOQFyJSMBDPEGLPpKEUdyxzIJ
	NLBeCj1keprWsS0aOxownJwUZqXh70KGioxm4DZvFL4qO2O1xI1RhrT99ZYsrYxj3kLj1HzqWUx
	DA/qcCqmi/HMhvFKBN4REVYmMcMt2PMv36GiuCWZ0LQ5TTwNUuaSNdK4Fir4MVUUrEVVG/guCeT
	xBOzY+yH31w67OombqFVGX2ma1lDT0whAv532nGyXVhqqJnZXBybNfl
X-Google-Smtp-Source: AGHT+IHXV/ESzl1acWGZ3meBGcyczAWvwr1GEBW9AQChrt2hameNq6SWHVtqfmzUhpmpIblxByz0XQ==
X-Received: by 2002:a05:6a20:12c6:b0:1e1:97e4:452b with SMTP id adf61e73a8af0-1e5c70022f6mr99781875637.21.1736182027681;
        Mon, 06 Jan 2025 08:47:07 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842dc7edbadsm28898070a12.65.2025.01.06.08.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 08:47:07 -0800 (PST)
Date: Mon, 6 Jan 2025 08:47:06 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dw@davidwei.uk, almasrymina@google.com,
	jdamato@fastly.com
Subject: Re: [PATCH net-next 8/8] selftests: net: test listing NAPI vs queue
 resets
Message-ID: <Z3wJCuamNhqEymSw@mini-arch>
References: <20250103185954.1236510-1-kuba@kernel.org>
 <20250103185954.1236510-9-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103185954.1236510-9-kuba@kernel.org>

On 01/03, Jakub Kicinski wrote:
> Test listing netdevsim NAPIs before and after a single queue
> has been reset (and NAPIs re-added).
> 
> Start from resetting the middle queue because edge cases
> (first / last) may actually be less likely to trigger bugs.
> 
>   # ./tools/testing/selftests/net/nl_netdev.py
>   KTAP version 1
>   1..4
>   ok 1 nl_netdev.empty_check
>   ok 2 nl_netdev.lo_check
>   ok 3 nl_netdev.page_pool_check
>   ok 4 nl_netdev.napi_list_check
>   # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

