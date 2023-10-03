Return-Path: <netdev+bounces-37678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D87B6972
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 9570DB20924
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065F62375D;
	Tue,  3 Oct 2023 12:51:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFD82915
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 12:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1895BC433C8;
	Tue,  3 Oct 2023 12:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696337500;
	bh=giCCL/NQzyaXSepsEpVlfuBXyhXS1M2eW5ebS85qKZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rz4WfdlKsXh1tFMotFawMYFAsYy2FjqKasOSSRBu5y6Yk6xxZUt7oaPH/+FfMAXll
	 xw207CQd/qaXVdVNBPqnp+u3U/jhAMUB+31upo1GUynANt3cOzOX4VlJpjunymCOiA
	 bgWi+0exsrfd1Wh6EDX3xJzXxZ+B4PU5vblYXaG94i7URiI9Smqex+9+YTqXAEULI+
	 i5G9QD10CdKbMjRN22No7aBUoZEaTWNgHB0NkkeYRbSB3NNo6b+HilmgzhUJYVCGfz
	 oOQPKxmyfTZhHJMRJmr8Lh4tw0m7FCcVxPMe7A9c5qZAMLqY/boJFiGnDAbDVcc4e+
	 zVWQGxcBPSdaw==
Date: Tue, 3 Oct 2023 14:51:35 +0200
From: Simon Horman <horms@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
	linux-sctp@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH nf] netfilter: handle the connecting collision properly
 in nf_conntrack_proto_sctp
Message-ID: <ZRwOVyKQR8MBjpBh@kernel.org>
References: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>

On Sun, Oct 01, 2023 at 11:07:48AM -0400, Xin Long wrote:

...

> @@ -481,6 +486,24 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
>  			    old_state == SCTP_CONNTRACK_CLOSED &&
>  			    nf_ct_is_confirmed(ct))
>  				ignore = true;
> +		} else if (sch->type == SCTP_CID_INIT_ACK) {
> +			struct sctp_inithdr _ih, *ih;
> +			u32 vtag;
> +
> +			ih = skb_header_pointer(skb, offset + sizeof(_sch), sizeof(*ih), &_ih);
> +			if (ih == NULL)
> +				goto out_unlock;
> +
> +			vtag = ct->proto.sctp.vtag[!dir];
> +			if (!ct->proto.sctp.init[!dir] && vtag && vtag != ih->init_tag)
> +				goto out_unlock;
> +			/* collision */
> +			if (ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir] &&
> +			    vtag != ih->init_tag)

The type of vtag is u32. But the type of ct->proto.sctp.vtag[!dir] and init_tag
is __be32. This doesn't seem right (and makes Sparse unhappy).

> +				goto out_unlock;
> +
> +			pr_debug("Setting vtag %x for dir %d\n", ih->init_tag, !dir);
> +			ct->proto.sctp.vtag[!dir] = ih->init_tag;
>  		}
>  
>  		ct->proto.sctp.state = new_state;
> -- 
> 2.39.1
> 
> 

