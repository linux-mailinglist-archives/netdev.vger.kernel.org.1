Return-Path: <netdev+bounces-112635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1725E93A453
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 18:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AD61C228A6
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05566157A4F;
	Tue, 23 Jul 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xH9l3GUn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAC5157485
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751803; cv=none; b=WcSsPUwnroE2tT8rmzQBzCkfwzf8qT3eqkHqtG6fs5uEmBI3ntOGBZMHMSwShQJc0/RTg2c4bL3k6dbJ1FmhN6Y7QxPYb2ZGJtfl8XLruR9IX2OS3I3PrevqD+IMyD1naiWbf+ZLJWWIWuMLRG1d6hip9xOOcs5FlX5FXzeY3no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751803; c=relaxed/simple;
	bh=kpdoFInWtlxJOZhj4dvrriq72u3LXp+9lO5P+qNMOiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFIeYcvHmzTY8Da2pDZJlcydnlrxjwMSTDELCYyVa5gHGRKzKoJHrp3ORuSh8x/AcEBYtDfn7n3JjFbrS/4bTztNll3tejW8ruVIMWWkj09JIdJuKyHzFY3SpRNdAvo6sBDrKdcyO0wjpSJx0ZS5DnIkeWwMU5wzu0RehmzuNsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xH9l3GUn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d2b921c48so1589482b3a.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721751802; x=1722356602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpdoFInWtlxJOZhj4dvrriq72u3LXp+9lO5P+qNMOiE=;
        b=xH9l3GUneznNrMW5RRtyknN2C7j7LerJl4mO6zNpm/gucPAcNpxmbjnJKIt1JJLcXw
         LbleDTHS7rFnxk0NjhpKUkGBd27UOBNs3a3xpbrn4/eY0YoRJve5CmXzK2AKL/Q0Gs1A
         6Yu/GfRkKN9FDTmO2LBe1buSa6gsb30DYprIf2T8TZYgjlKLB7DEmZGidhHzUAMqOxxV
         c23HUFsAl0xmelc4FDsIbqFIqs0qaRiWzDEiuiWRzkoxXvovFvUlcNJ8wRHCbTDPWPsy
         R9p+2gJEyvml2zBm52hPkqzGVTJcg4X4x3b666hDb6AZRdbTVvif5HAPfdFYyD/ZGwv0
         BfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721751802; x=1722356602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpdoFInWtlxJOZhj4dvrriq72u3LXp+9lO5P+qNMOiE=;
        b=G3Ombkfv+4Aj2Ph5v3Q/l6S8r+5PdTyRMt3f/hfN/WDeKfXpblZA30uBEowi4Nyx5O
         TjgDdjxK5s28DDhWcTYgIVQaFQLa8y9uaLMIA8Ap4ehy8j/i7imYiN+UxWWxuiLQFDrx
         V2b9UokpeU7eosl9+zy8qK2+9ik1b83eoZGHU2+GbIi3uMy1aMVJwmZTIDo35kTJfq0K
         VaI+bBQHbr1ZZ88TeYVtX/FIRHiT3hmgHtKZN1j+Ld4HZterpgxVCIDzvgHpElKAKtn6
         ncmYsuL1RIgVb5YqXlBTfDqJ0wpdZe49VZ7MAzRm8qsKiSkEoHlm+A/Z4ChBUyQJj2vK
         Ys3g==
X-Forwarded-Encrypted: i=1; AJvYcCUe9ICHpBi+dLI/1rZLOwjrC+ZHGC7P3yFu4dwEQyceJtB+B0Iwsfrdw1TTbCdNrMVt2nbEbTNP3b7BqASh6UiMLeS96rjd
X-Gm-Message-State: AOJu0Yy2C3McjQwBNzaTOPvKCPYgHsoA6IWzCbXf9g5+gFeTA9lWNPyZ
	tROpPHAcnPJgE3sYvX+sQpFRCiPvYDVMbktJgyOk6U1byfbi9UbmR7nF0i5ntLg8M6B0zAD4Fvl
	uDg==
X-Google-Smtp-Source: AGHT+IEdrmmQ8dNE+UQ2eMIJEKbNb4VqiKAa6r4PqkqL/DW9kEBfHxhsJ2G1DLsSdKXyLOcokzwKIA==
X-Received: by 2002:a05:6a00:3a0c:b0:70a:fb91:66d7 with SMTP id d2e1a72fcca58-70e99701252mr348933b3a.20.1721751801320;
        Tue, 23 Jul 2024 09:23:21 -0700 (PDT)
Received: from google.com (120.153.125.34.bc.googleusercontent.com. [34.125.153.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1d998317sm4413838b3a.175.2024.07.23.09.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 09:23:20 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:23:15 +0000
From: Mina Almasry <almasrymina@google.com>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, kuba@kernel.org, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, cai.huoqing@linux.dev,
	netdev@vger.kernel.org, felipe@sipanda.io
Subject: Re: [RFC net-next 01/10] skbuff: Rename csum_not_inet to
 csum_is_crc32
Message-ID: <Zp_Y87B-0yp9Tl3w@google.com>
References: <20240703224850.1226697-1-tom@herbertland.com>
 <20240703224850.1226697-2-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703224850.1226697-2-tom@herbertland.com>

On Wed, Jul 03, 2024 at 03:48:41PM -0700, Tom Herbert wrote:
> csum_not_inet really refers to SCTP or FCOE CRC. Rename
> to be more precise
>
> Signed-off-by: Tom Herbert <tom@herbertland.com>

I checked that you haven't missed any instances of csum_not_inet unmodified.

The rename seems straightforward and unobjectionable given that the description
of the csum_not_inet field said that it was a crc32 anway.

The previous name also contained an awkward negation. Removing that seems like
an improvement.

FWIW,

Reviewed-by: Mina Almasry <almasrymina@google.com>

