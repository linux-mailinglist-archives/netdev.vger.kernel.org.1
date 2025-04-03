Return-Path: <netdev+bounces-178957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C17A799FC
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 04:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA433B1615
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 02:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C2B27706;
	Thu,  3 Apr 2025 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjkHMwNd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C69B666
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743647701; cv=none; b=gctDV6nhi5M1CIsRw8Gqn4GRXFrSeGrmmd2SU6Mk8VZffnYG8g7TbSOaJvRRGRe5GiWhAgqLkRBQvl+xbKEyZmuOU6nHEOIhFSWqHflIHbIL/YTseoW4pPqnTUIckH9U+SY3GX6PNcGJVdQx7vPvhMTEmHFAY6IXh7SUIUsTZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743647701; c=relaxed/simple;
	bh=SSeMl+zcEf6Nbl1IkUsOAB8J8OfrYdogvgiBY988RLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDuXWyMQkjnfLZtbaMLu/WjA+v0ssRs+qCTbomNK9OveskOHiczawjhu3+6v03KW4nvHjr8Vg4euRNiBK8QJhwtNaL6l9/5W6O3M0EhQhO3FysxhrZZCz2jFf1jgwZg7FMnnemLDuRbV18ESVm6yyx42p5TAV9jguiMBer0dInw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjkHMwNd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223f4c06e9fso3802845ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 19:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743647698; x=1744252498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSeMl+zcEf6Nbl1IkUsOAB8J8OfrYdogvgiBY988RLM=;
        b=IjkHMwNdOFqW5wUH1pw8v5RFVjT+5jrhnHXbmsCTYE2FI39DsPrCFbB0o+XwOatX/d
         TTUJrLVX7Ud0n2kzkTPFii+c1ifLldBIRBT7s+BKJUmR9qG3n6uxMNwh60CV72s1LP4L
         ZEo+ww4kPZk1bPBBnnpbm1E1wpx8NlXTBwKZ8ooUb8BzAx72NPgTvtpp6vwk2wFq1yYk
         CunMf1aLAxJiNLJJxv2RXEK9Y2Rys+0y/UP0qjEd3lyZXDCMtqJK2efJUFKv79xjc6Yu
         YoVAt9XJc1qOFzIW1Agpyku2CtivPgsAleqDL+R+8wP2UP6oVg41e8a29bEH8KdbRVtN
         lmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743647698; x=1744252498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSeMl+zcEf6Nbl1IkUsOAB8J8OfrYdogvgiBY988RLM=;
        b=mmR6NY6oIJdr/jGxDXs1ROtZBtdCgUE92ZxwuLi3zSW3fuWFQVQZuZFMnqxzifcxZT
         b7pH7+5MmY/gjd9i75RY+iaxuMXXkjv+8v6981p2CAhlTMfsPGoMwhGScBX7tazNOky9
         hgL5QYzT1nosXhzqe1qVpiFqvdi+Iy4IL5v7UBJTt3E/xIsP1n+9pIIeZB8OKvrtBI0L
         0x+luyarZSlf7xc+p40dt5KgKhQf3312zVaylaHOfm/r+tvySomW794T5QtoR/Arxduf
         FzL3xXojgTJWDNAol4kImmQIZX95eu3BCwR/ZsFYGROtDxTf+eDb6bThxgEfqt2RIxCR
         09nw==
X-Forwarded-Encrypted: i=1; AJvYcCVlagc4Njb3FaXF6LyLlF/au24swQZtLzr1GWaRSWrik1UkCDiLl7kvL7IHVh+3fHfcJYPt/zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj19cF14Qpr9fEbjXtcW40UcyqlBtsZEDUx3korKJ3eX40xw1A
	i4oAO3TQjvdGmWlvGPq1fdya7tw96ZDCVN3y2AidLLSvgP0mhuk=
X-Gm-Gg: ASbGncu3Yeaa/N/PPUIyJ+AidcG1RqNCQiwnzqZjskXE1x0JAZ8alVLuqu3U5+PNzeB
	bveWclqfKU+PJ492kNxU30P836TzqzlWK4tFAO28cgwwxaINKMG77wMr0BYVTIjAqIbr9OIzdE7
	VvEupj+yQSBNS9YzAZ4oOfhRJyLVl8MB/EpEavvyGQwBFkxMiQGtRoWLk3yFASX8MpsdZkO3aus
	XZ5SMo0MQMn4Rp+b5hGNMDQjZmIJyUjgWGTSxmTQIh5zcEfUFysUCJ3EPfCdlK6isCpOLcv8/Ag
	IpB1SRY8fB6nLk0qj4iaY4M8KwyvhQFHrRHIgmA8YvP7
X-Google-Smtp-Source: AGHT+IGIYk4BmlxtYkfT8FMygY1sCrwUYiVJf1AeI7ouB5+HQuQs+IOwLb/igAask6L2CCXI6wKoag==
X-Received: by 2002:a17:902:ccca:b0:215:58be:3349 with SMTP id d9443c01a7336-229765ecb95mr27419455ad.14.1743647698093;
        Wed, 02 Apr 2025 19:34:58 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-229785ad0b2sm3248515ad.6.2025.04.02.19.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 19:34:57 -0700 (PDT)
Date: Wed, 2 Apr 2025 19:34:56 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v5 02/11] net: hold instance lock during
 NETDEV_REGISTER/UP
Message-ID: <Z-3z0MUidedMwpLt@mini-arch>
References: <20250401163452.622454-1-sdf@fomichev.me>
 <20250401163452.622454-3-sdf@fomichev.me>
 <20250402170220.4619a783@kernel.org>
 <20250402171213.10f809d6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402171213.10f809d6@kernel.org>

On 04/02, Jakub Kicinski wrote:
> On Wed, 2 Apr 2025 17:02:20 -0700 Jakub Kicinski wrote:
> > Is there a reason we don't hold the instance lock over
> > unlist_netdevice() in unregister_netdevice_many_notify()
> > but we do here? We need a separate fix for that..

No particular reason. It felt better to flip list/unlist and reg_state
'atomically', but I agree that it doesn't make much sense since the
other paths don't look at the device listed/unlisted state.

> I deleted too much here. I meant to say that we need a fix
> for netns changing while netdev_get_by_index_lock() is
> grabbing the device.

A fix for somebody grabbing the device in between two locks?

