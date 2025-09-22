Return-Path: <netdev+bounces-225259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E3B91457
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 14:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A7E18831FC
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E88D3064A0;
	Mon, 22 Sep 2025 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJgPFMeP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A122F39BC
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545934; cv=none; b=cFa8+ujc2/EOhkQCFAeKqZwc48BPhhkjAERGBE7V36hFgwHSvvAdvA0U5gHI8C4/Ayeg8ANHUNG55GeIcMSc/0XYkD2S6OncfmGasMFVS/0icUs3n21IFspBFv6HvJEohZCSTXcNIR7SYIo8ROa81+264NsHD9nOqM+VI8r+GiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545934; c=relaxed/simple;
	bh=4sTHJW8uoJ/XDGnhcQJZhS/2F1821sf8P+/LxbVBGnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERNX6z5yNn76mVc4xIeZUScxbzKh0WPovEuxm45/AF94vlLfiulqTk2coX/FU46e1R0CK2cVN2YbuiuiFBMRnul6Jx8vCSEsjcVQoDsencwt1xb0S9qtPvyFgfxKnk8qAhgIGHru+kyro1f2aNlze5Qfz4AnWx23oAiaYp9T72I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJgPFMeP; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4c7de9cc647so14169521cf.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758545931; x=1759150731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sTHJW8uoJ/XDGnhcQJZhS/2F1821sf8P+/LxbVBGnY=;
        b=hJgPFMePw3VkwzDfiCDutzJl05hYhQOSA4BOzCdK629fYPGKo/WlGwRTG4yw+A1961
         qop0D6HFx4Spx4vQtizFf53GQtj8o756Uqo+uEtJSoqehqnz/BtWnuD+4eKnnlmUPh5Y
         SHb2/9SqU78RGh+bMyaIpB9+i7fYegW+HDl+f15lV8HZzQCiuT7jDCPxiyKQt8uAh6dx
         DI/VZ4ZXTyuSooI1fLntihGa4gFArNW0pwkpgFwGe9k6CjNmWryG9jcxoPo2gzF26iCR
         ejljIJe5kCkXiYrpMbzK7wN/YlPK9fipJ5Btncg4Jn/o0VQhjXXet6W3+piRM+a+AUN7
         AN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758545931; x=1759150731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sTHJW8uoJ/XDGnhcQJZhS/2F1821sf8P+/LxbVBGnY=;
        b=PDYC/sRU+5bcOznT3eZ5523B0TT+YMX3BmjSWlDoZCULw+UYwf2VIhL4ksubRaHUXi
         cwT1j2jzSYecu2MDFPKz4SYOu3petpaPakmgt+g0rIX75qdSLHSl0MsqjGEmHFQ3f3+M
         qxU9x/m0nI1aL5GhU1Ee38RKEU78qEHMea2FlsWN3iJ4Sspmxlzf4DmvQLjL1KksB/PK
         SGh8XnGZ5oDkHLZ2HBGzOSfe/9duVmV8n+GYLOL55kLNLwb1nnFS5wAra0gUG/RhuD8L
         f+8cGXG9nYPsyO9/9e/3vLfkGudidhocjSNECaYD4HSnfXcMvK9QC6W0mpdAqZLE/MEr
         Hpow==
X-Forwarded-Encrypted: i=1; AJvYcCUWFWP3d9pyT4IKQ/te9ExIR1B0u1/deGBjenL4ddG3AYGDJJkB92wOPio5L7Az90qkjJatxWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDFri+VblkgJH8Gb0OH2cpfwil3dCs07JPk5InU+T9nLPQFKn
	wselsDpJeV77l93CabYv7JRPku4EI5KxWguffTl68wp3wHA/jb6f2w5UJt7yvekK2GkWUib8lW7
	aZzzAODqsMeZyGhy6Zxm+vgeVKlHW8YR9IRt332E6
X-Gm-Gg: ASbGncvAXKUCZe/v2OiB6rhQmAgM3OetPR7wTWpXdJ1VbrRBiAeIh5ntN9/A0nVncEH
	//BeIaa40Op4oaEGZIil9vqCWo1g/alPNY6fDSQt9Ri2EViTKBsHhInrtcCheLfGmw6MEXmElX7
	d+NhLsKsKv6GEbFBST3H6J9cxg0s3MqdWJ3T/Velh0wkt5kiTxZnAUHsh+QBaM2rA8kejTUH459
	MCrOcM=
X-Google-Smtp-Source: AGHT+IEIG8luC1FdBUxlTrBzsBm0tINQbCr9tsbBSGvx8EzgyZ3o+Ns7VkwAO+5f4a8iHBt0byiwTOiBN3ua0v2evUA=
X-Received: by 2002:a05:622a:5445:b0:4b5:fa2e:380f with SMTP id
 d75a77b69052e-4c2214c50d1mr83971321cf.27.1758545931052; Mon, 22 Sep 2025
 05:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921095802.875191-1-edumazet@google.com> <willemdebruijn.kernel.1fae2e81b156b@gmail.com>
 <CANn89iKzgg9fFJdmEZcJkvc7Q1d-R=ZyrOc+E9zdA7LXaTd8Jg@mail.gmail.com> <willemdebruijn.kernel.16b82d42e11ef@gmail.com>
In-Reply-To: <willemdebruijn.kernel.16b82d42e11ef@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Sep 2025 05:58:39 -0700
X-Gm-Features: AS18NWAs7ODw6uYhT_oSJyPg1gOzFyikTZ7Drg2QziGU__HaqtD13tvTCxqjUqU
Message-ID: <CANn89iLqjm6UE+VkHW9P1X3nSpU9Aih+BYVrrfnQYnC-VHnUkw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] udp: remove busylock and add per NUMA queues
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 5:38=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Of course. Thanks. Nice lockless multi-producer multi-consumer struct.
> I had not seen it before. A try_cmpxchg and xchg pair, but on an
> uncontended NUMA local cacheline in the normal case.

I have played with a similar strategy for skb_attempt_defer_free(), I
am still polishing a series.

For some reason, spin_lock() on recent platforms is extremely expensive,
when false sharing is occurring.

