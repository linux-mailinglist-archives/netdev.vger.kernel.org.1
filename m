Return-Path: <netdev+bounces-188558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CFFAAD5DF
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 08:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09705170A65
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 06:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5509202996;
	Wed,  7 May 2025 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYobWDKP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A61FECCD;
	Wed,  7 May 2025 06:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746598813; cv=none; b=RibYE1HL1M72aaUkppPc2ZQ4qSe8ZZebQXNrjZDJEtA/+laRJPi3uYMKIsYOeMOq94PcPBkYZ6sH1syj3oFCr4u2X9ip4HgwWgUyL2vffMaz9QRH/OsbzkH1e5okvdd2bo0rWL04jP/XWT3HyIjQoSOE2Y4sxAeImzzZAEt3icY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746598813; c=relaxed/simple;
	bh=vGBf4crFLlyh98XywP35vX52FQrE/MQ8FtiZ75/s7fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWcHfA5Tmkw0UetA/fcx0knl3gi7CK2vL7bCowACSxORcNqAza45u/gDs9VjPF+UUeCVcZK05GOY26YMoQG1zp3sjGSG0x0GXjPaj2p9coMFPNBenFH9v8iak5o2XNPyfJFJ/i6l+vZuAm8aueNfSJbSb2L0IYp5BKjLs5yUXs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYobWDKP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746598812; x=1778134812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vGBf4crFLlyh98XywP35vX52FQrE/MQ8FtiZ75/s7fs=;
  b=XYobWDKPJc4uFGQPRxKcOg5jj8IzSWd9Qwn2wu4BLA2evF4zC+L/qZ0b
   G4kaIjU/c03c0duT0OsKY1qRXcSh7VT0IVvSZWWZov2vjq+EXfuqBG5lL
   qpK2pDtuJQ1JVmiSjpGtKV8ec2Q5ZZQQpSacJ2I7Zb9+MNoejUym5Csfc
   dXeGHDkitMSieU7kBHxidi/0oRUxAsmPV7Owy/B3sJCCtixS6IykiO7Q4
   p3x60qusycdY/hZhFkgohwFMyEJ6lySJyD4f3LeNqpjzAcpacBKn1zGBK
   djXxIjVqLrvSeGJUpuDxKM5mTfuxVPm9ec/5bAZhpE1toq9hx4pFRyjJN
   Q==;
X-CSE-ConnectionGUID: /1P9AAQeTxmJvNjxMMkE2w==
X-CSE-MsgGUID: TuqqpYC5QuWph6WZRr9wbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="65839618"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="65839618"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 23:20:11 -0700
X-CSE-ConnectionGUID: m7Vnu9KCTEO41tmiyB99Dg==
X-CSE-MsgGUID: zUxCMTTWTUSt93fetARTSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="159146603"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 06 May 2025 23:20:08 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCY8T-0007BN-27;
	Wed, 07 May 2025 06:20:05 +0000
Date: Wed, 7 May 2025 14:19:52 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yang Li <yang.li@amlogic.com>
Subject: Re: [PATCH] iso: add BT_ISO_TS optional to enable ISO timestamp
Message-ID: <202505071336.tWe4dbxi-lkp@intel.com>
References: <20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com>

Hi Yang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 16b4f97defefd93cfaea017a7c3e8849322f7dde]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Li-via-B4-Relay/iso-add-BT_ISO_TS-optional-to-enable-ISO-timestamp/20250429-113716
base:   16b4f97defefd93cfaea017a7c3e8849322f7dde
patch link:    https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb%40amlogic.com
patch subject: [PATCH] iso: add BT_ISO_TS optional to enable ISO timestamp
config: x86_64-randconfig-123-20250502 (https://download.01.org/0day-ci/archive/20250507/202505071336.tWe4dbxi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505071336.tWe4dbxi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071336.tWe4dbxi-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/bluetooth/iso.c:2330:42: sparse: sparse: restricted __le16 degrades to integer

vim +2330 net/bluetooth/iso.c

  2293	
  2294	void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
  2295	{
  2296		struct iso_conn *conn = hcon->iso_data;
  2297		struct sock *sk;
  2298		__u16 pb, ts, len;
  2299	
  2300		if (!conn)
  2301			goto drop;
  2302	
  2303		iso_conn_lock(conn);
  2304		sk = conn->sk;
  2305		iso_conn_unlock(conn);
  2306	
  2307		if (!sk)
  2308			goto drop;
  2309	
  2310		pb = hci_iso_flags_pb(flags);
  2311		ts = hci_iso_flags_ts(flags);
  2312	
  2313		BT_DBG("conn %p len %d pb 0x%x ts 0x%x", conn, skb->len, pb, ts);
  2314	
  2315		switch (pb) {
  2316		case ISO_START:
  2317		case ISO_SINGLE:
  2318			if (conn->rx_len) {
  2319				BT_ERR("Unexpected start frame (len %d)", skb->len);
  2320				kfree_skb(conn->rx_skb);
  2321				conn->rx_skb = NULL;
  2322				conn->rx_len = 0;
  2323			}
  2324	
  2325			if (ts) {
  2326				struct hci_iso_ts_data_hdr *hdr;
  2327	
  2328				if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)) {
  2329					hdr = (struct hci_iso_ts_data_hdr *)skb->data;
> 2330					len = hdr->slen + HCI_ISO_TS_DATA_HDR_SIZE;
  2331				} else {
  2332					hdr = skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
  2333					if (!hdr) {
  2334						BT_ERR("Frame is too short (len %d)", skb->len);
  2335						goto drop;
  2336					}
  2337	
  2338					len = __le16_to_cpu(hdr->slen);
  2339				}
  2340			} else {
  2341				struct hci_iso_data_hdr *hdr;
  2342	
  2343				if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)) {
  2344					BT_ERR("Invalid option BT_SK_ISO_TS");
  2345					clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
  2346				}
  2347	
  2348				hdr = skb_pull_data(skb, HCI_ISO_DATA_HDR_SIZE);
  2349				if (!hdr) {
  2350					BT_ERR("Frame is too short (len %d)", skb->len);
  2351					goto drop;
  2352				}
  2353	
  2354				len = __le16_to_cpu(hdr->slen);
  2355			}
  2356	
  2357			flags  = hci_iso_data_flags(len);
  2358			len    = hci_iso_data_len(len);
  2359	
  2360			BT_DBG("Start: total len %d, frag len %d flags 0x%4.4x", len,
  2361			       skb->len, flags);
  2362	
  2363			if (len == skb->len) {
  2364				/* Complete frame received */
  2365				hci_skb_pkt_status(skb) = flags & 0x03;
  2366				iso_recv_frame(conn, skb);
  2367				return;
  2368			}
  2369	
  2370			if (pb == ISO_SINGLE) {
  2371				BT_ERR("Frame malformed (len %d, expected len %d)",
  2372				       skb->len, len);
  2373				goto drop;
  2374			}
  2375	
  2376			if (skb->len > len) {
  2377				BT_ERR("Frame is too long (len %d, expected len %d)",
  2378				       skb->len, len);
  2379				goto drop;
  2380			}
  2381	
  2382			/* Allocate skb for the complete frame (with header) */
  2383			conn->rx_skb = bt_skb_alloc(len, GFP_KERNEL);
  2384			if (!conn->rx_skb)
  2385				goto drop;
  2386	
  2387			hci_skb_pkt_status(conn->rx_skb) = flags & 0x03;
  2388			skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
  2389						  skb->len);
  2390			conn->rx_len = len - skb->len;
  2391			break;
  2392	
  2393		case ISO_CONT:
  2394			BT_DBG("Cont: frag len %d (expecting %d)", skb->len,
  2395			       conn->rx_len);
  2396	
  2397			if (!conn->rx_len) {
  2398				BT_ERR("Unexpected continuation frame (len %d)",
  2399				       skb->len);
  2400				goto drop;
  2401			}
  2402	
  2403			if (skb->len > conn->rx_len) {
  2404				BT_ERR("Fragment is too long (len %d, expected %d)",
  2405				       skb->len, conn->rx_len);
  2406				kfree_skb(conn->rx_skb);
  2407				conn->rx_skb = NULL;
  2408				conn->rx_len = 0;
  2409				goto drop;
  2410			}
  2411	
  2412			skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
  2413						  skb->len);
  2414			conn->rx_len -= skb->len;
  2415			return;
  2416	
  2417		case ISO_END:
  2418			skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
  2419						  skb->len);
  2420			conn->rx_len -= skb->len;
  2421	
  2422			if (!conn->rx_len) {
  2423				struct sk_buff *rx_skb = conn->rx_skb;
  2424	
  2425				/* Complete frame received. iso_recv_frame
  2426				 * takes ownership of the skb so set the global
  2427				 * rx_skb pointer to NULL first.
  2428				 */
  2429				conn->rx_skb = NULL;
  2430				iso_recv_frame(conn, rx_skb);
  2431			}
  2432			break;
  2433		}
  2434	
  2435	drop:
  2436		kfree_skb(skb);
  2437	}
  2438	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

