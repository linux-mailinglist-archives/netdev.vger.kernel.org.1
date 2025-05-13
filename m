Return-Path: <netdev+bounces-189987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6C3AB4BC5
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125D1178F7A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 06:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1C61E5B7A;
	Tue, 13 May 2025 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYrCupH0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819B101EE;
	Tue, 13 May 2025 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747116823; cv=none; b=jlHmenFCKAAs3BNrtpuV8t1Be+2nV+QzqiZAWRU5jHrSXyQCBlIH1639i0O6nbQswSZun4SDzHULkj9+yzL4kUZKRAwWrIp0bWHIQck0dEbabJUgZy+l+v20CIDlbw7yVN7Q4Pebn1Y9IXA2OAdeyU8vHdJeDlpiEM5IUA5GmSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747116823; c=relaxed/simple;
	bh=mZurxwtq+CMYvzINp//1+b6TujHGvHE82p1FPz26k+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkSDC8WdlSySaFX9MZqeCvkBdzY7CMoloNmHFSzJjByF31W8jtWEoKk5BuuNAbzuloCzed+oAB/chv/RMG7d5Az8ZOmxnCLCursAQXUx2ndVywRU0PAsqmK2mx+6q8HyahejYx/t9kXkvOeJQfFzimcbfBjsK7bDEKhG3AMXHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYrCupH0; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3da7642b5deso36626265ab.2;
        Mon, 12 May 2025 23:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747116821; x=1747721621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRrv0KBdwMIbTaSxKoyl49v0JwxRka2NNqw0EGI4u2Y=;
        b=DYrCupH0bF7zwGCTpBXZzYPB2p48kVaRHqLkA7wUn2ydMw4OiPglt2fbl6ZLx3fFW8
         LpvH3/s8k8SGbU24lgaZ6R7DRnbPp287QDsBPdMppBdYhD7+/eEAKhULuEfEyaDX7bo6
         qGz/v02bRK7q0KPurQtsoGU3uE1ce5bTP+aFyKxB9k3TKUO0CGuriG3w7D/ryer20XF+
         b7Dt5yufF3BvnydOhOXAOb75TW9OVl014c9QNDLHzyo+Mrf53nAAlpYyJ4axouY1tCNi
         fNhCwnRruooQ2HWf1bHvMM0y6gypc4ieww4d5PpNvFA6VcmUOF4QNVsaZses2To6FLx4
         Uduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747116821; x=1747721621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRrv0KBdwMIbTaSxKoyl49v0JwxRka2NNqw0EGI4u2Y=;
        b=k4QuYmkhRjQ6QV6tcM7dv3DJmU02H9dfrGWHGlBQX+i6F+6KDlnX4eaMg9wUfvI8n8
         qvGXU1I1jLJnaPUd4B5DAoOubX0ToYhjDOf0Fy4n6kErgiM7pAgwl7IkLehzM8D57O/e
         /P3TkVBN2MHBSoRV93VzpmM7T/6RXJEGuxzHarXwxzRYaDc95J9f81CvJCJmJK2iYPF8
         jHgHX3xzEWrvRdc/64uuSif9gcoIc7E6cq2HxE4Dfj3eAJT9IMKmAIp/XH+H2WneNpSJ
         AuAEEIzBLlbgKc8HH3tx+TOuW62yYFkdlsQNOkwm7Fv8GpM4t0LIBt7ZMF642VdN9SIe
         Tsvg==
X-Forwarded-Encrypted: i=1; AJvYcCXLQyRkwqRN7cEMiiPzc7LXmEiIGY1mdNSXaHf1TNDP7NH6pRImbqOR/RFPT7eHyVQkLcP109UM@vger.kernel.org, AJvYcCXyoqIlCwk+s4Yb9BLIye9Xduh7HkvXqMYgSRbWZJMt1m6F9YsD6p7A4xVHv6zw6asMLQYD1Mo4LfKzbL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaa5EJRoiJEkQxDu9DdnuObxJQk5umfDROhIMc6ZxHQh/vSfNa
	bAHJ/EwQ2dslbC1rWiRZSGL26jWc+iNWAtU364lx9u0MjuHCewAJjm1n3vMgr/faF+UbZLI2KL8
	XXZ0/bSIZDfQkit3ni0Hskiarrho=
X-Gm-Gg: ASbGncubRXLEqTK3RG9d0kZAUuOMP9Na7aCWJw0Rl/PbCnaCZmaFWdi9IPFeQusuwKr
	z0oitLfXAvk9DNZm6syP0bRlXBttoArfU6Iwgy1mHcqIWXTk7ovJTVM51AgntROQUeMkl4cUm65
	KAUkn3ir1MVdt2fYC+ASpSm0sGg/skQ4E=
X-Google-Smtp-Source: AGHT+IGJZDF4NmipsMzJ9kqrpdBnFCV6X6NeqcTgJgg52cCnXj6HQ3Wru4YWMFFl+fq0OYumq3vu6Hni/ERH+jo3xBc=
X-Received: by 2002:a05:6e02:12e9:b0:3da:7cb7:79c with SMTP id
 e9e14a558f8ab-3da7e1e7d16mr162013555ab.13.1747116821018; Mon, 12 May 2025
 23:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c8bf3f2-1620-420e-8858-fe1c2ff5a8e9@shopee.com>
In-Reply-To: <0c8bf3f2-1620-420e-8858-fe1c2ff5a8e9@shopee.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 May 2025 14:13:05 +0800
X-Gm-Features: AX0GCFuIQfkAVza6hbhK4sPe4d8m2OQUcFRXo71Y2QtNp3SmxPrR8NWz9WuNVT8
Message-ID: <CAL+tcoAYvN20aMz-WYFEUeBypS8yMJ53YgdMUHCX6FCr__qT9A@mail.gmail.com>
Subject: Re: i40e: How the packets will be processed when status_error_len is 0
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 12:08=E2=80=AFPM Haifeng Xu <haifeng.xu@shopee.com>=
 wrote:
>
> Hi all,
>
>         If the packets arrive at the rx and then raise soft irq to handle=
 it, but in i40e_clean_rx_irq, status_error_len is 0 and return.

Directly "return"? What version of I40E are you looking at?

>         The data isn't fetchted from the rx buffer, so the how the packet=
s arrive at the rx will be processed?

In i40e_clean_rx_irq(), packets are one by one constructed into the
sk_buff and then passed to the stack by napi_gro_receive().

AFAIK, common drivers implement nearly the same scenario.


Thanks,
Jason


>
>         FYI, the every rx/tx queue has been bounded to one cpu(64 queues,=
 64 cpus).
>
> Thanks!
>

