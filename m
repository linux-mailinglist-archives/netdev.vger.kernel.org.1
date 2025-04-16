Return-Path: <netdev+bounces-183213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47A0A8B698
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B8057AA025
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D23247291;
	Wed, 16 Apr 2025 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SitnEfzg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7BE246326
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798688; cv=none; b=o5ixP05WMbeuzjHccdVhEB8uHN1gPwYOzTob1my3GdOIM7wWNS/vcucbbn9MeBqaV2vuQgWbniRrkVsBEfsNg5bnY4/ooWnBJJjbuTPdu8DctZLiQ4j0G5AU3k9DBlKehIF4dhVRRHC0ZBathskiCNuKiA7LWxkkTAJupjbx4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798688; c=relaxed/simple;
	bh=gwOY1ws7nFrZ6QLNITh1p3bkqkyqfATYzBkX3kkCruc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=SIBbKLXPf7aowcKH50tSfLrcAnkPS9srx8fCi86sQS50USw6LKqFyA8Aok87YKIWFQZKNg8apZdCHWjHndQodwJWB7SA5kwYnYUVFuAs6VIXapjGdSsKgET7DMSXswqI7NTCDMZ+RIlmAJUrrfRD2n1ZeP0ugxAG9MyY6cwFT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SitnEfzg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso71161475e9.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744798685; x=1745403485; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwOY1ws7nFrZ6QLNITh1p3bkqkyqfATYzBkX3kkCruc=;
        b=SitnEfzg9gEYIBPf3O/rt2ii+qJMBJAqy/zgbHS+zgYEqn04oeGRMdTsuMQSTiByjV
         ysMV69LcnOy0D9QBL9xYOJPvXLN8SS6Oj975+aPNGsKx0/R0WeOT+keFgzdXdCLH6XKl
         Trzsm9BUcYYukLJmduI6QSgeno/bXvLeYWaXnCUYfq5Iy3IJLt779hCNxa8aLjxWIXlV
         fXtl0hQZr2ieiBHIwATNljbupS8a3ShC8gxBxoR4DR4u3c6e3QuOFTYCmI9IS8kts/kS
         b6aPAHEwe+JR+W5oAy/W+jaYGBbLk+mcsht+gF7C9JszNjQpnjXCyAaoVIMmyvILgbne
         AIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744798685; x=1745403485;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwOY1ws7nFrZ6QLNITh1p3bkqkyqfATYzBkX3kkCruc=;
        b=aN+to/lCgVGCYTgaHWhzJeFOQSHoVdwf/95dp6nmAgKOMhdaCr6DbqF8thcfX2Z2HT
         tsjm+NyD9iZhLTwm9wqNUU3bE6sOKuSzZSEXnpGfkDD6F80W2yC8lO0R9AYpgbMqO5NC
         JXzdes2YT3iy59TvQbX49tgqcT2+ahX8y0i+N2zHycLxF6yfWvH2XhCbdcoBQgL7LRz/
         KAZBBkPQv88874s0Jkr5fauBs2th2f2KvjzgAwazvQ5LkN/Pc6VCKNxSw0G7RhFYrmZN
         qaH9z0JsqEGnL6oBIuhHywkH53JQwYd5gbnaJ4nqGyiY4TsKO4JycSsunu+5g0r/o97m
         hwig==
X-Forwarded-Encrypted: i=1; AJvYcCU0GoNOzgEyCeTG9E+hYZjKNZPcW46nrny2+ON+S+/D9IzIYavssp8RbiNjO0chLWbarCCPPGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pW7GrbtESL4kfLDwsux3lCGkRU05lVD46qE9kRpqXFzh2yk6
	TeObk575PYD9BibuYwLjq5i0DCa/Govg+h2lcPnJRLJWau/TvBeX
X-Gm-Gg: ASbGncsCLtEtfLGntx7ZWGvu18jjRIsSQHu8uCWJ2EhW/BNzyluRiGkgJMb9WKhzyOL
	T2HHhi1hTGsakhQzETK/F90JW3jXgvMrrMUyJGq6QSLiisOE1M8Saqfj4TQ2hcpWOqk5VXauvrr
	V0mzhdU/D64MfqLxbDmluNjuKv5Q2RlRh7rILYuCGYySTRiC7Bjx9lYK6qoUA938yGKG6btSUkI
	i6EstCabdOIuV9Oe3YqSW5lQNlekiaz9ReqC1wdrHGqgbn7raWIcz2hQ6A93Ku+7xS4i/vQgV/D
	9HW1+ycLbvHaWjXPQ1DqXWJWIjNUgJzaW8BpDmorgEQcdVkBEDBthhto3A==
X-Google-Smtp-Source: AGHT+IFFy+fIk9GehhseCmSKtW4bQGlKUocMPAPalt+u3/cZp+nKPZUYtfA/X+HELAgZ6KU/XtklVA==
X-Received: by 2002:a05:6000:4305:b0:39a:c80b:8288 with SMTP id ffacd0b85a97d-39ee5b1c94fmr1262665f8f.33.1744798684955;
        Wed, 16 Apr 2025 03:18:04 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e94a:d61b:162d:e77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4f3df8sm16825455e9.24.2025.04.16.03.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:18:03 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  sdf@fomichev.me,  jacob.e.keller@intel.com
Subject: Re: [PATCH net 4/8] tools: ynl-gen: make sure we validate subtype
 of array-nest
In-Reply-To: <20250414211851.602096-5-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 14 Apr 2025 14:18:47 -0700")
Date: Wed, 16 Apr 2025 11:07:53 +0100
Message-ID: <m2tt6ol8qu.fsf@gmail.com>
References: <20250414211851.602096-1-kuba@kernel.org>
	<20250414211851.602096-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> ArrayNest AKA indexed-array support currently skips inner type
> validation. We count the attributes and then we parse them,
> make sure we call validate, too. Otherwise buggy / unexpected
> kernel response may lead to crashes.
>
> Fixes: be5bea1cc0bf ("net: add basic C code generators for Netlink")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

