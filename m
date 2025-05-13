Return-Path: <netdev+bounces-190004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8285EAB4DE7
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1442116BBD6
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD92201031;
	Tue, 13 May 2025 08:18:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chekov.greenie.muc.de (chekov.greenie.muc.de [193.149.48.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A14E20127A
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124290; cv=none; b=gY2EcasFptMPSp2H5gidmFmT2xd2a7IlILZ09XrXnYISRnqEGmEE1ePdHF9LzYzPf4SqxokNEi0v8CsU6/K2vhxVRNusufq4yY2XgaPxYwuKzfQvLXmdqIq5o9u0qINg1Ac+CXMsfjzAnVUhOanuvgaU1isYejIW/LQ97JeK5kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124290; c=relaxed/simple;
	bh=Y6zhbfx0EPaKL2q0VNMjNqYHR50U03Dk0PLMVQ2Stec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4ny18qaxzDGxxvXtL73LMjXpEunBSPXOBG961Bk/N4+TN3RwWcPKzQQdu04a6KpmmSTsRpeNcOE8Lr5o4BvENKJKVkzdbn+FGV4oPfh7u4EStKFNoS9L9fM3zk50AE8bQUW+/hCZ1XzPSv1v0sFVcoXFIIh6cC1XR5SHQ9i+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=greenie.muc.de; spf=pass smtp.mailfrom=chekov.greenie.muc.de; arc=none smtp.client-ip=193.149.48.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=greenie.muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chekov.greenie.muc.de
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
	by chekov.greenie.muc.de (8.18.1/8.18.1) with ESMTPS id 54D7nP3U086686
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 13 May 2025 09:49:25 +0200 (CEST)
	(envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
	by chekov.greenie.muc.de (8.18.1/8.18.1/Submit) id 54D7nPEV086685;
	Tue, 13 May 2025 09:49:25 +0200 (CEST)
	(envelope-from gert)
Date: Tue, 13 May 2025 09:49:25 +0200
From: Gert Doering <gert@greenie.muc.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Gert Doering <gert@greenie.muc.de>
Subject: Re: [PATCH net-next 03/10] ovpn: set skb->ignore_df = 1 before
 sending IPv6 packets out
Message-ID: <aCL5hZdbbXi8g4Ua@greenie.muc.de>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-4-antonio@openvpn.net>
 <fc07f58e-488e-490e-a33f-50f09163a0fb@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc07f58e-488e-490e-a33f-50f09163a0fb@redhat.com>
X-mgetty-docs: http://mgetty.greenie.net/

Hi,

On Tue, May 13, 2025 at 09:37:33AM +0200, Paolo Abeni wrote:
> On 5/9/25 4:26 PM, Antonio Quartulli wrote:
> > IPv6 user packets (sent over the tunnel) may be larger than
> > the outgoing interface MTU after encapsulation.
> > When this happens ovpn should allow the kernel to fragment
> > them because they are "locally generated".
> > 
> > To achieve the above, we must set skb->ignore_df = 1
> > so that ip6_fragment() can be made aware of this decision.
> 
> Why the above applies only to IPv6? AFAICS the same could happen even
> for IPv4.

Without having a detailed understanding of the kernel code paths (I'm
the userspace developer that breaks this stuff from the outside), the
v4/v6 logic seems different enough - possibly based on differences in
fragment handling in the relevant RFCs - that this is not a problem.

I am testing "3000 byte IPv4 and IPv6 packets over OpenVPN over IPv4 and
IPv6", intentionally creating both inside and outside fragmentation,
and without this patch "... over IPv6" was broken, while "... over IPv4"
worked all the time.  With the patch, all 4 combinations pass.

gert
-- 
"If was one thing all people took for granted, was conviction that if you 
 feed honest figures into a computer, honest figures come out. Never doubted 
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistress

Gert Doering - Munich, Germany                             gert@greenie.muc.de

