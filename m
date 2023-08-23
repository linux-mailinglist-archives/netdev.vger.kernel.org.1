Return-Path: <netdev+bounces-30031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1853785B15
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA061C20B96
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E604BC2C7;
	Wed, 23 Aug 2023 14:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC2BA3B
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:50:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAF5E69
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692802213; x=1724338213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EyWNtPcXwUUX8H+6bBWM7FE00K956XHV5T2ZmK9CicY=;
  b=k7RyITV6fAhgw/IRPI3jQjnKoJvfZkm9acP8sikHei6onVc5nRE+fmVx
   QQ0BbXWt0aFwFW4Jsq3bCJ8jwipkSnexGeqGUsbVgYP0d10dSuEeo+z9Z
   iPe2XDazyLDfTKZWT5QN7iz0T7n622JrSITWZT6iootglq1UNzn5DatV0
   Lbli7hSPhN2Herv3RIN3tokm83s9yqxmzHTg6xB0H/jdmlvJp1kTp12Cd
   VXRXtlCd/JneSmsycEaKulWFlsn279jiy+SSX33AniRvY0MrTyNQPY4WD
   6t768FnrOsW7vELsU8+vU/C7IE2pxPdjRy0+hOUVh2sH8HS/yqvFtpgmm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="373066848"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="373066848"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 07:50:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="736702197"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="736702197"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 23 Aug 2023 07:50:09 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qYpBQ-0001IP-1a;
	Wed, 23 Aug 2023 14:50:08 +0000
Date: Wed, 23 Aug 2023 22:49:44 +0800
From: kernel test robot <lkp@intel.com>
To: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	netdev@vger.kernel.org, linux-net-drivers@amd.com
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, ecree.xilinx@gmail.com,
	habetsm.xilinx@gmail.com,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH net-next 3/6] sfc: add decrement ttl by offloading set
 ipv4 ttl actions
Message-ID: <202308232237.WkCLb0PW-lkp@intel.com>
References: <20230823111725.28090-4-pieter.jansen-van-vuuren@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823111725.28090-4-pieter.jansen-van-vuuren@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Pieter,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Pieter-Jansen-van-Vuuren/sfc-introduce-ethernet-pedit-set-action-infrastructure/20230823-192051
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230823111725.28090-4-pieter.jansen-van-vuuren%40amd.com
patch subject: [PATCH net-next 3/6] sfc: add decrement ttl by offloading set ipv4 ttl actions
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230823/202308232237.WkCLb0PW-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308232237.WkCLb0PW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308232237.WkCLb0PW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/sfc/tc.c:1074: warning: Function parameter or member 'match' not described in 'efx_tc_mangle'


vim +1074 drivers/net/ethernet/sfc/tc.c

12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1054  
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1055  /**
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1056   * efx_tc_mangle() - handle a single 32-bit (or less) pedit
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1057   * @efx: NIC we're installing a flow rule on
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1058   * @act: action set (cursor) to update
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1059   * @fa:          FLOW_ACTION_MANGLE action metadata
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1060   * @mung:        accumulator for partial mangles
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1061   * @extack:      netlink extended ack for reporting errors
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1062   *
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1063   * Identify the fields written by a FLOW_ACTION_MANGLE, and record
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1064   * the partial mangle state in @mung.  If this mangle completes an
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1065   * earlier partial mangle, consume and apply to @act by calling
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1066   * efx_tc_complete_mac_mangle().
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1067   */
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1068  
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1069  static int efx_tc_mangle(struct efx_nic *efx, struct efx_tc_action_set *act,
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1070  			 const struct flow_action_entry *fa,
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1071  			 struct efx_tc_mangler_state *mung,
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1072  			 struct netlink_ext_ack *extack,
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1073  			 struct efx_tc_match *match)
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23 @1074  {
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1075  	__le32 mac32;
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1076  	__le16 mac16;
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1077  	u8 tr_ttl;
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1078  
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1079  	switch (fa->mangle.htype) {
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1080  	case FLOW_ACT_MANGLE_HDR_TYPE_ETH:
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1081  		BUILD_BUG_ON(offsetof(struct ethhdr, h_dest) != 0);
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1082  		BUILD_BUG_ON(offsetof(struct ethhdr, h_source) != 6);
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1083  		if (!efx_tc_flower_action_order_ok(act, EFX_TC_AO_PEDIT_MAC_ADDRS)) {
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1084  			NL_SET_ERR_MSG_MOD(extack,
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1085  					   "Pedit mangle mac action violates action order");
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1086  			return -EOPNOTSUPP;
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1087  		}
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1088  		switch (fa->mangle.offset) {
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1089  		case 0:
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1090  			if (fa->mangle.mask) {
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1091  				NL_SET_ERR_MSG_FMT_MOD(extack,
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1092  						       "Unsupported: mask (%#x) of eth.dst32 mangle",
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1093  						       fa->mangle.mask);
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1094  				return -EOPNOTSUPP;
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1095  			}
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1096  			/* Ethernet address is little-endian */
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1097  			mac32 = cpu_to_le32(fa->mangle.val);
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1098  			memcpy(mung->dst_mac, &mac32, sizeof(mac32));
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1099  			mung->dst_mac_32 = 1;
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1100  			return efx_tc_complete_mac_mangle(efx, act, mung, extack);
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1101  		case 4:
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1102  			if (fa->mangle.mask == 0xffff) {
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1103  				mac16 = cpu_to_le16(fa->mangle.val >> 16);
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1104  				memcpy(mung->src_mac, &mac16, sizeof(mac16));
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1105  				mung->src_mac_16 = 1;
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1106  			} else if (fa->mangle.mask == 0xffff0000) {
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1107  				mac16 = cpu_to_le16((u16)fa->mangle.val);
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1108  				memcpy(mung->dst_mac + 4, &mac16, sizeof(mac16));
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1109  				mung->dst_mac_16 = 1;
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1110  			} else {
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1111  				NL_SET_ERR_MSG_FMT_MOD(extack,
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1112  						       "Unsupported: mask (%#x) of eth+4 mangle is not high or low 16b",
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1113  						       fa->mangle.mask);
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1114  				return -EOPNOTSUPP;
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1115  			}
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1116  			return efx_tc_complete_mac_mangle(efx, act, mung, extack);
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1117  		case 8:
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1118  			if (fa->mangle.mask) {
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1119  				NL_SET_ERR_MSG_FMT_MOD(extack,
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1120  						       "Unsupported: mask (%#x) of eth.src32 mangle",
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1121  						       fa->mangle.mask);
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1122  				return -EOPNOTSUPP;
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1123  			}
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1124  			mac32 = cpu_to_le32(fa->mangle.val);
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1125  			memcpy(mung->src_mac + 2, &mac32, sizeof(mac32));
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1126  			mung->src_mac_32 = 1;
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1127  			return efx_tc_complete_mac_mangle(efx, act, mung, extack);
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1128  		default:
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1129  			NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported: mangle eth+%u %x/%x",
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1130  					       fa->mangle.offset, fa->mangle.val, fa->mangle.mask);
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1131  			return -EOPNOTSUPP;
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1132  		}
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1133  		break;
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1134  	case FLOW_ACT_MANGLE_HDR_TYPE_IP4:
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1135  		switch (fa->mangle.offset) {
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1136  		case offsetof(struct iphdr, ttl):
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1137  			/* we currently only support pedit IP4 when it applies
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1138  			 * to TTL and then only when it can be achieved with a
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1139  			 * decrement ttl action
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1140  			 */
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1141  
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1142  			/* check that pedit applies to ttl only */
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1143  			if (fa->mangle.mask != ~EFX_TC_HDR_TYPE_TTL_MASK) {
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1144  				NL_SET_ERR_MSG_FMT_MOD(extack,
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1145  						       "Unsupported: mask (%#x) out of range, only support mangle action on ipv4.ttl",
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1146  						       fa->mangle.mask);
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1147  				return -EOPNOTSUPP;
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1148  			}
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1149  
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1150  			/* we can only convert to a dec ttl when we have an
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1151  			 * exact match on the ttl field
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1152  			 */
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1153  			if (match->mask.ip_ttl != U8_MAX) {
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1154  				NL_SET_ERR_MSG_FMT_MOD(extack,
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1155  						       "Unsupported: only support mangle ipv4.ttl when we have an exact match on ttl, mask used for match (%#x)",
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1156  						       match->mask.ip_ttl);
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1157  				return -EOPNOTSUPP;
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1158  			}
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1159  
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1160  			/* check that we don't try to decrement 0, which equates
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1161  			 * to setting the ttl to 0xff
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1162  			 */
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1163  			if (match->value.ip_ttl == 0) {
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1164  				NL_SET_ERR_MSG_MOD(extack,
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1165  						   "Unsupported: we cannot decrement ttl past 0");
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1166  				return -EOPNOTSUPP;
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1167  			}
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1168  
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1169  			/* check that we do not decrement ttl twice */
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1170  			if (!efx_tc_flower_action_order_ok(act,
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1171  							   EFX_TC_AO_DEC_TTL)) {
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1172  				NL_SET_ERR_MSG_MOD(extack,
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1173  						   "Unsupported: multiple dec ttl");
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1174  				return -EOPNOTSUPP;
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1175  			}
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1176  
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1177  			/* check pedit can be achieved with decrement action */
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1178  			tr_ttl = match->value.ip_ttl - 1;
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1179  			if ((fa->mangle.val & EFX_TC_HDR_TYPE_TTL_MASK) == tr_ttl) {
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1180  				act->do_ttl_dec = 1;
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1181  				return 0;
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1182  			}
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1183  
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1184  			fallthrough;
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1185  		default:
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1186  			NL_SET_ERR_MSG_FMT_MOD(extack,
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1187  					       "Unsupported: only support mangle on the ttl field (offset is %u)",
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1188  					       fa->mangle.offset);
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1189  			return -EOPNOTSUPP;
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1190  		}
b1a793d7986335 Pieter Jansen van Vuuren 2023-08-23  1191  		break;
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1192  	default:
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1193  		NL_SET_ERR_MSG_FMT_MOD(extack, "Unhandled mangle htype %u for action rule",
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1194  				       fa->mangle.htype);
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1195  		return -EOPNOTSUPP;
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1196  	}
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1197  	return 0;
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1198  }
12322dfaf48dc2 Pieter Jansen van Vuuren 2023-08-23  1199  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

