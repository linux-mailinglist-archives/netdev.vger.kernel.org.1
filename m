Return-Path: <netdev+bounces-97828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FDB8CD662
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B701DB21970
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CDC6AAD;
	Thu, 23 May 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Sk31XbXz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F09107A8
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476347; cv=none; b=gLmPN1ljeGN7h3xEAmgl3ryWR+FNS37r7h2/N7K0bsgHDllfDwxmtv7fCXMiMzQEtF7Lq/87I8I4wu9615iQRFO7d3p6Edb7COP4/ouFpt9XMBRllzWJZj5KawrC36FhVy7EoWWpjWgPKiRVnngxIroMvlfsqUX8IOjcm0pA0Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476347; c=relaxed/simple;
	bh=waqLVeSOTG9HutmNeYzprcb7faVdy74a5jBbGny0QS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IezAoalyiWNn99XBFP/taxgUJYCLnX+ERPKSyGRC0g5lc9ydml9+bKtYJcpKh+ryBJQI0vKzHrTmNSOJfdRBCx5irHfWEQicBv9idz7rg5GbbNW3LPrkW5JDL57FNkstGjBHCjU9ETTeU748gv+LdRjMtePzbB2u5fJR2jNdMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Sk31XbXz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso20425055ad.0
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1716476344; x=1717081144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TSDbFlTWX5JkoFUvJumAR8Ry/7EWefOz6CCNrT3lqE=;
        b=Sk31XbXzJQQS1WSu8izoTxcDnwL9o8H7hqGgRedpbq4G6DXOE7NWeXXiNb/QMHfRCU
         P75HwGERHgSfY7F1BQ9gfNIKFe32oyut70odCtq3lndNeEId0LmKKvcEn4Pr7SUKAGzq
         N3lB0SsKiknfjjN4jtsvxRId9R46B88ilPJkbIgGCrnASdFYLzMfrf87dzFvkPIQIdi8
         7OY5/QZhTZrjHYSOejG/WdUfT51BMKwrSl8MDt3Syn6r4+Vxuaj1zXwTf1/xGLbxSLkk
         yD1agpRYWNHx7ExdsNnNWUfon1tmWIvxTVJ+uO0PntvOoExw+G1Qbk6YmeH71ZVwGFmz
         HF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476344; x=1717081144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TSDbFlTWX5JkoFUvJumAR8Ry/7EWefOz6CCNrT3lqE=;
        b=vjct8cpLWflU+JNpL5RxoVKaAS0nw/QEQW5IC9ugw9FHrMD/dqc71JfLj3b/PhTAUi
         LM3S6JxH+KmXx4h1mnXknLCRMFdB4IHALijKzWwjS99RmkNkYUzJYXPg681Owx3ZIDNT
         3MCnFqyOBvQjh3hTpkTJ1nqmbK4l6j10RVVbifN3hItBpAPyZZ1fPi7qFTV3McN721aa
         QM6hTchi7hA+HE8IPk9SmPz0rzm0j1LxWZUiYJmqe45QT4DmEex8S9ZWXP7/WGNfeGMg
         IBye+O1xx7PvYi023PIuNf8QOAyvwCYw49lNeB9/t6la0BpTK7QjQ2vPo35eJ512EKHH
         g/VA==
X-Forwarded-Encrypted: i=1; AJvYcCWvnKpMRMip0j0KhirGa7bcf3+6jZyoJYS8eF2NIIyriuLV9keAfKDhfwFryKDbDIvJdcyb2EPhizAhPiE0Rr6CxXFJPJaM
X-Gm-Message-State: AOJu0YxuAjENSo2d/rkyQDzopxfoW2l0+U/P6zguair1Bm5GKnaxMouA
	LeD6m5xoo7aUyvC1XX3LSAraAY/+fxdDjjSnGbO2/xBbm4phFbBdjC/L5i7ULlI=
X-Google-Smtp-Source: AGHT+IGmU2k/lyis+ORS1Przc8TsMwvXKNF79BbCa68mAbE3mSZXt5L454XdnWssav3PoRuyR6LieA==
X-Received: by 2002:a17:902:650d:b0:1f3:43a8:bd34 with SMTP id d9443c01a7336-1f343a8bf08mr14146365ad.27.1716476344568;
        Thu, 23 May 2024 07:59:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c1364fesm257489845ad.249.2024.05.23.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:59:04 -0700 (PDT)
Date: Thu, 23 May 2024 07:59:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gedalya <gedalya@gedalya.net>
Cc: Dragan Simic <dsimic@manjaro.org>, Sirius <sirius@trudheim.com>,
 netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
Message-ID: <20240523075904.16f3599b@hermes.local>
In-Reply-To: <94d43b6d-74ae-4544-b443-32d8da044b75@gedalya.net>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
	<Zk7kiFLLcIM27bEi@photonic.trudheim.com>
	<96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
	<Zk722SwDWVe35Ssu@photonic.trudheim.com>
	<e4695ecb95bbf76d8352378c1178624c@manjaro.org>
	<449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
	<7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
	<1d0a0772-8b9a-48d6-a0f1-4b58abe62f5e@gedalya.net>
	<c6f8288c43666dc55a1b7de1b2eea56a@manjaro.org>
	<c535f22f-bdf6-446e-ba73-1df291a504f9@gedalya.net>
	<c41ee2a968d1b839b8b9c7a3571ad107@manjaro.org>
	<94d43b6d-74ae-4544-b443-32d8da044b75@gedalya.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 22:33:03 +0800
Gedalya <gedalya@gedalya.net> wrote:

> On 5/23/24 10:24 PM, Dragan Simic wrote:
> > I had in mind setting COLORFGBG to dark background that way, not some
> > shell magic that would change it dynamically.   
> 
> It's far far easier to just do color palette overrides in your terminal 
> emulator.
> 
> The "Dark Pastels" preset in XFCE Terminal makes everything just work. 
> Both iproute2 palettes work fine.
> 
> Anyone who really cares about colors can and should dive into the topic 
> (not me). Once your graphical desktop is up and configured you'll be 
> just fine.
> 
> The only real issue here is force-enabling colors where they are least 
> welcome (crashed server, vt, no mouse, black background, just let me do 
> my work please).
> 
> This entire discussion has gone way way way out of control.

Fits perfect with "what color for the bike shed"

