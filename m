Return-Path: <netdev+bounces-202817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4518CAEF1B1
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D2A441DEB
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96262459C5;
	Tue,  1 Jul 2025 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pfGJpfmM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57777220F20
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359670; cv=none; b=S9okxBIUPbSr4irzHCKBpDK1PAQglZ2fQAjjWAP7AXnlQKPxY4ud2145HW4eMVh5mtV4kAYCbowJCjZbZQ76qSqh77O2NhV5MTGhEiag8qUmiF19DtE7xSsKVCFyEm+qfJqD9+GrN7Sv06wVCH4BBTalJgEMInJytrfog46oCPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359670; c=relaxed/simple;
	bh=5ikLTc8iKzNYke9+vz4Tcgp3xgvRhKTpysolE+c/wEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTamF/iBVjC/yZNJV2wwN5LiizuvKE9gXBBhk6nNEx1ZSqGYrCAFGqLL1Mx41sM0ThExqQpg8TZbOjTKVKGfHbRvAI0/fXmoSXXaQEtxMfO9kp5zKuwwON2CBSIlzr5AjScqzwUjAxs+dc0y/KAQ4Y9mySxuCxSJgliaRXne2QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pfGJpfmM; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 485F83FE25
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751359666;
	bh=5ikLTc8iKzNYke9+vz4Tcgp3xgvRhKTpysolE+c/wEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=pfGJpfmM3gGQcYVU3MNZq4J+HMfYB9lOhlIDNK3eB2cnZUXqJUIbQWuGgRZPYnK4Z
	 rmFHbM6D78EbZVI9jzRks3T3Z3lfWOFEGme1CzAEfw2kjHvMFsGTOflEmkrDYZMI7Q
	 KGAu9aOy+4F1ciMGh6gHknpZfUIzqDUHm8IAKcQHZYitcg2aJswCMbPck9ATPFZ8ch
	 CC4WENlGyVH0eY8x+OmctrtplzOmKHOCB6/bQzNn53KYCto4hDAT0LQKEmuvhZomAj
	 ZPLkyQMDkTbaViMcvPbHR5gJrZdjYDl3XBID+zVrdfqTsl9JtaDp9hqDbM3nsZV6l4
	 fc728y0ASDjGw==
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4e9ba1b4658so4186011137.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 01:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359665; x=1751964465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ikLTc8iKzNYke9+vz4Tcgp3xgvRhKTpysolE+c/wEA=;
        b=eZJNpLG7Rhs618FP1cUyCabbJfoefHUgL1Ez0xnVHQR6pD4dQtGnK3+0fBIZTFFEuH
         cy0KiR28viTPfYYWIn60vqDaq+0iVcwQ4FBBHtuwHr/nUWXerswD4SfGvReW8UEnCSAC
         squTX+ZBcOuSSiBMkRBm5tWs82pidWWFhoNqS49wfKs3amg4up6ad5rvTCain9fs47gD
         V3qZ/UsacfOkZSVkcoEfh6kSPbnT+YedDwW5/ydOg3PskAXpK58G4G3cwIGQtLzW1+5w
         3QDw1UkOis++mHzDoJetPKidDI96dlG5ixIykzTlgNUb9apjxlnrgmn0m8M30QSgCk9v
         gsBg==
X-Forwarded-Encrypted: i=1; AJvYcCX6d7GEMznja+qq3NouALzFfFPa16TAlIsqM64YVP+tNa9cR47m066/ZhfncvnTe7HOPLimAYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4z/dXtbVo3OyzbPttkNsR/6lQ7p62bpJsusRD5fKk/HI4ygDi
	w+8XlWD8WwUwilfIg4U7gBdzEfFCSR5leBPvUXzBicCMe3lOkd5a8Ug0Y4zrtQQrbaqlET0haBO
	lrUR25QwXhJjtgYnkR9tO2KxI0nW4GwPx8I1OhNbxp4LuhG2cF1QY60xD8lmDqO9bOu3RSM+jW+
	cNCemaAVRuaEI09OkaXKy48IRmPQsI04z5thIvmmV0Bw9cWnyapU3N39x3ppU=
X-Gm-Gg: ASbGnct8ZuUgOpxpSn2ZaJAVKr5lVEpbfEiyl/X2tTkg0Wx2C+G3MiAR6A3UVe2lAdM
	DtNz/GiRHQwlq8inffDIUoJa3XBRgf2AzCsSHNQq5olq4tRyhy/jsUxL3n+TCb8gUgUrWh73J9J
	tNO2fe
X-Received: by 2002:a05:6102:2b8d:b0:4e2:a235:24d1 with SMTP id ada2fe7eead31-4f143b1764dmr1631174137.4.1751359664857;
        Tue, 01 Jul 2025 01:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/XfNIm44PW5VunFf6h0jOcW1yP6L42lTuRUgGXOj4POf34vLlfU9zPs6f8E7vyoPOSBamW1MimVgR8iVOnwE=
X-Received: by 2002:a05:6102:2b8d:b0:4e2:a235:24d1 with SMTP id
 ada2fe7eead31-4f143b1764dmr1631166137.4.1751359664487; Tue, 01 Jul 2025
 01:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
 <20250629214449.14462-7-aleksandr.mikhalitsyn@canonical.com> <20250701-gehege-portrait-c098442c73d1@brauner>
In-Reply-To: <20250701-gehege-portrait-c098442c73d1@brauner>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Tue, 1 Jul 2025 10:47:31 +0200
X-Gm-Features: Ac12FXyvlb-oWVV4ZdKdWiFUglPTeWBh1qsmwVkifm-1RfJ3O1YjwqQVr7X_3U8
Message-ID: <CAEivzxfULsywKKuYM+T-5AMSQdF7ZyG85=PEJ0KZ0__j-B6=xw@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next 6/6] selftests: net: extend SCM_PIDFD test
 to cover stale pidfds
To: Christian Brauner <brauner@kernel.org>
Cc: kuniyu@google.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Lennart Poettering <mzxreary@0pointer.de>, 
	Luca Boccassi <bluca@debian.org>, David Rheinsberg <david@readahead.eu>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 9:59=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Sun, Jun 29, 2025 at 11:44:43PM +0200, Alexander Mikhalitsyn wrote:
> > Extend SCM_PIDFD test scenarios to also cover dead task's
> > pidfd retrieval and reading its exit info.
> >
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Kuniyuki Iwashima <kuniyu@google.com>
> > Cc: Lennart Poettering <mzxreary@0pointer.de>
> > Cc: Luca Boccassi <bluca@debian.org>
> > Cc: David Rheinsberg <david@readahead.eu>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
>
> Thanks for the tests!
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks for off-list discussions/review and help too, Christian! ;-)

