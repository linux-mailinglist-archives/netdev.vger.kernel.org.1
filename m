Return-Path: <netdev+bounces-226921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151EBA62FB
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8EE4A1BEC
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 19:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B8E1F0994;
	Sat, 27 Sep 2025 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdSIg2M/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749B38DE1
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759002741; cv=none; b=jkRj8+pht1JXZhFWcpesoRrNfcGc/8oyMD2X+UoF80Vma6uyoJp9b8wl7sPXkr/WNXZp8QmfX0Inm9Z9UNhdOC1+LTNrlC+86yyT1y8poGXIpEhPlTqcsFEopaEcaF0xd0lqxR6Sge3BjnpIMVMZQgH69JxcqRD+AQXF8cpQGYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759002741; c=relaxed/simple;
	bh=JC99V8IkgjjzUHZghrlBKTUJP67E0AwKyC3duDnjlL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQ2FOzpZHnEJfxa6jF9WmkT3GGzajwQhlOLJ8jAzokIs6CWEduOwizq0fzRLI1met/baNQNhg3EGHnIMXGSiZ6zyufRy0sJtbErTfKohjtc1UYhqzSsa0l0a17r5K9PIOVTHOcUMoYKaFUkfukJrc1vzw264NlYb6UX5QnYvnv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pdSIg2M/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b57f08e88bcso1372045a12.0
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759002739; x=1759607539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC99V8IkgjjzUHZghrlBKTUJP67E0AwKyC3duDnjlL4=;
        b=pdSIg2M/sEHPcjvFcIvraplx1swkpRsBI5vn4XU869MpgtiYhR5tJ094IQHL9U4fTI
         F6cjHJjvO+lIMhXRU+2vfxlbSYu1DvfCttqdexAHsxJTajAyFLq7HHlbe2OyaEIekZy5
         9CQvivd2uBaWRf/WtoMka4drT4a5hF3ONUMGQPdqaGyleBXEvNEfzfLEjL6bYRM0nEcC
         WIBVjBsfP+7wsEe7B22LBJDZOBaimfIXOUM5C7Dof8yZp1OrYe6aGQDtiFpLd1kWBMeK
         5JrNkrgq5IdE+wWj2bCIcPTq3VAafq6i/SG9I2D08++bM6dySGcWNst57tI8TgKn8B9C
         97DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759002739; x=1759607539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JC99V8IkgjjzUHZghrlBKTUJP67E0AwKyC3duDnjlL4=;
        b=dm9phwPKZP6myOvw5d+pkgYBEr8BbBmgYdmgaumrufkqp3DliDMqDpzH7kNbonjn/o
         IutQ+YDFLDFs6uOoOu88bsIoNc/Krm4gsSvtZ2Vho8D7WAdNXbAzjdIrHKp8Ac8DNEa2
         8OMv63XpNCLgfjcuvU6pRlPJcteK8KC1/KYgQdAW77UQ81C86sSSvIDct4o5sghpOnIl
         OFD0URvNxUPq07hkuFWjATN/ShvUVlJkCNosmWoC3s167DJ/0em0ZxFZWXQXlH2+gR9+
         PxPGjKK/ZQtlp8pPKmCcwzyPV2G0lIX5qEgH8srUu2X5oLYnQ7yS7x8I89CrxDpDMRJx
         XKew==
X-Forwarded-Encrypted: i=1; AJvYcCU0D29r/uKPRAWA92vL7JyA+7TdV6JdkYrEfsVXFMXrWsmVVVJ+RvzISDZbCSIA7Jw+T/2N1BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY1xa26fqbWaZDTCNA6A7FQW16mkxbXjeZu6V2rBgPGz6oDKWO
	HAXq4sUMGX4tEVU7sb4nuyPF9LsQN7/ZYsn21N8Xcym8K2fs94X0lJtqxSHboo9CF2k6joL3DLO
	fkMeuhIZ9soj5Rl/ckSkzpyBcLqlL+sEUZV+Yy3iV
X-Gm-Gg: ASbGncuqlV5gGhz4vAjofgF7h7m/8E5otKCViT952B7cn+Fgy8GpK7GHaeqLRnaxSVf
	SHYlqF4vmjCKKd/sl2dUbnByxos0WogeW9TjesgWKnNC2qAZS+210HaOJs8/L+P08T5cW64NA/P
	OOy7JIFL1sv+ow5aVlU9vdktvhdosNm3QKaZCV65Zkr5sjtuaYBh9MGp4RDsxt8MtT+Ta9aIYRm
	j85EotDA2JOd+E7gIcEOvVfoYy4g7a+NgL5KCKpG9LXQ9vqZFw=
X-Google-Smtp-Source: AGHT+IEgSAV9gMabomDeuioZ02UaZp+/HX2XmRo1TkLTgJAp7BmNDw2btbJJcqbdySk5nQAmmy8hWW2VSjL3w+pG6HY=
X-Received: by 2002:a17:903:110e:b0:266:64b7:6e38 with SMTP id
 d9443c01a7336-27ed4a47150mr121953385ad.46.1759002738569; Sat, 27 Sep 2025
 12:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926151304.1897276-1-edumazet@google.com> <20250926151304.1897276-3-edumazet@google.com>
In-Reply-To: <20250926151304.1897276-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 27 Sep 2025 12:52:06 -0700
X-Gm-Features: AS18NWCg1dLmqFkow2gJNU8sQLkmY8_FHS8kPq0gAiwiIbS4rI5D32W5ZVjV9S8
Message-ID: <CAAVpQUB+paJuEwVV6gHBTmsTU6s9LJdEN_HUBkoS0WUk3NMZqA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: use llist for sd->defer_list
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 8:13=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Get rid of sd->defer_lock and adopt llist operations.
>
> We optimize skb_attempt_defer_free() for the common case,
> where the packet is queued. Otherwise sd->defer_count
> is increasing, until skb_defer_free_flush() clears it.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

