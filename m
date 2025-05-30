Return-Path: <netdev+bounces-194411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1441EAC9576
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 20:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478F03A4908
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 18:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E3B23C4F2;
	Fri, 30 May 2025 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrszsRdl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D3320B
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628401; cv=none; b=hDyVms+bdkY8O79XRvhKVg8INXtMvXNOWCRSDXaXsFauoAdywiIbQ45WGw7gso0RugmQ9WXvrYBtFMrfGBYD4oZG4o/e5fyk7dtnOLr2QJVuTmHXRgbetMiwqkvbxmFk2ee+Mwt4jQ0Rykdb4an1W1V99H5e5rnKCwIRt+9YRMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628401; c=relaxed/simple;
	bh=t9lFh+oAmPOl6ZvE6QL+On8ZD++9uCDEr437mOmG80I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPQaEFIK+UjMK+Ucp65JrrvOsbBLjbCitgDYOH/xBLZuQigMvRNHtMrpMCAwazGmB4ZqHRm7Wi1XwRMn1zt05F64Q8PKBAfiM8AkMteaHmLDqR6tdO+jpOzUNqAjjNSaM/KtVGSjCfQd4H9d4RZUEoHgpKnLxZyMZj+LZUXvwrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrszsRdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B016BC4CEE9;
	Fri, 30 May 2025 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748628401;
	bh=t9lFh+oAmPOl6ZvE6QL+On8ZD++9uCDEr437mOmG80I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrszsRdlThRSA3XyFYc1ail8rRNTabDt5j2soWnh75hkIKMZofrTXD1mPXkxFKuUD
	 3bT88hyWWsBT/Hr/RmZM7hT31aJcOdCO+DwwTNqnVWiRWlW86v94dc4UYhafetUEWT
	 rD0Xg/ZiAmmQ00YOcMv+lpMALwfnlFJCUYCHK/py1LCpsrk8F9HAaiLqHBb23c5Xud
	 UBsTBjVPTh9mfuZczJfND/wUCgOPIdB/bKFey8R3G5wVTnTt1f7CSBUMTge90HskM+
	 eKcqhFRu2Mcrshb3L6nW9X0zCB8XnIwyhDGVLHhmXwool8NEhnurcDIq+tOchKd4Qy
	 ZxVzPTHywWWhg==
Date: Fri, 30 May 2025 19:06:37 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: airoha: Fix IPv6 hw acceleration in bridge
 mode
Message-ID: <20250530180637.GR1484967@horms.kernel.org>
References: <20250529-airoha-flowtable-ipv6-fix-v1-0-7c7e53ae0854@kernel.org>
 <20250529-airoha-flowtable-ipv6-fix-v1-2-7c7e53ae0854@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529-airoha-flowtable-ipv6-fix-v1-2-7c7e53ae0854@kernel.org>

On Thu, May 29, 2025 at 05:52:38PM +0200, Lorenzo Bianconi wrote:
> ib2 and airoha_foe_mac_info_common have not the same offsets in
> airoha_foe_bridge and airoha_foe_ipv6 structures. Fix IPv6 hw
> acceleration in bridge mode resolving ib2 and airoha_foe_mac_info_common
> overwrite in airoha_ppe_foe_commit_subflow_entry routine.

I'd lean towards splitting this into two patches. One to address the issue
described above, and one to address the issue described below.

> Moreover, set
> AIROHA_FOE_MAC_SMAC_ID to 0xf in airoha_ppe_foe_commit_subflow_entry()
> to configure the PPE module to keep original source mac address of the
> bridged packets.
> 
> Fixes: cd53f622611f ("net: airoha: Add L2 hw acceleration support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

...

