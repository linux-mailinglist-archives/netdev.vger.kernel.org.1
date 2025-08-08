Return-Path: <netdev+bounces-212276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DA0B1EE90
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 20:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAA0170AC2
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE06280A3B;
	Fri,  8 Aug 2025 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSZktX3f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275F127B500
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679168; cv=none; b=mvLRnYQWcm3uhflarLTuQZVbOfiKjtVaEbAwixLCEriAgrwUr4yzf3yN094PWraUpxgGcrPqPx3ZGE15DnWbSaKZMKMcOSlhXbbYDC9K7So2fkUt+ysXsDWYKiwh3C7s1dsYfu5Lbd3/3eNn/HUqFRYd3oKghmMbZXgqU9IsGVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679168; c=relaxed/simple;
	bh=YhbYQJP5+AQN0JpAOtiFJsxdb7GrVzXjGiCCWjHuPT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGABg1X3J81pRTypslnWYogqZJ6BRWq0tjHPKkymx12G2wcT1fdTIO65zvgGTr0luPmdKV4gI03XMxXpJxOIHIZre541ZU4Wt2Leetp1ra9EN88cxSOB2rkUTmCrp3lZCX7wWRKKcH0MuL/WXxDHhkhTq5/dutsA0XbCZSzFejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSZktX3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283B1C4CEED;
	Fri,  8 Aug 2025 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754679167;
	bh=YhbYQJP5+AQN0JpAOtiFJsxdb7GrVzXjGiCCWjHuPT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZSZktX3fY0369+VctQu//ySe0E3FcOTfLnSQMmRExR+xAas2dCEXSH6olZHWesPjv
	 hEkjdGSQwwULoH8wMlx5fiJ0hx5OdQyfntxGiRCC4vX3WyLr0gcFBdv5Qm3sr7CYX0
	 UkBAVy0LRr1fITlPZu3TJPJ3Axz4zXgY3Kuuq40IOFXF3luXKtJZYhabYGv6dg2MaE
	 oHfXiV1pspM/62v8zwWNMMpnPyimV3bAQJoG8I5PdjXhp9EE/9Xb3LCwlZ+A9zEqeB
	 V9EjzAjPbHVbVq3OstSQsPfFDCFtcHOZN2ZO7VM3DrDz6U0ComL1TA6hrm6AKOD/DS
	 d0ATOU3ZpOayQ==
Date: Fri, 8 Aug 2025 11:52:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, przemyslaw.kitszel@intel.com,
 jiri@resnulli.us, horms@kernel.org, David.Kaplan@amd.com,
 dhowells@redhat.com, Paul Menzel <pmenzel@molgen.mpg.de>, Jacob Keller
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v2 1/2] devlink: let driver opt out of automatic
 phys_port_name generation
Message-ID: <20250808115246.67f56cb6@kernel.org>
In-Reply-To: <20250805223346.3293091-2-anthony.l.nguyen@intel.com>
References: <20250805223346.3293091-1-anthony.l.nguyen@intel.com>
	<20250805223346.3293091-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Aug 2025 15:33:41 -0700 Tony Nguyen wrote:
> + * @no_phys_port_name: skip automatic phys_port_name generation; for compatibility only,

line over 80 chars

