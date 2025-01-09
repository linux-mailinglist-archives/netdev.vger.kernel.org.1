Return-Path: <netdev+bounces-156676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2358AA075AF
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9AA3A87B9
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7FC217F3D;
	Thu,  9 Jan 2025 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWH5MqKX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D95121773D;
	Thu,  9 Jan 2025 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736425406; cv=none; b=NZgR5SNbyRb9AIs0LA03pZMlITlDOq+1NmgOmGDyMawZbkdM2K74xFkMj7XOaXIs6tZKGX3Mr8t3S89C70zwm8acLbglqoSTcNWvbnI6qrmjxTjEow825dp7/197H96oXpdROqXJNfWcLiBWKhSxmMmPgQ3UIIoMivoCSo0RUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736425406; c=relaxed/simple;
	bh=rZKR2l04Hhezdm1fat4M6jFM9qd2zpHfQAUzFdZ/lEA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Gx/fipTmCPh8P6f8/hOGw6mu+0/B15JBjQkKoSvoCPKj0JJexV0NgrzrwC9zS4LeNo9mKBB+mSSde2MUbGsYPaUuxusYlWgiwcUUePgYD40kQMhTiyR3cvZFeIgAO2ZCp99l0+nOC/ctOKqjABHP3mdjexbW469hmIawhnAZu48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWH5MqKX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43623f0c574so6849475e9.2;
        Thu, 09 Jan 2025 04:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736425402; x=1737030202; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZKR2l04Hhezdm1fat4M6jFM9qd2zpHfQAUzFdZ/lEA=;
        b=IWH5MqKXkeYMZZ9ZVomsVTCNzv5MoaDgmqCdzV9HHuKrja7u1jK515BjlL3uTlIQfF
         9YEjliHQKIc52ypIecMyUsWDp+aEaD2GVO1ZZv1HUEjZLL8gFrTdhBIcD10NIW9V+vra
         eJ8CF5UeuCcUE1wa6QFz/Aw2HOBE8kQgJ4qCxA3UmGDU257goHWHFQ3kcDLLrmh/1Ehf
         YM9W+pH5tZSFBpRoGY+WJZ47QcqXiNEiV5N6kvOPMtD3vnCcwInHaJYYWQhub7ORLc1v
         OSOIUKxh+tHq1GeDF6uXJYtaQ7p8RGRIvhXZb9LQQKPvzf5jX6R7bBYPNhkmNUVCEQbE
         ePLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736425402; x=1737030202;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZKR2l04Hhezdm1fat4M6jFM9qd2zpHfQAUzFdZ/lEA=;
        b=s5On3Juhpn4z8pn9BWrcKzBrN99HkxkAYCmhazV1fSksDfFj3ei49jzVd2dCVbCDZA
         7w1e2zhRw2Jm4BokRIQ3RJLjaL03LnirFn8LMPibJkjJR7wHvas9c1zMIuEBubHUYt4O
         FqWAKNq1+SV5LVCICNuk2VNikXvJkspd3GqHxHTmu3naOEFpe1NDr53XE3oi44xoRLl/
         V1DlvlVcpV0jlcPUPmkwijArMrUHgb7y9Qk/HYikgIKx2pkZuK778PhMuxRPRtc1wF5Q
         kSKbhZwGAoQanSi25waky3fY6JK0fNBPnViWQLtt0fGv6/PlchdLMjsVQ1fg42ObRDaP
         Uwsg==
X-Forwarded-Encrypted: i=1; AJvYcCU0raksen51QxbyXzUvPpVqxVn/ezhx4jiwOiYQ9iTt31UKNNRdz/LnFxIUme9j8/r3RtgSnKRV@vger.kernel.org, AJvYcCXruKmbwbv/dJR2zhR2J3Zs10x8Mi+q7Jr6osojlrvv0IYVPyXIPrpuUMuavkqj1krcpK0uOETJlkS5hPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeawaLhlLeIhkQRlL0JQAgofgVHhUqG7m4hO25qIVSIVcoav7w
	EmW0INOWMRmJg8A8itORrM77l/xstWgnv2Jek/AYA4KEqe0OTdJGDJ3XeQ==
X-Gm-Gg: ASbGncvpDXAobI9mr1IEjybGf+e/1GAfmNtEflf0qhZkWHo7IhC475x0YWqo8YPqv6t
	2CoR7MrPCLGIvtlKBccAq8tnWT0tptcR2xJGGhIyHtVyEFvehZys5ct1kjE+iQ6YTKG9oMMWiwv
	Y/0IdqK2V+VPfF39pFCiA7ydzQ8rQdcN+uUpYqeIBtrqqD0rSzLJi96AQ05L6xZMOATkBbO26Nz
	DDvCWpJPMpN1FrN0L5X44cj+CIe6j+uZR/tqRYnoWREPlxXH3MYuSmCEYKJyWqtyKl8ow==
X-Google-Smtp-Source: AGHT+IG9CZxpfozpY653yun0yVD6nhni9k+FD7iXNbXx4YchsTVS2ugr7eJ8Fwr7soELyFR7ltUtlw==
X-Received: by 2002:a05:600c:3c85:b0:434:a802:e99a with SMTP id 5b1f17b1804b1-436e267821emr57678655e9.4.1736425400684;
        Thu, 09 Jan 2025 04:23:20 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:1cd4:f10c:6f67:2480])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1ce5sm1710942f8f.94.2025.01.09.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 04:23:20 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: stfomichev@gmail.com,  kuba@kernel.org,  jdamato@fastly.com,
  pabeni@redhat.com,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] tools: ynl: add install target for generated
 content
In-Reply-To: <645c68e3d201f1ef4276e3daddfe06262a0c2804.1736343575.git.jstancek@redhat.com>
	(Jan Stancek's message of "Wed, 8 Jan 2025 14:56:16 +0100")
Date: Thu, 09 Jan 2025 12:20:37 +0000
Message-ID: <m27c74mb56.fsf@gmail.com>
References: <cover.1736343575.git.jstancek@redhat.com>
	<645c68e3d201f1ef4276e3daddfe06262a0c2804.1736343575.git.jstancek@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Stancek <jstancek@redhat.com> writes:

> Generate docs using ynl_gen_rst and add install target for
> headers, specs and generates rst files.
>
> Factor out SPECS_DIR since it's repeated many times.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

