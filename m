Return-Path: <netdev+bounces-193950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E073AC68A7
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA2F1BC601F
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 11:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88B8283FE1;
	Wed, 28 May 2025 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4uIVbUOt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB80283CB3
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748433464; cv=none; b=lIdXbMX7QIRgaPAnfxBFTdqFoVmMygudNWDiNHbgfrAMbnQQ7onpoQUrqDQqg+TCEisNgb7SijwbSI8ndTIKKIL1mrNNRv2ac26zy9RdKT3GF/PElU82jmrO7MGqtBSsUDbGUcBkITAVcDlKbjMa+HPmMRQcw5qD5blCgIg1udY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748433464; c=relaxed/simple;
	bh=ESWFLUOM1NGM+Vv7/L2i6g1wtrKqJXlYZX0TvKMCcoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC3PVd5Odyy+NZxZcIWUk53AeaX9+7FQVrPlox+ihz6oAnh2nNzVZEMvCkHUcIBAjrj6wqImbCeqTp6r6a8/Lez674e8VNaIGxarJWX9FRkpjO/Vtn32uD7ucRP8MKSEc1jh0aS3Xd5RRoZbrcAoYrksAj48Ztg8VMx95vy92wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4uIVbUOt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OmmrYOiKIfV78PACAfvYm2ILQY/uIG5QzwP5hSwag6U=; b=4uIVbUOtRy+HOJuNUtYTF41g3F
	AbWHT/R9uFI6u5iGeKqBvZ36DCYjgOc9tLDQNS1YYShpumI7HlZfCOX9o6IeRsxD827fIj9h9mElw
	Qylk+WcfRB8qr/Tbfy+Wp11G21TY6C+tk3LgNXItMMdzXi8K4Jm+zUqS0b4S/qCCUCjA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uKFPX-00EAhB-FX; Wed, 28 May 2025 13:57:31 +0200
Date: Wed, 28 May 2025 13:57:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	netdev@vger.kernel.org, michael.jamet@intel.com,
	YehezkelShB@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
References: <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
 <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
 <63FE081D-44C9-47EC-BEDF-2965C023C43E@bejarano.io>
 <0b6cf76d-e64d-4a35-b006-20946e67da6e@lunn.ch>
 <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
 <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
 <38B49EF9-4A56-4004-91CF-5A2D591E202D@bejarano.io>
 <09f73d4d-efa3-479d-96b5-fd51d8687a21@lunn.ch>
 <CD0896D8-941E-403E-9DA9-51B13604A449@bejarano.io>
 <78AA82DB-92BE-4CD5-8EC7-239E6A93A465@bejarano.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78AA82DB-92BE-4CD5-8EC7-239E6A93A465@bejarano.io>

On Wed, May 28, 2025 at 08:38:29AM +0200, Ricard Bejarano wrote:
> This impacts performance so much that I can't even test it.
> 
> iperf3 doesn't even start and ping shows >1s latency:
> 
> root@red:~# ping 10.0.0.2
> PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
> 64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=1041 ms
> 64 bytes from 10.0.0.2: icmp_seq=2 ttl=64 time=1024 ms
> 64 bytes from 10.0.0.2: icmp_seq=3 ttl=64 time=1025 ms

That is something else. The slightly larger than 1000ms, means ping #2
is kicking ping #1 onto the wire. The transmit is not starting for
some reason until the next packet is queued for transmission.

	Andrew

