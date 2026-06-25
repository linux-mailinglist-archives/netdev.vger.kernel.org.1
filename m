Return-Path: <netdev+bounces-301865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jx3INfXCPGoarggAu9opvQ
	(envelope-from <netdev+bounces-301865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 07:56:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3233A6C2DD8
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 07:56:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=a61pJqeg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301865-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301865-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ED89302EEB5
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 05:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089B83BCD26;
	Thu, 25 Jun 2026 05:56:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6121638D
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 05:56:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366962; cv=pass; b=WAlNZK8QiIjIrigBOE7M5WgV1ponwZMb6In65qlxOkJZAqdtppsM4A6gQMptQdYzr4C8OmyBX+Uib3BcvzzADuXIK+cIZe4YpYkHQW4zaOnv0SeNs1Ikm5I3tdAgVGzNVeg+rKgx4j+ALyYWkexj/5Q28E5gPsJrXhg+5RQKlr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366962; c=relaxed/simple;
	bh=ZqgMKC+YW8/szECOHd4rSP7xK1qbOm4+sRInDPe1kWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiLOen8ta9/HWLuQnATdxdzSWudhh3XyW/V1ub9a+6KTgUvSGSHPFHO5zR/pdoqQI3bvcyg9VazQect/6T15IxRDYD+BhuUHxPiQhXoAYeAEM+JNb0WRNeVq3A+HV8rdQK+D42Dt1aMqyrsjUb0qVPTL/fL1h5FVBlW6shg7j4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a61pJqeg; arc=pass smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c11ff0c5e43so90147866b.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 22:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782366960; cv=none;
        d=google.com; s=arc-20260327;
        b=QERYxbsSdOSsQOBipkfbex1obFYq825Cs9xf7fF0xZBgo8LH952AUgW9MtbaJ54k5O
         RyjbiqT3ONVi8Qy9IT2pkEK8bZ8rqc1YoYsGCcL4BSIvXQqZzZLdC1hDknpvIPKv8j8k
         URvi2kKXDAwIqBWqbc514GwflL0I/u6SAosfn75VMC3AYehY205OUKUF94IvvZulO2ft
         2ZvnpAL6K8Hjdi5n8UnmZOqXWzoNT+btseVGCE3hOBHQd29GFItWiph/Q4VJcjcqUoqE
         ddbwLbDGu7CxaRLCF34nB04lysLoImHUYiUDreUXsdVoKNgUclCjxIK9Qch7WCaq6HFf
         ZRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZqgMKC+YW8/szECOHd4rSP7xK1qbOm4+sRInDPe1kWM=;
        fh=wvbekuI4jMuOM/UlmsiZctpynYCpu5p8zkqIBqp6bCY=;
        b=ESS6Sc2UL5TUzhVEK4eKKxyp6TFGPqv3W48n+3Q5T7oFjEs+6VADUFvqQHyZtst/LU
         3F+15E245HWX2OIc6JdC4FrUhHlPZiIA1Qnq983U/oje8JRgJW/KkrCJdb50+l95Y57g
         pahgMM5puommBgho2Q0ttpa9bChNbIhJtZi+rQRDBM2SXB1M1PPATofJVFYt2UADkgPy
         Cz2y2N90SIuZbA9OCjcR+UMPtoeeZulyVDkl3mCaSg8nV1XeC9xGXLljFwtA1Oy1TOF3
         2EL8e8hKzdyAyCRSWQSOwwf7g+W2WBYCzaDhHV2v4ii9Tfh3/U8CNg6JNrj7Y3pn1Ypq
         YbRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782366960; x=1782971760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqgMKC+YW8/szECOHd4rSP7xK1qbOm4+sRInDPe1kWM=;
        b=a61pJqegqU1NvGENHqxbWIe51bnFbyTj6kbwhdpV/eXfccNtwcH8O46FPRC8pX4Dlw
         DhhWsQ6HpvAW90/j1jtgusMML75W0tUnp/HR0ksxF28mGPmHxVBVGFy9BCevSufdtJw6
         e2FmMEiAGR6RxIPfyVybd8wZ42gkBHplYXWZ5cUSGM2BKZwQQjIU8B/8YB82vStIKtKA
         K58XNpCTjuOCLJa7Y0kgZrMuI3IXSPu5j1f3ipGi3Pgx+hChDeCi7vSXo6Sv+WUzjL+O
         01/j1t/yMq7ltJYq6s4w2Qjt2mTnZXFdENS3hhHkzO/jNMR7Jq2C3HOjwZVRQCa5Xfi0
         oaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782366960; x=1782971760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZqgMKC+YW8/szECOHd4rSP7xK1qbOm4+sRInDPe1kWM=;
        b=m9VRNA9vB1ZEq0RJZNnBCjAz1mUYwjx2ec+3yeNcSJltOmB/mNsF8gVs0GZpLsucNS
         vUSgmfi094XvDmYhknkB6mX31AVKG33IzjPNluXjpl0OSJhHiRplOka+NPX4IKed6Do8
         IqBhUPHkMWS6bvC4R2rV/4kMg4bw5EobW3x7IWaanI7AXS2/JzYNDQNVKWHibFhuQzYY
         RkYoxn9QpzqD2jVD37ckF+8ru2cUjYttpr+I/0CHYdcNjWE4U9/ppE8q/Be2HTCkLdCm
         URe7OPqSg2PQN6vIVPk79sHP1I8KjD0zTIJbLkOr/OyeBzcRf6CMZkPpmxQAx0PtxLsc
         HNWw==
X-Forwarded-Encrypted: i=1; AHgh+RrKjdPe/2LJ15fdEeRQDi1mTP66MhLtBCtObx4aE2Y/7zwBeMSiUi55Ht2zyIhtLdAqLYbOf1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdjhC7NH9G7skg09xZnAgG6irKuACpv+h0SknT/Qdj84ysbcjK
	0bi+Mbg9iGgqVIISUtl+WhPvDo0Q/5lIUc4wQEBtqrF3Nu+GZbGSPL0HZm9NXmd3dksWjY8rmlp
	0r0Q4U3q6dPEE7kJytvSWe8G/9bvqSjNiIqi6p1xE3ukGAGJwMp6LCc6t
X-Gm-Gg: AfdE7cmX/xb8NCcKbL3lVcUKTJfWmy9l3tZxkQa3FfRQzd+Qd+wdjggtiki2jPL9FKH
	LWPUNQZ7QvjqMt2Npl2jgBJKLyFnh0inq11PZX/gLsOmQbJrruq+fV728ygkRjpGTEDShHtNvOQ
	X03Y41SmuTEvgvuqJGieejWdfUiezn1kJmQNtCR9gbknYqJrm1FDvSYkKnWOjG4rz7ZJfeEBZMk
	GorfsNMZXjF/IL3vQic3Zi2NdfqpHJsf/J/URaPzOKKr2fA73XNSECNtibasMvwDYaVERkl5gLS
	q2u0+Fc9sQRpN+NRvgysqJiDA+V69zzEypz8MTq58TUQaPIrJzNHLKH3AMh//7OZk1RxX7x7jFW
	WPxExADHB7gpZYEtglvtcuFMlb7e5JyZ0h5wwemcjZw==
X-Received: by 2002:a17:907:804:b0:c08:59dd:3fea with SMTP id
 a640c23a62f3a-c1205ef288emr55756166b.27.1782366959575; Wed, 24 Jun 2026
 22:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624182018.2445732-1-kuba@kernel.org> <20260624182018.2445732-3-kuba@kernel.org>
In-Reply-To: <20260624182018.2445732-3-kuba@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 24 Jun 2026 22:55:46 -0700
X-Gm-Features: AVVi8CcHeY55C8v1qpSmaFr_Yn0y8cv3nqbiM0aULXgmNyaOHFYOyXK8r5BWBAE
Message-ID: <CAAVpQUDAGqBfw3yMRaSauW-U3zsbyp=L+X-if9pvS9-3MPfqKw@mail.gmail.com>
Subject: Re: [PATCH net 2/4] net: add the driver-facing netdev_work scheduling API
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	sdf@fomichev.me, dongchenchen2@huawei.com, idosch@nvidia.com, 
	n05ec@lzu.edu.cn, yuantan098@gmail.com, nb@tipi-net.de, 
	aleksandr.loktionov@intel.com, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:jv@jvosburgh.net,m:sdf@fomichev.me,m:dongchenchen2@huawei.com,m:idosch@nvidia.com,m:n05ec@lzu.edu.cn,m:yuantan098@gmail.com,m:nb@tipi-net.de,m:aleksandr.loktionov@intel.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301865-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,jvosburgh.net,fomichev.me,huawei.com,nvidia.com,lzu.edu.cn,gmail.com,tipi-net.de,intel.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3233A6C2DD8

On Wed, Jun 24, 2026 at 11:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> With an extra event mask we can easily extend the netdev work
> to also service driver-defined events. For advanced drivers
> this is probably not a perfect match, but it makes running
> deferred work easier in simple cases.
>
> Expose the netdev_work facility to drivers. Add helpers
> to schedule work and a dedicated ndo to perform the driver-
> -scheduled actions.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

