Return-Path: <netdev+bounces-204722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C63AFBE29
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 00:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F9E16CD5F
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 22:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE952882BC;
	Mon,  7 Jul 2025 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIOeQ3NI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FC612C544
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751926391; cv=none; b=R4lwh9lSoeCKvF++3+/FGSo89671EjCjwQM1YAIXlOEDvDcS0B98BdiiE3daed4QqlY62kSwNuIvuoJpQ5ZSXsLJN+XOuUwube6SOAFkCD1hzgEEGfHHJNAY8jcxOYVjPgbviJVlQ5rC91Cnyn27vEAArvw6ALhQtV+GJ7qiCso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751926391; c=relaxed/simple;
	bh=DiCT2Hb34PbDLVqieQWfl4SJoD2Iz+4Ty0FGCHBU9H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULUqsN9fJF4ae83q4qztq0i2Hhdb4yseAofMJtIOIaFxb82zbfKmTLBAd3YnSQvwotjMcaa6hkC3VxKy1CVqGRNaZB7AE3ylQAaG1saUysFDclqvgYGdOaWagWW3xmv9evAkl8prxi4YcijjRyq7I7zUuRrU4d6SqsTAFwBxdhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIOeQ3NI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a510432236so2496095f8f.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 15:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751926388; x=1752531188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5eBnsGNvXRwiXmALf/dPebej/dNe+pALdZTrdouKG2c=;
        b=BIOeQ3NIzwGBCEHADxpQhkIlS9B5Aea9Lg4ckJqIo94dowbWf6WGqNpwr7EaIDIqVw
         yqP+sRVaFeoqH3hVAPAQt1GpzUzEu9yQSq/UXllcyHOx9je9w/KkVmliHlLLiUVp9+Y1
         20k3RgAxDm0W17BWesNRCdCi6YzG+z01US1dpmkkTELdjfOtFQBFzsb/d+FLVtS8VtU+
         Sk/t+qLaLyWbn2oUCA14CHybvohXQwatvzwX3Ytyv+R8MytosWxWIzlUtUSxsv1C41Js
         HV8WzcZtlvlkrfrG6wBriFLtmjYNDrbAp7bAOgU0BXyeKxndqdAL60KGPppIQPffSnw7
         eB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751926388; x=1752531188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5eBnsGNvXRwiXmALf/dPebej/dNe+pALdZTrdouKG2c=;
        b=eJrnd2n6k39xIszlJAKCP2TfAMENi0GpPqx/MCY4oXnGWxVDGgHAWaax+poEhOnmNO
         Bc52A8S5pz6Nhrko54YoNOkSYXrlguogfaFEnlkLHzSP5pbqUzR/2hcwqnBOsI4ZfF1H
         ho2CMOdkL0zPmLTQb7knX/M0zZxhYDgttc8kwXVFn/3GdQk545nhVgZlWPZtLVYKUPiF
         5hUppTXf4udVeI/RhWdY96DGZdew7PiSgfT4xd9dfyerB2jVMnIX4EDYuLUxDG0ZiQp7
         25+B+z29aQZsJ+tRSz8BCv5/+oK+hvFcn5gMNVFQy79wvT6bzvRDGQJOF2JAmMdJKlHJ
         7CjA==
X-Gm-Message-State: AOJu0Yzsa7pSYz/Lj+77+G27ThqSogi39ZrppSzXfS1f9C/GRdA3DijQ
	heApVVL6oj1HOdQnG0Hd7lYEAUTdGruEkzeHvZFUjt7OIDdJTOIQ7QHp
X-Gm-Gg: ASbGncsQtsiDeZVkHebubk8RVOCG74C2Jwy0Ej9VmJpS30S0CILajxJrlKAhna32UAr
	inLfy33KSNphd201P9wwtzQ3/HCYNc951XhQq7mxCXFBmALskvNo74tswUiVNXzRZ0igNHMNlK5
	B2nFZObpI7Jb1mJX2HffxXskyjHQeGRgeEBGqZnWz71+K270ZOgxPDkBhSQgPQHmXuXLkhF9lCt
	gTPspoxny20Kzxsp+DJxi1Fheq+VlC/hwCRCJrkZ8isWrUQ0rxdxY7RnDtIQzAsH58QxBcGv7uJ
	/OAbqBHbrQJJsE+A+NGB4z47L3JTw/yDn+C0d/C2Bv5qNtBfQ2wmjJDz5qcW9wnG8stpon7mAGA
	JIPEGSIfEdkSXgUY/X6szn3laKYPmu9N5be416zP5hQjm76Bbnw==
X-Google-Smtp-Source: AGHT+IGb+tn70xvAIbk2ITa29AxbhlHC9y/+f9pgrc1P/eohvwbNx77HxbGZ/9XzjUozU97TlgWLZw==
X-Received: by 2002:a05:6000:2407:b0:3b3:9c94:eff8 with SMTP id ffacd0b85a97d-3b497031518mr10188406f8f.27.1751926387817;
        Mon, 07 Jul 2025 15:13:07 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd43c6c9sm3681185e9.1.2025.07.07.15.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 15:13:07 -0700 (PDT)
Message-ID: <6599d9af-8bf2-4d2a-ad02-c7a7f11844ba@gmail.com>
Date: Mon, 7 Jul 2025 23:13:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/5] net: ethtool: remove the compat code for
 _rxfh_context ops
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com,
 leon@kernel.org, gal@nvidia.com
References: <20250707184115.2285277-1-kuba@kernel.org>
 <20250707184115.2285277-5-kuba@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250707184115.2285277-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/07/2025 19:41, Jakub Kicinski wrote:
> All drivers are now converted to dedicated _rxfh_context ops.
> Remove the use of >set_rxfh() to manage additional contexts.
> 
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

