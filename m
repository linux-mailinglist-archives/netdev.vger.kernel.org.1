Return-Path: <netdev+bounces-226493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A79CBA1045
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1477E3B498D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C566A315D33;
	Thu, 25 Sep 2025 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLAgERx2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1E525F988
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824930; cv=none; b=dFWrCd8wVnyV7uiPumcAF7a5VzGydMF/YMgmRRrTvEE4Hj6Zg9TGHGxsoVNFk/lQKLCEY3vqFB0FMnj+iq5XUMluNNARY7WJdu3Jyqu3VnZIPRRrpeogbv/UfXWxcgI2iWFmzPxR5ELyf9Ve2GC3MQHSqFbk79ho1WGlOnBDHrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824930; c=relaxed/simple;
	bh=2bD99g3RCzHS7qpjMvEy6q2h4XoAf2oLQsUNEA2zgng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ8qE+KdyONyUJsiC8O4+NYsj/K+jT+ALEQPtcBSkk3q1IgFLOvgbxttiLKnghc8Mb22xsNvkfazrLfRggoru7bgPIqZGOeN4LLoHM7zBbV3eoUdaKQoybdGlXlFEiPb7cKPRIWtxFi42hPHhyrznLuchhSN7biTrB3PIhbPgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLAgERx2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-269639879c3so12504035ad.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758824929; x=1759429729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+leS/PUM3ARLJL0ftMj2JwrPx3Y3t/3wj//wIwdtcY=;
        b=QLAgERx2tWw7YHK3HgQD8bpWWpQxolw2efmsjlGrBZyFKfUNoqlzgbYWKEYLdxB0TO
         CONDvwVcn6h0CKhJGDr2DKRHrNM+a1UW5lJEjtfjBkxt2cn+6jRKVpQ/NRRjy5AR0uO2
         cj2DrBIIqAzNlTu7c4O2QJlLxeYMJB4Rc3JL5eXdYRbibBecfOf3hsF03WOkQjfPIg7g
         KDXfRy9zJixuH6RW+Hk35shG4R9ejRcEPRqPxB5Mufvj1Tpv0TJdSB+tUcD2Cq6bpoHu
         xkqGEWfeHP+ojkeYVIfIdxzFhoOKaAP8QPbv8gS8jHo1DLAF8pwYFxvztUFNGID0bQWm
         atZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758824929; x=1759429729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+leS/PUM3ARLJL0ftMj2JwrPx3Y3t/3wj//wIwdtcY=;
        b=mY5Lec4NM7Ns/I5j+E6JubJFiacTzgms2eC0eJCyXnXDELYHDRtQW4Qf5DV806guGr
         C8327U5zwZx4rUYDWQi6DIamajg2gNrvX4c4rPh5aAiPm6sfhzVQ4K/cvTu3LI2dmTQU
         MT3RExC1A0pDhFU8Ji8FktTHXt7wr+JcbE7JVD6rd/baaVKYkRWXwOb2S/IhP6tiYqC7
         jBMRTPs+HfS2gS2S/tWj5u5Qo+2Y6XcqDPRWqFo249aTviqunPg0eXN6a6Vv1I6CHIQm
         crD+Al3XDT7yLvFHInaDABT2eUsRNQiChmgUsNv5XzZ0+twR/eZ6TJZ9AifTu2HRvnjI
         Cz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUulMOAJeu4Gi1xJGh5GeviPdlElgIM0hDpPIHCNU8fHDhpr0MArzxZ2BaCcfv04DgSoPOhtdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLp8Gr2221BASygrFVZuPRAd92fvqhxy4Mk2KsQjuuRigXIxIR
	sy/vjHZJoVlD/Jvi6lfXt7dA1YbzRosJ7SeYi+UUbPcJWmUKnh/cACc=
X-Gm-Gg: ASbGnctORGfdwX4SFBLYvX1wgZrRXI4AoTLqJhZRWjI4XaW6HGg4PCPc6ttimQnOsMs
	hKf5D4B29BLZ91mReWITLIlozkIrpFiQXHVnjl7uH0OxFdh9RCLWzkInqGr/PFa6Pit9H5alHBG
	38o1gsOfc3phvX8h+AvfDDI+OkM4ikOAloehPNqtwMuczj+D+OBrngwcCweduqFafTz5UDTz8mH
	7DqLtDA6dzoDB+USgPPK/LiqpRGLTwXs198K6Y3SvirO0v7+/h3eX9IfxG/lGq/IV5CDAps50li
	evHI9QCkRYJA46j8/MBMBgo9nW8PFcXM5uHAIXhNFC9HhQHZ5T4iJpPSZWjsoMeWF9tT9v6axaG
	Vrgd47kI8rBf2n+VxuqPagcOGH8ygoPwoSZ6mH/DS7hX4KbTUvln193UbCKigMotZLWEsY8lcDl
	KCKVaf7unx+G+caOrU29EQ8i6u7FLnsfkcbd/emh2yzR/GWah/nslP5sRoFfNAQtcjRU4SpfOaN
	d6A
X-Google-Smtp-Source: AGHT+IHZVugBIgouDtYb9BFWkOqDdBYhyJsuidZA4cBawd32xhG7dw/4osu633h6hZASidRCxIqzeg==
X-Received: by 2002:a17:902:e80b:b0:267:d0fa:5f75 with SMTP id d9443c01a7336-27ed49df282mr59465845ad.1.1758824928291;
        Thu, 25 Sep 2025 11:28:48 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-27ed6733a63sm31851675ad.64.2025.09.25.11.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:28:47 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:28:47 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH v2 bpf-next 1/3] xsk: avoid overwriting skb fields for
 multi-buffer traffic
Message-ID: <aNWJ37JhjDf8ExwY@mini-arch>
References: <20250925160009.2474816-1-maciej.fijalkowski@intel.com>
 <20250925160009.2474816-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250925160009.2474816-2-maciej.fijalkowski@intel.com>

On 09/25, Maciej Fijalkowski wrote:
> We are unnecessarily setting a bunch of skb fields per each processed
> descriptor, which is redundant for fragmented frames.
> 
> Let us set these respective members for first fragment only. To address
> both paths that we have within xsk_build_skb(), move assignments onto
> xsk_set_destructor_arg() and rename it to xsk_skb_init_misc().
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

