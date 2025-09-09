Return-Path: <netdev+bounces-221365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF390B50505
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8683D5E6D96
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3169335AAAD;
	Tue,  9 Sep 2025 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="MEowf36t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hQyxjK6d"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687DD35E4F9;
	Tue,  9 Sep 2025 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757441410; cv=none; b=nJ++9UjGOvTK49JCZZ7Ci5NchzN3eg7sUFGc8JvSqU/ynckZSZVRIsNvM1kmViDdBK6qdP25NjnA/YVjQ8mhC2x/StZ89ZDv+HLBPbyeIaXt8adRNkJgaBbSNUF2XiwNs4O/RIRsYF9Cx8LArC/gUIkJNA2pzYJt6zypvwCWZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757441410; c=relaxed/simple;
	bh=1WfiXYcQ9DxGQzBNyXa1b+ATH91JkebVyqyf+y3+b4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHqgao1902BK26x1Fv6IBfp96UT2ce5+/zxdjs6uhJhWCUVo89WIm+Y8nEzFbQpmw9Jm52HhO1tuAYABenCUaDx/UVMv4OSxZKUTeiWrpFk6SlBXXVdvfqsfgeJmO+hLQaskRW0rZxPSnsceA675XqxtfU7t82FL9aZMl5wbkE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MEowf36t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hQyxjK6d; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7BFA21400077;
	Tue,  9 Sep 2025 14:10:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 09 Sep 2025 14:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1757441405; x=1757527805; bh=le/lK8mLuhjbFLfZDsOm1kwSbZZOkQC+
	xNBDwVJ54F8=; b=MEowf36tFPlNVS4TJdzkKEkaDWRbcoBs7PvG4mxU9ijmhYb3
	DtVy4nUs7+fZPCVB58mzQHpXP3GAWhU58K+1jj3tnDVcX1s5AuKiP/4fjg+WDnyK
	IOANr5xdEktcOEe8CjWnwbRlQ7aFdnWrjarOOoQqMqF+SA20v4ZJRJlH2+gZJqpy
	CWRHEddzC/mh2XYOSUK+toHRD4HXcT5jKB3i7CcLkzS8yTJPyssQIRTb9tn5ea+S
	K3atI/oQ0GwDPJGXhMPEu6CgJhg4I3fvayMbXXNgWBpYM4RW8AFXJ8F5Ovvslc02
	CzP33tZAAH+IO9P6fGPzh+KoPxsGhLZmnhDn/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757441405; x=
	1757527805; bh=le/lK8mLuhjbFLfZDsOm1kwSbZZOkQC+xNBDwVJ54F8=; b=h
	QyxjK6dlQoxutmlUpMYu/2Kav4r1iZEZmL+AMoE0DPmhrQwDHUrn6/LkQU3HQHuU
	+ucmXZsgvFPwycpDURl7Pa7LwbVZrd4LC8sY4fKRixLESSdsNxtSFpbAPZZ54Cqp
	c9AX5xnPHz+UGZhcf8AMph1/LDqlgvXT7CUdwmHN9dD7CRjQvaXVINhax5n+8B2/
	TwvptSWaHK4v8BM9YIj+/rVcrCugqWx8oyE6Bq7un0I7drFkFNwb5rc0S8pCwhD+
	yR+YE+gLAOP7/N3ltd+QBCnhaq+ghPmmxlBUUdCxaDC7qZZ7tnRdngskdlSMqcWw
	GqXHzA4Jn1OfUX8B8BUaw==
X-ME-Sender: <xms:fG3AaPndiZZvY2KsEo-IO9r-Yo1NafrmA2xL_BOjvm8EgJtHYyOnBQ>
    <xme:fG3AaAUcm__8hmjymCK5tdZV4DARxr7zzXSVCTkPqyuHqkvSSjTg9zzRaCmsoKnNK
    lA6lyxMs4oKcdIsCxk>
X-ME-Received: <xmr:fG3AaIRfmfg_4dyDuK8POGr9sFvDI4vogOdQINpmr3SPlHxWxElo4QNTo7WW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgfdvgeeitefffedvgfdutdelgeeihfegueehteevveegveejudelfeff
    ieehledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghsthesfhhisggvrhgshidrnhgvthdprh
    gtphhtthhopehjrghsohhnseiigidvtgegrdgtohhmpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhhuh
    hnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:fG3AaNCQRfIhDT5jto05Ke8hRI9TbHELJ6xms4rMKWsGqZfp4CJ4yw>
    <xmx:fG3AaAvQ-bfFmhhOvAIlaPj5votbaiHnoNnCoYHNSwE0ZlRZ14zfPA>
    <xmx:fG3AaL_-1Tlct-_UNXxEBrHqCsbRvgLs8JJZ_6WKBPDdY0wi72Y_eQ>
    <xmx:fG3AaHRQL_sa5jxSsxbUNpY8AsjlJaR8oncaoQS0WGcpmdzslGKKUg>
    <xmx:fW3AaNdttPE6D-MVg_npUKs8inrXT3X0SDUeQlKiVuD9LYlEyHtVPj1S>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 14:10:03 -0400 (EDT)
Date: Tue, 9 Sep 2025 20:10:02 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/11] tools: ynl: decode hex input
Message-ID: <aMBteqR5KP9KGcc3@krikkit>
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-10-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904220156.1006541-10-ast@fiberby.net>

2025-09-04, 22:01:33 +0000, Asbjørn Sloth Tønnesen wrote:
> This patch add support for decoding hex input, so
> that binary attributes can be read through --json.
> 
> Example (using future wireguard.yaml):
>  $ sudo ./tools/net/ynl/pyynl/cli.py --family wireguard \
>    --do set-device --json '{"ifindex":3,
>      "private-key":"2a ae 6c 35 c9 4f cf <... to 32 bytes>"}'
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  tools/net/ynl/pyynl/lib/ynl.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
> index a37294a751da..78c0245ca587 100644
> --- a/tools/net/ynl/pyynl/lib/ynl.py
> +++ b/tools/net/ynl/pyynl/lib/ynl.py
> @@ -973,6 +973,8 @@ class YnlFamily(SpecFamily):
>                  raw = ip.packed
>              else:
>                  raw = int(ip)
> +        elif attr_spec.display_hint == 'hex':
> +            raw = bytes.fromhex(string)

I'm working on a spec for macsec and ended up with a similar change,
but doing instead:

+        elif attr_spec.display_hint == 'hex':
+            raw = int(string, 16)

since the destination attribute is u32/u64 and not binary for macsec.

So maybe this should be:

+            if attr_spec['type'] == 'binary':
+                raw = bytes.fromhex(string)
+            else:
+                raw = int(string, 16)

to cover both cases?

I think it matches better what's already in _formatted_string.

(I don't mind having the current patch go in and making this change
together with the macsec spec when it's ready)

>          else:
>              raise Exception(f"Display hint '{attr_spec.display_hint}' not implemented"
>                              f" when parsing '{attr_spec['name']}'")
> -- 
> 2.51.0
> 
> 

-- 
Sabrina

