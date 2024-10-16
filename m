Return-Path: <netdev+bounces-136274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E049A1232
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A6B1C210BA
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC33F187858;
	Wed, 16 Oct 2024 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM0dDbt2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317412E75;
	Wed, 16 Oct 2024 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105251; cv=none; b=sU+0V82KE8yWwUkmOgGGmC1z63i21QRBXlQ78cwnr+MzkRNcojnO76JXkKesSJUqE0dWrUAzsQXk74MM7rgdA6y7r5Ggrx03vewToq5xtjZdyvTLJV8+Eu6E6VnhfW7U2mwwXTfEg4ES23JhLxdSfRlft4sUEyJJPjXGcDN3aIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105251; c=relaxed/simple;
	bh=2vHhwmlrazGFWY252vI+p1h6I8ahjtXaTN0s3tlNPvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIO10CmZQtwM+6bFglgtW9ECfwORwUNiG6++5hvjH68CU030g+8IB0CsFGImzf5V/sz/bjhr9Y5urG8GbacKpABH9HSBa6u98xaMJrvqco+YJ9aArZ7u93UhQfIwa46utWo0r11weAdJ22xhetP4Wj78GGURBrUlUtZdQ4LiIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM0dDbt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC14C4CEC5;
	Wed, 16 Oct 2024 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729105251;
	bh=2vHhwmlrazGFWY252vI+p1h6I8ahjtXaTN0s3tlNPvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kM0dDbt2RnsUPlhBMnvWYBJaxGqEPZ4OF7LesfYIcFiTq4QjcUW7jzQcwEB0yAqdy
	 tMjxoc1Kc2cIHyg0nTj4aS6Scmml44GN5XeylIfQOwee2wGC8FV2BNXPRcruh+Cx76
	 J/vOlUx8Wbm1+/QpCkIGt996g25qUmHl7DYFGCR+YBc4zkfiTBI+/7SCSawGglLAd/
	 WwjUQgjiUel0gmX2tbFO/kBHV3+eVgi8snQYdVFNIxsb8fggVx89sqlP8x/UfhaYsi
	 5BhEK1V+k6kMr2i+QFTS4daz7X8XMoH7/5b4FH5DFMqtKFTjhGlkDSQYaKTyzrTAJO
	 sYTZqlDNv7f0A==
Date: Wed, 16 Oct 2024 20:00:46 +0100
From: Simon Horman <horms@kernel.org>
To: Wang Hai <wanghai38@huawei.com>
Cc: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	VenkatKumar.Duvvuru@emulex.com, zhangxiaoxu5@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] be2net: fix potential memory leak in be_xmit()
Message-ID: <20241016190046.GO2162@kernel.org>
References: <20241015144802.12150-1-wanghai38@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015144802.12150-1-wanghai38@huawei.com>

On Tue, Oct 15, 2024 at 10:48:02PM +0800, Wang Hai wrote:
> The be_xmit() returns NETDEV_TX_OK without freeing skb
> in case of be_xmit_enqueue() fails, add dev_kfree_skb_any() to fix it.
> 
> Fixes: 760c295e0e8d ("be2net: Support for OS2BMC.")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
> v1->v2: Add label drop_skb for dev_kfree_skb_any()

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

