Return-Path: <netdev+bounces-163735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E91DA2B71C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E41F16475E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50C54A1E;
	Fri,  7 Feb 2025 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="aqdCVZ7g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14274B652
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887871; cv=none; b=hDUidA+gYGw4kUvUzmQ6dU7uREVJ8eJZz77ekz15IhVt7pZkTTO7Yba+DJ4EvBe0ZCMahYP4WSSkcF8hPG0xSaMXvBZdiE+wOUsp+qJaIuAhPkVqaharvYOv8/4hlePbMLDhYvPPMZr8RkgOsrWWwAViwE+hNL1Ulznlpx23j6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887871; c=relaxed/simple;
	bh=lCeNMSB/4ZWSOWf6m/MbqEJ7UeUlQVQ2Mxdo8U/T/+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dN8XtHKcl40WMKI6yXoEwWqz1rJdbK6z9gb/mztAY8t9E2vd6AxhK+bGthLdfYdgPSLmCwiZ3kRK63PtvumTQ3ETH705C18xhcVeETrf1U+dk2t65yjRC1Xa/zIrGiOE/Goo0qgvBtFFxqUChrTtoqPQrWJJezJsl83Q98OyPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=aqdCVZ7g; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f05693a27so22854935ad.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 16:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738887869; x=1739492669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41PEVxVSksJRZRsl2JkWcFebR9jMlRm3TEy4GCAbKvA=;
        b=aqdCVZ7gbxuzIn05XfwMX2RJRrjmm/kDdcDN31kwJD663JdO58djbjhyhjbnbtTywN
         BtSf7D2OT4AumbFCrkOn1nl1bRUvBK4LDSU8pp6yxpQS3NSI0ilYoS1poxG94s88coqY
         9j90UdojD4HMOfQy1vfVpnDb98rGx6HHhHr1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738887869; x=1739492669;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41PEVxVSksJRZRsl2JkWcFebR9jMlRm3TEy4GCAbKvA=;
        b=MxbzoQDhbMJSB1gqt0IiOrGOJIFQfhP8AifDjjwdsc3iyJJCoZfUh5HxM7hSDT+cdS
         +81ZnnG7hDeaCct3ZqddBwpxMYmaYz3captTTAEv9uIu/gfAJdB3y3oCbV9lEfgqE6H9
         p2P3AXedQskTD5pGxb/BLG9qlyaAdt1igV5/n+CoVhk5Rmbo/MmMJiTvIVjMVXES2Wt3
         39QMjWdh/QJpKZGJy+HJ4JYHsePpYwObAPG4micE027axsrgayB8FfOaBjtGaQezU23t
         znbYSZn8C/b4EORphG2tHP4SKm7rZGriLj827ejgdScWmLAOalxS0KpIGoEAfK1sAq9N
         wnlQ==
X-Gm-Message-State: AOJu0YxNmzA0SjD8voEgLsis+xFc6OyV1nrH/FksLC95e6Ni91P7pUuP
	nFr0pq1+dBiht3VOhjj7sn9khgS7KBk0NPyTbjUiFWkXi/NV9sGCvFBujlXppR0=
X-Gm-Gg: ASbGncu0Vz2E93u+lKbqZEEUG7z/Pa24zkK2LaWEeNmbKlqNNI0VMW/IxtYWmPyQFe8
	TEOuxWbo1ZMoBleKTJ2WqujfjNdehk+yF496L8rpT9ZNqyRoVy/HgQoARxOYImXSS/rY+nnW1tz
	ez8Ls+u1RDJwK7PiZ7myQZ9mduRjr7u6doTrM1TElJsmYmDm39kQXfIfrKJnvGjikXxwDpRkM1y
	uE/fSJtzFfNgtJsRbrUntQcNpZExqqhvf1HsR8E4/07nWFu8xeNvT5TL7q+Q8WdEolXr1zcYuPb
	JHjrKvPWqgiETugPYMPTDCIvK1ZL5s77xFuB7WEnVxSf90Rzay47R4HpmQ==
X-Google-Smtp-Source: AGHT+IH6rlyqvq0mOIskiuL2LEecsrtfK2Yt8yyBIbeL1ahoyqR4WobEEPc36Z+vAEHPsqoMCHNM4w==
X-Received: by 2002:a17:902:f710:b0:215:a96d:ec17 with SMTP id d9443c01a7336-21f4e6b8bf1mr19054735ad.14.1738887869339;
        Thu, 06 Feb 2025 16:24:29 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e69fsm18941575ad.1.2025.02.06.16.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 16:24:28 -0800 (PST)
Date: Thu, 6 Feb 2025 16:24:26 -0800
From: Joe Damato <jdamato@fastly.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	horms@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	michael.chan@broadcom.com, tariqt@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	shayd@nvidia.com, akpm@linux-foundation.org, shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v7 0/5] net: napi: add CPU affinity to
 napi->config
Message-ID: <Z6VSumnSnqa3wHfu@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, horms@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
	tariqt@nvidia.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, shayd@nvidia.com,
	akpm@linux-foundation.org, shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com
References: <20250204220622.156061-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204220622.156061-1-ahmed.zaki@intel.com>

On Tue, Feb 04, 2025 at 03:06:17PM -0700, Ahmed Zaki wrote:
> Drivers usually need to re-apply the user-set IRQ affinity to their IRQs
> after reset. However, since there can be only one IRQ affinity notifier
> for each IRQ, registering IRQ notifiers conflicts with the ARFS rmap
> management in the core (which also registers separate IRQ affinity
> notifiers).   
> 
> Move the IRQ affinity management to the napi struct. This way we can have
> a unified IRQ notifier to re-apply the user-set affinity and also manage
> the ARFS rmaps. The first patch  moves the ARFS rmap management to CORE.
> The second patch adds the IRQ affinity mask to napi_config and re-applies
> the mask after reset. Patches 3-5 use the new API for bnxt, ice and idpf
> drivers.

If there's another version maybe adding this to netdevsim might be
good?

Was just thinking that if one day in the distant future netdev-genl
was extended to expose the per NAPI affinity mask, a test could
probably be written.

