Return-Path: <netdev+bounces-133858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDC49974A2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED568B28D32
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED001E885C;
	Wed,  9 Oct 2024 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="c+kPavku"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF561E8835
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497455; cv=none; b=dnzp92i3Jf+UBHjxRLNDfYjABbKtiJ23gJyTQE1s8LXpqHQOwlEB+Ey/djxLN4/kBFavZho9i/+XH+fUKNpN48T44o+iaePcan1CE2/sM3bjDBALc4ql478mTDyspp1f427Nv8AXxpARehdcIVEN4eS8mole/q2ncSAq+aZITMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497455; c=relaxed/simple;
	bh=Y8Ln1XwEc4rjZOzbJ1tswoTM60G23BaKnha7OpfHnmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cytc3mCYR7gNXnbpmn35hCWf0oBRmETHlBmfGI4uZDu3kigHonbKPoDzHuLpjC9ubzsFoXmKndFnDOl7vMczZX0qhTv58AbzO+R2WfSO+gKI1s6mPAaakLy0XP7nQM/D1w2I3OLBc//1popMGFNagDGOrlozdwcalQRIIL0zC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=c+kPavku; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82fa0ccb0cdso2281239f.3
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728497453; x=1729102253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkucv3wf6/s6xNyUK3lJt7IT38u7QqljzkfyzNqbYBU=;
        b=c+kPavkuIeA6hAlH3toWJ29mGRckQcRMvbCMoHeACtuml01fBOWqsTvBt2sZkfMIzd
         NsOgZoukLRoth+ke05vZhAIHuOsbpwJeJSZy0l+MGS+jj+cdpuLNcH5lhhPZ1hbYNRws
         jHjb3aHwcI0NRZnRP15C2cGo1S9NJy+7iKvKOvrY18Efmcvs9ry/VwC1Sos41tU0MrvT
         nR6rcqp5V7fFIktA31axLUpx8EKwOpr4f15zwRgBSa0e2NAuZ3y52+psSaMTRQG0DikF
         JR9z/xDU3d79Bv5+n2dHOr/wedcIQB7bxPnN0SnN5HXlO7yvL0fv/dDwZfET8yuJ1cJn
         A+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497453; x=1729102253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkucv3wf6/s6xNyUK3lJt7IT38u7QqljzkfyzNqbYBU=;
        b=n6YMtfsciC3cphEk85Q6V4HW79kGg9eMoY0OP3Ib/J0/AfDFzBoguvFODfAYf9SNk4
         219mnMCkJcZKzSNdoxIAmcJp9/43GJZIlTzSf0jwruZMPnr+RmrHnkFN1xY51V3zeNX9
         ZQLHZdrtAe2jQY9t1jpyzj7ndmmH2zp+2lGuenHC21Qz1NL7+dbPyRRnNRmLm5WUQnDa
         r+q+tJ/hLn0AS9ZMpwLI3kLlpihCfqV4fHFI23yt32ycXro9BeUU1J5M45TgwQx8pSYP
         DK+U+l5jUeAgIl9QONl4u2eNgJIzsidQmSVHUU/ctFS7IoxChl1i7Q3DluIPgq3rD+KA
         M55g==
X-Forwarded-Encrypted: i=1; AJvYcCXNbpC0fVdFx+oZ/qD1lpdE5JKa/+G8RpdjzrG7yZwrBrOZ+kp4PtaAYWcbgc/MdYYKwmCQkJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00bNAU0N5OzX27bbY9yCvJjRtDipUQatoGUuvA9l4q9jN4avr
	dUb+2F+GkUrYaWwmynNcasPdFuynCu23rQQ2tYUmoDdJb3JjgWqFinzrlE3T46U=
X-Google-Smtp-Source: AGHT+IHYh+Bglk1MJQRysW3I9XHlC8lpkls2MkeH7/WvMTiC8jlasHO+h0OZXyUZDPnv5JlB7Lg3dg==
X-Received: by 2002:a05:6602:1554:b0:82d:d07:daaa with SMTP id ca18e2360f4ac-8353d47e54amr364781739f.4.1728497452790;
        Wed, 09 Oct 2024 11:10:52 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503aacb60sm231916939f.31.2024.10.09.11.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 11:10:52 -0700 (PDT)
Message-ID: <69755156-9aba-4b52-b4ba-da87da82de20@kernel.dk>
Date: Wed, 9 Oct 2024 12:10:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/15] io_uring/zcrx: implement zerocopy receive pp
 memory provider
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>
References: <20241007221603.1703699-1-dw@davidwei.uk>
 <20241007221603.1703699-12-dw@davidwei.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241007221603.1703699-12-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Looks good to me.

-- 
Jens Axboe

