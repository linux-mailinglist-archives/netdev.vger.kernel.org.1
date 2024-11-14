Return-Path: <netdev+bounces-144666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F3B9C813A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF33281303
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69061E6325;
	Thu, 14 Nov 2024 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdPPHbVl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14881E3DE8
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553180; cv=none; b=uJBEBe+5djar0OscGmYX1s0CD3RxrCtMvDnCOCpp71KilG+I2ZNwcDe0pg18DD3yCIF1nwPOy00nu/q22kXUXY1sMNnVQPLFnVPnbkhr2Gc6mVyu6q6ZBddXBrnwNfaHUs+xwdHZPQuX/QbEz0xur1Y+6vr6VwrV90XPHbXkxj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553180; c=relaxed/simple;
	bh=rQEdkp6Qf+VvHm77HUyGSYjTrdcy/Wer3otdYMx9Bfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOCq/Hh9J03Sszc20IAQ53vJqVLAmNX84xmTgw7UKzxmvpNOBL0rEEY8hNpp+3xy9qbFY45GwYttep6KRHfW669qiiDU3UGp1oMxizEiwj22TE1OoCXPkXxiH2aUQ9AK+5k13s1hhK1gNQqXhFQs2A9W2kiPgnHJ5IP+nGrRjVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdPPHbVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67FEC4CEC3;
	Thu, 14 Nov 2024 02:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731553180;
	bh=rQEdkp6Qf+VvHm77HUyGSYjTrdcy/Wer3otdYMx9Bfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IdPPHbVlGqImdoKWBfwAFGf/RH/xWLnv9KHxfJlQ6t0Crc7MVYzLbc1kjHBLoL3vl
	 x1A/QfY470OFVXZqT658KuRzYbn6GAyaxLGJ6za7DyEk/jEG6Hj76GGS8njHv+fICJ
	 4Di+lo9S1MCDZPs1PxGu1BD9DvGFjCnCdgWK3w/65fQvAknTP/EMpz1ira42HnAzU9
	 hIf5FaCui62jMLFJJTL7xOTF90FFheE3W3wMI/fLB8Cv6ynsfFPRzTRsWLCeWt00DG
	 RBKaXLmzjEqycrRf9IvM8abkcGBiVOCQ0LfXhBiTNboE/GsP8dXBV3gPemCRoH7OZs
	 B4ZgDKGvrcqGw==
Date: Wed, 13 Nov 2024 18:59:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Vadim Fedorenko <vadfed@meta.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] bnxt_en: optimize gettimex64
Message-ID: <20241113185938.21fa56cb@kernel.org>
In-Reply-To: <CACKFLi=eTekiVDLzaJ4dYJ5EG-wRS7-sJdYF=aDCW2jONVCXCw@mail.gmail.com>
References: <20241112110522.141924-1-vadfed@meta.com>
	<CACKFLi=eTekiVDLzaJ4dYJ5EG-wRS7-sJdYF=aDCW2jONVCXCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 10:05:50 -0800 Michael Chan wrote:
> I think this logic here to get the upper bits and
> check for overflow is identical to the RX timestamp logic.  It may be
> worthwhile to have a common helper function to do this.

+1
-- 
pw-bot: cr

