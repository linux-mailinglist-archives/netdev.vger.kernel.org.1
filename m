Return-Path: <netdev+bounces-217881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E17B1B3A457
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A002D1C80FCA
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03429225403;
	Thu, 28 Aug 2025 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/4Mg2a7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A730CDB5
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394749; cv=none; b=DdESXRWRtfVvi3liUO04kz0GM0M5g92kEpgigTPxsC0Lu7OknU2UR4GlVuJlZfPK870JuGGkhG+ihyXDF0W2PvUwwhb0MXblurYy1unqYDyoKZ1DDOzJYgTl57ODctt5/Mus0B4I4cjtKcqe39Oif4lN2crfqtP3POpkVsEedwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394749; c=relaxed/simple;
	bh=iQjNFeSm5HY73EWoorKAwvqrr3EMMKfqlvkjWftmr+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE2BY93eq0KlGeykwBqzUyo0lwrlojEhCdpiUOtG/Q2RaQcy+6d3flxa6HfLPDCcD/m3e6PGk4iIF4YfGbiq7Hh78hH4mWgIaoA79o44pmESw6OxIIcu6AwlIVZ1itXxLt8K87ah0jJTM16u8D8eI7NosdqM1exzxqTdHeEjNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/4Mg2a7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BDCC4CEEB;
	Thu, 28 Aug 2025 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756394748;
	bh=iQjNFeSm5HY73EWoorKAwvqrr3EMMKfqlvkjWftmr+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/4Mg2a7oxt84AZ6D9V0q/Egi7ycFHPNLesT2LmuKwO+93YuA1+XLiiPERgXQBfS+
	 kWHGD6xTB5CcqykXAQOA6IX4TTn/W+eLJIMN/Ho3iD20Nv3nkdxLGuBh+QhXn/QmTN
	 MqHb644QWHN8RNVQS1cokneXQk71pJj29MYJcQD7ogSz3C1ayYSuiCGwGEVBCurCmO
	 /tMii0GEbokMhnz69W0xmnXElog77DvBcKBeeCd1UYQM3sIEbM6rg2HPKXrI8aJ3sZ
	 v1xmpRP/RPU31/3OVvDTKN1cJsR8R7vimUNFk3v6iS3Lex5mSc5GkB+IRvbkdxRFnm
	 VwO0Wi9C2b9Yg==
Date: Thu, 28 Aug 2025 16:25:44 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/4] net_sched: act_vlan: use RCU in
 tcf_vlan_dump()
Message-ID: <20250828152544.GR10519@horms.kernel.org>
References: <20250827125349.3505302-1-edumazet@google.com>
 <20250827125349.3505302-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827125349.3505302-3-edumazet@google.com>

On Wed, Aug 27, 2025 at 12:53:47PM +0000, Eric Dumazet wrote:
> Also storing tcf_action into struct tcf_vlan_params
> makes sure there is no discrepancy in tcf_vlan_act().
> 
> No longer block BH in tcf_vlan_init() when acquiring tcf_lock.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


