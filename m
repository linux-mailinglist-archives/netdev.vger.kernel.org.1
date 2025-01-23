Return-Path: <netdev+bounces-160660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51637A1AB66
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 21:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95A43AF876
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 20:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0F1CFEBE;
	Thu, 23 Jan 2025 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qAMN0Voz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C9C1CF5F2
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737664026; cv=none; b=IzsQgRp5jbWz1BuQbp3+yDTBng8eZ7cXeRjWMHtlkCmhPrbZjV/PVkII7YiTzCA2LDL2x1yDqDUQ9zX1FjD04g34GCOYnbD+RELujR4KhRLldjuGJKc4+JS9khGD4XWZo7qUbZKFsk7xC3EWMMiypQg2/uWethhjoKZMPKs/5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737664026; c=relaxed/simple;
	bh=AjzINs+7xrekmJ3T/NM9/8N0e/0KyB/U2vhcKCGwYXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSuAxIyhxVGu6ftzHYuHEioQkh/XUvQIctA5fRj4APn2mNgFkcIhkHP8QUem6JhMR4YdMhPEF0A8SNzY5FKguZeUMCYntmwK8LOE53lT7BQ/KoksYG7msOUah6BCF0FG837+ifm+f6Ou+epSrY7qCJX4Uu901jQ70bp5DNVBIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qAMN0Voz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so1939689a91.3
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 12:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737664024; x=1738268824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1E8Wes9soW48PyI/Kb+C/5aCj864k4EZ/tvYvK1Pgk=;
        b=qAMN0Voz5/xYGR9izk3uhtMN6hHCaKQJB/dUWKbo1bGZz1J6Sii4v5GyJPUCEv+7Ic
         l95fYbCFeO9sY+sNDUGys83SXGea/akgLFy/AyML4j9tDv6L8gIRGTkT0ONhczMnXJPB
         jaZu7LE5jKyBIVnVFs70baL7b871cHYo9YJG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737664024; x=1738268824;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1E8Wes9soW48PyI/Kb+C/5aCj864k4EZ/tvYvK1Pgk=;
        b=E4EEu+LWxWHlaN9wJQHQD/5eCng3dg3ZxEDkGhXrXinsH6iuuOFyc5kknBqSi4DbL7
         EEGJ+v6I3+3dlNq/y3+H+ixjUG1dgKcw+LvUPXs/2ujoif3GrS42w/WcY5sAHwxKcdxs
         I/3fAPW8BT3ZLZSdS9pltzQEQwFWZ5NzMcoJVbwqYO+RMrcepFP73FSM3LlVUJjC/dpr
         hgTdx+zFw24ADLy6PuDyvDsuVc//iofX9XH5gRz4LXq5a5LRtZsidTUPdiELp7TVj93d
         RtiazfKHEO1y6dZxOTY2WOCNgA97XowYGWZSYqWq1QAyeVrmvsVtLoVx4ljrt5CD7ZfF
         wZ3w==
X-Gm-Message-State: AOJu0Yx1jmmu21+eAs1a38SMHRGO73edYRADjP3aKPxDzjfZNbHakLNh
	z0lbyUTmIdSvMgODhPNdtrXbBOTKA68u3wBO0rBIs7o0T8M7+XacYYyT2rySeS4=
X-Gm-Gg: ASbGncuogqbrvEZBffCnJsz80L0pWzAgFxMTCdQKPeid5U0dLDJgi2u3lgUvF22aokC
	6a2/f6cR9XrwVrEBGw7I/vWGn90H9yxhXFqiCnwXwIxOqk2sXk8v9hcxQBb57a35UJZuXRrL+W4
	tAsU1upfKPW97qZvW09y9dOjGsoY/qN4GSsWYPnFZVe5eQ0Xl7A+HxxPoUNKq+7iHUQvRmt0Dqx
	vD1pMdVWVU6pII/vT8BU5/0SstbFwc+Xo/yQzNY7tOTgyg8xknRDJKTfxno81fS+y2s0NoCv65a
	lJzKwUFkSUiXPAVyQXdH8Vhy+rMnoCSdtcFWi9shDBXvejU=
X-Google-Smtp-Source: AGHT+IF3uxjPwUFzQs8l1Xjs1kGf8hEf5axXZMU0HQEJXV+JRN1fGY1a666CyA83V1byq7axIHhQUA==
X-Received: by 2002:a17:90b:520e:b0:2ee:44ec:e524 with SMTP id 98e67ed59e1d1-2f782d8d6a8mr38739569a91.35.1737664024336;
        Thu, 23 Jan 2025 12:27:04 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffaf8961sm124932a91.31.2025.01.23.12.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 12:27:03 -0800 (PST)
Date: Thu, 23 Jan 2025 12:27:00 -0800
From: Joe Damato <jdamato@fastly.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	horms@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	michael.chan@broadcom.com, tariqt@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	shayd@nvidia.com, akpm@linux-foundation.org, shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v6 0/5] net: napi: add CPU affinity to
 napi->config
Message-ID: <Z5KmFNz7HDm9itoC@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, horms@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
	tariqt@nvidia.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, shayd@nvidia.com,
	akpm@linux-foundation.org, shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com
References: <20250118003335.155379-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118003335.155379-1-ahmed.zaki@intel.com>

On Fri, Jan 17, 2025 at 05:33:30PM -0700, Ahmed Zaki wrote:
> Drivers usually need to re-apply the user-set IRQ affinity to their IRQs
> after reset. However, since there can be only one IRQ affinity notifier
> for each IRQ, registering IRQ notifiers conflicts with the ARFS rmap
> management in the core (which also registers separate IRQ affinity
> notifiers).   
> 
> Move the IRQ affinity management to the napi struct. This way we can have
> a unified IRQ notifier to re-apply the user-set affinity and also manage
> the ARFS rmaps. Patches 1 and 2 move the ARFS rmap management to CORE.
> Patch 3 adds the IRQ affinity mask to napi_config and re-applies the mask
> after reset. Patches 4-6 use the new API for bnxt, ice and idpf drivers.

Thanks for your work on this; I like the direction this is going and
I think providing this functionality via the core is very cool.

I am hoping that once this is merged, a change can be made that
builds on this work to eliminate the duplicated

  if (!cpumask_test_cpu(cpu, affinity_mask)) 

that a few drivers have in their napi poll functions with something
more generic for drivers which have persistent NAPI configs.

