Return-Path: <netdev+bounces-100030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDF08D786E
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 23:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F6AB20BAF
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 21:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BB05FDA7;
	Sun,  2 Jun 2024 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb0YxSaa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2771210E6
	for <netdev@vger.kernel.org>; Sun,  2 Jun 2024 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717365416; cv=none; b=frI5neNvgSuhv6BqB6MczYsImxji2ReDc4wR4ywwwyevZB8ZjQKanX8CUeDSWFYFg4hw/ekxlUHoGLggcyGwwz1EGLtrQ3GxgtQOZvrhyOV42dqC2TnrdFUzF1arot1CPALeiTIUsQbC6XOX7N9e/z0kpmU3fSvZZbsJFfVDcY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717365416; c=relaxed/simple;
	bh=nwVcsf6YEV7+2JElKC6mJ1s5ktK9g3XV776/1DVWCGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAEHgfOzh3LbZ6RbqkMYiMYjGExoWBqNcJdce2FPbAATTRp3tL+XbYovNaJEDpzb5clLBwPCa8Cigi6pOTA4g3xU2qRdNh9l9c5N+UKAFPt0od55engy6NGRlYNym6aKPlwzVFkze2LkCc8n+xg3kEkkcB5DXCBOy8HIeeJpd4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb0YxSaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DB9C32789;
	Sun,  2 Jun 2024 21:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717365416;
	bh=nwVcsf6YEV7+2JElKC6mJ1s5ktK9g3XV776/1DVWCGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hb0YxSaarKsWlb6yICQN1MJEyntmxJpGrlnnq4+hMUKRsOTtFwW1mC0FyRYutyLp/
	 wyCa3Es3X86tIkPu2o1xl2Ftz7YgF0vx65S5nncEI39Vn/ufYmmigwpxFCqTTT0GoR
	 Kzalow7INeuUNvjsR8uCVfskejRZRdYPt5mOe7abmzRXNTbQoCmGVSHdVsuJKBhWG5
	 oDFZisigUKABP4iwsQLQh2THbbrCk+9mY8SgG+YQeqM3C8FzYDJ8xjPcqizSke3ohz
	 K/r8Oa/Pvb/saQJcGBSXONJ0OdiwRHpV+NDdAMaHsxfiYvqq39NQuYuCeescWggpNs
	 cdi8eFc8hzgBw==
Date: Sun, 2 Jun 2024 14:56:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: netdev@vger.kernel.org, Igor Raits <igor@gooddata.com>, Daniel Secik
 <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>
Subject: Re: [regresion] Dell's OMSA Systems Management Data Engine stuck
 after update from 6.8.y to 6.9.y (with bisecting)
Message-ID: <20240602145654.296f62e4@kernel.org>
In-Reply-To: <CAK8fFZ76h79N76D+OJe6nbvnLA7Bsx_bdpvjP2j=_a5aEzgw-g@mail.gmail.com>
References: <CAK8fFZ7MKoFSEzMBDAOjoUt+vTZRRQgLDNXEOfdCCXSoXXKE0g@mail.gmail.com>
	<20240530173324.378acb1f@kernel.org>
	<CAK8fFZ6nEFcfr8VpBJTo_cRwk6UX0Kr97xuq6NhxyvfYFZ1Awg@mail.gmail.com>
	<20240531142607.5123c3f0@kernel.org>
	<CAK8fFZ5ED9-m12KDbEeipjN0ZkZZo5Bdb3=+8KWJ=35zUHNCpA@mail.gmail.com>
	<20240601142527.475cdc0f@kernel.org>
	<CAK8fFZ76h79N76D+OJe6nbvnLA7Bsx_bdpvjP2j=_a5aEzgw-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Jun 2024 07:35:16 +0200 Jaroslav Pulchart wrote:
> > Ugh, same thing, I didn't test properly.
> > I tested now and sent a full patch.  
> 
> I built the kernel with the new patch but still do not works but we
> might hit another issue (strace is different): See attached strace.log

Thanks, added that one and sent v2.

