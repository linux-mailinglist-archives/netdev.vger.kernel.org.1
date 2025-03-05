Return-Path: <netdev+bounces-171897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBF5A4F39D
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FFB16EB84
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E4113D8B2;
	Wed,  5 Mar 2025 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed0PkaVf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D8511185;
	Wed,  5 Mar 2025 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137999; cv=none; b=VrTZ0njar6hQZsgLFaCkxHafhraxfuIXVZrn0vKpwn2yM9eQPsI5UWIFw7f5Lt3xNneW0GThUMjRODsR66waXtsXjVjHPLfAT38zo3qsLgvQrciBIYGl0b5GTtpHnHesbB4gvFRlc/KreiXsZO+obYFxrGBfN0l8YEPLOZ2KzB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137999; c=relaxed/simple;
	bh=No48rJZ9BUtGKhIoMFiw/HS/FMwjx8s58pDxfgR/Z5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b16uJTBrLnYjVVCcQoa7O9ry+Uz9aj617OXmslnlweNrVgntNJhBBwqt0kxgOaKXWWLwzcZQCWk1zGqGMDDYcUhg1Hnc7Gp+ZXJzcDgiirl1ikxmWwm3zGtiKsVE2XC+UM6zdkcPppvHfSarfeZKLvbLluOSHN795Fsq9HvaDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed0PkaVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F7AC19422;
	Wed,  5 Mar 2025 01:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741137998;
	bh=No48rJZ9BUtGKhIoMFiw/HS/FMwjx8s58pDxfgR/Z5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ed0PkaVfMacdhTE89Pj6FIh4ALkwsAL5apZItPR2KuoIaMVRGAcYubTKPCkNw1VIc
	 3E2XY7ADkMBUFVQjyZCB83XqPJ3pRFnSfH/zbnuMA50wXiqZON+WPo50nR8gR/hyya
	 434Zn6+kCqlWT+1/6EhJPp/gvxmK8GQl5Xluuz9To0ferdBtRSLesP0O8cHo/ZaYPv
	 ryIV6300mXSIj7Wa2o5qTRuvVRydPrCef+0M5ZcO6vZSQIHbPaa73+bUrkQFyGUlu/
	 CiqY/Y1gUzZH4eVI1DslBxcLKBCx71cGvtD23ImTahwgI+WjpB2O/wDPZ4rBwMjq+K
	 8ofqeBMakFaDg==
Date: Tue, 4 Mar 2025 17:26:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <lcherian@marvell.com>,
 <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
 <andrew+netdev@lunn.ch>, <bbhushan2@marvell.com>, <nathan@kernel.org>,
 <ndesaulniers@google.com>, <morbo@google.com>, <justinstitt@google.com>,
 <llvm@lists.linux.dev>, kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH] octeontx2-af: fix build warnings flagged by
 clang, sparse ,kernel test robot
Message-ID: <20250304172635.000866fb@kernel.org>
In-Reply-To: <20250303191339.2679028-1-saikrishnag@marvell.com>
References: <20250303191339.2679028-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 00:43:39 +0530 Sai Krishna wrote:
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_o
> e-2Dkbuild-2Dall_202410221614.07o9QVjo-2Dlkp-40intel.com_&d=DwIBAg&c=n
> KjWec2b6R0mOyPaz7xtfQ&r=c3MsgrR-U-HFhmFd6R4MWRZG-8QeikJn5PkjqMTpBSg&m=
> 3BTQZwLYQz62kiZ1f9l4NBS35e13zrdP_5Hx9-1k5Xt-PgWUMdRcW7G4m5xytsHn&s=OeX
> wAXPel9ALwlzw4B26ORCXJF_gbqT9Sk3-opDDfgA&e=
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>

Your email server massacred the tags.
-- 
pw-bot: cr

