Return-Path: <netdev+bounces-54811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BBF80854E
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 11:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713B01F21183
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 10:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86FF358A7;
	Thu,  7 Dec 2023 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RWTKAnCG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F1AA5
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 02:17:14 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1915034144so93977166b.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 02:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701944233; x=1702549033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sqU0iJMgtVnLb9+QVNHOqoSok7HnTOuiW3/J1xiXsw8=;
        b=RWTKAnCGRQodeMUovshGrHtfneqoBMZggqxfjeF0tivlSzTqQzdFDuDJBDtsFMaJ4L
         gAdkdovhy4qzaHz0wiZ4QIRpqHYTLThgjZe8dmpJb9YMT6oRc5IySg/CJCQSgSO0qkuE
         jh07ByVezoyJfkH0D0qmv8ItMPuVgz+9D7W7MbgFCC+l5gcLNJkXqNn6QRKQstpMu2LS
         NGt6gn1dR5UrD1ubsPfc6yobrlRoUleqZGtVyl2X1c4fFH2IjL9koSLkbL5/GbU5MJtV
         r4LULqubhaS0CqCZEI4ebjtKgDk9xer6ELVLGwuiqrwz+kK0tAO7aRJ1mitfKOM8Bu62
         mv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701944233; x=1702549033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqU0iJMgtVnLb9+QVNHOqoSok7HnTOuiW3/J1xiXsw8=;
        b=RbvzbCYIOqTwQI9s7twnKgxUlrsiiPzfAMQESdbVANmtJN/UVTGPtEzv+fm36fwQ3R
         ctuRwKdbG6KOQk1FxhkCh+GEymhLpFnPYbAS0Iyg9mVbPSwhRu6kItTNfO//yOmvb4iy
         34IdyDvlAt5IiQbZ1mWeRhP5EjvTaR/DwIKHSbPPGs6b9qFVtBAT/JhP1LLicBb6VsU+
         kjPuK/QWZO6MQwtpz9WmBmQRIrMUzC8CkGl1wVQhGlqDCcA2alEpqWqv4gnYZXHQC7bi
         MOO27iyg+uu5U0h/s46M9j1S6bXWIM6nAsEX/G1SBPQg3xWSjPCzoU4nEn0gjMyxaN+o
         ATWg==
X-Gm-Message-State: AOJu0YwP2/1StresN17yP4NlJ2f6lKmcpiE/6hbo9QP90YWMVzJiVUR5
	gaKFpYQ7DHl3db5ltSvFmTmUEw==
X-Google-Smtp-Source: AGHT+IEL42s6sXkCZBIVNWedah2iJOsv4SPrMisvele75QErvdWyTV9yeWlIGBU2jw3Wl4tGThsKKw==
X-Received: by 2002:a17:906:7497:b0:a1d:a9a:70fd with SMTP id e23-20020a170906749700b00a1d0a9a70fdmr1582587ejl.1.1701944232580;
        Thu, 07 Dec 2023 02:17:12 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709063e1700b00a1db8b08610sm630227eji.148.2023.12.07.02.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 02:17:11 -0800 (PST)
Date: Thu, 7 Dec 2023 11:17:10 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, nhorman@tuxdriver.com,
	yotam.gi@gmail.com, johannes@sipsolutions.net,
	jacob.e.keller@intel.com, horms@kernel.org,
	andriy.shevchenko@linux.intel.com, jhs@mojatatu.com
Subject: Re: [PATCH net 1/2] psample: Require 'CAP_NET_ADMIN' when joining
 "packets" group
Message-ID: <ZXGbptl6uCNxR+3W@nanopsycho>
References: <20231206213102.1824398-1-idosch@nvidia.com>
 <20231206213102.1824398-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206213102.1824398-2-idosch@nvidia.com>

Wed, Dec 06, 2023 at 10:31:01PM CET, idosch@nvidia.com wrote:
>The "psample" generic netlink family notifies sampled packets over the
>"packets" multicast group. This is problematic since by default generic
>netlink allows non-root users to listen to these notifications.
>
>Fix by marking the group with the 'GENL_UNS_ADMIN_PERM' flag. This will
>prevent non-root users or root without the 'CAP_NET_ADMIN' capability
>(in the user namespace owning the network namespace) from joining the
>group.
>
>Tested using [1].
>
>Before:
>
> # capsh -- -c ./psample_repo
> # capsh --drop=cap_net_admin -- -c ./psample_repo
>
>After:
>
> # capsh -- -c ./psample_repo
> # capsh --drop=cap_net_admin -- -c ./psample_repo
> Failed to join "packets" multicast group
>
>[1]
> $ cat psample.c
> #include <stdio.h>
> #include <netlink/genl/ctrl.h>
> #include <netlink/genl/genl.h>
> #include <netlink/socket.h>
>
> int join_grp(struct nl_sock *sk, const char *grp_name)
> {
> 	int grp, err;
>
> 	grp = genl_ctrl_resolve_grp(sk, "psample", grp_name);
> 	if (grp < 0) {
> 		fprintf(stderr, "Failed to resolve \"%s\" multicast group\n",
> 			grp_name);
> 		return grp;
> 	}
>
> 	err = nl_socket_add_memberships(sk, grp, NFNLGRP_NONE);
> 	if (err) {
> 		fprintf(stderr, "Failed to join \"%s\" multicast group\n",
> 			grp_name);
> 		return err;
> 	}
>
> 	return 0;
> }
>
> int main(int argc, char **argv)
> {
> 	struct nl_sock *sk;
> 	int err;
>
> 	sk = nl_socket_alloc();
> 	if (!sk) {
> 		fprintf(stderr, "Failed to allocate socket\n");
> 		return -1;
> 	}
>
> 	err = genl_connect(sk);
> 	if (err) {
> 		fprintf(stderr, "Failed to connect socket\n");
> 		return err;
> 	}
>
> 	err = join_grp(sk, "config");
> 	if (err)
> 		return err;
>
> 	err = join_grp(sk, "packets");
> 	if (err)
> 		return err;
>
> 	return 0;
> }
> $ gcc -I/usr/include/libnl3 -lnl-3 -lnl-genl-3 -o psample_repo psample.c
>
>Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
>Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
>Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

