Return-Path: <netdev+bounces-298428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0SfpJ+tdK2qg8AMAu9opvQ
	(envelope-from <netdev+bounces-298428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:16:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 199F0676144
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:16:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=a9CrgnnW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298428-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298428-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B356304D70C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FFD322533;
	Fri, 12 Jun 2026 01:15:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225A23395F
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 01:15:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226926; cv=none; b=E20Svi86KZtJioibdwHCVcqiaqAVEwHSgXLjJtaEsovlecc9QgAITJQHaenJCK43thHQl2Xgs4WRL3BTVzZR2TuYYlGqM1hG8jMI0yZj2v2q3ZgEZFcLbxVpU9PbfB49O8SFU0yPlYlvHdXXT6KN8KzqUrGg2pjVjnsdkHwgalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226926; c=relaxed/simple;
	bh=kL2zAACXFiDtW1eVsU5LUmYxMNAN4kn47KN/F6+Ia+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ol+6HGVNL7skJniPSljpsx+vsTQDdZOejym3BufJxl9cMse9anqEgEAhTEkfFmAwAexlX6O5/CGSuIye0AvfDd5wrsneBhALGN4ejcJXd+ZTR3QCPU1MkAZ5soUREVBlboOZ4/bZykowWO8HKf5eRdyRWyzDAdnZEcc3BRBJ33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9CrgnnW; arc=none smtp.client-ip=74.125.82.48
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13810b63a1aso995379c88.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781226924; x=1781831724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkTvbWtZ0JcM+jEsuldlyWxlhk0Y5c+iS1VR0niVTtc=;
        b=a9CrgnnWbbe0+5oPJoo6evzfbyFFx4ryM95ZZONGeYnsSsqvg8TDbU7wWi2DH63v3d
         MMOU5JfVwizGyAf0P/KxJcRgzXmuz9yAy5kQy9UhqbRTDK18PuopIMoQYjNTM8zJPv3+
         DeIw/AqHgBmXfB3qxvy/2PDikFx+aYVLeW2itemKozNvUxpmceUKUMoC9Sq4bMBb7Vbm
         gKHp62rr6euMSsGF6+VCT+mWhrqmV5dN0z/vK87rxn9k4K0JcCsRiYXrW/ASiE09PNRY
         iNBGLpCLxtrQY9r+XNhw82KPY4eOz1/TVMMWS5rjtKX+iK4yTN+qRVlvPnUXmQsbDqhO
         AvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226924; x=1781831724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BkTvbWtZ0JcM+jEsuldlyWxlhk0Y5c+iS1VR0niVTtc=;
        b=KTiGW8Thv73mZFKT/iOYeiGf2wG1gdbfy9YpIIrggjGuC5jcmjegJvcryEYsErSZrJ
         6g4OSb9LQgfUxY4HaK9p+moxNAo/6ltJlzdltUTgyLj7pw5OTy+c7+Z630i4Z9063Tqw
         OTECRMX0XB3Dudi5MwSwBnjKa1ndOX3TothDPNvkq8829khpLuQHfRz+xoNLJCUtp1wG
         DBwk0XvDDHWVNG8f2B+GaUvOdJ840qn5cNQiH0UzuSeEV0FJdg/sPRZHGECosncce3+W
         CZtZGvQrQJNKUOxrOVVBqMC0scciCUF/5wCA4CuFNrUpl61nmHvWDoABPqEaavxS9kPR
         3o7Q==
X-Gm-Message-State: AOJu0Ywl5V8HCQbyBMZdISIxNnePdskohiEgQ2CAeEgTwYXgFmsEuXTg
	Eibgj7Xmrmr7MVyoCN3XMx4fWL70PxZsPwwXmgL64JdsmxTkfcxFJi3o95JtJg==
X-Gm-Gg: Acq92OEbj6MEyCGp3o50QrQMwfJhnOTJE9ZXKs3A/RT0TUQveLl+md5U4H7P3RZ1udc
	tLaZs8JbG0sihw9PrpQPymSSW2SA/rYTLckqlvxCioajLNSIWPjtP7EhU06BJuajuFxkw5eH6ZF
	6Yzj8nC8JLXLfT7l4KY4BP0jmQXhp6BuXw38O7mDSDKjEHSfDBRGo9OkL1TmFDJ+8tFFpAKtcyU
	TA91ZyFPHP6Yw1wReGalFGYf9unVJaMP51Uz4IrzpDyycunnz0hK61toV4gESDyc7xwDBaUKT+1
	xQifmzfBxmgRO7hNnqduWMrS+O5FuDXFhXTcBDdebEcB/P+MW67GqKzecnzqO3H/DpqFLnb1wfS
	6rFin5nI8RvIjYZRIQNA20BVe7zMeZxZg6EmxoMHVIVqyIynSmbwcBUxWXWYflHDBQ34ixf+ldw
	WN8XKEy/eHXfdlpo/8jQAk56bRAqNQEEUtOJHFL20A2Jla0Y8XFJUDBhhTfESvpC5uNsHVrkO7f
	jOk
X-Received: by 2002:a05:7022:1a82:b0:138:37a6:6cff with SMTP id a92af1059eb24-1384b9763fcmr312789c88.0.1781226923916;
        Thu, 11 Jun 2026 18:15:23 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b975e55sm596257c88.13.2026.06.11.18.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:15:23 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	hemanthmalla@gmail.com,
	zijianzhang@bytedance.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Cong Wang <cwang@multikernel.io>
Subject: [RFC PATCH bpf-next 4/5] bpf: allow SO_BUSY_POLL in bpf_setsockopt()
Date: Thu, 11 Jun 2026 18:14:51 -0700
Message-ID: <20260612011452.134466-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cloudflare.com,linux.dev,bytedance.com,multikernel.io];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298428-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:hemanthmalla@gmail.com,m:zijianzhang@bytedance.com,m:xiyou.wangcong@gmail.com,m:cwang@multikernel.io,m:johnfastabend@gmail.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiyouwangcong@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiyouwangcong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,multikernel.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 199F0676144

Add SO_BUSY_POLL to the SOL_SOCKET allowlist in sol_socket_sockopt() so a
sock_ops or cgroup BPF program can enable busy polling on a socket (set
sk->sk_ll_usec) without an application setsockopt or the global
net.core.busy_read sysctl. SO_BUSY_POLL needs no CAP_NET_ADMIN in
sk_setsockopt(), so no privilege gating is added; the value is an int and
joins the existing optlen == sizeof(int) group.

This lets a BPF program opt specific flows into busy polling at the point
it has the context to decide. The TCP loopback splice path
(bpf_sock_splice_pair) uses it: the splice receiver busy-polls the ring
instead of parking, turning the latency-bound TCP_RR case into a large
win (numbers are in the splice busy-poll patch).

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..302dfaf03f39 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5325,6 +5325,7 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 	case SO_MAX_PACING_RATE:
 	case SO_BINDTOIFINDEX:
 	case SO_TXREHASH:
+	case SO_BUSY_POLL:
 	case SK_BPF_CB_FLAGS:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
-- 
2.43.0


