Return-Path: <netdev+bounces-105282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B47DF9105E8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671751F27ACD
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D102D1AF69D;
	Thu, 20 Jun 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeNJ18nm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C071AF698;
	Thu, 20 Jun 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890009; cv=none; b=MUJnAeuwAaxIOIptpBxYWbNfLialBA+XLskDgYNXhkv61I7fPZyDeuAp51pfNrQkaSJdnBOPzfYKe13INMcLJyP+FAwLfR2uoHk0S4CH2rk+/2TautGacIsrXVI7ZbT4CnYNUW7bqrRpM+PoQhQwu040EZr6Kc0jya93ulQ/0cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890009; c=relaxed/simple;
	bh=5+6TfDsfsUPrWZUmQaUBAnpLMQh6AHaEdq805oKkqZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ar312JR/3E+r0N5wTDQgBl+0O3MD8/wWqWBqi24yICaBYMwbA/z9gj7RfmGSTJTX6Y6w026Ll0VIbZSB/zMHF5Q+DxO8DwrpnJXxmd5rRccl2iQ3jBuvBQ36Vix1iwkkg3Fx7RMfEtkH6A+e0OS3EogRFfna02dO38SgSk7ixxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeNJ18nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBE4C4AF07;
	Thu, 20 Jun 2024 13:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718890009;
	bh=5+6TfDsfsUPrWZUmQaUBAnpLMQh6AHaEdq805oKkqZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aeNJ18nmIatSHrCUmEVR/NMNjnBbwhXS4k+lyHFW59cNyH+gf1/p2laaadaKfLsSq
	 F6VDmey2HZdBEqVZkgHqGjfgeRWGLUYYfXL7disHafDeqVfpLbzDKVCJJZYZkepOme
	 /aGGwfHRtXKyGd3luC74kkt0aevmVSHpSSCKaKoZSQSX6As7YJEe1F1B+qeg4CntwZ
	 nuDC/wi9XRRzOGobarrvqlJTdWyUvpN7jrlPN52fZLdbzIRm3Xm30Dd4fFcp6FguMf
	 rHXf3P6S0tXAuLTKHv+ATrdBHDtNCsFbvbJ0obuojrmk8tvPrwXvr8cmgDSg/LmOTf
	 V2faqBDfyeRyg==
Date: Thu, 20 Jun 2024 06:26:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <20240620062647.1111c801@kernel.org>
In-Reply-To: <652e2d45-749e-4492-a00c-c0a2d15ab3a3@amperemail.onmicrosoft.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
	<20240619200552.119080-1-admiyo@os.amperecomputing.com>
	<20240619200552.119080-4-admiyo@os.amperecomputing.com>
	<20240619162642.32f129c4@kernel.org>
	<652e2d45-749e-4492-a00c-c0a2d15ab3a3@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Jun 2024 23:24:41 -0400 Adam Young wrote:
> > drivers/net/mctp/mctp-pcc.c:344:3: error: field designator 'owner' does=
 not refer to any field in type 'struct acpi_driver'
> >    344 |         .owner =3D THIS_MODULE,
> >        |         ~^~~~~~~~~~~~~~~~~~~ =20
>=20
> Not sure how you are getting that last error.=C2=A0 I do not, and the v6.=
9.3=20
> code base has this in include/acpi/acpi_bus.h at line 166

v6.9.3 is not a development kernel. Your patches will be merged to net-next.
Read more of the process doc I linked in the previous message.

> That runs clean.

It doesn't on patches 1 and 2, but you're right, I think it's
intentional / because of the "historical" ACPI coding style :(

