Return-Path: <netdev+bounces-80165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3B987D4B8
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 20:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E572DB22DD7
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 19:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459CE55784;
	Fri, 15 Mar 2024 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="B8iM9QDV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182BA4CB2E
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532517; cv=none; b=JH2gbR7KeeH4b0SVs4QtxkBXHRu44EfK5SGrXB8hPF/SkCnitmQN8lzJLUrEOuagxG+0wuBHgGZQJFX5faASEZ1+dCk4WIQlVr1f0oPPk8VLpfP30QfMKf+ZHBoz9cvQMxmJdSILAC50fbokwfvNYvihus9NbYnKoik0lw5RgNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532517; c=relaxed/simple;
	bh=WZXQ3n6OAHQk56baal6CzZ+snXfrxRm2xjx8a0VoWYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuntBKWnjrqzQNqh/+URQbC5TSe+2PDgtx6qgGAMJx7GTZDH7DEMnrrAdUzSFSMuD9apfbMG6swiPCgw2DkGcKI5p1uKm9UG9DEjgOwID9HSQhtDGhkMpcUULkC7WGoMi5Yg9k9FM3XM7cjoQCZS7zviL1aaAHjGDZw6pmfgRPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=B8iM9QDV; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60a057b6601so24691887b3.2
        for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710532512; x=1711137312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JuTpc8vOHdn72vm+nW+iFZ+lBgZnpQ42Xv3ej2YV4rQ=;
        b=B8iM9QDVZLZoUQZ8+NLabWS5GVaGI8Isyl0UZeZNi6c7bxWMDdD9oOzjKm+InlbPtd
         nLtyh/PmJjVYabW8/ArekKixTswp0SJY9jxQLAy4uANQmBoi4FNZ1kEf5v58iLn+lflE
         cvSy0WnZRUsVqeCOG8yHqRq/VircQ3NdY/VOZD652Ya6yioJSClcndMz7Dx9NliOLBoB
         Uxa3CffXk6RcH7qLIVVsFtAeZ80I8beZvtT1jSBwmrg8C3oATJ0UfNWGDuf0HloYEFBq
         7jlSpRAKasi40HOg/8QIJWkHFfbcSgJ3PWlIFSYEk+rSGMjFBxHTM8sjYzkGwID1e5oG
         xIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710532512; x=1711137312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuTpc8vOHdn72vm+nW+iFZ+lBgZnpQ42Xv3ej2YV4rQ=;
        b=mtmST8tcaGxW8sglQPvBNvEys2J59/Gt7lWXstIhzFRuNaNIPnCSZZttBolEMjGpUL
         zC5UbgtMJRbhWI789otsblwiKzInu9ph/yHBOh2SSnhQ4svOQE999+oCVj9B1qk2wv9Q
         BVO959JAVuIICApgNrCYxrXliwbT1pt85iZsXGAAy7L9YiHbcjaYHVVVOaqibS0ltRIG
         VkJ+oU28IclUUCFgcqRV+pouCpM2rE6N5TfYrdXB+0l35OujpxZ0vv0/wxNvLbuX1EQl
         YxFAtGa5nr9CIbHelQZInIDHiv0gLl/6rkHYa1Ah5PzvqR7TXK0kSBYLsZ3Sz1cXHQSa
         M/Xg==
X-Gm-Message-State: AOJu0YyvinXBVaUVr6ARqgHFNcs0ndgkfrSD1vQWP9PvSqIcDqa1DMZ2
	Qc/hVIRJ1/5wTbjl4cza7kSzP5p3SO9EVdAvGv100M/SHZLaK6ZQdxmnE3RmSHrUzTlf0lWTnk/
	FGNk=
X-Google-Smtp-Source: AGHT+IHyogcIr/Qsc9GsN9jZgtkStJ86LGPi25CEyZtC3+KaxMDzrcvpAOvf7tMwDDJPH7QLO3rHqA==
X-Received: by 2002:a25:ea43:0:b0:dc6:ff12:1a21 with SMTP id o3-20020a25ea43000000b00dc6ff121a21mr5517436ybe.31.1710532512300;
        Fri, 15 Mar 2024 12:55:12 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:1046::19f:c])
        by smtp.gmail.com with ESMTPSA id j6-20020ac86646000000b0042e2002ed12sm2251399qtp.57.2024.03.15.12.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 12:55:11 -0700 (PDT)
Date: Fri, 15 Mar 2024 12:55:09 -0700
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
Subject: [PATCH v4 net 3/3] bpf: report RCU QS in cpumap kthread
Message-ID: <c8a337e11bb4843e2e1db4775f16518c18545950.1710525524.git.yan@cloudflare.com>
References: <cover.1710525524.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710525524.git.yan@cloudflare.com>

When there are heavy load, cpumap kernel threads can be busy polling
packets from redirect queues and block out RCU tasks from reaching
quiescent states. It is insufficient to just call cond_resched() in such
context. Periodically raise a consolidated RCU QS before cond_resched
fixes the problem.

Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 kernel/bpf/cpumap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index ef82ffc90cbe..8f1d390bcbde 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -262,6 +262,7 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
+	unsigned long last_qs = jiffies;
 
 	complete(&rcpu->kthread_running);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -287,10 +288,12 @@ static int cpu_map_kthread_run(void *data)
 			if (__ptr_ring_empty(rcpu->queue)) {
 				schedule();
 				sched = 1;
+				last_qs = jiffies;
 			} else {
 				__set_current_state(TASK_RUNNING);
 			}
 		} else {
+			rcu_softirq_qs_periodic(last_qs);
 			sched = cond_resched();
 		}
 
-- 
2.30.2



