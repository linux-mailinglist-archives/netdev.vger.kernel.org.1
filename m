Return-Path: <netdev+bounces-218585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC30B3D638
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 03:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4162416D5B1
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 01:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B0E1487E9;
	Mon,  1 Sep 2025 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bjv7ld1y"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533AA1CD15;
	Mon,  1 Sep 2025 01:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756688840; cv=none; b=OTk6+VuIXm1Mi6qCKruwuLY2kEz6XB4R1w7F/eeQ8hhApeAXW48qfmC/W8t4bl4QUSs3c591OA52BD3wlCLzz2nMSEA+sU3HFSNRkb7DKpPHAQAVS0RbFeCeUhTvUMgD6cRVUdWGdM26vDMmn7X3QEaOU88pFYJz+AW6FT0s99g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756688840; c=relaxed/simple;
	bh=Md8TFuP19NhcbqQn8poGQcHlc3x/YNcu37Q5pju81tE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mj9VjrY/oNce4fKjbj6YKJLz3l9sGJ/OgK1bVQjVLlH6I1B14aSvlv2+8mrDHkIpqZBcnR8EluiVMj+O8Y60cp+bMCdk7AnBlNaSMFkYNsIKD9f5ztfFzuyf/cVumv1HArpml15n0jRG0XU1LmBqu7b448w4Ecb72hbg3nBeXuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bjv7ld1y; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756688368;
	bh=Md8TFuP19NhcbqQn8poGQcHlc3x/YNcu37Q5pju81tE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bjv7ld1y4TEMjPOcWA7dvybV3M8YUmWUjMnzLi6n0ylo5iVnYJMZ9VxWqht2LwtII
	 6K6DomMA7mLrpMYdkCVZNmjI66lfdx6EHxDvobKT2sDuwQTPM1U6+vz9v2OHdqlxp7
	 iu0212nylIJ8O9zArMjEIOX6lXzZXNdhlhCi4jzKYY3+9oDn2Fk9R5HQDBAWTGei82
	 sJot+Ci4u1aKk5k68vWV09yS4RzZ4IhBA5avWUL+rJr31Y3cGzUwrHrFbQYnvm4B/q
	 r2Mxr9M/GOR/c9w3kPuwwou6ou5X7AzL9Q5L4QUtXjwE1QdPbMtWTCZygSns0gPzwL
	 Hkf87EaeWU85Q==
Received: from [192.168.72.161] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 27A2964CF7;
	Mon,  1 Sep 2025 08:59:27 +0800 (AWST)
Message-ID: <61914df7e54eb4279627697ceb11f8aae0e5b77b.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v25 1/1] mctp pcc: Implement MCTP over PCC
 Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, admiyo@os.amperecomputing.com, 
 Matt Johnston <matt@codeconstruct.com.au>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Mon, 01 Sep 2025 08:59:28 +0800
In-Reply-To: <25237d53-a93d-4c1f-a7a4-4b6ed03e10e4@oracle.com>
References: <20250827044810.152775-1-admiyo@os.amperecomputing.com>
	 <20250827044810.152775-2-admiyo@os.amperecomputing.com>
	 <25237d53-a93d-4c1f-a7a4-4b6ed03e10e4@oracle.com>
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

+1 on all the recommended changes from Alok, except for:

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0snprintf(name, sizeof(name),=
 "mctpipcc%d", context.inbox_index);
>=20
> mctp_pcc%d ?

Please keep this as you have in v27, as mctppcc%d, so we're consistent
with other MCTP interface naming.

Cheers,



Jeremy

