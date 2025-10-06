Return-Path: <netdev+bounces-227997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8534EBBEE0A
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 20:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477983B14A2
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 18:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A51B2367BA;
	Mon,  6 Oct 2025 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQyGCy5P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00489846F;
	Mon,  6 Oct 2025 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773800; cv=none; b=J4VQDXDR1jgu2/fBffDblieZTmmR//NxLoYzuRAlDjZ1iNBoIYFb58giBcoypkoFIne+L+Sn6y5bKxPGHkBKrs3lACFTyyejrT4kE9tsicqdwrm3qA65MBrSwet+f7vTPt0ya+G16JdRWIghF83BlrxV6asyr93/BvtcATWIHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773800; c=relaxed/simple;
	bh=JfT+OvQluLlH5pIHQb9J60KQSfNDPS/YlsCoOl6VnGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOCdPtRILpghd176+UfBKrMu6ipFNu6lB6cWdYrHEGbZWufulmE1EJTJoCZ2j8mJdAnteJy00CHEtl3Dru4BkxkGB1cuDNrE5r4jAP9C7PA+lS6G1MWLVYzQLwyyG0vhJ230Dt8HfqLnykUPpZJlG5OAVsffDfM8dzzffYzr5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQyGCy5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A742BC4CEF5;
	Mon,  6 Oct 2025 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759773799;
	bh=JfT+OvQluLlH5pIHQb9J60KQSfNDPS/YlsCoOl6VnGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JQyGCy5PcoWmN3Cxt+jzQ1uv0PQF6ViJ3BHL0EloYR/AfMz+9uu/1Stna8q1DUOw3
	 1e+uoA+R4OdJE71Caxoq6ronE/OR5OKDg94cZKAvN7i6/0EnDLuz2uiP1O5wbxwgKm
	 HmTk/1ezmdXCiMMnT7QK8uRO3w9fs+V9oQSRVRXnJN/M9Tm5JnwtVdfo+llUDIc8rV
	 Wb3D/Q9CJMDhCbYzhZdLO+ME3uYHTSNrpRmg/rrax8QJ0DUzDkRHap8JboLS3CrW5u
	 NyM89RL+jBCmmecK7X7G4ZVGCirnEg/DVljbw3pWahBcRJ+i/NNBpb9JCRTCJ+jAI1
	 LNfUpVb2JR/0Q==
Date: Mon, 6 Oct 2025 11:03:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Ayush Sawal
 <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Leon Romanovsky <leon@kernel.org>, Steffen
 Klassert <steffen.klassert@secunet.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Harsh Jain <harsh@chelsio.com>, Atul Gupta <atul.gupta@chelsio.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ganesh Goudar
 <ganeshgr@chelsio.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: fix potential use-after-free in
 ch_ipsec_xfrm_add_state() callback
Message-ID: <20251006110317.39d08275@kernel.org>
In-Reply-To: <f0cef998-0d49-4a52-b1b8-2f89b81d4b07@linux.dev>
References: <20251001111646.806130-1-Pavel.Zhigulin@kaspersky.com>
	<f0cef998-0d49-4a52-b1b8-2f89b81d4b07@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Oct 2025 21:28:51 -0700 Zhu Yanjun wrote:
> When the function ch_ipsec_xfrm_add_state is called, the kernel module 
> cannot be in the GOING or UNFORMED state.

That was my intuition as well, but on a quick look module state is set
to GOING before ->exit() is called. So this function can in fact fail
to acquire a reference.

Could you share your exact analysis?

