Return-Path: <netdev+bounces-157399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46C4A0A266
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2563A196D
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E98189F45;
	Sat, 11 Jan 2025 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbytJWnU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C281885B4
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736588972; cv=none; b=kDlgXoPa+iYW+vOJEie2hUsIW/FeniyZEMMomHJ1r9Rzbhb6DaB/HCGry5cKJv4UQorjYZtxiUixyZKhEXlj7/WfPI4b3npKaQ3DV2DsY1w+nFQXMoBV8JGnqwmDBuBLF+UiGOblflOrBhqaO937j0LypI9TMZVn6SJxQs3V8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736588972; c=relaxed/simple;
	bh=AblgLSACwiCrBiCNEaHlTkmLhzH/lPXUfMBmIVezkAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NV6oYy+F6U/yhB6tEvldgm9B1ddBHKPCbyfAZWKH5TtYtMcN33o1oRn1tOkinh/3q40jW3w2QYMbZyzxpLFE3urty6yavphcsIrEIcM3Jn9cOjCna9A0CQ2i/pBR9Hbe2nBrW+cn1h0rzJZezZCMIGt3lMonqtpf/2QUMe22IP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbytJWnU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736588970; x=1768124970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AblgLSACwiCrBiCNEaHlTkmLhzH/lPXUfMBmIVezkAQ=;
  b=nbytJWnURn1uOygxQck9ogSLyhnPPn9w5oBjo2PEmSZIQJmCxTjt68kL
   ze6Ucz0vrnk1DpdC9dTXoyYoezNHm5N79eWg9TcAlTk2qS83390WbVq8S
   I1nMNhPFMk7fDb19O64o78VXYRSwnR8OdW3WPvvbGAGtUk2wVqy9qCCPg
   +vkx6ar5szHvSGEV7huEYAy5uc/bhOtCHzlf7yk8h6ndzZ19i0jrxNk65
   JEFiYifl5nQObeQeftD/FizdXZHkNDKlrh6IT22NMRxjLU9KHXfF9JBm1
   IslMF8SEf6837audnH1t6K6wy1tb8WsY+fAPm3uymunx4FgViCW08Ivvb
   g==;
X-CSE-ConnectionGUID: t4ZbRffJQiap3XlKkSmJ4A==
X-CSE-MsgGUID: UiVde4brSniTyDCZRBxUNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="40646915"
X-IronPort-AV: E=Sophos;i="6.12,306,1728975600"; 
   d="scan'208";a="40646915"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 01:49:30 -0800
X-CSE-ConnectionGUID: HhaMVm9fQD27h95k9unS1A==
X-CSE-MsgGUID: BsC9mfnxRnmZUCtprqZFeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,306,1728975600"; 
   d="scan'208";a="103766867"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Jan 2025 01:49:26 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWY7Q-000KSS-1h;
	Sat, 11 Jan 2025 09:49:24 +0000
Date: Sat, 11 Jan 2025 17:49:00 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Donald Hunter <donald.hunter@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 07/12] af_unix: Set drop reason in
 unix_stream_sendmsg().
Message-ID: <202501111754.vEJ6CJgk-lkp@intel.com>
References: <20250110092641.85905-8-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110092641.85905-8-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/net-dropreason-Gather-SOCKET_-drop-reasons/20250110-173850
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250110092641.85905-8-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 07/12] af_unix: Set drop reason in unix_stream_sendmsg().
config: mips-ci20_defconfig (https://download.01.org/0day-ci/archive/20250111/202501111754.vEJ6CJgk-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501111754.vEJ6CJgk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501111754.vEJ6CJgk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/unix/af_unix.c:2303:6: warning: variable 'reason' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    2303 |         if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:47:28: note: expanded from macro 'READ_ONCE'
      47 | #define READ_ONCE(x)                                                    \
         |                                                                         ^
   net/unix/af_unix.c:2403:24: note: uninitialized use occurs here
    2403 |         kfree_skb_reason(skb, reason);
         |                               ^~~~~~
   net/unix/af_unix.c:2303:2: note: remove the 'if' if its condition is always false
    2303 |         if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2304 |                 goto out_pipe;
         |                 ~~~~~~~~~~~~~
   net/unix/af_unix.c:2268:2: note: variable 'reason' is declared here
    2268 |         enum skb_drop_reason reason;
         |         ^
   1 warning generated.


vim +2303 net/unix/af_unix.c

314001f0bf9270 Rao Shoaib        2021-08-01  2264  
1b784140474e4f Ying Xue          2015-03-02  2265  static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
1b784140474e4f Ying Xue          2015-03-02  2266  			       size_t len)
^1da177e4c3f41 Linus Torvalds    2005-04-16  2267  {
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2268  	enum skb_drop_reason reason;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2269  	struct sock *sk = sock->sk;
49efbfa661b688 Kuniyuki Iwashima 2025-01-10  2270  	struct sk_buff *skb = NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2271  	struct sock *other = NULL;
7cc05662682da4 Christoph Hellwig 2015-01-28  2272  	struct scm_cookie scm;
8ba69ba6a324b1 Miklos Szeredi    2009-09-11  2273  	bool fds_sent = false;
49efbfa661b688 Kuniyuki Iwashima 2025-01-10  2274  	int err, sent = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2275  
7cc05662682da4 Christoph Hellwig 2015-01-28  2276  	err = scm_send(sock, msg, &scm, false);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2277  	if (err < 0)
^1da177e4c3f41 Linus Torvalds    2005-04-16  2278  		return err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2279  
d9f21b3613337b Kuniyuki Iwashima 2024-01-23  2280  	wait_for_unix_gc(scm.fp);
d9f21b3613337b Kuniyuki Iwashima 2024-01-23  2281  
314001f0bf9270 Rao Shoaib        2021-08-01  2282  	if (msg->msg_flags & MSG_OOB) {
6c444255b193b5 Kuniyuki Iwashima 2024-12-13  2283  		err = -EOPNOTSUPP;
4edf21aa94ee33 Kuniyuki Iwashima 2022-03-17  2284  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
314001f0bf9270 Rao Shoaib        2021-08-01  2285  		if (len)
314001f0bf9270 Rao Shoaib        2021-08-01  2286  			len--;
314001f0bf9270 Rao Shoaib        2021-08-01  2287  		else
314001f0bf9270 Rao Shoaib        2021-08-01  2288  #endif
^1da177e4c3f41 Linus Torvalds    2005-04-16  2289  			goto out_err;
314001f0bf9270 Rao Shoaib        2021-08-01  2290  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  2291  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2292  	if (msg->msg_namelen) {
8a34d4e8d9742a Kuniyuki Iwashima 2024-06-04  2293  		err = READ_ONCE(sk->sk_state) == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2294  		goto out_err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2295  	} else {
830a1e5c212fb3 Benjamin LaHaise  2005-12-13  2296  		other = unix_peer(sk);
6c444255b193b5 Kuniyuki Iwashima 2024-12-13  2297  		if (!other) {
6c444255b193b5 Kuniyuki Iwashima 2024-12-13  2298  			err = -ENOTCONN;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2299  			goto out_err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2300  		}
6c444255b193b5 Kuniyuki Iwashima 2024-12-13  2301  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  2302  
49efbfa661b688 Kuniyuki Iwashima 2025-01-10 @2303  	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
49efbfa661b688 Kuniyuki Iwashima 2025-01-10  2304  		goto out_pipe;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2305  
6eba6a372b501a Eric Dumazet      2008-11-16  2306  	while (sent < len) {
49efbfa661b688 Kuniyuki Iwashima 2025-01-10  2307  		int size = len - sent;
49efbfa661b688 Kuniyuki Iwashima 2025-01-10  2308  		int data_len;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2309  
a0dbf5f818f908 David Howells     2023-05-22  2310  		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
a0dbf5f818f908 David Howells     2023-05-22  2311  			skb = sock_alloc_send_pskb(sk, 0, 0,
a0dbf5f818f908 David Howells     2023-05-22  2312  						   msg->msg_flags & MSG_DONTWAIT,
a0dbf5f818f908 David Howells     2023-05-22  2313  						   &err, 0);
a0dbf5f818f908 David Howells     2023-05-22  2314  		} else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  2315  			/* Keep two messages in the pipe so it schedules better */
b0632e53e0da80 Kuniyuki Iwashima 2024-06-04  2316  			size = min_t(int, size, (READ_ONCE(sk->sk_sndbuf) >> 1) - 64);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2317  
e370a723632177 Eric Dumazet      2013-08-08  2318  			/* allow fallback to order-0 allocations */
e370a723632177 Eric Dumazet      2013-08-08  2319  			size = min_t(int, size, SKB_MAX_HEAD(0) + UNIX_SKB_FRAGS_SZ);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2320  
e370a723632177 Eric Dumazet      2013-08-08  2321  			data_len = max_t(int, 0, size - SKB_MAX_HEAD(0));
^1da177e4c3f41 Linus Torvalds    2005-04-16  2322  
31ff6aa5c86f75 Kirill Tkhai      2014-05-15  2323  			data_len = min_t(size_t, size, PAGE_ALIGN(data_len));
31ff6aa5c86f75 Kirill Tkhai      2014-05-15  2324  
e370a723632177 Eric Dumazet      2013-08-08  2325  			skb = sock_alloc_send_pskb(sk, size - data_len, data_len,
28d6427109d13b Eric Dumazet      2013-08-08  2326  						   msg->msg_flags & MSG_DONTWAIT, &err,
28d6427109d13b Eric Dumazet      2013-08-08  2327  						   get_order(UNIX_SKB_FRAGS_SZ));
a0dbf5f818f908 David Howells     2023-05-22  2328  		}
e370a723632177 Eric Dumazet      2013-08-08  2329  		if (!skb)
^1da177e4c3f41 Linus Torvalds    2005-04-16  2330  			goto out_err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2331  
f78a5fda911652 David S. Miller   2011-09-16  2332  		/* Only send the fds in the first buffer */
7cc05662682da4 Christoph Hellwig 2015-01-28  2333  		err = unix_scm_to_skb(&scm, skb, !fds_sent);
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2334  		if (err < 0) {
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2335  			reason = unix_scm_err_to_reason(err);
d460b04bc452cf Kuniyuki Iwashima 2024-12-13  2336  			goto out_free;
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2337  		}
d460b04bc452cf Kuniyuki Iwashima 2024-12-13  2338  
8ba69ba6a324b1 Miklos Szeredi    2009-09-11  2339  		fds_sent = true;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2340  
a0dbf5f818f908 David Howells     2023-05-22  2341  		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
6bd8614fc2d076 Frederik Deweerdt 2024-12-09  2342  			skb->ip_summed = CHECKSUM_UNNECESSARY;
a0dbf5f818f908 David Howells     2023-05-22  2343  			err = skb_splice_from_iter(skb, &msg->msg_iter, size,
a0dbf5f818f908 David Howells     2023-05-22  2344  						   sk->sk_allocation);
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2345  			if (err < 0) {
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2346  				reason = SKB_DROP_REASON_SKB_UCOPY_FAULT;
d460b04bc452cf Kuniyuki Iwashima 2024-12-13  2347  				goto out_free;
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2348  			}
d460b04bc452cf Kuniyuki Iwashima 2024-12-13  2349  
a0dbf5f818f908 David Howells     2023-05-22  2350  			size = err;
a0dbf5f818f908 David Howells     2023-05-22  2351  			refcount_add(size, &sk->sk_wmem_alloc);
a0dbf5f818f908 David Howells     2023-05-22  2352  		} else {
e370a723632177 Eric Dumazet      2013-08-08  2353  			skb_put(skb, size - data_len);
e370a723632177 Eric Dumazet      2013-08-08  2354  			skb->data_len = data_len;
e370a723632177 Eric Dumazet      2013-08-08  2355  			skb->len = size;
c0371da6047abd Al Viro           2014-11-24  2356  			err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2357  			if (err) {
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2358  				reason = SKB_DROP_REASON_SKB_UCOPY_FAULT;
d460b04bc452cf Kuniyuki Iwashima 2024-12-13  2359  				goto out_free;
a0dbf5f818f908 David Howells     2023-05-22  2360  			}
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2361  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  2362  
1c92b4e50ef926 David S. Miller   2007-05-31  2363  		unix_state_lock(other);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2364  
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2365  		if (sock_flag(other, SOCK_DEAD)) {
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2366  			reason = SKB_DROP_REASON_SOCKET_CLOSE;
49efbfa661b688 Kuniyuki Iwashima 2025-01-10  2367  			goto out_pipe_unlock;
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2368  		}
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2369  
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2370  		if (other->sk_shutdown & RCV_SHUTDOWN) {
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2371  			reason = SKB_DROP_REASON_SOCKET_RCV_SHUTDOWN;
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2372  			goto out_pipe_unlock;
6ca5ecbc3d69e6 Kuniyuki Iwashima 2025-01-10  2373  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  2374  
16e5726269611b Eric Dumazet      2011-09-19  2375  		maybe_add_creds(skb, sock, other);
3c32da19a858fb Kirill Tkhai      2019-12-09  2376  		scm_stat_add(other, skb);
7782040b950b5d Paolo Abeni       2020-02-28  2377  		skb_queue_tail(&other->sk_receive_queue, skb);
1c92b4e50ef926 David S. Miller   2007-05-31  2378  		unix_state_unlock(other);
676d23690fb62b David S. Miller   2014-04-11  2379  		other->sk_data_ready(other);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2380  		sent += size;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2381  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  2382  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

