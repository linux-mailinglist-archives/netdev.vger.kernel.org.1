Return-Path: <netdev+bounces-260320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOt/LX4ZnWlsMwQAu9opvQ
	(envelope-from <netdev+bounces-260320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:22:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3561815DA
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73FB7303131D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5256323EA8D;
	Tue, 24 Feb 2026 03:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="AT3ln8Bd"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9229B76F
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771903303; cv=none; b=QI7tKaUc3L0SxxmlDCSTOiagY94vHMVWmkNjBqDomRGdhs5un8oDuBqm1tzrkW8m4tirkGz06BgXfZJCIKmVcVNFHJNL7o/Wc7e8Pav4zGd05TvTmQkPPA2sTe0DmAtK+4obHRppjrdpfA/xbFJVqx688F7dePWwKYYwl9/lofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771903303; c=relaxed/simple;
	bh=keOp2UBldaBSW3ji02nyMWxZVH/B/Rce8DhgJIAy7ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yo3ay8LySOPF8LbNE6Ljng+4Jb8rzvecGaARJzRAXVNYRgBDcf7rmimqY6eMJaaQ9e0lzeNJEx6Po0EnDNBbVD3pxv5JX54XSW5xRL9BNuryKAoePnR2Pdl/9k2YgjaEXLDNDCDhiqYpgNe1jgLCxaR+rETl1Oqu6dz+EFybsyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=AT3ln8Bd; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (99.223.13.160.dy.iij4u.or.jp [160.13.223.99])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61O3Lc6f091715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 24 Feb 2026 12:21:39 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=OORvIcpt40NrPzm7C1YMEidPOm71ORHbhwbkLwDDqi8=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1771903299; v=1;
        b=AT3ln8Bd03cWXIjcsuqiqWmScp9ar1ujPefGkK2FlGtMhfcuKAca4UkJ3ZE2b3/x
         eSBQlfkCE67+SRlC0V5+4PJXxuAz6JcvvRjRGhiqqDihwm/JSnVblOBkMblDLbKg
         Oh9kqLJlMWi3NArFHUx34J9So6Lu9RXd0z0Ex7DYZkcCr6GKwtZk+SfKRuN0PgtH
         mfon5YzeLl123MGYf8x/xU8xTxhjIGSemyJCEtDOmt7UEyjLX34cfrY9vTd0WxzK
         1pGuw7J4JHSwfj8DLQ5UF7rtvKPSGoUSU1MsfIsUVQwis8dRo+CJVX+aC8apuVuv
         AAQ4VRlxTzLjatfyTt0UHg==
From: Kohei Enju <kohei@enjuk.jp>
To: kohei@enjuk.jp
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
        haoluo@google.com, hawk@kernel.org, joamaki@gmail.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kohei.enju@gmail.com,
        kpsingh@kernel.org, kuba@kernel.org, martin.lau@linux.dev,
        netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
        syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com, toke@redhat.com,
        yonghong.song@linux.dev
Subject: Re: [PATCH v3 bpf] bpf: devmap: fix stack-out-of-bounds write in get_upper_ifindexes()
Date: Tue, 24 Feb 2026 03:21:38 +0000
Message-ID: <20260224032138.39888-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224031556.38398-1-kohei@enjuk.jp>
References: <20260224031556.38398-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,linux.dev,fomichev.me,syzkaller.appspotmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260320-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,10cc7f13760b31bd2e61];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:mid,enjuk.jp:dkim]
X-Rspamd-Queue-Id: 1E3561815DA
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 03:15:37 +0000, Kohei Enju wrote:

[...]
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 2625601de76e..d8e926a2d0da 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -588,18 +588,22 @@ static inline bool is_ifindex_excluded(int *excluded, int num_excluded, int ifin
>  }
>  
>  /* Get ifindex of each upper device. 'indexes' must be able to hold at
> - * least MAX_NEST_DEV elements.
> - * Returns the number of ifindexes added.
> + * least 'max' elements.
> + * Returns the number of ifindexes added, or -EOVERFLOW if there are too 

Ugh, I missed trailing space. Will send v4 after 24 hours.

[...]

