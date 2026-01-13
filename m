Return-Path: <netdev+bounces-249462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3220FD19600
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CE6230301A5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D34427381E;
	Tue, 13 Jan 2026 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UZfhdV+U"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1258283CB1
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313748; cv=none; b=s20M/U+L5GzocItwI0AAEA714X8ReMBQcRxuqn8xjk9RvkAiI3T8BuBSzLcdMbTLgYSo/2jpgneYQGzw42iciJXNhn9C+PDBNnzM48pKJGmlC5clLhrLRTu9vxWhowQ/ftXlkED0ZEQF5+CrlDBJHb6y/Y9WeIavAk1H/4L8s10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313748; c=relaxed/simple;
	bh=jbgj13ejTQDpFh+6HEeM+Bbg/KrpUKGbx9DpJ2yMlFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZzPELTzX3VopTeJqY0QDOfwxTxHp+j/LIUcG2MLafJTjhPJhByCJ64e21B6gKQ+upBtzq+atQ2VqRPJncCmG0ajMs0evJ0wjlrQMlLsvbM5YHGKDqIKH+TMNK1Qv01jrrJy7kRCEFde+rpq8YvPcTe5t0tcmtrFwaHHnVdved8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UZfhdV+U; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fy2VDSXDVg8Cgx8yPUuNm75Dz62t1/dRMPKHc+PBx4Q=; b=UZfhdV+U9ba1TRkED1WeHGIupU
	S08UQKpPgt+ck/NH7JRAgi5nexANFgD3E3Dp/xTahxEPUPgOs7Vo9XEgm5MCyMWXa2RaVOxDgdF3J
	s7xo0Kcj82lPGPFQvHj6oSBXWC3lYeEhSgqoZFOSBPKR8iwW5H3tvm6JPkQ0VgZkj0r0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vffBN-002diQ-EW; Tue, 13 Jan 2026 15:15:41 +0100
Date: Tue, 13 Jan 2026 15:15:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v1 6/7] ixgbe: replace EEE enable flag with
 state enum
Message-ID: <cb9f2295-0f1d-48a3-ab53-3d51c2930f94@lunn.ch>
References: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
 <20260112140108.1173835-7-jedrzej.jagielski@intel.com>
 <8f976990-1087-4ba0-a06d-c0538c39d2a3@lunn.ch>
 <PH0PR11MB59027E7BBF8EF6121DF24DDCF08EA@PH0PR11MB5902.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB59027E7BBF8EF6121DF24DDCF08EA@PH0PR11MB5902.namprd11.prod.outlook.com>

> OK, so you mean it's redundant? There's no need to explicitly state that
> EEE needs to be disabled when it i not capable of beeing still on due 
> to unsupported link conditions?
> Probably i would need to check how E610 behaves in such scenario.

It would depend on what your firmware is doing, but if it is
implemented correctly, there should not be any need to change the
configuration. ethtool_keee->eee_active should indicate the status of
the negotiation. If you are in a link mode which does not support EEE,
so it is turned off in the MAC, set it to false. supported_eee,
advertising_eee lp_advertised should not care about the current link
mode or the value of eee_active.

And you probably want to check for how phylink and phylib handle this,
since they are the most used implementation and so the reference.

      Andrew


