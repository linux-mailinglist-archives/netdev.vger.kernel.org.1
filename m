Return-Path: <netdev+bounces-136613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEEC9A24F2
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401FF289635
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCE51DE4C5;
	Thu, 17 Oct 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqKSloMK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064401DE3D6
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175139; cv=none; b=GFLNcTs5mdyu4e4z3Ki3MSZp9XWTYPdNzBkxo3tCFM9wI4V1AuM24FZSlWRGfp06JAW6OL1ylNVqlKONITebjoZFt51piWVz3J2mhGuYkxOh6CLvwSKJfi2dwPMxq7XflXvK5IkcQxPbc/MPcXLRnYz2Xm+1GcW70Zu+zruBR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175139; c=relaxed/simple;
	bh=xElwNTcwgTU6ZVWLcduWdFTZHns1fNNdsPlKx1iQ0LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7zXl66vZZzOogKwmoiChpMnYNhYCn0gJxp3sFDMracn2olKfZf3d0jBN/PfJ62R+9ahKvi8BhzbGJrBngFlKNyeUSiDiWcs8/kXAfloDbrIrJW2VI/0HkViouZHmqAEGxzerLbydR0SrLULCNEFwc6NrWqZ9jGCEyR4fyGemgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqKSloMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1C0C4CEC3;
	Thu, 17 Oct 2024 14:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729175138;
	bh=xElwNTcwgTU6ZVWLcduWdFTZHns1fNNdsPlKx1iQ0LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GqKSloMKuDCznntWlXfHu+M1zuNlOn6KbuOj8vSfhEKlY3hsYa+a/EdKeuBeVu0ml
	 rSgVYp59PlSjwsuC+eW65FH+ybcmhDuiWnDnZEeDSZtVuDquM+deOYLfZ2pEk39+U2
	 DMqvMrcQtTwbdMrxPTNV8Q0sv8FkKNqTs+tuf+Jsp000KyZdfcKAmdLyXs3iKYLfAy
	 k6+PQ+5kIlZPeKnKsVAXe9iap6JZ4fByx/cayBjwtw27GNxa3YBe/8nX7VCHMJdaCX
	 Jws11WFyUwCtmPM6vFs+C63pCGbLLzLZOHo5rKoxgkT2SDCXrpuHANt0QrMdyMMS99
	 uQNARasiBpwYQ==
Date: Thu, 17 Oct 2024 15:25:33 +0100
From: Simon Horman <horms@kernel.org>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Andrew Halaney <ahalaney@redhat.com>, Ong@qualcomm.com,
	Boon Leong <boon.leong.ong@intel.com>,
	Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
	Wong Vee Khee <vee.khee.wong@linux.intel.com>,
	Tan Tee Min <tee.min.tan@linux.intel.com>,
	Jon Hunter <jonathanh@nvidia.com>, kernel@quicinc.com
Subject: Re: [PATCH net-next v2] net: stmmac: Programming sequence for VLAN
 packets with split header
Message-ID: <20241017142533.GS1697@kernel.org>
References: <20241016234313.3992214-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016234313.3992214-1-quic_abchauha@quicinc.com>

On Wed, Oct 16, 2024 at 04:43:13PM -0700, Abhishek Chauhan wrote:
> Currently reset state configuration of split header works fine for
> non-tagged packets and we see no corruption in payload of any size
> 
> We need additional programming sequence with reset configuration to
> handle VLAN tagged packets to avoid corruption in payload for packets
> of size greater than 256 bytes.
> 
> Without this change ping application complains about corruption
> in payload when the size of the VLAN packet exceeds 256 bytes.
> 
> With this change tagged and non-tagged packets of any size works fine
> and there is no corruption seen.
> 
> Current configuration which has the issue for VLAN packet
> ----------------------------------------------------------
> 
> Split happens at the position at Layer 3 header
> |MAC-DA|MAC-SA|Vlan Tag|Ether type|IP header|IP data|Rest of the payload|
>                          2 bytes            ^
>                                             |
> 
> With the fix we are making sure that the split happens now at
> Layer 2 which is end of ethernet header and start of IP payload
> 
> Ip traffic split
> -----------------
> 
> Bits which take care of this are SPLM and SPLOFST
> SPLM = Split mode is set to Layer 2
> SPLOFST = These bits indicate the value of offset from the beginning
> of Length/Type field at which header split should take place when the
> appropriate SPLM is selected. Reset value is 2bytes.
> 
> Un-tagged data (without VLAN)
> |MAC-DA|MAC-SA|Ether type|IP header|IP data|Rest of the payload|
>                   2bytes ^
> 			 |
> 
> Tagged data (with VLAN)
> |MAC-DA|MAC-SA|VLAN Tag|Ether type|IP header|IP data|Rest of the payload|
>                           2bytes  ^
> 				  |
> 
> Non-IP traffic split such AV packet
> ------------------------------------
> 
> Bits which take care of this are
> SAVE = Split AV Enable
> SAVO = Split AV Offset, similar to SPLOFST but this is for AVTP
> packets.
> 
> |Preamble|MAC-DA|MAC-SA|VLAN tag|Ether type|IEEE 1722 payload|CRC|
> 				    2bytes ^
> 					   |
> 
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
> Changes since v1
> - took care of comments from Simon on FIELD_PREP
> - explained the details of l2 and l3 split as requested by Andrew
> - Added folks from intel and Nvidia who disabled split header
>   need to check if they faced similar issues and if this fix  
>   can help them too. 
> 
> Changes since v0
> - The reason for posting it on net-next is to enable this new feature.

Reviewed-by: Simon Horman <horms@kernel.org>


