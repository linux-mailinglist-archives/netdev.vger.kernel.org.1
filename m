Return-Path: <netdev+bounces-197517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7628FAD8FEA
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D97A17AE29
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02501C84CF;
	Fri, 13 Jun 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlowxnT0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996D11A23AD;
	Fri, 13 Jun 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825837; cv=none; b=D2L/CdDJouHNrMUHwiqDSa/CJgeh+ouoOSHO762A2BRYbwZOMd0cgr0lWfWVInJimwXFcD6r8nZGU213DGIWb2idWK2uIftz33DY7YPeGJfpTQtdsYGuzOxhGJPOVAnUPnDgdzvhpW0bfKuEmnoC1/UrSikxSpW4S6hBLImpsIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825837; c=relaxed/simple;
	bh=7gKLG5yJ6N0Gh2lnOGfwYmZeMz2q7/LyOeRBdAByCsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjV4DL2zcgWlIfQVYDtU/mqT7bJOZFntVCB6BNudO9lktYYV+p6VQuBqVuDXfn74l3+rEI95rWnWO2KbyK2Q6yVN8rvoTr8XC5iT7LWMPd8Al5z4qDQMuwFyUoSoLUNmYRTJ740VYwIj+cdg5KIcfmwIXeuDr9i1cJfSxIgSXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlowxnT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CBAC4CEE3;
	Fri, 13 Jun 2025 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749825837;
	bh=7gKLG5yJ6N0Gh2lnOGfwYmZeMz2q7/LyOeRBdAByCsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hlowxnT0Gd8gvS9T2iQZtZZ++871uQLPvv2YY7SwYOlNJsNUqhnQuyd9KhZekSoDR
	 J0qrkT5nfUKmMGcr6G3++LhmL3EjSQD2QFCjQ9yBHLqkJHVrk274eJ9ybzBQCYnfQI
	 hRVZ+ClSO2QU+FGgQg7MwRInMJW5GfG9Jlfbm7IVqkoPZG1c9osXvq/7EPK5u5iDyF
	 YWvQUy43M51wxCm0IsngWVUQS+4x0CdCwrTy3LjrHYRfL2OjziDa4xpbRTCWoMQDu8
	 THZrZD9nLcYonRH3r9y5TYNLOTHD2vTsG/WyzKHjJULYU+UEtU7zblGAYmh0dXULQg
	 CFP9C18MGJkcQ==
Date: Fri, 13 Jun 2025 07:43:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Chris Snook <chris.snook@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] (drivers/ethernet/atheros/atl1) test DMA mapping for
 error code
Message-ID: <20250613074356.210332b1@kernel.org>
In-Reply-To: <20250613095516.116486-1-fourier.thomas@gmail.com>
References: <20250612183234.51a959e9@kernel.org>
	<20250613095516.116486-1-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 11:54:08 +0200 Thomas Fourier wrote:
> According to Shuah Khan[1], all `dma_map()` functions should be tested
> before using the pointer. This patch checks for errors after all `dma_map()`
> calls.

Please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

