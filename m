Return-Path: <netdev+bounces-247150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEB3CF50A9
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0899C303FCF1
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0CF33A9DA;
	Mon,  5 Jan 2026 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm6+ugHX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBAB320A30
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634967; cv=none; b=KdfCOfXE+Q0YrZ9TrDnbo8O9tR0+A+b2TaMwhruFEDJiWvwyv3coXZf9wgzpgLKy28ju0uBIQycMKmJwgjya75fAy8rZeHUMEqqApC4NcxuFz2ukhVVGoj+vnAunxvvdsztiQrn0Z6ZUWvZ5hz3glDfMeceJYinaVs1V0FJgCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634967; c=relaxed/simple;
	bh=IUcF1X1xnAJ7YwKPtqLv0FZGYqXyK1mtTTaLTmGxHiQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HAqtrjPkSbEJm44euv2A2QjxiXs7e/yZwshGWaMobYtmOJ4uqE50NjL/hKvWCqUejbY8xqyRZdp2lViT88F72E0fKCKq5+icjk3BibO3uQDWvfSox3oUnP/6+l894sUP+peVgLoePc7yla+5X4kwqj7/hTLAIjUEMQw7u2wFhm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mm6+ugHX; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-646e2b3600fso163499d50.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 09:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767634964; x=1768239764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVLYF/uOhMu8eV3h+8px8OYI5XKKEcl9XrMt6ff+mr4=;
        b=mm6+ugHXhuZhn8YgM7tOWZXEkcxw35simtFlSSDhVXX4DmgD39qa9ULHwYW2ORk8KJ
         DI3+nv4y4Ti71NNGUxaVP208gUqEejdNkx0ImPVIbPW9RbcncqIl7qwkIHvl3yXBW97s
         n//TKhDQikBDr7aNh1PoRhGN8YNtQNws7jncrldam6i2HnsiVsCfq/lIDHpAQ2XPNOp4
         lIGv077HbFcLeuXj0w798hhrOCWUjWBAsxNy0QOmzPr/hxXmgxU/x91PP7Hm8XmYUida
         zHQnnO4bgI7pL6FWGyBieDhJIujCY+yR1C0kGGHXTzstfPYMsLMciqJXE18jPW+ZtfwU
         gPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767634964; x=1768239764;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WVLYF/uOhMu8eV3h+8px8OYI5XKKEcl9XrMt6ff+mr4=;
        b=se0v+MdFqq+doEzNBpviNQeaXLruKrQYIZLlG88yeNh4g/advaczcPdRqHHFxDvJNQ
         xMrXS41Tzhl3I9r58iamG5m4bw69jqyf47ITLE6Z1C1u8J93FTB5Iuk3+u4BG8GHmU0H
         wmMYdmqD9c96gOYsWT/cJ3ej29m/HhL6YYAhG70zAJTm0A3ZSHtCpBkXa+cqKlJfy7c8
         mV0jtEWLSq6OOXcNU70fnWlFtXc4oBNlgPZzuzvOKB9vmOXXyzgyZLPNbsMPSKTGGH3W
         auHWTdfTTHb/01Sr6NboOD8aaIsUaPo7LW/DBienBTXC7JYE9pUPUkdIWep4zdt6Gh+d
         Yk1Q==
X-Gm-Message-State: AOJu0YzI7hH1D6YXBxCar9nGZg9e8nj1P3hwmTX/cK+vv7+HYs0JfVvl
	B0IOOrOHa51z85UcEuLsQFr3sBDlKrEouwE49Y07D2wiRxjnufKPHU2s
X-Gm-Gg: AY/fxX6+hkMG1Qj81dDTXPq/Gpb7a8y+KTJ7PJX+ijhbinLVZMWXwCfFIYnO0i1VwuJ
	5IPGEhfsy7Dzl/JVWzJE4k4JPUB8PIzdW1XODKUbDkM+xnKkI5GZm55yoENHnh+HISvUSaRuBMK
	n+ROADt2DDHFN8UOtBj1+HJEHr3ZHLDMWFg7cZTuMctWLl8DLcRgABWF6Qnh1fkRSEojnuB1ikd
	rpylsHipD57IVhDZUaajY2szyz/v9Fxhu6XyamELB1n24Lh0bVHFv5SKdvoLQOemgaRfSXwpcrL
	WK4PqcASwv+cI0+TxaqZegNgNcavkJP2gEIMy5L1KDe/wF6NnBjmvsUcLV0akpLWwVMy/Y9rGMw
	0pkpjwzZH1gvk+0O2ZmwsZdp3dFIKW6nzQ3XzkegNMFV+CEpsSQcZkChxMw6hY2YcXMRMaWvs5q
	TtRd/Pb2sQ6+7s0VjQl49RtkOXj0UgC8EctYIbD8vuFxs+Nmn9O9sMz+yVLts=
X-Google-Smtp-Source: AGHT+IFzNe4PT8md0ta2rvGR3HVE54qmsSbhDf2wjC5gDJUQuCA67t920wEC4pAr/UbFolXDEWuAZg==
X-Received: by 2002:a05:690e:4085:b0:63f:556b:5b7 with SMTP id 956f58d0204a3-6470c8319a4mr283281d50.15.1767634964394;
        Mon, 05 Jan 2026 09:42:44 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790a88ad34esm1150657b3.34.2026.01.05.09.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 09:42:43 -0800 (PST)
Date: Mon, 05 Jan 2026 12:42:43 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 axboe@kernel.dk, 
 kuniyu@google.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.2124bbf561b5e@gmail.com>
In-Reply-To: <CANn89iL+AuhJw7-Ma4hQsgQ5X0vxOwToSr2mgVSbkSauy-TGkg@mail.gmail.com>
References: <20260105163338.3461512-1-willemdebruijn.kernel@gmail.com>
 <CANn89iL+AuhJw7-Ma4hQsgQ5X0vxOwToSr2mgVSbkSauy-TGkg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: do not write to msg_get_inq in caller
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Mon, Jan 5, 2026 at 5:33=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > From: Willem de Bruijn <willemb@google.com>
> >
> > msg_get_inq is an input field from caller to callee. Don't set it in
> > the callee, as the caller may not clear it on struct reuse.
> >
> > This is a kernel-internal variant of msghdr only, and the only user
> > does reinitialize the field. So this is not critical.
> >
> > But it is more robust to avoid the write, and slightly simpler code.
> >
> > Callers set msg_get_inq to request the input queue length to be
> > returned in msg_inq. This is equivalent to but independent from the
> > SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq).
> > To reduce branching in the hot path the second also sets the msg_inq.=

> > That is WAI.
> >
> > This is a small follow-on to commit 4d1442979e4a ("af_unix: don't
> > post cmsg for SO_INQ unless explicitly asked for"), which fixed the
> > inverse.
> >
> > Also collapse two branches using a bitwise or.
> >
> > Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.24d8030f7a=
3de@gmail.com/
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > ---
> =

> Patch looks sane to me, but the title is a bit confusing, I guess you m=
eant
> =

> "net: do not write to msg_get_inq in callee" ?

Indeed, thanks. Will fix.

> =

> Also, unix_stream_read_generic() is currently potentially adding a NULL=
 deref
> if u->recvmsg_inq is non zero, but msg is NULL ?
> =

> If this is the case  we need a Fixes: tag.

Oh good point. state->msg can be NULL as of commit 2b514574f7e8 ("net:
af_unix: implement splice for stream af_unix sockets"). That commit
mentions "we mostly have to deal with a non-existing struct msghdr
argument".

Okay. Will resubmit to net with a Fixes tag (after the usual 24hrs).

Thanks!

