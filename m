Return-Path: <netdev+bounces-166108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D72A34899
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FB73A0860
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27894176AA1;
	Thu, 13 Feb 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltmrwHop"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3D26B087
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461733; cv=none; b=swcR1uu1NWTobLVFZYXz1uC2eIw6l293xdiZMZVfupplr4L2pYCsbLDjMlIuw17ZdfvYhVZxXuJrN0EL3OtA+ClR85H07hZsSs37M/wfiKRWCAbYA/Z12eH1dvr1IcwUX1Kab3fsgQFuYIOWTSvnJYjFU+Hp0FSGzbQMyi/MWNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461733; c=relaxed/simple;
	bh=ImyRJrSHM5sxvpxFLZqQXBwOPY1Tz6w4sU3JqWy2FQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccys43+je6LIV/gTZkQMD597JLZvlX1zRMtme0tWrSYUIRONifR/tBVhE/IVFUSCvyTcMCKbrTe7soRZF/uvloqpltqjIq6NASDjlJuA+e/GyDQ6ocgfbDXHMAEpPiDg4bg2V6Xj95IPNEZRZHx+jLnlIbYNegD6/T1IzaFThso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltmrwHop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC433C4CED1;
	Thu, 13 Feb 2025 15:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739461732;
	bh=ImyRJrSHM5sxvpxFLZqQXBwOPY1Tz6w4sU3JqWy2FQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ltmrwHop9pd7H9WBqL9PWDUPqgYq4Kpp7K2rbBpMOPwMvx3aRWbcJ84q3AjKMlygF
	 MIWO/snMhihgPe4bJXstAAPci0vPTtc47ah6TE2bMRHSpvLGRhJYpuUwY6Zd6+sqqj
	 +YMsYGHWfsKcBFbtQ9QpfiGGYOggMsVNfGNSt7Tpj0KYZxioA3jjZUgjaqrcPKaAnT
	 kV46t/dr0kv0xTNrDjG+DHEmiFLbtztVsfj5l+14oH58TGnTLVYSZoLa4pmeo6onsW
	 509BlnpOfSX9S+DFlhNPHUptWtcdAnBeATVwBopHJDPh+z0QpPTDAeQaXFUQ7oJxWC
	 POKqp/KXKiGtg==
Date: Thu, 13 Feb 2025 07:48:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemb@google.com, ecree.xilinx@gmail.com, neescoba@cisco.com
Subject: Re: [PATCH net-next] netdev: clarify GSO vs csum in qstats
Message-ID: <20250213074851.7b4626e5@kernel.org>
In-Reply-To: <67ae123210650_24be45294bc@willemb.c.googlers.com.notmuch>
References: <20250213010457.1351376-1-kuba@kernel.org>
	<67ae123210650_24be45294bc@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 10:39:30 -0500 Willem de Bruijn wrote:
> > +          calculated the L4 checksum (which means pretty much all of them).  
> 
> Can we clarify what pretty much here means?
> 
> TSO requires checksum offload. USO with zero checksum is the only exception that
> I can think of right now.

I was worried that somehow another case will appear and the comment
will become stale. I will just delete the part in the parenthesis.

