Return-Path: <netdev+bounces-111486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC90931579
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD9CB21ADE
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9221318C34F;
	Mon, 15 Jul 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h75BEQMz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9CB172BA6
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049163; cv=none; b=ssvElSGyluXrmkW0o/NLi8v0rLPfZW+3WZGJCLhnDfUuzuASgUXYCN55TndRRJhIdFYaloU7DoMuMYsTY+/rihRsL2ZguI8lvOCrgdpc91eZNRCpWrgmCwiGa00YQh++ghBX0c5WOqPSI4SY9cZ5uV2d0JEAO0UEP38q6ejywFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049163; c=relaxed/simple;
	bh=gmUdVlmZWJxCtOIfUsdfv6b/PYnsMhHi7bxt/NpfvLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjayFdiHWMQAxZQDL7cQq3dBZQiSiRL8PuKOGF7cHCnqo6IqVinaLzLqEDjCvEfZVHmEixw/47qnmp0abKjWVzKFdCLk7rD2+a1uM8ujFgPvfF8H6Oa7s3XKsShISmh1HkbdhL6uE1FGh78rgvdb2rNhVT3Jq5dKEVe/pBjRmTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h75BEQMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D604DC4AF10;
	Mon, 15 Jul 2024 13:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721049163;
	bh=gmUdVlmZWJxCtOIfUsdfv6b/PYnsMhHi7bxt/NpfvLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h75BEQMzz5Wq1GfjShGZiQ0TZlSW4k2Zhp6nMLVzQqMTlvqV/nIkf9jWpzkP82/jG
	 RrMD98RvMt1rwNoi4LEbVLmQfLjxjL/7aGDEWzOA64O4g2zd6yIREcpd9n+judE9Re
	 A57TmQv+nvFLLTBA/1LuCB+iDFw8VltLHef8TBXMex+DdRnZyT5ADnRaptpN7lgMSR
	 pWnxS+1Jtec1X9FwfaW3VK7T8+mwsc7LyHS+Uv5dbsDDueLMuSOj9JIxlNftEbr06I
	 ZQOr2bTPDr5s4fJW7oTEGOlTkhUryoTSwt2SjsO/eyuMifGmfST7K3OaMHm3qGhBa4
	 8/HTXdmTkPE5w==
Date: Mon, 15 Jul 2024 14:12:39 +0100
From: Simon Horman <horms@kernel.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v5 11/17] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Message-ID: <20240715131239.GD45692@kernel.org>
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-12-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714202246.1573817-12-chopps@chopps.org>

On Sun, Jul 14, 2024 at 04:22:39PM -0400, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add support for tunneling user (inner) packets that are larger than the
> tunnel's path MTU (outer) using IP-TFS fragmentation.
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  net/xfrm/xfrm_iptfs.c | 401 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 375 insertions(+), 26 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c

...

> +static int iptfs_copy_create_frags(struct sk_buff **skbp,
> +				   struct xfrm_iptfs_data *xtfs, u32 mtu)
> +{
> +	struct skb_seq_state skbseq;
> +	struct list_head sublist;
> +	struct sk_buff *skb = *skbp;
> +	struct sk_buff *nskb = *skbp;
> +	u32 copy_len, offset;
> +	u32 to_copy = skb->len - mtu;
> +	u32 blkoff = 0;
> +	int err = 0;
> +
> +	INIT_LIST_HEAD(&sublist);
> +
> +	BUG_ON(skb->len <= mtu);
> +	skb_prepare_seq_read(skb, 0, skb->len, &skbseq);
> +
> +	/* A trimmed `skb` will be sent as the first fragment, later. */
> +	offset = mtu;
> +	to_copy = skb->len - offset;
> +	while (to_copy) {
> +		/* Send all but last fragment to allow agg. append */
> +		list_add_tail(&nskb->list, &sublist);
> +
> +		/* FUTURE: if the packet has an odd/non-aligning length we could
> +		 * send less data in the penultimate fragment so that the last
> +		 * fragment then ends on an aligned boundary.
> +		 */
> +		copy_len = to_copy <= mtu ? to_copy : mtu;

nit: this looks like it could be expressed using min()

     Flagged by Coccinelle


> +		nskb = iptfs_copy_create_frag(&skbseq, offset, copy_len);
> +		if (IS_ERR(nskb)) {
> +			XFRM_INC_STATS(dev_net(skb->dev),
> +				       LINUX_MIB_XFRMOUTERROR);
> +			skb_abort_seq_read(&skbseq);
> +			err = PTR_ERR(nskb);
> +			nskb = NULL;
> +			break;
> +		}
> +		iptfs_output_prepare_skb(nskb, to_copy);
> +		offset += copy_len;
> +		to_copy -= copy_len;
> +		blkoff = to_copy;

blkoff is set but otherwise unused in this function.

Flagged by W=1 x86_64 allmodconfig builds with gcc-14 and clang 18.

> +	}
> +	skb_abort_seq_read(&skbseq);
> +
> +	/* return last fragment that will be unsent (or NULL) */
> +	*skbp = nskb;
> +
> +	/* trim the original skb to MTU */
> +	if (!err)
> +		err = pskb_trim(skb, mtu);
> +
> +	if (err) {
> +		/* Free all frags. Don't bother sending a partial packet we will
> +		 * never complete.
> +		 */
> +		kfree_skb(nskb);
> +		list_for_each_entry_safe(skb, nskb, &sublist, list) {
> +			skb_list_del_init(skb);
> +			kfree_skb(skb);
> +		}
> +		return err;
> +	}
> +
> +	/* prepare the initial fragment with an iptfs header */
> +	iptfs_output_prepare_skb(skb, 0);
> +
> +	/* Send all but last fragment, if we fail to send a fragment then free
> +	 * the rest -- no point in sending a packet that can't be reassembled.
> +	 */
> +	list_for_each_entry_safe(skb, nskb, &sublist, list) {
> +		skb_list_del_init(skb);
> +		if (!err)
> +			err = xfrm_output(NULL, skb);
> +		else
> +			kfree_skb(skb);
> +	}
> +	if (err)
> +		kfree_skb(*skbp);
> +	return err;
> +}
> +
> +/**
> + * iptfs_first_should_copy() - determine if we should copy packet data.
> + * @first_skb: the first skb in the packet
> + * @mtu: the MTU.
> + *
> + * Determine if we should create subsequent skbs to hold the remaining data from
> + * a large inner packet by copying the packet data, or cloning the original skb
> + * and adjusting the offsets.
> + */
> +static bool iptfs_first_should_copy(struct sk_buff *first_skb, u32 mtu)
> +{
> +	u32 frag_copy_max;
> +
> +	/* If we have less than frag_copy_max for remaining packet we copy
> +	 * those tail bytes as it is more efficient.
> +	 */
> +	frag_copy_max = mtu <= IPTFS_FRAG_COPY_MAX ? mtu : IPTFS_FRAG_COPY_MAX;

Likewise, it looks like min could be used here too.

> +	if ((int)first_skb->len - (int)mtu < (int)frag_copy_max)
> +		return true;
> +
> +	/* If we have non-linear skb just use copy */
> +	if (skb_is_nonlinear(first_skb))
> +		return true;
> +
> +	/* So we have a simple linear skb, easy to clone and share */
> +	return false;
> +}

...

