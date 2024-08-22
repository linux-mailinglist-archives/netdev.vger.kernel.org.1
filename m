Return-Path: <netdev+bounces-121105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB9595BB5D
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 18:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2538B23EF2
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E191CB30A;
	Thu, 22 Aug 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNnavlYY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4CE28389;
	Thu, 22 Aug 2024 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342608; cv=none; b=uv3taIPO06ovURsdrIh1n5QToN9vCP2e03PQY2JvCRxOX+Uw6IN5J3GuKjoCRAO10BxqIRRe/9BXb85eB1DwMo0qR6cdxmQtv8yV820xY5VMVXdIjZfCzeGLCtMqFbZIrMXQaXG8yr5qpYKo+DtcjfBtsGfMlV4sag6VnvXt1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342608; c=relaxed/simple;
	bh=x9rJ728/I4oKwhKhjW2RJFaBWne6uweLKiafDhXVF28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcX2ngJpX9cymXQ2H2ybopqp5JKocOgwXdmF79oJs+YReB8Upr/2foavpIt5hOLf15DhJw5qHIpIu9WaCrD68RJF8ySN4MlWA5pj+qsXLI222MfF4y1HdHVrtshWcQhAAKNaXFOFyCNxxkRohhWIiWLDA3LNVu1RU+W1SF1c8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNnavlYY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f025b94e07so8794461fa.0;
        Thu, 22 Aug 2024 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724342605; x=1724947405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9rJ728/I4oKwhKhjW2RJFaBWne6uweLKiafDhXVF28=;
        b=MNnavlYYBKRCtMdJS5V0drmi/eaE+blGR57K/+7izMByLLGaj8oThk6zoPetOHzLfK
         AIR1iKlmu8eZJRWY/aujzcgbrVi/9GeMMZ/UE6DvoQt/jI999SvcFhT+NKdvOLHp3Sd0
         x7At4ylmMfKYAMBUlezlvHUkM421HdMghqYTGxXkw7MXCyKP1GkDCcWGUVoLd4SoABEj
         pPBt/XgQsv/jUHJ77QmlAEYZZlRQggXOuO0XCyH9TUxnzsHYsABYf2JZUOcXYcEEEDpb
         uC092qalEIMrnlEmXFwa26x8mxfe1BsZbyz6qTR8SLOasj8SspCyrPnKFLgEfu/QCiNi
         B3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724342605; x=1724947405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9rJ728/I4oKwhKhjW2RJFaBWne6uweLKiafDhXVF28=;
        b=hB/kAv92tthVQtUzRfH1ECSQLCsq6fwoLACEab5mt9lwV9gPL7yPPyDUyLCGnYEm3J
         /m9DDj5OPFLuJ5hCKelim4JIJf/YK4enBO4azjOG0dK4HQnU4ZiBFHCJFQIe8Tm873u6
         SRpMzwQvoCvZ5zfJyj5YTZlgeLEpGVgArstrvifL4SxXrHc3gEE11EdCREt2es4QuzMG
         cwMOJSwYBR/Fgb6EkVvrEH5rtD0E8/8zlKhxgGcSy02oxACTLineKvA4B75Jl/bSbnOl
         +u31w+1weIwka2bVUy7/VNsrblPDKNbVAhkphE8RevADJX9O2UYRltYGwpnQzCWpRznf
         HIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3TNMsZVhnErzMJa3Hf3mlfSnKvMp/E8Idwn2x2ARPo+8xCwUTo/tSbpnfEgP8ol7wyp8mxkaX@vger.kernel.org, AJvYcCXop9CBdgrA5XEN7E4Rss0fVhxaL/Fy2XNSDjxrbP1TqIZVDOZTTdSUelGp0+1RVhr842TeNggfG3GhoCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQBHYobc2JNvn6mBK41W71zijxM25YvVHcmgbB/9dcze/68Hp
	0Vnk84NVeAcoOr/H6UQHXoBhb/mYx7E2YAI44xfF/NTbb6Ek6A3jYir7GV7t4L+zR9Rxn93DL1u
	Tc3x2svPxfcvj7wqltiz3OXUelAarpdYRSBusXA==
X-Google-Smtp-Source: AGHT+IFFHS3SUjpH3nyAYI3HHO2cunLu7GMkhG2JSfMg34uswkTR7IkptGI2j8umWHuFl9B88HRE+pHrRUSBp/DKp6U=
X-Received: by 2002:a2e:9b59:0:b0:2f3:f39f:371a with SMTP id
 38308e7fff4ca-2f3f893dd58mr42620961fa.35.1724342604360; Thu, 22 Aug 2024
 09:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822072042.42750-1-xuiagnh@gmail.com> <20240822081216.78b3a0de@kernel.org>
In-Reply-To: <20240822081216.78b3a0de@kernel.org>
From: XI HUANG <xuiagnh@gmail.com>
Date: Fri, 23 Aug 2024 00:03:13 +0800
Message-ID: <CAN6V4iNsQzq8wu8eEesM_aH05z9UR5vA94=mt+kbD76LvE4n3A@mail.gmail.com>
Subject: Re: [PATCHv2] net: dpaa:reduce number of synchronize_net() calls
To: Jakub Kicinski <kuba@kernel.org>
Cc: madalin.bucur@nxp.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am very sorry, I misunderstood the meaning of =E2=80=9CPlease send a V2 i=
n
~24 hours=E2=80=9D, I mistakenly thought that it could be sent within 24
hours. Do I need to resend the patchv2 24 hours after the first
patchv1?Sorry again and thanks so much for the heads up!

