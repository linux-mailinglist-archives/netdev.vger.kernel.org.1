Return-Path: <netdev+bounces-174050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1729A5D2A6
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 23:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305CD178887
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 22:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13829264F9D;
	Tue, 11 Mar 2025 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq8ybwVl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7691E7C2B;
	Tue, 11 Mar 2025 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741732893; cv=none; b=oL2EPqvLvJAFJ+tB0+ud14nspc9k3H9O5dUP0iZbvNKbkHm9fqR2XEjPh50HRajmKCzemn2o04YPt0fITGzalwR1UMilY1yHHQ9XEaYdRQKxw1ig2pAtbjC4XFPSZTb0pVpce77kT9dRzsFm4CG34AWf7sZbEfgu333BiFx1XzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741732893; c=relaxed/simple;
	bh=+coG37l2eGCn++hwp9pjgurrJsYlGaIgrcTm4zrjQq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/KX6f2z8I79+uO8n/CJ0YphfzvSVYiR3iZxskux4EJvcK9AjKcQKdb4wLDR8bXBM92XVGVMdINHFJ07gXdaKTwVPCdrZk8VgkRCjrtbzfqavlW3DzqypshFFDKyHWRduTy7Io7V6QPUGmGerbozn89fmtMzm6Oe3PzaFI0ezPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq8ybwVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91A0C4CEE9;
	Tue, 11 Mar 2025 22:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741732892;
	bh=+coG37l2eGCn++hwp9pjgurrJsYlGaIgrcTm4zrjQq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aq8ybwVla2q0KOz660iw1mOT9EYn0dH46xGvjhQN0XgvJMXkj4L1dZBFcemoaGqGW
	 Vd8qJDDvNqtkjPXSJq4GQnt4LnEayMlnaKq4/N1c5BBbA12It51mC9zV8RXkIKdLLK
	 Iv2QEBYvpADJ/47SfWwToq3xR5kMcIPn0pH+Jhf9gVuQVwQBR38WslOwUlRwH/LfTl
	 HwLKkKKxX/Vft2tic54DhftabJH2Oyyl1JFiO1BoQrAGO5eVxeuua3GYE9QUxHAzcu
	 2VoJGU4pLbcRn+kicCib5IEhj7TrK8WHyQSSenrQGkyJSAj/uEZZlfjQSrPxSKH9ne
	 L8TVGExGlLPLg==
Date: Tue, 11 Mar 2025 15:41:29 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: macb: Truncate TX1519CNT for trailing NUL
Message-ID: <202503111540.8EB9B4702@keescook>
References: <20250310222415.work.815-kees@kernel.org>
 <64b35f60-2ed4-4ab0-8f4e-0dba042b4d4d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64b35f60-2ed4-4ab0-8f4e-0dba042b4d4d@lunn.ch>

On Tue, Mar 11, 2025 at 03:12:00PM +0100, Andrew Lunn wrote:
> On Mon, Mar 10, 2025 at 03:24:16PM -0700, Kees Cook wrote:
> > GCC 15's -Wunterminated-string-initialization saw that this string was
> > being truncated. Adjust the initializer so that the needed final NUL
> > character will be present.
> 
> This is where we get into the ugliness of the ethtool API for strings.
> It is not actually NUL terminated. The code uses memcpy(), see:
> 
> https://elixir.bootlin.com/linux/v6.13.6/source/drivers/net/ethernet/cadence/macb_main.c#L3193
> 
> The kAPI is that userspace provides a big buffer, and the kernel then
> copies these strings into the buffer at 32 byte offsets. There is no
> requirement for a NUL between them since they are all 32 bytes long.

Oh right! Yes, I always forget these are not NUL terminated. Okay, I
will resend this with a proper __nonstring annotation. I see the title
use in drivers/net/ethernet/cadence/macb_main.c and can confirm it's not
using C String APIs.

-- 
Kees Cook

