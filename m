Return-Path: <netdev+bounces-63115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7034782B3F5
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 18:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB5D0B23A77
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027D951007;
	Thu, 11 Jan 2024 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="A/RRVrC9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368652F90
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d4ab4e65aeso42384655ad.0
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 09:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704993708; x=1705598508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hw5wC+No1Hepsn65/qRkL+nn22p+/IRmjt01iDEiUqg=;
        b=A/RRVrC9j95QiZdDXKDbTqnS/o4JE/7UMnz3tlmslHZFC/cOL8omhtJ+yyNRDiEEhn
         X7c49BUMJqIekcCszsCcUOK/fXZvMaZG9s6TRqi9iub4OZeMhrxc9pcQHLhrgfey/7O7
         tnqB8qr5uiIZDrSIsu/MRehZmmmHtVW2ILhxU+4bFAjZ0GVsiu5xSvmpKNcu8qe/coe2
         /OvaW8Q2mva4gaQlEpvE1s1yWbB1uZfrHXtSBfrLUBxdslLXbcYVqIVQYNG2MKyXFk/9
         tRTJCQetisk+VTAa91/m3XwhlGk0ifbKTn/1xvtpn0mkymRENcIfsoR8ya3k8Bt7qOjz
         AYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704993708; x=1705598508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hw5wC+No1Hepsn65/qRkL+nn22p+/IRmjt01iDEiUqg=;
        b=k1hI1Dg/LBsHYhXQh0yNRQMz3wlkIuyyzWxNjJKMinjcR6UWGnMBaXWdd98ClVAaKR
         kR1YNTsmeJRUR4EglY43NW0n6pm01JEVT31RbZFLEz8RE6ABV8bJVsLL8M8YP0n7uT/3
         va3JXKPagFKX7IrbUe+e6QSGFVOe9nCQkycOlpN6WIxacFFSPQLUO0IPdjW92D9FWwV3
         ruBXCDJjgyYKE0nYzbAgTlZj5jUJ6Ym4HoEfCGlXqnSH3MeBQ3QvnoQP6t3yyZsPSrYn
         TMNIHyRmXMTSGWRLy7K0WaL0z/m7kD6ShVyXhXaVY9Ahk9F30/agtx2/QdQ5vDgfHXP/
         Gbmw==
X-Gm-Message-State: AOJu0Yy/TxJVBAI4jf5MSVRDy5UGXcomQS4FeX7+OHWMS+cc2NZ5ciMu
	p/tCUDefJlMPYjlmsM+Z8BO3ml6GpOxmcQ==
X-Google-Smtp-Source: AGHT+IHpXqAD326EQONoqedQDIa7W9YN3XBHRxAFL7Vl6aeaaHOu/IhQzMlLqfOrJIFcblpmGqRmVQ==
X-Received: by 2002:a17:902:dac5:b0:1d0:4802:3b6c with SMTP id q5-20020a170902dac500b001d048023b6cmr224118plx.4.1704993707699;
        Thu, 11 Jan 2024 09:21:47 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id jd15-20020a170903260f00b001d1d27259cesm1400461plb.180.2024.01.11.09.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 09:21:47 -0800 (PST)
Date: Thu, 11 Jan 2024 09:21:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Jon Maloy <jmaloy@redhat.com>, David Ahern
 <dsahern@gmail.com>
Subject: Re: [PATCH iproute2 1/2] docs, man: fix some typos
Message-ID: <20240111092145.7de8c2d0@hermes.local>
In-Reply-To: <cda844f5f7fe512ca9b7f87a6545157394b9d9ae.1704816744.git.aclaudi@redhat.com>
References: <cover.1704816744.git.aclaudi@redhat.com>
	<cda844f5f7fe512ca9b7f87a6545157394b9d9ae.1704816744.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jan 2024 17:32:34 +0100
Andrea Claudi <aclaudi@redhat.com> wrote:

> Fix some typos and spelling errors in iproute2 documentation.
> 
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
> ---
>  doc/actions/actions-general | 2 +-
>  examples/bpf/README         | 2 +-
>  man/man8/devlink-rate.8     | 2 +-
>  tipc/README                 | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/actions/actions-general b/doc/actions/actions-general
> index a0074a58..41c74d38 100644
> --- a/doc/actions/actions-general
> +++ b/doc/actions/actions-general

I am thinking about removing all the stuff in doc/actions.
It is in rough shape and doesn't really provide more info than is
available elsewhere. My preference is to have information in only
one place the man pages.

