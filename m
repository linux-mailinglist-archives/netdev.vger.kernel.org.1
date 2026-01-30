Return-Path: <netdev+bounces-255230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBCHOrL+fGnLPgIAu9opvQ
	(envelope-from <netdev+bounces-255230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:55:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD71BE038
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0D33301368E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE337F738;
	Fri, 30 Jan 2026 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QroVKV0S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88E33C534
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799313; cv=pass; b=P+equPbnZ4MH/UvtfamwmSEMNcCIwnhULyABazC4wOkpL/ki5ISre/vtLuwvrTndncV0aFHhAmohmcwHEYQTfjgVh9yXgQ+b9YhPyJiXRa7PbJVd2liYgAZSVnsheH6Vq1wqFRXYueZROJPL4BuDDdGuRmdksC/E328bN1B5Z9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799313; c=relaxed/simple;
	bh=ABEZfxsW2syqPlu6/K4Mc72DV+nXVeyyt3BSfY8vI3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/fxH5yd66RxVWvm9IlVmyqbdOiGvKLhesfnIkizrLY+E3NPJo2LcU03Em/FSNTB5UzrK6QeFIlZOrrPSoWlPYz/QbH0mL2rU/cqMjW2f9RBXOVzkZRmVT6Er4T5nshmb+0YoSNMX15Ou+qjMvvDPBEg+3dmMlwqInPo1eg9IDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QroVKV0S; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c07bc2ad13so192425985a.2
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 10:55:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769799311; cv=none;
        d=google.com; s=arc-20240605;
        b=cSurMD/fVKHjThUAXsVvNtE/1PsP0NYv/oHI7smzl5gD9pTJVXUv2IDcyJrY0t56re
         hiVTUP7uHCfoOv27FIJ3y9Phfs/H7Nba1h6rm0L/IM84x/gSGfCb0nsq//WguwGG87iy
         aEcowdwu9gN+rlZHZN5Lx15J3fZiB4tptUA8hVoAC3vG9Gjz1KCwzw7/d0CdGdCyTKGt
         2R4Q3h4NSVt1E9CfvOfMjeVjou6Y7rQviMTmfs5JLx7kIZPsGvHSsGm4fX2UyuSA8EI1
         205ZdEsRpto7sW00R6bNW2en8Cn0p8S7LTCNA3S5hixDYCWXuHxh27y5UbPt+5p5jl5c
         789A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ABEZfxsW2syqPlu6/K4Mc72DV+nXVeyyt3BSfY8vI3Q=;
        fh=m/3daOiLONGVWI8KMCEcXnFlX+z/pmY/B3PJ0/IL/fE=;
        b=IjqM+LafbWeuenDw7Ul8BkMfGm8FmVYbZI3kzxIrSL9gwag8E0n2FtZCGJpVqtnFhA
         TTlfSQgem3QV6L2VB2CD+yTwhWYkEAGizr+MiesbfF4XFAMiLOf8emczpSSGa4bqKzhM
         NnrIPN9zDofhCOgSq8H6TAdlzJokXkSrgeaAPAbva9nIIYZ6MDgG92hOysBHu/eO05JP
         DNLSieMSxDvB9JtBbD7VvRi3WzeiDFgYpSsmS1Fr9FNqzb1sOLvRF24rvMc4/68KtRBJ
         Ur2Qts6gq0oQmwMH7tHOkJBS7mxROOGl18p6cwVdPDBojngW0v4SMpp2iGcqv6RWyig5
         dEzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769799311; x=1770404111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABEZfxsW2syqPlu6/K4Mc72DV+nXVeyyt3BSfY8vI3Q=;
        b=QroVKV0SobjZ4s/B+ILCE0TPeNkL8N4u/RlfMtYG6/eIaJynacUGbPzM+afrGvpCt0
         U/HrYlr2Gf8cC9TpZiTldf9a3fIoUDjPcYOpPIzECz3SQJUWCJfBJsLnZy60SFOE67h5
         iftl1df5FU+Mw6+17Bing4EH3IFITJW1BianS8zKDrp5rP5yYC49M4ONKFDiUXWD5Lnq
         x/grGLVdufOJOHGCl74WGCiD6gssUgi0wbGdKb1i8H+yUck8Ge84NpeN3Eevvg+dQfX9
         yzzOP2oVg5M2PgCJim3O0VRPYcjQ3TIlsywIsw9WQBxIZOr35AFCUcMKCTN4r66tn9g0
         /xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769799311; x=1770404111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ABEZfxsW2syqPlu6/K4Mc72DV+nXVeyyt3BSfY8vI3Q=;
        b=ulQYKgjKQW9ndjozha2XlsbKagQ2Mq8TjFi0pfimqfiKFw0qBO3OCrsMkdd2rpDunQ
         spTcTqTuTjOCFEpmr4M8xWw8CD+uJYTQUGfztNWpx65cEC/jpRzz7QYT3or/6n0CuqOV
         Fxcf0h0STEVbsdnPUmE4awnDY6AmOeDc59jkleswA2AvEvjHPr+Xhh13rbBrMXSk1wU2
         /gUvVjCSREhqMyw6VMxr2quosE0wz1qTXZM7hE2x9XyQQa3tQzwo9bZEeXIdc29Ffi9B
         vP4TQwxTjoGDJ6LUVxcvr4PEOsch2K6Nz/LRb5DAWNFymB3RAvQyXk5UWqxF1PZhAPmA
         Q/tw==
X-Forwarded-Encrypted: i=1; AJvYcCUJuMFcCrRc82lFpu4L3CtDRHzB+tq7+v+cSTVFYLj8hAHjHX6M6iPHD9l/YJ7gju3jMEiTOQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQK4cMSi8SoStGB2GtcyViXbGiQac1ekgbDfKbZ8CDvVJ5Yb3
	JeFHLT0o1nvLOFq5MPsB0cRi6fdPDHA0KHLpLTWBimahSNopSBWiZbip4eoQT/23XCrL13JsAYl
	SbbguQRV8KOLH9+SctuHcG0fraObpvE4ezqvffCHj
X-Gm-Gg: AZuq6aK5gehLSmVCHW07iW+TSzeE9k4e37p+wSe+l9G3xzTSyUOEJ9pw1FEy0Sn661/
	2eUY2IVspIHF0hzmh0gc1QEUvvEd8w1SHePOVnSX4QyfDxjCGBH0u+3FmrQ8EQWVESyXx49Rai9
	9UX7rNrcXLQiRbM4Yi2z2Tey6MBjIwnXl/5nlbkVpwqjlC6wdbfHbAmvYctVghc7I3zWWFZYvms
	EgRjvAw0xv0Cd7b1LLVmKsfQJtAoNqZrfO/z/+RZbR6hwImJ7GajQJzYknqcrQmqzrIIMo=
X-Received: by 2002:a05:622a:15cb:b0:4ec:f6d5:ee46 with SMTP id
 d75a77b69052e-505d22d7693mr56735801cf.78.1769799310745; Fri, 30 Jan 2026
 10:55:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130033827.698841-1-kuba@kernel.org>
In-Reply-To: <20260130033827.698841-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jan 2026 19:54:59 +0100
X-Gm-Features: AZwV_QgbhWvtqr9ETLsH8j_z1CK4iiFOMmiskyq0Uy4hQm7Iol3qY5ksj5H6xk0
Message-ID: <CANn89i+ak=qy89AW22MzJFoTnqXSehGLy+uCgp24a=5K46mt9Q@mail.gmail.com>
Subject: Re: [PATCH net v2] net: don't touch dev->stats in BPF redirect paths
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Gal Pressman <gal@nvidia.com>, ast@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, dsahern@gmail.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255230-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,redhat.com,lunn.ch,kernel.org,iogearbox.net,nvidia.com,gmail.com,linux.dev,fomichev.me,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3AD71BE038
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 4:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Gal reports that BPF redirect increments dev->stats.tx_errors
> on failure. This is not correct, most modern drivers completely
> ignore dev->stats so these drops will be invisible to the user.
> Core code should use the dedicated core stats which are folded
> into device stats in dev_get_stats().
>
> Note that we're switching from tx_errors to tx_dropped.
> Core only has tx_dropped, hence presumably users already expect
> that counter to increment for "stack" Tx issues.

Reviewed-by: Eric Dumazet <edumazet@google.com>

