Return-Path: <netdev+bounces-125989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A321496F786
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A261F25EC4
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6620B1D0DE4;
	Fri,  6 Sep 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2+VyV4Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CE21D1F51
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634589; cv=none; b=LkBlhtr3c6ovMnsBkC0l0ZonT/3Vrszsi5djn/JwVUeC6+4oPy9AHx3H17NRux3CnugAS05J+xf1FUbTDYsRfFMQ/P6L/p+wksxuNnDaEbJVmQgTugQx76rjwznsJbzsaEJf//oILI/p8pm8m4o3Z54w5QzENU1jApSXgD6dunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634589; c=relaxed/simple;
	bh=AkshHGJCwSA/c3f6URldN+OvwR5GGBWXTT+jVK+kycc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmxkCLb2t7Tiqig1+dMIqUD3XeoGrfb3lsBaQ/XLS928+tUF9ghBdzdjk6D3b+NA/jrXtpILXkn9JaoES2SZezEOV0viWzhqt94Iidv/MQMjnERrBv1PnqBovn8lihmS7yU7IkYFx7wTWexFBtX4x1lT0fFj2zqtATLa3VqD4gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2+VyV4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF60C4CEC4;
	Fri,  6 Sep 2024 14:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725634588;
	bh=AkshHGJCwSA/c3f6URldN+OvwR5GGBWXTT+jVK+kycc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r2+VyV4QvLvzv+zqnC5q3wVSimowr5/kOBnpkauhnl+91pyVjs3Kyzz6mCrnRsSCk
	 I1wi5Gwg+zaYsbwSiRqUKpGAje6mXNbZtMb64ZJ1BWUGSrF1N0rsEpC/hNMbX9sk/j
	 aKhRMItf4swfjXmZhbLjXdMhlxjKvrLNkSis/1Wr25Y4oIyJWaDGNpJXLVWLb43lho
	 c8tSIIRnd1995ugMWHoxBQgga/xPDWJkxdHwTy6Oioc4WX4JH2vuiumeNlkCRyVFhT
	 +cqNc2YfZ/LLPFmiSwRBe3J4+luHBXv16LqzrmKv3lbRNHsWrTjJjMDRko6/2oWe0n
	 poIzdyw3JTa9w==
Date: Fri, 6 Sep 2024 07:56:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v6 net-next 07/15] net-shapers: implement shaper cleanup
 on queue deletion
Message-ID: <20240906075627.523b66f9@kernel.org>
In-Reply-To: <896b88ce-f86c-4f00-8404-cedc6a202729@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
	<160421ccd6deedfd4d531f0239e80077f19db1d0.1725457317.git.pabeni@redhat.com>
	<20240904183329.5c186909@kernel.org>
	<8fba5626-f4e0-47c3-b022-a7ca9ca1a93f@redhat.com>
	<896b88ce-f86c-4f00-8404-cedc6a202729@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Sep 2024 16:49:32 +0200 Paolo Abeni wrote:
> I forgot to mention there is another, easier, alternative: keep the max 
> queue id check in the drivers. The driver will have to acquire and held 
> in the shaper callbacks the relevant driver-specific lock - 'crit_lock', 
> in the iavf case.
> 
> Would you be ok with such 2nd option?

I'd strongly prefer if you implemented what was suggested.

> Side note: I think the iavf should have to acquire such lock in the 
> callbacks no matter what or access/write to the rings info could be racy.

