Return-Path: <netdev+bounces-127540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2338B975B5C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF24DB216E1
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7811BAEF9;
	Wed, 11 Sep 2024 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TaWJl/CA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC131B6520
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085353; cv=none; b=jgK5IwXBf3jx8QxtexmbGLsZBb/mjh/44/tlD7oq4Bu2zvdC8R/dMcnHl566eTMQxj31qugPgoc0cmJIEiCe1FHgDTi+Cn3zRXdRhd7tU3r7AA36G2UG+KoXUf2KzivGcX/3xryAZL6gFXNLC1i+2b7qHds6WxJoq1oCqVgxpX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085353; c=relaxed/simple;
	bh=r1JOqL3SMuhLoG9ZrTANujvTb8IR0/561m+yfMw290k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7qL+QqZIMLaXEeVm4u9s9FhHXEJOBO/WAhWi4ugg6u3UjkuFshVcMBe0k3Vfx+dzwTak2O1kTLfRTSWZE5a6j/snnIW1gzpPEFEyekrtShXLZ+B3bgCwOV0pK4v3kaXFDJ3O8h7nekbja0qm8lcHeapCZrTzUw1FLgJOCeiHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TaWJl/CA; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so39345466b.0
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726085350; x=1726690150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1JOqL3SMuhLoG9ZrTANujvTb8IR0/561m+yfMw290k=;
        b=TaWJl/CA71qt773CNDROhpyTbON1eFQ+8tR1Hrosh3cR40+UVaj/xjc1Xo+EHz33E2
         WcI/ybRpTGA6nnxDQI3C+uMOkqIQ2j6ibTLC4mN5UkEzaLoltH6QWHrrXHHd0qQcq/B6
         fzQ/+/P99PkN6mQvQ3Iapneu6WzZex6Zjxlks1KqpOQTF/Lv8owJPyqQ3B04XImDm1ak
         m2w9UfnXPgPEkWRa5FUqdD8lhB6PSCzxjUGbE+755tMSKImTDjayiuo3O0Ue37/eeLD0
         sE5YMKED7AgHyAGhRh+gaARAQfCqIVJg4b+ICwQbk/b4ijptnFDfu7ipCe5UJPsVjOPN
         FvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085350; x=1726690150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1JOqL3SMuhLoG9ZrTANujvTb8IR0/561m+yfMw290k=;
        b=iLmdqQPsYOFm+bRDD5pcjPDGwCkKnrYc/X9pBse+6pLi/EuNHRcdsc5RoGKWQKSqOp
         CkplX7M6K2CAKbxmr/HstSQX65wOqIINivE62J7A/zIauzsX78g/W9CUPv0tIEGi2WdY
         cFGaB0Axj+tw40Nj1NGIi1YA4665WKBql5jVIVJpz2kqlNAhCMFBNuqtj5DEuMrl9MUs
         GYKIktGKat8G1FFAyX8RsgCfrATwWY/82uGzcgUw9BGTpWqZ9jsapYYNZGHt2VWnAwrk
         6dtD/vcf06eoWl8LfMQRwNwnFs2y3CE3wK2iDPmOVLZoVFcMMDQoB3ckemku6+k8fRqP
         y/7g==
X-Forwarded-Encrypted: i=1; AJvYcCUUnmtH/GVw2NoB8IadeqkCKgTt3JlzmsfQvuExTohd0GDKrvQYo51iEJpzvTHKLP4JCNByAcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWHxZS7zru5E1rxUPnVq8e7seHI+xnRxNbmHM/mgvHDglCxIcT
	F+6FoyGSc7m6+o8URXzFvRVP6j1LIB0y4bHipjHNP6WyP2kiL5UAjkkCZ6r1Obs7dTR9plZ9+rK
	8UOcTxNTZ1LusJMMILwYZjspc6tWr90l6p9o=
X-Google-Smtp-Source: AGHT+IGWDQse6TyscgG5CfIR+8gOsyQKavEm8292qY8ZHQsZge2FuH6Ti9KhFX+uKagr39m9dkmwP219Kf1Yc5vk1VI=
X-Received: by 2002:a17:907:6e9f:b0:a8d:5288:f48d with SMTP id
 a640c23a62f3a-a90294bd976mr51828166b.32.1726085349509; Wed, 11 Sep 2024
 13:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-3-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-3-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:08:57 -0700
Message-ID: <CANDhNCpPnU7-=QWU7hWWn5LOCsb3kJFJ=VwyHc-b0ssepE6SXA@mail.gmail.com>
Subject: Re: [PATCH 03/21] ntp: Clean up comments
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:17=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Usage of different comment formatting makes fast reading and parsing the
> code harder. There are several multi-line comments which do not follow th=
e
> coding style by starting with a line only containing '/*'. There are also
> comments which do not start with capitals.
>
> Clean up all those comments to be consistent and remove comments which
> document the obvious.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

Thanks for the cleanup!
-john

