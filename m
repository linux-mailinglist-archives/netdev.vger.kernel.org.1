Return-Path: <netdev+bounces-260093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF5OFzJ4nGlfIAQAu9opvQ
	(envelope-from <netdev+bounces-260093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:54:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1CB179240
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71C1130E120E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8003E2FFF8F;
	Mon, 23 Feb 2026 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cWp4iQCG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366332F6188
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861698; cv=pass; b=r6vo8PYNCFgArpvsF0dFPparTC720sqa2KlXyNwRdfjB6m9uZgSHS94Pyj2Nshzdc6M3xzsMuOrvuUQTVGw7eK56utaur2gvrFDLBrmTqhZJhTqrE+iQ6XJDYvLQNWK8wMmVeIB5qC0wPHEf1pveBHuXBBcU42ubml0qIIzOWhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861698; c=relaxed/simple;
	bh=jDoixF8LzbCdqWJH8Jw/EgatJCh9hkQnNW+1N2mTfZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUiVFGRi9Qzj+iSonF/W3jaEO16sy399mh90/REbbF+YzUkJIPG48w8N89JqrUS3NDA85F9yrBlH3F76UBqwFh6ZMORafit5Uknt3Jta2c8u6efRhoEMbGZBdorWbzsTiNVI+NybKWPam7r8e5qcIbuZ3dSoMaERRPcDmhAUZA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cWp4iQCG; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-505d3baf1a7so942411cf.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 07:48:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771861696; cv=none;
        d=google.com; s=arc-20240605;
        b=AYJnfUEo05hJWelZ1+YZ2j9gxzcJwct7NZJqbqGd/rYNLHfJlPKUHkT+v9+oDIanWV
         VeC+1im+unk61QRF2RDSznbZFFWbjeooJIkKZqf6c1G37mbtEWgKLF2heAuoPbvTKjNp
         gPLvMVKd3PKOecKijIkAA/KJGc5Z76unKhJjq2C4jnuHvN+KEeAycSY05w7KMDaioTC9
         3LLxbjZ0lOiQqQavQ3+/OMVlyJNBjVPCCwD/4PpD8b42UQjnaW8Unhw0LDVKBGzb7gb7
         bR9ABxzdDtcrj95bnD+0CAJO+/UXrX3dhFQB3eeqZW1vIERxoZJA0q5dRLW0GNsaLkkA
         aAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jDoixF8LzbCdqWJH8Jw/EgatJCh9hkQnNW+1N2mTfZQ=;
        fh=fSwQ2cIYOt8Ow34vYwiTqnFwi1RKdhufqaRU5EAdw/8=;
        b=GJWg3LhrBLBIOLtC/1r/Nn07hL5qNiILeLTYhNoBVTkP6nvii5Q6nrO5ti8gFkjPqt
         nQdBg0qpJsO1BKvaDlVhFPRI7vEvUI0cKmuStfTDN2IX1ole70WhGdqp/oyIxKe3LrZT
         E5xikXB6xSFSDzBpRuaES74x7gIL8D7YN1ccMmgYxptHXzKcl2LjCzevGI1SK2JH93x6
         psDeUWMocWag23kdpRVB4B6ghA9TKTEueBm/UFSPar/d6xUE7kecKsvOrHXSKwYgqdd7
         cJhB7XT2HsKPGTCMVVCPDBKnnj8JQKGQZwR3/kRGJBvb4OHZbD7DzOjnbZYb6Qoxf82m
         RXhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771861696; x=1772466496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDoixF8LzbCdqWJH8Jw/EgatJCh9hkQnNW+1N2mTfZQ=;
        b=cWp4iQCGKy2cMbiLBwA5B/zJJ4IyF2E918wqLv76JrCZOpkyr6QnTIX5RVESKyJ4Uv
         HqhLhBVwBA4h2VEaXWPMao4f/l1BhdR8d1HSTtOsjnLuyl9avnKhgvL5Z3Dvu3Q8tImc
         wckVjAhxGvMH4QOTI58zxxfobVvTqpsZRkTx7GfYYzu/2LsrpXZ5k28XG3RJGWs50l32
         uLiMdiGjQuiaKC4zIJgdVQc8a5nID23KyIn8bftj7UMiS6M4xLl9i2mgLZMKb+BPn7Ce
         aGAOvkC3BObx9FqLmkI722HzSdvPH/yfvQbis3GCsbbagY2U1SeXrLqozoZv0gAFi7ef
         UgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861696; x=1772466496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDoixF8LzbCdqWJH8Jw/EgatJCh9hkQnNW+1N2mTfZQ=;
        b=Q8c0xu4MRpH0x6avogjUzXGDyG6UJ1REY5NkMMfdTN8OT84gsaazOeyvnyT3Jrs9B3
         FPO4CP0G6ukwedzYePasMJpGu766H9yvPDWmjefKTp0BCr0GcNSU1qpS2W/uZZUS8vvM
         x7WJjtkF8uphuBhJyuziu+e7Rt9SHxf0vQtnuQIED4GnCe8ihcEksj3THjuj4HiWi+XN
         etjlqmXiB0o4M+XXDLYmFEnJjMrqd8oG3gZneh4F0SqUt0eOaqlWHHMg36YeHLbPgTE6
         uPjVHGwjDmtCCvjb3+n5cb/1+uKOw3pRMM9lEW74GWutMZ9cXp8QcJooEgRwr73lnS+V
         2F0g==
X-Forwarded-Encrypted: i=1; AJvYcCWdAoqt3Qhn2r60n1xZTrur8TfpR72zZ42zUiAtndGbw6ti0eYGpKnKRCGkYC0yzsekUOXxi6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJlNfxwb5BAF9DEnBlNOap+xwYGmcBVlpe1rSC34t+21zYWwc7
	KJhXKaYUy28D58vX3cBnMLJInN+ckxP8iHqVqlqVpUYNi3Bf3/UszpOt1A7uH8LXnm1i3/oVrPR
	/v6jpPVnbuZX7cwDY5cbd33bHFDaZY85e6DrWk3apUKpKEZg4zfAfq+8T8UA=
X-Gm-Gg: AZuq6aJHQnHoLDOJWEg9GHCHAOCmkEKcY5diwaVj7z1hjKpk0VDupt0NFCbJIZK9mkS
	U4F1zJZly4sqFaZeMqp7UGo5H9DbR0psWBOOo7OTQ7jG4DCZUU7wmfx4nHrvXYX+PAHuTdrIrjz
	SdpWpho9rkxM6kkcaQIxrTZZGfBohXZLLKr3KBzQytWgnlmmKNvHigx9gXWOvRn3Eo5CiSDZeT1
	aazaGL5B9ADcviFU9f/2fcJBZAqcxmS28MKn2+/8GwPVRe/DC6S+Q4Gy5LK69hl4ox8yLZ9g7CC
	pjKVJRaghIwzxUejVbHBk7yXpP/xBZz8TId72Q==
X-Received: by 2002:a05:622a:1a85:b0:502:f1e0:dd3b with SMTP id
 d75a77b69052e-5070e891c19mr21639321cf.7.1771861695625; Mon, 23 Feb 2026
 07:48:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223113501.4070245-1-edumazet@google.com>
In-Reply-To: <20260223113501.4070245-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 23 Feb 2026 07:47:58 -0800
X-Gm-Features: AaiRm52_TDxV_gbLr122oEiFCJzv-1v66O3LUhHo5K7KFudTcDtx2L3cd46HufA
Message-ID: <CADVnQymnJ6B3SUh2STV6z0q8EEaDp7Ct2ZM6usXv0PjeaWAfLQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: reduce calls to tcp_schedule_loss_probe()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-260093-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EE1CB179240
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 3:35=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> For RPC workloads, we alternate tcp_schedule_loss_probe() calls from
> output path and from input path, with tp->packets_out value
> oscillating between !zero and zero, leading to poor branch prediction.
>
> Move tp->packets_out check from tcp_schedule_loss_probe() to
> tcp_set_xmit_timer().
>
> We avoid one call to tcp_schedule_loss_probe() from tcp_ack()
> path for typical RPC workloads, while improving branch prediction.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

