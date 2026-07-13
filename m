Return-Path: <netdev+bounces-306994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gJxXOew9VGoHjwMAu9opvQ
	(envelope-from <netdev+bounces-306994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 03:22:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D49746709
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 03:22:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=J3YeyoM1;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306994-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306994-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D93B3007649
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 01:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CA8256C61;
	Mon, 13 Jul 2026 01:22:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7B242D72
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 01:22:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783905769; cv=none; b=GWx1u2LniGcM2M3dWJMpvMiG7jOWob5EnlS1jzzsRNHIxKCPKmjFXKJdbEqGyw2CMUY7wTmWqPw86afGoG3WQ6ZCLydqBZqJsG6PNlSk9iKriPHWAnf9TvyTDEl7yBqbab1FK+S6RHeMOvSM6VzSlW5wZlvTv9y9ikCHFmj+t40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783905769; c=relaxed/simple;
	bh=r68fvNfyB5iq5zgmcYtQh4f4Sqo7v+mUf0FuLyud6fI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y9vhDT9/OR0QoyBmlkIHoWGY9RLftd3nnZyNyIn0ibxIpvd/HqERPqQUROsd7VIcAsoO7vMCgMBI19Of2CYKT3suJKXZgZpeIzj1EOamk6ZuOgAYYSOVywnlVToj88wf1LFfMt7tDdWGMlE5TV/JQBUqlsTQQeq7QHK6AMHXQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3YeyoM1; arc=none smtp.client-ip=209.85.219.46
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ef7b7651ecso28567046d6.1
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 18:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783905767; x=1784510567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NTLeZyR0HQahPotCRM69u6fZXEm2pgRfmSKzmsE+130=;
        b=J3YeyoM1w+6qxDuYW43WQT4HAXKqRE5ettOOO6O4AWpdSWrJUqNDX8NRabrHbapzrW
         YCPgqiQJZe0Sltd2ORUggUwSgXpjIGaZhfOAfzBzbMAfcDP9+C8gWDTK6FpQeGkuha9M
         4rc8ywj1QWcTb6NTlwsaDKvmn02gJfUTS+oLu+FnbDt1aenvwgjiZUr8ImyCbbh3Iy2c
         5AzBGhlAdz1GyQ54UWp5nWJ+JpKLw/0RErzDI1ZPkZoOca4MdJQCYgclC1Rpae4Jaefd
         PQmuQeBkjDKbldd3N1LzBoVHD1Ni/onM+hJ8KDWDqZYoN8GTkVpzA+Si4MHd1I+A+ufr
         BRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783905767; x=1784510567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NTLeZyR0HQahPotCRM69u6fZXEm2pgRfmSKzmsE+130=;
        b=BcPsBP6M3UODI5eJatjD8rFcTQhH8JXHYBLfoMJisdZH6Zq5uuMihtASMrL7DtFGlq
         wgeUTPznEqdqd1oVmp8AFq+dWQFeSq5oJ/Ylkpl5pCjiyyib7MNpASHqA7AJbgdiDpSb
         aFP0lhCyabKxKHOtqQBcSsM3mmB/UCkVXLZXkrvQjcJY7D3c3hWVrYDxqFos+YB1vPXE
         AKd2wD6TGnPcWogg7KSgMe+7zs+0L8aJWUIAm+13U67sys3JgeEngP51JeYhreSB3IjK
         et4wJPT/IvTBQUxyvtTSZnAbxLZOJdsNQqesk10DpuUFcGwH18XW+n5oO/2vZnP1IzSL
         i5rw==
X-Forwarded-Encrypted: i=1; AHgh+RplLl8kr6EJ/UT+mup0R3qyBazns9xZePm5ApDaGNQrg3dRMAvLQkrOxa+cqqcUWZo83eSmdCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/vkYbSlu6b7hNmDasvOMaMSyI9wziw0Ple5QrcSNdJ1kFly7
	dIqp4fiPWDRmYiSkmmNsrpKR53KKQY+rlHo/BckRLp6FzzuQMkz6a0w+
X-Gm-Gg: AfdE7clrc9xufmihzhPBtWB8YnjYuOJ7Hd0Exi6GbqoSQQcrel3Wr0Yu5SAuVCRlhIy
	obDT78rObjD6k2AgxWgCAkiW2q8WEyvjlXAd2GRPlrrL4sMwl5UwtZXcMet3QA8OHAXQyWGUHwc
	B72Jr09pbFHDFmnp8+G/LSGdFpfqjDV6N/jW/G1XpuVTRgtrifCdrRzJAdNSUry/tZZyCWLXX8H
	wSZoslypV0C+lqPw77VwiOF7/Na+x+VWrD0ARMK4P3ZOwyb8z8zNWNYWHBxlYLcpdYM1D8dlIQl
	xomA9mUUTpceiabkfAcAcoDl2Tv7RR8Ck5aclo9Ixmfz4lmbFra/4KVoM0d6MZ9QtVps2D3Ojyn
	Fq6af1WC/u8U8otEPheqNc5eARutB05ne45J/VL3sdaCw76OMCckohSDKSzfJpt0RKieix5Zzbh
	zz7fUwPXpTaWXIIj130YyQQSGPmc6pb2xphkP+uyJtzQ==
X-Received: by 2002:a0c:f119:0:b0:8e5:8d7b:5188 with SMTP id 6a1803df08f44-902351409fbmr120041846d6.9.1783905766785;
        Sun, 12 Jul 2026 18:22:46 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87cad3csm117151996d6.48.2026.07.12.18.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:22:46 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH net] nfc: llcp: Fix raw socket local ref leak on rebind
Date: Sun, 12 Jul 2026 21:21:11 -0400
Message-ID: <20260713012111.4066423-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306994-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:sameo@linux.intel.com,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shuangpeng.kernel@gmail.com,m:shuangpengkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linux.intel.com,lists.linux.dev,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58D49746709

Raw LLCP sockets own the reference returned by nfc_llcp_find_local().
When the bound NFC device is unregistered, nfc_llcp_socket_release()
sets raw sockets back to LLCP_CLOSED. It also unlinks them from
local->raw_sockets, but leaves llcp_sock->local pointing at that local.

A subsequent successful bind on the same socket gets a new local reference
and overwrites llcp_sock->local. The old local reference is then lost, and
the final socket release only drops the new local.

Drop any stale local reference after the new target local has been found,
but before overwriting llcp_sock->local. This keeps failed bind attempts
from changing the old reference while preventing a successful rebind from
leaking it.

Fixes: e6a3a4bb856a ("NFC: llcp: Clean raw sockets from nfc_llcp_socket_release")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 net/nfc/llcp_sock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index feab29fc6..0c00cdaab 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -152,6 +152,7 @@ static int llcp_raw_sock_bind(struct socket *sock, struct sockaddr_unsized *addr
 	struct sock *sk = sock->sk;
 	struct nfc_llcp_sock *llcp_sock = nfc_llcp_sock(sk);
 	struct nfc_llcp_local *local;
+	struct nfc_llcp_local *old_local;
 	struct nfc_dev *dev;
 	struct sockaddr_nfc_llcp llcp_addr;
 	int len, ret = 0;
@@ -185,6 +186,11 @@ static int llcp_raw_sock_bind(struct socket *sock, struct sockaddr_unsized *addr
 		goto put_dev;
 	}
 
+	old_local = llcp_sock->local;
+	llcp_sock->local = NULL;
+	llcp_sock->dev = NULL;
+	nfc_llcp_local_put(old_local);
+
 	llcp_sock->dev = dev;
 	llcp_sock->local = local;
 	llcp_sock->nfc_protocol = llcp_addr.nfc_protocol;
-- 
2.43.0


