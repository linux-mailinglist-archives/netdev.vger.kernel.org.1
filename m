Return-Path: <netdev+bounces-243980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA2CAC7D9
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 09:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76B82303E012
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 08:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7E22D9494;
	Mon,  8 Dec 2025 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AY5KgvWm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B18B2D63E8
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765182270; cv=none; b=nRQqaW5HFJXq8HVChZCSWTj5Ro0D5847VPGHyojhbe+h/4KayCmw7NNsSBfAMznGIlPK4BUT4QhwsAq77SfKuw3jB1fM1sKyrOQUc9N/gicbB9fDpSijf2kSh8UjIRL+lB7mcJxOOBNHVLSWvZFV/Z+/VCTRxMuhXCM/iJ+W6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765182270; c=relaxed/simple;
	bh=CHBD7yB8dlgaTI09KlnjEFi5jT+V6RNYefkvghzsHBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdqMXSDrtF+xVpQtQazduEUwlTYFQL74iu6iWgyxlY7DdxtC0j2nAkta3BnSOmDLR9Vy5U5sSCxlItXrsuPJqs8+pEc4YRkQOrDWqqyi0n1eUyTQ1mI172wZka4f1n33PAKvb4cYmQaJ+KNNRNdHQ9vuAEfSaPCWdz4zI4kQUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AY5KgvWm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29e1b8be48fso10987115ad.1
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765182268; x=1765787068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHBD7yB8dlgaTI09KlnjEFi5jT+V6RNYefkvghzsHBU=;
        b=AY5KgvWmsShpMRAM9vob15x+EAc+RkBYjV7v1Zc5ZKLC2HUQ5yrDlTW58GYQFmurEi
         loUSrgM3LGlr95jdaULdhV2ctX3L4kn9VcF/sAfO2NH3hfGjI42XKISZbc+ZzlwRQVjN
         wLn78b86YW25m6MwkuLBpdSlO4wHZQuE+ICroVEPDjWcDFkMfBiR8WNc2Nip02Rt3xYE
         DUmJYBMxcaZB1OCWyttlT93bQ7uX+e9dTu+CtTfX8RfYqKe3/D7qSOPORWPU7kmCaCTP
         iyPYJXytdCKAcIj6Cn6NmUHYx3I6N47QUn22ggTTvz8qFTbgEKmdR6z0seyKKGyYwqSI
         vyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765182268; x=1765787068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CHBD7yB8dlgaTI09KlnjEFi5jT+V6RNYefkvghzsHBU=;
        b=fYHJ3rp2thz+WzeJFoZnohIqyD2g4uf3rQ8H7WPZuWCMYlh8jgPl50vGJNXdezFR5F
         LmhHluQAX1lZwMjY8VLzxOPvtl02/lXrPMpaYG/VVj86MOcRmWA7BwITmb0RjHy41QV4
         INsSBFSy5F551yBA236+avbPE2si+jWj2OHac1zSV+JzbvoTK0Q40Rl8lwK3p3yMk4G7
         eJg0bqpOT6Nne3xUWMYS8yRBGyzeHI+BzY6ZqAuKwt7KJINFcbMzPTUZVEadOqU9bUef
         vsawR3wfYdRT2xBYSWB2DFFrq0ih5nMw5PpklAhrqGUmftuHRqgj/LqEGzjUpCDsjBbH
         Byzg==
X-Forwarded-Encrypted: i=1; AJvYcCVYmoCEOrz+iVn9syWYQ9RaaGgGpfRX/ZT5tT6A3BBqoJDYro6hEpERBPR5laW8eYM4XiP2MQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxvdzT3eVmowz7TNWOK7/kwUOWXdJX/NP2czv8zXMrqCLO9BLq
	FjIIHInU32rtdxidvwqiTmKrJN3Z0cGNnq3loAqqXbyvFrjiVtgeIoe55MGx6aeHr4ySot/lboN
	f9b24wSIPsFQc/EgKYDoIHkuCODoZw2g9A87mN7g4
X-Gm-Gg: ASbGncuSDD0T15eFio+efvO6c9uRlQBQOpGmuIFV05ObfNDjjX+fwgt2RwxWra5qF4Z
	ZMnygJyNK8lMLtTe1mbAABvqdUVf7OM1+tBE3sFpca4kx748ZaM7dy1qFa3pJkx6ULlYNb30GpM
	3Hf5w4rU+X8AD8rk0d0Aa3J/9eKTt8EeAwamBquTUXKZisvIsankGNgiMcXSmVrr6sZRaZ9qeof
	lm/pAiZyoAhhP5ILq44clUvLZ/K5dyZrB75JHdEDXb5tN9nkjMyZpIAjLRTI1jBGErfLZMvxkzk
	PzAo/i66ag6Av/kK/6tXztqbtaY=
X-Google-Smtp-Source: AGHT+IFug6scu8is6Vq1B0qSWi36ekRlg8uEiZ+/bOj2oLLiPimGgyhhXlIqD2CbCMVUgD7nVGKWzPj6+tGqKWqoItk=
X-Received: by 2002:a05:7022:693:b0:11b:9386:a389 with SMTP id
 a92af1059eb24-11e032bd77fmr5420502c88.44.1765182267993; Mon, 08 Dec 2025
 00:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203100122.291550-1-mjguzik@gmail.com>
In-Reply-To: <20251203100122.291550-1-mjguzik@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 8 Dec 2025 00:24:16 -0800
X-Gm-Features: AQt7F2q7cOgDNVU8VbF7GPRaGxkQNfHUniZkwn7tMMPxBWDpWi75s2pDgGibwxM
Message-ID: <CAAVpQUAfDxZfbeM8nSYH611oTfagnpbvK4FQ5H83h3vTd9NGfw@mail.gmail.com>
Subject: Re: [PATCH] af_unix: annotate unix_gc_lock with __cacheline_aligned_in_smp
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org, 
	oliver.sang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 2:01=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> Otherwise the lock is susceptible to ever-changing false-sharing due to
> unrelated changes. This in particular popped up here where an unrelated
> change improved performance:
> https://lore.kernel.org/oe-lkp/202511281306.51105b46-lkp@intel.com/
>
> Stabilize it with an explicit annotation which also has a side effect
> of furher improving scalability:
> > in our oiginal report, 284922f4c5 has a 6.1% performance improvement co=
mparing
> > to parent 17d85f33a8.
> > we applied your patch directly upon 284922f4c5. as below, now by
> > "284922f4c5 + your patch"
> > we observe a 12.8% performance improvements (still comparing to 17d85f3=
3a8).
>
> Note nothing was done for the other fields, so some fluctuation is still
> possible.
>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

