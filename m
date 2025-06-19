Return-Path: <netdev+bounces-199559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21E3AE0B1E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 18:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920293B1816
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F9028B7E2;
	Thu, 19 Jun 2025 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bw8ssvfh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6834528B7DA
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750349539; cv=none; b=F9UC2KFghqTD3QLWj3spSZuSmdrOEbe2lFZ/W2G7JMp2ImXDyldw6pSFLBKSB+m/RIXEIjY6XG1MNTQdPyMb0GDdZ3BTkGLFoJONh1KFIG5+KYPO/r3BATZxjEIN4H8TXWCYAA9ZQPq7tsYKcaeihE+DoEDbQLZ+Zg/NdD3u5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750349539; c=relaxed/simple;
	bh=eZeFMyXoXrPa0H3PUfdNacEX4YaUbbno9icAQHEzUrs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aM+pdx56h1rJt8T3jlGZPUfMlYCTYDjiyYLONifDDDgyxsbvdqbH2H9+5AInTkrCkprR9ihhzoz8cNHAT2Jbpua6qWLhmWO6sQwgcb/wA1LL2W6ey3pA4JuNj6J8ogjU/1f4j+Dbm9Yg/c0fN8zBUvhhlSH3P5f1zn8MN70pJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bw8ssvfh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750349537; x=1781885537;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eZeFMyXoXrPa0H3PUfdNacEX4YaUbbno9icAQHEzUrs=;
  b=bw8ssvfhpmu38Eqp8T1cw8hZmILEVl6Eue2CAi0RgALoLc7cVsgkP7+3
   /MMVtASD93LqcOs/fBv5EzqWsPENCkn2AXtjBydsWZGvVXmBTucrihBpK
   L3aDFM3iMouYtX65x0WRJec6xTn7eX8JajcTEzS7ZsRsitFYzX9fzM+1S
   AlO6mM9f2dJqQ8WZ3F4/Wa39G/Gj7rSLUmKAq8bbryCEmTgfd/a3FWByv
   FLCHSSy+vGVn/RF0WhOjoSKPeocple9Lm8BAz6GfJjQ7p6XXZ+WvzM9Yh
   kTpb/8wonTCoC8PVSwuJTZ0+tIprBEwZMljjPDF8X+7XdcI3B1jlcBhTk
   g==;
X-CSE-ConnectionGUID: tCs2XtvSQHW9ODtKrlHZTQ==
X-CSE-MsgGUID: jUiHDcj5QiiEzKqV0uPkDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="62873264"
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="62873264"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 09:12:16 -0700
X-CSE-ConnectionGUID: JzBnOImMSdmcABF+XTTyXg==
X-CSE-MsgGUID: 651QLFacSUS41TAeeL/YMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="150492953"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 Jun 2025 09:12:14 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSHs4-000KvM-0j;
	Thu, 19 Jun 2025 16:12:12 +0000
Date: Fri, 20 Jun 2025 00:11:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [net-next:main 35/47] net/ethtool/pse-pd.c: warning: EXPORT_SYMBOL()
 is used, but #include <linux/export.h> is missing
Message-ID: <202506200024.T3O0FWeR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
head:   68d019aa14d97f8d57b0f8d203fd3b44db2ba0c7
commit: fc0e6db30941a66e284b8516b82356f97f31061d [35/47] net: pse-pd: Add support for reporting events
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250620/202506200024.T3O0FWeR-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250620/202506200024.T3O0FWeR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506200024.T3O0FWeR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/bpf/test_run.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/bridge/br_device.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/bridge/br_fdb.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/bridge/br_forward.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/bridge/br_if.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/bridge/br_mst.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/bridge/br_stp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/bridge/br_vlan.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/bridge/netfilter/ebtables.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/caif/caif_dev.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/caif/cfcnfg.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/caif/cfsrvl.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/can/af_can.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ceph/auth.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ceph/buffer.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ceph/ceph_common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ceph/ceph_hash.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ceph/ceph_strings.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ceph/cls_lock_client.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ceph/decode.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ceph/mon_client.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ceph/osd_client.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ceph/osdmap.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ceph/pagelist.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ceph/pagevec.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ceph/string_table.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ceph/striper.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/bpf_sk_storage.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/datagram.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/dev.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/dev_api.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/dev_ioctl.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/devmem.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/dst.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/dst_cache.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/failover.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/fib_notifier.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/fib_rules.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/filter.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/flow_offload.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/gen_estimator.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/gen_stats.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/gro.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/gro_cells.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/gso.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/hotdata.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/hwbm.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/ieee8021q_helpers.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/link_watch.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/lock_debug.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/lwtunnel.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/neighbour.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/netclassid_cgroup.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/netdev-genl.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/netdev_rx_queue.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/page_pool.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/ptp_classifier.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/rtnetlink.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/scm.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/secure_seq.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/selftests.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/skb_fault_injection.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/skbuff.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/skmsg.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/sock.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/sock_diag.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/sock_map.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/sock_reuseport.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/stream.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/sysctl_net_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/utils.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/core/xdp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/dcb/dcbnl.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/devlink/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/devlink/dev.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/devlink/dpipe.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/devlink/health.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/devlink/linecard.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/devlink/param.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/devlink/port.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/devlink/rate.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/devlink/region.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/devlink/resource.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/devlink/sb.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/devlink/trap.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/devres.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/dns_resolver/dns_query.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/dsa/devlink.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/dsa/dsa.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/dsa/port.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/dsa/stubs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/dsa/tag.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/dsa/tag_8021q.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/dsa/user.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ethernet/eth.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ethtool/cabletest.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ethtool/common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ethtool/ioctl.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ethtool/mm.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ethtool/netlink.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
>> net/ethtool/pse-pd.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ethtool/stats.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/handshake/alert.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/handshake/netlink.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/handshake/request.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/handshake/tlshd.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/hsr/hsr_device.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/hsr/hsr_framereg.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/hsr/hsr_main.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ieee802154/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ieee802154/header_ops.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ieee802154/nl802154.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ieee802154/pan.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ife/ife.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/af_inet.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/arp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/datagram.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/devinet.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/esp4.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/fib_frontend.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/fib_semantics.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/fou_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/gre_demux.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/icmp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/igmp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/inet_connection_sock.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/inet_diag.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/inet_fragment.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/inet_hashtables.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/inet_timewait_sock.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/ip_fragment.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/ip_gre.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/ip_input.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/ip_options.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/ip_output.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/ip_sockglue.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/ip_tunnel.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/ip_tunnel_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/ipmr_base.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/metrics.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/netfilter/arp_tables.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/netfilter/ip_tables.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/netfilter/nf_defrag_ipv4.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/netfilter/nf_dup_ipv4.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/netfilter/nf_reject_ipv4.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/netfilter/nf_socket_ipv4.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/netfilter/nf_tproxy_ipv4.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/netfilter/nft_fib_ipv4.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/netlink.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/nexthop.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/protocol.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/route.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/tcp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/tcp_bpf.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/tcp_cong.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/tcp_input.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/tcp_ipv4.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/tcp_minisocks.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/tcp_offload.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/tcp_output.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/tcp_plb.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/tcp_rate.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/tcp_sigpool.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/tcp_ulp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/tcp_vegas.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/tunnel4.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/udp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/udp_bpf.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/udp_offload.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/udp_tunnel_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/udp_tunnel_stub.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/xfrm4_input.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv4/xfrm4_protocol.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/af_inet6.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/esp6.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/icmp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/inet6_connection_sock.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/inet6_hashtables.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/ip6_checksum.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/ip6_fib.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/ip6_input.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/ip6_output.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/ip6_tunnel.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/ip6_udp_tunnel.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/ipv6_sockglue.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/mcast.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/mcast_snoop.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/ndisc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/netfilter/ip6_tables.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/netfilter/nf_conntrack_reasm.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/netfilter/nf_defrag_ipv6_hooks.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/netfilter/nf_dup_ipv6.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/netfilter/nf_reject_ipv6.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/netfilter/nf_socket_ipv6.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/netfilter/nf_tproxy_ipv6.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/netfilter/nft_fib_ipv6.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/ping.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/protocol.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/seg6_hmac.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/seg6_iptunnel.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   net/ipv6/syncookies.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

