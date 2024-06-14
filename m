Return-Path: <netdev+bounces-103686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B97C59090DB
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 19:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B251F21F6F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 17:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFA115FD13;
	Fri, 14 Jun 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="cbH26gKh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A0BD52A
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384497; cv=none; b=Tt26gmHzi+FEhBoAP1sH5PdawsMaszKJSZQue5NzBPN0mcBBrD6trKYcB+osLx6eYOtXg8xPCfBA0UWG2IoONZvTkOP8e1EIyWgWfMF5RAJ6Vz2aJkkIQleGCxBl1UJHtXbDteIPGXvGtF4fAqDSLkw4XAYIV0c6HY5yHQmmKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384497; c=relaxed/simple;
	bh=DNOBMNx4uRuwelVuHNDcP1Ev5ajGCDjTpYXwU/sZYMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P14kQelP6PrurN8MxUqCemjwPCV2UVFzr8YZgUBepxoExMvcfZppliNUEeicFRKSTU088CgoB45S6OGI9aulWKXk46ntwVtAqPSSXHROPSbVmVLh0zGcec0Hq61pCCGtZhp1aMAYHDVVTZqVSDWXgt0jSpmkDFk519uJkP6pkBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=cbH26gKh; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c4f05f302eso498868a91.1
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1718384495; x=1718989295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCAlMvBFL6ccUugbwBFECdB4L60WoO83ky/bfUdkBw4=;
        b=cbH26gKhin2NADFwWnjzT2mCxCgO/JK5CL9+n3C75FrdQdKXelv9YxsqKSxHDgtNdF
         sYmiUfC4rgGlg+kfpqostSRT8HifoALhICkuL+lAKe7XSwtSJ/UKwXCzgo9MllItlgeX
         roRdlfQI8T1oGIwEPsyqLb8BP7DiuEB5s6Q1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718384495; x=1718989295;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCAlMvBFL6ccUugbwBFECdB4L60WoO83ky/bfUdkBw4=;
        b=RgH5ViIaUSh8R8oP1KIf1UjHk9I2A0YylE+Ll8K/y2435KOTsZldxh/3YfeUrR2nyh
         RbZawmZ+GuZRAAOOVlppkbPGAmEHqlGJYETkPMDShc9wZO8Ov3wT5a/+AgIpXgO1yPcd
         +QR2iAt0XjcAROBgj5bIuZ3etFjVDW3Ux+szjnI/ohhrDg5O+MmMxR0AZMm5xSKNMWzh
         YDhj+Ay14aeTL54nqI+nMIto15q1+ZcH8S6w7UHuiMpJ+JZzg/+L7gh8eLhOq9YbUAwL
         /5raDq9/5OSj1pJj7+2Z2LZKOTuc7PDk9mZ2g6USVahrO6Va6hJX9+1tI6ThJJjPZagh
         Mbzw==
X-Gm-Message-State: AOJu0YzIWqJNMrf2fA+aq3VkLlQrz3KBE54NS8vRbzINRHBXPSUN0N7Y
	ZvevWKXz/ELj9dey3R6M/z6CQbimfUhmJ+jil4s/ZzDdPZZtFOWoXl1Sypb6l5Y=
X-Google-Smtp-Source: AGHT+IEZ8+NsYkj7WMauIrntwwR59vtwGEwJlRUEhtPvP1ykoBk/eOsfD21Glt6Q809XfW+h/1oq+g==
X-Received: by 2002:a17:90a:7d17:b0:2c4:dcf6:2130 with SMTP id 98e67ed59e1d1-2c4dcf62279mr3187758a91.32.1718384495014;
        Fri, 14 Jun 2024 10:01:35 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c85a745bsm4086521a91.20.2024.06.14.10.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 10:01:34 -0700 (PDT)
Date: Fri, 14 Jun 2024 10:01:31 -0700
From: Joe Damato <jdamato@fastly.com>
To: Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: sun3lance: Remove redundant assignment
Message-ID: <Zmx3a0GbjxyYD2Zo@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kamal Heib <kheib@redhat.com>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240614145231.13322-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614145231.13322-1-kheib@redhat.com>

On Fri, Jun 14, 2024 at 10:52:31AM -0400, Kamal Heib wrote:
> There is no point in initializing an ndo to NULL, therefore the
> assignment is redundant and can be removed.
> 
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
>  drivers/net/ethernet/amd/sun3lance.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

