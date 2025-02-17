Return-Path: <netdev+bounces-167058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A77E8A38A54
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 18:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFA41892531
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29CE228363;
	Mon, 17 Feb 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h24XgEsk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBA3227EB5
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739812099; cv=none; b=HFDaDh3THSKJP+1BK6rF4nZWHFnh86hAH41WSUSm6xq5HAqDSzIw9927qtF+pJ9LF+NR6H1Gs8DQrHpHSBpf47xKLVX1wk4EHUPafgySGT/6nA+KYJZfZE9g2/cwGf71KclaRst2WQKZBDLqbxUubBvAOi8bFCy3V+Y+dy4o7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739812099; c=relaxed/simple;
	bh=h9h5a9Wcg66A6AqsayVK1eGpYFikic7eCBSbxNPOXbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbONSqmWbSjHKETaU6VgEwmks+DtE0tfPFUQujyl7F6U/PA8f75wuvjkVmcUHxOEAccV4DB4d5W8UEzDelTm/2HOLfuogcIdTtIi5GTB4ymXBk3P19qW6hxTpuqB5Eb0dkAp1doLZTG+4NNWmPb0XxNPtibQGdei1Ud9fAXX29A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h24XgEsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E368C4CED1;
	Mon, 17 Feb 2025 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739812099;
	bh=h9h5a9Wcg66A6AqsayVK1eGpYFikic7eCBSbxNPOXbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h24XgEskUKrqAC9+rkIA7iDkoDT2Mr9tS8XcXFrEPxVFBQ632YH1qOB5KFrkxsrdK
	 IkqJZlxW+ccWuADCGH81W9GRjm60oz/HV8vehD0axHY/V11VmmeP4OY8jrhq0Ce1u9
	 6Sdy6TymuPkLyP1LSXMX1Semff0ZAlR7zdeuDLK+VNL0au3APpeJXtuaWBPPNJTQqz
	 r/D8dR4pr+qNSIdN+cVBtZYStSqCSdCGIla473OkWlsrPjH5lLvNK5mYo5XSigt/R2
	 hoO14NYbEMzBXWUN5fINZSDoSsYC5cTLbprLsiRBPLWMT1CxqSkwl99OVOq1yCBk30
	 XA7i7TzgRFZHA==
Date: Mon, 17 Feb 2025 09:08:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, Saeed Mahameed
 <saeed@kernel.org>
Subject: Re: [PATCH net-next v3 00/12] net: Hold netdev instance lock during
 ndo operations
Message-ID: <20250217090818.390e4efa@kernel.org>
In-Reply-To: <Z7NTE1DlI0nQjjwy@mini-arch>
References: <20250216233245.3122700-1-sdf@fomichev.me>
	<Z7NTE1DlI0nQjjwy@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 07:17:39 -0800 Stanislav Fomichev wrote:
> Teaming lock ordering is still not correct :-(

Mm, yeah, looks like patch 9. We need to tell lockdep team's netdev
lock is not the same one as the lower netdev lock. Probably gotta
add the instance lock to netdev_lockdep_set_classes() after all?

