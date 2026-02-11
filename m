Return-Path: <netdev+bounces-258202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI2JEKEcjGkYhAAAu9opvQ
	(envelope-from <netdev+bounces-258202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 07:07:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A371218E6
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 07:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1E41303EF9A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 06:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D10334C9AD;
	Wed, 11 Feb 2026 06:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHCfkFBg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705B6330B00;
	Wed, 11 Feb 2026 06:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770790045; cv=none; b=A4o0WQckFwBNfedqvP44cGZQ06M8pCel2y40/4gmQipDWm5gWdSeZFXt7lv9rtDeQq/idksNZRWYAddBmuXJv9qkbFsp0BWUVPcoesgYS0f9vSTnAc1yWKoAUnBlw8pVVV2h6g+TWdnFStAoqljQS834aH90HBFk8Occ0wMRz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770790045; c=relaxed/simple;
	bh=xM91Tfu8SEyUDujMWffkdlLQ6abgiRKLRx//M74JqmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzLJlPl4dPq1ds5wsAzT4CHgo6mb6tuiauDi28CA4dHXIE3TJ6doLIX+5VZSEZrVFfdow6GkUOpq51b8zqzD3OV4IDMk3uLNuMaYkTFezhSvdyQRC6SLMxR4CrNEGO1ra2WXBRLr7Qjg4wGtBWIKW4xIJruuYgFgP92WCiHngis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHCfkFBg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770790043; x=1802326043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xM91Tfu8SEyUDujMWffkdlLQ6abgiRKLRx//M74JqmM=;
  b=EHCfkFBgjhh0oWXSG0zvbTJIG3FxhxN2T1PA1rjTb1FY6LQcCzYHIS0x
   77POvjnSOZ3HhhZq31X6T/tx72O3dBX/fKeeVkxGHgHH+eWLp9EoQQpxx
   1M7rlcM1QMqZNWgUhjVJptEUM+UuD2zbX9cadY4tD1+xS1KCmW3FyAiz1
   efyXx9KhRf5VzngM05sD6+HBL0QMbz1KkksoQxSwY3xvwePsmtxCiTS+v
   B1W0DEJ1IC9ZiOSOR0QsAEP3G+DbJNYZRG6wtRdHNH942SBVrl7YLPQ1Y
   Hpvu4nSujeqEKtzifPUFzvrPUF0DIoiIJpGE0IhtR1yp7LxgfyL5L9X0J
   w==;
X-CSE-ConnectionGUID: lcwJZVmPTLmcNsNOH1MfDQ==
X-CSE-MsgGUID: 3QQmpGMJRHCMh4mSq1Hklw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71916406"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71916406"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 22:07:23 -0800
X-CSE-ConnectionGUID: iCFmfES2RPi7IUyc5cpXeA==
X-CSE-MsgGUID: Q/uPc977Sg2laEKdR2gC0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="216678499"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Feb 2026 22:07:16 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vq3NZ-00000000pjI-1CEq;
	Wed, 11 Feb 2026 06:07:13 +0000
Date: Wed, 11 Feb 2026 14:07:10 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH bpf-next 3/5] net: ice: Add
 xmo_rx_checksum callback
Message-ID: <202602111429.7z0nNd0Q-lkp@intel.com>
References: <20260210-bpf-xdp-meta-rxcksum-v1-3-e5d55caa0541@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210-bpf-xdp-meta-rxcksum-v1-3-e5d55caa0541@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258202-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:mid,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01A371218E6
X-Rspamd-Action: no action

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on db975debcb8c4cd367a78811bc1ba84c83f854bd]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/netlink-specs-Add-XDP-RX-checksum-capability-to-XDP-metadata-specs/20260211-012550
base:   db975debcb8c4cd367a78811bc1ba84c83f854bd
patch link:    https://lore.kernel.org/r/20260210-bpf-xdp-meta-rxcksum-v1-3-e5d55caa0541%40kernel.org
patch subject: [Intel-wired-lan] [PATCH bpf-next 3/5] net: ice: Add xmo_rx_checksum callback
config: i386-randconfig-063-20260211 (https://download.01.org/0day-ci/archive/20260211/202602111429.7z0nNd0Q-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260211/202602111429.7z0nNd0Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602111429.7z0nNd0Q-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/ice/ice_txrx_lib.c:109:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __wsum @@
   drivers/net/ethernet/intel/ice/ice_txrx_lib.c:109:29: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/intel/ice/ice_txrx_lib.c:109:29: sparse:     got restricted __wsum
>> drivers/net/ethernet/intel/ice/ice_txrx_lib.c:181:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int [addressable] [usertype] cksum_meta @@
   drivers/net/ethernet/intel/ice/ice_txrx_lib.c:181:27: sparse:     expected restricted __wsum [usertype] csum
   drivers/net/ethernet/intel/ice/ice_txrx_lib.c:181:27: sparse:     got unsigned int [addressable] [usertype] cksum_meta
   drivers/net/ethernet/intel/ice/ice_txrx_lib.c:515:9: sparse: sparse: context imbalance in 'ice_finalize_xdp_rx' - different lock contexts for basic block

vim +109 drivers/net/ethernet/intel/ice/ice_txrx_lib.c

    83	
    84	static void
    85	ice_get_rx_csum(const union ice_32b_rx_flex_desc *rx_desc, u16 ptype,
    86			struct ice_rx_ring *ring, enum xdp_checksum *ip_summed,
    87			u32 *cksum_meta)
    88	{
    89		struct libeth_rx_pt decoded = libie_rx_pt_parse(ptype);
    90		u16 rx_status0, rx_status1;
    91		bool ipv4, ipv6;
    92	
    93		if (!libeth_rx_pt_has_checksum(ring->netdev, decoded))
    94			goto checksum_none;
    95	
    96		rx_status0 = le16_to_cpu(rx_desc->wb.status_error0);
    97		rx_status1 = le16_to_cpu(rx_desc->wb.status_error1);
    98		if ((ring->flags & ICE_RX_FLAGS_RING_GCS) &&
    99		    rx_desc->wb.rxdid == ICE_RXDID_FLEX_NIC &&
   100		    (decoded.inner_prot == LIBETH_RX_PT_INNER_TCP ||
   101		     decoded.inner_prot == LIBETH_RX_PT_INNER_UDP ||
   102		     decoded.inner_prot == LIBETH_RX_PT_INNER_ICMP)) {
   103			const struct ice_32b_rx_flex_desc_nic *desc;
   104			u16 csum;
   105	
   106			desc = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
   107			*ip_summed = XDP_CHECKSUM_COMPLETE;
   108			csum = (__force u16)desc->raw_csum;
 > 109			*cksum_meta = csum_unfold((__force __sum16)swab16(csum));
   110			return;
   111		}
   112	
   113		/* check if HW has decoded the packet and checksum */
   114		if (!(rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_L3L4P_S)))
   115			goto checksum_none;
   116	
   117		ipv4 = libeth_rx_pt_get_ip_ver(decoded) == LIBETH_RX_PT_OUTER_IPV4;
   118		ipv6 = libeth_rx_pt_get_ip_ver(decoded) == LIBETH_RX_PT_OUTER_IPV6;
   119	
   120		if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EIPE_S)))) {
   121			ring->vsi->back->hw_rx_eipe_error++;
   122			goto checksum_none;
   123		}
   124	
   125		if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_IPE_S))))
   126			goto checksum_fail;
   127	
   128		if (ipv6 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_IPV6EXADD_S))))
   129			goto checksum_fail;
   130	
   131		/* check for L4 errors and handle packets that were not able to be
   132		 * checksummed due to arrival speed
   133		 */
   134		if (rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_L4E_S))
   135			goto checksum_fail;
   136	
   137		/* check for outer UDP checksum error in tunneled packets */
   138		if ((rx_status1 & BIT(ICE_RX_FLEX_DESC_STATUS1_NAT_S)) &&
   139		    (rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EUDPE_S)))
   140			goto checksum_fail;
   141	
   142		/* If there is an outer header present that might contain a checksum
   143		 * we need to bump the checksum level by 1 to reflect the fact that
   144		 * we are indicating we validated the inner checksum.
   145		 */
   146		if (decoded.tunnel_type >= LIBETH_RX_PT_TUNNEL_IP_GRENAT)
   147			*cksum_meta = 1;
   148	
   149		*ip_summed = XDP_CHECKSUM_UNNECESSARY;
   150		return;
   151	
   152	checksum_fail:
   153		ring->vsi->back->hw_csum_rx_error++;
   154	checksum_none:
   155		*ip_summed = XDP_CHECKSUM_NONE;
   156		*cksum_meta = 0;
   157	}
   158	
   159	/**
   160	 * ice_rx_csum - Indicate in skb if checksum is good
   161	 * @ring: the ring we care about
   162	 * @skb: skb currently being received and modified
   163	 * @rx_desc: the receive descriptor
   164	 * @ptype: the packet type decoded by hardware
   165	 *
   166	 * skb->protocol must be set before this function is called
   167	 */
   168	static void
   169	ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
   170		    union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
   171	{
   172		enum xdp_checksum ip_summed;
   173		u32 cksum_meta;
   174	
   175		ice_get_rx_csum(rx_desc, ptype, ring, &ip_summed, &cksum_meta);
   176		switch (ip_summed) {
   177		case XDP_CHECKSUM_UNNECESSARY:
   178			skb->csum_level = cksum_meta;
   179			break;
   180		case XDP_CHECKSUM_COMPLETE:
 > 181			skb->csum = cksum_meta;
   182			break;
   183		default:
   184			break;
   185		}
   186		skb->ip_summed = ip_summed;
   187	}
   188	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

