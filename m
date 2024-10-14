Return-Path: <netdev+bounces-135360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC62B99D9C3
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 00:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710A12819A8
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E41A1CC179;
	Mon, 14 Oct 2024 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TVokI9lr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD415855E
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728944675; cv=none; b=mmY14CbUcqDiJ/LanQAk+1JII4dje5uu8e/SerkKsVHByEAuhu7FnLHARrGNsW898D99GYgXQouF7nGHdsMgGN3rU4qq0tIc4CKuSmdqE5XxRTKlV5SaWVKl6WBk2OlhSp0knhKfwXOv3bqm6EUz9ZmxVFMebxb75xbRe8Ha+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728944675; c=relaxed/simple;
	bh=ktAwmyevO98oWbYObx8Tjj+HI86c/yB3aFGzDIddWJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTqyC1uXwjpjcjuZfsWBCamIFdJy7W7lJGdjQ4IydjK1pg7RgHG5A7YeP8qzj60w+g+tuZ7ultxUKJGJSVIATLKGPy0j/2DAWUSMio3+ZOMGkDvumIIXCIno1+Y7/6c5fPP/ZFxesP2staF1EqzJojKcxGzpVkUVQf/ZoQEZbTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TVokI9lr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so3354212f8f.2
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728944671; x=1729549471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckgWCFQW027WKgN5jAosSmWvTt+ot1PMFeyvaWEixRU=;
        b=TVokI9lrwH41o3uvrsKVSmwAl4DziTmkL13rinV+KXYmC8OtFkMlAeMDnOWDvgG2aC
         1WSSDf2Wi/e+j/rnH3kWadxaX27psZ57VNahQRakGli/LzXNGQ+k/6nzjWg7rxCXota3
         DWRk1wGjQYPqMv33lLsWCI1tPO+psoZizb19jb38ruKBDfbz1qnL9R4mNKesjtAF1ULz
         i7LNMTetOD8uahCljsZv7OIma/GWN68VgQlbWOgyplmokopUZ3M/1eFQa+nVT2CxhCEg
         x0+sFahWQWvomJWhj6okaGSK76K2y1WW/KCKSGyCtulk33Wxy3Y1PBHrkyUdduNuMGP/
         waBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728944671; x=1729549471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckgWCFQW027WKgN5jAosSmWvTt+ot1PMFeyvaWEixRU=;
        b=MYQo6ck5JEnGGYUD51qnKnxox+OidkNrrm11Ofei6v5uKcefFgehyzbDlcv0Z9RUKx
         owCgMH19cJtmjk0JLzeHZ22XSZtmcZtgqsq7C6gJh1IBRM9PI2yKHid6VQ5AqAHfCUrP
         /vi2qa+zsVH8+348rW5lKpz9KtaviriiU4kCRScCMGNJUte9V6DK3Jvpandofw2q7Gir
         LcyIZymkeiybg/+xlnux/wh3y6oEsR5CLxbc1z3hznfshb7tBhc1+xlxR07cMGX6NSFM
         XFqe/lJkyAW5GCJnLjaJX+nfLnAlr6OODSsMPpxiiGv6VV8eHI35Y/Bc4fvbec5gkheX
         pO6g==
X-Forwarded-Encrypted: i=1; AJvYcCUViOFPMriYp15+yuSJFacpXcizhBum90D/6PCZ0Zqsi5DL4a4IE/1EKjqEixH8JjfkwYzRmaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMPONacSCOLe1plBqNJytfDT+GFF7uITUexu++tSG0kNaldpb5
	9N83PZUgQ8Z1jkOH+9GZEVrDHym8PtkzpoVS0AFoj0u/eWCMouW6vL47ZgLFluQ=
X-Google-Smtp-Source: AGHT+IEQomvdP7m32YYsQBNAvNQ8OxC5zjT2kRvDHpaaO8cZj0QxPiKr/UekWgIgfny2+pIy9TPIqw==
X-Received: by 2002:a5d:4591:0:b0:37d:4fb1:4faa with SMTP id ffacd0b85a97d-37d55313054mr8300515f8f.50.1728944671462;
        Mon, 14 Oct 2024 15:24:31 -0700 (PDT)
Received: from ?IPV6:2001:a61:139f:d001:dc4d:86d4:76a4:bf51? ([2001:a61:139f:d001:dc4d:86d4:76a4:bf51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f5699fbsm524405e9.17.2024.10.14.15.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 15:24:31 -0700 (PDT)
Message-ID: <fd906211-7f31-4daf-8935-2be1378a75f8@suse.com>
Date: Tue, 15 Oct 2024 00:24:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net] usbnet: modern method to get random MAC
To: Eric Dumazet <edumazet@google.com>, Oliver Neukum <oneukum@suse.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org,
 John Sperbeck <jsperbeck@google.com>, Brian Vazquez <brianvv@google.com>
References: <20240829175201.670718-1-oneukum@suse.com>
 <CANn89i+m69mWQw+V6XWCzmF84s6uQV15m_YdkPDQptoxUks4=w@mail.gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CANn89i+m69mWQw+V6XWCzmF84s6uQV15m_YdkPDQptoxUks4=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.24 21:59, Eric Dumazet wrote:

> As diagnosed by John Sperbeck :
> 
> This patch implies all ->bind() method took care of populating net->dev_addr ?
> 
> Otherwise the following existing heuristic is no longer working
> 
> // heuristic:  "usb%d" for links we know are two-host,
> // else "eth%d" when there's reasonable doubt.  userspace
> // can rename the link if it knows better.
> if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
>      ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
>       (net->dev_addr [0] & 0x02) == 0))
> strscpy(net->name, "eth%d", sizeof(net->name));
> 

Hi,

you need to have a MAC to be an ethernet device, don't you?

	Regards
		Oliver


