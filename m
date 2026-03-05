Return-Path: <netdev+bounces-264540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB4LGTjqqWmLHwEAu9opvQ
	(envelope-from <netdev+bounces-264540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:40:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5920218401
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2490304A9F6
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A9D34677F;
	Thu,  5 Mar 2026 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gni7X/C3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70B34403A
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772743080; cv=none; b=M+TdmbY6pm0MrLQ0/kXFibIA1nnsVLbGipI/40gZRQnSqo4d0OEOWI5GSEANG/3Tvurb/d+qsEul0c7yvacqF7UkpQekNAsrROpkdQg0iPqSaWhJ3NtEghLrmtsISJ22SBMahp4CadBIYfm4F7JIiPi6yU5BrODFgiiayicuyhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772743080; c=relaxed/simple;
	bh=cnxiDzaTG3dDRmVmA/NbvEgeXNe7TfmfMEbBpvNLqsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgRQhXqMJdtyxtRD3ABKHer9wAabWEoYde7PxdtSp+f8C8OS0BhwNQ+2l0lE1ZIJKkHl85S1H46g7n6Xby6nun2xFAe+pA2jpU0bwacvCigz7NuQ/4lPmC9kRCHmlLvSGUjRoU/Yo6W0nd6eAzDPnm8M8HVEsoQCi5zdIVsMkjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gni7X/C3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48379a42f76so73261415e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772743077; x=1773347877; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBymiq7nID2vF4wesRN60I/529SDzorxfefrpkxAGsE=;
        b=Gni7X/C38IFjzoKGxSw36Mv7ExYpAofpud9tmH6C78LpgTXLWvZaDDcuRNH7Lkvdx3
         naAstLwTOkgUPwq91rNedD8X0Sx1E98x07zjT6NGlRP2v3TyCrZgYWctMyFjuphGquK/
         gUj7NPR4NW3RxhAdC+t73Rxn6ijza0Yv7jbQLUwSgROARE1LkM4TY1O7evWhBdCTPHwJ
         KpcYGYUcMvVSF4j6c2kDE5giU1LPq91VIc/Yno/Y2amBPN2zoWUA+JwERA1QHD10YOuU
         vn0GcPV7W6a2b5R2ykzXdrIGlt3IWPlhU971KSDHTVSJRrJUFvkHGla0jyyeCPF02pEz
         TWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772743077; x=1773347877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBymiq7nID2vF4wesRN60I/529SDzorxfefrpkxAGsE=;
        b=lBCxFvqbmWvVvDaoq1t1L9jMreOilPKthkpSrMm/jQLiYi6+4Of+d4968cQo34Kzqy
         jK8JQMujbKerv3RqWE+GzuvgcSNrjn7HN6waZvnFY6/DDAOKKzHB415BrjmzYYYpNehM
         a6qsbgxszgd77TVmTIgfp8XqWD3mIOONCaUnAa5j+3nQYufUCPLp+g5LkkcsFG0nJzeS
         X6HjJG5pfTMPyMCGfC2a+lFOYG2+e/v1c8XRtJTZdWAF/Gp5caBDC9kBOmDAHj2humvs
         AFqAmw692cEUN/6C/1lOmY+lHfWmAHvHs66OD0rV1tkfkMCyxd82Tsvzm5zxojbS9YWf
         EU6A==
X-Forwarded-Encrypted: i=1; AJvYcCX9WXqp85y1t9mvgn6Fwgd9cMVT2minc7F/Fe0W3uRU0VjV8P9m9oXhLqFh0uVxBbK7Ytv99wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBW2O2LORIdssRJD6fe5T3drGZx2aUtKBTn4Ch5fCuozUq8kI0
	2U4uEHNHkmCjBp8Db4wGdWiLkSjbDuuSWUBoWsREP5XU4Yk/EbJzKrSOIG8PqPdgCPk=
X-Gm-Gg: ATEYQzwSZiay1G8Wuz018na066G0S0ty2xVSnlbn61sPTY1i9yke1NdzoRKFXALjziA
	DLFa9PfutRz5pIvPSYVzBd809rrqnLdS6UbwgHjn7a2mFtuDFVOWR/ai01F1ORUuKGV3B9Zeub1
	TsHopeJ6xlq43U/hMWlOUsSpXFQWFGWHr5ICu77LlzuhuArPXYDFUcEpgpgRTphtdXCKPzhIv5S
	uj0SdyzUYbrjwgLcDnJ4fh0pfF2/cQgyiZDcQNViL/stS8P2oXB/BZSEeNlMiATZ5KPoM1kAYZb
	HzjxQNeNkUrPHfL1CGEx7uphSyw4qtfiZhlCJzywPEmYG6ibsqGQlpAak6uOHOvsIZkPT3Y8JW/
	KkO+csPyQroxukDrebYMbmnnrB23sx4sHyTFfAtykNg+LeSvbhatTexWM3e4Aw1olbGWHy1aZ5Z
	Rh2z6d5zuZXQ==
X-Received: by 2002:a05:600c:a08c:b0:483:885:f0b0 with SMTP id 5b1f17b1804b1-485198bac26mr132115915e9.35.1772743077012;
        Thu, 05 Mar 2026 12:37:57 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b007a3364sm1714489e0c.16.2026.03.05.12.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:37:56 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 05 Mar 2026 17:37:41 -0300
Subject: [PATCH net v2 3/3] net: bonding: Fix nd_tbl NULL dereference when
 IPv6 is disabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-net-nd_tbl_fixes-v2-3-b7177db1a9f3@suse.com>
References: <20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com>
In-Reply-To: <20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1772743062; l=2650;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=cnxiDzaTG3dDRmVmA/NbvEgeXNe7TfmfMEbBpvNLqsY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFEHFEzi4olsRwKIGTYjj0OJcMJUp7J/8RoYSXtHC6YxcKesAOSiPUA9lLV1yaiiKX9118RM+Zw
 h7qF3LiueJwA=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Queue-Id: D5920218401
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264540-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Action: no action

When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
initialized because inet6_init() exits before ndisc_init() is called
which initializes it. If bonding ARP/NS validation is enabled, an IPv6
NS/NA packet received on a slave can reach bond_validate_na(), which
calls bond_has_this_ip6(). That path calls ipv6_chk_addr() and can
crash in __ipv6_chk_addr_and_flags().

 BUG: kernel NULL pointer dereference, address: 00000000000005d8
 Oops: Oops: 0000 [#1] SMP NOPTI
 RIP: 0010:__ipv6_chk_addr_and_flags+0x69/0x170
 Call Trace:
  <IRQ>
  ipv6_chk_addr+0x1f/0x30
  bond_validate_na+0x12e/0x1d0 [bonding]
  ? __pfx_bond_handle_frame+0x10/0x10 [bonding]
  bond_rcv_validate+0x1a0/0x450 [bonding]
  bond_handle_frame+0x5e/0x290 [bonding]
  ? srso_alias_return_thunk+0x5/0xfbef5
  __netif_receive_skb_core.constprop.0+0x3e8/0xe50
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? update_cfs_rq_load_avg+0x1a/0x240
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __enqueue_entity+0x5e/0x240
  __netif_receive_skb_one_core+0x39/0xa0
  process_backlog+0x9c/0x150
  __napi_poll+0x30/0x200
  ? srso_alias_return_thunk+0x5/0xfbef5
  net_rx_action+0x338/0x3b0
  handle_softirqs+0xc9/0x2a0
  do_softirq+0x42/0x60
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0x62/0x70
  __dev_queue_xmit+0x2d3/0x1000
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? packet_parse_headers+0x10a/0x1a0
  packet_sendmsg+0x10da/0x1700
  ? kick_pool+0x5f/0x140
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __queue_work+0x12d/0x4f0
  __sys_sendto+0x1f3/0x220
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x101/0xf80
  ? exc_page_fault+0x6e/0x170
  ? srso_alias_return_thunk+0x5/0xfbef5
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

Fix this by adding an early check in bond_confirm_addr6(). If
ipv6_stub->nd_tbl is NULL, return before calling ipv6_chk_addr().

Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 drivers/net/bonding/bond_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 14ed91391fcc..7d32cd231633 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3256,6 +3256,9 @@ static int bond_confirm_addr6(struct net_device *dev,
 {
 	struct in6_addr *addr = (struct in6_addr *)priv->data;
 
+	if (unlikely(!ipv6_mod_enabled()))
+		return 0;
+
 	return ipv6_chk_addr(dev_net(dev), addr, dev, 0);
 }
 

-- 
2.53.0


