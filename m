Return-Path: <netdev+bounces-239366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B56C67397
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51B4535F0E3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DBD24CEEA;
	Tue, 18 Nov 2025 04:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="snUCSIf6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6371862A
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763439243; cv=none; b=nH6rj7ozqqOEJwAMyDRz1bNVpXhFsaW4ImTQfCyK2Oh0ezAWOaQpbTjuGPzU/cb91RA6+3pt+aEH55GuXO8n/Mhj77DBmCOgNM2W5nrClrMMs+oqSwHgqXbXf4zbPFG8ytYYBLO9IDzZwj/pVzEdGU9nBgl1x04NL865yDk+R9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763439243; c=relaxed/simple;
	bh=TSePkeDOc/Y9du4y3iEd2xrogMsBFLjQs6hETvgW9cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxuJWWBXmK0K78K8qPbIG1p6tpSp8YrTqf79E26fEUNxFEoJMZFSiix5XXgvx03x77xL3kzng0VXAZy8+57EKsH5WngrwaAb9zjj7VJ5Nan7Q+yB651z1LHhzyYCpfUcpD+H7/0mod2ZrMPE5RfCipGZiyCl/t5QklvU7iRjRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=snUCSIf6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso1094619b3a.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 20:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763439241; x=1764044041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSePkeDOc/Y9du4y3iEd2xrogMsBFLjQs6hETvgW9cA=;
        b=snUCSIf6P5nvU204h1bN9AZnm9ltJbs/9iqi0Kpd4EZFUJf/WLLV4POjLR+DwsZuc5
         PDZs9VXIrhuyHvill/Sft4ozGZOHTjNRx+8dJgHUgK+luW7XqhZcfOvGY18piLdDvIyq
         fP3HXCKzwHbKCJ1TMC3Nuo56TUIylJxvKx46HaOHSSlHG28qYTIHIVMLKeh5oIBRD2up
         fXtdaM37TgbLqLOuUr20p8LeCJGxa7zw2Ij3YFySZqa3q01upxp7lTdN2j4gIqaPtjBb
         0LfN4rOJpyueUzgn0ww3LjMZYxYbJKAmn80x7fqc0AtZWVn4K1C6MgV0zNvk8hbHKuSd
         tJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763439241; x=1764044041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TSePkeDOc/Y9du4y3iEd2xrogMsBFLjQs6hETvgW9cA=;
        b=On/hDxj5Jdls4ZmqVVV0FMWrN5dNs0vTIWAVN/peZVLCcTcxO9uEEf/ezKhLPrDzqr
         4ZRn2XnABu9fJ29RhEBQ+ApPm6HOnEKzYaU7AjLuF4DoOB7lykX9v+rLRjErG3z3A656
         9QgBZvwj0ZO+rsptZtkcOiRzM1P3IUcUiL1vXRQCxLo9wVegrgYS28s/ARr6o5HTsRBZ
         NqOTODJ2oaAX90LYagXxXT0nds4uZlggbE+x4lB2TPiaxccWsoUk/yOD7yDWAC/WKo2e
         RzmPInLIrwUaqU07T6rWlvE5BPLbyMOh1TPtAoeP5d/vyFXdTdab3ZpS8+Ji0eVafKIA
         HOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK7b1vW3XTYDTVnZ7+5kuZHBCXeKD46HDy3ISx2efHOHLzb42aYQ6VE1wQdLpNiplAESf+iDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0RYq88wbJN0bZS22zvD7JtQzht+UpGxdJur2Hq7S8VWTjBUTK
	9WCvVuf2Ap8C8bK2yAhZ4qVl9RhL7l/eUd/aoJQKItQdSj/W7fbTGA8BgstDt9BY72F2F6zkKfZ
	ZxxXBItLML85oy1AEtmNbLwdmVtBKgccnUQ0ZoxZJ
X-Gm-Gg: ASbGnctt1ASjsmYdwjrcOqJ45BMfWrZEvOSNS7yTRHESW8TgjhM177cw5/wloXb9N/P
	PcFyTw4pPvUU/8VaRED0KZVHUUriD9089RA6xOfjVz6ae1Lf00kKZ3fftRMguaeCLCfcWNpIrSJ
	ViF6HYpNqcASFHPkoatuvg3FqnYdjl5wh2ny2+QaHcwCiS9AWeUygErnnX08WXv7heKdf43FanP
	wxQNB7kWsKsBvXeCaO9Zbo3gKOjnJj/Julmx3Ja5KySKQaqleR6zl0IIIh0uKRi8nEIdv1nMvFL
	ByTRkEY2OHJCxmvKjJm00p0jhHGPIAiFM/R+yg==
X-Google-Smtp-Source: AGHT+IHAojc1Y7Edx2fuMDf47cTUfKxTJG20H6X4e9vREzZE3VTuGgWC4i5Ntnt3q4xoSNfLFSaTn3S5xO0LsKGZTBU=
X-Received: by 2002:a05:7022:7e81:b0:11b:9386:7ed3 with SMTP id
 a92af1059eb24-11b93868327mr4593655c88.48.1763439241153; Mon, 17 Nov 2025
 20:14:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117132802.2083206-1-edumazet@google.com> <20251117132802.2083206-2-edumazet@google.com>
In-Reply-To: <20251117132802.2083206-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 17 Nov 2025 20:13:49 -0800
X-Gm-Features: AWmQ_bl_2P-f1VZJwpwfTxbtkcccD93md2Iz9x_BjJmfPBjbU_G-6vrYOJVQXT0
Message-ID: <CAAVpQUCb4a-QK7nB=jiYk+dzsfvdpCAq++hy6-cQHyTXAohmPg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: tcp_moderate_rcvbuf is only used in rx path
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 5:28=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> sysctl_tcp_moderate_rcvbuf is only used from tcp_rcvbuf_grow().
>
> Move it to netns_ipv4_read_rx group.
>
> Remove various CACHELINE_ASSERT_GROUP_SIZE() from netns_ipv4_struct_check=
(),
> as they have no real benefit but cause pain for all changes.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

