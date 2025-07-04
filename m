Return-Path: <netdev+bounces-203965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DAEAF8635
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857061C40194
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BC21078F;
	Fri,  4 Jul 2025 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gadcINUu"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7A1C28E;
	Fri,  4 Jul 2025 04:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751602186; cv=none; b=jTxq2W+23xWfs6VATQuc4rSiAtEfmO58a9ng9B4f9PbIeG1irNR4Zo7j4NUewSORmP44HiOJ3nPW+up5Cmu1sknmWBmFhA1/Ev6ZIoXkE3dCIPqcylC9eNhXqB4Oxssa0BmIB/q0Upttx5FlfVZ6k1WFkw5OqtHjClrKNcg4Hh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751602186; c=relaxed/simple;
	bh=NuTXy5WMCH00kP5NE8jojIc7E0/NGT4JS+O7qSkAWvE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jtf7uQCkIorY4bI/waRrVxLro/eX10lhTYNNhGwt8003ZAsawWdcqkW7FfGjJZs5oLd/4Jd/59/eZMnXppScQOsawOVbMdLhKIwjU9CwSqBtdC+zkV3V0JX+lL1mXLvgKckrdNfCCiKAql+MzeKjgpMWqRSFk38aqMU4dmy/bxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gadcINUu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=xVhyq3GAC3zK0skZbh1GvKpLi8ozrAxJQgU1jxCDsAw=; b=gadcINUuNR6ega90tbZtZW64df
	RvtQ1sLPUdCqjCUAiqgrZ/czweLaj42cJxsCYVtjTRECbLWQldOdYusinQR7V+0UnvIfM/JBVHZal
	4FghRFRu53FaOlDqpLFPlRjf97adW0mCDGLMU5snt/wKCiaulQtiJeK40Oz4XQ9hPNYkl1vlf42qU
	abe59qlidfvie7/df4QXG8IBt04BV2LjMoLOarwm96/E7y6rZNnK2KFlMLIULXlS0vSLX/3n/prOn
	Pf/D9Vz6hHdI7b3LZFFKHK4XWhfKulK5egK6i94aHGpUv2b9a9UDU4/MSSMNZaGWUPkriKYKAwnWg
	4g6uqmlA==;
Received: from [50.53.25.54] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXXjy-00000007maA-0sDv;
	Fri, 04 Jul 2025 04:09:35 +0000
Date: Thu, 03 Jul 2025 21:09:30 -0700
From: Randy Dunlap <rdunlap@infradead.org>
To: nicolas.dichtel@6wind.com, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 Gabriel Goller <g.goller@proxmox.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Ahern <dsahern@kernel.org>
CC: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_ipv6=3A_add_=60force=5Fforwarding?=
 =?US-ASCII?Q?=60_sysctl_to_enable_per-interface_forwarding?=
User-Agent: K-9 Mail for Android
In-Reply-To: <869cd247-2cde-46bd-9100-0011d8dbd47c@6wind.com>
References: <20250702074619.139031-1-g.goller@proxmox.com> <c39c99a7-73c2-4fc6-a1f2-bc18c0b6301f@6wind.com> <53d8eaa7-6684-4596-ae98-69688068b84c@infradead.org> <869cd247-2cde-46bd-9100-0011d8dbd47c@6wind.com>
Message-ID: <D20FF7E9-0A12-40F9-B134-BD78A8C59745@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 2, 2025 11:58:16 PM PDT, Nicolas Dichtel <nicolas=2Edichtel@6wind=
=2Ecom> wrote:
>Le 03/07/2025 =C3=A0 00:26, Randy Dunlap a =C3=A9crit=C2=A0:
>
>[snip]
>
>>>> +static int addrconf_sysctl_force_forwarding(const struct ctl_table *=
ctl, int write,
>>>> +					    void *buffer, size_t *lenp, loff_t *ppos)
>>>> +{
>>>> +	int *valp =3D ctl->data;
>>>> +	int ret;
>>>> +	int old, new;
>>>> +
>>>> +	// get extra params from table
>>> /* */ for comment
>>> https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Eg=
it/tree/Documentation/process/coding-style=2Erst#n598
>>=20
>> Hm, lots there from the BK to git transfer in 2005, with a few updates =
by Mauro, Jakub, and myself=2E
>>=20
>>=20
>> More recently (2016!), Linus said this:
>>   https://lore=2Ekernel=2Eorg/lkml/CA+55aFyQYJerovMsSoSKS7PessZBr4vNp-3=
QUUwhqk4A4_jcbg@mail=2Egmail=2Ecom/
>>=20
>> which seems to allow for "//" style commenting=2E But yeah, it hasn't b=
een added to
>> coding-style=2Erst=2E
>I wasn't aware=2E I always seen '//' rejected=2E
>
>>=20
>>>> +	struct inet6_dev *idev =3D ctl->extra1;
>>>> +	struct net *net =3D ctl->extra2;
>>> Reverse x-mas tree for the variables declaration
>>> https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Eg=
it/tree/Documentation/process/maintainer-netdev=2Erst#n368
>>=20
>> Shouldn't maintainer-netdev=2Erst contain something about netdev-style =
comment blocks?
>> (not that I'm offering since I think it's ugly)
>>=20
>It has been removed:
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
commit/?id=3D82b8000c28b5
>

Oh, thanks=2E  Sorry I missed that patch=2E=20



~Randy

