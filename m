Return-Path: <netdev+bounces-297847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vvWqJgrnKWqbfQMAu9opvQ
	(envelope-from <netdev+bounces-297847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 00:36:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E28C66D382
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 00:36:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DLh1dWyc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297847-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297847-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E600303A8DD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06D9358368;
	Wed, 10 Jun 2026 22:36:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789AE321457
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 22:36:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130979; cv=none; b=IYThT62/Y9sgAy0BBKGTIK/E617lQpdM1UXk2b+q83Rday0EC8HocZJAjJG7VzWUyGODdlV5dchGlRSA+9MtKxBiQtSAnAvdaxSJsJIMZpsxvxVuC1FIdArFqjM4lwKFo1h8gTm1yN8eP1lyfbdeTA4MFtDZWxhteTNtHRog4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130979; c=relaxed/simple;
	bh=kHe/milqIfTwfBf25h5+p/33Cv2Ue7aFIjmUouvsYhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lrEVjFOOlBFC8tNhgaO1Vcno85wz5Zs1OAxnwlxae9idqdXHFvITTs+L69rLZqXXRdNI/kSQtXE6AGS0L6Lt/sdA1D67G1zEYtwQ0uJFH4wc8Sg5HjMznQX2YG2WlRFsDz5YF3WM5W8jsamUieb0ruJKD1+WYZXH7xzt5QYo6og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLh1dWyc; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-842d37438d8so1694490b3a.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781130977; x=1781735777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bXS1uasNei2W0F5w8YcQ5DxawFmp0GvgIwWTHm3NDy0=;
        b=DLh1dWyc0YYVebV4UFy7sExVA3YELK9xN+vqnYHb3SZjvaG8g+0z36aO8fb4UOHJtn
         ptL/n/FiuFPkc7p3TZW/IA+6QkJXbciWaeyDn/UcWKwAPF+9HltiITIgKFmi6hrx/Xde
         RIcblDMTk6eKeqofzF+S67V51Tz0pbllMjl6A04VCdMETpCAOSc8yX213j1ocJOOzZ19
         4OoRwLcKabBF9w17uWYif47rvU6Sei1GayiChqedAq4lw0heNjIS4xUUNaJad5WpwKQ1
         m50Bxo4gx9A5eM8hpWzb/Va0TKq7AzSOo61tsKUlOVbqlEwtqPa0lTIuXLU3AaSXYf7J
         GeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781130977; x=1781735777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXS1uasNei2W0F5w8YcQ5DxawFmp0GvgIwWTHm3NDy0=;
        b=mrYc9Ubc9peV3wM2CEmC31TsvLoPqW2N1u3V/y/60nSSEUWgELPIXrbuoZGFKBD+O8
         HgWv45i0asxC1IxtSxiSX2wrprQa1WbKSN3OQ5RfrpBjbzzoCP+tyluvUVboa2d5gyOG
         pPGle2r9YKtucmAdIh+m4iLlacmMjC4bC0zlaNr9ddnRlgIqvQf5OQq9MiA8JwrrEADb
         kSmr7Mn9qqJbKCxC6oedALAGJqEejVWlwpW6ak+xhF825zSdBKeZulw7CJAWWvtrZ7R9
         Jc5WMrRFyKG38ktxuGBTNyvdrWc5vsbT59d4m5PgGBgE126J+l4xpBfE82kX7rHEGbNF
         3cNg==
X-Forwarded-Encrypted: i=1; AFNElJ9h30CAxZIOEy0A5dXeFDNHNmjlTnSRYpJlbD+bhDncWfSMyNBgh8KZ/z3mV6b+wwOWX9WOlC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygsMT40UonOlhAdp68NL7Hsya5UccuL3vqtGuHzdteAHBrjubT
	udyrYJxIi+ag/Vp4YDdqWriCVXH5UW/qYjpBWqpCkt/VawT8ZiO+R39x
X-Gm-Gg: Acq92OHYzE25opqP5RaN8ZpJaWdUxue58lfJ/d05JFY5EI1wXEHlDfbAQpgLBJSckyk
	TB1PgEPpUpUiNN/Bu5vfmGw6k5c/DWiQJaqZYkW0kFQeX5Gw8NClv+lqiEfXB4uz28z7eOdOja5
	hifFJCNLWMhH9x2YHuTulkB3FOb/8kGrUSqXDLLpHiBxkY6+PwuZLw+V8IoCj3lMYPB9tIey4cV
	wSCQohvvrlVMVE4Tq/5YOe1amKR4l01zYhV4mf0MaKaC4oQ5UJE7ywjy8/ljGVJ1C7NnQFLXMMx
	3UKy4pKajvrZNDVmpiNUTRiDCkmDzg/ISYCkCv7P1bSYWGfunfPohGYjlqE6S9dUl+jOfiiez7W
	mqViXUpXakavUi77/2kiBB8lWAyL82HO9xb5jCq1IKYD/IputWXhRf+W6GhKdCujHoF+wDXk3XS
	QSv/qPftkuATDgazOatBZbLvLQTKbIickZev3W3wFXG9zD0pj29zFhHy4=
X-Received: by 2002:a05:6a00:139c:b0:838:29b3:9ed1 with SMTP id d2e1a72fcca58-842b0fbc0e8mr29267443b3a.41.1781130976755;
        Wed, 10 Jun 2026 15:36:16 -0700 (PDT)
Received: from angelay-dl.atlnz.lc ([2001:df5:b000:25:842e:36f:486f:8213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428288217bsm29944978b3a.37.2026.06.10.15.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:36:16 -0700 (PDT)
From: Angela Yu <angelayucode@gmail.com>
X-Google-Original-From: Angela Yu <angela.yu@alliedtelesis.co.nz>
To: dsahern@kernel.or
Cc: blair.steven@alliedtelesis.co.nz,
	carl.smith@alliedtelesis.co.nz,
	linux-kernel@vger.kernel.org,
	Angela Yu <angela.yu@alliedtelesis.co.nz>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] [PATCH] l2tp: fix IPv6 xmit frag failure for oversized non-GSO packets
Date: Thu, 11 Jun 2026 10:35:57 +1200
Message-ID: <20260610223557.2765487-1-angela.yu@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297847-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.or,m:blair.steven@alliedtelesis.co.nz,m:carl.smith@alliedtelesis.co.nz,m:linux-kernel@vger.kernel.org,m:angela.yu@alliedtelesis.co.nz,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[angelayucode@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[angelayucode@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,alliedtelesis.co.nz:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E28C66D382

L2TPv3 over IPv6 can generate oversized outer packets when additional
encapsulation overhead is present, such as Dot1q tagging. In this case,
transmission fails instead of fragmenting the packet locally.

The failure occurs because IPv6 transmit path in ip6_xmit() only accepts
packets when one of the following conditions is true: the packet length
does not excent the MTU, skb->ignore_df is set, or the packet is GSO.
For oversized non-GSO packets skb->ignore_df is not set, causing the
packet to fail the transmit checks and hit the
EMSGSIZE/IPSTATS_MIB_FRAGFAILS path instead of being fragments.

This patch contains the line to set skb->ignore_df using
ip6_sk_ignore_df before the transmit conditions. This allows oversized
non-GSO packets to be fragmented and transmited as intended.

This fixes ping failures with oversized packets over L2TPv3/Ipv6 tunnels
where fragmentation is included.
---
 net/ipv6/ip6_output.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7e92909ab5be..b28aa214acae 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -359,6 +359,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->priority = priority;
 	skb->mark = mark;
+	skb->ignore_df = ip6_sk_ignore_df(sk);
 
 	mtu = dst6_mtu(dst);
 	if (likely((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb))) {
-- 
2.54.0


