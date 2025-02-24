Return-Path: <netdev+bounces-169002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A118A41E75
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D6117D9FC
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235CA205AAF;
	Mon, 24 Feb 2025 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OuyGjVsi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4108B2571B8
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398652; cv=none; b=HKfLCXeZutbKjbr1rj3OsvrOCwBUTzO8fmMELz9UkSjUYm0FtSYgwdnTqFipu3BYjsPsk+q2fGrRNfPwoG22Fthaf2VZngFdKtyz3FAUelwBHYpHrJhJFRInuoaVdmYLDIp4iRGCTwB1IL0OwpKG6L6UMifBuLpUNFzgV4OBsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398652; c=relaxed/simple;
	bh=+L3PhZEmgQaSbRAuJHWLglYt4qjvAOIrF1s42gg9W6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRqr2k6Ynt1vtiLAypyUJ+jHL0+Mkl5A90DfYWgJz9spibUCFmK/EqRD5nfiWR1crMhyovHynjoA70mMptaG8Od7ahJ+DY+Vxy+fmOZYUdgVwicx1Drht09GX2J3dcqvd+E+UE79ILggA4+D+URufNU7sClrCYse0/fAD/gsh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OuyGjVsi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-439a4fc2d65so39945905e9.3
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 04:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740398646; x=1741003446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0onFnRxIs2kBe+jELL7hIQKKJxUK1QSzk168t3wEz8E=;
        b=OuyGjVsi0z40guKq/yLMns9O69WhUyg5/ww9DyvsjsWoTKLbuhYaPy5toSyCNZbFhP
         Nt9mWOVxzC2IrPcYYEEEzELdIwYnQv0URlGr62FU+c6MeogXORACb/G+OcC3K3VRkeBe
         kwWEu6HwRzhZaEV5NCqrG0fE6cNbR+RyQWnZfGZ5qol/rSewIt0Mwt9w8HZfLGd6Run7
         +YoOa8iRNamF6+7p+ONrXMbyZUMuQx1W/Ho0ujUy97ZA8K4ZuvTKe4ts/4695iQmnAE7
         5myDGC5hJxmN6mXOFXO8OvHXdNZQ6EHq/ojv6nYJQ6+iFAV0tIltNm6syymGLxDoq2Nq
         i8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740398646; x=1741003446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0onFnRxIs2kBe+jELL7hIQKKJxUK1QSzk168t3wEz8E=;
        b=I+uB/PyHXLswojh4h4hB3eMgEPCxsnNNQWnG3Cr1hYau9TFv64KDdxj7375K/t6ihs
         93xjeDdQw34YlWJY8RESBKxTAjAqLzsyNAVrNTICP2TTMRcos+xMK/ZeRPxqbLt+yFso
         nak8zJpVXkIadkuVyASmwLxPGdCFMGdpSAeH3SLMGCm8yngily57K/wM3x5PMzjiIYnO
         b1tdZOrk3uvHczHtHmILzws8e2c7UABmOokS6jVCD6goQme1J26FUer49FWNAUVUpjs5
         kuRbYVrInaOESabJQH7DA1YQQTw/E9QcnUiWYzr4/CjgkpSs3/B6dktqdFFDZR44OIZW
         PptQ==
X-Forwarded-Encrypted: i=1; AJvYcCXReQMiarpzPgF6y/KTya0JqzzAgOdJxSTK741cqT4BbQ3NHgOpnXGVrjKhTGLWJpN1ixtaYmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIFsF7RpJQF3pyuNnjbJhdcaeV/8gaWJu4BWj9kR0fE0qMeRHK
	V735gHlGE4zD9FKAP3PQh8mopc2GX6uyajdPML5xPAd0GlOqaQoL05sArWaPlL4=
X-Gm-Gg: ASbGnctrt/WC3ieclG5t5uPj7mCkF4BzpMFnN3PxfADQLkFpBet3G6GB2zSrFCo/GmA
	+SKQW8lvJLfEliQD9Sz/AIbaMdNRWBbxHjzur+FAolV19HqEiFUM/Gd43xZrmAPLrxP3XlDkQZV
	jVoMwi/Gj7j+IeHcur1h08ZXtIXmPgAmV3vzFFUHENWz8F4tM/UAenvKrzDu1TD2Twm/UDau2H6
	QougbsyW9pA8L3qFDN0PM+jZq50G6+qgDCQC7XigyI2MD/mvn2Cl1VXLto6ny7B8AvVi8GIb5kb
	Va7jaL3FmItdeX39nJbawZC0keeIPt4S+r7AaoLIqVXjMhi+6y55
X-Google-Smtp-Source: AGHT+IGRKIPeXT1LNLoxtMfDiXfqTI3VfaUvrkEcTwnu3mVHJKxvqex6Qwlkx3D50c356CoRnS0VIw==
X-Received: by 2002:a5d:6daa:0:b0:38f:474f:f3f3 with SMTP id ffacd0b85a97d-38f6e95bd66mr11180365f8f.13.1740398646115;
        Mon, 24 Feb 2025 04:04:06 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([208.127.45.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258eb141sm30819875f8f.41.2025.02.24.04.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 04:04:05 -0800 (PST)
Date: Mon, 24 Feb 2025 13:04:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>, 
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "davem@davemloft.net" <davem@davemloft.net>, 
	"Glaza, Jan" <jan.glaza@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] dpll: Add a check before kfree() to match the existing
 check before kmemdup()
Message-ID: <kwdkfmt2adru7wk7qwyw67rp6b6e3s63rbx4dqijl6roegsg3f@erishkbcfmbm>
References: <20250223201709.4917-1-jiashengjiangcool@gmail.com>
 <DM6PR11MB4657A297365AE59DE960AA899BC02@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657A297365AE59DE960AA899BC02@DM6PR11MB4657.namprd11.prod.outlook.com>

Mon, Feb 24, 2025 at 10:31:27AM +0100, arkadiusz.kubalewski@intel.com wrote:
>Hi Jiasheng, many thanks for the patch!
>
>>From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>>Sent: Sunday, February 23, 2025 9:17 PM
>>
>>When src->freq_supported is not NULL but src->freq_supported_num is 0,
>>dst->freq_supported is equal to src->freq_supported.
>>In this case, if the subsequent kstrdup() fails, src->freq_supported may
>
>The src->freq_supported is not being freed in this function,
>you ment dst->freq_supported?
>But also it is not true.
>dst->freq_supported is being freed already, this patch adds only additional
>condition over it..
>From kfree doc: "If @object is NULL, no operation is performed.".
>
>>be freed without being set to NULL, potentially leading to a
>>use-after-free or double-free error.
>>
>
>kfree does not set to NULL from what I know. How would it lead to
>use-after-free/double-free?
>Why the one would use the memory after the function returns -ENOMEM?
>
>I don't think this patch is needed or resolves anything.

I'm sure it's not needed.


>
>Thank you!
>Arkadiusz
>
>>Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
>>Cc: <stable@vger.kernel.org> # v6.8+
>>Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>>---
>> drivers/dpll/dpll_core.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>index 32019dc33cca..7d147adf8455 100644
>>--- a/drivers/dpll/dpll_core.c
>>+++ b/drivers/dpll/dpll_core.c
>>@@ -475,7 +475,8 @@ static int dpll_pin_prop_dup(const struct
>>dpll_pin_properties *src,
>> err_panel_label:
>> 	kfree(dst->board_label);
>> err_board_label:
>>-	kfree(dst->freq_supported);
>>+	if (src->freq_supported_num)
>>+		kfree(dst->freq_supported);
>> 	return -ENOMEM;
>> }
>>
>>--
>>2.25.1
>

