Return-Path: <netdev+bounces-293875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDdhDd3KHWrHeQkAu9opvQ
	(envelope-from <netdev+bounces-293875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:09:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2901623C23
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E86243092D52
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06433E16A9;
	Mon,  1 Jun 2026 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfOkREbR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8842306752
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336828; cv=none; b=qoXIXyegQLkIKOsb7ETWwz9WcDvHa3Tock9W8YsdVkzl6pw2j6EtMmBUuG8LqeERyuKptrOL8IPQu2A4GbeHon0Ib4JdHpW8Ge3UnoHb2hF0d0cksuhO15cXrrBddeEFBbtedG1xZIXtQAb2DczIEdOBwfrGjWopzmkuYm6wq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336828; c=relaxed/simple;
	bh=TEwcs9QV6IRkpLFCirJt9niMwetx10OpdmiVpveQtLE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OFAf0G+R/Z2ojLj3R2ywZpeewwCiRkfaP+2irDnIgWHOj1FhtvhFi59V41edKp/is63kwvJli5S/KGBaZwU7WIMt3BJAO8cCkb8jsXu8Tn82fNLpKV6ApykvnJtBKKoNIt5AZeINV5FL5Q4rvfhR/CighjQvgV+48ff/ljFBBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfOkREbR; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137ec563a95so887301c88.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780336827; x=1780941627; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=63QzUSItxjqthVwyw4x4XOqLTeOM5ciWj6AEgFnXSaY=;
        b=QfOkREbRRvj7gdvSSW73LCHtnfHqKN2pZElFZmegsNZgU7xzheP/pt84P5XaBw3zIZ
         W7HU2HQ8jU+Bp7QGnBzgdNlb3DNHssKRKzVMM8Nha+1b4chOdCi+mFUDIQXuCGKmn24S
         UBQ+bolbAgCbsWrwtbAh2UA1F6vghwQTkujxNXPpGF/b4JIHVjQA/mJIWULjb9g28S1r
         XO6xZZM1+dcAfFagQ8HpHLxgWgZWKpscAnRp9iEGD238kXJ74F3CGLuI2jgkw92NXMO8
         w57iBrBKmtT2v7SAbmD3SYurIc3GMX/uygd3M1zu2atN0hKMG6QlCfFijTnXUOxkpvAu
         ziGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336827; x=1780941627;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63QzUSItxjqthVwyw4x4XOqLTeOM5ciWj6AEgFnXSaY=;
        b=fFBZVW/opblaRqBZzt3tA1eID+9Uq18pYSZrz1us/osBBt6jyAG7sSe4Nk3qaZj6Ze
         liTgzepBGN6S/axo07W80imejfB12i7ZvrT2hBsGbFPFPeNn1mF+sTVxCqZHGQknzFXV
         VEjN6EKLgnUvvoghN6/pP6Jgn8o/s7gqI+ydNLJRXGFy3m4HRnoqPMy27gG4oXn6cG71
         4p9o4KFIMRS1Vfl4IkWPfIQ71XBzkkSdu0MkwJ/UwhjF2OKSyisMEpqeBdrIKGiwJCBJ
         58Y7bwCEiRclOnMxOpsb5tqMztx4BrgimkWRHDbZ7YzJvYBkUo4MqG9fOIKrg45VE0W6
         4jMA==
X-Gm-Message-State: AOJu0Yz+cBx9gVP/fEfS1IJIkYnrda2IU75bWctn0Z4C30yv8T3kK54n
	/VHrgsbD83m/qVJ8JqCBPmLdIYoAFGmE6+Oc5DYREY05+cdg4LS0dJe9
X-Gm-Gg: Acq92OHFHk/+gX0dIb/Wr7ev5eKinn1Fx6XZ/UQPe2OMgGBJe+0Rdb6P049cDvn+x1q
	493pmTcj9Br86BbKElidB4DaBVsd1jHpsoBkp1k9bpleFbRC/BIGU7eGA470jXqdIMmbmkwuJeC
	MQZDBBaFqFHaF51TKDtVDAzxfj4bkAZNcITTmpPG3+fN+Penopa/Q08q/5Cy9tYw08X6GxYsBPZ
	68mInBXLYQJSdwIxwRxDWTUqy2ikH9Q9Dnsb7qyYaUEPUvl6OLDphAmE2jpAiC8xaSqBfHjTYaj
	fpNaehD0saJfckMYSbTZ3OHg8PmmcVTsAHk9q/UXrzTUgHCvHUAMhbfB1uum0hVUN4pt+IJkhMK
	tC0XBcYc++fcsiOoTsvqrFsJPfxoq9DGNAub8Js2ekP1URNGSPI7t+5z0X1vIWRC87zi2XaKQo2
	VXxcPweTXe5rXL6JugfXSC+TZDXYck/ez/65qfmXa4O+HsrxL7u412ZGRR/c5+IGtXIBo9F8Yd+
	uPvJdDoNmpEIa+QRvj7ZI3n/GI=
X-Received: by 2002:a05:7022:4b:b0:137:6781:7dc7 with SMTP id a92af1059eb24-137d423c272mr4699930c88.19.1780336826867;
        Mon, 01 Jun 2026 11:00:26 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:34dc:a4cc:76e5:e597? ([2620:10d:c090:500::7acb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137dc179940sm5050092c88.5.2026.06.01.11.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:00:26 -0700 (PDT)
Message-ID: <1bf1a11fa5dcb38287384833dd77c748f3a766b7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 05/13] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Mon, 01 Jun 2026 11:00:24 -0700
In-Reply-To: <20260529014936.2811085-6-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
	 <20260529014936.2811085-6-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-293875-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D2901623C23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-05-28 at 18:49 -0700, Amery Hung wrote:

I think refsafe() needs an update.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 877338136009..5945956a7573 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

I think refsafe() needs an update as well.
Something like:

    --- a/kernel/bpf/states.c
    +++ b/kernel/bpf/states.c
    @@ -886,6 +886,7 @@ static bool refsafe(struct bpf_verifier_state *old,=
 struct bpf_verifier_state *c
    =20
            for (i =3D 0; i < old->acquired_refs; i++) {
                    if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap)=
 ||
    +                   !check_ids(old->refs[i].parent_id, cur->refs[i].par=
ent_id, idmap) ||
                        old->refs[i].type !=3D cur->refs[i].type)
                            return false;
                    switch (old->refs[i].type) {

Wdyt?

[...]

