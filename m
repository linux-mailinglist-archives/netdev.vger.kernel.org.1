Return-Path: <netdev+bounces-220536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC5BB46800
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 03:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF5E5C5E4A
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF7317A310;
	Sat,  6 Sep 2025 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnB9AOLE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B74A55;
	Sat,  6 Sep 2025 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757122314; cv=none; b=HiKBV+croxE6IyuqHxE/PxP9vxZDaGuzLbjGHyJNrn776fqjM2Li08UMhjMQvHG/PJvAl1qGsvwpRdRPUfqq5lYXXLjxaBojc610EGB3rMcYAJOnW415F9ecTS2fg+XEAfWF1Kz0yWiCIFAtU7mM1qaPZOAGQ8Ecz+mTXDMX/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757122314; c=relaxed/simple;
	bh=1rInwyzH408KpQIKEUF6ugiv9s7w8IarbTw4P1jhacM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+n2y7s+sN9z8Big3jXvvbxRRRXnbvg07KWOAFj9GOZvxu2GVkgUhbb0+JcpBFpsXtTdIjhLqxHb41Tg5ihpAjlckrMxAIM/+J/2Xn+GAKKHnvpTrxuV7KZ2P2AUEq6ONzBSQ+I3uC5gJCEYLzavf68wEVT5sIu/FwL0Us0KYUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnB9AOLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209B5C4CEF1;
	Sat,  6 Sep 2025 01:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757122313;
	bh=1rInwyzH408KpQIKEUF6ugiv9s7w8IarbTw4P1jhacM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TnB9AOLEOQenk/17CQrezaNbHqyR9yotyIQTjBSufSdIguG/4ULcLZYPtmXVnIZMf
	 q1k2gvd2FVt5XclCU+FWV3mN1YON7dmTQDdJYJyZycMWgOvmPCLRT4ilQZHDPsDtqw
	 B4k6te7eBKac9VJfT7O2LGBOYSoHUnEKyjYPDiu1onIEDMizOfPXdJ6fpjM0cahbGH
	 9Q8zqESV83gGsBXwJ7x35uCe6v7g9JLUAu9GggCLf+3DEAbTe4e+z5yBiJZR4aOzWQ
	 F0GVPAKsvkdgaZga+ATyw7hUTW8e9GK5jmfI3Q4WyRQJZ/gx3Nt1B3fMPyypmd9xwJ
	 331+g/fndaqHA==
Date: Fri, 5 Sep 2025 18:31:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ssantosh@kernel.org, richardcochran@gmail.com, m-malladi@ti.com,
 s.hauer@pengutronix.de, afd@ti.com, michal.swiatkowski@linux.intel.com,
 jacob.e.keller@intel.com, horms@kernel.org, johan@kernel.org,
 alok.a.tiwari@oracle.com, m-karicheri2@ti.com, s-anna@ti.com,
 glaroque@baylibre.com, saikrishnag@marvell.com, kory.maincent@bootlin.com,
 diogo.ivo@siemens.com, javier.carrasco.cruz@gmail.com,
 basharath@couthit.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev,
 bastien.curutchet@bootlin.com, pratheesh@ti.com, prajith@ti.com,
 vigneshr@ti.com, praneeth@ti.com, srk@ti.com, rogerq@ti.com,
 krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v15 0/5] PRU-ICSSM Ethernet Driver
Message-ID: <20250905183151.6a0d832a@kernel.org>
In-Reply-To: <20250904101729.693330-1-parvathi@couthit.com>
References: <20250904101729.693330-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Sep 2025 15:45:37 +0530 Parvathi Pudi wrote:
> The Programmable Real-Time Unit Industrial Communication Sub-system (PRU-ICSS)
> is available on the TI SOCs in two flavors: Gigabit ICSS (ICSSG) and the older
> Megabit ICSS (ICSSM).

Looks like the new code is not covered by the existing MAINTAINERS
entries. Who is expected to be maintaining the new driver?
Please consult:
https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html

