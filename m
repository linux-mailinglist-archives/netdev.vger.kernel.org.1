Return-Path: <netdev+bounces-293956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL/LIaU7HmpriAkAu9opvQ
	(envelope-from <netdev+bounces-293956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:10:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14678627198
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D13C305AD3F
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A314B33D6E1;
	Tue,  2 Jun 2026 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nq3Vc5AZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20D34C140
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366221; cv=none; b=j8wS41cWvAQqM6xCPA07oQzVQXVWfNkN5DPhYIbzvxN3PbOxt/gUZo7FUGmri8bMwuMANhCMcfqMggyTu0WedaIVS9+cMtkEbS5OD4B0acg9yp3swhKnlVPovALGinL8rAoFBW4tWBTVf6LU5PmyTBoaJcOk/xs6ih6dQkYKJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366221; c=relaxed/simple;
	bh=y7Xd42BcknrLJfoPP64g2rAK+lYNayuuuDtn7l3IJAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+7W32HWVswJ5uqFOSmXQOwzAIcezQ/x4JS12qa+tEaFzePyTFaT2CVmH61Ip7pGgaOXJnO25Q3sowvqMUwMmkQXojXu/VVr0XIzuz1KQjCUGg/Q4ZHecD8kdSdBHflQb+fBq2+dyh7TRw6PE33oa8YyZZk3cEHKvGQioJqdFro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nq3Vc5AZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780366219; x=1811902219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y7Xd42BcknrLJfoPP64g2rAK+lYNayuuuDtn7l3IJAQ=;
  b=Nq3Vc5AZYYkSZRHSvAbpfMpIZE+oWTxmMCY9q0WYVhcbGFu7RAAfq5gv
   AASKPzVhRiy3tDO2QbDvnXtWAY7jFW9Up6/z4DlQbVjE92g/M5Rj+i97D
   UBydqqqpTi/ZFCjKV24ISriTDAeoXJOCyQowh6V6y1oHAoeEawa9x4POx
   n+q4Te2QklmT2QuiuRr5AdSFrBApHYkIOvJI/fU0AEn+4B0GBAQqZ8z4g
   /wi+ll73SxT7A2d1czrIfP5skMs0L+kCgsoyiWTah1pee8Pxk1+TpRqL8
   ioH74Qp7awHlWi67D1f/21Fzn3M+4AhxwuKKt/D0ylVYsB+dboLptYssz
   A==;
X-CSE-ConnectionGUID: LQNFCGYcT0uMKDKssAkZHA==
X-CSE-MsgGUID: RVh39GdrQ0KoVPgEyZOXJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="91709513"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="91709513"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 19:10:18 -0700
X-CSE-ConnectionGUID: bJcqv7MzQa+o128oLimDug==
X-CSE-MsgGUID: jdiXheh/TvW9ljwlcUxbGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="281865857"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 01 Jun 2026 19:10:15 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUEa4-00000000BMY-1J86;
	Tue, 02 Jun 2026 02:10:12 +0000
Date: Tue, 2 Jun 2026 10:09:14 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] mptcp: change mptcp_established_options() to
 return opt_size
Message-ID: <202606021033.Gt2vODEq-lkp@intel.com>
References: <20260601091816.444738-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601091816.444738-1-edumazet@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-293956-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,01.org:url]
X-Rspamd-Queue-Id: 14678627198
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/mptcp-change-mptcp_established_options-to-return-opt_size/20260601-174435
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260601091816.444738-1-edumazet%40google.com
patch subject: [PATCH net-next] mptcp: change mptcp_established_options() to return opt_size
config: i386-randconfig-007-20260602 (https://download.01.org/0day-ci/archive/20260602/202606021033.Gt2vODEq-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260602/202606021033.Gt2vODEq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606021033.Gt2vODEq-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv4/tcp_output.c: In function 'tcp_established_options':
>> net/ipv4/tcp_output.c:1186:63: error: passing argument 3 of 'mptcp_established_options' makes pointer from integer without a cast [-Wint-conversion]
    1186 |                 opt_size = mptcp_established_options(sk, skb, remaining,
         |                                                               ^~~~~~~~~
         |                                                               |
         |                                                               unsigned int
   In file included from include/net/tcp.h:44,
                    from net/ipv4/tcp_output.c:40:
   include/net/mptcp.h:271:59: note: expected 'unsigned int *' but argument is of type 'unsigned int'
     271 |                                             unsigned int *size,
         |                                             ~~~~~~~~~~~~~~^~~~
>> net/ipv4/tcp_output.c:1187:54: error: passing argument 4 of 'mptcp_established_options' makes integer from pointer without a cast [-Wint-conversion]
    1187 |                                                      &opts->mptcp);
         |                                                      ^~~~~~~~~~~~
         |                                                      |
         |                                                      struct mptcp_out_options *
   include/net/mptcp.h:272:58: note: expected 'unsigned int' but argument is of type 'struct mptcp_out_options *'
     272 |                                             unsigned int remaining,
         |                                             ~~~~~~~~~~~~~^~~~~~~~~
>> net/ipv4/tcp_output.c:1186:28: error: too few arguments to function 'mptcp_established_options'
    1186 |                 opt_size = mptcp_established_options(sk, skb, remaining,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/mptcp.h:269:19: note: declared here
     269 | static inline int mptcp_established_options(struct sock *sk,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/mptcp_established_options +1186 net/ipv4/tcp_output.c

  1145	
  1146	/* Compute TCP options for ESTABLISHED sockets. This is not the
  1147	 * final wire format yet.
  1148	 */
  1149	static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb,
  1150						struct tcp_out_options *opts,
  1151						struct tcp_key *key)
  1152	{
  1153		struct tcp_sock *tp = tcp_sk(sk);
  1154		unsigned int size = 0;
  1155		unsigned int eff_sacks;
  1156	
  1157		opts->options = 0;
  1158	
  1159		/* Better than switch (key.type) as it has static branches */
  1160		if (tcp_key_is_md5(key)) {
  1161			opts->options |= OPTION_MD5;
  1162			size += TCPOLEN_MD5SIG_ALIGNED;
  1163		} else if (tcp_key_is_ao(key)) {
  1164			opts->options |= OPTION_AO;
  1165			size += tcp_ao_len_aligned(key->ao_key);
  1166		}
  1167	
  1168		if (likely(tp->rx_opt.tstamp_ok)) {
  1169			opts->options |= OPTION_TS;
  1170			opts->tsval = skb ? tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb) +
  1171					tp->tsoffset : 0;
  1172			opts->tsecr = tp->rx_opt.ts_recent;
  1173			size += TCPOLEN_TSTAMP_ALIGNED;
  1174		}
  1175	
  1176		/* MPTCP options have precedence over SACK for the limited TCP
  1177		 * option space because a MPTCP connection would be forced to
  1178		 * fall back to regular TCP if a required multipath option is
  1179		 * missing. SACK still gets a chance to use whatever space is
  1180		 * left.
  1181		 */
  1182		if (sk_is_mptcp(sk)) {
  1183			unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
  1184			int opt_size;
  1185	
> 1186			opt_size = mptcp_established_options(sk, skb, remaining,
> 1187							     &opts->mptcp);
  1188			if (opt_size >= 0) {
  1189				opts->options |= OPTION_MPTCP;
  1190				size += opt_size;
  1191			}
  1192		}
  1193	
  1194		eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
  1195		if (unlikely(eff_sacks)) {
  1196			const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
  1197			if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
  1198						TCPOLEN_SACK_PERBLOCK)) {
  1199				opts->num_sack_blocks =
  1200					min_t(unsigned int, eff_sacks,
  1201					      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
  1202					      TCPOLEN_SACK_PERBLOCK);
  1203	
  1204				size += TCPOLEN_SACK_BASE_ALIGNED +
  1205					opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
  1206			} else {
  1207				opts->num_sack_blocks = 0;
  1208			}
  1209		} else {
  1210			opts->num_sack_blocks = 0;
  1211		}
  1212	
  1213		if (tcp_ecn_mode_accecn(tp)) {
  1214			int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
  1215	
  1216			if (ecn_opt && tp->saw_accecn_opt &&
  1217			    (ecn_opt >= TCP_ACCECN_OPTION_PERSIST ||
  1218			     !tcp_accecn_opt_fail_send(tp)) &&
  1219			    (ecn_opt >= TCP_ACCECN_OPTION_FULL || tp->accecn_opt_demand ||
  1220			     tcp_accecn_option_beacon_check(sk))) {
  1221				opts->use_synack_ecn_bytes = 0;
  1222				size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
  1223							       MAX_TCP_OPTION_SPACE - size);
  1224			}
  1225		}
  1226	
  1227		if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
  1228						    BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))) {
  1229			unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
  1230	
  1231			bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts, &remaining);
  1232	
  1233			size = MAX_TCP_OPTION_SPACE - remaining;
  1234		}
  1235	
  1236		return size;
  1237	}
  1238	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

