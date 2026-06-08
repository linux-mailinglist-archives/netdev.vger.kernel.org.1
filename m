Return-Path: <netdev+bounces-296377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bi/gAF5jJmr1VgIAu9opvQ
	(envelope-from <netdev+bounces-296377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 08:38:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 512086532CB
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 08:38:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=haDSYDLz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296377-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296377-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ABE5301AB8D
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 06:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC6538B7DC;
	Mon,  8 Jun 2026 06:36:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176C31E842
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 06:36:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900604; cv=none; b=e3QuU042YCEt+zLDGV/V2aFrL2zsTUg6qpPKUcQimJIL5mYV6wJHAXbew+5EsCniQ37EVDLadR1IMGDUgu8f86Vk37RtJ7bxLZVkbJHTuxUxtWVcCxwrqsYQIHQMbO/3CRjEMIfFIuvHkCt0e/00/I5klKZVaXgUo7JwakH6O9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900604; c=relaxed/simple;
	bh=ZBSotCsPkGx72Cnm3YYP+qCFKM0v9NLL1DlLxzGpLbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chWGwMbMXKY/7zKqBA3Kdm7KXERZsUE/PK1FqARqVvLzP7gjUhatGsce8wfHSC0Nlc+mCjjA8NwDTqdNVqbvQYhxrt3S8deMh5vFGxese9IRH9jqbDxoYDqsx+sqgx1N4ZaJFjvENDsMArIf0zSusg7hZrrKoEMIm8pBu5qI1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haDSYDLz; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso2368267a91.3
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 23:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780900601; x=1781505401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tBBrRhDE6o7kPVb9YH45wyWFzzeDpsDDOVgKo6zJUAI=;
        b=haDSYDLzTt/oHxDNcl387PVj/A7ltjVEYlPAhV6N18rble+RrdaMN8QPAlHIO25m3L
         4GbhoR7N3NObeeQdhP7XvLAakGqFGGHtgyjDw0z+4v+ZBcKuor965sb5BS4Guq1ty75b
         YaQqJBoaY+Z44qdff0n1AIgnnVPi/flc9bC6qYz0VbmlUMxyv6VOvHVlRl+/KBl+LFR6
         EVmEBqG2Girg9CmbZTw7iNh6BlbAq48fh34PFi+BHGyJ44xj8XMiNL0z0/xGydF+QoSj
         il17AXN/8fB/48LZ9CZgzZUjMDuqfPEOExSxH+IHpVvg/h7ZTXn5YsRNvm9mJrxLqi31
         tRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780900601; x=1781505401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBBrRhDE6o7kPVb9YH45wyWFzzeDpsDDOVgKo6zJUAI=;
        b=a8lb7fCSD5Jbc2Wl63Iqzd+6oZD54rnPhrsKilX82bxOC7TnUe/5ZHEh0gA/frOByk
         1IN9DIyzLM1vwA8W6dv5q2/ktqMoExC0Sci4l9jB/ZpfIUQKqemlUbUdw/tH/5U/C+rW
         M3ALw0OAetedEiU8eh3hP6MJcBLBlBio7lfjmWaCD0OtihXWCjjT88rQnhs39fvC0ZJQ
         A1o+TCGXx7sTaPgogFShT+L2d5jnh+9GqAYcjlNxu4RC1ZNC/WuQKbmsaPyYGvuRbwhD
         OCFv+wuP9MWQhREo8pfAXyYJuNX65IZZu6qQS8xLdrpXoQ4ZI97sp4A+Jmx0wt75UgG2
         VfPg==
X-Gm-Message-State: AOJu0YzNzsmUctkqmxIm0Qtql4teX2u6bJPExxCxPxwDGwrXYnplzAYd
	0OP/bp4fSMlUH/bc5Xc2pVQ3dmAd5B4yB/dhyU4APtz8RHanhlq1N0G7
X-Gm-Gg: Acq92OGdhK/x1NhJAM+9Ov0Gx9pjVxRxlNhcrYZ9cu0T4B9oWYBe5wPi3SYHUFncUKv
	9/Ag7bWYVz4uVc/Zzvew5gdbXnkFk12Yu7VE74T6goKbzABOzCwi607jLrdiwsCoOkjWk9B67qS
	iLtgudZ6JHMx4jLacKlREFRId6AwVbZXHQM1Rs6Ou9EPzlMjJ8pcwalArezzxY5Uu4rW9ixcQoV
	V5Q2WVg5FK/yXsyaXopoOJTQfC9YNbiMhaSnsYaFtiTyyh6ag4Qak82aYDC/OQJr0jhQ5GSKQZy
	IY+TPDAnQUPabuSadQIQChnx6UH4KtlDVIMT/uTGrX48F5Ldqvieumor1mZ4IEu3HmSP3t+twPz
	sVQQMYYIwA3ZLLbQkxcxInAkkTOTqVeXb9Mpp+AyDQjYieSXDOGsYY3Jgs8W91y56lmw/G1/OFF
	PmClbd4pxGGKRaEzQ62URdWLTz8bzHeLMIuL9yEqBrSN5Hdi9bcY8ah0Mx4Sr/eg==
X-Received: by 2002:a17:90b:57c4:b0:369:a9e8:dbf5 with SMTP id 98e67ed59e1d1-370ee643748mr14720295a91.3.1780900600627;
        Sun, 07 Jun 2026 23:36:40 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm17786545a91.1.2026.06.07.23.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:36:39 -0700 (PDT)
Date: Mon, 8 Jun 2026 14:36:32 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net] net/rds: fix NULL deref in rds_ib_send_cqe_handler()
 on masked atomic completion
Message-ID: <aiZi3WoSSY8yN8JW@Air.local>
References: <20260606192447.1179255-2-bestswngs@gmail.com>
 <73dcc08ff744364c097ec63bf81a26bd15e8f2af.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73dcc08ff744364c097ec63bf81a26bd15e8f2af.camel@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296377-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 512086532CB

On 26-06-07 12:32, Allison Henderson wrote:
> On Sat, 2026-06-06 at 12:24 -0700, Weiming Shi wrote:
> > rds_ib_xmit_atomic() always programs a masked atomic opcode
> > (IB_WR_MASKED_ATOMIC_CMP_AND_SWP or IB_WR_MASKED_ATOMIC_FETCH_AND_ADD)
> > for every RDS atomic cmsg.  But the completion-side switch in
> > rds_ib_send_unmap_op() only handles the non-masked opcodes, so a masked
> > atomic completion falls through to default and returns rm == NULL while
> > send->s_op is left set.  rds_ib_send_cqe_handler() then dereferences the
> > NULL rm via rm->m_final_op, oopsing in softirq context.  An unprivileged
> > AF_RDS sendmsg() of an atomic cmsg over an active RDS/IB connection
> > triggers it; on hardware that natively accepts masked atomics (mlx4,
> > mlx5) no extra setup is needed.
> > 
> >   RDS/IB: rds_ib_send_unmap_op: unexpected opcode 0xd in WR!
> >   Oops: general protection fault [#1] SMP KASAN
> >   KASAN: null-ptr-deref in range [0x0000000000000190-0x0000000000000197]
> >   RIP: rds_ib_send_cqe_handler+0x25c/0xb10 (net/rds/ib_send.c:282)
> >   Call Trace:
> >    <IRQ>
> >    rds_ib_send_cqe_handler (net/rds/ib_send.c:282)
> >    poll_scq (net/rds/ib_cm.c:274)
> >    rds_ib_tasklet_fn_send (net/rds/ib_cm.c:294)
> >    tasklet_action_common (kernel/softirq.c:943)
> >    handle_softirqs (kernel/softirq.c:573)
> >    run_ksoftirqd (kernel/softirq.c:479)
> >    </IRQ>
> >   Kernel panic - not syncing: Fatal exception in interrupt
> > 
> > Handle the masked atomic opcodes in the same case as the non-masked
> > ones: they map to the same struct rds_message.atomic union member, so
> > the existing container_of()/rds_ib_send_unmap_atomic() body is correct
> > for them.
> > 
> > Fixes: 20c72bd5f5f9 ("RDS: Implement masked atomic operations")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> 
> Hi Weiming,
> 
> Thanks for the thorough writeup, I've traced through the logic and the
> fix looks correct to me as do the tags.  Thanks for catching this!
> 
> Reviewed-by: Allison Henderson <achender@kernel.org>
> Allison
> 
> > ---
> >  net/rds/ib_send.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/rds/ib_send.c b/net/rds/ib_send.c
> > index fcd04c29f543..d6be95542119 100644
> > --- a/net/rds/ib_send.c
> > +++ b/net/rds/ib_send.c
> > @@ -170,6 +170,8 @@ static struct rds_message *rds_ib_send_unmap_op(struct rds_ib_connection *ic,
> >  		break;
> >  	case IB_WR_ATOMIC_FETCH_AND_ADD:
> >  	case IB_WR_ATOMIC_CMP_AND_SWP:
> > +	case IB_WR_MASKED_ATOMIC_FETCH_AND_ADD:
> > +	case IB_WR_MASKED_ATOMIC_CMP_AND_SWP:
> >  		if (send->s_op) {
> >  			rm = container_of(send->s_op, struct rds_message, atomic);
> >  			rds_ib_send_unmap_atomic(ic, send->s_op, wc_status);
> 

Thanks for your review.


