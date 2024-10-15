Return-Path: <netdev+bounces-135475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBAD99E0CE
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E841C21BE9
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD90E1C9ED5;
	Tue, 15 Oct 2024 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXS5pQbn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B201AC887
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980349; cv=none; b=P0s+kHGLgcPd7m5EVoiF4Q5ybB8WJdiDWKdY3sfnhXvlpaUt0YYOHTmE+EH5+7IIzs5NWHevU5xLmbsIfHeSRRsSnjgnO2IcwpVMg/A0EoIfCP1/BN9rcGAbh2P3578r4XRgeLRRRpc21fGNKC3J73dkfZLU++9kNVv/3sYHneM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980349; c=relaxed/simple;
	bh=36Vb0vpil/W1GB9wbmMtavb0r0T9tdrzR8pFMEvtzXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmyQcDGKuOan0HQ1lNJ950i+LEhu/ZD5EwmqVTP3K8gav22esIF8NBXhQFSr3XuawB5y+0id2aux4bHs+ZGqkx3Htgak8z52Vzz7bLw52c/zYGMS6YuaP9JflxXLwnHG3r+oKYcaJ1EPLTtPX4uV1lFHTeA6haXDTkIRCSC973U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BXS5pQbn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso6715056a12.2
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728980346; x=1729585146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36Vb0vpil/W1GB9wbmMtavb0r0T9tdrzR8pFMEvtzXw=;
        b=BXS5pQbnwgX1iqERnIGwFXQh8gCSNfflBx0FEmpwakpgSw7cGa3rUfTODqrfEy2RH8
         jsPHAlTIo1KPfLim2DNxg8to1G7PdXZ9uR2biJjQ5HUYr6jHAysYuZNVY/lqaBBJEH6k
         356935f6qs0cXGu2o3e8NObG2bekd/3YXCEts4rR/O7Y/+VbaWFXnDDPdQHSBnQLB2W9
         SFeCoXscH5wWwIkwabvNskQSJ5UQRQ3zwNXdpIqpBqMKIDMTat1rqLXTrphfXqstsbDn
         vgwj6oFLF2IRvUUAzJdTbj7ngi/43p9iu4mZo1aKcWdwspCJEj6IwJLkfwqsvXjGwoJc
         noqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980346; x=1729585146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36Vb0vpil/W1GB9wbmMtavb0r0T9tdrzR8pFMEvtzXw=;
        b=KsW+ZmGS2GijDiTlxLpwLZjcaMf5SXyyG60UEkwUI5p1ZjOOusoAT4qiXNlLhr8GGp
         ZyRb4X+ULq9CfLScajnvS5UCqbwe4LrEkoKMbXEqVPrcuDeUiuZSKzxnUpk2Q7DTP5AV
         UHRx+1V1WlW8EQxV36izV1pWJJefdT9mnQpAymXRIchcAS1MN38cA8KgEK+lYYQ2dy2C
         iE6IgFdSoI0Bv3TLgs/nyswEtM59G5s4w8vcpytfyN0HrE9MkoWfXLm7BGdFy1lKj/3G
         RbeNJKHOOkSIcoQLvW3o+uzvouN63MOh6BU64GhcvBRlWSW/MKZ/TL+pvGqsjz+5cIBP
         DX0w==
X-Forwarded-Encrypted: i=1; AJvYcCVp72uKG29KJXQ4vyYu8l6bcXctUbGa0hUmd3NhG0u8aYbtLOGU1gHFyeuDDo2GhE/4P6PDPRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxStXhBmKpmugSivu+2ihAT9uuUIh56KtjfnUhM2R5Btd8WzTXE
	TOS1V+eIEbAuODx8hlK2E7XE3T5ApIQus+YEv4voIObU8WOKjc0ki8qcDimulmB37flwOlGO1vY
	25Un6MQUjn0hLR8TF8BPtKq18NU5iNVP0gRwx
X-Google-Smtp-Source: AGHT+IHADN5dwSmG0g+5Pkc5Qa/YKxgfwpzwEulr95hVJlfLpoVkvx2e8qSZXLd7exkY00AkOFcowpjF3M6fi2+mZs4=
X-Received: by 2002:a05:6402:40c3:b0:5c8:9e36:ccaf with SMTP id
 4fb4d7f45d1cf-5c95ac506famr6552322a12.33.1728980346156; Tue, 15 Oct 2024
 01:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014201828.91221-1-kuniyu@amazon.com> <20241014201828.91221-8-kuniyu@amazon.com>
In-Reply-To: <20241014201828.91221-8-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:18:53 +0200
Message-ID: <CANn89iJH2huEOznHbxwzhzObK2e4U5TP1VjtP9ROQ7FC+VuKng@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 07/11] ipv6: Use rtnl_register_many().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:20=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> We will remove rtnl_register_module() in favour of rtnl_register_many().
>
> rtnl_register_many() will unwind the previous successful registrations
> on failure and simplify module error handling.
>
> Let's use rtnl_register_many() instead.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

