Return-Path: <netdev+bounces-225431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EE2B939A7
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4BF18857DC
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CADB277C8F;
	Mon, 22 Sep 2025 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DohfEkMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2AD25A642
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584181; cv=none; b=kUJjCz7+uHyQVuHy9RQNi/yMskMk41NWjP13stTmNbWc2swv9mOMeVXQGaiv29Ea81yGVaV4YZznmIJuHo/Web/+mu5py/T9d4ZUHo7+NbLBkYm582ujfod8bXi0KuiSPRJznLOKR9TGvYq1OpOAxa1reA+8j/1Ldi3BrTLbqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584181; c=relaxed/simple;
	bh=eQmNjNFXvG01rea8MnysvA0/424nxxb3t7fR9Ohh28I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPQuwgqp8nS8cB3wfsbho+Vw8Q/iHL1ZYoNe+nu7bWYBB4yi1ULlqGrJqT49Pi5gxPqdgQqaqBD1msxFYorq0aE53kqKFHXFJ+TiCkpIcZltrbHPeZWDpX9VHxH8A0qoBrjxcJZwbwBtieBhJAIlFgHuH/+nhKIrdyd4W6yZ1Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DohfEkMG; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso763168a12.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758584179; x=1759188979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQmNjNFXvG01rea8MnysvA0/424nxxb3t7fR9Ohh28I=;
        b=DohfEkMGuMuZyB3oR2roYR41VojpLLDLqiRkVlxhDJRwO6fwvu4IbzfPs3dwl5GLSZ
         /h8DAH9+j3PFJuLOUnjQ3QjYjWoXK1ugoBDsB6eS7EIcCsqzxBMSy4lvk3U1mp/3XXXS
         skKJZe+LykjxjFw7+pt0YKQ9LXA20h17m+ybW8yi1XnPw+cStT1O5VdeXA2xMRwn8I38
         O6TSp5s6QFpuU1d0OjOAaAGRnhcHzCpSRtBZ23qTT8M3Kfz7d1cbmNjFEUpQM4xceGSc
         D7B/hVv6uHRif9hlgWzudP1X18c83PUmplUWAokQHmDhx/ceICcknnWAQw5Krk3VfX63
         V+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584179; x=1759188979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQmNjNFXvG01rea8MnysvA0/424nxxb3t7fR9Ohh28I=;
        b=uN4dbpUbgJ5I8CHc6fRmVJJxH9g1LCsYiBJwmNSGvlqbjlNB0odrPICYIB/a3kNDxH
         +DL5yntRwk+TR9K649jY7U4uF2xN7678cLC89+MMR8qNjFjk/RZHR46vKJMtQC4S1fbi
         XIFETcytI5ucrys1QDFSjoh7Gm66d2ZFxDW6Dc/w0kYf9GQcR73SySgJ5zulDm0a6PDE
         4VT7Vp8Mq2FhCXpDLtIah3Gqsq3DnLAKQPaINtfXSZh++HIJpCwmKYV0ykhjssN/T0qb
         dBhaassTHE1ZusmIepMIrZIhWG1EWh57yOS/zFIfxr8te8PM7fNrT1A67LInTSrZOfaM
         I5Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXGqkRz6xEMYrHgRUGij+8ay9/H2jMXxZGrpJEHDkjYvpKP4Pm7SeVOBAU1P6rJMl8hgaDcpxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD+tKCgy3qpuVuXVRB75o6lIk1QiktOOWP+w+9WNT21C5RMOG6
	jKpsOFcpDx4sqGJQ/9bma7uBq4O8Ely2/oROCr5V/4DktMWeLNoiGOK4tfAAwhPeCV2ExXZ46wY
	vU1U6Fo0xvW1m2O2Mm5IBE5sWlQIxjHsg4EQzTiAahVzc2/Vb1N/X7SaDM64=
X-Gm-Gg: ASbGncuVehIn8s50sYY1GjaZqly7WHjzyRegNYbz03skzJTw56fbfym3i+x7JUnj2pe
	BOajyFmixIPe71GehF8FL8QHs4eELnCrxxcr2VNqPBIU5f785+asVv0ZXzbby1HcF3vep9oXPvy
	2oeO1LzKUizLBzYV0NZrE6b+YrwrYRSZw1kOzgTFPqlZgxo9lJJ8bXDXwnPV358lcyPRd22RUwU
	isbQ8cNyhFXEn+7mRb5w/0+U3ER0qUXReTClA==
X-Google-Smtp-Source: AGHT+IFPW7lOMgzyQPp046NtljFqsNUoWqpI9Zpa5IRxMXYc7kiK/riWlNY9mVr/JdK1vWc63b8oUvHUDRve65XJmEM=
X-Received: by 2002:a17:90b:48d1:b0:32e:c649:e583 with SMTP id
 98e67ed59e1d1-332a95e9184mr641035a91.22.1758584178659; Mon, 22 Sep 2025
 16:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com> <20250919204856.2977245-3-edumazet@google.com>
In-Reply-To: <20250919204856.2977245-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 16:36:07 -0700
X-Gm-Features: AS18NWAukwzMXWayBAjfxEgcQEiipowjOGE_eCbdIkdRbJiJ_3TVx3jnJb8O8OU
Message-ID: <CAAVpQUBvKFLNc9DHMikByVzFVc9bp_AHw5rpEnZre5-69sL_4w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/8] net: move sk->sk_err_soft and sk->sk_sndbuf
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> sk->sk_sndbuf is read-mostly in tx path, so move it from
> sock_write_tx group to more appropriate sock_read_tx.
>
> sk->sk_err_soft was not identified previously, but
> is used from tcp_ack().
>
> Move it to sock_write_tx group for better cache locality.
>
> Also change tcp_ack() to clear sk->sk_err_soft only if needed.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

