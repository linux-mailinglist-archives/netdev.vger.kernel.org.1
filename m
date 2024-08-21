Return-Path: <netdev+bounces-120676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C0495A2D1
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 18:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BED1C21105
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9C3148828;
	Wed, 21 Aug 2024 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abCL3cR+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6AE23B1
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257837; cv=none; b=ftCoELwL50d27le7Paik/DQtf12GKFTYLj60+rpBsP2gPktRiFWNxGdtzJ4QW9OoI6E/0Ma8dPD+AS5TsQFU1XSQCgosaCEDn9dNcal3hZrnKSsEeOKYdCkmNR4Fbe1xlYyujbGrG2T6IjNdEKU0bvI6WMrYm1D65cF5PXV8xCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257837; c=relaxed/simple;
	bh=eh2CaO7SLxneqTXJ0tkAYdS7T534jswugaRRjc4wKyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc5tduD2xCHy30B8F0uRddwmrnH98jckFqTukY5mdj46T1Dqt9KYKy8n6vfUt8sZwWtuImum9rtH6XtoHbgdAfd3c298C2SlpwyafLXTcbgIVsLR2l6Izd5y0eeAxObd5FBHFJO0mowNmcFGq8OQJ+pJ2yWhrsQxZwENBG8WkfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=abCL3cR+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724257834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eh2CaO7SLxneqTXJ0tkAYdS7T534jswugaRRjc4wKyU=;
	b=abCL3cR+6H/U8/nScNj6+ik+qEc9mBFkC6fMMDuX0NX0pl2qxoNmEmob5tqQukb2bXy/vu
	9TDzdMw/kuUgwpjCjX6egjXkLxxCXUpHtlJopfqaWD8vgS5wxo2LKpNKrEKbjQsJYZ/9mH
	O7eeBm4FJzxrBpVYvPz/9rHyroiF1s8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-boZ3tU2QOW-YQ4UBprkRpw-1; Wed, 21 Aug 2024 12:30:33 -0400
X-MC-Unique: boZ3tU2QOW-YQ4UBprkRpw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-372fe1ba9a6so631938f8f.1
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 09:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257832; x=1724862632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh2CaO7SLxneqTXJ0tkAYdS7T534jswugaRRjc4wKyU=;
        b=W4MGdc9m/aNzt5vjsOXd0LLthlozc/NJYna7UGXIsXUWrMC5xNt6bWceKtWQHLNSck
         YB+T8nFbho/1JEKGTnRL8f2M5cuJ9zfuuoUIACfDKzbBFfWWwrB8wg7qQScMUtGUUdjU
         ksLMII5sv6PXl16swuhUPzTJlm7AAGcrcXmzB1sS9KVMaNa1SUEx/tBM4xW1p2Y5D0Up
         Z4YT9Cx6R/hqBq8JWa0WFsiPfbAPaMlnrIKghl9sl9lSeysBLJmhuNzAImwhc10pwLB5
         50CJMSKuGSbPCoCCSpWep5f7R88qessObEpz+5xfm6q3nXJ3KfdPgcbwrKX73Q9gY0V6
         p1bQ==
X-Gm-Message-State: AOJu0Yxy8Ue42LEu1RX467/u6cBdVRSL4KLTlQHbXWM3sEvffe1ZOcCq
	reUkuEDaIQxOboR0OS65xnJS9Y0STxp582BEewVVLpiS3p/P3a+r7ZzmtqrGhEPsBq7sAVfWMKT
	rMmH134wBk/aLTP+0bBzhu69JVNimf9ldbWSW+U5p610A8StIrsEo0g==
X-Received: by 2002:a5d:4608:0:b0:368:71bc:2b0c with SMTP id ffacd0b85a97d-372fd5bbe67mr1762295f8f.10.1724257832015;
        Wed, 21 Aug 2024 09:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFHiwWQuwcb9FY723vZUjnvJiZ+wXV01CzfS27CAuf6/lQRnbvysDeH7IR7ggmior2kIS68w==
X-Received: by 2002:a5d:4608:0:b0:368:71bc:2b0c with SMTP id ffacd0b85a97d-372fd5bbe67mr1762272f8f.10.1724257831193;
        Wed, 21 Aug 2024 09:30:31 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aab44sm16105552f8f.91.2024.08.21.09.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:30:30 -0700 (PDT)
Date: Wed, 21 Aug 2024 18:30:28 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 09/12] ipv4: Unmask upper DSCP bits in
 RTM_GETROUTE input route lookup
Message-ID: <ZsYWJE7iTXu4jbN/@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-10-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-10-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:48PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when looking up an input route via the
> RTM_GETROUTE netlink message so that in the future the lookup could be
> performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


