Return-Path: <netdev+bounces-290126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLH3NLE1DmpN8QUAu9opvQ
	(envelope-from <netdev+bounces-290126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:29:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0FE59C06D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 701B230022F5
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBB63BED56;
	Wed, 20 May 2026 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/rFfpOD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B9B375F9C
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316141; cv=none; b=qs2+Wb+6ri8ysKoF/hkE6mdO+Rj3lqTjyQ4xtQy4YgOzvDi3pbl92u31cHqF8CM3yJR7FK358C8tmcdrxt07tW4mfpcsb7HsZLp5aUmUcabEtAKpNq7lahmBI0kFeRWF4yA7gNbinshQ+lP+icZiKL4BuQVexFVweLL+VjfcN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316141; c=relaxed/simple;
	bh=SP2atFYSkmnKyU0aqKVh99uzF7+QLksi19VL/Zr6SiU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rm64whauGL1DlfdwMb5gVKjWBbsSmenpvIOTQ+XXN3LmhdV6KmUKLiJ37s8UNMSATIif4RVGsGvdgxZR+tF0kIDOXl55p7TgEaGrTcjjL9DPTNwBQ5Y6k9ZgWIk/mdme/ow4qhNcWxasVRLURHGwmEyRpx5ObRojxYrk54lRTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/rFfpOD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3664df32e91so5796842a91.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 15:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779316140; x=1779920940; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SP2atFYSkmnKyU0aqKVh99uzF7+QLksi19VL/Zr6SiU=;
        b=X/rFfpOD/Hdne94jgS821ojiAZdF3B9vqDVu1WFjcV5RySIMgk9VMFur6jbg6EdEx8
         idtgNVSSlK1qHMDCp5WBIyrUXktd6agCJ+ExpAkN0GLprvVXnPIV6/aniec14SiVcPZM
         7gsTSi5s/iUiAntEybp7UAr2TtkiNgmqhCuyHy7kGN91yYRQzisNVX/Mwb0FwpgA2Rch
         qwvkjKKLK/vgzfWR/mSiYcCUBY8uEa0adeIS2ExUfgnticA7dPngooqP07RNm3vUztka
         mXMyFnZQzQHacpWW0/Rb9XWEo/N8bN1JIiEIlrU/ZssCjFB8xTe3bpx4asr2WTsieU7y
         vsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779316140; x=1779920940;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SP2atFYSkmnKyU0aqKVh99uzF7+QLksi19VL/Zr6SiU=;
        b=pBKkLha9CvH9HJquzNM58e9f0zLeGHSTXb7SnhsPXUxKXgCWuP3zTv6WM+3nzUBj/G
         DvzLsDxXbfCBKq9fTs1NUGjA+DHce/eMYUO+u1TVqoBsjtt4yN9XWBrsoe6fYaj7zj1J
         SW7OQWghCasVt64FYif3oH7/PNeJCxWKs+UJzrZ/Q8+X1AGsNnTXCmYLDaD8EY/9+Vle
         +ow8b+QTGA0pzTdFs69J5fENlwH7KDq/UHXnj8JWbqJE3cLSfemhvvvWBKNbBqoiQjMB
         GPo6ysCVx/8WqKKkO3+yIxGNrzIo7Rkmht7WG0qZNPowGgpz2qZIrZCTPyGG1dx0BepV
         gxRA==
X-Gm-Message-State: AOJu0YzgLATvjnU7N9gsVehhn0Gz0OaJS8AfsC8YlOfH+QL9rX5tF7nN
	jIVJHLoJOi032l1Kd+hNyp5yfzLN7KtSYHRd6BCWscB4VVwLuj2j7VAn
X-Gm-Gg: Acq92OFm9iuv+wCpboMkH/TcCwIQRtIys117bEIYLpCFe58tHJvwrKusDVR6oC10fLu
	cFowuqrIaGMR22+LJslHwl7egYnf3EeMTVs2520MQNbsytUj2XajAxwZQLwCo8jL31MSP+zn4Xl
	m+4ln27uMJA1ZjYtlKWc8tgnTbVSXi/Is/1ot4qR2rp9HejDz39xND8ksTESGqWQg/RQ390UQu0
	4zMz9rmxFFcs+C2BZOafPCLUwLODla71LJEpS7QiVtRQOiMtysNxVmS6vZGalH3iLiffIV2eRPN
	8vAzcpbrzcg5bYLnLT5Fr7PyGFhjT7Nb67m+N5/T8NVVbHmzyV69x6xo5/H9jpBRs6ygBAg0UqV
	APAJCeXxDSXJCT/TxO66WhGiMXOSEIpU5qpaDw7PpIT+mw4AQBsQ8AVHg5Npl2hnqRsahlZMN+L
	hd2L/Q1gh8YyS+NKkAOjSqIKJgHra8Mef04X2jpDGpPAaTHGrY5Bux
X-Received: by 2002:a17:90b:2583:b0:369:d7c6:450a with SMTP id 98e67ed59e1d1-36a4388a6bemr455068a91.0.1779316139964;
        Wed, 20 May 2026 15:28:59 -0700 (PDT)
Received: from [192.168.0.161] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3cc88b29sm619124a91.11.2026.05.20.15.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:28:59 -0700 (PDT)
Message-ID: <94954f57c4130610ca740f04b49941d04ee498da.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 07/14] bpf: Unify referenced object tracking
 in verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Wed, 20 May 2026 15:28:56 -0700
In-Reply-To: <20260519181314.2731658-8-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
	 <20260519181314.2731658-8-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290126-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8F0FE59C06D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-05-19 at 11:13 -0700, Amery Hung wrote:
> Helpers and kfuncs independently tracked referenced object metadata (id,
> ref_obj_id) using separate fields in their respective arg_meta structs.
> This led to duplicated logic and inconsistent error handling between the
> two paths.
>=20
> Introduce struct ref_obj_desc to consolidate these fields along with a
> count of how many arguments carry a reference. Add update_ref_obj() to
> populate it from a bpf_reg_state, replacing open-coded assignments in
> check_func_arg(), check_kfunc_args(), and process_iter_arg(). Add
> validate_ref_obj() to check for ambiguous ref_obj before using it.
>=20
> For ref_obj releasing helpers and kfuncs, keep checking it before
> calling update_ref_obj() for now. A later patch will make these
> functions not depending on ref_obj. For other users of ref_obj, move the
> checks to the use locations. For helper, this means moving the checks
> inside helper_multiple_ref_obj_use() to use locations.
> is_acquire_function() is dropped as ref_obj is never used.
>=20
> Pass ref_obj_desc into process_dynptr_func()/mark_stack_slots_dynptr()
> instead of a bare parent_id to make it less confusing.
>=20
> Drop the selftest introduced in 7ec899ac90a2 (=E2=80=9Cselftests/bpf: Neg=
ative
> test case for ref_obj_id in args=E2=80=9D) since the verifier no longer
> complains about ambiguous ref_obj if it is not used.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

