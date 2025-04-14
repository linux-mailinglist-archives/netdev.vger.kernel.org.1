Return-Path: <netdev+bounces-182372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E926FA88931
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CE73A2CF1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B18B27B513;
	Mon, 14 Apr 2025 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="B965oPYh"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD5E27B4F8
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650001; cv=none; b=G4PzD8plgD/OYq7VF6QvyHMSizYh7DQST7qXNdfSH2eCp11qjn2Q/jgApYndUfwfXrD3NO8zQ8RikashvZ0kM87r8usD8Fe0IV3X0MDBfudQvrGFGmieu88sM0Q9BczxBV6XHPzN8+uiVjLudkpWc1Zl7P1zxoOBktg2SWTSHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650001; c=relaxed/simple;
	bh=7+W/bBKIMa1dyTG3JW61Q2y4E76AiZlElKYKlW3Tal8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMH8xGZO0c9VtSxcPdiTMXGe9Nnf66GVGi45Aa7Ru3gfNyy/VkGrkkilU5xD9OZ7ntMQ5C5laPY+kI0oIYEUESHUoZfg8XZb0Jwx52zzzRcCu0SipChIK/Q/iH1mv/xv6UfhEyU+BPz8lpA5WOHzt8C2a7/TOu/w5nP9o2j0SVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=B965oPYh; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=5d5MDT5d07M+ebJOanarer1Ld3dS9fKE8f4h3PXifqg=; b=B965oPYhVuAQ3kwx
	ED7iBhin8rXGdfYwnVdsBEYAuyriHYVWv27s+99wm0AxNEsZWRP/fzpfL90rWGhW5s4QS41oMjwH+
	//GwC/JcErhxgeNtB9hZrXPGUGG7GcTbiFET18qQP983qDlUO8+Jme4EvYX4ihuYOyJH+j1FGE88a
	q5VAKLwXxz2NuJGSSDlVAJnAd5ytflp1peLU3AK2EKcl3i/Rc3rkTvWvChNbw9Zx0r5mbY9Qq9ihI
	tlYuZJADziVXB46kswxWVe5Q/yHpc2HcvCms1wNOmdYTbGMaef4ZpELDcMFFHFTlBcitZlMgtwa5D
	pilvf1YaGUvbUIv9gA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1u4N9v-00BNau-1t;
	Mon, 14 Apr 2025 16:59:47 +0000
Date: Mon, 14 Apr 2025 16:59:47 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Satananda Burla <sburla@marvell.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] octeon_ep_vf: Remove octep_vf_wq
Message-ID: <Z_0_AyjQRT58dYIb@gallifrey>
References: <20250414-octeon-wq-v1-1-23700e4bd208@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250414-octeon-wq-v1-1-23700e4bd208@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:59:23 up 341 days,  4:13,  1 user,  load average: 0.04, 0.03,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Simon Horman (horms@kernel.org) wrote:
> commit cb7dd712189f ("octeon_ep_vf: Add driver framework and device
> initialization") added octep_vf_wq but it has never been used. Remove it.
> 
> Reported-by: Dr. David Alan Gilbert <linux@treblig.org>
> Closes: https://lore.kernel.org/netdev/Z70bEoTKyeBau52q@gallifrey/
> Signed-off-by: Simon Horman <horms@kernel.org>

Thanks,

Reviewed-by: Dr. David Alan Gilbert <linux@treblig.org>

> ---
>  drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 2 --
>  drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> index 18c922dd5fc6..5841e30dff2a 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> @@ -18,8 +18,6 @@
>  #include "octep_vf_config.h"
>  #include "octep_vf_main.h"
>  
> -struct workqueue_struct *octep_vf_wq;
> -
>  /* Supported Devices */
>  static const struct pci_device_id octep_vf_pci_id_tbl[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CN93_VF)},
> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
> index 1a352f41f823..b9f13506f462 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
> @@ -320,8 +320,6 @@ static inline u16 OCTEP_VF_MINOR_REV(struct octep_vf_device *oct)
>  #define octep_vf_read_csr64(octep_vf_dev, reg_off)         \
>  	readq((octep_vf_dev)->mmio.hw_addr + (reg_off))
>  
> -extern struct workqueue_struct *octep_vf_wq;
> -
>  int octep_vf_device_setup(struct octep_vf_device *oct);
>  int octep_vf_setup_iqs(struct octep_vf_device *oct);
>  void octep_vf_free_iqs(struct octep_vf_device *oct);
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

