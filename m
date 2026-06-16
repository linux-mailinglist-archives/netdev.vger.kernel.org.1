Return-Path: <netdev+bounces-299805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id quphNLUqMWpIdAUAu9opvQ
	(envelope-from <netdev+bounces-299805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:51:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3298168E7AF
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:51:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sibbuWwF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299805-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299805-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AB1A300B3E7
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7ED3A48DF;
	Tue, 16 Jun 2026 10:51:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75842847B
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:51:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607091; cv=none; b=dSRFel0te9jNrkdpQ16k1uiD3dnGYodFyJbZmlzEzp8iny/A1/roVIxtQrqVmIhVJRWem0NLmKz3UDiVFZfVhbP3x5XdbrqsYGqDYEF6C+gkY94eWMzppxFtckOjaFgFgP3b+POV6zA31lJvGdw21e5iciQjFedFX0sT7YOwIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607091; c=relaxed/simple;
	bh=BYiitEcXHhRh6eR+a46Lb8G8JNceCCN8CajnI0gLC0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lK7ZVgKIQSWE8d6poxqBlStq0LS9xBpmF3h8m4HBR13S/BZmILUqOU+nNqhQc4c+y/CRrJxk1awGIiYNt9cGp6DNHb1vLHENVIlcGiVjhkTsUTT1up0j73bIJT/dsYBSbWpDb1u2ArfEfI+Ay7jRCFQfoB17gZDMoCFP6LQDQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sibbuWwF; arc=none smtp.client-ip=209.85.208.68
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so7967483a12.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607088; x=1782211888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cBInyREsNJJq2tfrHgYP7popCDV3FF08GB9ZJkZM/f8=;
        b=sibbuWwFCWtlXfTITbG3+OP1mWql47pRKcUL9ZVtifRJFeXRp6NIgf9DXmb+lT743h
         aTm1+/KEiylkJS/4/W3FG+mwfmhOD/ZAF0qCqjk7dHfFSdF2zY9/ZJjTx2aKvfA+Brlx
         +7ussk304r43dkpg9nEoBxrKcsdE42j0P2lnkW1QRW0nYYqw0c2wSBOjJaxFYzrH20aP
         CYldhhXjp62utEsbfNB62s700mPVv/pq4sx2nGD52c5Ak4KcnKzKCeh1wzbMfJFGogLP
         GWYfTNkfn6fIgP6okj9aLE9MG5Lqn0vhokrdPX7BNyJ+gA5IR3XuBxTbybUMICtyclfo
         td+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607088; x=1782211888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBInyREsNJJq2tfrHgYP7popCDV3FF08GB9ZJkZM/f8=;
        b=amhNQauWSr3FDWdj2xSQ8n2r0Vtt0QE5Y/K74RJy/nmGfOscxhB4ohC7pZ9rvE9rDi
         9GdwL1SZG3rBh/rNBaIq8tLKz+18WvvW2mJl+MpmaLmHBBPT0M5RGjIIQdE0TqDNvZkE
         FJ60oQflBaRvDQCPY0RemPxD92cb8szjkOkb0n55cvzbpSaEXqJHWyd2W1RFc2ZPAbnF
         LxKJUqXGfdukSxNilwxdprio0+jMpyMskR5EuEujLkHammAnX/mfhItcQ0QtM6f4Pi14
         H0/tSxjVzG/CYKuPHZiFYsUpeLhxwKYKgXQcYPO/F7KvIq1M1UI9kRAT4NmPrJbtPRhQ
         TZaw==
X-Forwarded-Encrypted: i=1; AFNElJ9CA+5TjWiCXAlMDx9La67xEiP5kcS+2EQsg+//MK1/F5LKAdYziqZIo/FLL++h4uv5UuIO8NE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzkj/y7ynTyQrTmQhIPlpzxQTHSFSRTOfQM9sUiaMsbzkDePaB
	kfX4B7CtQFsjTJXI1AW+fRAjj8FlNXAIbxvofuPGxWy6jKq93TdE5Sbd
X-Gm-Gg: Acq92OH5EPMzP5Cd7ONljIGzpBsTxSMS3q70RrbtAfXYzdzwLongf7EzV6OUn4XEujz
	kTHKXY7qxCFaLYgYSIExF9jqrBoY0/graa2806dgb4P+joMzgRiW+easR7bG5gaLDGBqG2tZHzY
	WkD3cGuQ68UUJu/1SHLRyfmH6392tgNFpV5p7GcI1ZaRaIjiMm5uh8HF9VV+vzIx27abb8RKTq1
	ztuWd1T41YLkWrY5E+NbmGyfRzoJhf6nFwJeHTP6EnWfuxqX9XQzCiNJFW0tMVGO00/JI5AkiJa
	Ur5QDupRNidE4BNQN3HdOW781zDBN3VD0yVk7iToZFryd+s+WF+uuNvgst5yO6jp04R4cDtTpFx
	SdZIRFZCq1IHZeA7RpRfD87hdLJmPr9UXhq9hgOlq8uxOS1G6n8Xjkrly19aQ7dMHqwYTUnceOM
	7/vW3qpzZ10hUcKk86iWwLtBsUm1C7qjVkk9TKa7efpd6YKplsZRjPl0JDHHuZaBAN4m4A
X-Received: by 2002:ac2:59cf:0:b0:5aa:6c2f:2a20 with SMTP id 2adb3069b0e04-5ad427a8bf2mr621532e87.30.1781600513392;
        Tue, 16 Jun 2026 02:01:53 -0700 (PDT)
Received: from cherrypc.astra-academy.ru (109-252-17-231.nat.spd-mgts.ru. [109.252.17.231])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1715d4sm3301048e87.34.2026.06.16.02.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:01:52 -0700 (PDT)
From: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Willem de Bruijn <willemb@google.com>,
	lvc-project@linuxtesting.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH 5.10/5.15/6.1/6.6/6.12/6.18] tap: free page on error paths in tap_get_user_xdp()
Date: Tue, 16 Jun 2026 12:02:01 +0300
Message-ID: <20260616090202.693916-1-nazarkalashnikov0@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-299805-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[nazarkalashnikov0@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,fomichev.me,oracle.com,vger.kernel.org,linuxtesting.org,asu.edu];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:nazarkalashnikov0@gmail.com,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:dongli.zhang@oracle.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:si-wei.liu@oracle.com,m:willemb@google.com,m:lvc-project@linuxtesting.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nazarkalashnikov0@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3298168E7AF

From: Weiming Shi <bestswngs@gmail.com>

commit 3bcf7aec6a9d16438f2cec29f5d7c8d5b8edf9b2 upstream.

tap_get_user_xdp() rejects a frame shorter than ETH_HLEN with -EINVAL,
and returns -ENOMEM when build_skb() fails. Both paths jump to the err
label without freeing the page that vhost_net_build_xdp() allocated for
the frame. tap_sendmsg() discards the per-buffer return value and always
returns 0, so vhost_tx_batch() takes the success path and never frees
the page; each rejected frame in a batch leaks one page-frag chunk.

Free the page on both error paths, before the skb is built. This is the
tap counterpart of the same leak in tun_xdp_one().

Fixes: 0efac27791ee ("tap: accept an array of XDP buffs through sendmsg()")
Fixes: ed7f2afdd0e0 ("tap: add missing verification for short frame")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260521163230.1478627-2-bestswngs@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
---
Backport fix for CVE-2026-46320
 drivers/net/tap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 6fd3b14273b3..b51ce7af1b20 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1052,6 +1052,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	int err, depth;
 
 	if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -EINVAL;
 		goto err;
 	}
@@ -1061,6 +1062,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	skb = build_skb(xdp->data_hard_start, buflen);
 	if (!skb) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -ENOMEM;
 		goto err;
 	}
-- 
2.47.3

