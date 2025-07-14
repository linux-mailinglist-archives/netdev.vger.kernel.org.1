Return-Path: <netdev+bounces-206838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7125B047CC
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 21:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606C94E2BC2
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 19:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6342222D2;
	Mon, 14 Jul 2025 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVWiQLzw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063B1D63EF
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752520575; cv=none; b=J8jRK6yrAWPXJBpzYfb939dirJQgwzhoMSOySihJV0OUHeBwcIwj7sW5D1Kj9q59evD72Uvhczw6oqwgxQ0lz3GYWq/aHekenI4EemIWMh5l1WYpzryuHcyWSclR8SVIMLyu28g4SPAWpIjcViXkRHAYn+b52SzxsQ5ta2Xcpaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752520575; c=relaxed/simple;
	bh=ExDnrFktU6LuZLYRsv0xzh0D0ij8XsepJ7UCVkDeD/U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jasQtJnUWStB00X2VwTCOCq7d8tPTIVf2Tc47GOTTU28jJAmkyoR4Mp6v8Y34Wp/cR4eeaSz6hZUzoFufOrMgiPPrcdyJEmpT0CdnkXcY6YkVKTyrcMaeOClOvep6uFDWr2DwWGwjGtZrbWWrukPPGa3/gvN3hYxufr71f733YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VVWiQLzw; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-41b6561d3c6so97773b6e.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752520572; x=1753125372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=quK8ZaMkVwSlhBi2jTInQf7Pwr7hnMJ4C8UE3Xp8UNc=;
        b=VVWiQLzwwPSaYPmcbD6YM32q8stKD1PuEfo1d8qxAjYJfVIxcUqMbkCGndlM4jwb/w
         V4siWah72Mw5ueDI8vFiNwDYStdEtpsRIMMwUO859PJ8P8oBCXk0Y+MEbus793EsL1Zu
         auV6loQX/4OCa9JXpYpg+zOv2mHym097eZlV4WrnmX+TR3UORALs468en+mw/wf+JZ0U
         8KrnIt3IUNaKWAfAd/Qz267bKbQvzjCoG2fkMaxYyCG8G0dinXFgVDBDn1vGxzAuwLty
         Fn773xbKYnTtKqCLx8tsCU2hw3kNzyYj7E8bTfD5cK8ZTMbLKCdYth1P72Oh756XqQrQ
         Oosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752520572; x=1753125372;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quK8ZaMkVwSlhBi2jTInQf7Pwr7hnMJ4C8UE3Xp8UNc=;
        b=bp9i2xv6okgtMhZpg2xIoCI7kcL2n7X3ueyYJHOFlk49rcJ+lsU03v6zEERR4919u0
         H9vbTnG0tqFxFNoiTlIASM8I352lFYbLfjS81DbHCAM7Cbz0PZu7nfANRJXisRXsNF2s
         UWT4mE3tEzjGBjn+OMcyH64O07ZYraU0SD7dIzDq8/otAijKC9gpFoPmza/arrzixrkl
         S0Zt6kyeLUTrEU7qpkZtoOcqRmTVJZyq7ne2O0a/Sr/kqGsVNVqkaUzJzI59FfeS6Fw5
         nKvgm2i2cy5W3mE0PT5DLaDNETth0EX7AFF5fX1x+3ImYQqDH6FXwTn1G2eCzVlraIIP
         AStg==
X-Forwarded-Encrypted: i=1; AJvYcCVe94SpUlv1JrFRM/MCl4glwOQ2wVcZ0vMryDVcoTY2s+tKZU8Iz86XRfYCO2gO3WWbcjYRB8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvUnCT29UHzLhOBoWWIubxBswmT5DqZhBXYBoYrPmgXBTd24w6
	FYZ4Kdpc/3yN8FX66zSP9nTvlMKXy82U8CeympCZG7ARV3oO8z8Y/Inqa8ilrrDDSdw=
X-Gm-Gg: ASbGncvYIAcvjyPTMBOalkk7t0Xo/n5B5vlk4pTKqHzOsG4YEDrU0JUvLIv2dUIy2IR
	2HRx7qimcNgqGjOa8EvVlhYx7SpnvwX04f/Eok691VF1emd8ocHqxrEEA82HacTxefA6FBW81LQ
	e/8t5dcDP8qJHjdoXfP4ba8wKKJYUKHRrGjZxsnlTNQYbuHjX9D/0mfwpE/ZgXHpuIoFDwocDtJ
	c9EeHMbxwvuoN5uLW7NGlf6mHdqx1KWsbm6EGZqMSaE4KYPGWUyOdEw8sYz1e3s67ohBQ6aByBD
	SdMNEfl68unjQXv8OcwzewNYsFS5ye6A4NRMbC2OBAqr0ezK8RNpXIrKgZkLDgnuEhaI2ftTEt8
	va3xVBTnsEIK5pgxGFV9QRjonRLAh+A==
X-Google-Smtp-Source: AGHT+IHBy9VWsoNVmD9Rbu7Fg9mDR5xD97fPNPQTUeW2MwfmoXbz4wuLLK9E6ELhEMvqF4ydV2rewQ==
X-Received: by 2002:a05:6808:1b98:b0:40b:9bd2:460e with SMTP id 5614622812f47-41baa87a1e0mr59840b6e.22.1752520572157;
        Mon, 14 Jul 2025 12:16:12 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-414191e561esm1633700b6e.11.2025.07.14.12.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:16:11 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:16:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Matt Johnston <matt@codeconstruct.com.au>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Matt Johnston <matt@codeconstruct.com.au>
Subject: Re: [PATCH net-next 5/7] net: mctp: Allow limiting binds to a peer
 address
Message-ID: <a51b1a51-8ff6-4607-b783-1944d324359d@suswa.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-mctp-bind-v1-5-bb7e97c24613@codeconstruct.com.au>

Hi Matt,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Matt-Johnston/net-mctp-Prevent-duplicate-binds/20250703-171427
base:   8b98f34ce1d8c520403362cb785231f9898eb3ff
patch link:    https://lore.kernel.org/r/20250703-mctp-bind-v1-5-bb7e97c24613%40codeconstruct.com.au
patch subject: [PATCH net-next 5/7] net: mctp: Allow limiting binds to a peer address
config: i386-randconfig-r072-20250708 (https://download.01.org/0day-ci/archive/20250708/202507080554.pDP37MtV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507080554.pDP37MtV-lkp@intel.com/

smatch warnings:
net/mctp/af_mctp.c:122 mctp_bind() warn: inconsistent returns 'sk'.

vim +/sk +122 net/mctp/af_mctp.c

8f601a1e4f8c84f Jeremy Kerr          2021-07-29   52  static int mctp_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
8f601a1e4f8c84f Jeremy Kerr          2021-07-29   53  {
833ef3b91de692e Jeremy Kerr          2021-07-29   54  	struct sock *sk = sock->sk;
833ef3b91de692e Jeremy Kerr          2021-07-29   55  	struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
848674f9a3c762e Matt Johnston        2025-07-03   56  	struct net *net = sock_net(&msk->sk);
833ef3b91de692e Jeremy Kerr          2021-07-29   57  	struct sockaddr_mctp *smctp;
833ef3b91de692e Jeremy Kerr          2021-07-29   58  	int rc;
833ef3b91de692e Jeremy Kerr          2021-07-29   59  
833ef3b91de692e Jeremy Kerr          2021-07-29   60  	if (addrlen < sizeof(*smctp))
833ef3b91de692e Jeremy Kerr          2021-07-29   61  		return -EINVAL;
833ef3b91de692e Jeremy Kerr          2021-07-29   62  
833ef3b91de692e Jeremy Kerr          2021-07-29   63  	if (addr->sa_family != AF_MCTP)
833ef3b91de692e Jeremy Kerr          2021-07-29   64  		return -EAFNOSUPPORT;
833ef3b91de692e Jeremy Kerr          2021-07-29   65  
833ef3b91de692e Jeremy Kerr          2021-07-29   66  	if (!capable(CAP_NET_BIND_SERVICE))
833ef3b91de692e Jeremy Kerr          2021-07-29   67  		return -EACCES;
833ef3b91de692e Jeremy Kerr          2021-07-29   68  
833ef3b91de692e Jeremy Kerr          2021-07-29   69  	/* it's a valid sockaddr for MCTP, cast and do protocol checks */
833ef3b91de692e Jeremy Kerr          2021-07-29   70  	smctp = (struct sockaddr_mctp *)addr;
833ef3b91de692e Jeremy Kerr          2021-07-29   71  
1e4b50f06d970d8 Eugene Syromiatnikov 2021-11-03   72  	if (!mctp_sockaddr_is_ok(smctp))
1e4b50f06d970d8 Eugene Syromiatnikov 2021-11-03   73  		return -EINVAL;
1e4b50f06d970d8 Eugene Syromiatnikov 2021-11-03   74  
833ef3b91de692e Jeremy Kerr          2021-07-29   75  	lock_sock(sk);
                                                        ^^^^^^^^^^^^^^
locked

833ef3b91de692e Jeremy Kerr          2021-07-29   76  
833ef3b91de692e Jeremy Kerr          2021-07-29   77  	if (sk_hashed(sk)) {
833ef3b91de692e Jeremy Kerr          2021-07-29   78  		rc = -EADDRINUSE;
833ef3b91de692e Jeremy Kerr          2021-07-29   79  		goto out_release;
833ef3b91de692e Jeremy Kerr          2021-07-29   80  	}
848674f9a3c762e Matt Johnston        2025-07-03   81  
d58bad174be0c4b Matt Johnston        2025-07-03   82  	msk->bind_local_addr = smctp->smctp_addr.s_addr;
848674f9a3c762e Matt Johnston        2025-07-03   83  
848674f9a3c762e Matt Johnston        2025-07-03   84  	/* MCTP_NET_ANY with a specific EID is resolved to the default net
848674f9a3c762e Matt Johnston        2025-07-03   85  	 * at bind() time.
848674f9a3c762e Matt Johnston        2025-07-03   86  	 * For bind_addr=MCTP_ADDR_ANY it is handled specially at route lookup time.
848674f9a3c762e Matt Johnston        2025-07-03   87  	 */
848674f9a3c762e Matt Johnston        2025-07-03   88  	if (smctp->smctp_network == MCTP_NET_ANY &&
d58bad174be0c4b Matt Johnston        2025-07-03   89  	    msk->bind_local_addr != MCTP_ADDR_ANY) {
848674f9a3c762e Matt Johnston        2025-07-03   90  		msk->bind_net = mctp_default_net(net);
848674f9a3c762e Matt Johnston        2025-07-03   91  	} else {
848674f9a3c762e Matt Johnston        2025-07-03   92  		msk->bind_net = smctp->smctp_network;
848674f9a3c762e Matt Johnston        2025-07-03   93  	}
848674f9a3c762e Matt Johnston        2025-07-03   94  
d58bad174be0c4b Matt Johnston        2025-07-03   95  	/* ignore the IC bit */
d58bad174be0c4b Matt Johnston        2025-07-03   96  	smctp->smctp_type &= 0x7f;
d58bad174be0c4b Matt Johnston        2025-07-03   97  
d58bad174be0c4b Matt Johnston        2025-07-03   98  	if (msk->bind_peer_set) {
d58bad174be0c4b Matt Johnston        2025-07-03   99  		if (msk->bind_type != smctp->smctp_type) {
d58bad174be0c4b Matt Johnston        2025-07-03  100  			/* Prior connect() had a different type */
d58bad174be0c4b Matt Johnston        2025-07-03  101  			return -EINVAL;

goto out_release?

d58bad174be0c4b Matt Johnston        2025-07-03  102  		}
d58bad174be0c4b Matt Johnston        2025-07-03  103  
d58bad174be0c4b Matt Johnston        2025-07-03  104  		if (msk->bind_net == MCTP_NET_ANY) {
d58bad174be0c4b Matt Johnston        2025-07-03  105  			/* Restrict to the network passed to connect() */
d58bad174be0c4b Matt Johnston        2025-07-03  106  			msk->bind_net = msk->bind_peer_net;
d58bad174be0c4b Matt Johnston        2025-07-03  107  		}
d58bad174be0c4b Matt Johnston        2025-07-03  108  
d58bad174be0c4b Matt Johnston        2025-07-03  109  		if (msk->bind_net != msk->bind_peer_net) {
d58bad174be0c4b Matt Johnston        2025-07-03  110  			/* connect() had a different net to bind() */
d58bad174be0c4b Matt Johnston        2025-07-03  111  			return -EINVAL;

same.

d58bad174be0c4b Matt Johnston        2025-07-03  112  		}
d58bad174be0c4b Matt Johnston        2025-07-03  113  	} else {
d58bad174be0c4b Matt Johnston        2025-07-03  114  		msk->bind_type = smctp->smctp_type;
d58bad174be0c4b Matt Johnston        2025-07-03  115  	}
833ef3b91de692e Jeremy Kerr          2021-07-29  116  
833ef3b91de692e Jeremy Kerr          2021-07-29  117  	rc = sk->sk_prot->hash(sk);
833ef3b91de692e Jeremy Kerr          2021-07-29  118  
833ef3b91de692e Jeremy Kerr          2021-07-29  119  out_release:
833ef3b91de692e Jeremy Kerr          2021-07-29  120  	release_sock(sk);
833ef3b91de692e Jeremy Kerr          2021-07-29  121  
833ef3b91de692e Jeremy Kerr          2021-07-29 @122  	return rc;
8f601a1e4f8c84f Jeremy Kerr          2021-07-29  123  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


