Return-Path: <netdev+bounces-99924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BAD8D703B
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 15:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DFB1C20A45
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BDD1514DD;
	Sat,  1 Jun 2024 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm2U4CCs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11684824AF
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717248823; cv=none; b=uVQl1medZGfP8zBL50rWI07kq0Q4+d/HEdM2B98A4i8rW/fOiNpV0RKUEBLvEPJIcdJLLWOHK0YulF01RgmaG4XNOjU2QGJZ8B/afEi0o36bVeQwBPvc8Lg/Gf/QuQvOcVe+kAQDURe5aPMeVR2B0nE73bcVriBVH0xOGH0gY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717248823; c=relaxed/simple;
	bh=lMrkSwj7N4USsLv0Hz40V8mhCYK5QBpoPyADRYfebd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vml25CrN4QhexXdBabS2ciUcL+onAvltnBGUmGuuI83ObbqVcKcYXUiMZiXJSCVio3m/oQcgZO0+jfje68zr49Rqp6W5Sq1TYXsAhqqfT6B1yCzxCEtlu0TEfdMgbHeslUtDlaG9pH3WkL4NCU3spxVOHk6V7eed6OoXx4JJPlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm2U4CCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E1FC116B1;
	Sat,  1 Jun 2024 13:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717248822;
	bh=lMrkSwj7N4USsLv0Hz40V8mhCYK5QBpoPyADRYfebd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fm2U4CCsiXen38py/3m6MMiKAWn/5HUgD5zvhBtX0zrrhrWcX7v7H3+/chwD2I6ZC
	 COqtNnKOfJYVhiiOX7PXyR2s3eGZfWejo3MrLzOZFc084+7nx+1W5/HOKSM01+TPQY
	 EXX/xxWsNfcCilzO4sRcsLn8Bkd41gGx1y93WnfAeFUDN2eI8QCrhuYh4S+9xqhV13
	 x2aHuNIG/QA9MWH1pXX3VsPiJGuYHSeBUOP0+d7Aov7hdiV0zYEMEYHSSUEDd+SPab
	 bizDBbCoahi/ICpvxzO1vfmSrs22J6rFu9InK+ahDEABjEXcInSiOtcEQzvWnHTH25
	 JqaO/eD1o0Ctw==
Date: Sat, 1 Jun 2024 14:33:37 +0100
From: Simon Horman <horms@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, i.maximets@ovn.org,
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
	lucien.xin@gmail.com, marcelo.leitner@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
	echaudro@redhat.com
Subject: Re: [PATCH net-next v4 2/2] net/sched: cls_flower: add support for
 matching tunnel control flags
Message-ID: <20240601133337.GQ491852@kernel.org>
References: <cover.1717088241.git.dcaratti@redhat.com>
 <bc5449dc17cfebe90849c9daba8a078065f5ddf8.1717088241.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc5449dc17cfebe90849c9daba8a078065f5ddf8.1717088241.git.dcaratti@redhat.com>

On Thu, May 30, 2024 at 07:08:35PM +0200, Davide Caratti wrote:
> extend cls_flower to match TUNNEL_FLAGS_PRESENT bits in tunnel metadata.
> 
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


