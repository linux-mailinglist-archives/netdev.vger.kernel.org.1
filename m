Return-Path: <netdev+bounces-230058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5415BE36F3
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6109B34C2F3
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A724132C30B;
	Thu, 16 Oct 2025 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/vwe4ji"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319A431AF00
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618307; cv=none; b=d3aFGV7pE9EIsvIuiBxu/qHLbngutRhsY4kjsY9ReBhljB/RWdrbgP3QD4Il482SB3JP1ZlTN6OtVwq0cz3XUv7Wk2PRVf6iUx4wqGiwjyIJrakE/7+LlWeJZFVtJp5SnzNHQ0Ebh3XMFYdkwgYzX8d2RQaQb/sXAAQQe+p8c6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618307; c=relaxed/simple;
	bh=Dd9bbstWTxKW6GEQKajDsyfE3C38pzh8JqnmYMwneUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noebDaYp8gyReyShlcdYqT9dIqeadimy3koGf5OxKNhVlZsI7nqrRKKmEEX8P5HnO2BHx0/Tlfa0cNCjRBsgP286sdu6hr+o2dbqMONm6ACY4CPrXv9Huvrmwd7JW6GKSwvvKtJN/hKTbZ1ztsaKqsJFpCChU64Dmn/tL8mr1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/vwe4ji; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7841da939deso667955b3a.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760618305; x=1761223105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzn3hIsMXxvxQH6Pl2+jyVSLI5DbYlEg7TFGTWc7hzg=;
        b=T/vwe4jiyxGpT1S1oc3wPNsENwprBnoTGQBNOtOPdrlK54vWUO6tjtixYeiXuTuL+I
         zEQ4UuOWzZoOOgtPWCiL/svMQ/+JdGTM9ZNAxyI4BtGSIQtu7cy/SJR11MnqP7iO1sbD
         /yt3Zxq9Y1HEoPelnM5lGW7BKQGUzSJGYsG07iWp4Q/9pPRhrFNL3EoE4Bei6xWD68bb
         +YkrRDfUXLLtSAbe1glGjm7Si7Vw3lFVxtll8K4nkvB/cuq0gIvlXa7H17vEc2UFnIZ7
         M/pd1vIKGZGyvlsVuDR6COX80bIMEidx87hLlwKP8gAWP/8wAuKipmopnoI2SmgqIMKy
         0+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760618305; x=1761223105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzn3hIsMXxvxQH6Pl2+jyVSLI5DbYlEg7TFGTWc7hzg=;
        b=b6pItGcmoTjAUeR2oCUZL5Nkv5TzveH0nqD9LrmOaHb2tkaCidktwtWpp9ckS/Bsql
         2Hx28acXmb8uj6zgPiH8sRoELzmwrJiOIeLYWQNwE2f37bvQekGnbu8TSxdMVH2CvxP2
         uaaUiZd3lK+cx9kF1nYmWrWGFb1i65qMQHi7piW+blY/uf16UpZvlHSDEEUFIOCvwLl6
         aOaYLyk4TOSdX6gy3xJmGQCQeBVl1XJQ1P98K9Zffl+/KPfw6sfdQjS7zyQAbvjoGcHZ
         ELoSoiuxiVcEWNI+v5B82atfTNZ736PjHhfCZ+EOTofqcnQ1KxSfUoyavTZwmQGq1s4f
         GvHg==
X-Gm-Message-State: AOJu0YzBFxlXRnWS4+KGFWa+buLLdOBDq3WgyNr3IHCZf3wLwAh7UYbo
	F5iHbdG/ZV3HKxsdBxM8AOv/k3A/MLeHDn6HEPe43xn8Hdgbr0wAnW+3
X-Gm-Gg: ASbGncvCy1H9yPBmoGk5wiZ9q72YW8swswH4jtyrpRMQ+EenxBdbA/7dyWvHmmXKENi
	OBvsxnkgqL4/24IYyf2KUGRFhsTPUhiez0g6bmn/4PbMgBnWHsooUwsHxItdEGZMQJecDq0CcFK
	0NSaurQYxIu6ZjUuJo90voMUbWpoirK34YGUc/MOV/OGROgSKYEBGSKDNQlU7yX3VjRsQaaEQDk
	qeuw5/OPdkoC83lbJXFDAksWrfpdfXyMeqwVIvVdOJDC4+Kgt2+m72xFpQ2mTaT3gULoXg4ctN+
	NSVEoztpYnvyoOg7bT1P4eepYgexk8knyb5wD+9CNASdrNbh/7z0J5ZBYxUSSqYSnPau6k1TUnE
	lzwhdq3kdBcOfyjyuRsjRBp0VS3ZiSxPDDkRLOKvEwdMGushAqWXvC37Y3x2ULRck2o0y0PgVjo
	xY6G44bVZhXQqgVQY=
X-Google-Smtp-Source: AGHT+IHaEAqXhlDDVHzRiYiU8r+iTf++U36IibLSmyfdTTGveuzbh0DYZipswjt8IVOLHS7FMFSoVw==
X-Received: by 2002:a05:6a00:92a2:b0:783:c2c4:9aa5 with SMTP id d2e1a72fcca58-79387d0f5aamr43386468b3a.32.1760618305303;
        Thu, 16 Oct 2025 05:38:25 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09aa20sm22165667b3a.39.2025.10.16.05.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 05:38:24 -0700 (PDT)
Date: Thu, 16 Oct 2025 12:38:15 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <aPDnN072argrq23q@fedora>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
 <aO74J20k16L7jS15@fedora>
 <to4zjjo5wfd5suootcy2v7n7kuc6rym3ld4jov26nunnarji2u@2hr7jyiq36pj>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <to4zjjo5wfd5suootcy2v7n7kuc6rym3ld4jov26nunnarji2u@2hr7jyiq36pj>

On Thu, Oct 16, 2025 at 01:27:00PM +0200, Jiri Pirko wrote:
> >> How about "master_upper"? This is already widely used to refer to
> >> bond/team/bridge/other master soft devices.
> >> 
> >> MASTER_UPPER_DEV_VLAN_FEATURES?
> >
> >I'm not sure if we should avoid using "master" now. Maybe just UPPER_DEV_VLAN_FEATURES?
> 
> Why? We have "master_upper" to point exactly at this kind of device.

I mean try not use "master/slave" words. I'm OK to use UPPER_DEV_* prefix.

I will update the name if there is a next version.

Thanks
Hangbin

