Return-Path: <netdev+bounces-158873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DD9A139D5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABE0188ADF5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316541DE4F1;
	Thu, 16 Jan 2025 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0PAUUeh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187C1DE4F0
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737030019; cv=none; b=o9idbGaNNyol1n/mVQs8rlh35ox7yN5rH7RMFY9X+XuEwi8OpFwKvazcv2INvEo7bjTt+zAzP9DEMw34plueeWCbwrYi53DPLpTG1KLp3D8jcbxMNvLVZK7UJfvS8S8GLmpHWyy3DfvhOpplMbzKCnX8Friyfh2dVAIoiIp5rdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737030019; c=relaxed/simple;
	bh=6avLKqbMIyAcFLsUgJ3ddPhVImaldHFi2l2dSLz4a2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkgP5D1y81BgQ60URLdhU+8BFK9xbKYs7PMXa/EcLPjzu+mUSxYSuhpqAaQXA8vbVrjYio/OexPGglbSYANyfScdtgo4NtqzUKG6dxFyvZj+WuDObGOD8ZXUnA5o5ofHg5OWN1d2/kzFVLxLvtHAgEjxjlidT0e6dU412K56shA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0PAUUeh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737030016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdvNaT5AMAbzNC+V/K1g6AuiGLizxX8gl1cmIdzr4t4=;
	b=e0PAUUehyoR21wKUKNsxxZi9+NH86QBuWDVnvj25gvrDbeMxLeWX+NPUU8ROyyofQYvrIW
	qfW/4Ba1hvjfjUaRjSkiD1alOZi+qai+MYI3+v5vrtna1im1CwudWCeqvUOgysRbapXsVl
	tjs+d7ygTEWhPDx6E86fKT3Sv5mh2Ow=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-8MC4aUBsOoijeL-664pBag-1; Thu, 16 Jan 2025 07:20:15 -0500
X-MC-Unique: 8MC4aUBsOoijeL-664pBag-1
X-Mimecast-MFC-AGG-ID: 8MC4aUBsOoijeL-664pBag
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4679db55860so17063091cf.3
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 04:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737030015; x=1737634815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdvNaT5AMAbzNC+V/K1g6AuiGLizxX8gl1cmIdzr4t4=;
        b=uiCZm5w788dEg7KQ9IUbpJnIciK9qt0Y23HtHXZFXmWdjJBz0RUUZnv3JfZbAanopd
         f5bAK87gyDkeZgSffr+cG+oZPDuXzWU16B1euxCE30b5aqcOMGhaYMPi0i+QFf4zP6+y
         ad+lUuOuGyJOetDcB98GMYhfwiL4DaZuCT0hCBjFwC1f9oaBTUW0ozCrQJ77kEQqPPCo
         bS2RPhWNv3MWkZfcfwzRdi2Y9qgdRwu9/Jd5dGWm/YS7mTC8BwmIqoNcDNpUqBmzeHnA
         z8iBBJYmuHw/FG8U51SniHcuum6qyUlIKtwRoXZGL7/46FG8d3S+KIBVncEWgFIaQKXH
         txUg==
X-Gm-Message-State: AOJu0YwQU5XgXzcBY1JtISgJFDSXA5IfPrseA/iUZrMPElc4fsWirSwS
	AhHZnT1tAH0Jmizs6zet/L7QJu/kUj6Ltej217x/diDIoqcLKgx3LtyWVShWsH3WxdYu/m5usoI
	9bUyDSbBWueynwzSOUBPNRJUoqStW+4Lx3MK0UdxIve+jssOl6DP8TA==
X-Gm-Gg: ASbGncusTf57nkKGc3IyTEYvyKUESyDAgbS2R1hu/Cx3hDLk8yWENGAqMxvV0dSNEOs
	xXAKfZRpywaPxv65ks1kMC/6KOIbT784lY+f1T/Xy0KgbuHLm6k9d0ACLbbjdOcZexGnzyzMcPt
	WMJ+10Mz9S+nZhn9p/FNwPCVtScqcn4MhoGx8biv0iKO5PGzmSC8QfmPoWk1+Yw0wR94htzYxr5
	S8o4YYyidahpdRxDQrPYX7bpYfeU0vad+Quw7LR1+vSw5OhIYv5CRtZ/wyuWIxOat7bfwYOJucQ
	nl2+JLCfWew=
X-Received: by 2002:a05:6214:4e07:b0:6e1:69cb:4292 with SMTP id 6a1803df08f44-6e169cb44b9mr243270556d6.33.1737030014830;
        Thu, 16 Jan 2025 04:20:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKFTAnHKeQ3NEu83F7oQ+Fqd55Mxu5etNZ1OGZtLq6UUBtIWUaZJUe+CpmMHyKcIwMC+azcA==
X-Received: by 2002:a05:6214:4e07:b0:6e1:69cb:4292 with SMTP id 6a1803df08f44-6e169cb44b9mr243270246d6.33.1737030014505;
        Thu, 16 Jan 2025 04:20:14 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873ce201sm74898461cf.55.2025.01.16.04.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 04:20:14 -0800 (PST)
Message-ID: <cc0541ea-00e6-4444-ae90-a6cbeec3f6d9@redhat.com>
Date: Thu, 16 Jan 2025 13:20:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netdev: avoid CFI problems with sock priv helpers
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, Li Li <dualli@chromium.org>, donald.hunter@gmail.com,
 sdf@fomichev.me, almasrymina@google.com
References: <20250115161436.648646-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250115161436.648646-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/25 5:14 PM, Jakub Kicinski wrote:
> Li Li reports that casting away callback type may cause issues
> for CFI. Let's generate a small wrapper for each callback,
> to make sure compiler sees the anticipated types.
> 
> Reported-by: Li Li <dualli@chromium.org>
> Link: https://lore.kernel.org/CANBPYPjQVqmzZ4J=rVQX87a9iuwmaetULwbK_5_3YWk2eGzkaA@mail.gmail.com
> Fixes: 170aafe35cb9 ("netdev: support binding dma-buf to netdevice")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: sdf@fomichev.me
> CC: almasrymina@google.com

FTR, I took the liberty of applying this patch before the 24H grace
period to fit todays net PR and avoid shipping a 6.13 final with a known
serious issue.

/P


