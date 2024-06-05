Return-Path: <netdev+bounces-101112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D41488FD627
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846861F23B3F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 18:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E7013BC1B;
	Wed,  5 Jun 2024 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0vWrlMl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606D413AA3F;
	Wed,  5 Jun 2024 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613933; cv=none; b=mdRJPICjVI8NZ7sPVnHx6suMUCvCQPLOK7Pok9Fn8Pjuwr7Qjyc/Bx8IeHnzO/F9xsOLARgZvHXj2QWss/t0x+9tcqFExMGlewWvlFERbAAloWhDcgYMkhuAewiUhqdVnYzUDvylOB2XuFcCfyDJ4YJaGAKoLT3eLzFXlzi42ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613933; c=relaxed/simple;
	bh=w1G9Oy3BR84r7WDCDEjU/smytorKBoYjKrur2nAtEeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACO5C5Pq2W9WIBpE/JDvcJ/dMWI2KVByHQODmXtPnES/oWkKOy2nvnvYk0bhquwiSfOdV+eKR5KpF1G7Q4e4dLtcYeq03JGPEx9kHLv56mYYu6ea5dRDo8I+jEokTDMsbTRxMY4bOTDurP0q/gycIw8V+PBu0x/15sTk0/6W2gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0vWrlMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6EEC32781;
	Wed,  5 Jun 2024 18:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717613933;
	bh=w1G9Oy3BR84r7WDCDEjU/smytorKBoYjKrur2nAtEeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0vWrlMlRj4c1iScujbH5fsyGqtYPyP+/J0VJNX4ix9iLi62oUIDLwnohofDukOsm
	 EySt6P4ujd48YhL2UYG1uzc4Egw4XJ/Gat/kQnIYtrwMj9VK1pQ1iwtCgWoqx7nPkB
	 PZVgPcg9IRc5rTwGSokHOze9XEZcuLIKMIAf0rgODSqbuA22uVD3u5Z4IxtPfj4Ued
	 /0TKGZ9XHvVYRSiARf9kxsXjAkMwZwEq3dyoFhMlWj7SezQ8aufULPgYgxYi73afkn
	 9B1uaZjQad5b6KKyX/eyu7v+PaN4v3hEoBatvmlumA64STa6ptiYuyzGjNBCGL60GP
	 SdVOEIoS6KjwQ==
Date: Wed, 5 Jun 2024 19:58:48 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: M Chetan Kumar <m.chetan.kumar@intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: wwan: iosm: Fix tainted pointer delete is case
 of region creation fail
Message-ID: <20240605185848.GV791188@kernel.org>
References: <20240604082500.20769-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604082500.20769-1-amishin@t-argos.ru>

On Tue, Jun 04, 2024 at 11:25:00AM +0300, Aleksandr Mishin wrote:
> In case of region creation fail in ipc_devlink_create_region(), previously
> created regions delete process starts from tainted pointer which actually
> holds error code value.
> Fix this bug by decreasing region index before delete.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 4dcd183fbd67 ("net: wwan: iosm: devlink registration")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

Reviewed-by: Simon Horman <horms@kernel.org>


