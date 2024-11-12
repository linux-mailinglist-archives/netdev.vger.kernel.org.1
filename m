Return-Path: <netdev+bounces-144224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324429C6502
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 00:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72027B2E7E2
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C277219E29;
	Tue, 12 Nov 2024 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qgPuv3By"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F8C219C89
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440977; cv=none; b=qFx03zHkROV28l7p8/vH9DxdtEoU6wwIkxkOBi/GZUuz9UntCiZ0/eWdOW1eTknzuoulzyZxx0Pe/BDEcOStZhFmRSt8Rqpsx9iQG51QRpY4clgh8vwO6Lt6gHq30xSABJ4Ir5CAN45DPD262uzo6aJTBX0xw9jfo4GLQvPqIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440977; c=relaxed/simple;
	bh=ROEKZwcjfPoFsAyKX+keZg4EVAszmoTI9P0VxnZj+P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Egp0/B0fjDpU9kq1hp+NpKKy/VdUqWjzw1podKCkxsxg/Ybso13iXaDgnYXuv71lLmLgBqM53VJ0rNMwDeUbNulE8JyUzr3LFXDtQbGCx3tKFfkugVQSkKabYlZtjAiDgVhFDiTGvhNT0Dn/c75lTF7f8sKSTS6nxiPBPgdtPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qgPuv3By; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa1f73966a5so19820866b.2
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 11:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731440974; x=1732045774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6NA8uAj1cVJkjjtOVQkEyoz64zoAQPhiIwxOuuleueY=;
        b=qgPuv3BywtIhL5pm/UuwfJMgGcxZE+cL3WOIkWXF6GCH3hPrf3VkuxGEwMbhSjACGq
         BLeReqD2ZY7b1vT5JIzjWqLGH9AWJZiErxN+EpcxsRss2N9gyN0G2Gb4mYpwCKMziuQp
         ClWGCYjMia6/lSou8iKXs4gsptmpuFc/HeRFwm3AY0rtJeIHR0s5vr3MsXSONxaR34Lt
         totHMnKkGC7opx7efQR27jatC5fFjdiqxSh98fiyjI+SzMH9veqVtKBWqp4nEXj52I5c
         /ojZbXaBwV5D6nSdwEvfni+az1rUjbgbXPJmJBd3hmk+kRax5lYQpRVJyk47UeIOVQvG
         k7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440974; x=1732045774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NA8uAj1cVJkjjtOVQkEyoz64zoAQPhiIwxOuuleueY=;
        b=kVlz7rl70WW392hM5gndnbhkvekpRbMMegUuugl9arCnJ7cspRTreEF2iIGLbHRdH3
         XYDiI28fb1wYJmLEU3GMxirjvr6dDoiA92AhMwhMOBLyDPnjfd+VYyklA5KGjBp3rn3I
         gxXthmr4LMMJUsT5z3XbBQCko8wVkv6h3uiMdqrUfGECkTNYzoZE/UytqwPnhYAVisB1
         QSK/yAkKyDh+HsVP9pnq+/4WZ7AalJ4RNJqk2YNMq5hRX8f49tVXNw/urNWNIynq8y/x
         CBf7xBWzq94RmHlinyoui2T3ps4NN6ZvTSAQVSTUZZk8GaMgXpPwZM23nMvb1cd3GkE0
         Q4oQ==
X-Gm-Message-State: AOJu0YzppWKVKI4ghlRzF2lzdU8gcqzjP2M1dPnfVrqf01K1TNyJzeaD
	Q6HUp3OmC2ExIu2EDUVVI+/PuMtSS5gLaN/W7WIinK4o1C8/4Y/mufM7JbUNfdI03Annf6QT45m
	uhPn+9E5vtikITJZ03NimJDCW1ZkDCWqPrrRcg8bRq0+r8qxATj5P
X-Google-Smtp-Source: AGHT+IEWd6x+Tan5+f/ne9TchNv31H7K2uiWWt7/55DofMHIPXP1vprN5IdxeoGKCR77UaNKo4f8HB0SBsX8iYEskYw=
X-Received: by 2002:a17:907:9281:b0:a99:77f0:51f7 with SMTP id
 a640c23a62f3a-a9ef0044506mr1542728066b.61.1731440973679; Tue, 12 Nov 2024
 11:49:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104233315.3387982-1-wangfe@google.com> <20241104172612.6e5c1a14@kernel.org>
 <20241104172739.2993c325@kernel.org>
In-Reply-To: <20241104172739.2993c325@kernel.org>
From: Feng Wang <wangfe@google.com>
Date: Tue, 12 Nov 2024 11:49:21 -0800
Message-ID: <CADsK2K_wc9f4BrnGW-HMcjD5SgNb8oLU=jE4QEJqFumx3dXstA@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: rtnetlink: add ipsec packet offload test
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, leonro@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

Thanks for your information, I am able to reproduce the test
environment and run the test.  The main reason for failure is that
this patch relies on the previous
patch(https://lore.kernel.org/all/20241112192249.341515-1-wangfe@google.com/),
 and it is not checked in yet.
And there is another routing issue that I will fix too, and I will
upstream it again when the previous patch is checked in.

Thanks again for your help.

Feng

