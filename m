Return-Path: <netdev+bounces-307654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MFBdLjYGV2qfEQEAu9opvQ
	(envelope-from <netdev+bounces-307654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 06:01:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 338C675A65E
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 06:01:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=n926Dhed;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307654-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307654-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37E25301DC27
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 04:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A03280338;
	Wed, 15 Jul 2026 04:01:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684113777E;
	Wed, 15 Jul 2026 04:01:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784088115; cv=none; b=hfeGsNvm0d3AulH0LBJ6dPKwZg1w7HGh8hA/6+TN+6sXD77AjxvwEJ+Cax3XNDp2kSssGuyOE3OL9rYYJ6T348hpTM15NKmlHXQDn1CyHR89qzug3sjiJ4ZSPkZG2Omv8nns01AuRnNU8Tsv1PC3XNxrddpL4cq9CNEAiNYD+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784088115; c=relaxed/simple;
	bh=5AJJsRpyYtSZqjnFUuo1zsAdOCizExAAGxBDIeEJrpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpzYMsFQjM2HXEx9en3a3GKVEwvw8LJTLRQ95e8vk3oHpKa9ZI5skqw6W09854GTP2gagAt4I8P/7kUsHWJljGZod72QOyArilqiNPQkRWLazRmxbF8kdtUvVbeNhseEhm0B9vl91oPErCH6LL4A4USvJVSDqjJjwFUj0XJ1wbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n926Dhed; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784088114; x=1815624114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5AJJsRpyYtSZqjnFUuo1zsAdOCizExAAGxBDIeEJrpI=;
  b=n926DhedXX5qhZ8+BhU3TmnipIcmE9CA5jPv2wcnDNO1W+evFh4Zjmdb
   I2nunIjfud39sDPbKaLaQROPCE61NVqDXca953N7QMlwp3XXqest2ujaE
   m6b3PbawrcqloRKtSqGFeTW8VS746b9jylkgNBNKXYqTpstmNcd6Ah0U+
   QzZVInnIRyyHRYG8xOmzKrDSqn/TwV7jtDZM/61thZIuNfADPRryoU2nK
   Yzs7ZmCcDxXWOPbR9RCgk7plxoXoI8OlWkqgLPciwgpCdDkHbNfZF44rE
   H0pUCSc8OmEl3SIt6hcwFjstewH083DTvX+N6jje8tzcf803WjXZeBZzM
   A==;
X-CSE-ConnectionGUID: KiMik+5WRWKVhrVO0pY/NA==
X-CSE-MsgGUID: LLFH9+e7TuafV5scorIgsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84913229"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84913229"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 21:01:54 -0700
X-CSE-ConnectionGUID: 4QNuT6xvQdSRRrDVzfZ4+Q==
X-CSE-MsgGUID: xSjqqebhSBqCberCRx3fBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="286121459"
Received: from igk-lkp-server01.igk.intel.com (HELO e5a8ed462067) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 14 Jul 2026 21:01:51 -0700
Received: from kbuild by e5a8ed462067 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wjqof-0000000049t-02ZM;
	Wed, 15 Jul 2026 04:01:49 +0000
Date: Wed, 15 Jul 2026 06:00:48 +0200
From: kernel test robot <lkp@intel.com>
To: Weiming Shi <bestswngs@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Tung Nguyen <tung.quang.nguyen@est.tech>, xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH net v5] tipc: serialize udp bearer replicast list updates
Message-ID: <202607150523.48dOIqUE-lkp@intel.com>
References: <20260714192140.1810202-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714192140.1810202-1-bestswngs@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:oe-kbuild-all@lists.linux.dev,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:tung.quang.nguyen@est.tech,m:xmei5@asu.edu,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307654-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,davemloft.net,google.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,lists.sourceforge.net,est.tech,asu.edu,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:mid,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 338C675A65E

Hi Weiming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Weiming-Shi/tipc-serialize-udp-bearer-replicast-list-updates/20260715-033047
base:   net/main
patch link:    https://lore.kernel.org/r/20260714192140.1810202-1-bestswngs%40gmail.com
patch subject: [PATCH net v5] tipc: serialize udp bearer replicast list updates
config: x86_64-rhel-9.4-bpf (https://download.01.org/0day-ci/archive/20260715/202607150523.48dOIqUE-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260715/202607150523.48dOIqUE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607150523.48dOIqUE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: net/tipc/udp_media.c:106 struct member 'disabled' not described in 'udp_bearer'
>> Warning: net/tipc/udp_media.c:106 struct member 'disabled' not described in 'udp_bearer'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

