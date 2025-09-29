Return-Path: <netdev+bounces-227224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C32BAA8B1
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 21:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F91189FD49
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 19:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A233B2472A2;
	Mon, 29 Sep 2025 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZFi9gtB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA4EAE7
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759175909; cv=none; b=QBR7jBZj9lIa/RX6VbTxk3eoW0+duzhRbeTI5sqbMq40nniY3xC9PVaXTzxsrZpMrwAZ9WowHIeHFvSRIHQQWn4ENFU3JXQ0eGEtFCm8V1LMn1/Z4T8ChRPMNMZD56kaz2OAX/eFBSa4QEYDfJAUY23n/lIMEB4b/g3NbnSAJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759175909; c=relaxed/simple;
	bh=WdicRI0lW+PGtCiPXv9obrCJTn+wZ6NS3dwNm1Ifvr0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kadqrCsa6F+DHwCxuDC5TqSnXZIbjgE57F4zhskRir2efDz6k6N3UUMIRqogw/ZdoJBcpGBs4WMSsqqtuJBsEC3A9sTBRCDW+iGq1La5rEE8bxMj3TqLRaEqjI25rHHvIgTYay8GfpObfnZm6i/4II7OciX0uUjVGlIB3P/+AOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZFi9gtB; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8e286a1afc6so2973939241.1
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759175907; x=1759780707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nE68KxQv0TltB4c9BEbfsALxojS1THywA4eEOPwE7iA=;
        b=GZFi9gtB8dpw5jsyDAHMEtUUKIJDk+wHqc+9Gv95QL9FzUXVmWtzROjg8/haJ5VSnh
         dXWMKyTmwnqkB1V0kSLG5Ij699fIKraeiGz0JgZn/PrlgMxj40PcXZFZGJp8XjibB0cb
         EC6lc/thsgeihj7yU74eup1ro3b32JqH4wO1NHrhfht4sljxA0r/XiKtukW4VQADkjIx
         ahjAaJW38NLX2ihtfhOi5XyN6vZpa1oj6pw+RX2g9vju9gbnH1S3MJOWQgPtiengl76u
         V+AyvKplQEgBTAZtbzlt333Cb/Nno8GQes3e/kN2Acc2B44jidaBIwXSp7OgeQv7A4GF
         rn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759175907; x=1759780707;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nE68KxQv0TltB4c9BEbfsALxojS1THywA4eEOPwE7iA=;
        b=ObZhnAPMYK8CnPYTxRq3bijW8P9IiZB8w0saGM77bHn6uCr9ya70mSAyMvZlK0NYWx
         6v/+7kXO7//rgb5E1WSWvZT/U7PYNA1OGvVIgvEePis+oPxCHB/TtduKVobjxcwCFp0J
         +fSGlEvPhIS6LGITgpBy1q3orvBGebOPtNgd5+2Up6A5pLsoIP+TZS7siJJL3vE40OYO
         46HqS+fvr3bXIMb4zIlTZ0+c3s9S0iYDBHmxMTVf22hKCh5tSTgovSArqzaRro+P8x4I
         hwrI63UUqCzNV6U2vg0uTsUnZ3ns3YnGOCd9bhein7daJ6nv6IfD73XWnEXmWT3rGto0
         fx9A==
X-Forwarded-Encrypted: i=1; AJvYcCXQ/lADT/loOTFWpO3/5A2GxQle1UD5+Xj55WUq5E9uDqNgGL3KeipH7ZjmVWfLaOOdm5u1Nlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Ssi69qUc5jEGJklXnFKv1hZEbZHSk/EY0UqPlyHodjKbkEJD
	1AXx+UXbefqErPLxTKCaDzQfPJAX78Z2l7wkEpqpdVMn41X7e3UvGkPS
X-Gm-Gg: ASbGncuCIf2xVivWGcaREnpnGwHhCW/CbHsrMPw9XyZu/7r8kYVTBI1BNqhqmN+xjF5
	wWE/JB/Sm43iymytLG8+MVkzVQDb6lmP+Ak5Wwj9/z8BFQeQO4y0UW6N3uC7jsnuxLKZp6g2MCJ
	JX+CiJDamtlD/UmMYYRH/hE0KE3If/Pn/Czgv6nTY6z/KIUjhDgt8pp2AMacxwfHwXboxCaiaeM
	Mnrxtvth9/WyGCWjchVDXU5Ab6Qyr+/U7nc7uxGn+vzCiLR2SSmZlr0UOpg0ws77i2oU28M8uUL
	BsYzVB9ua10lyjAUZG+7mDLVBrLxBVI4/jRdDGKgB/Uj1cY3TUE99yiS916BC9kmSGcb7U39Jac
	wmBMGIfCl3qFUXxRJiQ4RNyMJxQC4/U54yVuxd0Y3Ejv0Cs8I6K1JWOGixezPnYhrP4QxKQ==
X-Google-Smtp-Source: AGHT+IHhZBo942KumGmltmwbYn1aDAUL688YBYTItkGrRHlDRWctRRm60Zi4UInSzQ+S3HEZ3OJAIQ==
X-Received: by 2002:a05:6102:6212:10b0:59b:f140:ebb2 with SMTP id ada2fe7eead31-5ced07a5fc0mr888040137.7.1759175906974;
        Mon, 29 Sep 2025 12:58:26 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-916d98d73d6sm2580672241.15.2025.09.29.12.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 12:58:26 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:58:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 petrm@nvidia.com, 
 willemb@google.com, 
 shuah@kernel.org, 
 daniel.zahka@gmail.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.211020478b1@gmail.com>
In-Reply-To: <20250929120437.3eb28d75@kernel.org>
References: <20250927225420.1443468-1-kuba@kernel.org>
 <willemdebruijn.kernel.2e2661b9a8ae9@gmail.com>
 <20250929120437.3eb28d75@kernel.org>
Subject: Re: [PATCH net-next v3 0/8] psp: add a kselftest suite and netdevsim
 implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sun, 28 Sep 2025 12:00:15 -0400 Willem de Bruijn wrote:
> > I'll leave a few minor comments inline, but nothing that really needs
> > a respin and/or cannot be a minor fixup later.
> 
> I'd obviously prefer to have the tests merged in the same release 
> as the code.

Agreed. My intent was to convey support for that.
The few notes are not critical, not meant to derail.

> And there's no time to respin since net-next closed. 
> I'll defer to Paolo's impartial judgment :)



