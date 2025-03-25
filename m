Return-Path: <netdev+bounces-177407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BB6A7014B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4CC4173B11
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607B8261380;
	Tue, 25 Mar 2025 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjjQoEn/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE4258CE3
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906671; cv=none; b=MILDKo+Je9QOcDiPzFxNJLjGh0h97bMmpn/5SPOAp/W3tRd9Kl66eAgZ8beknCy32bm3yelxSUjSKtX52sx8bIzUT3nVxQTGRucA01fhvSFwwf8b2j0qM6uTn7D8YBIl9h08lty2l+9WjrT+0pRJVPBbKYLzi0XCMEkw+DJd1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906671; c=relaxed/simple;
	bh=hrOChwOm7lWdDyxANP1zrLZndcr1V+LbwKiMpBijxh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3wYIvFVaAEkxt9Bv+mEXUjlJC/jyTLigPs2N1tPkBbGrVBbX/kPolZOYwF3rgOLN0JT7FToh4by1Q24LqLGRvAnc6wPIT/2hZ2D3qLV/7m9PbsCovksqE6zDSHKbyeVdpWsFWRdj0iLxEACuPtHqcLiGWBoW0J0jcYQ3us0dhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjjQoEn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84344C4CEE4;
	Tue, 25 Mar 2025 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742906670;
	bh=hrOChwOm7lWdDyxANP1zrLZndcr1V+LbwKiMpBijxh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NjjQoEn/z7g3t2hTzuo2nWWwUmUp76c7BOa2T1OwjOb6KyKBZRowxvRRz9f38nh2h
	 opASFRtUt+Ypiur/Qta50Q6KdjBa+c3stXpc7XghcSd96ZsqV2hFkFjBc8dXQmLGiq
	 0FDcCRUc8Va8wHbaMGSnqb4ceNEUtovHf6Cj9JIySicJWBFtrcVwOajYuWoFqzlKyP
	 yS4vNat5MgnhEULLxex07GR6m4QfL3mil8RIp3eHQ2UN4mHkvjZ394snGvUsAMb3Iq
	 KBxNErO550kpcdq36o7EWZ/LXWB5Qb3LWcu/RHDinQdQH/CpdhGntyl0EEPdjRLBt/
	 1BMq55cH3Lp9g==
Date: Tue, 25 Mar 2025 05:44:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Milena Olech
 <milena.olech@intel.com>, przemyslaw.kitszel@intel.com,
 karol.kolacinski@intel.com, richardcochran@gmail.com, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Willem de Bruijn <willemb@google.com>, Mina
 Almasry <almasrymina@google.com>, Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net-next 01/10] idpf: add initial PTP support
Message-ID: <20250325054421.7e60e5ad@kernel.org>
In-Reply-To: <20250318161327.2532891-2-anthony.l.nguyen@intel.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
	<20250318161327.2532891-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 09:13:16 -0700 Tony Nguyen wrote:
> From: Milena Olech <milena.olech@intel.com>
> 
> PTP feature is supported if the VIRTCHNL2_CAP_PTP is negotiated during the
> capabilities recognition. Initial PTP support includes PTP initialization
> and registration of the clock.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Tested-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Would be great to see a review tag from Jake on these :(

> +#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
> +int idpf_ptp_init(struct idpf_adapter *adapter);
> +void idpf_ptp_release(struct idpf_adapter *adapter);
> +#else /* CONFIG_PTP_1588_CLOCK */
> +static inline int idpf_ptp_init(struct idpf_adapter *adapter)
> +{
> +	return 0;
> +}
> +
> +static inline void idpf_ptp_release(struct idpf_adapter *adapter) { }
> +#endif /* CONFIG_PTP_1588_CLOCK */
> +#endif /* _IDPF_PTP_H */

You add an unusual number of ifdefs for CONFIG_PTP_1588_CLOCK.
Is this really necessary? What breaks if 1588 is not enabled?

