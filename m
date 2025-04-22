Return-Path: <netdev+bounces-184906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A41A97AC1
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 00:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372AF5A13A5
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 22:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650E825CC5E;
	Tue, 22 Apr 2025 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iW3g5YMi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C56E242D6B
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362564; cv=none; b=loQrPA973RxC3ALHlUKo3CvxcO7sQnwkB8uZM/7mnYzTGPFvjuFy5CfyfxboDKeow3p+cpX5CNnOftfD4mBFi1XGfFNO6NDafOHQq4ouXUBcfuhJo8Gbzn5r9Yk6LUapVALI/3Axxr5C0ni8ow3xP3PO7flZ8A+ALycZG71FPWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362564; c=relaxed/simple;
	bh=MEhdpwTjo3YYGd/IXJ3n1Ytzk8c6AhzAnobQyGJM9m0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QbvWp1pP6U2DUjDNYU2R8igFugWo/goMRBMj5/HYfSCnTlMKJ3BRan2LQ/GWtZa4JcIBGPceW67u7KSDNbPgdKR+5lGFPSRBAeamXWMYjfxJ/3ML0jdfxleuRUccFJPJLhhpx5R+JIOX1Tm/TobsJtpKDsSo3wKo2F8iAghuop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iW3g5YMi; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8f8657f29so53352916d6.3
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 15:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745362561; x=1745967361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBzeT7kQC1yVqsLS4jhP2z5bW5aVJIuFV4Fc44a1TFs=;
        b=iW3g5YMihix6iQoFq96FAikUHzGvyerbEIt0HIiYROsREuh3gzMMb4TzvjgXphkhG/
         yZWqIdu0lRSWomXKOM2DlMlf+WUXdITI5vydeCqRF5mP9lBcIi+eJT+41f3djOBxz9uL
         iLYtYoVDaUfz1Cqs0I1lPLudP6bcSS3bg3/b69RHsp1L2ABKwdOUdyj81DpDndjn9JJ8
         eHex/gGfD1jucXUuxUJOzlnItgPMW34w96VcgIKDJM/Z5ods+dLQf3PF6pNBRD/3qPLk
         skP/a0AZ0YAUvDo/Hhv8H+S6jat7aLFCx6SlNQeFHveZWW8VRghw9Vy3Q/ccnNTmyQz2
         YlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745362561; x=1745967361;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PBzeT7kQC1yVqsLS4jhP2z5bW5aVJIuFV4Fc44a1TFs=;
        b=LV5pCgzjHh6D2TSHfZTCJh5OyjQUFO0yUfjkOu/O4Jh3YjhRcmZJXZ2Egf71/dU0k/
         uivi7qMiIefleMYuYbLO1BDi3w71E8DFoh2v0t7Dz8rwc7vN1OIkD/2JJSrWVZMgwDyh
         NbdD0oNJECdFNvmLGqmlsxMH5VWFUQJDfcMa7HUCX+FIZ4wTXu7vvXLzBrNT/0Hokbye
         hMWSTF7EAA9JJ75+Fyh/Pfv5uLQHlHSGsbLr64eq00s8cGlOGi7rUSTFXEcZSe79K3Zi
         a0lNnLmW0fM0Ihl69uznvzbrJX0HhFVqiEj/E92RU2Jx7C5PE44xsAx2+AMN7/yd+eJn
         xXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3Z5b3Ft95kmt9KiJbDNrqbmUFX1UUpwP92OcozLPEPeIF2KzsRXEpxeoKBlzDA2jNzVpBimA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN7FY5anZC2ENAnUJlMQnwFYWDJaJ9tMrKJXo3vwL+1lIDFpyZ
	v2xf9fSpqvENjl2hkal69HUuYMhmzxWmGnWslIPgnjeowqSk/OVu
X-Gm-Gg: ASbGncsxUB/SEckzaAsbvuI6O5gk3uQuwk3fLoCj00KRlVfjdqFdgoZ1aVkM7KLgovQ
	rCi+yujgfZZjCU//uxcMqPmYB0LPjxKsFcZ5Xmoe57UErcMUL28Zswe3FcurJ58fZBZiYRShSu6
	MWrRWK2D7FhzsluQyqHCXFN9dtKH3yVUfSEpDrw3nCBKIEVXj+ADHGJQImg7rxw+jlhYuy0JmBt
	7Gr79VFsp+9hJalrMIQ+3xGZ84G5ot5pRHnpL06ci3gDMCwT7D9LUs7q8BllQtAtuzDwp62XpEc
	iXAGkTr31KMo3+B3IIL9BJv6EsZvD85WiGzn17fiZGGprw62exkR0qekMOV7782yXcqbuYy8+mx
	vF/vykUjo/lLVm/5iUGslUse+T5NyEBU=
X-Google-Smtp-Source: AGHT+IFn/AZJmWR2PvBY8yFvPeLH8+9dnMjfHW5DT8jVTPtS4Y+7UXnCSkSOWgzTgBlFsD7HPgvL/g==
X-Received: by 2002:a05:6214:2505:b0:6e8:fb94:b9bf with SMTP id 6a1803df08f44-6f2c44edd2dmr264697016d6.4.1745362561432;
        Tue, 22 Apr 2025 15:56:01 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f2c2c21c56sm62870096d6.101.2025.04.22.15.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:56:00 -0700 (PDT)
Date: Tue, 22 Apr 2025 18:56:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 andrew+netdev@lunn.ch, 
 netdev@vger.kernel.org
Cc: Madhu Chittim <madhu.chittim@intel.com>, 
 anthony.l.nguyen@intel.com, 
 willemb@google.com, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Zachary Goldstein <zachmgoldstein@google.com>, 
 Samuel Salin <Samuel.salin@intel.com>
Message-ID: <68081e80888e6_3d8ff0294f9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250422214822.882674-4-anthony.l.nguyen@intel.com>
References: <20250422214822.882674-1-anthony.l.nguyen@intel.com>
 <20250422214822.882674-4-anthony.l.nguyen@intel.com>
Subject: Re: [PATCH net 3/3] idpf: fix offloads support for encapsulated
 packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tony Nguyen wrote:
> From: Madhu Chittim <madhu.chittim@intel.com>
> 
> Split offloads into csum, tso and other offloads so that tunneled
> packets do not by default have all the offloads enabled.
> 
> Stateless offloads for encapsulated packets are not yet supported in
> firmware/software but in the driver we were setting the features same as
> non encapsulated features.
> 
> Fixed naming to clarify CSUM bits are being checked for Tx.
> 
> Inherit netdev features to VLAN interfaces as well.
> 
> Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
> Tested-by: Zachary Goldstein <zachmgoldstein@google.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h     | 14 ++++--
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 57 ++++++++--------------
>  2 files changed, 29 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index 66544faab710..5f73a4cf5161 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -633,10 +633,18 @@ bool idpf_is_capability_ena(struct idpf_adapter *adapter, bool all,
>  	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_TCP	|\
>  	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_UDP)
>  
> +#define IDPF_CAP_TX_CSUM_L4V4 (\
> +	VIRTCHNL2_CAP_TX_CSUM_L4_IPV4_TCP	|\
> +	VIRTCHNL2_CAP_TX_CSUM_L4_IPV4_UDP)
> +
>  #define IDPF_CAP_RX_CSUM_L4V6 (\
>  	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_TCP	|\
>  	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_UDP)
>  
> +#define IDPF_CAP_TX_CSUM_L4V6 (\
> +	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_TCP	|\
> +	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_UDP)
> +
>  #define IDPF_CAP_RX_CSUM (\
>  	VIRTCHNL2_CAP_RX_CSUM_L3_IPV4		|\
>  	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_TCP	|\
> @@ -644,11 +652,9 @@ bool idpf_is_capability_ena(struct idpf_adapter *adapter, bool all,
>  	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_TCP	|\
>  	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_UDP)
>  
> -#define IDPF_CAP_SCTP_CSUM (\
> +#define IDPF_CAP_TX_SCTP_CSUM (\
>  	VIRTCHNL2_CAP_TX_CSUM_L4_IPV4_SCTP	|\
> -	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_SCTP	|\
> -	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_SCTP	|\
> -	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_SCTP)
> +	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_SCTP)
>  
>  #define IDPF_CAP_TUNNEL_TX_CSUM (\
>  	VIRTCHNL2_CAP_TX_CSUM_L3_SINGLE_TUNNEL	|\
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index aa755dedb41d..730a9c7a59f2 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -703,8 +703,10 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
>  {
>  	struct idpf_adapter *adapter = vport->adapter;
>  	struct idpf_vport_config *vport_config;
> +	netdev_features_t other_offloads = 0;
> +	netdev_features_t csum_offloads = 0;
> +	netdev_features_t tso_offloads = 0;
>  	netdev_features_t dflt_features;
> -	netdev_features_t offloads = 0;
>  	struct idpf_netdev_priv *np;
>  	struct net_device *netdev;
>  	u16 idx = vport->idx;
> @@ -766,53 +768,32 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
>  
>  	if (idpf_is_cap_ena_all(adapter, IDPF_RSS_CAPS, IDPF_CAP_RSS))
>  		dflt_features |= NETIF_F_RXHASH;
> -	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_RX_CSUM_L4V4))
> -		dflt_features |= NETIF_F_IP_CSUM;
> -	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_RX_CSUM_L4V6))
> -		dflt_features |= NETIF_F_IPV6_CSUM;

IDPF_CAP_RX_CSUM_L4V4 and IDPF_CAP_RX_CSUM_L4V6 are no longer used
after this commit, so the definitions (above) should be removed?

> +	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_TX_CSUM_L4V4))
> +		csum_offloads |= NETIF_F_IP_CSUM;
> +	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_TX_CSUM_L4V6))
> +		csum_offloads |= NETIF_F_IPV6_CSUM;
>  	if (idpf_is_cap_ena(adapter, IDPF_CSUM_CAPS, IDPF_CAP_RX_CSUM))
> -		dflt_features |= NETIF_F_RXCSUM;
> -	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_SCTP_CSUM))
> -		dflt_features |= NETIF_F_SCTP_CRC;
> +		csum_offloads |= NETIF_F_RXCSUM;
> +	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_TX_SCTP_CSUM))
> +		csum_offloads |= NETIF_F_SCTP_CRC;
>  
>  	if (idpf_is_cap_ena(adapter, IDPF_SEG_CAPS, VIRTCHNL2_CAP_SEG_IPV4_TCP))
> -		dflt_features |= NETIF_F_TSO;
> +		tso_offloads |= NETIF_F_TSO;
>  	if (idpf_is_cap_ena(adapter, IDPF_SEG_CAPS, VIRTCHNL2_CAP_SEG_IPV6_TCP))
> -		dflt_features |= NETIF_F_TSO6;
> +		tso_offloads |= NETIF_F_TSO6;
>  	if (idpf_is_cap_ena_all(adapter, IDPF_SEG_CAPS,
>  				VIRTCHNL2_CAP_SEG_IPV4_UDP |
>  				VIRTCHNL2_CAP_SEG_IPV6_UDP))
> -		dflt_features |= NETIF_F_GSO_UDP_L4;
> +		tso_offloads |= NETIF_F_GSO_UDP_L4;
>  	if (idpf_is_cap_ena_all(adapter, IDPF_RSC_CAPS, IDPF_CAP_RSC))
> -		offloads |= NETIF_F_GRO_HW;
> -	/* advertise to stack only if offloads for encapsulated packets is
> -	 * supported
> -	 */
> -	if (idpf_is_cap_ena(vport->adapter, IDPF_SEG_CAPS,
> -			    VIRTCHNL2_CAP_SEG_TX_SINGLE_TUNNEL)) {
> -		offloads |= NETIF_F_GSO_UDP_TUNNEL	|
> -			    NETIF_F_GSO_GRE		|
> -			    NETIF_F_GSO_GRE_CSUM	|
> -			    NETIF_F_GSO_PARTIAL		|
> -			    NETIF_F_GSO_UDP_TUNNEL_CSUM	|
> -			    NETIF_F_GSO_IPXIP4		|
> -			    NETIF_F_GSO_IPXIP6		|
> -			    0;
> -
> -		if (!idpf_is_cap_ena_all(vport->adapter, IDPF_CSUM_CAPS,
> -					 IDPF_CAP_TUNNEL_TX_CSUM))
> -			netdev->gso_partial_features |=
> -				NETIF_F_GSO_UDP_TUNNEL_CSUM;
> -
> -		netdev->gso_partial_features |= NETIF_F_GSO_GRE_CSUM;
> -		offloads |= NETIF_F_TSO_MANGLEID;
> -	}
> +		other_offloads |= NETIF_F_GRO_HW;
>  	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_LOOPBACK))
> -		offloads |= NETIF_F_LOOPBACK;
> +		other_offloads |= NETIF_F_LOOPBACK;
>  
> -	netdev->features |= dflt_features;
> -	netdev->hw_features |= dflt_features | offloads;
> -	netdev->hw_enc_features |= dflt_features | offloads;
> +	netdev->features |= dflt_features | csum_offloads | tso_offloads;
> +	netdev->hw_features |=  netdev->features | other_offloads;
> +	netdev->vlan_features |= netdev->features | other_offloads;
> +	netdev->hw_enc_features |= dflt_features | other_offloads;
>  	idpf_set_ethtool_ops(netdev);
>  	netif_set_affinity_auto(netdev);
>  	SET_NETDEV_DEV(netdev, &adapter->pdev->dev);
> -- 
> 2.47.1
> 



