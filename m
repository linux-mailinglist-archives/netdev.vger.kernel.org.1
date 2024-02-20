Return-Path: <netdev+bounces-73171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932E585B3EE
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A55280CA3
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 07:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135625A4D3;
	Tue, 20 Feb 2024 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="L6OT4WxP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F045A4CD
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413921; cv=none; b=jV/bdRM4dgyJCjz7uz28GbeUZcGIRk6Q9qwDtxCHtbHQS7HQ8EBBPxVDw523x/Kwb6qr0wtxHhDMi9Y2fxIPJgSNof7ouhmnuRF3TRkyHhIkNZvo+oWt10EynghkOhE4rrIPHNrVYDd65DRRpCgj4FxaTikRZw7A3imcLqlnwOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413921; c=relaxed/simple;
	bh=k//fQ0ajSFvHXSs6x8FDVStp7zluOlbqMCQSWkjEmn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBdAPRleEgSJiP5SSYnZA5y56jNgtE87eQdjczADAq3yJ+yPOw7tuEK3vfz1jhGlGPenxO7LeT2c34FHcKuWMrM0G1U8p6Q8AnkmCuqo9jtDnI14H3umIvhVIF9GtcluEZF38+FQtfSK2/DeZOtCcFRKtWajM2edoTgSqRwdNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=L6OT4WxP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4125e435b38so22792235e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 23:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708413917; x=1709018717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4p6B1TY760Qd+NFHf1aESJibMDsVoMPTWU7zsLITGRY=;
        b=L6OT4WxPp+TpNixRIvuO0hSLFWSzHyR39V4pxxvVYR3zDfgy8rwRgE+DIi+elX+bZf
         biuG9MThYSq5pEt9i6R+GkxcILYnRkylNRx14oEDFVa8exWTbBubu2zGHAckBxrbmDr/
         Wp0DSkb/cOxmy3vYq/+IWYj0AW4WPTHWAV4IEz8Y3gxK9ZxhauYghOLZepZSCkSjuxEE
         fMAzb5oh6dqVAwvZRq/HnoIXxd7z9Admw4sovclo1eyMJC2cX0bNr/X2eAI+RVhUAf2S
         t1LsElFv4GA0GxI4pqGvtJQIfPuwoiVElBljS7lItGFz0kvDmP575jWnvsL/TBcTdRZk
         LZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708413917; x=1709018717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p6B1TY760Qd+NFHf1aESJibMDsVoMPTWU7zsLITGRY=;
        b=RASglppDgK19X/5SWRTkPBEZLan+qK7W08gS7PmiyFDHMns4E0/oBGzf4wMuX4f3IL
         3V/CfRDNZyX46FeN+QTXL8VfzZ8sItgvA4FoZyWPAUIzqoHdwPWnQWrP/Nfzsiyg2faV
         e/BYgsyM7jXjC80ZvxMFdv5WdU8PqZa0J8CT+Kf606n11ETmBHbHmzvmpW9c/A7cBdQz
         OXIGUT3zXSRhdqKSLiprReGu027E2DCOK415RJlroXiZVXI0ZHY1vQISoe5XyL+tRadP
         lZ2HHTn94EkdTlgvGS63/NXCRaT0HqPQvbBsfO5mxJjY4X7XuhdIhUiS72GJJghTs4o2
         Kfjg==
X-Gm-Message-State: AOJu0YxlcEGt4nL0QyjgnW/40U8eElm/OnpmOBH4chWGpQ6/HzHHgwEQ
	VUYg5t1IYeayx/1PRqKD0KhtGcWAaoG/BPCgV8npxugfGQWC8ZAia2egNN1W7VmrDBjE3MAgFXq
	1
X-Google-Smtp-Source: AGHT+IEuEYI29ufGKNb7msUrlrpjl2390ure41UxpSBJhzoXAsIr7AATTY6LyJM5UJcBPNBIObN2mA==
X-Received: by 2002:a05:600c:5197:b0:412:7061:d7f with SMTP id fa23-20020a05600c519700b0041270610d7fmr182955wmb.1.1708413917549;
        Mon, 19 Feb 2024 23:25:17 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c469100b004120b4c57c9sm13786934wmo.4.2024.02.19.23.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 23:25:17 -0800 (PST)
Date: Tue, 20 Feb 2024 08:25:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com, donald.hunter@gmail.com,
	sdf@google.com, lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 03/13] tools: ynl: allow user to pass enum
 string instead of scalar value
Message-ID: <ZdRT2qb2ArAjaCWI@nanopsycho>
References: <20240219172525.71406-1-jiri@resnulli.us>
 <20240219172525.71406-4-jiri@resnulli.us>
 <20240219124914.4e43e531@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219124914.4e43e531@kernel.org>

Mon, Feb 19, 2024 at 09:49:14PM CET, kuba@kernel.org wrote:
>On Mon, 19 Feb 2024 18:25:19 +0100 Jiri Pirko wrote:
>> +    def _get_scalar(self, attr_spec, value):
>
>It'd be cleaner to make it more symmetric with _decode_enum(), and call
>it _encode_enum().

That is misleading name, as it does not have to be enum.

