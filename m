Return-Path: <netdev+bounces-108822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7686A925C9A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFE51F22956
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2EB185093;
	Wed,  3 Jul 2024 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNaXZdp8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210C136E2A
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004920; cv=none; b=ZT9P27+b6zVJioVei0g/4Lsf6UOkL8kKGFew5B54jMkrLPAwQb1o0EY99exSP8/xuTHd0Fn5s+HALLxNM+bIZG36qKEmFD1PVMzYaQTWFubM8ApNw0dKWEneOlOg2yCrWktD17X10d6gT4Qh4B3f2MfnkIvJ2vGZfw/6xewqyww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004920; c=relaxed/simple;
	bh=BW1RmaLzEtmZaCH2FD0nrRQOMs78QO6luSfeFqPMCRE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZHuSThu7mYSzWATyVB0ZfX2ik9GyGiobl2/Bz2WNMPELR2/GRFfffmkGt8X8XlwXmxhcpq86QyRWn0aVEKHvQINrXRlVakxYreO9eqaf1UYfxdSkzaxBoSIlJjdXSIaxKFLHLyLqJv5obAPkBPPBx0RNlBYfgp1fJawPhknvM5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNaXZdp8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42564316479so32112745e9.2
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 04:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720004917; x=1720609717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1jNVDVjDmGwWvefC2kbz1tQhrbTxn6yXbt/FgpnrC0=;
        b=VNaXZdp8Rhhwz8wOQfCTahuf5XoXUy9pE6926ZA72L4Zpu2W9+STqwV5lL5KlCSwW6
         9713jWOSDNhLjDLScqUz0ceNe4WXnEC0FxzZqluR9Z2tnWzlTO9aTPJRQKQk3iNslwKH
         f9kjMV+LZFUxqY3U+dXycU/FA3IRfEvDZM5zC1k5Z++pdTyU51PMKobSNqDS7zjTF+Fy
         QGJ1Bd1zRw7bTX9l5xnIxkzKN1aTpxWvD/cWDD9546Iro8GFo8YgO+edGuDiYIzMNEbZ
         nEl7JeaPOy5VXDcOQc7OXtX2vG7MzlF/uSEaEEaTpSmWYySb2HRTJdZn2bWIInFLybts
         hufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720004917; x=1720609717;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1jNVDVjDmGwWvefC2kbz1tQhrbTxn6yXbt/FgpnrC0=;
        b=XjonD3PQSUbQ6eInyRxmbeBrajfjsRWQ2XlOu+5qK2sXU1ImPl0obtNEAzyn3IMxQX
         Ssd7lifjjyPaSKsezaJJfb1beMMJl+zultx4+rF7EhJg2fMGDTU9Td9BzIHkTwv7lspD
         Ro9TmrX/ht7EaEDxb2NqDf2R+6XFmnFS1G5HZXOg3LjpKDm28niEorVKN2c0UHLs72xC
         5UHxiebUtSKn+hIOVBXlohAAs30E74qp183Vl+3aRctgnOMRBOZtZyNqVsNgjfeCrBAK
         cYgYakU10TomaieYSrcxOz7pO6ln3rxOLUAVSUk2iOKYgGD8vsBO3ZJ2Xtcmf2/k+YNL
         uiDg==
X-Gm-Message-State: AOJu0YyMWnrzGDSR2w/JWtm3TL4tSfZGZpNIassyHLpmS16bwE2Mdp0R
	GCWf50AQqGJCURifrfJ2uj3gu5S1FzpM4dqTL1Lpz2NGBNFsjDBSQnLrhsl/
X-Google-Smtp-Source: AGHT+IGjg52yzYWT2R2rrlPh5phX24ewkCq+vqrWA75u+RjZW9fB16Du2lf8mRsCtw4q3DEntasyKQ==
X-Received: by 2002:a05:600c:68b:b0:424:a7e7:e443 with SMTP id 5b1f17b1804b1-4257a02b8d2mr77393935e9.12.1720004917216;
        Wed, 03 Jul 2024 04:08:37 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42581bd5e4bsm128590025e9.10.2024.07.03.04.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 04:08:36 -0700 (PDT)
Subject: Re: [PATCH net-next 01/11] net: ethtool: let drivers remove lost RSS
 contexts
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 michael.chan@broadcom.com
References: <20240702234757.4188344-1-kuba@kernel.org>
 <20240702234757.4188344-2-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <c22f9b2b-cbcd-d77a-2a9a-cf62c2af8882@gmail.com>
Date: Wed, 3 Jul 2024 12:08:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240702234757.4188344-2-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 03/07/2024 00:47, Jakub Kicinski wrote:
> RSS contexts may get lost from a device, in various extreme circumstances.
> Specifically if the firmware leaks resources and resets, or crashes and
> either recovers in partially working state or the crash causes a
> different FW version to run - creating the context again may fail.

So, I deliberately *didn't* do this, on the grounds that if the user
 fixed things by updating FW and resetting again, their contexts could
 get restored.  I suppose big users like Meta will have orchestration
 doing all that work anyway so it doesn't matter.

> Drivers should do their absolute best to prevent this from happening.
> When it does, however, telling user that a context exists, when it can't
> possibly be used any more is counter productive. Add a helper for
> drivers to discard contexts. Print an error, in the future netlink
> notification will also be sent.
Possibility of a netlink notification makes the idea of a broken flag
 a bit more workable imho.  But it's up to you which way to go.

