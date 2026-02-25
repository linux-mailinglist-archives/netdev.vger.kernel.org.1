Return-Path: <netdev+bounces-260990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMcQJ1QIn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-260990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:33:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9A2198CAA
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 061663028658
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEC83A7F44;
	Wed, 25 Feb 2026 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P96UkeCT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D36396B71;
	Wed, 25 Feb 2026 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030033; cv=none; b=tFwb4iwDS+leMjTFRB2+u902MosvJw5GmMG3vo4Mu0yosSxXpo+j/nTY4bObIHLT8gYkeOc809mEfCGV/Ej3ZGHsifwxkUc5+7jVM/YZ6ZPskvMXJ2NDJmv+Pz+vqHgVbDoJBc/uFMSYF9mZKdsLYFL84lXxG4BZwR51Ra0zX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030033; c=relaxed/simple;
	bh=Pi3y1CO9Welj8wzp+EKtynj1x5SZzWRB0Oum+hWgztc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu7AXJHC861zLNuq9COXyx5EMD81E2nGmJ0EoTajcQwakYT/BptXpm0HoxhV5gACY0S7z7mSwLmvbGbmBbCSVy6kOxj+SB2oUrL15H53Rhbh9wS1BxMwZZnUCfFnluqQJPjpKDV8vuwtmY+Dpwq3cOAuuW8hPLJpI67KYPcqlEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P96UkeCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E976C116D0;
	Wed, 25 Feb 2026 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772030033;
	bh=Pi3y1CO9Welj8wzp+EKtynj1x5SZzWRB0Oum+hWgztc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P96UkeCTgGZ3d4CG7xogSe16c8gy8Mg53avi0NuAew4t2Mhanv8kulZyHxdTJFqtE
	 0J8BLtPujPZr8aolb8RWhX7fmhyQYkdTCAG+FnwXOk7IYyXn/GQ+TIZ+RqhQQfH7Oq
	 BdZ4+jlNaJf5LvVro5BDzAB0m27/4Kn8MoSo13Uo=
Date: Wed, 25 Feb 2026 06:33:45 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH net] vsock: Use container_of() to get net namespace in
 sysctl handlers
Message-ID: <2026022550-expire-divinity-e12b@gregkh>
References: <2026022318-rearview-gallery-ae13@gregkh>
 <aZ1oTufA5JkTBl35@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ1oTufA5JkTBl35@sgarzare-redhat>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260990-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F9A2198CAA
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:54:58AM +0100, Stefano Garzarella wrote:
> On Mon, Feb 23, 2026 at 06:32:18PM +0100, Greg Kroah-Hartman wrote:
> > current->nsproxy is should not be accessed directly as syzbot has found
>                   ^
> nit: "is" can be removed
> 
> > that it could be NULL at times, causing crashes.  Fix up the af_vsock
> > sysctl handlers to use container_of() to deal with the current net
> > namespace instead of attempting to rely on current.
> > 
> > This is the same type of change done in commit 7f5611cbc487 ("rds:
> > sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy")
> > 
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Cc: stable <stable@kernel.org>
> 
> I'm not sure this is stable material since these changes landed in the
> latest merge window (v7.0-rc1), but yeah, you know better than me, so there
> could be a reason.
> 
> If needed, maybe we can also add:
> 
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")

Ah, I missed that this was a "new" thing, you are right, cc: stable
wasn't needed, and the fixes: tag is good to have.  I don't normally add
those as it's up to me to do the backports and I can figure it out on my
own when they hit Linus's tree :)

> > Assisted-by: gkh_clanker_2000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > 
> > Note, this is compile-tested only.  Some of my scripts found this when
> > looking for places that are missing fixes that were applied to other
> > parts of the kernel.  I think the af_vsock code uses namespaces, but as
> > I don't know the network stack at all I figured I would let you all
> > review it to tell me how wrong I got this change and all is fine with
> > the original code.
> 
> Thanks! LGTM and tests are fine!
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Great, thanks for testing and the review!

greg k-h

