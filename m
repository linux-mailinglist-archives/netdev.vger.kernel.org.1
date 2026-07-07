Return-Path: <netdev+bounces-305620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y/MpIXaKTWp51wEAu9opvQ
	(envelope-from <netdev+bounces-305620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 01:23:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D812C720618
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 01:23:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BijXF1M3;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305620-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305620-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEAFF301C139
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 23:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F2351C0D;
	Tue,  7 Jul 2026 23:23:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D17146D53
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 23:23:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783466610; cv=none; b=pALeH6Ns8A8JYOYlYZSgOXf9h1qyaRbdh7tBz+/uX8nqf9bv06ljhf5dyg4hyDMK/bnpEtzhW/nM4icEjvEsjEHsTaps3GkAav3bbrCBxHl+t47JgTfxMaa48li/e6GlqHJNe+KdZGcA9pzfK7MHBi19IKZoEA8JjS463i69NMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783466610; c=relaxed/simple;
	bh=mQZ9V1GEmt+VqUk4kC7u7qbTeEFsn2SSRia8xIjBDUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssJXSG0PW38zFvV0seKS8PI+vbrVvVLDLd9vELmzZ91yd4QLy97X72vOQBhVdr2uHo3NrCuHADWokYlkJLjz1Pg3kAmkC+oaSqjEY4tcpx9sapCSz9yLuLX2E1ULBRzwYiwH5FYrngUdHoPYL6vk7siJuh549RDP2qkhjWdkeLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BijXF1M3; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47122683cf3so41886f8f.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 16:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783466608; x=1784071408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7U3MX6ghFE0ZIT9zyJDBq1y0YXrQGQB4NvY8Mq0tds=;
        b=BijXF1M3LAKuAwpy2q3EAlkdQBSTdnE4yNLcieSfh3s1z6Qe22ZmM0TGkuGTZWFAEF
         JHD7UMfTFOa4r/Narufp4TAuYQ712fv/DIMPlTymgo7/mN5AlWFxF8pl65vb9bety2go
         wKT/P0ve0GrONe1W3Fl7y3wBcrimVbxusjtclNe+ng/vw0/wv+atFmDwpH3RB4Xo5EAC
         SiIYtKF0TwCctgSJASjp1NR7he7jtjmRe/FVbQmUegCSZmJKWNhGN1PDut4xzVsQ0+J1
         bsiUEzGbgBFCSoHMBXK0U/w/2PStJHIrBZZ1s8bEKHZMwDDhWRFpvRSu5NunE60ZWK2H
         qAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783466608; x=1784071408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q7U3MX6ghFE0ZIT9zyJDBq1y0YXrQGQB4NvY8Mq0tds=;
        b=sIzh2HRkNZpXYUQRMJLQQDUu8HIao9AwHP2dWqf0lQCC/GkUE+2EokdyMy0copjC2l
         y2esFG53IPYXw9xdxlASQNhn2X7X1VZuUtkiIjQH8MudUvEJSDrAmFy/3MQCYW8nroyW
         CxwxRDCxW++GorxvSffKialfHJdIFu0GfSMaT6lZ9DsKO/eA7M0LrBZ2y20LwLdFxFwI
         mQ6K1uuCFvdPHlXzpGkwld16frxnJB+at5G1Iqv1rGcdPuiUyaiwwEai9OHFkh4d1QaT
         aVEXgjLPe263ttX+H6mzmqXC+x/b/Fvtygg69CoyHBkUDZzFSHpd1K+pOevyDGGDKR8J
         Y9Pw==
X-Forwarded-Encrypted: i=1; AHgh+RrgGW+K9CpN/yqLTW0nfB7RBT/we3V6bj7D07VNX0MP0WI7gD/SNUaUEUhU0VFz8OWqHrJq2v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeGxSadZh4/OO/DjsOikM9MqCgT1+gNmdSwXl7ffbeHzTeUi/O
	Hrw8PAQ/3VnB3+6IBpuUHFV2dTuj+Mcj1ic9ZW/jf20USbtPCy9GAQMqmjrtp7Xm
X-Gm-Gg: AfdE7ck9GDCHZWIm2Y2AxPX3veDSiIJC4tNnF+c/iR7clRQsUSmcPMMYv9uj8YT404M
	dAAWTBNT/URYrB47jAqBgGeSzNZ2R62zFy++uzT8lnl53TTknO0HX52MwiusTyMMcGBtQk2MTM6
	2H0gUmLB1UUWWPAv7CmWP7Q8BAsTKVwOTAlMuR6CVuUjv8ZMmK2vCW+niWY1RQVDF+REzYy2j1B
	4R0Olg6pJON7vv0k42lthnxrXIaAxXME+1zoKe1KnENRnOV/vFVJrrYuWATvKCyS40SKQ4CHw8h
	nTgnmUv+Yq5yuCXxuGOQC3XDLid/f+UXKOr7L/LYzLWMQ2OYhEDhglQB+cV/ck1s31snTfb64OC
	XT8wy+Sx49MCRrrPGU5AKNYJ+RZfEXwH86xe5QFQyq87cQcpX64jVMG2bxHxv8ShcXHKTMGkGuC
	DaOBjL2JWb4tKh7g86JyNTmq84GIDX6eGAn8XA4k88lvh5H4Ir
X-Received: by 2002:adf:e549:0:b0:476:8a:5 with SMTP id ffacd0b85a97d-47de66a2fcamr6207251f8f.34.1783466607549;
        Tue, 07 Jul 2026 16:23:27 -0700 (PDT)
Received: from localhost.localdomain ([151.189.113.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039afacsm35916922f8f.19.2026.07.07.16.23.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 16:23:26 -0700 (PDT)
From: Nils Juenemann <nils.juenemann@gmail.com>
To: rjethwani@everpuredata.com
Cc: borisp@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	leon@kernel.org,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	nils.juenemann@gmail.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	sd@queasysnail.net,
	tariqt@nvidia.com
Subject: Re: [PATCH net-next v14 0/9] tls: Add TLS 1.3 hardware offload support
Date: Wed,  8 Jul 2026 01:23:25 +0200
Message-ID: <20260707232325.61396-1-nils.juenemann@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAKaoeS3misLGVi4wEqQg3OwbisTBfB0zx-i3b81g2-vnOS_UYA@mail.gmail.com>
References: <CAKaoeS3misLGVi4wEqQg3OwbisTBfB0zx-i3b81g2-vnOS_UYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-305620-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rjethwani@everpuredata.com,m:borisp@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:leon@kernel.org,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:nils.juenemann@gmail.com,m:pabeni@redhat.com,m:saeedm@nvidia.com,m:sd@queasysnail.net,m:tariqt@nvidia.com,m:johnfastabend@gmail.com,m:nilsjuenemann@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nilsjuenemann@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,google.com,gmail.com,kernel.org,vger.kernel.org,redhat.com,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[nilsjuenemann@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,everpuredata.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D812C720618

On Tue, Jul 7, 2026 at 3:38 PM Rishikesh Jethwani <rjethwani@everpuredata.com> wrote:
>
> Could you please send the following from the dump:
[...]

Hi,

The kdump for this event is incomplete -- makedumpfile ran out of disk
space before finishing -- so I cannot run the crash> struct queries
against it. I will capture a full dump if it recurs.

The oops still gives the relevant fault-site state:

    BUG: kernel NULL pointer dereference, address: 0000000000000030
    Oops: 0000 [#1] SMP NOPTI
    CPU: 9 Comm: swapper/9  7.1.0-rc2+ #4  (mlx5 ConnectX-6 Dx)
    RIP: 0010:mlx5e_ktls_handle_rx_skb+0x10a/0x2d0 [mlx5_core]
    Code: 45 0f b7 c0 e8 17 dc 58 e0 49 89 c7 58 4d 85 ff 0f 84 4a ff ff ff 41 0f b6 47 12 3c 06 0f 84 cc 00 00 00 49 8b 87 f8 04 00 00 <48> 8b 40 30 4c 8b a8 08 01 00 00 4d 85 ed 0f 84 b1 00 00 00 49 8b
    RSP: 0018:ffffd4504071cc38 EFLAGS: 00010293
    RAX: 0000000000000000 RBX: ffff8dca063b5500 RCX: 0000000000000000
    RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
    RBP: ffffd4504071cc68 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000076 R11: 0000000000000000 R12: ffff8dcaaf984000
    R13: 000000000000000e R14: ffff8dc8383605e2 R15: ffff8dc801b33200
    CR2: 0000000000000030
    Call Trace:
     mlx5e_build_rx_skb+0x6fa/0xbf0 [mlx5_core]
     mlx5e_handle_rx_cqe_mpwrq+0x120/0x2a0 [mlx5_core]
     mlx5e_poll_rx_cq+0xa1/0x920 [mlx5_core]
     mlx5e_napi_poll+0x118/0x7e0 [mlx5_core] (softirq)

Decoded faulting instructions:

    49 8b 87 f8 04 00 00   mov 0x4f8(%r15),%rax   ; icsk_ulp_data
    48 8b 40 30            mov 0x30(%rax),%rax    ; priv_ctx_rx

So R15 is sk:

    sk = ffff8dc801b33200

The fault site reloads icsk_ulp_data from sk+0x4f8, gets RAX=0, and then
faults on the priv_ctx_rx load. CR2=0x30 matches that load.

This is the direct tls_get_ctx(sk) use in resync_update_sn()
(ktls_rx.c:553). It is a fresh icsk_ulp_data load at the fault site, not
a value CSE'd from the earlier access via resync_queue_get_psv()
(ktls_rx.c:486).

So I still think this is consistent with icsk_ulp_data being cleared
between the two reads, with the second dereference missing a NULL check.

Thanks,
Nils

