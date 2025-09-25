Return-Path: <netdev+bounces-226285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0264B9ED3D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60798175CCA
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8EB2F49E3;
	Thu, 25 Sep 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyM4MrPr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FF2F49E2
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797692; cv=none; b=dYdhKMvesUZKJjJciShLeRbMRMqr2IS4OYBYQu6c1tsLMgXb65SkfKA7rqZwKkQFwgfURdTvKdtdsEZNc9LxQ0IdYW9kQvgK3PWW0BvmkJ6reSM16EIoVeYxfY8dXZntHV3QGvcbk16Phv/TXMrt8t2LNXVhKX2BotLG+118FuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797692; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=YGeAyKVPx26p/wO5wZNe0Z7O9JvQkyTWEUcTd17pH+UZ4NO5Mx8NVx3BnxUGmQCoXDGxU0Vz58CiF5S6Fd1woqwOvtyXB3pX/rpHoQi82OP/07/K4gczF46B4zcAo2eCQikKLNnqtXBnEon8WQyXZEZ6EzbkcktC02B/LTT3q1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyM4MrPr; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so859646a91.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 03:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758797691; x=1759402491; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=QyM4MrPrXzMsF532daIzeFM6iptEa8iyud1CjVWCB1QiT9v5lkx/EkV1voQ2jhxvxO
         nbjR8NpWTDMMZXE4/1b+sR0UauZUvY4CklsPCDrEe6vwGOgDE/qmYrQULFXlpI177Q9M
         7JRISqUpA5/N2RW+HjuKlHyqvWO2eqKkFd0D7WDKLG4YEv2vk7tS6DbFzboW8kRqArsX
         ROba5ih0hWKlr3ATH/4ae6s+tsOfGmgWJWiWw9H3J1rDq9xVmYKR3+p/BfbunM+0+cQw
         8qcIE6t5+/gbe9gFFIoBljasElv9lOQPXVAdhLKV1M3JuR4BR82XJA3p11/ECNtO0ayL
         pPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758797691; x=1759402491;
        h=content-transfer-encoding:autocrypt:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=qIpgbdeMZog09mfkAtDREqUJwOoRAeWilbtP/4cWi+GAMZGVaMbEHvapqs0XROabMu
         rEEM5Cl7ru/8V48Bat5tejTdObi2iRpa5IXUiix6uPVhu1D4QtDq39L4cyWEMvAKlcjR
         i8+oQEyUFghm8WuUte86Zkn0DxTGghgc3k/g58X0RbeA0TsIN1zuxXqZbP4PKiuxbR+1
         RV4P3iD1ezDchXtu5Xxq1/+ekN8Hdfw3k9t9MHOtBSA/LKWjA2Ke15SyOetfQ6bds5/t
         haPI2MDI2qaSiqi9x/k3lfztxl3Hcrbt4Traa93wu9QUgVH5V3YdMeFGUDoFBiMujOpw
         OjYw==
X-Gm-Message-State: AOJu0YxUPoGSUDOUa41PlfhUAiAz54GD8hoJhc7UWUeofKOifWu4IJKd
	VxcgULEkvwBuH6ZiGD2uuj5t59AIg7CB1D52S7R74uPY6nQUSbmqCRgii2YYA6HM
X-Gm-Gg: ASbGncsuhgR3X7WAN9alJMUtYLEcJ1lpuun9QQknqUwM3Y4GatL2i5H5rg98bRx8D+r
	2/Ust77USOx97Ir7r1ttRN9VATZN3UKC6dRGl5eEBUDcMnjKDlUCUIt7/rRvGqhSEsVNxV1sMUi
	wGLorg0t25W4jh66sJU3RqDctz0NyUA6LaxWktLNwICJrnmcBL6FP77yeNP1r2K6haPJ+6YoKo/
	Lf1zqGkgxkvAvSqYdCcfRUTW6fycHY5zRWKmR+5u3JV3lJhko2EHswDe4umEtDST/2yGcncCDSy
	AuQbzJKIxjfIbqbiwZSzqDDPobisHN+c+fWDsj0tHlSkHOJ+MbLISfOxzjaNmTqkx8bCUj9379p
	lVmMJWZxCJiaCfaUfl+IVh+IwNXFOfCoEF7hOAGJ2JSME+d8wrJ8yxj2IHlDpT5BHbPCG58Hb7y
	4Jrq/BcUyt
X-Google-Smtp-Source: AGHT+IGJy924XJEDZ7bWBoyShXiPhOxYDfWRhXkjm4lzaGvtHnO4pUiQIT2Q8m9xmm6ff0J1zjMhvw==
X-Received: by 2002:a17:90b:4f4b:b0:32e:859:c79 with SMTP id 98e67ed59e1d1-3342a15e6b6mr3342549a91.0.1758797690585;
        Thu, 25 Sep 2025 03:54:50 -0700 (PDT)
Received: from ?IPV6:2405:201:8000:a149:4670:c55c:fe13:754d? ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be148e8sm5393782a91.16.2025.09.25.03.54.49
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:54:50 -0700 (PDT)
Message-ID: <8374c663-f465-45ae-8a2f-1d887d53bba4@gmail.com>
Date: Thu, 25 Sep 2025 16:24:48 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: Ankan Biswas <spyjetfayed@gmail.com>
Autocrypt: addr=spyjetfayed@gmail.com; keydata=
 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
 TRpGew2ozniUMliyaLH9UH6/e9Us
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



