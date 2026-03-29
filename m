Return-Path: <netdev+bounces-272973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iELjBoV1yWnHyAUAu9opvQ
	(envelope-from <netdev+bounces-272973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:55:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E47353AFB
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28FD6301015C
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67A9257845;
	Sun, 29 Mar 2026 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="A2JdmtZO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACE540DFDF
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774810373; cv=none; b=qakatRnLjKmOuy9fLNrqt5CKzux985ZfoARfBCx6rok+ffHbRnIG5tdHIMswPkhOqM6jphcrkS4j1Htd6gatwmewZdetzrIwXdXq7zoao5IvQAbVikAzjgqh4+yxrqjNWj3lsU4HtKTfq+5unORc1s5nvRsqodJmu9dg+XiPRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774810373; c=relaxed/simple;
	bh=vtsq7ZEXOhvYIN59j3COqwZlbV048fVgyb+36XCIBYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1AyFVUNQ64daoiSS81EjlSxMcRjBkpBQmfzt6Oe+Wzz44xthcTcL6B2rusaiFB4KSWr6e+2cOZRyMQufKuvO3gMu84W2iE+m6nXLQl7RJejPt1JF9mCrSXgwMoR2aA/kzpcGV0TtjMsAvkCVeH/66+mcYKNrxi5Ie5HhrWfge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=A2JdmtZO; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-126ea4e9694so373743c88.1
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774810371; x=1775415171; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vdN2Rp9mxnKLh3WKCSCA1a4AkL+fa9NhwSuePSdays4=;
        b=A2JdmtZOvm70rmb+Q5RJnWdSB+DF/f2Ba2I9n9T881b/RKsEnTQF+mmWDMQLmTxzz6
         4a2Yn0jXYrJUuzTQiiDh88fE5mCDv2B+icoOXCgWjquJNtg/p6/ozz8pDjr/uk+dzDwJ
         +ws+U99pDdvETv9jpqaHjVwAwcR6BMnmpqsAMWYVTxaL/caU1bMm/AtOz8I1q2v8YQCA
         PHaz21bAUdQffjqaRRo9ReoLkEW3lHuSHxiI0RoleSWHvDkGrJ0CqtK+CX3ExrL9pnLp
         UBZ//XCfbq7dHGMOgiwyxZUYupdjK4Mdgl3+Okn5C0CC4i6pGJl/2bXAyP7vjXZdXXfp
         mUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774810371; x=1775415171;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdN2Rp9mxnKLh3WKCSCA1a4AkL+fa9NhwSuePSdays4=;
        b=GUE9jUyImcbEkqNMg81J5MoY2WCVjyRoGjXNTwjokqyqkPAv9XWkKrPc5qYtfWbQEL
         cqRX//cJOns40nuHC+E3OWr7VFj/8I2FIbFOxKDw/dsB0wwSiGMcGx53d/3wjNhGKvl/
         3nVvKh6f6SZpgzppwVCjKLZIu61jORzoFczfkm+bADLMpi5QWtBud6MHq5Y1+BC0qtJn
         diqn/3LvbQZA7G96XZa5bOPx+MuBCEI5nsFweGnn7pGCXYuW46RVyWDJyabclkNK5jXQ
         /535UIYhUUDPQXhBFsqyi5THkTYFfotl6vgV1dkZ+4FCdpqOIroDGsaO8zGZ3Jui7VRI
         KcNg==
X-Gm-Message-State: AOJu0YzcSWNGaEt8vNSjNvDYGvzNGcTDUUJqQoIgufhIo31LsuIpldMS
	wF6N/yQTPitAn+YX43UiNrWwz08GO6oRbWRZgDgXVuFGkQiN43pTjVXIViJtdqRDMQ==
X-Gm-Gg: ATEYQzw/2Jf79ioAFu25sjZrDsccqOz9HvNsgxwtnJMt9amkH4gNmbs8IGck5IN1v1G
	2Cc5anTSPRa2Rw8salDN8Zd8tYLueGqraCb2w2PL5710rCQo15zVmtWYTt8uS+dMcXcwBReLUHX
	Ep4tjSUpq0vis2cme4lL+s86K2dNbOfP+nBKhLgkpkQQq1+9dVWL80UfXMbKBNelRFG0pJ2wxHE
	CsIy+OeDHH1+MjBji392OQLLiUYQREa8ta/LjKiPznzKGt/jABU03+k0qzmNCKHO19XNlKZ2ylE
	jY+/ZLvRUubUz9L0iTBCjPVnP6fsoVhM/dy+Gsqgd0PHOW0GbQPlreY7xdkAB7ATsb1ApKdBSWP
	rTWeB+91Wzg2ZnzRwV4LOSPABTHLt0FwQzd+JMG7rTiA+/gyCA6LBS8w/DK7ptJa/+7mPO0T3iR
	2Jit8cKTaxy9nbiJ8//UCE4FM/LlUW6Q==
X-Received: by 2002:a05:7022:92a:b0:128:ca6f:adf0 with SMTP id a92af1059eb24-12ab288a2c4mr5698583c88.17.1774810370858;
        Sun, 29 Mar 2026 11:52:50 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ac09e3872sm5003527c88.13.2026.03.29.11.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 11:52:50 -0700 (PDT)
Date: Sun, 29 Mar 2026 11:52:48 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org, 
	bestswngs@gmail.com
Subject: Re: [PATCH net 1/3] net/sched: cls_fw: fix NULL pointer dereference
 on shared blocks
Message-ID: <s52rg5clqff6z44qdnjcthqhp3bhyzqn322esxj4caw7tqtkdw@2povbhh5efc7>
References: <20260327061300.3066844-1-xmei5@asu.edu>
 <CAM0EoMkspiNjXpdwnG2HaPK3n+BJkjTRbA8k4TsV4fcVk7g_Zg@mail.gmail.com>
 <CAM0EoMmVey4ayJBZgogMO4S3Z-_n5oDfasdZyiVryEqCNqu6bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmVey4ayJBZgogMO4S3Z-_n5oDfasdZyiVryEqCNqu6bw@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-272973-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,asu.edu:dkim,asu.edu:email]
X-Rspamd-Queue-Id: 69E47353AFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 08:15:17AM -0400, Jamal Hadi Salim wrote:
> On Fri, Mar 27, 2026 at 10:11 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > On Fri, Mar 27, 2026 at 2:13 AM Xiang Mei <xmei5@asu.edu> wrote:
> > >
> > > The old-method path in fw_classify() calls tcf_block_q() and
> > > dereferences q->handle. Shared blocks leave block->q NULL, causing a
> > > NULL deref when an empty cls_fw filter is attached to a shared block
> > > and a packet with a nonzero major skb mark is classified.
> > >
> > > Check tcf_block_shared() before accessing block->q and return -1 (no
> > > match) for shared blocks, consistent with cls_u32's tc_u_common_ptr().
> > >
> > > The fixed null-ptr-deref calling stack:
> > >  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
> > >  RIP: 0010:fw_classify (net/sched/cls_fw.c:81)
> > >  Call Trace:
> > >   tcf_classify (./include/net/tc_wrapper.h:197 net/sched/cls_api.c:1764 net/sched/cls_api.c:1860)
> > >   tc_run (net/core/dev.c:4401)
> > >   __dev_queue_xmit (net/core/dev.c:4535 net/core/dev.c:4790)
> > >
> > > Fixes: 1abf272022cf ("net: sched: tcindex, fw, flow: use tcf_block_q helper to get struct Qdisc")
> > > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> >
> > Thanks for also providing the tdc tests. Looks like a bizarre bug—and
> > in my mind the question is does fw or flow even factor into tc blocks?
> > Please give me time to review if the approach makes sense - perhaps
> > this weekend.
> >
> Since the fix is exactly as what u32 does - why not move
> tc_u_common_ptr() to a header file (pkt_cls.h)? then reuse it in u32,
> fw, and flow.

Thank you for the suggestion, I appreciate the review.

I spent some time exploring how to reuse tc_u_common_ptr() in cls_fw and
cls_flow, but I'm not sure I see a clean way to make it work across all 
three classifiers. The core issue is that they need different things 
when the block is shared:

 - cls_u32 needs a pointer value (block or block->q) as a hash key for 
   tc_u_common lookup
 - cls_fw and cls_flow need to bail out and return -1 (no match)

If we keep tc_u_common_ptr() as-is (returning void *), the usage in 
fw/flow would be tc_u_common_ptr(tp) == block to detect shared blocks,
which is less clear than tcf_block_shared(block) and doesn't save any 
code.

If we rework it to return struct Qdisc * (NULL for shared), it would
break cls_u32's current usage where it needs the block pointer itself
as a hash key for the shared case.

I may be misunderstanding your suggestion though — could you share 
what you had in mind? 

Thank you again for your time,
Xiang
> 
> I am still questioning the value of using blocks with these two
> classifiers and unfortunately the commit message of  1abf272022cf was
> not helpful.
> The testcases look good. Please add a letter head, perhaps quote the
> comment in tc_u_common_ptr() since it gives a good description of this
> whole dance.
> 
> cheers,
> jamal

