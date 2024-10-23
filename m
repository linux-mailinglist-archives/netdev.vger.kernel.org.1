Return-Path: <netdev+bounces-138308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8829ACECE
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515A41F23F01
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3801B4F23;
	Wed, 23 Oct 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8LHqdFC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1C219DFB5
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697471; cv=none; b=J/CIsuKS8fs/XYibhwWLA1caK/xkWpUwIbg1idWk71yqA2UayCagTBSyzV+H0a6jPBById1xCmObOY7kM0znRbuLCOJB39fncSXdGjdEziJAsArM0SCkBEa6pt6kkvg6nnAhMn+3TuPwYKwpQgR0Vy+CKsl0t/42Wxscl5hOQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697471; c=relaxed/simple;
	bh=7Y04qbQg8UzfZa8zelQ7454G0B/u4XwSkHmERbOAMcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bU5G8wTBtuTBBuFr/9GeL3PqMeb5isuWBIB8DCS2EErkhBlvBkJI3BbENBQ/4uYn82KH+19oE9YsJi4E9DqdqeI0vpbFAKuRAuwFlEA+5ws/CjGJaJyKbYp6IDgRntPr+Oi2Wp4hA/MK3sxwiNs62wXUK/yZ8kDrKkGeOGhuBMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y8LHqdFC; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb443746b8so73775251fa.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729697467; x=1730302267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Y04qbQg8UzfZa8zelQ7454G0B/u4XwSkHmERbOAMcg=;
        b=Y8LHqdFCu7S5V+86B/JxKZBQwWBwRcH3hUrbPmetEYAYsRgzjpRhW7T0hYqYXv8wFR
         FGQiqLWA7Ly7DLBxbOeGu1N1NFNjdmMRcgZAWJJ+kBG21GgdfEHJNlO78dh+7BCq6kCj
         usKV5AmSjEPvWxM/QgineSf4cmSQq6JYRJ1yyW0FZ38c69oRFTrSx5zEVAkmiGmLsrRq
         R+uLd/2C/WAfBXnJfrMQ05uFKeB5Pk74KCntISkISZEUQIOprEG8iiCa7xW0RCkiGa8L
         0qIwPAbbXYKuEDYSjY5AjR6Ph4UvadJwxoZ5itjUyShtFSvbn9yT8bEWnCDiv3PDTPtm
         6XSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697467; x=1730302267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Y04qbQg8UzfZa8zelQ7454G0B/u4XwSkHmERbOAMcg=;
        b=w5YAY5Szg7MSmhVkcuZdH++FjKJ27hzzkeRcyDT+UwQt1/yLhshdRt8X/U3xEJkOCJ
         +3n03glx4nf138gYwy/UjzRLtj05mcFiGbk6lShH2tCq5Pvp99cTAYZV2q1+QAynheV4
         Y9UH7wMULEolidBJoZeNtchWogPHvnrhwDORKLd6sqr/rLAFgyra8Qv66NTBfBvI+WFQ
         jCRRvHI/l7YeyQBqaFpGkLpABzFfLWn7ibSoNsibSLs4gqqTWLz+tFfLJBL2Y/Eztqrc
         fyg2UXuOrxus2aKXyOUoMpuuNwJaUqOdp54EiVxHJnGqHB4Qp3au/o0Gdf8c+JlIoF6b
         Fnpg==
X-Forwarded-Encrypted: i=1; AJvYcCWG6X10H+hCRKDfyU5NXpSW7mR0tED0PP4YOuL+3weUnIy1IIMe0fbmK4hcdeH5xF8weAUSFz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5er+CW0MBILMAZpDov7pEzUg0n473alRilih3QbcWOmluzwSm
	RMjbK1r4PGgvG6D24rqRLY24gdXzMrLdlVgTi8UUkaRQq9BUncX8SY/07TRiVn/RNM2pTyXXbW6
	aH4hTqu9+d2mNe/rE5EH6aW3x7i1M5krDKez3
X-Google-Smtp-Source: AGHT+IEJSLLyXKu7ihEjkp115HBeAYiHlmo2U/xOu2UAcou0qnWenyIG4TW4BC5nLNu7qbfj+BSFYq1rNcrRmE5Beb4=
X-Received: by 2002:a2e:bc25:0:b0:2f6:57b1:98b0 with SMTP id
 38308e7fff4ca-2fc9d5851dbmr19591461fa.42.1729697467383; Wed, 23 Oct 2024
 08:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017183140.43028-1-kuniyu@amazon.com> <20241017183140.43028-7-kuniyu@amazon.com>
In-Reply-To: <20241017183140.43028-7-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 17:30:55 +0200
Message-ID: <CANn89iLeWyA3sC7HZKjqWESmqmtgTS_hOv94ufyu_wRcxYZK8A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 6/9] phonet: Pass ifindex to fill_route().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 8:33=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will convert route_doit() to RCU.
>
> route_doit() will call rtm_phonet_notify() outside of RCU due
> to GFP_KERNEL, so dev will not be available in fill_route().
>
> Let's pass ifindex directly to fill_route().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

