Return-Path: <netdev+bounces-298606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oF3nE6rwK2qYIAQAu9opvQ
	(envelope-from <netdev+bounces-298606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:42:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D99206790A0
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:42:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="DTLi//zo";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298606-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298606-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F70D31A23E2
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34633E8C4C;
	Fri, 12 Jun 2026 11:40:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662443D666A
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 11:40:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264452; cv=none; b=IAqAAr5WqtYlO2mcT/WBl68R35JfcFsaK1R6rNkApFnHsfxtZUZOldRMlzy5RvGY8gSjRgi9xOC1kWS96Dr4MjKkZOMBVY4xCQ+NNTKreXI/5tMXAOQIqwKIDgANbnAwxDqNFfSi7RnYq3EyEWeyd7xa77Lm1UTmx+L43g5xijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264452; c=relaxed/simple;
	bh=+8lv4XArd/KwhtE8lU4HJ+brttyOEuvASR41k7r5TA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JCGyE8WgbUakxlkp5AHggjadhqXSlGVL5D3qBKHUTTLnfF7bfOFyG2AbnjTyTv2AwNGuqSRJsGCcTvHQp4AFyCMHilOh4jPrVX/VK84shquctLfujsNYjKSOCSs2KsvCJ34CbR6kuXMENKvcoZ5U/MFLcFrKVKpmwek93EDJbHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTLi//zo; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36d8b644473so813662a91.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781264451; x=1781869251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3A4DI9oNtTuCvLmw1xW2OUzcOaOyUCmbNpOHdpzsdg4=;
        b=DTLi//zoU2/xdLbXTb4+wkj+x5uATOGdWvETmUQyuCOGcgh/WeZ93d/uP4P+0j3Xi5
         bxjEq2tsNy/L3HSRW9TBHC0nmglGGilRUXUHZEizIZ2djuuaqdHPEB1kUb5tmn1qMGjO
         Yw1kRjao1IAAE5Y+zUU2/wzSkNF2CtV+kQPkfSQe9BiTeVPnChYpYc/FvnoGmT/Me7wl
         3cfauM/jxh5SRC/jnh2BRR6FyXJkXF+iNpukDHY+UIkQv31FpeY3cHoenuSSU5iM+HBU
         nVtv4kB+ue2lovGsWX9DjNnNLrpdWrBYGspUDgnNsnD/GsLP2ef9ZMSzJ0g1SiyNyceU
         1itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781264451; x=1781869251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A4DI9oNtTuCvLmw1xW2OUzcOaOyUCmbNpOHdpzsdg4=;
        b=SpmghpE1iWN726JJXjentDOg9QJdKXtxb3SSMl5tN86+sGqi9aIMEcifK/nAY5TCWz
         ZumESbDsq2PfE547dOc+a8b4fOyZ6Jybn62tSJ7UTcwtAfbKPEyYiaiX5K8mOVB+srSH
         mHr2iDJvF7l6ov4RkqNzholk4Em+lt8m07HXLtoUtlL875KjHMoBg/8aG5s5KOqiy3p/
         ZYDo0qiIGck1J2EE7SMoQ/F+cWQj+R702gsEZLj69XE5dnfsiBwZmBsg3pgc6QlIPxFy
         6YYsmTnHzOiUHz5486CvKeb2UqjkRoT9vOS7GQzAfOxXetiSFUoZopJfWD/H3piA7Wqy
         GbLg==
X-Gm-Message-State: AOJu0YzfwDjqFabsf24+p1j6Jrl6QqSMm4BAISgsYSGo5fxkWe3/HVV9
	9GcmAGp/9i5V1ZaNnynljaBnhxtRh6e9mCKTkjSpEL8i9kwUV/38ZkvW
X-Gm-Gg: Acq92OGG93k+wOXE2q32AxQA+TIBLrxHktRSZpOyojckr23VPzn4tBKWaHFuIuMfVfA
	1psBNj2KhKJOx9TMRMvLGJXAKgAPUe/ylKspNc6yt1EwXoP6Tk8Z4Rqdslwi8WbGlG416XYNx+/
	C7nZ4ZxULWlvba937SguZWBQX6K2BaGED1pKpedmkX28c3ERmPRQMaaTveHiR4JyJKOP/xW4ro0
	i7Banz5FIKKivfL6ACSziaMvqTqrydr+Y3jYaOlS6lwgJiWr/HRZzCdWBqaMfbvTd3KZXy0w53o
	GbRd+5SdoARROZzRW0iUpw+AuFjxI4wqOSJHwRkssGDWlgyzw8d9/5qluGFgi72eDrqqWS3Gd7N
	La4J6cMr4AZ7zw7rqJwnFvbbg93Mzzr66FUJUpqmHo3xeErkefHi3rylA5l3ScvtvSuKSE0SYgP
	PvTefQCVx2Nu39+dW54j21J/z8JL2758TiTiVCor4yvvs8Mvv+A0I8/FN9aGBzCKgRsfbV+BbHm
	CEbfTo8yoEa
X-Received: by 2002:a17:902:e54b:b0:2c0:bb2d:a314 with SMTP id d9443c01a7336-2c4129391a8mr31141165ad.28.1781264450591;
        Fri, 12 Jun 2026 04:40:50 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm20697455ad.38.2026.06.12.04.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:40:50 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	toke@redhat.com,
	menglong.dong@linux.dev,
	emil@etsalapatis.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v5 0/2] bpf: Fix generic devmap egress skb sharing
Date: Fri, 12 Jun 2026 19:40:30 +0800
Message-ID: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298606-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:toke@redhat.com,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:sun.jian.kdev@gmail.com,m:johnfastabend@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me,redhat.com,etsalapatis.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D99206790A0

Generic XDP devmap multi redirect can leave cloned skbs sharing packet
data. When a devmap egress program mutates packet data, another
destination sharing the same data may observe that mutation.

Fix this by making cloned skbs private before running the generic devmap
egress program. The private copy is made in dev_map_generic_redirect()
so dev_map_bpf_prog_run_skb() can keep returning the XDP action directly.

Add selftest coverage for the last-destination case, where the final
destination runs on the original skb while earlier destinations use 
cloned skbs. The test records the source MAC observed by an earlier
destination and checks that it is neither the sentinel value left in the 
result map nor the MAC written by the final destination.

---

v5:
- Move the skb_copy() check back to dev_map_generic_redirect() to keep
  dev_map_bpf_prog_run_skb() returning only the XDP action.
- Preserve mac_len after skb_copy().
- Use __be64 temporary values when updating mac_map from userspace.
- Initialize rx_mac with a sentinel in the last-destination test instead
  of relying on -ENOENT for ARRAY map lookups.
- Adjust the last-destination test topology so the checked earlier
  destination is not the ingress/source veth.
- Split the last-destination check into two assertions: one for store_mac_1
  updating rx_mac and one for detecting last-destination rewrite leakage.

v4: https://lore.kernel.org/bpf/20260611080850.536996-1-sun.jian.kdev@gmail.com/T/#mf830f03d362f33e0941d1b0e425169698fce76e5
- Preserve mac_len after skb_copy().
- Separate errno return from XDP action output in
  dev_map_bpf_prog_run_skb().
- Zero-initialize net_config in the new selftest.

v3: https://lore.kernel.org/bpf/20260611043317.512843-1-sun.jian.kdev@gmail.com/
- Split the kernel fix and selftest into separate patches.
- Move the private-copy logic into dev_map_bpf_prog_run_skb().
- Use deterministic DEVMAP_HASH keys in the last-destination selftest.
- Fix the Fixes tag.

v2: https://lore.kernel.org/bpf/08c35c70-a59e-4e0e-91db-22b5ec30b611@linux.dev/
- Move the private-copy step into dev_map_generic_redirect() so the
  last-destination path is covered as well.
- Use skb_copy() instead of skb_unshare() to keep caller ownership
  unchanged on allocation failure.
- Add a generic XDP last-destination selftest case.

v1: https://lore.kernel.org/bpf/CABFUUZFimdrZdq=NWi+N-0sJZWvMwY=f4iF6-3TVMS8=m07Zmw@mail.gmail.com/

Sun Jian (2):
  bpf: Run generic devmap egress prog on private skb
  selftests/bpf: Cover generic devmap egress last-dst rewrite

 kernel/bpf/devmap.c                           |  12 ++
 .../selftests/bpf/prog_tests/test_xdp_veth.c  | 166 +++++++++++++++++-
 2 files changed, 175 insertions(+), 3 deletions(-)


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.43.0


