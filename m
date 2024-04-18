Return-Path: <netdev+bounces-89211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312C8A9B2B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA6D285C4E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC71415CD50;
	Thu, 18 Apr 2024 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWbpaOfY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A3A69DF5;
	Thu, 18 Apr 2024 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446569; cv=none; b=OhRWsntuFDNuyzED7ClUPgiBV5BRkDIEpKq7ZeeFUUr8uiscHJzLdrAiXnR7YJJIySJ4RTqo3gzxZNIMO5RPEUMzVelwLWK+HbG3Gst8HF/xxI/+9H33QsjgQfGsqHWXccZzNayvVf8QBi0JcTgMUKXcW7MaKl/ewSPXZ4iDFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446569; c=relaxed/simple;
	bh=Krmtk53Nn9bXQ1UTb1fUNAQvTji+4AjXJghIHMRiNf0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W2bLMlvqABzPfYEVGXCtgfVWhL6ocEMLMXwvKdS7ePgjFbKR5Xj6gyhAcWZzG6N/jlSkE1I8SEa4SgimD34VjL1grLjLAzqGGVHw0Cv7ITL6b5yascrzTZZbgSE1asDo7rXhwKtB0pGsXjE9XQ2kBHW7h2DcXSErj4MmPgYz+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWbpaOfY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-58962bf3f89so225472a12.0;
        Thu, 18 Apr 2024 06:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713446568; x=1714051368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnEIxVC8cY7hf7SzMttR6bIl9eeb9SLXmm4fBuco5OU=;
        b=IWbpaOfYo6BTlwYB8hudzWCOSe45e195sL3l8Q0/QBl474laR+bOtirZGElqdwGO/Y
         9qEUtkdLOK1K1W1hnbG3BEzotD0VAEK4Jx4ObNyW3gQD4KbdtC2oPUUizFPr4HnRTDR0
         GrGF1HYh+QJ93B+lRpupnxGbTRx3ZbhOU8NadQSaAj9s0tJzolhd8D06dR1Rnzd1n4cB
         ks+5XGyJuoITtrAKR4VeBF2+KPzeYeFgigTbc7pSQKCoS4bR22omrDtIzUQF9t1fTUP/
         AAm17MIZC7oSjpQS+qSQ/yYtx/gfRXNOwhs8Snc834uYEQMhTV4a0b+FWCTiWP7wF2QC
         EFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713446568; x=1714051368;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vnEIxVC8cY7hf7SzMttR6bIl9eeb9SLXmm4fBuco5OU=;
        b=uRS8RnaezTGdcIaz4qG0nFB0A69gzMdHo8DOgAv9PZYlb9aqqXVBTfYz6d5h9ZtlJf
         1ha9L6KfjKSmDxQp/UIWbQ2fNwQU+4Ikm9b05TfWwhWo8ApwVaYgwt2egn+jVt2jot1K
         sq4fGtaj2xCxIbesvhFi7W+WzFftK+nhOzJLqxmtbLeUb/jo3kFXHPtMzA0eMcwzSG6P
         kvm63Y93vjwbymbka4nyTr9RfM/+d0HCUoXr50yFO0clnQ1dpas4r5z2f/0FHZxJVUsu
         XGmd5aKs4+d+dEz8ngi4zCyuprPzX0CZ6e1aXuTnDKBYf+ozFdnO2VQbC1fTF44mqZ4Z
         xYKg==
X-Forwarded-Encrypted: i=1; AJvYcCW5j4It/x+AurMWP93V3TYHrYg7kxuQDDpQTguHTTp5hOti9oeyMc4EwR5B8PaogJDIASFkvRZ37yFSPt04yDiooWK4u+KjF8HSMU3XiLF7Mfn9KV/inJFUzCV/Ty3Z0bd1F0AOlHM=
X-Gm-Message-State: AOJu0YyWn+bvOMmRgubhYq0emR32y52z5X2WAdzYlMFEPqhIND16l6NH
	Krp2/XSlImkfVG9D0SfVxIiY+mzE3qS5SWGLO90hDowm/odMR30h
X-Google-Smtp-Source: AGHT+IENSG2n2rPgzUpACTMKkindKnuv/3BA6BobGUN4O2GVcTrz0XFnByHcS8eJ9brT9hRKwsGisA==
X-Received: by 2002:a17:902:7b95:b0:1e2:2ac1:aef0 with SMTP id w21-20020a1709027b9500b001e22ac1aef0mr3038293pll.2.1713446567729;
        Thu, 18 Apr 2024 06:22:47 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f54200b001e2bbc0a672sm1477635plf.188.2024.04.18.06.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:22:47 -0700 (PDT)
Date: Thu, 18 Apr 2024 22:22:37 +0900 (JST)
Message-Id: <20240418.222237.2262785113908798789.fujita.tomonori@gmail.com>
To: gregkh@linuxfoundation.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH net-next v1 4/4] net: phy: add Applied Micro QT2025 PHY
 driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <2024041801-anteater-cultivate-d8a0@gregkh>
References: <2024041549-voicing-legged-3341@gregkh>
	<20240418.220047.226895073727611433.fujita.tomonori@gmail.com>
	<2024041801-anteater-cultivate-d8a0@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 18 Apr 2024 15:10:36 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Apr 18, 2024 at 10:00:47PM +0900, FUJITA Tomonori wrote:
>> >> +            if i == 0x4000 {
>> > 
>> > What does 0x4000 mean here?
>> > 
>> >> +                a = MDIO_MMD_PHYXS;
>> >> +                j = 0x8000;
>> > 
>> > What does 0x8000 mean here?
>> > 
>> >> +            }
>> >> +            dev.c45_write(a, j, (*val).into())?;
>> >> +
>> >> +            j += 1;
>> >> +        }
>> >> +        dev.c45_write(MDIO_MMD_PCS, 0xe854, 0x0040)?;
>> > 
>> > Lots of magic values in this driver, is that intentional?
>> 
>> The original driver uses lots of magic values. I simply use them. As
>> Andrew wrote, we could infer some. I'll try to comment these.
> 
> Wait, this is a rewrite of an existing driver in the tree into Rust?

No. As I exampled in the cover-letter of the patchset, the vendor
released drivers but they haven't merged into the tree. The vendor
went out of bushiness and the drivers have been abandoned.

