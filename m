Return-Path: <netdev+bounces-267540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAFCBvtDtGk4kAAAu9opvQ
	(envelope-from <netdev+bounces-267540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:06:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3DA287CE8
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4579131D1538
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1A63CA48A;
	Fri, 13 Mar 2026 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PehQkiI4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674F39A04F
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773421171; cv=none; b=NE3nIK+h0Lk2BSURdLlIF/vh1O+gNjEltUlTjvR8yezdfrpEbrOBRFavY6R1iQ6200tgRf88MkJ1Nu2U/joqjOvkGycA3nTwWC83qKgHshTAgkya+drO1X/hA2HQHFcSRopE0avdpRAc/GBvMUEU0MY1ztxB1X8y/vQecfpbT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773421171; c=relaxed/simple;
	bh=ZtCcl/BQGcxN/KUZGbuRltnqiIZdE1BNslevOQGWgSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRcgQQjRyQZ57bq6Z4BsBvZL+SG7kPzCd1gEdCQ3D3j1MxwCmHO8zn5K3TTCQfNi8uJr6IK2SoE37o+K/TxDrb8mYg5h6XijavN+iAYV0KryGLq4UISdu+MkCEe+SNNKWFAUFPdXtT+4zw/7tZwgoixp3SpA7GcpWyuvCM0R/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PehQkiI4; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89a1347051aso25986366d6.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773421170; x=1774025970; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=23vNKRuSFnFOzf5hO6ZBoQlegCCAZzuo2j5iFmnbc5A=;
        b=PehQkiI4M6Jd47dJdNiK4ZLpmpbRRoOAWmvfoehAtix64kyfPIt9T7FFN0IRc+ycUs
         n4vQbLjq+2guHsmefuI5RlDxSwngphyDF95e4Mt7gI3j2s+1ZffqdHV1xk1EMwHfbyAA
         qznKFepOXmTz82YsZVkgQgTMP9ljWjFXH4W3pFYk8o8TSJfQ5SMALHY28jOJp9fM9rx7
         2ukcl66e05ePXuU+frU8gUxrJWbXkrZx7lMkCQgl0LwWMzFmHsHUivqZD26nwuOsO6wR
         1T1V72GHAty9EA54Il2rQE1OP/m/+Y4Q9PhepBm6eU7DI6NIF8HlbT7aeXRRiwYsFivm
         UH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773421170; x=1774025970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23vNKRuSFnFOzf5hO6ZBoQlegCCAZzuo2j5iFmnbc5A=;
        b=iWgTUBa0hh4DldC5+Aj2b2M2nebKURLSut8Tg1fpICjdYXLg0RXh9qHbloS9L4gp4G
         CQf6pdeH7UXyyux/6vfxm4LI3t5Ej0dTwVGyYf2Eg0EpJuvdA91aoXrt1oOOA6oG83+r
         88AEBe07NZnxTCMOQEfw2C1OO/2Qt5+oqUeIL/gndfl44JPuyuGc1Tak0ujUxayX5vrx
         tkSzHnsHQuHf2DmOMNt7kUh17sdAQHfaltH5nfTcL4pE+oHoUogOwpDff7zdR/cbhSWr
         BCJvGwD0ZXZPx2UB5J+CaTVlLF8LsRneNF85JjzgwUIP28/g5Kd7yvrVvkqVlgwtTwS8
         CDgw==
X-Forwarded-Encrypted: i=1; AJvYcCWrIy1WJJgypfp2gKw8G8ZfHWgnWBW9gFmJCEH7yYHLYLBIthpxciYQqUCNAhgw+ctZ9BUL460=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIlwqCM0g11kzKqkOORIQhnbEhFF8LXEvtpofNeo67dipzhfw9
	FxgMszCAnct1OWXJGdlyR6JIJw4UvZP08Y4KSOOzUJBwPcfBkSH0Elsf6gh4Zx3Hcfw=
X-Gm-Gg: ATEYQzw9Y6IQLpbcRstPPx4UQtIRd2ABdV+KMJCPv2tfg4zkhmpt439pR3RLFYZwoxI
	Cdn8BbMmkEvTZopIXKEtNrKK/z1WsRP8+RWWen/W+6At7tiijQUl21VWUtEbdp8rZ7vNl73Fh0P
	mlHmELKYpFwKah7jr8+lxtstvzJAN5rywwkuQiOhjRevF00DrAEohPdEuEFqZI4TVGSv7m3aJ/2
	QhiQ2Te34Ns4+n8DIoJA5MGM0Qqx/mFDuS4gkaXIXCQHhMTkhxkcvF8MtCXbUol4atYmdRoutvP
	7p4zf6EtT+sl9pYwrbeWF11mBGllIUQxW2oABSn/GwuruAmL0K3EmuCEgkbWEwptjNJo13TQi3W
	swErWDOghc6JB4lL/umtWu0l6Ys8zrQbBW6Rud7Zg0Ksl5i0bwu2DwPjWbCZzhtGppI6rTw0QJ0
	/B3D2/Tam9Yog4MH03CEYWJ2S8H315UJjwDhaAkcaCBUZusCi7CjtLMSfYJFLSpFVGkiGJcxrmV
	jTnamDG
X-Received: by 2002:a05:6214:c2d:b0:89a:622e:d334 with SMTP id 6a1803df08f44-89a81fe1ef3mr64802856d6.48.1773421169725;
        Fri, 13 Mar 2026 09:59:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beb4besm60515486d6.15.2026.03.13.09.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:59:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w15rE-00000007Jg3-2Wt2;
	Fri, 13 Mar 2026 13:59:28 -0300
Date: Fri, 13 Mar 2026 13:59:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 0/8] RDMA/mana_ib: Handle service reset for
 RDMA resources
Message-ID: <20260313165928.GH1704121@ziepe.ca>
References: <20260307014723.556523-1-longli@microsoft.com>
 <20260307173814.GN12611@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307173814.GN12611@unreal>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267540-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F3DA287CE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 07, 2026 at 07:38:14PM +0200, Leon Romanovsky wrote:
> On Fri, Mar 06, 2026 at 05:47:14PM -0800, Long Li wrote:
> > When the MANA hardware undergoes a service reset, the ETH auxiliary device
> > (mana.eth) used by DPDK persists across the reset cycle — it is not removed
> > and re-added like RC/UD/GSI QPs. This means userspace RDMA consumers such
> > as DPDK have no way of knowing that firmware handles for their PD, CQ, WQ,
> > QP and MR resources have become stale.
> 
> NAK to any of this.
> 
> In case of hardware reset, mana_ib AUX device needs to be destroyed and
> recreated later.

Yeah, that is our general model for any serious RAS event where the
driver's view of resources becomes out of sync with the HW.

You have tear down the ib_device by removing the aux and then bring
back a new one.

There is an IB_EVENT_DEVICE_FATAL, but the purpose of that event is to
tell userspace to close and re-open their uverbs FD.

We don't have a model where a uverbs FD in userspace can continue to
work after the device has a catasrophic RAS event.

There may be room to have a model where the ib device doesn't fully
unplug/replug so it retains its name and things, but that is core code
not driver stuff.

Jason

