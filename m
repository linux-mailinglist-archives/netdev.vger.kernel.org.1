Return-Path: <netdev+bounces-301949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xYWCCLUVPWo3wwgAu9opvQ
	(envelope-from <netdev+bounces-301949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:49:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DFA6C543A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:49:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=BfmCV2e5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301949-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301949-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD69D3032CD2
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0727738422D;
	Thu, 25 Jun 2026 11:49:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4583184;
	Thu, 25 Jun 2026 11:49:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388146; cv=none; b=sdmEZ1k4gZ4VARAHXPCvO434iT55JtwAv9cxs5M8+xXXkb+oH9GgAthPEJT7N5M1pr0tCAQJR/pGCYKF8WCZHM9Gu/XHBUnR9uC6AQEdJKXmZVGatbU/V7ikThVUO2S3Mt1Od6fTZsrp+YrMGNqqC5pY6NVgi/TLhqQBe7sBuEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388146; c=relaxed/simple;
	bh=ceA76y+bq7lHcmY4HlqouL+xi+eZDkTmNm1ZztpOceA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV19LfvQqOGLxVyiNdKUNEGDKARlBbWC0doa4/rTsI+4VVv40xSzBI/tX7bVqf9/ydX01aSWzV31iPHGgJPyLD/j31xXUp1HVdKE+fdq5fhZ4G8Ql+as0XS08uRgodYu45ElFEGKWQg6R31SxDQU27TFUKW0xZAM5ibXxVTgcMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfmCV2e5; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782388144; x=1813924144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ceA76y+bq7lHcmY4HlqouL+xi+eZDkTmNm1ZztpOceA=;
  b=BfmCV2e5ZCpIEbvApo5+5eZX8JN0XWxMu70s/ReD89a1PpLldToxBq0/
   UarXN9VNo+ML6+fHvL+wnAH+B+jhJA2fkPwTDl7odMEqDcSHuS/tzInE8
   toni8cJVONHupO5i1ViPB/WhONh8hEy0x0DsHcl/BmKsBmRRlrq231VDP
   6zH581u5JrXNsUMNLXHWkhZb/4qY5rMeRKIP0EdypDNWdUBogguhbtHrQ
   q785zIGZkPm1QIWUx4a65mZBixvmcbDt6Idn1pV1hNcwCZCqAmiQGmNZo
   xpmDk05HxekDB6dZadlndjNtqU6H0lI84/wODArAdsOW4TjRDqkVmtPg/
   Q==;
X-CSE-ConnectionGUID: ZqTaOA5yRV+/8TRky5YfXg==
X-CSE-MsgGUID: BkjSvFjPSUmRYH0snR37RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="100714169"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="100714169"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 04:49:03 -0700
X-CSE-ConnectionGUID: ODcsmju0Sy6Zzs/c3o8zPw==
X-CSE-MsgGUID: I9SWvSiRS+WZlsePSTCInw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="246243007"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 25 Jun 2026 04:49:00 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wciZk-0000000047V-3bcJ;
	Thu, 25 Jun 2026 11:48:56 +0000
Date: Thu, 25 Jun 2026 19:47:28 +0800
From: kernel test robot <lkp@intel.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>, davem@davemloft.net,
	gakula@marvell.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sgoutham@marvell.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Hariprasad Kelam <hkelam@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [PATCH net v2] octeontx2-af: Block VFs from clobbering special
 CGX PKIND state
Message-ID: <202606251954.vsXupLpQ-lkp@intel.com>
References: <20260625044621.2841831-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625044621.2841831-1-rkannoth@marvell.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301949-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:davem@davemloft.net,m:gakula@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:sgoutham@marvell.com,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hkelam@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77DFA6C543A

Hi Ratheesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on linus/master v7.1 next-20260623]
[cannot apply to linux-review/Ratheesh-Kannoth/octeontx2-af-Block-VFs-from-clobbering-special-CGX-PKIND-state/20260622-133621 horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ratheesh-Kannoth/octeontx2-af-Block-VFs-from-clobbering-special-CGX-PKIND-state/20260625-124846
base:   net/main
patch link:    https://lore.kernel.org/r/20260625044621.2841831-1-rkannoth%40marvell.com
patch subject: [PATCH net v2] octeontx2-af: Block VFs from clobbering special CGX PKIND state
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260625/202606251954.vsXupLpQ-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 6cc609bb250b21b47fc7d394b4019101e9983597)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260625/202606251954.vsXupLpQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606251954.vsXupLpQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:1522:6: warning: variable 'pf' set but not used [-Wunused-but-set-variable]
    1522 |         int pf;
         |             ^
>> drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:1696:24: warning: variable 'cgx' is uninitialized when used here [-Wuninitialized]
    1696 |                 cgxd = rvu_cgx_pdata(cgx, rvu);
         |                                      ^~~
   drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:1521:8: note: initialize the variable 'cgx' to silence this warning
    1521 |         u8 cgx;
         |               ^
         |                = '\0'
   2 warnings generated.


vim +/pf +1522 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

  1506	
  1507	int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
  1508					  struct nix_lf_alloc_req *req,
  1509					  struct nix_lf_alloc_rsp *rsp)
  1510	{
  1511		int nixlf, qints, hwctx_size, intf, rc = 0;
  1512		u16 bcast, mcast, promisc, ucast;
  1513		struct rvu_hwinfo *hw = rvu->hw;
  1514		u16 pcifunc = req->hdr.pcifunc;
  1515		bool rules_created = false;
  1516		struct rvu_block *block;
  1517		struct rvu_pfvf *pfvf;
  1518		u64 cfg, ctx_cfg;
  1519		struct cgx *cgxd;
  1520		int blkaddr;
  1521		u8 cgx;
> 1522		int pf;
  1523	
  1524		if (!req->rq_cnt || !req->sq_cnt || !req->cq_cnt)
  1525			return NIX_AF_ERR_PARAM;
  1526	
  1527		if (req->way_mask)
  1528			req->way_mask &= 0xFFFF;
  1529	
  1530		pfvf = rvu_get_pfvf(rvu, pcifunc);
  1531		blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
  1532		if (!pfvf->nixlf || blkaddr < 0)
  1533			return NIX_AF_ERR_AF_LF_INVALID;
  1534	
  1535		block = &hw->block[blkaddr];
  1536		nixlf = rvu_get_lf(rvu, block, pcifunc, 0);
  1537		if (nixlf < 0)
  1538			return NIX_AF_ERR_AF_LF_INVALID;
  1539	
  1540		/* Check if requested 'NIXLF <=> NPALF' mapping is valid */
  1541		if (req->npa_func) {
  1542			/* If default, use 'this' NIXLF's PFFUNC */
  1543			if (req->npa_func == RVU_DEFAULT_PF_FUNC)
  1544				req->npa_func = pcifunc;
  1545			if (!is_pffunc_map_valid(rvu, req->npa_func, BLKTYPE_NPA))
  1546				return NIX_AF_INVAL_NPA_PF_FUNC;
  1547		}
  1548	
  1549		/* Check if requested 'NIXLF <=> SSOLF' mapping is valid */
  1550		if (req->sso_func) {
  1551			/* If default, use 'this' NIXLF's PFFUNC */
  1552			if (req->sso_func == RVU_DEFAULT_PF_FUNC)
  1553				req->sso_func = pcifunc;
  1554			if (!is_pffunc_map_valid(rvu, req->sso_func, BLKTYPE_SSO))
  1555				return NIX_AF_INVAL_SSO_PF_FUNC;
  1556		}
  1557	
  1558		/* If RSS is being enabled, check if requested config is valid.
  1559		 * RSS table size should be power of two, otherwise
  1560		 * RSS_GRP::OFFSET + adder might go beyond that group or
  1561		 * won't be able to use entire table.
  1562		 */
  1563		if (req->rss_sz && (req->rss_sz > MAX_RSS_INDIR_TBL_SIZE ||
  1564				    !is_power_of_2(req->rss_sz)))
  1565			return NIX_AF_ERR_RSS_SIZE_INVALID;
  1566	
  1567		if (req->rss_sz &&
  1568		    (!req->rss_grps || req->rss_grps > MAX_RSS_GROUPS))
  1569			return NIX_AF_ERR_RSS_GRPS_INVALID;
  1570	
  1571		/* Reset this NIX LF */
  1572		rc = rvu_lf_reset(rvu, block, nixlf);
  1573		if (rc) {
  1574			dev_err(rvu->dev, "Failed to reset NIX%d LF%d\n",
  1575				block->addr - BLKADDR_NIX0, nixlf);
  1576			return NIX_AF_ERR_LF_RESET;
  1577		}
  1578	
  1579		ctx_cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST3);
  1580	
  1581		/* Alloc NIX RQ HW context memory and config the base */
  1582		hwctx_size = 1UL << ((ctx_cfg >> 4) & 0xF);
  1583		rc = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
  1584		if (rc)
  1585			goto free_mem;
  1586	
  1587		pfvf->rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
  1588		if (!pfvf->rq_bmap) {
  1589			rc = -ENOMEM;
  1590			goto free_mem;
  1591		}
  1592	
  1593		rvu_write64(rvu, blkaddr, NIX_AF_LFX_RQS_BASE(nixlf),
  1594			    (u64)pfvf->rq_ctx->iova);
  1595	
  1596		/* Set caching and queue count in HW */
  1597		cfg = BIT_ULL(36) | (req->rq_cnt - 1) | req->way_mask << 20;
  1598		rvu_write64(rvu, blkaddr, NIX_AF_LFX_RQS_CFG(nixlf), cfg);
  1599	
  1600		/* Alloc NIX SQ HW context memory and config the base */
  1601		hwctx_size = 1UL << (ctx_cfg & 0xF);
  1602		rc = qmem_alloc(rvu->dev, &pfvf->sq_ctx, req->sq_cnt, hwctx_size);
  1603		if (rc)
  1604			goto free_mem;
  1605	
  1606		pfvf->sq_bmap = kcalloc(req->sq_cnt, sizeof(long), GFP_KERNEL);
  1607		if (!pfvf->sq_bmap) {
  1608			rc = -ENOMEM;
  1609			goto free_mem;
  1610		}
  1611	
  1612		rvu_write64(rvu, blkaddr, NIX_AF_LFX_SQS_BASE(nixlf),
  1613			    (u64)pfvf->sq_ctx->iova);
  1614	
  1615		cfg = BIT_ULL(36) | (req->sq_cnt - 1) | req->way_mask << 20;
  1616		rvu_write64(rvu, blkaddr, NIX_AF_LFX_SQS_CFG(nixlf), cfg);
  1617	
  1618		/* Alloc NIX CQ HW context memory and config the base */
  1619		hwctx_size = 1UL << ((ctx_cfg >> 8) & 0xF);
  1620		rc = qmem_alloc(rvu->dev, &pfvf->cq_ctx, req->cq_cnt, hwctx_size);
  1621		if (rc)
  1622			goto free_mem;
  1623	
  1624		pfvf->cq_bmap = kcalloc(req->cq_cnt, sizeof(long), GFP_KERNEL);
  1625		if (!pfvf->cq_bmap) {
  1626			rc = -ENOMEM;
  1627			goto free_mem;
  1628		}
  1629	
  1630		rvu_write64(rvu, blkaddr, NIX_AF_LFX_CQS_BASE(nixlf),
  1631			    (u64)pfvf->cq_ctx->iova);
  1632	
  1633		cfg = BIT_ULL(36) | (req->cq_cnt - 1) | req->way_mask << 20;
  1634		rvu_write64(rvu, blkaddr, NIX_AF_LFX_CQS_CFG(nixlf), cfg);
  1635	
  1636		/* Initialize receive side scaling (RSS) */
  1637		hwctx_size = 1UL << ((ctx_cfg >> 12) & 0xF);
  1638		rc = nixlf_rss_ctx_init(rvu, blkaddr, pfvf, nixlf, req->rss_sz,
  1639					req->rss_grps, hwctx_size, req->way_mask,
  1640					!!(req->flags & NIX_LF_RSS_TAG_LSB_AS_ADDER));
  1641		if (rc)
  1642			goto free_mem;
  1643	
  1644		/* Alloc memory for CQINT's HW contexts */
  1645		cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST2);
  1646		qints = (cfg >> 24) & 0xFFF;
  1647		hwctx_size = 1UL << ((ctx_cfg >> 24) & 0xF);
  1648		rc = qmem_alloc(rvu->dev, &pfvf->cq_ints_ctx, qints, hwctx_size);
  1649		if (rc)
  1650			goto free_mem;
  1651	
  1652		rvu_write64(rvu, blkaddr, NIX_AF_LFX_CINTS_BASE(nixlf),
  1653			    (u64)pfvf->cq_ints_ctx->iova);
  1654	
  1655		rvu_write64(rvu, blkaddr, NIX_AF_LFX_CINTS_CFG(nixlf),
  1656			    BIT_ULL(36) | req->way_mask << 20);
  1657	
  1658		/* Alloc memory for QINT's HW contexts */
  1659		cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST2);
  1660		qints = (cfg >> 12) & 0xFFF;
  1661		hwctx_size = 1UL << ((ctx_cfg >> 20) & 0xF);
  1662		rc = qmem_alloc(rvu->dev, &pfvf->nix_qints_ctx, qints, hwctx_size);
  1663		if (rc)
  1664			goto free_mem;
  1665	
  1666		rvu_write64(rvu, blkaddr, NIX_AF_LFX_QINTS_BASE(nixlf),
  1667			    (u64)pfvf->nix_qints_ctx->iova);
  1668		rvu_write64(rvu, blkaddr, NIX_AF_LFX_QINTS_CFG(nixlf),
  1669			    BIT_ULL(36) | req->way_mask << 20);
  1670	
  1671		/* Setup VLANX TPID's.
  1672		 * Use VLAN1 for 802.1Q
  1673		 * and VLAN0 for 802.1AD.
  1674		 */
  1675		cfg = (0x8100ULL << 16) | 0x88A8ULL;
  1676		rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_CFG(nixlf), cfg);
  1677	
  1678		/* Enable LMTST for this NIX LF */
  1679		rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_CFG2(nixlf), BIT_ULL(0));
  1680	
  1681		/* Set CQE/WQE size, NPA_PF_FUNC for SQBs and also SSO_PF_FUNC */
  1682		if (req->npa_func)
  1683			cfg = req->npa_func;
  1684		if (req->sso_func)
  1685			cfg |= (u64)req->sso_func << 16;
  1686	
  1687		cfg |= (u64)req->xqe_sz << 33;
  1688		rvu_write64(rvu, blkaddr, NIX_AF_LFX_CFG(nixlf), cfg);
  1689	
  1690		/* Config Rx pkt length, csum checks and apad  enable / disable */
  1691		rvu_write64(rvu, blkaddr, NIX_AF_LFX_RX_CFG(nixlf), req->rx_cfg);
  1692	
  1693		/* Configure pkind for TX parse config */
  1694		if (is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc))) {
  1695			pf = rvu_get_pf(rvu->pdev, pcifunc);
> 1696			cgxd = rvu_cgx_pdata(cgx, rvu);
  1697	
  1698			mutex_lock(&cgxd->lock);
  1699			if (rvu_cgx_is_pkind_config_permitted(rvu, pcifunc)) {
  1700				cfg = NPC_TX_DEF_PKIND;
  1701				rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
  1702			}
  1703			mutex_unlock(&cgxd->lock);
  1704		}
  1705	
  1706		if (is_rep_dev(rvu, pcifunc)) {
  1707			pfvf->tx_chan_base = RVU_SWITCH_LBK_CHAN;
  1708			pfvf->tx_chan_cnt = 1;
  1709			goto exit;
  1710		}
  1711	
  1712		intf = is_lbk_vf(rvu, pcifunc) ? NIX_INTF_TYPE_LBK : NIX_INTF_TYPE_CGX;
  1713		if (is_sdp_pfvf(rvu, pcifunc))
  1714			intf = NIX_INTF_TYPE_SDP;
  1715	
  1716		if (is_cn20k(rvu->pdev)) {
  1717			rc = npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &bcast, &mcast,
  1718							 &promisc, &ucast);
  1719			if (rc) {
  1720				rc = npc_cn20k_dft_rules_alloc(rvu, pcifunc);
  1721				if (rc)
  1722					goto free_mem;
  1723	
  1724				rules_created = true;
  1725			}
  1726		}
  1727	
  1728		rc = nix_interface_init(rvu, pcifunc, intf, nixlf, rsp,
  1729					!!(req->flags & NIX_LF_LBK_BLK_SEL));
  1730		if (rc)
  1731			goto free_dft;
  1732	
  1733		/* Disable NPC entries as NIXLF's contexts are not initialized yet */
  1734		rvu_npc_disable_default_entries(rvu, pcifunc, nixlf);
  1735	
  1736		/* Configure RX VTAG Type 7 (strip) for vf vlan */
  1737		rvu_write64(rvu, blkaddr,
  1738			    NIX_AF_LFX_RX_VTAG_TYPEX(nixlf, NIX_AF_LFX_RX_VTAG_TYPE7),
  1739			    VTAGSIZE_T4 | VTAG_STRIP);
  1740	
  1741		goto exit;
  1742	
  1743	free_dft:
  1744		if (is_cn20k(rvu->pdev) && rules_created)
  1745			npc_cn20k_dft_rules_free(rvu, pcifunc);
  1746	
  1747	free_mem:
  1748		nix_ctx_free(rvu, pfvf);
  1749	
  1750	exit:
  1751		/* Set macaddr of this PF/VF */
  1752		ether_addr_copy(rsp->mac_addr, pfvf->mac_addr);
  1753	
  1754		/* set SQB size info */
  1755		cfg = rvu_read64(rvu, blkaddr, NIX_AF_SQ_CONST);
  1756		rsp->sqb_size = (cfg >> 34) & 0xFFFF;
  1757		rsp->rx_chan_base = pfvf->rx_chan_base;
  1758		rsp->tx_chan_base = pfvf->tx_chan_base;
  1759		rsp->rx_chan_cnt = pfvf->rx_chan_cnt;
  1760		rsp->tx_chan_cnt = pfvf->tx_chan_cnt;
  1761		rsp->lso_tsov4_idx = NIX_LSO_FORMAT_IDX_TSOV4;
  1762		rsp->lso_tsov6_idx = NIX_LSO_FORMAT_IDX_TSOV6;
  1763		/* Get HW supported stat count */
  1764		cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST1);
  1765		rsp->lf_rx_stats = ((cfg >> 32) & 0xFF);
  1766		rsp->lf_tx_stats = ((cfg >> 24) & 0xFF);
  1767		/* Get count of CQ IRQs and error IRQs supported per LF */
  1768		cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST2);
  1769		rsp->qints = ((cfg >> 12) & 0xFFF);
  1770		rsp->cints = ((cfg >> 24) & 0xFFF);
  1771		rsp->cgx_links = hw->cgx_links;
  1772		rsp->lbk_links = hw->lbk_links;
  1773		rsp->sdp_links = hw->sdp_links;
  1774	
  1775		return rc;
  1776	}
  1777	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

