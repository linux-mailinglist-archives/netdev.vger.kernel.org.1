Return-Path: <netdev+bounces-259364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFivI9k0lmkkcQIAu9opvQ
	(envelope-from <netdev+bounces-259364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:53:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE715A6FA
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86B4F3019051
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 21:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B152F1FED;
	Wed, 18 Feb 2026 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCxwxpqH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A367F3EBF10
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451607; cv=none; b=FCERJrjOs2m0af/PGuDU4vHocacsP1+T+et4myx084GEJ92U38AjfdgjpHvzNtR0V8ZeidyMvvQTATXyoY6AkNeJJXdvVbQhBfkVB9VhfFYygfZ+s/m8oSSHR+p8XBNbf4guYav6hOBuyAYsqJ/jOgso1Mc5aED8qoUZBdCSj1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451607; c=relaxed/simple;
	bh=187Sg2rWcOEMsHm5jtTm1F1qf2CktxIiYoS5gzFIsC4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PX3TK6yeUmXIaCedY/1aC6G4Jgz5Eu+Htx1HNh084xe5AFhH2HpcQvnM/WmQmy3juOvE1OpaQ9NrAYaUe2pxMu2xezUpFFMHeQa6ype+MEKZTd9XhHIDHGX9ahxpYVBvLMX6irszA48YqCPDx4eP7OZ0h77MnRYdysjGRRNHSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCxwxpqH; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-649e97f1e1eso200434d50.1
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 13:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771451604; x=1772056404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GsmHND0uAK3+t3Vppv5wGLyAd7fEv8Sr7M0eIN1tfo=;
        b=SCxwxpqHFv+sk3fx8KOB3lJk62GBCpGAoENEDGoQa5dk39SwcJCf6mtjCJEoEExWoz
         UogUWz2SpIBr9p7dFeIBmQgyndDC5KyTmE8lDHsOeSIwsMGCCdl7ZlCyAfHWdO83Nbw4
         MTu5c1qSsoNauGhqHr7hrKrqDqPoWSXXjDBHtGuFYppa0DzfuIDigQ/xiW+W1ZjZOolP
         RgFi2cy6Y97S2U0EFNzCZGyERa3T7YhUSEJZBMkdYJuzJzLHXCIh9KNe6DkpHPnAWATT
         ij+PM3heKJW8rh294qvdmQY5VOGPwegrVPS4sfyb5HMq2bz49uIloTKEbOHIvfANDDYa
         a8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771451604; x=1772056404;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GsmHND0uAK3+t3Vppv5wGLyAd7fEv8Sr7M0eIN1tfo=;
        b=cq6j337uA2RQP6kUgcQgu/5eB2dhMWG7j15fdWk+DJMzDVZBDZLMiqRd0Pdkw/fbt1
         TcYesBmf9b97oEbWstXo5zGkRMoMpt9bfbxSvEg80atHLLG8us2jUW5zF5ZgrE9JgzaJ
         Fmv3YZdzRRyf77FEeZU9mxKwXDR04l8LSKDhlQvmyYQloJvSSl6p11ZTUQGl2YDr1l7w
         1VMUkuZllULnZj+LGwdKoZc6y+WKRlNYWYCtkmXjMJvKejU2iNb8SK4VfpkctyqUC9mc
         qgsCanSrnvFtlSbWoZst1M4wD55zqF7HROyJM3FMtyVXiUglT91xpSDjJVcd3hStamBr
         d/BQ==
X-Gm-Message-State: AOJu0YxaCFi21asKxPPJawtvfVCvEhLPFM0JzCuDbcMwF84JU2nFDbY7
	IktVEKXus6lya5pPwNEchPGERkw7ZKUI0ODRJHqL3LTZwu0JrMOgenNr
X-Gm-Gg: AZuq6aIz4UQT3lWO2oZZCD363Ytqir7DNQJwXOZGAVIq1aIdRyIn1XzrN1UL6lmjXPj
	ONyU37398zKGvHyk+M6CnQfQDwEEjXZJuh9S6Wu5K2lMNBgW2U75eFShZC64mk4vw8tWTdvrHPQ
	aEKVZm5gWrmQKnw8bLS9AeVgPLPcxjTZ4BwY22HqgXpQ53ukIUdOPvtrt4PFZte78S5DKoiAtPR
	vetkBhXdydQuvlXqO1Mz8E/FFEksSr087dVfvjgt6J9g76yvg3r4zJUE8bb9Zmeg5VlAEQZQQXz
	0RiNgm+0WXz20DG7D7lnZzvvvayJXS7nHXxod5jhHjxAj0ZqC/C+9Z2nDcsxodSuPoJ/b9p+SZY
	o2tIYKfPM8qgJlcX60luorvRktxS6T4iqBfGvRYgt/8yWHwkZsvI0QeBMkZ20I1/a2MYlDL53zL
	Oj02B3lUoWyE5REIxHYjw4vtTaG+Z8Cf8QZhcPYXVZsbHCe3cg0QvKMeWdPKhk+wtzOLpbW4UJz
	WbkSZ6JuA==
X-Received: by 2002:a53:bf0f:0:b0:649:d492:cb39 with SMTP id 956f58d0204a3-64c14d39c25mr12667861d50.47.1771451604571;
        Wed, 18 Feb 2026 13:53:24 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64c22e936a7sm6325265d50.6.2026.02.18.13.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 13:53:23 -0800 (PST)
Date: Wed, 18 Feb 2026 16:53:23 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Maurer <fmaurer@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <willemdebruijn.kernel.10cafd56e9b48@gmail.com>
In-Reply-To: <aZYSvY8nUKhpLZhv@thinkpad>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <aZNBfh81p1zBvbi2@thinkpad>
 <20260217161053.XMFBwFXg@linutronix.de>
 <aZYSvY8nUKhpLZhv@thinkpad>
Subject: Re: [PATCH RFC net-next 0/2] hsr: Add additional info to send/
 receive skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259364-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 12FE715A6FA
X-Rspamd-Action: no action

Felix Maurer wrote:
> On Tue, Feb 17, 2026 at 05:10:53PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-02-16 17:10:38 [+0100], Felix Maurer wrote:
> > > I agree with Willem that the changes are pretty invasive in core parts
> > > of the stack for a pretty narrow use case. It got me thinking what would
> > > already be supported at the moment without any changes in the kernel or
> > > pretty small changes. For that, I see three parts:
> > >
> > > 1. Userspace needs to get the full HSR+PTP frames including the headers
> > >    and including the rx port information.
> > >      a) Userspace should have a way to _only_ receive HSR+PTP frames
> > >         instead of all traffic on one of the ports.
> > > 2. We should not forward HSR+PTP frames in HSR interface to prevent
> > >    creating inaccurate timing information.
> > > 3. Userspace needs a way to send packets a) over just port A or B of an
> > >    HSR interface, that b) already include an HSR header and should
> > >    therefore go mostly unmodified.
> > >
> > > Is that about a correct summary?
> >
> > Yes. Point 3b needs to be extended by
> >   " + or does not contain a HSR/PRP header and requires one by the
> >   system."
> 
> Ah, I missed that! Thanks for pointing it out, that seems to be the
> tricky part to me. Just be sure, you refer to the Pdelay_{Req,Resp}
> messages? Or are there any other messages?
> 
> > > If I understand your patch 2 correctly, you will be maintaining two
> > > sockets in userspace (one bound to each of the ports A and B through the
> > > HSR interface using PACKET_HSR_BIND_PORT). Binding through the HSR
> > > interface to port A/B has the very special meaning of making a socket
> > > only receive a very small subset of the packets, that is PTP traffic at
> > > the moment. This seems like a somewhat hidden property of the bound
> > > sockets and should at least be very explicit.
> >
> > Technically four sockets (two for A and two for B) but in general yes.
> > What you mean by hidden property/ very explicit? Document
> > PACKET_HSR_BIND_PORT in packet(7) or something else?
> 
> Yes, at least that. Maybe also make it more clear in the name that this
> kind of binding means that you will not receive all packets from this
> port but just some (atm, PTP).
> 
> [...]
> > > The other thing that came to my mind: this sounds like XDP with AF_XDP
> > > could be a solution that could be used already today; not so much
> > > because of their speed but because you can program what goes to the
> > > stack and what ends up in userspace. It fulfills 1) + a) directly, 2)
> > > implicitly by not letting these frames enter the stack, and 3) directly.
> > > But I also see that handling AF_XDP sockets in userspace is quite some
> > > work to do if all you really need is to separate out some traffic.
> >
> > Not forwarding PTP traffic needs to happen unconditionally and not to
> > wait until the system is up and has the software running.
> 
> I agree that we should just do that in the kernel, no matter what else
> we do to support PTP.
> 
> > However if we
> > ignore this detail and can receive on interface A and send on interface
> > B over XDP and get timestamps right then we have the same as the packet
> > interface on the two eth devices. What is missing is sending with HSR/
> > PRP header.
> 
> You wrote in another reply, and I agree with it, that sending with the
> system HSR header and sequence number must go through the hsr device.
> Frames that already have a header, such as Sync an FollowUp that are
> forwarded, could just directly go through the slave interfaces.
> 
> I think the cases should be handled independently: to send a frame with
> a full header (i.e., the forward case), we already have the AF_PACKET
> socket on the slave interfaces as an option. For sending a frame just in
> one direction in the HSR ring through the hsr interface, we have to come
> up with something, but IMHO just for that.
> 
> I like the idea of putting the port hint in the ancillary data of the
> message, but I'm not sure where to put in the skb then / how to pass it
> to the hsr interface. Willem's suggestions are worth exploring I think.

Could you use existing SO_MARK? Optionally per packet with
sock_cmsg_send. And use that in hsr_forward_do if set.

Or perhaps skb->queue_mapping. For instance with tc BPF, see commit
74e31ca850c1 ("bpf: add skb->queue_mapping write access from tc
clsact").


