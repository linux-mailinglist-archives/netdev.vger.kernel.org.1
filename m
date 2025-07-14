Return-Path: <netdev+bounces-206834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C87B047BA
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 21:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21521A67690
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 19:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B61277023;
	Mon, 14 Jul 2025 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwvw+oX/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB4325C80D
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519969; cv=none; b=ZmZxmvWK9aLOC3pfteptr5bPBghbkTzbSpln4vPcWEaqUAD+B53hHKdYxKtUl+u8HfotPr8NheDwZRwP9kzOPXU0+abOGRBopaTzlweeWwtiMdDD6SbsbABXRwqA/1Ccdl0+EPum1RY+96Le1LnkX1R+M8AAIMvB8MnHIfWjjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519969; c=relaxed/simple;
	bh=36OXI6KdfNW5Azr1XrUS3aZkxv95IVhnKyZFnAzOoQc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Cqw0QGv7L84oG/hMmDC4e1NFZQCiJRGY4Df7+0LjWCd5SoTALHnyDeUAtlP0rJnz9UnIWd+bxuE8h0jK9mTzXrJqTMQO+I7yt1pr1nDdj7biiBViNFtMb9VA5wL+Qgsf833XLmVL7i5/1ASH9KnwoCtt4S3fJazboMDdPL8rRaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lwvw+oX/; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-613ab402150so2515708eaf.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 12:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752519965; x=1753124765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Kej+z2nwqH47H8syUxUZJZrrsTEp7h/K0YFhcC1+oo=;
        b=lwvw+oX/FgmV6WxHc1f6327vxDQU1fAtojQmRlSf/CE8eomxk46yTdx/1upDygeENI
         AdRh9Uq77z29UOrM5FuYDt7QksiLfV4kj2d1cDrt8JtPrFVAfa3vgkUwcKLHlTujXOSC
         2aqdQ/FjjO0nWfGOUL61aw9W8wHu+RtTX40zDR34OtiAZT5fnH59nefP9WMtbylSTrmb
         /vE8fEf2a7B2ByGgn1NM3UKzOAhHDw2uwWAVum700g3zPmBcgnkeZrouTR+CfxSVZeR0
         eKbW2TazpYH4p4Vr5jezYsZqrEe/N0GxgAnGgxR15fXVomKuXbfmfNxeMOEPpluCcsKs
         /miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752519965; x=1753124765;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Kej+z2nwqH47H8syUxUZJZrrsTEp7h/K0YFhcC1+oo=;
        b=LNNBO7o6AR1q/buniRRQM2SsL5fKNZVV+TNYfBf9C4YvkPiG8rwWs+64GWqwlScFUF
         m8HPeHGIjJWQIuqbW5w9N0L+MpORLbiYy9WK6dgswPWZJ/fPfyVSp2fwussbfVcZr6Z4
         ieAttE02vKfWQHS4D+TMd2J4RH7KuVCxf/VaXzuR7Vi4PwzJYRn/YZ0yi00tZRTp/cVo
         g7BtWz/z2z0xnJv9ZjZr7S3SkBuXkdqacCBN3QrbQDjz2hRp48mTC4R6Nh+9cWJVDAB3
         9Swq+eELspgpbPMqI0iW8/nIo8P02EccJcpFthb6js/ifuEC2KgNUvbgxb3ZGwPzTKvO
         TTkg==
X-Forwarded-Encrypted: i=1; AJvYcCVebj4u/6qYaIv1mHTTuQblp5YUS1JojlW5mJNqorTTN8KHx46VQkYZp03FCkiW0DCD/pkcUSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXlkjuZvEnyScUbssXBo68kpm8MgArR5pklkvaCDOLKwRI6gAd
	I/g9qw4YiqbYlv2tDjtaKvKWE1Qw4yYa/umxCFMsmha4EEmzEbyKR8EQqck8Ap5uXkc=
X-Gm-Gg: ASbGnctp5Ryi+l9FBJ27DKydgktq1Crst0eJHZ5IRC3ODdLAezL2D2DhpBMX4myeAy2
	FAz8/qEF3yo2qB1hzbGmLOdxYMykwG9FpIZzrWaty3gv0/rm5F0JfUy5mSnAShV+txF5T3ZumSy
	INshHGYnZIi5meeUe2I5mPcPIfhmt9qn9h40o84UlPwLKykWSOKfLpkhs28gsTBnjq0ekIHkMBO
	E4Fj4/QYOlSu8B/i7fnEFzEN+kjIrJyIS1qIDXk3jWQps6voaA+oBuon7XzPnn7/RQzyYPA2DWR
	QSHjJ/gMuaFm0nJo25gfxolHpTnkSH003Z6DrbgHuuRe8dmgy+Eb1n9Kn2xsqebkysoTlWik8Uf
	GFu74t4mNF8cmys1D9fgOZR7ThNwYBQ==
X-Google-Smtp-Source: AGHT+IGZFgkatUwd5pWgCV0TZaCErLH8Y+F35AINecBPyk3TXs9Ccww4XoxGRNH0aYE4YRF/Gl4C2A==
X-Received: by 2002:a05:6820:c85:b0:613:cb90:21c with SMTP id 006d021491bc7-613e6015f92mr9732936eaf.8.1752519965067;
        Mon, 14 Jul 2025 12:06:05 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9d6d51bsm1169531eaf.5.2025.07.14.12.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:06:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:06:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Eric Woudstra <ericwouds@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: Re: [PATCH v13 nf-next 1/3] netfilter: utils: nf_checksum(_partial)
 correct data!=networkheader
Message-ID: <e70e50e8-9419-4ca0-b65d-dbf4869a5d89@suswa.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704191135.1815969-2-ericwouds@gmail.com>

Hi Eric,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Woudstra/netfilter-utils-nf_checksum-_partial-correct-data-networkheader/20250705-031418
base:   https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
patch link:    https://lore.kernel.org/r/20250704191135.1815969-2-ericwouds%40gmail.com
patch subject: [PATCH v13 nf-next 1/3] netfilter: utils: nf_checksum(_partial) correct data!=networkheader
config: x86_64-randconfig-r071-20250706 (https://download.01.org/0day-ci/archive/20250706/202507061710.RCwA4Kjw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507061710.RCwA4Kjw-lkp@intel.com/

smatch warnings:
net/netfilter/utils.c:131 nf_checksum() warn: signedness bug returning '(-12)'
net/netfilter/utils.c:155 nf_checksum_partial() warn: signedness bug returning '(-12)'

vim +131 net/netfilter/utils.c

ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  123  __sum16 nf_checksum(struct sk_buff *skb, unsigned int hook,
                                                  ^^^^^^^
ebee5a50d0b7cd Florian Westphal  2018-06-25  124  		    unsigned int dataoff, u8 protocol,
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  125  		    unsigned short family)
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  126  {
39644744ee13d9 Eric Woudstra     2025-07-04  127  	unsigned int nhpull = skb_network_header(skb) - skb->data;
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  128  	__sum16 csum = 0;
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  129  
39644744ee13d9 Eric Woudstra     2025-07-04  130  	if (!pskb_may_pull(skb, nhpull))
39644744ee13d9 Eric Woudstra     2025-07-04 @131  		return -ENOMEM;

This -ENOMEM doesn't work because the return type is u16.

39644744ee13d9 Eric Woudstra     2025-07-04  132  	__skb_pull(skb, nhpull);
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  133  	switch (family) {
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  134  	case AF_INET:
39644744ee13d9 Eric Woudstra     2025-07-04  135  		csum = nf_ip_checksum(skb, hook, dataoff - nhpull, protocol);
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  136  		break;
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  137  	case AF_INET6:
39644744ee13d9 Eric Woudstra     2025-07-04  138  		csum = nf_ip6_checksum(skb, hook, dataoff - nhpull, protocol);
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  139  		break;
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  140  	}
39644744ee13d9 Eric Woudstra     2025-07-04  141  	__skb_push(skb, nhpull);
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  142  
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  143  	return csum;
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  144  }
ef71fe27ec2f16 Pablo Neira Ayuso 2017-11-27  145  EXPORT_SYMBOL_GPL(nf_checksum);
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  146  
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  147  __sum16 nf_checksum_partial(struct sk_buff *skb, unsigned int hook,
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  148  			    unsigned int dataoff, unsigned int len,
ebee5a50d0b7cd Florian Westphal  2018-06-25  149  			    u8 protocol, unsigned short family)
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  150  {
39644744ee13d9 Eric Woudstra     2025-07-04  151  	unsigned int nhpull = skb_network_header(skb) - skb->data;
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  152  	__sum16 csum = 0;
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  153  
39644744ee13d9 Eric Woudstra     2025-07-04  154  	if (!pskb_may_pull(skb, nhpull))
39644744ee13d9 Eric Woudstra     2025-07-04 @155  		return -ENOMEM;

Same.

39644744ee13d9 Eric Woudstra     2025-07-04  156  	__skb_pull(skb, nhpull);
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  157  	switch (family) {
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  158  	case AF_INET:
39644744ee13d9 Eric Woudstra     2025-07-04  159  		csum = nf_ip_checksum_partial(skb, hook, dataoff - nhpull,
39644744ee13d9 Eric Woudstra     2025-07-04  160  					      len, protocol);
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  161  		break;
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  162  	case AF_INET6:
39644744ee13d9 Eric Woudstra     2025-07-04  163  		csum = nf_ip6_checksum_partial(skb, hook, dataoff - nhpull,
39644744ee13d9 Eric Woudstra     2025-07-04  164  					       len, protocol);
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  165  		break;
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  166  	}
39644744ee13d9 Eric Woudstra     2025-07-04  167  	__skb_push(skb, nhpull);
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  168  
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  169  	return csum;
f7dcbe2f36a660 Pablo Neira Ayuso 2017-12-20  170  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


