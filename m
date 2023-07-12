Return-Path: <netdev+bounces-16995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E00F474FC3E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278D128181F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D75374;
	Wed, 12 Jul 2023 00:37:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB746362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751F9C433C7;
	Wed, 12 Jul 2023 00:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689122252;
	bh=kJTpZl3S/kIaQrY3t/rFL5opcgZYJgCgLqA1XVkhmls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U6rZhEBkGj4xIexCAqsOed49+q8XlrrFzvPRd5ih5ksPAPGpUKpKEqhSfXlZsndIG
	 1XXCdqXDyPsu5Vb5pW0ExLW12lUF82H2PmeW0XEG96zHDXs1CwFPcgF0QRyeGQJmWg
	 5FIIGVldvJ1gYZsTSYa0tXwhedKudw+ma4R+bva3lun3Ynn3Ii7hYILZIR4mDWgBbV
	 cbDVBwZPzbsG/Szhd/zows1ReeJIziTTAfOQECnGZZGVuKNgqZMEiMzpRylWfPQDJN
	 G5bPQnRcOESkNpRj+xMuEo3HnebPwH/v1xxeDi/2eRY1jiz+MPPMExG/qCLIL7tvYd
	 2BmmDqvvuLyKQ==
Date: Tue, 11 Jul 2023 17:37:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, Ivan Vecera
 <ivecera@redhat.com>, Ma Yuying <yuma@redhat.com>, Simon Horman
 <simon.horman@corigine.com>, Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next 1/2] i40e: Add helper for VF inited state check
 with timeout
Message-ID: <20230711173731.54b9fa80@kernel.org>
In-Reply-To: <20230711120904.GP41919@unreal>
References: <20230710164030.2821326-1-anthony.l.nguyen@intel.com>
	<20230710164030.2821326-2-anthony.l.nguyen@intel.com>
	<20230711120904.GP41919@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 15:09:04 +0300 Leon Romanovsky wrote:
> > +	for (i = 0; i < 15; i++) {
> > +		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
> > +			return true;
> > +
> > +		msleep(20);
> > +	}
> > +
> > +	dev_err(&vf->pf->pdev->dev, "VF %d still in reset. Try again.\n",
> > +		vf->vf_id);  
> 
> This error is not accurate in the edge case, when VF state changed to
> be INIT during msleep() while i was 14.

Right, it's a change in behavior from existing code,
old code re-checked if INIT is set after the last sleep.
-- 
pw-bot: cr

