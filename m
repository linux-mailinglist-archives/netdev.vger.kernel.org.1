Return-Path: <netdev+bounces-78389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFEF874D9D
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 12:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED31B23AAA
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC5512A156;
	Thu,  7 Mar 2024 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBRou20e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488101292C0
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811414; cv=none; b=eopxMtu0WVejBwQBQ6oXz9JCWhNlcv/AE5TVYsyJq8v1Kxb0dZMAxN0rm0rKziEK2DyB83S7tj3VM9NOUN0MP00SgD/GcPWuk1LCfgX23cdMLeNDUYvK08dj0X0hpu67JQVqDd2Sq0tw56JBh/3Daaocsau9jPkRES5JdHyNfo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811414; c=relaxed/simple;
	bh=csE9+Fb1qbDL7EQ9gqnLFCsH8i1dvljsRV4NNfkRqIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOpob6omde0LMrE85m+ueBbT4pmx90nHOCLuc2R08oGkmtFqvn1JmG4Pbfmjjt49/UWw7l8OxTlFoiVhxo+wREv3zxzFH3HoLR5/ok1hmohDtbJV5qqBFjmqt0FllC618fZjHLkB0RUSXzRJpuA81yqM6DHoeIj/TAhOWLvJQfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBRou20e; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5681b7f338aso3367a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 03:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709811411; x=1710416211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csE9+Fb1qbDL7EQ9gqnLFCsH8i1dvljsRV4NNfkRqIA=;
        b=pBRou20eRvrRPp746txBjnKlQFWBt8vYvN75U4XCRO+Tci3eivtClA5fp6MSomAw4O
         LNrJ2+L/sTDgbsrbqMF6Fv5zE+QwiMH3TbxScQ1ULbn26pwHqCTdcYTYGPzI5ZVBo6e/
         obMMDCiXNtb9d1Xv4E1+2ppxBOLXFKHlksG1FmVSHZOJ5gSKQkUkIcb1708pdZ+UetnF
         JxmJjNsk6VcVrMySB9sHtPWczffiwzUXc9HTEWB1Ilzb2Yq17NR1JnhO4VD/grW/lKI/
         7pw1TOEjBHGNkbg0GjBUHyAMH/KQHeGXfKDYyVLR+PMepPCTBqhu4hEayxb+amQtwhRr
         s5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709811411; x=1710416211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csE9+Fb1qbDL7EQ9gqnLFCsH8i1dvljsRV4NNfkRqIA=;
        b=kJZ2BHSzQqA86iuPUOBd3Wug/fPgf6X3HdkqAYRAWkjs5Tng80frq8pZeExZtqNdlb
         KdSdqz5WqmkY4pBIYGOodjPs7s1al6QR17M9AsxUsR1y1M5GeFB3Q6k3xe4J5IOp2ocW
         C14sOcf18hCgl8dIvRVOUT0zxqbBqPKUC1RMRPnViZKQjKNHXzRJwAIO4kC582nR7Ae5
         cYgAgACHCK3t5Ev6MJrXIbcNvo/1aCTW+c146S5G2EzEjhYUpWK9QInnmEeB8AmFy+48
         kuajyRLvHUYdlYvGwUt7rsZstWL+imbwfb8FpUKn6Y/kuKxtvcLVJGWQ5f824PHdgKfl
         0/Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXIiPJWLjKE3QMNuhODgxopxGws79EkxMF69pxuGlQ9zW/Z88VPA3ngBYVecZgZl5ImwLSxvmHfE/jE4ACIDDlGipJll/RJ
X-Gm-Message-State: AOJu0Yz3SnXnI6cjR9ZRwcHpajr+Xb1pEAI42cLMsaAQnRKH9yWMJs8b
	HEtg82noXjBVDT4Smwi4QqFcdUuL+N5JP6LDo1t8AZ6skDjw+FjT9813o7GGN7wFoknekVtmCCB
	LziBUXizMjQ0pO2r1ZvLquQisqVNedv+MeTS/
X-Google-Smtp-Source: AGHT+IFN+ugPG1MFVDNGu8EIOU8XjifORKg5Yakb5vpTZ17CLf2qhGejlG3OgPc/1FIj1oKxaSdO9DDiVGzlPE1EaXA=
X-Received: by 2002:aa7:df92:0:b0:567:f511:3815 with SMTP id
 b18-20020aa7df92000000b00567f5113815mr149183edy.3.1709811411456; Thu, 07 Mar
 2024 03:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304092934.76698-1-kerneljasonxing@gmail.com> <20240304092934.76698-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240304092934.76698-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Mar 2024 12:36:40 +0100
Message-ID: <CANn89i+xg_rSeaVNo__FdZkV46_CEhM8c2Gpr+i-GsWnqatAiQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] tcp: add tracing of skbaddr in
 tcp_event_skb class
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 10:29=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Use the existing parameter and print the address of skbaddr
> as other trace functions do.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

