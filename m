Return-Path: <netdev+bounces-238932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66363C612A2
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 11:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EE63A2A22
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 10:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D94823F429;
	Sun, 16 Nov 2025 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmMgaCoL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADED2309B2
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763289548; cv=none; b=M2MPP4NHnfXkqfPVKRLmOTfbxNLxZ6eU81pzENLphF4Wa2C+0V6CivBe070uCK//Xq7I/X1DbnNJUSakzBNSGUF18xVxRx5ND8PDYS1L/yDm3kDS2/GUF0PAyrrWZq+0PRH8uJxpbXkimw3lP5WVFVMnsLyg/xuOE4l9AgixMvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763289548; c=relaxed/simple;
	bh=eUooGoIK3p0HDkJHI44CQC5dCUwh7Ui3R3yP/HMUo7o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=W0m7ERRJ9BRM1jcu1cxoIVX+jnEtDOmKIP5rO40OYG4rMuI/789Sva0LlCfOMka2/ZDQSHMKftPyJpLThMWgI2te79m6oCaxzTJvoIY82OAdxADn+BcqfgzEFs6I0O/Oc47r5R4BOXz+II7GtdYJEU+OrnUnryYW8z0+CHiW2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmMgaCoL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a219db05so157295e9.2
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 02:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763289544; x=1763894344; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eUooGoIK3p0HDkJHI44CQC5dCUwh7Ui3R3yP/HMUo7o=;
        b=MmMgaCoL9Gw8wGi6SOiSdRAQoeRGk275mdhAkS3qdEWAyNXQdojX7I6NkxvS/KD2ci
         8z3C3HZM4aEmjZV6MYGUiz6+hNvur2O71a/2HJy1UXrCSww/cvPF5rS5Rwb3CB9otFSI
         ahow5XiG/sTT3Paowoq6ORDSj08B7uOaV1eWDyw38IuVZ5oCzr1rb3bMpC9S4eJhRVSr
         h5xchwULR27Cykpo1WG1FT7OM5b84XmY1I875eeSAX2qDGWmSzdF40MMoPTARTVFlhN0
         Hzo6iJjy0Y+1WBclqrkPpteji6JXbMZ0dCkWqYTwV3YvAFWNX79/xKVpt9Ujqs+dkgFI
         r4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763289544; x=1763894344;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eUooGoIK3p0HDkJHI44CQC5dCUwh7Ui3R3yP/HMUo7o=;
        b=TSTRgv1Rmjpa1qHMYshVAqPx5SL0oNMs4KpxWv5xC/LMJbk07vMMRhl7wKiFNHVlfQ
         ekFvS9y/kk2jUSh1WRHgnydOLmsODZtjStPQdZdLLbExDAXXS+U29e+cpWM+AxPm0A1k
         YIKq/7V/pbm75NYjb51nB0W5n9bTp5nuUPUYjXcVASXv4l+X8hhr2Nenc6uDYOHSbZZq
         V1mPfECuh09ci6dJfNnL/Z0glnWB8hhkWmgMgRbHu0vJbx6132JzNC++8PWKkjzTYIdV
         f5o1RvABSHJZyA7SSi4LFvuNjq6Hb2KfnqvPFVKjEKE5SpVkvMH8nvIAz8enNlpOkDzm
         WYtg==
X-Forwarded-Encrypted: i=1; AJvYcCXym4YwxDkRvyX6EpSOJc+AnagKTq9tJadtPFyLzt/Jsuipc+Hy1nwNOEDaqSGEZP7qPkd3i8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4RP6Zj6P8QX/jeuUyD2UFljU3bwAPQcXHP87YLnKZpaoy67Z
	yqJ3r/oqWE2f0x5FLWHDJ880sDUhW3+QvTjRWu1j8nhYe4js6IshhOwX
X-Gm-Gg: ASbGncuckStL6tV2uKtyUrTq7CpQdWwvoWGJGUjQVyfNGVAguFufa1B/aepPJLMN1AK
	Qp8DbLfFEzYufv67rrltrFfQagArId4VjGYnGxG5vkeKtyeLWUXrW8XHcVStUvPhilLdN+RVqSU
	wJ6UpkecRi4KNwsvqfcyNUE9Gt04m7JEdZ9WmhH+ENTFG7cLm5OvxHVN/HQVs6NERoIG3yAkxvC
	1sj9pLsymOvPWS4YGOOJbkPHJuczUfXgLEdLObGr3SH5zPp0QJ5yLfZMlCR6+HwNg1W7ieAoEQa
	cC1btpRURU9NnpdJ+k3k+NKYqqSR9/T5QwZHXI78oqRbT6GClouTSeals7LXpr+DKEGkcsWuC6l
	7tZE+kTXIHF1d8QkYaaNUEnWj5pcCOk9fRmEoRqNuyHIsuXN6i6Jkjs4vrtX51fIX68Irjlsh/b
	T+ygpWZoqtZv+y8zG1XBXaJEc6AdMO4gRmkw==
X-Google-Smtp-Source: AGHT+IHUgA14e0djNX2e3oM4Gvg+pve85sKiv5fjYxtKFgTIDLrC8YQXvlm3ko1cndGmvyw773o/eg==
X-Received: by 2002:a05:600c:1382:b0:471:114e:5894 with SMTP id 5b1f17b1804b1-4778fea3098mr65089985e9.25.1763289543502;
        Sun, 16 Nov 2025 02:39:03 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:adf2:6bca:3da5:f30d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477981347f1sm35447105e9.6.2025.11.16.02.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 02:39:02 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  sdf@fomichev.me
Subject: Re: [PATCH net-next] tools: ynltool: remove -lmnl from link flags
In-Reply-To: <20251115225508.1000072-1-kuba@kernel.org>
Date: Sun, 16 Nov 2025 10:31:40 +0000
Message-ID: <m2h5uunu9f.fsf@gmail.com>
References: <20251115225508.1000072-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The libmnl dependency has been removed from libynl back in
> commit 73395b43819b ("tools: ynl: remove the libmnl dependency")
> Remove it from the ynltool Makefile.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

