Return-Path: <netdev+bounces-169076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84444A42805
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170427A44BD
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E4C262D05;
	Mon, 24 Feb 2025 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="sPHKhG4y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BF261565
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414991; cv=none; b=WY0CHo+etLfmIHBXNPmu2U+tl7pRB66CbtEghQqLQgZhgqqLKBh8/NGSxF8NgshgMi8RYtmhfARm3F8We1Pb4z6nVLbu3u9g0F9Vpu84EUuebNnKUkilziYfpQ3W+7AwtwCxyVEewQaxQBv2PU0AS8FwYhWk5xoy8In2d8R9r9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414991; c=relaxed/simple;
	bh=FofER6M6N889eNt3Vtq1U6v45RWXpE3Xmo3mKD2WXSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qy7EF6vdfwN8vHkW5Lvo950s8oylFqDraic2ohnQXuvwntAhGWLY4Va3RkVZCYjvBBkiCl+U7sCSzhi6BLPGH4pk5dem5OFEr+Reic8Q3njOfHGnomTGYDMUIkJbN+trTPzsxrA0WQuYNV6eyS0NZsmzB+MqftWWZRodqLXSwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=sPHKhG4y; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-471f4cf0f52so1776491cf.2
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 08:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1740414989; x=1741019789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FofER6M6N889eNt3Vtq1U6v45RWXpE3Xmo3mKD2WXSY=;
        b=sPHKhG4y9kRelVjgTpHP1h0PxbwpndNeL0iJb1yDA0nO4HGaFL+JwJAzkf0zR2VRWx
         WtC1vj4mVtgk3o5KXcWi3OoL8vL33p8Y5E13sIQLG3Z9vqs4NnlnHX/q87USFHsWTlD3
         sVWoWrHlWhQo6ltchhxt4pOHc3/rei/5/IDUqth86JjWMZeLWCgZ/x4tAE9cGqRLu9f/
         IMmKEgvbksEbK4CRvXC94MwHVAQbDED/rdhiT/UwbkVBFI+VaMwICuBLw/i9VqhvscrK
         yR7Ewa+5Qmn0u7caFi9SjVKfbk9OYfmO5aWTRP88HOqaEPMMWClGkK5wSsGKKpD/aeQ1
         K/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740414989; x=1741019789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FofER6M6N889eNt3Vtq1U6v45RWXpE3Xmo3mKD2WXSY=;
        b=QQLKpZBrqNow2hTzHhNW5qtRmlbp87JGdQtaLMQxnmxG44rr/Fw5DnNVj+WaumtGP0
         BjNKMBZXKnEC12coNV2x1++yiTui/cTLxe66Fzdxibng/GDopW7gkb5nmU2S6pzcHoVk
         hkvdF7kFZpvdxkXI8kTdN2nWTssLP6pMjSwLSpMu3MyZ51xgxBInFy4O/H7+MlI6wZJl
         ElXwN8zQJuZ3eU4zHbs2n4AghC5l2UxQNCUqpSpSi2Ldn2BfI3+bPfOsB05LhvAwziZZ
         F4v0VG5HseelRIfyXzv9ZsJo3C5IdKynCZ/Q/Ki6Ut+8553H3vfYS2jgd/OjVHF5vX2g
         VUcA==
X-Forwarded-Encrypted: i=1; AJvYcCX+foUfKwbbhny16CEEa0RRZfU2ksFvJrhnobSH0LPXhQYEEGALfXnO1Jy/R2DIPb3ql0IgUW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3v4GFUTCuSXq1tkgIXYnX6VMm6n8DrOgwIkTUKZ114toHQrmJ
	RruauxROBevYfB/jwvOUnFRVIGjrNxx2jYYFyhK93P+oKpU6gHzxmDsMBmQsnUk3c4we0YUfO4i
	Lbo0n2fgQEd5tJsDHQdtSgY8ZgrQychSY34ajNLgyWZWsxerh7vNggQ==
X-Gm-Gg: ASbGnctEK/NoJZV4mmWGj86MYzz1tA4WC8TP59Q62+RfDWNv133tCCZwRGwq7CFbcUV
	HUeY9y1Glu/TSRjsnxBHKqBl7EwzYIdiC+ACX8TcupZYwubTQdk7pTmaSvIt9W3sS64oltmsdLz
	2XAUcudaxtXA==
X-Google-Smtp-Source: AGHT+IF8KC1kGRHKNLGmuA1fEsqQuYPYOAnpFqm62S+6tS8417diws1ydavrvl6UcE/zOP+v04wqsYOVJ/yWyLcFDwY=
X-Received: by 2002:a05:622a:3cb:b0:471:f185:cdda with SMTP id
 d75a77b69052e-472228d9e7emr76279521cf.9.1740414989090; Mon, 24 Feb 2025
 08:36:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222204151.1145706-1-jordan@jrife.io> <1cb55499-f560-4296-a44c-e5af7a3d1758@blackwall.org>
 <ce7053c5-b06c-45e2-b0f0-eb1a33131853@blackwall.org>
In-Reply-To: <ce7053c5-b06c-45e2-b0f0-eb1a33131853@blackwall.org>
From: Jordan Rife <jordan@jrife.io>
Date: Mon, 24 Feb 2025 08:36:18 -0800
X-Gm-Features: AWEUYZnbgHkAM5wRqm7e8vFrY7BRqStG7Haygi4CkmWWYZOpqTkNsxGuqOic0No
Message-ID: <CABi4-ojtcyN1TONmgEqZKpW=F9yOREj6kCy3AbKgO19iHGSv7Q@mail.gmail.com>
Subject: Re: [PATCH iproute2] ip: link: netkit: Support scrub options
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	stephen@networkplumber.org, dsahern@kernel.org
Content-Type: text/plain; charset="UTF-8"

> Aargh, just noticed one minor nit:
> "Usage: ... %s [ mode MODE ] [ POLICY ] [scrub SCRUB] [ peer [ POLICY <options> ] ]\n"

Yeah, that's annoying. I'll fix this and send out a v2.

-Jordan

