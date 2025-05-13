Return-Path: <netdev+bounces-189962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EB0AB49B0
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCDD8C3C8D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91A71C863B;
	Tue, 13 May 2025 02:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMnE2ixe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929D1A5B96
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 02:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104493; cv=none; b=CpKa/tozBW8xIZAUcTsKAcPSPmwrtz2cqZBybAbUdWjuusp+hwDaTZFh3iISAafY2/qOP7Xzvewu76fWx68OvtCTKBYi2km+S41xBu50mMVlaGadEtBxluzV6ZIBVkJdcfATIFj4nkPFoOijmBF4GNfLtSNUak2AprzZNUFuOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104493; c=relaxed/simple;
	bh=oVAAINjf7nhgJsAWNtj+ew1E0figJJN/dk0b6bs7q3g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AHVg9ZFtXCv0dwCSN0nX+Ln63wDhlPGano4qDCxb3VcSbI2+YHNdRSF7aec6RxtmKuK7BGgL39XBvZEOMMergg6ACPREqpx1GCGru8NE2hPfXNCYVRHJqRlbZ6wGIeJtmKPc8G4OalUn0CLQcds2PBZksjnI9Y35OM7fLYsl9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMnE2ixe; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f53d271c4cso47952106d6.3
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 19:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747104491; x=1747709291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLtlZnKZw5dOiEwgXhpAjmdeWZ1WT8xctFkKVR04ck8=;
        b=YMnE2ixe3Cv+/+tU3QOf8PU6wwA42kzk3tbQ2L2ZxdV23b2f7d7r7xiEQ+UlA2rDyz
         0rd42+DH8MeNnH6PsR5BRfNlMEXnfEF507xPDyfxb5kisbv/ZnCy+sEafW1uYt6F4uiq
         u21kbmdw9HI26j0ptiwnSrPW1Vt16b9W9B/FR2V88uxalDfWGkZwKkSuPLY8/MKRg4dK
         1ZIHaZIYFfSCi2Bu2Ts/ZKzvvpqvGngVi+df1jTBG61qkEwGsJlW1wW9HtZmk0rrlUsN
         vw7xae6lFGA6Y8VNcqmQdoPaRI3JuZw3Oy1m4Wm0pxICOlA4YnuM3dcb7ZNot6ka8cwt
         Bw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747104491; x=1747709291;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gLtlZnKZw5dOiEwgXhpAjmdeWZ1WT8xctFkKVR04ck8=;
        b=lyNikHdOnD6dOKw1fD+WklhnQqrT9YfDbRfZ/kW5/aYIOQonaABjGO6WCzo8b9l1qe
         Byb+Md9bPzaOAzbCeyEZz6PTtwgOnVe09wfRryIsphM2KB50iryCLEGh7EwNpaEs/5S/
         BVx6VJDxVwZBAwsO/ulF1gHBDyFS60ZYzhOqn34sgEtcGKyOf2lgenwCg7cC1n80VU7w
         BLruqscXQm2QInc+qV7PWsppCO0IgMl4c93NERwZdJvHZjEflR8D1BnPMGD8pgxc/rhm
         2vPVVC4FI0Ij7mcd8J46g1N2+C2KWkwIAe2VzThK1J4nCaYi1jSoXbBya3q65b3YLA97
         aS6A==
X-Forwarded-Encrypted: i=1; AJvYcCXTYNdEbeFnDQuz2sq0a2WnWfA4YrLGfAb4gVwjFftoOLhT5QzwwfuMyQJKgmlTdqDdeo6OlB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSLBVrbK1F1IG5M/2hYd19EozivOmOqqgOBV+fmK59URDFxaB5
	mC/VPPj5xto9uB/UJcCeI47TFwHtUTIrlT9g6BLxHyvhpFjdqBef
X-Gm-Gg: ASbGncsKZXLO9FLiK3muIAfxBB/zML58g2UZ2AzClvZAfqDaOgBy7+Tur26H4GvLBqX
	GR5gdGyYvgSu3jgMBHwdNQlXS5/WsUx4gmYBYOg0xHNWOLAW5nWIsOUGbcgtiwBcOpSftz3Wdy+
	OJjAsq4uwhRuZvmmzB6GtvEinEQ16nZ4OezTHwJpG7yvPrquiMO444VMwhWnUDmYAbEme+Z/dGP
	6086TrycIMomOKYVvyyLTwYYu9q1lLrPvhNJEj6AtwIk7Ro/DLSKI6hSpvEsVd/+hr4flTatgfs
	y20fU9QwbpSEmUCedzazbmKLEGr4EWfJC9gK5kST+JVnXgqkT0gjkzENa1VtrLgXNxPDQIji3fH
	12AFTqtMoare5gI1eEpMD4/xy1966GqtgVw==
X-Google-Smtp-Source: AGHT+IH/xu416V7utYk6NxJngOqvX866rhOjaRgbd7mshGZ/0ZG/pydpvFgvEglAamTUX0qkXejVig==
X-Received: by 2002:a05:6214:8006:b0:6f8:8df1:655 with SMTP id 6a1803df08f44-6f88df107e6mr10849706d6.29.1747104490833;
        Mon, 12 May 2025 19:48:10 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f6e3a600easm61278476d6.123.2025.05.12.19.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 19:48:10 -0700 (PDT)
Date: Mon, 12 May 2025 22:48:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 willemdebruijn.kernel@gmail.com
Cc: brauner@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 horms@kernel.org, 
 kuba@kernel.org, 
 kuni1840@gmail.com, 
 kuniyu@amazon.com, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com
Message-ID: <6822b2e9e484d_104f1029457@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250512223729.58686-1-kuniyu@amazon.com>
References: <68224e25b13ac_eb9592943d@willemb.c.googlers.com.notmuch>
 <20250512223729.58686-1-kuniyu@amazon.com>
Subject: Re: [PATCH v2 net-next 7/9] af_unix: Inherit sk_flags at connect().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kuniyuki Iwashima wrote:
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Mon, 12 May 2025 15:38:13 -0400
> > Kuniyuki Iwashima wrote:
> > > For SOCK_STREAM embryo sockets, the SO_PASS{CRED,PIDFD,SEC} options=

> > > are inherited from the parent listen()ing socket.
> > > =

> > > Currently, this inheritance happens at accept(), because these
> > > attributes were stored in sk->sk_socket->flags and the struct socke=
t
> > > is not allocated until accept().
> > > =

> > > This leads to unintentional behaviour.
> > > =

> > > When a peer sends data to an embryo socket in the accept() queue,
> > > unix_maybe_add_creds() embeds credentials into the skb, even if
> > > neither the peer nor the listener has enabled these options.
> > > =

> > > If the option is enabled, the embryo socket receives the ancillary
> > > data after accept().  If not, the data is silently discarded.
> > > =

> > > This conservative approach works for SO_PASS{CRED,PIDFD,SEC}, but n=
ot
> > > for SO_PASSRIGHTS; once an SCM_RIGHTS with a hung file descriptor i=
s
> > > sent, it=E2=80=99s game over.
> > =

> > Should this be a fix to net then?
> =

> Regarding SO_PASS{CRED,PIDFD,SEC}, this patch is a small optimisation
> to save unnecessary get_pid() etc, like 16e572626961
> =

> And, SO_PASSRIGHTS is not yet added here, so this is not a fix.

Ack, thanks.
 =

> Maybe I should have clarified like "this works but would not for SO_PAS=
SRIGHTS".
> =

> =

> > =

> > It depends on the move of this one bit from socket to sock. So is not=

> > a stand-alone patch. But does not need all of the previous cleanup
> > patches if needs to be backportable.
> > =

> > > =

> > > To avoid this, we will need to preserve SOCK_PASSRIGHTS even on emb=
ryo
> > > sockets.
> > > =

> > > A recent change made it possible to access the parent's flags in
> > > sendmsg() via unix_sk(other)->listener->sk->sk_socket->flags, but
> > > this introduces an unnecessary condition that is irrelevant for
> > > most sockets, accept()ed sockets and clients.
> > =

> > What is this condition and how is it irrelevant? A constraint on the
> > kernel having the recent change? I.e., not backportable?
> =

> Commit aed6ecef55d7 ("af_unix: Save listener for embryo socket.") is
> added for a new GC but is a standalone patch.
> =

> If we want to use the listener's flags, the condition will be like...
> =

> 	if (UNIXCB(skb).fp &&
> 	    ((other->sk_socket && other->sk_socket->sk_flags & SOCK_PASSRIGHTS=
) ||
> 	     (!other->sk_socket && unix_sk(other)->listener->sk->sk_socket->sk=
_flags && SOCK_PASSRIGHTS)))

No need to change as this stays as net-next.

Might we helpful to replace "a recent commit" with the full commit refere=
nce.

