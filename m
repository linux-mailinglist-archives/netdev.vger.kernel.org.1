Return-Path: <netdev+bounces-286258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cVzkAoRJAGozGAEAu9opvQ
	(envelope-from <netdev+bounces-286258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:01:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68590503404
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3935D300B3C6
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDDD366048;
	Sun, 10 May 2026 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGkSLbA0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD61D54FA;
	Sun, 10 May 2026 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778403711; cv=none; b=l5JJbgwhwW3zh513j0JD7VS8emYeKk6Hzf9hbrnts4Z07x3rGt5XOX1vZHn2ggM+Bjl/1fjpOtuZpktKYuJw6vO1KC2m7ncCb04luIJQOazrUtJJa1AuAusS8ZAsbe4Ai26OS62CVGj6KxIz9oNzTaRVQ+2UuCzaIVmCMG1OeHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778403711; c=relaxed/simple;
	bh=OZFp0rfyazKjRwHnU57/f6YsNV5zbXktLoeHYQduvBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R89gt6IC2Crr36/wstimvhwyfDgecbONBNkcMVKTx9zqI5oAuGZmiwu9JnYG1EfPCRbqxFy2WFp8YiI+XRsjIVRtjG5/HrW1Sa6wUUPE8sR/300tUIsNIYtp0gTGd0PMUYT1Y4rpbWwIvKCl4IRKorX2jpRLvbZUTk5IXU9z0Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGkSLbA0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778403710; x=1809939710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OZFp0rfyazKjRwHnU57/f6YsNV5zbXktLoeHYQduvBs=;
  b=HGkSLbA0IGMeNl1cWEh81b/Jktx7ci0FOWAYgUBO0ixbvPmvUExAyoNi
   VPHBRnkq9Xy9yQaGjSbQzHlwHZH1wecOqspEyw8EGhqLto6Pd7MEAuvia
   2LRCGe45M8kt9iyeOcyI/Inyt9BkdC74bouvgA+th0zi4DVz8u5IJIj0c
   1N3KfVpcgWMBzq5xiD897qQeAGdrk5z/WaGITlnhLT5pEwPA8oemx0+WT
   jf8VJRripe/IdMfe+GhAFGRJqKp8SGg+6bXNdl2HDhLMhdRIPf4GWe3rh
   rpp7wC7yaelkKto4KjlHZqqgCDq1eC404MEm+SgO6OwrSdEwx2qCQFP5b
   Q==;
X-CSE-ConnectionGUID: HL9qbHpyS3iwG/YFYu/nlQ==
X-CSE-MsgGUID: poh0r5wRQA2SQSFI3ULC4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="96743288"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="96743288"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 02:01:50 -0700
X-CSE-ConnectionGUID: b7wtxgHxQye/5EiR1bMJKQ==
X-CSE-MsgGUID: yn7CwMTqQj+BR1Z1YkhJ1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="241156950"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 May 2026 02:01:46 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wM02h-000000001w5-1zLv;
	Sun, 10 May 2026 09:01:43 +0000
Date: Sun, 10 May 2026 17:01:15 +0800
From: kernel test robot <lkp@intel.com>
To: Lucas Poupeau <lucasp.linux@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lucas Poupeau <lucasp.linux@gmail.com>
Subject: Re: [PATCH] llc: fix coding style and memory barrier documentation
Message-ID: <202605101615.XGX7gOua-lkp@intel.com>
References: <20260505192549.74382-1-lucasp.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505192549.74382-1-lucasp.linux@gmail.com>
X-Rspamd-Queue-Id: 68590503404
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286258-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url,git-scm.com:url,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Hi Lucas,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master horms-ipvs/master v7.1-rc2 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lucas-Poupeau/llc-fix-coding-style-and-memory-barrier-documentation/20260510-102311
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260505192549.74382-1-lucasp.linux%40gmail.com
patch subject: [PATCH] llc: fix coding style and memory barrier documentation
config: riscv-randconfig-002-20260510 (https://download.01.org/0day-ci/archive/20260510/202605101615.XGX7gOua-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260510/202605101615.XGX7gOua-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605101615.XGX7gOua-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/llc/llc_input.c:181:3: error: call to undeclared function 'dprintk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     181 |                 dprintk("%s: PACKET_OTHERHOST\n", __func__);
         |                 ^
   net/llc/llc_input.c:194:3: error: call to undeclared function 'dprintk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     194 |                 dprintk("%s: llc_sap_find(%02X) failed!\n", __func__,
         |                 ^
   2 errors generated.


vim +/dprintk +181 net/llc/llc_input.c

^1da177e4c3f41 Linus Torvalds           2005-04-16  151  
^1da177e4c3f41 Linus Torvalds           2005-04-16  152  /**
^1da177e4c3f41 Linus Torvalds           2005-04-16  153   *	llc_rcv - 802.2 entry point from net lower layers
^1da177e4c3f41 Linus Torvalds           2005-04-16  154   *	@skb: received pdu
^1da177e4c3f41 Linus Torvalds           2005-04-16  155   *	@dev: device that receive pdu
^1da177e4c3f41 Linus Torvalds           2005-04-16  156   *	@pt: packet type
74c950c966c180 Andrew Lunn              2020-07-13  157   *	@orig_dev: the original receive net device
^1da177e4c3f41 Linus Torvalds           2005-04-16  158   *
^1da177e4c3f41 Linus Torvalds           2005-04-16  159   *	When the system receives a 802.2 frame this function is called. It
^1da177e4c3f41 Linus Torvalds           2005-04-16  160   *	checks SAP and connection of received pdu and passes frame to
^1da177e4c3f41 Linus Torvalds           2005-04-16  161   *	llc_{station,sap,conn}_rcv for sending to proper state machine. If
^1da177e4c3f41 Linus Torvalds           2005-04-16  162   *	the frame is related to a busy connection (a connection is sending
^1da177e4c3f41 Linus Torvalds           2005-04-16  163   *	data now), it queues this frame in the connection's backlog.
^1da177e4c3f41 Linus Torvalds           2005-04-16  164   */
^1da177e4c3f41 Linus Torvalds           2005-04-16  165  int llc_rcv(struct sk_buff *skb, struct net_device *dev,
f2ccd8fa06c8e3 David S. Miller          2005-08-09  166  	    struct packet_type *pt, struct net_device *orig_dev)
^1da177e4c3f41 Linus Torvalds           2005-04-16  167  {
^1da177e4c3f41 Linus Torvalds           2005-04-16  168  	struct llc_sap *sap;
^1da177e4c3f41 Linus Torvalds           2005-04-16  169  	struct llc_pdu_sn *pdu;
^1da177e4c3f41 Linus Torvalds           2005-04-16  170  	int dest;
846d7f9be89210 Lucas Poupeau            2026-05-05  171  	int (*rcv)(struct sk_buff *skb, struct net_device *dev,
846d7f9be89210 Lucas Poupeau            2026-05-05  172  		   struct packet_type *pt, struct net_device *orig_dev);
aadf31de16a7b2 Ben Hutchings            2012-08-13  173  	void (*sta_handler)(struct sk_buff *skb);
aadf31de16a7b2 Ben Hutchings            2012-08-13  174  	void (*sap_handler)(struct llc_sap *sap, struct sk_buff *skb);
^1da177e4c3f41 Linus Torvalds           2005-04-16  175  
^1da177e4c3f41 Linus Torvalds           2005-04-16  176  	/*
^1da177e4c3f41 Linus Torvalds           2005-04-16  177  	 * When the interface is in promisc. mode, drop all the crap that it
^1da177e4c3f41 Linus Torvalds           2005-04-16  178  	 * receives, do not try to analyse it.
^1da177e4c3f41 Linus Torvalds           2005-04-16  179  	 */
^1da177e4c3f41 Linus Torvalds           2005-04-16  180  	if (unlikely(skb->pkt_type == PACKET_OTHERHOST)) {
0dc47877a3de00 Harvey Harrison          2008-03-05 @181  		dprintk("%s: PACKET_OTHERHOST\n", __func__);
^1da177e4c3f41 Linus Torvalds           2005-04-16  182  		goto drop;
^1da177e4c3f41 Linus Torvalds           2005-04-16  183  	}
^1da177e4c3f41 Linus Torvalds           2005-04-16  184  	skb = skb_share_check(skb, GFP_ATOMIC);
^1da177e4c3f41 Linus Torvalds           2005-04-16  185  	if (unlikely(!skb))
^1da177e4c3f41 Linus Torvalds           2005-04-16  186  		goto out;
^1da177e4c3f41 Linus Torvalds           2005-04-16  187  	if (unlikely(!llc_fixup_skb(skb)))
^1da177e4c3f41 Linus Torvalds           2005-04-16  188  		goto drop;
^1da177e4c3f41 Linus Torvalds           2005-04-16  189  	pdu = llc_pdu_sn_hdr(skb);
^1da177e4c3f41 Linus Torvalds           2005-04-16  190  	if (unlikely(!pdu->dsap)) /* NULL DSAP, refer to station */
^1da177e4c3f41 Linus Torvalds           2005-04-16  191  	       goto handle_station;
^1da177e4c3f41 Linus Torvalds           2005-04-16  192  	sap = llc_sap_find(pdu->dsap);
^1da177e4c3f41 Linus Torvalds           2005-04-16  193  	if (unlikely(!sap)) {/* unknown SAP */
0dc47877a3de00 Harvey Harrison          2008-03-05  194  		dprintk("%s: llc_sap_find(%02X) failed!\n", __func__,
^1da177e4c3f41 Linus Torvalds           2005-04-16  195  			pdu->dsap);
^1da177e4c3f41 Linus Torvalds           2005-04-16  196  		goto drop;
^1da177e4c3f41 Linus Torvalds           2005-04-16  197  	}
^1da177e4c3f41 Linus Torvalds           2005-04-16  198  	/*
^1da177e4c3f41 Linus Torvalds           2005-04-16  199  	 * First the upper layer protocols that don't need the full
^1da177e4c3f41 Linus Torvalds           2005-04-16  200  	 * LLC functionality
^1da177e4c3f41 Linus Torvalds           2005-04-16  201  	 */
23dbe7912dad6b Stephen Hemminger        2006-05-25  202  	rcv = rcu_dereference(sap->rcv_func);
696ea472e19c6d Changli Gao              2011-02-22  203  	dest = llc_pdu_type(skb);
6aa7de059173a9 Mark Rutland             2017-10-23  204  	sap_handler = dest ? READ_ONCE(llc_type_handlers[dest - 1]) : NULL;
aadf31de16a7b2 Ben Hutchings            2012-08-13  205  	if (unlikely(!sap_handler)) {
696ea472e19c6d Changli Gao              2011-02-22  206  		if (rcv)
696ea472e19c6d Changli Gao              2011-02-22  207  			rcv(skb, dev, pt, orig_dev);
696ea472e19c6d Changli Gao              2011-02-22  208  		else
696ea472e19c6d Changli Gao              2011-02-22  209  			kfree_skb(skb);
696ea472e19c6d Changli Gao              2011-02-22  210  	} else {
23dbe7912dad6b Stephen Hemminger        2006-05-25  211  		if (rcv) {
8f182b494f8779 Stephen Hemminger        2006-05-25  212  			struct sk_buff *cskb = skb_clone(skb, GFP_ATOMIC);
846d7f9be89210 Lucas Poupeau            2026-05-05  213  
8f182b494f8779 Stephen Hemminger        2006-05-25  214  			if (cskb)
8f182b494f8779 Stephen Hemminger        2006-05-25  215  				rcv(cskb, dev, pt, orig_dev);
^1da177e4c3f41 Linus Torvalds           2005-04-16  216  		}
aadf31de16a7b2 Ben Hutchings            2012-08-13  217  		sap_handler(sap, skb);
696ea472e19c6d Changli Gao              2011-02-22  218  	}
6e2144b76840be Arnaldo Carvalho de Melo 2005-09-22  219  	llc_sap_put(sap);
^1da177e4c3f41 Linus Torvalds           2005-04-16  220  out:
^1da177e4c3f41 Linus Torvalds           2005-04-16  221  	return 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  222  drop:
^1da177e4c3f41 Linus Torvalds           2005-04-16  223  	kfree_skb(skb);
^1da177e4c3f41 Linus Torvalds           2005-04-16  224  	goto out;
846d7f9be89210 Lucas Poupeau            2026-05-05  225  
^1da177e4c3f41 Linus Torvalds           2005-04-16  226  handle_station:
6aa7de059173a9 Mark Rutland             2017-10-23  227  	sta_handler = READ_ONCE(llc_station_handler);
aadf31de16a7b2 Ben Hutchings            2012-08-13  228  	if (!sta_handler)
^1da177e4c3f41 Linus Torvalds           2005-04-16  229  		goto drop;
aadf31de16a7b2 Ben Hutchings            2012-08-13  230  	sta_handler(skb);
^1da177e4c3f41 Linus Torvalds           2005-04-16  231  	goto out;
^1da177e4c3f41 Linus Torvalds           2005-04-16  232  }
^1da177e4c3f41 Linus Torvalds           2005-04-16  233  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

