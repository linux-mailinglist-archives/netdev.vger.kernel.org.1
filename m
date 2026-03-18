Return-Path: <netdev+bounces-268887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLWLL+dIumkFTwIAu9opvQ
	(envelope-from <netdev+bounces-268887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:40:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CABC2B680C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B6773006B6C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 06:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552903612F7;
	Wed, 18 Mar 2026 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p0/cvBYs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DE21B918;
	Wed, 18 Mar 2026 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815825; cv=none; b=Oq8PiZogjJVGkB06JGmWA1Fn3bHyYilfaCpkC92AnHCvSTPO2NkqhVExywDm3VxCHxtslmHR7eO4km3hXM5alv3pbymsHQ4pJPLO9tw1BZaUb2zVNHXQ/8CpYauV0sNMF4vXi6I0Y/LbWAg6s+jDYmHRsIPWUPUEpl704aweOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815825; c=relaxed/simple;
	bh=KKXQx4AZN32QRqUy3BQB2Ca5L3Cu5POfq9rizGvZiDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDZPsxnr3LDGvR79V++kmlRnN3s7/q04z4jaZ5HQ294DOg3Q+ORVI+SKxoYZ8v/T/1bRd9u3XRaldazlRuHkD7tMS6kO87zGTXXruhu2GhLAi4NhwL/o05qjbs63moaBuFXSBjbKuMcBNru/TpDgeUywueJppMNSzQn18JkIjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p0/cvBYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1772EC19421;
	Wed, 18 Mar 2026 06:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773815824;
	bh=KKXQx4AZN32QRqUy3BQB2Ca5L3Cu5POfq9rizGvZiDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0/cvBYs7in47EAH61+Ne+rEq2U8xmicwhgqhWyB4iC0Swic6qaNiTW+Y8m8Wqm7f
	 1x/Pks0iM6tSYzh8BEbHEuKKGkkx5zkD4fGmb1JTbgcpvSlZkmVvoe/Rm2CdCBn7N4
	 WQcS8DLj+g032lRdYXwh3nlYt11jPi33KxGixvjE=
Date: Wed, 18 Mar 2026 07:36:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Omer Zalman <omerzalman42@gmail.com>
Cc: oliver@neukum.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: usb: cdc_ncm: convert sysfs show() callbacks to
 sysfs_emit()
Message-ID: <2026031824-bladder-percent-ba02@gregkh>
References: <20260318040632.69531-1-omerzalman42@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318040632.69531-1-omerzalman42@gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268887-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4CABC2B680C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:06:31PM -0500, Omer Zalman wrote:
> sysfs_emit() was introduced in v5.10 as the preferred replacement for
> sprintf() in sysfs show() handlers. It bounds output to PAGE_SIZE and
> avoids potential buffer overruns.
> 
> Convert all show() callbacks and the NCM_PARM_ATTR macro from sprintf()
> to sysfs_emit().

There is no need to change existing show functions to sysfs_emit(),
unless you are doing some other work in the same area.  Otherwise it
would be a huge churn all across the tree.

So no need for this patch, sorry.

thanks,

greg k-h

