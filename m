Return-Path: <netdev+bounces-280788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JpFIu826mmdxAIAu9opvQ
	(envelope-from <netdev+bounces-280788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:12:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F84454240
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8EC2300AB2E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493A135DA6C;
	Thu, 23 Apr 2026 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oh3N2o39"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D535DA61;
	Thu, 23 Apr 2026 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956805; cv=none; b=LWnMxVQCyX+BKcwLb3BUV/bfmYoJCP5+ZuG6mv/MPJkkpWqIT8Iszfa+fHi89p4G7sRUKbNJUGOAwtUW6zOY1O+k3wj3hAMt5BCe4ic7kVJFNUvbd3zPM+gONLqo3brYksyYh6pzRUAbbjaPnMSEWKv/3Iuj6jjawPuJMcXSRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956805; c=relaxed/simple;
	bh=602NRMnU7bVrrfXuYkx4jBiuf+ga8V/WQFmakxO6U0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUNS2i7OYnoCCVYtxYGs0MuSZ0Lkw7imZmDZw03vcyPWRzzsR2xNDZ7vhovrK24ZbDxzDHsyn7IzBga2qOLBifHr+ZcODxhTOUjI372Lat7ivY6l28A8xAkxPftukLPXFdWN5mMfYAgbnaSCIOJll1hn/arjURrECBRX2ZZ0REo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oh3N2o39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C03C2BCB6;
	Thu, 23 Apr 2026 15:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776956804;
	bh=602NRMnU7bVrrfXuYkx4jBiuf+ga8V/WQFmakxO6U0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oh3N2o39TxRWVrPHXqG2OIPCwjmgAquHgkW1Tf/X1lzZgQRw1cljlxqIcLBP3fqCM
	 G+rqk924s933m9IB/ni8mZLE/qW6c9APFnKWElWIZ3oAkwU2oqTnAn3g7ibHDUgDUx
	 Jlg//fAUGTRAFtzn2oNtMfZTR2Spin4qK2A9aBKE=
Date: Thu, 23 Apr 2026 17:06:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] ipv4: clamp MCAST_MSFILTER getsockopt to optlen, not
 gf_numsrc
Message-ID: <2026042344-ferry-mystify-74ee@gregkh>
References: <2026042054-dime-spectator-820e@gregkh>
 <17e348e1-b551-41e4-a512-906109dded4d@redhat.com>
 <2026042345-prompter-boogieman-1f5e@gregkh>
 <a8634793-e905-4298-bf48-ba9a2e9c3eee@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8634793-e905-4298-bf48-ba9a2e9c3eee@redhat.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280788-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1F84454240
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 04:29:06PM +0200, Paolo Abeni wrote:
> On 4/23/26 4:18 PM, Greg Kroah-Hartman wrote:
> > On Thu, Apr 23, 2026 at 03:57:55PM +0200, Paolo Abeni wrote:
> >> On 4/20/26 9:26 PM, Greg Kroah-Hartman wrote:
> >>> @@ -1486,8 +1491,12 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
> >>>  	gf.gf_interface = gf32.gf_interface;
> >>>  	gf.gf_fmode = gf32.gf_fmode;
> >>>  	num = gf.gf_numsrc = gf32.gf_numsrc;
> >>> -	gf.gf_group = gf32.gf_group;
> >>>  
> >>> +	if (num > (len - size0) / sizeof(struct sockaddr_storage))
> >>> +		num = (len - size0) / sizeof(struct sockaddr_storage);
> >>> +	gf.gf_numsrc = num;
> >>
> >> Since this is exactly the same code added above, likely a common helper
> >> would be useful.
> > 
> > Useful where else?
> 
> Just in these 2 functions, to avoid duplicating the logic.
> 
> Not a big deal, but it would feel nicer. Also the
> 
> 	gf.gf_group = gf32.gf_group;
> 
> statement is moved around but such change is not needed, right?

It's just moved down, I inserted the check/assignment before that line,
and git diff shows that as remove/add for some reason :(

thansk,

greg k-h

