Return-Path: <netdev+bounces-155409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F43A02474
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618F3164013
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1301DC9BA;
	Mon,  6 Jan 2025 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYHvewOf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E141CBA02
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163775; cv=none; b=p9meD6pmfEYFSwsHQrdk7ouK62gpF07nbO42GL0UFoEhMHrUELoprsdNDGFseYq+9QOzggTW4gyVVM95BnogOxoNLfsPcVnQVUK+hR7qMJ6i+yfkNj3g102Mdd4PRqy/VaJkYbrgO9SYzkGmwtgHBO7BKVuqrvjGnDetnsWLNL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163775; c=relaxed/simple;
	bh=qW4wObHyuTrT4Zir2rUK748yTIQfQRMYqu6TyI7Ae5g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QCDbsdZ0o1oOLEOwW3FwWihG2xMBmOWxA/UP2qgb20icUgIVHfF22MeBhMYTiN3UumR69cOwUS4PKMsAtS0v8Aql8j4WxUCNLaHIvwccLRGc+bDHJ2pb1avXjqqb83SaQsTVYTEdyjgk7nm1Q0SfUv81MhEnoJAaqHYlxJiaXj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RYHvewOf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38634c35129so10968226f8f.3
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 03:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736163772; x=1736768572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7YG3GOy+g/NwAsJ5y2aA9Pj10HoYNeBxwmK3RuNDKnA=;
        b=RYHvewOfv/0ThDGyhhEPgutvJpNBHFBc4gVjcpb7I+waM/EvumzfBIR4x58wyxBFnw
         aRrEFfFzKXOiv6+za1d7QJqdBZ7BD0TwGo2T6uXCMr+mNIx7qXTo3YN0O8V2Yc0lZzgy
         7vhqYboA8D/2mLGtEyCNeAeWA0IHbTCODZ+ROA1CVr8DpqUFWYC55fUORkJDGkOHLzzJ
         QpcdG7CDkViBZsVvobS1OE6jkr9qHnqfYWKjauiRMUnsiVmX8P5Y7v12zCSKFi4lDiCv
         Owc0tZg6anba3PjNBhz8+TwIX71AJpPyB+1jb1kzyESTJiVERwZM90O2fh7ZDvyA1N7n
         9X1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736163772; x=1736768572;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YG3GOy+g/NwAsJ5y2aA9Pj10HoYNeBxwmK3RuNDKnA=;
        b=Ny917kKMPfIzDDjbQQ4UI3crTmPYyAvYrAlJLu1+oMrf27TurqHlZE6+EinSNtFr4+
         MgTPYf8I0uVJi62W1ctbxUijLeTtTJarDh+NMNmObgqQrxAlsbtTmwtFmTSnHqjESWDT
         LcqKBiRUrpmLUeh+y5PKb0SKsld1KEM+MvxtOTI/sfWpj6AD+cxDGTkomHqfYLw8TxhH
         HTMVxLtR7p7PzZULldL1yXKIQkk8XTTVQ+CeIVkUnyZMLo76K/HY4j5zHP8U56RrZpm6
         SQb7jO3b7s79Td5HOZNaT253L5KabmFh9qdPaa8FMQYXTK5+ygfEIHO34RuMs/Wsbl81
         Ty+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJ+bXLaoZWOtQFtwk7J/hVJVQebCUoqGEkQnRNnVyJnSjL6h/Iy4gG9yV/5dXAh+4Q1iIK6U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztR5O/jyb4sFBN375NqttSNvvrhHWgP+RxNX6kvj9zRHirjS4t
	1Lk3TNI/Oc8LEzgsPdfCbxBrx5/4Dr68H/PVA/Bvu31BoW6sQgs0Fk+05lKNRhI=
X-Gm-Gg: ASbGncsrVH/2Dt1UgO2icHS5JhyC2oZ6w1dU3bWf07BmXBrPNmOtha8FsL6GU5BHAkh
	Xhzqa+kJmN5GXLhQi3fPgRmIO8roRA3a49zPL3FgJtloLNam5qDst5ZGeHNbSBG5f1YkuVO++XE
	UNkM9MTRjyGngvYeGxd0VBGquM2KQpYuA6PWVBrxwPOYiC0YLKzxfmTGm6C457wYyB4BrRD/Mx4
	WhGbSsFtPrDaba4tE9CCML3CG1XHs0RC6OpiOwRA4IWHHcQeeIklywZCJX+Xw==
X-Google-Smtp-Source: AGHT+IG58q8cr4ocVDcWdFjGoPg3w6C7BABpHxOy8yDsyEhI0WRiV8e3ntHXum0mHI3s5vxK/9Yb1w==
X-Received: by 2002:a5d:584f:0:b0:386:399a:7f17 with SMTP id ffacd0b85a97d-38a221f2ed2mr38603926f8f.24.1736163771738;
        Mon, 06 Jan 2025 03:42:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a6abesm47655764f8f.90.2025.01.06.03.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 03:42:51 -0800 (PST)
Date: Mon, 6 Jan 2025 14:42:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, michael.chan@broadcom.com, tariqt@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	jdamato@fastly.com, shayd@nvidia.com, akpm@linux-foundation.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 3/6] net: napi: add CPU
 affinity to napi_config
Message-ID: <e602748b-4376-433f-b864-066afa11daf5@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104004314.208259-4-ahmed.zaki@intel.com>

Hi Ahmed,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Zaki/net-move-ARFS-rmap-management-to-core/20250104-084501
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250104004314.208259-4-ahmed.zaki%40intel.com
patch subject: [Intel-wired-lan] [PATCH net-next v3 3/6] net: napi: add CPU affinity to napi_config
config: i386-randconfig-141-20250104 (https://download.01.org/0day-ci/archive/20250105/202501050625.nY1c97EX-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202501050625.nY1c97EX-lkp@intel.com/

smatch warnings:
net/core/dev.c:6835 napi_restore_config() warn: variable dereferenced before check 'n->config' (see line 6831)
net/core/dev.c:6855 napi_save_config() warn: variable dereferenced before check 'n->config' (see line 6850)

vim +6835 net/core/dev.c

86e25f40aa1e9e5 Joe Damato     2024-10-11  6829  static void napi_restore_config(struct napi_struct *n)
86e25f40aa1e9e5 Joe Damato     2024-10-11  6830  {
86e25f40aa1e9e5 Joe Damato     2024-10-11 @6831  	n->defer_hard_irqs = n->config->defer_hard_irqs;
86e25f40aa1e9e5 Joe Damato     2024-10-11  6832  	n->gro_flush_timeout = n->config->gro_flush_timeout;
5dc51ec86df6e22 Martin Karsten 2024-11-09  6833  	n->irq_suspend_timeout = n->config->irq_suspend_timeout;
                                                                                 ^^^^^^^^^
These lines all dereference n->config.

d6b43b8a2e5297b Ahmed Zaki     2025-01-03  6834  
d6b43b8a2e5297b Ahmed Zaki     2025-01-03 @6835  	if (n->irq > 0 && n->config && n->dev->irq_affinity_auto)
                                                                          ^^^^^^^^^
This code assumes it can be NULL

d6b43b8a2e5297b Ahmed Zaki     2025-01-03  6836  		irq_set_affinity(n->irq, &n->config->affinity_mask);
d6b43b8a2e5297b Ahmed Zaki     2025-01-03  6837  
86e25f40aa1e9e5 Joe Damato     2024-10-11  6838  	/* a NAPI ID might be stored in the config, if so use it. if not, use
86e25f40aa1e9e5 Joe Damato     2024-10-11  6839  	 * napi_hash_add to generate one for us. It will be saved to the config
86e25f40aa1e9e5 Joe Damato     2024-10-11  6840  	 * in napi_disable.
86e25f40aa1e9e5 Joe Damato     2024-10-11  6841  	 */
86e25f40aa1e9e5 Joe Damato     2024-10-11  6842  	if (n->config->napi_id)
86e25f40aa1e9e5 Joe Damato     2024-10-11  6843  		napi_hash_add_with_id(n, n->config->napi_id);
86e25f40aa1e9e5 Joe Damato     2024-10-11  6844  	else
86e25f40aa1e9e5 Joe Damato     2024-10-11  6845  		napi_hash_add(n);
86e25f40aa1e9e5 Joe Damato     2024-10-11  6846  }
86e25f40aa1e9e5 Joe Damato     2024-10-11  6847  
86e25f40aa1e9e5 Joe Damato     2024-10-11  6848  static void napi_save_config(struct napi_struct *n)
86e25f40aa1e9e5 Joe Damato     2024-10-11  6849  {
86e25f40aa1e9e5 Joe Damato     2024-10-11 @6850  	n->config->defer_hard_irqs = n->defer_hard_irqs;
86e25f40aa1e9e5 Joe Damato     2024-10-11  6851  	n->config->gro_flush_timeout = n->gro_flush_timeout;
5dc51ec86df6e22 Martin Karsten 2024-11-09  6852  	n->config->irq_suspend_timeout = n->irq_suspend_timeout;
86e25f40aa1e9e5 Joe Damato     2024-10-11  6853  	n->config->napi_id = n->napi_id;
d6b43b8a2e5297b Ahmed Zaki     2025-01-03  6854  
d6b43b8a2e5297b Ahmed Zaki     2025-01-03 @6855  	if (n->irq > 0 && n->config && n->dev->irq_affinity_auto)

Same

d6b43b8a2e5297b Ahmed Zaki     2025-01-03  6856  		irq_set_affinity_notifier(n->irq, NULL);
d6b43b8a2e5297b Ahmed Zaki     2025-01-03  6857  
86e25f40aa1e9e5 Joe Damato     2024-10-11  6858  	napi_hash_del(n);
86e25f40aa1e9e5 Joe Damato     2024-10-11  6859  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


