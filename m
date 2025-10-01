Return-Path: <netdev+bounces-227423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D8DBAEEA8
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 02:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E3017181F
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 00:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CA122FAFD;
	Wed,  1 Oct 2025 00:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NgmDui0Q"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90B22D9F7
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 00:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759280218; cv=none; b=rH9ea6taaMpw2s7TLm8mn1grWLYdI1P//s4GjO+wWhORp2xI60G6Pjk/e+hRH5w3kfyWN/4hgyDPjoGDWG1vKwHrLr1ghqEfgp+CP4hoLIJ007uNf6n+we4kDxn+ykJQ6KhKIhVq8RDN3DR3en8etIHbdL3CuDTRLg/50mUqFtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759280218; c=relaxed/simple;
	bh=VuU+/v6F1J7biSuqsmIXjhJSbde/MKkxtq4Pwx+sCIk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=m4wygxDl5VozMyioAHG9+wPWwnfK+lh/HiT51rXJVSBksFc/urPJ1HUF014X/cNqCJq1A63ytFu8HONyJy77EovWN2NYLBhQeS9QwFVblhjvMQhYDqEZ0S2clnLEhOCyVHNmQd666OS07wNijJsH8KGkss094skDb+MTeXzoJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NgmDui0Q; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759280212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L38rvfI+dkE0b/B0EtVLWmgKWUZ1mrW0nniZ7ZuX6rI=;
	b=NgmDui0Qq47kPvfWe0TvpClYQ5wGitSCwEy+gifvP4okiXS9OR0ZQzdb02+GFP/PYzXYEB
	r/N4PU8YjnkU2dhtGTrNAJZXawNeAb5xmUI5xAA/Vcv36mmcMrwGGStNA1EIYHdZ/ININf
	IswpnCTLuZuugcyil1DcZwVjn6V8Q1E=
Date: Wed, 01 Oct 2025 00:56:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <f7e414eaef1f722ae125cf3601a0567136f973fc@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] usbnet: Fix using smp_processor_id() in preemptible code
 warnings
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: horms@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org
In-Reply-To: <20250930174340.5e554e10@kernel.org>
References: <20250930084636.5835-1-qiang.zhang@linux.dev>
 <20250930103018.74d5f85b@kernel.org>
 <98852ec27b03a4b7a16243e32b616a0189e32165@linux.dev>
 <20250930174340.5e554e10@kernel.org>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Wed, 01 Oct 2025 00:39:18 +0000 Zqiang wrote:
>=20
>=20>=20
>=20> We also call netif_rx() which historically wanted to be in bh conte=
xt.
> >  I think that disabling bh in usbnet_resume_rx() may be a better idea=
.=20
>=20>=20=20
>=20>  Actually, the netif_rx() will disable bh internally when call from
> >  process context.
> >=20
>=20Sigh. I said "historically". Commit under Fixes is very old
> so the fix needs to be backported. Look thru the git history=20
>=20you'll see that netif_rx() did not disable BH when the bad commit=20
>=20was written.
>=20
>=20>=20
>=20> but the skb_defer_rx_timestamp() is usually called in the bh or
> >  interrupt context.
> >=20=20
>=20>  Anyway, I will disable bh in usbnet_resume_rx() and resend.
> >=20
>=20If you think you have better solution, please do not hesitate=20
>=20to propose.

Maybe we can use netif_receive_skb() instead of skb_defer_rx_timestamp()
and netif_rcv() in the usbnet_skb_return() and disbale bh in usbnet_resum=
e_rx().

Any thoughts =EF=BC=9F

Thanks
Zqiang

>=20
>=20Also make sure you read
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> if you haven't already.
>

