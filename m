Return-Path: <netdev+bounces-119328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4959095527C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2DF1F24073
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54B81C4631;
	Fri, 16 Aug 2024 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2eaBSFdZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A67136E21
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844154; cv=none; b=iSjT+Ktyr7G8/nOeYbKEfT2VkVJv9WKHWYEOCW2KXFnOfCl4xAUReJk7OS5cQ0GJPck5bvyCfUDVieBDXs6GjQQ+0SBQnribVpjDJ/Hesric2kplw6GkNBuUGPNKUU2L69pvDuPpZM1FtAxs71QAoF6skRFUUvo+sHnTFwAwXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844154; c=relaxed/simple;
	bh=4dHNtfPVCa52Ap+8pBhAKQTKBOF2eYufbhX7WxuHbGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5Pgwsko95bdntf+wgl7Ui1a3c1lwck/1lZ/aXFRDt8NGWXk5g7KLyyhL+hfo1ZNN9Pedc8qXrcDmJ4VtazFdMEnjeX/gjgZ9qXsP24rgXEO4oIatrArPTB/4MEfc8gSxD2tyCadG9ZEAmEp40tG91MUVgM09D19V1Bb/vo60i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=2eaBSFdZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-202146e93f6so7598115ad.3
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1723844152; x=1724448952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OurHWaNewnPUl7Vl2e9VYMZDKn68MoMrTbPnePs+I0=;
        b=2eaBSFdZhR9/mUAyiOy4kuOoyYa+4/zqPkAve3l+f1UJshgNFZJXKedwweAz0v39lN
         /hc6yu1opkLOki/CaJMWdsRvk2iNquix/84EQfkuOHHqf6mW6l5Tfl+oiVgoOleuvVdm
         uAvh9H/I+M5u0EcgVUYNgv+YL3ySBTRxIiti6Xq9z5ajVLcOcgkukHiuCzTPbieOZkkT
         XtoVA5qtrKPa8Vq1cQlAj6hle125Zx3eZvog4QgrHH6FdEhUsir5ILUjsAkzj2L3Ldbw
         w7QYYAsBK8jrW1DsksUyICic/0ReCjXE5CG/FvaA4W/Ih/DTwLvFwROyze5pcxyRbd4f
         htqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723844152; x=1724448952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OurHWaNewnPUl7Vl2e9VYMZDKn68MoMrTbPnePs+I0=;
        b=uVifo+yw3soxNIs3CPilAzhgPSbvVXW9eRSG3zXLCndSkqRSvXZO6Ag7P6EnTkGDRy
         D/xtyrv2Em7sYinBSqZWqLcz/eFoyiO4j2xnucHnjBRjUP0a3O3apKkNsw+K7wxAq5kY
         YEM77w+x8/Rbf/8A3yrM/uodMt1wFiM8hRtV/AtEaOnnaRQWWcAzLpLWkuUqPTlFE0oG
         +iKWLEM2oKTgEfzWjlu21Mbgn7f8QnLQTc/B7kS6tnZj0B8LowjAvP8A2gB6AH3m7WLL
         H2c/o6SW9NN1wAj/eQDVriPVl2P9Sr0ohwoRsliO+xCV9VsqewvUk43JY4MBJUGx7oQR
         6Sfg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ1FH18lQZHwveuUSSbMYHvrFD/aTU8rwuTcyggjNxBIDofFIB/9BYOWRUgUBnCTlzO7AlJRJUWuahPjyRAWM3yjBkr37/
X-Gm-Message-State: AOJu0YyDU6KAmB+1XSQiotOwlhAEy4+c1Rifl6GAQUlYiwSw1/D7sdjm
	dcyGucB3QaAhUnx52t/T/KNF68UwR2Hle5BTrb6p2KfYI0BgksVtQy2uhSLw9aA=
X-Google-Smtp-Source: AGHT+IE2WQgZgACvVx8b5TfM+9UaIT3UnGBBhC6jLbHsQq/R6AdIYu+m9AwJunEJSgIEUk/zVO5rAg==
X-Received: by 2002:a17:902:cccc:b0:1fb:7b01:7980 with SMTP id d9443c01a7336-20203af4193mr53861235ad.0.1723844152013;
        Fri, 16 Aug 2024 14:35:52 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fff5esm29761185ad.15.2024.08.16.14.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 14:35:51 -0700 (PDT)
Date: Fri, 16 Aug 2024 14:35:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org
Subject: Re: [PATCH net-next] tcp_metrics: use netlink policy for IPv6 addr
 len validation
Message-ID: <20240816143549.41234094@hermes.local>
In-Reply-To: <20240816212245.467745-1-kuba@kernel.org>
References: <20240816212245.467745-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 14:22:44 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> Use the netlink policy to validate IPv6 address length.
> Destination address currently has policy for max len set,
> and source has no policy validation. In both cases
> the code does the real check. With correct policy
> check the code can be removed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>

