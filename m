Return-Path: <netdev+bounces-277468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GBvH5Ye2WnVmQgAu9opvQ
	(envelope-from <netdev+bounces-277468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:00:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CAB3D9F97
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 782BB303491F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DF23D903B;
	Fri, 10 Apr 2026 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nZWgR+OE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3563ACF19
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836147; cv=none; b=R/T7H0jnhSlGa+Vhy7sXPaIJMlF0d1kr5r32bKnSm7KYq1d49QEaT2nUgBdvvq2jecjMEDb2vQTKan8AXYeZc6xWh66RrHxuFZqHGoub0IOhtjsgT+yToPgL/xBD4YmnwvSdpFd0Ps+RYR9gIg83UfTLS653zGaEyqkcgPaOcys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836147; c=relaxed/simple;
	bh=0Q0+8gWU/OnHPwUzDqNWTjffaSeWf0ubCqA+tJYMO5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYTOGUwvmyL+P2kD2sJxhGxHJys7Errng620ZV8JNWwbSSP2gWbIJANwnYBLg1UjoIRmR3ckhb/pQQS70ecJIhOUiSuU9+9aMwKlaP2tGY/qa0KgtEAsecTQitsWFPrf1weRP2+T/s4AbJjNwk6Bqlv9E7fbZ2GQYgOTcoyRwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nZWgR+OE; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cfd44fa075so255931885a.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775836145; x=1776440945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ObmojYrR1bT1z5x62+Qhk3lWqZ4Kveh/kQz01OPOloE=;
        b=nZWgR+OEuOvD0Y8zTsqOexDYJ2I3U/Tv38Yw3J6/b7oGY5Q+FHq0gJsjYxOIImYqwI
         xTmZs/g4Pjm9YNNWOzW9LUTKpp80ds8/SrUw659aKCHxJ5FUffs9qffTDZT8NANKzNxk
         RFf8Q67PcKe7S1xy7jIlNUUzD8/vShrr43pJXQinAOSYzxtQtHLR9mF8N0scGlDh+BwI
         GFIde74szTWdOqLjibq4Sh2Oaw7MQX2WKDajZSKr423oTrFb1/vXXrH9obGGFK+uZ1jq
         h+bXt3KvpXqLLheGZUHNgtZewOsEPBPsBacKOO9aC7VzDaNilT40ATxTnmeeOmtrHox0
         z3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775836145; x=1776440945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObmojYrR1bT1z5x62+Qhk3lWqZ4Kveh/kQz01OPOloE=;
        b=lrQDnDd5bYxq7fgcpg+7QQEsvu5J1kpS3E7RQN21ACgziMCkKcK2NpihHmcE7Z8h2Z
         sEuG0CBUON0eaoSfB294/bBXMxybHQmiDM8R8QDmLuTnn2vA6G7g5qoht+njR5C9WGAK
         A1LS6mZjaBj5XM/EhnOgi6MWjE4XFPddYxryxnfKfVqcZU1KFDWuadu5/X8/77KqcooO
         Wi7VZ+ZVL5OcRxAX160Vpt/dvlOKV+yDS6b8/AdSZPe/D6CXmGrmdgCTObau8iypSo9H
         hIW3ThoEbbvBaFzopgm9iT734qrT4DDm0zLyVpbgQtEikpI19jxeJLQcPS4r/AAGDdVZ
         P0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDaqI21UpYs+mk7oJQcSmhFyx0kxmMgnDtKFWWlbQzIXXMPnfS0l4JDSPDIH8fLRJp7d3azqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytPom4UCm7R8ceTwZXc/yxqC4b3DchnTlgsFYVn7odZb70ESrn
	7t4sWUlrckrz6qJKJO4nngkZAoy6IwR1UzN5l3oM6yUlb0vxPuBRNYpJAKTRtgYOcis=
X-Gm-Gg: AeBDieum/bmYLKnUG4bh/ikIWOZ5K30DoNoi75HuW5PVpXeiM2t8bc5PGBmksesZdDW
	ilZsfptorVDL2eNlKmqnyZvNq3XQ1lurdWPk5YA6zXVKjRk8LCy1mtc3KJ0vdQg1LnFec21B5td
	83MLPujrzptKMddg5HhYDv0IRU1q3e4TeA/5AwJqQlZomvPnH+pYrWz0NxOQyJhqG4WYJbHg/gz
	zGAlpKeKHwrzZhOCoLKqQyLALdQMskUWxx/Uln7RE8g8xv+cg8AGR4qckk8idWpw4RNSU4jIgcS
	67OkPJ3hMzI8H/WAB+otv4iKfWRIVTFTcONJY2MoKbLTwC4Tj/vV3jbGD67ndBsc1WM1rRGWNSG
	9a0urVCxe+RsJAz8+8fzrg2b4D2a0p99XuevyWp/Jzbj7aI7FucYdw9eY6BFnZ3f85R1W8+GP6R
	2NcyfWtb8o73PHDSZJ0qIVES68hNnJ387fO32WNp6JUsV9O2qTFC72gPoTk8cEU1k59OyZsQ==
X-Received: by 2002:ac8:690c:0:b0:506:8738:651d with SMTP id d75a77b69052e-50dd5c6c83cmr59257571cf.62.1775836144664;
        Fri, 10 Apr 2026 08:49:04 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd5cde374sm26640791cf.17.2026.04.10.08.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:49:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBE6R-0000000Ejyx-0q5y;
	Fri, 10 Apr 2026 12:49:03 -0300
Date: Fri, 10 Apr 2026 12:49:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Long Li <longli@microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <DECUI@microsoft.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next 0/8] RDMA/mana_ib: Handle
 service reset for RDMA resources
Message-ID: <20260410154903.GB2551565@ziepe.ca>
References: <20260307014723.556523-1-longli@microsoft.com>
 <20260307173814.GN12611@unreal>
 <20260313165928.GH1704121@ziepe.ca>
 <20260316200843.GK61385@unreal>
 <SA1PR21MB66832D0A369DE7E411ACCDEDCE41A@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB66832D0A369DE7E411ACCDEDCE41A@SA1PR21MB6683.namprd21.prod.outlook.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ziepe.ca];
	TAGGED_FROM(0.00)[bounces-277468-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21CAB3D9F97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:43:49PM +0000, Long Li wrote:

>    Today a DPC event on one NIC kills all RDMA connections and can
>    crash entire training jobs. 

All rdma connections on that nic, right?

>    If the ib_device persists and the driver
>    recreates firmware resources after recovery, raw verbs users can
>    resume without full teardown, and RDMA-CM users get the same
>    disconnect/reconnect behavior they have today.

No, I don't think this is feasible. There is too much state, the
kernel cannot just recreate things and transparently keep going
without userspace handshaking this. IMHO It is just the wrong model.

We have always gone for the model that userspace has to be involved in
the RAS and it has to recreate its operations on a fresh new verbs
FD. I think anything else is going to be so complicated and fragile.

I can't see any sensible way an already open verbs FD can survive a
device reset.

Jason

