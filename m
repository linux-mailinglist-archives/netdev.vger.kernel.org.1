Return-Path: <netdev+bounces-295648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +331Il9vImrOXAEAu9opvQ
	(envelope-from <netdev+bounces-295648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 08:40:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C40364597B
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 08:40:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ULVyPXty;
	dkim=pass header.d=redhat.com header.s=google header.b=Ws81fXaj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295648-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295648-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7810730636DA
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 06:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851DF407596;
	Fri,  5 Jun 2026 06:33:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3819E407571
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 06:33:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641188; cv=none; b=boL3z1ivEVhjfaH0eMcAAoKZBUpkk2LH+5W5jJ5Fd/v86gDFusGdNWAPnDw7CpeMD4r7QMZwIjnjGkUpkh7B8brF6Oung3kRSC485iNAt72mP16jdcKbt9phG2EUa9gDEpoKJA+mAcn5H4Y03ImxPc4G2UugBo3s7VHoMJBbxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641188; c=relaxed/simple;
	bh=GObav0t2xLliYCsPoAV//zijkxPq12LJaglbYe7Ih2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXxouRAXoH1aRpsO1ixLn+Bhf4ysl5XLk90MNNJWXDYRGngzcatm2vaHhCkMWDiaBTrNZgcsaWsDMtDrkinYiAcAwh/+O6Y7LEvBu/3JMtCoaKyytLKw2O9MdxJcomnAtBtfCnGoe93pUXp2wqgXYp1VKMVLAxJ+g1bwQtWu/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULVyPXty; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ws81fXaj; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780641186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GObav0t2xLliYCsPoAV//zijkxPq12LJaglbYe7Ih2o=;
	b=ULVyPXtyS/JTuiDdHAbVrdsyGj/i7AnFfglgaYMZRCoajy2jtjDo6Ox8p3aAEB+N7fkgzm
	BOHm0CRB4JGcmBYJ12+x6y8KTbrc17MxDOH1HgrOw6tL9mWydOIC757P1S8cG+MQwLqe47
	F7Z2TVIfht6V5BvYZv+SJd24Rt4fAqc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-4FET2WHgMVODtGbeTV-gaQ-1; Fri, 05 Jun 2026 02:33:04 -0400
X-MC-Unique: 4FET2WHgMVODtGbeTV-gaQ-1
X-Mimecast-MFC-AGG-ID: 4FET2WHgMVODtGbeTV-gaQ_1780641184
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-68d233bf9easo2245287a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 23:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780641183; x=1781245983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GObav0t2xLliYCsPoAV//zijkxPq12LJaglbYe7Ih2o=;
        b=Ws81fXajv+0FKIbYYAPCo3dBMYOalLxQ9SyZF+cgSOeAX9N9tIrUrTelGmcX6bIF/X
         QXZxK+PGf04CSHrDo2eGiT4uwD/H06VYxw7iZiGUiSMoC7QHBf5s/IXwtq0bfMMNb6rO
         FDfbKvMCRpnZsxdGk8Hex+il+fFUKopC2oSGCCalaZDfB53/JTvQUMzpJzPY3jX1EQUH
         p2wtGGFgeeT+VySNAi7jzDnVtMVPpkjaip8H0HwXt4BaACoU0V90HbiCYPXcWMh+28Lg
         Fbu8vv1s74cC5Q2a4nsTWe/IAVHeCDn7LKUqGEC4updJ3XK6PItTmhj2hk6Vp3YtCZ+K
         Ig4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641183; x=1781245983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GObav0t2xLliYCsPoAV//zijkxPq12LJaglbYe7Ih2o=;
        b=T+Y+74TlWJJAjPmxEwC17q6BHZqKGcatehxTaDRTfdjO7rhVa9cHeEJREzPS9NsLHJ
         0SjcQqPKa3qaBgZqS/N14ndP69Rtny0Np2UaX6voUHYFXvP4trcV6PXYoM8bNnvPLdfi
         Be5Xw8zwoNqpvtWjIO8MbbVz6kGirA5Zfx8rcNNSS8eDU9C1GdCu00G4HBEmodokk9uM
         s1GpTxatmq6YkBD5OhtS9Qumlm5m+d6KskfO4f4JcGSipnokt8lzet7yT7TKEaa4MdKI
         i5YSZVSrSorPDPngaWORyImNnh/AlgCOkrExyrD37DbTizpE4HKAq4YCtshTZSVTgODz
         /3xQ==
X-Gm-Message-State: AOJu0YwfvgOT7m7WlqlGsuxXP0EKDhGVEd9YXCUrDmzjQ332AOffr4C9
	on47llj5wK7IZKracl0tLxGYjxeGIimfFsccrTAp3o1z5npANPxKL44rO1cRl+e5PIPgiIvzK7O
	4QFWr3bE/Ahyb0osVVZ6ZuavbnwNHTFuPc1nnh21zH0RwGKosmNWBgsBUDg==
X-Gm-Gg: Acq92OHVPkmhuVpLxdylF17iyFfLZv8oLo7qrwxFumekhGp27KEIOQdTDvs4scocsHZ
	hQXAaHa28YMLUf1sYRaBl/FqZdtoRTlKxywCAlVMWn4nBOhvE1GVVo//nbfxZuTjIcuDaVauEif
	I3kwDc6b10imzCXcEYclYfHTjITbd48Zb3qRx1Yj+KVddj83CRKtj0mSnuDS0YXnQZWDVlFmq7f
	MMawhXYL6af7vApRxO7zefyF6OFibyPrzP1Hv83VvnZsv2TLufRhuEOfaa1X9Tq9a0L9Ff/TvHX
	EoEMQnRDMdxFOdojlVYhB4h/eEW78liyvEIV/V63Lttr6aHQc5qPLPMxzraUZ1U8Y7Rk5azRTIM
	lYdXfUTfua8G/656m22tqLATdvXM8lMkBBoNKxJoJuB77+FkrVWkxAo9iiH9B4Fw8ywSrVMr6Pm
	xTZColFQ==
X-Received: by 2002:a05:6402:1f4a:b0:678:a507:e81b with SMTP id 4fb4d7f45d1cf-68fa5049406mr893962a12.21.1780641183521;
        Thu, 04 Jun 2026 23:33:03 -0700 (PDT)
X-Received: by 2002:a05:6402:1f4a:b0:678:a507:e81b with SMTP id 4fb4d7f45d1cf-68fa5049406mr893866a12.21.1780641180640;
        Thu, 04 Jun 2026 23:33:00 -0700 (PDT)
Received: from [10.44.49.226] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e6585185csm3322610a12.16.2026.06.04.23.32.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2026 23:32:59 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Pravin B Shelar <pshelar@nicira.com>,
 Jarno Rajahalme <jrajahalme@nicira.com>,
 "open list:OPENVSWITCH" <dev@openvswitch.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: openvswitch: fix possible kfree_skb of ERR_PTR
Date: Fri, 05 Jun 2026 08:32:57 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <5D810C0D-0AB9-4EE5-864D-8D1D60238527@redhat.com>
In-Reply-To: <20260604121946.942164-1-amorenoz@redhat.com>
References: <20260604121946.942164-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-295648-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amorenoz@redhat.com,m:netdev@vger.kernel.org,m:aconole@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:pshelar@nicira.com,m:jrajahalme@nicira.com,m:dev@openvswitch.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C40364597B



On 4 Jun 2026, at 14:19, Adrian Moreno wrote:

> After the patch in the "Fixes" tag, the allocation of the "reply" skb
> can happen either before or after locking the ovs_mutex.
>
> However, error cleanups still follow the classical reversed order,
> assuming "reply" is allocated before locking: it is freed after unlocki=
ng.
>
> If "reply" allocation happens after locking the mutex and it fails,
> "reply" is left with an ERR_PTR, and execution jumps to the corresponde=
nt
> cleanup stage which will try to free an invalid pointer.
>
> Fix this by setting the pointer to NULL after having saved its error
> value.
>
> Fixes: 893f139b9a6c ("openvswitch: Minimize ovs_flow_cmd_new|set critic=
al sections.")
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Thanks Adrian for finding and fixing this! The change looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>


