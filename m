Return-Path: <netdev+bounces-130918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E522B98C0C8
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A50284241
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E741C461F;
	Tue,  1 Oct 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5rD0Ir4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F3282F7
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794411; cv=none; b=O8BTtX39Cb04XJKCSm6qKzpk8485DfORQhB5sQIl86aOt4hlnTHfZ5dsRdldx/2F4vwmEC9ymzohRNAVx8GZFJx6ozjMY2Q7R9s4DFPffiIi91l099HeXT7+9dNCo0W9oxt99+XiwEFdASOeJpc8c1C4bqG9vfJtR+JFVorac4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794411; c=relaxed/simple;
	bh=yUtfkfIdDrnhy2KnwV9trAWpHCtsjfnbR7GfFoHnr38=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YejywBo9qPEiqqVK+uhHZzRHcVMZYvHMCmFS69xVINfZUTencIeP5EOuM8/+0oJ8tKHERq1Thqm2Hu4MgK4AdbtJJ+9kmurhawc+hvrskPDgbYh07ULEyHfGCdi2tsbGz+tve4y872iMQ14NpCLfGhUyMVPCO7NRQWegTaSMjto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5rD0Ir4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fabe5c8c26so33896811fa.2
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 07:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727794407; x=1728399207; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0JqqD+DWVcLzJTK/AZZnNSETc+uwI7/dh+Z1slJhNwI=;
        b=e5rD0Ir4wa2jrQajPJALLWYqOu2GSFDJoMJHWpwdE0qNH6VGwcU7NobJMawz3vEbOt
         ypbSo63gjUwg5N2YDPtYmxQYevfE7w/kkIW2oUG06sq5y8biqJbH7vayaHztocLPXu+G
         OdEN4BTN0WYmnfK46a1vWH3mY5dIeVvy92/yDtjI7edRYgZ0aygrNwpZzZHiaaOt24Ws
         CZPyxmln+RizHHGE/IVAAIAP5Q6H3ur8qeuu2+ZPPWVQoO1SdJ3YkNm+lQMjrxtkYEx1
         hF0xkRDZLaf3spLwBTd1ae7z73Mt02S8ZZIZlfqeekbgabbeRKazUlAV+ezixqLonnnn
         WAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727794407; x=1728399207;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0JqqD+DWVcLzJTK/AZZnNSETc+uwI7/dh+Z1slJhNwI=;
        b=s/EGopIz0UpJdhs6kPCvU9chyHxLRh7qdZg4qkDLyvX8iYa4Kq2yqZIQPiz+fpOOyf
         uVvnm8xTFSe25OId2qRf6iO2N4wuadQ9cnv/mbux9CKyAJmRXwTaGML0CKDxj6b+Nr79
         PCxmgRtuR+B+N07C0RzP5ec6VBqLdZK8HjxCGd2ez05atlMnor9BeF/fxjURdsBvFJPF
         MOvyCGYFwMrtuAoO9Z109XA/GJRvVt/qIkt6XL3TnmshCx+n+1tjzc8AJTfT9PTVzcOS
         pe7OVW7irwfgpHfkNBPBMu2rL9DGH8fkEp83sgRO25OADJEB2Rj6Kz6OW5KXrszVQchU
         0ZEw==
X-Gm-Message-State: AOJu0YysMmczRA3V+ZVb/NIMfoJKK90TybPCu2peDgikpXCBSAyNyeDg
	wLk6oGqnalkwJU+bVD27PGleDoox3W5IROcbW5TcqegXuK9C6XuseG7Lv+Sl9zNnlTKRQDTP+bN
	Jt4Ed+PYpTwIR1IXhdeGlYgfIJkZk1SyTBYeRau4=
X-Google-Smtp-Source: AGHT+IE3p+K200dsUwtiFafHsHXjJTviSNhqzkYBMyQoD/yye1eSA53hFFHtCO/qLWJLdxggiOczwROE9POazvsUZD4=
X-Received: by 2002:a2e:4a1a:0:b0:2f3:d8dd:a1f6 with SMTP id
 38308e7fff4ca-2fae10877bdmr116071fa.40.1727794407001; Tue, 01 Oct 2024
 07:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Budimir Markovic <markovicbudimir@gmail.com>
Date: Tue, 1 Oct 2024 16:53:15 +0200
Message-ID: <CALk3=6u+PTcc2xhCx3YgWrx3_SzazpXTk1ndDmik+AOi==oq9Q@mail.gmail.com>
Subject: Use-after-free from netem/hfsc interaction
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There is a bug leading to a use-after-free in an interaction between
netem_dequeue() and hfsc_enqueue() (I originally sent this to
security@kernel.org and was told to send it here for further discussion).

If an HFSC RSC class has a netem child qdisc, the peek() in hfsc_enqueue() will
call netem_dequeue() which may drop the packet. When netem_dequeue() drops
a packet, it uses qdisc_tree_reduce_backlog() to decrement its ancestor qdisc's
q.qlens. The problem is that the ancestor qdiscs have not yet accounted for
the packet at this point.

In this case hfsc_enqueue() still returns NET_XMIT_SUCCESS, so the q.qlens have
the correct values at the end. However since they are decremented and
incremented in the wrong order, the ancestor classes may be added to active
lists after qlen_notify() has tried to remove them, leaving dangling pointers.

Commit 50612537e9ab ("netem: fix classful handling") added qdisc_enqueue() to
netem_dequeue(), making it possible for it to drop a packet. Later, commit
12d0ad3be9c3 ("net/sched/sch_hfsc.c: handle corner cases where head may change
invalidating calculated deadline") added a call to peek() to hfsc_enqueue().

The QFQ qdisc also calls peek() from qfq_enqueue(). It cannot be used to create
a dangling pointer in the same way, but may still be exploitable.  I will look
into it more if the patch for this bug does not address it.

A quick fix is to prevent netem_dequeue() from calling qdisc_enqueue() when it
is called from an enqueue function.  I believe qdisc_is_running() can be used
to determine this:

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 39382ee1e..6150a2605 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -698,6 +698,9 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
        struct netem_sched_data *q = qdisc_priv(sch);
        struct sk_buff *skb;

+       if (q->qdisc && !qdisc_is_running(qdisc_root_b
h(sch)))
+               return NULL;
+
 tfifo_dequeue:
        skb = __qdisc_dequeue_head(&sch->q);
        if (skb) {

I do not see a better way to fix the bug without larger changes, such as moving
qdisc_enqueue() out of netem_dequeue() and into netem_enqueue().

Commands to trigger KASAN UaF detection on a drr_class:

ip link set lo up
tc qdisc add dev lo parent root handle 1: drr
tc filter add dev lo parent 1: basic classid 1:1
tc class add dev lo parent 1: classid 1:1 drr
tc qdisc add dev lo parent 1:1 handle 2: hfsc def 1
tc class add dev lo parent 2: classid 2:1 hfsc rt m1 8 d 1 m2 0
tc qdisc add dev lo parent 2:1 handle 3: netem
tc qdisc add dev lo parent 3: handle 4: drr
tc filter add dev lo parent 4: basic action drop
ping -c1 -W0.01 localhost
tc class del dev lo classid 1:1
tc class add dev lo parent 1: classid 1:1 drr
ping -c1 -W0.01 localhost

