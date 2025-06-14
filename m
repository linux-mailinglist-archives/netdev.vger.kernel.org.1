Return-Path: <netdev+bounces-197704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDB4AD99A6
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 04:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E69189D5B0
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075877DA6A;
	Sat, 14 Jun 2025 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vif7yLdZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA43BA42;
	Sat, 14 Jun 2025 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749868060; cv=none; b=Mn3XNmyphX43Ubtpcf65WVXv/0gQcIibxVKn7ClScqKVdpu1sMt2o0po+KyhDX++8+ZN4JCtjx7BtDY4befvfAjCY5sNw5F51SE09IjLKa8JaDxnPpL3OJLwAn3cjwcFwJ4VZgdL2xudUL51ATes8AhK5hWQoZziY+/trxe2pvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749868060; c=relaxed/simple;
	bh=6MPxcrzvl/j0c311UlB0dF6QX2mG0TJI28/AbWapSRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZU7Y5rO7Kr9vyJuvZv38hUbX2hFdz1mqMwMcjzaCMC0YkVJxU2skSLlzMfRDfeo08rff6UFkAsc9C7DU+FN1xqIfdnrq16TIAfOOdE7hpUmgiEGUwBMjm4qlOwok610n5C/J7rrx5gh3KJhRiZ0CquCQKouOMv45QerbjcwDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vif7yLdZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad89333d603so531494366b.2;
        Fri, 13 Jun 2025 19:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749868056; x=1750472856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MPxcrzvl/j0c311UlB0dF6QX2mG0TJI28/AbWapSRE=;
        b=Vif7yLdZsXnpbjgsosJOC8F84+o5jsRkGgyZJrr4bMc9IqEHMaz3zt4zMQDwX+gxSA
         UznaJqh9ggXE2r9X4CAjBmHMhup9+m2+iI95CACjNSsOCTYvM4kFW7LBvTL4t/pfR1Rv
         +gvP0t3XI57Tk/UDU+U13NAzXrfJrZzviuYC3EMppxMpylIkB1Q2evFweUofFLjMZ5wR
         0GmyQgZB5fDMZM9nF+M1pbnnfZnc+hcOt4afjmYxGHqLO5OX/Ajy+hgSwOsq3Cg6eEnn
         fD7JzkH10cKDHKpDKFp2Mq/goxr2bG7wlMqbR7tkusldcjH72NjwgjTDihlL8dGWuA7X
         9Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749868056; x=1750472856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MPxcrzvl/j0c311UlB0dF6QX2mG0TJI28/AbWapSRE=;
        b=O0YWxP08rIIdVxt/V3IojzQTgnmb2K0uls+n65P/Iwyzxx+HO/jmk44K0suxWdGL9t
         hXLfOYoxUgTBY4ohNpAXxwNs2amxl/aK+FAMZFCxTac9/nGJcvk8QyY0TWKuaj/6T9aR
         h0e/SJWREa9FUxNBChCd0hBywCf0ynWazFEAUK6WGViBHQfvdT8KIY5ccv/R9T5HVQmu
         +M9qgdc2f9ZmSczmKaTZXfMKALgtoTWELeMRyqhGV+6YVdDWj6oZ7+Ix0BqcEoClO7LB
         w8Mtsy5qiybKyKmuXa7NnbcAhRU7opbJ4Qfq/bcpBBkjzbKfGDHSNzB9kM8kHNCtupIQ
         3ldQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkMZ+10xejADmpWSwI1578Fg3vWNELEnlpR7GjR841qHwoTHeEP3ZgM6+5lY4Z+OJOMR72hq3tvYUw4Kg=@vger.kernel.org, AJvYcCXTO3GE/vz4fwHlT1HRzQo7WGROfOyDQlP43w45PCv0l4KR6OobiACwp7ryJhHIA31eiPmOAwLa@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgDczgHFDxRK+oW16zOAf0p8gkH7QlZ21lZRioLdML6aO7LLc
	72tXaMiCUem9/zqPK3SDoByem0QnxkEIElMI3pHDq9SFMd3F84O/fw+RCc70CXIwmuCpTBgOlH9
	FUsiBdZKL5AMkQa3YkTs2yhG6qaD3NL0=
X-Gm-Gg: ASbGncu2JCN2pbIex7oVdDta0whiTr5gTCs+3fviaomkVbCSNSk6A6Yc2LcyOMSYpkQ
	NVJnXN4tEtcmd6rwmBZF7HCwM5ENBxwH490ZcQspfpV2VfZ3SeW82eteHSg2PxPzalMMT7WB8Ay
	e1v37j5nToAYah6mKXgnjxVSxJFlViVnfqnzMu6WrzihU3
X-Google-Smtp-Source: AGHT+IHSDZgUvD0qwZNlq4ENrrlQE2VqR4K9CtjsGABFFoir+MEGYeLA5t/HLsmifXnXBAbqLV5m/cTF91+KCmvaLiI=
X-Received: by 2002:a17:906:7956:b0:ad8:9428:6a35 with SMTP id
 a640c23a62f3a-adfad367d90mr116753966b.7.1749868056224; Fri, 13 Jun 2025
 19:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613102014.3070898-1-liyuesong@vivo.com>
In-Reply-To: <20250613102014.3070898-1-liyuesong@vivo.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 14 Jun 2025 11:27:24 +0900
X-Gm-Features: AX0GCFtO7HPk3CZD3Wtlzh_X41p29PyqpaFeYaRdgJ7FwzPXJATvNm7kwiBt7gE
Message-ID: <CAMArcTUJBWKftYQsVwqHQRR-cS87hMcMOOU3u2_83oa9TjzEaw@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: amt: convert to use secs_to_jiffies
To: Yuesong Li <liyuesong@vivo.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 7:20=E2=80=AFPM Yuesong Li <liyuesong@vivo.com> wro=
te:
>

Hi Yuesong,
Thanks a lot for your work!

> Since secs_to_jiffies()(commit:b35108a51cf7) has been introduced, we can
> use it to avoid scaling the time to msec.
>
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>

Reviewed-by: Taehee Yoo <ap420073@gmail.com>

Thanks,
Taehee Yoo

