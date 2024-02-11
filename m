Return-Path: <netdev+bounces-70840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC46850B9A
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 22:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E781F21ECA
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 21:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC675E3A5;
	Sun, 11 Feb 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="aXD3Lnfe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A35B691
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707685221; cv=none; b=cwm1xPqFUF1SBtgM8OhhE7bLPXnnuFDOiIzjz2lrQETVs25+HNZfXH/z2eZjXJQbMSPX/c+4KoLZ5EuOpDbu5fOIplApT4l4YdIjmpbfelnG5uGXq3Cg+YBRaXR6hPWckW4pnP+NOMfEKqofc0P0ICXe+e0BtTb7xt7Ov9d9bWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707685221; c=relaxed/simple;
	bh=0Oh8O+8vBE6vhSYcu0Xp3IRVbOI0Uw1sjneFYT2Iscw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMvL5vm5mLyPFQC9yMci/KTVeOnLnD7u8IorkyIEuwzrwInWaM2cLfhNgmRFzd6RNGgfqNls8cw1kkNmtIIxfa5ccAQEDdvo/nMXmywRg9wtR0nDQTdX2kjOjdsGwMfy8vaIxfK1x3CybC4Zk7jOJassbMUX2pgCGq7HcE/eP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=aXD3Lnfe; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e2db19761fso689469a34.1
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 13:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707685218; x=1708290018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7qnuPFn6sd4ClQXRLEzKlQOXSFvOolYT2MzJijjxMA=;
        b=aXD3Lnfe1RNwIAdPS59LAOpqOotNVapiRD7iqHQq1webVIfhEE0xG5jl67YIBFPUqX
         yxUEvF9MAWnUrCYJI2Xgtz9PW6n7PN4+LXi6K2fnYGA8p+tWlawQFkEfDEN7Fz5Cwz3Q
         fAwc2hJeTMtddDJQcnoN4iE0fUqfNSbOUc4nPKaVVXKo6/iGmOVjmPRlWfJ646vPzrRU
         nCY/BOtLTrKs5ECmM41uCnHTTj0Wlve82GNm9pyrd9xlmPN5VfyOS2ABrPnMSgCPjiFT
         IefBoLBmNOLH+ZF+hUlGhMYDqF9lDtMcbkIna/Abga6D3g7nIbLv7pSlReubibqjGoDG
         UjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707685218; x=1708290018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7qnuPFn6sd4ClQXRLEzKlQOXSFvOolYT2MzJijjxMA=;
        b=RhCviwkDuNRmlLhEK1DVm1lA5IDYZzfCh/TMC1uIruaLP1Z4vfKDLhxcl+GxELh1WC
         yNiGn1xUqhiPWvf7vpN/4i9OQqmbt2Pcr9uVNe6KuH/sET6ULtsaAsUub9dtg4ycgyRW
         xRFmisqPdI2VNucJU5egGVAdVHZO//TfON4PBE5/1liFs6Zqegg+BIEBjt7lX5qDsSoN
         Gd7sPAV3pL1WQW6BgXDBLSEEBdQjeiEzjZ3XUx5f1gdnZUDVBavGMPN4LUeDLr7/g8Fj
         SWr3kd2BBhY1EBzzUEgxs7ZuLBr4rZtOqp0abGmw1Y736a0HmzKH7FhHGYJ09JDiRexO
         LzRQ==
X-Gm-Message-State: AOJu0Yx+iLth7zRsBtklsPNRPKFOfkegM7oju3feCafyotY5WzFm/cW+
	qzmdrp8PDQgfluZQvdJjMAIkfeI7NDtrr1kzXS3rQ4ivVyyRG+sDLweP4TyJiip5tQKJXXpikS4
	/
X-Google-Smtp-Source: AGHT+IEnSFxiDVBRewFSYslyaoFhcoDoyuEpeh/rF84D31d43kwHlryVnEbJHNOBzt2NONhAW7zzYQ==
X-Received: by 2002:a05:6808:e8d:b0:3bf:f487:e40e with SMTP id k13-20020a0568080e8d00b003bff487e40emr6006200oil.33.1707685218397;
        Sun, 11 Feb 2024 13:00:18 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id fm25-20020a056a002f9900b006de050cf904sm4148567pfb.22.2024.02.11.13.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 13:00:17 -0800 (PST)
Date: Sun, 11 Feb 2024 13:00:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] ip: Add examples to usage help
Message-ID: <20240211130014.2a35e179@hermes.local>
In-Reply-To: <20240211175704.5963-1-yedaya.ka@gmail.com>
References: <20240211175704.5963-1-yedaya.ka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Feb 2024 19:57:04 +0200
Yedaya Katsman <yedaya.ka@gmail.com> wrote:

> Currently the usage only shows the syntax with all possible options,
> which makes writing the most frequently used commands cumbersome, since it
> requires parsing the syntax in your head. This praticularly affects
> users new to the command, that resort to reading man pages or search
> engines in order to find the correct invocations.
> 
> Copy over the examples from the man page, with the same indentation
> for the command exaplanations that exist there. I removed the second
> link example to save space.
> 
> The whole section is indented the same way the other sections in the usage
> are, to keep the uniformity.
> 
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>

No.
Examples belong on man page, not the help message.
Help should be short and concise.

