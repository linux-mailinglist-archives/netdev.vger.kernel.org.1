Return-Path: <netdev+bounces-148589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A619E278D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85757B2635A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76DF1F8AC9;
	Tue,  3 Dec 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ahu4dCmj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B411F8933
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243176; cv=none; b=mRixpmmjsaX21NEMh43FFOOG5D/kcH5SQurhhJcTN+tEAWxz6A9orUP1/oZIfBOAXsRNTda/jOcilUDph0fSF1ofo7mQmZEaTVKx9W9a1znNkKwjWbSumlZPxWVU+BSBtIRCE1G3gjLdP62LHUuv147ccwVSafQ3lVpjT6s7Tv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243176; c=relaxed/simple;
	bh=iKSwEj1QUd4Z6seRbKb5DsDKmOf5JRe9IWTGuEMsE7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6Io7pESfK5rSo9iu5O1o5CpERIbumPa3CjCPqKqN/d4+C/nDYuyA3ziT/W6KDzeHuUkicXo0wfX86N75iHbBoD/npfMSEj2DNn00JHDItkkV8s93p528QeDgetUSaEQ3yZbGyd5t4YW/DLKXLWwqbIm5sugq48uIdIKTYCBrrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ahu4dCmj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215b45a40d8so13127625ad.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 08:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733243175; x=1733847975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVMAhkmNKECc/EhK+RjBpCowxBMGNxsxV6VjcSeAbx0=;
        b=ahu4dCmjkZTiR4ojorbUJBdR+FTcaT24z/zcQ7esS0rdl8zGd/IKd7emi5GUZ5rm9M
         Pv7LMHSGqj26NLS6rJyR+u9tJDbvh6vuiD/SqCL0isUYFhtYY28Pt9AgzekZjIHX/Gf1
         rKfEV3EWt4jGXtaCwUTsl+ZPS8DnuJndnNynk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733243175; x=1733847975;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVMAhkmNKECc/EhK+RjBpCowxBMGNxsxV6VjcSeAbx0=;
        b=Dh5SOxQJBkge48naVrsEoXfqVAlFpCMxDdQauolhNAyabfF8/MKkFv3P+ZfvgOiHzb
         C9kLygezywbont6ad42Xv4/JesVn9HF49D/hRBQNCi8tbfEqGxNxuRcLNEEz4OfD413e
         UTJs14I6effcHfZ6kuWGqiLHcSooERDsiYmvjoUCZvusdzBNDdiRZvRKR9BUtpa/9i9e
         zGhoA6M2Q+DXkOMCDzvRPMH61MqodeTtEGWjl2J3ZicTEpdRYcO3yif8MFXUQSIdio2y
         BYcUbX3eONFA/qsP+QrAg8WbeQzHc4DndtzpePMRG01pzkt9j/TVNUCAwPsPjKIfy6/g
         AfDQ==
X-Gm-Message-State: AOJu0YyTMwo6qfW2brw9hFERy2W3Vwo8dx9fNXgo0aSJ7iqGHoyI8DZk
	fzdV/f8RMpWt7Ui7HosBHEi/M4heNX3yl7hFymfrZjL2KFmReSxIO90ZjAvP3cg=
X-Gm-Gg: ASbGncsRXv9tEerjsE7ko/T4ntV2jd+RGNWBGdr0vPUWQ4XtjqXis0QHBBxWaI1nn3Z
	KfRB+Re+c9feIc+ejiMfP4htiPARSbQDr51WZ+TAMbcWcWFXHuCF1hEBibKapKOsL9jgjrAFNpY
	VLBh0QxNajrk+fIOKEH3GUTYJueKEpGj4ASKYEFqqp6+d2xhUzXHBLlRYWHMl+kqaMHxm+JGkPw
	ewz/xEgzdAIk2cW5K2Ejb7F7+WRj4X3da/5T6FEVQNBUjZsupuTQdgSb0pChzOWEDfkn1yIRSEE
	JowYZCG7TafPETM+
X-Google-Smtp-Source: AGHT+IHbJxCIE7dNvn0u2Dahnh6gAzNdniqSXv5Pmp3C2Lyxfg+sQF/aKgavRzPI6bN7e0mY9bjTHQ==
X-Received: by 2002:a17:902:f686:b0:215:931c:8fa2 with SMTP id d9443c01a7336-215bd104617mr41724185ad.33.1733243174771;
        Tue, 03 Dec 2024 08:26:14 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f479asm96731665ad.41.2024.12.03.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:26:14 -0800 (PST)
Date: Tue, 3 Dec 2024 08:26:11 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org, mkarsten@uwaterloo.ca,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: cleanup busy_poller.c
Message-ID: <Z08xIyc7OcRoEE-C@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
	mkarsten@uwaterloo.ca, "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241203012838.182522-1-jdamato@fastly.com>
 <Z06T0uZ6422arNue@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z06T0uZ6422arNue@mini-arch>

On Mon, Dec 02, 2024 at 09:14:58PM -0800, Stanislav Fomichev wrote:
> On 12/03, Joe Damato wrote:
> > Fix various integer type conversions by using strtoull and a temporary
> > variable which is bounds checked before being casted into the
> > appropriate cfg_* variable for use by the test program.
> > 
> > While here, free the strdup'd cfg string for overall hygenie.
> 
> Thank you for fixing this! I also saw them this morning after a net-next
> pull and was about to post... I also see the following (LLVM=1):
> 
> busy_poller.c:237:6: warning: variable 'napi_id' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>   237 |         if (napi_list->obj._present.id)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> busy_poller.c:243:38: note: uninitialized use occurs here
>   243 |         netdev_napi_set_req_set_id(set_req, napi_id);
>       |                                             ^~~~~~~
> busy_poller.c:237:2: note: remove the 'if' if its condition is always true
>   237 |         if (napi_list->obj._present.id)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   238 |                 napi_id = napi_list->obj.id;
>       |                                            ~
>   239 |         else
>       |         ~~~~
>   240 |                 error(1, 0, "napi ID not present?");
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> busy_poller.c:226:18: note: initialize the variable 'napi_id' to silence this warning
>   226 |         uint32_t napi_id;
>       |                         ^
>       |                          = 0
> 1 warning generated.
> 
> Presumably the compiler can't connect that fact that (!preset.id) ->
> error. So maybe initialize napi_id to 0 to suppress it as well?

Thanks for the report! Can I ask what compiler and version you are
using so that I can test before reposting?

