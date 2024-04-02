Return-Path: <netdev+bounces-83911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F18894D65
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 10:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56662831D6
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 08:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA7D3DB9A;
	Tue,  2 Apr 2024 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+IobMaR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0643D996
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046508; cv=none; b=r3/R3wKMVNoB8Io5xscEzkhrNV6j2DJyPnHE0aR3BmCTD/deV/MC1rY1PEGpCMJ8bJj+9ZgdEY7czgVhhFoJEQnM+cpyIhnHJT7FbGqrR3/3bPrke4U51VeCfy1bwX2dPTqFwQuQ2XohV+6i8AG3DtxSbaLQ0ocDDXDq2udHRUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046508; c=relaxed/simple;
	bh=GYotwLJNZuQDLnqMlIBHiyoLzXuP2UzZxzfh3kIEElE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfujzWs3Rhk5wxrhKYqEfML5jV1/KBNoe9ybKMPYjvzzFq6gRm2C325SfuszJ7rVgJOjoJjpy1lom0nh7Jb7jY0tXGjAB3rnvBm8Dk4EF6cjoyO5Um/8MrKatMV+zNaMbdiwKordw1PiPyGqsAVaPVox1foAdKwLAhDOvmw0pSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+IobMaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FCAC433C7;
	Tue,  2 Apr 2024 08:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712046508;
	bh=GYotwLJNZuQDLnqMlIBHiyoLzXuP2UzZxzfh3kIEElE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a+IobMaRz5izLqOycsRiUI97bqwaDGv0BOF12+DWSPQi6c2KcztIr3hAEwXm8rDNm
	 e7gt8BFCbv5ZfFnuyeIThpTW/09vU5jmwnaqrqOPvq8cCEnAzHUp8+2OtDWPVG4QzH
	 IcaGOJWUcYJURn7BQtI1qPluijAP2QuxsoxJOLQH1cnQlznG0QTGs9ssgyQESj0ydV
	 DOstJUMuB96mifEoH9BlIDuQSaadX4fbsgaP28DjYrYzSrzPtqNQ7DT4QLnlsvX5I8
	 aM4+AHIGDlF46jWS9Yz8NoaDEp+fk3kplodhELIL4C0ranxtDUdVupNwRuGvGIwqlC
	 Wi3K34eya6gGA==
Date: Tue, 2 Apr 2024 09:28:23 +0100
From: Simon Horman <horms@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
	victor@mojatatu.com, kuba@kernel.org, pctammela@mojatatu.com,
	martin@strongswan.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net-next v2 2/2] netdevice: add DEFINE_FREE() for dev_put
Message-ID: <20240402082823.GF26556@kernel.org>
References: <20240328082748.b6003379b15b.I9da87266ad39fff647828b5822e6ac8898857b71@changeid>
 <20240328082748.4f7e1895ed81.I1515fdc09a9f39fdbc26558556dd65a2cb03576a@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328082748.4f7e1895ed81.I1515fdc09a9f39fdbc26558556dd65a2cb03576a@changeid>

On Thu, Mar 28, 2024 at 08:27:50AM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> For short netdev holds within a function there are still a lot of
> users of dev_put() rather than netdev_put(). Add DEFINE_FREE() to
> allow making those safer.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


