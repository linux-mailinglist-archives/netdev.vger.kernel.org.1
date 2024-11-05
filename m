Return-Path: <netdev+bounces-142132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 533729BD9D1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00D1B224AA
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1EE216A31;
	Tue,  5 Nov 2024 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6mrzoHq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0DF21643C
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730850090; cv=none; b=guUJ+3lYCFijNYw8pIF3VvpDwbXDKzgcLZjJzOYmLF1jOTcVLee94En4ejqX+/dX9SDVIDC7SjZgYn+KoiVyzN4TOcxcOjDaxLvEMsRN0xDr7zuo9tJRJN+fRTfg6auD4Y7jeFCKhyo6O+WJFeyX5apqxmMDT7/RCr2lhVMMyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730850090; c=relaxed/simple;
	bh=A6sIL665Rsnzw2jQbwODKs9cUBNMZ6Cwi2OgDGa3Kw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhSK9GSwZkEG/BptHbhgunki9MaFnqHn1KdpbMAyLqgOdpNymXRsxxeMSd/8Hool5xPYV2WQdBKrK9xltKxLLLB5cn+NR+sux7N+lAkk3NDjf2y/RJvxMm2KW2kH4BYnZ5BwE1g1JXIx8mQw1sy9W/URG4iGi3CYowKDX2In1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f6mrzoHq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9eb3794a04so189457366b.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 15:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730850087; x=1731454887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fu0/RDofU7ER4jx30UDmi0GrnOBcb9QQbNAoTs7sIFk=;
        b=f6mrzoHq5hCGeHEhLo0jHDjBB12mkoqiG2KTmARSq3gfP0EUwwzSabaRYgqr6Rv4hz
         zKRmieDAzxqkwbapaY74YzzWubUaUhNVtpMqoYNgl1CLt6YQVjiI5CK3lHM3xHMamnrD
         sEAy09eqAUqSRLfSOm9MRnjsIxRxOEhZZcAwP1fVmAmaO+bP7tcmSnAcfuvYn1h0G9Jv
         jezoiRBxvvnKja6uvpRDXkqnT6HYBosZ2aAdTulbduqozmEYlTnZrpS1N53WlQAd5yRK
         UXHd28cQRQyWEAvQ7SIJ9/zbPUW7u59xvaQe/mi3xnuhwNNVmt61O6dVqXM8+GJp/kr1
         zD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730850087; x=1731454887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fu0/RDofU7ER4jx30UDmi0GrnOBcb9QQbNAoTs7sIFk=;
        b=lQyD7HjoCBNQGf1kzWvCLDS/wZFxgdW+qGJvIb3CzeR5oSuLZC3tXtQIJjZuvKeiOV
         IXrguiQ1zBt+kfIReLAergEU7PZQIObE6D3cafrPWEmmI20kfQthaFIuq4QJaOK+ArVv
         3VVNv+uCOkgSZEej0MR8Ak6OmjPVnpNJ15XPZlgAUo66/+usiacUjW8tnxcL3x4GeL/F
         FbEyCWJn+zHRNhu7gKToS1gE7gj3ochTOvQTEzll/7PRv38tBl88ww2vNJ+GWG0PbaUx
         vfoVYQkHXMS2R71rTM/d8Yp1VqhuABQnx+Kq/b24q5vusFoxg1MKo7H25DHwBdqXXMRx
         zIYA==
X-Gm-Message-State: AOJu0YwHemdWSoVlkDWt3gsB/ZL06ADvL6cwd7rfINoM4k7w60N+Y96m
	ZJmAhndTnVvMSeGgVPtsDMU94CAMwH/uhLdmhTrwe1FadpyAmaWPCPR28QNI5b//htziyyWrdbm
	2/5X5mcHyNDoTjaj6LcGiNROawGv1ZSZ6yJpg3bIoaD6S2/FdXjzo
X-Google-Smtp-Source: AGHT+IGKrWw7+OwT0oRkArubvu46E6a2vXnRuaAs3CHUUnyxo0FMMbd6KEZK7x/CJHumhrBhJylH/Z05d09OjV7Q0IQ=
X-Received: by 2002:a17:906:794e:b0:a9a:76d:e86c with SMTP id
 a640c23a62f3a-a9e3a6c916dmr2490804466b.49.1730850086792; Tue, 05 Nov 2024
 15:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104233251.3387719-1-wangfe@google.com> <20241105073248.GC311159@unreal>
In-Reply-To: <20241105073248.GC311159@unreal>
From: Feng Wang <wangfe@google.com>
Date: Tue, 5 Nov 2024 15:41:15 -0800
Message-ID: <CADsK2K9seSq=OYXsgrqUGHKp+YJy5cDR1vqDCVBmF3-AV3obcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] xfrm: add SA information to the offloaded packet
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com
Content-Type: text/plain; charset="UTF-8"

Hi Leon,
I checked the current tree and there are no drivers who support packet
offload. Even for the mlx5 driver, it only supports crypto offload
mode. If I miss anything, please let me know.
Since the driver only requires the Security Association (SA) to
perform the necessary transformations,  policy information is not
needed. Storing policy information, matching the policy and checking
the if_id within the driver wouldn't provide much benefit. It would
increase CPU and memory usage without a clear advantage.
For all other suggestions, I totally agree with you.

Thanks,
Feng

