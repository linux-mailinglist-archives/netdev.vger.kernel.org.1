Return-Path: <netdev+bounces-186699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262D9AA072E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EF2482D99
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7EC2BF3C4;
	Tue, 29 Apr 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXJyJZJI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBD2BD5B1
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918845; cv=none; b=TfrrkTQmV/oupa1sYYUeizqh04WhylIXvv1VkxsRQa9sFUnupt097VqLpac6ly3Z7i4lc27BEirCGEn9ywU1NISmEd/EOXdG4D6PO6CfZoFzFgkJxOwt1VrGt7duwhjPODGVdKA6RgrgWuwf0iQY2Gi8ryum1au1xEKfJm6uNFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918845; c=relaxed/simple;
	bh=hJaYS8BCdHkHpplqhD823KhwLYXzmQPkTGXjfsYZBKc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=a4qb8BjYTcoL1bjoHrfc6Qgr+PgWEQRglBmnhSXB2QsUwaxE56ETr7piFlaipd8pyhFW3Z1G5YvPdhLhUKFp76IGdO9PpWTFK6zUFyAVgRPKM46/ntJnHiuH0TvfbAzGajSpuowKN79hZ8y3EKr1bn2a6ikjtgXy+2BjfqCwAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXJyJZJI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so36337435e9.0
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918842; x=1746523642; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hJaYS8BCdHkHpplqhD823KhwLYXzmQPkTGXjfsYZBKc=;
        b=HXJyJZJIUDdzA6trK/IsQI//R4TcJ6pGaTJPYaDmZF/DbKiNDEK0mtIFbuqSHFkupk
         CTKtIWM2zhHkS6x4MNVd+a1PGaHtZRyHhHblFNadhv8Pq09XwmxQxcuvQNWve7kC7hl2
         Hizpf+8CIkPYiYYI/mUbUqonXhiJdD5gjwHdvi4q4lEwD1hRqOd4KwxK1eCwFoAKj+Pg
         7CxLrrsw1V4nD7YHxzmWalL5oZdCQ6Hspdo3vm45ocZIybSqfs/SANlxIl1ptF5owP7L
         B2YWzUYWt4ER64ldf7gnXFXRypJOViZTp6Xmm6hj7w5b3oabNZUY8KE0ISY1SxAHk/89
         dqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918842; x=1746523642;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJaYS8BCdHkHpplqhD823KhwLYXzmQPkTGXjfsYZBKc=;
        b=Y5W+ze/UQmup9PSzYuj2xDtYpsZjd/A1hyPqEJ9JBdywgiSYJp7U0BgWy1mokvo0G5
         lcu8aMnw5lXb0bSBpGJOpQAIKP5FRXYL4aQES5dS1YdXVdIgY77o9h40Lb1lQklzZvHH
         lr8uAgGPLAPcwbCGLDBcrb3PPAceeJjMzOvvOxqLt++14afytFyRYG4hXNter7q21z3G
         XZUO9S6oYmT6Bvfj5dr0qQ3DrXPEO0VU6y2MWfCsu3za9AzOc8Rt9ln5Cf71GVzhkbSl
         0hG7KzSsOCRZXZN7HWmfRNXFYXuL1otx2yX3iZWoIKwi8tkluZhX0BNuaZzC9t9v9+Jo
         HssA==
X-Forwarded-Encrypted: i=1; AJvYcCXI4StNKjNSBs35WG6TxjIikV7hheTSl4meymCLtb19adFvW0zzSvmve6+ScVcuUJFcObP9iiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJb7QrsrxIxgoM39SvpsNOL24EETqQM1s8bPf4kx/sr4+50j0
	pPzVygCX4x/coX0FBv9CTqzkIAePWkhMCmVTlQR6AMMkwvyQKHLF
X-Gm-Gg: ASbGncuq+S96S9rpWEeMcEro0udrjX84P5PhJ09+YTO0zu8wvErAo3dDSWQnS5p6K5B
	aF4Q+yO2DwlP9hMrHFf2GSgPG01r7MsV2JQSTN2n7sp0W1Fwm7EJv9obqlE32j8O+K/udNsWuXs
	BR9NuJL82Akwt+t9CaCtVL3drbU/SzgrNSvxsZBdRkeIaKHQQZANMt187U6nRQ+ZuqT/USDF3AT
	jJlQMK08cZ5lUOfZkRxbanHPEnGCi5Xsio4FMl0JS7r480o5q8Ui4ISyb6ILqAzviJ+asvMdnhO
	TnSkdluun0ryKhffge0BGwBKem0uYT+JhvYuOVPybHx6mMp4sq0bPw==
X-Google-Smtp-Source: AGHT+IGmJfEkfYredLSgPVI6XWu0bTIA24LttcfBb+bcZgLOYS7P+J/bzbD8Y9QBP+vN4A9nCc1llg==
X-Received: by 2002:a05:600c:4509:b0:43c:f8fc:f69a with SMTP id 5b1f17b1804b1-440ab77d34amr109852355e9.4.1745918841711;
        Tue, 29 Apr 2025 02:27:21 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:251e:25a2:6a2b:eaaa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a531dc6csm148886775e9.24.2025.04.29.02.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:27:21 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jdamato@fastly.com
Subject: Re: [PATCH net-next v2 03/12] tools: ynl-gen: fill in missing empty
 attr lists
In-Reply-To: <20250425024311.1589323-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 24 Apr 2025 19:43:02 -0700")
Date: Fri, 25 Apr 2025 10:12:54 +0100
Message-ID: <m234dwsiy1.fsf@gmail.com>
References: <20250425024311.1589323-1-kuba@kernel.org>
	<20250425024311.1589323-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The C codegen refers to op attribute lists all over the place,
> without checking if they are present, even tho attribute list
> is technically an optional property. Add them automatically
> at init if missing so that we don't have to make specs longer.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

