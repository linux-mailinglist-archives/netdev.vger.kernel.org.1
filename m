Return-Path: <netdev+bounces-218627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5950B3DAF1
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD9C1667DF
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A21D259CBB;
	Mon,  1 Sep 2025 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="OgHq9ONC"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEDB1F428F
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756711476; cv=none; b=Xqo8Q2W3o2KowvGqjWwgn/vV+xEqxDXdn+59KSw7M9rtwykK1Uiovghj50dyR15F8FxLWlqnGcRRBi67QI8VyoA4VFYVKjlzZjSLFuvEQ4yQ0SK/FY0W5jBXdPIHf6RqeWzgWZHADL8bzWQqfyyppyEfYtSh/83y308LE0Tmayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756711476; c=relaxed/simple;
	bh=GPcbmmiFjlzxoGAYefZaCHrsAfxi2c2VQpq2TJjQOf4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QripEGx7Zey4t8Zr3ihhK3RJ89mXyMf6atsHeHuAPPoWdmXR4J0lrKmTRHHvIoPOzqX69QnbfCZ9K/HyMANBg1qcaqyTUDgTRZXGp/uoUWGv39BREU1PwTIbAVsHAVX8ofdn2QysorCb/ypCIlrIHSh/TIskLAZtW1ERJV8+Ppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=OgHq9ONC; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756711471;
	bh=GPcbmmiFjlzxoGAYefZaCHrsAfxi2c2VQpq2TJjQOf4=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=OgHq9ONCrNvJ6AOlcdZv+759bz4/nqqJGvfYdvRxEagYZa+5/vUXj3/MRJC5LA/i4
	 qhJIv2q3mfTE3TLh/BhVfX2t0jvXzelwSTNmdUaADmtL6yoX3advlGHaG6vp22MaDM
	 vPGoth4h6JayP78hiJTidysTeTGA9/J+4tTJzOdTMHbqUFUT/S+cT6D8UTjEvrdkB5
	 23LLqwIEjGzpfKpHMAGbreNQl5yfXlrqfJQnYeRs4p64L4y+NFruZ+V01jmRUaOFbo
	 2NcmODKOqs3W9RCfb9OLaWNGkvaxCwfSDBuQtPJgAWU6C6OQxL6N1AEFRi3clj8DEu
	 0O/aDkU+d7lFg==
Received: from [192.168.72.161] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5DD0464CF7;
	Mon,  1 Sep 2025 15:24:31 +0800 (AWST)
Message-ID: <048e6efc6e61901d0df3defaf6cc64c2afa5f937.camel@codeconstruct.com.au>
Subject: Re: [QUERY] mctp: getsockopt unknown option return code -EINVAL
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, matt@codeconstruct.com.au, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  horms@kernel.org, netdev@vger.kernel.org
Date: Mon, 01 Sep 2025 15:24:31 +0800
In-Reply-To: <20250901071156.1169519-1-alok.a.tiwari@oracle.com>
References: <20250901071156.1169519-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Alok,

> Would it be ideal to return -ENOPROTOOPT instead of -EINVAL in
> mctp_getsockopt() when an option is unrecognized?
> This would match the behavior of mctp_setsockopt() and follow the
> standard kernel socket API convention for unknown options.

Yes, I think this makes sense, and probably extended to the level !=3D
SOL_MCTP checks too.

Is there a particular path you're looking at here?

Cheers,


Jeremy

