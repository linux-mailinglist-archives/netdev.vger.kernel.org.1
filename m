Return-Path: <netdev+bounces-214424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 950C5B295DB
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 02:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DC11966340
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 00:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45508632B;
	Mon, 18 Aug 2025 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="KMVqDQpo"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E6F26AE4;
	Mon, 18 Aug 2025 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755477240; cv=none; b=CHXeku06Z9m1+2yZnu56pssihIK2CPZd28k6dUyDUpNKOKI38tUHbAxQOykXGuo3bf286hOFXjjexdH5rwTfEzfvlYZguD/BhtTPu12h8qQvv2jBwe9X2VLsb2fkHBeVkwF4jYgYiLFSklKU3ARUok9yy+BRHOBccDqTsWkjQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755477240; c=relaxed/simple;
	bh=i7v+jmozaxU/yN8mCTMzUUNms7yFfLWNhtUZ5EWwTHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LITkXB05NS3uF3sKib7x3knPVxd/osHTc7dw//qoggaIYhEQa+7ofWOnJt769shOz3r0U5PFrjZX88BQNTs47/MTgCXgNFf3AReWFY0zqcBodwuS/0RXvOSVYNswrpEQjz6OvC8yz/C81bKNLMag2kh7M+rUrCwKdaRCNa+cEFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=KMVqDQpo; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1755477229;
	bh=i7v+jmozaxU/yN8mCTMzUUNms7yFfLWNhtUZ5EWwTHA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KMVqDQpoCODoqrUuUj0+iVX3ndJEWIG7ImLxce1cAfbEA+K2YAaf3yNeSI8nA98U1
	 UWLXcbtXn3KRnW2psD6o48g8Ox3VodOmQJ5YcH7kOjiVezF4P382KAjqXGJvjaH0XE
	 7T3XWXxBKU6UX9+YO9fw99RcpZaqMEwut1HuOE+OidjxMgHwh/uQ4v8yPMTT7BXnSh
	 qmZOndUXEXmFc1liVy779c3OH2y+7LG4BI3rks7O4yPCFK1ZzMcfPLw+/HfMzfTDLn
	 aS1kmGQQOz7UBx7Qua4minFBs55T9l+a516vMcKKDiPCfxYR2kljunuGnVuvLGRSYR
	 vqqGZ5mcSkolw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4E12E69374;
	Mon, 18 Aug 2025 08:33:48 +0800 (AWST)
Message-ID: <d6b7d0c82806ef41bc7ee7173595d334acbf3b17.camel@codeconstruct.com.au>
Subject: Re: [PATCH v24 1/1] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, 
 admiyo@os.amperecomputing.com, Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Mon, 18 Aug 2025 08:33:48 +0800
In-Reply-To: <5a061bbd-637b-41c1-a6a7-5a14e479e572@amperemail.onmicrosoft.com>
References: <20250811153804.96850-1-admiyo@os.amperecomputing.com>
	 <20250811153804.96850-2-admiyo@os.amperecomputing.com>
	 <42643918b686206c97076cf9fd2f02718e85b108.camel@codeconstruct.com.au>
	 <5a061bbd-637b-41c1-a6a7-5a14e479e572@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Adam,

> > And just confirming: the pcc header format is now all host-endian - or
> > is that a firmware-specified endianness? (what happens if the OS may
> > boot in either BE or LE? is that at all possible for any PCC-capable
> > hardware, or are we otherwise guaranteed that we're the same endianness
> > as the consumer?)
>=20
> The specification does not specify endianess.=C2=A0 It is not addressed i=
n
> the ACPI=C2=A0 PCC spec nor the MCTP over PCC spec. There does not seem=
=C2=A0 to=20
> be any endianess modifiers in any of the ACPI code base.

There are a few cases of endian conversion, they appear to be cases
where a pre-defined data format is used, and only where that data is BE.

That's a pretty strong indication that we don't need to worry about host
endian !=3D firmware endian (I'm assuming that firmware is the entity
that parses the PCC headers you're constructing). All sounds good then.

Cheers,


Jeremy

