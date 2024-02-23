Return-Path: <netdev+bounces-74444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B998615B2
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD561C24563
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FCB823D7;
	Fri, 23 Feb 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="YWDBiaZS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C51B12A16B
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701834; cv=none; b=mBr2CWTN9iZR6OMAntaHFRoTrVVc4VGJBSUtBfWZE6KOGeNe+od0QRELpOD5b3OGBLkR2LVRfzQGEK7apBMKA+i/bf/AfPmZqBmfMk8/ePM2cUrC1ANtl3rHjQO0b4FkD523PVHMKQhtU6/VZAR7fpso5Nuk8g2WPayMstDB9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701834; c=relaxed/simple;
	bh=WD6oWqwCx/FOYYjSobiW3GnnhXdEA8bZyRlv3vBzxN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbm1xqQ+XC6TbzoVhMETzzuxdITZCUJx6+Lwve1mdr02DTlNKHhOqs13u+b6wd4fgqJkgdANmehD7tCGTC7ONfAak6l7gSg3vt5p3NMJV6L+89kjtqqaMNFUbjEULrZckv31jBWuUnhH4fz1cojz8ABDtS/QXPOf0nL4e94XHGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=YWDBiaZS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412985a51ecso282805e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708701817; x=1709306617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WvhsN/BkGyJgqlePQ6A6dkEBn4f6yxFqr9HtsK7X4Fs=;
        b=YWDBiaZSFk3pBr3mn2JcybIGCB8I+GeyeLzp5GubZEpaP5OjdtEJATTQrQ71Q9fHU3
         zxGVPT51i67HiWT2HjT7Ry+Ql8NzagVFj+qsFc28WOEEHxshSv5+SYZ1ViaXWeGaKFk0
         IzIVKzaNAi6R5J52uxInpbbR7BrgwLZf4tp0M/3qCzXf9RURVARml8c3WV+ZhMjnPTVy
         BzllY34h0JetKj0kUx3G0VCjnJTcTnMWhUGAeL8pfdu6rpOZRI+JOk19wxYoJ6o+VfCb
         DNbTMNWAKinM6nSJEJ73IRhgb18V1p2jkN6bYnV93Y49CDvikoHRAXdmhP1Ly+KRhrTe
         0ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701817; x=1709306617;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvhsN/BkGyJgqlePQ6A6dkEBn4f6yxFqr9HtsK7X4Fs=;
        b=cO3ySP+SpiNBI2VBw5byOAI1xWu6EBVsPoSA/zhljAZwhNIWoyys0H85macNAFU6IY
         rBsNhEDVWbVRd+coP0vwRZlMsrgYALsKk+dAeGN/eMB/VKNr7/eD8a5TTpXb9HzPVaSa
         zRhNrX+yi9Wbi1XbKp5AGr2AI8fkdqsqu0FFz1ABahZUt7eK66Xtg/J+rSLZQ2nU51zt
         pdRd5ZfsCjy4QzyjGpl/7E1n2tkyYEEEgO7+efR8++0lLfFhR9WippyHBips+n9kW0dz
         3lBh3RwchGLgvmjHOTuQ7BPBDAnDsYYxCvLwna+twNCUOwTftcEQNx4yfKDQ8oRPwjbY
         ncSg==
X-Gm-Message-State: AOJu0YyUSPVBw9tfoZ8jvJCFNJIZltwGYyZNfN47SNEp8r8DZJvu0tWF
	70KxMPefKNA4vgk/gV5Mm4CrcGAMUjve3nZMFQHkCNsKztmQ+p01dLAksqOv44wfZiTy0pDNaz/
	5
X-Google-Smtp-Source: AGHT+IFlX+w3KHnpBVGixzjNeBbkLfIuABQonwn9aOC0mjRM2wKYiPotIOCHn0N6E+HthLpA4H5N/w==
X-Received: by 2002:a05:600c:a3a4:b0:412:8f5c:cd08 with SMTP id hn36-20020a05600ca3a400b004128f5ccd08mr112591wmb.22.1708701816700;
        Fri, 23 Feb 2024 07:23:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c0b5400b004129018510esm2679782wmr.22.2024.02.23.07.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:23:36 -0800 (PST)
Message-ID: <2fe8e7c2-f336-4638-bbb3-2d8f27d7a658@6wind.com>
Date: Fri, 23 Feb 2024 16:23:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 06/15] tools: ynl: make yarg the first member of
 struct ynl_dump_state
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-7-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-7-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> All YNL parsing code expects a pointer to struct ynl_parse_arg AKA yarg.
> For dump was pass in struct ynl_dump_state, which works fine, because
> struct ynl_dump_state and struct ynl_parse_arg have identical layout
> for the members that matter.. but it's a bit hacky.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

