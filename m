Return-Path: <netdev+bounces-261910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PJGFHC/oWnPwAQAu9opvQ
	(envelope-from <netdev+bounces-261910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:59:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A711BA700
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C9CE304075A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4996944105A;
	Fri, 27 Feb 2026 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ0tOmBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEDD14A4CC
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207764; cv=none; b=qMKGJ2IY/KJGDxT9naHmHuAg0V2hJS9Yko5w6SwYWdhIZC9ycnwZnSRMGK4MvBTs2nqCPvmJe/fWTi0OLJoqizTsrVbAcKRuKXU9K9FjMVhtbjlNJnqtBi+NidRpCBfK//0CcaSkHd7E8AF9QUPoDYuljTYKqqv6Q/VRlvr3OwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207764; c=relaxed/simple;
	bh=m4HHYEoegrmceXAFNgfEuq74TcPKLbfaBUhmSQ+0Cxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMdrIcTstSbkANXn87pdy9cigRBrjH4ioaW3S3b68RDsIcOMNFLs7l0OSCG72McOzhhbV8fhkHIbddysbCpzuXpbjEsZmEacTrqCNnyFbAn8Er1rDxb8iSGd1cBtGPa76KQU/+9DTiBIQnJxh1gki/k1DbvjJcEuOEg9vJW557M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ0tOmBQ; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ae222d87dso2013635d50.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772207758; x=1772812558; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ADjfSCeCS9i/E1+pRoJw2Du6HOXpGomBi+es/5I2vPI=;
        b=PZ0tOmBQHMv1CcCOl3F1Vfzu4MshMiYVwI4ejuymk7sgHZyMqr6CSdykTZa+C4xKJq
         upO9WHjtjAVPMCMGN2J2yszI8yg+rehrJRERVTc3XwhsIfO9XE09AmGApA+mCJvtk2ZK
         gAcGXbI1G/ZyMV3otPdM0WVbl4I9IZUZCS1zY3yoX1uFRavZ3q5cbVV7by315tCmSsXf
         MxNDgP8ZnYAmwiuv4WcGatSyUnnRUnjQa0GNhXMO003ZYYuOSVLR00NOkLhBYe+nLsWT
         wYtBIVsc0dKLNhMT17RaeeAx3fxLZIy9gZo6fkLLy6UKtfTgGC8O5C+YUOJkfH/plt3J
         8h+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207758; x=1772812558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADjfSCeCS9i/E1+pRoJw2Du6HOXpGomBi+es/5I2vPI=;
        b=YriVQ9P3JHq7BHPA29Pb3QP/IK0f/pZUwCD/+slw2R1UucpS76+uX72y+T9o5D7Pjk
         mlT2LDbmG6yWWfXavApGdd/Qcg57TNaTKWGf4mqW0YeBtVdy3frjuCQJyaHlWmk9dHN5
         PHUnGXznAefrxdxC+JJQ05bRDvbtytiZ4FL1lFZQt72Nyl9J+ZX7lWKsDyFwS0PP38U2
         6j3p7qe4uE2BBz77Ncl8dwUwtUHhSG5ZbRLkGC5UEJwNmrtXrZTW6raBVwvcWomB6kx3
         /HYpdTHwR/5CP2Yn+Kz3riqN5jFRr5VO23zOs2jKGj/FnDFXhctCApPHL3r8HqFfC2aU
         quYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdY4jgaVzt+dSuK5pZHdB5z42NOQlKPD8je9tF1tEPrTN9x9zX/sxeeYmgoB6HbbY4jdpKh0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHNUKUJpzjLoTHCdprReOi1NW/y+LKJjzkzDDaWobdBI3LkDs
	nbB42fSJFhOtIymNtWpzfXxVSA4FCxPKGBwbjnjoxyWI6XiyEye6vY+1
X-Gm-Gg: ATEYQzxysC+9DAWJnNxXgTETJWXt0l7+fr4EWDITeKyhSgEG2i9LWKgXwNgJA+pvf0b
	IE8iz/ZLQe3tCsOGAmTTi0LrVTAuxj3QOesKU/OYZ9rkgKlNABKufpiMUWa3B2l6psVjeyN7eV7
	VyoApgq/PdaFbOkndeXzVMwUTUNDNEsjfcrZ6X6yAeCbfBm15aCU9td5fJbqmfoEO1vNpTCPDFI
	puOGVE9rB6Whnyd3WNGxkiUWe+ROXFfrJfL9j0lbCludyalnYYGrz58EqSAcWhPiixHSAmkg6Dr
	J3seLZXPFtTP4npN7R5gFtgwLOdv7BEDNHnOjeGrPM5jQPnQ45G4X+MAWrIS3pDEfPTWslS9i5x
	EnzdSTwULzFcB5Osto3OmuD91DARvU3AcOYmrKrQNJqW+Q5wkvQfhRkxmYgM9YADFl49tXCF4Ln
	URttA9FNSooee11jgZ5WcHmdDLmfBA7Fp3J77BzT6bVJMj7tw=
X-Received: by 2002:a53:b1d3:0:b0:649:6581:a683 with SMTP id 956f58d0204a3-64cc202dc40mr2350443d50.12.1772207757906;
        Fri, 27 Feb 2026 07:55:57 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb75a1157sm2569498d50.6.2026.02.27.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:55:57 -0800 (PST)
Date: Fri, 27 Feb 2026 07:55:53 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] net: devmem: use READ_ONCE/WRITE_ONCE on binding->dev
Message-ID: <aaG+ibeUBEHohG68@devvm11784.nha0.facebook.com>
References: <20260223-devmem-membar-fix-v1-1-37dcae1e49f8@meta.com>
 <aZ5VNkUqkTEzX6PJ@mini-arch>
 <aZ8R5n80NmnPb1J9@devvm11784.nha0.facebook.com>
 <CAHS8izM9gS+4rKaxSdqx3yjn4harxKQ2HeCszPyq6XNbq+UcMQ@mail.gmail.com>
 <aZ9SS22ig+7BJsGD@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ9SS22ig+7BJsGD@devvm11784.nha0.facebook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-261910-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: A7A711BA700
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:49:31AM -0800, Bobby Eshleman wrote:
> On Wed, Feb 25, 2026 at 09:31:48AM -0800, Mina Almasry wrote:
> > On Wed, Feb 25, 2026 at 7:14 AM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> > >
> > > On Tue, Feb 24, 2026 at 05:49:42PM -0800, Stanislav Fomichev wrote:
> > > > On 02/23, Bobby Eshleman wrote:
> > > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > >
> > > > > binding->dev is protected on the write-side in
> > > > > mp_dmabuf_devmem_uninstall() against concurrent writes, but due to the
> > > > > concurrent bare read in net_devmem_get_binding() it should be wrapped in
> > > > > a READ_ONCE/WRITE_ONCE pair to make sure no compiler optimizations play
> > > > > with the underlying register in unforeseen ways.
> > > > >
> > > > > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Looks correct to me, and AFAIU Stan is right, we might as well
> > annotate all the reads of ->dev as technically there could be a dmabuf
> > uninstall happing concurrently on another CPU. I also think it's
> > probably good to annotate potential races.
> > 
> > The ->dev write in dmabuf binding doesn't need WRITE_ONCE annotation I
> > guess because it's initialization, it can't race with any reads.
> > 
> > This makes me wonder what other fields in dmabuf need annotations. I
> > hope I didn't miss many more.
> > 
> > I would add this is really not a critical bug because
> > net_devmem_get_binding() is in TX path, and it is more than fine here
> > if we fail this check if there is an unbind happening in paraller with
> > sendmsg(), but it's probably good to annotate potential races anyway.
> > 
> 
> Sounds good. I'll take a look at some of the other fields while my mind
> is in this space.

I looked through the other fields of binding and binding->dev is the
only one that wants READ_ONCE/WRITE_ONCE AFAICT. Most of them are only
modified after the refcount hits zero (dmabuf, tx_vec, chunk_pool,
attachment, etc..) and I think binding->list is protected by the netlink
priv->lock.

