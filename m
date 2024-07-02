Return-Path: <netdev+bounces-108465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB68F923EB1
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664B528468B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3731D186E4E;
	Tue,  2 Jul 2024 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHAjHfoP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55B158848
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926318; cv=none; b=Ji5qUfOA+Y+3jSK8JUwXiGIaBgFNLSXEwpK8m8UqB2/BtncUMo3PcLT/A2uWtpBcPhu9aLkRtvGHBtRR4IuRot+zxSOMzyKkB72cLf9OpNd72bypEAUZR1VJMwhEqehCnQgGMv8498sYbpjLTBM+p9E3LMgHkVT5ZMCHvGdyqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926318; c=relaxed/simple;
	bh=m5h2/GH66e3aRzT8PyvhVqYVaN35dmPkcodzdh3EAdU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=K6oYi4Vd1XUdn0f6qvODOZnR5lRn7lm9ApenM/aHyGesi5pr+4BMCtirEZT7bQ3MGfeeRk/8n+/ZqwXiSmQGim3wRvwbBO8RTR2ghkddA5hZdllnxvcgAJghcQdTPmidaIeVCes4/EWqh1qP7SXngFDFccLOzmgnbHheObiEqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHAjHfoP; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b5daf5ea91so1593226d6.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719926315; x=1720531115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yGD4Fri+DI9Vfdr9OW2rXTjPYpCymJuykLqX4aVH5E=;
        b=mHAjHfoPFqKBtE8KNT3F3iksWnCvlB1Fr9ZwtDZgUIjGvg4MQcd8FHqYLt6t99ugje
         2WvhKfEKdO5eiDcIM4BK78gPrTHZjUmlsJ/ZoIunFm/ShXugJ3BUL0NGs7X0vIxcWkhQ
         KTtVznE6W+HV6U2M/fedlu0Aos1CX9sVjhOx3cym3k73sxp7U7z9y4eoxUYGJ/FPiVnh
         mVj5eyFjiKy+In4doo5IctjcWCjQnRawWOBxtSBuvl74Iuvt5hM0ocuksp041QAnMsxr
         mgG9rDrdKbO8M4qpY8N49wVO+zXaf9h0bGINDH9QzGmjdTl+huZpqKrBx6lsvcAM7O7f
         KBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719926315; x=1720531115;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1yGD4Fri+DI9Vfdr9OW2rXTjPYpCymJuykLqX4aVH5E=;
        b=vT9mPc1aLjUrltUKI0mNtMceoo0FFUkAhkLKOJO4w7nW6UiBA3ff1Ok50nvl+S9mTF
         VrYclwF35BUrPwrqrtlBmYhrM7SaT3T6x9sQxMGZlteCARvXQldVqWUn2XhimNyIYbwh
         E9uSfOnfxzPdzRvJfqZzpJZsOhufL1aCzvKRYR4129HMNYbvNtwh0np12TAkxUwXT+gv
         6wWm8DYLLrJAQmGhp5LR4NRhgebDsAtgphete9w9UHTXViRahCeFlJmUWeacERfJM3cc
         Jvrbo3xVK1HzkP3c2AuklAsWf17G0bQVamWtH3rbR0JARkh4eJWw0X7RRbqZGsaC/iqA
         Re/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIBaUXKexVc24VSaHy8eNruLgnUOHMkPQIMJA1irOMQhjXUz0+htm7Q1DfsGaM/V3YgBu6hiKJhYpe6iRSYgt968czH+pl
X-Gm-Message-State: AOJu0YxtD/XRGQ1p8REEpFhpwyYT18R/ZV/EZV+Y8UIyJG0xGDNEIjMe
	qny+XntMjhq7p5rOR18kWDqvz5bREoflylLoCmMSfC5qJJTc380A
X-Google-Smtp-Source: AGHT+IFUk62p8WwnSCBWSSpKgYBHnoSvRhAujdrWx7XWDXL+ozwkBKWQ83V3SKuRzbjF0L1Qhtrf5Q==
X-Received: by 2002:a05:6214:1bcb:b0:6b4:35fa:cc17 with SMTP id 6a1803df08f44-6b5b709e185mr108993116d6.20.1719926315390;
        Tue, 02 Jul 2024 06:18:35 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e368bb4sm43921866d6.2.2024.07.02.06.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:18:35 -0700 (PDT)
Date: Tue, 02 Jul 2024 09:18:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <6683fe2acbe92_6506a294e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240701225349.3395580-3-zijianzhang@bytedance.com>
References: <20240701225349.3395580-1-zijianzhang@bytedance.com>
 <20240701225349.3395580-3-zijianzhang@bytedance.com>
Subject: Re: [PATCH net 2/2] selftests: make order checking verbose in
 msg_zerocopy selftest
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> We find that when lock debugging is on, notifications may not come in
> order. Thus, we have order checking outputs managed by cfg_verbose, to
> avoid too many outputs in this case.
> 
> Fixes: 07b65c5b31ce ("test: add msg_zerocopy test")
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>

Why did you split this trivial change out? Anyway..

Reviewed-by: Willem de Bruijn <willemb@google.com>



