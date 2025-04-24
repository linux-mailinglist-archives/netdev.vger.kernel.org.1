Return-Path: <netdev+bounces-185458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DF0A9A781
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C537A8E9C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9D52147F5;
	Thu, 24 Apr 2025 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jvPWtqIf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1834D214A82
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745486107; cv=none; b=a+CKbT2f4jrpRuZEq4MWBoXFib6aPyx3XkaBZdALoBLzcpUrWz/Qjqnt++lCA468qbQMbNajyplLdYJOsQuECPHja1zGVYw+syBgZ9uxuqLyMWl/VCy2q7PHNsJsOc10L2WvSvfGoFXI2lERbJPnBSv0KvwtRkViuEtjYmr2w54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745486107; c=relaxed/simple;
	bh=in/2y0YoZ2yZl4c/CdwB/cwwywlW21ZOpJuMU1dwn4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q88z5KJ3LQEp7FrO5jtSio/FhQ3WS5i/jU2pWF0cxlWNhYXZ0IRf54RcxEnFfOgPLg3yqH3g6M8z/YgBmOHGdFn3Gj3P4eIwOdAf/275iFUpV1N+km7JOouti7uAOGC5OQ+kamnpKevQV+HLsbhLPSjFUAeLFIn/VysOTxIgV+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jvPWtqIf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so835373f8f.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745486103; x=1746090903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FiDsSnC1Jo5moXRMw1WQLWKEZeoWVNhukmu1XrjYXeY=;
        b=jvPWtqIfdVjnSX28jiUUf1CSUCgNEtlAtBpLVw8uqfBW+AJmKN6ApudLvhZ2aEwGz3
         kh9pzFeKToNQCYIfr0gIcylpRyYvSEr45Wf7AO0+nJgz+MI/MgrzKizlIJoG+xu+xtpu
         +Z9ohwv4XvXZGKg7PdtagyUHPgAGmxkfOzWodWFAsMkPQpUE5Ex19DgRNKvzNmKlxvKA
         mVxCssF1btpuo4FHCgdXPHtUzlnUGmhp7vhS3ZeEMIBfGFbgB+/G7mXsmR4ppcqRk/mH
         0TriowjfPNsHG7DeGFUmhIkw6l4tsc7PS1I4EKeapQRaK0DHLfGDBhnb0ALTANb9UJYR
         RnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745486103; x=1746090903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiDsSnC1Jo5moXRMw1WQLWKEZeoWVNhukmu1XrjYXeY=;
        b=EwPlcJ48EJ8UL17gi3XlxGGuwDdCn9QuHjCpE6Tz+vLMh/036Wohg9pl8TG7XQcO+l
         +6JlAyPOwqX/Sw17+8x1EvQqvBvM2dGowcJuHtEsHO2BQpQJqCT1K3L/TWUPX2M3pmjr
         6CgBsMFlAdvUbwO6jqgQQCOgETAW9tvkkg3cXmBgnyUMVgHyQzeVSBf3soT6bnYpy2on
         l8n1tlmcfgNrKqmRGSA6c9vukoKAVUuBK65weZJQpAC0dgF56Tas5DI1jG5e5evsos+W
         2b3NL7rEeOkOs00/KQyZrhOpSB9ZUb2ZaqpCXTRN+KPLkwcAaNYoSumZTS+JeC2sdztb
         hLww==
X-Forwarded-Encrypted: i=1; AJvYcCWJFWM9xVcRSFLYwEIEThygsdmkgAXeU46s2u7fDuWHgeygM2FvA74e0sMKnusm+lcrOlRu1go=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrzV+K763EPqy3RaR1ss1VBwV6KxCPjN1h6mWv1XZEkJQawiIC
	6/YG5vYuRYhEeBm8JKb2uIky/uNdm8bn0W6a6PUCQ2ykU5WZYOPf7wIYMS9Qjgo=
X-Gm-Gg: ASbGncv+BBnUQOIkjt2Lq7PhArLi04y41V+vM/6ZqrVK7lZPb3gnKjU7HDZPSZgcE6D
	rVbXEifiVZ652txi3h13cVdl9SQTUlY/Phor12JaGopDMUv4P6lZvrGQd+0JouDZFdgnpMEGbWg
	nlz97SnAU01ntEUu8TkjOpQrR9quKjL/4A4jjaM1KdVV/2FQXzquObX5cvoq/W8PODkKiLGIzkR
	mvV5QMs9FVM+Jk7tW74g75GKvznlfM4/L/k8vsySjahw5bPS4KSw+CJ8wtLd/vq4vIWjwvkb+6l
	cpxUX+ebkucH7eMfm7S4f230acvmBWKFmU69bk+dE8Xn3V6VkpLx+A==
X-Google-Smtp-Source: AGHT+IH4I/sbwt8HJrCkcK469I5qqmyCDqdV1L4VN/TndZ6j/MVQ4zf96BLAR38phUwb523qaIQTTw==
X-Received: by 2002:a05:6000:186c:b0:39a:ca05:54a9 with SMTP id ffacd0b85a97d-3a06cf61cefmr1132529f8f.29.1745486103059;
        Thu, 24 Apr 2025 02:15:03 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d532aa9sm1439089f8f.68.2025.04.24.02.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 02:15:02 -0700 (PDT)
Date: Thu, 24 Apr 2025 11:14:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V2 01/14] devlink: define enum for attr types of
 dynamic attributes
Message-ID: <djjwnxpqfcngooptb67pvelhdb4n53elnfgvq6wqjql2ss4egr@osfsq5ccs2tt>
References: <20250414195959.1375031-1-saeed@kernel.org>
 <20250414195959.1375031-2-saeed@kernel.org>
 <20250416180826.6d536702@kernel.org>
 <bctzge47tevxcbbawe7kvbzlygimyxstqiqpptfc63o67g4slc@jenow3ls7fgz>
 <20250418170803.5afa2ddf@kernel.org>
 <v6p7dcbtka6juf2ibero7ivimuhfbxs37uf5qihjbq4un4bdm6@ofdo34scswqq>
 <20250422075524.3bef2b46@kernel.org>
 <ccwchffn6gtsy7ek4dhdqaxlbch4mptjqaqmh43a3rk7uu6dxu@jfua3hr6zxvw>
 <20250423150735.566b6a52@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423150735.566b6a52@kernel.org>

Thu, Apr 24, 2025 at 12:07:35AM +0200, kuba@kernel.org wrote:
>On Wed, 23 Apr 2025 13:12:56 +0200 Jiri Pirko wrote:
>> >Coincidentally - you added it to the YNL spec but didn't set it for 
>> >the attrs that carry the values of the enum.  
>> 
>> True. Will drop it.
>
>Hm, drop it.. in? I mean you should set:
>
>	enum: your-enum-name
>
>on the param-type and .. fmsg-obj-value-type, I'm guessing?

Okay. Makes sense. Sorry for me being a bit slow here :)

