Return-Path: <netdev+bounces-145657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256729D04F4
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 19:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8C9B21818
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AA819342E;
	Sun, 17 Nov 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="t7rYLQ4F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4715C0
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731867032; cv=none; b=mMF/JfqaGd7ck5WIzWthA0BJKaniCKwg2w5JFelwy3db9fMjMJul3RD5bIbXcH1s0xD6GM3dfQKb4kby65tury0Tg5iJq6Ong4rR5PPG4S2d74/o6TSFFuuTUyxchmu4+4oaLH4/QPW+whHwA9Ckqz2xgMf5wl8ennOhsR790wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731867032; c=relaxed/simple;
	bh=omy1vPv9yyrmVb9mnzh9SVB+8KoCKoTbLsmy3o/t3EI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+ydtdw+zLEtlnNVQjxYTmR7qy7/oJ9U/V2jIPWhV92GFUdPuLBz5KBbVP460aSeY8ZiILZV1qq0jD34Paq9zYQdjBWmB++4jC+GU7jrwJiRYsUPmQV12+2WhXLutNbKIp/bfwFVDX+ASxg2tJv6bJwCFdZJOA/Zw4saI1dRMoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=t7rYLQ4F; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7248c1849bdso792525b3a.3
        for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 10:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1731867029; x=1732471829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N33BhjHRfRSuMcPymVOtYysXnsdqJkviGekmc6/OOwQ=;
        b=t7rYLQ4F+P/GUQrngU4BEuM5uSfHmvC9JNBHKFgxcYicj4OdSGMrWEOeHdUfcP+ib5
         KFqnbQn31hWb/3oL5ttWou03vX12UAzRRaja2d6HIMTQHDDYLz3JMjrDwNcJhjtVlsnc
         8xEwnjXef0nOt92cP+RQaKXo8hseBJ00st4oaZlfu0ZhdWz4zt5IIC50NhJLwvE3PQlk
         g5FodXvKpgHqpdWFnkd8GxhX5YWeLS+QBF+bArThYwROdOafqCsjI2fEgjBwBmbZFNcd
         swfdrWGXorAXliq4eWTIzxMpzndxa1V75Ws9yxpDmQ4GIa1gDuo9WepUwfmmi3DTBerz
         DDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731867029; x=1732471829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N33BhjHRfRSuMcPymVOtYysXnsdqJkviGekmc6/OOwQ=;
        b=tO7B50MQ4QMeI/UJGoCypyBbNyfY5H85+mAHuiPrn/76PASzbkefjgbWrOI81L6A83
         bftBHH84toSjHmoNsBeM4RcKXBfWgXF1SVp1PmKXO/ZdayXO7qezcCjCwUeKhIeZQ1vp
         rrdNe+4Igg5P23Xlm7hPqs9jjBxNSGxjbW1q1GiY5/asFAUIdfGRcpNXTBdo1+w4L0a3
         6GV+vcvSjSbvNVvtYB54oke5l7D83f+cyh/7AQ8XYXimenV+pvzxUl5W1pxDSjLMKBTw
         fZkdWNKIA9ZlV4XlwQEzDcizjpafOznnfLJ5ijjPGfOn9iNM0OV+74fdLkShTtgwvg7x
         jp2A==
X-Gm-Message-State: AOJu0YxKJkKFsYXifG0eqBaGsgRGJIQfX/A0hAAow4FIj0gh+zEXtaDY
	O29Ptw1xK4UVNaWz9AMrx0kFhsUnYxkJrQ18fWIityDJk4sR2CXD8IlkSO1iaDU=
X-Google-Smtp-Source: AGHT+IFN5JMmSUYEFBMUhO+gnyDlBCjiiwV21rfblJhUaWwINDHUAjDVgK5DwvKtPQHKA35fG4l5Vw==
X-Received: by 2002:a17:90b:380d:b0:2e2:cf5c:8ee8 with SMTP id 98e67ed59e1d1-2ea154f5f8fmr14816214a91.12.1731867029331;
        Sun, 17 Nov 2024 10:10:29 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea67700e19sm961417a91.19.2024.11.17.10.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:10:28 -0800 (PST)
Date: Sun, 17 Nov 2024 10:10:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bjarni Ingi Gislason <bjarniig@simnet.is>
Cc: netdev@vger.kernel.org
Subject: Re: dcb-apptrust.8: some remarks and editorial changes for this
 manual
Message-ID: <20241117101025.7d924bcd@hermes.local>
In-Reply-To: <ZylcVAmsr55YK38b@kassi.invalid.is>
References: <ZylcVAmsr55YK38b@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 23:44:20 +0000
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
>   Output from a script "chk_manual" is in the attachment.
> 
> -.-
> 
> Signed-off-by: Bjarni Ingi Gislason <bjarniig@simnet.is>

These dcb patches are not formatted correctly. You need to
use git (and format-patch/send-email) or compatible diff arguments.

Yes, I could edit the patch to make it work, but since you
are working with a distro and sending so many patches you
need to learn how to send a patch that is correctly formatted
for merging.

