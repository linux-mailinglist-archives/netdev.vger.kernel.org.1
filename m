Return-Path: <netdev+bounces-196159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1360AD3BD2
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1651889508
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29CE227EBF;
	Tue, 10 Jun 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="qpK/GqGK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD2227EBD
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567364; cv=none; b=o8L5pHTDK5WRPfLnoi8HAQVtEdaz2acQqfmv9CFJ1AonKknFPjhlW98ybG83kEoGfVWdIwItAFtqkjjZLplXBiMEXNlaN2+bX0lAG/kogjl18D3TNvIs6hEjKx/j7/BD86j9ns8UFSK5tsd3riZ0iPLIdWKhm8JTrXieHnHbFhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567364; c=relaxed/simple;
	bh=GVOUbnW5jIXSY7Ry4t+OeajU9A/jIbzTs+m7docZlH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=np4BJJVvhGvL7bts1s9ar35ylgc9bLGQnLicr4y0BgZz9o2pMeCv9ly+lCmpykikK1Exj8eKFRqmgHGm1CdbKggxfBVoNS4rq7vbPVguaitb/CQyWop95zrCO9WKQco/3RixwMtfGpbMMv7I7xnzxJa5pb+cVnAZji1pi9bmhN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=qpK/GqGK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-604f26055c6so13067000a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1749567361; x=1750172161; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gfPA4Z6BxTYC6N2EpfH48xk58qxXay44PVya1GG7JW8=;
        b=qpK/GqGKcAZ+SoSx0Oz8TVBzHfblaeqThM34P3Ygk5VL1CLoDUv1vB7EI6gD/+9BMz
         65408xB1ZuEbZlADq9nqhto8DODuXA4Why7FtsvDbHgu+g/V3QKBLLSQ7BbYyzyn2lY5
         cKQ6AS+BJf2QBFAoEPlgE2HpaUJsXVSszhnTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567361; x=1750172161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfPA4Z6BxTYC6N2EpfH48xk58qxXay44PVya1GG7JW8=;
        b=GONopoAgvxbOIE0i6OMBEYLI+xFs3h5J1w8fMFR1Av5b35ePZGA15R+fkJHTCuzg5o
         HC+mMyTMwoBA9CxoVqBJWux+Zm/eBiD82rWIVpjJnybITV7qlL6v96Yn0SINeFIygiWL
         KGYQV1/iqJRJKs5gxhEZOcdcd+zLGKCK1koB9Wk6/AtmXMN9lFgb2kV9NPWekFk2oDLK
         4p2AqZi+vpULXLtuDZXIccJAmJHMeR9df6ZwFao230dvuNP6M7Dn171ENQRdhOt5nmiB
         qFVQZfxB5culXQKpfOomJIdsII+RUQ52XQH4NurjDSCEpOB6jZyuxKvILKz4WrqCon7d
         zS4A==
X-Gm-Message-State: AOJu0Yx/cYWxeX1Mj4giF3F5ABaTepXHNEeuLFR81vbdTvF36BzvqdI7
	zWN05z9uhTlj8+E4x0vCSAxwvYPzQn7pz/f2cac4W57pvPuELkozBAJPzVECdhJ4kDA=
X-Gm-Gg: ASbGncvxRsz3V7seu9KvGYJDiLv4d6vXzmj8AwFmjSrU05/SN7wWCo6LPBmjELcMaMs
	2kcKwS8GCYFN7JRgEGHdlCUknzV53b84wCddnSlzDHRBR+PFjw7HMyiRjmib9Ks88+HVoRyk6dg
	0lQAyEqj5QnCF1GF5V6oYmI1EjaTR7iAH6R+xr0iJ+hGtBiBddY7k6b9fdCOUBGEiO1IZtASQgF
	u7dyXV5NXIT2rgsA8Hw/Wdqs7vv5pnZlWFAd6+HcO/yTK7/RsGGcq7Y4IukDLt9oioM0xZG6o16
	niCYLgwlXTV5iGbvRo5m/YXAVGqkBZtIT4H9cwrW8mJfoECuu3mtbIacJG1rC0jBxxxc
X-Google-Smtp-Source: AGHT+IHasQyxnP6iCm69PqEocDdDJHgCcsg1ZM7bbSpyJcd/F6NmBykWd20csi2fSemw5cF4+YVRRQ==
X-Received: by 2002:a17:907:9494:b0:ad5:7048:5177 with SMTP id a640c23a62f3a-ade77308c74mr294442766b.23.1749567360773;
        Tue, 10 Jun 2025 07:56:00 -0700 (PDT)
Received: from carbon.k.g ([94.65.219.179])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d754f8bsm747859766b.17.2025.06.10.07.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:56:00 -0700 (PDT)
Date: Tue, 10 Jun 2025 17:55:59 +0300
From: Petko Manolov <petko.manolov@konsulko.com>
To: =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
Cc: netdev@vger.kernel.org, David.Legoff@silabs.com
Subject: Re: wfx200 weird out-of-range power supply issue
Message-ID: <20250610145559.GC4173@carbon.k.g>
References: <20250605134034.GD1779@bender.k.g>
 <2328647.iZASKD2KPV@nb0018864>
 <20250606140143.GA3800@carbon.k.g>
 <3711319.R56niFO833@nb0018864>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3711319.R56niFO833@nb0018864>

On 25-06-06 16:42:42, Jérôme Pouiller wrote:
> 
> Do you think your power supply could be unstable with your new DT?

The DT says it should be 3.3V, that part is OK.

> The voltage values reported by the driver (-21 and -20) are obviously not
> correct. Maybe it would make sense to get the real value measured by the chip.
> Do you have access to official Silabs support to make that request?

I'm on vacation and unfortunately my replies are delayed.

Funny enough the actual voltage measured is 0.65V which is way below the nominal
value.  It seems that i'll have to debug the stpmic1 now instead of wfx driver.
:)

Again, thanks for your time.


		Petko

