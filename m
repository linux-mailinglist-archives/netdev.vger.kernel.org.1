Return-Path: <netdev+bounces-300777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EI4vGjYNNmq27AYAu9opvQ
	(envelope-from <netdev+bounces-300777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 05:47:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D789D6A8490
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 05:47:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BDGASgfV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300777-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300777-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA2103025C1A
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 03:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB9A22F767;
	Sat, 20 Jun 2026 03:46:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C713635E
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 03:46:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781927208; cv=none; b=NBtmjmPtT86KuOkY9w9YWTL/5X6mxotDSlqJjKhDCV7+s8SiCRzzxyoteu8lcpkAD28P+vX5eegJ0pYuum0IPhCg50iEayNdW7KXUvRhNjo+xCYll+DFReJVDIL74XG/Y9YUo11W2uMrTU3RQL7Xgmfy6l7SYbtsO2Qc3uu3p8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781927208; c=relaxed/simple;
	bh=3Qzg76vHOmcgRqXqt8NkpIhXJ5YC4/BNbosdNTyIHSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5REBmiuiZs13/AVrj6wj2S/UHc+A4UiuJ2Y6cdRGxywU/HPehx8e4l/fOc9SVDcqh/3cissAqOeTHRpxqwayIHHDfDgSQBTEiX1sgYHp5Sl4b6ZZTkagne6f1xQ+Uam1owzn7jZPmK7cV5frVPpZ9Fr+nE/mWqV3C9TZtAH/NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDGASgfV; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8453bcf7276so1494568b3a.2
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 20:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781927205; x=1782532005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9lOYVWh4m+fhmrtdr8+YU5CQtPB1bE+eoCFLRPIV28A=;
        b=BDGASgfVwaVIAadGajdTFbnOw9w9ybYWTGU3tTFY2KS8jbmxYiKM4czkVdSbXwR0cR
         BMfAcSI23YWBpiozRViDKmFD3l/nLAXuKxpHEBroxDxtFq+VVHgeXUoCfMWS7Np2OWtx
         vfiO4dBN/IJ9mdePzqxFvsTEEgkyLNQXQZ1nlhMdFHexG3VLG5EEM2XlqcIWPBZPczuH
         tW6OsCCaOQjGlBPFQaJrbozz7KHodH21l+UqLaYMlvyxjnKGwIbgcMV3i2nhMcj5S+fO
         EppJ1M3VoBjSBDXpYVNnhopkAS6k93jL4Fstd2nJzB9x1ti9+XfjmXXYOAZtJq0d/icz
         uJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781927205; x=1782532005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lOYVWh4m+fhmrtdr8+YU5CQtPB1bE+eoCFLRPIV28A=;
        b=KUIA05K3ycoXilxbRv3hs5U+I5OIl++lo8gXTGdasbuNpnAGQiK8Is+OculmGP4tWp
         isg1Q2U3VS0fp/I/E5oRuL+NVJYPfvOfw04w6t8mYXtMD8UAtji3vRM7w3BziF6kyYef
         6W3uBstcPvPr9huXrQZmWUjamUEXHI6QO0TF02h3giSdwlGPRd7cE+5tM9UuUCkk4c1o
         /MRDlBsOqL8E8kMKr8Fmc8AuYBa57mnMyRqrNH5mz2P56zU5pyAwuWERFvd3ayazXzb/
         1mK6edYJ04TaKfWJchfaA8S+XV0h2FtByV5CqKRS03bX26eroPjOKIMhjLKreQvKMnH3
         AbyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9TeEDqFTB7t4EYYq4rPq5tEvFTuY7RW/hn0dut4VDJPoQlP7HlhJPwCZOKng+g18e4r6N1v1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YysbC9esTDapkP8yFRi0indAUjsxjRVyjqLK1CvetxYC0Qa+iwx
	3goaivvObpPVJkdqMeNN81wO3+WRjXe49CRFg4pVAJbpjhA0i1kJLsru
X-Gm-Gg: AfdE7ckwBHO1QoUFRIKzgg1da4SEjrGTHmSh84GiInIJfzwk1HrTPHZztMtAkqYe4K5
	jtnHd8HbN6VOWu9yxGNs1dsnq5EUT/JEJKneiB2ZTjT/pSJ2UbTY421oQsTVBbVKrik0IhGBlPS
	azckMqbfqRg4Z0UuJcC+T/1XYLWhagWuNsF1rDh0pl6HoEXCL2TYZClRXWmPW5ulkD7p1LDBpdZ
	9HxJ6txqC1QZwyNM4tTtLUE6faxResxsQEuEZx+vzERWqivjy4yEQShbpaNBwhTOMf80Ee1ED7y
	EppkYxq+0kw89q3Zm8MLB0W8lJJdtVamCKga8ynTQ7hxs1ZIoADG6RX2EG9tEHkwE2O/dIQFOdZ
	aD3veXSNCIoqIhnVu3hTYM/UJfG47pywrRXvilOV/zJ89/Hgxs1Qf0H2BsoROj6s0hwHd3vv8zD
	G4UsNinwfvrNHJfHvsbyramiZfSZxMraod3XaY13aPMwbvTKZzM5c=
X-Received: by 2002:a05:6a00:9296:b0:845:286d:4675 with SMTP id d2e1a72fcca58-845507c1c40mr6335507b3a.10.1781927205187;
        Fri, 19 Jun 2026 20:46:45 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ee3dc2sm701458b3a.58.2026.06.19.20.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:46:44 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenz Bauer <lmb@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v2] bpf, sockmap: disallow update and delete from tc, xdp and flow_dissector
Date: Sat, 20 Jun 2026 03:46:23 +0000
Message-ID: <20260620034632.2308-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300777-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:eddyz87@gmail.com,m:memxor@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:sdf@fomichev.me,m:lmb@cloudflare.com,m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D789D6A8490

sock_map_update_common() and __sock_map_delete() hold stab->lock and call
sock_map_unref() -> sock_map_del_link(), which takes sk_callback_lock for
write. That gives the order stab->lock -> sk_callback_lock.

The reverse order comes from the SK_SKB stream parser.
sk_psock_strp_data_ready() holds sk_callback_lock for read, and after the
verdict tcp_bpf_strp_read_sock() acks the consumed data inline via
__tcp_cleanup_rbuf(). The ACK goes out egress, where a sched_cls program
deletes from the sockmap and takes stab->lock:

  WARNING: possible circular locking dependency detected
  7.1.0-rc6 Not tainted
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

A tc, xdp or flow_dissector program has no reason to update or delete a
sockmap, and redirect does not go through here. Drop them from
may_update_sockmap() so the verifier rejects it. It also closes the
matching sockhash inversion.

Fixes: 0126240f448d ("bpf: sockmap: Allow update from BPF")
Suggested-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
 - reject sockmap update/delete from tc, xdp and flow_dissector (John
   Fastabend)
 - fix the changelog (Jiayuan Chen)

v1:
 - https://lore.kernel.org/all/20260616091153.2966617-1-rhkrqnwk98@gmail.com/

 kernel/bpf/verifier.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..94d225521b5a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8766,11 +8766,7 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 			return true;
 		break;
 	case BPF_PROG_TYPE_SOCKET_FILTER:
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


