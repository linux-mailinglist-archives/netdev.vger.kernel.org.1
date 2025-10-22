Return-Path: <netdev+bounces-231587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24626BFB030
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 10:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8D13B8A20
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B1830CD9F;
	Wed, 22 Oct 2025 08:57:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2E266584;
	Wed, 22 Oct 2025 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123432; cv=none; b=AveveFSX83p776LR994nzoARBTF5Qvx8300gLquahsKZSjeImStq77Jc8JQSoA2eD/mIrjw8XEWknSud9y6xYys7lSM/fKg8DIuBdZ8UT/CiMbvZQt3N7KTspdwTcjv2XYjPh1KfN6NWqQz6ATA+XeYpyDuyswqviiHlV5Mpvo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123432; c=relaxed/simple;
	bh=1cEWqNCWQO3BrKIPjk3XHU+mFCpURXGNIyp9pcPbofc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk1unHFqyVLA6Oyv+nwOh5IGyCHG7TJ8onibek3LZVQn4baNsbm5jnNxIydIQuZLv/+Yn7h4Hd+lJkSKrSzdUhwWLqklY13BD/FfJU8jdS8IOsEr0OKiO0lH0RtS5eUg/7TLLPnxrQXKj6VsRU/WwGqdul4C/vcsjsJMA4/9iX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 91050A82E9;
	Wed, 22 Oct 2025 10:57:06 +0200 (CEST)
Date: Wed, 22 Oct 2025 10:57:05 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Wrong source address selection in arp_solicit for forwarded
 packets
Message-ID: <t6emma5j63fsaujkxgxpkihap5qena6yp5qhfbr3u7rkgv2brq@loognuyll4ut>
Mail-Followup-To: Ido Schimmel <idosch@idosch.org>, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <eykjh3y2bse2tmhn5rn2uvztoepkbnxpb7n2pvwq62pjetdu7o@r46lgxf4azz7>
 <aPZB33C-C1t1z7Dk@shredder>
 <76z4ckbvjimtrf2foaislezs4vlru5upxn3i5ysu4au2m2pfei@slgxispho2iv>
 <aPetQ3LZo0Uikke5@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPetQ3LZo0Uikke5@shredder>
User-Agent: NeoMutt/20241002-35-39f9a6
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1761123418050

On 21.10.2025 18:56, Ido Schimmel wrote:
> On Tue, Oct 21, 2025 at 02:31:51PM +0200, Gabriel Goller wrote:
> > Hmm I don't know how this would help? There is a link-local address set
> > on the interface, but we would have to add a ipv6 source address to the
> > arp packet which wouldn't be right?
> 
> There are no ARP packets. Neighbour resolution is performed via IPv6
> NA/NS messages. The script below [1] replicates your setup as I
> understand, but it uses IPv6 link-local addresses for the nexthops.

Ah yes, I understand what you mean now. Still, in an IPv4-only
environment (e.g. OSPFv2, which does not support IPv6, where we would
have to add route-maps [0] for every interface to rewrite the routes)
you still have that problem.

[0]: https://docs.frrouting.org/en/latest/routemap.html#clicmd-set-ip-next-hop-peer-address

> [snip]

Thanks,
Gabriel


