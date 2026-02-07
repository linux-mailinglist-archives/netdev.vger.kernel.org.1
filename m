Return-Path: <netdev+bounces-257751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nAusLqQNh2mqTAQAu9opvQ
	(envelope-from <netdev+bounces-257751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 11:02:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E211056DF
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 11:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5470E30046B8
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 10:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A102D6E4B;
	Sat,  7 Feb 2026 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdUCdync";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQAt3tm/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E34C255F2C
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770458525; cv=none; b=H6359t/RcUzRAL6rBvR+dzH2OJeShot83MxQGjk0o79WdIm3R9AVXkgqg2Qj7Ue5VDGrKf12gRh66u2l6cHL3kB+yRvXcKjk45rI9R6tc7SOdNVNwS7e3xlPGSzMXVEcJKfAbnIzkMp/Sf1YbcDSazLtWN97IOhhtE6q8uoOMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770458525; c=relaxed/simple;
	bh=alBBNiHKr5Pm0+hZd8jm5+Fidbd+LvAXEPwf19/p9z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSpZHYuHL/jOvUA4OogHJ64QuVoyFQts9a+sRhihLu0iiNINEQem0483VUfMSv7TUFsa2S0cqMZ69WrO5injFEmby4f8ZT5h4uLND+kEx0WU0skhpah+vcBOREeDBjBs0WVha+I2J91qsSAWFT3mJ3pY20voYaU91xMbz2BOtrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdUCdync; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQAt3tm/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770458523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UT5bIrKTvZeJXWmYoolrxZm/cNKxL1SPj9tdfZAy9/Y=;
	b=OdUCdyncfK5mzEF2UNEZAMD8QWMRqIns2FdGuQDPUmixjG5kzjkaxQsVelaK0GBhiYJx9I
	XE3aWcDgpQpWoIUn1roRVIlCjUdHIWi7/u7O+51hY1n6u189L6LK6AQmnYfFtysXRYTbIQ
	T2OU9X5CA8T0CN8jRiXZCV7VVM4ETeU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-JXxDg0_wMz-R-LomblO1Yw-1; Sat, 07 Feb 2026 05:02:02 -0500
X-MC-Unique: JXxDg0_wMz-R-LomblO1Yw-1
X-Mimecast-MFC-AGG-ID: JXxDg0_wMz-R-LomblO1Yw_1770458521
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435aadfaf4eso1647769f8f.2
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 02:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770458521; x=1771063321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UT5bIrKTvZeJXWmYoolrxZm/cNKxL1SPj9tdfZAy9/Y=;
        b=SQAt3tm/Qi64HirvfUzY9sVkyF5KNVt0+XoyMdsdxD7sisv3/L7RCeIPxYdw/2vLPE
         3SK8zsLVSgw3IrGLPtr+dLZMvIztoObBLXBwEkf9mhLysuCpmf7qSxGCCD7OpS4SmiMj
         SSz6KeKhoYQnNMFNFFE6qn1YzgN1jVK8Jv9tjHK8Ro3pP738uTPS1jhcBrWapNETUp+C
         tYQQeGPHUTUgIwxlVnA0ML0h+a6D2osUwHcB9thLgpIxlTblrkIDXL0cQjoz39iDWb6E
         t5oxKYgsB0T0HqJXIA26T95Ompfp2fGNhCpvNGP+WS6+Q/YwcLwl76UMxaQRe1L6ipIy
         fblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770458521; x=1771063321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UT5bIrKTvZeJXWmYoolrxZm/cNKxL1SPj9tdfZAy9/Y=;
        b=i6gHJOZ9iL/sQOlPNVQbz1AlVqD02yt4e4o7aXl1cGmRonqZafTf5v7dU/TXBCQkru
         VAnCoTWhgQjsx7Zzf/70U+oiTkifIy1fk/uHDkzVI6WtYOTvLei/1Pd1J/YcNv1a9Kga
         WAadsYLGGY/VvfHnpQXpeXC7tkp7H2r45+SLmZqDa5apPYc3bGNYwe1XRV7tycaKli1J
         H7niBP4fRFrGcZXhGQuZJ0+nT/fsGWu8sdd5vAL9c9+mP2GOu7QyENLvvCoP6wExdR7g
         dfbAE+m+Ez8ygTwyH43ALSExK0rxCFSOC9+OgDLI5igO0DDaqOhH9WdQ2oaq2+5rDNh8
         Lx2g==
X-Forwarded-Encrypted: i=1; AJvYcCWk8AcK9JIkLDzTN3lYGTxpj+jRZMr0RHn5YTB6IHThXJzST3BG90iU+h4YZq+NfuETdm66l3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgfGhQRua641EfYKsiWya777XCrhw/fjy1Tth8m5x1kKSYQU7I
	oV7zuTWStf/ceCeNUhpWUDmgIbuDxedTky+IR0oH/dRG+26DQXteOlmtiBl3GGL/ZRysit8JUeX
	vqwKbpQJNXmR+PU5zNyg1KoWaY/ufOMJE6Wc3bKtmUHB+Zcz/vQrtsi5c3Q==
X-Gm-Gg: AZuq6aJq5t6EsDSdzB9mFkjzeb35pX5ByiMkYmwXsHMutGmdZzKK3qAwF/wGJCxl7P6
	23prRKvXoxSIFWNf6yGO1T5Ln8EP7TnwFYGv+9T6XHIQV2IXGLY3cR4cMuVlNOjUJnLqSqaG6hY
	piHDPpEtvQ6Sah+hYA4iC1C/FpQ+eYNHJ0foM5E3js7IsB6Urtd50qqTv8FsS5rXPIIF1A7hz/B
	axTsx2Vqoq1Bmc4kg0OICedeQfAnUoJSARLjUgq0ZHEld4RSz99k1Tg7LkK+Roi6Q8HLn29F7da
	7WB3MmXTNQPxZMVyZ7tGRuKJ1/9Uh9l8Ns22GK9VRm6kIs0337XbNkmDL2W8MzsxjenIaDRk/wr
	cbu2w2eSQI2/u8S4M1dM5d9XRP3LVId15qw==
X-Received: by 2002:a5d:5e01:0:b0:432:c37c:d83b with SMTP id ffacd0b85a97d-436296590a0mr8522796f8f.20.1770458520560;
        Sat, 07 Feb 2026 02:02:00 -0800 (PST)
X-Received: by 2002:a5d:5e01:0:b0:432:c37c:d83b with SMTP id ffacd0b85a97d-436296590a0mr8522747f8f.20.1770458520048;
        Sat, 07 Feb 2026 02:02:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b2ef1sm12662561f8f.7.2026.02.07.02.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 02:01:59 -0800 (PST)
Date: Sat, 7 Feb 2026 05:01:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v20 00/12] virtio_net: Add ethtool flow rules
 support
Message-ID: <20260207045848-mutt-send-email-mst@kernel.org>
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260205184328.3b706154@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205184328.3b706154@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257751-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3E211056DF
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 06:43:28PM -0800, Jakub Kicinski wrote:
> On Thu, 5 Feb 2026 16:46:55 -0600 Daniel Jurgens wrote:
> > This series implements ethtool flow rules support for virtio_net using the
> > virtio flow filter (FF) specification. The implementation allows users to
> > configure packet filtering rules through ethtool commands, directing
> > packets to specific receive queues, or dropping them based on various
> > header fields.
> 
> This is a 4th version of this you posted in as many days and it doesn't
> even build. Please slow down. Please wait with v21 until after the merge
> window. We have enough patches to sift thru still for v7.0.

v20 and no end in sight.
Just looking at the amount of pain all this parsing is inflicting
makes me worry. And wait until we need to begin worrying about
maintaining UAPI stability.

It would be much nicer if drivers were out of the business of parsing
fiddly structures.  Isn't there a way for more code in net core
to deal with all this?
-- 
MST


