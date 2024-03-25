Return-Path: <netdev+bounces-81810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C48088B286
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB751F358BE
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F42C6BFCC;
	Mon, 25 Mar 2024 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="syRlfbk9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE692F2D
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401565; cv=none; b=OybRLPn+STkQHpl8sy2P2123Xr0GY6iup/fkucLMwT33MKIH4yK1ORQt8TNwrEggIfyc+X7YGrZdhUXUyh5YbSoMrfYPbZ77IYeddElZc/D4m/8P7tvlZyP4HlandbnBFIyyTEga/eU3LHFM9DjaJBVwWsqTmUpKfpECeND28i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401565; c=relaxed/simple;
	bh=7aQV7YmrNGwyj1O4Pv14IPkEDZQ21c6ezWxpUiYzb6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhhM2d6zG1/UTN5pAkPuU6iDdJd+U4WZ6AmHXBUOGwSeEGpuBkp3yBtDYyxoZ1F3kNCTR6U7e4Wr3HKoFBLYTnRC1SodcVq94vvpyafUuPvW6AJTY6dd/HyUtxXJs1nHn0yC+fHYdTHbgAiK2qfHt17InglpheGNvI7dmyD2i88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=syRlfbk9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6a9fafacdso3647100b3a.2
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 14:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1711401563; x=1712006363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK7j7z853tLG8HE26hv/3vrtNLVGEZ6lWUljlO0dvaY=;
        b=syRlfbk9FxWrHdzkpodyT+VI9HwEGEWVGLzrjCw3RQsWJXigF/Nmmra01OXAXFHR5V
         UXZTLi/Og0SZ8ZS46W/Q3x+x9byrzkR/gY+0vGwxj3TOUEzSJdWOuwapm5Vfx141czj/
         7brai4SOmV2hTJy1I+B8gHB+WxB8KEql4CMOsBdj9oyYt/2n14jYqo1xh/zCuKfIAutl
         JD6dtNtd7CpwbMK3SXcmbfEtt/HWa9AZNhuOqepAyUmhpqg50bZGSiDNQ6UBT4FwhzkP
         lw1YJ4w7bm6h9uhX9jSHEdX74VdH4CeD7lnCWhS2yah8QGJK8ASeF5HpzksJFK26DXLp
         z2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711401563; x=1712006363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jK7j7z853tLG8HE26hv/3vrtNLVGEZ6lWUljlO0dvaY=;
        b=ZAgld2/JkSrh3ZR0QTkP1ffUxjNvrv5OpRxL093BW1NJa8d69F4zK7ep1tG7rBVgNv
         Xob5CjwfyLRWCBhAfINYx8PIO/kH6LE5yGgSL8NdrNz1DmPYChNQpKI86Chxsl1mBnSu
         afzMOa7ehnAc+U7yYZwKwblyRzGf9U1At3W1E/JsnmMRoaIWJCUmJR4oS1c/z6SCOojH
         1IA8nOWL52XXGZqYfeGYb6oTcwVOmFOsZhKAzoKqjPXe12RrB6VtRMiiWTPVoGqHMSfm
         DwXzgf1EoX93N4mLx7DF5dgyjFa/+ozRWqjfo2g+FVy91UwTJuGHiDCiWs8i4ORW5p1Z
         SHqw==
X-Gm-Message-State: AOJu0YzzKiqmRwy68P8/tHykj0+A/g+wOdni6myNBysE5sRmFDgnr8lN
	LcQA7pqotuQAEZI1t6n51SqFXT3JJnxnh//5eXMlkjCrCH1U/YCLfdFZTm+Mag91RISc+Zx1xx0
	a
X-Google-Smtp-Source: AGHT+IF+3YxnJKtcz2grlg/ZOun7ogqce61Mngu60/wUt6KTTW2xgG3H/ZnXod/OpnCasA/rq56uGg==
X-Received: by 2002:a05:6a20:1054:b0:1a3:4660:1324 with SMTP id gt20-20020a056a20105400b001a346601324mr6134747pzc.20.1711401562753;
        Mon, 25 Mar 2024 14:19:22 -0700 (PDT)
Received: from hermes.local (204-195-123-203.wavecable.com. [204.195.123.203])
        by smtp.gmail.com with ESMTPSA id cp5-20020a17090afb8500b0029c472ec962sm10548703pjb.47.2024.03.25.14.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:19:22 -0700 (PDT)
Date: Mon, 25 Mar 2024 14:19:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] ip: Make errors direct to "list" instead of "show"
Message-ID: <20240325141920.0fe4cb61@hermes.local>
In-Reply-To: <20240325204837.3010-1-yedaya.ka@gmail.com>
References: <20240325204837.3010-1-yedaya.ka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 22:48:37 +0200
Yedaya Katsman <yedaya.ka@gmail.com> wrote:

> The usage text and man pages only have "list" in them, but the errors
> when using "ip ila list" and "ip addrlabel list" incorrectly direct to
> running the "show" subcommand. Make them consistent by mentioning "list"
> instead.
> 
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>

That is because ip command treats "list" and "show" the same.
Would it be better to do the same in all sub commands?


