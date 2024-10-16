Return-Path: <netdev+bounces-135920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E552C99FCAC
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8BE2869B6
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5991531C1;
	Wed, 16 Oct 2024 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMJE2v0v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561571EB27;
	Wed, 16 Oct 2024 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036847; cv=none; b=BDCHsbzl707NfK5+ZelYcz9yD87BrM1q3OA1IMzgQzcCVWQefbOCYIusjOHYyqALG/l9xVJMameBtdl57hNL8heF1YtIiNV/ch2NRd6DrgbzBUl3rakV/HeZmZeh8h3AaDOO01Q8P5QM3jAQ0ebcAk2oxWTQP3TZVB/Sd2z9n0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036847; c=relaxed/simple;
	bh=xy1TpimW2Yr1ElBhc0cXQaLXbElscLeveE22MTVq25U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaPngEBNIPy+aYJIdrUTeUYJAj/a2KAlRP5crRYv7j6WNxOt62B5IfhglyxWwzgsV6gRWI8x5QR1rxn1J513N8suhtwHAG2/y6iDmWBS18hNOLjYhdM+mG2YIvxrg29rBb57AgwAQTdVm4FF4QupFI9oOlCnyBdJ69RsNEqRy/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMJE2v0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77198C4CEC6;
	Wed, 16 Oct 2024 00:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729036846;
	bh=xy1TpimW2Yr1ElBhc0cXQaLXbElscLeveE22MTVq25U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tMJE2v0veU3e2oyzigotKne85sbNXCLiR7roEKjxebrIuB6TH9lFJHHTbnOzbMYeY
	 AaqK9bHPLI6Rw86EYeaRPC8MTxjy6tcehyxgX7F06HeVnTUxsA0uSxTOLT8JwtU3/j
	 PiAo6l4NMgqLw+qHZgxQZb6vC58Db+SYikPps80c/jfq+9Ehv/ZnI0KnZZF71/QDlX
	 VevGw7Rd+nL0p5KiBWOrgKDSenvYHnytR0imYKF4mVD9SP9SI3VHBPf91i9pMXtZ3e
	 oQTNjcXsLre8IfqycnJLscy9JlgZpx2vRtPtcLbs0nNO7LyDQKc7U+MBVrAxnam07H
	 jDv7xprvJINQw==
Date: Tue, 15 Oct 2024 17:00:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Wang Hai <wanghai38@huawei.com>, bcm-kernel-feedback-list@broadcom.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 zhangxiaoxu5@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: systemport: fix potential memory leak in
 bcm_sysport_xmit()
Message-ID: <20241015170045.3613f73d@kernel.org>
In-Reply-To: <d5a7d26c-982b-49cd-8bc9-2f2c535af2e2@broadcom.com>
References: <20241014145115.44977-1-wanghai38@huawei.com>
	<0c21ac6a-fda4-4924-9ad1-db1b549be418@broadcom.com>
	<20241015110154.55c7442f@kernel.org>
	<ed541d60-46dd-4b23-b810-548166b7a826@broadcom.com>
	<20241015125434.7e9dfb04@kernel.org>
	<d5a7d26c-982b-49cd-8bc9-2f2c535af2e2@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 16:55:59 -0700 Florian Fainelli wrote:
> >> Yes that's my reasoning here, now given that we have had packet drops on
> >> transmit that took forever to track down, maybe I better retract that
> >> statement and go with v1.  
> > 
> > Sounds good, we can apply v1. Would you like to ack/review here?
> 
> Yes, now done, thanks!

I'm having bad luck waiting for people today :)
Pushed exactly 6min before you responded..

