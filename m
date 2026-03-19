Return-Path: <netdev+bounces-269236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD6EMJJIu2kliQIAu9opvQ
	(envelope-from <netdev+bounces-269236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:51:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEB92C4356
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DA96301F380
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A3253340;
	Thu, 19 Mar 2026 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4iiQdF2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BEC23C4FA
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881484; cv=pass; b=C4QWIBMhLKhwv1fAeELnOQ1ZW7qM/TRO/HwyNeRdP89MDdVYR0scPXv/i1WUgn8hwquk/PwsQ2Majk5cNhs5uzssDLXY8i5W+jNGz0eBOcLVyzmSsgzWl0AisE+WebZKChQJTbwz6Pmbc92K4CtI1kocuH1QcG9hJZ7Da+MJP1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881484; c=relaxed/simple;
	bh=FYquantrsslVPILiINBNEthKiXHN+4BdvURHe2B9LgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkGYLFbSuV5F6Z9LhUlAEw6GXFgQvCxPFZpVpMkSjUpHyXtpkeqZjePhJFtWZTTw20YALJPlFhPacH6Wgh/Zx3LVj2VzCwhlyOk1o5ULZD989NPVwPLaWX9/Ut6r/AIhHC4+2UoceiiqdBFSRZ1YMBfLhCcvbAti3bDe3ix3Nt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F4iiQdF2; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-359fea895b5so371406a91.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 17:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773881483; cv=none;
        d=google.com; s=arc-20240605;
        b=gtdcdNgASt9MKmAMcil3MgBz9AefKms8RY7x62h3jbryM/VlumX9Jt93MwpdJhGSLc
         DCiswsmxY2Ioo6WKJYJT+D0wCrJF2fFPJiBEHFZqfq74TKujjJX6HhUiV7+3XXZC0IGF
         vfOCg4OC4bX3nTVrYViHQ+dZr+Gdbj8/6XEADLGthwhvTXBvsxmlAVOZNbbGYR7sIRH/
         0aOMBC6p+kh6ARQPPsWJS0kx0dvsuwEH/ua4r4y5PyWI5fH2sCsbDwrCmBdatBEV1isU
         MDsjvcZiIQGCFSo6Pug2pcQLAt7jjPXWV+O+YDo3/YoebZ81zf7zww+j17Vm7eFO7YvM
         nDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FYquantrsslVPILiINBNEthKiXHN+4BdvURHe2B9LgM=;
        fh=BfNXUmR5OxMBiIf2HipRfRwU9Eg5YmRWS8t+hB6eFzk=;
        b=GM5hLYaci6JA0ObVIFOHqS5hWCNQG903vVxyJ3nxL+GoDpILwVV+OR6UM7TYyl2wUI
         nKdWW5o6IbCCMjFrL6IbnYBS1zlVMV2tADDRrKgSXblIzEAnprH0Gaxl6sh/NJvyHCW3
         zbJXB3IqSwn7/qnoThjYanD20sc52SNLDyGpJ5Tul57BApJjblEvunzcWt/y6FBZlCKm
         vRY9fqDZ9xnvNCkUJ16Bt1RC8TlDC2WA8GyMqABSWrQCccWwUY7fwLRN+zc1DMRmLxdn
         SXiJ+rJAmLePoELIoaca5dspkotPNQciGh9zLFooaVaTxA5+d7grwm8+K5vZNhK7ZFM+
         0XZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773881483; x=1774486283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYquantrsslVPILiINBNEthKiXHN+4BdvURHe2B9LgM=;
        b=F4iiQdF2vSso65jsARLFgMarEVzw3gXw4PYgvquMXi55c/PhWzTuPg5WKi8d0E0bsD
         B6WvMpMSvNTVDB1bHUCi18tGW6Pk9ZcJTADnZV9411/JEh/1fkblol1f77+VmI3b4OjO
         16HOkq8phfPx5cLumKE3CbSC8g1pCiKf3fFyyZiT+zjRPpdubcSh+d9vfRmY2yurzcAF
         R4Dq0xFyMQYE+yi3lQv5n4RuQd7NVtlU9f6JnoUS7LApsARV8Yryd9Uc4jmnV1IzUzTd
         eoOxM7K+b78EPRQlZmkmkjkolyvkvvjl7zhOn08dJryRglO+oGY3XW4AgXD5uqCdnjbR
         vcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773881483; x=1774486283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FYquantrsslVPILiINBNEthKiXHN+4BdvURHe2B9LgM=;
        b=Q/Y7k9NSFCgPo+A2JGG3TtZKd+pMYJtykX9y4AuBVOoENXlRneL7NegUkNfzkFhK8w
         elZioFKWdwjPujGZxTLZ50eZ95QBq5K55Rrl5s78Eda8kxZX9t6WNfLCHpI/531Tri36
         8hdNX1xVxxpdtIiBbIg3s7awR00LgGSe9qx3pSfqWbCUd73dT4scyoT9my6JcrM/EFH3
         UHu+6orypnPQF7dNwoFRqX+9svygAjQZLMS91wsqe6H4UmHu2BrWlWJj6dEtRXpxsmmM
         RCDpHjQRrQPROlriFClOAWLykA7FoOMoUA84NPqfSNo6Sw+XhCOcFInDK+XKdiZiFdJ4
         xkzg==
X-Forwarded-Encrypted: i=1; AJvYcCW46Zt4WAjnJ3LA+ps4TuBbmOBE43l1seJhzeS7uOzWarlBqAV4b6EdRtf2sj7bVREJ8UzgTV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0rNc1dD9mZLi48oq776R8K2unXmzKPr4sEIv6oXteLsb4VbT
	IdxYDMoxHenWw3i8CYjgUl2yaoXRw3Hh7uQklLzMMbbE/ZTz5wVxlWNCIaT9aZ8csh3rKqcFi9/
	DPtTL4NLMK40fG/Hh7t96GEk/XB5ZrSPdmMzehcEM
X-Gm-Gg: ATEYQzyTqWHlDTJHhu8/FIbcgWEwR/s48sufJbFjZKfiRRU+CK7Qxh7gpOvpiLDITZ8
	UZMjF4KYudyThKbh8bNi23srFRbdbWBxvpMewjiAWgI0Hd1lk+7bMXefZwRqCl7TPm8TRlB0KSO
	qZbSqQd3JMmwpjc1KvVW384ggDEAkTs1zx55lInChPqsawUiseAfy0+r8ez/Akxjt5+Vhy103Jd
	NZghwU31PRmZVUehxL7StXiO9l1BBY3o9U7UCxKLAXcSEbF4WpWXeju+a7bhHJVIy/Qq8xMXlzd
	F3RCH+28lRd9XKPv4sD4K/SrLLiVrLYbWDPCi2FPNFk8uNy5
X-Received: by 2002:a17:903:11cf:b0:2ae:cda1:1d2b with SMTP id
 d9443c01a7336-2b06e3cd2d5mr52678835ad.29.1773881482504; Wed, 18 Mar 2026
 17:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318010325.2003395-1-treapking@google.com> <20260318172802.46c1fef1@kernel.org>
In-Reply-To: <20260318172802.46c1fef1@kernel.org>
From: Pin-yen Lin <treapking@google.com>
Date: Wed, 18 Mar 2026 17:51:11 -0700
X-Gm-Features: AaiRm50AqrKVto5QacwTd7u2kWs_qo700uM6KuW3VUeb1WpqW1K_kfLdV6UoweY
Message-ID: <CAHwYsirHq7PRWg-jeGz=+Yrn2Td=o3vBSXrjfPos57V0VQL6gA@mail.gmail.com>
Subject: Re: [PATCH net] selftests: drv-net: ping: Wait for carrier after
 toggling offloads
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Taehee Yoo <ap420073@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269236-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.897];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[treapking@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FEB92C4356
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

Thanks for the review.

On Wed, Mar 18, 2026 at 5:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 17 Mar 2026 18:01:17 -0700 Pin-yen Lin wrote:
> > Toggling checksum offload (or HW-GRO via feature dependencies) can caus=
e
> > certain physical interfaces to undergo a reset or a temporary link-down
> > state. In the ping.py test, this leads to immediate test failures if th=
e
> > ping is attempted before the carrier is restored.
> >
> > This is observed when running the test with GVE driver when HW-GRO is
> > enabled. When checksum offload is toggled, HW-GRO is toggled as well
> > because of the feature dependency. This leads to an interface reset,
> > causing the subsequent ping to fail.
> >
> > Add a sleep period after changing these features to allow the link to
> > stabilize.
>
> Sounds like the test found a legitimate problem. The configuration
> should not return to user space until the operation has completed.
> User should not have to sleep 10sec each time they touch NIC
> configuration.

To clarify, the configuration operation itself completes before
returning to userspace. However, the short link-down during the
configuration triggers asynchronous systemd events. These userspace
operations affect the subsequent pings. Sorry for not making this
clear in the commit message.

Regarding the 10s delay: I agree it is long. In my environment, the
interface stabilizes in under 1s. I chose 10s only to maintain
consistency with existing delays in this test script. I'm happy to
reduce this to a smaller value (say, 3s) in v2.

Regards,
Pin-yen

>
> --
> pw-bot: reject

