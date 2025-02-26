Return-Path: <netdev+bounces-169919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE604A4678F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06EF188588D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699C2206B6;
	Wed, 26 Feb 2025 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="FxYEgwwL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7419005F
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589496; cv=none; b=Cw7gmT+Lu0gbVLJB6EwYN+0OTnYTaStnY+EDFrD7CKiVUF0Vn5IiVAb3tnmFmTz7IM+sPFrcLcdA9wApzjQNzNpVITOrO76K2K/TslcwtUC/Y4hygc/LKHECLgr94C+B3XOmE3BegG9nLlL2bTa36SJxkzzZcJ0KRZBuuWdac5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589496; c=relaxed/simple;
	bh=AWsRoz2fNu3CXRN7h1fJe1Turw58iB3Gsbcsk340M4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUmGEubEB7zk5dav6yBxoiJdWkL22K1sDTeksSGz5iAhgLstU5Fy+p9pAyeJeEa37Ziis+q92/2BxGdOHKLXVNlAG2X7VFB0MRwjLytQyRLhf7NPoxrJf4nLvjRpy7xRmyZlr/q84S+qLLYdQ7YJGkn4nXED08Dtm+jM6EQruIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=FxYEgwwL; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47206ff9906so7233331cf.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1740589494; x=1741194294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AWsRoz2fNu3CXRN7h1fJe1Turw58iB3Gsbcsk340M4Q=;
        b=FxYEgwwLPGfUa96vktWzGFxw7kI3Jbw6RJ1l/apuEixDCw01KjIh/rbozk5dYBJrSf
         l92Fqltx0JGXmojp7n4PNM2Uf2qqVWfppEM0PeQUPHqJSxpUKwLxPpAcpZSFR9IYvDRw
         YszwA2WOUsZ+td7BIXtT06D5ZlRMieZn8XXkb+26elwT7Z3NVJW/9jrGPTzfnyFWWpJh
         ZcvObL0lceh3hGrOsHxchtg6/zefUbCO/GavnuTmBf9hVWdFJjnK+epHvbkJpoDqVf7H
         MlNZYxtQbCxcjN1WgeZYX3MvSaPmdJK1nWGB/67ngfPvHcWwjH3xZQYV7TuLNb157sFJ
         eh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740589494; x=1741194294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWsRoz2fNu3CXRN7h1fJe1Turw58iB3Gsbcsk340M4Q=;
        b=Vj65WZbD0C69HpfOS4wXffnUYtSxs5UQhsFhqy7Cmv0rRMIE1ngHYzcF8z5ppnOpI6
         fjRPMkq52fHWc9kWcVawv60eN6sBdHPH39KGrVATX4eigX0BXl7ZOOafjSZvheBm3wPh
         P53iG1/QpipGUMouN+I7xbke5oQxXAhqEbtK3315z6aOMbvuA4oweQxGk7sxdUdwYuqb
         RnX18C/034/+zPcWPSPY0C7Bjp5KpdkPeN/FiCxHgDbGzq49aNx0x1jqveAOHwBQqhz0
         XUn21r6TY6kbbofzH9TQVlVYkTjaoBi8guKYBPzBgDp4ErFIS0XCpbt+xqxKpuSykFsc
         /xtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2SThQJyS7r77DnkRA9F6oaCOgx9f0O/8qIqExaYwIfhKi7l0LIn6G5eshhrin+7H4HfZyQ4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJiJK7ahXToSrVGVi1Ibrqpc1kE6J8gXViPeRTclbahxdkTzMN
	TtFaw+W2HtEu3paEukVbjYdshVzRxCeJ9PZpN1kZq86y1yWMBu70gYzYU8Mk0wrbhad+fUg4Tgz
	5ODPdjmLEYIwyRxmX+olaESeZ2BK7jyNMlrm1BQ==
X-Gm-Gg: ASbGnctfXBge+XGvKduqBJbwJ7WNHaGUCjHldLnYIe2JX+zcm2JbxF6gA+OusWnSYHb
	6ySQTTdkGAT80Nv7qCpDxZuAsZLLaxcWfKPO7xmxwnKZ4SskDrP+oIct4kwCekmam1+bfNjNO44
	rDCO07w9F3xBIXH2NVEm1KP1FlDmOnFSCbNGQh/Inr
X-Google-Smtp-Source: AGHT+IGklVbLHssJPI1L1/VFC49krBHkA/q+FnsaacxEENuSfvREAYd1ePOxr27IHHmmJHZzJK3xP+UMKVG4EgjFmQM=
X-Received: by 2002:ac8:5786:0:b0:472:7e8:a773 with SMTP id
 d75a77b69052e-472228ab2abmr122960141cf.1.1740589493798; Wed, 26 Feb 2025
 09:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224164903.138865-1-jordan@jrife.io> <f1854274-653a-414a-9300-c2e805d2ce14@kernel.org>
In-Reply-To: <f1854274-653a-414a-9300-c2e805d2ce14@kernel.org>
From: Jordan Rife <jordan@jrife.io>
Date: Wed, 26 Feb 2025 09:04:43 -0800
X-Gm-Features: AQ5f1JqxOf2RYy8Ymp-gU9ORSmMKw9yE8irwk_sAaJBquTvUZ_G4CAZDwKthpcQ
Message-ID: <CABi4-oiq4nZzPzmtncVEhbbcbZECjJy6QL1TN18J8L01oy2+4g@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2] ip: link: netkit: Support scrub options
To: David Ahern <dsahern@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"

> needs an update to the man page.

Ack. Will send a v3 with an update.

-Jordan

