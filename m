Return-Path: <netdev+bounces-79110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C074C877D31
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 10:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDEE280F79
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 09:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E0418643;
	Mon, 11 Mar 2024 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/IlAXCQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC801802E
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150450; cv=none; b=EDTY/OL+0yvdVEP4Sc0raDorFNBPosvH+TY3gedtimDfrAgky0YArM33bhsLjocxdlrzwQGrlFzMLOF08YVCeYXQ4tW6ueeu2h+DCQ87ZKhMSaLJJ+Wp3ULc5VXKIujX7q/BdVRHcG+qcUproWNLZbQg5UsLxce0ne2urLkeYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150450; c=relaxed/simple;
	bh=RzRyZ2Y/H60IoTup3z+ujF9hhfZBZucIJa75wXuEEy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m96tNX5bTcEUWZOXs48m61stz4ZpPlGWly8/C30lFzk5i8p9Eir07/t5yfjsfaHxdbrD78AbaZal1iQJhixIvvqmyAS5Oo5v4a9AJIAUVq0gECxIoHpwtPtJ1nrJnACt6PCYuNIEP5TSPW8Snh+/Cs7VQ+7Zy1LA/1bZpdhxgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b/IlAXCQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412d84ffbfaso81305e9.0
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710150447; x=1710755247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dArePOa7PMIXZ4bi++Ti3065IMzX7n1A2PpSfuOmlDE=;
        b=b/IlAXCQA7RJRDE2FkR+aQX7BBMHvcMyHjt2FRLkhUELqtL7mS7MO5nbO8dzjbww7g
         aNMlOUKrLE0TPrrzFsyy6RELE30f01uKICZVwUw/Rl7+S2mPSjolfp8fHdK2W/8Q3WeY
         Yf4ejDnJgUwS8DW10dtKoHIasFYndmhmO2i0Rf/FAT7yC50fPjnc8VH/Svb8yd2c9H09
         ix1/IJhg1o3xw7i7TUZR13PTAoRxKrS+yzz5BECFNR+LlysQpBfhXFxkfeggQjDw7moG
         EjsouVRxvkawZlbmFGh4ApZ3l1Ad9nV5X+7Z1mDuwK+Xl1NLleM2X107EXm7pUDzQ58V
         g/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710150447; x=1710755247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dArePOa7PMIXZ4bi++Ti3065IMzX7n1A2PpSfuOmlDE=;
        b=cN2ku3liYDdmQwaCSjsgaNd78YYYrR4dbXDYERjWS66YFCU2v6dn7o/qc9LMBKRurT
         9UlA7deVLpSFxLtqgOKPOheLNKHDoCJ4gSRZpcGHcOKLW7CqsnPM6A+srzFmrayU+8Z2
         /dmjk0iwBdkUYye78ZM7J/b+yc9R7cnnhurgvLkhGR6d6E0oIT5OjDlt1ccITUS7tz3v
         D24SVaWQjxN9kXnTZ7FiGKI3dJMygvjkR2SMdmw7XUYXx94dzC5DwEhu1m9iilRsXDnB
         NjSVzQQlY/I8Sp5Co4fUkRCZpMbZBOJQ8bgTt+lRsNBWpeDPlp5UPom0PL+fzffM/Aqs
         Wcgg==
X-Gm-Message-State: AOJu0YxU6Ve9h7mOqqe6CH5FqaAZ+tzzMH2aiRpEFtHxM8xLaJPM6sWL
	J8eV5vexKilG1HB7smP0nAYxMGVgi8MhlsMOooZBB1tNTZZAzU3PMjDfxj6H7cFVNtxb7m5jqTZ
	YUhm1toCtS5sio1x5uJSbufPh7EgQd6tpqW1r
X-Google-Smtp-Source: AGHT+IGyNWQ08iZUA1VpkYextSDsboe4nQ92CWQiDd1FYfLlKjj50bt//Gadn6b7WEXMxQbBswLX9skbmuS+QLIET6Q=
X-Received: by 2002:a05:600c:2e0b:b0:412:e4fc:b10 with SMTP id
 o11-20020a05600c2e0b00b00412e4fc0b10mr756873wmf.3.1710150446475; Mon, 11 Mar
 2024 02:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <95eb2777e6e6815b50242abb356cfc12557c6260.camel@decadent.org.uk>
In-Reply-To: <95eb2777e6e6815b50242abb356cfc12557c6260.camel@decadent.org.uk>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 11 Mar 2024 10:47:14 +0100
Message-ID: <CANn89iKnQZWNw3NS0uGCWSejKxaUh8iL=UwZ+9+Lhmfth-LTxQ@mail.gmail.com>
Subject: Re: Is CVE-2024-26624 a valid issue?
To: Ben Hutchings <ben@decadent.org.uk>
Cc: netdev <netdev@vger.kernel.org>, cve@kernel.org, 
	Salvatore Bonaccorso <carnil@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ben

Yes, my understanding of the issue is that it is a false positive.

Some kernels might crash whenever LOCKDEP triggers, as for any WARNing.

Thanks.

On Mon, Mar 11, 2024 at 1:02=E2=80=AFAM Ben Hutchings <ben@decadent.org.uk>=
 wrote:
>
> Hi Eric,
>
> I noted that CVE-2024-26624 was assigned by the kernel CVE authority to
> the issue fixed by commit 4d322dce82a1 "af_unix: fix lockdep positive
> in sk_diag_dump_icons()".  By my understanding, this does not fix any
> locking bug, but only a false positive report from lockdep.  Do you
> consider this a security issue?
>
> Ben.
>
> --
> Ben Hutchings
> Time is nature's way of making sure that
> everything doesn't happen at once.
>

