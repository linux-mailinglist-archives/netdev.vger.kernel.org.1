Return-Path: <netdev+bounces-155336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B85BA01FEA
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40890163013
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 07:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343302A1A4;
	Mon,  6 Jan 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bn2sxRcj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC91D63D4
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736148652; cv=none; b=F6hOrRwOi78A7MR+CP1zSFKxcV3Shec7lBBAbBX+X5tLJNMJ5g2kjcL024XPIYZ8Zw8UBOf4xhOQZlEpNjdwgxlXQhAiMZuUT0K/Do+dJ0WEMTE3/8th2y1mFF4KLSIg9kGrnSNVowa0ZbUmO2Q4XQaBw9bMPOPjc2A4gWHMYtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736148652; c=relaxed/simple;
	bh=SheoHcWTDBeU0sV4PPrXT6xnde956qcReHb2Jm5/QnY=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=sGo4TAFgk9R8nqjqfGQxWhhogNVYM9X0+d0FU/5k62IYzSII72E7i0YhBueoeIV7QpxTkuX2uKhOVpqn43zc86q3ZNts6WKQg6FdejQ5z/9uKA18NwTxYI2WF/aoLmP0XapCheFTBGN95ootu9w0JtQfp/keLZWkSDFZhNKodB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bn2sxRcj; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-aaf60d85238so779672366b.0
        for <netdev@vger.kernel.org>; Sun, 05 Jan 2025 23:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736148649; x=1736753449; darn=vger.kernel.org;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEaDbyLqyL4DJ9Oe21r/aXHkX1sIZ8IZpq8gMNbHoWU=;
        b=bn2sxRcjit5fdhbauxxp7YSAbXsx9jNUxtLb0WWJcR0pQewqw+fjb3lyIBXTIPqT1p
         ucPxpLyhXjOBGO4LZrS44sjgFeOle1ivdFTYQEle+hpBsfflhcjDuT5Sn/WvLeUBOqew
         PIKn/H+cw+6Ljn24pO6vBZ1dPqjLLHPaFiLG4GC3AaEHldly+rI4oxDD72EoDQObaLFa
         9iB0gm6s4ni4Hmj9T78ha0j7Xu8K9hT1bIxqs9PlBDtZVpec6AXXLs4tqgbjtkBEeKp/
         XgRQt3NflGFsftkx/6fzvgYTlCJeil3BR9I3BUR2rngYRF0th+PxWl7GEvWiDhf3d/yl
         4A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736148649; x=1736753449;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FEaDbyLqyL4DJ9Oe21r/aXHkX1sIZ8IZpq8gMNbHoWU=;
        b=i2rm/43H7vmPwGW/HCeJxOy01MZOfaPxbPuYbnrnXPge83/AT5aNwhFPs2xyjRmtm/
         4BPPvE16lQPWeL4nXSzujbvVtN/9AnqzM8Ar5ikxpuHPWDRCFxNlW/QhCgkjDsWzxLPQ
         IlgkRlFI0l8U7fSjeQB206wsVmchmINWj9fl1l1AgOc9c+MZ83PtoqCx15ajAN0kMNje
         3Bv8z2XVnFodAWfytUeYtPc/E91nHSV7o0U6nQ001D2halklhvA/8gbHMTYCAiwYr5aG
         Jyy46+RDDFm5ysjAOqmP5B0ola4seg+VpMtSaHSxpqErnOrc3v+s2P+UcSlGTXxRvAM3
         VCFw==
X-Forwarded-Encrypted: i=1; AJvYcCU3O2qmZAOaE868f4g5sj7wVirsZGhu+dvX1NZ4c/SJYN7ysbokHjR9b1va/Nv/jfvhw4x63GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZoE+6jCioFyd4NDR9PzmbLY9BIVtv/GGg5dqOaxmmiEDsmeVJ
	hT406ubK0waIqasOG0onzJAToRvRzokaDU5wXwCKi5tKli0bjbsz
X-Gm-Gg: ASbGncsfXIz3TyQI6K1rrjljhfWRZBV//b/fb7FBJEjacPDmGMro6MXNvvBvCaeuyVr
	6QJntOfep5DCUHwdCaWYKoI9dEzu4xgMZVEQuwF9/5id+1iKmlTXRVq0azwVzBasCXfSgI8XF5I
	3mX7rDP4ylms6DPynub2D3VBWHDTYFeobb9BJ020EJiWofHv3sRnZDNzsTenhRk/jU6+TWHED/z
	0QQEiMZP2mz2qODALWNfgqWemnawE46mFSu+pYNex7VRohbr8+BrtpTTMiTdhFLlThbu03o0pg=
X-Google-Smtp-Source: AGHT+IHx9i7Ag75n7mqQomek9K54ihGtMMDmB9GyRaxvs0pQzQZBwKBTCkp70vLjxnUcNNFktLF18g==
X-Received: by 2002:a17:906:ef0b:b0:aa6:7d82:5414 with SMTP id a640c23a62f3a-aac334c3de4mr5369924066b.30.1736148648793;
        Sun, 05 Jan 2025 23:30:48 -0800 (PST)
Received: from smtpclient.apple ([41.221.207.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e89887csm2218668066b.80.2025.01.05.23.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2025 23:30:48 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Ady Santoz <santozady5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Mon, 6 Jan 2025 06:30:47 -0100
Subject: Re: [PATCH net-next 07/11] ice: manage VFs MSI-X using resource tracking
Message-Id: <DC56BF1D-547C-48AD-99A2-838B8AAC6215@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, michal.swiatkowski@linux.intel.com,
 netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
 rafal.romanowski@intel.com
To: jacob.e.keller@intel.com
X-Mailer: iPhone Mail (19H386)

pedido de agendamento 

Enviado do meu iPhone

