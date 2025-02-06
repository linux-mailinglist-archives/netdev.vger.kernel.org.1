Return-Path: <netdev+bounces-163435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF6A2A3CC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC691642BE
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B959C225A48;
	Thu,  6 Feb 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkIIV9X2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932A225A36
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832562; cv=none; b=qhQg0VZvCeOLcQfUSYdbhehcNKdksqU13Kl0QpWD7TmVMUdHKK6HDWxMi94fyLjgQqFxgFOODWd+Jy92mCRdAe2+t/tJao+oWDjRkF5V7RkwYSPc/eYv7chFzETuqySG0Qx9fU0vbZ7VXhVeIYCN7CLcgfJ85EG9lVMhweVp0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832562; c=relaxed/simple;
	bh=Hp8D2UpUB8LSe0tS79Q/Ztz5i/h+c+LhDuD05ZQIBgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdEsAYJ1Urjs9jGFDR6EGc31b9zsin7Qt5DbbfiFjxXtK6pVv/aqTHjippCOU5gaSCwB+vHiSK3fQYWvmT+G5j+Dx1wAbOqVsrma8E5W+/FyjaaO/IeqA4XwX6NNUqpU2/kmHj1Eqi/f5uEGWoWk+khD2g0vwnYC/dCE8RLXEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RkIIV9X2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab76aa0e6fcso97433466b.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 01:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738832559; x=1739437359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWDgCRG2JISUlyz37zwRV9Om7+HpOA4ggCmMt2lDU/E=;
        b=RkIIV9X2gqDWG0Go/jFr3zuv/csRYXiv/AlmQryWQ6gg+MnDDjmwRtg/u/ttyCkJLA
         W4018SSnL55Jljqv9tybsgBjWpCxQNqye61RXIfYTfwVKh2CtnP3luSn3A2itzLd9KYS
         QbPvyH9DAyNbsRb59uAkMGs/1Wt4fe+p1z5H6kyiY6QeR6sSbrGbQoVz5el8FHQV2HWi
         UAOW+fsuBXQj1K/ZbJ41wETNMgtWbPwkcQvzdQU/MMVWMF6qZlzdDjKtD34LAb/v+gdY
         b1NAaLwGfQrcQuaqMoWnB21ResTPvfqGV439CT7b2Kri8RnZFY1WOP977k+WDdLk4Vti
         24nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738832559; x=1739437359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWDgCRG2JISUlyz37zwRV9Om7+HpOA4ggCmMt2lDU/E=;
        b=OGFvj5zs5VSwS9xO/B/A5Kux/WxUMoCXHWZouIqiSiKPV7UgS6tMRQlPml1IO5GIKH
         MQGdvzpes7xoNYvJX8xwoKF1RheESj0VyJ/h4R5as4AAQE5iYwShZASTWZ4FihlmdcMY
         dsTZ/uULT4VmmmBDr77cuMFc6NwmXsOlxVSTPgIV9AnmrESIexwUatzyELwUhP/Bj3hI
         kH5kkivXsk3WfYH4cLAuza3LzOPr74T1PU1GA2l5tYV8BxA+2jQ3ytJyzAWcfIfTVkZQ
         rDYNVKhyXiitbZjF3JqffuN1FlnnrprjnidUxUoGuZIRrsJ8fgkqoFeZtL2xW8ShCKkV
         SUHA==
X-Gm-Message-State: AOJu0YyhNbk9luPHvnEEM69xG02MwxlSCqOeGBRV4X8lbh5kL1pmKztv
	uoOKGo6bNWOo0DjOrKwrn7Mi/fmMN0ViONXQ6MtZT1p2cfWH+b2rhB8ydE5SlkQmX/RSp2F1j2h
	5SN2tdd6p4geGvFP/Zady4eBhan6LoGiQqrb/7DPbqPZsnciFEQ==
X-Gm-Gg: ASbGncvIrCHcgt+0KbDUUdLhbsKVYgOhG+DZwv3PTpy6CpDfVbSQVPv0x5cC7njq1+R
	XZLOd2gYDB78B3wl8bHYcJVxT/Mm8Ks7dC7ZFs4c+KxOVcUEWvisj+6wtO4T8IayCECYeVr32tA
	==
X-Google-Smtp-Source: AGHT+IGL+Wm1jNd7m+ybFuNU2jUmMjfKTuc0LP5Om5chV7UKr+Zgv5802SmwxpVwxz449nrAcik/ICqttWRD07CJYKs=
X-Received: by 2002:a05:6402:3205:b0:5dc:5ada:e0c7 with SMTP id
 4fb4d7f45d1cf-5dcdb762c7bmr16753959a12.26.1738832558911; Thu, 06 Feb 2025
 01:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205193751.297211-1-jdamato@fastly.com>
In-Reply-To: <20250205193751.297211-1-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Feb 2025 10:02:27 +0100
X-Gm-Features: AWEUYZlwJSqtqB-4OOyEFkAsstBoQxZIbRm3_DU4qBR6mr5PmsTTexdXeHatwjg
Message-ID: <CANn89iKgEd+T717kP=Bq7cSssr8ibh5t-+g6Ztybd+mkJFt8mg@mail.gmail.com>
Subject: Re: [PATCH net-next v4] netdev-genl: Elide napi_id when not present
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, sridhar.samudrala@intel.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Amritha Nambiar <amritha.nambiar@intel.com>, Mina Almasry <almasrymina@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 8:38=E2=80=AFPM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> There are at least two cases where napi_id may not present and the
> napi_id should be elided:
>
> 1. Queues could be created, but napi_enable may not have been called
>    yet. In this case, there may be a NAPI but it may not have an ID and
>    output of a napi_id should be elided.
>
> 2. TX-only NAPIs currently do not have NAPI IDs. If a TX queue happens
>    to be linked with a TX-only NAPI, elide the NAPI ID from the netlink
>    output as a NAPI ID of 0 is not useful for users.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

