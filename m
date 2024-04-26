Return-Path: <netdev+bounces-91564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 583818B311A
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83530B21BE0
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA8313B7AC;
	Fri, 26 Apr 2024 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xERvQg0d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614413B2A9
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115532; cv=none; b=Egfmkwb4lr6x76XVVW2kOVzdeuFJwzN4QJJnjYdNqeSVRJTCEEmJFNIcZbRK2kaEFjI1t1UjzU5yDZK9SwvCPnsoLyNhVo8LCEpVhCPsifGxBcn+xN7TwsKRrbdtL1fTZir4PRgX4z+cGxFCEJfPFpx5T2ZGSqqgNGTEkwQ6nvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115532; c=relaxed/simple;
	bh=o4CijGE6DQCwbT0vcZY7rzU07Zixh1ND3g5gwlWNbNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AACXzG5bKBfYjeRXJGOxP8av+yp64QAEiwJe1RptfOtsqIIk2KWJYc4+zK6vzzFZa51+S49h7cQEaY54CqCdv7Kiwcg++BACfscziNNk1SngYokgRXiqXch4y9rAFJ2xT4PMd580TwalH4DwTt4+61BMztVv7IODxJK1EiMqLEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xERvQg0d; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so5918a12.1
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115529; x=1714720329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4CijGE6DQCwbT0vcZY7rzU07Zixh1ND3g5gwlWNbNI=;
        b=xERvQg0dQHwVLMvTbKEcVsRsYVGHJUrhY3px0prfFdQ52BjZjqjKk0WrDjxQ4a0Q78
         XDl16DZH7QMVkZoqgFD72lCewV0jMapepCUhvO+ozyoMw/Ncxi1u2B352abx6wBapy0d
         TTdKtWQ5GLS6JXJaWClfFvznhbhrtkxtolzCiy6HWDWVFsqyyJVLMwxWYYcoysyxt1EX
         WuagN6wbgxiH0f/LCFRtFNbDJWYp0cdYW4sIJAuYVASPSv1ELCWc/wIdLeHP4Ws9g+mR
         oY5VOPumjeWBC+Vpfj9DVwk2h1VHQ5LOJ4zpvV6PzcPxYzqwx+jBzCmGODgwAWgl0ttD
         E7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115529; x=1714720329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4CijGE6DQCwbT0vcZY7rzU07Zixh1ND3g5gwlWNbNI=;
        b=KiOhyWv7mu9e4v4d1lWXzhSY3zN1zvJIfxWEvZLTV1mSp2uAbA9/pYu2kWdhg37qZO
         0186YLxOJQ1Od+6Kd3HMCcjoW3Dxt7u4cLkrUZkFyhcWV1MSKKR+wfOK0sBMXZqOboVG
         RD1fUEMkW4FY1eJx/KhzWrwjSx8KVM0YloRTVRiI44GjleVqNApqMZBlHez2uxf5uMy/
         MgUUx/LKYAaL5XwvKr5zSupNPFqudgeBc8IAf3yaxt4DetafGzUTnzw17ZGrQRCqFQQG
         gKx5gcUy8MsBsdsutgP/EjN6RzoOLn7L/FZOzSwqo/6NITqgF+6bgLgEz0Z8nf2cCRvC
         mvrg==
X-Forwarded-Encrypted: i=1; AJvYcCX0qjjbUJ7dxxOEqqzFHMU7Ght0VA1oQmOi7aTw3KCM4Lb99ozSa9Pf1XZLm3MgHZ14u3KD++86tYddBukIBM3lxj/wjIN8
X-Gm-Message-State: AOJu0YxCzz72ZR8ksavjL8MFyTAzj3aQJ/WZNWGXp9QtRB10z06zbI+x
	tMBgxfmoJAXjN9vU/4FuatnTfa+ljkCZDu2QOXuxK9/WWt6VwNMST3/ph4Xo9Wp8PWBIaH17LsF
	pDGiQH8TcBuhMrDSGn9aKlqqbJQ0AKDJkYQ28
X-Google-Smtp-Source: AGHT+IFGK6axy8x4vSxxxy3Oh+3ntHHua1mtJilCxbRJCerWML/wCChAU9qlPo9HVLrAqSWMm+hZgH/UuWi5SnGwh08=
X-Received: by 2002:aa7:d497:0:b0:572:25e4:26eb with SMTP id
 b23-20020aa7d497000000b0057225e426ebmr71684edr.7.1714115529122; Fri, 26 Apr
 2024 00:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-7-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-7-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:11:58 +0200
Message-ID: <CANn89iK9Nqug+X8fPzRQ49fu+AydSqb2Js2FggkOHNFdNEcfAw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 6/7] mptcp: introducing a helper into active
 reset logic
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Since we have mapped every mptcp reset reason definition in enum
> sk_rst_reason, introducing a new helper can cover some missing places
> where we have already set the subflow->reset_reason.
>
> Note: using SK_RST_REASON_NOT_SPECIFIED is the same as
> SK_RST_REASON_MPTCP_RST_EUNSPEC. They are both unknown. So we can convert
> it directly.
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

