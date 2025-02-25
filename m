Return-Path: <netdev+bounces-169605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FB8A44BF4
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2795A3A720C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DBC1ACEBB;
	Tue, 25 Feb 2025 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WbHutTCA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AB1A727D
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513912; cv=none; b=fI12ceRrlM75wE586w8vnXH3G5JgdmS+yhkWrUupsomziXTH08jxHTf/gBFgtYMM7m5qYaUcINK92IYzHnPby8xcU1WLSPUZEviWJKrA1Ar+oA1tHsk/R3fAofQrNB7KLMX2Ku9qNs2Xz6pgqojP1qnZPllRXSBIKnKWQ0B4DBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513912; c=relaxed/simple;
	bh=ZbFhjhJzzPdU7qg4OL6BpZWoloFSSDxEJNo3uKjV7Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVTK6bwbawY3eL3GMzmJe//bz7OaIJqZMdw30rUWK55RfJ+EAeFZZLqtHsInQRsQfnwiTWQshsbxUHQfUDWkQ/OVQnQUstza/SEd7JZr8I8WvkaHbAzx0c2mgubGAXWd8GAOw2nympL5xWLSEMYLPjiSAEKiZT+ureT+LAwNb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WbHutTCA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220e6028214so132858695ad.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740513910; x=1741118710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7rRRMf5SsNxWlQh/JxR+Ow4SZo3/cWOaF5W5bjLrDg=;
        b=WbHutTCAXvbtYNGoD8NAazTBClp4JfYyVb0/Ll8MUyFINrHOnJKkhdF6t/4ENPYZcg
         PjAkDk21KSB8AIdLlCVYVo6h6fMVF+pLQvRIFHdbQBhm23suhRHnqtOFcYKwt9iffS//
         en0i5IlEP3C8GifQdzIr22F/mFbT0oWYwbJwempS2DfnkIYaSnuGp/b0dGcL9HwuyKTY
         sVCcF/0+JPgZgkS+HjHrrJFKR8kCtBhNjft4njmydXj2obMkrQeXVg/5M4a5lCCPGHWe
         RazeulqtEvqjqdVhGjg6EtL7VkMPdJ057B1LD71+Qt5Y0lnfJg+HcniZvJsuCZ7ylWvG
         Ts4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740513910; x=1741118710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7rRRMf5SsNxWlQh/JxR+Ow4SZo3/cWOaF5W5bjLrDg=;
        b=uF18EPwC3rDQinaB5plQlactSiY/dBL0355jkaN4hTFr/j8/k6MBaY+lwzmm5fcCe3
         ugleMbJI2TMdQmfhV6lJSC3PaBsLJV3DNU8bQ6VU116zmTmypxxoIJt8D6DiSb8U7EOG
         Oq8tzW1L7j3uEqUaCAV5XivYgPB0sr9KFxRSnPp14lcK1Wrv1NsGOx0YybYUQfMIirXf
         kSo1IWUoMK8RSCUCtsfFWwlddxhengg2fm5UdrqsVwgtwKcaJ+8DX2YlL21wRhvOO2AB
         Gx8AW+CFMztoajaSeyGDDMEoz5FTomLWXdxsXQMsS6FSeisE0VEitiQEaklQI30p0kOL
         cXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+JkldUa/6ydpSZ/A761/BAIUtqrbhjt6Gr7rp1GVqdmPS5qPHdO2IVjEAs0UxKcN9OtCQpZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHCa/G6bd68DAQXHgxkQnz3OI2qzVHyDvpG+FcJgLrZWhgLQ70
	qI3n/DMyGQrXmyfbzwcIUBbvko5d9s2P6Bl6abmUKS5lQguYNttvJo93a48xS80fm3Q0oCQ79UK
	rBbo=
X-Gm-Gg: ASbGnctVUqVYDqWbuMBFW5nQeIPUBfcJzzbLHjYuJ8EEldw01ZkX+IsKXWkT0N6VZNN
	9VDrAEkc0yjBCgKY4zOrVo6nhE5r55c6UflJIbKdPubCbDprX/BsuNFu6wb/wuEEMz0WstTH5s/
	5kAP34PKnYaBNcbbhDa5TgMOzkBjl2F25CqG2Xq8+9QhUIsYzyYFdnnlUQHwOqscqgM5dp10dKj
	5tZKc/n3993ddf13JGDgOcQSk7+mk3vBfQUkrm2hIdB0p+xUDLygZxold7g8bu9h7b3/7mpFGma
	lL33SJPDWtUc9RhBHlMqfyHOYcmJDbP4atbM130lf8MbBcF7ux0CYS5AkA==
X-Google-Smtp-Source: AGHT+IEmzpdRfroAIEPIL7+pwQe4f2ES9B0C6EZn6C+xpvOPqGSTIOstqonfdnt5BpA5MEdSGccDEw==
X-Received: by 2002:a05:6a00:84a:b0:725:e4b9:a600 with SMTP id d2e1a72fcca58-73426d78ecemr30572954b3a.16.1740513909595;
        Tue, 25 Feb 2025 12:05:09 -0800 (PST)
Received: from google.com ([2a00:79e0:2e52:7:2633:28b9:cd56:888c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81ecaasm1920426b3a.153.2025.02.25.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:05:08 -0800 (PST)
Date: Tue, 25 Feb 2025 12:05:04 -0800
From: Kevin Krakauer <krakauer@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org
Subject: Re: [PATCH] selftests/net: deflake GRO tests and fix return value
 and output
Message-ID: <Z74icGa4rlnNafoW@google.com>
References: <20250220170409.42cce424@kernel.org>
 <20250223151949.1886080-1-krakauer@google.com>
 <20250224124830.7c38608a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224124830.7c38608a@kernel.org>

On Mon, Feb 24, 2025 at 12:48:30PM -0800, Jakub Kicinski wrote:
> With msec-long deferrals we'll flush due to jiffies change. At least
> that explains a bit. Could you maybe try lower timeouts than 1msec?
> Previously we'd just keep partially-completed packets in GRO for up 
> to 1msec, now we'll delay all packet processing for 1msec, that's a lot.

Results again with each test run 1000 times:

gro_flush_timeout=50us  napi_defer_hard_irqs=1 --> failed to GRO 0 times
gro_flush_timeout=100us napi_defer_hard_irqs=1 --> failed to GRO 0 times

gro_flush_timeout=50us  napi_defer_hard_irqs=0 --> failed to GRO 36 times
gro_flush_timeout=100us napi_defer_hard_irqs=0 --> failed to GRO 46 times

100us with 1 defer seems to work fine and is well below the duration of
a jiffy. So we'll usually be testing the "default" GRO path and only
occasionally the jiffy-update path. I'll make these the numbers in the
revised patch unless someone thinks otherwise.

