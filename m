Return-Path: <netdev+bounces-183255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D110BA8B7AF
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA41317F4D7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F01023D297;
	Wed, 16 Apr 2025 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bl49U3Qt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD98238D21
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744802854; cv=none; b=hiZfP2vXaot1zi0f2bSPtfpEWUgli+f0nsESFz9forApLyWqJe6StK4ORBn16bDCDPtSIXmSj8WIj8XRZkVgWs9T9V8iK2LT01Mx+Mv3MSB2JRqzpCrYksE/4lHYPbMVTDKPLfxC5zz/PgenqIU6MYWsfeZvm5R8FVLBSSSloGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744802854; c=relaxed/simple;
	bh=tkU13aYCFpYdT2YPArlgiMKiiH2fHctvXP5jj9uD3hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPu4uDfr5MTXITAUW+Yos+kfWeJA3YHlVCIDLRBHmFs+5lJSRGpwqlgDwonezQ35id1ZCPmWEoaLsiVREUb7MjUMMgweSGRo7mB9pjPS5XFWg4lF5yiygjwEIsouM3/0rBD2HtJb4nhE1VPgEIxSBYjWPRR1YxQyrN2lcjmiTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bl49U3Qt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so3903785e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744802849; x=1745407649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xI0WbhgqV2dbCVnkOIRWul+hqRe2NvpQGqQBwZDOL4E=;
        b=bl49U3Qt9r1627OwKydQOV6E/wY6YVjYu1/Aw+PJ5pADpgWFXh3ZLtw9d2XsjKkrDy
         lOzfR5hylq0qP3ksSjdOrK0KFTdRKCb0qfiyfZ1rsqY7yJgiZWHXVOj6+BGUUXI0TM9T
         P2YNtWODNlQfGtXZA4pRC0B1U7v4Dpr9nLpZH8GeMuP0OdyL/jy/cpmiBnPLVyUitxhc
         Ci+jp69D7jv8wU7B3A5pccNrgcbe9GKt/L/pHF8bx5tAKPZi/rHZqvL3ehTSCAiaUFFj
         izZs9KlsMMzm9r4PqqbHW/oS9NcFjaGsbvYxvSrq0j3vg2adbLLFUJUi/jwtRz8HBGVu
         eyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744802849; x=1745407649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xI0WbhgqV2dbCVnkOIRWul+hqRe2NvpQGqQBwZDOL4E=;
        b=Bg6Wnld18CRTZcUHVG4bDmdeXIXHy02udmKFO/fUahDSlMIPkaKJgaLaeIQZsv+hZf
         WYWIP9f1Fv/cHJU3m+DHJOCPPaGX3htGYDTF0BPb1fWUy0s/gmKDyY3mEWbo7VB+yfZz
         g5/ysgokygRu6r4dCYCwicEdfX/Zc/VBgphq7RxCehbgmT1ceYC3vgy/vkvDvH+3zb0y
         d8C/QN1yZ3PHm0ps3v1uxvNp5ELjQDbbWhtBMkB5dhZzon75RM69drWd+sylXQSxaUJA
         pwTOO8ptsMsUGmPdWA+nZGzUx1xmRpdOQXYJfrHh39pCrwnsgZRlGE2jX7hVKzW3t8mA
         AhkA==
X-Gm-Message-State: AOJu0YxDZpM+QyPlWkqehfIb9hCf8V1wFlXt26YhiyGLLEQKHYUNqcOj
	9G+sl0D8wWgNeySvi4HYKaphoioqtlSfv+Wu0tQfSKt4jBgKkl0bcb/yUwHEGao=
X-Gm-Gg: ASbGncsZttIxTDKMntRY4EuyTS6e2CCLKbNMWn1JecAzRN1dfvcqBRx6/HpwWLlD7Fa
	nyi0LmrTi5R0jRqFyDtD2Fjoc7O8EMnXTR44pfCog7fHLEYfTxaSYbv0bpgpkz3j86u6VAm7YnJ
	ropOnzMB3EpjYjF2V9+nzjIDOixGKkLORfA1GUbb0jqoKU/jup43Tq9TRNikjY/gxsy5uwS5P8M
	GeRGOaqwJjXVtK3BM6QOwy6gRiB3+ElCeXZijVmSWORKssdizxj+pePs8BenF+7vXaRZih4/yye
	xe3E7jLJTcgtuOgPlV7gq2n9jRvM1vj94lIXjOnhS8UPv0JA
X-Google-Smtp-Source: AGHT+IFmmZ+0sNX1CQMyE1ILmykK5qGrVMGIcgR72VrENQzc12emQreTpJFUlRe6cIdH6VqSYD0Iqw==
X-Received: by 2002:a05:600c:1e18:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-4405d7690e3mr14190585e9.5.1744802848707;
        Wed, 16 Apr 2025 04:27:28 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440609c94fesm920655e9.40.2025.04.16.04.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 04:27:28 -0700 (PDT)
Date: Wed, 16 Apr 2025 13:27:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [RFG] sfc: nvlog and devlink health
Message-ID: <t255xnzuddoio4da3eiv7se27xvb6hvi7qkvflwpa5p3sa5qor@tpnrxyam4ock>
References: <7ec94666-791a-39b2-fffd-eed8b23a869a@gmail.com>
 <e3acvyonpwd6eejk6ka2vmkorggtnohc6vfagzix5xkx4jru6o@kf3q3hvasgtx>
 <96e8acf9-dbd9-6512-423e-22f52919475f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96e8acf9-dbd9-6512-423e-22f52919475f@gmail.com>

Wed, Apr 16, 2025 at 12:24:07PM +0200, ecree.xilinx@gmail.com wrote:
>On 15/04/2025 17:41, Jiri Pirko wrote:
>> Tue, Apr 15, 2025 at 04:51:39PM +0200, ecree.xilinx@gmail.com wrote:
>>> DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR is no use here, because it only
>>> clears the kernel-saved copy; it doesn't call any driver method.
>> 
>> Can't it be extended to actually call an optional driver method?
>> That would sound fine to me and will solve your problem.
>
>Would that be "diagnose"/"dump clear" or "dump"/"dump clear"?
>The former is weird, are you sure it's not a misuse of the API to
> have "dump clear" clear something that's not a dump?  I feel like
> extending the devlink core to support a semantic mismatch /
> layering violation might raise a few eyebrows.

I probably misunderstood. I thought you wrote that it is the dump that
is actually cleared.


>The latter just doesn't work as (afaict) calling dump twice
> without an intervening clear won't get updated output, and users
> might want to read again without erasing.

