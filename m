Return-Path: <netdev+bounces-203408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4B4AF5D4D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBF41883F57
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4C33196C5;
	Wed,  2 Jul 2025 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kC4dKTZw"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B7D3196B0
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470092; cv=none; b=Fu34Gbbws/JmzEy46fW1ms73Oej0y5HoF2EU588ofoj6Rr25x3i5hQIQbg8EEiIZeITvOQux6aK34T8BS4cbTpNxnSFYXHhQ+3q7z0vvwr1tVXbKsIJOTL1pfQIeuG4Wgc2ekF7FBPRY/bKAxZDvWHHmesBXP/gsJd7PHKzalhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470092; c=relaxed/simple;
	bh=toA1Z/HEzEC87vvHzwP53jgQyCAQTPKIkkCux8WahSA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Z9r26EzZD92Bq/VxKfFe6uPBVu+QcfnJ2iOy8CHhtlwIbFQIUvmGnwAcdzskKPQQPOWubDeP4bJXrsIEN3ZsHe8NzmtD14l6lfhxanfjqNZAGSwXCaWtArbb3I8or6fMXRhaA8EGelG8R5Tq0MEenciwe1py7s0Ki2yAqtueS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kC4dKTZw; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751470078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j37gTI83G/0npP0vUifckHIJRdF1qjNhI6E7oZQqNe0=;
	b=kC4dKTZwI8kVcBTPiULB/3Z1bTjznXesHizU2OBZDrOWKE+8E0ZCWvdtSkmYGE+WsQTBFo
	ROoEoxz3FgmIkC711b2kv6tqHY7tExrnI2gvGqPhkvZ78pyYIB9sK+6qLW5oEsSARImbzk
	6ETnWVuy1ZP6hN7cALaosa06Nnvb22Q=
Date: Wed, 02 Jul 2025 15:27:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <c910cfc4b58e9e2e1ceaca9d4dc7d68b679caa48@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v1] tcp: Correct signedness in skb remaining
 space calculation
To: "Eric Dumazet" <edumazet@google.com>
Cc: netdev@vger.kernel.org, mrpre@163.com, "Neal Cardwell"
 <ncardwell@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "David
 S. Miller" <davem@davemloft.net>, "David Ahern" <dsahern@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "David Howells" <dhowells@redhat.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <CANn89iJD6ZYCBBT_qsgm_HJ5Xrups1evzp9ej=UYGP5sv6oG_A@mail.gmail.com>
References: <20250702110039.15038-1-jiayuan.chen@linux.dev>
 <c9c5d36bc516e70171d1bb1974806e16020fbff1@linux.dev>
 <CANn89iJdGZq0HW3+uGLCMtekC7G5cPnHChCJFCUhvzuzPuhsrA@mail.gmail.com>
 <CANn89iJD6ZYCBBT_qsgm_HJ5Xrups1evzp9ej=UYGP5sv6oG_A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

July 2, 2025 at 22:02, "Eric Dumazet" <edumazet@google.com> wrote:



>=20
>=20On Wed, Jul 2, 2025 at 6:59 AM Eric Dumazet <edumazet@google.com> wro=
te:
>=20
>=20>=20
>=20> On Wed, Jul 2, 2025 at 6:42 AM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
> >=20
>=20>  July 2, 2025 at 19:00, "Jiayuan Chen" <jiayuan.chen@linux.dev> wro=
te:
> >=20
>=20>  >
> >=20
>=20>  > The calculation for the remaining space, 'copy =3D size_goal - s=
kb->len',
> >=20
>=20>  >
> >=20
>=20>  > was prone to an integer promotion bug that prevented copy from e=
ver being
> >=20
>=20>  >
> >=20
>=20>  > negative.
> >=20
>=20>  >
> >=20
>=20>  > The variable types involved are:
> >=20
>=20>  >
> >=20
>=20>  > copy: ssize_t (long)
> >=20
>=20>  >
> >=20
>=20>  > size_goal: int
> >=20
>=20>  >
> >=20
>=20>  > skb->len: unsigned int
> >=20
>=20>  >
> >=20
>=20>  > Due to C's type promotion rules, the signed size_goal is convert=
ed to an
> >=20
>=20>  >
> >=20
>=20>  > unsigned int to match skb->len before the subtraction. The resul=
t is an
> >=20
>=20>  >
> >=20
>=20>  > unsigned int.
> >=20
>=20>  >
> >=20
>=20>  > When this unsigned int result is then assigned to the s64 copy v=
ariable,
> >=20
>=20>  >
> >=20
>=20>  > it is zero-extended, preserving its non-negative value. Conseque=
ntly,
> >=20
>=20>  >
> >=20
>=20>  > copy is always >=3D 0.
> >=20
>=20>  >
> >=20
>=20>  To better explain this problem, consider the following example:
> >=20
>=20>  '''
> >=20
>=20>  #include <sys/types.h>
> >=20
>=20>  #include <stdio.h>
> >=20
>=20>  int size_goal =3D 536;
> >=20
>=20>  unsigned int skblen =3D 1131;
> >=20
>=20>  void main() {
> >=20
>=20>  ssize_t copy =3D 0;
> >=20
>=20>  copy =3D size_goal - skblen;
> >=20
>=20>  printf("wrong: %zd\n", copy);
> >=20
>=20>  copy =3D size_goal - (ssize_t)skblen;
> >=20
>=20>  printf("correct: %zd\n", copy);
> >=20
>=20>  return;
> >=20
>=20>  }
> >=20
>=20>  '''
> >=20
>=20>  Output:
> >=20
>=20>  '''
> >=20
>=20>  wrong: 4294966701
> >=20
>=20>  correct: -595
> >=20
>=20>  '''
> >=20
>=20>  Can you explain how one skb could have more bytes (skb->len) than =
size_goal ?
> >=20
>=20>  If we are under this condition, we already have a prior bug ?
> >=20
>=20>  Please describe how you caught this issue.
> >=20
>=20
> Also, not sure why copy variable had to be changed from "int" to "ssize=
_t"
>=20
>=20A nicer patch (without a cast) would be to make it an "int" again/
>

I encountered this issue because I had tcp_repair enabled, which uses
tcp_init_tso_segs to reset the MSS.
However, it seems that tcp_bound_to_half_wnd also dynamically adjusts
the value to be smaller than the current size_goal.

Looking at the commit history, it's indeed unnecessary to define the
copy variable as type ssize_t.

