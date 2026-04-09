Return-Path: <netdev+bounces-277056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPS4MsTI12k/TAgAu9opvQ
	(envelope-from <netdev+bounces-277056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:41:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9562A3CCE47
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C088E302ED64
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7933DEAE6;
	Thu,  9 Apr 2026 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UOdYSeYx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B05348453
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749095; cv=none; b=k0d5zydfbch6uEU6IPffslyEs7t3gCpx1y7rbSnPhALN5JFdgqQtn5I+UUpCak8PReSAoCCm1zF6gx/1fuf1/1QsreFyU+3/ZybgVPpc1ZCcUNGUUGHDxCprkL2LBS6pDAt4YqllU1nO9WzL7LX/hd1n47cqoTpWW0YcBKRwKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749095; c=relaxed/simple;
	bh=PqPVYuoHcB9VbWWRLwQgWRPkMClKIoD5tzzfx+rg4LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=squINQOMhjZWuaLMfxWuZjsLpHdNzNHyC5meJ8gyz8Ip1WXeZ3X67uToAQaMjeptwySPC5SVL8CqRpq1J+CjXnyaDLTAjRvdYM0DNlqhHssrWfD3f+x2NwbVztOgiht9X47F8sIbVcKaUrwDJppXb8FPbD7vx2IQe6Jv5ovk3SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UOdYSeYx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so1456004a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775749092; x=1776353892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=umW1IQdOAOPjgPj9z57AnteG7vvMbaLS+TiyzZ/vV5U=;
        b=UOdYSeYxBkrY4xXeHsU2BtzwnnUs8iRhJnp8SsbNVNMj9b4Mzkq/kF4accTlBr2y0u
         YCBni/Jp5wq2IGej+vSZOSS7d/7aTKNlbzYird9r46gLLDZrzZINeHbQZOhPSF0crYcU
         aJ5u0wLqw8Y4fesAnL+vAiIKCh5xzvJ+3CvP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775749092; x=1776353892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umW1IQdOAOPjgPj9z57AnteG7vvMbaLS+TiyzZ/vV5U=;
        b=n+rCf9coND9C1zmGKH5w+JYW7JpaYqkvO+EeMQ5T9UE1uR87EpzrKH/O1Nzybv/l0y
         QHvL5EnxbTANewr/aAN47WZCM4gfhbEpzAJOOuXaXrpT78XRIS23nCF/H+HNyZTaP6cf
         WSqwNoB2ogEgH6yZXpGUCvafeNe+qqILNkKgPFZhgZ5HTWsiCyZ2dthdMw8RCRiUAibn
         9W50nGcLm5R28AJZNDeZSz6m2Cg6Zk/oMsSSRiDBwWjnnvyert/UhWrpHTyUVBMv1nxu
         gAUwSpd1czURBAjruvjmEBznMqnGb7jpgW+MM9yVYdsVQnH7KS8x9lOf1vCU/tuomOOs
         Kwag==
X-Forwarded-Encrypted: i=1; AJvYcCXw7otpem1LGy/2HO4avtitlYiUqHXOx2F1w3PBPualOi65mtb0G1hSpvKSyZEoEEnNfkwZKqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjNJwYrodrmTg5CpTdcDWAx+wLKwZz9JNh6iV5YsD06P0x6ec
	2M+Ov+OLbCN74H1LIdklUGX2NPuQXo1KjTK9BzYPUG5KcZjyaJe/SUwp14yrEfIP2h5iJXL5Ybx
	Rz9x625Y=
X-Gm-Gg: AeBDiesb3AAhTrwQqkCsRWdoXqODJ6RzUFVlymn1WUlP89ui3J47+ITnwzpYZm8Po6k
	gg/HYDJjNO1dW9iLA1hVknEmP2GxZFptmYNvSZdFYIYUPeMHjJo+L/5knc/F1UeVAxCjDPi+4Fx
	ZsLFWPl4DIT1Je5qiUfXbXgJBiOP0O+/kZXBTSZgpsPZDENy8fzripVsyltMNLGc1aGOxnlh0e7
	3XQyUETAjpJ3dIh6sRJcmzpeN4mHw2P8JC95psvm+ykqIVK0g52+l2sB/PbuRZWQDAeF8Svo2N+
	p1luaOrQTdfxbPy2ijJUOkBIhcWdmHNhOCJDdDU65K8sc1grVJOoXgq21HGQ5RYLmhp7NIRXpTD
	XYNB7OyYIyakTYpp1nBMeamhkJL69ftYZF5FbLpMkLFlBAYHg76I8JnjGwdFoLG1jo24aj5MgFz
	NqhIK+WzDv/dc2rc9gKgoFBfkq/6iaAsD0V79bidsKV9DVXrRJuUS66t+MKTs5Hc+NflfIlbI4
X-Received: by 2002:a17:907:388b:b0:b9c:b3b:841c with SMTP id a640c23a62f3a-b9c6797f6a2mr1315498466b.47.1775749092075;
        Thu, 09 Apr 2026 08:38:12 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c5824sm3191966b.38.2026.04.09.08.38.10
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:38:10 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9358bc9c50so150593866b.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:38:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQuDO9sF1nWmRpW0lN4RJ5W2k+CyXK6KuOHgulytLcH0+dh8o4Yvsk0dNzT6gvOJMYb7kM6sQ=@vger.kernel.org
X-Received: by 2002:a17:907:6d0c:b0:b9c:94a3:317d with SMTP id
 a640c23a62f3a-b9c94a3345fmr1104212166b.37.1775749090683; Thu, 09 Apr 2026
 08:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adZTGOjjJrVJOcT8@shell.armlinux.org.uk> <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
 <adZ9grUg71f518Fg@shell.armlinux.org.uk> <adZ_ZmjcE8S22vR1@shell.armlinux.org.uk>
 <3a1d0520-3402-47b2-9d7b-4e14a3cd07a4@arm.com> <adayAMR_dEA6W5vW@shell.armlinux.org.uk>
 <adeaiSAnkaggqPsA@willie-the-truck>
In-Reply-To: <adeaiSAnkaggqPsA@willie-the-truck>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Apr 2026 08:37:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whO3F1u+nme4cnYMy5baYmb7CH=wE63dcNaPLWD0vKaew@mail.gmail.com>
X-Gm-Features: AQROBzBMqgTUhWghYpRNIZDpsOWA443UoVRzdGjObC6SoT9V2ssj-2Muj4chrOs
Message-ID: <CAHk-=whO3F1u+nme4cnYMy5baYmb7CH=wE63dcNaPLWD0vKaew@mail.gmail.com>
Subject: Re: BUG: net-next (7.0-rc6 based and later) fails to boot on Jetson
 Xavier NX
To: Will Deacon <will@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Robin Murphy <robin.murphy@arm.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-ext4@vger.kernel.org, dmaengine@vger.kernel.org, 
	Marek Szyprowski <m.szyprowski@samsung.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277056-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9562A3CCE47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 at 05:24, Will Deacon <will@kernel.org> wrote:
>
> On Wed, Apr 08, 2026 at 08:52:32PM +0100, Russell King (Oracle) wrote:
> > What's the status on the iommu fix? Is it merged into mainline yet?
> > If it isn't already, that means net-next remains unbootable going
> > into the merge window without manually carrying the fix locally.
>
> I'll pick it up for 7.0 in the iommu tree.

... and now it's in my tree.

               Linus

