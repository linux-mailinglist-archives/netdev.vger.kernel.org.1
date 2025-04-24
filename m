Return-Path: <netdev+bounces-185677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A246A9B4F3
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8941BA0F59
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145A128368C;
	Thu, 24 Apr 2025 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LsVBgLWH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93C2820DC
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514346; cv=none; b=MKFYx5DQBMrBZPYpJ+tDZETQJewlvU67cTYZPCGP68NwGZd1hWy1jh6q7UUrgpV2hsPpX+fJ9M7RRc0zPt49zqkQwoLZu9WWSyVGbD/pO4KPvn20QSIh0BFjGisn23+fVDeFObhHt0kP9L3hx8iXWgp9nUrE3GtA28L3bLraYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514346; c=relaxed/simple;
	bh=C6SJw6TbjdDG56VoM/Kv2+2EDT6n8leC/O7SpRft+8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ierMn9yEJEY5Ytq18ahwpVD8U8u24vVS/ZP2tG47xF26aQ3iH5c+1Y6zVPKnx+6bvlc+B+qsREpM0hu7wv9uY1Q6LV8ZKMnNe8jLE8OOaRpfQdDiDDPYyrl1Bpqhyp5Snv/mzukZ5tiMJ6qycvP2lLzwyeYPCDR5nss21P6E8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LsVBgLWH; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47666573242so3311cf.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745514343; x=1746119143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6SJw6TbjdDG56VoM/Kv2+2EDT6n8leC/O7SpRft+8I=;
        b=LsVBgLWH2puAD4qc1/tyziEUC3CfULdP4NxAzydfwbSJGjd9zqAD2VJB1qITYXJFsH
         EL/RJpIevm92QVC0oPOvL5Luci8BcNAaTc0KkF32AMIcjvJcD6/jk99gaAqs1Irpnbme
         BM+M+xAafpi/2v7CLEkajLpm3Lx3nmhuAVCsQzUlGOn7hJKJFzUhO7D4hz4xzxdna9Os
         XDIBrzFlaSR+GRtqztQSR4MZb8xvYgKPPHWnek7Rh7tlcA6ICCkgNsJC4j7R+FUWc8PQ
         Ry4tR7SEvS54Om+Yf3272BySM0eWAvKbjDzm29zEOsQGT5tjdQuxRnWTDT0o608OlqKd
         wSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514343; x=1746119143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6SJw6TbjdDG56VoM/Kv2+2EDT6n8leC/O7SpRft+8I=;
        b=XV4dzJIhtRb1PyhvjhgnSp4yshGLXMbSu4nA++iWaZTEVZbXfCHnWvGc89dqfl4AOK
         uww45HTVM8WIV+0fna0GOI7Lt+duvRb4Sij6onWKjKNI8QDzUC2C9hNiENaxHlTFOvmo
         T3THT2agsdLFIcZ+7A/X69l1PsiiUjL2Kq6b/YP4r7cLpSxeE6ccSU5S2b1SWDw+slUD
         em1D8dipto3a4r10qtXxGXV2adEikr2YTQEbKAmJ2MOPsE5IEM/3N0g+/tjfoN+Obl5O
         d+Jn6hlXMEslSdlAjmYxaOjMoiRyDhE/PYcSPV5d2epmEaaYUyQNoXaJMRGU2IgN2i4U
         YAHQ==
X-Gm-Message-State: AOJu0YxxrKgf4bKz8o1y/v7RROC2tsCd6NBABPSk8+c72uDAZtodyZmP
	Yq1wfBPsQNMtPqfFw778httvsccQEg6ChXIqDK4uGOmLYVDXmDpnvGZcy+dLRdDBB5bLACgQl32
	vspTL6P83vyZTkgmZba5DrCq1rZsT8YT1NWFYKjez3FKYz9P7yPjo8e0=
X-Gm-Gg: ASbGnctibwARLDZ6sjUNUI3VKFT8RJK9rbi/3I8Fzt8eQS9nYLKXwH0gTDTs/HDgB5M
	qc7pwYqTyzfcQl49ThNlPk2qkAGxeSlpX7t7ntGu3MwYXYPDG6MODQliRPhYNgbvTi63CXaEJqj
	wSEpQwAI+YDc3VRMDbjhtru/tfmQWVlQKHmkgzBDXDvp4Kr/VrMkDelg==
X-Google-Smtp-Source: AGHT+IHiE5KFx+ao/sIJZLng4g67p7Nl8Y+Fq+Nj6mX2Lf0pj2ciEEUuYS08mS4f/5EQG01SaCQ+LW9J0m475Vek+Ck=
X-Received: by 2002:a05:622a:5918:b0:47d:cdd2:8290 with SMTP id
 d75a77b69052e-47ea5053113mr4475311cf.9.1745514342873; Thu, 24 Apr 2025
 10:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423124334.4916-1-jgh@exim.org> <20250423124334.4916-3-jgh@exim.org>
In-Reply-To: <20250423124334.4916-3-jgh@exim.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 24 Apr 2025 13:05:26 -0400
X-Gm-Features: ATxdqUFuWjnhO3UxSkDPwHT4-wYxGgKQZh4MKZJrpIlcFrUyN_HK8Wx6oEg0bvU
Message-ID: <CADVnQymwCjSkk20DwyZ5vJ0d3zHuNjM6Baai2cN1eR2mTqmxDw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tcp: fastopen: pass TFO child indication through getsockopt
To: Jeremy Harris <jgh@exim.org>
Cc: netdev@vger.kernel.org, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 8:44=E2=80=AFAM Jeremy Harris <jgh@exim.org> wrote:
>
> tcp: fastopen: pass TFO child indication through getsockopt
>
> Note that this uses up the last bit of a field in struct tcp_info
>
> Signed-off-by: Jeremy Harris <jgh@exim.org>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks!
neal

