Return-Path: <netdev+bounces-94929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF18C106B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC0C1F224A8
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231D21527BB;
	Thu,  9 May 2024 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="12O7hd2z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770EF15253E
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261524; cv=none; b=CaMvpIAeJDLz0YONOCi7+/dfgtJ3VC9qXY+I8PBZ3jECU5n66TXNISrZkRD5cPZWrJBxtAuMbmw6kEpP01ZDIu4ozOg2EJ51EmBPt7pBZAq2whgvjQJhsCxe99dUlP3LuEmxq/bjnGRepR5z+yo0kVoCZpeQbbDCxOrZOr/xLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261524; c=relaxed/simple;
	bh=UGtd25PtHEIWxCFYY/R1k/CiR1C5wx6tTMdVM+SZH6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNpV+GbT7zS4cgK4W50PiJOqSzWbBu1PLwh2D15k/VCuvegEYtKs/qG0BF1cCv8iWsU2PKpcjD2cS1oniDNy3kC+p/Ar5CPKLJzklthGK7i5Npsv9uChhsM7gHrzKHQefaoV9r4iXP0DHU9WgpyiQerD2AxMy0Kqx/a8RPy0Ho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=12O7hd2z; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso4975395e9.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 06:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715261521; x=1715866321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=70d8HmBhBsVnOVGM9dBLiSdBfBSq7HfimZSV/5XPOsY=;
        b=12O7hd2zCN8U3YDiF/NiZW21UN6bBtIjcCDbBir7gFNoMfGlmrh0rOeEsrArZAE+T0
         Ek31ConGocLhr6Nlzm7PKoF6JAA3ElYB7t51hHmgqKH5ETeDfSfpSEmz5z+f3ATeWe2H
         QqKywAdHKDsH20cQkALBUm5FNHVovCZYxFCJfeSqcWg059ZYeww8ZjjYHKU+PPNfuEJt
         da3p7z59RB8gyCTAEQA7u2+u+Ll1DbwUiT/hhyKqQCuOEC8ahrbR4P9Myw6hPMarh5fi
         sm2Ve1fpqUVfu70yRVIp9BCQnUeRbuq65OHAhkHQ2r5/eVssu3vOl3Uy1ZqMXhO9CM7e
         oL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715261521; x=1715866321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70d8HmBhBsVnOVGM9dBLiSdBfBSq7HfimZSV/5XPOsY=;
        b=br12/8BUJzwnn6/f81eGL8axUbYjINHWT7do6zg4b1PraVXNUpfoF49DnVBVxEGOlK
         +FG4PIqmqnYk0QNTkyJPzeH/FzxxlkIV64hpqT1eHbXocGdg09I9w1ZnxpkWbekf8nad
         /fYf/KDutkoSebNofaB3RSQuBIHqngKPwVNbGT8XVLrZF5mL0r9qZZwAi/ZCBOz1x++h
         9O45b5VzG41a9nQp9dJaMbdhU/vKvUvUmO3Q6lO1XfhScrL72no5g40+/ebZfE/aRcVf
         SgYX5/hjZAtLdTBZgiaSA/z48GLEkBJoicL/SCQrrEFD76AjG+OLMm3yiMunN05s9x7t
         CgYw==
X-Gm-Message-State: AOJu0YzYrJBWuj47C9wytF69n/5WBOUNfJ6eXvquEcWWGNbazG+k/NPg
	1gcUAPFzyeV84uS8uSVgEficRqFJQ1L+NcxHL5Gctqyu/29RhyfxFtooO0H1evc=
X-Google-Smtp-Source: AGHT+IF5XnRKnh+zxxiQWj046SakVClKzAm5n/VwxuaCxO5rFmV2zyz0T1mPR2yDxRk1wD0FiW+FfQ==
X-Received: by 2002:a05:600c:1d05:b0:418:d3f4:677b with SMTP id 5b1f17b1804b1-41fbce7ddc9mr23119235e9.17.1715261520556;
        Thu, 09 May 2024 06:32:00 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce9426sm26020195e9.25.2024.05.09.06.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:32:00 -0700 (PDT)
Date: Thu, 9 May 2024 15:31:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509084050-mutt-send-email-mst@kernel.org>

Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Add support for Byte Queue Limits (BQL).
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>Can we get more detail on the benefits you observe etc?
>Thanks!

More info about the BQL in general is here:
https://lwn.net/Articles/469652/


