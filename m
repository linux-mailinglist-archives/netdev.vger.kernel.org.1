Return-Path: <netdev+bounces-100631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FF18FB65F
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC63EB2448B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1492513C827;
	Tue,  4 Jun 2024 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZnjOXyy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A92A3E49E
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513087; cv=none; b=bgpeZ3tU/TvnlKN9dnvgEEIyrSMDlB+24MQ4GEnvedLWcVX5i4WqndzOuNEwI38MhFc5MhwdMYX6dGVKpn1T27GwqjH9D6BO4Px3rCzzRfRO3veZ6Aa5CeIkIa4EUwxQEGGK6HXa5KA1hH8ZbcmF217yMNdERw0dF8aYAN+eczA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513087; c=relaxed/simple;
	bh=YVqJF7j5JTQcuur7kW34sX0MoeZvsjWq25tjWcLUlGA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dLDTkvv6ZUxOwbSY/UolfarXbFNC38gHrNThmuVH1qi1aZdSl0oK4o4Uqw45yKiC8PAdEAxQrvx0o9yFh8f/W3CPVSSJlHTXG54B+ccQfVeA09Blz6tT1danPMOUfLV+fizue52sA5uOrH3LX2giR1nB+qY2+KbTf5dU0Rr4E78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZnjOXyy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4214aa43a66so9211455e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717513084; x=1718117884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWxnal/GF1udjmqvzHkBMrVzYmCCb8ussd8fKG2YMZ4=;
        b=gZnjOXyyMO6uvPCGvK02Ft/J/AHZD882pYIQfBapTCXJANVqZMns9YmKmhX5KpDw+f
         WpiCD9dfQP4Id63gQnqgfphRh8oJoCKoPUdd4ueVvvHVUPgIk6xoW4sGJP6fhFb70D8a
         uh5ACsKlHE3tH+CwUJ/PtM3a3ws3/wXXJhG5kWfDOtFiRyr5qaJZCmsYWHScr759Pu9K
         D9xbgzdjwWszC4jHC9w9TqgyYKqQ9v2yartQdkj88NtwhwRQ6Rw8m63MZ4cxhW1cEpo0
         UAY5NTcpsbHOkOaCtBvbBsNTzVl+bO7EcW6DhVtIRhdPaU6ccsgFK5xbARZjHZXr6GjH
         XHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717513084; x=1718117884;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWxnal/GF1udjmqvzHkBMrVzYmCCb8ussd8fKG2YMZ4=;
        b=ZNo+D6VoDjuJn1ucXKRX3NG62u7OLL2GtS3CVjwgvU31BAchkst2Y2WhjAI+mx8LzT
         IyVCsGit/mDpgo2/VLJr5v8KckgmF0LaT3x1EJvdbySgo4z900hIprOiGEFelQx9kCVt
         e4lkudKGitIw+uhIoe3rcnUC3wgC7HFfPVpNPT2ZGQTk3uchWl4r6Dvn+aaJrLSJTnQy
         qscJe0OCzQTbANMEzGwJ61pMqtBUsaRHq511bTFb7h2GAzgGCCMFJIzK1P1UdaG7CK82
         BB4WGLWSI8zndmd4YtIMEDymxoSilEbuy9AZKINvMMLCk1g88PXtUE5gIB41K7GsJyG+
         aWqw==
X-Forwarded-Encrypted: i=1; AJvYcCWAEDMEe3am+oW4FU065EHyR3tCwmjfQTx3IOybSG3vUIpkQ53ubKFyK9BKm0+C9gyEx+B6JOfacnyoUoNCXrrcTDYQKCKk
X-Gm-Message-State: AOJu0YwLvWRBjau4HD2NJBLrnqBM9ljowFAH4DU9LRDSUHNLRLiSw60k
	X0uhLVNYJ/0HE7M5H/U2qse2pQF6XvOdSHbKgJ9zj0+LT/3j+MAH1kDVvg==
X-Google-Smtp-Source: AGHT+IFj6Lyh5ghsSNuhune+XvmP7snHfxxmIsdvPOB9gWz85JR1zF/LewxFgmluGImKBa5kJWaiIg==
X-Received: by 2002:a05:600c:444e:b0:41f:ed4b:93f9 with SMTP id 5b1f17b1804b1-4212e0621efmr104142015e9.19.1717513083503;
        Tue, 04 Jun 2024 07:58:03 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8b76f3sm155028535e9.47.2024.06.04.07.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:58:03 -0700 (PDT)
Subject: Re: [PATCH net-next v6 1/7] net: ethtool: pass ethtool_rxfh to
 get/set_rxfh ethtool ops
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
 <20231120205614.46350-2-ahmed.zaki@intel.com>
 <20231121152906.2dd5f487@kernel.org>
 <4945c089-3817-47b2-9a02-2532995d3a46@intel.com>
 <20231127085552.396f9375@kernel.org>
 <81014d9d-4642-6a6b-2a44-02229cd734f9@gmail.com>
 <20231127100458.48e0ff6e@kernel.org>
 <b062c791-7e4b-ca89-b07b-5f3af6ecf804@gmail.com>
 <20240603161752.70eee7a4@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <e0d451be-8c22-332b-bd6b-09edc4d25c97@gmail.com>
Date: Tue, 4 Jun 2024 15:58:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240603161752.70eee7a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 04/06/2024 00:17, Jakub Kicinski wrote:
> We add "supported" fields to the ethtool_ops (e.g.
> supported_coalesce_params) and reject settings in the core
> if the driver didn't opt in.

Ah yeah, good point.  Will use params then.

> Can we avoid the confusion by careful wording of the related kdoc?
> "context" is the current state, while "params" describe the intended
> configuration. If we move the "no_change" bits over to "params", 
> I hope it wouldn't be all that confusing.

I think "no_change" should stay in "context", but be renamed.
("params" has them implicitly via setting indir_size to
 ETH_RXFH_INDIR_NO_CHANGE or key_size to zero.)
The bits in "context" mean that indir or key has *never* been
 configured for this context, and therefore the driver should
 make up a default.  In that case, if the context has to be
 recreated (e.g. after a device reset, or maybe an ethtool -L
 changing the number of RXQs), the driver could generate a
 different table.  (Also, unless the driver decides to write
 the generated default table back into "context" by hand, the
 core won't be able to show it to userspace in netlink dumps
 when those get added.)
So I guess context.indir_no_change should really be called
 something like .indir_unspecified?
Or should the core just insist on handling default generation
 itself (but then it can't be sure of producing defaults that
 a device with limited resources can honour), or have yet
 another op to populate the defaults into params when the
 user didn't specify them?

-ed

