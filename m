Return-Path: <netdev+bounces-197595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A71AD946C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D4837ABEC0
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523B822F766;
	Fri, 13 Jun 2025 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XUqnmCZ5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92022DA17;
	Fri, 13 Jun 2025 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749839331; cv=none; b=Flk0bGqv0J6UW3sMiVggFjngqgoF41gQndkDMnGNVpDFez/b/joAxaGvoia7xN3YpwN9B1dncDPwVkNCUnb63ElMgO0JuVrnxKn0/W5YZK6rTzMv0wLYXSAXkCvM01DOIpGLZ2/pKEZ2yUQ511ZCdHqD9SVq9b9RJ1nJl6sTBe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749839331; c=relaxed/simple;
	bh=vx+L4EWcVjAmC1H85Z6K9NQ6o3bPzGB68D+lyL43M80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfB/DCpGXRnRdPwsvWX9SJcjrs/2lKiBAkNZnZp6d9tZKzl5r+rHEyndz8bTE4U2gMnjyQ47ervKKYIDA/rFT8+S4x4dCgRZa0DoC9ISBVrbDpYd22VMbir2rHJAPMTgWcQFvzZm04rIm7uWD1QPN1NNW+bUnQMmB6M8R3OmWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XUqnmCZ5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aZeDv6uJiL3yHMZHYwsHRlG5PjnadZxlMcLR2eb7Kl0=; b=XUqnmCZ5YH2M/SgnKbr15HrSL4
	MLUt2m8EpiC13BLUOb1Ldml0LWp/7AyCxhtdk8EhiDvWQFky1oVs12OPo2LKNw0meyIjuoTisGsIS
	ucC++UKd1ju7M6uDD3+KwNqPDNp+TykcKIlJ7qaN9GbO5Mz3e9IMz96HqAf2Z0esD5hU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ98q-00Fksu-0N; Fri, 13 Jun 2025 20:28:40 +0200
Date: Fri, 13 Jun 2025 20:28:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH net-next v2 05/10] net: fec: fec_restart(): introduce a
 define for FEC_ECR_SPEED
Message-ID: <4689760b-18ac-4a3a-b6ff-b21f099aee16@lunn.ch>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
 <20250612-fec-cleanups-v2-5-ae7c36df185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-fec-cleanups-v2-5-ae7c36df185e@pengutronix.de>

On Thu, Jun 12, 2025 at 04:15:58PM +0200, Marc Kleine-Budde wrote:
> Replace "1 << 5" for configuring 1000 MBit/s with a defined constant to
> improve code readability and maintainability.
> 
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

