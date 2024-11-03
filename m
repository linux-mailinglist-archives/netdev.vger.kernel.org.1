Return-Path: <netdev+bounces-141300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6749BA680
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 16:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3FA281788
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E31216FF44;
	Sun,  3 Nov 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Fa7bho5a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D4E552
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730649497; cv=none; b=NUWZot4W4i89gsZ1kbTugs6E89dVl2/px9jE7Fr7ay+Zst/0Yovz7kkgENFwbxFdRktdkmGw6vfFfw0aqZ4LF23GkkQg/zLPIYYW5KwdMFjqCosoBU5jMnQqz6d1i1Rtzjloajsk4z6PhWaKctRbvRmkwOtVbI9ys8lhmzJ9l8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730649497; c=relaxed/simple;
	bh=HWBgZkUmPVzrloXfNapbzp7PFPfVFmC8qPxNcKxNmu4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5htJknQCW90HRVAWK4usmNo2UkeLYgIuNOQ7j5+GV9+qSWrPP8KBWnW05lghSq3gBLKn4+n4GpuVcXvQ9fnOs6G4U1GxsVoZ+qwNME08xHWZGg9f4Wf3W+g2L0xn7DeDhNTz1HgpNigNdq0Gx8HiND+4vuL7RPTryIvUknFnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Fa7bho5a; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-72097a5ca74so3193787b3a.3
        for <netdev@vger.kernel.org>; Sun, 03 Nov 2024 07:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1730649495; x=1731254295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3383YEtkHYFgNHw9+P2FH1a9C7KzEvqX5tXyfqkibcg=;
        b=Fa7bho5aw53/PZxi2uHqebCTKZWR8mPuXRS81TQmb8HihlkqkZ93WzoqEarrXZd4tq
         NbmaEMK2/iovxdj4L//NFzRXdMbSS5gsKla9d4aIk2vErkucoe2twIRWUA2ei3xAyrIm
         G30xijey/VD0NW9pkVEq7Tdkvws/51QDv+7NSksFzYGBoC5guhrmTqjeOks+DYCacDqi
         BIIxEFJrL0tjo9sxYbQlN8C7U1ABB9M9z22GIE7XZC8jX8t6zpScM/CRAzL0zorzVcrk
         gMjckBywJo+WzFYFIgG+UtKrjwtlo1yVxoxcigGkXQfcK2pXzHjUffS0RUnqvXseya8O
         jajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730649495; x=1731254295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3383YEtkHYFgNHw9+P2FH1a9C7KzEvqX5tXyfqkibcg=;
        b=MmcymaFA2FLYNBrmAvhf9fP4YcMvqegomLa+Tbd4AmgrVw/IFBfKxLVcfw211Vd8H/
         meigoEavLOm6G2qlRo6sJlg763mrHMMJHgPjR9VCibsJd8jblXYP8UUPQYnSPbyCl3Vb
         8RMnRN6ktmG3g/s57Oh4P7+WoJp6cvc3c4DCNn0/og3vvd2afcvT4/SVUl7svOy1i/R1
         /6ocXI8yWYpEzB3uLEQLxcXuLcbnbCdR4x0QLmvkMIVTMcOGxXOEH3pNHj6kh+gr5fMY
         fkh9/XOrOmsrXeRvwcsytwecWcdB+84Upz+ZrkrWKdhWn4+hWsUeeOU0pZ7N0vAxbp6c
         uYow==
X-Gm-Message-State: AOJu0YwjNY11ESKJDVC2bDWq1jO5lYSzeD4gejvYT9h96KAl2UGfolmI
	1ZhVsWTobClZde24Oagk7jv+hdXCshp6chaRXEvKZ5P8RX+tsQDcHW9aD8SkU3g=
X-Google-Smtp-Source: AGHT+IED6uEn6rcGyC9hFTv8HSaQG/xUwUPikcWeNYMIyCKjcFTuPEbFtWPZ1K866xL2UTbIWlls2g==
X-Received: by 2002:a05:6a00:a8c:b0:71e:13ac:d835 with SMTP id d2e1a72fcca58-720c98d0dabmr14344348b3a.11.1730649494734;
        Sun, 03 Nov 2024 07:58:14 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc31b40csm5667334b3a.209.2024.11.03.07.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 07:58:14 -0800 (PST)
Date: Sun, 3 Nov 2024 07:58:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bjarni Ingi Gislason <bjarniig@simnet.is>
Cc: netdev@vger.kernel.org
Subject: Re: dcb.8: some remarks and editorial changes for this manual
Message-ID: <20241103075809.199df5bd@hermes.local>
In-Reply-To: <ZybRdNeIHWohpWYN@kassi.invalid.is>
References: <ZybRdNeIHWohpWYN@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Nov 2024 01:27:16 +0000
Bjarni Ingi Gislason <bjarniig@simnet.is> wrote:

>   The man page is from Debian:
> 
> Package: iproute2
> Version: 6.11.0-1
> Severity: minor
> Tags: patch
> 
>   Improve the layout of the man page according to the "man-page(7)"
> guidelines, the output of "mandoc -lint T", the output of
> "groff -mandoc -t -ww -b -z", that of a shell script, and typographical
> conventions.
> 
> -.-
> 
> Signed-off-by: Bjarni Ingi Gislason <bjarniig@simnet.is>

Thanks will pick this up in iproute2 release

