Return-Path: <netdev+bounces-163739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12144A2B729
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E3818896EF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F73D26D;
	Fri,  7 Feb 2025 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fe6vRydV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7304C83
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 00:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738888367; cv=none; b=o0JX2t8udHsPg/6L3IdxH/BCV6AE+JH7QFqcuCNmzQw15LLhwDBNZLDoN5yxFhxRF93Th1saojT4BcsDWjtos4VORKoxHXdyt4KZhqHdSia0QMKXegP0/+Umd3HyqxEYl4jXF74IpMn0CgBVmsbYBhkiWu0kOAnVAUdMb7yH57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738888367; c=relaxed/simple;
	bh=/Jt0lno7IU39xWLuQOUH8l6pIc0dUFOlJ8Es/01ilAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pkx7TrN93vLEWfcJoAflnrgW33V1Jdf6u5RgeMUqap6Xj+nA/ZlqoI6DcY0ZVfA9CerbIInXPA3IFjL6SfmtGYlzuC2KrHVxRqo4fg5Cl1CAPQ0xJjRkIwHFDA2KCCXVwnIomqvYf9LRhUFS4oSrM1gVLiURn+sOA/3tPhsrpsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fe6vRydV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f032484d4so69315ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 16:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738888366; x=1739493166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Jt0lno7IU39xWLuQOUH8l6pIc0dUFOlJ8Es/01ilAE=;
        b=Fe6vRydVS1uTTgaf1Oh3+u4+86/XfbAhGaQEDvfYFswyz7zPc5qQWeTCi2I2+uCJaS
         r8DUyDjtYWS/K6NBOVZH/Y+6u4PkhpXT9gFbMVJxN2uAu8CVCsjoR3QKPllcPOEXpGx3
         fbReMFWcFdGsDnleVNH5pB08pagZ7M4n7+CV/7rFlDI0r6aQeLLpi66yJYC5X2doZ9QK
         pQcsrYyCF2YFohYzQIiqCc8ViqzBUd8BdoOft32sCrzvHc7MXJS19r8buHsB+TJjFMIC
         680ZEPyjhhRh6X8uAijZMohG52jmkTWduq8lKp2U1t0oNNsu9PiPjBLQ5aEKV8ACH9QP
         H2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738888366; x=1739493166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Jt0lno7IU39xWLuQOUH8l6pIc0dUFOlJ8Es/01ilAE=;
        b=q1Hxc4/7b6DcRKS6rqQd+pjaac+JxKJ7g5cKoxfDPJBhDYPZlT2gRkCIQU31fAF1PF
         mE/vuWHPPH/lGca+fe8bH5YDWYfloF3kTyt+dde/c1E8o8vwtT/WjnByKk8QJXN/J/XG
         q/AVJZKee2HDeSwQo3wiwygOA7952bcxFX++mvnAa3B6XOOKnNmphneO3v919kmd9AzD
         b25UASUXH0w5Lll+Xa81rFdFM0U2+aB7PBqbfWJAVd/yvQ+MzCmoeHixe7XXrZJLcZGO
         pzn9smIAeme0YkkBNbPUEEp9AKoQHrDot9LlrfvzJLwtJwLq81pheZG6z1m6aSHv0E4B
         n74A==
X-Forwarded-Encrypted: i=1; AJvYcCWyuXTnIlEADRwvZaNWP1sRit9+opOJR1FU2PywNPiDXpehBmLZ5G0TlaGVf6PsfjlV2TtNnww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJecanBqvo7V06DVhkzFSKQ+IT6S/fAQqC875kGJ405Xm6S2JR
	9MjsbIVaxPu9Kg0VAIh5Yj50NMrmiEhX34JycxZWXhMSEwyxx6KABXALb2SLgQTDgBAv5BGf5Em
	6zJaxTCWm0r6y/MiscrbKUp8O54eOWN5zBahn
X-Gm-Gg: ASbGncuTpkfGrLrLt7rBEHviG7z0mgbSWJHCZ6Jmhmzbm5Q/5BBOrZ+/8zLx4MYyZDL
	71KJUEAzG1Xec875nYdeGcS4GefmP4jXWAsy8/ZAzJ4q07lQaS+sZLchz1s68T+/ZGnRZ3ebO
X-Google-Smtp-Source: AGHT+IE0I1vjmNNU5kXLDAfXBWAoVmkgtr3gNIE2mUtVZERn9EXymcvTYWAbGF+C5T8fCZctbPcK8FFHaEh65Rbl1lU=
X-Received: by 2002:a17:902:f646:b0:21f:3e29:9cd1 with SMTP id
 d9443c01a7336-21f5247981bmr539965ad.1.1738888365440; Thu, 06 Feb 2025
 16:32:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206225638.1387810-1-kuba@kernel.org> <20250206225638.1387810-4-kuba@kernel.org>
In-Reply-To: <20250206225638.1387810-4-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 6 Feb 2025 16:32:32 -0800
X-Gm-Features: AWEUYZkAwQwtXZhPCmflBDeHh774Rr2HgYumthFI-9qhSRxu5AU325l0Rs_vG6g
Message-ID: <CAHS8izOAbOJ6KrRG8g0PJ3WNBM-GbPPFkg5Yx+fm+_XuN1cAgw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] net: page_pool: avoid false positive
 warning if NAPI was never added
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> We expect NAPI to be in disabled state when page pool is torn down.
> But it is also legal if the NAPI is completely uninitialized.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

