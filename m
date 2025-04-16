Return-Path: <netdev+bounces-183220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAA2A8B6B7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACD21904553
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5162459EE;
	Wed, 16 Apr 2025 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrtGfKNu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE76238177
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799052; cv=none; b=krokVq/Lx/qRO6UhdXEIZJ0/in22j1QXKMBum57MVyuBffJa6Dxcrpo4ysMp5jB+B1dR425GeD0P2Wp46xLn6hye4LvT02vN7BMQfHmWdigHRebk888rDBaxBstQHQ1NYeXnXe6DGRKCaKf31/QMnrjLSZSUtVmxQgEUkebVORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799052; c=relaxed/simple;
	bh=I5Ptylv8SBDHZDbjw+8WMGIUfiGxfXIOk+66TH1hNsE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZXg4KpFs7/qnJhBAy41NcNaA0R57fILbEIXPdkF/smeT942qMfcd+rr4CPxG9DrzkWfoWv7NIKajDoQ7NM10CE2Fiiw8fIPX01YxC42aJS7PuHILkFA33FnnH65WD+fyYIS7n0vxObqgqzNjvXEvXeELkfXxbhIY7dSll43fnk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrtGfKNu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso349246f8f.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744799049; x=1745403849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=058rmNB1d7FYsoEWN5Di82TAeB+tFSqtrwWam7p5lo8=;
        b=PrtGfKNup71x+cLk4xKNfXM0KbctBQpk3l0IoYSqcxmi1t/5zFZeU/y4GBunLivmqP
         HjhKxRAKiRu3heiK9Hb2Ghv0624ElkBCZnJxs7v/j7EX9xvQLuFiOZk4MYxQnFd5x9A1
         OR8P1lRZBEMruN4yK45HDJyWUBMT6jTSWCENF7+e03kwZqENWAqOcmgTqqf0kmOZjQCr
         svpOzgHDGwVcju548o3nACEdZFZIchf+VXCOkdlbHjMuZ9mUI1Xt4Pp3FIPXBv2cBbiS
         pNAO17HBgbrCiwGwKFg47cK1A0EVh56AUIJy2ytxIKo5YZRrGcYWpdvci2ZHhrTLPTG9
         i0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744799049; x=1745403849;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=058rmNB1d7FYsoEWN5Di82TAeB+tFSqtrwWam7p5lo8=;
        b=aQURpILeYUeOl5l+wyCjOeuelBpWPs46lL3O1nQSnpCHXYkP7eNKdbq/Oh3mI+KX6P
         Jpje9yGYR8Xjvad5+vfqAC8EIYx6eRyR84y3Kmry5CbEZ63RhG1Om1NpN+Vhjum1jQ6J
         vkVWWVS5Ds9CYKRQBo2iaZjsEEbqcijtQ02WNIkbkRGah1X+eAv9RhReNbx1b1DHnzUq
         fKYNsAprQj/F5DVaFLRBqjMOlJkd9FhZKZRUJOrlQQD4hdT8Vi7H2sTlwhUFL5uIXI1G
         aeGJ0SE/SM/R41df9V3QiZ7pjlcKPwBuXZ5RKxx2F5PcGsA9ZwKKEjZT2LURWZ4/oAdB
         KiNA==
X-Gm-Message-State: AOJu0YwsZGNijeGcGQBdvflVBmUAJ2j4loJOr8zJhrhV8cx2hv7O5E04
	P5GxB0pdlx6IIQ7w5Pl42pmXIW3dpBOK6pE4e/fFgcT8eKCuFxsqJyihSg==
X-Gm-Gg: ASbGncu1Q00FNB67+R56deRcUnfEXoc8OPezHODSI9tSbUaZW6cP29Yx46W6upI4k11
	eGWrDF/1ezonK8xJoAfZAtgEsRAHaxneL+H1Nz+xH0Rt6jmSgoq0ljl+8jFkOLvtlrWSn3j4S8x
	HWn05DgeMTBfx4FjtXuqaoQCN+8P2Yqkzrk0NzL2/0MRDe71qKmCdu/81q23I8dO/peER14Zsht
	tO5sLmZdnwOIhv0SBFRk8BwP/Yy/S9ggQEmrhbyq4X5FiFdY2HvLvALg6Tldq7sX6/gnGHVUG8d
	eGvdpf08NXqL9TBXXt/85cauyn1HrAOMPc7+x8LR+rKPiJQ8j/MmWO3CvLIaqZeXDumzqu8zjDu
	OB5zf9rykGTUA2WXbLPWZx8SDgXdc
X-Google-Smtp-Source: AGHT+IFEU5hH2c9BG3rfkye/87VVc1FjXF5m4h/K0ANVkmCx0HamDV5Rf9qE1OLACn4gQCRIr95SNw==
X-Received: by 2002:a05:6000:1ac9:b0:39c:266b:feec with SMTP id ffacd0b85a97d-39ee5e9a72cmr1201173f8f.7.1744799048815;
        Wed, 16 Apr 2025 03:24:08 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96400dsm16965071f8f.11.2025.04.16.03.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 03:24:08 -0700 (PDT)
Subject: Re: [RFG] sfc: nvlog and devlink health
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
References: <7ec94666-791a-39b2-fffd-eed8b23a869a@gmail.com>
 <e3acvyonpwd6eejk6ka2vmkorggtnohc6vfagzix5xkx4jru6o@kf3q3hvasgtx>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <96e8acf9-dbd9-6512-423e-22f52919475f@gmail.com>
Date: Wed, 16 Apr 2025 11:24:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e3acvyonpwd6eejk6ka2vmkorggtnohc6vfagzix5xkx4jru6o@kf3q3hvasgtx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 15/04/2025 17:41, Jiri Pirko wrote:
> Tue, Apr 15, 2025 at 04:51:39PM +0200, ecree.xilinx@gmail.com wrote:
>> DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR is no use here, because it only
>> clears the kernel-saved copy; it doesn't call any driver method.
> 
> Can't it be extended to actually call an optional driver method?
> That would sound fine to me and will solve your problem.

Would that be "diagnose"/"dump clear" or "dump"/"dump clear"?
The former is weird, are you sure it's not a misuse of the API to
 have "dump clear" clear something that's not a dump?  I feel like
 extending the devlink core to support a semantic mismatch /
 layering violation might raise a few eyebrows.
The latter just doesn't work as (afaict) calling dump twice
 without an intervening clear won't get updated output, and users
 might want to read again without erasing.

