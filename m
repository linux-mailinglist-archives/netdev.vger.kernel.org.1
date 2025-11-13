Return-Path: <netdev+bounces-238475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 085D6C596BA
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 451254E7F6D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7122E2877D5;
	Thu, 13 Nov 2025 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="16QlJh6u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F99346763
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056401; cv=none; b=QfM4aB15dhxgeWrRv8FrWshdLN6I1WuKq1sA19Wv1T7RUD7ikjjAg241GM/7HNk24zYjqNsCvmDkPpq71eP7KYtRVAyDFwA8pLeMTIro2JvuO6gqti3qIi2a2gGm1/mgBJGrlOQ+yZjW16cUBMS4B8S0NpqahX2qV6UAJ7djLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056401; c=relaxed/simple;
	bh=t5Pq0Gq2dcc/YKJPCkypXrdYl3RPqio5qQNZF+Z7Y6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfFWVTM1yB4kJv4tHi2PJcxYR+WuQBtZ5VIqZ1CE7d50PezrV1J7zklrmH16PZYwshj0LLuudyQs8FpRtOxYL+vvxyQsJgowMUZFSUzjAiYsT3br+fbjabVHFnkyjnOYrIb7+JsedmexYo/5iUoXfgoGKPJmpAObybQz1zL8gVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=16QlJh6u; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29844c68068so9822015ad.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 09:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1763056399; x=1763661199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=knyvx0r46e0/fyeifvBAIH00pzG9yrBv+mLt6EyLN40=;
        b=16QlJh6uXmZryZUGowd1o50io8CAtFFuc+RWo3u/tOvrqrAp5iHE0tRP+VvO1lkeyK
         Fzaxz9S4ibUYVN1pV4qjhRmsPrE/X/CJ/OpJW9X6QKP8RILptkub+uHDdbI0O2K0V2s8
         pYT+dRgxBHAOUYc5b/GsFWOsQXGb4JhQOKY0sIalZWGV9rC/flY1tVkVYqspm48RRTDY
         STYj/bX2i5ydxYB+8K6+Z3877Z6hial5vdQBiBEoff0E4kGIgLjbFleJ8WiX/qqftX4G
         RFCbvVh7f6wInqPq/0q+XS+0OxNgVI/+I6aorkhIspLSaQX70NheNfWSeeMRYenUpEuQ
         Q+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763056399; x=1763661199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knyvx0r46e0/fyeifvBAIH00pzG9yrBv+mLt6EyLN40=;
        b=oW3AnlhOk8T4bFOeSR9xkkWCKyNft4k6rIwODmFWKJDiV23cqobHTFWkXxxikIi+tG
         DfokhspFWx1pFrkt9o8/4poG/HcaCKNlbrbfzowocNXEoG0B++ilAxNbEww7pzHUGN73
         jcJNSIB8LwqFD6X5WAcQJZcWTNtzG7rczZnp/dK2Q0yDg0ciZp33Wx5uXwrJ3L0AD6Sm
         ojpwcb9DZajPjJJ3KY14QRauw0i84ilutzfvWRRmQv/dhvLQuvQAE7hGuciqk20jHxT8
         g0aF8XcgNaCwz4JM5pURnFU7/uemyBBTRSuz9ilYixRWQe2oErP5ftg4nCmByEt/SUWe
         rvMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqtMemH1UJ1TbjMV+oit84LdjCWB616lmo/29hWnFpX2c1Q5dqNSDgxdeuHXyn/VMRAKP2DJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6DjEkylqO7pZLDd0zW4tx34ITGeE7PMYERV0hmikfg4HhGb57
	JA1sS++nPydjgeBHn+IN2S5WeAI2gKFpoZNYXVOo+wF6eZDt8sroGzPMa53VyJeK/Jj9uIZN422
	gFiHxOzEHFOzLt3bCobmT/3XuTM99jT3BL5LTnull
X-Gm-Gg: ASbGnct+M8+McVC04U59kaMNixTOUDdsqnZ8QCYQy6WzWiHMuI47h64oB9CkSwq02hf
	fmCFDbKiEcJ2jqK/Ygm2sBRZvmy9TQuMvpkMW8S+XbuIPjgMarOYksxfLL8XtpyL0X1jVEKyfEH
	upJgROkScsV0mhsDjvKpXukDwVlnqHBg50Sd3khjp2b6a82t4oNgJj8nbydAKNKfpmLrgHcz9gr
	1RxMlGgLL3dM+mXNtavQ2zCzzgD6GExP8hEb8+o9k2gXM/GNWyPkFBXT3Un5I6SgxI6RK5Pg9z4
	HxE=
X-Google-Smtp-Source: AGHT+IEPcHxzVWgrPQIVoUQhDLCaixyNQmsZYjIffsPhvq3bvO4ylej2Uu724y8vFi6IyFpMpgBYsTAaFfs5/tRCCLQ=
X-Received: by 2002:a17:903:32d1:b0:298:1288:e873 with SMTP id
 d9443c01a7336-2984ede8148mr104793245ad.56.1763056398817; Thu, 13 Nov 2025
 09:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109161215.2574081-1-edumazet@google.com> <176291340626.3636068.18318642966807737508.git-patchwork-notify@kernel.org>
 <CAM0EoMkSBrbCxdai6Hn=aaeReqRpAcrZ4mA7J+t6dSEe8aM_dQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkSBrbCxdai6Hn=aaeReqRpAcrZ4mA7J+t6dSEe8aM_dQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 13 Nov 2025 12:53:07 -0500
X-Gm-Features: AWmQ_bmu90xYCCuJcfzgcp0YLwNFRgyM8ZrvRvzLETRtby2aqqEp5kb_rIm9lsU
Message-ID: <CAM0EoMkw11Usx6N2JJDqCoFdBUhLcQ0FYQqMzaSKpnWo1u19Vg@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, kuniyu@google.com, 
	willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	hawk@kernel.org, patchwork-bot+netdevbpf@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"

[..]
Eric,

So you are correct that requeues exist even before your changes to
speed up the tx path - two machines one with 6.5 and another with 6.8
variant exhibit this phenoma with very low traffic... which got me a
little curious.
My initial thought was perhaps it was related to mq/fqcodel combo but
a short run shows requeues occur on a couple of other qdiscs (ex prio)
and mq children (e.g., pfifo), which rules out fq codel as a
contributor to the requeues.
Example, this NUC i am typing on right now, after changing the root qdisc:

--
$ uname -r
6.8.0-87-generic
$
qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2 2 1 2 0
0 1 1 1 1 1 1 1 1
 Sent 360948039 bytes 1015807 pkt (dropped 0, overlimits 0 requeues 1528)
 backlog 0b 0p requeues 1528
---

and 20-30  seconds later:
---
qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2 2 1 2 0
0 1 1 1 1 1 1 1 1
 Sent 361867275 bytes 1017386 pkt (dropped 0, overlimits 0 requeues 1531)
 backlog 0b 0p requeues 1531
----

Reel cheep NIC doing 1G with 4 tx rings:
---
$ ethtool -i eno1
driver: igc
version: 6.8.0-87-generic
firmware-version: 1085:8770
expansion-rom-version:
bus-info: 0000:02:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

$ ethtool eno1
Settings for eno1:
Supported ports: [ TP ]
Supported link modes:   10baseT/Half 10baseT/Full
                        100baseT/Half 100baseT/Full
                        1000baseT/Full
                        2500baseT/Full
Supported pause frame use: Symmetric
Supports auto-negotiation: Yes
Supported FEC modes: Not reported
Advertised link modes:  10baseT/Half 10baseT/Full
                        100baseT/Half 100baseT/Full
                        1000baseT/Full
                        2500baseT/Full
Advertised pause frame use: Symmetric
Advertised auto-negotiation: Yes
Advertised FEC modes: Not reported
Speed: 1000Mb/s
Duplex: Full
Auto-negotiation: on
Port: Twisted Pair
PHYAD: 0
Transceiver: internal
MDI-X: off (auto)
netlink error: Operation not permitted
        Current message level: 0x00000007 (7)
                               drv probe link
Link detected: yes
----

Requeues should only happen if the driver is overwhelmed on the tx
side - i.e tx ring of choice has no more space. Back in the day, this
was not a very common event.
That can certainly be justified today with several explanations if: a)
modern processors getting faster b) the tx code path has become more
efficient (true from inspection and your results but those patches are
not on my small systems) c) (unlikely but) we are misaccounting for
requeues (need to look at the code). d) the driver is too eager to
return TX BUSY.

Thoughts?

We will run some forwarding performance tests and let you know if we
spot anything..

cheers,
jamal

