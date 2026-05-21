Return-Path: <netdev+bounces-290181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ja7IXNZDmo4+AUAu9opvQ
	(envelope-from <netdev+bounces-290181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:01:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF49059D79F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCED930AD9FB
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4346C2989B0;
	Thu, 21 May 2026 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVTWkfu5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7B28C2A1
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325111; cv=none; b=ryoIaTnV0zNrmCYzgZCcHzhXBDdzE/sGc0qmt0mRozlds+UNe5yEKQuAherKybI8fybzQjTwMFhFyDyskonu3c+dy4V6XketINYfUpoSM2xix3P4uTL4uFlOQftw9akvFIhB1NCS/K0It+oKcKtOemmU+VrX/NxZqZSnl0UseqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325111; c=relaxed/simple;
	bh=TlqusJpotS49Ur9UgNkVL68G6zPl2pzZ7jPe+rTCkQY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=D+Ab1bEPz5wFeVlMpGtJjb59rTXs33rIdRtpZP2jLRvwx+yDq3crq8lX5Fjp8D+5sMnwqoSAIovolPv7V0qBAfWiKgeRMN6QuRZADn6E/bUEU3QZmI/X3finSK3m7VQCL1n8K9blHmRgCwzgA1K20rRvtoKhVNuksxPfILgi1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVTWkfu5; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7c5d8f45465so52652127b3.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779325109; x=1779929909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVgoE2LhgkTLnz2IyN0M69nyDCsXq8idQSu6+3WdPfo=;
        b=mVTWkfu5HBcBOa8FXY2guP7cVGbnzRmtzFR7RR+JGY4VL2FXnVPPSsJ62MOINcMHNr
         iei8dA2S6xvfR9izwDM0mMyx+TvLyXm3r08C++3NVrlJZ2GX203WZda/qC8Spyhoxgkg
         xNzsWBqx9vzcQ39LOQbHdDFy5cxBqZ9dKWhpUi0hoWslehDVWvWVVcP5euyrly1ttudq
         TJHYUODFCvvlsKdqkukuI6di5UQQXUj7XI1g/uM/qxCk7jaP3HgiQSN7D6fj6d8xodpm
         I8mqZ7tI3OSJJlIIgYGWjL/H2bAOoYye5Fy0YopZi0FYpFC7c5GYj6qcw4Yxk2Tp5XeE
         qErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779325109; x=1779929909;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVgoE2LhgkTLnz2IyN0M69nyDCsXq8idQSu6+3WdPfo=;
        b=gfX+oGl0FIZOapIRz1SrAaUy9OhHfhm9ViFVFV2WtiV9oTara+7WA1B5V3sGtx1rHq
         Lo62gecFQnIbAWHJCESTPgU3ak24pCIwwjnFsd2T+DznME1lYZ9h2cW7tJ0AKQWTMLNL
         PTkdqY2e/r6EIOZoVUfjl2CL3skM4G4+6+vfw4/1VIjnfTNwmy2/vCM+OZZthYHmeKZ9
         1Wlr3lyCo2IQD+vTgXCklbpjReQBATabJ1DFSen4gZaSN46uxrlQKkeyOjV2AgOQhmHb
         ThW7t9cxNaHpICyBmERii6TwgF8+i/gQcZc6ilNeHX01lP5VMvfCeU9hpyn8+cCGLTQe
         Ll9A==
X-Forwarded-Encrypted: i=1; AFNElJ/IYl3ly2yvVEqL8jCBUDqQPT6g+z11DnIXRlwuqKat5KzYuMzNzxGBmz2JtJvbu2sMlFm2KOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCrnKW5WakPdPvjAPqSp4hvbd/DqZzjXBXKP7CybRUK3Y6Rwle
	a76ChNbC75MoJCdpXlxxI/c1NqfYvglDVmWEsFdYpdrhhUCQLfkv7NpecMhQPA==
X-Gm-Gg: Acq92OFuybJNcbbMdbrPiz9GOeqInSBb/O5WmIMfJDIKTWRtkAPKuzQnLBjmctgY9Y9
	2SHEJK3DHFapFFFlW+IZnIPOp7r0uw3tTZI6LjGUXmoyeUCpV3DiWFLPfiaOXE3UNBe9wEo27bM
	McqNJ4lBQIkYdoqYfsIfrBC5jPH6l03sKHv6Bg2I78F4csrB0lbiljzTolnhAWIn4SEQw66A4lm
	8wTWik9N4p+p6DsglzI4Rz3qXRUuLtq9xyeV5RUA66zSfFG70UzrLXc7i+eYud5GlQF1/hwvsZV
	IMtUB1+SUJ15whoyhEVhNC9EbibBOxToVtZXNXRYgEMeg/zdrGBo59s2JuMnd2/dRRmgE01lT+z
	01YwJJMtmiPkA+feNqnfN3IqmDmXgwwPMpi3k/kJfz739f+fTRPmuoPJBS5KCqaMjWcauN1YSmz
	zA/jNfYky5iYt4yfoBi/j48wPQVWjcJgiwg48gCK162Ib8iEAClBQsgxJcG0KMjyhRVNYRInIYf
	0IIvRMXfkRfUfY=
X-Received: by 2002:a05:690c:9b0f:b0:7ba:f2f1:86c0 with SMTP id 00721157ae682-7d20b17a777mr9219837b3.12.1779325108995;
        Wed, 20 May 2026 17:58:28 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0ccf7sm61477567b3.25.2026.05.20.17.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:58:28 -0700 (PDT)
Date: Wed, 20 May 2026 20:58:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Dongli Zhang <dongli.zhang@oracle.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Weiming Shi <bestswngs@gmail.com>, 
 netdev@vger.kernel.org
Cc: jasowang@redhat.com, 
 pabeni@redhat.com, 
 kuba@kernel.org, 
 edumazet@google.com, 
 xmei5@asu.edu, 
 linux-kernel@vger.kernel.org, 
 Si-Wei Liu <si-wei.liu@oracle.com>
Message-ID: <willemdebruijn.kernel.7526a484e05@gmail.com>
In-Reply-To: <3f4460b0-fd07-40f6-a9c6-827dd0ce2ff8@oracle.com>
References: <20260520160020.375349-2-bestswngs@gmail.com>
 <willemdebruijn.kernel.28580e8a2708a@gmail.com>
 <3f4460b0-fd07-40f6-a9c6-827dd0ce2ff8@oracle.com>
Subject: Re: [PATCH net] tun: free page on short-frame rejection in
 tun_xdp_one()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290181-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DF49059D79F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dongli Zhang wrote:
> 
> 
> On 2026-05-20 5:05 PM, Willem de Bruijn wrote:
> > Weiming Shi wrote:
> >> tun_xdp_one() returns -EINVAL on a frame shorter than ETH_HLEN without
> >> freeing the page that vhost_net_build_xdp() allocated for it.
> >> tun_sendmsg() discards that -EINVAL and still returns total_len, so
> >> vhost_tx_batch() takes the success path and never frees the page; each
> >> short frame in a batch leaks one page-frag chunk.
> >>
> >> A local process that can open /dev/net/tun and /dev/vhost-net can hit
> >> this path: it attaches a tun/tap device as the vhost-net backend and
> >> feeds TX descriptors whose length minus the virtio-net header is below
> >> ETH_HLEN. Each kick leaks the page-frag chunks for that batch, and a
> >> tight submission loop exhausts host memory and triggers an OOM panic.
> >> Free the page before returning -EINVAL, matching the XDP-program error
> >> path in the same function.
> >>
> >> Fixes: 049584807f1d ("tun: add missing verification for short frame")
> >> Reported-by: Xiang Mei <xmei5@asu.edu>
> >> Assisted-by: Claude:claude-opus-4-7
> >> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >> ---
> >>  drivers/net/tun.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index b183189f1853..f594360d66d6 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -2394,8 +2394,10 @@ static int tun_xdp_one(struct tun_struct *tun,
> >>  	bool skb_xdp = false;
> >>  	struct page *page;
> >>  
> >> -	if (unlikely(datasize < ETH_HLEN))
> >> +	if (unlikely(datasize < ETH_HLEN)) {
> >> +		put_page(virt_to_head_page(xdp->data));
> >>  		return -EINVAL;
> >> +	}
> > 
> > Make sense, thanks.
> > 
> > The error path from tun_xdp_act does the same. And the default: label
> > used to too, before a batching optimization was introduced.
> > 
> > Is the same then also missing if build_skb fails?
> > 
> 
> I also agree that we may need to handle build_skb() failure.

Thanks. Fine to defer to a separate patch btw. Either way.
 
> In addition, I think we may need this fix for tap_get_user_xdp() as well.
>
> Thank you very much!
> 
> Dongli Zhang



