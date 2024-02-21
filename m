Return-Path: <netdev+bounces-73709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090D985DFAF
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D67B2110C
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0718569D05;
	Wed, 21 Feb 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uw7cvGJs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8847F48
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525870; cv=none; b=Zb4NWhiQkvfEpQEVTIJ+NIZePqRl3zjrQdxpEyT94P3tFimTQ7HYIh33+3WxxenQpFCMNwPzyxnYerFDoF7A2LrWZsfdbcf+xIfacBcGUa1I7ulWhw1OirHl+tudLzFJqFeXLrsTYbW86+I/pdYYq7B3z9f86YnaEg/HCcs/sr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525870; c=relaxed/simple;
	bh=trEN1oPTJC/27UXXOnhDMxpVq7aAN7x1+MCSBss/x6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLYeuAKhZ8FH97l2crEZqZTq7mWQFyqgeAHQGgG78z4jx76mboEecIq4BTQAduze5DWPP6z9Dq7e2EqRwmKFFWkoobxOraD/YlCLzZTfk6o9R/c+ZFnAisYWMjOaMYpcsRQTUWP2iGvqnjzawLnzOF7RRN464vCbhaL6QBgRGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uw7cvGJs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41278553215so3563835e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 06:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708525867; x=1709130667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3s2Qix5YavRxw1qmptKQswyXBdWKakxoNrg/6UPRDU=;
        b=uw7cvGJsAClzBtg5/el/mNxhdGRwyQqxpPGGbJNbNR5tvky0sJkhcnHV7DV+J2iTDB
         pKgAXDGv5YrP30ATROzXHB7aO8x/LtsuxWhl89chkdYeQWy6C+THCaIGwyIb86ASqJc/
         AXqu3LdWleqGng8XJeJbiByIqETkz1lpGbm0MNl/EYObTxYd73squuoThCv+IIupB9pT
         7BG+R0b/pdYUZNtIOdkJloHRlscIBMszcRhGAu6rrLiza4KZ6p3ea3j0oiHchmr/le5v
         bRhXFYgLEdTYzJTgE6KXj6wojeWPMHIVbakTnRzruVsoKY1YtO7fgggEUDwZhaOCft0O
         Qw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708525867; x=1709130667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3s2Qix5YavRxw1qmptKQswyXBdWKakxoNrg/6UPRDU=;
        b=Vq7pHA3Cy0C0NysX2Cg+qKLfVXWZJ+KfwPZR2J4Nn8qmxmSNsyDs/R6yHqLqcAREVS
         3VX9nmTJ8zfdzmxABEg3uGziD9vJU/nLzleh6BPoj0li7IoVw494fjL7Ee4+5VnWljkR
         grZzbybWgGF1BTpeYsFqTHU/YT58oOawkuG74Gr+La2d5W5m71oZ0yGI7iIEqC6rIvm7
         F1nt+uk5bWMbgBJmq7P5wyigDQxpAWsHNNjyUCtvdchIG8MZ3lWfB4jkd2SBZS1F87YX
         nIdaWXz1ifqnDoMklGsDIZRT9Mq3SPZJ2wsJUjIRP261hiipWzxGCkpCQtbuhHC4w8IE
         Iasg==
X-Gm-Message-State: AOJu0YyBnEhE9/qEIJl11rIfbHvFpAQ3yO1iuhw1iCtY2aT+9hm4mH3w
	DuM93echL9phcbzCVGHUaHN01Rk7w/VqHCN64feztBLGYWzjB8ejOHsbO/dLQ9s=
X-Google-Smtp-Source: AGHT+IG3oZkAaE2rp8KQ1h+0HeNrAVSJHYOzcvh6xej7TQz23elzgriTnIbb2xhpr+0dbBsGRIG9/w==
X-Received: by 2002:a7b:c850:0:b0:40f:ed18:f74b with SMTP id c16-20020a7bc850000000b0040fed18f74bmr12789682wml.35.1708525867020;
        Wed, 21 Feb 2024 06:31:07 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c469100b004120b4c57c9sm18576589wmo.4.2024.02.21.06.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:31:06 -0800 (PST)
Date: Wed, 21 Feb 2024 15:31:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com, donald.hunter@gmail.com,
	sdf@google.com, lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 03/13] tools: ynl: allow user to pass enum
 string instead of scalar value
Message-ID: <ZdYJJ-1D2d71-Vz2@nanopsycho>
References: <20240219172525.71406-1-jiri@resnulli.us>
 <20240219172525.71406-4-jiri@resnulli.us>
 <20240219124914.4e43e531@kernel.org>
 <ZdRT2qb2ArAjaCWI@nanopsycho>
 <20240220175556.2a8a4ef9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220175556.2a8a4ef9@kernel.org>

Wed, Feb 21, 2024 at 02:55:56AM CET, kuba@kernel.org wrote:
>On Tue, 20 Feb 2024 08:25:14 +0100 Jiri Pirko wrote:
>> >It'd be cleaner to make it more symmetric with _decode_enum(), and call
>> >it _encode_enum().  
>> 
>> That is misleading name, as it does not have to be enum.
>
>It's a variant of a encode function using enum metadata.

Not really. "decode_enum()" is exactly that, it only works with enum
case. Here, the enum is optional. If user passes scalar directly or if
the attribute does not have "enum" defined, this has nothing to do with
enum. But, as you wish.

