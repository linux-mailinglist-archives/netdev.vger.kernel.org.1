Return-Path: <netdev+bounces-217156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6BCB379D2
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DBE177C8B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 05:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E7730C35D;
	Wed, 27 Aug 2025 05:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dWKgAOcj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827BE28725F
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756272510; cv=none; b=XgtU9zbYi3Rk6+W+H0bp9o8/+yeTh1viwi0yGuZzWqsHKfdBOxnvn6sS3yOlKOvfvdudU33Mr6l/3NEMPVkh7odLEX2hoA/JXzvVYWAb/3hb/zTfwqYT1EbjmxRQZnm+giwoM4O5UqaDmWeKz3VMw0Xxz0AW0sMHxFqqwBvJ2m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756272510; c=relaxed/simple;
	bh=shxHhXGsRPrcAVTTlBNtprLNf7ft+cEvEScOckY5xhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4BaHXZGWLrmgoc7q2KZhdL/LDxLaoP4vn5eHAj5i1pCXqqZy/xW2f9iuZEczaWCt0MdSEWkiSR9X8WxANUwemsmu7nPZQiwW9H3Rz82NDvQOAh8Oypc1akWowqkqKepQ6NroWP1gCkaVwQWB9a13nW8w1Xm0Gt679zlLQNusg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dWKgAOcj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4c1aefa8deso1989584a12.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 22:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756272509; x=1756877309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shxHhXGsRPrcAVTTlBNtprLNf7ft+cEvEScOckY5xhM=;
        b=dWKgAOcjRdfAKVwmFHkQbpdY1OoJiCF17PNT5QwiCQuc4nhL2coCccxSdHp1aQ34T1
         xVcwRYm9wvPJngT/ymIjmNsOPwI9Ri1uKEKERpugIijJjpPy4pvD8NAD9jXxERtSoOYo
         H3NTfeuMYOq92TsCnvVxxnHNe2eztEBtf5xkljYVMURoGKUSW1XsUvfzmYXokFETRdMu
         KXOyvGnWbxsMFkOHBUJrTDVbJC8NsfIGzWz4S5rruPzFL4AA64jE6EhQfI3B1mYfgtzF
         UQhntT3TzkDfDqZi4vNoPvWffM9RCiYuQtlsqafXd2FfOGpBpR8rUmtLTCWb72tf6b3q
         EDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756272509; x=1756877309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shxHhXGsRPrcAVTTlBNtprLNf7ft+cEvEScOckY5xhM=;
        b=EGMi3QAy4LobJHF7ONBPomGC/8afx/MeWbHQNPUG2qSvxvDhMAmRCID8fbE3GioAvt
         Grwv8YfLl4khmIBih7NKAw1Y2nif2PxnQj6KAX/eXZZUygHBK4eDy07KKsLZHoSsjOK3
         tkt1k3vFGU4f0yZzfLJaSURWcuD7vP71bZMv1aKQtbg8vhAjjRXyUwwaYC19DHjJrsnD
         M9iTn6Xe6Tc7PgAuBOLtnmkoztgmH0v300LdOqhOuPlPWO3t4gY6+YShRZ/35yjgrAlg
         7xOaibRKCCUjqTACY1LjrdPXk73akw0J1pdRq8dS9fc3DTZ75gDheu6JPuhOKfy/EzBu
         729Q==
X-Forwarded-Encrypted: i=1; AJvYcCUl3F/XrwOfPeNPrpGfwq5szaY4i0OS3in+whPKQypZs8fG60SoMzzNc3j3+IxFpz0QN4V1DtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9fiorv0uxwYwiZghTujJEZMYflD064NH3YbnrGMynPd8nsqCj
	x2fIxI77lx8Rgm36lc6QTGZ4YbmypyeXmKT4i+UYZJiWJGWR0/kpBWTsICDH0OkVAEdxnSgZEPc
	YopfbbwZKInljb0dBt2VEaByu8WTce18fi7/XCh3V
X-Gm-Gg: ASbGnct+QtbZ/KLNkxQ1hOeml/VBIKse2mXhuBVUNAEnd9B8K6v7boaRzPm6wuAfp3b
	frnPviwOjAhoKyCYJW9flFXLVYcOrQ4ZsHIlTCGO+LtLkdfQuvoJXMX4C9YbBWpyWExZWvm8EgX
	M8qRA+jlmTVbzNvis4CAhfxIWWpSZM4GkfH3TButhNXDJwY2zObrJ+bYVGPny7zCJX3o5iVFpCy
	hHK2IcrGhuJIfnaXMjd5rYSGkOrtcaGGKtQ68eZtXhsLJmqevWtQXoPXTM3ZgnZwe5kM7o3O6qt
	7SIXkkcreV0Ucg==
X-Google-Smtp-Source: AGHT+IHmjE0faZ88ryPhE8reTGG/JFWsqmMcn1EXEgBc+X55RFCkO0bspbEiKZH1+LDAuqMVtffxkhYRePDaFZ2hO1w=
X-Received: by 2002:a17:903:2bcc:b0:248:79d4:93ae with SMTP id
 d9443c01a7336-24879d497e3mr45248175ad.33.1756272508539; Tue, 26 Aug 2025
 22:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826125031.1578842-1-edumazet@google.com> <20250826125031.1578842-3-edumazet@google.com>
In-Reply-To: <20250826125031.1578842-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 Aug 2025 22:28:17 -0700
X-Gm-Features: Ac12FXy3Gha-8CqOriBMLogu-ybXwVBw2aRT1kmMzgaAJqCu8e_jVRppSClaURw
Message-ID: <CAAVpQUASrTvQm+p5yXtPoZDs8wVm57GGk7uOZRWiYuGG8_1R4w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/5] net: add sk_drops_skbadd() helper
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Existing sk_drops_add() helper is renamed to sk_drops_skbadd().
>
> Add sk_drops_add() and convert sk_drops_inc() to use it.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

