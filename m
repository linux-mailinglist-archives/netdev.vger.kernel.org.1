Return-Path: <netdev+bounces-80859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5060B88157E
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 17:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44E2B23BFB
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C3B54FAD;
	Wed, 20 Mar 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoUKb1BM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55154F92;
	Wed, 20 Mar 2024 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951680; cv=none; b=o4SteFlYDJMzxr99czu+zK8+fqt1NHRPoAAm1aiUeSoF7Q/BpQf1v6T3KMm2XadNPmr0qJQDmZiHzk/XJqkrZwXT4pHFBtCvibqbbHUO3Hw42JSsrHPnevD92T2Qkv+2ihQqtAZzus0Gc37GC5NSU5NkOWo6ZSyb3fdtvFpGVXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951680; c=relaxed/simple;
	bh=Knp+GyIrxjiqzs9RPdIV6EPSjw9Di62CuHFlK7en0Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQhh4LUOR6Jc5LmCJFPYxssV4C2UZFDI8IrFQE9eD6ClxPs6b5pBjTz/Qmis+5ytFiFmLChW0GqR1gER8Y8GRJ5cJlB9yXDuJPvrxj7WPbhVkRVTzWr93uLYbdn4I7XW/T0+UsflDimdhycNiJMDD44KXbRPT3pG2hNyR5VcgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoUKb1BM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14062C433F1;
	Wed, 20 Mar 2024 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710951679;
	bh=Knp+GyIrxjiqzs9RPdIV6EPSjw9Di62CuHFlK7en0Zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SoUKb1BMv1Y/6RqB9NPHqWw3cag7uoAQCxuLrtYBsMxFhQEo9SUBzYhW685e+bgNk
	 0AZ6w1twoo1I9FuwcyAv8rrpudPPXMGwFaIyVDQgfSSMNzf4fj1kH9ehWNAuvFFddG
	 hHReE1PEggMbRoyzIW4V0ecGcfKfFX880RgyxCK61aQZFQt0QYYIBIi3Suj3OgDypr
	 Xb/EarmFUDYC57fuNxmiWlpJV15K0DWT/lWgLJ5ueCnkkp0JKH+74jnyEUHp+WvwI2
	 KGiX771tL5i6OesbpSQ5EdqinoLLu0eVXgJsSdomDrd14W4vyR31kH16zSOfIF8R9g
	 tqKHN5i8horBA==
Date: Wed, 20 Mar 2024 16:21:12 +0000
From: Simon Horman <horms@kernel.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@lunn.ch, dan.carpenter@linaro.org, jacob.e.keller@intel.com,
	robh@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	vigneshr@ti.com, wsa+renesas@sang-engineering.com,
	hkallweit1@gmail.com, arnd@arndb.de, vladimir.oltean@nxp.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, jan.kiszka@siemens.com
Subject: Re: [PATCH net-next v5 00/10] Support ICSSG-based Ethernet on AM65x
 SR1.0 devices
Message-ID: <20240320162112.GW185808@kernel.org>
References: <20240320144234.313672-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320144234.313672-1-diogo.ivo@siemens.com>

On Wed, Mar 20, 2024 at 02:42:22PM +0000, Diogo Ivo wrote:
> Hello,
> 
> This series extends the current ICSSG-based Ethernet driver to support
> AM65x Silicon Revision 1.0 devices.
> 
> Notable differences between the Silicon Revisions are that there is
> no TX core in SR1.0 with this being handled by the firmware, requiring
> extra DMA channels to manage communication with the firmware (with the
> firmware being different as well) and in the packet classifier.
> 
> The motivation behind it is that a significant number of Siemens
> devices containing SR1.0 silicon have been deployed in the field
> and need to be supported and updated to newer kernel versions
> without losing functionality.
> 
> This series is based on TI's 5.10 SDK [1].
> 
> The fourth version of this patch series can be found in [2].
> 
> Detailed descriptions of the changes in this series can be found in
> each commit's message.
> 
> Both of the problems mentioned in v4 have been addressed by disabling
> those functionalities, meaning that this driver currently only supports
> one TX queue and does not support a 100Mbit/s half-duplex connection.
> The removal of these features has been commented in the appropriate 
> locations in the code.
> 
> [1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y
> [2]: https://lore.kernel.org/netdev/20240305114045.388893-1-diogo.ivo@siemens.com/

## Form letter - net-next-closed

(original text from Jakub)

The merge window for v6.9 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after March 25th.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

