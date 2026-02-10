Return-Path: <netdev+bounces-258159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLWfMLCUi2l3WQAAu9opvQ
	(envelope-from <netdev+bounces-258159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 21:27:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CDE11F055
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 21:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EFCA301187A
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 20:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FFB32F751;
	Tue, 10 Feb 2026 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWNa67YP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7B32A3FF;
	Tue, 10 Feb 2026 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770755243; cv=none; b=W2UMtYfl0pI4QC+QUpLDc5xYaHpluhOun91oZDKWsjAR6YvNloq2ulFZxXnW3YBEKwtNwpS851NDSxBQW9sJEIdhaMZnBVGgKhvYKx5hkWfw9R5/FQ9u9ug8oIU1+kE26/j8BWAAALPOGXNwukmqpOvpAarHb/7T2kyTQiZOy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770755243; c=relaxed/simple;
	bh=NIS0BQnienSqp5kwK4dN3CbDaVN0KvBK1JLoLrEFazw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePN4HLO57pbZKX2DUV52yK7oqG5fe+4YLX/5WehztCZaj5UM95BDQiONrj2+sUuHRvuXktV57kjSz5VVG4JHJlVF8kLRD7M/a1vM+KrGU9PackKlQ9Y1KrtrxjXxxJBImb70ZtrZiRR/FZd5dn/+2+DgKmJx5m+5YYwwYR1bKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWNa67YP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770755242; x=1802291242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NIS0BQnienSqp5kwK4dN3CbDaVN0KvBK1JLoLrEFazw=;
  b=EWNa67YPCgh5fN5wFydJvtLL68Oc2ls6AUuMjZCut6rqxpipF073J/hK
   MpaK4evFzfavLd+xblpSZ4FEnaAp2va4e19Ww6L0iwQNngn8HX8YH00ZT
   VVUcS9+ThvxJ8zmSWH1p2q7NflVhbVNmaU3tSWvNbOiK56Uo7TzA786yA
   lnLjveMnmUxRaxG69efEmoe+Y0jqSIp9njuJBKIzRknpjwgBrsUhAaiIr
   HGbfZA/VV0wKFsVyfGv4nF+ri55NrZvnl5E+NerEMUuNo9V8S3mG3anYY
   gZQVU6lGqYjiqnPAHI8VehNvPglCohhEyEDEg07EQbFnwmwa2RuIQGqpM
   g==;
X-CSE-ConnectionGUID: bcy0ykE6SjK2TJa//MQuXQ==
X-CSE-MsgGUID: t2+SQB54Tyu+6KqNw8XBZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75740668"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="75740668"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 12:27:22 -0800
X-CSE-ConnectionGUID: l1evAz9pSmCBNBPmfWi6ew==
X-CSE-MsgGUID: v8rRE28ZS6S64hO6l7NNMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211654594"
Received: from igk-lkp-server01.igk.intel.com (HELO e5404a91d123) ([10.211.93.152])
  by fmviesa008.fm.intel.com with ESMTP; 10 Feb 2026 12:27:18 -0800
Received: from kbuild by e5404a91d123 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpuKK-000000000uP-0nhC;
	Tue, 10 Feb 2026 20:27:16 +0000
Date: Tue, 10 Feb 2026 21:26:33 +0100
From: kernel test robot <lkp@intel.com>
To: Feng Yang <yangfeng59949@163.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yangfeng59949@163.com
Subject: Re: [PATCH v5] bpf: test_run: Fix the null pointer dereference issue
 in bpf_lwt_xmit_push_encap
Message-ID: <202602102144.JapMKlzC-lkp@intel.com>
References: <20260210090657.86977-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210090657.86977-1-yangfeng59949@163.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-258159-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89CDE11F055
X-Rspamd-Action: no action

Hi Feng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf-next/master bpf/master net-next/main net/main linus/master v6.19 next-20260209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Feng-Yang/bpf-test_run-Fix-the-null-pointer-dereference-issue-in-bpf_lwt_xmit_push_encap/20260210-171138
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260210090657.86977-1-yangfeng59949%40163.com
patch subject: [PATCH v5] bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260210/202602102144.JapMKlzC-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260210/202602102144.JapMKlzC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602102144.JapMKlzC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/bpf/test_run.c:1162:17: warning: unused variable 'fl6' [-Wunused-variable]
    1162 |                 struct flowi6 fl6 = {};
         |                               ^~~
   1 warning generated.


vim +/fl6 +1162 net/bpf/test_run.c

   984	
   985	int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
   986				  union bpf_attr __user *uattr)
   987	{
   988		bool is_l2 = false, is_direct_pkt_access = false, is_lwt = false;
   989		u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
   990		struct net *net = current->nsproxy->net_ns;
   991		struct net_device *dev = net->loopback_dev;
   992		u32 headroom = NET_SKB_PAD + NET_IP_ALIGN;
   993		u32 linear_sz = kattr->test.data_size_in;
   994		u32 repeat = kattr->test.repeat;
   995		struct dst_entry *dst = NULL;
   996		struct __sk_buff *ctx = NULL;
   997		struct sk_buff *skb = NULL;
   998		struct sock *sk = NULL;
   999		u32 retval, duration;
  1000		int hh_len = ETH_HLEN;
  1001		void *data = NULL;
  1002		int ret;
  1003	
  1004		if ((kattr->test.flags & ~BPF_F_TEST_SKB_CHECKSUM_COMPLETE) ||
  1005		    kattr->test.cpu || kattr->test.batch_size)
  1006			return -EINVAL;
  1007	
  1008		if (kattr->test.data_size_in < ETH_HLEN)
  1009			return -EINVAL;
  1010	
  1011		switch (prog->type) {
  1012		case BPF_PROG_TYPE_SCHED_CLS:
  1013		case BPF_PROG_TYPE_SCHED_ACT:
  1014			is_direct_pkt_access = true;
  1015			is_l2 = true;
  1016			break;
  1017		case BPF_PROG_TYPE_LWT_IN:
  1018		case BPF_PROG_TYPE_LWT_OUT:
  1019		case BPF_PROG_TYPE_LWT_XMIT:
  1020			is_lwt = true;
  1021			fallthrough;
  1022		case BPF_PROG_TYPE_CGROUP_SKB:
  1023			is_direct_pkt_access = true;
  1024			break;
  1025		default:
  1026			break;
  1027		}
  1028	
  1029		ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
  1030		if (IS_ERR(ctx))
  1031			return PTR_ERR(ctx);
  1032	
  1033		if (ctx) {
  1034			if (ctx->data_end > kattr->test.data_size_in || ctx->data || ctx->data_meta) {
  1035				ret = -EINVAL;
  1036				goto out;
  1037			}
  1038			if (ctx->data_end) {
  1039				/* Non-linear LWT test_run is unsupported for now. */
  1040				if (is_lwt) {
  1041					ret = -EINVAL;
  1042					goto out;
  1043				}
  1044				linear_sz = max(ETH_HLEN, ctx->data_end);
  1045			}
  1046		}
  1047	
  1048		linear_sz = min_t(u32, linear_sz, PAGE_SIZE - headroom - tailroom);
  1049	
  1050		data = bpf_test_init(kattr, linear_sz, linear_sz, headroom, tailroom);
  1051		if (IS_ERR(data)) {
  1052			ret = PTR_ERR(data);
  1053			data = NULL;
  1054			goto out;
  1055		}
  1056	
  1057		sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
  1058		if (!sk) {
  1059			ret = -ENOMEM;
  1060			goto out;
  1061		}
  1062		sock_init_data(NULL, sk);
  1063	
  1064		skb = slab_build_skb(data);
  1065		if (!skb) {
  1066			ret = -ENOMEM;
  1067			goto out;
  1068		}
  1069		skb->sk = sk;
  1070	
  1071		data = NULL; /* data released via kfree_skb */
  1072	
  1073		skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
  1074		__skb_put(skb, linear_sz);
  1075	
  1076		if (unlikely(kattr->test.data_size_in > linear_sz)) {
  1077			void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
  1078			struct skb_shared_info *sinfo = skb_shinfo(skb);
  1079			u32 copied = linear_sz;
  1080	
  1081			while (copied < kattr->test.data_size_in) {
  1082				struct page *page;
  1083				u32 data_len;
  1084	
  1085				if (sinfo->nr_frags == MAX_SKB_FRAGS) {
  1086					ret = -ENOMEM;
  1087					goto out;
  1088				}
  1089	
  1090				page = alloc_page(GFP_KERNEL);
  1091				if (!page) {
  1092					ret = -ENOMEM;
  1093					goto out;
  1094				}
  1095	
  1096				data_len = min_t(u32, kattr->test.data_size_in - copied,
  1097						 PAGE_SIZE);
  1098				skb_fill_page_desc(skb, sinfo->nr_frags, page, 0, data_len);
  1099	
  1100				if (copy_from_user(page_address(page), data_in + copied,
  1101						   data_len)) {
  1102					ret = -EFAULT;
  1103					goto out;
  1104				}
  1105				skb->data_len += data_len;
  1106				skb->truesize += PAGE_SIZE;
  1107				skb->len += data_len;
  1108				copied += data_len;
  1109			}
  1110		}
  1111	
  1112		if (ctx && ctx->ifindex > 1) {
  1113			dev = dev_get_by_index(net, ctx->ifindex);
  1114			if (!dev) {
  1115				ret = -ENODEV;
  1116				goto out;
  1117			}
  1118		}
  1119		skb->protocol = eth_type_trans(skb, dev);
  1120		skb_reset_network_header(skb);
  1121	
  1122		switch (skb->protocol) {
  1123		case htons(ETH_P_IP):
  1124			sk->sk_family = AF_INET;
  1125			if (sizeof(struct iphdr) <= skb_headlen(skb)) {
  1126				sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
  1127				sk->sk_daddr = ip_hdr(skb)->daddr;
  1128			}
  1129			break;
  1130	#if IS_ENABLED(CONFIG_IPV6)
  1131		case htons(ETH_P_IPV6):
  1132			sk->sk_family = AF_INET6;
  1133			if (sizeof(struct ipv6hdr) <= skb_headlen(skb)) {
  1134				sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
  1135				sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
  1136			}
  1137			break;
  1138	#endif
  1139		default:
  1140			break;
  1141		}
  1142	
  1143		if (is_l2)
  1144			__skb_push(skb, hh_len);
  1145		if (is_direct_pkt_access)
  1146			bpf_compute_data_pointers(skb);
  1147	
  1148		ret = convert___skb_to_skb(skb, ctx);
  1149		if (ret)
  1150			goto out;
  1151	
  1152		if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
  1153			const int off = skb_network_offset(skb);
  1154			int len = skb->len - off;
  1155	
  1156			skb->csum = skb_checksum(skb, off, len, 0);
  1157			skb->ip_summed = CHECKSUM_COMPLETE;
  1158		}
  1159	
  1160		if (prog->type == BPF_PROG_TYPE_LWT_XMIT && !skb_dst(skb)) {
  1161			struct flowi4 fl4 = {};
> 1162			struct flowi6 fl6 = {};
  1163			struct rtable *rt;
  1164	
  1165			switch (skb->protocol) {
  1166			case htons(ETH_P_IP):
  1167				if (sizeof(struct iphdr) <= skb_headlen(skb)) {
  1168					fl4.saddr = ip_hdr(skb)->saddr;
  1169					fl4.daddr = ip_hdr(skb)->daddr;
  1170				}
  1171	
  1172				rt = ip_route_output_key(net, &fl4);
  1173				if (IS_ERR(rt)) {
  1174					ret = PTR_ERR(rt);
  1175					goto out;
  1176				}
  1177				dst = &rt->dst;
  1178				break;
  1179	#if IS_ENABLED(CONFIG_IPV6)
  1180			case htons(ETH_P_IPV6):
  1181				if (sizeof(struct ipv6hdr) <= skb_headlen(skb)) {
  1182					fl6.saddr = ipv6_hdr(skb)->saddr;
  1183					fl6.daddr = ipv6_hdr(skb)->daddr;
  1184				}
  1185	
  1186				dst = ip6_route_output(net, NULL, &fl6);
  1187				if (IS_ERR(dst)) {
  1188					ret = PTR_ERR(dst);
  1189					goto out;
  1190				}
  1191				break;
  1192	#endif
  1193			default:
  1194				ret = -EINVAL;
  1195				goto out;
  1196			}
  1197	
  1198			if (unlikely(dst->error)) {
  1199				ret = dst->error;
  1200				dst_release(dst);
  1201				goto out;
  1202			}
  1203			skb_dst_set(skb, dst);
  1204		}
  1205		ret = bpf_test_run(prog, skb, repeat, &retval, &duration, false);
  1206		if (ret)
  1207			goto out;
  1208		if (!is_l2) {
  1209			if (skb_headroom(skb) < hh_len) {
  1210				int nhead = HH_DATA_ALIGN(hh_len - skb_headroom(skb));
  1211	
  1212				if (pskb_expand_head(skb, nhead, 0, GFP_USER)) {
  1213					ret = -ENOMEM;
  1214					goto out;
  1215				}
  1216			}
  1217			memset(__skb_push(skb, hh_len), 0, hh_len);
  1218		}
  1219	
  1220		if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
  1221			const int off = skb_network_offset(skb);
  1222			int len = skb->len - off;
  1223			__wsum csum;
  1224	
  1225			csum = skb_checksum(skb, off, len, 0);
  1226	
  1227			if (csum_fold(skb->csum) != csum_fold(csum)) {
  1228				ret = -EBADMSG;
  1229				goto out;
  1230			}
  1231		}
  1232	
  1233		convert_skb_to___skb(skb, ctx);
  1234	
  1235		if (skb_is_nonlinear(skb))
  1236			/* bpf program can never convert linear skb to non-linear */
  1237			WARN_ON_ONCE(linear_sz == kattr->test.data_size_in);
  1238		ret = bpf_test_finish(kattr, uattr, skb->data, skb_shinfo(skb), skb->len,
  1239				      skb->data_len, retval, duration);
  1240		if (!ret)
  1241			ret = bpf_ctx_finish(kattr, uattr, ctx,
  1242					     sizeof(struct __sk_buff));
  1243	out:
  1244		if (dev && dev != net->loopback_dev)
  1245			dev_put(dev);
  1246		kfree_skb(skb);
  1247		kfree(data);
  1248		if (sk)
  1249			sk_free(sk);
  1250		kfree(ctx);
  1251		return ret;
  1252	}
  1253	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

