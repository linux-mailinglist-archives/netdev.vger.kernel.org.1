Return-Path: <netdev+bounces-191931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4114AABDF66
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1E31BA34D9
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B026261571;
	Tue, 20 May 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbONgQnq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF525F98A
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755883; cv=none; b=sp/55XtqqsuXJCRq1JBEzpri81wgVfty9dqDuMq7Z6Ro0b7VTM5vAkqT2d+59N5t/gtS+O9rZirXFwXn5fM4JgO6x/4IBIMSLD7WNNv/VyA9Tk5Vnd4r2PwGi0T3MrzX6rAnasAwYlcR3l77DMWGetj4KcFiejsl1TZwXmNFYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755883; c=relaxed/simple;
	bh=sAeNCAl0GjlQKrm+f91vwz/79VKpSq/6746O3r+2mH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+yHk6ACSoHiA5JSyYD47wMD9w42LS5VxGAnimNw2DC6tWKpBec32sqhuXYPCj1lGYOCCl+nMlba54gHQbZGrIZnTDhRjD64kfIzSPvdGsHmjiyYv5qLOJU2Y9SEHPxOvjFtbON/zYt4sITCX9ZH1HdojmnUesPXEg3eeNBJoLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbONgQnq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-231bf5851b7so44838985ad.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747755880; x=1748360680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAeNCAl0GjlQKrm+f91vwz/79VKpSq/6746O3r+2mH8=;
        b=LbONgQnq5+PWY0cGES7aiowCtQa4ULjEi3CjVMX8l/HmE7LbWxfPTJkziT0UL1O7Lh
         eqXH1DkEbKL1DkoGJvhCyyecJ7qQ1fEpKmLwG9nbBfIaWHGGiGJ+S4ER7CWTsURYFBHC
         OJVjd73/ujRch6T2NLqBgGNtCYIliwRhMTdkaSRu125r+zlvLESaT3DCmbNQTmAzUmxJ
         WdgoLIfgAMWRVnAnrFiPo+dPzZKeFZP8Bikej9XJKwr1ssTWjBmoWQRhjGlvinj8gEiW
         A/aJ0vKdYbXixZ8T6NZ7IG8BrOyC+Un7NlwQogcJQkFMTDWXFq8SlRt5j4RIdBPJg/u8
         PyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747755880; x=1748360680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAeNCAl0GjlQKrm+f91vwz/79VKpSq/6746O3r+2mH8=;
        b=f77FjCL1NcH0iXzAhR1OUxzwbOo4ZIweZPUXtguAE1BCN/hyVX4OU8pRVOXQrx4xIi
         /mw1k+E44w5UEQIruJyMcC9sjsApg+ERCJtbscESbDucsqpPDEO3wcLkyLECUwIBxPtI
         ydMKYTE0D3pPbpoygnYlALLE42CT0J+zTOPuwVDvxtVofLzu1kTW76sweBZAdZdWCGM5
         9xOQuTdVC32sfOsQvAhu9okmRouGkMpjduCdOiwSNiie5wozeh3TR5omrBuazDZ0JRYp
         SogJDqAc9ySziDxSKSsri7R9oIGVrMjWRKwc+2WgJvsvOVbdkFjfXnGF/0YdfkLhzNKh
         dceQ==
X-Gm-Message-State: AOJu0YyyMDEteSKoqU+E+MiBydvo5N4zdayKypCApYbgYirId3a02spg
	uIQROZUDtI080FH23XULmZJt3L1g/wO0aka8StSuOj53tGiU6T1ZoD7ffjPqtCgeO049nDsXmXJ
	lUfgBHq4Zm6XNLiSx0tjXaHaX9h9ynFUrO+YgTEg=
X-Gm-Gg: ASbGncti9wGYud6v3nnJt/8DkymqBxMr+U0qvLX2OR2H2kQjDKOG7745UHKyJ4vBnv+
	+Tng1kZxwTvoidFkSFtKYcwFlluY8CMfD0NY176ANCBJvteen6NRVtsBn3CHID4udUC/gFFOy+x
	Qea2u+UEIZxKIjRx75i6WyO7p2R+fZWA==
X-Google-Smtp-Source: AGHT+IFItKx00FgtHD3TpZ7XCYeaMOYscorXiNJ3O+7ZYYuf2AqZ41Wb3NzBdPKhz85SlE7KMhlCk71QDMzDUoutEgo=
X-Received: by 2002:a17:902:f78a:b0:216:2bd7:1c2f with SMTP id
 d9443c01a7336-231d4511e0amr208520345ad.18.1747755880141; Tue, 20 May 2025
 08:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520050205.2778391-1-krikku@gmail.com> <4068bd0c-d613-483f-8975-9cde1c6074d6@intel.com>
In-Reply-To: <4068bd0c-d613-483f-8975-9cde1c6074d6@intel.com>
From: Krishna Kumar <krikku@gmail.com>
Date: Tue, 20 May 2025 21:14:03 +0530
X-Gm-Features: AX0GCFtjfzEGauHG6PQsvUYHDZ2WqeiZz5Y0kARYHJ5kWsh7Brhkn_YUHqypRo4
Message-ID: <CACLgkEb+5OU+op+FvrrqiA1mgsp7NbA=KB_dCa532R6AL2c3Kw@mail.gmail.com>
Subject: Re: [PATCH] net: ice: Perform accurate aRFS flow match
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, edumazet@google.com, 
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch, kuba@kernel.org, 
	pabeni@redhat.com, sridhar.samudrala@intel.com, krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 8:18=E2=80=AFPM Ahmed Zaki <ahmed.zaki@intel.com> w=
rote:

> Are these numbers with the patch applied? Can we get a w/o and with patch=
?

The numbers are for the original driver vs the new driver. For
purposes of calculating
them, I had sysctls in the code (removed for submission) in the
original and the new
driver at each of the locations given above (a simple
atomic64_inc(&kk_arfs_add), etc).

> A table might be better to visualize, also may be drop the
> "rps_flow_cnt=3D1024*" case. I think it is enough to show min and max one=
s.

I will re-send the patch after adding this table (and Simon's feedback).

> Also, please add instructions on how to get these values, so that
> validation team may be able to replicate.

I have a large set of scripts that measure each of these parameters.
If you wish, I can
send you the set of scripts separately.

Regards,
- Krishna

