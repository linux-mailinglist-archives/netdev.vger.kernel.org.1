Return-Path: <netdev+bounces-145695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BD29D06B5
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 23:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB44281DDF
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 22:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381131DB375;
	Sun, 17 Nov 2024 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWLXKng3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817A15445D
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731883304; cv=none; b=je25sb+t8aqNDKvOFHCtPw3osX7uTXuAPu8Upx01luW01H0gbq3JTOrBAN3r0qdzwPbhRlnZ+LNld9nwUTI1OMJdnDM5DD5a70j+UQx3um7MmoZypqR8n8ty3VVZ4TMlReJiHpa2gOyWTvuB8AerjrCi2PGZ7IQr/elRZxum05E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731883304; c=relaxed/simple;
	bh=oD/hNRdR/qJ6gLA5pBNm/miI+eSxnQIBdqvIkH8gHfs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=An0hJ4sDWyww/pyj//FPxSNwL3nhZwHjuatWNBcUpzWVcgdi8KFUCgMXNsNZGBTS5rIdeEd13RtEs0GHFPyCTuABWd4e5Kg3NB1oXUmVtXl0PdJmpZaeWnUaCawtDHapE444Zwb+iByjVvASg2vRfassoLaFil/GXEJlIkmlfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWLXKng3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso5050569a12.0
        for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 14:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731883301; x=1732488101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2ktFFf0cKGqaf9MBrA+rOF7o6IMiIaN18AcSe2ncGo=;
        b=LWLXKng39S5IJoGci1QJDUt5ckD+PmOd6NKihYPJGDqnXAkx57zn2tEG0BXeJwhz+t
         61KbNvkNrXjKqPUgtJMHEXNCNxBhq5/xIyRoUmNMKADgZ8qspEJAKn4TePmMU2/3uWn+
         WAJjJrlPn/T44UQ3ffrAhbC41V7lq3lkNn7NU4iq9hZgR230tY/6+suVUftxciDnTXpY
         lZyTmfdTyRT6IQaZlwfsvaB3T6zt55XSjIBXFV2uwNjOGObAx3Ym+z4Wp87+kZRVrmKe
         a2uMxCeALXrFi3i4Ht5qR3X4UBEs9iSazy3fZxVZPBwTzgzPG3/ww/f+fa0z+Ac4+WYM
         3Bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731883301; x=1732488101;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2ktFFf0cKGqaf9MBrA+rOF7o6IMiIaN18AcSe2ncGo=;
        b=JWZh3z5n2UTOPReO68lfesRuTGoWdcaXlYz3Iu62v0DGX0PPQ65hGIG25q6VDDyNox
         Km8r4VMLp6MP91uBukhSChVW+0HIZt0RXKt19hLuVxNKEZsSYrQb1jO27Uf26eumisXP
         O3nlf2x/AzxtlYYFPEGH6VQaZ4gMUjO61dL/sgefIn/qO96Xti9eUI42/HiKkh4COjyf
         dkZ3WTwbD4DG7fjofulrOtk/yaWck8TWmRfs/S3l3ss2SY3DXcKRIKTHSwHMJd+K5fSM
         m3cIPKWHL19j/MiM7fmgwrNV0l2By8N5gKyV8x7JTcrhBarOk9FLEU4+2HFZdlKuVDMr
         AbEA==
X-Forwarded-Encrypted: i=1; AJvYcCXIJLVHG1tr0/WkGrq5X1D2wPRuuC3Mjc0k07HIy8uP01IynRiSEAOhCqzeVoZ8TSozUZU6y3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnqgAdhvfGmKRHsx/bAY6VPVYDvdRKXZpFGk3EislaGekFpi+e
	2FqdHZhZT6JvZscNcsqaqYffVOGUv8hQbiIVsAw4AnmxtxEQAsz6NcpZ7Q==
X-Google-Smtp-Source: AGHT+IGwUB06d5NYNW8Z5+XDNY1lppmufUtSM2fXvAqhHF19GkxjowSr56zkq772iNdFITEklqeGzw==
X-Received: by 2002:a05:6402:d06:b0:5ca:e5d:f187 with SMTP id 4fb4d7f45d1cf-5cf8fc676b7mr8201329a12.17.1731883300743;
        Sun, 17 Nov 2024 14:41:40 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfb99af32esm1214955a12.75.2024.11.17.14.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 14:41:39 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <88c439e9-0771-4bfc-a4af-70b4be76ea1f@orange.com>
Date: Sun, 17 Nov 2024 23:41:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GRE tunnels bound to VRF
To: Ben Greear <greearb@candelatech.com>, netdev <netdev@vger.kernel.org>
References: <86264c3a-d3f7-467b-b9d2-bdc43d185220@candelatech.com>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <86264c3a-d3f7-467b-b9d2-bdc43d185220@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2024 19:40, Ben Greear wrote:
> Hello,
> 
> Is there any (sane) way to tell a GRE tunnel to use a VRF for its
> underlying traffic?
> 
> For instance, if I have eth1 in a VRF, and eth2 in another VRF, I'd like gre0 to be bound
> to the eth1 VRF and gre1 to the eth2 VRF, with ability to send traffic between the two
> gre interfaces and have that go out whatever the ethernet VRFs route to...

A netns is vastly more flexible than a VRF, with much cleaner operation. In your
case I'd just move each eth to a separate netns, and create its GRE there.

