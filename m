Return-Path: <netdev+bounces-138739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF6C9AEB1A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D69282BAD
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6A01E9096;
	Thu, 24 Oct 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VauM04US"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2651DE4F7;
	Thu, 24 Oct 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785191; cv=none; b=aU5DEDKmU9r+U6FZCP9TXYrDgMWPDH9/g7IDyWuZ5xOZZ7D9esS5es9rSBQ9gCX1idjeWYO8/5CYt58oUzlRyjJS7cLKwmsuI+0LKxdEosl8Ln78+AdwpbnNYeC1pB1FX2y+0mYIkqesx8j2c8F8V3d+mTBdnlN2hKfHZaIKJcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785191; c=relaxed/simple;
	bh=2qnd2i2UONcjZVkzIcTSxS7pJORJ7ofkM+P7wpTWR88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHvi1gP+Wdj1LcgXIGTbg9H0FWxLc9kMHJZuSqn48MJqJ6aZbrf2AwdCVyujILo66pxyHmUa2M+jLQMPQv3JUG9NagKMUuOq7gcp0XXZzjX4BBtZ71n1/I5/jylv5vsKXhNdG9Pdx1sBeRgr7Jkhec2XrakCIDLKvOfPebuux6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VauM04US; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729785188; x=1761321188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2qnd2i2UONcjZVkzIcTSxS7pJORJ7ofkM+P7wpTWR88=;
  b=VauM04USf7Z99vrrqkdTMPEI4kPPLEchHn/QNqjUB9HFnhhzQYX0XXPw
   StSvx/ao8G1qlVZ0+uN6kEYTJtiBmiEkgbCrfLnReTOoFNPiPCrkHi8E3
   CClyjsgK/R0udlJKSRH+tWebZXiRDU3jdFzApoGFfhuETp9XGvzT2Voeh
   nWkqCP9K/eH+FtfY6lwV0+lxYFuYym96wLS3rUs/BujflDfu5JWLuh7+Q
   ABL7P3HqEvQXtXm6c6Pn1gGlx+NHIpsh+Cw7cN5si6rmQHhZvYo7xpU8B
   CPArfdEhnp90ceHjpDo+ZziJxf1Ccrp7hr3RTBgEm/zJKNM3AKQxwA0yn
   w==;
X-CSE-ConnectionGUID: /Dv/OAaeQ5qwOYERp5IUOw==
X-CSE-MsgGUID: 4xro7paDRKWfxMARYBwH9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="33329777"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="33329777"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 08:53:08 -0700
X-CSE-ConnectionGUID: tcjiEK13RmWtiqkxiu2aew==
X-CSE-MsgGUID: VGYhRvXaRAeqcW9zowBLGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="85243352"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Oct 2024 08:53:02 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t408y-000Wck-10;
	Thu, 24 Oct 2024 15:53:00 +0000
Date: Thu, 24 Oct 2024 23:52:38 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	andrew@lunn.ch, Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	horatiu.vultur@microchip.com,
	jensemil.schulzostergaard@microchip.com,
	Parthiban.Veerasooran@microchip.com, Raju.Lakkaraju@microchip.com,
	UNGLinuxDriver@microchip.com,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, jacob.e.keller@intel.com,
	ast@fiberby.net, maxime.chevallier@bootlin.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 06/15] net: lan969x: add match data for lan969x
Message-ID: <202410242319.ShJiPqSp-lkp@intel.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-6-c8c49ef21e0f@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-6-c8c49ef21e0f@microchip.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on 30d9d8f6a2d7e44a9f91737dd409dbc87ac6f6b7]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Machon/net-sparx5-add-support-for-lan969x-SKU-s-and-core-clock/20241021-220557
base:   30d9d8f6a2d7e44a9f91737dd409dbc87ac6f6b7
patch link:    https://lore.kernel.org/r/20241021-sparx5-lan969x-switch-driver-2-v1-6-c8c49ef21e0f%40microchip.com
patch subject: [PATCH net-next 06/15] net: lan969x: add match data for lan969x
config: m68k-randconfig-r121-20241024 (https://download.01.org/0day-ci/archive/20241024/202410242319.ShJiPqSp-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241024/202410242319.ShJiPqSp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410242319.ShJiPqSp-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.o: in function `sparx5_vcap_init':
>> sparx5_vcap_impl.c:(.text+0x4632): undefined reference to `vcap_port_debugfs'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.o: in function `sparx5_vcap_destroy':
>> sparx5_vcap_impl.c:(.text+0x4d24): undefined reference to `vcap_del_rules'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.o: in function `sparx5_vcap_es2_get_port_ipv4_keysets':
>> sparx5_vcap_impl.c:(.text+0x38): undefined reference to `vcap_keyset_list_add'
>> m68k-linux-ld: sparx5_vcap_impl.c:(.text+0x50): undefined reference to `vcap_keyset_list_add'
   m68k-linux-ld: sparx5_vcap_impl.c:(.text+0x68): undefined reference to `vcap_keyset_list_add'
   m68k-linux-ld: sparx5_vcap_impl.c:(.text+0x80): undefined reference to `vcap_keyset_list_add'
   m68k-linux-ld: sparx5_vcap_impl.c:(.text+0x98): undefined reference to `vcap_keyset_list_add'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.o: in function `sparx5_vcap_ingress_add_default_fields':
>> sparx5_vcap_impl.c:(.text+0x114): undefined reference to `vcap_lookup_keyfield'
>> m68k-linux-ld: sparx5_vcap_impl.c:(.text+0x142): undefined reference to `vcap_rule_add_key_u32'
>> m68k-linux-ld: sparx5_vcap_impl.c:(.text+0x1a6): undefined reference to `vcap_rule_add_key_bit'
   m68k-linux-ld: sparx5_vcap_impl.c:(.text+0x1d2): undefined reference to `vcap_rule_add_key_bit'
   m68k-linux-ld: sparx5_vcap_impl.c:(.text+0x21e): undefined reference to `vcap_rule_add_key_bit'
>> m68k-linux-ld: sparx5_vcap_impl.c:(.text+0x268): undefined reference to `vcap_rule_add_key_u72'
>> m68k-linux-ld: sparx5_vcap_impl.c:(.text+0x288): undefined reference to `vcap_keyset_name'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.o: in function `sparx5_vcap_add_default_fields':
>> sparx5_vcap_impl.c:(.text+0x31e): undefined reference to `vcap_rule_add_key_u32'
>> m68k-linux-ld: sparx5_vcap_impl.c:(.text+0x358): undefined reference to `vcap_lookup_keyfield'
   m68k-linux-ld: sparx5_vcap_impl.c:(.text+0x368): undefined reference to `vcap_rule_add_key_u32'
   m68k-linux-ld: sparx5_vcap_impl.c:(.text+0x3b6): undefined reference to `vcap_rule_add_key_bit'
   m68k-linux-ld: sparx5_vcap_impl.c:(.text+0x3d4): undefined reference to `vcap_rule_add_key_bit'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.o: in function `sparx5_vcap_es0_get_port_keysets.isra.0':
   sparx5_vcap_impl.c:(.text+0x704): undefined reference to `vcap_keyset_list_add'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.o: in function `sparx5_vcap_es2_get_port_keysets.isra.0':
   sparx5_vcap_impl.c:(.text+0xadc): undefined reference to `vcap_keyset_list_add'
   m68k-linux-ld: sparx5_vcap_impl.c:(.text+0xb3c): undefined reference to `vcap_keyset_list_add'
   m68k-linux-ld: sparx5_vcap_impl.c:(.text+0xb98): undefined reference to `vcap_keyset_list_add'
   m68k-linux-ld: sparx5_vcap_impl.c:(.text+0xbc2): undefined reference to `vcap_keyset_list_add'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.o:sparx5_vcap_impl.c:(.text+0xc42): more undefined references to `vcap_keyset_list_add' follow
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.o: in function `sparx5_vcap_validate_keyset':
>> sparx5_vcap_impl.c:(.text+0x214e): undefined reference to `vcap_keyset_name'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.o: in function `sparx5_vcap_init':
>> sparx5_vcap_impl.c:(.text+0x464a): undefined reference to `vcap_debugfs'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_select_protocol_keyset':
>> sparx5_tc_flower.c:(.text+0x2b8): undefined reference to `vcap_keyfieldset'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_flower_replace':
>> sparx5_tc_flower.c:(.text+0x1c58): undefined reference to `vcap_rule_add_action_u32'
>> m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1ffc): undefined reference to `vcap_rule_add_action_u32'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_flower_handler_basic_usage':
>> sparx5_tc_flower.c:(.text+0x5a): undefined reference to `vcap_rule_add_key_u32'
>> m68k-linux-ld: sparx5_tc_flower.c:(.text+0xd2): undefined reference to `vcap_rule_add_key_u32'
>> m68k-linux-ld: sparx5_tc_flower.c:(.text+0x11e): undefined reference to `vcap_rule_add_key_bit'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x168): undefined reference to `vcap_rule_add_key_bit'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x190): undefined reference to `vcap_rule_add_key_bit'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1b4): undefined reference to `vcap_rule_add_key_bit'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_select_protocol_keyset':
>> sparx5_tc_flower.c:(.text+0x264): undefined reference to `vcap_rule_find_keysets'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x3ca): undefined reference to `vcap_set_rule_set_keyset'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x402): undefined reference to `vcap_rule_mod_key_u32'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_flower_handler_vlan_usage':
   sparx5_tc_flower.c:(.text+0x476): undefined reference to `vcap_tc_flower_handler_vlan_usage'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x4ec): undefined reference to `vcap_rule_add_key_u32'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x50e): undefined reference to `vcap_rule_add_key_u32'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_flower_handler_control_usage':
   sparx5_tc_flower.c:(.text+0x5a2): undefined reference to `vcap_rule_add_key_u32'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_flower_handler_cvlan_usage':
   sparx5_tc_flower.c:(.text+0x842): undefined reference to `vcap_tc_flower_handler_cvlan_usage'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_flower_destroy.isra.0':
   sparx5_tc_flower.c:(.text+0x8a6): undefined reference to `vcap_lookup_rule_by_cookie'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x8c0): undefined reference to `vcap_get_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x8da): undefined reference to `vcap_find_actionfield'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x94c): undefined reference to `vcap_free_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x95a): undefined reference to `vcap_del_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xa4a): undefined reference to `vcap_del_rule'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_flower_simplify_rule.isra.0':
   sparx5_tc_flower.c:(.text+0xace): undefined reference to `vcap_rule_rem_key'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xb0e): undefined reference to `vcap_rule_rem_key'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xb2a): undefined reference to `vcap_rule_rem_key'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xb68): undefined reference to `vcap_rule_rem_key'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_action_vlan_modify.isra.0':
   sparx5_tc_flower.c:(.text+0xbb8): undefined reference to `vcap_rule_add_action_u32'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_add_rule_link.isra.0':
   sparx5_tc_flower.c:(.text+0xce2): undefined reference to `vcap_find_admin'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xcfa): undefined reference to `vcap_chain_offset'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xd5a): undefined reference to `vcap_rule_add_action_u32'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xd74): undefined reference to `vcap_rule_add_action_bit'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xd92): undefined reference to `vcap_rule_add_action_u32'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xdc8): undefined reference to `vcap_rule_add_action_u32'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_set_actionset.isra.0':
   sparx5_tc_flower.c:(.text+0xe4e): undefined reference to `vcap_set_rule_set_actionset'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_add_rule_counter.isra.0':
   sparx5_tc_flower.c:(.text+0xeba): undefined reference to `vcap_rule_mod_action_u32'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xed2): undefined reference to `vcap_rule_set_counter_id'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xef6): undefined reference to `vcap_rule_mod_action_u32'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_add_rule_copy':
   sparx5_tc_flower.c:(.text+0xf64): undefined reference to `vcap_copy_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xf96): undefined reference to `vcap_filter_rule_keys'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xfa2): undefined reference to `vcap_set_rule_set_keyset'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xfc8): undefined reference to `vcap_rule_mod_key_u32'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xfd4): undefined reference to `vcap_set_rule_set_actionset'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0xfe6): undefined reference to `vcap_free_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1016): undefined reference to `vcap_val_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1026): undefined reference to `vcap_add_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1054): undefined reference to `vcap_free_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x106a): undefined reference to `vcap_keyset_name'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1090): undefined reference to `vcap_free_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x10bc): undefined reference to `vcap_set_tc_exterr'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x10c8): undefined reference to `vcap_free_rule'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_flower_action_check.isra.0':
   sparx5_tc_flower.c:(.text+0x122c): undefined reference to `vcap_is_last_chain'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x12fc): undefined reference to `vcap_is_next_lookup'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_flower_template_create':
   sparx5_tc_flower.c:(.text+0x14f0): undefined reference to `vcap_admin_rule_count'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1570): undefined reference to `vcap_alloc_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x15cc): undefined reference to `vcap_rule_find_keysets'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x15e4): undefined reference to `vcap_select_min_rule_keyset'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1648): undefined reference to `vcap_free_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x169c): undefined reference to `vcap_free_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1736): undefined reference to `vcap_free_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1766): undefined reference to `vcap_free_rule'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_flower_replace':
   sparx5_tc_flower.c:(.text+0x183c): undefined reference to `vcap_alloc_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1890): undefined reference to `vcap_free_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x18da): undefined reference to `vcap_rule_add_key_u32'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x18ec): undefined reference to `vcap_free_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1990): undefined reference to `vcap_free_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x19a8): undefined reference to `vcap_rule_add_key_u32'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1ad8): undefined reference to `vcap_rule_add_action_bit'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1af4): undefined reference to `vcap_rule_add_action_u32'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1b56): undefined reference to `vcap_val_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1b68): undefined reference to `vcap_add_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1bb8): undefined reference to `vcap_free_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1bf2): undefined reference to `vcap_rule_add_action_u32'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1cbc): undefined reference to `vcap_rule_add_action_u32'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1cf6): undefined reference to `vcap_rule_add_action_u72'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1ee4): undefined reference to `vcap_free_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1f32): undefined reference to `vcap_free_rule'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1f94): undefined reference to `vcap_rule_add_key_u32'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1fcc): undefined reference to `vcap_rule_add_action_u32'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x1fea): undefined reference to `vcap_rule_add_action_bit'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x203c): undefined reference to `vcap_rule_add_action_bit'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x2054): undefined reference to `vcap_rule_add_action_u32'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x2092): undefined reference to `vcap_set_rule_set_keyset'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x2110): undefined reference to `vcap_set_tc_exterr'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x211a): undefined reference to `vcap_free_rule'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o: in function `sparx5_tc_flower':
   sparx5_tc_flower.c:(.text+0x224e): undefined reference to `vcap_find_admin'
   m68k-linux-ld: sparx5_tc_flower.c:(.text+0x2378): undefined reference to `vcap_get_rule_count_by_cookie'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o:(.rodata+0x986): undefined reference to `vcap_tc_flower_handler_ipv4_usage'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o:(.rodata+0x98a): undefined reference to `vcap_tc_flower_handler_ipv6_usage'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o:(.rodata+0x98e): undefined reference to `vcap_tc_flower_handler_portnum_usage'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o:(.rodata+0x99a): undefined reference to `vcap_tc_flower_handler_ethaddr_usage'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o:(.rodata+0x9a2): undefined reference to `vcap_tc_flower_handler_arp_usage'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o:(.rodata+0x9ce): undefined reference to `vcap_tc_flower_handler_tcp_usage'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.o:(.rodata+0x9d2): undefined reference to `vcap_tc_flower_handler_ip_usage'
   m68k-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.o: in function `sparx5_tc_matchall_replace':
   sparx5_tc_matchall.c:(.text+0x13e): undefined reference to `vcap_enable_lookups'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SPARX5_SWITCH
   Depends on [n]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && NET_SWITCHDEV [=y] && HAS_IOMEM [=y] && OF [=n] && (ARCH_SPARX5 || COMPILE_TEST [=y]) && PTP_1588_CLOCK_OPTIONAL [=y] && (BRIDGE [=y] || BRIDGE [=y]=n [=n])
   Selected by [y]:
   - LAN969X_SWITCH [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

