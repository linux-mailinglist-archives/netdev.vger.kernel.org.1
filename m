Return-Path: <netdev+bounces-162457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EF0A26F9C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAE71886AE0
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D25520AF97;
	Tue,  4 Feb 2025 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imxOsI0j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275B2036FB;
	Tue,  4 Feb 2025 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666474; cv=none; b=CXzICiekfHSlMKWJgbp3M9SwAbAfI4XMmiSG5O5Zx0OSJFCeGOsAcVFePyzQIcs7nmcRBJhTlhliXWkLe5MQo+HDQIDBn7g26jaYZOq+TEh1Wd1lRr009lOenwuv4lV5nqTTOgqLVb9uleB+4F7uXjcDGP/viKj5MVWqOwQn7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666474; c=relaxed/simple;
	bh=RLy6iT86rLgM2HHshpWz9dck2WLGdq20ROafdpvjNxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lByriLz4UsGlo1Elr9COv2kzDiG52gas/yPA7BjcZUytqfXCOnwk8tI3JF22l7A/jNmJ50oRU7yoqQYMDYHtn66fh/x+9l/4ASohv9MG2Hw02x7yUCgxeUnW3LynDSLFN8NW60N7gnNfa+bZzD+8i6dO37Qd2jJlFXJtv3htXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imxOsI0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F11C4CEE2;
	Tue,  4 Feb 2025 10:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738666474;
	bh=RLy6iT86rLgM2HHshpWz9dck2WLGdq20ROafdpvjNxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imxOsI0jZ71fu5RPYLS1M1/a/BSTzG5nCUwuNZvi4UyDIoCayGYyxHil8oUqJ0FPh
	 nHYpFQghdBGf6UDDYXGWORxtJ6F3M1JwfhIuUfUN3XPmkeBYR2EKc1VyFXGBtE9xLc
	 76KklyaZ31bwvbvLtWMO6bFzK4XIYm1wKlD6Ju/h2P/hCRNESTk+tqeV6XOVeyrIyR
	 8yKbIdRHi2fdKDcTIzdugIMGEzOb/bdUQN91VFxvI+kuwRmA/ksp8JtBbK5Lbrb83E
	 x+z+W4ZXBWN9TdoWjJE9MhZijIVqwaHg2qJekloaYThjLV29GjpNIeeMjOMISw11n4
	 nazuBhyJXaWmA==
Date: Tue, 4 Feb 2025 10:54:29 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Moroni <mail@jakemoroni.com>
Cc: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pavel Belous <Pavel.Belous@aquantia.com>,
	Alexander Loktionov <Alexander.Loktionov@aquantia.com>,
	Dmitrii Tarakanov <Dmitrii.Tarakanov@aquantia.com>,
	David VomLehn <vomlehn@texas.net>,
	Dmitry Bezrukov <Dmitry.Bezrukov@aquantia.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: atlantic: fix warning during hot unplug
Message-ID: <20250204105429.GP234677@kernel.org>
References: <20250203100236.GB234677@kernel.org>
 <20250203143604.24930-3-mail@jakemoroni.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203143604.24930-3-mail@jakemoroni.com>

On Mon, Feb 03, 2025 at 09:36:05AM -0500, Jacob Moroni wrote:
> Firmware deinitialization performs MMIO accesses which are not
> necessary if the device has already been removed. In some cases,
> these accesses happen via readx_poll_timeout_atomic which ends up
> timing out, resulting in a warning at hw_atl2_utils_fw.c:112:
> 
> [  104.595913] Call Trace:
> [  104.595915]  <TASK>
> [  104.595918]  ? show_regs+0x6c/0x80
> [  104.595923]  ? __warn+0x8d/0x150
> [  104.595925]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
> [  104.595934]  ? report_bug+0x182/0x1b0
> [  104.595938]  ? handle_bug+0x6e/0xb0
> [  104.595940]  ? exc_invalid_op+0x18/0x80
> [  104.595942]  ? asm_exc_invalid_op+0x1b/0x20
> [  104.595944]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
> [  104.595952]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
> [  104.595959]  aq_nic_deinit.part.0+0xbd/0xf0 [atlantic]
> [  104.595964]  aq_nic_deinit+0x17/0x30 [atlantic]
> [  104.595970]  aq_ndev_close+0x2b/0x40 [atlantic]
> [  104.595975]  __dev_close_many+0xad/0x160
> [  104.595978]  dev_close_many+0x99/0x170
> [  104.595979]  unregister_netdevice_many_notify+0x18b/0xb20
> [  104.595981]  ? __call_rcu_common+0xcd/0x700
> [  104.595984]  unregister_netdevice_queue+0xc6/0x110
> [  104.595986]  unregister_netdev+0x1c/0x30
> [  104.595988]  aq_pci_remove+0xb1/0xc0 [atlantic]
> 
> Fix this by skipping firmware deinitialization altogether if the
> PCI device is no longer present.
> 
> Tested with an AQC113 attached via Thunderbolt by performing
> repeated unplug cycles while traffic was running via iperf.
> 
> Fixes: 97bde5c4f909 ("net: ethernet: aquantia: Support for NIC-specific code")
> Signed-off-by: Jacob Moroni <mail@jakemoroni.com>
> Reviewed-by: Igor Russkikh <irusskikh@marvell.com>

Thanks for addressing my review of v1.

Reviewed-by: Simon Horman <horms@kernel.org>


