Return-Path: <netdev+bounces-192741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED966AC0FEC
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2147B4E197D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C88298269;
	Thu, 22 May 2025 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p34b+sSO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF0291869
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927612; cv=none; b=MelkwOS0h2s2/IAGsRAuuKsvYDmAw6rljqc0AVV0HU5oI63PZxMX0jgV39eapkPaGVnz7ZAnEylmR9rGO0qgVeBohr30u/8rqVCI8aWoqtTmuzdstP9Pd1mBXfWRUMbAZe3jrSCjwaISvqeHs1KCe0lxNeCr6U/nECC12pC7JIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927612; c=relaxed/simple;
	bh=Pv94H2pDXsYpMFyCGmfr8sAIbVX8HJmOkdf0lqan8Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqsBLlP0EdqVqk9xOLdpfe68bl+0Mul0BcGje38JAOkIXDNJxbo80Ju1hfkL7xc+ImHMwgHP/bMAEYAXD7XmLvTCTmJdeTsI8nRZ+LgXAAHsPeLwViYOAb9FuB58Y8tt5NOxOyxeNcoT63leiqFEE7jgyNnCuqtwqrJcPpurpc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p34b+sSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356BBC4CEE4;
	Thu, 22 May 2025 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747927611;
	bh=Pv94H2pDXsYpMFyCGmfr8sAIbVX8HJmOkdf0lqan8Ng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p34b+sSOLV5uJd7u9ObPmBwJEs1ErSt2EJU93XSkm3BaS+IF2vdq7fNwpUN/xsBRv
	 t6HzY0iZYsquDkBRkVQNxGZBi9tYPFY/5ek67hSw0OZMx6Z3F6I41NYstlOEvw5LcB
	 hCzpeucGeI+rBMe0TaLFcCzseZcCe0vHlQc0zkAHCq4ENHaMycQ1kU0hRezkSutZfZ
	 EKK/8f3F0vjg/t5ZMqjZ4CdE6udgTjltPqZtIe8hG6YRPSjD4xYrtzjkyb6htjvwCN
	 eUjfIjc97EpL5QZ8g6LuaAdzbpPquc6dVvXXAHCQ3ykp9rLy929NZLrqH0FnFGutKM
	 ujstWeEWitq9w==
Date: Thu, 22 May 2025 08:26:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS
 contexts on queue reset
Message-ID: <20250522082650.3c4a5bb2@kernel.org>
In-Reply-To: <423fd162-d08e-467e-834d-2eb320db9ba1@davidwei.uk>
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
	<20250519204130.3097027-4-michael.chan@broadcom.com>
	<20250520182838.3f083f34@kernel.org>
	<CACKFLikOwZmaucM4y2jMgKZ-s0vRyHBde+wuQRt33ScvfohyDA@mail.gmail.com>
	<20250520185144.25f5cb47@kernel.org>
	<CACKFLimbOCecjpL2oOvj99SN8Ahct84r2grLkPG1491eTRMoxg@mail.gmail.com>
	<20250520191753.4e66bb08@kernel.org>
	<CACKFLikW2=ynZUJYbRfXvt70TsCZf0K=K=6V_Rp37F8gOroSZg@mail.gmail.com>
	<423fd162-d08e-467e-834d-2eb320db9ba1@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 May 2025 12:01:34 +0100 David Wei wrote:
> On 5/20/25 19:29, Michael Chan wrote:
> > On Tue, May 20, 2025 at 7:17=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote: =20
> >> "reliable" is a bit of a big word that some people would reserve
> >> for code which is production tested or at the very least very
> >> heavily validated. =20
> >=20
> > FWIW, queue_mgmt_ops was heavily tested by Somnath under heavy traffic
> > conditions.  Obviously RSS contexts were not included during testing
> > and this problem was missed. =20
>=20
> IIRC from the initial testing w/ Somnath even though the VNICs are reset
> the traffic on unrelated queues are unaffected.

How did you check that? IIUC the device does not currently report
packet loss due to MRU clamp (!?!)

> If we ensure that is the cse with this patchset, would that resolve
> your concerns Jakub?

For ZC we expect the queues to be taken out of the main context.
IIUC it'd be a significant improvement over the status quo if
we could check which contexts the queue is in (incl. context 0)
and only clamp MRU on those.

