Return-Path: <netdev+bounces-185702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78883A9B6B2
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A921BA0AF1
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A0028F50B;
	Thu, 24 Apr 2025 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ylzR3I28"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549591F3BBE
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520571; cv=none; b=XQ/bdKgae4sRK7qU5qcU33VZXlI/Sj2Q5o7U3x/mxRZmipIi7Zm+mmBcHtStnal6dwV+3S9u44Hllka6KNLTykW94GE99vSK7CbiCcuR6/e7ZaztKJ0xQ9J/135B7yr+rnPlA++8t6kSImKVwQ1cQTlum/E05niRFvCUagdFRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520571; c=relaxed/simple;
	bh=YJThV8OU+yLTh48RfiUdm+OTToDHsoL5U/oCrdFEqDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBOaEcWCAhZd+9osiz235Da4BwYzd3FAeLCthz1HfOqzpcVY+HJbGobo57hKxE+nCXhwru7MmP1h2pD7rSN4kiHft5CICfSaPnCOFYic5MI7QmV8BBdE8GmU3hHE8MPIkueAqaVWddXpXB+9vRFCRQIMBcqcVKWD9vhu4J4ZlCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ylzR3I28; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2242ac37caeso17385ad.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745520569; x=1746125369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJThV8OU+yLTh48RfiUdm+OTToDHsoL5U/oCrdFEqDQ=;
        b=ylzR3I28/yHFuETRVx8TQjGviT85wGYNO9xhZfMuqph6DIlhaSNwaWlvkbtPK+qs6B
         ElMVBnjACjOFiHTrBVLwYd0Ca2Bvc55SIR11MRMKQdqC8pWDQ02LcBDNfeiyTRnZ5NNU
         VMrctS6S7a6mrVAt0zxIvDmckXP/ME542w8bOGeXP/yi/f+pdH6jDv3F/FZqfds1HJIy
         CmMS680r1gfHpGVYwT3Dpz2TINkurECqb7m/VPrDGvlHQ8N/F80q96LKwbu+ATbjBkLf
         pAIcJXHi1I9IhYCmVJiTMIOvpxgVkg4KgEzzvZCM1nspYuccVgdk/hS2G9SO+thvSb9j
         Wi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745520569; x=1746125369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJThV8OU+yLTh48RfiUdm+OTToDHsoL5U/oCrdFEqDQ=;
        b=FKK9aoe7903xbj/Kbcyrx6seCjNagrQBO+vj2IBsapi5UZ61XcX0EVENvhKFSlrJbF
         VQ9IiMEpnzMaH26FOR7kq61zuE5fhoKZJTLUocT5HgTghJig6zhXLvAdOtqZK7R1P2y/
         xyQ13KuggcW3g4jIU0F1mDfIFfEw/7uYwiC+0Zil0AVN5L9diFuK7NUJ8zQ/alLKYq9Y
         Mya7nU4lWIF4Iuqd9+slzYq/Ei59/aLZP9DHPq6B3eSIEQzT9qMeCb8UTJbDzxwMjwcE
         Wu0TKAd8RXf399QdH1D7YRUfeFTASuBfRXw2uyyqV/1orUbiM/VHQFywOgvbXmk2CCaz
         qfBg==
X-Gm-Message-State: AOJu0YwdDuorWG65QWLSs+7prTvnCw2rbPA4Vu1MOHKbUGC1aFpZ8949
	hEIMuhq47WGp0msZNPDaJ+0688RdJ05WCZMq7AATacaB9LD3PWBmIxWh81xOV/RaMla3rwtuEdr
	iwWnQ6EuAM+x2Nk1SD7x8DNSR3/IauEWKtnVdmkcXng31aDssebFx
X-Gm-Gg: ASbGnct4jyM557nZVgO7hxLWU2H043WA0akDqnjtF/zqvSQvzrwVj6L7UIfNmgGAVyJ
	a1/rnDmwMi52qQXdTeGxRmX4JQiVLKg/nH1RfFrbbX89lySr2WmAOtEx8/VJFyXhhywIrj3Oa9z
	NvC61VrffnGSumCrUiMhnnvq2a4zPbzwhsk632KNBAA3J+kHxF3rmf
X-Google-Smtp-Source: AGHT+IG7TvFiypkSdm6cFL8QXv7Geze56CiuyUqiMCDjIy5B3tjxrLsMvkElYIkhtHnXIN1qIRY0zGBcPAIono1A5h0=
X-Received: by 2002:a17:903:2053:b0:220:ce33:6385 with SMTP id
 d9443c01a7336-22dbdb49fd4mr181535ad.9.1745520568724; Thu, 24 Apr 2025
 11:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424040301.2480876-1-almasrymina@google.com>
In-Reply-To: <20250424040301.2480876-1-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 24 Apr 2025 11:49:16 -0700
X-Gm-Features: ATxdqUGSuXy2A5TP0CkyPakNQ5S2ontOlQJJboyrRu9J3Ao5kJdPZ2OrP3y4P5Q
Message-ID: <CAHS8izOT38_nGbPnvxaqxV-y-dUcUkqEEjfSAutd0oqsYrB4RQ@mail.gmail.com>
Subject: Re: [PATCH net-next v11 0/8] Device memory TCP TX
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 9:03=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> v11: https://lore.kernel.org/netdev/20250423031117.907681-1-almasrymina@g=
oogle.com/
>
> Addressed a couple of nits and collected Acked-by from Harshitha
> (thanks!)
>

Hello,

I made a slight mistake sending this iteration and accidentally
dropped patch 9, which contains the selftest. There is nothing wrong
with the selftest in this iteration, I just accidentally cropped the
series 1 patch too early.

I'll repost after the cooldown, and if this happens to get merged I'll
just send the selftest as a follow up patch, it's an independent
change anyway.

--=20
Thanks,
Mina

