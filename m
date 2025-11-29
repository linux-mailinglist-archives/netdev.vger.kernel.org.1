Return-Path: <netdev+bounces-242642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E5088C93508
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 01:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67CCD342293
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 00:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19915156661;
	Sat, 29 Nov 2025 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA4QZ0Ou"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E2145A05
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764376174; cv=none; b=hogOMFyzAmuhrZTe22VRTs68hs/cZAyINNCWgg6AVOclEjV9q4LrgeW+xLTeMmxWrRsNzBshF34ERNs98gxJ05gaLxnM86wngPCzRiV81kvUGgHAwSrt2J9d4yUnGlusbkYOVXQYMgJheSmTiXuBIJV8F1OdsRgkrzfObKz3PQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764376174; c=relaxed/simple;
	bh=Tr8CujLGw3YcAAfHxcNeLqxceVOmmXkvQt+W8ruQNyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kobch28YCwwyl6oJc+in7UU5PpS8aLSaBKI1zkN6wTtDzR/R5+TrzjAEiNDKSsA0kTSxGikqKNMKu9GLM156oxaQQDUDslwi3s4rAW7A+omTc91Q6wvW2OBerJ29ccE5H24yhcW7kskUt0SuNIBqAUbU6sv4Z6zvZKuGgwQy0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA4QZ0Ou; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-298144fb9bcso23505795ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 16:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764376172; x=1764980972; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yfPItJtxtVkepW3xvRirvbr5GNC9ailwlOfhV4ci5nY=;
        b=KA4QZ0Oukje1V0OuwcpfAXeqAQhPyQKBA9Jrhi9D28jTTXwQyf5YAeoBXA0/naN/KF
         PQs/eB1DrM7JsxXve1zNzpXqywgFqQ9UJGbybp/ZZ7izSIC6AspC6SUHzaVThvUnDAkD
         2TaSP4kZ+SJSGG5p8G3yWJpBB1R3ZOZ2C8fo3WxA09MEEIFZE9bjcHm+84Sf/4DnHDOH
         eQJ5m5XHA9duNOPJJhUDVVc2z7vkKsRgzMSBQrjMCEJMNzmQyNBASXVIVN6N/BbgT58Q
         ch8h+8DnDwtzYmOVjD7EAWSPBvAzTdeyC5VeW/R2DuHqWveNBUHIHfNSXCAOBAQtWkTB
         ggyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764376172; x=1764980972;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfPItJtxtVkepW3xvRirvbr5GNC9ailwlOfhV4ci5nY=;
        b=rlPkJ082ulPwQnQASlzNPQxCnZdbmf2oV4E0q6PT9wcQfXOmoO2iKq+uSsyfLt+6Us
         gj9OBY23RppEcVmz7552Rfa4nda+HUoVfOMybWlglgVyEY6qZFO58N/HaqNbU2ayYcVd
         WZai7ROEvdShnWM7R6nCfSmRk8+QsXColg5Y2v+jo0ArNRDbKCzjzWEQUNwq99fq3SfI
         HaoPKLhqe1xX0fDHcAIGLiO2wp9qKuGPfh6gKu1acn+RDFLAkfRMY+lV9NWJtuZM1upD
         fvtA0vRWuDRg0NddifXyVIp8CP0AbcO/7CmsU7MEbwtIXI4lytfOahkBUUAWneFTHfMf
         y7dA==
X-Forwarded-Encrypted: i=1; AJvYcCUPWAHN25QWuZa8cO9Ebpgdk9O7ikIvhTv6fiOOz1052skFAjFywbDZxUh3ACezY+Nf1AcXh+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaoYUNTiBNY7epH88u6R8tzzgMmf4xKjm/1zL/rn2cbWyqvqM5
	zUji+mw91ijMzib1WR7K00URglF9ONuQw4Y3g2onkHTumkVIFWx3yBza
X-Gm-Gg: ASbGncv5gVkUqKtqsToVYsvOY2dCX52bqo6A2LqdriRrzcfO9u4ey69Gfy/+SRHR0Ll
	yVA/Kl8AVRsvOIjVJHXfBFIWATRWcJ2uqCiHTfFBJvoMZ8ZxMyWbOEv1MQYOQTHjmjGFkJ32nyi
	l427FR4b4kvVo9/cLawincTDIQ1jjj8xO+SzZIJjEoMEbSTvCzprQOY4Riw3THIlPxy9Oc1FAK+
	yfurnJaudvI/+7Xk88IBkDZ8MmunCohi8mirfT74Gqe2vgD5Y71frIIOjaj5DE3lXVqriQ3qM9K
	s2Z7wb3jhg0TokbhgAFcWQYmKagPiu+XPOp6WPtPKeV6V0vE/17Jj1qYpRRBszApYKbHg7Pc23p
	8HtU0joow7u/pk9bxosKVZhw/FZcgE0qnMU58hqBlY+hQpjSP9cDy5jTlIOYZJtcM3ApuU5Nrm5
	Wh7zxIveU8vGrCs+EpDftE
X-Google-Smtp-Source: AGHT+IEC5WrdfCCJ76WXE69q/CZcRVcYqwwoI3WG0FVZXiWJi/ZKkiFT8vn5RGjP6UqALqB1iAfCkQ==
X-Received: by 2002:a05:7301:c8a:b0:2a4:6b6d:90ae with SMTP id 5a478bee46e88-2a941593b2emr7871175eec.9.1764376171735;
        Fri, 28 Nov 2025 16:29:31 -0800 (PST)
Received: from archlinux ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965ae9d06sm20924270eec.4.2025.11.28.16.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 16:29:30 -0800 (PST)
Date: Sat, 29 Nov 2025 00:29:22 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8 0/5] netconsole: support automatic target
 recovery
Message-ID: <htqwtsgxsffbjbccd62kzcdaa2uxezdtywudcrfghydym7axad@4j46eyxzvhte>
References: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
 <20251128161133.3397b20c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251128161133.3397b20c@kernel.org>

On Fri, Nov 28, 2025 at 04:11:33PM -0800, Jakub Kicinski wrote:
> On Fri, 28 Nov 2025 22:07:59 +0000 Andre Carvalho wrote:
> > This patchset introduces target resume capability to netconsole allowing
> > it to recover targets when underlying low-level interface comes back
> > online.
> 
> config hiding a build failure somewhere:
> 
> drivers/net/netconsole.c: In function ‘send_msg_store’:
> drivers/net/netconsole.c:1304:16: error: ‘struct netconsole_target’ has no member named ‘enabled’
>  1304 |         if (!nt->enabled)
>       |                ^~
> -- 
> pw-bot: cr

Hi Jakub,

Looks like it comes from Breno's patch [1] which was also part of the same testing branch.
Not sure how to proceed here, I suppose we would need to pick one of the series to apply
first and then respind the other one.

Thanks,

[1] https://lore.kernel.org/netdev/20251128-netconsole_send_msg-v1-2-8cca4bbce9bc@debian.org/

-- 
Andre Carvalho

