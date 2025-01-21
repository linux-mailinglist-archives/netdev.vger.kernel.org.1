Return-Path: <netdev+bounces-160152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1329A1888F
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 00:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E511884880
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2251F55E3;
	Tue, 21 Jan 2025 23:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB0dDkJE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A7B5A79B
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 23:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737503384; cv=none; b=deI0hraGmvveUncBp47Z5cmFNZQXroFnuVuN/Pehxkd7gghyoh7oTDV9pwxoWTekzdsizDB3hFIyQtSA/FHZ/3GRyJrXKBEqny1b9aPFcvxZXgowq7kWR45a21VnAEdZx95HrWYu2PeusDzkb0Q3LaR4ZZ3XQ0c2DMFiF4s4CiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737503384; c=relaxed/simple;
	bh=Usie9GDGmYnB6p/kBB0GOtJuqrA3pP3mGMYGCo8etjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7Gf+MbYCWhuplFBR4RICVWwfAPEVCIwef04VPQupWPZQhrOVnyBXsUvcadQZK7fIfjjAqRa4cOwVIulvS0k8HQrz/KHEN99KuD1NdQZy5Q9sY+qMqZEJ0hSm2Txh7ewHvYQodIqSX/n6KRgtj08G0hBjHr1QMXuIV/lTImv1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB0dDkJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10F4C4CEDF;
	Tue, 21 Jan 2025 23:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737503384;
	bh=Usie9GDGmYnB6p/kBB0GOtJuqrA3pP3mGMYGCo8etjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bB0dDkJEpFUHasmgetfvMXdz72IVmjbpBpMXYJMPUIo9TS5v7oR1HX5H1Y/vfCn9/
	 m1SfKjk5Qt/LU35rMu0/IyzpIZTiFYQE3K5DWEk4yOoe7Ogxtvg1yhnLYKxkGLVxi5
	 yHoBrzMHYLF/qFCJzXn27zg9XkA/vJAuY1ccvBtQXk4xcVqV/+xJnJetdXLQNs2Zgr
	 XtEKOLZ5P+gbrBN+fT5NVhoDskrVw09zpsi9uOn/SWbvbK4ztxPpleeDmKfyWu1sHd
	 5pLBaZ6LOferIJZnbVSO+c34RFjhzZrFguIfLGfGskKAz13tomZCHijMl8wcXF3T39
	 JdmC/dsPYwlXQ==
Date: Tue, 21 Jan 2025 15:49:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dan.carpenter@linaro.org, pavan.chebbi@broadcom.com, mchan@broadcom.com,
 kuniyu@amazon.com, romieu@fr.zoreil.com
Subject: Re: [PATCH net-next 1/7] eth: tg3: fix calling napi_enable() in
 atomic context
Message-ID: <20250121154942.7b9cc97f@kernel.org>
In-Reply-To: <CACKFLikWkU-w+9jOQC=Mmygb-3TsQTtQWm9aLTpNG07+aXxdOQ@mail.gmail.com>
References: <20250121221519.392014-1-kuba@kernel.org>
	<20250121221519.392014-2-kuba@kernel.org>
	<CACKFLikWkU-w+9jOQC=Mmygb-3TsQTtQWm9aLTpNG07+aXxdOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jan 2025 15:06:36 -0800 Michael Chan wrote:
> On Tue, Jan 21, 2025 at 2:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > tg3 has a spin lock protecting most of the config,
> > switch to taking netdev_lock() explicitly on enable/start
> > paths. Disable/stop paths seem to not be under the spin
> > lock (since napi_disable() already couldn't sleep), =20
>=20
> You meant napi_disable() could sleep, right?

Yes :)

