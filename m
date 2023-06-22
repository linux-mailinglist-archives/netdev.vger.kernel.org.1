Return-Path: <netdev+bounces-13154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D4A73A830
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480CF1C21163
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D674820693;
	Thu, 22 Jun 2023 18:25:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4920690
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:25:51 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700CD2114
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687458349; x=1718994349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZMpnIkmykJ1L3GvJ4a9FCU6fcXiYKhGWTGCEesBdMvU=;
  b=kzPsfrb01d0xplJDHlXwdsa2EQJMlbtku3JQJQ3aBWwQAlMym3Iw4cMS
   Qi6c2ONengvMTzTz2iVJ2n5ow8Juv9lsBGuLz91xZLufvMNU4Iy1Fp4VT
   jAw8jVR05jEK7pOrrz4OvK8HpFiaDznALQ9nAS46WiwEGo/GL8aij7yJI
   +SwIjMklcRoSm0W9ESGk6TasMg4xbpXCWGDKbFcgDACeBAG14GUaQv2sC
   e3wGZmw0Q1Xbs/MjzRmukLHnNse2lJWa+4dLx1FcoNnvpJ8Gkt3SgBjt2
   ME4vjsZ5CPtrBkhDuIT4GpOl8HI8Mgq6SsGuxGdEO4hk0yZIpUpqCPT/X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359437327"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="359437327"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:25:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="785025435"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="785025435"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2023 11:25:46 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qCP05-0007jr-0z;
	Thu, 22 Jun 2023 18:25:45 +0000
Date: Fri, 23 Jun 2023 02:25:05 +0800
From: kernel test robot <lkp@intel.com>
To: Lin Ma <linma@zju.edu.cn>, krzysztof.kozlowski@linaro.org,
	avem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Lin Ma <linma@zju.edu.cn>
Subject: Re: [PATCH v2] net: nfc: Fix use-after-free caused by
 nfc_llcp_find_local
Message-ID: <202306230247.UPcyNhPl-lkp@intel.com>
References: <20230622150331.1242706-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622150331.1242706-1-linma@zju.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Lin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master horms-ipvs/master v6.4-rc7 next-20230622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lin-Ma/net-nfc-Fix-use-after-free-caused-by-nfc_llcp_find_local/20230622-230631
base:   net/main
patch link:    https://lore.kernel.org/r/20230622150331.1242706-1-linma%40zju.edu.cn
patch subject: [PATCH v2] net: nfc: Fix use-after-free caused by nfc_llcp_find_local
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230623/202306230247.UPcyNhPl-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230623/202306230247.UPcyNhPl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306230247.UPcyNhPl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/nfc/llcp_core.c:146:24: warning: no previous prototype for 'nfc_llcp_local_get' [-Wmissing-prototypes]
     146 | struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
         |                        ^~~~~~~~~~~~~~~~~~
>> net/nfc/llcp_core.c:299:24: warning: no previous prototype for 'nfc_llcp_remove_local' [-Wmissing-prototypes]
     299 | struct nfc_llcp_local *nfc_llcp_remove_local(struct nfc_dev *dev)
         |                        ^~~~~~~~~~~~~~~~~~~~~


vim +/nfc_llcp_local_get +146 net/nfc/llcp_core.c

d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  145  
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04 @146  struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  147  {
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  148  	kref_get(&local->ref);
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  149  
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  150  	return local;
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  151  }
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  152  
c470e319b48bf1 net/nfc/llcp/llcp.c Samuel Ortiz    2013-04-03  153  static void local_cleanup(struct nfc_llcp_local *local)
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  154  {
c470e319b48bf1 net/nfc/llcp/llcp.c Samuel Ortiz    2013-04-03  155  	nfc_llcp_socket_release(local, false, ENXIO);
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  156  	del_timer_sync(&local->link_timer);
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  157  	skb_queue_purge(&local->tx_queue);
474fee3db16c63 net/nfc/llcp/llcp.c Tejun Heo       2012-08-22  158  	cancel_work_sync(&local->tx_work);
474fee3db16c63 net/nfc/llcp/llcp.c Tejun Heo       2012-08-22  159  	cancel_work_sync(&local->rx_work);
474fee3db16c63 net/nfc/llcp/llcp.c Tejun Heo       2012-08-22  160  	cancel_work_sync(&local->timeout_work);
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  161  	kfree_skb(local->rx_pending);
4bb4db7f3187c6 net/nfc/llcp_core.c Jisoo Jang      2023-01-11  162  	local->rx_pending = NULL;
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  163  	del_timer_sync(&local->sdreq_timer);
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  164  	cancel_work_sync(&local->sdreq_timeout_work);
d9b8d8e19b0730 net/nfc/llcp/llcp.c Thierry Escande 2013-02-15  165  	nfc_llcp_free_sdp_tlv_list(&local->pending_sdreqs);
3536da06db0baa net/nfc/llcp/llcp.c Samuel Ortiz    2013-02-21  166  }
3536da06db0baa net/nfc/llcp/llcp.c Samuel Ortiz    2013-02-21  167  
3536da06db0baa net/nfc/llcp/llcp.c Samuel Ortiz    2013-02-21  168  static void local_release(struct kref *ref)
3536da06db0baa net/nfc/llcp/llcp.c Samuel Ortiz    2013-02-21  169  {
3536da06db0baa net/nfc/llcp/llcp.c Samuel Ortiz    2013-02-21  170  	struct nfc_llcp_local *local;
3536da06db0baa net/nfc/llcp/llcp.c Samuel Ortiz    2013-02-21  171  
3536da06db0baa net/nfc/llcp/llcp.c Samuel Ortiz    2013-02-21  172  	local = container_of(ref, struct nfc_llcp_local, ref);
3536da06db0baa net/nfc/llcp/llcp.c Samuel Ortiz    2013-02-21  173  
c470e319b48bf1 net/nfc/llcp/llcp.c Samuel Ortiz    2013-04-03  174  	local_cleanup(local);
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  175  	kfree(local);
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  176  }
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  177  
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  178  int nfc_llcp_local_put(struct nfc_llcp_local *local)
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  179  {
a69f32af86e389 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  180  	if (local == NULL)
a69f32af86e389 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  181  		return 0;
a69f32af86e389 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  182  
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  183  	return kref_put(&local->ref, local_release);
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  184  }
c7aa12252f5142 net/nfc/llcp/llcp.c Samuel Ortiz    2012-05-04  185  
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  186  static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  187  					       u8 ssap, u8 dsap)
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  188  {
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  189  	struct sock *sk;
a8df0f379213f1 net/nfc/llcp/llcp.c Samuel Ortiz    2012-10-16  190  	struct nfc_llcp_sock *llcp_sock, *tmp_sock;
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  191  
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  192  	pr_debug("ssap dsap %d %d\n", ssap, dsap);
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  193  
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  194  	if (ssap == 0 && dsap == 0)
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  195  		return NULL;
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  196  
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  197  	read_lock(&local->sockets.lock);
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  198  
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  199  	llcp_sock = NULL;
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  200  
b67bfe0d42cac5 net/nfc/llcp/llcp.c Sasha Levin     2013-02-27  201  	sk_for_each(sk, &local->sockets.head) {
a8df0f379213f1 net/nfc/llcp/llcp.c Samuel Ortiz    2012-10-16  202  		tmp_sock = nfc_llcp_sock(sk);
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  203  
a8df0f379213f1 net/nfc/llcp/llcp.c Samuel Ortiz    2012-10-16  204  		if (tmp_sock->ssap == ssap && tmp_sock->dsap == dsap) {
a8df0f379213f1 net/nfc/llcp/llcp.c Samuel Ortiz    2012-10-16  205  			llcp_sock = tmp_sock;
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  206  			break;
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  207  		}
a8df0f379213f1 net/nfc/llcp/llcp.c Samuel Ortiz    2012-10-16  208  	}
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  209  
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  210  	read_unlock(&local->sockets.lock);
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  211  
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  212  	if (llcp_sock == NULL)
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  213  		return NULL;
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  214  
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  215  	sock_hold(&llcp_sock->sk);
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  216  
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  217  	return llcp_sock;
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  218  }
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  219  
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  220  static void nfc_llcp_sock_put(struct nfc_llcp_sock *sock)
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  221  {
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  222  	sock_put(&sock->sk);
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  223  }
8f50020ed9b81b net/nfc/llcp/llcp.c Samuel Ortiz    2012-06-25  224  
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  225  static void nfc_llcp_timeout_work(struct work_struct *work)
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  226  {
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  227  	struct nfc_llcp_local *local = container_of(work, struct nfc_llcp_local,
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  228  						    timeout_work);
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  229  
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  230  	nfc_dep_link_down(local->dev);
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  231  }
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  232  
4b519bb493e086 net/nfc/llcp_core.c Allen Pais      2017-10-11  233  static void nfc_llcp_symm_timer(struct timer_list *t)
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  234  {
4b519bb493e086 net/nfc/llcp_core.c Allen Pais      2017-10-11  235  	struct nfc_llcp_local *local = from_timer(local, t, link_timer);
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  236  
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  237  	pr_err("SYMM timeout\n");
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  238  
916082b073ebb7 net/nfc/llcp/llcp.c Linus Torvalds  2012-10-02  239  	schedule_work(&local->timeout_work);
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  240  }
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  241  
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  242  static void nfc_llcp_sdreq_timeout_work(struct work_struct *work)
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  243  {
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  244  	unsigned long time;
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  245  	HLIST_HEAD(nl_sdres_list);
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  246  	struct hlist_node *n;
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  247  	struct nfc_llcp_sdp_tlv *sdp;
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  248  	struct nfc_llcp_local *local = container_of(work, struct nfc_llcp_local,
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  249  						    sdreq_timeout_work);
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  250  
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  251  	mutex_lock(&local->sdreq_lock);
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  252  
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  253  	time = jiffies - msecs_to_jiffies(3 * local->remote_lto);
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  254  
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  255  	hlist_for_each_entry_safe(sdp, n, &local->pending_sdreqs, node) {
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  256  		if (time_after(sdp->time, time))
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  257  			continue;
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  258  
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  259  		sdp->sap = LLCP_SDP_UNBOUND;
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  260  
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  261  		hlist_del(&sdp->node);
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  262  
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  263  		hlist_add_head(&sdp->node, &nl_sdres_list);
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  264  	}
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  265  
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  266  	if (!hlist_empty(&local->pending_sdreqs))
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  267  		mod_timer(&local->sdreq_timer,
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  268  			  jiffies + msecs_to_jiffies(3 * local->remote_lto));
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  269  
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  270  	mutex_unlock(&local->sdreq_lock);
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  271  
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  272  	if (!hlist_empty(&nl_sdres_list))
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  273  		nfc_genl_llc_send_sdres(local->dev, &nl_sdres_list);
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  274  }
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  275  
4b519bb493e086 net/nfc/llcp_core.c Allen Pais      2017-10-11  276  static void nfc_llcp_sdreq_timer(struct timer_list *t)
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  277  {
4b519bb493e086 net/nfc/llcp_core.c Allen Pais      2017-10-11  278  	struct nfc_llcp_local *local = from_timer(local, t, sdreq_timer);
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  279  
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  280  	schedule_work(&local->sdreq_timeout_work);
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  281  }
40213fa8513c2a net/nfc/llcp/llcp.c Thierry Escande 2013-03-04  282  
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  283  struct nfc_llcp_local *nfc_llcp_find_local(struct nfc_dev *dev)
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  284  {
29e27dd86b5c4f net/nfc/llcp_core.c Axel Lin        2014-02-26  285  	struct nfc_llcp_local *local;
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  286  	struct nfc_llcp_local *res = NULL;
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  287  
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  288  	spin_lock(&llcp_devices_lock);
29e27dd86b5c4f net/nfc/llcp_core.c Axel Lin        2014-02-26  289  	list_for_each_entry(local, &llcp_devices, list)
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  290  		if (local->dev == dev) {
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  291  			res = nfc_llcp_local_get(local);
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  292  			break;
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  293  		}
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  294  	spin_unlock(&llcp_devices_lock);
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  295  
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  296  	return res;
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  297  }
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  298  
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22 @299  struct nfc_llcp_local *nfc_llcp_remove_local(struct nfc_dev *dev)
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  300  {
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  301  	struct nfc_llcp_local *local, *tmp;
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  302  
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  303  	spin_lock(&llcp_devices_lock);
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  304  	list_for_each_entry_safe(local, tmp, &llcp_devices, list)
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  305  		if (local->dev == dev) {
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  306  			list_del(&local->list);
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  307  			spin_unlock(&llcp_devices_lock);
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  308  			return local;
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  309  		}
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  310  	spin_unlock(&llcp_devices_lock);
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  311  
972f46a30da575 net/nfc/llcp_core.c Lin Ma          2023-06-22  312  	pr_warn("Shutting down device not found\n");
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  313  
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  314  	return NULL;
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  315  }
d646960f7986fe net/nfc/llcp/llcp.c Samuel Ortiz    2011-12-14  316  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

