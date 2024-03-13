Return-Path: <netdev+bounces-79712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF0E87AB13
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 17:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB181C2112E
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD44482DA;
	Wed, 13 Mar 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OgTGHzNv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC34E1B3
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347158; cv=none; b=aEF37hHAXecuslU6pfLrWW9zKihDanmg1gtJxS5z9rz9gr1f8IkYxSIXgXqlzFQ7TNzXf7uv6XiXxPcy+OVmOB7XjAehI4yB/WU3mqzPKuzGChOxDAcW0Kyx43emp6q5wN+UdEZI/04UUE8kIbiYQ4lIOpGcb6ds8zriFEFVPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347158; c=relaxed/simple;
	bh=1+v+hX17pdDJJ6b6jYIIjDKh50fBpD8puF0YHUfUemQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMn8nPX8IwNqkQ2OwaCmXijaKn0ISo1NvGUwtLUBE4JxuRIqPD8syvq25hZzEXADBOp8EG+7Xu+rZIKfjkq7sDM0pVP/EiGaZpzu1Qrs7hChJ4R8NyNjoYyhFgdr/wz7oacpivne+voFRoPbIrtS2DZcZ5M9j1ADdSl06Ge83m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OgTGHzNv; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42f4250a382so20346971cf.1
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 09:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710347155; x=1710951955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zuZkoM/pNXkg3fwRgcPCCwXFIp95GZp6NoxUGsneVz4=;
        b=OgTGHzNv8DL7sPU+pYpZcazNi/0ETXxuLOa5V1z097C80bO+gxIi4ImuaAne7AgEpQ
         nB4wzP19UO0aWqwcHTrcpMWHYDVlQGzXbkKIIizx5Jq+Gb12ZZXplh+Z2efe0DDkFF8S
         9y5YSC5TB1e1PjQoTbMJtbTv7x3nzriddVec0+NWiojZ2Ivdlm4L43V19Rn3C90NHJpw
         P9D4utQNZM4ZSpJB27cafYC4MingLA1wHKTcVQa3hL/b+D0GorfVwRXMj5ajVo7KL0rb
         I2pxn7VQIZWUlia3hln/UUZDTHacIy+mi891u4BcLdfMqcfgI0kB+6We8lJjkCxXF474
         cOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710347155; x=1710951955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuZkoM/pNXkg3fwRgcPCCwXFIp95GZp6NoxUGsneVz4=;
        b=OaOCaexVksiGjWoa/Ia/bpLfeXh5vnuPfhsjqoGWGbhQAG6mFk5/jpEA+Btl/F2/Bh
         BD/7tnsM9AvKbqkH2CyZpgZTzbt53V11lhLJRXSgi2kqby0sv0bVZEdZrYQuZ7/yDgbO
         +w9uUIfurdOS0CjFpYH9RPahkmy0I55n37Z37diH9v9swDah67F6X7h/YftxyxhTfqOj
         pEIPcn2snd5NnkdB0mI9rQZnDx7GWbYj5TY64K6fBEXMNCMclni6NqP1UqpNjNxvI4ID
         ZQHWW3T4AZPQi3Ng0CuG6piYzRbdj7gHJuf1lpc/orVLsIvfykBjENpJjZDBJq/uwO7K
         G45Q==
X-Gm-Message-State: AOJu0YyEnpvOTaQ4sqbekaSV7tSD1SWueEbGRbyT3LwDGostLxzrkm8f
	6k2OX/kxI4GeIkN7dtv4zMf7sjOONgVReIXUnHAnRbqM7oX7n361CQ/ad3k7NNUQvDEvujWx4gR
	pBIQ=
X-Google-Smtp-Source: AGHT+IE4RSELlhIjyVIl9mdoB2c6/y2ghhFHfvK2xWIoar8kwAstJE8efv21r1w2Khjmt3u/eHzNNw==
X-Received: by 2002:ac8:7d55:0:b0:42e:7a9a:f13b with SMTP id h21-20020ac87d55000000b0042e7a9af13bmr17444916qtb.58.1710347155602;
        Wed, 13 Mar 2024 09:25:55 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f91::18d:37])
        by smtp.gmail.com with ESMTPSA id k10-20020ac8474a000000b0042f1c348853sm4948440qtp.21.2024.03.13.09.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 09:25:55 -0700 (PDT)
Date: Wed, 13 Mar 2024 09:25:52 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [PATCH v3 net 2/3] net: report RCU QS on threaded NAPI repolling
Message-ID: <c8c7a84eca24c900c154f4b284067b13520fa37c.1710346410.git.yan@cloudflare.com>
References: <cover.1710346410.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710346410.git.yan@cloudflare.com>

NAPI threads can keep polling packets under load. Currently it is only
calling cond_resched() before repolling, but it is not sufficient to
clear out the holdout of RCU tasks, which prevent BPF tracing programs
from detaching for long period. This can be reproduced easily with
following set up:

ip netns add test1
ip netns add test2

ip -n test1 link add veth1 type veth peer name veth2 netns test2

ip -n test1 link set veth1 up
ip -n test1 link set lo up
ip -n test2 link set veth2 up
ip -n test2 link set lo up

ip -n test1 addr add 192.168.1.2/31 dev veth1
ip -n test1 addr add 1.1.1.1/32 dev lo
ip -n test2 addr add 192.168.1.3/31 dev veth2
ip -n test2 addr add 2.2.2.2/31 dev lo

ip -n test1 route add default via 192.168.1.3
ip -n test2 route add default via 192.168.1.2

for i in `seq 10 210`; do
 for j in `seq 10 210`; do
    ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport 5201
 done
done

ip netns exec test2 ethtool -K veth2 gro on
ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threaded'
ip netns exec test1 ethtool -K veth1 tso off

Then run an iperf3 client/server and a bpftrace script can trigger it:

ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t 100 >/dev/null&
bpftrace -e 'kfunc:__napi_poll{@=count();} interval:s:1{exit();}'

Report RCU quiescent states periodically will resolve the issue.

Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>

---
v2->v3: abstracted the work into a RCU helper
v1->v2: moved rcu_softirq_qs out from bh critical section, and only
raise it after a second of repolling. Added some brief perf test result.

v2: https://lore.kernel.org/bpf/ZeFPz4D121TgvCje@debian.debian/
v1: https://lore.kernel.org/lkml/Zd4DXTyCf17lcTfq@debian.debian/#t
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 76e6438f4858..6b7fc42d4b3e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6708,6 +6708,8 @@ static int napi_threaded_poll(void *data)
 	void *have;
 
 	while (!napi_thread_wait(napi)) {
+		unsigned long last_qs = jiffies;
+
 		for (;;) {
 			bool repoll = false;
 
@@ -6732,6 +6734,7 @@ static int napi_threaded_poll(void *data)
 			if (!repoll)
 				break;
 
+			rcu_softirq_qs_periodic(last_qs);
 			cond_resched();
 		}
 	}
-- 
2.30.2



