Return-Path: <netdev+bounces-240065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D1793C700A0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A5533524B1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCC82D59F7;
	Wed, 19 Nov 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aVLrGC4k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F8236E56B
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568622; cv=none; b=RMrqBBC4hBB1doRWooQ5NC53puDTCoOrYtamv0ERXjRKAbQgvzsyylnLkFetwFa5xN+6aSOSRIgyLlQQ03vDdR90h0gQ7+B4Dlb8oABZ1XB5FOfYvzdV1yEbDEaysr4jO3aYvchb4Fn7L5VqxE0AZFUGE2jRHEEcqDkhalmEKkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568622; c=relaxed/simple;
	bh=mHmSBdBUMsM98MKMQ16j1/Bj/dx65pntHMGDTY2scS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCR4/beQ9Hka8ilPYIfL1f6cU4fPqrwIK8RKrFz+YYKsZ/Yh6JleCyaTDe1CxZjwik1yp3kMhe8ggRKBT1OZDMFOCtK4DL14dwouBVeY4V49mRFvqVvZ3LRBAlqL+qy8gaQeLoavJcEvsHVGi1zfsh4jiqy8RODpdXQnUBvVcUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aVLrGC4k; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b737cd03d46so645915066b.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763568619; x=1764173419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=obMO0wYPRukfGEWb9Ik5Mm0Kc6J6YzvOIw86E9DCTVA=;
        b=aVLrGC4kb0XZg19NyUJPeVGLsGEKG0Dj615KQB28MDqlKDLP1JaoiTTEg8c5Arpqj3
         h3gAUA62dbsd+p68q2KxkLJK4oxlDzRIVC/8LLXKGXDAPVgAbsA0IlVy+zqvIXKIGTFm
         cqspXGvRdUIdW6Fn+xTpNLmvT/9UHIILeApJGoyfaPU4zjSMcGV0ulCm0NrjL79RI7qr
         YyCinEpjKeHCtsHUoDFuNy56uh9WdTOR6I3ACHYhP+ZGGNHr6agcOSprCFR/jUv1rqir
         Os3TkrqEdJAUnX43a/+3rxckYSk3fiwyXnFLbUY3xc2P9XxmEoFMz4peJdzUQBwpnkCp
         mvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763568619; x=1764173419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obMO0wYPRukfGEWb9Ik5Mm0Kc6J6YzvOIw86E9DCTVA=;
        b=LlLapad84or3bypsJ/n0DSI+ClYKg+BxuTHFeiSXEg1vv3iXd3AE9i5XWsrWiFUiRS
         gjU7rb1KV68Oz95ZDeA54Wt5yoZj8Qy108gtDYERsk9fybYo+vcYgDqHpIGz8rgmsrmv
         nT3fGFFS/mn4n9gk6t2fg28y6iAvWIDh4tJWkUPj2ZH3cfjV3NDJ6SkLZtL87HolGbsk
         kwu22jwc0K5ADLnpL78FJnsA9uX9OQAhZ+Wg1R2G3Z6YziKpP6uDwwmTbj4ShmfmuCH+
         6z9FKM3enyWMYv8VMhl59cTUMJ4ZQKIcu3ohXQKgA3RMkN4LYC04PEKW/D2Le1eFCcau
         v8Xg==
X-Forwarded-Encrypted: i=1; AJvYcCW1rlQlPOGDXTpUXUrDRPyM6gf4CnshAMClROvmoI7wiCMldAOPs7CCvoKR6K60eb7U/K2LnC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYz7IBoZWP7iMuqRSB1ZW9KstSfD/ZCUP/a01REF5CbGoU+ZkD
	h5u1Y84ylg1eIJNUT5WVUZsu48nRdnnaxTyUWcdJn3u3Zc+in2EYEJaEgfqnVU7oSqc=
X-Gm-Gg: ASbGncv+ku561iepfsE0qtnCY3qID3jW0Sh/430nJK5OmCuFM3vLL6kxrUYCXFDnvuW
	qRdVSRGOa/Qo8zlSdAVvcofcRuaniWIymHWg3FZTz5NyD99qKtfCJDrmlwoFilVyjQXPOww1ELd
	4DpiFVcmXBUtNCvzM+Rt0b3oZgA8DpbpNZPinLCXIfkNdTk7xQg9uNGk6UkupFZM+Rtg/1Ex0y7
	Lb31SzqJb53t4qdNXOsjs80Q5CFLQc77plbEUj7Mu5ZIX4k+T9QCcnC3nj/OUOUqtE0+TCWkGpI
	RuO/xK5IBBMZWwSTfVLGrkRLvonkdhmryh9gKghjpNJo9+mHnLIs6zZJvPXG7XuX1Kz1CmgPxNa
	l//fPlRkv3Fqidk8JC4l9YpRRUgmBaKuAnBPpIrIYurdwZioukO3vBkQU2QCcLGYsQzoShGmuAt
	5UxlhH7Fgt82TUlUWJjjc8KrI=
X-Google-Smtp-Source: AGHT+IEXAArin/coa0GZgSrEav6MLboqNEKcMPid0tRL7uyYDaIetyaKZwreOBItTdMx+ON6Mg2+iw==
X-Received: by 2002:a17:906:7d0:b0:b73:74d6:d360 with SMTP id a640c23a62f3a-b7374d6d4e3mr1534730966b.40.1763568618474;
        Wed, 19 Nov 2025 08:10:18 -0800 (PST)
Received: from FV6GYCPJ69 ([213.195.231.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad800dsm1664562866b.29.2025.11.19.08.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:10:17 -0800 (PST)
Date: Wed, 19 Nov 2025 17:10:15 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Nikola Z. Ivanov" <zlatistiv@gmail.com>, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Subject: Re: [PATCH net] team: Move team device type change at the end of
 team_port_add
Message-ID: <mekjl7qqrb6nkk6ru4fztqxzemldzbsplf5tzuu7amc7yaa5j3@rulh6ijsppaq>
References: <20251112003444.2465-1-zlatistiv@gmail.com>
 <c6fa0160-aac6-4fc4-b252-7151a0cb91d3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6fa0160-aac6-4fc4-b252-7151a0cb91d3@redhat.com>

Tue, Nov 18, 2025 at 12:46:36PM +0100, pabeni@redhat.com wrote:
>On 11/12/25 1:34 AM, Nikola Z. Ivanov wrote:
>> @@ -1233,6 +1231,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>>  		}
>>  	}
>>  
>> +	err = team_dev_type_check_change(dev, port_dev);
>> +	if (err)
>> +		goto err_set_dev_type;
>
>Please don't add unneeded new labels, instead reuse the exiting
>`err_set_slave_promisc`.

Well, that is how error labels are done in team. "action" and
"err_action" is always paired. Why to break this consistent pattern?

