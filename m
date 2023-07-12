Return-Path: <netdev+bounces-17271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6887D750FAB
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D70C281854
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD8420F94;
	Wed, 12 Jul 2023 17:31:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5304920F85
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 17:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2E6C433C7;
	Wed, 12 Jul 2023 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689183097;
	bh=RLANM1Rf2rL+ybWIdByM+k6HZWZtuPQnztSMhJLdouE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tTK3yzJR+a2ofuctlkUFuDrwdgYPrsPovUww2UmNXEwbp2BYEkEI39tBgwunXPgrl
	 dc/rdLVSfEUEpT2pk7PvRIxdqigwT97tv4NxXZEj6fEO1fMJAxW27SbJgl3OLJsk9z
	 Z2z4axFYJoZ8PUSGOz9r6PstfvS2HIkLF+i2J78uLCcAquvtNgnA3PHhpB9VwcQm5+
	 DtF8zaKfTlBTuMmXvRUhP0zjhfu1rzuPFmZPuaZ9Mqndq3IxQSS3fuWLGSx1a4qUUE
	 aozhfNI3sUbmZx3upTurlJOoiLn+TmxDjilIAud8OxogD/7WglPtYSudVR6mU/Yeom
	 ZqhAcgEu1ZgCw==
Date: Wed, 12 Jul 2023 10:31:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, Ma Yuying <yuma@redhat.com>,
 Simon Horman <simon.horman@corigine.com>, Rafal Romanowski
 <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next 1/2] i40e: Add helper for VF inited state check
 with timeout
Message-ID: <20230712103136.1a85eb91@kernel.org>
In-Reply-To: <cd7a39b2-c73e-6919-7ae5-5a2cea5a3ed9@redhat.com>
References: <20230710164030.2821326-1-anthony.l.nguyen@intel.com>
	<20230710164030.2821326-2-anthony.l.nguyen@intel.com>
	<20230711120904.GP41919@unreal>
	<cd7a39b2-c73e-6919-7ae5-5a2cea5a3ed9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 15:18:29 +0200 Ivan Vecera wrote:
> > This error is not accurate in the edge case, when VF state changed to
> > be INIT during msleep() while i was 14.
> > 
> > Thanks  
> 
> Would you like to add an extra check after the cycle or just increase 
> limit from 15 to 16 (there will be an extra msleep)...

15 or 16 is of lesser importance, the bigger irritant is that the last
sleep is no pointless. I'd move the condition check into the middle of
the loop:

for (i = 0;; i++) {
	if (test())
		return GOOD;

	if (i >= 15)
		return BAD;

	take_a_nap();
}

