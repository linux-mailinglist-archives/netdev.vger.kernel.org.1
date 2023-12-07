Return-Path: <netdev+bounces-54812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7662680854F
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 11:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D21F210C5
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 10:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF683358AC;
	Thu,  7 Dec 2023 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ai+/pfcL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E169A4
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 02:17:27 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54cde11d0f4so1070370a12.2
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 02:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701944246; x=1702549046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QKcdfQaRJ2HeU5FDIIxeWAcQe/nkkksmniRilXK8xs0=;
        b=ai+/pfcL1m/owWwkuSzWE/AQj9mi15AvE5+33CGTK+4Xpd5huI4WW8bplfNHCmBjTa
         fWqA2uOekm7cJDbdSjMDcPYPy7iXkOcUs15/hQO7sGmDUwBsDSeyNOFKlB39RngfqKCV
         lOHvAtY1QRuy3jYQd+57RtOFZ0Whw4IAYI3k/+//KqrOQEX835ZxyS5Ib/S530mceWVP
         pE0FZ4e89PhVMKKtn72Wc0phPfWKIT7zUKkj8zvSuXvep/PMktIqiT4uAkGawe1fd8ox
         bR/SUae4ZuDfngdY75nhkNjjoreO7M2cCOXlDJScBsh6zf60TEEOLeDyzRG1EhZBOBWe
         EGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701944246; x=1702549046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKcdfQaRJ2HeU5FDIIxeWAcQe/nkkksmniRilXK8xs0=;
        b=RapAB7aWHQFd0ax8CXKUnLYV5IYMdN/nv/U72YKeBNAYCgt1aO9/P7iRAUFEWy/9p9
         lSBHDhU94aPe2jSYdX3++gmHyPHjsPMMN0I1m3o+oioDS0n+U8cu3ftp2KZxlV9ZSrKe
         /zDFs5HK7bIuzJA/w1iqJNjsOhUJvREixJke7Z2CiBub73PbRrH4o6edPsNiBGfEFoUD
         2IXdL1RHeFjNzgrxFvGeMClI7whi+17X/LtTzNsNHJpJwtej7+LNuuIT3zI1stPLAx44
         xh7jVtKraG16bzWuoQYbOmVTwaENZFeLfi6/7dQgI7nelYcGoudb+BOZczhVDhLRDVUU
         vs0w==
X-Gm-Message-State: AOJu0Yz3WDAh4XINjlhoEoUTn2Xz5xHwfheoUGC/kg2XC0lvZqHVFfqy
	SIXhDyCO9MvhSrPtJwiAivjUKQ==
X-Google-Smtp-Source: AGHT+IGXkBgiZeBXibaGf3qxGWZ/gZxeudqIMlQP9bovLDk7Et3Mt8d4cKgxV6cevO5GxCgN+9kuoQ==
X-Received: by 2002:a17:906:3c4f:b0:a1d:4235:5b65 with SMTP id i15-20020a1709063c4f00b00a1d42355b65mr1393500ejg.76.1701944245900;
        Thu, 07 Dec 2023 02:17:25 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q5-20020a1709060e4500b00a1d17c92ef3sm626900eji.51.2023.12.07.02.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 02:17:25 -0800 (PST)
Date: Thu, 7 Dec 2023 11:17:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, nhorman@tuxdriver.com,
	yotam.gi@gmail.com, johannes@sipsolutions.net,
	jacob.e.keller@intel.com, horms@kernel.org,
	andriy.shevchenko@linux.intel.com, jhs@mojatatu.com
Subject: Re: [PATCH net 2/2] drop_monitor: Require 'CAP_SYS_ADMIN' when
 joining "events" group
Message-ID: <ZXGbtNjyU1N1jtJ3@nanopsycho>
References: <20231206213102.1824398-1-idosch@nvidia.com>
 <20231206213102.1824398-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206213102.1824398-3-idosch@nvidia.com>

Wed, Dec 06, 2023 at 10:31:02PM CET, idosch@nvidia.com wrote:
>The "NET_DM" generic netlink family notifies drop locations over the
>"events" multicast group. This is problematic since by default generic
>netlink allows non-root users to listen to these notifications.
>
>Fix by adding a new field to the generic netlink multicast group
>structure that when set prevents non-root users or root without the
>'CAP_SYS_ADMIN' capability (in the user namespace owning the network
>namespace) from joining the group. Set this field for the "events"
>group. Use 'CAP_SYS_ADMIN' rather than 'CAP_NET_ADMIN' because of the
>nature of the information that is shared over this group.
>
>Note that the capability check in this case will always be performed
>against the initial user namespace since the family is not netns aware
>and only operates in the initial network namespace.
>
>A new field is added to the structure rather than using the "flags"
>field because the existing field uses uAPI flags and it is inappropriate
>to add a new uAPI flag for an internal kernel check. In net-next we can
>rework the "flags" field to use internal flags and fold the new field
>into it. But for now, in order to reduce the amount of changes, add a
>new field.
>
>Since the information can only be consumed by root, mark the control
>plane operations that start and stop the tracing as root-only using the
>'GENL_ADMIN_PERM' flag.
>
>Tested using [1].
>
>Before:
>
> # capsh -- -c ./dm_repo
> # capsh --drop=cap_sys_admin -- -c ./dm_repo
>
>After:
>
> # capsh -- -c ./dm_repo
> # capsh --drop=cap_sys_admin -- -c ./dm_repo
> Failed to join "events" multicast group
>
>[1]
> $ cat dm.c
> #include <stdio.h>
> #include <netlink/genl/ctrl.h>
> #include <netlink/genl/genl.h>
> #include <netlink/socket.h>
>
> int main(int argc, char **argv)
> {
> 	struct nl_sock *sk;
> 	int grp, err;
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
> 	grp = genl_ctrl_resolve_grp(sk, "NET_DM", "events");
> 	if (grp < 0) {
> 		fprintf(stderr,
> 			"Failed to resolve \"events\" multicast group\n");
> 		return grp;
> 	}
>
> 	err = nl_socket_add_memberships(sk, grp, NFNLGRP_NONE);
> 	if (err) {
> 		fprintf(stderr, "Failed to join \"events\" multicast group\n");
> 		return err;
> 	}
>
> 	return 0;
> }
> $ gcc -I/usr/include/libnl3 -lnl-3 -lnl-genl-3 -o dm_repo dm.c
>
>Fixes: 9a8afc8d3962 ("Network Drop Monitor: Adding drop monitor implementation & Netlink protocol")
>Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
>Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

