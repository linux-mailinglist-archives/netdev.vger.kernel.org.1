Return-Path: <netdev+bounces-258326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MjsONm6jGlgsgAAu9opvQ
	(envelope-from <netdev+bounces-258326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:22:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C9B12691B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED95D3010BA6
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCBA1B394F;
	Wed, 11 Feb 2026 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSTaXBzL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EAB22339
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770830551; cv=none; b=PNGyY2TB0X94wzjow7RbW14VIFpIE1NBhX1bdXjPhbxsVAKqImq9Tgiv3ijUSHaKR/C0ig9oOaKfETRTMcycY9Y43vyG3BKrwqWots8TekotMP9d52B+uY7ZBGoYBQHO+4KDv5ZAPsDtaH0b7xF5IeTQxZ9DgQc1OiVkrUDifLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770830551; c=relaxed/simple;
	bh=7JJEbaI8gADvksOgSC/RqZsRMhXUw/AVhllJQLiiqS0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rFFLDjXwSRt9POwmb9tDfLUd29iG/WWyBKuyV63hekd6RAsqakDa1GtdX3gak8nb8TiVRnzIoPDma12hZsC3A5VGn06/HRZvEcbc0XEAC5ToX+qY9105zxOkyt8BV1x1NL6LxEZGnBqGmA7AN3yGOk5HPFY7PkP9J6KxlA8yYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSTaXBzL; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ad019bb5eso5515995d50.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770830549; x=1771435349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOPQYb8U+ctug5FsMgUJIr/auxzVIvYKdx/PJfk6yUs=;
        b=BSTaXBzLrVSI8po5vn/kystCdl7+M+5unWrIMI0ukIpP4/YQtGBGKk9rj/ZQlhOrS8
         cIGbQhRheZnfl/6bHI+csINg8+uKoRDt/hynlEhoi1uWx6YA99hqZVfOXnrfl4w1tMNy
         54m5L790dNRnteodDLPXMXlvAYc9Kvhy0QBiFk+mqKTM333SXDBf1RiS151Ie1iNx1vO
         2p1JcSmsz2x4mAfNAhosoZUH6veqdRy9oUrQtLc8wgkvepf+JkX1LEaBOOH2k4llZg3i
         Qw1nNUM2aQdhRy28HyiEBU6cERF6a3cQO2rlXcwRmuugZRR1c5Ufd34M9xDaNOyG3aUH
         a4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770830549; x=1771435349;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wOPQYb8U+ctug5FsMgUJIr/auxzVIvYKdx/PJfk6yUs=;
        b=KO9tCOeIgijvl09yF7i64ZesykPkrbMXZODmiOZ6OaCGjJFQd6gsjiT2lF2Q5m5L4O
         jUxyGaglkSF6D1/ur9XFcLxQxBOyX/kXyVePN48sMVNYbj70o6wau44Nbg0H0UdH8UlQ
         NMcazcHmLJ58unFDFzNlaspeY3uS1tVX5S3zwQocCfGvWxyOffamYPId5fZOIl9Gh2vo
         sz5Qv23E8Cvudkh1oRNSViLyDMOKDJckBuYGU/ma1BiNL+W4eDyCQ8HP3x7rT/9ue2s4
         T2PQtxS4ZXLaP1UkBFBkQlu7gbaZGijAVU4VudrJAdd26Ggcw926PgDaOE38Tzozgl43
         Ks9w==
X-Forwarded-Encrypted: i=1; AJvYcCX1/b9k+vHlGcDFyMZM1iVc0nj/wXlDajl5NzELR1C1Ct5er+F9WGYOyQH4PspxUUewOewbq+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhbYw02UA/xuOLnnUzs6NwGwy++zk4RnwWyvsuM/vSp58HqGR8
	1FOhQvDKa0pvy57sXGVHrIF21ZI8iqSwmgAll+5VRwpUpEeXcYCKGA4E
X-Gm-Gg: AZuq6aJ999uHpLzvk+45FEaLyIRjr+qt7tPZjWQGrlSihpvb07y5Am1NPkYSLUua/vA
	GkWSkdDH33Xev2YqOmph7GinIdloY+IaETzRojEX9rIiMazxZpfVKjBOEN+rF03KYR+xjbHTWWG
	q3FzX8OzfyA6eSbt2xqb1KaG53VKeJVXyucWLchHNmtnJUhTjB4nIaipAS/7x8wNX2dLVfV/EIE
	JBK7Uq0cobCEhJohyHOoN3qZNr9AutxDrh1w5pVHxgZaA+hbPf+Zltw4TEl7xmnPTP8lsMlAljY
	uA+Af8AKY6w3vFOetOly//kRWyOXwEM2jLOtezXcmjxwCvICFBYbrVCdjL0ITDKo/cTtRjwQZ1t
	hBR2IUIAAkcKaySfy7CydRkT2AcWrvy9dNujdWgq0n8OfCUxiJBWIlgXyCPepj7SWL/006gPgMG
	pngGEIVua6koj4cIOVfsoDlXkq2FYSh7vyDK0mT4L4D/7tqgEGW7F+8OmmFzrQtVrevAmRt8Y=
X-Received: by 2002:a05:690e:1513:b0:649:bb4b:f822 with SMTP id 956f58d0204a3-64bbaafb604mr17332d50.48.1770830549204;
        Wed, 11 Feb 2026 09:22:29 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64afc73fe6asm2480743d50.0.2026.02.11.09.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 09:22:28 -0800 (PST)
Date: Wed, 11 Feb 2026 12:22:28 -0500
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
 donald.hunter@gmail.com, 
 michael.chan@broadcom.com, 
 pavan.chebbi@broadcom.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.b86b179834ad@gmail.com>
In-Reply-To: <20260211090013.12991cd0@kernel.org>
References: <20260207003509.3927744-1-kuba@kernel.org>
 <20260207003509.3927744-7-kuba@kernel.org>
 <willemdebruijn.kernel.743811e01cc@gmail.com>
 <20260210175638.123782b2@kernel.org>
 <willemdebruijn.kernel.503ed4ace7bf@gmail.com>
 <20260210194814.21a0c403@kernel.org>
 <willemdebruijn.kernel.172899765680b@gmail.com>
 <20260211090013.12991cd0@kernel.org>
Subject: Re: [PATCH net-next v2 6/9] selftests: drv-net: gro: use SO_TXTIME to
 schedule packets together
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258326-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45C9B12691B
X-Rspamd-Action: no action

Jakub Kicinski wrote:
> On Tue, 10 Feb 2026 23:21:07 -0500 Willem de Bruijn wrote:
> > > > I wonder what's going wrong here.
> > > > 
> > > > fq_classify should pick the queue based on skb->sk also for packet
> > > > sockets.
> > > > 
> > > > And flow_queue_add should add the packets to the tail of the linear
> > > > list if the delivery time is identical to that of the tail.  
> > > 
> > > It works but requires that we either modify the qdisc config to set
> > > a orphan_mask of 1, or somehow set the skb->hash on the AF_PACKET skbs.  
> > 
> > Oh right, fq_classify does not use skb->sk for packet sockets because
> > they are in default sk_state TCP_CLOSE.
> > 
> > And this is by design, as clearly documented, as packet sockets should
> > not be assumed to be a single flow:
> > 
> >         } else if (sk->sk_state == TCP_CLOSE) {
> >                 unsigned long hash = skb_get_hash(skb) & q->orphan_mask;
> >                 /*
> >                  * Sockets in TCP_CLOSE are non connected.
> >                  * Typical use case is UDP sockets, they can send packets
> >                  * with sendto() to many different destinations.
> >                  * We probably could use a generic bit advertising
> >                  * non connected sockets, instead of sk_state == TCP_CLOSE,
> >                  * if we care enough.
> >                  */
> >                 sk = (struct sock *)((hash << 1) | 1UL);
> >         }
> > 
> > An orphan_mask of 1 sounds like an effective workaround.
> > 
> > I don't see a way to force a specific skb_get_hash result across
> > flows, given hashrnd.
> 
> So WDYT about the patch? I don't wanna tweak qdiscs on real interfaces.
> It's way to hard to undo. IMHO either we keep the patch as is with its
> limited effect or just drop it.

Reviewed-by: Willem de Bruijn <willemb@google.com>

I would say keep it. When respinning, maybe add an explicit note that
for this to be effective FQ needs to be installed.

Aside: there currently is no API for the kernel to communicate whether
a cmsg SO_TXTIME request was honored or ignored. But if a caller cares
it can either request a Tx timestamp.

