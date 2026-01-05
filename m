Return-Path: <netdev+bounces-247144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF8DCF4F87
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50EBA300DD81
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69E0337B8C;
	Mon,  5 Jan 2026 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQofoQ/9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159B132C943
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633724; cv=none; b=Qrhw2Xj08Dbg4epcttykuuICmKCBV1SfHiinDQsdaaHMBek8uNI31aN/BtAiMxUfI0p7SJhYkF6HTFVx4BiaQO11/EXv8YlV5WKXNMsDv9aRA311E8eXziPN2ar+ARLCadzr6h1oaBAVfuQXIbcSuXaumnNghpZOR0AJxv4pEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633724; c=relaxed/simple;
	bh=jpAj3DWhFAx2eK0iRqED6Htof1GSoEpawjbz2OaKA7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSeAgqLMbi8M7P49nvLnm2ai7ySjlfMtHg0jSxKWqnsVRbKNA3Ufud2O7PUFb1YCrhhemBNrJtBOqc8m76tTMhphRKClPjWQj68BEuWvclZrtahi6zVbJCxCEuzUg72HojEhvuIVyBjkcfCpbYWugM3o/3Fg7jdL1YM+PoxtGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZQofoQ/9; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ee1fca7a16so975911cf.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 09:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767633720; x=1768238520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9n7kq7yJ+X4StCqlThGUTc1cNfWeaJKbXKCromtapQ=;
        b=ZQofoQ/93M7Y4UlRn728gTicKHpp011PqW+HZ1QLJmKfAVD3paeR+yByh57nlgQma7
         2LKz8hql1zlI3QHwJqi+tK0CRGY/KWAkg/B1NdN1PIEYKGfiAyO5SulnnYdSVpTv7fgY
         nfP3y1nsGkUey9SQlgZJdY+D+xiENq+Tuc1cgRbYlsWbnAAN46/vAJc5svXxBfTdflM1
         CyDl3VZ/6DdMzObVscNk+5MuzLArTpLHPTf/YqZ1nKDrxwMcZENKEHgizb0SmG+suVSk
         de3Z85Vb6rEQaa1vGboY3DeDzpXNz94zqvo+fZDIrmUdfMlEfKzZnevT3RInpaOgsaAr
         aJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767633720; x=1768238520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r9n7kq7yJ+X4StCqlThGUTc1cNfWeaJKbXKCromtapQ=;
        b=Mgk5Rqh0jqut5ZTxhq4QUbd6nEBCqTiGoN0HCSeC1v4MgiWgOud8ml2BUIRBI6lkvG
         DC9jw5eiHWrXIFEQwtvuE43mWZnbs3s52sBrMDn19Nll/zQRWUNacbnr53caz5QahkZI
         v43DHyhITrtysWBnY2tRixJn11ZotvthsxsyDGTNu+YACzAxFC/jHYrbBy4KuukyknFh
         VVsQVxJ1hOXuVwjFTGMA7A5z19basgsfN0N+RThUwiAk/ubDx1MLHsQFQRrr2bbycTbk
         KyU91oQpzg3J1wmvMjxZVpsIQCKU5hNUC10jCEXhZJ57uXcGcOFFUv+h0nkQsQZ8Akm/
         +vSg==
X-Gm-Message-State: AOJu0Yy5l2ZXVtyRs4SX6WIxVhW8A935DaWaaRt2i5YX6j0LMNqRAnib
	9dXNcZypo2vPzsXTYqa+XRfux8QeXO4WODs/4YJmocU/6J6gyVulEqMwsulPqk0K2HlWgD+sJka
	ePG48vs2LL/t7/SpmWqItq1vIRjzd0LMvlRtSVEif
X-Gm-Gg: AY/fxX6IV2UVqwry69sIWI3M26qiizE5xL2rZC3PnXxfzFhEbNsMHkr5nNi9+1ichPz
	O4eCscCAtzA5+sGibeO4qL0QWxtXbazlqs7DLF1KJmTiWVkn/vZkJfpNJGrU7rR9iuqczT0l0+q
	qOK43Uc0HG9VirNoSPUmKxuuzrkDIGQrH+V2MkrD3nWAXLYDzxAn0Zaatk4z/b0T3+xMRr0tJkN
	oQkPloCy3vX4jFXuJ31GncdtIKF51/k5JziGg0icVMFJXMFTByLirWDr90FY4odUZ678X08
X-Google-Smtp-Source: AGHT+IHhFuRtc9OjJnmE3vtWZJxuVm0VzjkCr4QvpZEr4xmBGUGVpK2wERXnb3GdKq8KZoV/JSVMHLgRYVDPParxyfA=
X-Received: by 2002:a05:622a:4a84:b0:4ec:f6ae:d5d9 with SMTP id
 d75a77b69052e-4ffa77a8cccmr3596921cf.39.1767633719513; Mon, 05 Jan 2026
 09:21:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105163338.3461512-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260105163338.3461512-1-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 5 Jan 2026 18:21:48 +0100
X-Gm-Features: AQt7F2qRwerw5mD5cmZtLqkLC1AqnULrM0A7nFSyQKD8Q09H3L-DlFT-yKcpUSU
Message-ID: <CANn89iL+AuhJw7-Ma4hQsgQ5X0vxOwToSr2mgVSbkSauy-TGkg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: do not write to msg_get_inq in caller
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, axboe@kernel.dk, kuniyu@google.com, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 5:33=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> msg_get_inq is an input field from caller to callee. Don't set it in
> the callee, as the caller may not clear it on struct reuse.
>
> This is a kernel-internal variant of msghdr only, and the only user
> does reinitialize the field. So this is not critical.
>
> But it is more robust to avoid the write, and slightly simpler code.
>
> Callers set msg_get_inq to request the input queue length to be
> returned in msg_inq. This is equivalent to but independent from the
> SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq).
> To reduce branching in the hot path the second also sets the msg_inq.
> That is WAI.
>
> This is a small follow-on to commit 4d1442979e4a ("af_unix: don't
> post cmsg for SO_INQ unless explicitly asked for"), which fixed the
> inverse.
>
> Also collapse two branches using a bitwise or.
>
> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.24d8030f7a3de@=
gmail.com/
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---

Patch looks sane to me, but the title is a bit confusing, I guess you meant

"net: do not write to msg_get_inq in callee" ?

Also, unix_stream_read_generic() is currently potentially adding a NULL der=
ef
if u->recvmsg_inq is non zero, but msg is NULL ?

If this is the case  we need a Fixes: tag.

