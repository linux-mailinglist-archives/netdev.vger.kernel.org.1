Return-Path: <netdev+bounces-21692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCB87644CC
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53106281FF7
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 04:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4890D1864;
	Thu, 27 Jul 2023 04:19:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EC6185D
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 04:19:23 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE1B2701
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:19:22 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-54290603887so291198a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690431561; x=1691036361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJ2cNyH/qVDzCA/eIjFBiU8QVXBmGdxt+VwazCaB3hk=;
        b=kcICFNEq6bzQHovavKo9thttOpbw6BnfdOROi3kn1BfUy/Hy5PyVeHx4FF/FV6iIcj
         LdeRk+BaQy4/9swrjWcKVlogIlxRRsqeDajYE2oDrQqrV0SmTkVcRxE2dRrBnAsS2CH5
         CCog8gWtPTKR82Hi4/oHSCh07uuibuSh5n+KhEfSBws3M826Qb49vjvX+EC3yVjkxgtA
         TATWAou0fl5l8Ov1ZPvys8l546bajqHMME8yn7a+TR3krSwoR8Si9893B6gF+pTZsV+d
         Vhl8KXojEIZPvEZUP/BvwA0HgK9vqQm2GgzbDJeTnpRc/DrHYGSUWqFrwbMa7XYNh1aX
         9VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690431561; x=1691036361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJ2cNyH/qVDzCA/eIjFBiU8QVXBmGdxt+VwazCaB3hk=;
        b=D2VigR2GwU0ICwuMTLhcwQjMQriqMetcjyKV7lj9ernZg9A4ha9BSOqM9Nn6ZeNynr
         E0gOygPsq1Tbph9TTe18yOToM9cna23cgYLmDIB3Rsh+M+MaFAfQBibPPj5o7ihuIrhk
         aED1DIJLxju7seJ6xdaLCxzOrmRumRWqa1Qb9iX8fS+JIUm/t0ossXPEymLIQPi5rJFT
         gsRIm+4823hDIc2KcTBMWGRLgd1d95/nOGyLmW9gZRnNVzFfYV9KwlFYeqVFl7T1HYtl
         VWttOQz4FYbal/NMgAcn42o2VEC14jRe1oA1coVbypQ0TsgimmTEMoKV4Qz9fw8PgFQS
         rQeg==
X-Gm-Message-State: ABy/qLYN3Zji/OApIIPrgPr5jJgZi9qBKT7RxMEaJxAkPKrA0RICYC9Z
	rY/tHZ4DBuvWVDhMljpgCp8=
X-Google-Smtp-Source: APBJJlFvhqOYKVw0+4Hw8i3qCusO7H7fk4s5YThimx1VG2v09MfTssEE0th97xtyIlM5hsqiGVprMg==
X-Received: by 2002:a17:90a:4547:b0:267:f147:6fe0 with SMTP id r7-20020a17090a454700b00267f1476fe0mr3034443pjm.16.1690431561532;
        Wed, 26 Jul 2023 21:19:21 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ga22-20020a17090b039600b00268188ea4b9sm340277pjb.19.2023.07.26.21.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 21:19:20 -0700 (PDT)
Date: Thu, 27 Jul 2023 12:19:16 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [Questions] Some issues about IPv4/IPv6 nexthop route
Message-ID: <ZMHwROD1AJrd4pND@Laptop-X1>
References: <ZLjncWOL+FvtaHcP@Laptop-X1>
 <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1>
 <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1>
 <20230724084820.4aa133cc@hermes.local>
 <ZMDyoRzngXVESEd1@Laptop-X1>
 <9a421bef-2b19-8619-601e-b00c0b1dc515@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a421bef-2b19-8619-601e-b00c0b1dc515@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 09:57:59AM -0600, David Ahern wrote:
> > So my questions are, should we show weight/scope for IPv4? How to deal the
> > type/proto info missing for IPv6? How to deal with the difference of merging
> > policy for IPv4/IPv6?
> > + ip route add 172.16.105.0/24 table 100 via 172.16.104.100 dev dummy1
> > + ip route append 172.16.105.0/24 table 100 via 172.16.104.100 dev dummy2
> 
> > + ip route add 172.16.106.0/24 table 100 nexthop via 172.16.104.100 dev dummy1 weight 1
> > + ip route append 172.16.106.0/24 table 100 nexthop via 172.16.104.100 dev dummy1 weight 2
> 
> Weight only has meaning with a multipath route. In both of these caess
> these are 2 separate entries in the FIB

Yes, we know these are 2 separate entries. The NM developers know these
are 2 separate entries. But the uses don't know, and the route daemon don't
know. If a user add these 2 entires. And kernel show them as the same. The
route daemon will store them as a same entries. But if the user delete the
entry. We actually delete one and left one in the kernel. This will make
the route daemon and user confused.

So my question is, should we export the weight/scope? Or stop user add
the second entry? Or just leave it there and ask route daemon/uses try
the new nexthop api.

> with the second one only hit under certain conditions.

Just curious, with what kind of certain conditions we will hit the second one?

> 
> > + ip route show table 200
> > default dev dummy1 scope link
> > local default dev dummy1 scope host
> > 172.16.107.0/24 via 172.16.104.100 dev dummy1
> > 172.16.107.0/24 via 172.16.104.100 dev dummy1
> > 
> > + ip addr add 2001:db8:101::1/64 dev dummy1
> > + ip addr add 2001:db8:101::2/64 dev dummy2
> > + ip route add 2001:db8:102::/64 via 2001:db8:101::10 dev dummy1 table 100
> > + ip route prepend 2001:db8:102::/64 via 2001:db8:101::10 dev dummy2 table 100
> > + ip route add local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
> > + ip route prepend unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 1
> Unfortunately the original IPv6 multipath implementation did not follow
> the same semantics as IPv4. Each leg in a MP route is a separate entry
> and the append and prepend work differently for v6. :-(
> 
> This difference is one of the many goals of the separate nexthop objects
> -- aligning ipv4 and ipv6 behavior which can only be done with a new
> API. There were many attempts to make the legacy route infrastructure
> more closely aligned between v4 and v6 and inevitably each was reverted
> because it broke some existing user.

Yes, I understand the difficult and risk to aligned the v4/v6 behavior.
On the other hand, changing to new nexthop api also a large work for the
routing daemons. Here is a quote from NM developers replied to me.

"If the issues (this and others) of the netlink API for route objects can be
fixed, then there seems less reason to change NetworkManager to nexthop
objects. If it cannot (won't) be fixed, then would be another argument for using
nexthop objects..."

I will check if all the issues could be fixed with new nexthop api.

Thanks
Hangbin

