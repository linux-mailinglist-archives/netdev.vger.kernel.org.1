Return-Path: <netdev+bounces-73332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B38D85BF14
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 15:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8301C23508
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE1E73165;
	Tue, 20 Feb 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KNHYsIDn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06876F51C
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440475; cv=none; b=ho6GgFayMgPyPckFi5un0HI86X75uDxl1DmXvuc+osW5IAjdgbbPtOsaqfI3dG+U66/Ar84qI2V/dOiZ4fhOcQo9tli2r+N2mj8n52n3E7yhBoZPVvhs7yKKxj5t24G3cLXN+OZ2Z0O8E4BYTnzNZ8hrTIkKQsXGKnoBVUdys9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440475; c=relaxed/simple;
	bh=xcKwrAzsBz4ZR8PFeoQ3SMHAAKFb7X1c3uA62MpyX0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5mKz3sEMjV4lnYFhcIOBxeIRd3BMkhIYz00G+3wgy4qNL/8fP09mLH9gfEW5Af13pxsK/j8x5nbc5enbNx/r6Sj5T8yLCplCV0lrsTSqsose+gzglmlGnnHssqXgWD52yMos+p1UCYnhgbYt4eaFRrQzY1cY99td+y9TKL+hoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KNHYsIDn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3T378xVKsT3QjhFte78N5ojvE0rsiQQOMmnoWU0sR7w=; b=KNHYsIDnvoQNdFQ0vAh9VPuugO
	ZKs5bVOox37LWDcYyH9F4Qas6SfCo/gFr7ApZlkjtajmR3C117iWrL38Yk2pijlGhFPkiCw1RsqKt
	wfnxH0if4iBw2kXJjjcTzjqgoXkVsIvClsri8b5Ss1udXeDwLmJ6XrQO4sepvuEo2TQQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rcRPc-008I6b-9y; Tue, 20 Feb 2024 15:48:00 +0100
Date: Tue, 20 Feb 2024 15:48:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] tg3: simplify tg3_phy_autoneg_cfg
Message-ID: <c8dba169-a0ec-4e8f-bc96-4a8d4787ebc4@lunn.ch>
References: <9fcf20f5-7763-4bde-8ed8-fc81722ad509@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fcf20f5-7763-4bde-8ed8-fc81722ad509@gmail.com>

On Sun, Feb 18, 2024 at 07:04:42PM +0100, Heiner Kallweit wrote:
> Make use of ethtool_adv_to_mmd_eee_adv_t() to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

