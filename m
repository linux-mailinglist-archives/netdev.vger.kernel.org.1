Return-Path: <netdev+bounces-292924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBLtAfzpGGruoggAu9opvQ
	(envelope-from <netdev+bounces-292924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:21:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B285FBF5F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2490303B16B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819ED3537F1;
	Fri, 29 May 2026 01:20:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D014A8B;
	Fri, 29 May 2026 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017602; cv=none; b=CNrC3JUDAgW6gY9pqEdb701EuFT6L1ULkCqlhuC7eArMuVecHBIz3aQic+b2rjg3eIPY1XiYGNZeGOdJjE3D45Jregqhq9XcZ/eqlKyUfdd/EPsn30RBPELfBvIMLe7RykdGQD+I/qvAj8aFsjfceYfyYPXYo3KwK7EuyAQ0qxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017602; c=relaxed/simple;
	bh=Yx3uJs72nqLatdtBg9//ieBwUgxB6mlJUI6Mn6zZ96U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ja0YFkz6UdYqDpS0Zv3riJL3g7eUS2+EyKe20tDqV1zQkyPZNP8Y9l63gWizEpRSnojtmHbaTYghwVUREI35MmcsMXialrm+Du7wNkMWLrIgXwY/IapwOSMFuwOb2vwVFtDmYO8XKSCvxnTLV2r6kxJFXfjjQ6BI2SWeoe3WOsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnU+ex6Rhq+he1EQ--.184S2;
	Fri, 29 May 2026 09:19:45 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	xujiakai24@mails.ucas.ac.cn
Subject: Re: [PATCH] llc: Fix NULL pointer dereference in llc_conn_state_process() when sk_socket is NULL
Date: Fri, 29 May 2026 01:19:44 +0000
Message-Id: <20260529011944.2898974-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5783055b-60e9-4e54-a17d-79b5e8f64fb6@redhat.com>
References: <5783055b-60e9-4e54-a17d-79b5e8f64fb6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnU+ex6Rhq+he1EQ--.184S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4UZw43WF4DWFW5ZF43ZFb_yoWfWrbEk3
	9rAa4fZwn8G3y3Za98C34UJw45Jr4vga4kWrsxXF1Ygw18trW0gw40grn3C347Gw4xCFy7
	Ja1F9ayIk3yxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbsYFJUUUUU==
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	DMARC_NA(0.00)[ucas.ac.cn];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xujiakai24@mails.ucas.ac.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-292924-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: C1B285FBF5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for your review!

> > diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> > index 5c0ac243b248f..de65c452f6e68 100644
> > --- a/net/llc/llc_conn.c
> > +++ b/net/llc/llc_conn.c
> > @@ -101,7 +101,8 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
> >  	case LLC_DISC_PRIM:
> >  		sock_hold(sk);
> >  		if (sk->sk_type == SOCK_STREAM &&
> > -		    sk->sk_state == TCP_ESTABLISHED) {
> > +		    sk->sk_state == TCP_ESTABLISHED &&
> > +		    sk->sk_socket) {
> >  			sk->sk_shutdown       = SHUTDOWN_MASK;
> >  			sk->sk_socket->state  = SS_UNCONNECTED;
> 
> sk orphaning happens outside the sk socket lock, and before the timer is
> cancelled. sk_socket can still be cleared after the previous check and
> before this access. You probably need to move the sock_orphan() call in
> lc_sk_free(), after stopping the timers.

You are right. I'll send a v2 patch later.

Regards,
Jiakai


