Return-Path: <netdev+bounces-272796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAKeKOwdyGkShAUAu9opvQ
	(envelope-from <netdev+bounces-272796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:29:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFD734F967
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9AC5302A19B
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F23322B72;
	Sat, 28 Mar 2026 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="cAr0dJ8k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1521F872D
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722428; cv=none; b=htb3T2eDJUGyE5pD4niuDuj0a/spCrbxkQrAdEPyEhJ+HpUzI13PtOvXLCm1+52VsMBp7lPGnjlL2WCd5VZULaAZXBihEaPihmz31KBPWJYE+rVvtIGGY697vKkQmbg7smyJmBUb6TBTVa1iFvrIGGsEP9dJ03IHlCExJI/JTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722428; c=relaxed/simple;
	bh=oJF/93lUug/kmF70peC8jZ3twLG/1QMTJGE1+eLAESQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tI+kkLvGi4SKbCtN6HfS3CHh2Km/Ir95Sob2y+07EIatpypsVcTlJb7R/p5gyObbA1rp+0KtiorGrKgKlLAT8lvjOtonPEugK7fAxKBmJg7uOodjBZdaoANYWRaP+br/sNdKAzwTdElDiz5ZLfPi1u2JsuySShbwJiM8ENwNTnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=cAr0dJ8k; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-126ea4b77adso4474492c88.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774722427; x=1775327227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bAUykv3YHmIdxaBV8Hx1kfnSB/sIeqUSwiBDml8dSf0=;
        b=cAr0dJ8kzuBmHBRC0ufkBA+WmCtKjEderRrJdC9QbNTDqfDVz/n1waOxNe/IBTreYN
         HJ4ZT6Eo7RH302prT6SKTXuBnTUPisxW+KOoL4ch7fXVAeyt90+MZsDrX6a+LEG+0lCi
         gnNuEW2FShAt7MfD/TSffKxP7DhPDS+GnYTsJbk8EFnqlAtMRafpfIcpjlhfqv5fvH2Y
         nqgRYgKv8+LlDps7qX8CKUXcSKglVkR6L+gjbzHwGKqkJnxjAwuA3BTxtc/FwNH7KbTW
         01eCd+ClaCXc+sk8hcGy6/ggi9euPVGc3cafacKGHmf699129e+wteDvG9731B23fUvF
         ZoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774722427; x=1775327227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAUykv3YHmIdxaBV8Hx1kfnSB/sIeqUSwiBDml8dSf0=;
        b=N2uXsxdeFYkDTRXvD7hSwZuKO7MXCpkOKcWIHeWcmsB0LrnUtQzfpGgoD10mSXvQpb
         rQim0JZarnZqMcz76Bwp7ae2LLMxXdg6dn02vF0RT4/KFtw3ruelJjidtqv0HkisovJa
         /DC48K3kyxKl+wgxZzaXkrZ5EnvrUxmYj7ZjnvJOUQqEgFdR6A0+bwHIhsa5iUL636Yx
         10XqFAH60vufvUdV6aVvYgzXvxt9g8+FlCTeMnoD8kFv3TlTm5Vw3fo4YsugDC4pVaP2
         K49bD3ZyHCb4WP3pTS0koVEd0SxUfXObBnF81Cyt8PXTVmzzdFbPmbASgt13PnXQ7Bme
         lNDA==
X-Gm-Message-State: AOJu0YwKHkOoW9ZJN2p0auwDu4QgUx5ecEIdJ0X4ju5UKwBn2sgcX5Ua
	5Zm/NwpvCqV1cWjY4nj5Nf3g47V9hUKZno/kB9kVoZL/QnoE8O+ld4mzBAfzt0Vda1EPCGq5jQU
	roKQn
X-Gm-Gg: ATEYQzzAnpJEIh6WK233/v0F5lKG424HzLfk30zCQCNZKtCvgVdd1ZZQNQs2nGAzNKP
	OIrwPIPIuNE2IOI4oqRCR3y0X0j+c7yrfDZRK5cEqAlMmA+I/eOvfvGMyldnPB0VN4zhTAVNIxZ
	aQ9zR6ulG2sHuFJOgEtzeJ1XxixWzauFQs7YER9eh9nyyQ5qr3wLJynLNvJ8fGDgFbZrzqUShOe
	bfhbyK4fO/A5hA7ukPVZJZuRJm2sm/qafUPKtchKJdK9pdUhMo65dk8QQ6LnxsNXJuXU1L4Nlw2
	/fGFTiMEMkxiA4XyHW5XI/s+Esa7gCSXnuG33C7XLNJictd0NUWDPPsX4CxuxAjKEyHKal9P0mn
	Ivx2sM/KJ4Hyst7ybr9PZSnSeJkh0gCHMMelYzo72HEcTG/nJgbdH2jINpvd1pLwv3CNB0ooIxf
	Rn/gZurGzXqMn2i52JEwSDsnkHUbqYHM2J
X-Received: by 2002:a05:7022:4183:b0:12a:6c7e:bef9 with SMTP id a92af1059eb24-12ab2857e70mr3813290c88.9.1774722426666;
        Sat, 28 Mar 2026 11:27:06 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cb08csm3909263c88.3.2026.03.28.11.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:27:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net-next 0/6] net/sched: netem: cleanups and improvements
Date: Sat, 28 Mar 2026 11:26:01 -0700
Message-ID: <20260328182704.456993-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272796-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 2FFD734F967
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Cleanup and improvement patches for netem, done as follow-on
to the bug fix series found during AI-assisted review.

- replace pr_info() with netlink extack error reporting
- validate slot min/max delay range on configuration
- fix slot delay calculation overflow for large ranges
- remove unused loss model struct fields
- remove stale VERSION string
- add per-impairment extended statistics (delayed, dropped,
  corrupted, duplicated, reordered, ecn_marked)

The xstats patch requires a corresponding iproute2 change
to display the new counters in tc -s qdisc show. This will go
as separate patch after this.

Stephen Hemminger (6):
  net/sched: netem: replace pr_info with netlink extack error messages
  net/sched: netem: check for invalid slot range
  net/sched: netem: fix slot delay calculation overflow
  net/sched: netem: remove unused loss model fields
  net/sched: netem: remove useless VERSION
  net/sched: netem: add per-impairment extended statistics

 include/uapi/linux/pkt_sched.h |   9 +++
 net/sched/sch_netem.c          | 120 ++++++++++++++++++++++-----------
 2 files changed, 89 insertions(+), 40 deletions(-)

-- 
2.53.0


