Return-Path: <netdev+bounces-106189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CA2915263
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A70A1F2418F
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225C119D06B;
	Mon, 24 Jun 2024 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="Fe3QkowS"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8819CCF4
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243046; cv=none; b=M4Q/rutAIPWF3mA3sPKXOUb+p8m6Zk53pC415uUy8sNOpLqvvorikujnhHJP7Xtigdt043Vq8hp7K/+dvQLdnPD0iLkaCl+/n5zR6vqcxLA4P23vs+pAOYFnYPy3Q1VBxJ/1hgg1wG7YN9XUWp4uY8J1CJssgfUWuu4lJeGnNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243046; c=relaxed/simple;
	bh=WwRtKn5/ebjAEk57hOB8MyZ5LDinpq2pODUJGN0hWN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r33n/E4ZbBEFs9GPU2dImMGUZFgH056y+aUjb1pkNTQZ1+xC1jMB87ypVUNhw4gMI3bJ4p/M3ED8LibI3gHhZKic14OiCLY1teQgnJGZgbYNkidnUjvxXUAvAXZ2eqraSVrc3/g8PX5BrUxQ7SE5VUIBUx1XDJYC6l5xHAynzvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=Fe3QkowS; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 8cbb0dbe-323e-11ef-8845-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8cbb0dbe-323e-11ef-8845-005056abad63;
	Mon, 24 Jun 2024 17:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=trQLK57u0qsZGdQ262Em2qCdD08nSUH5foODYiCL05A=;
	b=Fe3QkowS4nnBBhong+JGk5kPHJW4VArxPq2g+BWXzbtJYagV4C7Plv2kgpEnxxiywN8VdkZNZ/TOu
	 Y7Mz/MqTyEsoPlhmFLHrgbEnwmwEQCe9Y/MkZ2TkQV2pJlqrc/Q3EQInjPz/Sb63CKEbHEqkrRzAlX
	 xVi/mplenlqKBDPQ=
X-KPN-MID: 33|NeeYuP7twEuPlMeROkMZwpYg4AX8TBGHvQ63w3MWi0XOfpkvETaaudpsmJ5tA5C
 V0SLxxyum5EWuvVp9T3diNqo5vQHhAW/SnNhb0J242RQ=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|cfvohYJfmxJgWXB1LViisEUK64q+cuKxdJ94iKHgsdBVbihCCvBH4kFEV8Gy3IY
 YGAkul7rEH4rt/gNU7/17Rg==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 8d1a71f8-323e-11ef-87b8-005056ab7447;
	Mon, 24 Jun 2024 17:29:32 +0200 (CEST)
Date: Mon, 24 Jun 2024 17:29:30 +0200
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v4 05/18] xfrm: netlink: add config (netlink)
 options
Message-ID: <ZnmQ2k9qUyOyBWap@Antony2201.local>
References: <20240617205316.939774-1-chopps@chopps.org>
 <20240617205316.939774-6-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617205316.939774-6-chopps@chopps.org>

On Mon, Jun 17, 2024 at 04:53:03PM -0400, Christian Hopps via Devel wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add netlink options for configuring IP-TFS SAs.
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  include/uapi/linux/xfrm.h |  9 ++++++-
>  net/xfrm/xfrm_compat.c    | 10 ++++++--
>  net/xfrm/xfrm_user.c      | 52 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> index 18ceaba8486e..3bd1f810e079 100644
> --- a/include/uapi/linux/xfrm.h
> +++ b/include/uapi/linux/xfrm.h
> @@ -158,7 +158,8 @@ enum {
>  #define XFRM_MODE_ROUTEOPTIMIZATION 2
>  #define XFRM_MODE_IN_TRIGGER 3
>  #define XFRM_MODE_BEET 4
> -#define XFRM_MODE_MAX 5
> +#define XFRM_MODE_IPTFS 5
> +#define XFRM_MODE_MAX 6
>  
>  /* Netlink configuration messages.  */
>  enum {
> @@ -321,6 +322,12 @@ enum xfrm_attr_type_t {
>  	XFRMA_IF_ID,		/* __u32 */
>  	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
>  	XFRMA_SA_DIR,		/* __u8 */
> +	XFRMA_IPTFS_DROP_TIME,	/* __u32 in: usec to wait for next seq */
> +	XFRMA_IPTFS_REORDER_WINDOW, /* __u16 in: reorder window size */
> +	XFRMA_IPTFS_DONT_FRAG,	/* out: don't use fragmentation */
> +	XFRMA_IPTFS_INIT_DELAY,	/* __u32 out: initial packet wait delay (usec) */
> +	XFRMA_IPTFS_MAX_QSIZE,	/* __u32 out: max ingress queue size */

+	XFRMA_IPTFS_MAX_QSIZE,	/* __u32 out: max ingress queue size octets */

Add the units in comments? This would help the users.  The "struct 
xfrm_iptfs_config {" mentions it is octets. Adding it to uapi would help the 
users more. The defaults are not so obvious to find. 


