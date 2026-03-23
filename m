Return-Path: <netdev+bounces-270442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JqTFZ8JwWmtPwQAu9opvQ
	(envelope-from <netdev+bounces-270442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:36:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8412EF2C7
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FBAD30242A6
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5F6386C1F;
	Mon, 23 Mar 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="H45bhmGS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82F33064D
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258307; cv=none; b=XAjJ/i6KPJ1Rc+feYdDeNRPuTX8d40D47vdH0Fqe72uVETLwfKJtjj81hE+Zj+kii6fTQnzhOr7YcDUSwihMO05xuEizus+QpDuRl0IeaA020Mtp9LvRLmjmMxQ8GhlSEPVwHjxy/jW/yN9Z2Q6TLO37HuzV+nUuZ/Gcy2/K/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258307; c=relaxed/simple;
	bh=2yYK9eqyeT82cWS6knhL7d44t3BEnP2mgtCfvio2ceI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g10e6bk2EdaD+1IcE5crBSGH/q48hZHqMh8L+gibb8kXxAFRh0IjgJEhw9Glb/s7SgBTd/zo3MiUeww5x0Tt+1Ota1/KApaCjPDnxXgdyydXMyojXvHLixTL+gZln2j7A0xZxFsf0Aiayf50a4GrwAvCz/iodjg75sj6m7Da1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=H45bhmGS; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 20FBC3F877
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1774258297;
	bh=cN6VpjTmiSo4pkQzZdJn2BDRMXRoJ5nje1efWmRb9MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=H45bhmGSBg7XXjJW9MNdDLefhBYn7YlSHBig1Jbr6Z4v65/mN++2ggErBkTy/93KG
	 8WwzOmyrF6Yh5Hh7qcIDeTHqJH3Y6i7kTNpZKdU1xXuI1Ugd+juxDEKKkukZrgNgmh
	 G5GQslO4XWwn2chayprigo+pSgTYh5QYEIJGY6KwcxWtn/neinpqSlSGEtjV+E8z3U
	 Fmo0j0eHYZyZA5oxZWozw2MvVtxD9jHjRb52g5TkuGmQk13rfBjFdTSCN0Ta4G7X8z
	 qTxj2idasB8P71EGfM+Ew1jUCHYisMD++hbq+pOCfJF3LqHZpwf3qMy1MC2npa7AZM
	 cKlbG9dNxwyrhNY9k3is8sgO7AqD5Wzwl93XKJMyjYEHOi/FrN7bVsx3wETmTSUAvH
	 iChCjY+nd3uIlUEixryQSBByC7TkT8Q4tTTBisC9VSMHsAx/8nMiZZs+2EJsLwzwuK
	 rCrYSFZ5yNtOAW/xO+O+gsxkOUDUp0LhS8eW0gvoecOOm4977TgN7o8PSvjOxfAZQ4
	 cik+KZ/y6ru7WglqqvpXrJjwN8VYvKCtQbJCLh4C6yKJ8o9IVtFmu2NAQxeub3miGC
	 mwePTYFLXmtv6dP9MP7oxZneipFEqJrBjksFzsPx05VJk8S+YoY17gEb7Z/m8PC+Yf
	 RqOMrkOb/DMvJQpTY+irF2M4=
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b4730dad8so3461199f8f.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 02:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774258296; x=1774863096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cN6VpjTmiSo4pkQzZdJn2BDRMXRoJ5nje1efWmRb9MQ=;
        b=q7xriSM7UVQonAJ8vAp/1QYyB+lIFtYy9zRnEWXGSbhWnv0VSSohvsks+sOk/G7Uce
         DKBxbdkJmjgsjVFKIT2nHv81dQ3mSpZ/UbYNaoGjLbkO8krXX9w/6dQDVggTRIgqLu1b
         nOlln74kL2Ltt4UWtVMcbskr49seZUXayb1jbaHX1fN8hkgScvzmvdvwpKjeYu+btgtl
         89mYBDVP1faJer7MB+ZYrm4fdY5csamYgEOJgZrikK1C0hnsaqBwGfvgKt8cDm9Ife8a
         KvoOauuIXnX5eRDH6BxQLLvCDCMebcStO4zj70ZXWNWRDjSuLkLLAdNLUgntBFQWzWRm
         W/6w==
X-Gm-Message-State: AOJu0YzQZQN177xdSYzK2bO/wYnusDeDF1NNN/LckDN29IW5cYRKu2PV
	OEZhPrpM0UwTdvddXWmy163755QbtSs3kUzNh4+RslHJHovr8d7abmnVBmDBPod8poUnJzham8K
	jYSx/8TjXYyHFxVvhPvq2c1jTy32M4NSLKRTXMQ7uf+v3ed3alBWvh/MMFDXq4WcIHsbNm0smBN
	3Ue3OTvg==
X-Gm-Gg: ATEYQzxi5kwIoFW4KQOl1KHH1JP9mdTPcNIisZRFbk5ww7vSqCguKct4TkOpEsOSbiL
	9bjxya7z8vViUxV8yGeSusoOHRbRsDHK6eZUMsPiL8boSireOm0YnP613Hs4fvRJGnhHcZMgFTk
	8hGpDkl6dQ5u77yded8GYdgWMM3w3ttuw/8b/1YeXpC10sM4f5eCkQ/rF4foybg5y0LqynE0xA2
	MfFUMJ8z/DwVc7zQ2glCjUl0AkH3wj2EsTNXBLMJYw5HBqMDKF5YqOrS98HqFEREWhYEFb1v9Cd
	Dpk6QzpQ1Zmtlz0Ku+4KGD1/6Iw666sfDy0qo/y1rkJCXKDFzabokuQS4HDjNISIlVT2d+GKGYi
	o5cu/OjvYK15q1LLJzWT55ye7KIHhP5g5
X-Received: by 2002:a05:6000:40ce:b0:43b:4489:d456 with SMTP id ffacd0b85a97d-43b642919d9mr17908471f8f.47.1774258296057;
        Mon, 23 Mar 2026 02:31:36 -0700 (PDT)
X-Received: by 2002:a05:6000:40ce:b0:43b:4489:d456 with SMTP id ffacd0b85a97d-43b642919d9mr17908419f8f.47.1774258295520;
        Mon, 23 Mar 2026 02:31:35 -0700 (PDT)
Received: from devstation.. ([194.120.133.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6cdfdfa9sm18901032f8f.9.2026.03.23.02.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:31:35 -0700 (PDT)
From: Ioana Lazea <ioana.lazea@canonical.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	stephen@networkplumber.org,
	dsahern@gmail.com,
	jay.vosburgh@canonical.com
Subject: [PATCH iproute2-next 0/2] tc/tbf and tc/htb: Allow 64 bit burst 
Date: Mon, 23 Mar 2026 09:29:11 +0000
Message-ID: <20260323092918.11010-1-ioana.lazea@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270442-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,networkplumber.org,gmail.com,canonical.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.lazea@canonical.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF8412EF2C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


        This patchset updates the TBF and HTB queuing discipline
configurations to support burst sizes beyond the legacy 32-bit limits. 
As network interface speeds increase, the kernel’s internal 
representation of burst (calculated as time at a specific rate) can  
easily exceed the 4 GB threshold. These changes enable userspace to 
accommodate these larger values where the kernel API allows.

        Additionally, if the burst exceeds the upper limit supported by 
the kernel API, it is now reported as an error in userspace before 
attempting the Netlink transition. Previously, such values would 
silently overflow, causing corrupted values to be passed to the kernel.

        The implementation follows the approach used for tc police burst 
handling introduced in commit 3b26e8abf404 ("tc/police: enable use of 64 
bit burst parameter"). The reasoning behind the patches proposed here is 
largely based on the rationale described in the aforementioned change.

        Similarly to the case of the tc police burst option, as 
implemented now the TBF and HTB burst option limit the sizes of the 
burst up to 4 GB (UINT_MAX for a 32 bit unsigned int) due to the 
constraints in the user space tooling. Historically, TBF and HTB burst 
options were capped at 32 bits, which was a sufficient limit for the 
lower line rates common when they were initially developed. However, 
since the underlying kernel logic treats the burst as a time-based 
value, it is already capable of handling larger sizes at high rates 
without requiring internal modifications. This patchset bridges that gap 
in the user space tools.

        The detailed technical explanation for this change was 
previously detailed by Jay Vosburgh:

Link: https://lore.kernel.org/netdev/20250916215731.3431465-1-jay.vosburgh@canonical.com/ 

        To summarize the details at the link, the burst size is limited 
by the kernel to approximately 274 seconds at the specified rate, and 
has no inherent 4 GB limit.

        Below is a short description of the main changes made to the TBF 
and HTB queuing disciplines.

        In both TBF and HTB, the primary modification replaces the 
unsigned integer burst variable with an unsigned 64 bit integer variable 
(buffer64) so that burst sizes larger than 4 GB can be represented and 
passed correctly through the kernel API.

        For the TBF qdisc specifically, the following logic was added:

if (buffer64 < (1ULL << 32)) {
        __u32 buffer32 = (__u32)buffer64;

        addattr_l(n, 2124, TCA_TBF_BURST, &buffer32, sizeof(buffer32));
}

        Increasing the burst size representation to 64 bits introduces 
an issue with TCA_TBF_BURST. The kernel expects this attribute as 
NLA_U32 (a 32-bit unsigned value), while the updated implementation may 
produce burst values exceeding this range. Passing such values would 
cause the tbf_policy validation in the kernel to fail. To avoid this, 
TCA_TBF_BURST is only included when the value fits within 32 bits. When 
the attribute is omitted (for example, when buffer64 exceeds the 32-bit 
limit), the kernel falls back to using the value stored in qopt->buffer, 
which already supports larger burst sizes. 
        As seen in commit 2e04ad424b03 ("sch_tbf: add 
TBF_BURST/TBF_PBURST attribute"), TCA_TBF_BURST was originally 
introduced to handle issues with very small burst values. Omitting the 
attribute for large bursts therefore preserves the intended behavior 
while avoiding incompatibilities with the kernel attribute policy. 
Additionally, the burst value is explicitly cast to 32 bits where 
required, ensuring that 64-bit values are not passed to kernel 
interfaces expecting 32-bit fields.

        These modifications bring the user space tools in line with the 
kernel's internal 64-bit handling. The logic effectively avoids Netlink 
attribute validation failures while preserving the original intent of 
the burst mechanism for small values.

        I look forward to your feedback on this approach.


Ioana Lazea (2):
  tc/tbf: enable use of 64 bit burst parameter
  tc/htb: enable use of 64 bit burst parameter

 tc/q_htb.c | 16 ++++++++++------
 tc/q_tbf.c | 24 ++++++++++++++++--------
 2 files changed, 26 insertions(+), 14 deletions(-)

-- 
2.43.0


