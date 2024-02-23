Return-Path: <netdev+bounces-74476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30C8861759
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 17:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002601C22492
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71549127B75;
	Fri, 23 Feb 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="d9oBSUCo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2082C60
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704857; cv=none; b=okVjnZNtBlI/wLD6tHsMr4kzOASioWucn55lSSjB4rFlIQBYC1K/Fk/qKPZXXjEqMgar4BvA7TK+thJNJMrQVsNNqhryN7lVnK8zoR9ngeVqYjZmwIX46HL67DikH/394lgwFNLkt2upYjnqIHRiPsLxzN07OnT1VddNZqZhfs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704857; c=relaxed/simple;
	bh=Sne7MoIEIosIL4YY8uzUEy4kpjqxsoPUDSi5smt2FCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUHrQI7Xx8RY1F3Ebszqvz0iHVgCejqWc9Yq+qw+qscviK2xryi/MwFbdOWY5rh+Z5uOQ8TPOTRudH/6txCc38faeeFmlsH1RNrCLzypdHPjEKCx4daClN9BoyjwqHaSTffwCcqXvFwHcL/OdLqL+4CuaXAiOYt2Njieu7q4YV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=d9oBSUCo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4129738cc81so3163965e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 08:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708704844; x=1709309644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8sqMtV/CSCE4NXtvGwrzi3BoKXfv5w/eLz/KwYELG8w=;
        b=d9oBSUCoZtRMPG1qdcyBisUAZAi3zSZWTKAAEV03/ZYkM0Gk1bQJy0BtQ5wXnL0DjB
         dYefH5tEZHt/lNCVEpHV/WD18sdztRsKVU3TztkjL8UMfOhMIPVPkWB2gekKT8oiFdIo
         2i694HuCk7cf9VrClSwxHQVq2NA1ayl4Kvaq6MmukIfbv8hZPsWHX+7tm8tt1zr3LFAq
         FexLfV6mBU2eTWLUUxNHEAo62Nq/qNuyChFuZr4uGsr+u4/4bxFhoHeEH7nGuxQ+qKAR
         okQKKm4dQP0tUl3fKXLDRKFyt1403FotUHBYGhFxwV0SeGCo5YIjwrOL1k1nQOvPivyN
         tH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708704844; x=1709309644;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sqMtV/CSCE4NXtvGwrzi3BoKXfv5w/eLz/KwYELG8w=;
        b=VAmSKU6lzjQPp0Xi/juRw+6GsKIBWs23Wn2Tc2wc9p2BulRWiTwpfzfsXv1XS+iBSg
         AMnOzSgKjJfBCaA+LFsgEXCv+l110IljdmfoRslBpgsLcN7qbCaAmRWRGRUxyxAgzKlR
         cSeFsrCl0KQxmHLf28a4c+RNm4SVCFpixXQbmUFcj9I0XiwIsjHoEU+9j7QXnaruJL99
         t8f4VRTpk7w/WYRBUy+TLHMglpBrfFw/s82ez+2UWDuoPZzdW4bv05ybWOqg+zvTELUq
         QD9c/W+4YG9EFdpWKxatKz2g8w2plq1PhHI8ZK8LqWSMiqykcEmodtke4kiNExg5z+lv
         BB6Q==
X-Gm-Message-State: AOJu0YxkiQiUwoRGtekJatKdUdY2/WcBNFdu3C7gFpyhH8OpODfVtRkk
	rjGwdYqVA+PnS9wYEaLs/TrTakQ+MYGk35TWWrN1f3aGTSx1vKfPlEaFTRud65Y=
X-Google-Smtp-Source: AGHT+IHJ3DlD/abCY1jrSXTGVXM6wGtWyDTxnkxse73VKmRYVMjdeWjO0SBWRfrjGwVK48hL5jsYJQ==
X-Received: by 2002:a05:600c:a42:b0:412:4a57:3852 with SMTP id c2-20020a05600c0a4200b004124a573852mr200944wmq.15.1708704844124;
        Fri, 23 Feb 2024 08:14:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id fl13-20020a05600c0b8d00b00411a595d56bsm3057707wmb.14.2024.02.23.08.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 08:14:03 -0800 (PST)
Message-ID: <3c5f0881-739b-40ba-9d43-ef7c18745809@6wind.com>
Date: Fri, 23 Feb 2024 17:14:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 13/15] tools: ynl: stop using mnl socket helpers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-14-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-14-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> Most libmnl socket helpers can be replaced by direct calls to
> the underlying libc API. We need portid, the netlink manpage
> suggests we bind() address of zero.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

