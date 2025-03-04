Return-Path: <netdev+bounces-171760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BC7A4EA2D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285298E119F
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE30291FA9;
	Tue,  4 Mar 2025 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NMI+5nR0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BD132111
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106647; cv=none; b=pwDiS9qLw9IX+GCBU6XfYp5qVyquhYcNemxVOE02Wtue/APqU3uL+94lnlUYq3Xd3zOJ4J6cTM0o6jda5CEscdbBW2QiznXCFNKpcAjeemlqXDjvPvlBOZh5NbMhhdqbWCJTXRNDnkJ61OZhTR5BvD8VgCilY/BUR295PkmoUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106647; c=relaxed/simple;
	bh=VeGBsb5Xck8Tta1xvgou1PGdFXEKArsNi6SaIfxPX2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxcG8c1kQSQKKssIsJ+TH6p6Y46a9j0lM8glIR2xSEdacPIOkJjCXx1MfcP8w+hSgOjAzfvMPPNBkqq1bwLJKQWJVTDz4c7goPOnzsVQD6ckCdUeI0h6dsa5j/G25ma1Vut5cot7nAwx8Q2LArSKiw+cFp7QK0on0pAZg+X2+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NMI+5nR0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eCQOn1hj0IetOvRdhzAd2kd70BkF5pWeIArj/vy9gzE=; b=NMI+5nR0oGJ+Q+V2siw5a4stbd
	e3LsU3NGYHr0uubQw1DBKWmXTzPwpoGzXz9do0LfCestzZy2Fx1Ij0S0WGUxOCQOpUWvF7sxiYkE6
	6roiJjLfiF6wqPALglxP2IAeMK53dNHxFtEHCS5BU4oJKrYdd0r6lXzRudKvWVgS69SY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpVNC-002CPU-Md; Tue, 04 Mar 2025 17:44:02 +0100
Date: Tue, 4 Mar 2025 17:44:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Viktar Palstsiuk <viktar.palstsiuk@dewesoft.com>
Cc: hkallweit1@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: phy: dp83869: fix status reporting for speed
 optimization
Message-ID: <717fcb04-6f9b-4c2c-9fe6-4c2d2131671a@lunn.ch>
References: <20250303102739.137058-1-viktar.palstsiuk@dewesoft.com>
 <3a80404e-9baf-423c-bc5e-22c3d80a0cec@lunn.ch>
 <CAHQtF0u3zXqLcd73xk5G0+g5Tek65M=NfOSkfvRz75B7wY3pXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQtF0u3zXqLcd73xk5G0+g5Tek65M=NfOSkfvRz75B7wY3pXA@mail.gmail.com>

On Mon, Mar 03, 2025 at 04:41:54PM +0100, Viktar Palstsiuk wrote:
> Yes, the term "speed optimization" is used in the DP83869 datasheet
> for downshift.

Please could you reword the commit message to use both the datasheet
terminology and the kernel terminology. That makes the change easier
to understand for everybody.

    Andrew

---
pw-bot: cr

