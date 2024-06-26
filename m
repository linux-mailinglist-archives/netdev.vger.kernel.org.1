Return-Path: <netdev+bounces-107014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657569187E9
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 18:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20860288867
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13BD18FC69;
	Wed, 26 Jun 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWR6b8Vj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1AF18F2C9
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420625; cv=none; b=rowyE55YvUwwtqqM8bQ+TvQkN4e+14gf7d/DGuiMtAo93qA6mbH5yciXz6xpoHKMNBEzj58EV0EM2Qg/QIuoOkv2Qg2udo+u2DFUuJ5iZjNgIWb5Qdobc0+VtmdbO8cRkRG1bU7s9xxzy+AT0N95FD1xVe0Pt9hxWqMSJhz2IYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420625; c=relaxed/simple;
	bh=ABXkIOrOZiFOhYaEthrDJmymD5XURc+Sd2GLzHVrxSw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mp8gTCZSkqsB8JfCZLMbvEHaMPRyhOMSn3ZtnGVXL6sEs/aS2l7ngEMN9yz3ApdPVtJ5MngCxRepaSlSZMj0ExDXLDw6kCL9jHBJvK6YeWoy/K0Gqadd8ixv+UlboFNJAKLab7zRCuPigqtBWx4ixLl48q264v7WJWDJijSPR3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWR6b8Vj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-364b2f92388so4837096f8f.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719420622; x=1720025422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfEBOPdIux/DCtIWKciINeh0dROuUwqsdwzNZbyCkRc=;
        b=SWR6b8VjTripfQ6nOz3StpJDFmBWrIwsTdZFZSyi8QIaCjX8k9qmq6lMPVYNCZI6bf
         iNUMgOD7pAOKNCXCENSvp42lRcsFyc2bY1520tfdAMyzRjJxetYXPQEB7NQv6a1FgEpf
         hRX5kCH5HIaeTnM+62Z9xfjaSv7cO49sMBPPwjF0MSS5ORR3Z1LZmyGGpX4adyDwiYZH
         sHJPTpTQuGJbgkMBfrMr3vgWRF5beIqiOsGFc9bxU9YbefEgW6+kNRiT7epOdAscleaS
         lFHUEXJ3VpkSpcKY/ObhtQXxiuMVH7DSMXrHoaeHQSR/rJGBWCqQXvMFGOofvTT4oUvA
         EKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420622; x=1720025422;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfEBOPdIux/DCtIWKciINeh0dROuUwqsdwzNZbyCkRc=;
        b=G7z5kf9OJprFLD2bACBnYwdttuiXcA5EBZTx23jXd4xzrsASEoSsNpFjSq74TU9dw3
         HaCiaGvx+GeJYWbnEqAN3jD6FTutRPE5tqbJ3oAkgyZDeJOXn2DTeaIz7uDV7zOt+xHe
         t31xGCTUOvTLVmi1Wd8rHwtFQEepg8KERtn9xqFCHTctb7+f7lpgVrQt4TntY0h8KvuN
         S8qVxPNS7xuED7MVf+1rTyBX9Ci/fqWAsBb469tDXfBscOJam2mTAbE2f5VZBl749wCI
         1XItJ3FUbQOAr45OpGVb5gSWFWHyS8Kin64ne94jBucHtxD1daIdstmCo1V08srCX5Fb
         mGAg==
X-Gm-Message-State: AOJu0YxUWrF+fWeqq91U+gq7r4M4ZTV4y48ws8oq+HH1GJHJ8R9LJ1tk
	QadjxLT0faRV6VMuIcdauPjJZLxs6xTcdAR9hxyGf53mLo2NuTJ3
X-Google-Smtp-Source: AGHT+IEkVVvDKGc9kW47BTl4OtIcGedEsPzA2EZRN/Bwk0Y1BY6/qUGDbhwch8YJQV3qD9pMn/g14g==
X-Received: by 2002:adf:a3c6:0:b0:363:1b67:9e0f with SMTP id ffacd0b85a97d-366e94dab0dmr7100977f8f.41.1719420622334;
        Wed, 26 Jun 2024 09:50:22 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm16282925f8f.96.2024.06.26.09.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 09:50:21 -0700 (PDT)
Subject: Re: [PATCH net-next v3 0/4] selftests: drv-net: rss_ctx: add tests
 for RSS contexts
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, dw@davidwei.uk,
 przemyslaw.kitszel@intel.com, michael.chan@broadcom.com,
 andrew.gospodarek@broadcom.com, leitao@debian.org, petrm@nvidia.com
References: <20240626012456.2326192-1-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <f81bd29b-7f5e-781d-df05-da34fd539888@gmail.com>
Date: Wed, 26 Jun 2024 17:50:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240626012456.2326192-1-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 26/06/2024 02:24, Jakub Kicinski wrote:
> Ed, could you try the tests with your device?

Don't seem to be able to get them to run:

# Exception| Traceback (most recent call last):
# Exception|   File "/home/ecree/kern/linux/tools/testing/selftests/net/lib/py/ksft.py", line 134, in ksft_run
# Exception|     case(*args)
# Exception|   File "./drivers/net/hw/rss_ctx.py", line 70, in test_rss_key_indir
# Exception|     if len(_get_rx_cnts(cfg)) < 2:
# Exception|   File "./drivers/net/hw/rss_ctx.py", line 55, in _get_rx_cnts
# Exception|     data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
# Exception|   File "/home/ecree/kern/linux/tools/net/ynl/lib/ynl.py", line 1029, in _op
# Exception|     return self._ops(ops)[0]
# Exception|   File "/home/ecree/kern/linux/tools/net/ynl/lib/ynl.py", line 985, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.lib.ynl.NlError: Netlink error: Operation not supported
# Exception| nl_len = 28 (12) nl_flags = 0x202 nl_type = 3
# Exception| 	error: -95
# Exception| 	extack: {'bad-attr': '.ifindex'}
not ok 1 rss_ctx.test_rss_key_indir

Cursory investigation suggests this is because sfc doesn't
 support netdev_stat_ops, we're still living in the bad old
 days of ethtool -S for our per-queue stats :(
Much as I'd like to fix that, I don't see a prospect of the
 folks upstairs carving out time for it any time soon...

-ed

