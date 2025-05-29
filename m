Return-Path: <netdev+bounces-194277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B63EAC84C8
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 01:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802483BFF09
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 23:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D60A21CA0E;
	Thu, 29 May 2025 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="EDrMxORe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB74211A29
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748559749; cv=none; b=le1hog572R113UmtAHjzjb5NnEEXaPf2P7Dk270DNV9XRTjAiGbf1hrJ5rXsgnPypMeT956136jaSVaGHaqK0ZgpbXWmGS1ZElhuUJXb8rhTb1/loSWpvSGlCUeXv7kC1ZcMxozEF28QdySwkfPgXsBPhhmw3pkmcd04/RFKJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748559749; c=relaxed/simple;
	bh=VFgJ42h1xmpjJ0zp39nNxG9Fv6fnSjEUmqFNPKsFatY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXfT6tdtFuU4G8DTqsdLYg/XwXis51SYMuiQTnQAdvfiZ7HqVDtjLDguahAzawCd//YSiSshdhHXP5HEo340Djbm/qeDfP9XpqXfdaN/7q4mnsRWPTc3ZD4iKDiQXxK6pYYeVKLmUoJRBdNVDpltQcjpcWTgSSo3o5aklquIB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=EDrMxORe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22c336fcdaaso13710155ad.3
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1748559747; x=1749164547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQH12qcLqrdzXdVf7YmZZp8XGkFuZzY1d3D5OkaR41Y=;
        b=EDrMxOReCgLv86pjxm+rR16TTAV+fQiU/ixOUQ9L+PQ36HFRbpxCwEAKCvtsufwLo9
         kX2PVtH5erBJfPtm7aP2tiqvUfC5cQXADuNK8Q+1Rm8l6bEPUAy9keEBp9LGZ16AbwdL
         wZaf6fSSbS6EKNj1OolfickP2rDHGJ2CEeFCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748559747; x=1749164547;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQH12qcLqrdzXdVf7YmZZp8XGkFuZzY1d3D5OkaR41Y=;
        b=aOKVBPJ8cwUKG+/NArC7D1bPsgqZEBEFVP0EiVgxQD6iMZUT/09WS/egQR76vWOvk6
         +Hf47aV96mT8nTkgnvNLsMe1fItTDjQHLUSp8hUcUufHC5cy5oeduxwrTMc945YahilI
         0O2eOxt6ViLxkwfEUuBWkvSuXl22sZf3pl92EeVrf5aowXvQ+XcTLqDGNQHVTt3CsCeg
         cVZHEjvqmBFX+czY/oAvYU3gKyH5o7265xV/qxr6JX2ziSgD/9AVi+Ca9EOfTBA8Nhd0
         XP2rp9vgXNX5BgsyV9VdewgdPWk7D6yyyQ129zpO4fYlfCsiYS5LU05N478VWnw5G4Ce
         WLCw==
X-Forwarded-Encrypted: i=1; AJvYcCVOtPm/2DoFLxHFCQUCRigVAa0IlAner5jgZ74jFAbU9mCiGMJK6k9eWj6VzpxX9Uwss0bsTzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBlutnabol/Hte+zr/MCk/ka+IsJ9FxcxhWuBdbP864JgwEua2
	LowNOqg88ENqwo9p+sC4vmrGepM6mQ8eTIIk+KvTZMBYb+UMvyRy4WHd0qekoNsAXlPh+1zvwES
	SpudTfUc=
X-Gm-Gg: ASbGncvjPvRQYykQ9fxW+RZ6glmgH1jr/iy9SpOQUxF73Abe9BrKWlsBcja5z4USyA/
	SWTnwnjGOmZDLVtFWFegsr/BowPc8fCtvCuMcCe2MxbDXBsiGPwcx1gFWqmdRv3G+lXSl6DAixE
	sHhDf/1qnNjEHo7gKphYnOaDPsPM/+H+xWWNUqmQekkZO+DgJJD+kkqyC60vJbAuThg3anaq5PA
	CQIdTqZTu+T4CH1fHv+wN+m/kFsv8zDm+6h/WPZSuSUsqoGulb2i+sczv1R90NAVqcdSI1yOCu2
	hBlYfJtAgB/4eJu65mN8ESiCdj9GgymDGmdUf90yEwPPU8I+kYQJoDZbdmiW3/bACMGgFmrof5+
	nrmgexZQ8DdgegpQdNO0CyVKdiG4W
X-Google-Smtp-Source: AGHT+IEs2LtoFEVuYj7Bn70H//Rg8U+pZ1lnUHGET7ctwQpKfF9iRRxIgcBYe5EgCAODZLVFoYy8jg==
X-Received: by 2002:a17:902:f684:b0:234:a139:11e7 with SMTP id d9443c01a7336-23529d7c2a3mr18482625ad.35.1748559747427;
        Thu, 29 May 2025 16:02:27 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd75d6sm17178105ad.123.2025.05.29.16.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 16:02:26 -0700 (PDT)
Date: Thu, 29 May 2025 16:02:23 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mkubecek@suse.cz, danieller@nvidia.com, idosch@idosch.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH ethtool 0/2] module_common: adjust the JSON output for
 per-lane signals
Message-ID: <aDjnf-OMI9Ot2pC5@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, mkubecek@suse.cz,
	danieller@nvidia.com, idosch@idosch.org, netdev@vger.kernel.org
References: <20250529142033.2308815-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529142033.2308815-1-kuba@kernel.org>

On Thu, May 29, 2025 at 07:20:31AM -0700, Jakub Kicinski wrote:
> I got some feedback from users trying to integrate the SFP JSON
> output to Meta's monitoring systems. The loss / fault signals
> are currently a bit awkward to parse. This patch set changes
> the format, is it still okay to merge it (as a fix?)
> I think it's a worthwhile improvement, not sure how many people
> depend on the current JSON format after 1 release..
> 
> Jakub Kicinski (2):
>   module_common: always print per-lane status in JSON
>   module_common: print loss / fault signals as bool
> 
>  module-common.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Code seems reasonable to me; no idea on whether its still okay to
merge as a fix, but I agree it seems like a worthwhile improvement.

Reviewed-by: Joe Damato <jdamato@fastly.com>

