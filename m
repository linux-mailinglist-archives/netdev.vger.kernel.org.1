Return-Path: <netdev+bounces-70331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6C84E652
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76A61C21ED8
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2157986ACC;
	Thu,  8 Feb 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="wiNDdQ7u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6392E823CB
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412004; cv=none; b=ISITMDNzXr0zGK8mbTtom+Cd8lho6qWCU0PkLbfKol1Qgm7WZed9sT7QRmur1fq+M4HmzSTz0bA9J1LVtGjq22CTlXtBh6r0mANXxDH+x9aUfhOEpZgIzGhfGj33E5nAvg932vPnvUnsibd93Tu9N2Zx6hjZIDryDvSUOS9kxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412004; c=relaxed/simple;
	bh=MudUqbchmYjrWPSvF2tna/cqF5GzYn3jmA4bjDZ1p6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnXvguPQSGRavYRt3jSoZygfIiktvs4q+g/FLuxmtmElqQeo07CDohC82a4mmRvql8xQRNi523P6JCVtT9vJ/ZQu5BuPqT8CQwA0xqnMOdkd9r88PU1iS14VMQ57bb9q2J/e8lA3cdPwDlKiI3bTEWMirat0Uth4iwBoAsSMnGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=wiNDdQ7u; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d93edfa76dso17761585ad.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 09:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707412002; x=1708016802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qmf8wrmwq/1n2yS4+wOOvGU5rITTdiqLMpKhmCgz0KY=;
        b=wiNDdQ7u8Preg7C2e7mVg8T0N3X22bcLEVV0oIDMpJCzxpEl5NKS1DK/N/eFgq3Dri
         xw83u3dHJIckLREtHrOMo0JsQ17d/vxrxgCQuCH1BiNusXBsdr2autELA4WRM9vzs6gn
         /WNLZgpnPhGsnQGe15Uo0z8wDANDObc+ftuN7tW/78Rs8x4tMTOp+Cxtvyy3nG/cWNwC
         MXs/8c0c36ALBth9jqZ/dRSJ59D1nlQZVikPVAwSm6l39OsjWGN/z6RHmq/xJe1OG/Fi
         i66RY9pfcVj5q8fUkU8hwrvXTV25bxku8dtod0jS4P1J4ccLHV2gdZMSsh7AnL4eC0kK
         +cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412002; x=1708016802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qmf8wrmwq/1n2yS4+wOOvGU5rITTdiqLMpKhmCgz0KY=;
        b=EMtK614+Jwb8QB7CzhaE+mJPffb3dLmDjTIhqZzw7/vA0NZz2r4XcZImMaPkjiRUV/
         3XkY2tzFoGAnmxjOs/Odxd9OTRtjA26LwXg5WSsUJwJurXZnrR58z3HC+pBTGhtdcatC
         4GaD0aV8ZWYqCkfCq59JeWlX+VqR+gtv/pVTfFSWj8c7DbNSMB0crowVuYL/TKhFyi6D
         l8exWQkQFu3qsoeImuWp+Em0QyV6zNmt0jN+pLaMVEf2Ry1s4+EMOOWYx6l+8n3v9rbB
         2XeUvLQ6jzTlEIc4cOsc3dWBca0uFdV9ru5gqSVq0VX3gc8zp4j+JRrY/n8ovp/a9WTZ
         rfsA==
X-Gm-Message-State: AOJu0YwAHRpn8IDCavaST+tJ3yJWa7NRz/zbjB3woINxLkd8su/v6+7n
	/NtV715o2p9YiBNWUITS9rEI+iRAvkJvk1Vumf/pzCWrb9SWXZp6aVuxh1ZXa6y0OH0zUjdJhcV
	8nf0=
X-Google-Smtp-Source: AGHT+IFX+up2UCsjpMzaEI7ciGlPccru1Nr5sRUJkwGg2qeCN7qxZa+xFXWFBgVdhtijOAHrn/gO6A==
X-Received: by 2002:a17:902:a3c6:b0:1d9:e182:2bf8 with SMTP id q6-20020a170902a3c600b001d9e1822bf8mr7685782plb.6.1707412001759;
        Thu, 08 Feb 2024 09:06:41 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id lb5-20020a170902fa4500b001d94c54b3bcsm13285plb.264.2024.02.08.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:06:41 -0800 (PST)
Date: Thu, 8 Feb 2024 09:06:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] m_pedit: Fix descriptor leak in get_pedit_kind()
Message-ID: <20240208090640.79912da3@hermes.local>
In-Reply-To: <20240207214224.19088-1-maks.mishinFZ@gmail.com>
References: <20240207214224.19088-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 00:42:24 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Found by RASU JSC
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>

NAK again will break caching of pBODY.
You get the idea, not going to look at more of these RASU patches.

