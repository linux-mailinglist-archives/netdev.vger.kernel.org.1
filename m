Return-Path: <netdev+bounces-214245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E464B289F9
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 04:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A7E189651D
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 02:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7631EFF8B;
	Sat, 16 Aug 2025 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H3aCE55t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE991E0B9C
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755310707; cv=none; b=p5kXWCXSl7EsMfRE6VTuAqleo4YruXU6jQNKw1YxFbVQMN2vqY7YEPMWpFzl+lDmp2+mWum+OMOOUFSCsRBr75QVdibpqnfqpZ5e8UWhj76HKLCYTAjIYF3g3eNSLiehe57wGKQA+JLXKrGIKiXNSQbLtErxW927pbCyPn2wrhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755310707; c=relaxed/simple;
	bh=wUGIvKrpeupzIRgkLjoxvnnL4aYCz4wqe6Y1gDPHbAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYMzXkPcOenkv3fy5aO8PVtowt1Z4Pa6SisGPdsfaA8XB/ZsTJrrA67iDMj/XFZYzqvJRfGbAOlGR9wDJgN7BA8sMpKUqurEx7Gk91aCPAimf+F9Wb9OIm7PYl9WPwwI7QMK5H6gLRnJ4YrOgJvKfYxempT+7t1z5/z3dwILYyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H3aCE55t; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb61f6044so430282166b.0
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 19:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755310704; x=1755915504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwsXpXXIuYQCL/FW90IpYibOz6Dfp82j0b3aRU8rwPo=;
        b=H3aCE55tHzz6WyPbYzCUrIo+ItI9OxGSKAoOHBd9+VdEnZJQZAuoxK6SW11sMlk4XV
         RZ9swmz5Z/S2AuD8Qve3WSn7y8QJONm7FNvw+v/LApoP7IhpsNbvJgYXnKkR4qX+Caw2
         AQQjReLbjSEwz4egINy+HNBZ8s6ei2JqdYMcp2P7k98JEEFQYV2c/qe3rbr1MxPl8qEH
         TJ60zK831q0fWwtlJ6ppGoQVYnKmIngPCOBeXf4IAbM0R38B2N/NaCglmgdqHQtwcvR5
         qlJlo+bBmFX/7BSXEE6XcI5FYwat8EDf0egsspx15KoUoUCshIsVaknZeHQRrF6DB8KI
         Bqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755310704; x=1755915504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwsXpXXIuYQCL/FW90IpYibOz6Dfp82j0b3aRU8rwPo=;
        b=HeDrprobW4RllOyfjd1hcsrt7OBqG5UdRI8SCaxQ6NBKPp7T3wQEOqcqndY2xKTqkN
         r0aEnP+CQyU8VlEYXL89QssZ5+nxsTA9IP9AS+0GMJRifhdYwl3eEUzhk3JgxwSiBOwN
         TidlGiD6isoyUmx3E5/jMwo2oYNdNjs1SvFezsRZhA5BphrB/Uv70rUwRMZ7LmDkYM7+
         Cfrteba+NhlZ9aHxyayE8fSfgCBz9voDiYDAcfHCz9O/k1zD/j6jm6FLfWe7uWGoooGT
         zUQvAcvJZ4eZ1zi78IETmoN0ohzAS5/utn+UnL8yVFbhb5MmawEvxmtNvqlby4gzLeKF
         ljIg==
X-Forwarded-Encrypted: i=1; AJvYcCX7K8je4O2TdkvUE3UhZxSj3v1kgD4lupUnuqy6MfYkEuHXHLaCKPuCvTfRDDrr47gcb2HfSqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJXxW+CG6YjqsUm0fY6diRS0M4IsKxpIua5itypOfM5ex0Rab
	ZR1q9sWnwv1GfIQDADF1IR+0Ojwu/cWgjj1AVUm8sSmawRd0Z+aCju7aNQYEOeXFwA==
X-Gm-Gg: ASbGncvWyU043djLwjUmTvpfX5F4gugTQG3UdOWmYnQct+r+kzTNuwxFpZ4iNTLiZ5b
	EE3bN6roCx3EKpRpxdlatKT4KTedjgN1YeJprXFEnIVgvGIqZIv1aye7BdrQ8Y92TJgd+GBhX2D
	E4eNYTzpd+pHoMhVfVbelWmLT4bV0I6rNnIs5TrU+AV4fJ3hZ0AKfMWidswkQJ2+/czd6E0ZoNX
	+u/85zKF4SjfCtdd92FIAxFIINcZ2JkHJEsXGlVuZdTiwsVFFn+jGCcAGf/75G+RgFirTV3tukx
	37IhdLvlr2MT7mvyocYqx+UYkJ/pCNxKR8G5375W/Vs4+ZCrh7dZeIo5NDA8MkoPv/XHru4ZQbG
	IPT/WbbfHNBOhrY+eXlsbIA==
X-Google-Smtp-Source: AGHT+IHNk8PBKUNrSPx10ifAUYOJvFnn2Jc4DOTuWB3OZc7DjYdpAwzxQ0MKpk/V8JZvySJfquvRNQ==
X-Received: by 2002:a17:907:7f09:b0:ae3:5185:5416 with SMTP id a640c23a62f3a-afcdb1a2e5amr388545866b.13.1755310704049;
        Fri, 15 Aug 2025 19:18:24 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd01168csm262745266b.91.2025.08.15.19.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 19:18:23 -0700 (PDT)
Date: Sat, 16 Aug 2025 02:18:21 +0000
From: Wei Gao <wegao@suse.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, kuniyu@google.com,
	kraig@google.com, lkp@intel.com, netdev@vger.kernel.org,
	dsahern@kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, edumazet@google.com, horms@kernel.org,
	oe-lkp@lists.linux.dev, kuba@kernel.org, pabeni@redhat.com,
	ncardwell@google.com, davem@davemloft.net, ltp@lists.linux.it,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [LTP] [PATCH net v2] net: ip: order the reuseport socket in
 __inet_hash
Message-ID: <aJ_qbZDvDJwVoZGA@localhost>
References: <20250801090949.129941-1-dongml2@chinatelecom.cn>
 <202508110750.a66a4225-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508110750.a66a4225-lkp@intel.com>

On Mon, Aug 11, 2025 at 01:27:12PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:KASAN:slab-use-after-free_in__inet_hash" on:
> 
> commit: 859ca60b71ef223e210d3d003a225d9ca70879fd ("[PATCH net v2] net: ip: order the reuseport socket in __inet_hash")
> url: https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/net-ip-order-the-reuseport-socket-in-__inet_hash/20250801-171131
> base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git 01051012887329ea78eaca19b1d2eac4c9f601b5
> patch link: https://lore.kernel.org/all/20250801090949.129941-1-dongml2@chinatelecom.cn/
> patch subject: [PATCH net v2] net: ip: order the reuseport socket in __inet_hash
> 
> in testcase: ltp
> version: ltp-x86_64-6505f9e29-1_20250802
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: ext4
> 	test: fs_perms_simple
> 
> 
> 
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202508110750.a66a4225-lkp@intel.com
> 
> 
> kern :err : [  128.186735] BUG: KASAN: slab-use-after-free in __inet_hash (net/ipv4/inet_hashtables.c:749 net/ipv4/inet_hashtables.c:800) 

This kasan error not related with LTP case, i guess it triggered by network
related process such as bind etc. I try to give following patch to fix
kasan error, correct me if any mistake, thanks.

From: Wei Gao <wegao@suse.com>
Date: Sat, 16 Aug 2025 09:32:56 +0800
Subject: [PATCH v1] net: Fix BUG:KASAN:slab-use-after-free_in__inet_hash

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202508110750.a66a4225-lkp@intel.com
Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/linux/rculist_nulls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index da500f4ae142..5def9009c507 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -57,7 +57,7 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
  * @node: element of the list.
  */
 #define hlist_nulls_pprev_rcu(node) \
-       (*((struct hlist_nulls_node __rcu __force **)&(node)->pprev))
+       (*((struct hlist_nulls_node __rcu __force **)(node)->pprev))

 /**
  * hlist_nulls_del_rcu - deletes entry from hash list without re-initialization
@@ -175,7 +175,7 @@ static inline void hlist_nulls_add_before_rcu(struct hlist_nulls_node *n,
 {
        WRITE_ONCE(n->pprev, next->pprev);
        n->next = next;
-       rcu_assign_pointer(hlist_nulls_pprev_rcu(n), n);
+       rcu_assign_pointer(hlist_nulls_pprev_rcu(next), n);
        WRITE_ONCE(next->pprev, &n->next);
 }

--
2.43.0


