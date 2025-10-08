Return-Path: <netdev+bounces-228277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21226BC6258
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 19:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9AB94E32F4
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 17:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFD42BEC4A;
	Wed,  8 Oct 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JTB1oRfT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C44826FDBF
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944728; cv=none; b=Z4jMEdXjXJnh6A7Gjpx9h+1l752RHBe9Zp+45Wuyb5sX+0PK8F1xf4vxIqk4qE//0uvZNfzqnwE8t3DiTJewKjZ2mWwpAAfGgpkYTVXhdShWrMpReurJGJaaTlG5/QxTGOR4KnLHD5Ka5MNh3vRdbxuI9At6nyW28vVKrOtbHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944728; c=relaxed/simple;
	bh=FZ72KjjNRCv+mDtm1ZNzA+BxeX+JJu8XiulC7AUJhyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ebir+bqAkPOAy3Ia/Y0bdIbzBPI4p74x1BNTHwj6XT9Lf3mtiHrieLMQ868XR1zsro5MXQguQTsjMwSK3LbSk4PyB8udUcXGlzXae9NgMa8JIokY3if273CeFu/nkMZZeoIJhiTvcjfTzzVWt5b8URfspdAwyRceclJbV+Hdhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JTB1oRfT; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-42f7b17f9f7so612075ab.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759944724; x=1760549524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vipt197t4SpD4OGfl+VquOF1ckWbo9u7qu446HO7ecU=;
        b=JTB1oRfTUECNjB+Ppzy7RfBTKYMA8Tg/4gIr2ln1t7ItHJ7lft6sMrMnIouQG8dfho
         ywCCmn8Qtc1+Uhry5kt9xmyE2c3f3tiQTLDo0Ecwgiumw8Fmj6OYi63aqsOOBjWeK3O7
         Fd6AldlqM65ZrIM5PT56H2LltzS3OeG9TxrMAO5zdUkYNpM70NeHTMBaSTFikvFrPiPD
         /qqUGu6MV3vmFJVzQkI/SLvfKb3LrX34sdNBbK8orFYTCClvnRdnMxEqJ22PAjOAEwG3
         59xGdyJjxipvvYqFiCCR7hdTlolUIka8j9KpsOw4jX6I6wrwpvvd6HaaCIn/f4Go9Lyi
         mw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759944724; x=1760549524;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vipt197t4SpD4OGfl+VquOF1ckWbo9u7qu446HO7ecU=;
        b=MAiu78FRU55gdCWMEJNo2iysB6ERtQPDh903V9YW9N7mFB3WPITfbW7luu++QqjJDx
         676BGApV/S86ee4EEnPMlMxhMy6Pndz5rS0YVREXKoKbIqVSt+fq9CLHKNVjws01MflM
         LEB+fKfisBkkW6eH34pRgwMlaVSOxeFOeSc9b3GTrhbsJ2YVKQLht11+jiDlmsJ0xIw6
         Zb/1Oc7fXB5jup8Kyc+HX47xYc9sVxLEUIlfAWKyoMKSDJ28AW5B7olJKXzPFYVM00xi
         82AasR3f6AdiwHR/OVYtWp6GxXicQJPr6S+bxZtOoNOAunZd0Q5pId9y2rJHzDdCaehu
         Ztng==
X-Gm-Message-State: AOJu0Yz2PYLaK4O1PExb8KKR0bjnUOmW+mWBDJQCdBgGkQJwQod2MlZu
	4p9MvqFBCWnndzSxv7qr8N/7a0dsXVRErmrBmFNAE+M4hUn1MsWsBkOIWeuuBHDCm73iChFIRi3
	JU4NHFic=
X-Gm-Gg: ASbGncuBByDt3EWi5fwsUHYUMAngOAqcW8U+2hD2Da6ycvT3RkNDfg0sRwAiVKwW9SS
	jz87mbewbtErJw0sXHtQCakB6ORNnv9tOYNdSHeCjxHKgW/ugK82qXzNzeAcAqVh4IdllbK3uRW
	M7+2S1gP7tW1HnwOMdewYCTOEOB8cyWY1r5Mxue2P10wa0uvF0s/Orp1G0V+V/3WXuQyxRCoPNO
	PHHxlM7wi7Puu6Z7fA+Z0UUSEyXXcu6vv1NdkySl6mHkOdZqiHLojEhGEotVLRPNyOyRvYUxoaG
	PX9vR07z/Ru47zfr+Rj/EoIXjnJUrnOsbH9vlAzHemuEGewGtN9FWxqqz/46WHWV6ETGomguoTn
	AaH5uD9zfMUIODvDDNc9UGeZxkKs6/ZoLUEUGrQ==
X-Google-Smtp-Source: AGHT+IEC4Taq3VC3RrSC9C71BGoDHllCdNhzl2OzqWKMV9gk2XtuM6gXx0BiF6KKCcpdB8f7gkn/jg==
X-Received: by 2002:a05:6e02:18cf:b0:42e:73f7:79c4 with SMTP id e9e14a558f8ab-42f873fb613mr40954925ab.27.1759944723815;
        Wed, 08 Oct 2025 10:32:03 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9027872csm1366205ab.10.2025.10.08.10.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 10:32:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <1b3a55134d4a9a39acab74b8566bf99864393efc.1759914262.git.asml.silence@gmail.com>
References: <1b3a55134d4a9a39acab74b8566bf99864393efc.1759914262.git.asml.silence@gmail.com>
Subject: Re: [PATCH 1/1] io_uring/zcrx: increment fallback loop src offset
Message-Id: <175994472323.2061199.15519046555023509207.b4-ty@kernel.dk>
Date: Wed, 08 Oct 2025 11:32:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 08 Oct 2025 13:39:01 +0100, Pavel Begunkov wrote:
> Don't forget to adjust the source offset in io_copy_page(), otherwise
> it'll be copying into the same location in some cases for highmem
> setups.
> 
> 

Applied, thanks!

[1/1] io_uring/zcrx: increment fallback loop src offset
      commit: e9a9dcb4ccb32446165800a9d83058e95c4833d2

Best regards,
-- 
Jens Axboe




