Return-Path: <netdev+bounces-235562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DF4C32667
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE58F34B715
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58981339701;
	Tue,  4 Nov 2025 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNbOMyTg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E3303C9C
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278048; cv=none; b=DDZSf19T2tOoTN0BQFTJkCIssba1SS2oq0yH5eOWZ2PJSLQGUy/FpxrX57tSFfzrHkSvfucZGs9ss1ptZwWfUn7a4bsTdsF4lmLLnMgoXgm+jzS8IOatrUZDb5cCp9bMifUs8s0NJ5CTzpGmcmpo1sJ3x80S9q0Hm/ItXSGZanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278048; c=relaxed/simple;
	bh=Wx29MHBm2RXDiUAmF5T94+hpdR6eJPgN69rPPWd5OmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFrmyh1vhpgnrM8sqUzYr7yVgJajm/uhMqWaUPL7oQ/Zl9G/K+VMTSbWI/5oZtXFJ881FLCgnxiG+9m1sXfZCeEgWx2BCr1m0FrxHhOlV909B5doeRDQ3dL+gsn6ZfkRqti7ObffOEjUqA6mhD/PvgthYrBWDK/nbsCsbYMLv7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNbOMyTg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so5092063f8f.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 09:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762278045; x=1762882845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvW8YZNNPsNEShPfc1BYhe9HoTHxi+BogUvpfvWJsZU=;
        b=DNbOMyTgQCJk5uWQmJY28FtcTW9l3t60aYdvUiOQGriS6xhNjt79re3/eUNxLw22fZ
         SJQX9ubMNKxc4gbE+qOu+eS3xm/fsrrCLmRKJAYgQ6UD0ryiw9KuRBq3DWHZ2aUbWE94
         vHkxNVQdZiqf6qIPpEHsQZ0h3YZHPQi2A+StO6FZROYSGHl1Iz9DoHoQTrvnhM6YuweU
         2cM/xjEMyohTQfKkGCBP+RjPpTUgWsfYigd/jS+mbsSEZb+/6RlK8mJLoHWJZX3dDjOR
         xP/0kJMmkptus7p0+sBG6W9AvPiX+w9pjNveYPyMD2M/un+jvidV15nxMK05ciUhJlRm
         rBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278045; x=1762882845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvW8YZNNPsNEShPfc1BYhe9HoTHxi+BogUvpfvWJsZU=;
        b=eoMFQYzqBcVSys3nXAoLMfabH+EGjmhQ8YwMh0lPhvC8R+0D/a2F1LaNEWw+aDmJsZ
         7JKrynlQETjaZChw22wnQO1c2vvOfe1QEvdjmcD/IrsPObi+FvXRr1YMwSm00P/nlZjB
         OySvFNR1BVXP4LrKjt/FpVAqfNz25KCbsQiCgHiFSw9r6tZOnNImiT6r87XEdI2KMSdR
         mokXhjYWXtWdlUj3JVcQbcwF9OQRyZ364DKyDrF3K8V5lTUyaeYTw8VGRvsANEuNseC2
         isXhag4CG7pCfpHwk1ihi6hhRtoHcpdWoYSe/ZtVpwP0qAx1sxVVf6OW0orbvuCvZKfx
         HfgA==
X-Forwarded-Encrypted: i=1; AJvYcCUH6cq50eOav/05fTu6EbtYvYGrgAaWVL4EnRCHkJ8L5GkixzJrauHFwItxDIiQRm11H8kYrss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMuBN2NZRPyoWs10KeHENCfLTnDD0HPyGF4zc+5D0FHqXEDhPe
	GIv1icgYQXM+VrAgtsMSdrgo15PtlnLkNpskOPnyw7VSwvDrLT6DeQSs
X-Gm-Gg: ASbGnct0RTc+wX0h+uGGeOgacJ0DPKFx1xZBzK23q5FSnNZ7DER43RTuQB/NTBb92dB
	Oc6hVRBZ7Dc/9rwvvdPFJrSk9Ov7p/YOZXBAayb0cJS/i6iZTzYpCrfWcNmGmQRbPsW7HmsIvEZ
	5H91sL5tnQdmV7rwMw9VcgxBb7rHsfkGx9Y4jbexJgKz6WvOwE11TONJqQhImknxg73FrJdYyq2
	yXEzP1HWOkCNFbfijaMesJm5eR2jCh/Jum3z15Lbd2XFeCdzoL6jZCKldLc6OjRFQ6CXOpL7uzV
	1MPw9Jnv3NcaafcPsAIfL49eq+u3klRRhBDXCupEhv/7Y1teFAsi6SdsrynpBxr/Z+z57ILv8yn
	6p2PB+fWf63pMKd167VgCJrWHsIESPHWCIYJBaDcL8SwVyBmqDGu7XCUiz2OWjELwCyxS0VolNQ
	SIo81ob6aiA4JObN07PTZ/S/pDysWqziRMDgLIoLlU+az43mezeKohkTGDu6L6PPA=
X-Google-Smtp-Source: AGHT+IG8vD2A31Am91kKp86zcrwHM1GJNdLY6dWjx4cxR0fFQbBMXyptxdu0zGiFmrarnTn1sUpqAQ==
X-Received: by 2002:a05:6000:601:b0:429:d2a7:45a7 with SMTP id ffacd0b85a97d-429e32f4abcmr119842f8f.25.1762278044409;
        Tue, 04 Nov 2025 09:40:44 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc200878sm5622982f8f.45.2025.11.04.09.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 09:40:44 -0800 (PST)
Message-ID: <08951e84-24f4-4708-82e9-d23147d0c352@gmail.com>
Date: Tue, 4 Nov 2025 17:40:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sfc: Fix double word in comments
To: Jakub Kicinski <kuba@kernel.org>, Bo Liu <liubo03@inspur.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <20251029072131.17892-1-liubo03@inspur.com>
 <20251103162416.788bca9f@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20251103162416.788bca9f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2025 00:24, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 15:21:31 +0800 Bo Liu wrote:
>> Remove the repeated word "the" in comments.
>>
>> Signed-off-by: Bo Liu <liubo03@inspur.com>
> 
> If you're doing typo-style fixes please fix all of the problems in
> the file.

FWIW this file is automatically generated from definitions managed
 by the sfc firmware team, so typo fixes need to go to that upstream
 source or they will just be overwritten next time the file is
 regenerated.  (We have tweaked the script to add a comment at the
 top of the file explaining this, but we haven't pushed out a header
 regeneration patch since then so it's not there yet.)
If Liu does produce a comprehensive typo-fix patch, I will do the
 work to upstream the changes.  But it doesn't seem worth it for a
 single fix like this.

-ed

