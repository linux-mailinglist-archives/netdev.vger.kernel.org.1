Return-Path: <netdev+bounces-150732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53AB9EB5BD
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9A01883E36
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683071BD9DD;
	Tue, 10 Dec 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sD1sQ5NL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D8C1BBBC6
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847172; cv=none; b=RZ+l9G1PlJqL8wh1/C9uDYjUozHHlZ60jYlRKiEafWTIl2h+GQTFdZBdREKy3ylzx6hgzaNEGjfI6cFmVoqlNhRrpYjRGO48Vr+oeDPABuWN7x3EfSdJ6H6yt+PAwSk7+afpctS0/DdZmYk/Hm31F83/hwqeIcWXCMhNxfooUJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847172; c=relaxed/simple;
	bh=IEEi6Rs914XyJs+OK5nkfUNZ57Kyhb85U4z8bcFbL2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svK2VSQMspFxpCXSq8JwkinIi5x/DrY76LOZyzg+qBhJmrjnHsOJfVqXaIcPtn+9jL9hQEm9tGaMx3IIsz2j3QDiQAm5FUqwpEzE072wpXkGxq5mchztPxN10BvyQEo6HKcGMRqxUqFJfXcd/Tu4fKin/iCm8+U4ujAQnjOYvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sD1sQ5NL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so9074684a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733847169; x=1734451969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEEi6Rs914XyJs+OK5nkfUNZ57Kyhb85U4z8bcFbL2o=;
        b=sD1sQ5NLqBqIHikLU1Jxpgt5cxV/2vSow+crbeVGudUxrSIppwpDDugwUdWm4dAXr2
         BRmQZgRePiaoPTBwN7lrMMu60aR8Yl/PSPTQJkizhJDQYrMUZaqGlQKWfrgiUHYk96cU
         yV7Scumy2/jGwUMmQAJDKppYsCXDMSYcKBt+QBfkDgKVJPraF0Jroux0o4McnEEbx8WF
         hDx+C7UIZndQ009CTGICrxdig1N1XUiudj15HRcovqAuklY8EG+3IGGIyw9bSZFajqj1
         xV0Tv+cesK3VIW/VKGQBaRVf02UMd2sabcMXlZ2w8aALbx9hBKy52iSZ+BUeZGAnwdcX
         2niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847169; x=1734451969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEEi6Rs914XyJs+OK5nkfUNZ57Kyhb85U4z8bcFbL2o=;
        b=srbaykn5uBjAcRHnEecFfDP/kaj5fW4cHkghZmEV09wa7BkxzJOP+nF5Y59wEEhyG5
         XQJqZ9bWa/pmEjTo0FIJQMCOvhW/uCkv965wKF4v2R9ee/F1tvIoyHpjZIBnL0+fwGZm
         WL9E0uW1VIPSj2NGJ2ZHf6JGyD0vvv2NYPJBC5vzaJnfJGQ7SbCTQkJ36bql6QIPZYDn
         4c3p9Wt/RWohqyBse+zmNVO6Mb65e+UvbsPKXIaG6YR8O6P0Xvx3Tb8V8f67+W3npXJK
         R3QGfN9fSRYm/DPl8mXl7rPMwPN8VTp6aXOL0hR/7sj31Nd5w4tn8oJdbagOt+FGklPI
         eS+A==
X-Gm-Message-State: AOJu0Yyils+TjwhvSQdHKBK8lXJYFn2JfIXOuiT4F9HmNFDaVjzbVPv7
	q5tpkF0BU5ZWNkYG7ucUAaG+akhfnrZeV51kBItmKCz9MBsRNTJn7w9TkKr5MShUXtLZhv8ioqI
	Zy/nXzfV5iSkC6ooHBnTcwAHe1tjPq4t8cd7fko9KnECL5tXinWJ1
X-Gm-Gg: ASbGnctwXK1xBZ/QXHEFFLznLIWg1n7hu9S6Yv4eR2dTTYJigrs7k5QRXYJgiqlAjmI
	lTkcW8n4ZpXAO+rUhVrrStBVT4VYGpITIgjM=
X-Google-Smtp-Source: AGHT+IFC/KNyJLyHI2/ye5Ac84Q8Z6BtOd46kGclCv+WlL7f+aQgPRnclsq5M6vaWLh6SgB/Z9DJNBgT1+mVN6Bg9Lc=
X-Received: by 2002:a05:6402:1e90:b0:5d0:d610:caa2 with SMTP id
 4fb4d7f45d1cf-5d4185fe2aamr6068148a12.26.1733847168800; Tue, 10 Dec 2024
 08:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1fMaHkRf8cfubuE@xiberoa>
In-Reply-To: <Z1fMaHkRf8cfubuE@xiberoa>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Dec 2024 17:12:37 +0100
Message-ID: <CANn89iLgWc6vZZo0tD0XVg0zY-T-eUjKj4r=O_B3QARjFB755Q@mail.gmail.com>
Subject: Re: [PATCH v2 net] splice: do not checksum AF_UNIX sockets
To: Frederik Deweerdt <deweerdt.lkml@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Michal Luczaj <mhal@rbox.co>, David Howells <dhowells@redhat.com>, 
	linux-kernel@vger.kernel.org, xiyou.wangcong@gmail.com, 
	David.Laight@aculab.com, jdamato@fastly.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:06=E2=80=AFAM Frederik Deweerdt
<deweerdt.lkml@gmail.com> wrote:
>
> When `skb_splice_from_iter` was introduced, it inadvertently added
> checksumming for AF_UNIX sockets. This resulted in significant
> slowdowns, for example when using sendfile over unix sockets.
>
> Using the test code in [1] in my test setup (2G single core qemu),
> the client receives a 1000M file in:
> - without the patch: 1482ms (+/- 36ms)
> - with the patch: 652.5ms (+/- 22.9ms)
>
> This commit addresses the issue by marking checksumming as unnecessary in
> `unix_stream_sendmsg`
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Frederik Deweerdt <deweerdt.lkml@gmail.com>
> Fixes: 2e910b95329c ("net: Add a function to splice pages into an skbuff =
for MSG_SPLICE_PAGES")
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

