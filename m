Return-Path: <netdev+bounces-265317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG2LB0SjrWle5QEAu9opvQ
	(envelope-from <netdev+bounces-265317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 17:26:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD8F231122
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 17:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0197F3004CA2
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 16:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF99C318ED7;
	Sun,  8 Mar 2026 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7xCEGu+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E8130E82E
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772987197; cv=pass; b=EK+by5H/9myBD3PBGhVujbyZpI1S/1pbtLnS0pmeUBJQ9SCWJIw44YfnP6HQiTbAsU4IKzweXko4nQhXH8gB9KIScDe3/AKI3/4oiY6uf1JdKEiRDED+AiEoj1aNb3TXPHWZ99of2fMHFY7bJ8HXV7cUpWWEPr2ZwY3uEuSQBTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772987197; c=relaxed/simple;
	bh=Hc2GQSymig1T5faKF35G09Oc8rwLv5ak3bHOB09LknI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZMw9r2+brkruN94q3Ati2WUr9+NZhTMv97IKvW27jowEI2Jwf2dyN4SZNf26/Q6pgij7y6SnvSckwyIXkIvwF4bd/uab/s0wBkRuHPziNbJfJP3I8dib5NQ750pT+OAocfnt5bjqrw4RjvrefreGVjKvVZWkdAPkn+SsNRKpo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7xCEGu+; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50906a98ffeso471161cf.0
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 09:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772987195; cv=none;
        d=google.com; s=arc-20240605;
        b=L7oN7FQAhCkKvJOyaR7TGbKNWBI4LC80B2uTD8XQfyEOuChITsEzripweXs1JeWjZC
         h4nSI+o8YnU5obYqXBi61hJ4NfPRHxZon1A139eycNyKzF9OkUv5YQHKvIMp6XAbqd9y
         YcDv6TuNx+Qtiu+JY7EHJdvnF0ovbRZOSPV6jDhYNA2r1YjQzsttJV1KQsxL9jNlnapT
         6Jq5goRaWmNIHyDSfRI2oqOJDcIeEIUzdhtD6w2TmdFD3yoqVdTaLHaqcqsLZitE02aW
         7yor/aguAR23hT900fBqBKnVxPU6vI/7ZkpMjgeMJuNYBrRzKLqip4db0k8KEtpuNBqB
         D+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hc2GQSymig1T5faKF35G09Oc8rwLv5ak3bHOB09LknI=;
        fh=a/VyOLM6lFjOSn0Jc4830RFZCrzOx/qwldE+1L1J/RQ=;
        b=gzVTdNXziI2qk4Q7edZ0zdN/JenBXNIN38JQisHAczG4X12zpuu9GqLASTWnVoWmb7
         p0anjbbx9QEWd0+xVLRtoFd9hPYo4WEFvKvfg6xPGWVrlGep09hbkI/9TpIqHMi7/6EE
         lCkeYX4fZyYg3OWYOHQrjecfmQA+KFq+Gxyj0wyanivn8IyyzMVV1PhhtCaYU6Fq8IeB
         E+1z0vUHBw18Ueed+ZyAe7sSTK2WvJ6cFdx0jOiVV6zxPUQQBl98Tnl5RyV3depd8YVh
         DBU3zr/BxNWKeFmwoRNuTS16hk8F1soc3DFMZzTNYAFlUeJUzi6s4pXKLcQ3fDTdqgYQ
         Hh+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772987195; x=1773591995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hc2GQSymig1T5faKF35G09Oc8rwLv5ak3bHOB09LknI=;
        b=n7xCEGu+yC39q3D5ARzgnLqK094ltxK+3n01Ty3WE9HJHvYPNLaC4R5LW7Gqgm2JyQ
         DRnkVzejfwEEOhcnpdgIfhBDEd055gpZaG+yktcqMzR9no9p1v+WuGrOmhRGMn1Z+mqv
         0vbnV/l0i5CQQhxcFXPr3Y878LtLyu84gsnuGd9ErI6zU9ePhDGUr0lZZYFPpO05DkZS
         CL+T3BS5cX0BpRZDl9PQdAf6cTkrQVneXv7f6pNRojmw6h4l66kTvA7pnDcMkxvh7fJD
         CtYllMp6kDlxQ2uycM4snOdKsJEHq7ES1ofvRdDRvusCu/wwHc1yEEozn4Da6hTkHFKT
         8KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772987195; x=1773591995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hc2GQSymig1T5faKF35G09Oc8rwLv5ak3bHOB09LknI=;
        b=FZbe2w3dBC/9xdhdrXs8c7e6K1oJPo6YKWWlviCLEx4iuFcfW8KICaMfvFDeTpe/xP
         NdYts2Yrh9UQYYu2z+CGbpPfaDHmsBp0W7kMgTJc0zIu7tAfpz9XO5driBk+FqPUAaD2
         iPQPtV/DbZj3o0JTO9Je7o2dVT9xibGatUlZGXIsuQ4u5611+NINgQv8ta5t5oMSpaN2
         RwndINCIPoBrld31OMpIr35tSd9Sr+2yrc48YOkbbhk2UR7z8eKwMz53mgKtOPAhA2o7
         ekH2AwzzQewUEvBLpS+mzoim5B7F2G86qLKn1AZs+PCsgRHI+yCNXuMf08LfueSBzaJP
         4THg==
X-Forwarded-Encrypted: i=1; AJvYcCXU1SQuhUurkl/d4utBBooDgJqsp/0nfbqouGkJNP7h8HkuJVerrXpndMytcyb0hhmC6iKNPaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5UGDGEnZ3cuoM+T5T1TiLWs3OQDB40UpC4FCXI+m7KSdQ6F1O
	pltAZPjv9RP3Bm/ZVVEXtqZejeIHwZ6DNwofjh1fMm/gg7QJouLl6Yl8FXtklXCWEfFcYT8FzyH
	qV3jSIrZjrTDoOLHN2A414hQnDgsGD4w6sBWy56x6
X-Gm-Gg: ATEYQzxxqmOzUN7kwBGb3sXNkdbbwMD7bGu25hBe4x3V37pPalpaPRKZV/4N19WcZVr
	RGKmjElaTkNhtERTRZqiKcQylvHXxK1FIPbxquv0kHZCNjLWqFYftkHeW4D/jKBCFgl4UFXX++d
	2sd8aOX7Nea6HG+87gTJA4S4S5a/AO2SNoMja4VCzmq/FGb0d7gKu6ea+Os1bFkZtCb5ihT+lz2
	f2CCpH5VR+sqHx6IrQUo27LagzkKDK2fRDvwI+U5tMHM7lp6dIwA+6+UqSuZuc04II+UNagUbzk
	1FJe8ULM7sXYQkOq5aamfDZ7ebOAqn6nKeKNMe+QPknIZI0qNEiWDDDbVjr7kacU8J1rXas=
X-Received: by 2002:a05:622a:e:b0:503:2e98:7842 with SMTP id
 d75a77b69052e-50900e6ad39mr16057151cf.4.1772987195108; Sun, 08 Mar 2026
 09:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308122302.2895067-1-edumazet@google.com>
In-Reply-To: <20260308122302.2895067-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 8 Mar 2026 12:26:18 -0400
X-Gm-Features: AaiRm513EnIHNRBAtQqrzdxWNcJ5DIhzJnZuTkUjVtAW_zQN02wC_nXGWjUGBxs
Message-ID: <CADVnQykvqgvfdw4fzr5DTtPMuUKDPao6Hi3ZKj+AXKwTZPQXFA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move tp->chrono_type next tp->chrono_stat[]
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1AD8F231122
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-265317-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

n Sun, Mar 8, 2026 at 8:23=E2=80=AFAM Eric Dumazet <edumazet@google.com> wr=
ote:
>
> chrono_type is currently in tcp_sock_read_txrx group, which
> is supposed to hold read-mostly fields.
>
> But chrono_type is mostly written in tx path, it should
> be moved to tcp_sock_write_tx group, close to other
> chrono fields (chrono_stat[], chrono_start).
>
> Note this adds holes, but data locality is far more important.
>
> Use a full u8 for the time being, compiler can generate
> more efficient code.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

