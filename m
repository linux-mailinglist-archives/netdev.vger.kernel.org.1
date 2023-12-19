Return-Path: <netdev+bounces-58971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CDE818BA3
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B654F2861B8
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C89C1CFA8;
	Tue, 19 Dec 2023 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xE3YTvoV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A111D542
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-552eaf800abso17409a12.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 07:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703001327; x=1703606127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6VVqXCOP3y9jHvrk7wySN2T3vdbOMYcwytfuOKrDrA=;
        b=xE3YTvoVO/bUM5pK4tHDHSdyOW5lXsemIjkQyXVTXjz1eSFUqrli+fAPL+x0rPEdrC
         XZ5wVqpuF8R5cb5ZtiQY9mmCDiS2o+OvV6+TW1XEDphZ63GK0i1qcN7Me67FwOSFbKlk
         joLBCIlKIMR7+awTFeE39ErotLx6YhFstowPeTpT4sce76O7l9HbfsxkCNqNWsMMQXdQ
         wMVRFfZUEd7zCih/oqLo1PXALuYI/E/5q6h/RPGWGFGGnyt8SU+kQMAHhRFLWT42WGZK
         WxNBALzRH65MuwBpnXg92EPt6rbfu+MQx0oLqjfc6vCrgLsiuvQIFQOBX0uRZqEaIGd0
         m+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703001327; x=1703606127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6VVqXCOP3y9jHvrk7wySN2T3vdbOMYcwytfuOKrDrA=;
        b=qKyriZyHpOSYEOedg0QEQL9g36YbCSkx4thjluU3NrGMQ1ko4nDpKHvsWmsYwRRrPK
         //wmly1KSKyP9l7rMDEE2O0dKYF2K3FpNs0gQOOaft/uFLrJ8r4jfzFnrfXrISxID4Q5
         c0murrUZey1xlYjU0PGJ/DzQ3ACZ797Azj/jht+CM+LL1wpSdMusTBkLwGm1B9IOCGgO
         BEyumT6WgACsz5qCTTxJK3uPacJFrZmOgUs3Vd83JEPvDvbipeENx7ex1LISOVith1hg
         EKnMdWcAwtbxFIa8eUyxrsFIbkabSZayz2Ahw2ZoeUUGN3/kR4zFRcE1PFg2JAzpPeAH
         Yi/A==
X-Gm-Message-State: AOJu0YyavJXpp/abPAceDAT+SM4Qg9yGcPkyVUZbc/bB7QZR++quVA7n
	jocqF1/2878scVqCjwwhhf7ZlTjCoF/8WG2cfRF/j9HuPK2u
X-Google-Smtp-Source: AGHT+IHjJPHd0XCEpKiJKvZSCOqiLywem8xJK19+v0Z5OYCSp1pE3xV62epw1aU0i8HW9BoqrZSll0BA+YRhBnIzkcA=
X-Received: by 2002:a50:9fab:0:b0:54c:f4fd:3427 with SMTP id
 c40-20020a509fab000000b0054cf4fd3427mr190776edf.7.1703001327187; Tue, 19 Dec
 2023 07:55:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219001833.10122-1-kuniyu@amazon.com> <20231219001833.10122-12-kuniyu@amazon.com>
In-Reply-To: <20231219001833.10122-12-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 16:55:16 +0100
Message-ID: <CANn89iKVTAewzWfbcuY_pLemvMOAOVOoFGOj1KwJpYBuZ5bCNQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 net-next 11/12] tcp: Link sk and twsk to
 tb2->owners using skc_bind_node.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:23=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Now we can use sk_bind_node/tw_bind_node for bhash2, which means
> we need not link TIME_WAIT sockets separately.
>
> The dead code and sk_bind2_node will be removed in the next patch.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

