Return-Path: <netdev+bounces-98525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8AD8D1AAE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8361F23A8F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDA416D4CE;
	Tue, 28 May 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="307U86Bq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15E16D339;
	Tue, 28 May 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898116; cv=none; b=YLo6mkuAYtfRMnTsG6cJJl+fIwC8vSIwS+FaTb+Dq7SW3UVwZhyMfpcH+2F9+5IPWnOANtXpbyIqJj06BhPtUPXa/T1rCny559we2ZGxotDz+mNhNYEq5YXd7arbfg3JyuJrOwQWeVxxF+JVO+cGQumUE8oF3vY1q5tvCDtcy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898116; c=relaxed/simple;
	bh=dQeGBHjPQIWO+7pLwlnXWV1KMuBRTnyQEz/KMfUZSwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5krKVOBdhTdBUblIBR+jcm8WsJwGRJfAWE98WX7Mc5xPqIwhW4bhZv/UqUusCRQMldA33ocj3gF1++kDrKEGV3o7ScSyijkwrk1bvTTqj7w1V9DrK7Wx0BGqlQ2bDirBzVSGv1jcNlyF86i+NISfLPKr5VZL6/G4OV1uB8LH2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=307U86Bq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cVx5qFKGIxYr/0RCHVr63o/16UqTO6KTePA888kXg4Y=; b=307U86Bqtd+yMgnNSYNVXOKiqs
	HYPIxAyXHp1ZLoTNbhsapdqYop76Kp9Z4FB5PXX78+8Zwfd0KyEsQdZHQKGtHJH2tEqmmVQGYVAiv
	LcgJVQMpxBnXa+W5kA8eilOfGNo3iZzx1iae71xwMjn4wd/sga1zLZFkV6QGpAu6jqaQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBvcg-00G9Ld-L9; Tue, 28 May 2024 14:08:10 +0200
Date: Tue, 28 May 2024 14:08:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Nicolas Pitre <nico@fluxnic.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: smc91x: Refactor SMC_* macros
Message-ID: <c78b6a94-9379-44df-960e-cd01a9e71d45@lunn.ch>
References: <20240528104421.399885-3-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528104421.399885-3-thorsten.blum@toblux.com>

On Tue, May 28, 2024 at 12:44:23PM +0200, Thorsten Blum wrote:
> Use the macro parameter lp directly instead of relying on ioaddr being
> defined in the surrounding scope.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

