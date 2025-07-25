Return-Path: <netdev+bounces-210067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0595EB120A8
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239481C819DB
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4BB2EE283;
	Fri, 25 Jul 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb8jFiay"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA31E766F;
	Fri, 25 Jul 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456246; cv=none; b=lpV2ybnxk33uLTdqpGbyxCN8uSAao4gtTqjVD6lliowSomu6kxPjC6elKx6LKDeYWnTT5MoYGas5gASz3h54nDpNt8f5E6+/DiskipA40o4dk/39LlxLqju1jsVfh0MeWJOg2x152YLICf9Bd7aPEGO6RjyAX4iIgNn2cCbNCe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456246; c=relaxed/simple;
	bh=ihW5yS8KFZKrwO0tJX/UuD4EkoLbr7i1SBwQd+lMnXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQujzyqgvDhLN4iEJR7oUyNf6dwCS3ZarO2eB6PS8YSpedBhLMl4oHAP+WV8SQ6r/2ms7bgcTceGqDBB6DiMoqJVs/fIq+gr8q2xuvBKrM7Bt9y07Y80zGVyoX5vmPYIeHFfujESA0kxMdYPxQOmE+dqX9qOM/6zyc+WzR+scaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb8jFiay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24400C4CEE7;
	Fri, 25 Jul 2025 15:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753456246;
	bh=ihW5yS8KFZKrwO0tJX/UuD4EkoLbr7i1SBwQd+lMnXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cb8jFiayvxhreIH/8+a+QoQbA/x58ZHzXBAAizmQByRgcdrrEF574jeVcuDsiqC8n
	 KxP0Zr1Jy6ewFMYP7MYNO52Z7Tkl3Fce0K0ZBu8wG2DYnnF6h3InH/TAyjagt22XPH
	 O2myFrduHE1afqWrBdCJZZIRkMiClL3kY2x2tkR6qOHqsZq62C4liYoWuQI0FxU/FV
	 Vgz5vUUWW0zzzwpf4+PExo2Yd/3f3RDnAehjrtsgpJNss9YFD9fmfZ6CoSNum5xnEs
	 +4Pcu5nFkr7daEznYE4AeF/TEDL9AG5nwiV9Mj7bmBbAak2KhKFaFWsX7rQPPmIc+I
	 4IhvRQYbrOd3g==
Date: Fri, 25 Jul 2025 08:10:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Moritz
 Fischer <mdf@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: nixge: Add missing check after DMA
 map
Message-ID: <20250725081045.34ac4130@kernel.org>
In-Reply-To: <CANn89iJW+4xLsTGU6LU4Y=amciL5Kni=wS1uTKy-wC8pCwNDGQ@mail.gmail.com>
References: <20250725133311.143814-2-fourier.thomas@gmail.com>
	<CANn89iJW+4xLsTGU6LU4Y=amciL5Kni=wS1uTKy-wC8pCwNDGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 06:53:16 -0700 Eric Dumazet wrote:
> Not sure if this driver is actively used...

Like most of the drivers that are missing dma_mappnig_error() :(

Thomas, would it be possible for you to sort the drivers you have
reports for in the reverse chronological order (when they were added
or last time they had significant work done on them)? Start from
the most recent ones?

