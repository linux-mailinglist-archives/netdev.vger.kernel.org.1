Return-Path: <netdev+bounces-212329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A4B1F4B9
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 15:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AF15605A9
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 13:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5832868A1;
	Sat,  9 Aug 2025 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1NpFZ9L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE016157A5A;
	Sat,  9 Aug 2025 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754745856; cv=none; b=IVwrmgl73BC2Rei+SOjT+PhhkSs89Ti/AQcLtteaNt7pAvlHNHbkl3Bu1i4XbXYf9WqbsddEMqVGjJPFtyaFMw89EnZJr7CQxICfkZuIdZbZaXVnZlB0qWh+wPXHkFN0jlEggZFEEIBIh9I60fo1ThgfW53y5g/nyFUuWXRuw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754745856; c=relaxed/simple;
	bh=i/aXl3FafuonDW2uRsPEFO2nW4UOl5q69OmnYgerOAg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awdJp0GrCzDb+JhhW2gTc3jgI7ohQmfS5rCBKSkQWjLC0M1SqoHfrkrAJ+h3iSTUozdsLsMHmsQ2WLMaAidS61hEP6Iqy7ktzy84FOmoI+Z1jyIwuUzwIk8Brza1AhHZZn5v+JzJrEtHhsq8Hp7Uegdr5Mn1kGcp9eNpZfSK0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1NpFZ9L; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31f1da6d294so2766264a91.2;
        Sat, 09 Aug 2025 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754745854; x=1755350654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gg5qA8e+0UYHLSOIBa7q2BXIt9K71iMCY0q3plis3nE=;
        b=H1NpFZ9LFpgupZKYuO4NiQMnq0xGp37VUWAsup1vMXJDdAis2NKgvEFxbJbGcwNS3C
         EU36DYeR6QJJV/ZA3rmjsaR8P+3Iz+AU64R0fJHxUKEfGHHDBzOSqPVtNrYDWLgYIg6r
         1/dTN3uq7AjMSXoGWuLwmTJcnO4958XZrAG4fvG9bHQVWBgFtJVNIJ7nTdrLgrMBGhuP
         N1/sI9HH2Op/+/F2LS7ufK/LG8gmL0QzgRMUApA274padEPf6TSuOltkNCDorBr2QCO+
         N1jZJMJorgzoSOncgnSxZ15lwrjRJwQg+7vV3tf/nH1c2ExCgwEQwkh46r3rvFN/XiMh
         QIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754745854; x=1755350654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg5qA8e+0UYHLSOIBa7q2BXIt9K71iMCY0q3plis3nE=;
        b=CB4IVd8a9Lo8xQAwX1N3RC7JWbZxyecDNDqe5zMDwRVJVZSq9TG0IswHXkm4I/Woqb
         vuY7obgMP72IRMcnj+fSmfpiisaNZMkXlBAgMXrrqksCqKMTjt9vUVMYIs/z4U6NfQTF
         3qi4H1XMluZCMgR59q2r8aCvkASm0uD2l+HHkq2N/9g3/APa3olBj2unr5r0EOqjEGpU
         jqQ6rKWbFkw1Nnir9QHwUVf5i3ogco0KehTz26zfe+uexIQ2ISnr4+DQy/Vbyag+1O1D
         Dah4dMYkGcmvJIi25dKM37miSRi46I8UQVpusqGOUZ4JbBv3ReNzq5Xg2Zf6O0FU9SgI
         sw/w==
X-Forwarded-Encrypted: i=1; AJvYcCUAZY91GiyLUK4IJm810nmnf26SjP6SJ9JEyMV8JIeoli5kqfAhADJBDgp/lIdHaBRBKCp22paS/fn8MKU=@vger.kernel.org, AJvYcCXpv4F32kkoGhHbMu9x4G8rPHh+xIu5WOXorL/guJgs3ByzeHHKYHMS6hcmkFAYBqQzEyxf2xxI@vger.kernel.org
X-Gm-Message-State: AOJu0YwGRP+6xYNTY1RJDaYUZjrwgmIcOM8asbhcEoNnXp2eHpFQ92af
	Wj6Yf2D6OBplfApefaDLoOo/yVTm0S3Ft+P4/jp7HDDYPLWRkgV6bzcZ
X-Gm-Gg: ASbGncvgyjgWOevP+plt5ydxtNoYpdx7wIjEU2RAIzxH6gyX0Nol0kmeO71S7Q7kJS2
	1sieXLbSCsadayVNoZ2vMa1V6AkfBLj+Pujzk0/m1E9ID3UTpoVooXXvY1zjYY0Xv8G2A12fK8u
	kdjlVTQN8OpmVUkOPhnV26PIsSGFUfnoRB4QOOedK0C7fTdYn7J3vckwgCWL2f7z+LB8EMKPt+q
	Ujlrwxt7qIGbf12BN+ZszEXsD7GpWK+xDKzrO5jEa3AWgCeUmIct7FDtX4q0R8Dj2uR3TBQ+gRt
	OwLjCg27eViWugqS6alKpbN3tLPl0yuRXniRIxLf4Xm2s4P47XCIKU9z+XyMOAW2krRB4FRJ89+
	qw0msit4Ss35731mY1k8LwQ==
X-Google-Smtp-Source: AGHT+IG6XUjvU1ujGKElusFwiJuytuORtuq2Rt2NrzrdYHFF84WEYLfReDSdYsL1FrWIQ0Z4Hb3WYw==
X-Received: by 2002:a17:90b:2ecc:b0:321:87fa:e1e8 with SMTP id 98e67ed59e1d1-32187fae3a9mr7874585a91.2.1754745854056;
        Sat, 09 Aug 2025 06:24:14 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3218c3c2d58sm3034935a91.16.2025.08.09.06.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 06:24:13 -0700 (PDT)
Date: Sat, 9 Aug 2025 09:24:11 -0400
From: Yury Norov <yury.norov@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] rework wg_cpumask_next_online()
Message-ID: <aJdL-5t9va5Ln0xv@yury>
References: <20250719224444.411074-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719224444.411074-1-yury.norov@gmail.com>

Ping?

On Sat, Jul 19, 2025 at 06:44:41PM -0400, Yury Norov wrote:
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> Simplify the function and fix possible out-of-boundary condition.
> 
> v2:
>  - fix possible >= nr_cpu_ids return (Jason).
> 
> Yury Norov (NVIDIA) (2):
>   wireguard: queueing: simplify wg_cpumask_next_online()
>   wireguard: queueing: always return valid online CPU in wg_cpumask_choose_online()
> 
>  drivers/net/wireguard/queueing.h | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> -- 
> 2.43.0

