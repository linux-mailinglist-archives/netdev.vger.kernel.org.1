Return-Path: <netdev+bounces-268287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFCMHmd4uGn5dgEAu9opvQ
	(envelope-from <netdev+bounces-268287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:38:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A442A10E3
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2650E300874A
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B52434DB78;
	Mon, 16 Mar 2026 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwsreuVr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45120FAAB
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696950; cv=none; b=bBrsClrwP1/5XdwZU8O956I67Wa3drYDvwzLj8X2lEN/jNahU67CFXJMHgb6O8doaPWsim0wewoggyDRMrfsUo5D6OOIIbZzmbH4KEhomsUjss0eVCzIt6ixnfxiBQLT19pHpCwUOwQ2DlajynnSAfXojVgutQoFeaEcwzpRQT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696950; c=relaxed/simple;
	bh=Y2ydpJMk3ZlWBU6AhADB5LMwqIZAStXoc5F7Opp4G7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uABc10VT+OODueVifBEF0afG1pYvo8Y7tHbDzwr3z/fnkIr9/RUxDa4CsdATV23fzSSSHKFPeyBD89NxGwf/ppJHbqBfw/ZUfpkXZMrMtz6P3EMmjGbyoUVN8LOU1Fl8PwpSXc2lQOsVFxKgWhiX6Zv+EsofXBB1mHW2SlyUqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwsreuVr; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bea8a1c040so3039731eec.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 14:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773696948; x=1774301748; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y2ydpJMk3ZlWBU6AhADB5LMwqIZAStXoc5F7Opp4G7Y=;
        b=KwsreuVrHGql7J6Ht2Cvl3N/TmlCPAXhrnaNgzqPweEyTCvs1Ip9NJ4Ps3QhQx2PE0
         j/84O7mh7wbTqadFBAVABbBfgnqd+whth+vnHGQ/Y7WsSxx79Ttw6EQEODrvgbse2rdN
         R8ZccGaeJTY09LFgPHiqPcLCt3IGMLQRSi+SHueJHKvrHpLnDZDk02gRpzUWXMtBF9Ot
         7GMRMfWCOaF/tkglCMz17SwxJwc/PBBx8nHUjDwxJp54Y1K9QsU5dXq2hLt4nXy+3BIE
         ghZCS5eFdDlkjDxR+bw1icAw/G0L2ThXsPg/Pjg0ZMSHAFlOoID1V3uDPAeIOO/cQqkH
         a9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696948; x=1774301748;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2ydpJMk3ZlWBU6AhADB5LMwqIZAStXoc5F7Opp4G7Y=;
        b=WRYLEFEw8d19kXgsFnJQDgX9lGSOs0OD0RxcHlspEAAYF49RkRmsVSo1cWDFlN9XpL
         ouo9FA2z3Y+DHP+ehhoM6EvJY/cQFd+oTte4d1kKTZqXzmzqqt4EEfAdOf/a9RDk8VmO
         zREYlgrbrSRCH1MiL68ueXnZ1Xa08Catk3CZlPfUYfhLfAaor1iBbYHSsaqVRbIaCPIs
         kEMnFBnI9B/vt3e9Vej7Ebu8r71UqvicxTZdaocJp5jCtlFAFNr+906HPk5dhBn5Gyq3
         oj9RD1JjRvk3qO2kN4sua5V0Zi6Hp715I+EWRyUPRzBHZ8/aljKdBj9at8AuekJKUzGw
         +GrA==
X-Gm-Message-State: AOJu0YxmpwLoumiYYoDGmYMFyYQq8eRGZKdpp1ulR9DC9pIzSnOhXkP2
	7SEWftvxpoJC1r30HZ0hJwgrMGi4+d9QniVd8w5pXhcUC0dR4udgZgVs
X-Gm-Gg: ATEYQzyc+IUBIuC0fOvc5Xj8PpKoY/SOuaBiUZ0vhYFF9IWvRZgvCxfE5EZo4lZnvhG
	n2lrWX5OBeJ3dgDcnS03J4DqfK1ETe+S4TbU0UvIGpXxHwUJVBfqdgm8CQ8rhj3IAUe8jJ8q4by
	4nrhNPzYbTNDK+MdFXRo8Nam+lTWxPaxWcn44TP9irs7WYLhjXprsfuDrRYXlrYFfNHrIxWTk8z
	3dNfcWTNFPmKxyAn7yL66tmrUToXh4LzrwQJR4xL7189PDUecf/ij5/KSGg0NCksUpjeCcNEBHH
	xuZYtIbUirse2GEr0Pl4U2zXIW5mq4LNzXMq+DKCXp1PKQn9b8axwEz3pqSR9FxVOADEoZVahRY
	z2nwBoLJOUnX6Hp0LcVjVV+N8wVr9lCH3ioQbFbAIQmyo+XuvpR4KHOHfJVS2mCASLOn+AeetLD
	qWzwgDT7dyTKjm9OR0r6CZWgIi7+MVMKvIT3Tv49WbkCB+YIO8vyC54EbO2fk=
X-Received: by 2002:a05:7300:6c27:b0:2ba:8706:d022 with SMTP id 5a478bee46e88-2bea54de53emr5565490eec.18.1773696948153;
        Mon, 16 Mar 2026 14:35:48 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::7bc? ([2620:10d:c090:600::76f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0bfd41aacsm8878081eec.27.2026.03.16.14.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:35:47 -0700 (PDT)
Message-ID: <26897fdb11234b8dca4cc6700325428d63847d18.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 02/11] selftests/bpf: Test passing
 CONST_PTR_TO_DYNPTR to kfunc that may mutate dynptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Date: Mon, 16 Mar 2026 14:35:46 -0700
In-Reply-To: <20260307064439.3247440-3-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
	 <20260307064439.3247440-3-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268287-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 22A442A10E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-06 at 22:44 -0800, Amery Hung wrote:
> Make sure for kfunc that takes mutable dynptr argument, verifier rejects
> passing CONST_PTR_TO_DYNPTR to it.
>=20
> Rename struct sample to test_sample to avoid a conflict with the
> definition in vmlinux.h
>=20
> In test_kfunc_dynptr_param.c, initialize dynptr to 0 to avoid
> -Wuninitialized-const-pointer warning.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

