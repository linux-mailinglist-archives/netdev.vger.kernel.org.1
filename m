Return-Path: <netdev+bounces-186176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3309A9D5F2
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343471BC6621
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B608A296145;
	Fri, 25 Apr 2025 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gbVzKjFy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B152957DB
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621710; cv=none; b=remsghSYp78IuD46fmNkan7USr/HqAWSvAwQoV+ZF80G4Kt7j91G/yH3/ozBHqpUYv7STPm46S+R0e8ug83GJkdXlTBEcKy7ZZAZB0S9XyfeiU2ZmDondLGfS0N+A96OMDnc4fFEGl8g7VzS+WNuFF9AaK44/xDEBnlupBTys4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621710; c=relaxed/simple;
	bh=5j8X1Lw29JLPt9xgwn5803X0uFEfTtiO5K2wh7TqQbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHVstnDquuZM8eqQ8g7bLHyO6dnZOHBArflRCTCU+lDgUugf4ZvAR94wkAicnoDBOT1tEV2Xeohhq+Iye+EsxGz3TIOdyrOhFy+qnFK0e0qIKpjdWX9QF7Imo4wg3UjWrvOwJ+j8FxSc8FW77cW6RXjoxMniMkLeN9MVnRbiL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gbVzKjFy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2255003f4c6so31986815ad.0
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745621708; x=1746226508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odWol/G2YntXBxFcl2FgScZA7hSxxrI6Ap9e4BCx4xw=;
        b=gbVzKjFyEbiNEu7jRgoL0QSS1durZo9KjHIX9PYzJQRp/5vl1FWGDz5zDK72ivqyRi
         DD2jZ7xlfNOt4Seipg+MVXCtreUZFvqtBlxSD3gmon6hcvVgaVWfIsbZAa02bj1BAyg5
         e5ClPj9kqDsMwPbJWzT5k3WixePSe4xSwkEcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745621708; x=1746226508;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odWol/G2YntXBxFcl2FgScZA7hSxxrI6Ap9e4BCx4xw=;
        b=rg1+qtlZFcIDGb5hjN3WtNEbQR9sX+rzGwg9teJtKYA69l28I+RYLyckJvCkH6Bh6X
         odV45X4SdrExkVWal5fm8oAyCwmAUrRKHORc6BzyzT/Ww+5wrwtxZpewrtl+ELesbHtn
         OeIe1l5AwVGxyPS++0UvCJbcjNHXGhnG6tmAodzhODzpL8movgvAWsgIIAU15VDIwheV
         TibJhF415AWOVWnZYOEZ0QFB+TTnvporS2uRDj4cjyCeqe7G0GUNjyTihpMTxXwqm10B
         U4O8522iioagL1ZlPfTOTAT0fW+ftRnXd65z4WmyBmng1b6QjeBpOI/37vI+ToOLAHmJ
         0ohQ==
X-Gm-Message-State: AOJu0YwZjkI8CvaDLSZhYvd7CKZx5nkrEeF5Hd5VMNHcIpF4HgAlGXSK
	yFaNhEucePQ9h/WivxzyAHae+YlI60U7gEkpfjN2FLZH52zbVvVkgCDNQ7HvXJY=
X-Gm-Gg: ASbGncvdw/XBxXW41hHxtqt/cNReZvAHPSvEiGTQmCxkphpuYWdzAxnXoALpqczSQzb
	tVISXxlMiXq8sHoSCbw+tPlXKHFQ21QBFygQrkfoJd00g8eFcAuhM0u/hvPUpchAA2nCr5o+A91
	DQoGZf7lYSC12yPfsRoX1ys0i2w57ypYitBzCIDCbqg3NpAhjFFlDoDKbBuyofmUT81S/ojmECG
	SLtYg4eRu0/ta+r1GQc/aWAMBtZrPEnJoaqojLqdl1FUrQ1iurzo59aVBpJRSuTAukvNvH7DcNT
	FND6kERGxHqc+IoVK6HW18w3HlTQhhzknLbP4gUFehk1Pem8YvYQ7L87/hZ0g8VpRsTU51aRUSY
	sn3CO3IZcXfHK
X-Google-Smtp-Source: AGHT+IEyQ1XtgzaFT3m5L27SJWp+PA5iNrgzJcZYVGCiSMOzTwtj8LRTvmZ6rrW7GC3SLhZzs+DHfQ==
X-Received: by 2002:a17:902:e805:b0:224:de2:7fd0 with SMTP id d9443c01a7336-22dbf5fc55dmr60610085ad.25.1745621708266;
        Fri, 25 Apr 2025 15:55:08 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76f8asm38187185ad.35.2025.04.25.15.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 15:55:07 -0700 (PDT)
Date: Fri, 25 Apr 2025 15:55:04 -0700
From: Joe Damato <jdamato@fastly.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 3/3] io_uring/zcrx: selftests: add test case
 for rss ctx
Message-ID: <aAwSyL-N9g5p1z9o@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250425022049.3474590-1-dw@davidwei.uk>
 <20250425022049.3474590-4-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425022049.3474590-4-dw@davidwei.uk>

On Thu, Apr 24, 2025 at 07:20:49PM -0700, David Wei wrote:
> RSS contexts are used to shard work across multiple queues for an
> application using io_uring zero copy receive. Add a test case checking
> that steering flows into an RSS context works.
> 
> Until I add multi-thread support to the selftest binary, this test case
> only has 1 queue in the RSS context.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  .../selftests/drivers/net/hw/iou-zcrx.py      | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> index 0b0b6a261159..48b3d27cf472 100755
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> @@ -21,12 +21,25 @@ def _get_combined_channels(cfg):
>      return int(values[1])
>  
>  
> +    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port 9999 action {chan}", host=cfg.remote).stdout
> +    rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1}"
> +    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 12840"

I wonder if perhaps future cleanup work might use rand_port from
lib.py instead of hardcoding 9999 ?

Reviewed-by: Joe Damato <jdamato@fastly.com>

