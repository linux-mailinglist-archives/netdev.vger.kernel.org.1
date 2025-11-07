Return-Path: <netdev+bounces-236871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB2C410CE
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 18:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7F5426390
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4396F331A79;
	Fri,  7 Nov 2025 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1dS8azGY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80824DFF3
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536771; cv=none; b=XaQs0Rvy66oY0KeGJkgNaQ6iS9jjKw86EYvNgZLklnzvLyRbVbG7NG4I27YXViUVtcGjkEQk1kp92sqfC+NKY+CMt8njTYv/Ph7r6vZkpdEkgnnBTYRi466m9PSFMOO8u9b7ieryS/DwW2ADwzSlAIc8bB5dVj20F17/E0YH0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536771; c=relaxed/simple;
	bh=Cg75Lty+6nWjTh0v+AqPVULJA9cDsZuNBdO8szqyhWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJ2C86XIh8k+PC9jFo1IXPumP/6CD8ziPtH35DJtXKue28dTfYwEAyRth8yo54pNZdwNYo23sdfZXnnhdsd0omuX8uJTwrCME2kxH6Mdy/BDjaQQyNz73s0jQzMRqRsDBsNkADHuBDIlxXU+WRukFO/vOFG1J8Z5yrIZ3jlyz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1dS8azGY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AVBvNv5VOWBrqUDiUiETOaRoG4Mvj57lHka9tqHu+e8=; b=1dS8azGYYVlKK5zi/VzAzLuvTI
	qIt18gjklQQjcbKwIWEKvAuGnfpX9Jo7zzJCG+lo/IjeB06bDFFtmWknF6TA2YA7mvIvDa9xRLJED
	iDWSf9KK4Qx82yaWqhVNVKn12ryZUyl5RmHMBvo8zTawYvmRSbG8WqjnHvduA3JexdkI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHQKD-00DFoY-NJ; Fri, 07 Nov 2025 18:32:37 +0100
Date: Fri, 7 Nov 2025 18:32:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Subject: Re: [PATCH net] bonding: fix mii_status when slave is down
Message-ID: <2e184a78-c02a-4395-8e18-a72a8330db46@lunn.ch>
References: <20251106180252.3974772-1-nicolas.dichtel@6wind.com>
 <7a6372b3-b170-49b9-ae62-eb0d1266bd6c@lunn.ch>
 <80576ce0-7383-4b46-bd3a-3ecb0837007e@6wind.com>
 <fbc92957-4cf4-4687-bc2d-ed09cedf8572@lunn.ch>
 <a249ba44-a339-4f67-89a0-af08f9464c05@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a249ba44-a339-4f67-89a0-af08f9464c05@6wind.com>

> > I agree with your fix, but i would also like to know more about the
> > interfaces you are testing on. We should probably fix that device as
> > well. What is it?
> There is no bug. It is manually put down by one of our internal tests.

Are you sure?

admin down should cause the link to be dropped. You want the local
device to drop the carrier so the remote device knows you are gone,
etc. Also, dropping the carrier saves power. For a typical 1G copper
PHY, that is 1W. For a data centre connection, it can be many watts.

	Andrew

