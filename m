Return-Path: <netdev+bounces-172827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4522CA56404
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60FBF1780C1
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 09:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57D9209F5C;
	Fri,  7 Mar 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="lwfzFAp+"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE4204C0E
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339971; cv=none; b=EDCgvKQfmVQd3ZNc9kYdjOWmzh7n5hAFvBnkMVSd0hJ7YMpAjUlo2UkDkHOgbqsLKlbvLja/BWgvDKgLMTUSuGhy22j6z6Fq/UntK9jG4AcWVlaP3jTEElZRr0tuYrJ6Euu2y82pv/w0nDewmPbQidnF8DLPRweHEujgUE7i2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339971; c=relaxed/simple;
	bh=kUGNhKndVnG4lvy0lWi69O4G6X3wRJgHqMdT0byLlYc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hZn34iws/qgvBdwrgYumMltiHMw4k2kYYrjS+GlJe9eF98R/4DZMiMg8+DwVe48bPemClJCTOXIsNAmWKOBjHYQNh4E6wBbRnCgA/yiOJR3NPcPJcrBspFUJ5/aMi83KZyzeFaFOswuh/GNe+TL1F9iO8qf0LKXOMin8gvfIcdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=lwfzFAp+; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tqU4T-00335K-8T; Fri, 07 Mar 2025 10:32:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=I6WduNgDa6X5BJ/G54SlQLFV0rIsjm0NYn74kwGYfC4=; b=lwfzFAp++zSl/XVJsfmLsgAb7b
	rMO4Kh38ac0I6Ab0OhU0JPnLpcW5I1oNrMnwGwPXWAQw8Rvf5b1QCyodGeykF6W9WVremiubCW9Qk
	8j5ZhQOM2oA3tl3LFuSUAvQ+5x2ybKTtu54pNSGxXoXmmlXG4BmQlFjVcuJiUNbRBYeNH3Azylo8i
	oXMZvtllBUWdbosyzX2XzQGWFNYV7vFm8YkZCMTZk9cNO0p1oWpMxZymLEFS68ZIUzdJ2OYVzZ4pO
	bch9zFw7um2YBOFSiR83u8fciR7qKwN4dV/WqYENXZMZ1EhAZJtlOqqgyNNN1qcTvyLKq+SV19wek
	ihOJwMHQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tqU4S-0002Qc-Ls; Fri, 07 Mar 2025 10:32:44 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tqU4C-0064FB-VN; Fri, 07 Mar 2025 10:32:29 +0100
Message-ID: <7e3ccc22-0028-4cb6-829f-67d93cb5c14e@rbox.co>
Date: Fri, 7 Mar 2025 10:32:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next 2/2] vsock/test: Add test for null ptr deref when
 transport changes
To: Luigi Leonardi <leonardi@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
 <20250306-test_vsock-v1-2-0320b5accf92@redhat.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250306-test_vsock-v1-2-0320b5accf92@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 17:09, Luigi Leonardi wrote:
> Add a new test to ensure that when the transport changes a null pointer
> dereference does not occur[1].
> 
> Note that this test does not fail, but it may hang on the client side if
> it triggers a kernel oops.
> 
> This works by creating a socket, trying to connect to a server, and then
> executing a second connect operation on the same socket but to a
> different CID (0). This triggers a transport change. If the connect
> operation is interrupted by a signal, this could cause a null-ptr-deref.
> 
> Since this bug is non-deterministic, we need to try several times. It
> is safe to assume that the bug will show up within the timeout period.
> 
> If there is a G2H transport loaded in the system, the bug is not
> triggered and this test will always pass.
> 
> [1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
> 
> Suggested-by: Michal Luczaj <mhal@rbox.co>
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---

I think the credit should be given to Hyunwoo Kim, not me.

Thanks though,
Michal

