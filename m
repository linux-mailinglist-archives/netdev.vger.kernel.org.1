Return-Path: <netdev+bounces-200757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E2AE6C85
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF604A294B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1D02E2EE4;
	Tue, 24 Jun 2025 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0Uv02fy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C74299AA1;
	Tue, 24 Jun 2025 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750782962; cv=none; b=bsVUbutjtYXqk1+5Zqkzhe53kJBfwHcMuhMhUEtswISaKly8eSl2xhwB+h9FFtyxvvawks66CgmKdyR0sQGSmHyX5Oktq3Vs3V7PfW2Hk7VqWJDETrx7GUmYqIWccMUWWzv5v5eaZaTzYm2MfEWLHrS3yhvTKEw0EhqiBN1jeqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750782962; c=relaxed/simple;
	bh=EHe1rJUWykMibMGwarXmYaMOVnTzyLv2jpQ3HiolEJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnuGaxfoD0sFLYToujW1q7lxlq8izJJqb9yKwHR4QoditMXdYyRWKwB1gAJjBlADm07F31wNFqvVFOiNBW2/4XyL/mM47PWdM9c+z+vEW2MnISJK12JSZ+Uj+8c9Xzcg0/zyqeuIgYGg8xFjrqLD8k/A3jgItl2KX98mLfauFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0Uv02fy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D12FC4CEE3;
	Tue, 24 Jun 2025 16:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750782961;
	bh=EHe1rJUWykMibMGwarXmYaMOVnTzyLv2jpQ3HiolEJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J0Uv02fyP/wEMC3CoMHj5gwWvUaIFW2xHAbuBJf8uM7VqwGMtzGBG1kTRO4SUL7/2
	 9dIO1naaV0HmHOShH+ya5EANzPLYtcds+KEIFH3eVjx3+IGcOPxjSx6ZFYBcDUd1UN
	 GTZAQ8slysltiexlYzAghBb31+zt7SIORjXJ1Vq1pJC6T8PXk3xZuXVj7UCZLxfwWo
	 Uub4kMma0FWAlrLG6FJBnJhVdCJZcKmQ+6uHt58e8V/jDmMCOAWX6s5VOO5QOjG/OP
	 7ytsoQHeDBgYXoQjaP+GlCfHwLutDNVR2u1KulD+2L1puSriLUA5sSCYmykWh4xilY
	 RQ8WnQTbwpG9w==
Date: Tue, 24 Jun 2025 09:36:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [patch 13/13] ptp: Convert ptp_open/read() to __free()
Message-ID: <20250624093600.17c655a8@kernel.org>
In-Reply-To: <20250620131944.533741574@linutronix.de>
References: <20250620130144.351492917@linutronix.de>
	<20250620131944.533741574@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 15:24:50 +0200 (CEST) Thomas Gleixner wrote:
> Get rid of the kfree() and goto maze and just return error codes directly.

Maybe just skip this patch?  FWIW we prefer not to use __free()
within networking code.  But this is as much time as networking
so up to you.

  Using device-managed and cleanup.h constructs
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   [...]

  Low level cleanup constructs (such as ``__free()``) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  ``__free()`` within networking core and drivers is discouraged.
  Similar guidance applies to declaring variables mid-function.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

