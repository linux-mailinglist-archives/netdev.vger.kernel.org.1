Return-Path: <netdev+bounces-144022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4289F9C5229
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2B51F23855
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FB320E332;
	Tue, 12 Nov 2024 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTbm41fY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9074620E015;
	Tue, 12 Nov 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404122; cv=none; b=WPvQm+q8qwRI8eozvz7HgMS/C/aS0s9qqFloCdumSwgYQ5n5gOUuKNs6KLeO2aSa6W5vON2JrQ+0ZJwPgtVsEIfcKRVCBx5m1CmKLtBMxktRluy8SgnQReeT2YjuL89PRi1cUeOEdh7G1a59J75uHHNWn4B4t3ReyekDPtAddQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404122; c=relaxed/simple;
	bh=Ulfos9jKmMp9FRRzcWaNP9pRqcDXWjbtCIFpVe+BjzM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=hyw1hNQnYceJ5ZkdA5ot1EKTUcTDUeb92P9ihiFv+5nyuNReb+FCN0AtoA2G68hjShiaZA9zeGgNzW5lifGA/04pdnBSarI4Dyw6Cyvaf6nwNcw/7XuNQ1o7Q3QIoMX4XhqXx+gbVkAwTsBSpRxtq5wWE0vxn1i4G+NMYOm5qrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTbm41fY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f1292a9bso6639130e87.2;
        Tue, 12 Nov 2024 01:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731404118; x=1732008918; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/2dA/CSJ1mXRX1iIfc9wkyf+fvE+0vTa/19Nc9jWmsE=;
        b=ZTbm41fY3Pmam8B76DmvYzU3cM+OWaoDi3t8FpZEzqCjUkJwtQuU/iFB7Z0RKQMJSR
         RzfWGBVXmHYvt/jqXtU1ZdASeFztqDIB5dBXUgDYznGiGX/BJ3ytyHTfKDvdFxyUdN6i
         gq2aL9gOxUmzK9d5LAzUEa/mVrOiJveLjgaS2u/Ahs4fQb2l2LQ5a8Pxe1VgS4y2B4Xg
         v6/nFfBud0UvsVjX7MNiHtqu4Z1rIHq/TC7fbTl/RLNctwEzQhlCB4zrwoBKC7EFM+dc
         BkCnfxawOgR4fb5VL7mfYbrTc/GK2/Gj1X9X8n+yGiVPZmoAIYd2/fqA4RvDbVxcKegd
         ogCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731404118; x=1732008918;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2dA/CSJ1mXRX1iIfc9wkyf+fvE+0vTa/19Nc9jWmsE=;
        b=dgsF0ofNAAyAV6u/W5dq3Z+KedpKo7EfyHAn0zT80PU+w8nlv9GWTww2/7NrMiibO9
         qKq0DAKmNe1VWb5kpwKxXQymQ1tCxUOg3i7ZlevXlX2/NWoIeLE6hAnN3rF/JTNBE/eK
         0ySUP3nevtcnQBU4ySP14zICWA7bUFlh7sB/jI+qdGtzVlDkO1bmdmDMvtTH+opKJ36O
         KBH4CyCTXrVBUDaFyZOUR/PF7IbVUbM4QaAku0+fKCIMoLL0Si03yWuDAD9N5Ru95/Hv
         LOTzIDO+BpwiPStsw1Y4eVvyJ22zhZScnJx01vqmlkpVzpzDqhfdYgnXVode/LoRuAWL
         huDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9nmffQ0hnN3RiZrTYEbi7UgeLJwllrf7Mx732oCYMul3zfwWA8+1wfHc7C8d/KsDLol534FpoRAAOpUo=@vger.kernel.org, AJvYcCWy7w9OP5oXfbKu/7lWHKTudiLEKj7k/tfnwouhPF6mqW+9oK3R1Vwqqlxi/Gozq/LxMFBDQ9p/@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCGBsh1jtVwIkp53DpBe3kp9JB1Lv/kRMhMjlKWtx2knsz4TM
	gUSuAXpQ3YsL0FQ14eZhn9sO6uDFf74jUgyW+bOGf4l0FIoZgw41vLKbug==
X-Google-Smtp-Source: AGHT+IFIhvdsWxGDaHpDPZFOhDaxNLymcA5oHrHaD/i0n7/b4Fl+3DYEGfak+N0uLU404q5aq+Dp0Q==
X-Received: by 2002:a05:6512:2389:b0:539:ebb6:7b36 with SMTP id 2adb3069b0e04-53d862c587dmr7358493e87.25.1731404117991;
        Tue, 12 Nov 2024 01:35:17 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:a1ef:92f5:9114:b131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c18e0sm206352035e9.28.2024.11.12.01.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 01:35:17 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: kuba@kernel.org,  pabeni@redhat.com,  davem@davemloft.net,
  edumazet@google.com,  horms@kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools: ynl: add script dir to sys.path
In-Reply-To: <b26537cdb6e1b24435b50b2ef81d71f31c630bc1.1731399562.git.jstancek@redhat.com>
	(Jan Stancek's message of "Tue, 12 Nov 2024 09:21:32 +0100")
Date: Tue, 12 Nov 2024 09:34:54 +0000
Message-ID: <m2serwu75t.fsf@gmail.com>
References: <cover.1731399562.git.jstancek@redhat.com>
	<b26537cdb6e1b24435b50b2ef81d71f31c630bc1.1731399562.git.jstancek@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Stancek <jstancek@redhat.com> writes:

> Python options like PYTHONSAFEPATH or -P [1] do not add script
> directory to PYTHONPATH. ynl depends on this path to build and run.
>
> [1] This option is default for Fedora rpmbuild since introduction of
>     https://fedoraproject.org/wiki/Changes/PythonSafePath
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

