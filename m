Return-Path: <netdev+bounces-302050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TLZADXxiPWpR2QgAu9opvQ
	(envelope-from <netdev+bounces-302050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 19:16:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7EF6C7BF1
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 19:16:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Z8nGM3Ru;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302050-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302050-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25A01301FF98
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3B3E00A7;
	Thu, 25 Jun 2026 17:12:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D7A28B4FA
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 17:12:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782407543; cv=none; b=ZSoSu+svcdNp41kTyY81XrdezoksddX5quyKe269a03dA1tXk1+fe/xV8FfW+mHuMK3ChQH/VGWD1F+hVsmjtrtDsP2o1jSYKEyD6106uB95BR0nHTEwVqDmeXVGJ+dSAHOGELTW1tvYhonIFpaHjFBitvMjpw7U4q1VaObX1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782407543; c=relaxed/simple;
	bh=MW80NVEm2MD1nfVSO16WUFH7nGPy7hbHNATKDelkpSc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GNTB3V17urUxJE1HL5HZNzFotleAZrEyjWspVMInaqChxdKHhZP810u0MEK02PPJ2LAlodZTjOTNnGehJ+en2iL2lHoOYMKoGudhHq0ongbn6ELGUjQTu1+L88NudGmceVEaDETgKCU5upyBLoa8z2SrB62r/dwThLcqcjGWfq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8nGM3Ru; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782407542; x=1813943542;
  h=date:from:to:cc:subject:message-id;
  bh=MW80NVEm2MD1nfVSO16WUFH7nGPy7hbHNATKDelkpSc=;
  b=Z8nGM3RuCscdS6yiVrGk+4wO6mS9zbPBC/1yeHidQW4xhu6PyzFMfrl9
   x6oBEUarqVIhHO5eeGfBP4/P2PPbAZJ7c8Lo0SgFXfYBdu5IpZj0ne+IA
   yKwK2oHHJtAdcSCjLidt3MdMafsBn+2VTstHewRBXmCnmqjLVWGofmU2n
   xWelomLXyAdEPObVTuA56q6vZBAu1EOl47iGz2S44Rerss1zPNMbb1TEh
   mJgpxh325R/gu67Pps2biDOBgTdi0lg/9AQsMZSRl61TERdtGhMfSWrG+
   Qzb9H7zV7sLb9e54jDw6eeSB51OCEZlu8uZKCFALDlmffRJISxtLr29hv
   A==;
X-CSE-ConnectionGUID: 0+98Mr07TXmhzKXmaTddQg==
X-CSE-MsgGUID: zPIiY1PhQOSKMh0pDI1FTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="100742295"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="100742295"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 10:12:21 -0700
X-CSE-ConnectionGUID: Kk3bJCWMT+2DU0KrVQLCDw==
X-CSE-MsgGUID: 3ZUfS4srSeShoE2FoaSaAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="255795942"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 25 Jun 2026 10:12:19 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcncb-000000004Kn-1x7Z;
	Thu, 25 Jun 2026 17:12:15 +0000
Date: Fri, 26 Jun 2026 01:11:54 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Subject: [net:main 69/101] net/xfrm/xfrm_state.c:1220: Warning:
 missing closing `"'
Message-ID: <202606260102.GcwhFSNK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302050-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:oe-kbuild-all@lists.linux.dev,m:netdev@vger.kernel.org,m:kuba@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,secunet.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B7EF6C7BF1

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git main
head:   02f144fbb4c86c360495d33debe307cb46a57f95
commit: e9deb406c10f5a73bcfd62f42ca1187b220bc188 [69/101] Merge tag 'ipsec-2026-06-22' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
config: s390-randconfig-r133-20260625 (https://download.01.org/0day-ci/archive/20260626/202606260102.GcwhFSNK-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260626/202606260102.GcwhFSNK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606260102.GcwhFSNK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/xfrm/xfrm_state.c: Assembler messages:
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
>> net/xfrm/xfrm_state.c:1220: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'
   net/xfrm/xfrm_state.c:1225: Warning: missing closing `"'


vim +1220 net/xfrm/xfrm_state.c

edcd582152090b David S. Miller  2006-08-24  1200  
81a331a0e72ddc Steffen Klassert 2024-10-23  1201  struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
81a331a0e72ddc Steffen Klassert 2024-10-23  1202  					   const xfrm_address_t *daddr,
81a331a0e72ddc Steffen Klassert 2024-10-23  1203  					   __be32 spi, u8 proto,
81a331a0e72ddc Steffen Klassert 2024-10-23  1204  					   unsigned short family)
81a331a0e72ddc Steffen Klassert 2024-10-23  1205  {
e952837f3ddb0f Florian Westphal 2024-11-28  1206  	struct xfrm_hash_state_ptrs state_ptrs;
81a331a0e72ddc Steffen Klassert 2024-10-23  1207  	struct hlist_head *state_cache_input;
81a331a0e72ddc Steffen Klassert 2024-10-23  1208  	struct xfrm_state *x = NULL;
81a331a0e72ddc Steffen Klassert 2024-10-23  1209  
ddd3d013292031 Herbert Xu       2026-06-12  1210  	/* BH is always disabled on the input path. */
ddd3d013292031 Herbert Xu       2026-06-12  1211  	lockdep_assert_in_softirq();
ddd3d013292031 Herbert Xu       2026-06-12  1212  
6c9b7db96db62e Sebastian Sewior 2025-01-23  1213  	state_cache_input = raw_cpu_ptr(net->xfrm.state_cache_input);
81a331a0e72ddc Steffen Klassert 2024-10-23  1214  
81a331a0e72ddc Steffen Klassert 2024-10-23  1215  	hlist_for_each_entry_rcu(x, state_cache_input, state_cache_input) {
81a331a0e72ddc Steffen Klassert 2024-10-23  1216  		if (x->props.family != family ||
81a331a0e72ddc Steffen Klassert 2024-10-23  1217  		    x->id.spi       != spi ||
81a331a0e72ddc Steffen Klassert 2024-10-23  1218  		    x->id.proto     != proto ||
81a331a0e72ddc Steffen Klassert 2024-10-23  1219  		    !xfrm_addr_equal(&x->id.daddr, daddr, family))
81a331a0e72ddc Steffen Klassert 2024-10-23 @1220  			continue;
81a331a0e72ddc Steffen Klassert 2024-10-23  1221  
81a331a0e72ddc Steffen Klassert 2024-10-23  1222  		if ((mark & x->mark.m) != x->mark.v)
81a331a0e72ddc Steffen Klassert 2024-10-23  1223  			continue;
81a331a0e72ddc Steffen Klassert 2024-10-23  1224  		if (!xfrm_state_hold_rcu(x))
81a331a0e72ddc Steffen Klassert 2024-10-23  1225  			continue;
81a331a0e72ddc Steffen Klassert 2024-10-23  1226  		goto out;
81a331a0e72ddc Steffen Klassert 2024-10-23  1227  	}
81a331a0e72ddc Steffen Klassert 2024-10-23  1228  
e952837f3ddb0f Florian Westphal 2024-11-28  1229  	xfrm_hash_ptrs_get(net, &state_ptrs);
e952837f3ddb0f Florian Westphal 2024-11-28  1230  
e952837f3ddb0f Florian Westphal 2024-11-28  1231  	x = __xfrm_state_lookup(&state_ptrs, mark, daddr, spi, proto, family);
ddd3d013292031 Herbert Xu       2026-06-12  1232  	if (x) {
ddd3d013292031 Herbert Xu       2026-06-12  1233  		spin_lock(&net->xfrm.xfrm_state_lock);
ddd3d013292031 Herbert Xu       2026-06-12  1234  		if (x->km.state != XFRM_STATE_VALID) {
ddd3d013292031 Herbert Xu       2026-06-12  1235  			/*
ddd3d013292031 Herbert Xu       2026-06-12  1236  			 * The state is about to be destroyed.
ddd3d013292031 Herbert Xu       2026-06-12  1237  			 *
ddd3d013292031 Herbert Xu       2026-06-12  1238  			 * Don't add it to the cache but still
ddd3d013292031 Herbert Xu       2026-06-12  1239  			 * return it to the caller.
ddd3d013292031 Herbert Xu       2026-06-12  1240  			 */
ddd3d013292031 Herbert Xu       2026-06-12  1241  		} else if (hlist_unhashed(&x->state_cache_input)) {
81a331a0e72ddc Steffen Klassert 2024-10-23  1242  			hlist_add_head_rcu(&x->state_cache_input, state_cache_input);
81a331a0e72ddc Steffen Klassert 2024-10-23  1243  		} else {
81a331a0e72ddc Steffen Klassert 2024-10-23  1244  			hlist_del_rcu(&x->state_cache_input);
81a331a0e72ddc Steffen Klassert 2024-10-23  1245  			hlist_add_head_rcu(&x->state_cache_input, state_cache_input);
81a331a0e72ddc Steffen Klassert 2024-10-23  1246  		}
ddd3d013292031 Herbert Xu       2026-06-12  1247  		spin_unlock(&net->xfrm.xfrm_state_lock);
81a331a0e72ddc Steffen Klassert 2024-10-23  1248  	}
81a331a0e72ddc Steffen Klassert 2024-10-23  1249  
81a331a0e72ddc Steffen Klassert 2024-10-23  1250  out:
81a331a0e72ddc Steffen Klassert 2024-10-23  1251  	return x;
81a331a0e72ddc Steffen Klassert 2024-10-23  1252  }
81a331a0e72ddc Steffen Klassert 2024-10-23  1253  EXPORT_SYMBOL(xfrm_input_state_lookup);
81a331a0e72ddc Steffen Klassert 2024-10-23  1254  

:::::: The code at line 1220 was first introduced by commit
:::::: 81a331a0e72ddc2f75092603d9577bd1a0ca23ad xfrm: Add an inbound percpu state cache.

:::::: TO: Steffen Klassert <steffen.klassert@secunet.com>
:::::: CC: Steffen Klassert <steffen.klassert@secunet.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

