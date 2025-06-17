Return-Path: <netdev+bounces-198580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A538ADCC2C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD223BBAA1
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59172E4266;
	Tue, 17 Jun 2025 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFGzKnL2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C02C15AF;
	Tue, 17 Jun 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165200; cv=none; b=ZWqFdW1Zuo4ptsbQxaNc6t4094wvXv1NQPNapRqABL8KR64Cen7QsEU0q9tfv1XwUmlllVg/NmXVYr+ns6+HHn6fRX0oFN59l4ULjDxBiHQb/He8sWk/XAuiZ/sjjZwaIuX/8gnr0OyqurKgXqgAwuN04DbhrbEjgjEhbLx2U10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165200; c=relaxed/simple;
	bh=zWvxu2gtRwziN0D1uM8YBntQ/sMq9MebxFHK1gkA/iE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=kn0V4//1T/D1TFxk3IzIXJA5fF9bk27ZNWDOcBxFX+BIb/9g1lPhZl3R0PyNBVs/kia4JiA2NplnpCMnMrpR60ltqEGiztOZXG9RYdemCJnfnjJgBe/gBlpGn/LYLahnkqhPf/qVMO9e0CByt5v/TEL2V5Xs077mk+QqpsJ7osM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFGzKnL2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso2280565f8f.1;
        Tue, 17 Jun 2025 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165198; x=1750769998; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWvxu2gtRwziN0D1uM8YBntQ/sMq9MebxFHK1gkA/iE=;
        b=EFGzKnL2dRyaw/ntf/g7Pr8Xq72x/DQXc3XS8oUhHkIx4aQcgK+SFxi3W2ui5zaFW0
         vRhubQMDDqb7501W9Wj1hoNXKdFVyP9Zhml7RfEdlzPf8DU824w2TVedj09vs4lx9t+1
         S+jg1nRHMcvkCta5NWJWQBHOcJyMzRl706RbGt1pRpCY5yK6x3Rto35hcheORZuZR4i4
         e0TqlQSHz4VMzgSRD2Arv7ST6+k/rLoBeSTFN8P1fhCEzbhXYh3CjzHU7R0LQDa8FY/c
         MAf9aRsbpCrvYTH2MCBE0cy2ktERiFIeZcc8+4ml38UT7aiPjLzGKJEwD5tcZo8/mhJe
         kB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165198; x=1750769998;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWvxu2gtRwziN0D1uM8YBntQ/sMq9MebxFHK1gkA/iE=;
        b=pdUq5BvVzaTVkOhkOwv+GM8hIyna7bpgMrH7cL6aNH+jFkq5AvoHQo5Uyy6icVC1tC
         T5Xb1nYZNLrm6cWc39SEJdlDTI2WZPt4Cai+uEqoDx4WvCDkQdjcCOcjVgXzHPhkVLrC
         /UaOB9BhLdJRv+wLv/dgN4wo2tMV1uECddcUhYU9bNsqnHMEeq89uU0BGLHXU4VtUpJD
         5Cp5GiJorfKsY7brBNDNvYzFfAyPsgolaXTFNq5W9LXyrDGVkUZ0WJMdx4eXKaOdb851
         tEYLu74y1XL6G0rTOi+bnWQWcpvGsYge6DDSLOUJYHceWQ4RwqhNlZvObcM0lqh9pNe9
         YOGw==
X-Forwarded-Encrypted: i=1; AJvYcCVmZjCZ+/4PNjXXIf548UJBioGQcKSfIB2WXjz4FS0VImuhPVBtJpY6IBR+M8o8AaOyH6z0G6b8funB3cE=@vger.kernel.org, AJvYcCWfkynrFb8s/mE+ky4Lq56xB7hYgCAlTp7R2s3x5CqliRz8aR19xXdrNvbCoCBAHBmn20LvFrNk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6oFo8lsg/GMiSb4N8f095BAK24wJ+l8FgXTLYaaA06afovtP
	pCusbxwvyZQj8y+lQ89Vs4vzwRRO/z1ddUfUZfw1ABkTSeuX8wpC2gEJ
X-Gm-Gg: ASbGncuJRA1CcVlSRx54qI7rQetItnoP7vWKsiAOoF93vxBcWKBzcJNd5DQPdBoU4Ai
	s1SrSgiNZvTdRSZn1HiVlIn2L0j+JfIYhlI4AYeummR8iZRgtmyD9lzDn3sGoYwi5VNtvTTIq/D
	mVMYBsgVwkD6FZkPkme0pxDY4fJtgjVsqzkI4lpgQNEafM1tS5y1bgZvXd+zCNeErID4FIbg/CE
	HrhAPdux1Em7IAC3hX79sglRCUTDqBfOs7Rsz0xmSrVF7r2DRgc+3GR3GL9NtksQNCVNzg6XFOc
	J/+76or1tUXaYpa2Gg1Ums4gQmJQtHdVrYPFG20QL5kLQYlGJ0tiuuOUa2EQAbOpmCWbYXq8r5P
	XENJmsMQtuA==
X-Google-Smtp-Source: AGHT+IE8AiYw8pPM0MPp2QbRXFeBYuO8zVpjLKhqgwA0D8FzZ7tZ/oOZfwEVscmLCWsCmLOOVvfUlQ==
X-Received: by 2002:a05:6000:200d:b0:3a3:5ae4:6e81 with SMTP id ffacd0b85a97d-3a57238b515mr10306104f8f.8.1750165197492;
        Tue, 17 Jun 2025 05:59:57 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8931:baa3:a9ed:4f01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b47198sm13723974f8f.81.2025.06.17.05.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:59:57 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Ruben
 Wauters" <rubenru09@aol.com>,  "Shuah Khan" <skhan@linuxfoundation.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v5 02/15] docs: Makefile: disable check rules on make
 cleandocs
In-Reply-To: <e19b84bb513ab2e8ed0b465d9cf047a7daea2313.1750146719.git.mchehab+huawei@kernel.org>
Date: Tue, 17 Jun 2025 11:38:26 +0100
Message-ID: <m2wm9ak5zx.fsf@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<e19b84bb513ab2e8ed0b465d9cf047a7daea2313.1750146719.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> It doesn't make sense to check for missing ABI and documents
> when cleaning the tree.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

