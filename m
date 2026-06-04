Return-Path: <netdev+bounces-295477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tBHZEbwIImovRwEAu9opvQ
	(envelope-from <netdev+bounces-295477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 01:22:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7FB643F05
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 01:22:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VhikLx3Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295477-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295477-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB94A301DB97
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 23:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24125356768;
	Thu,  4 Jun 2026 23:21:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F63BBFD4
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 23:21:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615283; cv=none; b=EikhHrqbhHrdTVWEYRetvQHO5dzl13esSSiLX4+Q9VcrPeokHlo7t4B5a3T5r/Sxrkl1Gtjzw+015I6lL42t6E8zrcF7Uw4mwsaJsR3Jea56RbxWYc1mR2+onAR4xDG9LAVg+JLcn9dzmCUGoW3AfJW+ulWMEX2iU59NxnkhjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615283; c=relaxed/simple;
	bh=7U/szfgXKtXMnDv3RqDoe2ETwCv4LarwWXNMMbO3ur4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nAvySSqBMK3ifJtiOBBxwF38pqtPhdRSAjxS7WHniP10NurQ216Cuz6TYOqAeaovpqBijBbc63MmR36hAHMdZtPfVIfWJj+N60iv7uBcmv5IDS38F/ZPcVikkrQVZQoShVsKRu2wl3Kquv1b0xyDd2MkN1Z8l9n/yWFo0vEZPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhikLx3Z; arc=none smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8423f626a65so552041b3a.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 16:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780615281; x=1781220081; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eHWZ6A9B/1c/c8Z7W9iMQrXkzA6+51AuQekNuyU9bqI=;
        b=VhikLx3ZAzO6ZumEvHpaQDfkaZaXQGcvqfrOrTFe8FVZh3aIJACkNC7UN8cQJAOJjd
         Y0RQm1ASKbvWNHZr1zFihuoNjD5eYsPQS72/aF0/yMPxmmarqsw43wV3QwJ3J9uN+lHv
         FtQU8x4pEq75+GMVHRPPAzeGSxXp6iswoitV38dwyOwW6O9ch4BnO1MBQoINAyJnBgQZ
         Lra0nZ3Qc83D6NhjhDA48SNgEurcWNDutG9rF0IxN+NaCg+PTPamCX53VatV9EkzWrKC
         4NlZ2C7sTtjgt9f9Ha9iwRfSjeF7XdJXfZebBZl6j9EpaI/liezHVPzUZF7anNJex9gJ
         +Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780615281; x=1781220081;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHWZ6A9B/1c/c8Z7W9iMQrXkzA6+51AuQekNuyU9bqI=;
        b=S3sXUOj/puELMpKMVx9oEQpljkkYfzJPRuaK57gCwUDVdOEyiJMc1wkZhok3+lpV+Y
         s8GkK49m/pyGt2N7nwnsI2q+zFCeWDUI0N40wOg1mNqUvAxu2r4nKEjCcnYQzvoMz8JE
         GjdO3X1sBaE9or4QStkpEiMASy9T/y8NF+MPTNudkEZUDydqsGLjtfktVYxc4VKp6wbz
         8ZgPUc3bbGvTNjkQkinFMa+MSEJOL3CoscdQdbZ8Sh3l34DJip517KoQF38oWsQ5gN7z
         n6OYaAFP9vnxUPG2jkeDSXVIXnUYd8lcmfwWnhtb3PBR89C31iu7SI0ykfDvkkCv/oHt
         mJCg==
X-Gm-Message-State: AOJu0Ywq0TxyBCAt5y3sCY9Tvgdh1QBquEPkxuwPKQaD1qnNnBQ66QtJ
	Yc0VOwahznbYqsMojIK20oF0xpx0eIPX5RCOujouNRMBd1L7Fayj3mkk
X-Gm-Gg: Acq92OE8P1ZHaIzSpOJ3TXz/91nmlIg2AEgd267lzkkttAxs/o3A3g22OXMafyap9O7
	2WZ20/NgOUaCuc9dXl5Tsodla2gyUihpp9OtcyrpQAvrHpizo6c94bqDqHVl5Sk8qaE1WLCFU/c
	vx9ZUxYqaxyR3kr1dQfEpIoPJG4r/GmO7EMZouWDeL2GIQiZXj8qLF5Hi7p8HZf1LulqGzTMLYG
	NdUZrVYE6hpzfRLkpjwynob86WQk9aHDRN+XU9o+V+NJ5XkeBdBQZJXwDhOQOTDACLv/SC+fsXC
	NGQI7kC5ru2h5bmk14QFaddmjoLzulRxKchtnbvekJ9OkeyUD48vmv9ck2KQBOC7iJFJZgC8hhq
	M4HP6Bf/lJUfKP8GHsWyDgpg/7B9in6STsmlqjp35E/uRxwxeKEihazE93b9a75ckpE4/2UzfVX
	7D+KjiASSM5AjOLK/hTKzlKRfTOoAAWx0Bcb8LTl2lLmiUVSawh9P2dfgBajxaFQ==
X-Received: by 2002:a05:6a00:1d83:b0:842:3ca9:32d5 with SMTP id d2e1a72fcca58-842b0e2048emr690165b3a.5.1780615281146;
        Thu, 04 Jun 2026 16:21:21 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a2600sm7739586b3a.27.2026.06.04.16.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:21:20 -0700 (PDT)
Message-ID: <b4302a13ccae77b304a09b47c58565c8ff1970c2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Compare parent_id in refsafe() for
 REF_TYPE_PTR
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, ameryhung@gmail.com, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com, ast@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Date: Thu, 04 Jun 2026 16:21:17 -0700
In-Reply-To: <a5988106169c7350f39a4d07b36b679a5fb39cda49ca371cb79c23da7b63971d@mail.kernel.org>
References: <20260604220904.1032145-3-ameryhung@gmail.com>
	 <a5988106169c7350f39a4d07b36b679a5fb39cda49ca371cb79c23da7b63971d@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-295477-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bot+bpf-ci@kernel.org,m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:kernel-team@meta.com,m:ast@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:bot@kernel.org,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F7FB643F05

On Thu, 2026-06-04 at 22:59 +0000, bot+bpf-ci@kernel.org wrote:
> > commit 89f2be9817e074d02702d22068104fb9fd9aa103
> > Author: Amery Hung <ameryhung@gmail.com>
> > Date:=C2=A0=C2=A0 Thu Jun 4 15:09:03 2026 -0700
> >=20
> > =C2=A0=C2=A0=C2=A0 bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
> >=20
> > =C2=A0=C2=A0=C2=A0 refsafe() compared each reference's id and type but =
not its parent_id,
> > =C2=A0=C2=A0=C2=A0 so two states whose PTR references differ only in th=
e parent object they
> > =C2=A0=C2=A0=C2=A0 were derived from could be wrongly treated as equiva=
lent and pruned. Fix
> > =C2=A0=C2=A0=C2=A0 it by checking parent_id too.
> >=20
> > =C2=A0=C2=A0=C2=A0 Signed-off-by: Amery Hung <ameryhung@gmail.com>
>=20
> This looks like a bug fix for parent_id tracking support. Should this
> include:
>=20
> =C2=A0 Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking a=
nd fix dynptr UAF bug")
>=20
> When commit 308c7a0ae885 added parent_id tracking, it updated several
> safety-checking functions to compare parent_id but missed adding the
> parent_id check in refsafe() for the REF_TYPE_PTR case. This caused state=
s
> with different parent objects to be incorrectly treated as equivalent
> during state pruning.
>=20
> > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > index 5945956a7573..06d9ae24f006 100644
> > --- a/kernel/bpf/states.c
> > +++ b/kernel/bpf/states.c
> > @@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *old,=
 struct bpf_verifier_state *c
> > =C2=A0			return false;
> > =C2=A0		switch (old->refs[i].type) {
> > =C2=A0		case REF_TYPE_PTR:
> > +			if (!check_ids(old->refs[i].parent_id, cur->refs[i].parent_id, idma=
p))
> > +				return false;
> > +			break;
> > =C2=A0		case REF_TYPE_IRQ:
> > =C2=A0			break;
> > =C2=A0		case REF_TYPE_LOCK:
>=20
> This adds an extra check_ids() call for parent_id. Could this make it
> easier to trigger the WARN_ON_ONCE() in check_ids() via BPF_ID_MAP_SIZE
> exhaustion?

I think the bot has the point here. Let's switch to reallocating idmap
or failing check_ids() if there are to many ids (probably an
unrealistic scenario).

