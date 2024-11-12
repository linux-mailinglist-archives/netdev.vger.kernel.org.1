Return-Path: <netdev+bounces-144011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2079C51E1
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81E5282211
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2145720CCE5;
	Tue, 12 Nov 2024 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIn87XE/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87294206042
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403452; cv=none; b=YkX8BP00IO+XeYES93K+c7NvXMWzDprrH5lNgjl1Wi4n51XGAgcw/f/DSDUWG0icAuHDBKAc2xw9ua4oYBhyqIw8XVDqfRa+XhZyIOt1wJZQQcVmYbmT/haqcxZ1XXSgK+Oot8hhGEfydNN6lMqHufVU9QLrFQjWtysDsjb9lZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403452; c=relaxed/simple;
	bh=wmHalBTF+umwJqqlhblNkxR/MK+QBOxtLWBOWO6BoGs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=M0UdFk2qkgQXnSbg53BRIHGtHM3lToKqOkYJ0rIuMEoFrVpA9adSeWriV19xPbTOS0kGYlB8nM5yyoTcCTQJr6bx2FZUiv8IC9w178L38DzWlm645BjqwjRg0v7+PYMbzyYsYNm2cIViuNaWgs15IMAD3PVwvtqul64VeK03UuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIn87XE/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43158625112so47740385e9.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 01:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731403449; x=1732008249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcyyrO9uue9TUoxI0pALH1aVpEd1z0nX2nTCqexFV2Y=;
        b=PIn87XE/xSTBn3xXMEKLbkHKbzgbblXHDAhrcZQHKLdi/JnjFV1AyJb7eMdD4HeTdu
         NH53QvTBjdgqt3UMtHQ1Ffio2aV6RA2Oq73hXPq3sW+O2V6hStfrl4yPwdwRurOSQJfa
         adbklB0oSLZBbVbjCxttotiNsP6Hj7JbVRzJY3NCyCUm8IvKuYQQmfnx6yzndCRDO0KW
         axj42xJMHWxC4OPoWuE5hTYJFC+N5ikXrr6+IMnkozIRtFoTaKsfN7s3z3P1Pb886yqT
         usmBtk9CXyt4AhL3Kqv1SdvSCaJfcDA9drzVWkCf9WMyoyoBU2eRxMPdYyNhtSUKRUgi
         logg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731403449; x=1732008249;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcyyrO9uue9TUoxI0pALH1aVpEd1z0nX2nTCqexFV2Y=;
        b=WgoCA9+OINLyCvNtfzUk/CT1wMqAPhZe0lHDW7QS63evdZ/HnowkvjsYwEyKrc+gHt
         C+Ua/2sw0W+zlO/THDiF5/9g1LTyi4RmTg8YhoVoo4NP59SMEnzNrqpDsQ7WT00qbIaX
         60f5klIMW01HOT0HzVE6/QS4hh0pRnF7IMF5YF4h3luO9ewzK1wRTRM7WnpNPkae8cvf
         PNHW2ISU6wJ4Ng7RjeBBGSC3VproyTu/SvWYS9lwq92YGMn1iedBHL2XehIye1PIoXmT
         NfHDB0kyoo23f4Hl9dkDGvIxK7OPLWP1xCCfSVTtWZPt5EQcLxujZyoTO0XGVPSdmmrC
         lwDw==
X-Forwarded-Encrypted: i=1; AJvYcCWMOeByZV8PUm3e/j4aXBFxxmQ+yh2r/UthkuLfFJrcqnN4r3KS4iy3NmT6yGcZJuxDZ9J1gjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSGoz06/xeTGUeulIVoWa328DO83npOVMQQNiqHI4y2PwNUTdC
	8uT90MAO2gJsbsu1xi1U/n6bKiKx8iYCloMUcRVQMIwm+x1PgzQw
X-Google-Smtp-Source: AGHT+IGzVQFx4z5zNnTalocLtoqjlyzKkpBKTBbTqMeREnmirbKQA0zPo7qwPWOAZMyXB0JBlBauhQ==
X-Received: by 2002:a05:600c:4f83:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-432b7517aa4mr125843185e9.21.1731403448747;
        Tue, 12 Nov 2024 01:24:08 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa737721sm242929275e9.36.2024.11.12.01.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 01:24:08 -0800 (PST)
Subject: Re: [PATCH ethtool-next] rxclass: Make output for RSS context action
 explicit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, Daniel Xu <dxu@dxuuu.xyz>,
 davem@davemloft.net, mkubecek@suse.cz, martin.lau@linux.dev,
 netdev@vger.kernel.org, kernel-team@meta.com
References: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
 <ea2eb6ca-0f79-26a7-0e61-6450b7f5a9a2@gmail.com>
 <Zy516d25BMTUWEo4@LQ3V64L9R2>
 <58302551-352b-2d9e-1914-b9032942cfa3@gmail.com>
 <20241109094209.7e2e63db@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <7fd1c60a-3514-a880-6f63-7b6dfdc20de4@gmail.com>
Date: Tue, 12 Nov 2024 09:24:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241109094209.7e2e63db@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/11/2024 17:42, Jakub Kicinski wrote:
>  - fixes for helpers used in "is the queue in use" checks like
>    ethtool_get_max_rss_ctx_channel()

If there's an RSS context that names a queue, but no rxnfc filters
 currently target that context, should the queue be considered "in
 use" or not?  (Currently it is.)
I'm trying to figure out how much of ethtool_get_max_rss_ctx_channel
 can be subsumed by the logic I'll need to add to
 ethtool_get_max_rxnfc_channel; if we don't count unused contexts as
 'using' their queues then ethtool_get_max_rss_ctx_channel() can
 almost entirely disappear.

