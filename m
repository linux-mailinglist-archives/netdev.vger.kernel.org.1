Return-Path: <netdev+bounces-172641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4023A5599A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71021891A51
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7A827933D;
	Thu,  6 Mar 2025 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2YGM4j/M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7A4279338
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299807; cv=none; b=l4kPKnJRkqO0RIt6xoE6UVIJMsTQkIFmvFRM+FF8AOqPUb6HKG4TBq11sfaIs1jW6jCGd2OLdPanAiiKgoaJcFaQrQ4R/dwI/Ob4QgCYt93AJXY3c5htOTpkrqDSvA6m6/OL/rqZBNHr1JQdSdJn5eJ0dNDWrw0zGW/r0an3c8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299807; c=relaxed/simple;
	bh=AEmzCchJ1DRyZWxKA/ZhZ5o79Y5STH9WWwM7vqwuxXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPgzftpn6Vq/6rD+DQEienO7rPuKlpoplDmvJPvFvu7PaoMLieQnnVvWLxYkQjsnRxtZXkj9ztPvBOQHsHyHN6JleYo0RJ5Hnh+jDJh6EDGxr3N+pi9nQtGUmb/ue8Mc0Et3JT7URgEAO7Qupko+HQ27EL+d2RZ531GzV7msVQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2YGM4j/M; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30613802a59so13025831fa.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 14:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741299804; x=1741904604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xQvs3PYqzuUxFH1k0ZgLbrdHIOglHHb7p+NSV0/fAE=;
        b=2YGM4j/M3KXYo9Y25sWjg2g0+HBOvLrPkDr0UdaO+zjRD5ftw6djz9USxo0KnbLhri
         ZUZ06Kij4sV2lf3mFKHStbP+8fJOc4fyFL672AU1U0HGMARIx0jX2nH/ki3YFyUUIxX+
         2qyJ6tFUaOsEh7w1N3cCAx7/DNBatOm7LwzdzBv9DIRuz+RCpegexVV/n1Tv1T9id7IR
         nIjEF8WHZf2KrcD1QAdlDfrYMI1b8L1YgmpWpWrVho5voai5byQmYe/5YsOKPEZosuQQ
         QcZ3Y/aFmbA3FjznAodLbdsF2kT2ZUvtYLJ7iL8k3Vf2ordwMmXPNed6TpLW3NVQxR+s
         rAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741299804; x=1741904604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xQvs3PYqzuUxFH1k0ZgLbrdHIOglHHb7p+NSV0/fAE=;
        b=k+KLE/T0VrWz0FNIiDZngDg0KznmBPr6fOM6S8L6kpUiKO1Hw2YHD+rap+2H24Ae+j
         QrKxIUBtn04PTYiJ8nEL/wMO+m0UL5iRrgDlqJLDcO8Cau6SeJxJzsgV7UrWtSF2CnNr
         pamyUKejX3qo9wwoS2vSivCiAeDXe//0wD/7Mjj//c+nvrovQ7DfmHx4sMVVPoSufu+i
         2lNhlMlft6JBMh2sCqwqVE2xGIsVLap4ogO8m9A7c4aFuuwdr/gKoQK+YoAAYa6wjao9
         BUrqWpbBRzzuMc8drZ+rzAeGNZvwJBtoZiv7VDNktm0PpdY1qyIFh5Phnn4LvlNRdRhX
         19uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS64naRg5faVoQWcWv0val41espPYwKcCnWAd8OX0qc+0saqUYAlgS2qhH1+X/Ie4uWJwvY78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDLUw7v2TMIltewhdz51REP+n5jSz1eG9LiVe/eku0Ba1ItcOA
	EitqtvB4/Mo5G0dA6AAb4Nl8kNoIJfffu5kmOeS/vdq/1DT/UkEDlL2RBok1bLdlbV1EdIKLgLb
	J7jRXJjyjAV4zVKABcNUGB2Q5SKeavt7Tv4RQ
X-Gm-Gg: ASbGncskNTcHPTGqxmehzfRUjCE/lCwmaGQHrM3xRM/XY+LwS7mGVPK6yTE6Fxt96bk
	nMMOWcbJ1/IRmHbV21v7yRSF662cTabVthDcET/wdkOGjZYii+csDUbu2h9lWnfz2FpxKSxfQb7
	sgCizt8/bJ4p8R/+bp4SM0DzLli3zexMyszPCU6qBXU1xUEW2aKhiYlhg6KGp5
X-Google-Smtp-Source: AGHT+IGHtsEQHMxiMAebDSsZufzsNN8c2ajNDWSBZRqthclOH/P1cMAaTSDIrG7A+0o0UBPRR6TD20BBkGkjJKdJP9c=
X-Received: by 2002:a05:6512:2342:b0:549:55df:8af6 with SMTP id
 2adb3069b0e04-54990ec735amr283164e87.53.1741299803974; Thu, 06 Mar 2025
 14:23:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306171158.1836674-1-kuba@kernel.org>
In-Reply-To: <20250306171158.1836674-1-kuba@kernel.org>
From: Willem de Bruijn <willemb@google.com>
Date: Thu, 6 Mar 2025 17:22:47 -0500
X-Gm-Features: AQ5f1JrgAgKDWKhZ421x_AiYkN0k4T8b0AWao1AEfLMfdCe2Zy07Uuw0ZYlPoMY
Message-ID: <CA+FuTSemTNVZ5MxXkq8T9P=DYm=nSXcJnL7CJBPZNAT_9UFisQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] selftests: drv-net: add path helper for net/lib
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	petrm@nvidia.com, sdf@fomichev.me, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 12:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Looks like a lot of users of recently added env.rpath() actually
> want to access stuff under net/lib. Add another helper.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/te=
sting/selftests/drivers/net/lib/py/env.py
> index fd4d674e6c72..2a1f8bd0ec19 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -30,6 +30,13 @@ from .remote import Remote
>          src_dir =3D Path(self.src_path).parent.resolve()
>          return (src_dir / path).as_posix()
>
> +    def lpath(self, path):
> +        """
> +        Similar to rpath, but for files in net/lib TARGET.
> +        """
> +        lib_dir =3D (Path(__file__).parent / "../../../../net/lib").reso=
lve()
> +        return (lib_dir / path).as_posix()
> +

small nit that one letter acronyms are not the most self describing ;)
I would initially read this as local path

