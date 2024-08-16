Return-Path: <netdev+bounces-119110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A0D954121
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 07:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7211F2401D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBAF7D417;
	Fri, 16 Aug 2024 05:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoYtb5vC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A063383A5;
	Fri, 16 Aug 2024 05:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723786058; cv=none; b=r7vkRtq4/FSbEAxnrlMZclIfBdMUp7oGdAhPXhjOns72mDJvFtuwFPjVpvxsHvVALgSN0KLLukUpm3rMRDgU9A1HB3sfA1Z2MaV7kgqb6t6ScXHOsLZfkmc/z8SloYhUDNYauEfYFh2gVf0mTnSqhnwiINGQsBeMKZP16DAHSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723786058; c=relaxed/simple;
	bh=C8JCEvLWQ5G/QX+Z+B3U2mu7/HOAbBoLrxCp/fUrX8w=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DucKsg1IyQz7mt0KUtYxfJDvrxFBdXgyY6SbVpRwbxSOL3lgtuyUUCsEn/PU34/StupMk2Bo/P1Gk7Zz/3xdi/LK/j2c1/mBPqprFo9hYh7mTWLUG7UvsBT+xWwm5c0/2qQaACHLcwhVSGOizKkG+QoGRteDx17CfsVfPmaqLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoYtb5vC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201f577d35aso1233525ad.1;
        Thu, 15 Aug 2024 22:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723786056; x=1724390856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YyB88pFGj7JzZ7sJwulMUE4+n3R2zoWCNUpzRWIdUSU=;
        b=WoYtb5vCGMrzcPav3ipJ1bKZBRxbzT1fL2XU3wWD1vHJYdjYKdwcbJ19rEWekFupdk
         Ln0Jbk8QMkwl19ZXDGeEFq6yN8VLQxh8el263r91XMg9YWi2CdUpIJx0P9n0Kcdm392r
         mx5ul9fzeXoTXlOGyESdWfqbQ5R0NqxzsEGkmfWcfaICinSLPwXAkFiK/z6zlMAnIePn
         MZ5HhW7SyCFktlUpkeERCddkInSVi9NG70FW3h6K5w8fUtiIvktvHgzLRxa2lhGYq5PQ
         X04tq7E0JHpJGtae3pgtQzID4E4nmRn/4pq2aYJbJ6irQ4x2o8r7KymCysYeRE32xMb4
         2Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723786056; x=1724390856;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YyB88pFGj7JzZ7sJwulMUE4+n3R2zoWCNUpzRWIdUSU=;
        b=n4jJq/qHopq+IBG6tusyb17UnZtL0JhUNzlnovGH/JPYfr9+mPtKN39LUPqItCzSLr
         Ao1PRg2elHjviqNoOFw3VPraL+dnCzwkB3kZucgWtiV2SpMEOFWuv+XUQ5NJMi8N5rVk
         GwTOcMl8hIf+tfTF4/M5FyjnhcqYvBmXFmIJdiT82kawejorK3gga0AawmQ4xpIwhBAk
         dO2IDaaqqbPEYszdJ1uF3lLgIdFLOixBDlp5GCtfbsaOoexctFHlipxzlAB+YnflY8aa
         cKP77SGXb06fmN6vT+/jA1lplAucDNPuUSTPJNiqbG2pAIL4D2cTcL6a1TLVf9j86B3G
         pFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8Ux2DiDXIZA4ep8YTzuKCHPG6adGuHg61lBJKM8bxmILP2/TdGEpcAxwgPqeqUjWuRv8Z0M3iZZNSBL/WjNGmReg0omq92TzdTF7rqsDZpOYxqEH6mXL8TGxMaCqY5YrOu0OhjhE=
X-Gm-Message-State: AOJu0YzB27z2JeYKgEdxvwOG9jFNzt5+BKo19vmkIWMwXkaAInY64vy+
	T2vuy2SBaCoxh/fdkaLzXG86C3y3byq0FJ5nxvECp2R8+3fIqmBT
X-Google-Smtp-Source: AGHT+IGHm1R+J26Nli5IP7BHkYxLx1Oa6Kcv2MSBGSW++PXMxn059j0cYvaEFXBYbs0dQVITADgwNw==
X-Received: by 2002:a17:902:ea10:b0:201:fed0:5169 with SMTP id d9443c01a7336-202040635d9mr12899125ad.11.1723786056248;
        Thu, 15 Aug 2024 22:27:36 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f1c88834sm17131045ad.255.2024.08.15.22.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 22:27:36 -0700 (PDT)
Date: Fri, 16 Aug 2024 05:27:21 +0000 (UTC)
Message-Id: <20240816.052721.12647889619015306.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v3 4/6] rust: net::phy unified read/write API
 for C22 and C45 registers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <82db7404-4665-4563-8011-6d2d5e9c2685@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
	<20240804233835.223460-5-fujita.tomonori@gmail.com>
	<82db7404-4665-4563-8011-6d2d5e9c2685@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 03:09:31 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> So the problem is with the comment above. It would be better to say
> something like:
> 
> This module provides support for accessing PHY registers in the
> Ethernet management interface clauses 22 and 45 register namespaces, as
> defined in IEEE 802.3.
> 
> Dropping the via, and adding register namespace should make it clear
> we are talking about the registers themselves, not how you access
> them.

Makes sense. Replaced that comment with your version.

Thanks a lot!

