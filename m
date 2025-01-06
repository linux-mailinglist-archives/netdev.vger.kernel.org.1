Return-Path: <netdev+bounces-155630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E50A03350
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC871884FDD
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E501E25E5;
	Mon,  6 Jan 2025 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP5K/4tq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5221E2309
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736206234; cv=none; b=grrzESa1d8vRWRDHKadWai2l9paP8xGffrcAMPbuqB5Yntrd/qDxuTSk39k80CjIuJ06D/j8ZnpyJ/epQnXg0ylqE8FMkRMReaeMrqUqEN/0zXMASz+dpcrs/W8aowUBob2xFZnpBtk3QTExCooWuTgwBjjaqlHBLHeH92h4JcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736206234; c=relaxed/simple;
	bh=WjUCY5wtD4Evc63bAEebM8ZKNNWNGb2/gpg1cAsIBY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jN1D45vbTFr6oRRHkwIMMYhcnLVAi5Smccy6BsJldOrcAFXQj06vjfT+h/TSTje4F1cEw79UBNEkk9Ir/bar/HR86eKFMIVDx1WnNNnMjG5KmQn6jWDATbie1k0Xszd4aC6HXnZJex/8L0D9shwS799CWj8bJ0H92b/6/YSc45U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP5K/4tq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B2DC4CED2;
	Mon,  6 Jan 2025 23:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736206233;
	bh=WjUCY5wtD4Evc63bAEebM8ZKNNWNGb2/gpg1cAsIBY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rP5K/4tq7GAfLyMViP/mox3YXtun5qhoAFqq4s18XISrtCxXz4kS3oXMpqG0s1R6z
	 SOfHEpnq8g3MG7peKgG4+1ZHVLFPxYGebOMjCGj0QwUzEEf77/3xn3QT/inaqigfD/
	 x4F7BDSSuqiGMe9kM1PlYR4FOiy3ep7ohUk+AJGDa0ozdaAFoCPnwRzQLuVIr5KJQ4
	 QnpU6JHfkGgEMGVvB+At/d+2pETAtOBrcmx/Fk5WF4c8CN0Wpo9ho+bwoKNWvjEv+p
	 ZO07xUv4LrkpzBalEwXiysUyQBRb2vw0sahpmpqkr9rkKOQ3OZYVUinc7i5p293vtC
	 3XpJXqx8ETFFw==
Date: Mon, 6 Jan 2025 15:30:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, David Miller
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] r8169: add support for reading over-temp
 threshold
Message-ID: <20250106153032.7def28fc@kernel.org>
In-Reply-To: <f3e07026-8219-4b36-b230-7f7ddd71c7ab@gmail.com>
References: <97bc1a93-d5d5-4444-86f2-a0b9cc89b0c8@gmail.com>
	<f3e07026-8219-4b36-b230-7f7ddd71c7ab@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jan 2025 19:05:13 +0100 Heiner Kallweit wrote:
> Add support for reading the over-temp threshold. If the chip temperature
> exceeds this value, the chip will reduce the speed to 1Gbps (by disabling
> 2.5G/5G advertisement and triggering a renegotiation).

If there is a v2 -- please make sure hwmon folks are CCed.
Looks like get_maintainers doesn't flag it, but since we're charting 
a new territory for networking a broader audience may be quite useful.

