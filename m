Return-Path: <netdev+bounces-225662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CBAB96A80
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 17:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B29EB7AE4CE
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D24025CC74;
	Tue, 23 Sep 2025 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipTJ+fgH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF16A23E325
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642555; cv=none; b=SV/Ovu2WPVbUvCgERj6pRvYa2b2q/d4eU8Dq7SlgJc1J9xziiVHv8sDTebQYLlY0MNAqAm5kl2mMBAXQeOoOaj6AyqG3ZUC889d3jn/W8Rfspd12N7CFH75qaeJQ/AyjmLpQYCaZFZoVeK9FPCyzXbMQBkFTc4YTZZ6uUMMKpaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642555; c=relaxed/simple;
	bh=a6gz1VpqLfP2Qo81xJtC/LGGtIJs3zssm8VUofjyi+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmvwhxFW3MGIgtdc9gLbApK0cLbcDxvH4KTEgo8+RIkFQOUbfRYBpt0QKg8tHpcLEtAcs3jYl5mrc3anvnMScQRtFx6LxevyW8kwRUWMS3641mzo4qgsLsIv1G95l2IE+6F0aSgRvlGmUxwaL6Jw8oKP40myfrTjAAC6r19M6qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipTJ+fgH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b556b3501easo434468a12.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758642553; x=1759247353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pgkmz7Yia2mUyCjlHvvFUXxL30TIgrGepaFfyyHrQY4=;
        b=ipTJ+fgHdRbmh85ItpZqwCFUFulSta9o9pGEWEHJY/SiYCOl46spIdxo3LibdMwcFe
         dno2rJr3o38UjF/UuV0qV7lIYDgn0y0tBHgWatCFMCceI8W3mjwLeJ1yJFmtjUQIyTIs
         N7M7GT4ErAsROV/FvZa1lgzfgWGkpG51xD8NNlZgPLNsshW6jTBre6cp9226QlH56qvL
         grhI0L10fjFJ9OaLi/YxOkmS3voP/PfzODW9yfbHu5lbQt8dh4WiDcMHJrwK6Nh5EiHc
         q9haxs7w8HYGGbzygzbFzX6QY0CliRh+zwYx1rPECDgIqIC4T+bquSV4MCJ7ifadSlRv
         KMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642553; x=1759247353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pgkmz7Yia2mUyCjlHvvFUXxL30TIgrGepaFfyyHrQY4=;
        b=nzTNsIL0QgEtqaRVfTdaFeafGQ/T87ijTnKrTZXW/3nQV9aJDy3Ggn4I/taKQp+kPt
         CTFzd9vQJxiWVlZyFmGCKmFVKXAa5Au7jvRiktafnT4HOy7QHygHt0I+cBe1rJPreD5s
         xtXZ+PYQWFn6+x6Hxza3K8vUtVJJ8eiTHNSEwaASV1tfL01ZHNQf7xVudUsZRrUF5ouV
         YHS+AhJZi8B8U7lqA4kRAOUA9q7ZLM2y0N9OAyN/G88Pn4ukeadTzLetV363f3OnoEbv
         TL0yVCYX22it4FBtIQBaMhLYJfWt/yAd0CMbFO31SG63RfK4yOwk+MbWP3gbGalKsYIU
         BRsw==
X-Gm-Message-State: AOJu0Yx97ZYEHRwttLs1oyowgn/lNVIwdumZd99oaVNeCdbhDSM+xmyF
	lTd44Fv7Mx7DIAbb4BR4PTgHwg/etPjZJEmzuIeB7urpgG/8dGWkkb/fkuhdnj6GpVLPKP3ee1J
	47EbcJ8eVqNTaohb4v/kkA9nuEEdCsaA=
X-Gm-Gg: ASbGncujhbdJRr6FZk+mfycdcqlFc3b5pJFUM5CmbGJXY+cdH6P1WBBG6cNlrGzpXDG
	qSFCs4bB7dcsKKF3zGxte/gxvooKcLzbh1JgjmmhgTIpk4neLDKbaK0ffGr4SdIXFIx2IsPlqm9
	Ttw2AUdeIgjti9Z4oYtC2fwdvaCgZehG2mCiabjepgxJ5sRFQVZfitx67TVgbeaXhLVSOesJnA4
	cRwdza9YLd/JfK6Lln8w8Mb0k0MmkUBCgv1dk5BcQ==
X-Google-Smtp-Source: AGHT+IG7o9i2dC43ioTn7wIZWQ8fZEx36/pwtA6UL0v+ENVD318XjL1HnK/qVloz+EM5tn9E+0yFRx7wuB1Epbm1wH4=
X-Received: by 2002:a17:90b:3d0b:b0:31e:cc6b:320f with SMTP id
 98e67ed59e1d1-332a94e17d4mr3928720a91.5.1758642553164; Tue, 23 Sep 2025
 08:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758234904.git.lucien.xin@gmail.com> <a7fb75136c7c2e51b7081d3bff421e01b435288f.1758234904.git.lucien.xin@gmail.com>
 <20250923090641.GE836419@horms.kernel.org>
In-Reply-To: <20250923090641.GE836419@horms.kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 23 Sep 2025 11:49:01 -0400
X-Gm-Features: AS18NWAbFH9Ui-fpEfRTHKNs6RYmJyoXlKo6RimozANIMCZAAraSfSWOKbynGIY
Message-ID: <CADvbK_e9w0vW225G++wmHPrBj9d=7MBYXT4i8aeMvZ=Oc-g-ug@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/15] quic: provide common utilities and data structures
To: Simon Horman <horms@kernel.org>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Benjamin Coddington <bcodding@redhat.com>, Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe" <alibuda@linux.alibaba.com>, 
	Jason Baron <jbaron@akamai.com>, illiliti <illiliti@protonmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Daniel Stenberg <daniel@haxx.se>, Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 5:06=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Sep 18, 2025 at 06:34:52PM -0400, Xin Long wrote:
>
> > index f79f43f0c17f..b54532916aa2 100644
> > --- a/net/quic/protocol.c
> > +++ b/net/quic/protocol.c
> > @@ -336,6 +336,9 @@ static __init int quic_init(void)
> >       if (err)
> >               goto err_percpu_counter;
> >
> > +     if (quic_hash_tables_init())
>
> Hi Xin,
>
> If we reach here then the function will return err, which is 0.
> So it seems that err should be set to a negative error value instead.
> Perhaps the return value of quic_hash_tables_init.
Good catch!

