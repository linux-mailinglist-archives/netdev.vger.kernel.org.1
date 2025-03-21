Return-Path: <netdev+bounces-176692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071CEA6B5F3
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 09:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430B11775C0
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 08:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCD61A841F;
	Fri, 21 Mar 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgBVyQBn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086054431
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742545061; cv=none; b=t3o6aNHCcDNa+P8j/wc9W+7mH+HKCIgccDV24XmsVojt3fFJ6r81VRPVy5zgfYRH6ttVu47FaWhi+vHJMFX8duHE9RZtZA5GWn2wF4x4V1ZTADynIhK12g20rdaTOEyyknJUiFyCz1C3Q26rpuu1qR7CQReT2k184cvGoXjP49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742545061; c=relaxed/simple;
	bh=U4KD6crzZNmnb5hdY0vgeeeLm5lHPbUGgltcPn4owKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx1jLkRh6S19A554R/AyqI1wNj2vBralwz7JsgucyL2/p8BfSqB8VFUXrNI95BXIPwkOyfNdWYlCKMMus2W8ho4uF4JYMwc48QdK4fCPvAwnG5QicRFA56MQQRJKls5aQNBxVFpWtor7be9YOP4FEbqd6en3g75cy/vuykpJrK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgBVyQBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD67AC4CEE3;
	Fri, 21 Mar 2025 08:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742545060;
	bh=U4KD6crzZNmnb5hdY0vgeeeLm5lHPbUGgltcPn4owKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgBVyQBngWs/GzR1+q2FPccMOcJJGWcOdOcRT61cum0KFU8eO+XXVFCzYPtfEINxj
	 4eDCmYQJnmpGq9yDCr+A0EUzj1KVZH/JzakcgpZpS2bhGUA6g6gS8nlPMDHrxHdFyY
	 ga1/IMUrTNw8LNhM2XCg9oqANPgFDCKbwcNbsE7LoKNPPKShCBBXDqNalLcF2YAMnB
	 q/dJHLLOCSW5LtPivkRirJnTroLXD5hkuaAwAn7Jg8cAYL+rAw3V0KRC6MESmNqIAP
	 WgbwUZKrH/6k67OmKcCRyRHtN6N2q25kxnJWz5GopeST3WzVCTPvhP+HE6wun7w9wG
	 B52PsLONmqqwA==
Date: Fri, 21 Mar 2025 08:17:36 +0000
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net 3/3] net: dsa: sja1105: fix kasan out-of-bounds
 warning in sja1105_table_delete_entry()
Message-ID: <20250321081736.GO892515@horms.kernel.org>
References: <20250318115716.2124395-1-vladimir.oltean@nxp.com>
 <20250318115716.2124395-4-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318115716.2124395-4-vladimir.oltean@nxp.com>

On Tue, Mar 18, 2025 at 01:57:16PM +0200, Vladimir Oltean wrote:
> There are actually 2 problems:
> - deleting the last element doesn't require the memmove of elements
>   [i + 1, end) over it. Actually, element i+1 is out of bounds.
> - The memmove itself should move size - i - 1 elements, because the last
>   element is out of bounds.
> 
> The out-of-bounds element still remains out of bounds after being
> accessed, so the problem is only that we touch it, not that it becomes
> in active use. But I suppose it can lead to issues if the out-of-bounds
> element is part of an unmapped page.
> 
> Fixes: 6666cebc5e30 ("net: dsa: sja1105: Add support for VLAN operations")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


