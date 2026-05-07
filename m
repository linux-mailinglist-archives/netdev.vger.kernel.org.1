Return-Path: <netdev+bounces-285454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAkiAkXR/GlhTwAAu9opvQ
	(envelope-from <netdev+bounces-285454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:52:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1904ED146
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ED163020015
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA91845BD7A;
	Thu,  7 May 2026 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CT6eV0Uk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336474611E1
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176036; cv=pass; b=SwkeIUBSsfc6Wx54OFC0UMhwzyu5TkW4d1Ri6hWjN9iZ+/W5qq4cDwsNUV+kJiAVARDuwrWTZ9KSX0OE9MyYzBlZYK28e/XxNWpM51gF0EER6N5fTVfmLmnhgZbbHQQXxayuoiT4GfVk3PA7fivGw9mDsuVmi3HYMrlGats8ybo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176036; c=relaxed/simple;
	bh=3Zn30fkFKlJSdP2LvpHGyWzzLtY8CCnDkyZEefTVO8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyANcquguVIHYmjiSH64OQS4gB94SjxCTQVYEJFGhWXCc904BV3tFjVpmmP3TS1m1tyDqVpohYcMDyyRfvVCqeJcG9W0iG5W6kijoQIlyMQGdZCcDIN/341akY6cYHYKSQ3slFuNQ4flIds0FXHorX6kyDuAELf4ze79/E8mb7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CT6eV0Uk; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb40149037so105183185a.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 10:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778176031; cv=none;
        d=google.com; s=arc-20240605;
        b=DVOb10QFhVqsW0le/GAFQ1MyhyX6X9t6dIo2+W7Jp4zsG6xgL7YtLAUn1xoG1q/pmd
         ZGSWuko87AoO0wDJwcJXcClYu0Q2/7O+npEYicQhufliQOg3ZGLtH6krr/MRMoyE33aa
         vaZ5AFWz6eAXmmPnj9s5IySnQX+MXfx5Wq8TW2Wnw2f6166pbCr7a9Ug7wSblXddtq3d
         /5oJIkrFdKpJswdlWMWv8dsx5VJ4fowOgvKCt1182RLL1wgf0eN0ErvmC6yrsVqSgtOE
         04MSKihEpa8pOgAxYQOk5gnlYgyfmr0u602B9UDjE0pSqBUR/OhBfjy+1HL0Y6js5Q+u
         22YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Zn30fkFKlJSdP2LvpHGyWzzLtY8CCnDkyZEefTVO8c=;
        fh=A/8zJ2w1upap/OR0Q7dHKRTHOV4kvEvzDr7dXBgIrcA=;
        b=ScJiyHSFqccR26BeD/cMzUzLRxECAMRRr23vVDdkol0PcJrjw8Xr9/znVuaAqP8IRe
         NKP9yopuTbctWFkVyDR1YcRwwY+/wC2ucVBoIfpw2actebgVntuSXWVLAEcErzbT9QeT
         1ezP5WtoiCks54lerMmmbtThmf50Sx4ZF/weaj4p2tjrhrNlH8oxV7Bv/J5Pv4xIVAKV
         dGQySRIk7lGPzW/IecNSzt0stwEGgL/J3zSaHwKtN94jgBL+CSnB3KRWQ7iaB9X/cZgA
         z3Xe/esSuoTcsI0QGaLS+FlP7InzymMh17fpg56/8CyEA/tthAkmeFsUSYGgHTh3ikdv
         xyFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778176031; x=1778780831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Zn30fkFKlJSdP2LvpHGyWzzLtY8CCnDkyZEefTVO8c=;
        b=CT6eV0UkWkYNuo0AI1NbHF8bvSYvplbg/7hjC7cmDt1MWnuIZONXeTBkbK/2ssnaDu
         a0VHMEzT6r2rX8NQRvAW/I8d1Daw85PYUN9r5noNv90rfGszDt66LfeC9xMrnaoRJzdR
         eiH/QoCKArjcTiGsbY897Kel8xn3oFWZQ1ndJeHDEuIhxnH4tJ7rimIMtRprj0NRbeOv
         Z5aNNYT6XyY6d0DgATen5uX90fIStivCfn+tnMgl6Nr6pP3nzN2we/e86IyDjpdVakTV
         VsiVzxfLcyW8nCqo1Ql3BmqZpk0cOEv704Ucw1MeZsZGtuWXTd49ZG4w1yHzKAlyzplB
         mlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778176031; x=1778780831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Zn30fkFKlJSdP2LvpHGyWzzLtY8CCnDkyZEefTVO8c=;
        b=R0IYE5IRtkyM1PNUbtEndsOLxSulEudPhdSLk7YNEGGkB/C8ivDIZFXXq4CD2V8Q0Z
         XJFf6F3KSRYOUAT4yJv1+P8F56ewGjQyFbkFIUqQc0cng9SB89cCj/zEXBzD6WwujtIu
         ToUlCqvFPXm31tafjPE19wmU7HTdlQ4n8iYEDwGxVr8wokCYlIJoNTEcGaZy1OQztsqS
         g4wplY3ZzhXGgesuJOyUWDdYyMDct1jMhsm6bdf53WrKhSivdpM0z86z9Bnrg/5Vf9oP
         4vxc6aoaHHzjko1364Jg/EXFeoZINH3xorrq3jKgAJIRAh8wIqQzwr9nvJGNL9yvExdK
         LirA==
X-Forwarded-Encrypted: i=1; AFNElJ+qUxrzSJ4CU4MwuTPi/yLXng1YhOtxtU8DBYi7i0r32cddapKqDwbylPOLsIYtthwFtDkOZVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycOf/ISg8OVcC+0CtE571S4GL3KxVYlePZ8VMRP3hq2omhgdxK
	ZDzEt2Nv/FM4ngInZ+YkGlhpSEjAw/3N0ii4NQIsC43Fd6bw5b/xA8qAhROwtOF42okdpYgUUm2
	zijYFo0/+bChOTQWUztGhhzYm9zF7fhkOsfzavG1P
X-Gm-Gg: AeBDiesZEN16zHzBaUuss2ip6iemQJKQzurgqgDHuGoC2XtO0WQjmDa2iUGIc3jCI4m
	ErqzRwQf24ohSawjrS2dV8LMbeuZaa/TMGxUhAMOhnFSOREZb53vv8hJHYOhP9yERO/MUzWbWal
	Q0z1oNBibtoXoBy5sRh3rjzDYbVSb8WCcre1ZniObXPK45nbQdJweDMmdvQRIpB4YrAsZSPSpp7
	pxMT0BRTismR4qClhZPG7J0VAFseWaJQW41F+jVSgSjrna8q2/TCaYA0PnOIDt8AmI8/MMGVO0U
	EQbxujBMVyFASM+tGJiPOQSWT7qwktxqIkIk73ndoZM51fKwlK2wWzeVZVvnxOwhSz/9yPe2I3N
	0BvNtxcZVKuBMwhjmApvufIxNJb9BXLM=
X-Received: by 2002:ac8:7f85:0:b0:509:127d:ee06 with SMTP id
 d75a77b69052e-514621efd89mr121415031cf.58.1778176030762; Thu, 07 May 2026
 10:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507174547.4125412-1-edumazet@google.com>
In-Reply-To: <20260507174547.4125412-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 May 2026 10:46:59 -0700
X-Gm-Features: AVHnY4IjxS8iMOOA69UbCBHRqo6SjCvjxaPYPK90TV3gaaG-LM2ITBP8exr7ngg
Message-ID: <CANn89iLJBtqdzzo-Ei3kvWcZ=kB-t=Fy=5hDTOKu73foJUk_5A@mail.gmail.com>
Subject: Re: [PATCH net] rtnetlink: add RTEXT_FILTER_TERSE_DUMP support
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6D1904ED146
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-285454-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 10:45=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> iproute2 can spend considerable amount of time in ll_init_map()
> or ll_link_get() to dump verbose netdev attributes, contributing
> to RTNL pressure.
>
> Add RTEXT_FILTER_TERSE_DUMP new flag so that rtnl_fill_ifinfo()
> limits its output to:
>
> - struct nlmsghdr
> - IFLA_IFNAME
> - IFLA_PROP_LIST
>
> We can later avoid using RTNL when RTEXT_FILTER_TERSE_DUMP
> is requested, as none of these attributes need RTNL.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Wrong patch title, this targets net-next tree (obviously).

Thanks.

