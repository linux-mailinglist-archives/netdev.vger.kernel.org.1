Return-Path: <netdev+bounces-203366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6659FAF59F3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810E03B3F46
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F6283FF7;
	Wed,  2 Jul 2025 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QzAlb1xA"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507C328153D
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463731; cv=none; b=fUDquKF00N5NtaegHDYNorM7v8Vo1JKnj0aJSOQuj18lH2Ynoj9M+5JSO9jFphSE5a2aFgLpaWSbIOnCxOuaQCor3EaWSDs/J2BGNgYYKBBcb0yUMKomRmAfMgl/N7zXm9grc5NOG0Pg7K94n6D+sNO71o9h0TZs60k2pIGVAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463731; c=relaxed/simple;
	bh=b7pxCULpm20JFy6r/oOANL31+tW9KjmRDtjR0yp8gVw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=nT+vyobSQN6dqrgXduGeJN0OGqdV48hvIP5pGrcXdMBkgGXEdof9A+RD5KprfgmdQiXuLT7E3Pg/ryPv5uiomTW4BCF5gfCo1Yfg3qifvJz4ArhxFT4DoKLn9sxy3PcNa+CSBrtL3LNlBL7o9kZtz4vA0afJkLeSyQIU1sNOgKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QzAlb1xA; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751463716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tph6Iri6OgFsPEJii+Yj5f7810J94MTfrMXRVTOuE/s=;
	b=QzAlb1xAmEq/dA2u+DNC5lPfiRug48cMefhMZnNl1TXOeUHoP7sQJzu1TIKHBzT/OVTFfu
	XvpX8CHJcTjq6LBZ1DXu9t2lBH8Dwzf7/urcOyCHEDmxXo+m5Qx5wVuXV9PIZDN0+40NzN
	eXxfOrtXXl9+ItWSg4aJJmtqwPGXAr0=
Date: Wed, 02 Jul 2025 13:41:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <c9c5d36bc516e70171d1bb1974806e16020fbff1@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v1] tcp: Correct signedness in skb remaining
 space calculation
To: netdev@vger.kernel.org
Cc: mrpre@163.com, "Eric Dumazet" <edumazet@google.com>, "Neal Cardwell"
 <ncardwell@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "David
 S. Miller" <davem@davemloft.net>, "David Ahern" <dsahern@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "David Howells" <dhowells@redhat.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250702110039.15038-1-jiayuan.chen@linux.dev>
References: <20250702110039.15038-1-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT

July 2, 2025 at 19:00, "Jiayuan Chen" <jiayuan.chen@linux.dev> wrote:


>=20
>=20The calculation for the remaining space, 'copy =3D size_goal - skb->l=
en',
>=20
>=20was prone to an integer promotion bug that prevented copy from ever b=
eing
>=20
>=20negative.
>=20
>=20The variable types involved are:
>=20
>=20copy: ssize_t (long)
>=20
>=20size_goal: int
>=20
>=20skb->len: unsigned int
>=20
>=20Due to C's type promotion rules, the signed size_goal is converted to=
 an
>=20
>=20unsigned int to match skb->len before the subtraction. The result is =
an
>=20
>=20unsigned int.
>=20
>=20When this unsigned int result is then assigned to the s64 copy variab=
le,
>=20
>=20it is zero-extended, preserving its non-negative value. Consequently,
>=20
>=20copy is always >=3D 0.
>=20

To=20better explain this problem, consider the following example:
'''
#include <sys/types.h>
#include <stdio.h>
int size_goal =3D 536;
unsigned int skblen =3D 1131;

void main() {
	ssize_t copy =3D 0;
	copy =3D size_goal - skblen;
	printf("wrong: %zd\n", copy);

	copy =3D size_goal - (ssize_t)skblen;
	printf("correct: %zd\n", copy);
	return;
}
'''
Output:
'''
wrong: 4294966701
correct: -595
'''

