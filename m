Return-Path: <netdev+bounces-303266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MOC+B3naQ2oKkQoAu9opvQ
	(envelope-from <netdev+bounces-303266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:02:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 805146E5AE9
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:02:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=o6hsTLBS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303266-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303266-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DAAE313446B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0767E24E4A1;
	Tue, 30 Jun 2026 14:54:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231003D0932
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:54:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831272; cv=none; b=nJbP028F1xU3g6CVGZ3I/ddEf7Y2k2r+1mqNu65BK6KkIj4705fIDcDB+gkTEoG+c8x31QDqd64huMiSqCyM13SMQON1i7qRNApIt3HJnNqC5E+DArMypo84KpvoccjCITRHj5Uc3s3Dx/2DSgPOe5l3PWjnA6i2FaNQbA10cYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831272; c=relaxed/simple;
	bh=pl4s/6iqG4iSWxDnqowahuLLtVqCMT3nY7wajXCTXiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsOF0/u7qi3/6ySmhPKy5xpwlC1IpqWiBWFiwYSxJIm94Fcn6L33gwDMWLF7LR7VXEydRW2u4CsX0LGzSBNjGThNbd/sepjZj2KEulZj/GpQOzD3nyviO7vcoPf+Np5v2HA2j/suVZNY9FNClKh9w+SAZPrmjoVdeJZiQZe8Gzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6hsTLBS; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37f72212544so4358801a91.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782831270; x=1783436070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ggz9EBjbp7saeRSZLMYqE+cKP+mv7VKgG7WqG3xg4y4=;
        b=o6hsTLBSx4Kr7qQlWoowecnZW6X34nK5jfp9LxOj2H9xf/5ikM9Ck4wytu0PbO368G
         nEvftZ+DcoZmYuPU0Vw6S3JSUz9FhEQ/+FxIVJJtGyyeWR+a2SisTQhar99oqDBhPTw0
         w/RTr/Wt70COEN0raSChw0gRDXFPp5X/WUE+I8lH7bL+Zdwzk+fbo+1eTYO6N2dKrjPz
         6Yk1iKbQWOaEB2Tmniea0LPJkgZmM4XEXNTdZ87Ds8CQCjU1sieT6s+3x1VI1HNd5SLI
         xJDdaRv9unuEoXXrNKB7zMhVZDLwlbWVqfkLq833AmNo2tKGkKgNiRpv56RlUUimva2T
         UbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782831270; x=1783436070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ggz9EBjbp7saeRSZLMYqE+cKP+mv7VKgG7WqG3xg4y4=;
        b=r8GvdaCbVg29wP0DDeB3rgIIvOdpZ61gyQhpoY0UUM24sm7+UROVE//QACpnRkDQbU
         tN82Fxc2rPP1lROPZDhDRNSj4GnDpDkVaXQmmNlNsXuz4mbtjzTTdo/5DBUDhjVbAD0W
         VMDSNtRU+R2i4QPnlUcwWR/6JBj90QlbQFAYcq1pmbk7h9FBYlbDtOOolmJfl6bA6BsT
         xdKLbSvwa7my2OfTO9MynE3ZSPm+yai3W2DAUjmKfsc/7enoh/+RErrBJ36e3fKrJsWt
         fBmYVc9f1sPtJyIOCpL39S7fLYgdo4WPIUaZf0CJ3jcRY9/dnGO4dxQFhegxrVKwWwEf
         8WZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKfmjS0PpqhCxIfQ7B7QZxES3kccEiTKV7s0m+JylU/CnQXcVhidurO1ib36ucZDphwCcK1dE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy57KbaNmHyFa+hKjAnhHx1wI5H07CpchAwH4kL3EiwjjkqjnM
	/fUZ43IUGeP6fzxIj75TCOp74Alp5DQihfEH//6UpEqmg9vCYsXWwcYj
X-Gm-Gg: AfdE7cniVOD+PadMZ1499mkmNBH2iXvgqtmOix+CilSeQwAFP9z054aKZcXOcR/y6yn
	UjD8uhAeQ2iPqYW21Y84QtBt68dvqv0s6aN4jKrZPkHMJ56Hn2o/7A+oe8pq9uiB9IiPEdiyJY3
	HfFIQw8SW/2+amxQMVjXVEndc3vYUf20pC29SLqOJvFrGKr3QrTKankVZOCr1u4ash06KeWOWFl
	IUzIc3x/KrkpRWyijvBvUQEnWNXvw7tPbrcr7ME4QaTAud+AFG4QEccBLa4UeR3AMnLPXOFo/iQ
	IKu5uul6kgTwqji40c0rEQuhaTKTv87+HambGeJHoSz0KVoQz3ryJfCqFh2oLVKe+ZOoXhwvyYt
	6XyGNFicYRVW1yv4pN7G8itMgQV+wAqIbgG0NtF13c7ZHB8Lsqfbg6wYaZU5PTxr2KPWp5aZZpb
	mVrqMTiCLD7+kwtf14ySjxPti6hOBfSFUQ/DR3EK1gJaXplOkH+XI=
X-Received: by 2002:a17:90b:3dce:b0:37f:9ce1:cdb1 with SMTP id 98e67ed59e1d1-3808c1035e3mr705579a91.31.1782831270257;
        Tue, 30 Jun 2026 07:54:30 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095b684basm20122a91.1.2026.06.30.07.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:54:29 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 1/2] bpf, sockmap: disallow update and delete from tc, xdp, socket_filter and flow_dissector
Date: Tue, 30 Jun 2026 14:54:05 +0000
Message-ID: <20260630145410.3648099-2-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
References: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303266-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:john.fastabend@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:shuah@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:sdf@fomichev.me,m:jiayuan.chen@linux.dev,m:varunrmallya@gmail.com,m:ihor.solodrai@linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,etsalapatis.com,fomichev.me,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 805146E5AE9

sock_map_update_common() and __sock_map_delete() hold stab->lock and call
sock_map_unref() -> sock_map_del_link(), which takes sk_callback_lock for
write. That gives the order stab->lock -> sk_callback_lock.

The reverse order comes from the SK_SKB stream parser.
sk_psock_strp_data_ready() holds sk_callback_lock for read, and after the
verdict tcp_bpf_strp_read_sock() acks the consumed data inline via
__tcp_cleanup_rbuf(). The ACK goes out egress, where a sched_cls program
deletes from the sockmap and takes stab->lock:

  WARNING: possible circular locking dependency detected
  ------------------------------------------------------
  syz.9.8824 is trying to acquire lock:
  (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
  but task is already holding lock:
  (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173

  -> #1 (clock-AF_INET){++.-}-{3:3}:
         _raw_write_lock_bh
         sock_map_del_link net/core/sock_map.c:167
         sock_map_unref net/core/sock_map.c:184
         sock_map_update_common net/core/sock_map.c:509
         sock_map_update_elem_sys net/core/sock_map.c:588
         map_update_elem kernel/bpf/syscall.c:1805

  -> #0 (&stab->lock){+.-.}-{3:3}:
         _raw_spin_lock_bh
         __sock_map_delete net/core/sock_map.c:421
         sock_map_delete_elem net/core/sock_map.c:452
         bpf_prog_06044d24140080b6
         tcx_run net/core/dev.c:4451
         sch_handle_egress net/core/dev.c:4541
         __dev_queue_xmit net/core/dev.c:4808
         ...
         tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
         strp_data_ready net/strparser/strparser.c:402
         sk_psock_strp_data_ready net/core/skmsg.c:1174
         tcp_data_queue net/ipv4/tcp_input.c:5661

  Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    rlock(clock-AF_INET);
                                 lock(&stab->lock);
                                 lock(clock-AF_INET);
    lock(&stab->lock);

   *** DEADLOCK ***

A tc, xdp, socket_filter or flow_dissector program has no reason to
update or delete a sockmap, and redirect does not go through here. Drop
them from may_update_sockmap() so the verifier rejects it. It also
closes the matching sockhash inversion.

Suggested-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 kernel/bpf/verifier.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25aea4271cd0..83ea3b33ff67 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8488,12 +8488,7 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 		if (func_id == BPF_FUNC_map_delete_elem)
 			return true;
 		break;
-	case BPF_PROG_TYPE_SOCKET_FILTER:
-	case BPF_PROG_TYPE_SCHED_CLS:
-	case BPF_PROG_TYPE_SCHED_ACT:
-	case BPF_PROG_TYPE_XDP:
 	case BPF_PROG_TYPE_SK_REUSEPORT:
-	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		return true;
 	default:
-- 
2.43.0


