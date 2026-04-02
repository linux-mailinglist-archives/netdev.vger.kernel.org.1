Return-Path: <netdev+bounces-274329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOdfIM/WzWn1iAYAu9opvQ
	(envelope-from <netdev+bounces-274329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:39:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9A7382BF4
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83056301D24C
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 02:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C732C937;
	Thu,  2 Apr 2026 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFGh+ujb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE4D2DCF57
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 02:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097547; cv=none; b=Ysub6Buvw/ATl3rLz1lgRequw1sedt0ExqAIt1nLqBJ5S9/xAZA/lJLSjeq5UN7aBtSaxvbeUh6teIUXjnSnsbku0qTdiVsDbBY/Ioin1guyk8iDhe/AE7b48RUq1vg3T1xwn/EK0evJ95yazpuOXeKq6u0GT4qqh8t/DHW7uqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097547; c=relaxed/simple;
	bh=rP3OCwKh0lVTegcUNdRph1Tl7P92pvs/YeO+oqqsPqg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bC5yECgwgh6Ub96t6+qmCIgDvVL0j84Mx0+jKfJ2WQwE01Y1TRxeQrq410yAIk93osT7E8vbpVfA6oeHEKgLP3I1pbE255GSnmpODNg+H3wNBoJ8cY2/QXOBPXDblAB3eWo4ocDlGyJ7QUvSpdW9rNVFQBQoFEb0Cu1Xu7+oe1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rFGh+ujb; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79db5e18ac6so15705957b3.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 19:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775097545; x=1775702345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzXpB61GlnOdnCfwmcSsuKY/d401ddyF51RX6eWxhuQ=;
        b=rFGh+ujb2vfrAEVU/jtuBVSoEroD/786ge030JK2hYecINol6gAekexavzdDeGjesZ
         gtFqLT87HBLDY7/Rr7sGkOCX0mrnISntki0gK8n+Aky2Zo0aR1F764+qitx6ZjH3tzVx
         GuYY/U3IplL6NVDEToPrd2uYAolUJokAJYiyiZ9ezR8bmN6ozPjXnE2YoxkCpTCMfCMk
         nKO04esbi8or8J4tTCc4cQdnZlYd7EPSeiIdx9uA6FA+5sPAv8WNOsWnnSflNCXUP2c+
         b+gqgImupVFS+SqJwQe5DL0ZOz/lt2AurRVxBbtMT0Frjnr0KNKLijdnoNhh32wsDqD9
         M4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775097545; x=1775702345;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uzXpB61GlnOdnCfwmcSsuKY/d401ddyF51RX6eWxhuQ=;
        b=iqnS/DU93bsNsXYpbVxu5KAdymAD4w/4iujUbJmtyOpLH11vInlroHBvbMlZ0mgo7o
         0IlbhSO6LmWru+8c14qN0uS/XX+bsbKite7q/eVfkC864qKbJhI/kT8OtTsBCSJv0IBA
         SuemN8JuwfdiVkil90CBRTKbSglwOuYGP2az48cYCHNYxvbqj6g+5JPSWKT+2p5ekMrn
         Ve5acVd3m5KpIKhXsTZoLBrjGXVtaXsD0hZmsJYN2R8sHe114AKE3QubXuRb2MlXjgve
         vKAyjTS6NMWG/zL9ryH4y6/IjaexJLZLcakpbGCg2h5D9QZJGPuvgkM4H+SrEj26n0fX
         tqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3jM9qLFoRHaY554yjtKqJolfFRCzBVcpBxw1K9rSVPABRAIbe84AEr2NjoUxMAfMlBNrSKuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZOLLXUlbiJTyiX+gkho4c+KohbGFLXKdkOoQ8zGG04ptl/1L
	hoyxHn+ru4wgSPRbknzSgjjLHu+w279fTxKW05ZIYkeejRluhe3x8Qlg
X-Gm-Gg: AeBDievkDJmxHwOC4wsoQDnKjDalhGGKECWZzQfrcx0ntU0jZ8ARKnNmUN/PGkTmciu
	xknKb7aOXi8YnLyJIK1TSCvrZJzQi4cQGkzM/B23PMrciCRVZsuqb69cQdXa+00T+FO2ub0JKxQ
	PbNAeQ0fubW+tRVSNey/BHsmeEweG//6A1qfMfWvOYSPtIWE/SXjSZf0fX98kxsSydREioy4eJj
	PYTfduiV4HRe70x8Kl6cXqiWC3m9MxEhESIRogF9qqj9RReGtWNDpTCU1ne341xPP4GZDVI8hnm
	szv4oVyHXcyrpdVB0JR4LtZnTtPQUhOqUoyHEoAAodsDko24b977RNlyQPNfJq65ymUyI7bgAfF
	WlHzOH0nMFs7vcoz8NdlcVixwS5PdZI8EwU1NSkV7QNjFo4vlr9u1zupxY5WNAy57c7wMUhfeoH
	InvsCHD5m8G+/dNeXUXGgqdT1XH2+jICvBNswu4n85exIEirlMzHKNbgChJJpwNmKjcfk0Qi+sw
	LyJBKiD0uoNKlo=
X-Received: by 2002:a05:690c:3481:b0:79a:b440:5c8d with SMTP id 00721157ae682-7a3bc302170mr5926717b3.11.1775097545266;
        Wed, 01 Apr 2026 19:39:05 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370905079sm5509607b3.23.2026.04.01.19.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 19:39:04 -0700 (PDT)
Date: Wed, 01 Apr 2026 22:39:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 anubhavsinggh@google.com, 
 richardbgobert@gmail.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.123ec4c7f938c@gmail.com>
In-Reply-To: <20260401191030.23104696@kernel.org>
References: <20260401182625.372605-1-kuba@kernel.org>
 <20260401182625.372605-7-kuba@kernel.org>
 <willemdebruijn.kernel.14f444719030c@gmail.com>
 <20260401191030.23104696@kernel.org>
Subject: Re: [PATCH net-next 6/6] selftests: drv-net: gro: add a test for bad
 IPv4 csum
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274329-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C9A7382BF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> On Wed, 01 Apr 2026 20:28:46 -0400 Willem de Bruijn wrote:
> > >  	/* ip sub-tests - IPv4 only */
> > > +	} else if (strcmp(testname, "ip_csum") == 0) {
> > > +		correct_payload[0] = PAYLOAD_LEN;
> > > +		correct_payload[1] = PAYLOAD_LEN;
> > > +		printf("bad ip checksum doesn't coalesce: ");
> > > +		check_recv_pkts(rxfd, correct_payload, 2);  
> > 
> > This verifies that a packet with bad csum does not coalesce to a valid
> > packet. Perhaps too paranoid but, do you also want to test the reverse
> > case?
> 
> Will do, easy enough. Tho TBH I can't think of a case where this would
> matter. Bad csum pkt must bypass all GRO processing completely right?
> Because we don't want a corrupted packet to flush a valid session?
> Or you think some implementation may actually feed these packets into
> GRO to avoid waiting for a session timeout?

Interesting, I thought the opposite: this would flush an RSC context.
That's also how the OCP text is written: "An SO context closes if a
packet matches the flow, but not the other conditions." 

There's a slight subtlety when sending three packets p1, p2 and p3, of
which p2 has a corrupted checksum. If three consecutive payloads, then
if p2 bypasses GRO, the other two are not consecutive so will not
coalesce either. This is the likely case for a real bit flip in
transit. Only if p2 and p3 have the same seqno would p1 and p3
coalesce if p2 bypasses GRO. That would be a weird, possibly malicious
packet, which is not much different from other TCP injection attacks.
Which have more serious consequences than coalescing efficiency. 

