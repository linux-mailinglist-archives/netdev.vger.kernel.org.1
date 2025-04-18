Return-Path: <netdev+bounces-184127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3782A93642
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0B644874B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C998B275114;
	Fri, 18 Apr 2025 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng3BtWBN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1AD211499
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974010; cv=none; b=nAYsGf9zruVGhxZPE1CZng/EfamqlT3qmYkPE0aZRGeATbee9/hCOuAEoxbgYm6U5438dX9h7R/NMeXYtMCWwcMm1qCew6jJdBKxpHskO3NI0RcVpMAH5OLq5A7/HoUGqfauypf5HdYc1ymqTAI4lyb1XO1phEECsJwVFTjVlw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974010; c=relaxed/simple;
	bh=l20U+79278iSXJ8uzveqEiS4Bd4MjDaMmtvnhQpRON4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=IWfMS/zTCQBMnN+3FHy2h/SuEQNabOIU63qHMvESTHD2zEBl3Hz/xBMPAm3TmPQopuc3GXrCTc8jF555dIFJvU2aN6ppIGw5/Z/6x8H3e3PAWQejYYkHgs8YCxoCLQnJV9bSE/Px0o15QjwfnjIZ3d7qEfyDvLPm6mDJCKopfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ng3BtWBN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-391342fc0b5so1438982f8f.3
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 04:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744974007; x=1745578807; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l20U+79278iSXJ8uzveqEiS4Bd4MjDaMmtvnhQpRON4=;
        b=Ng3BtWBNwxcvgjn9iOtqHrRun/62aIXqc0DEj4MDsbaWvxQS26DBcHcp/aLQ3v3kOX
         3hRwHh05ZMUAzGSKsvbrVDCsIPd9BFkq7na4Ejcz1v9sHM29LjS+dUtgg4DczANcZYyu
         oQpLXAGknjMosS9HGZH692nGEBCaL+3UBKc/iGFfbldVqLb7bp5lZff87rsZbRUlM19b
         fiUKzj18Ey+ppvln73k9QmxsthtrRSy775sUTTk58VG2qUkg2Xb8e4QkEmUUI8nozE37
         nFkeV4gGqzMi50MPk9IOMx8TlytDMddiSYH6m3ldbSAujWy0tnFk5CDG0YeZvuOVyoyr
         rbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744974007; x=1745578807;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l20U+79278iSXJ8uzveqEiS4Bd4MjDaMmtvnhQpRON4=;
        b=cE4y+mEH+EADVyLRFuEDQPiqIRLwNqnTaOCf0wyE/zmqq+EnWcgyeRpu297gLiS6/C
         IWKtWLRjhpM1QZTWlKg0IsT+13a1/vQTdspJxaX6YNg8ClAlBgBWKodbqEyGDSyG0Laz
         qzDxYRYzaPd8eWMRNkm8PdqjikRQA49GDTCllqSnPcWsGaZ8W+ozIBMRbR5NG5Qw0OvD
         fw+OmJpJV/UxftZQ2CFdg6S4kt+yIMVUH/BMVFrugzTF0qDeGQVTUA3u0BKZrIbfIT5N
         fi6vhwOEmn4OqCwSgH///8whKsRrjaL4t05XoayFh+v4d+4DOLDJBjmkom15J2ooK5d1
         Ds6A==
X-Forwarded-Encrypted: i=1; AJvYcCXavB499dOIFQJOe/TWixRMor6bgFnj10WnpLaS5BXBP0kqzSKTvKiJRJSBFJNeNCHPAbfvWHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nlrMJV1sIjQUB826Y42RyKohcIazoctQp/lBPzmjjcPtWrpf
	qBENfpT1NxO67tFGaf8By6l9Usy7qohAv9pPGlqw4lRfRkd332eG
X-Gm-Gg: ASbGnctvXCHHQCZBT83glsgUadrmCZeKkBKPFdaPTCCLQ2ZNytNCx/1DxDJNGgBdd7i
	gcLQb1W2+ccp4zjDd5nLSkl1P1e8W3d57gpmtSrnfRQu46Pb6Nwl5LRjj2JlwGIKkNc+DUrQakr
	d/tdawK2EkbHDbdJ/jQ3q3APR7Qjc6ZYOc4WTDXshfxvKY8sd/We9ZiD4F6DSyV/otZaCh3kPFS
	cVaJ0O0ccZvi43yxX9/pYhqXdFzlOynBV8DmwYptQ/vfz0l+80f3r2wKPSt7Pc/4TPJhvlOXHrX
	zvQDVZ3wmMLojVyU1jAm/3VLwLxvk2eglSGmC+QUxT61oHQypsUam+RrJCU=
X-Google-Smtp-Source: AGHT+IEuvG9RZBjVtgKZjEm8CtwgB8U5fVlm58wnI/bQObvPdf6k6j4CRrD2D69iykJgmskyG6Gyaw==
X-Received: by 2002:a05:6000:184c:b0:391:212:459a with SMTP id ffacd0b85a97d-39efba51004mr1793800f8f.22.1744974007409;
        Fri, 18 Apr 2025 04:00:07 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:24a3:599e:cce1:b5db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43bef1sm2390266f8f.49.2025.04.18.04.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 04:00:07 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next 10/12] netlink: specs: rt-neigh: make sure
 getneigh is consistent
In-Reply-To: <20250418021706.1967583-11-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 17 Apr 2025 19:17:04 -0700")
Date: Fri, 18 Apr 2025 11:45:04 +0100
Message-ID: <m27c3hiw9b.fsf@gmail.com>
References: <20250418021706.1967583-1-kuba@kernel.org>
	<20250418021706.1967583-11-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The consistency check complains replies to do and dump don't match
> because dump has no value. It doesn't have to by the schema... but
> fixing this in code gen would be more code than adjusting the spec.
> This is rare.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

