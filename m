Return-Path: <netdev+bounces-208819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275BCB0D405
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62F73A66D0
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 07:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58C2BEFF3;
	Tue, 22 Jul 2025 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ci6IK1UI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DF228AAE7
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171071; cv=none; b=JZn9rbgRr7wW3osoWRp7E+J0JcvMFcY6BmJagLFUu7eeY6xoA42KvZ82aqiwzGB5kMKMJ0CpynOYHLRFszaSZ82p3sndwoGh02jhTiajSCEt4nmRMLtgMBzT5hKgpMa/EZh83Qv1c9pAbK9TLx5cxCRu3gMT7Iql7e6Ryi2uTgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171071; c=relaxed/simple;
	bh=YbX2SuCv9kohVPOE5H49XJHYjDUoiAEpAoIvflUwGZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJMNM51GCEKtWqwgDBdsV7S57/bEhxb3C665s/9mQsZEvVCvgp34ddYWRWTXtrQjyYohUcSMdBIXOGntByfGTAVmAMa3yeXrnkojxeA9jOO98be0JJo4a/P3R6pZPCGyGXBLMT4sB62ePfsraYcWaRu0sX7+J+ORhZYUNoVAuZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ci6IK1UI; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab3802455eso68013811cf.2
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 00:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753171069; x=1753775869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zq8b+Loz1K89tfD9iGwwhI73OX1oOOF1Fuc/hSZ/ALA=;
        b=Ci6IK1UIjTk/aDsHtwUS4W5dwvdOYATLoRlm8+cAzdeZrzbfvX/60v4EXBLhpzPbeQ
         oAcARMsdFIXTCXSWFgr9i3WRjuuTc2VUVKu3WcheQt0Ri8Xnf10/RjbRNKJAgffwU0Eq
         1P54CrVP5lF97BKALP+L50hHt/hAyWEJb4C7t+ctLTJK2QpUrBDZDgEsFw80NqtpaHc7
         h47WnAaOZFA8Jt2snyA2SDW5KoE4SzxTYDMSn0q5o3OMEsN/pB4vsNBV6K+oN7GAyu7K
         2StYFNvt0SPMiXX8WMD8cvyxxSd4vtuHb733XoXohmWDxJeBSfh4ojrMgDR0/xoaj/2h
         lIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171069; x=1753775869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zq8b+Loz1K89tfD9iGwwhI73OX1oOOF1Fuc/hSZ/ALA=;
        b=oRqhXJsYL91v2twDUJR/9ug3aDfCd3rHiTKFg55tvBg/zF2G+s/zAAN4BQ7yV7z3DT
         MWTMlNVoQNcFZJiCZEEWZIV1xHwMCouyr4pIzFRL7Jjn/GFlkzSPPapeVx2q3pXiZmb3
         IfQGhWa0vc6axhs1Rmoz8qFv6/+G82+bjG92Zdvj8LJCef7lEAkNtNz1Yjpab9zBGS8g
         tnp+YVjh25qoCNMDZBmJf+xn4hpq30tPwy3ON4c9/qkrugTO2dgdJgNHzMKC0ut6SMCx
         buCbuiRnlFnsiF4cRnVCVT8xsCShHPTy9UzQ/zFm+2T385eu+805sIWm73JBL9aHyVhM
         Gibw==
X-Forwarded-Encrypted: i=1; AJvYcCX9A+ywHluVoa1p0YOex3JO9sAVB7rPMupYYcoWkNi2lBf3xDEP4DuvcelPvji4Qy74Po/eBK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3iBSE3n8Q43ralOE/lzKleDSq0SK3AH8fnYGHGfwMsUehOo/j
	KVNRaVmNNdOOms0ymgCNHoswedEC7QAqeGqrmIiUZpKfk2Rrvb7zjWt36yDrbype9WW2YUg2vNQ
	WbVgzmKsNKbjLQzPiLPd5COGDFq5tUx+46gq6e4p6
X-Gm-Gg: ASbGncs6fCySzDCRko02JvrjkoAfIYk/7M4AEkK4qBo77dWt2DZq+9MfQ5eF2KlVU4+
	kw5yB8rx3Nr7dCkIUYfG2mo0WwpUsedJRPp8rqtW8ENkYJwwUvNbwE1Qy2B+bowkmNHeB6ccBAX
	uXGAjwdn/L5HbMUS/UkEIovhFQQnZyHx2WZKZJNHBhqCDWObpw7ou5Hpb6SoymIYZaDckNlmO18
	r6/pg==
X-Google-Smtp-Source: AGHT+IH5JT501c03HpS5tYWvBZUUIsqAWCnI0IFwDHukriQgcfTKFZ0Tt34HFIdkazhCLwFipSwNs+2WND7h/Ha9DQg=
X-Received: by 2002:ac8:57d3:0:b0:4ab:6d9a:5057 with SMTP id
 d75a77b69052e-4aba3e1a2dfmr272475181cf.42.1753171068870; Tue, 22 Jul 2025
 00:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722030727.1033487-1-skhawaja@google.com>
In-Reply-To: <20250722030727.1033487-1-skhawaja@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 00:57:37 -0700
X-Gm-Features: Ac12FXzEZJVoyvhHVY9U6eoQAoQQ_a98L48Gbwd-LiPKHEQRQSQLlRhZbMY09WU
Message-ID: <CANn89iLB8=8NdjD2TPd_Tt22q-z1zBfgY=Spm5K1n1+M93HF+A@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/3] net: Create separate gro_flush_normal function
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 8:07=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> Move multiple copies of same code snippet doing `gro_flush` and
> `gro_normal_list` into separate helper function.
>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>
> v6:
>  - gro_flush_helper renamed to gro_flush_normal and moved to gro.h. Also
>    used it in kernel/bpf/cpumap.c
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

