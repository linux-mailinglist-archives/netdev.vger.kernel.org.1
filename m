Return-Path: <netdev+bounces-118680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14559526EF
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 02:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45A91C212CB
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 00:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035CF36D;
	Thu, 15 Aug 2024 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSZvXPKh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BEC15C3
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723681969; cv=none; b=UKhBVN4MXfbjuEg+QWcCBaoNBc1Da3njA8JvlBfUlyU5TvrM4w/Te2pjzH/EuGSWmEcir34/ORJrsEgfTTTUeaAxeh7lGz+zD9sOrgHjzKNxeA0qPNOvTP82Be1G3Foc2V+du15C458Yvv4KnqMaN18TjTBpzBWML46ugsnHIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723681969; c=relaxed/simple;
	bh=sqkteINPphqWHaFjtlcfFPQqiDJwS9pT0Z3y5YAaQd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfwMny7t4kqg7HUckAGjnsZFIiWrwRKavI3UQvYqyMYR0huk7QUxVwAdnQf0SZ2SaxdUH0BHE4bmFCbY7iKI+q6paPqi/5+6uPcBcSK2z/RzKn29fo226gZBmFVOlNe+6NDU4z+dWdrWtBPqMpTA1GIGtdDCqDIrqbawu+SE0Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSZvXPKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB092C116B1;
	Thu, 15 Aug 2024 00:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723681969;
	bh=sqkteINPphqWHaFjtlcfFPQqiDJwS9pT0Z3y5YAaQd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SSZvXPKhkVLLxDKGQoD2JX2HsN9z6Is+/Cs1+GT4XNVUgrQlYMWAwsFkfXrDK9Ukb
	 mg6HN+a5OGuRTuMGYMrRn1zl+gvIHLltJmJ3X4vSFWR4TdA1yMTnw1xz4hH/mmIkHR
	 Bg6RHqAPzkx/rwWh6OTSxMCeWunXPPx65ITEhNcusvZAm/OrY7vNUhBt3N1Gsj+LIH
	 lSlNTLMTHh1nm8GeXssSpoe06gr0kRPI/6zCPTYCh9s58p4ZYMeXH1CSu3Gbnsw72T
	 ZEqt834UtXz5Z+UHKgQ3DDv2uzn1eTNALldhfh67bzyiLeIYhALvcoOyJecaVKWZOt
	 BcJBT588rju1w==
Date: Wed, 14 Aug 2024 17:32:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?=" <maze@google.com>, Florian
 Fainelli <f.fainelli@gmail.com>
Cc: "Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?=" <zenczykowski@gmail.com>,
 Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "Kory Maincent (Dent Project)"
 <kory.maincent@bootlin.com>, Ahmed Zaki <ahmed.zaki@intel.com>, Edward Cree
 <ecree.xilinx@gmail.com>, Yuyang Huang <yuyanghuang@google.com>, Lorenzo
 Colitti <lorenzo@google.com>
Subject: Re: [PATCH net-next] ethtool: add tunable api to disable various
 firmware offloads
Message-ID: <20240814173248.685681d7@kernel.org>
In-Reply-To: <20240813223325.3522113-1-maze@google.com>
References: <20240813223325.3522113-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Aug 2024 15:33:25 -0700 Maciej =C5=BBenczykowski wrote:
> In order to save power (battery), most network hardware
> designed for low power environments (ie. battery powered
> devices) supports varying types of hardware/firmware offload
> (filtering and/or generating replies) of incoming packets.
>=20
> The goal being to prevent device wakeups caused by ingress 'spam'.
>=20
> This is particularly true for wifi (especially phones/tablets),
> but isn't actually wifi specific.  It can also be implemented
> in wired nics (TV) or usb ethernet dongles.
>=20
> For examples TVs require this to keep power consumption
> under (the EU mandated) 2 Watts while idle (display off),
> while still being discoverable on the network.

Sounds sane, adding Florian, he mentioned MDNS at last netconf.
Tho, wasn't there supposed to be a more granular API in Android
to control such protocol offloads?

You gotta find an upstream driver which implements this for us to merge.
If Florian doesn't have any quick uses -- I think Intel ethernet drivers
have private flags for enabling/disabling an LLDP agent. That could be
another way..
--=20
pw-bot: cr

