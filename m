Return-Path: <netdev+bounces-185670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 174AEA9B4B3
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DC29A783A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B75828A1CE;
	Thu, 24 Apr 2025 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Edhor5B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144928BAAF
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513576; cv=none; b=QBy04v50jxYoTvulE3B0OKE/QyWmUI2JO2v+TVxShH8TMVfgZKBKKDYxqguzQ7zNPIJVsoq2D4r2WIYCcVcTpbRgTcsoB6Ceu+9+5WgcHg+0ikwhBcyJQ2ZUDQlaITRYvHpCVbfhttwgQSRriG37TrBvzLEjWUvPus0yQlwzD6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513576; c=relaxed/simple;
	bh=gLPdqmdR15dvvugXKFWgaDMmlP55hysaDHBLMsTxmUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbZMv/GYVfVh6e2s8ybx/0XyvkcuUt+LPiPxjoeDp8udyLC4TpetGPQtVBP48TPqtq0+dkytR4XCwC7vRH+QpLJJkE1dlvwIVRdnNxYmc8o3rULX3UpePQzQR1FMPgJAFmNFrt80/sBrz0d+OWXfKtdegV3xK/Nb2N8IaGPWjj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Edhor5B; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c08fc20194so276090685a.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745513573; x=1746118373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLPdqmdR15dvvugXKFWgaDMmlP55hysaDHBLMsTxmUw=;
        b=1Edhor5BjcZXCDPDTD0wvTJUFNacGH34H4XoF2XOF9kUxI3PVRp6fvt9DUYjwJmwEB
         pp5uLLnF0C5DduJC0Zo7NORQUGoEluIUiyc4i4k1uIqGKb0SZBewSkmbNJPMBLliZnt8
         9YqiSf3vSmnN25WGVWhDZrmSEWbWKnZJdrSikw8b7ULVQRy8tvxBDc+XAv3m/8/E1hg4
         Cyr8bWJfzH/nMABk+bxXZJ8J9mxpFpGKR11jHwTi3URNmjeffBO1p+2UKF0D2vkqc76S
         J6o4pRxnMu9k6vW7p0fEUE3cvDWXpanIuEmeyRiDbQT1OgJOtOpbBKLb3JcuKKaRBa+G
         qLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745513573; x=1746118373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLPdqmdR15dvvugXKFWgaDMmlP55hysaDHBLMsTxmUw=;
        b=CSYcdsfXe9/zlAqo9e6UB5tuTSrflwZgNSMlg4PXS40E6oaeQW58SqHDYzAJIScTyW
         1RL2Jf+xTpYR68MfXywopJv1zpXtNNrsBdcbe3//tIApiMJLiZOZbo/i0tvOc9KYvcHG
         6RUl9idUGx02hhwMN8/9ttj9EGfqIALhQlcKQSzbkdQuhcVp0dftSDt2K+N9bc011zUa
         Mb640/p3oj08SHyI6MNI7S1XqazIdclUg9bMbm+ktwWtIpcjr0NcQ0ugjVHQUjD2EwSk
         01tX9oxJc8AjmPU46cYqhDTpHq7lsrhIGdt+2G5EecYOTbz4wx4ye9jQ4mWKUTf4MQyM
         N0hA==
X-Gm-Message-State: AOJu0YxTuA9anZyxlYIMW0C4+lKYbEBFLUgPl1A7Q4ghblSBsxaSMBLM
	pLBchy3cgwPlueQwX+VdEMMrQGZN92Iqn6tyy9NVWrJdlMYNZLbsI4GsCVKsHnAo6bMPWSfsLIy
	N2IdbOtL/rf0EDADm5xY2u+KzOwrS6REmGZq0TFcVxTFgLrEUwm4i
X-Gm-Gg: ASbGnctispjqCKnc7j4YzDRjCEutq/SpMBL0HtAClX06QZtyyU68lgJxv7Hn4HIBvHo
	B/rX32fuTD1a4C23KH39pXYd9ZpxujkEueqn8aaerEN3q26iXTAGYI12ul7iYk/ZX/qkMgbORKF
	Ife+X/ixXj2H4bIP30U/fOAjXD6SLLDhjZEP2R9LOBQjh884dc12E=
X-Google-Smtp-Source: AGHT+IH8A4Tz/ZWhvnH5N7SsRgB/5THNjno92rB5MQuE1IXHWPuMdA8htyrgADGW4xm5M1o69eSmQaNg+/wJ/DTjyHE=
X-Received: by 2002:a05:620a:248d:b0:7c5:592c:c26 with SMTP id
 af79cd13be357-7c95ef0248amr18923185a.19.1745513572951; Thu, 24 Apr 2025
 09:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423124334.4916-1-jgh@exim.org> <20250423124334.4916-2-jgh@exim.org>
In-Reply-To: <20250423124334.4916-2-jgh@exim.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Apr 2025 09:52:40 -0700
X-Gm-Features: ATxdqUETivVbemdZGQPoJC_MxXJWhMksVTto24tbgUP8-g9QPtn-NKq7sUcwJoE
Message-ID: <CANn89iJa3iRUAY4MM-uqf5aBz_z9Gz5iUg=4b4-0pq3ZY3YYJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tcp: fastopen: note that a child socket was created
To: Jeremy Harris <jgh@exim.org>
Cc: netdev@vger.kernel.org, ncardwell@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 5:43=E2=80=AFAM Jeremy Harris <jgh@exim.org> wrote:
>
> tcp: fastopen: note that a child socket was created
>
> This uses up the last bit in a field of tcp_sock.
>
> Signed-off-by: Jeremy Harris <jgh@exim.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

