Return-Path: <netdev+bounces-73174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A457A85B3FA
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D726F1C236FE
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 07:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA86E5A4E2;
	Tue, 20 Feb 2024 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aA+SA4lY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90D5A4DE
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414103; cv=none; b=CA5cbDxNG8yu6C/c2p6Az1j/kCWMmc1AW4eIwIccptZesz1lyJOlQ9RnAKHuIL4GBfSfcLUvAs2HVpHzB+Ib4XM3+hUC/Ta/1E1Q6Xk1JcYhWVSuF7k5jg4TNaZMC6VhdJY7VEseD65QZcNH+BtUUJH/njLMnEHo+1gk9QSW210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414103; c=relaxed/simple;
	bh=QBT+F+XDubAN6hJsUKjyVdLjQrZJB9NORNepdQfTyY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHU/1rabXTYWkxt8F5lYwv+YTYogwH38fcejcSSzNKpfG+2WndIhphEzJbOZmMwDuKruv+3GttVBbKnrG3OcJ/COhJipGNgebUFj9Nywae4sRbkjK7PM47extAh8DsxQtUxKfzG7SgEdHOoahg2MgDccx89i+THCbcxjsnFuMEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aA+SA4lY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e3a09cd79so227902566b.3
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 23:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708414100; x=1709018900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBT+F+XDubAN6hJsUKjyVdLjQrZJB9NORNepdQfTyY0=;
        b=aA+SA4lYz/0p82OgPiWzrs+n3AMIykKiUlaLpspQhND7+RpojsK07npZ7nS+kj0EHM
         NZqTdjTTZS/n4u0VmX9kDNpcp4TRkNAMiuRjpxOmH6j8Bhj8pvPaLTKdCZK0c+4lT9wX
         Jw8o4/cjwl34Rt/Fwo5U4G0EOp7VYeWnFGNCQcNiPf+8bRolZWMcEdeTRBKfcF2x89fd
         iQ1XONJMAVCFkm5kF2mFeJ4GpqdCURHcjqUar/oWOdj0DcU3WnzNdrfcqq3RXA9Te1nh
         vXfAUTgdMCiQytSu4DhR1pGc36BZpmM1SiaBJSFYWvIFHYHE3HVBWD/bqvtG/JRr/ktn
         0K0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708414100; x=1709018900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBT+F+XDubAN6hJsUKjyVdLjQrZJB9NORNepdQfTyY0=;
        b=nbVlUXE41G0ZhrIdhH2a0mIJk4oqwHZGYdemlEc1lMQVmh9jG8cn1o4TkhTTlVjo7D
         Ho1AAQE3MRv4yYg2jAiDqGY1pW17X6GGfjRmSzC3CBJMSeumyWvRjpUlhzPWy+cH9qe+
         7lnqKGRR3bXObxIXqSCg1PBnPk1u2p/dp9LXRT2o2r/cAn/+ZveGQ0112wQ1W4ELZD7j
         Wtl38M5bJDDv6Dg6+3q650bQmC3ByiR+fdL/ievBQsybUpoWEJsoEB3MkvLfu34QSKkP
         KcgHVv5yJ3rjyA+cZvTbzD7bgxP6tyeYpH2JNq+h9+Ii2G0bRJqyvsrYvoj6L2vH98n+
         yVNg==
X-Gm-Message-State: AOJu0YxGnCcwehWmgh+nMnXCpTKe1pnfqs18r+cxNYIF2YPVTDr7leYG
	svDAnY90WZ/LaHvW9m2qRSWfs/Z/36w0yINRCLHk0fQoZOd5GF/FlmioOi2auxU=
X-Google-Smtp-Source: AGHT+IErGUqXQPhOpK0QueE6npEtpqScOcGzDFqV1k0zUJPZi6xnmzxNlA7bILNX+qCMdY5J6nm9Yw==
X-Received: by 2002:a17:906:694b:b0:a3d:590:195e with SMTP id c11-20020a170906694b00b00a3d0590195emr12713865ejs.4.1708414100578;
        Mon, 19 Feb 2024 23:28:20 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id gz7-20020a170906f2c700b00a3ebe808fe7sm1267504ejb.115.2024.02.19.23.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 23:28:20 -0800 (PST)
Date: Tue, 20 Feb 2024 08:28:17 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com, donald.hunter@gmail.com,
	sdf@google.com, lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 04/13] netlink: specs: allow sub-messages in
 genetlink-legacy
Message-ID: <ZdRUkXPuoM2-PWkB@nanopsycho>
References: <20240219172525.71406-1-jiri@resnulli.us>
 <20240219172525.71406-5-jiri@resnulli.us>
 <20240219125118.27eaf888@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219125118.27eaf888@kernel.org>

Mon, Feb 19, 2024 at 09:51:18PM CET, kuba@kernel.org wrote:
>On Mon, 19 Feb 2024 18:25:20 +0100 Jiri Pirko wrote:
>> Currently sub-messages are only supported in netlink-raw template.
>> To be able to utilize them in devlink spec, allow them in
>> genetlink-legacy as well.
>
>Why missing in the commit message.

Sure.


