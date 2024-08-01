Return-Path: <netdev+bounces-114815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700869444BD
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B765281B3C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 06:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A64158531;
	Thu,  1 Aug 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EndNkB1Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07189219E2
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494961; cv=none; b=KAB9S59GH0LmPUQ3v64WlUgqIfHhm1FNB2QSac6NiN3VELVYWBVvJsX2qqbZC4jlmzK/iQoANtT6BEf7/O+GrPXPGAi9W2psPaMoAkcdP5kx47wEbc7sFBU5P5SI6V44/IGRAW5NeQ/NMEYwdAeB1qiOXxZEDB99nR7nX/ji2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494961; c=relaxed/simple;
	bh=L7Gz2tgIq+7O8lP5UdApNrJLhQ+M0SXvNYzqqR1IpS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+VXsQsdVNhPbSYrMzIYI8rD5zmdCtd5M/iEIuMmJ1NkI6x4jgfvmvHn5hdMCGr1CkAJKBB+qxS3ey5ZT0DKkRKQ1kwWb55p7ea29LR8cNqSsfrlfpeivJFaSfuvfRCB7eqPf9uSclU0Tat1epkOIDS0mSICKpocglq/ypZ1OHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EndNkB1Q; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so29343a12.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722494958; x=1723099758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7Gz2tgIq+7O8lP5UdApNrJLhQ+M0SXvNYzqqR1IpS8=;
        b=EndNkB1QjMy6ryhGDzSnj6kvlLNSGXkIOG02WTRzAdRzakR6r1gB5s96DoukGU8FrQ
         FmZyadsyddFSgcIn17UR4xE8tqMqMMuqNoaKPAf2fXDASWWnQBXnuUcBcuapq4xvxqxN
         7qi+nBcWzip3OE4y/Kw8f/EHYR9NCxTdQggNPU7EQ1iT7eJpt0kclSA3iX3lvOX8T0X+
         rNSaqU+fz0FXmG2i6anZH4jEzpD17A5BH3jTkmjBPDj4dss/0MEmVlrrvE5RR5wMpW74
         6dSuX3kWDv+0m3JZMq/VyZTHE4nDLYZ9ZA0OQue+o38oIY0GZrzXybEWG71K90E7lVH6
         eauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722494958; x=1723099758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7Gz2tgIq+7O8lP5UdApNrJLhQ+M0SXvNYzqqR1IpS8=;
        b=WQLoq/qMq4s0Sw4PKc5QXiXqEzrU6K2tIKcT+CKgGv/wDbbeb5NVLmTqueuAtCpih5
         sQq73IMT8XTj848iJvFfT0r5/K7mazE7DDncNwwL5K09lO4d6ip4j91fq76YBrfCeyEP
         AZ+YVkH7y7M7g6ZR1xRPQhL+oqxVLz2tXoJfARqUXSM/x1h87izGhyQC5DrdeXGNBssY
         4YwYsrV++b9FGKHmIPynj/FVQrhGVdtRxBplPSR4uG1XU+ktp9fVx/znr/PxXLosAmOu
         5la9safyFBF98H/RQn2I6GzbqlYPSEEzBdNnjUIZpwm7Bfx8y/+G0L7PBrX014WtUGxf
         X8SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTacccyqf+LOCq7aBe60NcQZ4O485VISThT+WnEWsSLw1GZw4UYBP1pVlMq2h/p72PLgKOEmF+hP87cqk44S1top3VWtLW
X-Gm-Message-State: AOJu0YwU5S+JVhkAv9RiBcvvkinUpiuSCLZuio6TEZs1UKMMUhu9Wer+
	w4ROdhf9YJ15pW5nZbUkq5/ZrDkO1adxtWqmZwyXxPDXZpGCDghB058bfHR8GBDoSO69j/m6t3g
	7EOWWiwqxOy8j6qIwrNwNu5ajAYVnoaEE66bk
X-Google-Smtp-Source: AGHT+IFFYUEp98eIwfP/LGkoFLOJ2l80laxZdL5uR72YyfZ1yRiDcwUAbU1v6ZvFj9Zmu5SDKknV8jIeIlQd/tqq+SQ=
X-Received: by 2002:a05:6402:40c4:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-5b71bbd2aacmr83105a12.4.1722494957930; Wed, 31 Jul 2024
 23:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731120955.23542-1-kerneljasonxing@gmail.com> <20240731120955.23542-4-kerneljasonxing@gmail.com>
In-Reply-To: <20240731120955.23542-4-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Aug 2024 08:49:06 +0200
Message-ID: <CANn89iKU7SKe+3z6JjcjCS3RkXy_NbqbCuyJGktZ4eH5_gU5Lg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] tcp: rstreason: introduce
 SK_RST_REASON_TCP_ABORT_ON_MEMORY for active reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:10=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Introducing a new type TCP_ABORT_ON_MEMORY for tcp reset reason to handle
> out of memory case.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

