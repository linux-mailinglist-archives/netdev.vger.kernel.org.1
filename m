Return-Path: <netdev+bounces-184091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B9EA93508
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A664649FE
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A834726E162;
	Fri, 18 Apr 2025 09:02:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708BD10942
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966933; cv=none; b=BjbMGVCiFFtJ1aeUXtgMhol0qEWxxUHEJNWCS6vwdm4BWx37DXQv5DQfmMH3MJzAUlkqspQ0GJfmkW6FnNCg4TqSfDPhi8Lt3wad9eHWQQ1Bfxk4vVJajhll6vhPXIdJfNxPkF6IC0h6ttB0bH2MpZz9N9eRHtXt0QggqC8wh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966933; c=relaxed/simple;
	bh=CKAPhUJD+t5qCNkGHVIoIR/1PEuTGy72i7rNJ555e/k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXZ5efWPbDBUz9VYiLBf89LFhIxKRMuPHaaj1epbp1eDOoIYwOHE7ElZvf5rOIL2a2U85O7xeIieHPOwpFiv/LTJ5iIGlbqLswxv3ZGiogqaMv3n40qDLql+IGXsMrMFPAMTWXoUbKXWHJZFC5pT6YEU2/w2bTMxnL6sPH2J/dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A419420868;
	Fri, 18 Apr 2025 11:02:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MF8iOeVptaJa; Fri, 18 Apr 2025 11:02:02 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 29AA220704;
	Fri, 18 Apr 2025 11:02:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 29AA220704
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 18 Apr
 2025 11:02:01 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 11:02:01 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 5AF5E3182C91; Fri, 18 Apr 2025 11:02:01 +0200 (CEST)
Date: Fri, 18 Apr 2025 11:02:01 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Chiachang Wang <chiachangwang@google.com>
CC: <netdev@vger.kernel.org>, <leonro@nvidia.com>, <stanleyjhu@google.com>,
	<yumike@google.com>
Subject: Re: [PATCH ipsec-next v5 0/2] Update offload configuration with SA
Message-ID: <aAIVCZ2Ozd23xkwu@gauss3.secunet.de>
References: <20250313023641.1007052-1-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250313023641.1007052-1-chiachangwang@google.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Thu, Mar 13, 2025 at 02:36:39AM +0000, Chiachang Wang wrote:
> The current Security Association (SA) offload setting
> cannot be modified without removing and re-adding the
> SA with the new configuration. Although existing netlink
> messages allow SA migration, the offload setting will
> be removed after migration.
> 
> This patchset enhances SA migration to include updating
> the offload setting. This is beneficial for devices that
> support IPsec session management.
> 
> Chiachang Wang (2):
>   xfrm: Migrate offload configuration
>   xfrm: Refactor migration setup during the cloning process
> 
>  include/net/xfrm.h     |  8 ++++++--
>  net/key/af_key.c       |  2 +-
>  net/xfrm/xfrm_policy.c |  4 ++--
>  net/xfrm/xfrm_state.c  | 24 ++++++++++++++++--------
>  net/xfrm/xfrm_user.c   | 15 ++++++++++++---
>  5 files changed, 37 insertions(+), 16 deletions(-)

Applied, thanks a lot Chiachang!

