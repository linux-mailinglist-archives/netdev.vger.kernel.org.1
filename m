Return-Path: <netdev+bounces-171102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC6A4B814
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 08:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1831890F72
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 07:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16141E3DCF;
	Mon,  3 Mar 2025 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEeCMz+R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2994A3C
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740985576; cv=none; b=cTrs22eTv/MPk5x2lxmm2sbRhCxlCXenkC8x2QFcXl6aGbgX3cFHbQzkRmZkuvkBf+0wWDzdJDTGrsmEN7bkE48eibYDh+2QDFe9m0cfmeeuPiwtICXZT24Q4WA9NZlwZe1XhQd7ZGkRxX+SR7BQyq3+7bozZjSnInE/DQNY6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740985576; c=relaxed/simple;
	bh=Rka7/Rx/UAJwBcyQ1ctL/DACSoeBVpoGCkrLxyEqkDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=asA7Vb+7BRTwcP0c5qyPZ6cDJOzd50lPTzkS0HEC7brcIpdi5p0jGoH9nJRrBOM13Ql5RSjZtLD/jd3vPdwWWvu7gYFlMPrs3giVgM+TnJS/84joBtkcEfFGlgtvZSy0QvOweYIsxCyMC4V4t1gFbDExWt8Pa4oj7faeKwZUxwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GEeCMz+R; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abec8b750ebso709405466b.0
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 23:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740985573; x=1741590373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvEeRk3M8QKrsU6ZWqi+zoW7rNpMcZv1dlxRGclyC7A=;
        b=GEeCMz+Rbktm/9rhAQq1g8PSma7KjfiNJvvMwnLP1pFi9n8QkWm+/albMgNWB3AlP6
         DFThGFL4+nSBc5dFQUTENCaY4znQaIK1/hWfh6GlbPIbTPsZ3Guh1LnKoHXPWpxCaFRg
         Jy02Xebm3PwR6IF4RroGHJF/PonhugOQILhgNi2TokByTssbBcy/zyEjev/U7VnI2M7a
         P6xslx2DU2R8JCWYIfylpdybKYlM0JKDPj4BAqChG6joApIPSWu5JU3xH30enl5Y6x5K
         PsmptkjzDat1xLl6eyD9w/+JXOPej3J+LZ+Ikg7T/DSmiTvCM5xXCEWcOB8KEkZEaEWp
         cl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740985573; x=1741590373;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvEeRk3M8QKrsU6ZWqi+zoW7rNpMcZv1dlxRGclyC7A=;
        b=Hhz3BxrX3p12Fwf5c+y6aYv4S0EsuqgdyQiPkCVAyhf4A7YLmtASHMFBxIaCP0Hgon
         3B029SNsGL5+sMOuAsWYjzS6M5XTyObv2Auztdw/Cd55TmGbbD7jRojRFQog8QA0PK+v
         A1K6vCmzPfHpbQzqTXNUPTxn+b4V1n6KCGezHJ4g0HVMJigm8OoRhl8jOtQvVthCorNN
         Ki88X8EiREalir7e5Xkh9k6kJ/l5X9HjUEocRzOQxAywWFizyZt05xKGQj0mX8/stZTQ
         KW9VBBKGseN/uK1xZ+ugXlzozGld9AfBxF7rcwTocS1MqmIkSioUYyyuV1r/p2lB8oZz
         x/XA==
X-Forwarded-Encrypted: i=1; AJvYcCVQeBXpxfKSqh3HcgkRoO6PSFOE6vLmLlHvHM1eXIPcKEB9nyquyEhYf4WidRbkIQjvoBC13R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKxcwmvjJuAzoMpnSL5TuCpWbzPG9aG2C+INUxsTaObqGNyjCi
	le6tM5Fk9snPQ1v4m/Tsg0GgxYxIGh6X1QCS3j9s8DabPyYVL8AfUhz1jqM08z0=
X-Gm-Gg: ASbGncta+/DLS9r7CQimJyMOOmu9qBmm5Si/wu3i//jxD0g3rQpSBFFOlAf8F29DZkO
	oD9NTKgIafxp5KPAbpSa21TFMSJM/dkVfdLzAbpqhkxROOvgYnuL7I2OKfE8WqGZlUcp4S5S5Bn
	9I/NN5aK1NNoJFEvOTRB0hoOMqaOAgjmPZcqLfihcFuS40zNOTPRNTe0Os0lB2TxgCBzUjHFztg
	qa5A/fagNcTHiSlLf4BGW3hXBqBpSW6GnQhA654MLx7HKe8OS2fn5fcKkOtsRtZBwXSXA7Re8WD
	2ah1KX6BfLGgFEZ0kuXTb1/el8M2hZHyb6xP8jDTKQPWRDUYcw==
X-Google-Smtp-Source: AGHT+IE9RaG3JnTWQBOFC+cG5oJLPzGegDPF8j6pgIAxLmaI3dzluH6lmpvCgAJRjLW14fgB2O0LwQ==
X-Received: by 2002:a17:907:9728:b0:abe:e814:ecb4 with SMTP id a640c23a62f3a-abf25f8dd35mr1474577666b.4.1740985572603;
        Sun, 02 Mar 2025 23:06:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c0b9cbfsm769454866b.14.2025.03.02.23.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 23:06:12 -0800 (PST)
Date: Mon, 3 Mar 2025 10:06:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 12/14] devlink: Throw extack messages on param
 value validation error
Message-ID: <838b1bb7-776f-481a-bda0-015368012040@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228021227.871993-13-saeed@kernel.org>

Hi Saeed,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Saeed-Mahameed/devlink-define-enum-for-attr-types-of-dynamic-attributes/20250228-101818
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250228021227.871993-13-saeed%40kernel.org
patch subject: [PATCH net-next 12/14] devlink: Throw extack messages on param value validation error
config: sparc-randconfig-r071-20250302 (https://download.01.org/0day-ci/archive/20250302/202503022006.eOu80RMF-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202503022006.eOu80RMF-lkp@intel.com/

smatch warnings:
net/devlink/param.c:498 devlink_param_value_validate() error: we previously assumed 'param_data' could be null (see line 475)

vim +/param_data +498 net/devlink/param.c

ca557d9df319fed Saeed Mahameed 2025-02-27  461  static int
ca557d9df319fed Saeed Mahameed 2025-02-27  462  devlink_param_value_validate(struct genl_info *info,
ca557d9df319fed Saeed Mahameed 2025-02-27  463  			     enum devlink_param_type type)
ca557d9df319fed Saeed Mahameed 2025-02-27  464  {
ca557d9df319fed Saeed Mahameed 2025-02-27  465  	struct netlink_ext_ack *extack = info->extack;
ca557d9df319fed Saeed Mahameed 2025-02-27  466  	struct nlattr *param_data;
ca557d9df319fed Saeed Mahameed 2025-02-27  467  	int len = 0;
ca557d9df319fed Saeed Mahameed 2025-02-27  468  
ca557d9df319fed Saeed Mahameed 2025-02-27  469  	if (type != DEVLINK_PARAM_TYPE_BOOL &&
ca557d9df319fed Saeed Mahameed 2025-02-27  470  	    GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_PARAM_VALUE_DATA))
ca557d9df319fed Saeed Mahameed 2025-02-27  471  		return -EINVAL;
ca557d9df319fed Saeed Mahameed 2025-02-27  472  
ca557d9df319fed Saeed Mahameed 2025-02-27  473  	param_data = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA];
ca557d9df319fed Saeed Mahameed 2025-02-27  474  
ca557d9df319fed Saeed Mahameed 2025-02-27 @475  	if (param_data)

This assumes param_data can be NULL

ca557d9df319fed Saeed Mahameed 2025-02-27  476  		len = nla_len(param_data);
ca557d9df319fed Saeed Mahameed 2025-02-27  477  
ca557d9df319fed Saeed Mahameed 2025-02-27  478  	switch (type) {
ca557d9df319fed Saeed Mahameed 2025-02-27  479  	case DEVLINK_PARAM_TYPE_U8:
ca557d9df319fed Saeed Mahameed 2025-02-27  480  		if (len == sizeof(u8))
ca557d9df319fed Saeed Mahameed 2025-02-27  481  			return 0;
ca557d9df319fed Saeed Mahameed 2025-02-27  482  		NL_SET_ERR_MSG_FMT_MOD(extack,
ca557d9df319fed Saeed Mahameed 2025-02-27  483  				       "Expected uint8, got %d bytes", len);
ca557d9df319fed Saeed Mahameed 2025-02-27  484  		break;
ca557d9df319fed Saeed Mahameed 2025-02-27  485  	case DEVLINK_PARAM_TYPE_U16:
ca557d9df319fed Saeed Mahameed 2025-02-27  486  		if (len == sizeof(u16))
ca557d9df319fed Saeed Mahameed 2025-02-27  487  			return 0;
ca557d9df319fed Saeed Mahameed 2025-02-27  488  		NL_SET_ERR_MSG_FMT_MOD(extack,
ca557d9df319fed Saeed Mahameed 2025-02-27  489  				       "Expected uint16, got %d bytes", len);
ca557d9df319fed Saeed Mahameed 2025-02-27  490  		break;
ca557d9df319fed Saeed Mahameed 2025-02-27  491  	case DEVLINK_PARAM_TYPE_U32:
ca557d9df319fed Saeed Mahameed 2025-02-27  492  		if (len == sizeof(u32))
ca557d9df319fed Saeed Mahameed 2025-02-27  493  			return 0;
ca557d9df319fed Saeed Mahameed 2025-02-27  494  		NL_SET_ERR_MSG_FMT_MOD(extack,
ca557d9df319fed Saeed Mahameed 2025-02-27  495  				       "Expected uint32, got %d bytes", len);
ca557d9df319fed Saeed Mahameed 2025-02-27  496  		break;
ca557d9df319fed Saeed Mahameed 2025-02-27  497  	case DEVLINK_PARAM_TYPE_STRING:
ca557d9df319fed Saeed Mahameed 2025-02-27 @498  		len = strnlen(nla_data(param_data), nla_len(param_data));
                                                                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Unchecked dereferences

ca557d9df319fed Saeed Mahameed 2025-02-27  499  
ca557d9df319fed Saeed Mahameed 2025-02-27  500  		if (len < nla_len(param_data) &&
ca557d9df319fed Saeed Mahameed 2025-02-27  501  		    len < __DEVLINK_PARAM_MAX_STRING_VALUE)
ca557d9df319fed Saeed Mahameed 2025-02-27  502  			return 0;
ca557d9df319fed Saeed Mahameed 2025-02-27  503  		NL_SET_ERR_MSG_MOD(extack, "String too long");
ca557d9df319fed Saeed Mahameed 2025-02-27  504  		break;
ca557d9df319fed Saeed Mahameed 2025-02-27  505  	case DEVLINK_PARAM_TYPE_BOOL:
ca557d9df319fed Saeed Mahameed 2025-02-27  506  		if (!len)
ca557d9df319fed Saeed Mahameed 2025-02-27  507  			return 0;
ca557d9df319fed Saeed Mahameed 2025-02-27  508  		NL_SET_ERR_MSG_MOD(extack, "Expected flag, got data");
ca557d9df319fed Saeed Mahameed 2025-02-27  509  		break;
ca557d9df319fed Saeed Mahameed 2025-02-27  510  	default:
ca557d9df319fed Saeed Mahameed 2025-02-27  511  		NL_SET_ERR_MSG_FMT_MOD(extack,
ca557d9df319fed Saeed Mahameed 2025-02-27  512  				       "Not supported value type %d", type);
ca557d9df319fed Saeed Mahameed 2025-02-27  513  		break;
ca557d9df319fed Saeed Mahameed 2025-02-27  514  	}
ca557d9df319fed Saeed Mahameed 2025-02-27  515  	return -EINVAL;
ca557d9df319fed Saeed Mahameed 2025-02-27  516  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


