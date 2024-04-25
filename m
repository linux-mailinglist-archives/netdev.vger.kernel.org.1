Return-Path: <netdev+bounces-91198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857F98B1A59
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 07:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93921C20CCE
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA00D3BB24;
	Thu, 25 Apr 2024 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHaBAZ62"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E4B3A268
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714023150; cv=none; b=G5871+F0nEPg1V17SjKnQoSpojpIRFBQHLqDbPGpdDUpCNDsOQZGiqS1h1A6jbqN19QQFcc1t5Eba/6gBAk2MSRWKxSuUduKepFJGXWk4ca7gIK2ag46m6ZHqLgcXAlNVBQMdsj1Nn9a4qwAKz1wvSETx/aIZ4vN60l3k06QPUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714023150; c=relaxed/simple;
	bh=PZ3JE39u85K0M0rv3SLGJ0Dq4lCTndTsCLjSWF9nMbI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KswgInmT1ds9uDW/tI6jYBjqRmldKRYw4TNULC4f5S/GfHK7M8spONxumAoE4lXV2LLyUrSlGu/bvFvpk38v9AXsa5VtRNSITbwUhgZgkSXTgZ2KXoiVWtR1tSJkl3Jz0/+kph3JQOMyDpecx0ojXlSbmbqEACnNoWNpyOKO0+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NHaBAZ62; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b3fa5163bso2639235e9.0
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 22:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714023147; x=1714627947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UdTZwuYXM16Mj2k9VkrP5ulubcWPQ9dmOEwxsHwpBnQ=;
        b=NHaBAZ62bk6jXp2OIC1PDENEx7e+/r2Uc+VATONo7g5JRu09FF5xuW8mk8oRjZE1DS
         yD4Rli6ZqLPrqzC3sGMTwlK3Jvd+iLmlUMNXmUTxnB5Gp7h2khLwBQwDivrpNJTey0X2
         lfbOAEra2RjqUkhdbzeZ4K+cjhmEEyEognNbHP9h8DS7ipSB68Ev/IDIL+GD4LRVCRg6
         /k81ecVpH3kRK+SJ7jNnmMdmMYDV9ga95wa2nZzhUXvTOGGesmEy4cC+nt0c5y9sZ2z2
         70VrAl+NPFGwVCZok/9Iz0Arj6XV0PzunYu3LpX1c5RM/OXBSI3gzr/Pk0hPlcwkbJyg
         6kqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714023147; x=1714627947;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdTZwuYXM16Mj2k9VkrP5ulubcWPQ9dmOEwxsHwpBnQ=;
        b=MvqsdoiFS35PAEymeXB/Gs8mR723+U3HNn907UTrFxU20z4hsyaxzjMIIXIL6vEC8L
         7ySUJctxsuRMV9L3dpsV/FS2XaNb6imUjBb7dJ/HQGvWK6IZNL99UW0vTEA8/Ettjm7L
         MkI/8r9wTeNikv9XWbVUgj+YDIUq4e7++yuOaDNLVgGLghSxojxy8r/v9lLGGkEuHBZ3
         w7B8bYI5GtMD5fcxRkuv8XyGLTYjLU8RXHGsLwZ1Ln7TPCOyHQkpHSUqKoJkmjeyRZUY
         aW+r0ZBc5ZoPc8zrVzgZQPkyZqc5MSV7rlHuAx7bj1KHSFC45eVlNUkK1x0cuL8R1wix
         0itw==
X-Forwarded-Encrypted: i=1; AJvYcCXMad/5xkzu6n93RM3Sr0Kl/RbK6XInOWJew3lS9APTGjlHSlWlQzlLz31+TNgov8LvQsLICjl8iDrMdwzWasftUY96tAJ2
X-Gm-Message-State: AOJu0YyisXK8bsF9lEI4LxDrU//ZZwLFpP95TYqUx6LbPB3FIr/QfyhV
	tWOq1ktlJGZB8Z70F9kQa657RGoqYtmxLm85/dS+ZA1o8hcj7SWBlX+uBXxelHo8b+m+8kQfgl4
	M
X-Google-Smtp-Source: AGHT+IGtnxLdTXO/d17U7QCLeydtbuZFyhcdeuIE7hEySyeMHNs3CFGJBnzsof5+CO3kLG2KnU41vw==
X-Received: by 2002:a05:600c:154f:b0:418:e08c:817 with SMTP id f15-20020a05600c154f00b00418e08c0817mr3027255wmg.32.1714023147171;
        Wed, 24 Apr 2024 22:32:27 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id q12-20020adfcd8c000000b00343cad2a4d3sm18702534wrj.18.2024.04.24.22.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 22:32:26 -0700 (PDT)
Date: Thu, 25 Apr 2024 08:32:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 5/6] arp: Get dev after calling
 arp_req_(delete|set|get)().
Message-ID: <047e4452-c694-4dea-9273-74ebc3a2892c@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422194755.4221-6-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/arp-Move-ATF_COM-setting-in-arp_req_set/20240423-035458
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240422194755.4221-6-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 5/6] arp: Get dev after calling arp_req_(delete|set|get)().
config: i386-randconfig-141-20240424 (https://download.01.org/0day-ci/archive/20240425/202404251215.QHgck00A-lkp@intel.com/config)
compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202404251215.QHgck00A-lkp@intel.com/

smatch warnings:
net/ipv4/arp.c:1242 arp_req_delete() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +1242 net/ipv4/arp.c

8f4429edb1b716 Kuniyuki Iwashima 2024-04-22  1235  static int arp_req_delete(struct net *net, struct arpreq *r)
46479b432989d6 Pavel Emelyanov   2007-12-05  1236  {
8f4429edb1b716 Kuniyuki Iwashima 2024-04-22  1237  	struct net_device *dev;
46479b432989d6 Pavel Emelyanov   2007-12-05  1238  	__be32 ip;
46479b432989d6 Pavel Emelyanov   2007-12-05  1239  
8f4429edb1b716 Kuniyuki Iwashima 2024-04-22  1240  	dev = arp_req_dev(net, r);
8f4429edb1b716 Kuniyuki Iwashima 2024-04-22  1241  	if (!IS_ERR(dev))

The ! is not supposed to be there.

8f4429edb1b716 Kuniyuki Iwashima 2024-04-22 @1242  		return PTR_ERR(dev);
8f4429edb1b716 Kuniyuki Iwashima 2024-04-22  1243  
46479b432989d6 Pavel Emelyanov   2007-12-05  1244  	if (r->arp_flags & ATF_PUBL)
32e569b7277f13 Pavel Emelyanov   2007-12-16  1245  		return arp_req_delete_public(net, r, dev);
46479b432989d6 Pavel Emelyanov   2007-12-05  1246  
46479b432989d6 Pavel Emelyanov   2007-12-05  1247  	ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
8f4429edb1b716 Kuniyuki Iwashima 2024-04-22  1248  
0c51e12e218f20 Ido Schimmel      2022-02-19  1249  	return arp_invalidate(dev, ip, true);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1250  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


