Return-Path: <netdev+bounces-271284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB3hDX3ywmnCnQQAu9opvQ
	(envelope-from <netdev+bounces-271284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:22:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE331C42A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAA31301C126
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA05F349B0B;
	Tue, 24 Mar 2026 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ruc37CfH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0923358C6
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383695; cv=none; b=pWv+ICcCVTcyPD4amRDrrLvJIJBf+zO83BcjtRehFuE2EvFkPXHxmRacMz4JcH2kljXxZ/plJq1xVamtaOd5gcwRJ8Dbsk9dBCYJdab+/gk00R6kh/0zcWGgkH0DollcxSARhrnvP8udIAF//UOdzrKCWzF34e329WP22QWqFVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383695; c=relaxed/simple;
	bh=YekaUXXUymXZs/3g2Vp+S0NZBc707UWzjqqiXrrBWgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y1toIE52QjJJqxzkgMrMTkYgSyizi6Z3gziuy5Umbdg/1lXOyI5ziwmMfCTi5jKOxyQhJRHEua1n5FZO9Z/eB6m7AUHRLunQSb7MzHQhCVif5P1PNNt4bxG4wGRa2bXXvCfSPfF34L8iQyGs0Pgyu8XJwK0TiO/ACKHMYg+l+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ruc37CfH; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c0ecaae7dfso9525016eec.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774383694; x=1774988494; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YekaUXXUymXZs/3g2Vp+S0NZBc707UWzjqqiXrrBWgU=;
        b=Ruc37CfHS+B/+pv/hj0IEwYVhZcTJF25K97i2ijyp8k8T9wgtOHEJWnhGA6LPFioKB
         5ApXWklgKgV3osabwatO7QT/FkFdJw5JXH9gzmfPHPv+7992PyU4seEQsuxiqmm6O3Ny
         ozGbPB3w/MTOHQ7qKzOtVkayWp3vWo5xg+SWH7kLpPJxXZjJGXmgc9J+kzgEg0m9pNu+
         uhOCmBEAGSsXwAh+EQSXcYeoPOLCipDYV2ljD6A/z7iBgmqzpf2dAWVmIRx0KRd3fJ+j
         rcFsBooHKMuL7kaVk1z0tZLBuQLMHJ839PuTmWLa11xePpcRHP6Wjff642o7z3nhp6wp
         mbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774383694; x=1774988494;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YekaUXXUymXZs/3g2Vp+S0NZBc707UWzjqqiXrrBWgU=;
        b=rU81a2+uOwIytAyssswyMBqp3RA0Dln79LKOHVqqME/QVsqEZ4Y7syLJDtUFwxh3Mg
         WhFEbyaWvfs/ilX/ILiImdS64ubnED757aWaqSylKs4O295S+7+x/3RqNA6WRq+v0csw
         Z/lF23kn0s8pHiRrM7ncQYDOJyNGd87hVrFMfAX53EH9FHmuvLjlDbDdRTOcxvlvZq9K
         0W5mUVKoCEJYgTDchuhR7IBncsblHoVcKkXc/kHvlekCqCS3ciNETLC1TyXVB6MXluZu
         QkOQ1N1PqEuB/ay9e9Q9kygkwJFpMD315NXqL1B87Hao4Pv5H8ZjCg2uNPUjBDNNoXGn
         aizg==
X-Forwarded-Encrypted: i=1; AJvYcCXpHSPzjnv9aJiimxsAc/ChTurywRVVhhr+atShw+4Kd8PBx+8NEmElLtoECMYphrzvCeD510U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoSV76q5j05NQB9dmuAPi7ZaqqMRKAvh5ryQBeFuOj5jlseQg6
	0XlgO+G87IkP8QOhKKtKUjo9i3C+GfiJTmpMvFXmGiY3ZeIPeMiXQlOi
X-Gm-Gg: ATEYQzyOGo1mXtTIvOC0yCEpR6L9qVQSbtAxTXVTBMeH78uOblFPHu9yoQXz8Yvc3Ix
	ixBVUm7AVvQfpJckPOeslFoSlVMaZtitGVj3urYU1899raYONsnwMGVgbEX2CJ/wC8SQYN2Lfyj
	PHt4t6GVcfGfCT82B6z75cGK9GCwbTfgT6+ngpLv53ilZw5rR825/jrsy2FqanawCZFiuDtWlWO
	fqmTKNJ3jPrwjbzxeZz0l8wcrU6LjxYtuIMtLN5vnFugmkIO1vnZPD2SEvrUjKHJ0vRD8pq+JZG
	A3I2HLAr1ghS9M3RJLVuqq1eAdjWm2UF003IvM1jjh7wTvWbA/pxSp0tlcTAgato95EbxaB/IeY
	eiSJQYDZN2zMFLGMJJ7rr7Gj5VKVVPrxNshWw7oorzWQ0tnvTXP/nW4l2RDzdyUqRbOJBwveMXi
	JLUfLu8xHemEIt8XhjTDYLIpt8LeLbMMsPb2EnPziadShQr7U8CoQFcg9qYWo/SFqZa6Orhumt6
	IjiGg==
X-Received: by 2002:a05:7301:4e0b:b0:2c1:4b1d:a472 with SMTP id 5a478bee46e88-2c15d3fb1e1mr395106eec.29.1774383693468;
        Tue, 24 Mar 2026 13:21:33 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:41fb:8dcd:b77b:d6ce? ([2620:10d:c090:500::bed7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2ce04asm16295986eec.21.2026.03.24.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:21:32 -0700 (PDT)
Message-ID: <1de9261a98d6e4041ad2e99c745fd6be0831a492.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Support pointer param types via
 SCALAR_VALUE for trampolines
From: Eduard Zingerman <eddyz87@gmail.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, 	jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, 	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 linux-open-source@crowdstrike.com
Date: Tue, 24 Mar 2026 13:21:29 -0700
In-Reply-To: <20260314082127.7939-2-slava.imameev@crowdstrike.com>
References: <20260314082127.7939-1-slava.imameev@crowdstrike.com>
	 <20260314082127.7939-2-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	TAGGED_FROM(0.00)[bounces-271284-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E9DE331C42A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-03-14 at 19:21 +1100, Slava Imameev wrote:
> Add BPF verifier support for single- and multi-level pointer
> parameters and return values in BPF trampolines by treating these
> parameters as SCALAR_VALUE.
>=20
> This extends the existing support for int and void pointers that are
> already treated as SCALAR_VALUE.
>=20
> This provides consistent logic for single and multi-level pointers:
> if a type is treated as SCALAR for a single-level pointer, the same
> applies to multi-level pointers. The exception is pointer-to-struct,
> which is currently PTR_TO_BTF_ID for single-level but treated as
> scalar for multi-level pointers since the verifier lacks context
> to infer the size of target memory regions.
>=20
> Safety is ensured by existing BTF verification, which rejects invalid
> pointer types at the BTF verification stage.
>=20
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

