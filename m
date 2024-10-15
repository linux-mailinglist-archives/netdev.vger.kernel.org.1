Return-Path: <netdev+bounces-135471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E824E99E0B5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9256F1F25436
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4F71B85FA;
	Tue, 15 Oct 2024 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0G0KxkKH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BFF1C57B1
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980217; cv=none; b=dsMoKI5DJt9aUcif8mVGNlPDDBofV04RCHgNCH8X48H1L0lmBAQfCyNt0FSBF6Q8C1zWTbDWkYCvwdfxtHDRczN3ip6zrIQg2OPG1CJO2eISOXLldnjVhtJO4auG6gKXpRl2/LzsdL7AE1Of9eSyhJcwzdy7tVVQA9Is3Pf58yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980217; c=relaxed/simple;
	bh=NJ+gdPg7AVUPVqSIE9u+0X/whrIDBj0KAP10SY13xGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lA1H4CXvDBjpip+kFkl0d3uSnoLo9zbsMizqIN9ZbwbOdzhjxx9WOcFGvx+wvo+XU1y3gH3XqI2/T99UEH/YX8/qI8a/Pe5GQ7ikQz1e5JYCUe78Fss5D8Ok3m24IIpB0bQGznltVilL5zxJYpkd/WhUA0Q6RjBpG028CV8M56s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0G0KxkKH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so6735532a12.2
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728980214; x=1729585014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJ+gdPg7AVUPVqSIE9u+0X/whrIDBj0KAP10SY13xGg=;
        b=0G0KxkKHKFo5LJHFOmOZxOj0kCZy6PQxiyyZoDF5ywKv1YqVHv8m+CEpTAnttv16x+
         aJ5by3Qws3164TUIgR/NkPUYl9tmwH/vgfUTDrRqTUHi4hESFQ11E0qo+Ks4ykpMEDu0
         tMd7udOwBkncIhCRGDjoccV4o9u1ozSepnsToB/BFNxffzFw0CSgaDvbqeTc45vJZgNP
         eoKGsbNGx9n7mkTa2qIxf13Z89qTWrmpXoQtVimIfVrZZXFU2Ene4b7PYlED3xa3P4Q1
         kCXyqNqNG0xDRIwDRtQCKeBNB56UTar6hM0WurO0riqvUAqDjAmfB4p3CVDu7cdC8R+k
         OISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980214; x=1729585014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJ+gdPg7AVUPVqSIE9u+0X/whrIDBj0KAP10SY13xGg=;
        b=Ld5LkQaW4Kn+j0++Q9CA1xrw3C3f+rGVUy17eQq/ZYLp4FPkncxNMaNLp0SbERJDF6
         SKNHu/akZJNOR5PHZWHpGMwMOgTybNNfy/D5Qr6+VnI3l8wGkTyrOsBiWktRUCRA66WB
         5xyg1gQoBKsmAOk2+pDlV0rmTFcWn2KKFM51zko1mSRuzy1k8QdzAjf8ciYUPEa99cBb
         f7ZHdhlKz17b2mVCtHUJZoPtfMxNTud0eKhLFQyTDZMwGv03sZ6aVF6KuMx9u0nt7TP6
         Vr9VHJSxwBJbd7sk6KeDFuAS2WN7olyY+wMR7mEI1tlr2AN6cwoAq8V+PNGLs1ZpjMjw
         nMtA==
X-Forwarded-Encrypted: i=1; AJvYcCXBzyj5PNw1E0ODP/WgyYsfw0QsCud+qkjODfS56dbtVn8uUWpmrFC2ceQEjNa6akluUmjMzHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjvJcP692kCAYShbxXmGtUiaBPKSZO9LnIArb8yXgbeFumTmGf
	ZUaM+Nxnn7A1UsasAEUi/SP/AGU1H9etSYv8af2iMUXY0j7RJGN4LN9BAYMt0yblCHSqlCstTwL
	lKh5ImbPVQc7XdrlDHViG0JEjCyZrg6WVFb2n
X-Google-Smtp-Source: AGHT+IHg7npdTPWyFRbxWjBxpb8bo4TfFgpfz81OxXGCTPzFH9nUB1UhZpy35SH9TKSd9oAZUOKoV9XLg/Ulf6GrI0c=
X-Received: by 2002:a05:6402:2b86:b0:5c8:95ce:8cc2 with SMTP id
 4fb4d7f45d1cf-5c948cd1d9cmr11159221a12.16.1728980213660; Tue, 15 Oct 2024
 01:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014201828.91221-1-kuniyu@amazon.com> <20241014201828.91221-6-kuniyu@amazon.com>
In-Reply-To: <20241014201828.91221-6-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:16:41 +0200
Message-ID: <CANn89iJz7tCj8+qXRxC1dPDGbMU+z5c2-4ZvCxqqgB2j4tL4nA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 05/11] net: Use rtnl_register_many().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:20=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> We will remove rtnl_register() in favour of rtnl_register_many().
>
> When it succeeds, rtnl_register_many() guarantees all rtnetlink types
> in the passed array are supported, and there is no chance that a part
> of message types is not supported.
>
> Let's use rtnl_register_many() instead.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

