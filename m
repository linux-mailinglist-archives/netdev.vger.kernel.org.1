Return-Path: <netdev+bounces-225545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF28B954CF
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B8E16F3DD
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E36320A34;
	Tue, 23 Sep 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK2s/708"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2EC3191B4
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620621; cv=none; b=p7J8I5wZcNI5l2ZHGPjhZssj2kEIlnaA4knLE6g2dc7FCrpACU0hNVniKvi5kQvjqhPJOb3DklXfY8XNXw4xM/N3zsU7KxziNwbBIMezUh4haCxv5wtr8U86ucXQRZ16gtvRbuoRdA5uLRBDmSTHWj03xCfHzNYpDf1a5hjrFA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620621; c=relaxed/simple;
	bh=dKfDpVh8msWTrDBDqVbzpowzdFUKTxgyJEtUcL8fbSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CT+MYiQt+CDmUR1dKE/seyepyrBBx3K3ssXP2rUOXwlfm8stXVWB4a25JFTsuPeTuOaJKCln5lQlZ93p9gabLv+nbW9FqkvZoWXpIwO35pj6qQpFA7HeyRpiMb7tKMEYC2bIvrPraXucy7/5B5PVe3kdfYWtQJULj0/wcdu/T94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK2s/708; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-425635acc4dso30131385ab.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758620618; x=1759225418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKfDpVh8msWTrDBDqVbzpowzdFUKTxgyJEtUcL8fbSE=;
        b=iK2s/708xYqenH2NntA5PUXTnxhZbTXpMfM2IPZ6mrE5SMn7CpBKDGK9VkrYFUQONo
         GX7rGpZ3M2TRkcES/9LMLADgM22kPhPpA9yb59Q0qs9HcH1GDDFCKT15tigAEWI3Ocs4
         L5GtwqvVnWC/S2ULRyp6Azn7YKGUhXhHXs5HoA8ECuph6m4rc3IdZmna5Csw8aJjHvlF
         4qIwsahEGPgiG0AGa76mjvM0gwGUnYoH9tQWL7Yjy0yCfyyg1WXAhX5IBjrgFfVBi8om
         l7wEVFAikpKz4CEmv/AggFyUpp6fz3Qhi8IUVDozNwBAq/aJagZgo0cuYgaV+cNERxwl
         nIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620618; x=1759225418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKfDpVh8msWTrDBDqVbzpowzdFUKTxgyJEtUcL8fbSE=;
        b=kgNAHH2e4epj1gDKe6fuftV2weBb/jubAyYkPniyevaJX7L/9jFIU4//LFD1WRI81B
         n26/raA8vZqSrdpd2g6b69c8BnW/tTQbucMA+qsn5F/McAz/m7i7WqglvKPTdBGfnLY7
         L9FnexTYzyXJqxxfRznxIZH21DHApVkz9RTPgTR8GWJwL7oED3myC5/MVLViA7q4KE1M
         FQxLtt3ZCMy7yiFTYFyVnTvbxYDi8Cbgo+SzXGl+I9JXwt6jXC3Q0fLg66XqYIxizGu0
         ZjmbOOYc9dZrKS7kA4sqitQiczBBkT9UJV1mMRMZbqbtCn4rznfeii33B5CwH4xp2s3v
         xssQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJxQyx2rgmAC3hr5wNhex94/sHMY7nnovI/J4P8IB6A5Li+xXjYy9sV8ng69dbrm/Irh2ZMqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJv6dF+UTo5Rkp0zy1biWHMeRBNT7qJgKl8KIdZebHfLWLeyP9
	XDMNzxkeowuekJtO/M2ErMXc0sfF0eMXDh7kYUjo1bFqbqmoJUmXHDgC3ZzvS4Hkp8LN5y/ecDi
	Gq5CWRXZxBgAAgxOF0kTqArTqeehTdDE=
X-Gm-Gg: ASbGncupHNNlq2SKt+8ujPpIgd145C8tuQa4JTLrW22HzJ75kCyThk1/6e7FQIwtnyq
	iSPcg5G+eyf5DHkMurw5XeRez9BwcWDIQRvFqSVw1eRRwso+uqsKLiuTqxPKK+Jyfpdr3hW/aN0
	ztn3OBWz722LGwx4RqF5Bsff4DtnlXLUaZLg8YIussyfqmfrh3RNHOme8nsquhV02EmMFdgz/yV
	3fMTMujvXlUXAWu
X-Google-Smtp-Source: AGHT+IEJuvK4J1SX0MKzHTVhKvppI7P86iWwYksJPuEQJKZwjbuR1NJa0z7QabxO9bYtMS/Pl21iu0WZ/ZWCuBkD5yw=
X-Received: by 2002:a05:6e02:1746:b0:424:ed48:9acd with SMTP id
 e9e14a558f8ab-42581e8edf5mr32642295ab.27.1758620618656; Tue, 23 Sep 2025
 02:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com> <20250922152600.2455136-4-maciej.fijalkowski@intel.com>
In-Reply-To: <20250922152600.2455136-4-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Sep 2025 17:43:02 +0800
X-Gm-Features: AS18NWCoaoaMEGSK7LyZmRiOJwp7u0shXihHAa4eyMNum036Kyajq7saiaMAhaM
Message-ID: <CAL+tcoBpMOUMfgjWesPJzrXCwuLMM-Sa_GeqjrLwie8=Bi8jtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] xsk: wrap generic metadata handling onto
 separate function
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 11:26=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> xsk_build_skb() has gone wild with its size and one of the things we can
> do about it is to pull out a branch that takes care of metadata handling
> and make it a separate function. Consider this as a good start of
> cleanup.
>
> No functional changes here.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

