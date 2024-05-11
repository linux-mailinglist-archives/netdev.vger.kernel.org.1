Return-Path: <netdev+bounces-95628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8258C2E5A
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD7BEB227A2
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 01:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB3D527;
	Sat, 11 May 2024 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkhHoqgo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5391D299;
	Sat, 11 May 2024 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715390015; cv=none; b=gKSqxsNUnzpk57Gu0je9e1N2vFdcKlx5xOtWTg8dkY7adprf8A+atGokHfb5kFwILDa7E7RqmF/gs78ZFDHJeAqj7++9WmAOYK6OGcsY1DXSln9Kof392evKcCK6+ucek0WRHA5y/jFO3dp14kQnAzbPdb6OdzG4BolEFgPPu7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715390015; c=relaxed/simple;
	bh=cgdoNz4tkjzgViPcjjibKmzb27Ek6YvixZ4sWrj09yc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsmKoGqI86zDS6+IR2lHWvm/NlzCtrW9fIQntlW/CC8Rtl4M96DOv3qiMS1M6in1BS8jsYEjZeTnJQisIQ8ANLwe7S4eACX9Gb0V6j7b14Hfiac5tHOKOohAmsLcYts/lH7bViGkuD1jUiRvPKt2bW0pl7dXfqATZJ95egl04PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkhHoqgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F3EC113CC;
	Sat, 11 May 2024 01:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715390015;
	bh=cgdoNz4tkjzgViPcjjibKmzb27Ek6YvixZ4sWrj09yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fkhHoqgo1p8NNgvQ06XjavWD0fegdaidqP30u+OHwFGp283Ip5qIVWwWn3Ka79zDB
	 Ri2pQ9/+UJ6KxXSoFQEL/PFbUJ4H4ctlyfzaFv0WT+bgJZ1loc/2lGF7EDosqBN02r
	 RQswNVf3ORD7oaT8axtuNhF/08gt1ZH/KkT7zcavegYeXqp3R+2+QVrstgbgxMZ9I9
	 JUi1d+nSJztzBiKImnYuoufwMugmYa10/uw2ibu1NBt/zm+nWClwrUPeCdJj+1gJzf
	 uzho9bVBQ9qwu7t6rj7TRrkLdiBgyMPyxEqkG/zi43ESKBE6ovfNH1reB4aWjFnOWe
	 uYuLDSDaeeNrA==
Date: Fri, 10 May 2024 18:13:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 richardcochran@gmail.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, Arpana Arland <arpanax.arland@intel.com>
Subject: Re: [PATCH net-next] ice: add and use roundup_u64 instead of open
 coding equivalent
Message-ID: <20240510181334.623b3fa3@kernel.org>
In-Reply-To: <20240507205441.1657884-1-anthony.l.nguyen@intel.com>
References: <20240507205441.1657884-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 May 2024 13:54:39 -0700 Tony Nguyen wrote:
> + * @y: 32bit multiple to round up to
> + * @y: multiple to round up to

@y kdoc got duplicated

