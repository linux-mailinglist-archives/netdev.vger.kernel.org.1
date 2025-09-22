Return-Path: <netdev+bounces-225395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2525DB936E2
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D7019079B9
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 22:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD82FD1CF;
	Mon, 22 Sep 2025 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="DiP2mvyJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6734E27876A
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578911; cv=none; b=OGndZGo0HAXW4lv98Ot7uQctNQwyITK2Ya85eX9B+KB85GiXwZdG3q6oU0v8525XB062eyEONWCOaNST6XhVrzx/cIwKWBH3P90bXo2uhkHuT1UUZlyJKbQIYEki/Ng6pG76pJC0OW838KnlRbbyl5bTQqxTicta/OdsYmCyFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578911; c=relaxed/simple;
	bh=Avq2y8MdAwK0oH1I3MtgdoQ7iSmzzMmfx5BVuSNgHcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQ/B1WpwXToZNNP4RA9IKPA6flpSLGelsJ1ijduPfdBiKWC7UrO/kOxiX09vr2UDtG/op2AK6XV4xxPthkP/2c2sJe1OyXBY3NeeHji2k8QyyzuW5yB3kgqTVUspI79GEC8PZMgHkODI+3oOR4UH4YBsy3YpC1owffn7HcFDn6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=DiP2mvyJ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b7a8ceaad3so47844221cf.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758578907; x=1759183707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUjK8kSlRwyRA71ulpxBj11meZbRhX9iUJHgvPDIzMg=;
        b=DiP2mvyJuIZZFK+eJLPbZUHCc6UaBSc9TK3FZS151JBFLCG/GX9fPPQxPy0Sp4k1Fn
         53or6umbFGNkReYKf4u5ZcpusSmNM3dS3SqV22/YMulrgkPl59n0gbOZNKUdXgs5zczh
         KalQ9xJdgzNZbv7jbaHUSrjiuy47Oei0gsJjj23pSwIFD/2v1Ea1xU/SRxr+bH80UtEn
         h+dELNBmfhpx4lHWlWHZ+ChXXQdNQkgQV5+7vE0I3NA7HbLAk5yzx1cJYFtZvzr8AuCQ
         7fnBqcmkzX/GwV61QVDcge6Yruf3aynVZU+U7Bo/bx+EXeT9+N6WS8fEf14JKt0QZZbl
         aswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758578907; x=1759183707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUjK8kSlRwyRA71ulpxBj11meZbRhX9iUJHgvPDIzMg=;
        b=A4jkA8uQYFCzeKC2P1O8Ki6yohYNJcDiRTxxolhDnEaaWjzSBi2XJaV6duncN+woyf
         OrDDuppIdR4uH0aH61BDXdzuZRiJ6najLqLHyMqgPGd2NhsvnXRScUQnzHIG+Jmt1O7X
         OaEzBiWU2FgoDVDYlV8eos/+e6B57JfGqrsj8w6xnpT81T4J9kwqj7vJYOTMcXBUzYy/
         yD7raJP2zsv6WKl4IHQ+MczTUea47xMDvyInKil3s88FkPbmKkLFNUe9y7qyxbH7y3uB
         mzC99AXvJfztszGb0FI1BMm+XOc0Sq/TdyuskhcJhj4oxR2nv0vEFXEQulIRuraA0PxI
         M5lg==
X-Gm-Message-State: AOJu0YwrEo48ZCbAuMcmXAWFfb0R1JLFJXpoXEZ4eQo2lh/HJjcB9cjz
	kFb+NNVi7kwpMcxNuLJU8D7zqQc9+GVFXxUgINNGFDcMMdmxsAtDcmJDoXxZbaETOWY=
X-Gm-Gg: ASbGncv6kgS0TlNeP36Gy9Q9p8zK4sW5vaEXTYKPOZ7AY5ZFe7tLkrWWt+F18K2+3Ih
	Wxmm13FECnFddFQOOjxlPQmyo/XRh1Ad3+3v1aYAJEvvHkYHg4qfb65yObIM+suAziFGyCVJzoJ
	FwWen3Cu/AdLF+0guUCR4jOmOOGUe1rTmx4q9Gf7c3HBNeIyFeqzCzQwqEjwKXyIIfEQeadi1ga
	o1O4tAKI/ItLAP5KdKGkBkLpbsQWADY9taIThvYZ3koU/MK1hOvgtX7TgF2JyqZRu/QnUDz7ccv
	cm3On94d3ofPF32WGiIPLkejzAjvkl/hpOT243fBNSWM0p64jWgH8jO5RQCUvo6GXHJuyhlQE5U
	oAZ368UUP9U47NEiN1GLhj7QWcIEVxoOoIZMnfXHIaOXC1vc9YsGYUf3WdH2tML33YT8kXG++Tr
	U=
X-Google-Smtp-Source: AGHT+IEz0icBL4xjkfXiOd9WdBXGddBAYbpiDBXZ680UQhfkHWQJ/JZKh5CbDmMzNtrP9ERLzyDGHA==
X-Received: by 2002:a05:622a:450:b0:4b5:d586:d74a with SMTP id d75a77b69052e-4d369db6905mr5212111cf.37.1758578907176;
        Mon, 22 Sep 2025 15:08:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4cfdd34b180sm13096701cf.34.2025.09.22.15.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 15:08:26 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:08:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp
 <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
Subject: Re: [PATCH iproute2-next 2/3] iplink_can: fix
 SPDX-License-Identifier tag format
Message-ID: <20250922150822.3fce0568@hermes.local>
In-Reply-To: <20250921-iplink_can-checkpatch-fixes-v1-2-1ddab98560cd@kernel.org>
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
	<20250921-iplink_can-checkpatch-fixes-v1-2-1ddab98560cd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 16:32:31 +0900
Vincent Mailhol <mailhol@kernel.org> wrote:

> In .c files, the SPDX tag uses the C++ comment style.
> 
> Fix below checkpatch.pl warning:
> 
>   WARNING: Improper SPDX comment style for 'ip/iplink_can.c', please use '//' instead
>   #1: FILE: ip/iplink_can.c:1:
>   +/* SPDX-License-Identifier: GPL-2.0-or-later */
> 
>   WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
>   #1: FILE: ip/iplink_can.c:1:
>   +/* SPDX-License-Identifier: GPL-2.0-or-later */
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

NAK
Iproute2 excepts both formats and both are used in several
places.

