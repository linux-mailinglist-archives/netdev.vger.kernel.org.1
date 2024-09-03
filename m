Return-Path: <netdev+bounces-124614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A4396A369
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91B4B2627F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC1C188A22;
	Tue,  3 Sep 2024 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayyqdHtq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B823188A1F
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379009; cv=none; b=t95cT8C84acWW9VGuawG4plcet/RL1AgT7af6wzlxrmn3CRX+e+4pQ7uW3cQV06sRdvYsuE4+DolY1+sQyesrLyYlN/6h1mr3QZ9irbKL+WiGrGj81pPGJxbB7FrK5rk5rEMUXfJCrmhor3UpzzhsgxjujelA3ijpnxToWIpc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379009; c=relaxed/simple;
	bh=JnyCF259xXx4hXkOTANrGXvAwOA2sDX9S9TjhukgUw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAaJ7+8/NVpK6gPWgwgt+XllPwWrCkuawkYeH2/r5BMr416+O4PDqLnLvpljwTCLMaT040n8BFP1MBeMer7nHMEgco+1EH5a96v4sKpMwDVh2ZW0r3wxfH4dSOrIVVdEbqmncYI4TmY1trPDIMh1700o+p1S3Do6u5aWmMCAkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayyqdHtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446A2C4CEC6;
	Tue,  3 Sep 2024 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725379008;
	bh=JnyCF259xXx4hXkOTANrGXvAwOA2sDX9S9TjhukgUw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ayyqdHtqirKg/jJiIch1Ei2uFq81LXB1v8KFmqOhkXPVz35ujZzwjc7d65YC3V7yT
	 QEDaNqG2VceR/g52Fb2+hV/qWbPiWetKyooex8I2xfoH/Y//I6f1ulRmAzVb9SxTmP
	 XYDKrQamzi9O5Rp4RIGnu545z+YfVid+AhtSJHBjRVSM5Xi8pviGm8I90AHaEfGloz
	 jhhTasjwbdFhTxYY3KM2BsflDre28om1gBgdE+xa7ynQpPOJUAnnkyzzYBahK62VpN
	 GTRfgvIjsSiHKUk+AzMaVotIixnYGxSsBKMHItJ6OhXFjl+Y2oxAoWnpL/tEyUoCBo
	 FcBlsbgYCCctg==
Date: Tue, 3 Sep 2024 08:56:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Tariq Toukan <tariqt@nvidia.com>, Jianbo
 Liu <jianbol@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>, Simon
 Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCHv6 net-next 0/3] Bonding: support new xfrm state offload
 functions
Message-ID: <20240903085647.77460623@kernel.org>
In-Reply-To: <Zta2eKJAMY-7fZzM@Laptop-X1>
References: <20240829093133.2596049-1-liuhangbin@gmail.com>
	<Zta2eKJAMY-7fZzM@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 15:10:48 +0800 Hangbin Liu wrote:
> I saw the patchwork status[1] is Not Applicable. Is there anything I need
> to update?

Majority of the time seemingly inexplicable Not Applicable status means
that DaveM tried to apply the patches and git am failed. Seems to be
the case here as well:

Failed to apply patch:
Applying: bonding: add common function to check ipsec device
Applying: bonding: Add ESN support to IPSec HW offload
error: sha1 information is lacking or useless (drivers/net/bonding/bond_main.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"
Patch failed at 0002 bonding: Add ESN support to IPSec HW offload


