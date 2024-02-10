Return-Path: <netdev+bounces-70774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256948505A8
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 18:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB99A1F25436
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3015CDE2;
	Sat, 10 Feb 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="wxwZj/EJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801B65C8E8
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585534; cv=none; b=fuViIXRqhcR7He8Jg4O3E1DVyOcHl086n9V0Jcso194cSX663AFBcA9oLCCzcFskARAN0nnUYMFR2OKx2ANKNtZ2VMulqB9NdjbhrIx5SByJs9FRzLEr0twTvSXiUEh/TG2CIAgKF6EFqEEn4UlXHCQpvdsn6theW4FrvoZuLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585534; c=relaxed/simple;
	bh=YHVg5c1fop9V9/tlRVi6Q+MmZLkdquDYXCZon/zLaq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNHOd0ZB42sGqOSlwM0P98nyMlsFspCatrKR1R4ka5q3QoE4vTXTEs7pr0Yd0z/dYiEiTn4PdKaKYsYlv3cbF+LGUe7OZ+MQAVXS7tbNegcIEOoZgQEMW1Jx6ycWe16x82NF8G95hl0s1zQjUKlpdWVOJ/y2OX2EiiKA3VdzflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=wxwZj/EJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d8df34835aso1483312a12.0
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707585531; x=1708190331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dqo5z7wPlVcN8hVdZJTdSH+25F7F/NafO/e+3YnXVpE=;
        b=wxwZj/EJcrVYo0KusC+AuIYj5dnf50GAvNp+mSMD1BXSlcaE6z1ULNoQ1rnindkEJX
         fr/wyU0QGrWX/tooAz3cAUT20N6YFWR3XafVQKhxgJX7WLIG+lbFQe9wazzoran7tq29
         K0xYvTD2pUQn81PDTzt2HtoIx1GI2zi3QJZxTKHKPCukPU7d9uJWFwpItaFeD/itYeDd
         PPFHasVE8PbGOJg5/kgK8N6iVanqKRaXPPvspccMKzUDb2ZOLt5wdpCY3wmeKw3htB20
         eu+St9alcljOXyO6ZtI9b+nGO1D5W0jhE4UVpnBOfn9HBPz19QHUcZsnGlYjpwRNP1pC
         VrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707585531; x=1708190331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dqo5z7wPlVcN8hVdZJTdSH+25F7F/NafO/e+3YnXVpE=;
        b=Rbv7FXVGQrpN8N7BHAYVksa9JRh5dImjVeWY4ym01/qQS2hX52b04e4MTcmdIEu/rf
         Pk4bd9MoDtRkOZwXNXI6rONaXs+TzqPxDoAdo/9stzbjCnWTtIlIyigzGrUINEzCTwot
         oXEbMq7Szr9FJSCCCFOPpdUKykPl3Bp5qDF1LNY/tsSRH3XTmAod6uzjJiVhAEndb31j
         rotZUG+uKYiZInseB1IbgQRoUYKIe4eOQon7hQ3SewMmFtTVr0LvVP9MkbKIHhjCI110
         Vt7CNHXohSPh0zH4FgHhtJ/5vwyRF8wzqzrguSdQN4DDq6ssUKmanGRC3IbZFmuNwCfx
         SxTQ==
X-Gm-Message-State: AOJu0Yy4eugsbRJ08gd2PJqqXZLTcptr08gko8VHQJ+nfAkX1lx0OGj6
	pJXIv7Cue1Q9QQTkDxrDB3Mqhg/+SygTp0CA1SJcaxypmuO572FGQuxppwEaSWn+vOGi/q06Ffp
	l
X-Google-Smtp-Source: AGHT+IE1tm7k8WVYQ2t5Q9PZ9jVGH3jkj42pTzxmASE6HScvnuszPppb9UiRYrKTGdcAQMQnlw7etg==
X-Received: by 2002:a17:90a:e643:b0:295:f706:add5 with SMTP id ep3-20020a17090ae64300b00295f706add5mr2959169pjb.24.1707585531622;
        Sat, 10 Feb 2024 09:18:51 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id gp8-20020a17090adf0800b00296b62d9793sm3743312pjb.3.2024.02.10.09.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:18:51 -0800 (PST)
Date: Sat, 10 Feb 2024 09:18:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Takanori Hirano <me@hrntknr.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 v2] tc: Add support json option in filter.
Message-ID: <20240210091849.77f9c634@hermes.local>
In-Reply-To: <0106018d927d04ff-efbd5d4b-b32f-4b39-a184-a28939608096-000000@ap-northeast-1.amazonses.com>
References: <20240209083743.2bd1a90d@hermes.local>
	<0106018d927d04ff-efbd5d4b-b32f-4b39-a184-a28939608096-000000@ap-northeast-1.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Feb 2024 10:08:03 +0000
Takanori Hirano <me@hrntknr.net> wrote:

>  	if (tb[TCA_CGROUP_POLICE]) {
> -		fprintf(f, "\n");
> +		print_string(PRINT_FP, NULL, "\n", NULL)

This should probably just be print_nl()

