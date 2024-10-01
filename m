Return-Path: <netdev+bounces-130881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F7898BD8C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9162B1F23C3F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5BE1C4617;
	Tue,  1 Oct 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mc3CRff/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2B1C4608
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789352; cv=none; b=COGjDGP1LUAnaLpIP4NfGOBuwgqC9WtNwOHaiqkapEeGiUCSHH87ZOcjwhgeBtxSU2h6QARE2e4w+ddfF4oLT6CcOcW18c9Ve8GHeGbQE4Hbgu1QAxaWCuP9yHNXiEh2eCtbNdI6mQZ1UdoeHzqiXbCPtA5M2Q+3RQv2p1+9NCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789352; c=relaxed/simple;
	bh=3N5Oa4iBwWJMrHwO1iOZ5iDlia5jS2rBTR6Q024+txc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiqEKXTwyEDiRMc+J53lPcr5M6duPp1pdufiFkDg8VMFbXl/z4HyOBwpuxS3EFf8PyUaLxtDnNhnLFIpBml3N+aRYrPUTOKnUgZGHEYQhkWNtHNOukephNErvcgNIrfgCRQqfST/XoL3SKtTJCs8LoFAomUwpe6LgWFE3SHyazM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mc3CRff/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c88d7c8dbaso2274411a12.2
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727789349; x=1728394149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLR5rUKxjnbtEIA0BFW4FvjL4OXH+X5CXBSSE//MCSI=;
        b=mc3CRff/BmHH4Il1Jq8zQCpWYssJHOeDuuWk6h+MCnSuh40j8HVwVzShZMUjCc4Sdv
         wMiHh+ODBvoLc0UB77pxKL6NmIx8ifPwgdlZcwpSeJTxCazDPL68Xg9WXFl0I8O234N/
         k26Vz07sJw8Br3S6/hZAMAYWzu8Y7rxwGg7ShcdyH9yclGX/PSfchE4nHeH8qRYxK5wz
         S8mbzxqrQU/OHKL+bWKSfUmY5iko0NH59risMzFB4m7yRXrmdKGpNyjMwT7n7waXq8de
         7G8YTvMCmJt8UWtUFG6wvMPbnkIkl31L5O5eNqsnuM/yDcfUOa6Js2+aOVQ2sznh9ULP
         Plsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789349; x=1728394149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLR5rUKxjnbtEIA0BFW4FvjL4OXH+X5CXBSSE//MCSI=;
        b=u8O50MU7iFN9vyqFGc6mayja7oWy3PRywvG17x+LRO1UaUsTFKwbBd5Z2CWrL+7LD0
         FgxcQVTfHLLkMX/XiT0Bglbc8+B5hg0yhmm3AG+OTDW/3n/zuBjPg7iblePyFE0aBlm8
         zowdv7hRxlOYx2f/Il5Kvag6yRMSAMFAq9cc5Nf6y/Pv/isd6xw4mJipJUL1oV7EfHg6
         55OxJq2c9SPG7fIDcz9W9Dlqm3Ds6nIjMTsUL06A0YxUT8JqyTTkyW3y4XicFCRtbUUc
         hHpGXORR5oSvuEpS+u6Fp3Vp32HbNiSxIaTq1H++KcwAY8dme+JBGWRk8KVX49/px33X
         v3eg==
X-Gm-Message-State: AOJu0YwXiaF8nj2c8j1s1H9NckbVWfCyS2oL7qlQvDrr//idar/My8xV
	IcMMK0wf3ieKKvzZO7Z6syYO15ToHdaGUzPUHpjhfXn6sJPjMnZZo46prcBySXGe0nGsXTNZ86P
	ftJd7xFiRosHWOr9s12jBbfIedTQje368Kupy
X-Google-Smtp-Source: AGHT+IEMUuCHddG9Vk6YID/f1XHxwlEJTI1pb6l0JQq2CQQDsu5DKwV1+Y7fOfCRHUcILD/kINc6pUMJQz+zJkjsiGY=
X-Received: by 2002:a05:6402:26c8:b0:5c5:cb49:2f28 with SMTP id
 4fb4d7f45d1cf-5c8824ccdf2mr22823763a12.4.1727789348992; Tue, 01 Oct 2024
 06:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001132702.3122709-1-dhowells@redhat.com> <20241001132702.3122709-2-dhowells@redhat.com>
In-Reply-To: <20241001132702.3122709-2-dhowells@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 15:28:57 +0200
Message-ID: <CANn89iKp47BVt0uGEbCuhEhYvMDy=6+cpp5PQTNQewPWxr_vyg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] rxrpc: Fix a race between socket set up and I/O
 thread creation
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	yuxuanzhe@outlook.com, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 3:27=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> In rxrpc_open_socket(), it sets up the socket and then sets up the I/O
> thread that will handle it.  This is a problem, however, as there's a gap
> between the two phases in which a packet may come into rxrpc_encap_rcv()
> from the UDP packet but we oops when trying to wake the not-yet created I=
/O
> thread.
>
> As a quick fix, just make rxrpc_encap_rcv() discard the packet if there's
> no I/O thread yet.
>
> A better, but more intrusive fix would perhaps be to rearrange things suc=
h
> that the socket creation is done by the I/O thread.
>
> Fixes: a275da62e8c1 ("rxrpc: Create a per-local endpoint receive queue an=
d I/O thread")
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

