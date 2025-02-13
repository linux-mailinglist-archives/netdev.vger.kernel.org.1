Return-Path: <netdev+bounces-166026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88121A33F67
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94673188B640
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485153C47B;
	Thu, 13 Feb 2025 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV/fqfcb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA8E33FE
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450721; cv=none; b=tXP7FLyifqR4rkY2Uz0tZip2/izMZnGnfFfm8ka61uTmSsikFMyQcRpHzAQNZ0Vmbk2uCoZfm3IxgPXfmJY4GDOjHOD1Vab7GYYIQN7dTGOhk/mb/5pt1c+hugcH+rrRj1YsHA2wsPC2Y6TPzcyvD3oL+/UdQ2o3rR2ZfkPtjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450721; c=relaxed/simple;
	bh=eOtzoHmgTpONSOg+OU2CS1jgA5e0c3BX00ardee6k4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjx6jVjcjiCrhWrYHS8bduLq+daxsKyBMTW7AjLMmpM8wtCecPPW1ZeAqaAbIMt85QobDFjH5lgLIZYgbZ5eq4VBCPsTeaxqaIXDEFLsWC2NrQ8gUOcnDwc3ArDruuoj2Tkv8RaKixfdTh4zlByvMkWuLs6QKTJC2IviEmrtVfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV/fqfcb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f818a980cso11503875ad.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 04:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739450719; x=1740055519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a76iZQlqnM4e9UNOjC3LdRnY6h/+ohu6heGEqnGPQLs=;
        b=bV/fqfcbrUsjrOTwNGu0RttTwFq+CZPB/7DfbD90k8xWkdkRLjWd5kOPyoxBOFvqQY
         TjT6dOgh/21ki4wYkPFVnQP5yZXnrTdBkffklXhTlqfHKzoObgI+Nkx7MlovbrgezyDb
         h6XjcxRE/S3gO+QEpWGnzulVd6C8aSsmTOGvXX2U2MgDvPkj6HLMqMXfkHnCpLxNeIMr
         wovowNTkSxZUeNez0nBCNPyoeroBA/DH2rPovsxjaFv75oq0yo/4kEUtpH9Fn3bjHNJz
         moCtRukoPATAAYDOmwL5S17HCE3f7YcgJwEcRvCppj0B/zRN/UjRYtD1IwIrNPmxKosQ
         19UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739450719; x=1740055519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a76iZQlqnM4e9UNOjC3LdRnY6h/+ohu6heGEqnGPQLs=;
        b=BsbZdsYMZjiZeEPIhtOUYg9P/ggPjrQ+MO16zm1dfGnaEzPxQpUl3N7rBwoiKVPv5B
         gEmV0c1rvK53d9ANB8qo2NfGB393YVds0fzNuStpKpij5OMraM2GQs2rDXkwepOMRh+d
         QPwUN5/0fP8K5x0SvlDuQCjtyC2UqAB2hGRCUAq9xwk77RP7BUqLOxzgfRESPcW0W142
         9dgdqMdJ2ldWXD6h6ODYnz4g09hW4WfRvtU2NjPw85YCYGqrZrvHm61uVng2qcuvzjxM
         bHx31UPabTJeErt+2/SGRHEyqQ6mhl9KK9F+Wmj5KagWR6AFpqPvBkJID4Qtnyiz32IE
         wziQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0fRCPLRxWbiHvBkNWaaDYw1om0zD8nmY7dk7uI/AmgWXopoQjJ+slf1GndHBqMQzcNj+Utts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEDO37dwZhfbo5cshjhEFw4YJfpE8SuWNpLM4qxW77AKovamRO
	R7M+KLxr+LV+3Hr3GFzFcfbLeYRV2fT5464ZIPlnZZrbr4lfxpEJ
X-Gm-Gg: ASbGncu3Yg8XNndk1BFDk7IPykcJ8z4odVgMbJfiVMX3u20CLPBluxXfZK/RX0L2dax
	euoHlyjvY6yLkWbu0QEyLt/QUK9JCUzv77sojet7IkFZ4dZ74SyBiiBFir5MG+fg6r6lONyPCUu
	AOS83qefYtqdEbT9l+RbH0CgutkvM18lrawwLkcpA7Hsx741bd3H3zuUOji2uNsOD1hUlY8AUCL
	76fi88lRUDz7GvvYNZKuI0P+iBdNHHtqUbI8L0WmNmq5P5IXo9730ooHsHxRMA9jfNfzkdnsFXh
	ZWdou46xSrW6oPtoOLOwx5FwHUNTo5dYguw=
X-Google-Smtp-Source: AGHT+IFedsMxw19lXJ8KHLVCCEe+tGL50He0RoYVH2rymQmCoTJrmpV9+pwjKlP+bv/UD5pEGad9Ug==
X-Received: by 2002:a05:6a00:188c:b0:732:2269:a15c with SMTP id d2e1a72fcca58-7322c43451amr11372781b3a.20.1739450718959;
        Thu, 13 Feb 2025 04:45:18 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568a9esm1188189b3a.45.2025.02.13.04.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 04:45:18 -0800 (PST)
Date: Thu, 13 Feb 2025 04:45:16 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux@armlinux.org.uk, horms@kernel.org, jacob.e.keller@intel.com,
	netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v6 1/4] net: wangxun: Add support for PTP clock
Message-ID: <Z63pXJKUNJqZlwdu@hoboy.vegasvil.org>
References: <20250208031348.4368-1-jiawenwu@trustnetic.com>
 <20250208031348.4368-2-jiawenwu@trustnetic.com>
 <20250211160706.15eb0d2a@kernel.org>
 <03a901db7d22$24628cc0$6d27a640$@trustnetic.com>
 <20250212181744.606e5193@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212181744.606e5193@kernel.org>

On Wed, Feb 12, 2025 at 06:17:44PM -0800, Jakub Kicinski wrote:

> Give it a go, I think it will work better when machine is heavily
> loaded and workqueues get blasted with other work items. But not
> a hard requirement if it's difficult to get right.

"work" items are essentially uncontrollable.  They should be avoided
if you need any kind of QoS for work being done.

Thanks,
Richard

