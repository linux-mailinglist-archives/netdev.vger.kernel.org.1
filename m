Return-Path: <netdev+bounces-114120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD2A941023
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4024C1F235B6
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F062A19415E;
	Tue, 30 Jul 2024 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLO4SXu+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6013DDAE;
	Tue, 30 Jul 2024 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337409; cv=none; b=S1vYA4+mKKCCZz/h6kj4zQLQsShiAEIvo7JJ1mY2A6XF0fesfNPZWFk0aFaG1yusl2NJcIvCCRpSeSv8onpHnQlAhEXvPZ8RXegiWgJj55+HUNmhH8gFWUCOtZlOJsk/BV/Ug51XoaSV/Pgq9IRvBF0jAGwgt+xP7pfupX2BoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337409; c=relaxed/simple;
	bh=CXkoGsg6csuPovdY1NpQLB+BXK7giXSuwsrflARY14U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoTWQQMEH3LeXf/j6SGEjNE86HB0B3jdyMwig5rJytSzHKa4Vh+3E5gz6gX6bmw5FtAYSUdws+ipzppu4a21Yb4Bcg08VqCRyQm5vzl4y6O4xwpaJAaHpHjFaya3xZBoc5SyNbiyARWxIpaxen8bFwdnqzInyeRz58GbURDE8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLO4SXu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9157FC32782;
	Tue, 30 Jul 2024 11:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722337409;
	bh=CXkoGsg6csuPovdY1NpQLB+BXK7giXSuwsrflARY14U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLO4SXu+NXYj5kFTql9ncVanh291Pk0zTWF7m91Ti2+VYyNB6GsWUQqxeqPpI5R97
	 L3MT4tlWOsqc63ESriMBteo0sdNIupp5c/Y1qiA7CyvNu7w4TfwnOmh3fdQ6IQcLzw
	 R9E7KFPOsKw4A+UvrXc3gdvLc+SXDDqwvSVF7gXi3TVy5teOxeUvk9oJ48B361BCaw
	 /WbFnCa8TG35i6JFsi41i4ZWm3CR3XGJZNpN+0SwizPjdo4uLeQYW0O7qmC9K18AOa
	 o6ncDE5dt06FVN20AivMHhB8aObwUkLPZFy8Xs6TXNdbZgc/Pm8DnZrHHg7B/a4i86
	 GS/E3V8rVMp6w==
Date: Tue, 30 Jul 2024 12:03:25 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net 1/3] idpf: fix memory leaks and crashes while
 performing a soft reset
Message-ID: <20240730110325.GA1781874@kernel.org>
References: <20240724134024.2182959-1-aleksander.lobakin@intel.com>
 <20240724134024.2182959-2-aleksander.lobakin@intel.com>
 <20240726160954.GO97837@kernel.org>
 <870cd73e-0f87-41eb-95d1-c9fe27ed1230@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <870cd73e-0f87-41eb-95d1-c9fe27ed1230@intel.com>

On Mon, Jul 29, 2024 at 10:54:50AM +0200, Alexander Lobakin wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Fri, 26 Jul 2024 17:09:54 +0100
> 
> > On Wed, Jul 24, 2024 at 03:40:22PM +0200, Alexander Lobakin wrote:
> >> The second tagged commit introduced a UAF, as it removed restoring
> >> q_vector->vport pointers after reinitializating the structures.
> >> This is due to that all queue allocation functions are performed here
> >> with the new temporary vport structure and those functions rewrite
> >> the backpointers to the vport. Then, this new struct is freed and
> >> the pointers start leading to nowhere.
> 
> [...]
> 
> >>  err_reset:
> >> -	idpf_vport_queues_rel(new_vport);
> >> +	idpf_send_add_queues_msg(vport, vport->num_txq, vport->num_complq,
> >> +				 vport->num_rxq, vport->num_bufq);
> >> +
> >> +err_open:
> >> +	if (current_state == __IDPF_VPORT_UP)
> >> +		idpf_vport_open(vport);
> > 
> > Hi Alexander,
> > 
> > Can the system end up in an odd state if this call to idpf_vport_open(), or
> > the one above, fails. Likewise if the above call to
> > idpf_send_add_queues_msg() fails.
> 
> Adding the queues with the parameters that were before changing them
> almost can't fail. But if any of these two fails, it really will be in
> an odd state...
> 
> Perhaps we need to do a more powerful reset then? Can we somehow tell
> the kernel that in fact our iface is down, so that the user could try
> to enable it manually once again?
> Anyway, feels like a separate series or patch to -next, what do you think?
> 
> > 
> >> +
> >>  free_vport:
> >>  	kfree(new_vport);
> 
> Thanks,
> Olek
> 

