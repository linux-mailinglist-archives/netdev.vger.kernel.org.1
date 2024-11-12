Return-Path: <netdev+bounces-143990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41CD9C5028
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA8D1F21E6F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 08:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BCF1AB535;
	Tue, 12 Nov 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VMFzu641"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16319D067
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398442; cv=none; b=DTW0bRoR8NydxeAWlD0tvb/3ciZmL5y0J+UpAioNBmB0lxCty2M++Qxk1/oQUTUmeel1L0oa2zqL2q9OfiWJCUAQ4DQRsX7heRIpHygw2Tb5QucJGwP9KksIhZq5toPJGec1roIFbPRjtTHtqmHM72ukX5GvqoXcyRrV/auzxvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398442; c=relaxed/simple;
	bh=wXb3qUhuq8utOMpZPN9n2g4NnHeNjqOE02UUw/rXJLY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH1B6hSneAUyQgW5340p19pPV8ynSo+xJNt+k6tyvxULSHkahp6WZImUFxueOM4YTfksHrNJOYxB3yFsvyV/bDd9VmwuLlTTnDZul3MmMPqAr+0JNT/nY9NqvZsnZ69huMkB9cF0kPMJPf5vMJnVFAKjAug4MctTTouzKYni8XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VMFzu641; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A7E87207C6;
	Tue, 12 Nov 2024 09:00:30 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XnT49Yy7MWnN; Tue, 12 Nov 2024 09:00:30 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 21ED3207BB;
	Tue, 12 Nov 2024 09:00:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 21ED3207BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731398430;
	bh=78nIx6/N70SoTK638TSBLKr35S5cXKr5nIZ4FGDJ36s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=VMFzu641AE5X1WylsTElUdiHU3UsvfowG7bi6Gio5JjwwFvfU/z1SjLkO2fxfbeys
	 CktFDZ6kS8LGFALF+lwVtuBGOAyBYwsjwkko8BBzh/VmPFS9TCGaJRgqxcSXwOElya
	 Jy/IDRTbUFtVcgPgJ2dP1qlVu/C5cNEMmJhbAngoxqmVL1OBBJn0n1IvFDIpM+MZKX
	 NX+rSnM2MLD+uyiJ+XPWcLPNvb+5uHVrly2jZTDZq5oHe7lnMuYNVbhjdne/VFk0dM
	 FDU5QwP4i1wUpixXiJifPVgkSEEPrhafIKkq5OoVA9KUXzv5ZqMf7speK40P9nz9eM
	 NtmowHmyqG0hw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 09:00:29 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 09:00:29 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 0DCD73180304; Tue, 12 Nov 2024 09:00:29 +0100 (CET)
Date: Tue, 12 Nov 2024 09:00:28 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Guillaume Nault <gnault@redhat.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, "Ido
 Schimmel" <idosch@nvidia.com>, Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v2 0/4] xfrm: Convert __xfrm4_dst_lookup() and
 its callers to dscp_t.
Message-ID: <ZzMLHKLEKelIf3f8@gauss3.secunet.de>
References: <cover.1730387416.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1730387416.git.gnault@redhat.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Oct 31, 2024 at 04:52:27PM +0100, Guillaume Nault wrote:
> This patch series continues to prepare users of ->flowi4_tos to a
> future conversion of this field (__u8 to dscp_t). This time, we convert
> __xfrm4_dst_lookup() and its call chain.
> 
> The objective is to eventually make all users of ->flowi4_tos use a
> dscp_t value. Making ->flowi4_tos a dscp_t field will help avoiding
> regressions where ECN bits are erroneously interpreted as DSCP bits.
> 
> Changes since v1:
>   * Rebase on top of ipsec-next. Now we don't convert the ->dst_lookup()
>     callback handlers since they they don't have any "tos" parameter
>     anymore. Therefore, the original patches 4, 5 and 6 are dropped and
>     replaced with the new patch 4, which just converts the "tos" field
>     in struct xfrm_dst_lookup_params.
> 
> Guillaume Nault (4):
>   xfrm: Convert xfrm_get_tos() to dscp_t.
>   xfrm: Convert xfrm_bundle_create() to dscp_t.
>   xfrm: Convert xfrm_dst_lookup() to dscp_t.
>   xfrm: Convert struct xfrm_dst_lookup_params -> tos to dscp_t.
> 
>  include/net/xfrm.h      |  3 ++-
>  net/ipv4/xfrm4_policy.c |  3 ++-
>  net/xfrm/xfrm_policy.c  | 16 ++++++++--------
>  3 files changed, 12 insertions(+), 10 deletions(-)

Series applied to ipsec-next, thanks a lot!

