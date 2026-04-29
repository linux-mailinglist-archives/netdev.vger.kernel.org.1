Return-Path: <netdev+bounces-282195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFRgKQhm8WlfggEAu9opvQ
	(envelope-from <netdev+bounces-282195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:59:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFE348E319
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75190302243E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4D535B136;
	Wed, 29 Apr 2026 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/VoO911"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2829E24A067
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777427911; cv=pass; b=SQrjvAIWYffFBSW7h1IJTH+XLizYHtud1hO4229gpEtJ9E7nT0quyT4RX8cFK3zv6xipRImkIK1GLhZ31rGioYQOCaN7zJebOQEl0uX3PKua69QkbeZ17ME/Jru8mTNzZG9Hoa6zBwL5eLP/aR2MYjzPOjG97wkkaDy5PwjEhXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777427911; c=relaxed/simple;
	bh=CDF4+RTCOAGouBrckQ9grX8Lmt3xq8cebQxQZaXsFQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XG9nZNaVVdPlh9TCldX6dj4FU8OxoDCWoh17zqHubehfNnFYDfY2n7l46h56P31hQHWQ1YekOSwB3p+UpTY/P0i4ulqLYxJhxf36IixcocQgyLW5w+GPGPWGpnvhETk9aVCQH0K+1kfXtprgYyzLZD1+LZ8KTYRbD6/MuP+p+a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m/VoO911; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50e5c7eb565so106471691cf.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 18:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777427909; cv=none;
        d=google.com; s=arc-20240605;
        b=TK3Sl3Y8NGvKkUIAfOZ9oEtAzydOWuLm7a77+fX5Q07ix9nb8Ov5YeyA4tMp2+Dm7M
         AqVF4bXA293B2XT4JKErefVmgExmLTpuGSPfzT4t4V3AAtfyJw9zypHr/XEbtU7/0yAh
         sdYMrXg4RtY8rU3BW9dZxcxCGuiXuwQtUySxEfjpDJEpCjlwyuB5MQtF7vhgbffXk5jQ
         E+V4VmPiJ/2qvQJ5+h6bFxJFuMYFii3FKIFwbDEwZ1FBQOsPrxkx7P2KDYCUOEV8JFw2
         uR/aVasIOX9XGjENm2BLBjBv5nTwk/njYM6IdQ+sZVWmDbcXBVdc3XBybW970BLmDvof
         3kEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CDF4+RTCOAGouBrckQ9grX8Lmt3xq8cebQxQZaXsFQo=;
        fh=7hw9xYi+AZck+u7d3AnTyj7+Ey9E6vG5lm5LHq3ywp4=;
        b=AmkIGrrsvAGJTsyTaZq/M6IS8yV+2af34oRoEA/boxWY0ijeW1a4uA4QmOghgvDZ8K
         I/SIDPr96Y2DtNauNos2BZqmuAhds5tTPUzpphtNqQ/aJmWpF9uoYUZX8lY6YXwGVN6k
         FLdR3yHswaPOQdB/TOAALo8OqHqfV18p7XwbFxns0i+cx+Fg2QbfH48QJ0PX7hMTn4RT
         HfDtSNjlIo1y2TaDFWgOb052bFVUgLV66NSlpTkUmSsAnfV7ebjKL9qlRyvOTFTaz+Mm
         7lnC+PADYmjs54ckH8+Tj5ZY0FjmLuuaThv6BgKgMAy6ng83WczlCjPHtjSTzGpzrM72
         IVjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777427909; x=1778032709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDF4+RTCOAGouBrckQ9grX8Lmt3xq8cebQxQZaXsFQo=;
        b=m/VoO911B3KHSkj0aj1fkuE9LipOIlPI1MtELBAHlGNthqpDDaPdf4r8GxahoiIrL9
         iXxSHxkdzXwmvIGnIJUy2UWNTy2u8/vVlSRZDR9BD4+wzeq4ayTSzKjwhzM97NjuifN6
         ipnmH2rcJcGgCulKa9kiK8E+Krkta2u+jkBgRNjrJGD5CrUUbGohFOLtX+Fv8yxbescu
         UBGJ5+4W+8X472O28Hwi4C5wS94g+WNBFHVNLQr1kjAc5BO9/EIm1OCa+Lf5xCZEkJsG
         WH3JABI/9PGxpdjAQuOVrjNHCC0uPQiTvKkeaxURgYHudSbxRhcOA6qw3AO6TY9vtmLr
         EBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777427909; x=1778032709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CDF4+RTCOAGouBrckQ9grX8Lmt3xq8cebQxQZaXsFQo=;
        b=aqLRfAxQr5nwUQlLUzGq7qMTKK15nybXfKeXH3RvM4QhqUpStHyrK9a6Y+qdCIW43K
         XFd4JlRvDmmUzRsNOLAi/V0jrnPtD0iUszVHrcgbYnRzqNV2vxpAO3+O/UrFJvlTDFQS
         8JDmZdPNCzAtPdPuvlb5S6t1u1Mmd8gfBU2PWMlKtoZMxkzDjqtnEtFbQs8glLNhLT8S
         +EPtKWteI0uRoOlSjxYd4tMo62DuaLuWuk/iQIyopm9z7vA7yPjbxYxzlPODJjop9vnZ
         71NY0KZKHGNdY+LWhWVJocJM3AZoq/+xD8Jnw1DI2wHe6f8W1fqOvdSH+9TMCSjz3Skq
         vQjw==
X-Forwarded-Encrypted: i=1; AFNElJ8XBtaCQ0/qm/C9twtAwaZmwx1TrE0ZbQ9VPmd4u3GG67+j2LOE5AdS2FtOrVIoLObTQ+8jAng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkBC+lC5pvCqc7vsRNB/VIXttSGyxgw9RY8iar0HbtQw9iJE2A
	8+lbf+1lHH7i0wxrRaXNXs394SUAfZYTXq4TFs/u3CBfUaeksPV1BJ6goYqtTXLdbwDko0Xo9BN
	hBOZaPAqX+CIduYoFwa7lnX8zkRjT2wwVWHrPZPw4
X-Gm-Gg: AeBDievvVmPlNcO8/ofKRApvmyu+2bvkUVbD46P6BnCU/IUYRr2EfCuOGhFBvlL7pOY
	HG+jblLxI0z1cv5vJSs50E4ky37RntS3gNHcn5POOsyonQGJLMo7Zhhj1dJiQJV4Xeu94UvlLRD
	IgieGqp7JuhhoONgQTu/V4w4FTtAUkHIa9dQ7oaGMZethd6B8N3tXclZtArBRYbZOXXgWRH0HIV
	JAmxTlbsmg0msD3d6C7Yr6lVehpPW2c5xb3+eNNt5mV+HI7Bb4Qo7RMG0Otv2Fr5KcLwacqJT1r
	HV63QS63sGubRU3ZPPk4s5meafcjf+lY/kWnvJuUi+1em1Qwf/J7PmXvQqQ9fmvzoHehCB8uc7Y
	PlyPddjYQBg==
X-Received: by 2002:a05:622a:5c95:b0:50d:db76:55cd with SMTP id
 d75a77b69052e-5100e1eadf1mr79444781cf.52.1777427908497; Tue, 28 Apr 2026
 18:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429014913.1043836-1-edumazet@google.com>
In-Reply-To: <20260429014913.1043836-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 18:58:17 -0700
X-Gm-Features: AVHnY4KI-PjVKn3QtB3Cd_LiHxZ5t8jlwPxpTel98pQWUjIawOHeKaZ15291WxI
Message-ID: <CANn89i+zJ_pWXoz8bTgaEcB86gh-ocg8kKjz5jWFi9iKd99ftg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add sk->sk_synq_overflow_ts
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CAFE348E319
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282195-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 6:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_synq_overflow() and tcp_synq_no_recent_overflow() are currently
> using tp->rx_opt.ts_recent_stamp to store a 32bit jiffie value.
>
> Use instead full "unsigned long" storage, as an union with sk->sk_stamp
> which is not used by a TCP listener.
>
> As a bonus, we can remove time_between32() from include/linux/time.h.

Please disregard this, I sent a wrong version of this patch.

pw-bot: cr

