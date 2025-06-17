Return-Path: <netdev+bounces-198786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D47ADDD0B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 22:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7284917FA5A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 20:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795B2EFD93;
	Tue, 17 Jun 2025 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bcv8J52d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60512EFD83
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750191281; cv=none; b=PNxsKihBCp9YRuBdMZxFRGrQYYHKcNgFa8Cu71xfQTHaEXToatTotxNCrKtL0fENTXLQNhyDbue3+1Owg4g82w4YfWfvKuXZUS0ECpbmkUt1KN1yvjVJmOADSuWvuuMo1yO/c4KNEr9NV8FJ1eln4fwAvP4+11ElEnwmJ+y27Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750191281; c=relaxed/simple;
	bh=INcAZefW15cBrtKKp1JIdih6FkyAnjMuDj4MdBbxCik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=My0DyXQ8qR/TxrSU0lgBNxm+WLsilAkQXNbgOoOYV3bnorlfs2Hs0xKdKgjLvC8jxwCxy3uWMZVW1q0b/2+5hXYuL1RYrV0XNp424ipHJFWBk/QThGH4qk8MQAmbMOtluyzFmT8aa2rrOdS2TGE+1I6YAbL+qJVaGIQxGDerd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bcv8J52d; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2357c61cda7so3205ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750191278; x=1750796078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rtxoD/HgRcRcM4T/4LdH/w+9lyF8T1e+IM1csMbVXM=;
        b=bcv8J52dR2NCgpSaNxvePiDcd0ycVc9SPiks4hQqd8mfNmWsSU2Jpg4z+MpexEWRT+
         RadnEHbXRrziLrqALI2AZe1ZNDQ+5VMl2lsWOT/rh3+2BlQVgoWoIHnK6qCJ9gobery3
         jgdJtGXjrgcA44RVPLurWE6+DjF3AAFpJ2JnHAvvKCE/GErI7ANbuc8ESkgwm5YwoLlD
         kX0UQ4EIZuj7C8Q2yvddNVPMaSxChNPUwxsg6/d4UGHtnYXHg9+OYlqdIdUtNHLDW1ej
         6q5Xi5U9bndI/GyKj3SSleFKIbHyBlphsreGJdmwUHRYxCeIJ4Qp4xpwWB+aTTMu65Pc
         1ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750191278; x=1750796078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rtxoD/HgRcRcM4T/4LdH/w+9lyF8T1e+IM1csMbVXM=;
        b=APQhXB5NEqQi6srzEKNk/D4RC5O4RLYr62kltZ3ANM5gVAOF4XiYKIBf7D2LCM739g
         yARyOhQ+gc7h9MK0t0U3jKt9bmdm03LL4KfRQ5ZhmS+zMsD1dDQBjA2LNaLRvPuKrz+6
         HTXsXuV7FKF6KOisSlJDoNIEFOxKXNe95UMAcD4yr8pBwbO1cFLy0G5gTpHQ+N34Kiqr
         idItHY3KjBnnSIbsenSpqhNCJa1yjr43zfa5PQQsmmYa49E9d8Qpd3Sp6rj2eeVTQKS1
         77XXbAvmhBDWtqV8cR3erXHFKLXzHwZW+KWEeZZ/PrOUHTvTVqrvSd+xaszpN9oTOD5z
         +puw==
X-Forwarded-Encrypted: i=1; AJvYcCUXc6NRb+Y0SzyXgmdZ20Uh+vjz7CQYOgBdQQQ/zyy13mYso9eR35A6JZijlsQ3ZAeDq5ZOpPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHxISWC/+UQVgY4W4GIATXCk3ItqdCPjp5qP1EoLsjb6oiKggz
	+bYxsaFg8Hryzf4midqQHgL8hRqjTrW9gMshvM6RPcSoWq6iGzO+tUxt/o3gZ5folEQbmUv4kP/
	nfC01btOXHDrqqOq0fyDovy/Estvm1NfBciRX3+by
X-Gm-Gg: ASbGncuNIS6xsInnoVEodJqif5hE/aN/XBB8r2TVuvtBQitEPAnGo2QYpdjAqrnYkDC
	dYYmb/bm6hy1EmqXtNc1nFjpcrE3lqNo0n9ySoiBe2ylcI2b8G9gYsOcGGwkz/7psZes9Bd/Lvq
	CjRKs+drLUzxgQ80fAH7cGliZzo3sVnpRXoWiBwSfiae1UtzqzOq8UXqbTO8/Y8cUucFFVhIhqS
	Hqmyy4oXjKL
X-Google-Smtp-Source: AGHT+IGAr7vUMZbGDr8Ufm4vwLgohiqqfQKu73zFNXQZQq6y5/FQJtDLyE3dokM7LkNnxh3uKDQVgX9ckv2eJWpVijM=
X-Received: by 2002:a17:902:c952:b0:234:afcf:d9e2 with SMTP id
 d9443c01a7336-2366f0099d5mr8419825ad.17.1750191277405; Tue, 17 Jun 2025
 13:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617094540.819832-1-ap420073@gmail.com>
In-Reply-To: <20250617094540.819832-1-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 17 Jun 2025 13:14:24 -0700
X-Gm-Features: AX0GCFsaW9VZd1TliMlsA4Qz-XJHztdIn2K8WV88e4OqY6kyhAct4KzbnRXJIek
Message-ID: <CAHS8izNXHvavBAWyyvwzwFh6CgaBhCnvQvtMsE4B2CHVm206hg@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: add netmem TX support
To: Taehee Yoo <ap420073@gmail.com>, Pranjal Shrivastava <praan@google.com>, 
	Shivaji Kant <shivajikant@google.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Pavel Begunkov <asml.silence@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 2:45=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> Use netmem_dma_*() helpers and declare netmem_tx to support netmem TX.
> By this change, all bnxt devices will support the netmem TX.
>
> bnxt_start_xmit() uses memcpy() if a packet is too small. However,

nit: this is slightly inaccurate. memcpy itself is not a problem (via
skb_copy_from_linear_data) is not an issue because I think that's
copying the linear part of the skb. What is really a is
skb_frag_address_safe(). Unreadable skbs have no valid address.

This made me realize that skb_frag_address_safe() is broken :( it
needs this check, similar to skb_frag_address():

```
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c05057869e08..da03ff71b05e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3681,7 +3681,12 @@ static inline void *skb_frag_address(const
skb_frag_t *frag)
  */
 static inline void *skb_frag_address_safe(const skb_frag_t *frag)
 {
-       void *ptr =3D page_address(skb_frag_page(frag));
+       void *ptr;
+
+       if (!skb_frag_page(frag))
+               return NULL;
+
+       ptr =3D page_address(skb_frag_page(frag));
        if (unlikely(!ptr))
                return NULL;
```

I guess I'll send this fix to net.

> netmem packets are unreadable, so memcpy() is not allowed.
> It should check whether an skb is readable, and if an SKB is unreadable,
> it is processed by the normal transmission logic.
>
> netmem TX can be tested with ncdevmem.c
>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Seems like a straightforward conversion to using the netmem dma
mapping API. I don't see anything concerning/unusualy.

Acked-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

