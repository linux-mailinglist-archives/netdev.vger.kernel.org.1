Return-Path: <netdev+bounces-112611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E35D393A2C7
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 16:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201FF1C221E0
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02171153BE4;
	Tue, 23 Jul 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPN1AZ3V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6FA14BF86
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745167; cv=none; b=m/ABjTAEPkp3U5h8b6PaK3F3O+8uFdudbJrcUhMp8Ta/h1HbQ9nTGgQTIhkl2lLiebdr31gt793EaHAmn6G40MsdyfgoenuuiMPsGGVebiNuipGSNzgZDkDUNx/VtzMQSHZy7Uq2NCFVssru5gosstxEBPTi66Bq6IUG7nFLb7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745167; c=relaxed/simple;
	bh=M8QPdNoErhvseqN1OJfQLnvZ1KG36wzCI2ty/tnPpuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6YY8uk1Kr6BsCc6bjU6OAFM7F+j28/6r2ITtCgOeEQWcnuB/4GlyavACtugHftfhFlPFN5WrNrp2r5fBtglhGq5EYdgE9rWxQIXBsHmgE2kEHkz9pqGQNXZP23cn3IAOFvhIFegHT2UDI6DZx1VmoGz1MHFOYxIA+Cj4F+nrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPN1AZ3V; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so15218a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721745164; x=1722349964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/3luC+b74oek9g0LUsZq7rzlOWeW8aiRXZj5lINnDU=;
        b=sPN1AZ3Vbsk5hcuPqFEpKZAh5F5mb6ok4ZoCTgMgl7Vid0Wdv3mAahWMm1oMS5+ht5
         tZGHGDKsm4d38bMuvXCM2ywwhnMNc2+BXYJpzQ8F6/o/k4/EloJa3tlYMZb4bpv/jsVo
         DQbhYgsEmGyUdh3KK6MGAJLjWGwsN+EfS0NusDDpCIW0cquKepJ2G0sVj4s/gitXRgjq
         aU5+ROcyZN/4Va2knTO2k58WQfJMJ0sWLMffaocCH4o8Brd8nDrTKJKAJjn3avrdAasu
         iC/dXog4Fx9Vf88Bny8mNwvfjd+69j8JI8YDP7SHVq2tSqDYO9AHFm1f/g9BjJ9eMwTX
         snlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745164; x=1722349964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/3luC+b74oek9g0LUsZq7rzlOWeW8aiRXZj5lINnDU=;
        b=MotGQFuCOQ6iEO8OJhoSZ40C2AepbNKs70qbsEKzhhVgMvTL9jUyjHA/fUn7/9tbUZ
         CI9mY/WlUvp2MQdPMj0VRm4PHmKI3QjFKzi6uMO0ffcABopHEIu/mVnUt1rIrruOxXwq
         ThXUODvA3ws3Qoid61/eiBs3JlRmRDXaoqeDQrzDQGb89esa8Rk/5ICik9w/1O5Igkvj
         yD2oBKCuO5fsUmj5xM+HCsUcroVrtksKrxHtl5T/gpTTi8S3dDHtkW9c8I2tS9VUBzKU
         mP/ZkXHoafH86o5WRaYDWSp63V2obzQrk0JQmAOp4MMMFXFh1YcWghVbTUHSSHZxsHcU
         LLfg==
X-Forwarded-Encrypted: i=1; AJvYcCX7pTc6ZMCw5hC+Q8eQ0VvqZvHfuEVQM8OcPWQsHGO2Z02c6D0ZrpCm+nayg/kk7ypQZU/OUs/Q1YBV+pYBtvPOR4MCwIwT
X-Gm-Message-State: AOJu0YxqrvKF1hz1Eu4DPUA81klSBr0Bnmy/YGLsdbbqi5TJnJzb6bk5
	XwAV+g7py+w2n7cT1LwdUbQyRnY4TOuB8wEdmfWGVaLrujRX99l+sdqLWfzWCj54HDMAQ+bPSJH
	RCspyxcehATbvQWyc0sHTNJJSj0zcmlH/phQc
X-Google-Smtp-Source: AGHT+IHryeGRcNZLCDA8qms03eeDbKTz45Mz5TYFlQKLM2GscLleFt9jBQNlP1av7H7byqMt6vKBSbp+d8N3aZr3M4I=
X-Received: by 2002:a05:6402:5254:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-5a456a63b69mr546528a12.4.1721745164063; Tue, 23 Jul 2024
 07:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
 <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-2-d653f85639f6@kernel.org>
In-Reply-To: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-2-d653f85639f6@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 16:32:29 +0200
Message-ID: <CANn89iKOa8YKYjz4jVN0R+3qCpcALTAJ_8W+pd+022jAMT+Zjw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] tcp: limit wake-up for crossed SYN cases to SYN-ACK
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jerry Chu <hkchu@google.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 12:34=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> sk->sk_socket will be assigned in case of marginal crossed SYN, but also
> in other cases, e.g.
>
>  - With TCP Fast Open, if the connection got accept()'ed before
>    receiving the 3rd ACK ;
>
>  - With MPTCP, when accepting additional subflows to an existing MPTCP
>    connection.
>
> In these cases, the switch to TCP_ESTABLISHED is done when receiving the
> 3rd ACK, without the SYN flag then.
>
> To properly restrict the wake-up to crossed SYN cases, it is then
> required to also limit the check to packets containing the SYN-ACK
> flags.
>
> While at it, also update the attached comment: sk->sk_sleep has been
> removed in 2010, and replaced by sk->sk_wq in commit 43815482370c ("net:
> sock_def_readable() and friends RCU conversion").
>
> Fixes: 168a8f58059a ("tcp: TCP Fast Open Server - main code path")
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - The above 'Fixes' tag should correspond to the commit introducing the
>    possibility to have sk->sk_socket being set there in other cases than
>    the crossed SYN one. But I might have missed other cases. Maybe
>    1da177e4c3f4 ("Linux-2.6.12-rc2") might be safer? On the other hand,
>    I don't think this wake-up was causing any visible issue, apart from
>    not being needed.

This seems a net-next candidate to me ?

