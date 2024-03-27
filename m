Return-Path: <netdev+bounces-82663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB0F88EFE8
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 21:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A877D1F2C9BE
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 20:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC721514EA;
	Wed, 27 Mar 2024 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwOwplyH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C637A14F112
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711570077; cv=none; b=i5p83cRu/DhHD27X+623H95qtVA33mBvKc/f+gdJFrzrPCU0yBka+QsgBwR1H3UvauDQYYIIbJjUsIKWV0awF+a2WkmLTXk1qMscWzZan2tcs4UvGbdXSPZucFa1y3XwYdkLxJiMxMFj8x23g7/qh4JNxHT/kRB0TKDdgDWKwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711570077; c=relaxed/simple;
	bh=NIPUK2Z23lnRBX90YzsoMRiPV3B8hTNLsPlzhQp0x6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLWtgzEIxhcTDDvKafr6Gv0X+UJLmCiNTsTzRGpWE9+2Th8mu9SfAno3A8quZjeamKJqvhPOgQsNuuF3LME0X332lqUXcFRq4vbU8H9s6T1uNK/WEfhGzOVcBF1x4h8qTUQmDwFF2GBmiP4YhK4eIaCVH6IjjCFC/KdNRXyCQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwOwplyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B441C433C7;
	Wed, 27 Mar 2024 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711570077;
	bh=NIPUK2Z23lnRBX90YzsoMRiPV3B8hTNLsPlzhQp0x6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HwOwplyH5Bmkb2vnqQlWWb+Db/ysWOAdtVFjwVKyz+JBR7Ri0lTSXipoEDQVNSSbQ
	 gKMsC2Q4pzbaiAdWASkGr7SAVbuG9wzrXOFW6AISja3La7BanP7zcfQnTDxxh0MfKm
	 lw48dvI6U/eQpxW+WZ520Tm1UtoZjiHxXd5Kg4phbMDwcu4Nlia1SXmPYJ9KPpMIlC
	 Aw89Ra3QiJdyJ6XaObsOAQrEGGCvbiRHt/xsKrWmC5RxLxbL9DQ00IYVg6B6vd2B7f
	 vFsGn5qYJ2UgJC+5fEIz1AO+3YpjYGwHhCKO8Ki9zLtXQjy28W/m+DlAf5Ljh4QlhB
	 rItnhXKi5kZtQ==
Date: Wed, 27 Mar 2024 13:07:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] using guard/__free in networking
Message-ID: <20240327130756.00c3c705@kernel.org>
In-Reply-To: <427aef33f1698c8f5b27011d0a829ec4d53b5f5c.camel@sipsolutions.net>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
	<20240325190957.02d74258@kernel.org>
	<8eeae19a0535bfe72f87ee8c74a15dd2e753c765.camel@sipsolutions.net>
	<20240326073722.637e8504@kernel.org>
	<0dc633a36a658b96f9ec98165e7db61a176c79e0.camel@sipsolutions.net>
	<20240326171549.038591c8@kernel.org>
	<427aef33f1698c8f5b27011d0a829ec4d53b5f5c.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 20:24:17 +0100 Johannes Berg wrote:
> > IIUC Willem and Stan like the construct too, so I'm fine with patches 
> > 1 and 2. But let's not convert the exiting code just yet (leave out 3)?  
> 
> Sure, fair. It was mostly an illustration. Do you want a resend then?

Yes, please!

