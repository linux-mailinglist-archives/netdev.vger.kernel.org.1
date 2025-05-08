Return-Path: <netdev+bounces-188987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D2AAAFC1D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47DA1C01A35
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51579229B2C;
	Thu,  8 May 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtP1zYNr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C675A79B;
	Thu,  8 May 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746712461; cv=none; b=SWWqqTH3ouzOJnl+Fy95gZ5y65iBi18LwixwYRSpY/8Fv2VCz0oDLvo/dkeHJBI4kg9kv+MTk7Bu7kA+qwgIRFLed6C6uZ3pyf2BWE2NcikFc8dsC4AZqNw0Kvdjv8B3deWplYJUUbYquw7d7mfjkydNq6/KftJ3h+gvz8SXx84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746712461; c=relaxed/simple;
	bh=1kERyB/X3LORcekAOcOV5bGJKtJ9lGUEkzmpO2kYh0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3Hk7M5+IquazW3E/C+zr8EKUjhzEQSQME66tDFq2lSv3AukaCV1b1UOvXf050FeWjgmlGq1VDEYMH3M5bFk6d1RHKdJLLRXJLklGjHsL1wuKTgRD3M1SAwxgRA+z1HQs9Rz/5TKbJAIluXxzChYmmhKJM8vc6/TKWz6yRIe6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtP1zYNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B810C4CEE7;
	Thu,  8 May 2025 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746712461;
	bh=1kERyB/X3LORcekAOcOV5bGJKtJ9lGUEkzmpO2kYh0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PtP1zYNr1TWaHC4IiKJdvGu60kmFmqoGZORJ99VB1YsvdQXzHS7kPCejkr0c6xpJN
	 z2XKttR0Xm328o5uDpOfNnjPCnSXLdXP78YlukzlwX7eAb7eK7PPc3FYFGX9ZZ3Ei6
	 QdsKPXzHYwfnVTHZNQLSCzRbrbaS6GIK+crQvVgmuzd6k19KNkmTjWujfr00y18lcg
	 MBKIcyQlNeBmGmOxm0KI5Kcxw2qVBRYtGVLkLNGVTT+RUwp+m5WcEwVBA3cjRnA/6B
	 bveOYM6OOe74LHWrNDRW4VxEHhl4WZ06ZQRalye4Rnyl/lkjej8XgTH+uiLZP/WmEr
	 oV4An6O0/GIEQ==
Date: Thu, 8 May 2025 06:54:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <Thangaraj.S@microchip.com>
Cc: <Bryan.Whitehead@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <andrew@lunn.ch>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
 <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v1 net-next] net: lan743x: configure interrupt
 moderation timers based on speed
Message-ID: <20250508065419.2a089eba@kernel.org>
In-Reply-To: <32159cd4a320a492fd47b6c38cebdb9a994c8bf5.camel@microchip.com>
References: <20250505072943.123943-1-thangaraj.s@microchip.com>
	<e2d7079b-f2d3-443d-a0e5-cb4f7a85b1e6@lunn.ch>
	<42768d74fc73cd3409f9cdd5c5c872747c2d7216.camel@microchip.com>
	<e489b483-26bb-4e63-aa6d-39315818b455@lunn.ch>
	<20250506175441.695f97fd@kernel.org>
	<32159cd4a320a492fd47b6c38cebdb9a994c8bf5.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 May 2025 03:36:17 +0000 Thangaraj.S@microchip.com wrote:
> I agree with your comments and will implement the ethtool option to
> provide flexibility, while keeping the default behavior as defined in
> this patch based on speed.

Why the speed based defaults? Do other vendors do that?
330usec is a very high latency, and if the link is running 
at 10M we probably don't need IRQ moderation at all?

For Tx deferring the completion based on link speed makes sense.
We want an IRQ for a fixed amount of data, doesn't matter how 
fast its going out. But for Rx the more aggressive the moderation 
the higher the latency. In my experience the Rx moderation should
not depend on link speed.

reminder: please avoid top posting

