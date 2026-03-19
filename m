Return-Path: <netdev+bounces-269344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L1HOTOtu2k8mgIAu9opvQ
	(envelope-from <netdev+bounces-269344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:00:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3A62C798C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DDA3312B4D4
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992843A3819;
	Thu, 19 Mar 2026 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nCrzYvFV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767AF399019;
	Thu, 19 Mar 2026 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906966; cv=none; b=lANYCqpijDUY35ce/t/lCg3dSCvNW2ACn4Q0s4NB/62HioKjEgZ0IZP2A5i6kZhrH+ONUokSDXWdg/cCm1Bcrx2w35vS1Ng6Qi2mDURaJyB0xoE+9UDWxsgJD9JaSI0NuH7AplqQ7VdsiFztBqVUqIfOMszgIFP8gMDDo8MW5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906966; c=relaxed/simple;
	bh=h3rzfv0bTvhK5848CButRMmbxWbvmcLDo8IAaOG6vxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6G2JuhHcsSb2wMUz1WgnyIoNf1p4EcCYm5WHJmb1vJguDYkVv26OYgdbz3ZlAZjVmj0ezZQS2EjQbANrIjW3qC1wuboO+IINJdpgFhVUvmKNfvSMU4GTxBqjLfFOCxyDPcFuYEVdYzsvK0lNK27pOGJfZQ6jUiDwMrgeDQuryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nCrzYvFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CB0C19425;
	Thu, 19 Mar 2026 07:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773906966;
	bh=h3rzfv0bTvhK5848CButRMmbxWbvmcLDo8IAaOG6vxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCrzYvFVecz/ZTgeiCcD7MGR6IliOBWE5i9ycvFFdZBTqcISto51gNKjy8dthdSw0
	 yEmPqkDYMrcnZMWjSmsKV3i1wU+yF2FWsYGaIlwv7LCWe3B8cLcvp8Oyr0c/JQyj/g
	 ju86qNn5JUNMlLgpoqqAitO+ULxi3G2XFoyW//XA=
Date: Thu, 19 Mar 2026 08:55:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: bestswngs@gmail.com
Cc: security@kernel.org, edumazet@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xmei5@asu.edu
Subject: Re: [PATCH net] nfnetlink_osf: validate individual option lengths in
 fingerprints
Message-ID: <2026031933-whoopee-dawdler-f605@gregkh>
References: <20260319073243.1176330-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319073243.1176330-2-bestswngs@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269344-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[asu.edu:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[bestswngs.gmail.com:query timed out];
	NEURAL_HAM(-0.00)[-0.920];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: AF3A62C798C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 03:32:44PM +0800, bestswngs@gmail.com wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> nfnl_osf_add_callback() validates opt_num bounds and string
> NUL-termination but does not check individual option length fields.
> A zero-length option causes nf_osf_match_one() to enter the option
> matching loop even when foptsize sums to zero, which matches packets
> with no TCP options where ctx->optp is NULL:
> 
>  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>  RIP: 0010:nf_osf_match_one (net/netfilter/nfnetlink_osf.c:98)
>  Call Trace:
>   <IRQ>
>   nf_osf_match (net/netfilter/nfnetlink_osf.c:227)
>   xt_osf_match_packet (net/netfilter/xt_osf.c:32)
>   ipt_do_table (net/ipv4/netfilter/ip_tables.c:293)
>   nf_hook_slow (net/netfilter/core.c:623)
>   ip_local_deliver (net/ipv4/ip_input.c:262)
>   ip_rcv (net/ipv4/ip_input.c:573)
>   </IRQ>
>  Kernel panic - not syncing: Fatal exception in interrupt
> 
> Additionally, an MSS option (kind=2) with length < 4 causes
> out-of-bounds reads when nf_osf_match_one() unconditionally accesses
> optp[2] and optp[3] for MSS value extraction.  While RFC 9293
> section 3.2 specifies that the MSS option is always exactly 4
> bytes (Kind=2, Length=4), the check uses "< 4" rather than
> "!= 4" because lengths greater than 4 do not cause memory
> safety issues -- the buffer is guaranteed to be at least
> foptsize bytes by the ctx->optsize == foptsize check.
> 
> Reject fingerprints where any option has zero length, or where an MSS
> option has length less than 4, at add time rather than trusting these
> values in the packet matching hot path.
> 
> Fixes: 11eeef41d5f6 ("netfilter: passive OS fingerprint xtables match")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/netfilter/nfnetlink_osf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
> index 94e3eac5743a..c35b831dac5a 100644
> --- a/net/netfilter/nfnetlink_osf.c
> +++ b/net/netfilter/nfnetlink_osf.c
> @@ -303,6 +303,7 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
>  	struct nf_osf_user_finger *f;
>  	struct nf_osf_finger *kf = NULL, *sf;
>  	int err = 0;
> +	int i;
> 
>  	if (!capable(CAP_NET_ADMIN))
>  		return -EPERM;
> @@ -318,6 +319,13 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
>  	if (f->opt_num > ARRAY_SIZE(f->opt))
>  		return -EINVAL;
> 
> +	for (i = 0; i < f->opt_num; i++) {
> +		if (!f->opt[i].length)
> +			return -EINVAL;
> +		if (f->opt[i].kind == OSFOPT_MSS && f->opt[i].length < 4)
> +			return -EINVAL;
> +	}
> +
>  	if (!memchr(f->genre, 0, MAXGENRELEN) ||
>  	    !memchr(f->subtype, 0, MAXGENRELEN) ||
>  	    !memchr(f->version, 0, MAXGENRELEN))
> --
> 2.43.0
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

