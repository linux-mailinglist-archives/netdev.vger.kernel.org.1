Return-Path: <netdev+bounces-180755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE4AA82553
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F051895ABD
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E619264FA1;
	Wed,  9 Apr 2025 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMQ4jvFZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52FD264F87
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203083; cv=none; b=Qphc22Zm2tGCzIB2whkix/fEl9PUUfTS4DNw/tbSdR6I9/r4TBLHo6RGhczyEjw7L9U//XTRr+ypBnvGDAVLVu6kfkc0j6naoWUnom0919shPu8xPUhIPvD3rZzUVULvx8ImjwvqqbX5aCpV10FPQvJ5N9/yfvpwUEnZLeFBD0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203083; c=relaxed/simple;
	bh=1gy/NwJ3yzcnIgIQYwzci2ifOwNSda9QUogpoaksyLg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=jBoPoo+w7RNo8qI0uyan49HF3LMIlarVpLfvCLHV/HEpxUSgnEwupXAVmIUeej+tgKigRcAIQByJgVigRBDlGrqPyNPLmq4MjNtxY7emLYkFoJR1Cyoc6Kn37pUC2PSbQ3fvs6FYIFH2hPFkM2zGHc13Mr4vb4EM5PNw58NAviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMQ4jvFZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso32455895e9.3
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203080; x=1744807880; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gy/NwJ3yzcnIgIQYwzci2ifOwNSda9QUogpoaksyLg=;
        b=aMQ4jvFZv0Rmo1setX6MrfHL+ExFPuU12PRtyBInQJiHqjqynlNEBBCpm7UZRcmO70
         km82WT4w3RioxqiDl/tUAkGATC6K4fJmG3Czxha3ovbGa10WxEEjPXU2kF7+mi0b6ofG
         bC9nWVJIfDAO/MN724FtZyFhlO2MC/ulpvxNXknxP+LePCTFKtbXjyJFoGz3w9+Qvz97
         yapfMC8atF9+rua6y7v/3+j2MRMiAWIAoqJoNUkMoOiFFW24Ry+c8R8OrIj3g13g11R4
         gehgZLUF5qZgJ4hIEnorMnnKxYOjz2bHliqkP9CUOaizYYTS/6JAxf7o/tjPDkpVglQy
         zPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203080; x=1744807880;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gy/NwJ3yzcnIgIQYwzci2ifOwNSda9QUogpoaksyLg=;
        b=vfZzMJ2ZuoxgkzrMFtJqVS0UH9fmnyTZjk4D9kmFxZnJgA1f5TuzKZf0ajc0wfDJIp
         KimY+e/DdkUmOu53zd+gaEjbBB0hB4HK2oqKh8aKwQvkDNAl4YaN0BKBA5wWHWHGerrz
         SKLev7ItVWs6+2ZIe038rq3rCYdnXjXNRljAaHNl1E6iLUsaeBTPjJRoKSliSepsUJGy
         DLeXoqkKbJffkVFFoS2bjujZUL2cGpeCjrlKYePkak/B9SvCIAwH8a7t2qRpGX+QXUqI
         ZntQ31wCVR6NvJvM9UvUD3Xj+5Kep0iVCA+g1J91gjIZxsjNri0mxOXRofusvgv9arRL
         brSA==
X-Forwarded-Encrypted: i=1; AJvYcCUIwPiKeyiEKE76ONLekmnQwxC+4T9T6+QWjG8Lhfv3SzYiAKO0Mr1S4A22QiBOJivXxfXNV+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHE3i2ea3xQQBMiATvVYt0+pSIdl3fX02WNOKwyy+L2CNTDUmq
	eUwO3Er+KWNb/t7hstN4NEs286yZhC56bem1NBHwq5QL9Ojf1dS/17tLseZl
X-Gm-Gg: ASbGncuwpec4wBq1wlUwbgvAN5hPwZtrhAq4uXsPYXz6ypNWLe7LhgwLXYLtsFPZpZC
	07r1V6HRzWjv13otFPmBUXerBbu+f4SXZfsYhpW3hW2y3HqEQ5lsUuMaVYNyDy7nKoHxcEsCjnn
	NVCq0vUiLL6N+BGZ3NpPFX81orz9DfTwQrsbMEygUXkSWzTZ4OeFNZiaB7GuO8jIwi1I2U7x5B7
	6Dye5An+PpCo/YR6H0swFe9ogs4ub6oam/bE8bP8s4MT7TUxs+JRqO1glqwUzfHbU0VjfrcR49t
	SrscacYn4YTpIXrQn0rOAPQtuE781WTAJBUuB/+RUP+AbhAiGGyEfuJ1upX/JJmI
X-Google-Smtp-Source: AGHT+IFWpdGbDZtDF6FeKae//6V0aOgRN8+ECq73PrJZ2uXnvYXMKenyUWuOYp6EOemOmbj/aNocDg==
X-Received: by 2002:a05:600c:1e83:b0:439:91dd:cf9c with SMTP id 5b1f17b1804b1-43f1fe1676emr30831375e9.10.1744203079645;
        Wed, 09 Apr 2025 05:51:19 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:2c7c:6d5e:c9f5:9db1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893f0b35sm1543135f8f.70.2025.04.09.05.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:51:19 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  yuyanghuang@google.com,  sdf@fomichev.me,
  gnault@redhat.com,  nicolas.dichtel@6wind.com,  petrm@nvidia.com
Subject: Re: [PATCH net-next 11/13] tools: ynl-gen: use family c-name in
 notifications
In-Reply-To: <20250409000400.492371-12-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 8 Apr 2025 17:03:58 -0700")
Date: Wed, 09 Apr 2025 13:38:37 +0100
Message-ID: <m234eh33xu.fsf@gmail.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-12-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Family names may include dashes. Fix notification handling
> code gen to the c-compatible name.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

