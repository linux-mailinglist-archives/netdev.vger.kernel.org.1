Return-Path: <netdev+bounces-247623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6536ECFC6BA
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C071300D313
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 07:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B2E29BDA0;
	Wed,  7 Jan 2026 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJv1TC3U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C029ACDB
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771731; cv=none; b=RRaGs/nHxA/wRNbPO+BD3mTIhFfIfFPGXMpuTFKg09igg8xyid9HE5E8pLcxL31i6faWmnO/bZvHgZ+3R/6gzP8Cbb9p/7CnY568Hr8x7cU0Ow8gCxUSfYBGWjyhf58iQ3uPJUkJwAVEsZM7oRqyv2llg+JwKBZVAkGwjBL0bjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771731; c=relaxed/simple;
	bh=9QJNm5DRwKf59jnnJG5BlivpbtpgPTlbJeGEV0wdNpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7T8lUX4NgQ4zatgzt/C9wpJ6eyePEUoDJ1uoRbibO85jNymbqOxdeBhWDxHo0GkYggbvt6JbQAbWwnKJcgnm7asXIBrMHrRJuyoC8N96H5kNS9yw3RCztjljdbHnIGKc3eunhY9LxMI+CpVn9ZvJ2rT8F3ntfkkznk4yFwUbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJv1TC3U; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-121b14d0089so1268093c88.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 23:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767771729; x=1768376529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QJNm5DRwKf59jnnJG5BlivpbtpgPTlbJeGEV0wdNpo=;
        b=AJv1TC3UTsvKPwDwGGATFzCt9cfHdm2HzU78kn33DvQKcggtqolKHSd9VFZ77bOibg
         7A0vdzi4NZwTLL10gL24GCOGnxD4S3Vyos6tdTs+cBfx8Y5fSrkCwz4KkBODUt4N70DI
         I/o8dY6q16ALFfQwlq9rR+J4KCfQCigaLGbbsJnLTajWfPoP6Af0B0mcuw49tiLrhkOG
         6N3CXk90lQHPMyC0tSvfO0dHRszeagLr1S9NE+i/fXWi/Obg0p/MsFFQfk9TycLCzBKu
         EEWG5MUpXpw7QOXWSuHoh+hNvVyjgqo6RN9fQrGNJr0Fw05i3eYCy+TBZqRSVkFcdYfg
         tJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767771729; x=1768376529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9QJNm5DRwKf59jnnJG5BlivpbtpgPTlbJeGEV0wdNpo=;
        b=PaYx61pBMRgIKCSqdZCRmMJkeP6W8Yub1BWjcbfy5iDX2+ms12PEjZXuvbMA/kHY51
         ryazlszvnrpZNLWcrdP1F5OHzXjS0ZUII8KsZ8BniR+WljhoZIC5qQF6DvH6aJ5+SgcZ
         iEVjDQp+2YBfOlpkNM/XiLaTPUNLH6bVqWmyxxvcMl8HHwqpbmKHbveI6HxNK61ABgXA
         c3o0rILFk0/Lk7LjthpcqMqpUL1MzoFFHoduTjWFvHFkm0z5GoqhewqG/17dRDfmUlAO
         UBtatNdnL9I1oAajJQ6L0wH6e4nmm7lu2jDSsDlqsjq+LCrHXDy2JOOUv9v9BCGt7fqi
         dD8w==
X-Gm-Message-State: AOJu0YwT+VQfzEIr1mjzpRE8qZddzb7BB6fc5t8IfXF+bV2ovDZ5yHoz
	aeANdtQyeVdIouxIZpaEHRfNslsZAFrzv9WA1KYfAhDMihwx4Bn2oQaniMrKg/GzxtPvtRQbVP1
	Tzs/sZx9YDzguX6cLuwiQTEYxcNxIuNwiBSZfIJYZ
X-Gm-Gg: AY/fxX6u/zVllyHnunHkitb+UsCtuoQZwPFpjcy6tPFKwpkUaLFM/xFoLgJktj9Atye
	P1Wo9FLdLFsvZ2Ic4wV8M7hQqM+Bg4a7N34C9oSOQBVf60BuP168PGXBo6RUNCHle9pIXS+41BV
	/BZtsg/d43J16KjTINLcek/mkMUsrhlrkXv8lPNokpCjGFCRT9Yz+UZT+jLujr7iu/Ar2I0olLC
	SEHZvesSb2Mmt+rCtvkZb6U+J43gVs3u2F39/gVfTeuOJ5HIW6rxqoppkpWrDZkyDdH5olPR+Wc
	vLmaE1dhiqWFipYOJ8UBkfAWbUoJXek76y7BJw==
X-Google-Smtp-Source: AGHT+IHMXLR1dSJfxcyCPbSrXs5AyyqzXdXaJh6E7kme9E9G8J/I/dysqiX5PT3nhKf5G1WZ9ncIEdRFyf1wJQpkyEQ=
X-Received: by 2002:a05:7022:60a9:b0:11d:f440:b695 with SMTP id
 a92af1059eb24-121f8b0dd2dmr1257647c88.16.1767771728310; Tue, 06 Jan 2026
 23:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 6 Jan 2026 23:41:57 -0800
X-Gm-Features: AQt7F2pi6DhNd2tylE6EKsDQMV7gSCWCOw0f6mbD4f7hrHwByqv-R09v8JtQlFI
Message-ID: <CAAVpQUBRymieDppfa=QsS2Q9u9mkYoq+Rb-iCtKC7t=2bRrpbw@mail.gmail.com>
Subject: Re: [PATCH net] net: do not write to msg_get_inq in callee
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, axboe@kernel.dk, 
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 7:06=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> NULL pointer dereference fix.
>
> msg_get_inq is an input field from caller to callee. Don't set it in
> the callee, as the caller may not clear it on struct reuse.
>
> This is a kernel-internal variant of msghdr only, and the only user
> does reinitialize the field. So this is not critical for that reason.
> But it is more robust to avoid the write, and slightly simpler code.
> And it fixes a bug, see below.
>
> Callers set msg_get_inq to request the input queue length to be
> returned in msg_inq. This is equivalent to but independent from the
> SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq).
> To reduce branching in the hot path the second also sets the msg_inq.
> That is WAI.
>
> This is a fix to commit 4d1442979e4a ("af_unix: don't post cmsg for
> SO_INQ unless explicitly asked for"), which fixed the inverse.
>
> Also avoid NULL pointer dereference in unix_stream_read_generic if
> state->msg is NULL and msg->msg_get_inq is written. A NULL state->msg
> can happen when splicing as of commit 2b514574f7e8 ("net: af_unix:
> implement splice for stream af_unix sockets").
>
> Also collapse two branches using a bitwise or.
>
> Cc: stable@vger.kernel.org
> Fixes: 4d1442979e4a ("af_unix: don't post cmsg for SO_INQ unless explicit=
ly asked for")
> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.24d8030f7a3de@=
gmail.com/
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

