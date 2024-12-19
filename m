Return-Path: <netdev+bounces-153161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF7C9F71B6
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C505A168E96
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A8E40BE0;
	Thu, 19 Dec 2024 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRr/MB2w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA61853;
	Thu, 19 Dec 2024 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571403; cv=none; b=tpy4MEYdG83455oGrgBkU+KRcQvEfWdUgZSexhH1z8N5IxQphPV3+GDdYDc4F7SNYU0X3+TvkZA46bC2ldjU5R3B74wW8ndJNqwVE7CMfLl3xKkI+fv6i9qTj56LmklGwvAYLMnv4FvLwaCnIXeVm0QToJY0uAHboTkugC5yRJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571403; c=relaxed/simple;
	bh=dzuFxmPBZPLG/7XxTZKJQwWOuhlikv9IRCeqf77quic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwS+Zktq4is4j2pV+eiA+5lc9muToZn+ifpjr0NCn3+KmboKVjqkg6hga8viFYzG5CbN97TPz3n3dbbVPxidksU0PWk5sPIZE+chZgA0860/GUF/Ac2v89kRJV2sDK+VYV86sk2RY5T1449W3Kl4e6huXD9cnusz9GYLikVpxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRr/MB2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9375BC4CECD;
	Thu, 19 Dec 2024 01:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734571403;
	bh=dzuFxmPBZPLG/7XxTZKJQwWOuhlikv9IRCeqf77quic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fRr/MB2w/38rdvQZyJsXXt0XXLFCvft2hmMQd4+wmyzHLKAc1MwUJQrdnKloTzRvY
	 FdJvKPFbwJPaSroES2rH75CSY1WyufqpDWaT9klFLd1QeL3iEH2CcpukgZvEqnLeJu
	 qHWB7wNK50kRIWWUcSCmYgdmx8Es1/FWp+REHxROv21YKQuYygh2wiIq6isSzI9n2L
	 67m2bIQen2pXrnciMC0Llbmjkhy3udXE1cOVlUpEnCbTX8r1fmHdQUEdaC2tlZgCEM
	 54mZgGdh6dOMIIzDGddNdPyotU9iIaCBFvS45W51vZRZXFyhdZ0+k9DIhv9SPHe8XT
	 ssJwef6Nuxxew==
Date: Wed, 18 Dec 2024 17:23:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Caleb Sander <csander@purestorage.com>
Cc: David Miller <davem@davemloft.net>, Tom Herbert <therbert@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Eli Cohen <elic@nvidia.com>, Ben
 Hutchings <ben@decadent.org.uk>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>
Subject: Re: cpu_rmap maps CPUs to wrong interrupts after reprogramming
 affinities
Message-ID: <20241218172321.71ea4b4a@kernel.org>
In-Reply-To: <CADUfDZpUFmBCJPX+u3GYeyFUbQ3RgqevvCpL=ZE48E4_p_BpPA@mail.gmail.com>
References: <CADUfDZpUFmBCJPX+u3GYeyFUbQ3RgqevvCpL=ZE48E4_p_BpPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 10:18:30 -0800 Caleb Sander wrote:
> I can see a few possible ways to address this:
> - Store the current affinity masks for all the IRQs in struct cpu_rmap
> so the next closest IRQ can be computed when a CPU's closest IRQ is
> invalidated. This would significantly increase the size of struct
> cpu_rmap.

Ahmed is actively working on something along those lines:
https://lore.kernel.org/all/20241218165843.744647-1-ahmed.zaki@intel.com/
hopefully we can leverage it?

