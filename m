Return-Path: <netdev+bounces-177251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F66A6E69A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180581890B80
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC00192B75;
	Mon, 24 Mar 2025 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBlwv313"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878F035944
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855570; cv=none; b=EF318JhkTqzqcZahd6uiJrfpO1Jqr8GNOEGIWj78aFTp9YRKVzCZOQfFCXftlNIRB9TCuDTn3tSH1sx0038qjteRyhcLbD2GiNDPNXvceO/NuvBpcwiWKTZwMno+Pc+YR0s+ihWpf8OmGignbyYrvpIGKUjhCsKfgprS8V4EKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855570; c=relaxed/simple;
	bh=ebo/ZpJA7JESxl003JeTcfuBdb+2v6IpDnphTeBxybk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmW1Xgb2b0gKWB6jrKwSLnwRIrAEh4gazn44tsNmIjY9RoxOf1CO8+WAG40kP616+nuPRfVDenPMwvlJVeP1b/pZ1eg/BSKEwHduzkfjkXmfBGcnsdS9ztWcPfhHhOe0j32WYPFP6GIVZQomPRxoPMJAn73iFaTIYtgUrg6NmzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBlwv313; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2260c915749so65026605ad.3
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 15:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742855569; x=1743460369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/1HJWPNlR/yseKGXxIqgpUwzgY58AlzPfOhvKFbYDvI=;
        b=MBlwv313uFN33HjVAz6cyBw1bRi5qE8OIBPPMN+DijNh8CnFDRS93NIIYc2kFhLh2h
         NG/i5MnQVC0hSJxSxCARxqIfUd5wKjnRz9EtdLZKty8CcypknrEg+FbEMqE4qMlJtWeu
         h/Ua+CIC5CwNsIA5Dy7sNGTgpwULDyo5JhdtjFwRbhfkZD6fkVJiM4IWt+xuRQsPPbMv
         l7JMGpEtTGqpHJ4aGzTfnj+fij0uq3r7xDn6abh5NeQWZt1qdUTjAoRmfxU4hB3dMo0n
         OL+PEgtIBGHWscBkPquDvrR1H7+PGsNmDfFAkyNJm7VeRJBlciSfNIDCX2IJJueYVl+R
         IPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855569; x=1743460369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1HJWPNlR/yseKGXxIqgpUwzgY58AlzPfOhvKFbYDvI=;
        b=kPv1MaorYYIJBUReBrpE2NXrknpkW7TNdPdgpc1PHkFclZsYKlWew8gH6gx2gLurSn
         rFB0fpf4qn+BOEvgII3PlUns1eJox71ZVWrO9xVtM2JNJAJ+Mdqvi6nL/JSg8jTzBzg2
         DxJ16EjSj3PMHo7VHlrZqbPZW+YgQxaaG9+AgRSW8dSYFH5OoXK09bhHMdXI3KE60uFC
         bdG0awYqRaST+Do6jVg2AqMtB+M9TFu+/U20RoUGUOaRd7ysGwf5pieFzZGy1TURODz7
         TgTLmJ9BhDTISwS6SNfNotExyxj+x6YDcvdhE4KEWIBHbNqZp0rVhE5iNa1eMI1i2VZs
         7JPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNF6pYEqod0UHjxO7vgTQMEINKHPKVVPI1QZLTTVD4oNnGsBJiN32Ofn8B0ay9R8gMhkj2dCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvOIP/IoK7viycaIQLhZN1K+y0sG1zuZfQJ//W3wltDJE+18Wc
	1/9ChuGX8a2T48E/FahlkADqVyygSBkqwHEpKJIyODhuoi1GFTvgNJpkk6J2Mw==
X-Gm-Gg: ASbGncuiBVXKTQG9fVMuEvtav6lNQM6jOs3qNisaOgdG9yAfBpzgzYn2pQiUPuzcpKB
	UloITpdFKsOCRerCYFlu5MINljJqrDnaoTZbvFx589CFbuR7Esi907DteWDQonX2pAikbgDIOPV
	ecjRQU7WaWW5XPR5EkM8A95Uj7BuLir8cCbX301VKrx7ZwlCFsz/62Gtl/nPJ4EO/hnLK+qpa7F
	dsicsnONXx7JAIfOg9m7kaNEALswyarQ3A2gkvtkAccJY3/d0G6/emM8EZepQOS14N2CU0WgBkx
	gLK7q+qE1ZWlBlbtLn5ALf9kzG4FGmxtZ1uAeOQ20v8A
X-Google-Smtp-Source: AGHT+IFOGcuS1XTOkY5Ix5qp2qSjH0lGTU8WkXvnmoPw5bq/8TIm8bQrunmJXU806iBgFQ0eWoh/8g==
X-Received: by 2002:a17:903:22c7:b0:223:3630:cd32 with SMTP id d9443c01a7336-22780e44f87mr216289905ad.53.1742855568494;
        Mon, 24 Mar 2025 15:32:48 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811f442fsm76690575ad.227.2025.03.24.15.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:32:48 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:32:47 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
	mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] Add xsk_rr an AF_XDP benchmark to measure
 latency
Message-ID: <Z-Hdj_u0-IkYY4ob@mini-arch>
References: <20250320163523.3501305-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320163523.3501305-1-skhawaja@google.com>

On 03/20, Samiullah Khawaja wrote:
> Note: This is a benchmarking tool that is used for experiments in the
> upcoming v4 of Napi threaded busypoll series. Not intended to be merged.
> 
> xsk_rr is a benchmarking tool to measure latency using AF_XDP between
> two nodes. The benchmark can be run with different arguments to simulate
> traffic:

We might want to have something like this, but later, once we have NIPA
runners for vendor NICs. The test would have to live in
tools/testing/selftests/drivers/net/hw, have a python executor to run
it on host/peer and expose the data in some ingestible/trackable format
(so we can mark it red/green depending on the range on the dashboard).

But I might be wrong, having flaky (most of them are) perf tests might not
be super valuable.

