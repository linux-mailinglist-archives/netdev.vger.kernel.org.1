Return-Path: <netdev+bounces-161870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8D3A244FE
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 22:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6BB1885AEF
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 21:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DCE1F3D3E;
	Fri, 31 Jan 2025 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNTxpqUt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B898F9FE
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738360428; cv=none; b=BEYU80jSTQVOdX4kklXTlIM5GjrX6jrEMdr+OqGiQXmtY84B88vsZZ5q10842/WQvqXgWC3EVbJGwEyH9lhFBdbKMBk41SyWeWFCbw47qTPurQgqgkJItz/Tm5sQehFSwSEg2UkGMgxY5n8wS+28AEHzuKUJeWUUDQa9hqy7wDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738360428; c=relaxed/simple;
	bh=kayC9/pn7CbVMxYhfgtMn9nLhcWiC28RMFWbISTpCWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNL7b9P7ZqPEhYuAiILcBqmEsIShrIP6EBgLG185QXyJSUoNpTKglgnpGhpLqoqCdVG1Wihah4JYIndiVkWTLsA/glKCJFevBlMGxCECaD/gcx6oWntKvMAxX5HxVmQsIv0RccGQgQTEqSMz/udAjy7uIZWLY7uh/CGIxpeZqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNTxpqUt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166f1e589cso62565325ad.3
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 13:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738360426; x=1738965226; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eh5/oK43NrXmZ1iR3YtTfTJP5VudGVJFV65FewXwuG4=;
        b=fNTxpqUt0upZZbKEg6S2AXswXBoEKJANths1g6VDv9FSyZzfZDOJ1iWCwgbNidG8aK
         mlMNt3ft4UKAyCMjYg4KE2cYSAG01QI5J8hqr6j0u+kRjyhFbI+tW5XE6aTfQXpWEbpz
         rRDGrVIiZcW4ROaUj9/VHnbZDlx4c5+woQYkJoKf10QOiFVVE+EJC8eRufkXN2fnyAG/
         F55G6QMwFQcqsxbYOPqqXPHBv+CKdf3Lm7CvstAGAObv4kSw+zjB0qf1221v6H12/4nc
         PKCyFqc/AwzHdBXKasgQfJYire71PxLy6FJL+nlE3RIneIYA91Frah1PFwAYpbMXbbZs
         joyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738360426; x=1738965226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eh5/oK43NrXmZ1iR3YtTfTJP5VudGVJFV65FewXwuG4=;
        b=U7BrKpo7x4FoDEP0dMnEwyTzH/92o/WHcDY2KHWlyZg3MutNilM/vCU8FvNhEfP9Ni
         ymClwjfDSzvDMXt2F2Z0KimQbCNLj7++y9n1BmgIhhgnLbaazq4gT4+qXRiKBcNw7JEj
         HABXV1qpeAYz84n0h/8dN38FZ1zb5e9kK8cqz0+hXs+MBkxDEFXPOGh8+opWoTkH5IeK
         ejJYQuXJAJCRJJgs+mKajnmX4QIE53LVkZlf5/MH96HABcQD1AqKRSkl4BTUHs1PhaCo
         +xDZsbeci3cnqmhJdOdrHI1RZRpeMYZXZw1FmB+ZldYFu/0JbbX31O6W5rs+dawFfeXF
         X+sQ==
X-Gm-Message-State: AOJu0YxHMyCt+7B4bKn4nJqit5TZZozlrGUZZSUZGcEnkXewKJQEiQiV
	8X8zW/ttimW4c1pk0WT9dGSqjmNkdImD/x4yoZxgFL1wHmdyKJL9
X-Gm-Gg: ASbGncsUYNWhCVURMRD0TKAui0L2AcYfsKpo/1F8xqpXj1uGnxC/Y19oNjneLwwkbOn
	uusQXeMQKKfD6DthE6MajdQytk+1TdwbAN2owD1NAD7HwLmkksLcATtMMvew6CzgzRD5d37zMwJ
	edqOzT7Lx60SupJ3rKsmXLa6GxRyKwMUSQAs8FCXfceVW9OenJCV0fQiR+1kjgDNqk7121bLfMi
	qO+GSTU6/YkB+3OGzdog5CFK72qcBafIXK0MUa8iJ9OzZDkMuYLqfhvsnbxh6xUn3n4iOqj5X2g
	8N4Sf+d3YJvZmAbZtfoM
X-Google-Smtp-Source: AGHT+IFrYESnadSv2+THg7xnBNQfjqe2BqHszLgchWSSSEiw0R0kMaPjU2nWRchGgmVJy4c20oA/zA==
X-Received: by 2002:a17:903:2b07:b0:215:a964:e680 with SMTP id d9443c01a7336-21dd7d78e22mr214113655ad.25.1738360426244;
        Fri, 31 Jan 2025 13:53:46 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:9ca:6511:2ce0:8788])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3308e32sm34980815ad.207.2025.01.31.13.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 13:53:45 -0800 (PST)
Date: Fri, 31 Jan 2025 13:53:44 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, quanglex97@gmail.com,
	mincho@theori.io, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net 1/4] pfifo_tail_enqueue: Drop new packet when
 sch->limit == 0
Message-ID: <Z51GaME2q0QVc+kB@pop-os.localdomain>
References: <20250124060740.356527-1-xiyou.wangcong@gmail.com>
 <20250124060740.356527-2-xiyou.wangcong@gmail.com>
 <CAM0EoMk8dBGaZOUUqw4fbZUVK99Q3xO=uyuCKGE7eQjDELZdQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMk8dBGaZOUUqw4fbZUVK99Q3xO=uyuCKGE7eQjDELZdQQ@mail.gmail.com>

On Thu, Jan 30, 2025 at 06:17:36AM -0500, Jamal Hadi Salim wrote:
> On Fri, Jan 24, 2025 at 1:07 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > From: Quang Le <quanglex97@gmail.com>
> >
> > Expected behaviour:
> > In case we reach scheduler's limit, pfifo_tail_enqueue() will drop a
> > packet in scheduler's queue and decrease scheduler's qlen by one.
> > Then, pfifo_tail_enqueue() enqueue new packet and increase
> > scheduler's qlen by one. Finally, pfifo_tail_enqueue() return
> > `NET_XMIT_CN` status code.
> >
> > Weird behaviour:
> > In case we set `sch->limit == 0` and trigger pfifo_tail_enqueue() on a
> > scheduler that has no packet, the 'drop a packet' step will do nothing.
> > This means the scheduler's qlen still has value equal 0.
> > Then, we continue to enqueue new packet and increase scheduler's qlen by
> > one. In summary, we can leverage pfifo_tail_enqueue() to increase qlen by
> > one and return `NET_XMIT_CN` status code.
> >
> > The problem is:
> > Let's say we have two qdiscs: Qdisc_A and Qdisc_B.
> >  - Qdisc_A's type must have '->graft()' function to create parent/child relationship.
> >    Let's say Qdisc_A's type is `hfsc`. Enqueue packet to this qdisc will trigger `hfsc_enqueue`.
> >  - Qdisc_B's type is pfifo_head_drop. Enqueue packet to this qdisc will trigger `pfifo_tail_enqueue`.
> >  - Qdisc_B is configured to have `sch->limit == 0`.
> >  - Qdisc_A is configured to route the enqueued's packet to Qdisc_B.
> >
> > Enqueue packet through Qdisc_A will lead to:
> >  - hfsc_enqueue(Qdisc_A) -> pfifo_tail_enqueue(Qdisc_B)
> >  - Qdisc_B->q.qlen += 1
> >  - pfifo_tail_enqueue() return `NET_XMIT_CN`
> >  - hfsc_enqueue() check for `NET_XMIT_SUCCESS` and see `NET_XMIT_CN` => hfsc_enqueue() don't increase qlen of Qdisc_A.
> >
> > The whole process lead to a situation where Qdisc_A->q.qlen == 0 and Qdisc_B->q.qlen == 1.
> > Replace 'hfsc' with other type (for example: 'drr') still lead to the same problem.
> > This violate the design where parent's qlen should equal to the sum of its childrens'qlen.
> >
> > Bug impact: This issue can be used for user->kernel privilege escalation when it is reachable.
> >
> > Reported-by: Quang Le <quanglex97@gmail.com>
> > Signed-off-by: Quang Le <quanglex97@gmail.com>
> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> 
> Fixes: 57dbb2d83d100 ?

Ah, probably. I will add the Fixes tag in v3 after I resolve the
selftest issue.

Thanks!

