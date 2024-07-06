Return-Path: <netdev+bounces-109655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EE3929528
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 21:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B771F21736
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 19:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF091208BA;
	Sat,  6 Jul 2024 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="B/VAis8f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A36208CB
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720295781; cv=none; b=OWSKsGEPejq4AzBqDx0vfiHCr1rQ2m9Tx0sl8l7BdOf3hJPeTNUDvJQMZjzzx9hZw/EA1ohYN5mz9UZCqHMQPKDB/PkT3jtRRDspqwEBYn639KWs2eVXHRcS/TRUetDQk1OZyyIUER+ulFil1T8M/xS4NrlXEEH/BfPaFxVIoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720295781; c=relaxed/simple;
	bh=ABamVRk+WKBdPkS3Nr1R+yq9+y8SA7oZNui2ovWzqng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQnJVEtt8BZCdqnanZls+IOSRyhC44sgSLGLNUuy7U10KjyLDinCzvRUCqg8HSW2RcGg9bXID/ZxG6M98KDVYvVjlZ0pl5kfS4AS6qaJRtKexzKE/8Aug7R+cn1eQo/4wBRWHmV3kM2WL/80WTr0LhXkk6mvQm7rHALi9kGUVmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=B/VAis8f; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d92bbadfd6so16748b6e.3
        for <netdev@vger.kernel.org>; Sat, 06 Jul 2024 12:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720295779; x=1720900579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmKC/6dx3mlxXNLCeWHfcXH8XN1JAAa8PHgB5ApKUK4=;
        b=B/VAis8ftiTwG4jATSGUR2qtCaLjP0Q+vLH4ox7KIPkV+9vo+USjnYVCeDd1C750A3
         WLJwznZqRhmc12GlhqcFTbWTVBqLLfejzSx31AGQ5YHbNEmpZh/Q99cgivgYu/41Oj8h
         EZIyKao/7vpPLInvhB1WBz2M8Yuz+6VuLMJX+/1n1eb95/ftYR078WEsEgipTz5mm9jE
         NvbccT2o7UwhvysLtqRXgXMDztKXPzS/kUBu6129jWa642lrRx7NnhHOJ0D/OfUio5kY
         87VDBTVvHTJPRO/tUu9wmX7M7s46ng5vPHYZXt7wBu5c9f2utZTcdQgVXVKIIH4jW3Gt
         ONkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720295779; x=1720900579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmKC/6dx3mlxXNLCeWHfcXH8XN1JAAa8PHgB5ApKUK4=;
        b=Y8b/8L3LbD0swljN1LSIk94MxdUn6HIAB7u7YDDpLRbrW9M8NyAS2QzS4OVpwG38Od
         OJyJUCL4cXubmknTVVaHWWZ6nyV+ZbEeS5Kn28Z75lrNQfOgt63csU5dB2i/9J0tdE+N
         lKk9DGaB89pco3UlA4+6fqRfUcF51sOQdH7ZCls76j7d3jRGd0R9/HQpdv0dDi5ZxRqY
         Zu9Pqab99vb1xHxhHt2OIdEhag/M9g6fOhZm51RHhgWXoLZdERVF7/CYQaFmUX5hLNim
         ezqNeyjOvyNlKZ7ek5ED/gDLgwQkf0Jcig14hPKQXyXMhNY2Um3Gvf8UXwB5PFPMcIrM
         dBIA==
X-Forwarded-Encrypted: i=1; AJvYcCWjer4Tt9u2J7AssnqViphdRkUp8D4JyPZyF7Sim0hnyYUYD5i/MHf0QsSMo8XwNxXHHpEL7U2QC/CxcxyUahHCUwlNZV9f
X-Gm-Message-State: AOJu0YzsRJ7/EFsdafJQac0VTM6c49YfLJxbIupIcxqAs4sgXWitiOoq
	xHIJ5O18oKTWcZLy7r/mjwEYKW5tDEPyBnJUyVf6g8CPMzGWMBfdPTS6PB+r/hyU8aQe+frbW9+
	97hY=
X-Google-Smtp-Source: AGHT+IGqmw155Q3yIZQQnkRDwG/nqm14bMzVG6d+hLJ9DIXKp3mUoZo96llflZNaLnVzFoL5uauEag==
X-Received: by 2002:a05:6808:2227:b0:3d9:2190:9d56 with SMTP id 5614622812f47-3d92190a02cmr3701431b6e.59.1720295779119;
        Sat, 06 Jul 2024 12:56:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-76c7a4c4741sm1467746a12.45.2024.07.06.12.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 12:56:18 -0700 (PDT)
Date: Sat, 6 Jul 2024 12:56:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@kernel.org>
Cc: roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, liuhangbin@gmail.com, Tobias Waldekranz
 <tobias@waldekranz.com>
Subject: Re: [PATCH v3 iproute2 0/4] Multiple Spanning Tree (MST) Support
Message-ID: <20240706125616.690e7b98@hermes.local>
In-Reply-To: <547c13c8-c3c3-495e-8ca9-d87156bfe3f5@kernel.org>
References: <20240702120805.2391594-1-tobias@waldekranz.com>
	<172020068352.8177.8028215256014256151.git-patchwork-notify@kernel.org>
	<d6e8ce6e-53f4-4f69-951e-e300477f1ebe@kernel.org>
	<20240705204915.1e9333ae@hermes.local>
	<547c13c8-c3c3-495e-8ca9-d87156bfe3f5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Jul 2024 09:26:46 -0600
David Ahern <dsahern@kernel.org> wrote:

> On 7/5/24 9:49 PM, Stephen Hemminger wrote:
> > On Fri, 5 Jul 2024 18:53:47 -0600
> > David Ahern <dsahern@kernel.org> wrote:
> >   
> >> On 7/5/24 11:31 AM, patchwork-bot+netdevbpf@kernel.org wrote:  
> >>> Hello:
> >>>
> >>> This series was applied to iproute2/iproute2.git (main)
> >>> by Stephen Hemminger <stephen@networkplumber.org>:
> >>>     
> >>
> >> Why was this merged to the main repro? As a new feature to iproute2 this
> >> should be committed to next and only put in main on the next dev cycle.  
> > 
> > Because the kernel support was already added, I prefer to not force waiting
> > for code that is non-intrusive and kernel support is already present.  
> 
> I have told multiple people - with you in CC - that is not how iproute2
> branching works. People need to send userspace patches for iproute2 in
> the same dev cycle as the kernel patches. You are now selectively
> undermining that process. What is the point of -next branch then?
 
The original point was to have kernel -next and iproute2 -next branches
and have support arrive at same time on both sides. The problem is when
developers get behind, and the iproute2 patches arrive after the kernel cycle
and then would end up get delayed another 3 to 4 months.

Example:
	If mst had been submitted during 6.9 -next open window, then
	it would have arrived in iproute2 when -next was merged in May 2024 and
	would get released concurrently with 6.10 (July 2024).
	When MST was submitted later, if it goes through -next, then it would
	get merged to main in August 2024 and released concurrently with 6.11
	in October. By merging to main, it will be in July.

I understand your concern, and probably better not to have done it.
The problem with accepting things early is the review process gets
truncated, and new features often have lots of feedback.


