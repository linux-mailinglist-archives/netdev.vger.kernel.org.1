Return-Path: <netdev+bounces-170067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC51A471EE
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7141645C5
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 02:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FED433C8;
	Thu, 27 Feb 2025 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWTqrt72"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B94683
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622051; cv=none; b=B9on23svRlaSJrhvacJBQJ5GbmdOPRdgrtWx15mneChVR+6ClNCsvXCTDR+zpUsbwMINjNfs1dYgR0/rw9dfRyrI3dEvvhAorx4CRSX3KolanEcSkPxQWN7SigoHHPmQ/5BBjICg1WCyFW+SxEYJ5dSMkpzDhiI7GMuLIRiO3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622051; c=relaxed/simple;
	bh=eyoKuMdnJOs4NEtfu+JfvbCG4h4Yl4W0IC6UMqkQhWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFR7AZ3AD6qswJnnpbxeZKLpALLYVDLGp4uJmxjdZ+cjaKlOMTcSQXkSRua70JwvyaQVFeKhOEK5zmTkf/8ULZOzfLlMhFl8aB6h6F0Q5PKXUZF6pz3ckOVaXe5z/LB9PnPFSwEM25deYlznWAi29O7HZLDXWIuJ/nLSg9W7fTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWTqrt72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8489CC4CED6;
	Thu, 27 Feb 2025 02:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740622050;
	bh=eyoKuMdnJOs4NEtfu+JfvbCG4h4Yl4W0IC6UMqkQhWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OWTqrt72SUUW+fYsHqAxn/genDKlL0/ZSTQ3rbvkXRplcB9hjZtsacYDq9KFqQxkq
	 aKD82USw04wyOIaq2w6TypIEM0bC76tUkNn0Z/t61y9q2OdLD7+e10YeO2ztjTaz8x
	 jNi9gK68VJaJPb27cGmq29p2NCAOFzgY4doHvdaz3NVd/ilkvtL3Oyj2BlMpH7wWUy
	 zu6pfcfPyVsCdKG5KA5PXvF/SSoG+fKO5mwg7p3oxXj6Es0gM3mnvD5Aru7+Y+oR6w
	 ylso9WH1UiiVrbVVLQUd6KeQq5MwW9hCyKGMbgGVHPPeflEWeoxKxBRvYyT5MIkXoV
	 hIMbGQ+V6gQOw==
Date: Wed, 26 Feb 2025 18:07:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, gospo@broadcom.com,
 somnath.kotur@broadcom.com, dw@davidwei.uk, horms@kernel.org
Subject: Re: [PATCH net 1/3] eth: bnxt: fix truesize for mb-xdp-pass case
Message-ID: <20250226180729.332e9940@kernel.org>
In-Reply-To: <20250226061837.1435731-2-ap420073@gmail.com>
References: <20250226061837.1435731-1-ap420073@gmail.com>
	<20250226061837.1435731-2-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 06:18:35 +0000 Taehee Yoo wrote:
> When mb-xdp is set and return is XDP_PASS, packet is converted from
> xdp_buff to sk_buff with xdp_update_skb_shared_info() in
> bnxt_xdp_build_skb().
> bnxt_xdp_build_skb() passes incorrect truesize argument to
> xdp_update_skb_shared_info().
> truesize is calculated as BNXT_RX_PAGE_SIZE * sinfo->nr_frags but
> sinfo->nr_frags should not be used because sinfo->nr_frags is not yet
> updated.

"not yet updated" sounds misleading the problem is that calling
build_skb() wipes the shared info back to 0, but it was initialized.

> so it should use num_frags instead.

num_frags may be stale, tho. The program can trim the skb effectively
discarding the fragments. Maybe we should fix that also..

Could you follow up and switch to xdp_build_skb_from_buff() in net-next?
It does all the right things already.

> How to reproduce:
> <Node A>
> ip link set $interface1 xdp obj xdp_pass.o
> ip link set $interface1 mtu 9000 up
> ip a a 10.0.0.1/24 dev $interface1
> <Node B>
> ip link set $interfac2 mtu 9000 up
> ip a a 10.0.0.2/24 dev $interface2
> ping 10.0.0.1 -s 65000

Would you be willing to turn this into a selftest?
The xdp program I added for HDS recently is a PASS so we can reuse it.
29b036be1b0bfcf
-- 
pw-bot: cr

