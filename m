Return-Path: <netdev+bounces-186708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A02AA0745
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502B01B65D05
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8582C1799;
	Tue, 29 Apr 2025 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heh3MmGu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584362C178C
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918858; cv=none; b=BgXaY6olAGOrs9N0scoiqYhVvv6UtIq3eN/HgYLVLBTwSaxHPVToWD9A2Q4LuQDfcsJcF3qZrOkkYXlQSi3tug2sJZJNtimbzsnWR40hCvrMyZpe3fXbj3DIFlMQ9qzggzUm53oLzvucogucWB7ZkuV2zEIb3rQlKQZ3sOPMUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918858; c=relaxed/simple;
	bh=WWf7g2m4b1gRuw3i9AVGlA3TVd4LYTzDJPwC1zK00Zs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=MqAF1X8xtJFBnCUy2N8Q3HRqLggbEJx1wPbr63kXWlR5H/JDjQs+R+qZk8mjX4/YXeIH3U6rbKEv3SR9rxVRgigTX2JtCO94Gb54j6crTxGINRvRA+J2Vr3Z/GcnHlNAv3KOY3Vx7oCWV8vYbUUY5uI5by/Hwi0MT1s4K+GSktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heh3MmGu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-441ab63a415so11692725e9.3
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918854; x=1746523654; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWf7g2m4b1gRuw3i9AVGlA3TVd4LYTzDJPwC1zK00Zs=;
        b=heh3MmGuU2IKs/5Jx3AdFwTmLm0w5BFLGbodJk4N/kuwKxeY2X1W0ADqYQAR4m3VPh
         uaYcDtUODHeUzaN+DIZaiTUlV3tDQ1kAKqpwuZc3fQj3OIyNLhf9A/5D76EZZDSe/LFR
         TiEMbS44Jsh6oqcglr+rzp2MvU1N5j52kB7MTnMco26NuGMCQSJ9V7H9+xDJYJmJ/QM4
         5YytwIUEimM4VJjk/I4VCPSDJa40a4qmqk3mSO4LCv2qp/AUhG/YqpWHQgMM1lF/Ibmp
         w1/4tmOKvUBIgmwT5KnBmT9FikdGeRrLKjazVnJA2z24PN6JkjCQXPXSHBdVImL6nUAR
         ApBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918854; x=1746523654;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWf7g2m4b1gRuw3i9AVGlA3TVd4LYTzDJPwC1zK00Zs=;
        b=ni8WnQVYdFBDN1lOu00IRoH6y39eyQfCS6L1lMZZRM8cl6L02oIEy4+HwWNGeSyqRz
         ooPrlP3rcUzYAhwzHPxTG/i24Fdb1/FrtIeiZYBNP4W4n1tHxg/eS+zreycWrUo2p7Kw
         chwS5GHTHJjcrbR9+gdbetZTaWZaVmpXkSJt1/tDC5VMW+cGFEA2n0w0He0fyFA5kmbo
         BqygSjQ4vJnKllK60p1QcsWEaLN0fIMQo2xA4EaX36qYVA0URyuyRSZolJZxR2P52tLo
         fxHIXp9tG/GboyDHZGWfmfaqExPRW5cFU/sfNEYZIQwBA0bzfRTJbhDFbjjbb6+4aYIh
         VvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXvz18USZbPIU8DaKjz6iOFUiG5cFlEbC9ooUk134S6hG2se3ctH9qjDRzrU7lVNk5/kSvCGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW4RKMEA9wsQJS9jgzSo8bOYybfLpVWPKwfJS63vL7pLfDL0Mv
	XsYHAclFCSh6/9b/ap6z2I48X1FN+Cte16ht7TjoRdtOWH8PZ1VK
X-Gm-Gg: ASbGncteIF78/Q5DwcGy65oWoZpA8qmuKhoMJ96sni9VnyL1SqdbNz7Y6vt7vLD1grz
	R4KYjEpPr373rVPQ4BhRKMUpr9lJwXwFZsUtmt6PdSOE0Nz1V4pklKe8GlOeYnBVvADOxNYB4tJ
	MJnLHoTl5ewoKVkENbegA9XFJQbl3cioH5g9y7BNPtVbSwUUtFK541C3KPw6qvVTDs/3JFFxLxt
	xOht65w17n0GaHKjNqYONUbWObHbxWaEazkgXFP1ICL9Tb7T24W62iei9vnNqv37k5xMWJewSI8
	QlTEUZGdcXVQNJznNh0nhjlsPFR0VxQLuwg4tx3m4zfp2TgDdnDUJg==
X-Google-Smtp-Source: AGHT+IEIUDVbdXfv8a9Ho0ROi5PNr0Fw9VSfUtV6fFz4iHl8UW2eqMhvs5OZ97BNLKLkIukrzy5qjg==
X-Received: by 2002:a05:600c:4743:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-441ad4fee15mr15063925e9.27.1745918854533;
        Tue, 29 Apr 2025 02:27:34 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:251e:25a2:6a2b:eaaa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441ae3fb8fesm9299265e9.1.2025.04.29.02.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:27:34 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jdamato@fastly.com
Subject: Re: [PATCH net-next v2 12/12] tools: ynl: allow fixed-header to be
 specified per op
In-Reply-To: <20250425024311.1589323-13-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 24 Apr 2025 19:43:11 -0700")
Date: Fri, 25 Apr 2025 11:08:12 +0100
Message-ID: <m2zfg4pn8z.fsf@gmail.com>
References: <20250425024311.1589323-1-kuba@kernel.org>
	<20250425024311.1589323-13-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> rtnetlink has variety of ops with different fixed headers.
> Detect that op fixed header is not the same as family one,
> and use sizeof() directly. For reverse parsing we need to
> pass the fixed header len along the policy (in the socket
> state).
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

