Return-Path: <netdev+bounces-37196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C10A57B42EB
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 20:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 78AB1282CF8
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 18:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4267D18B0D;
	Sat, 30 Sep 2023 18:16:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7FB678
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 18:16:17 +0000 (UTC)
Received: from mail.lac-coloc.fr (unknown [45.90.160.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C90AD3
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 11:16:14 -0700 (PDT)
Authentication-Results: mail.lac-coloc.fr;
	auth=pass (login)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 30 Sep 2023 20:16:13 +0200
From: alce@lafranque.net
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, vincent@bernat.ch
Subject: Re: [PATCH net-next] vxlan: add support for flowlabel inherit
In-Reply-To: <CANn89i+q_0e3ztiHD5YE4LBJCSeaETk3VyJ0TPuJYP9By1_1Tg@mail.gmail.com>
References: <4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@mail.lac-coloc.fr>
 <CANn89i+q_0e3ztiHD5YE4LBJCSeaETk3VyJ0TPuJYP9By1_1Tg@mail.gmail.com>
Message-ID: <16773d6da33d211716c3f13211624f36@lafranque.net>
X-Sender: alce@lafranque.net
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.lac-coloc.fr (Haraka/3.0.1) with ESMTPSA id BB8F6D89-7DAD-4689-B670-759BAC2D8297.1
	envelope-from <alce@lafranque.net>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Sat, 30 Sep 2023 18:16:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lafranque.net; s=s20211111873;
	h=from:subject:date:message-id:to:cc:mime-version;
	bh=2m7Ssy6FvyH0gj6BLrGKHk/GAAKH/Ro6bIdWdqv9m6M=;
	b=XlvYPQbCjmJtvPH93LW3PSYF6nQX2Xdw8vUY1SwIbQTNXA/uzVOOKPJt5dHf25oF0w0lxN2Zi6
	ygRNlLPPFRfksDnm/i89nG8fO6HKwBpdwx3DeFJjgTFYDaYyh7W/Ous3DtmjlIBvyn6CpGSV0VhD
	5eixycIzc6HNrsph+iDN8=
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MSGID_FROM_MTA_HEADER,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 2023-09-30 17:29, Eric Dumazet a écrit :
> Side question : How can "flowlabel inherit" can be turned off later
> with an "ip link change ..." ?
> 
> It seems vxlan_nl2flag() would always turn it 'on' for NLA_FLAG type :
> 
> if (vxlan_policy[attrtype].type == NLA_FLAG)
>     flags = conf->flags | mask;  // always turn on
> else if (nla_get_u8(tb[attrtype]))    // dead code for NLA_FLAG
>     flags = conf->flags | mask;
> else
>     flags = conf->flags & ~mask;
> 
> conf->flags = flags;

The "flow label inherit" cannot be turned off after the
interface has been created, we have followed the logic used by 
TTL_INHERIT.

If the behavior isn't meant to be, we can try to modify it.

