Return-Path: <netdev+bounces-122775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 985E5962826
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D661F2490E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7B21862B3;
	Wed, 28 Aug 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nwL8iclV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8768D174EDF
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850133; cv=none; b=sSlh++8qGQ/bzAILSJfMi3eP2TTGFAZ0CxgG3j5Ir0cd2fS/xd3wOhrFXjLzNgjMUf6d++tjOJ/dBg1fmQ7bAZL3BTLxWdN/mSpdyB+V61x46LFUrwBjNGynlE4jHuGEcDM4eVYdtUQ6PbHR2i4WOHoiiW0f3Jet+8cdZrP3BFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850133; c=relaxed/simple;
	bh=YW/EEtXgeETLFFYtUTMkx2TeMKhtdDTvNiLHJqoT6SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDMjmgdLQkv7+BKhAl/KJ7FJNTpynOwdtGhjBjmgPYyfIdqgZ1tVJUKCuK1bRks0V38+gvULXTAK6ZgR2DuZ7F49IknGgkBeKpinRkHqhAZhPg3KiAtOad8Mr6IfZzvikvt8Lf6UW9NuFvPsBt3ktOzjVo0X/4SSWLc2EWjEI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nwL8iclV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280c55e488so3644815e9.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 06:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724850128; x=1725454928; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mmup1prCsSAveeq41yKkxnTwUrUc0XBZbbpuemoosDY=;
        b=nwL8iclVz+HpbRJUqajCtTy4H3TBywU5YE6Zw25sf5i11rOSxnP4I5AFyLLRwSMTyi
         6IdUZA84vQn9vKKFSqi1xNXOVHUf3+WggZpywS1tCZLGSGzL3UonHP1QrjWL5mFyTN/J
         z9qgKWHmaXyvk3YUMxUZCjbooqzZ8NLt9rPkRpibYgk5+bxLEGIcv/GwaUyfxdwA+6SO
         DcuWijugMg4bZRDNKgv9QN2HNGe1IbWv1YZ5h4oyHg0ZtGLX29eshko/m/xz5uoCVNAE
         IveIACYRytCuVeosItkZIUpJ9pSj8XeBdvVHcEg6qHyGHhSxN8kLAZ7hI/FqUBmEuFsl
         BU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724850128; x=1725454928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mmup1prCsSAveeq41yKkxnTwUrUc0XBZbbpuemoosDY=;
        b=uEftd3QdyszxOnslMiE//OWy5WS9O/a+c93xJUK0yEEAF3hWCCWlAIyPEX1xZu7fM3
         f5wLEZwg6xEFzghL1K+PK14X7hx6FjcqENd144x4Lj6PnuYooG3O1FDXpGKD/JGnilhK
         axJ2UzdR+T/Z2RHeqVixtHMRsKQVNbsXjvlqsMSvtl4zzk3b2IlHHLo/fjJ59SGKDuVf
         fQMxcpEmiLXcIvhAVgoj6lEtXm6fOKa8h/tgbS8fCItOJXI1/MOnrSlWdK7+JGDM5sVy
         CtIRI62omUSmEQnZVT435OoXma8FUIw3qoZuDhFF1ewL1haDRPt+5udaHBBTW4msA1LY
         75kA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Tz713qoYifvNqNpUuMmtStQXwNt6NMt8hZfX2WBRyT4Mh+LFsfUUo1v0hQbUwoAvRjhjjBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz6bH7JT46LVDAxHxHZwE040iVno/MHqgbjN3C30vFZ44VH4/a
	EBFOFm/9rdFF+WKU/F0jm+JTvo43WNxJ0V7cSLAX7WKd3FDGaXRc5E9NqBXpkf0=
X-Google-Smtp-Source: AGHT+IEm+WHpRdAJGfRLPoUCMWf3gf8YblqWr20+YClpfaWeQgOWWtsVTJ94b/3Yj/5DOBlz4LE5lg==
X-Received: by 2002:a05:600c:4687:b0:424:a401:f012 with SMTP id 5b1f17b1804b1-42ba5674248mr10695785e9.3.1724850127369;
        Wed, 28 Aug 2024 06:02:07 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba641da5asm20904025e9.36.2024.08.28.06.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 06:02:06 -0700 (PDT)
Date: Wed, 28 Aug 2024 15:02:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <Zs8fzY-QA1e8b86T@nanopsycho.orion>
References: <ZsiQSfTNr5G0MA58@nanopsycho.orion>
 <a15acdf5-a551-4fb2-9118-770c37b47be6@redhat.com>
 <ZsxLa0Ut7bWc0OmQ@nanopsycho.orion>
 <432f8531-cf4a-480c-84f7-61954c480e46@redhat.com>
 <20240827075406.34050de2@kernel.org>
 <CAF6piCL1CyLLVSG_jM2_EWH2ESGbNX4hHv35PjQvQh5cB19BnA@mail.gmail.com>
 <20240827140351.4e0c5445@kernel.org>
 <CAF6piC+O==5JgenRHSAGGAN0BQ-PsQyRtsObyk2xcfvhi9qEGA@mail.gmail.com>
 <Zs7GTlTWDPYWts64@nanopsycho.orion>
 <061cba21-ad88-4a1e-ab37-14d42ea1adc3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <061cba21-ad88-4a1e-ab37-14d42ea1adc3@redhat.com>

Wed, Aug 28, 2024 at 12:55:31PM CEST, pabeni@redhat.com wrote:
>On 8/28/24 08:40, Jiri Pirko wrote:
>> Makes sense?
>
>Almost! Tacking aside the (very significant) differences between your
>proposition and Jakub’s, we can't use devlink port here, just devlink, or we
>will have to drop the cache too[1]. Specific devlink port shapers will be
>reached via different handles (scope/id).

Ok, I guess. Need to see the code.


>
>Additionally, I think we don't need strictly the ‘binding’ nested attribute
>to extend the NL API with different binding objects (devlink), we could
>append the new attributes needed to support (identify) devlink at the end of
>the net shaper attributes list. I agree that would be likely less ‘nice’.

True and true.


>
>What about:
>- Refactor the core and the driver api to support the ‘binding’ thing

Ack.


>- Update the NL definition to nest the ‘ifindex’ attribute under the
>‘binding’ one. No mention/reference to devlink yet, so most of the
>documentation will be unchanged.

Ack.


>- devlink support will not be included, but there should be enough ground
>paved for it.

Ack.



>
>?

Thanks!


>
>Thanks,
>
>Paolo
>
>[1] the cache container belongs to the ‘entry point’ inside the shaper
>hierarchy - i.e. currently, the struct net_device. If we add a devlink_port
>‘entry point’, the cache there will have to manage even the shaper for
>devlink ports group. When accessing a group containing multiple ports, we
>will get multiple inconsistent cache values.	
>

