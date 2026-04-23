Return-Path: <netdev+bounces-280677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM9ULrzj6WlQmgIAu9opvQ
	(envelope-from <netdev+bounces-280677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:17:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3541A44F2B1
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDB33304EBA5
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9773E3C55;
	Thu, 23 Apr 2026 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIItjoZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80223E3C45
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776935736; cv=none; b=bvpLvOIRWGzREZ9UUjWQyVw/UZCCKC/PYodu07bdtYGtH/ys/CMjcCGO/TnBQ0gCKr7+WtY29Z69kB93LakHhJlepDJXGfsTdoX4GptxAPVGi/aq3UE/3JjaqqxVdyDD7XHhgiCfWOK1kh1Mb6kI68Hb1ZOPcVWysG2g5Zt+yTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776935736; c=relaxed/simple;
	bh=tumqCjg8ioy3Iv8OQ2rolx3y2ieRyPfAr1zre5Dbmdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=h1z5SfGCLaiaIO8rUQhf5JyRz3jM0m66M+zsnhrRGvbcTSSs7kmKSrR55ucDz2RdN/jOiadhZNb0w15vNnVJmyrANdsRSnp2QIlxvZE51KCph95baXDTr4Yx1B+C7uT+2kDhoH5+S1i8JPiR3mNkFEJo+vI/iwZqxLpf+Bivi4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIItjoZu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b461310af5so25260545ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776935734; x=1777540534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:organization
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sHEpv/1qXsMJgP6KklqXPkz0wDWe4Z9dTmnatzra1I=;
        b=bIItjoZuaFRjlCxStQ7q0yuGsBaLUMfXwAVlNl1bh8A6E9ksgW7pyEygSPwfukU3U0
         ZA/tAXnjvmBH1qMp5wx27RRhxJTMm03s2wzUQBAuYBUgty3Kx1DPnlNd2ZCamIKpzO25
         u1QAOlUWrNGxWIK8kYxbHLhHJN6rwbDzGNIlc1LybHjDfRpfSSGo2p0T1TaVrr9czxVM
         tLIle31AloQu5fSU2uDPXimAyiq8D4lsF5zshRUoVP2eZ4+6Gj6KqjNo8ZBGWa9HumLQ
         qFriEojZUweU/tk2M9VUxose5RKx/LKACrcXSMxv4Fp58eb1v3Wi1PJbCQ6Ln2c+6yQq
         cuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776935734; x=1777540534;
        h=content-transfer-encoding:mime-version:in-reply-to:organization
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/sHEpv/1qXsMJgP6KklqXPkz0wDWe4Z9dTmnatzra1I=;
        b=pGlKalCVEbo4K97rxPeL9e4HxX2uHPlBTJi3HmC0TQsA6l8TsHGcbMjn2W0QfLSObd
         gHF6UIzdA0VrWyqvi3UmMJP7g4QrEl7q76Y2NB/tG4nOmQmn2G4zzIyrEpSMhEgqx/EA
         YreswvDlHE6phivtkFr63dLswuOMqYiY1b7UdU9PK8Yc2TVEAJFdqrxwz8yeui46rKXC
         roJTeSox2/vMuuc/SphEscbj1eCkU65oZf+to5bLrieirIbCsaDxWY079+fj+cpWTnxD
         IjVW03/uK+iwgfj0SebHqG9XJvfdWddd/Vs8K9HsEM9vkmmZCN7wTYvIW54HJqUiKJnv
         c/Hw==
X-Forwarded-Encrypted: i=1; AFNElJ92m/2z3JERjWbbepsySJNxDF7nC0ZFSscO/D2r1Ac5wIi/LJiYcw5cTP7o3x8/isbRP+zYx34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ9dr8hPNdKDLLCp/nwKNkgkUZ8K6+5MLwIr5nV1kN7drc34Kl
	6frr71Hyfb6qRHUB1zPVB4xINQcJ+lm+4BnFq2LqkzmFzufBU60Dq9gf
X-Gm-Gg: AeBDiesg+//1pdsIvV4zGIulOwAH+TIZXMXQ8h6hRJ6EkPjeaP9cYzaQviG4b0mu7lC
	xU3wbAy5DuOeDDgbXo9DW6ectylJhM2RJybHvuEmEeO1acsHx+AJyPjyO7EqtPSFiV3DSNdOkjP
	crPtYxw5xOg8t0mtX/7mpFk+/TZ4N0ZNfUOe29G6gfLLoC3Rr2zvrz6VsHW5waYPssjOWhSDDPc
	WsDSuztcXELo+GR+z/DpwME1ddb3NS6YfjpDecjJTWL238dJrbXJVmTtsY5sjavbaTCtwZkBtg+
	9plI9gZ7UxryKJ7o99FR7AZNO1RQeJKZwcyYezjLAjSHMo1SaOsxHyOpU5trzkQzA1ZtWmwv+E2
	ouO7m80IEYVttwtqSjMU/7qmnyxDm0LXc97uczpzyDbdZB3S1TYJMQ64q1tk0fyh6+KyT/hqcKR
	T+JkNjYgTo0pQuvV4oiLYBEBa79cRCc4Suv1HTYNRaZu8ZA31nXECSDPDIN/DNo2LEVw==
X-Received: by 2002:a17:902:aa96:b0:2b7:86be:7670 with SMTP id d9443c01a7336-2b786be7763mr67586695ad.19.1776935733936;
        Thu, 23 Apr 2026 02:15:33 -0700 (PDT)
Received: from localhost (vpngw1.cse.cuhk.edu.hk. [137.189.90.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab55062sm190241795ad.84.2026.04.23.02.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 02:15:33 -0700 (PDT)
Date: Thu, 23 Apr 2026 17:15:16 +0800
From: XIAO WU <shawdoxwu@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: a.s.protopopov@gmail.com, akpm@linux-foundation.org,
 ameryhung@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, brauner@kernel.org, brgerst@gmail.com,
 cgroups@vger.kernel.org, chenridong@huaweicloud.com, clm@meta.com,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 geliang@kernel.org, hannes@cmpxchg.org, haoluo@google.com, hawk@kernel.org,
 hui.zhu@linux.dev, ihor.solodrai@linux.dev, inwardvessel@gmail.com,
 jeffxu@chromium.org, jiayuan.chen@linux.dev, john.fastabend@gmail.com,
 jolsa@kernel.org, kees@kernel.org, kernel@jfarr.cc,
 kerneljasonxing@gmail.com, kpsingh@kernel.org, kuba@kernel.org,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, martin.lau@kernel.org,
 martin.lau@linux.dev, masahiroy@kernel.org, mhocko@kernel.org,
 mkoutny@suse.com, muchun.song@linux.dev, nathan@kernel.org,
 netdev@vger.kernel.org, ojeda@kernel.org, paul.chaignon@gmail.com,
 peterz@infradead.org, rdunlap@infradead.org, roman.gushchin@linux.dev,
 sdf@fomichev.me, shakeel.butt@linux.dev, shuah@kernel.org, song@kernel.org,
 tj@kernel.org, willemb@google.com, yonghong.song@linux.dev,
 zhuhui@kylinos.cn
Subject: Re: [RFC PATCH bpf-next v6 11/12] selftests/bpf: Add test for
 memcg_bpf_ops hierarchies
Message-ID: <20260423171516.00004adc@gmail.com>
Organization: CUHK
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
In-Reply-To: <958ccd923342ddd02e9122381d51319cb125ec51d601bb6fcad57531a2f5ef57@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,vger.kernel.org,huaweicloud.com,meta.com,iogearbox.net,davemloft.net,cmpxchg.org,google.com,linux.dev,chromium.org,jfarr.cc,kvack.org,suse.com,infradead.org,fomichev.me,kylinos.cn];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280677-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_GT_50(0.00)[56];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawdoxwu@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3541A44F2B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

> +cleanup:
> +	bpf_link__destroy(link1);
> +	bpf_link__destroy(link2);
> +	bpf_link__destroy(link3);
> +	memcg_ops__detach(skel);
> +	memcg_ops__destroy(skel);
>
> Can this crash if skel is NULL?

Yes, this is a valid bug in the selftest cleanup path.

If execution jumps to cleanup before memcg_ops__open_and_load()
succeeds, skel remains NULL. In that case, memcg_ops__detach(skel)
dereferences NULL through obj->skeleton in the generated detach helper,
as you pointed out.

This is also inconsistent with nearby tests in the same file that
already do if (skel) {
    memcg_ops__detach(skel);
    memcg_ops__destroy(skel);
}

The C repro, modeling the same control flow:

--8<--
// SPDX-License-Identifier: GPL-2.0
// PoC for cleanup-path NULL dereference in
test_memcg_ops_hierarchies().

#include <stdio.h>

struct bpf_object_skeleton {
    int dummy;
};

struct memcg_ops {
    struct bpf_object_skeleton *skeleton;
};

__attribute__((noinline))
static void bpf_object__detach_skeleton(struct bpf_object_skeleton *s)
{
    (void)s;
}

/* Matches generated skeleton helper shape from review mail. */
static inline void memcg_ops__detach(struct memcg_ops *obj)
{
    bpf_object__detach_skeleton(obj->skeleton);
}

static int setup_cgroup_environment_fail(void)
{
    return -1;
}

int main(void)
{
    int ret;
    struct memcg_ops *skel = NULL;

    fprintf(stderr, "[*] trigger cleanup with skel == NULL\n");

    /* Simulate early failure before open_and_load() assigns skel. */
    ret = setup_cgroup_environment_fail();
    if (ret)
        goto cleanup;

cleanup:
    /* Same problematic call pattern as in the test cleanup block. */
    memcg_ops__detach(skel);

    return 0;
}
--8<--


Signed-off-by: XIAO WU <shawdoxwu@gmail.com>

Thanks,

xiao

