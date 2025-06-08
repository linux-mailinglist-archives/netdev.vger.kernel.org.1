Return-Path: <netdev+bounces-195565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EAFAD1321
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 17:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B252188A986
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 15:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBAF188006;
	Sun,  8 Jun 2025 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGvJFoK9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D837081A
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749398247; cv=none; b=M+77YqssrUM5JfxrgNdrY6eN2cNgQNcV7oLyiZRh8RTNNb3yNJWtlCZpmDj81A/bqfELHGNQ8AhZDBxvYIqFhLMZBCvn9jGsdsCGJ9Qg+AYFic937Ax+hi+rSXbyBmsp2t/vSxuvN03ErtJGOXsAeOfsZEow8ALtucJSporR4AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749398247; c=relaxed/simple;
	bh=ohdeAPDZDhDZZcG1b54Sh+o8d02OBfJCZfALWp9FB6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeddLrO4SL7gxWVYVsNTm1B1vgza1BAxqj0AhLrqfsVzfQr/XzhQn2IlBXrdgEJCI9I17G/fz/blVpvJUKFA78TGc4pByaeN5QVdXWyiZSD2tpZKVB1t3eIpbUDKe8UzM+qWKkY4ndlufA16LvimPxZ1aZ9djhe6iSKEYntktPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGvJFoK9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749398244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohdeAPDZDhDZZcG1b54Sh+o8d02OBfJCZfALWp9FB6Y=;
	b=IGvJFoK9buaWxQeSNAkqyE3rUtORYEnTgX8ivKLive29ba22Xshx0tSTvGslbjssBmA1LG
	B5e5jikfzRUaLfqYvVb0uFiq73Re/L3PPj0wxnijGKbkEzFISzvvDSTBCEmLi+oRhQi1eH
	AcaY9hgQ7w5ExIi7Nbwnvy1oLNnpwuw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-Xa9OtPpHOKiRlN0Q1SUlRg-1; Sun, 08 Jun 2025 11:57:23 -0400
X-MC-Unique: Xa9OtPpHOKiRlN0Q1SUlRg-1
X-Mimecast-MFC-AGG-ID: Xa9OtPpHOKiRlN0Q1SUlRg_1749398242
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32a8058e48dso15964591fa.2
        for <netdev@vger.kernel.org>; Sun, 08 Jun 2025 08:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749398241; x=1750003041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohdeAPDZDhDZZcG1b54Sh+o8d02OBfJCZfALWp9FB6Y=;
        b=jkdGNKxQKvOPTNAbXZHUQ4wc73qjDe3x79VUVGhWUUzZBFdOcT7YxIEBJ9wTj2OK6F
         MEM+Btuqhx8kFNgppMWXDlyAjcS3wlAOQa/nV4eGMJKsBLEAHgk1BIlhEtdxGT+/XuzQ
         WzW93iNlGN81XbszjVdI+ZED6N/UR79QrV82ESCVs7gRqWkdWsFBfemU06h/vU2yDwos
         7zt15OGkV+jXS2eWGtwJcskv/kL8xKIcihzkjkkEbMqb6oR2IOjM6GkDbjcCCK23aMN7
         5IWoixGDkwvdCqbeZA2aV/1QwHGLAYotXiFjKTXVytqNpxZ5zS/5WQOO05uHY2cQVokT
         WbTg==
X-Forwarded-Encrypted: i=1; AJvYcCUhXPVuXJwYdkaCpwlngNFp8VLGLvWPO4CjuP/d2dDIlNE1Gx50btkZtu2ZNTgYT9Omjoe2SDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCPUUdC3pRsJiyCtPuJzN/S3KXrrNR6fnoMIxP/6lc4T6tckK3
	2lYAVGKrGIH8F+j3/bBPaCrc8FoIgzOI1Fz3BBSKUEHO54n+YW7wJfuf8uY+Ja6jb0vdL7YddVC
	Qgy7REvjAo1IOqmYtRB7v2iovuPBRUbfj1+jWmetxi7IdZfuZRtg1qhRtb+6fVh7HLTpn2CGSGd
	H0wpGMKm2npXH9BdjOOg3dqSwUi10WVrph
X-Gm-Gg: ASbGnctOzGqpcRSQDiX1xDijtKWMJODKB0pFf9B7z5HSb3U8y7oA+Lb+Hn72QRexEPd
	+kolQGWV0omkfhEyOrTizW8OuDm5jizva5Ls3nSEwLT0KyZbQghpKRjNDu0H7Ftft48fsemrqmL
	026vt3W8xtrnbr/d/PZm4dHQ0x+kDW+DNbzf46
X-Received: by 2002:a05:651c:2125:b0:32a:88db:f257 with SMTP id 38308e7fff4ca-32adfc0cc63mr22376211fa.31.1749398241438;
        Sun, 08 Jun 2025 08:57:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ92pDCTQGVUd+R73ZAPBWMpMSpFvxZRdi0lJDDTAwdZD7T6D5c+yJ74WYS4BOrdyFNAyTdhpXWCX1bHQi7kE=
X-Received: by 2002:a05:651c:2125:b0:32a:88db:f257 with SMTP id
 38308e7fff4ca-32adfc0cc63mr22376121fa.31.1749398241033; Sun, 08 Jun 2025
 08:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603183321.18151-1-ramonreisfontes@gmail.com>
 <CAK-6q+i1BAtsYbMHMBfYK89HfiyQbXONjivt51GDA_ihhe4-oA@mail.gmail.com>
 <CAK8U23YF53F0-zMbq5mk2kY4nkS1L0NH9j-UJrdaS5VUZ5JZdA@mail.gmail.com>
 <54980160-6e46-4ac4-b87f-41b7dccba1d3@lunn.ch> <CAK8U23aRrvC4wC6WvcBRPA4YuyC1MPvOj8FO=cWfi43_Fdh4Zw@mail.gmail.com>
In-Reply-To: <CAK8U23aRrvC4wC6WvcBRPA4YuyC1MPvOj8FO=cWfi43_Fdh4Zw@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 8 Jun 2025 11:57:09 -0400
X-Gm-Features: AX0GCFsqG832Kq3kP_9JJ4OsbpseJv4f7JiSDEeHcFGaDfX1uUo8TfC0qw-LJHM
Message-ID: <CAK-6q+hO7byb-MRSd1U64-CMLrjrDdHfV5WLjK4dscCgxFSMOA@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: allow users to specify the number of
 simulated radios dinamically instead of the previously hardcoded value of 2
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 7, 2025 at 5:42=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmail.=
com> wrote:
>
> Ok! Just a last question:
>
> Shouldn't we define a maximum number of supported radios when using
> unsigned? A value like -1 would wrap around and result in thousands of
> radios, right?
> That said, wouldn't it be simpler and safer to just use int instead?

there is no limitation to add some during runtime. It requires root
permissions and you need to know what you are doing when you are root.

- Alex


