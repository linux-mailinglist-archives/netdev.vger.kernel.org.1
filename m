Return-Path: <netdev+bounces-289644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA2eEnvpDGqapwUAu9opvQ
	(envelope-from <netdev+bounces-289644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:51:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51058585D64
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AFB93008D16
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AEA3314C4;
	Tue, 19 May 2026 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="YGwlI5Oq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243994502A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231093; cv=pass; b=EkWiHnkl/XNVXo5s8s26rWPddGjV6J8Oi7ZTnXQjrLT2RKKmQEYmDdiQbiN4eGt/S3fKAXjlEcTVGOpd/h3IAm5Ei5JwPsIwicj9hp46Kt0zWzV0GhPxhvdsX/XkraxoPyV0wN3BBHCbPZ1yQi2v3qFtehBlIO0akTZva0EZjAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231093; c=relaxed/simple;
	bh=MVS6wmu94837v/zO7IT9E3k18G8mMTgMnPTm/vqstfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5NDQnJ+X8Wrcp0XYqzP8yqCB8k/PLHzJd5vI0AshXAsNr/A6G1ccDR2OJPCiT5GaVFEw4hqG+xKmeDgxn95ahA7afF/3gEG8s4zFeMpHmEjFMb5waTH8DSQ9WJvkk8apB0XiGIKkG6Cci99h5BdKBK1B1EA+Bqy1nNTzsF7tUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=YGwlI5Oq; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9125d2a4d36so283251785a.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779231091; cv=none;
        d=google.com; s=arc-20240605;
        b=QhwiMjW1ehCWwCRLtbaKiVUm2TSR/IqElm1n72xjj1oFacA5TZDvfqb5VUEHie2PYm
         yBuGFFznrW0qLbgZ/P8GNWLXfpbNLJ02goHrx3pK7dp+InAtqwmu6ZAKBYZxJpClnOnz
         2g/OQQnIdNXorVwtmH/9xvJ+68+OSU3go8DVhBrBOMzBiyu1+GpPbDQ8tqNsXfJXyfJS
         MolakACkvdBpVFW1vzO9s/YxGcuetWGr80ih0XyHIghrYpNaoYWuFj7CvbgwM+8Ey08/
         w+x+6QDrxbJdSdkI7zp1P8S37wXueB8ZyCyzUiPa7QKGZ12f65+BUZ77oRdfjJ13loPQ
         GXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MVS6wmu94837v/zO7IT9E3k18G8mMTgMnPTm/vqstfE=;
        fh=kd9pmBGzLS3bAC0BdRNVWsFZNa0NHTjcZiMyeE0e0Hc=;
        b=Pz2gX+0xOLU7fCGhaxOt4L+IT5AHLQSoZMlNz9cqHqys9qBgUqsxSur0TXGHO8IJMX
         IyFXThW/RDQ2vfdRFTplnHSUQ5QzxeEsNPLbcCA3aVkjK+8YDKaYqVsQ/uNfoxkYOe5I
         A/WZUE7UnS/1dSIUE2h/26chO5m+r8CqRCjrnEMAfO7tBLDIhz7K4yfU4NAn65kMwn1U
         LxMnppX0zZiaHp4zHLaTeeYbvekxYsgfshwNVtMO+Hi+hSSHf5s2l8KpFM9yaLLZ7sz2
         oeU+AwKzMWsb7XP0VGiOEUOjaFvgcuOBhthmwYQc5/egpVMiVQZDPLB86S/lOfSbwbz6
         Br/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1779231091; x=1779835891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVS6wmu94837v/zO7IT9E3k18G8mMTgMnPTm/vqstfE=;
        b=YGwlI5Oq17JscwAzn7XHqHkRF8fk/S1q44e2xL1vQ1iCLKteCk3u77NB+tSR4crvD2
         evOtnR97cuch/OkVeP7JevacU0fIBGfRqAd5/aVr3y3YwNR13nNVz9/ANzDFs3CH7TmW
         EQZPgxjTuVjvTHLzGmGYKYmeEhbiqY/J58G7El49gQSZsrZdhnePEuXXFutGkFvibvi7
         8q7awGwx+YMLm++fW0Q4JDOsIQSseUY+h2IOcEowBh5WYUe8Use5Ie+cil6FiJSdN45p
         bOYGvC+RHLzl78Ij7rjrlfsSA0KkI4Q/EixvT+nWFlbEOSyeF5jss9xn/J3k5rRRwA3g
         Kdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779231091; x=1779835891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MVS6wmu94837v/zO7IT9E3k18G8mMTgMnPTm/vqstfE=;
        b=sYOcALVGT1Pk0de5ku3q5mE2hpXXR4eTlfrR8tVOhtLEEPVYnqHNYbCxXXSMioC3QA
         eAF53NpiCwYG6kD8WaAOuoFow+ws/ioZ7DP4t0WpAZqYSW4CdGLlfw/oMmGjpsoEHeWa
         OX+VakuF1NV05S5EOMaoALplxjpX9V7gpymCUwhGJamLshwQoE0S5K4vgyaTOl7tl5B9
         Wa0KzQ4sJBU6cGrbgUPOqW7U46+pmeqBmEBPqIbWGydft+9rM7kivjvIAQVmU9mDUdxR
         FghLj/5+z+L1g3sMzDHB/SxJH6w9V2xTKxcBlIxaSoI2IqUZlR+QJ0nhO6ZIsduxjqcb
         Qr9A==
X-Gm-Message-State: AOJu0YyOZXZ1hE9iFu5TpggkTTDMuUSKf2ZctlXIi3KHYM5Wr8DlPh1v
	Qcymw1D0gMmFZ6bPfnIkgH3IzG3CXZut0QKZU361ra4UHJNg3qORBPGKTa4Re6FE3C8Xf7CUBAI
	Nm68cxLz4IyEDR4CoFhN7ucoVorhT6NnTiQKdqGFmnSgoMA9JLbfR
X-Gm-Gg: Acq92OHU5sLKYP7kOZzQWp4j8cdYiHOKVB3qN8JUV5mu9UjDNMbQdclivKt1LYEtRCD
	ZRisaDOX+tKEbYTEuaNuYHD5hvhRiLZDbiPl+P92+ElWiid16DV4/W4h/9PYTpwbfSBpAkKxFO9
	qz5xyCrKznThNoPgYm+jrVV7B7ZAqX0OFAJqcTIzfUV8vIbKDf0TG0Dh9EPc8n14CYcWU6imq1J
	x0mxzp8nrzoWOTp8XUzeCrvS0Dq8VximNEBM7h5XOAoUFae3hZ1Y/RrIbSfY32uuucR3TIL/EJy
	t1HGXJvYbAj0a6wEvFalusYMSntC62PWTMV2ZiGFPncSIpHeoQ==
X-Received: by 2002:a05:620a:4627:b0:90f:9cde:9782 with SMTP id
 af79cd13be357-911cd958161mr3349310885a.17.1779231091074; Tue, 19 May 2026
 15:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agqkMwgM1PdkyMUR@juliahub.com> <87mrxwmxmy.fsf@nvidia.com>
In-Reply-To: <87mrxwmxmy.fsf@nvidia.com>
From: Keno Fischer <keno@juliahub.com>
Date: Tue, 19 May 2026 18:50:55 -0400
X-Gm-Features: AVHnY4KZ1CFgMma4srRYQcdgNCVwZDa_I7PxIYUDeaY_xFfjnf8miUD-UzfvNxs
Message-ID: <CABV8kRyQuior0c6KPpOb1gqUHUKzm=LOdnms-auXFLGNgWnVKQ@mail.gmail.com>
Subject: Re: [PATCH net-next] mlxsw: spectrum_ethtool: expose per-PG rx_discards
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[juliahub.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[juliahub.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[keno@juliahub.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-289644-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[juliahub.com:+]
X-Rspamd-Queue-Id: 51058585D64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 1:33=E2=80=AFPM Petr Machata <petrm@nvidia.com> wro=
te:
> Keno Fischer <keno@juliahub.com> writes:
> >
> > Of note, from emperical testing, these counter are per-"priority group"
> > (PG) not per-"switch priority". It's a bit confusing, because the rest
> > of these counter are per-"switch priority" and the header file calls
> > these "Per Priority Group Counters". However, that should be read as
> > "(Per Priority) Group Counters", not "Per (Priority Group) Counters".
>
> I think it's (Per-Priority Group) Counters. As in group of counters that
> are per priority. Similarly there's the "Ethernet Discard Counter Group
> Counters". These names come from the HW manual.

Yes, that's what I meant, sorry if that wasn't clear.
I meant to make the distinction that this comment
is correct for all other counters (even if marginally
misleading), but not quite this one, since it is
Per-Priority-Group, not Per-Priority (i.e. if you
map 3:2, you will get the prio_3 counters,
but the rx_discards_pg2 counters).
I think we're on the same page, just spelling it out for the record.

> LGTM, thanks!
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Thanks!

