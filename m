Return-Path: <netdev+bounces-112260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD6C937BF6
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 19:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1FD2826E5
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 17:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8059F1465A8;
	Fri, 19 Jul 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DboOl3gO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3F4146A85
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721411857; cv=none; b=KqEQrRVog450pvY3wjKjnaU9wJmu4bBWp2Etr5s5hWIjz9gEyfpOOnkajjucwq5fnzWvjXTAhYPEuBYVujqHJ9psLBGP4en7pAWrO0msJVh7Is6akkcEimet+rgPQYwjqlCKwwxxOgCB9rmIs8ojUELZnwwS3EgGIkNED3Xdtlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721411857; c=relaxed/simple;
	bh=gBSfgHqzMZyfzEG292qR2pPcIdmVtij9j0W9wDUC/Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMayXW+wtq+c6Yl7jdBoIvhZRvwZgn5ORJbCDsPpqS7/DlETgmkZdbvkYJHv/ugQsZJ5lwMpVtGrPMCiLtOEcHFhF99jcf9iqEhl+a5gOaFXJMJTsd/ndQYNZzGSLzA7kcw4YrQu1zQCRB6ReHN5wAtDgO+BmoM8HJpgJrb/8YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DboOl3gO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721411854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ScE19C0ZbjRjXc1ErXBtrk4kqtnK9/PBxVB1lOMtsB4=;
	b=DboOl3gON246nqT2019b728K2Zval5r62OEChi39UgAyGTyhi1ZiuGKPGwLlFyMaw9fFDT
	uq7GdhFMc8P0juLj68d7aDnA4elsk4ULPMV4P4xbn5E/FM3LhyxXfnu+ljGGo6BC9+dItH
	3xwj5WfwlmW1fTgW9sJHSZVgpC/sNog=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-MIF41snmNcW782BgjcQuWA-1; Fri, 19 Jul 2024 13:57:33 -0400
X-MC-Unique: MIF41snmNcW782BgjcQuWA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36835daf8b7so1167980f8f.2
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 10:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721411851; x=1722016651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScE19C0ZbjRjXc1ErXBtrk4kqtnK9/PBxVB1lOMtsB4=;
        b=kmHwIJGL9Nvpbrc00+BuuCg/oTKi0uauLo2SKb+zDusH27Hjp8G+17/W7HChlTDp5L
         MivpHn97sv6yePUIkxFxJLtaTlc8zy9M8JL8AJY89CXJAw5gSq/TqdWwncatC3gv6a7U
         Q/3IP95CVGkTEwD5S8BHfu0rOFHJIAaihcaj/AnaoQgS7eFRUjxXZ9wKjxvaFuLhw3QJ
         Rl0Cvsqupd07HEJhlf2vQOUoSrxQ1cN12GJbRiHCR2ODUgaf7WHRFZrvMi92zpUtPGRT
         8oadqrVI1KUSaTpklG0O/wDOGCq0QD1IyWNhQdtp/V0/BdQ9AYHn9pRsOlIL0sEickf9
         UG0w==
X-Gm-Message-State: AOJu0YwtxZAliDWxI4NcUAyKbjPRHETG1kcC0lpCujuW0bpyRsYqUqw7
	mShHEtIlqXHcUp41QO1nRyd5+zACTZXUTbeEzc/rhV5aBFlUPd0PY9wl9W/kqFttzHZlA1UN0cD
	DGG7oeccAqmtNIz3JRiIW78HZ2yX1jPhKy5cJePJIMFv3z8HG+dGa0M8AyLu+Yg==
X-Received: by 2002:a05:6000:1562:b0:368:4b34:541 with SMTP id ffacd0b85a97d-3684b3405d2mr6071476f8f.16.1721411850985;
        Fri, 19 Jul 2024 10:57:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzxkuszdZLfxoKFpwNyb1jHEnDFzNmx6ruGw39Qp9b85hUaH5kAf3dHNtAVY4hMrg0An8Ktw==
X-Received: by 2002:a05:6000:1562:b0:368:4b34:541 with SMTP id ffacd0b85a97d-3684b3405d2mr6071454f8f.16.1721411850288;
        Fri, 19 Jul 2024 10:57:30 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878694637sm2219339f8f.56.2024.07.19.10.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 10:57:29 -0700 (PDT)
Date: Fri, 19 Jul 2024 19:57:27 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
Subject: Re: Matching on DSCP with IPv4 FIB rules
Message-ID: <ZpqpB8vJU/Q6LSqa@debian>
References: <ZnwCWejSuOTqriJc@shredder.mtl.com>
 <ZnypieBfn3CxCGDq@debian>
 <Zn3DdfGZIVBxN0DR@shredder.lan>
 <Zobnma+cQPMhIlSy@debian>
 <ZpkVIE1Pod1jrgsc@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpkVIE1Pod1jrgsc@shredder.mtl.com>

On Thu, Jul 18, 2024 at 04:14:08PM +0300, Ido Schimmel wrote:
> On Thu, Jul 04, 2024 at 08:19:05PM +0200, Guillaume Nault wrote:
> 
> > So, do you mean to centralise the effect of all the current RT_TOS()
> > calls inside a few functions? So that we can eventually remove all
> > those RT_TOS() calls later?
> 
> Yes. See this patch:
> 
> https://github.com/idosch/linux/commit/80f536f629c4dccdb6c015a10ca25d7743233208.patch
> 
> I can send it when net-next opens. It should allow us to start removing
> the masking of the high order DSCP bits without introducing regressions
> as the masking now happens at the core and not at individual call sites
> or along the path to the core.

Thanks for the sample patch. I think we're on the same page.

> > > I was only able to find two call paths that can reach these functions
> > > with a TOS value that does not have its three upper DSCP bits masked:
> > > 
> > > nl_fib_input()
> > > 	nl_fib_lookup()
> > > 		flowi4_tos = frn->fl_tos	// Directly from user space
> > > 		fib_table_lookup()
> > > 
> > > nft_fib4_eval()
> > > 	flowi4_tos = iph->tos & DSCP_BITS
> > > 	fib_lookup()
> > > 
> > > The first belongs to an ancient "NETLINK_FIB_LOOKUP" family which I am
> > > quite certain nobody is using and the second belongs to netfilter's fib
> > > expression.
> > 
> > I agree that nl_fib_input() probably doesn't matter.
> > 
> > For nft_fib4_eval() it really looks like the current behaviour is
> > intended. And even though it's possible that nobody currently relies on
> > it, I think it's the correct one. So I don't really feel like changing
> > it.
> 
> Yes, I agree. The patch I mentioned takes care of that by setting the
> new 'FLOWI_FLAG_MATCH_FULL_DSCP' in nft_fib4_eval().

Okay, let me contradict myself... :)

Considering that the number of users of this new flag has no
reason to grow and that we can ignore nl_fib_input() (which is close to
unusable as the necessary fib_result_nl structure isn't exported to
include/uapi/), does it really make sense to add a special case just
for nft_fib4_eval()?

I imagine the pain of describing the tos and dscp keywords in man pages
for example. There will be enough important details about the ECN bits,
the behaviour differences between IPv4 and IPv6, the different number
representation between dscp and tos (bit shift)... If we also have to
explain that the behaviour also depends on the module at the origin of
the route lookup, end users are going to get completely lost.

> > > If regressions are reported for any of them (unlikely, IMO), we can add
> > > a new flow information flag (e.g., 'FLOWI_FLAG_DSCP_NO_MASK') which will
> > > tell the core routing functions to not apply the 'IPTOS_RT_MASK' mask.
> > > 
> > > 3. Removing 'struct flowi4::flowi4_tos'.
> > > 
> > > 4. Adding a new DSCP FIB rule attribute (e.g., 'FRA_DSCP') with a
> > > matching "dscp" keyword in iproute2 that accepts values in the range of
> > > [0, 63] which both address families will support. IPv4 will support it
> > > via the new DSCP field ('struct flowi4::dscp') and IPv6 will support it
> > > using the existing flow label field ('struct flowi6::flowlabel').
> > 
> > I'm sorry, something isn't clear to me. Since masking the high order
> > bits has been centralised at step 2, how will you match them?
> > 
> > If we continue to take fib4_rule_match() as an example; do you mean to
> > extend struct fib4_rule to store the extra information, so that
> > fib4_rule_match() knows how to test fl4->dscp? For example:
> 
> Yes. See these patches:
> 
> https://github.com/idosch/linux/commit/1a79fb59f66731cfc891e3fecb3b08cda6bb0170.patch
> https://github.com/idosch/linux/commit/a4990aab8ee4866b9f853777a50de09537255d67.patch
> https://github.com/idosch/linux/commit/7328d60b7cfe2b07b2d565c9af36f650e96552a5.patch
> https://github.com/idosch/linux/commit/73a739735d27bef613813f0ac0a9280e6427264d.patch
> 
> Specifically these hunks from the second patch:
> 
> @@ -37,6 +37,7 @@ struct fib4_rule {
>  	u8			dst_len;
>  	u8			src_len;
>  	dscp_t			dscp;
> +	u8			is_dscp_sel:1;	/* DSCP or TOS selector */
>  	__be32			src;
>  	__be32			srcmask;
>  	__be32			dst;
> @@ -186,7 +187,14 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
>  	    ((daddr ^ r->dst) & r->dstmask))
>  		return 0;
>  
> -	if (r->dscp && !fib_dscp_match(r->dscp, fl4))
> +	/* When DSCP selector is used we need to match on the entire DSCP field
> +	 * in the flow information structure. When TOS selector is used we need
> +	 * to mask the upper three DSCP bits prior to matching to maintain
> +	 * legacy behavior.
> +	 */
> +	if (r->is_dscp_sel && r->dscp != inet_dsfield_to_dscp(fl4->flowi4_tos))
> +		return 0;
> +	else if (!r->is_dscp_sel && r->dscp && !fib_dscp_match(r->dscp, fl4))
>  		return 0;
>  
>  	if (rule->ip_proto && (rule->ip_proto != fl4->flowi4_proto))
> 
> Note that it is just an RFC. I first need to remove the masking of the
> high order DSCP bits before I can send it.

I find "is_dscp_sel" not very informative as a field name. Maybe
"dscp_nomask" or "dscp_full" would be better? They're more intuitive
to me, but I have no problem if you prefer to keep "is_dscp_sel" of
course.

> >     /* Assuming FRA_DSCP sets ->dscp_mask to 0xff while the default
> >      * would be 0x1c to keep the old behaviour.
> >      */
> >     if (r->dscp && r->dscp != (fl4->dscp & r->dscp_mask))
> 
> It's a bit more involved. Even if the old TOS selector is used, we don't
> always want to mask using 0x1c. If nft_fib4_eval() filled 0xfc in
> 'flowi4_tos', then by masking using 0x1c it will now match a FIB rule
> that was configured with 'tos 0x1c' whereas previously it didn't. The
> new 'FLOWI_FLAG_MATCH_FULL_DSCP' takes care of that, but it only applies
> to rules configured with the TOS selector. The new DSCP selector will
> always match against the entire DSCP field.

Back to nft_fib4_eval(), making it behave like the rest of the kernel
would also mean it'd behave like the existing ipt_rpfilter module. So
people moving from iptables to nftables would keep the same behaviour.
Unless you strongly feel about keeping the FLOWI_FLAG_MATCH_FULL_DSCP
flag, I think we should ask Pablo and Florian if they're okay for
making nft_fib4_eval() behave like the rest of the stack.

> Are you OK with the approach that I outlined above? Basically:
> 
> 1. Submitting the patch that centralizes TOS matching
> 2. Removing the masking of the high order DSCP bits
> 3. Adding new DSCP selector for FIB rules

Yes, looks like a good plan!

> If you already have some patches that convert to 'dscp_t', then I can
> work on top of them to avoid conflicts.

I think we can complete the new dscp feature faster than the dscp_t
conversion. Therefore I think it'll make more sense for me to rebase
on top of your patches.


