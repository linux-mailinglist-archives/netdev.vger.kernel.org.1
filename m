Return-Path: <netdev+bounces-75831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B8886B4EE
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79CB1F23B2D
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378536EF0C;
	Wed, 28 Feb 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaFnKqdy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8936EEEC
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137755; cv=none; b=SiWclvSPQFeTF47UUJ0z8Bdkhpj+ZWWTFHbyY+xPRve2jOAp806wNuUdiUKOk0U5evHLHVBjoqkTRpBVAnIWY7xLyYWiJnnyxCp8zIyt/j4BQM14R1agARI+pZEW6u131d0Lmi+PSDvHoyrsmCtQXVrsgZWHqeFHukGFY2RVUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137755; c=relaxed/simple;
	bh=XNaimSICo9rFgu5GrgmXjrMWgcC6FxIHRsG01VFJsXA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TPX/mXNNkjAR4iIyD9QmEuKoohKeL3e2PWRtKzjiKN/JqO6SQhg3VdNJQLuPP/7hodjoBIU4vpt8X5Ova9iBSx5NBeLSV1f/xlTCtknm35PQK9waQ6qB+0skERgn6f8hFQtj7bts2Z+m1AyH9qfWnxtKsjpb/5IUNZsLJcN/FPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaFnKqdy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so7591890a12.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 08:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709137752; x=1709742552; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XNaimSICo9rFgu5GrgmXjrMWgcC6FxIHRsG01VFJsXA=;
        b=DaFnKqdyKg0rrUQJVxBE5RWWbPmgR/k6OcrjIxyY8koPao1mQHzhyK16kYDdpEiLvK
         UE+P+KasFFfQr3jiOdia3NLhvSyrN6K3jTubAewTgnXbUBQqoZ6eb5M2/m212QuyxUIT
         m22ee0R0WCLXZFIIFHg0Y74iYtkLt3r9tBdA2C6LmGys9askVZGoNjl36R6twWd0CJvQ
         dpOl7h+OZiswoTzSRIlI876/CFYSknyz4SuJxr6Q1atay9Il0Gue7U/EvgiDabBdHBpM
         U3oIVf0mgJChthY2HFeZi0xjIet+EIKAOAa9VZEaHkQOvE/NEuJ1XbFxjjLI1pVjTNuu
         b+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137752; x=1709742552;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNaimSICo9rFgu5GrgmXjrMWgcC6FxIHRsG01VFJsXA=;
        b=uq/dDMc1VfLj3kRtk/ByICg7g7OUQNtYM9DZqQqMzk/IKawT2OMp9jU2UtUtzj2K/w
         FkMpp37TVu7RtncGmzpA9cKSf9yRxNldf9uuVA2mlRPnStozKJDK0Nq6y/XhY+5s9SKL
         EV0yp7s6LQ2EH2TV48oeO/TH3eXqhUXM7I+p0Vwhn4LdJ1eSyWt0d328movjRA+U6WYr
         HbHd3RD5VRLYAY48Y2/BL420G86BHdwscj92XHfeiQ5xcEI7L8FUjYrFd1FVshAbDnyc
         vancaFxbAnERtWWnJwJNW0RmCFPVPXMSFAuERRcDPvhWSMG2NLMBh3Gh1Ms9JJ7u3Rwm
         OYLg==
X-Gm-Message-State: AOJu0YyH3bmYxKsgnT/4oB8c1ywjzX2o3uWAmdT8qIP2VUQI9onnnBZ8
	29mhqZPbj0H2idHrGfXf/OPVUdbmU1Vwcyy4m/gR2xglboCEwSkdP72wL0T4tDtLyXjfI3dU411
	eiJtE79w99YahsAUW30bz88WkU5vS7jvl00o=
X-Google-Smtp-Source: AGHT+IHgTP7EP8goG29ULOUNcznpObCJKmD2o86G6ei75cjZGLZD7oGuilyjn+WOzs8RiOCVtKRdaE0FWv1UNHwQ/E4=
X-Received: by 2002:a17:906:48d7:b0:a43:553c:ea4f with SMTP id
 d23-20020a17090648d700b00a43553cea4fmr128424ejt.23.1709137751554; Wed, 28 Feb
 2024 08:29:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Patryk <pbiel7@gmail.com>
Date: Wed, 28 Feb 2024 17:29:00 +0100
Message-ID: <CA+DkFDZPdS+r0vdFp0EU_xh=05gu5VuqOrT7G_Nj5gdjM8OOcg@mail.gmail.com>
Subject: Question regarding handling PHY
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, I've got a question regarding phy drivers. Supposed that I want to
use an ethernet phy device - in general - do I need a specific driver
to handle this, or is it handled by some generic eth phy layer that
can configure (through MDIO) and exchange data (through XMII) in a
generic, vendor-agnostic way?

Best regards
Patryk

