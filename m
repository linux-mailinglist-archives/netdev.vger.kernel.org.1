Return-Path: <netdev+bounces-103750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDB3909532
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 03:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632B21F2377B
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 01:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8A01C2E;
	Sat, 15 Jun 2024 01:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2s0B1p7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA110F7;
	Sat, 15 Jun 2024 01:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718414853; cv=none; b=m8st7TQu48i3AWLy8xLqfw48xp69TDEX0jORDbRwLGP2cnQICSMWyVeCmhKPCn1mOHOx2jpiZ7ZFAR5AXoUQiKBc2dmOUNzG+uYEVN0rKzHNd6zebZ3hzuaJ0qqRnpYfvrtnPfW+bWecPS54GHvtEBHtqaHelz7xkGMVwJk2bmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718414853; c=relaxed/simple;
	bh=uO0l8fWM8wy0kjfMSdBXh5QBa3T8WTIIwxytMlnolVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xe1JtFSUIYO7di1Ss26yDMgEGRM5Laqf6YijtI4WZqP2ZAY5B0sYSzeAiTnHN/HcS1GkWKIVtvGpCCUQMmzFhUwxUvXaYvH16TxUyBWOAeM9S1mE0viQrmAIeE2eOoAy+juu6WUn/up3EAUIVCPiecQL8fupr6OnhdnHRFxB0Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2s0B1p7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B56C2BD10;
	Sat, 15 Jun 2024 01:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718414852;
	bh=uO0l8fWM8wy0kjfMSdBXh5QBa3T8WTIIwxytMlnolVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b2s0B1p7PB2aVGlz/qIbq4zDYFcmZfBVDr8OoH5cbCMbXdkyprsvQL3baKEfsUPbA
	 REnK0pGaGHJkKuvfFLULnBdImhIqrNDxF7fpQEe6SeWzyCVTH4w8riYFWakn+HV0wy
	 byoYWfa+fZ00mC+BFn3ywN31UD5h8P1ikdn26tBCA57vSCy/AHo/UhGAFR6boQzyyr
	 nTHxPBuZStTKKmEXG+n6FIGKNJKO+2K2xTkIYRIQ0tkp0nStGglOFf0nNgGe8/aPdb
	 rzzPmBXsac1WNHVdaD0Tb5bcJn+j3k69Exgm6/YLF+7rLDAJa1L8hcPijN4m7BbqUf
	 ueE+btEeiORgA==
Date: Fri, 14 Jun 2024 18:27:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: Frank Li <Frank.Li@freescale.com>, "David S. Miller"
 <davem@davemloft.net>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH resubmit 2] net: fec: Fix FEC_ECR_EN1588 being cleared
 on link-down
Message-ID: <20240614182731.3244deef@kernel.org>
In-Reply-To: <0f315501-e8cb-4904-8c43-d9721fdef846@prolan.hu>
References: <20240611080405.673431-1-csokas.bence@prolan.hu>
	<20240613081233.6ff570cd@kernel.org>
	<0f315501-e8cb-4904-8c43-d9721fdef846@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jun 2024 09:59:16 +0200 Cs=C3=B3k=C3=A1s Bence wrote:
> It only writes 0 if WOL is disabled AND the device has the MULTI_QUEUES=20
> quirk. Otherwise, we either write FEC_ECR_RESET, which resets the device=
=20
> (and the HW changes ECNTRL to its reset value), OR we RMW set the WOL=20
> sleep bits. And then, if some more quirks are set, we set ETHEREN.
>=20
> So I think RMW is the safest route here, instead of trying to keep track=
=20
> of all these different branches, re-read ECNTRL after reset etc.

Okay, just resend without the empty line between tags then.

