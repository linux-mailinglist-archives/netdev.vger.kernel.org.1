Return-Path: <netdev+bounces-179682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE84A7E0F1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B3607A1F0B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307BE1D7E3E;
	Mon,  7 Apr 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExVEJrTs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3E1D7E5F;
	Mon,  7 Apr 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035598; cv=none; b=qqQVAjdqnliA0mqZz86/jYqSwW4ZV5T/MGW78jEWV3AnHX52QxiTsKdJ8HVDlFFm8vS/3oJO7h7XAoCUqgDP5VXd7Ck3TvufxJIIFn5p9R6KISLqlj+4GfwWrWywgK3I6v19lZzFgMNCOH4VlorLn7HN0wPBfEuELXQMOCF7R2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035598; c=relaxed/simple;
	bh=COo4eTIosiBDvpHNDIDibfVEmpvog3VWcP5SJfo6PGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWJPToFgBtCdjQd9DwI0AyuFKpBq7g1PnhMScJDydcN8uSzQs0w/aCdVfppD31GzA8Ut/ARZNAvgAls8o5DEfcDeiYA0diYc2m8n9mJBeefrasfi3NCxyIB1c/H+IHk+VrXtz6boeF2FUgyyfQGBxMQxEDUWwlYv8WZkIhy839Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExVEJrTs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7359aca7ef2so6113517b3a.2;
        Mon, 07 Apr 2025 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744035596; x=1744640396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ykkh3Ohmv9ZUd47pCocMHxGpinGV2tHgF6Qucb+8O7Y=;
        b=ExVEJrTslu2D5AvyvcYzblaDoWpz7wAMqjGYHCcbfIhyLG1zouE/BDkVVHlrT77rMF
         tLUmKtUmP4Sii5Cu2pAH2EfCDNMxKbhOMqHctP1tFGLAgmu7Hnx6OxYN/MspYVd87DTL
         lGBo0kUJmELujpABob81bDmqpd4rqf0/twq+GwofdRN+eS7y8lrN/Dsqk5XtEkOQfFof
         wihiaBoUtTaFwyE/AjyyxPbFyWQ1tmMwlkyHvqFUMhSqAQtzlPeh4erwrGiZ3kuJQjA3
         q4IQnEBmbItwF12wMkRlYfPT939VvhCJaY7lProj8uRfqS+55Af2BsO0EEUur/wld8my
         BJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744035596; x=1744640396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykkh3Ohmv9ZUd47pCocMHxGpinGV2tHgF6Qucb+8O7Y=;
        b=oEcXWetbDVvpzlwB6/yAsumr4fqiq98dZe4h41WkQ/a6iI+PaVQaC4U29k75V7KZC4
         GEe++gWeISvd2e66dmqS28ZvUPm5pAxGkMXTi2pS2DZUujHA/GIgY5tCbA7/UmoHMXNz
         J/P+ANfz0UO8z6nzDWwfcflhWjz69L6p8fALRXCGoM3c8m2pkR8MZZQ9GYioO58rpU6L
         AFTpljL5BsxQ0U/SN5x+lDKS407rT3aJrRWAEtB75sOGXeML920tjHw98JLwWIrk+uvp
         Id7lu9edP98w2TiOqu4baq/4ZVXUyTUEni26OW0Dd0tFECDC6AQfPuOpYeEJxSYiKULH
         1zmw==
X-Forwarded-Encrypted: i=1; AJvYcCUXf6rRIOuth8otkrmwilBJ9ejCAXeZjNXacrOwYvd1ydPJul7E+JDJcvIypunotyuin6jVBVkX/DABvD0=@vger.kernel.org, AJvYcCWjW/BwE9Yc5sUCwadTM/w6Pt5/wfEIVP4Kt+kwQFsawx24u4pq7T+WRof4Kjc9LCjaMCvGljjx@vger.kernel.org
X-Gm-Message-State: AOJu0YwRsxI8DFsmw8kxYWKhT5rRU4inbcuZWyrcAuKrJ0tYF9a0Jit5
	oZVScfGl03sisKUhQGYrP8xCIHiskwQX2P3TfrWVUgn7WRIlDWs=
X-Gm-Gg: ASbGncsP0CAOQ+TvCwl9GXOSB9jqP+xx/ft5gJddvRmsrgn8BcA6mr1RsZ6et/Psvqv
	83Cu/Lwo5eM0nx8c7a78P24YUgCYdKezdrhTfaK/li5vli4okPak+uLqemV8m0YJpQHR3dJXHAL
	SKOEEE85pD2DYl6h1Mt5hMkpveYnVE3wZlhmjPDbBEyILv3bUHT7EUvEe86sru/dr7Jonvg5pmW
	HJgug5R538MHewFaSvHUS4qaiv66NdBs9tivdzrivudXsuWg34BAUAltPy7dskQx0nAN5p6yJgh
	Y3DfLTk8Smot7ox8lZq/QI5HbCS1GGTVt3jDAQzmRs8c
X-Google-Smtp-Source: AGHT+IH7qTsg5rAVlTqY22Bx9Y+Mos8itMtbbMRcIw6Seluh6RcUktlYJUma1nx81i4q1ja//ikO/Q==
X-Received: by 2002:a05:6a00:179b:b0:736:baa0:2acd with SMTP id d2e1a72fcca58-739e7156defmr18489104b3a.20.1744035595875;
        Mon, 07 Apr 2025 07:19:55 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-739d97ee6b3sm8839062b3a.53.2025.04.07.07.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 07:19:54 -0700 (PDT)
Date: Mon, 7 Apr 2025 07:19:54 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, sdf@fomichev.me, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: bad unlock balance in do_setlink
Message-ID: <Z_PfCosPB7GS4DJl@mini-arch>
References: <20250407063703.20757-1-kuniyu@amazon.com>
 <67f3890f.050a0220.0a13.0286.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67f3890f.050a0220.0a13.0286.GAE@google.com>

On 04/07, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> unregister_netdevice: waiting for DEV to become free
> 
> unregister_netdevice: waiting for batadv0 to become free. Usage count = 3

So it does fix the lock unbalance issue, but now there is a hang?

