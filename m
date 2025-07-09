Return-Path: <netdev+bounces-205560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56471AFF427
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D9D1C25834
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 21:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1209823534D;
	Wed,  9 Jul 2025 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtaSl1Mb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B441C71
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098100; cv=none; b=D0tdR6PtP9id3sIs1xj01i7+kK+9Hpd4zf+sYDanuFeYKkK2pLeOAGNx4jx8dbKR0eQr0bsRDMlwYOTe3lIPmn31CmivhW1YiTciOJLqpXIctzZKTR/2YjXNHVkrWsw+P6B+dL42FFd5ermRASZAuHbkLZuks+/pFDKl970sfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098100; c=relaxed/simple;
	bh=g01q5/t8IhirkE+0g8SGisklHTTSUQOrqly6IH5zqUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1Vvmv5pk+syzIrswWzQ14iDK1H83oKMWEI6RPAaVAG8BljFw7cEEMnzmfUB8nqzDu6jjo1ZCNqAfWr/F/eeFOJ3E15NHw3aykOlNVCs2/avOKq3V01vPrlzlWZzm0mVdoWvE20fwhIAHk9Ab8NRVVJqKOQ13vk6EfFJYW1lAMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtaSl1Mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F0AC4CEEF;
	Wed,  9 Jul 2025 21:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752098099;
	bh=g01q5/t8IhirkE+0g8SGisklHTTSUQOrqly6IH5zqUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VtaSl1MbblIZINxFfjt7Ms196N2Dxu14S6tIdqX/wnAlv2hE3CHp2UhRP0KOvBokX
	 6mfracfzsIQTprrP2f73ISCubmrZ7SnxRZEDFVPieW6DyMFKjKBZuaDijyR2TMgluT
	 K0LClvKNZDgIUsLXks1ok7+I3Go4C4IKVXE7iJDoTm7Uw0hgAgYq6Gi8R5pkodjpkw
	 8tT4omUPVfR/MdSBTpGuJGtuiTOtc7i8lGwUx1/AdpRN9HfoWFkFa/Rm7LoZO6AKlF
	 YunoirM0R+feHYMsvOKCldyjuYx9ueRX9h/GJOGmlZS6wV6bX8ZtJRbRlCmx96nXfN
	 BDq9yZriQNZUw==
Date: Wed, 9 Jul 2025 14:54:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
 security@kernel.org
Subject: Re: [PATCH v2] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <20250709145458.1440382c@kernel.org>
In-Reply-To: <aG7iCRECnB3VdT_2@xps>
References: <aGwMBj5BBRuITOlA@pop-os.localdomain>
	<20250709180622.757423-1-xmei5@asu.edu>
	<20250709131920.7ce33c83@kernel.org>
	<aG7iCRECnB3VdT_2@xps>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 14:41:29 -0700 Xiang Mei wrote:
> On Wed, Jul 09, 2025 at 01:19:20PM -0700, Jakub Kicinski wrote:
> > On Wed,  9 Jul 2025 11:06:22 -0700 Xiang Mei wrote:  
> > > Reported-by: Xiang Mei <xmei5@asu.edu>
> > > Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> > > Signed-off-by: Xiang Mei <xmei5@asu.edu>  
> > 
> > Reported-by is for cases where the bug is reported by someone else than  
> 
> This bug's fixing is a little special since I am both the person who reported 
> it and the patch author. I may need a "Reported-by" tag mentioning me since I 
> exploited this bug in Google's bug bounty program (kerneCTF) and they will 
> verify the Reported-by tag to make sure I am the person found the bug.

I'd be surprised if Google folks didn't understand kernel tags.
Please drop the tag and if you have any trouble you can refer
them to this thread (or ping me).

