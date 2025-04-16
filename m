Return-Path: <netdev+bounces-183212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C506A8B697
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D0F37A6EF2
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592C12459F8;
	Wed, 16 Apr 2025 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6V+Nnn0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC12459ED
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798686; cv=none; b=mdl8ips/026uIT7lcjj/ZOZmr7fEx+Sq4nqFuK2OUXWH27r026mMrIgTqvXaVh94JxYK4gs3DSEmyWZ4jTQeZlzwRP+BnrwG3ErkZxSJWHJytQJFLQMQ6VV4RqKO4rI647m0/+Ejlfy8yjuUxs7r1PoIMt58gXBaZ9o42Q9+WhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798686; c=relaxed/simple;
	bh=QcQkD9LLbTof0Yvjb8yLo15mH/EAZG5zKLm91DyfPs8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=INcR66JpfCbCCx7jS11kmBkkhycnCUai5eBE1ZoRwNIiSE29rSTlYzCwwwdWZTjn20RmweItCjVsmTHK7uCVZti1CePvAlz9BMd5qSAQ5ege4KjesL5uJXj9ALTep0Hpjvk0PkV3IjT9xXDPFmnMRWMxk7fESSUeGo5M9zQaYNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6V+Nnn0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3995ff6b066so3612084f8f.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744798683; x=1745403483; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QcQkD9LLbTof0Yvjb8yLo15mH/EAZG5zKLm91DyfPs8=;
        b=f6V+Nnn0UUJ2NMN1sJM7onYgnzBpbDEv0tKnbVsDUKmzIbtDQxG90yKDl7sOuwjmOv
         Tlad27Y25cb4b9MZNYaf9RcGI8s6kio58nHaTOxNheshWor1GT1kiwhg3z736gDb94gl
         8VVIxLStnRPCTotb7V2EjVRwjYqQnbJM9bVQFS+ah6whqxmyUHSCtz8+MZ38LVhz4RWX
         Fmv3N9bnZWuVED1gC8+2JuIxOz+6dbNrq/pPeDTKkgC2CLT+684NnYp4YU7W0iJ/hS+m
         G/WOM7m3I5jx2Lje77i7JiROyjQZFnR1R8EwGF76lGnk7J+kdiWhA27k54ux0NyzpzlP
         Hldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744798683; x=1745403483;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcQkD9LLbTof0Yvjb8yLo15mH/EAZG5zKLm91DyfPs8=;
        b=TlDOP08c9BD1qLameCiHrkgp7TVDTKdYR9Q+8X+xpXs0moXd+lhjcpkEE5y7NJvFAM
         8m+zx5pNSgCoa+DK72FQ15ncxJzhDFuuhw20BggFqeMvvnZP+QB53iAx3mmIlw/kDXE/
         nhKSEbF+z05gKj3y9BvFNYKOWMEt6h5+zrP7SK4uxAVjk25POS/BDSpc28HdwzPW+jQB
         0X/g2zVOP32wWQlh2OIbhPMQhaQPzykz5bpAFwN3AqpulrVVd+yR1l0vny3n5TArrt5d
         O96ex5OJOyfju2e0B1t7rSydF3nV6tlgUXPfk3Vp0kydoTcgkLYWvMznbws52JOeXDka
         MzdA==
X-Forwarded-Encrypted: i=1; AJvYcCVHO35PC4nj/0d0yqglFVtSqIC8wIuSkU22V9Y6skMTOpzb32GmQb580+NdaVCm/VMtss0FFdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLe0jA6bXBZsubKV9HVO9+wttbAp748z3y7V0Un9D1uABqcwah
	W43Ts0ziOcGpebWp4kk8mUG6irIKlw5o2fNFHexcWj7rAEw+WTld
X-Gm-Gg: ASbGncvjwya3KK+Mea4IjpFS3ABGi3og/i1xkq5fwUYXiBdF+8Hnfka0t29/mUMIm3N
	7TURO4RYKzAQLr0bFRdVL/Nx+lb2qDcB5gUePMc2JOfm+XpD8V63Vtb18XFN7ZRWketyTI6IZuJ
	UZZVugkj2HvksgQACRoPb4jUls1d1y6rTrDtYStfuQvNe0mo4RbBnQKgym5rnc7yJgH9/Foiv0f
	OFJzmv8uMz3D/9gqG54r3+oQdGiRkLX/oYtY0MfCAsIFjGAtNUMgJ+gsKSGV0H/P/xqmsSqd0so
	OVyAni3mIeZ3ptZE3M93WCsiIMlnns6WANHAVwcTKTFOvZakTb9EFtEIEg==
X-Google-Smtp-Source: AGHT+IGrHzIt+bYY92uxmMNz45X4vmwll8usFtTBnAVp2kWOYW3QIqxwrAC8uFKh46ikwNIj+o8JtQ==
X-Received: by 2002:a05:6000:1a8d:b0:391:4095:49b7 with SMTP id ffacd0b85a97d-39ee5b32392mr1182294f8f.25.1744798682718;
        Wed, 16 Apr 2025 03:18:02 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e94a:d61b:162d:e77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4f2444sm16753085e9.17.2025.04.16.03.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:18:02 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  sdf@fomichev.me,  jacob.e.keller@intel.com
Subject: Re: [PATCH net 3/8] tools: ynl-gen: individually free previous
 values on double set
In-Reply-To: <20250414211851.602096-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 14 Apr 2025 14:18:46 -0700")
Date: Wed, 16 Apr 2025 11:06:59 +0100
Message-ID: <m2y0w0l8sc.fsf@gmail.com>
References: <20250414211851.602096-1-kuba@kernel.org>
	<20250414211851.602096-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> When user calls request_attrA_set() multiple times (for the same
> attribute), and attrA is of type which allocates memory -
> we try to free the previously associated values. For array
> types (including multi-attr) we have only freed the array,
> but the array may have contained pointers.
>
> Refactor the code generation for free attr and reuse the generated
> lines in setters to flush out the previous state. Since setters
> are static inlines in the header we need to add forward declarations
> for the free helpers of pure nested structs. Track which types get
> used by arrays and include the right forwad declarations.
>
> At least ethtool string set and bit set would not be freed without
> this. Tho, admittedly, overriding already set attribute twice is likely
> a very very rare thing to do.
>
> Fixes: be5bea1cc0bf ("net: add basic C code generators for Netlink")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

