Return-Path: <netdev+bounces-234724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F73C26830
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 586264E7FD1
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814BC350A0A;
	Fri, 31 Oct 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="s7BzkPma"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A63502BF
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761933699; cv=none; b=ZO6gPihL/3TKbmJcFkqU+uVFyAdcJ94FvWLCn8vptJbgc2bc8ezXC1DK1/aPvbcBodx1xaqdVDbOvLTBrK+B2sRsJyGDBxJ0bYj2MxylXaYjsIVliF7FQHm0m0nZrNEp6aX0lxjvHg9jg8FEmWkPzx0FuNi73IHW+xPMvouaYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761933699; c=relaxed/simple;
	bh=81+nJ650azoIXDBc6RcFb6YDuiULytfHKOAtUCKouK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjvz76jedarqtqcYACRk9qZGCx2HA7mlg/N3bRM6uVKp18pV/rB6cdJ+fX1XH1TB2XXps8WvBqRW8sunfT+XKlq/I1h38r0lVd0Ks6xhmtbjDDNqffZfG0mFtEy2xYNKxDPTztmlLGu2yhRwBCaKBU4mR6AyQZMM3VgA6iQb2G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=s7BzkPma; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6ce806af3eso2506395a12.0
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 11:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761933697; x=1762538497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=virWIerUx49P6zwM9hCjO2u0AG9r9qg+xRXO7tQjwas=;
        b=s7BzkPmacwRMLjit3NFkO4A8WjrTbk+xNXWZm74IjJ6JS/z1rAEVygdLp8tcdI9v31
         ftEBVhHqXhze9SvtFdDbwXXOkFdYYSjJNfFEKMSMs1945033P7dCuYZlyuE+u9CXlRe0
         ZJ65v17pU/9ywT9tRgfOz0xLhxgnbI4g0stCLF0gfP4ehqd8NEJIWTcp+XWmP5xGXXpv
         57+MtccO4V33a91ZLReDG+8A8mJGw0KnqvcFulFuGB24xkJkYK0Ujt/hZ3+Qv0us98v9
         TLhkLGMawxwz7pi03yjI6Z012KZd9zqIvIhGNkk3ZicZ57+9dEMHOBcVXdqcEPwZCKHF
         cT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761933697; x=1762538497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=virWIerUx49P6zwM9hCjO2u0AG9r9qg+xRXO7tQjwas=;
        b=IV3gR03YnpJeKnq48tQo0fej2ltNmvJpc5bpi8kX7tcEYhsJpmDo5MrQIxFRg6LqKU
         ywg8xgZz75YSn4Rp9HmnpYcN4UQQDdbOUkkVOGEG/0+E5FRrlLCZwcuJ/QdWkI2b47ji
         E4LHq2b+dwIszc4kFri1lqA/OOYo+6iRHHYlhxQbR9c3GHpri/mlDHYO+yL4KucDxEyg
         VaCTej/U3VzlATKxppUcO75rf2hAYlkt7Zduk5ddRI5EnBppqJtFRA/v7vHlOzaHY9u5
         xZ95UPlpz8sfL0RrJYULWVPI0h4YUHJjBPUkPgRIDMuhnCEvrYvGmHo93+drodmgNIpj
         6qeg==
X-Forwarded-Encrypted: i=1; AJvYcCWT9JzfZcCeNpFY8Ev5yCw6gvn10xR06QTXk8GZKqiPu22wRi0iTzALyHYglcJ36P9UAiXOGW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkDlcqpRcpaFlXIBTXvwwiyRWssWRJnPAoNdGnt5ZRLRkeJOb
	Kb41qSjynSj4/Z7at4MRQElzPR7ofFcSPpLm4w6FWpZooeQ02hzzfpsZ9j56WmrA8LQ=
X-Gm-Gg: ASbGncujkA9T6Z9BBwRmDWSiB9EgGU3TLdy90T6Y7gC+Xm2fGFhkL5vDT0GAvRVskCB
	LTwwCSW2Z2sP7oxIQWvIZe4qllvSJRn7tiHW+uz7l3qWJymF6k7tgKVfwYkp72EgdUS4mfYo+8u
	smSTCQTUkdloFR643At7UEsYlDI2oZ9crq6Lnk75IOVPoquuevubhe0rT5sQTOaf3WiucgLeUBy
	IN1uvwIQfDU7ovITf+OZKj7TXW14phm4vu9HCcj2RRXavvnD6Le3cZMoLHPq5scPLEG4CwM/uOW
	kdJZW/0YlcReFbdSg2UZdN1N40lVJzXEeArf9rUGPSeVKONHF5X+4HwPbmi98b7Fs/XF2sU2Fmj
	k2n9YYaPh7SGILCh4YgLo7tQ4zA0drg2gpksCB2C8592X2fiERZq1t8W821QQrrYLhsspnUzM1N
	GzrUrdgXQar1Kry61aJViMAh0oHS3w8abBvA==
X-Google-Smtp-Source: AGHT+IGLscsEnHzdJ0wSF1z/pg6r+/MX7xr+3OX5V0qn3x0wM3NQrWp77SgBn0CVsTBJv7XWMAUWpA==
X-Received: by 2002:a17:902:e74e:b0:294:9476:494a with SMTP id d9443c01a7336-2951a533f8dmr53661025ad.56.1761933696540;
        Fri, 31 Oct 2025 11:01:36 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29551168756sm2955035ad.16.2025.10.31.11.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 11:01:36 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:01:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Christoph Schwarz <cschwarz@arista.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, netdev@vger.kernel.org
Subject: Re: TCP sender stuck despite receiving ACKs from the peer
Message-ID: <20251031110133.3d469992@phoenix>
In-Reply-To: <a673f379-9b0c-4d02-8884-23c62930513a@arista.com>
References: <CA+suKw5OhWLJe_7uth4q=qxVpsD4qpwGRENORwA=beNLpiDuwg@mail.gmail.com>
	<CADVnQy=Bm2oNE7Ra7aiA2AQGcMUPjHcmhvQsp+ubvncU2YeN2A@mail.gmail.com>
	<bcff860e-749b-4911-9eba-41b47c00c305@arista.com>
	<CANn89iKRXpKkCzRw_7+VyG6jD2Tm5VUPQ-0bhQKUwh2sgzJZuA@mail.gmail.com>
	<CANn89iJcLepEin7EtBETrZ36bjoD9LrR=k4cfwWh046GB+4f9A@mail.gmail.com>
	<CANn89i+=rqOAi3SJ0yj47x9X=ScDX5-dD2GmAVRsVGNP9XDBEw@mail.gmail.com>
	<a673f379-9b0c-4d02-8884-23c62930513a@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 10:43:36 -0700
Christoph Schwarz <cschwarz@arista.com> wrote:

> The "parent" device is served by a proprietary device driver for a 
> switch ASIC, and implements TX flow control, with the TX queue being 
> stopped frequently. It does not have TSO capabilities. We could look 
> into adding that, but as of now it is not an option.

You really should not expect any on mailing list support for anything
that uses proprietary device driver. I.e "not my problem go away"

