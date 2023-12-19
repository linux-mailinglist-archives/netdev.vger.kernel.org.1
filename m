Return-Path: <netdev+bounces-58962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856A5818B36
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965BD1C219AA
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112E41C6BD;
	Tue, 19 Dec 2023 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNh6M68r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7221C6B2
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso13015a12.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 07:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702999617; x=1703604417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4ibeGJIhne6VVKV0BNtUAckK3Ab5WOV40VT8IASPMc=;
        b=CNh6M68rOGjTloWysic49ZOYfY1o18/NfPsGR0LwMJi7+Tn7RMmT8X/oWKcybG6Ain
         6/cK7mSUu4kAg39PxEzT3QCchiRxEkaJP9E2sWFuJbOjIieTcuzu/cEoBgjj28I2fjJv
         zw6CB5YC861RPx1b0kafwIxH8y70QPVkbOeR+b4UOAMbI6mePgmglgBQdzicIBuzI+Ax
         GMaw09hjiii4qiWo1DShtI++yLJ1XFqWWm08v5LHNIzHiP0qtMFKomWhV/6Vo2iSeUU8
         Hsbw20IcWDSG7dJ48CHedkyfYpZIwfETVmZ7CQkrlNnB/oJo+/oZzri+NgPLR0uaU9sN
         VdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702999617; x=1703604417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4ibeGJIhne6VVKV0BNtUAckK3Ab5WOV40VT8IASPMc=;
        b=GKgNNZ5k4WpFbuiiEOknKuGOx6CGFLIul7ry+ov+XupWM6t3wEdK/UXcxXBlQe2BYg
         lTxQJegx5M7LDLt8Z7wRg5zSwfb/buJgX50IMlTqsD5WcOkT2AsGC2+aBvmkbqV3RSHg
         pTVAW4J1IU1X9AzCmqNBmCVU8Ag9iDBvywpTeaLqs96tpLrER4tplVVR5KZDQEROVIKA
         /8tSSOuj9y6eiD5QYJ6JVkm0XLXZ0r2EFbXn0a6EEkw8Y6coNVSSnkOvnJR8M9OVoplG
         sGbNEjN5594hFTBdHV5JbnXld5eNlc0tCauMcgUhb2hSeF27XrZjK6oqswSfJ96f85i0
         CvOA==
X-Gm-Message-State: AOJu0YypECc9xC14E5hMGQlYzwY6v88kiVUW/LKkWnu21eG9u78YpoXN
	wWQlleEC7O1uVXs513AQCvVvKjanl9l0EqDZEJU3CQZo/hz7
X-Google-Smtp-Source: AGHT+IGcUCffJnJj5Prxizvhv+SwupxTM8tYBb/9m2rMVDG1x2zpZVi2W9m+iTp5/gC2A9PDNCUNz4rsKiBKvAQGQyo=
X-Received: by 2002:a50:8d4f:0:b0:553:773b:b7b2 with SMTP id
 t15-20020a508d4f000000b00553773bb7b2mr186812edt.6.1702999617488; Tue, 19 Dec
 2023 07:26:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219001833.10122-1-kuniyu@amazon.com> <20231219001833.10122-8-kuniyu@amazon.com>
In-Reply-To: <20231219001833.10122-8-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 16:26:46 +0100
Message-ID: <CANn89iK1XemZLwD_dnDaONKyaBeuNtcRciydzDWfUievpK7dcQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 net-next 07/12] tcp: Rearrange tests in inet_csk_bind_conflict().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:21=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> The following patch adds code in the !inet_use_bhash2_on_bind(sk)
> case in inet_csk_bind_conflict().
>
> To avoid adding nest and make the change cleaner, this patch
> rearranges tests in inet_csk_bind_conflict().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

