Return-Path: <netdev+bounces-208828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EC4B0D50A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 10:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86FF1C2468E
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C942D94B9;
	Tue, 22 Jul 2025 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pK9sxva6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D22D9497
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174548; cv=none; b=FMNcVQKIwT7JyxUEBqRY5hNEpU+c/kfyVxO8q5hGuXXBjycXEg/I9lx8k3xIQOWc1eELe5JSUV4GKjN1Mskvk0asIv4L2Ts+0J4rckRWlgvyCMFJAMLz4HfV74vIrZZvYq4wCMzBv1DlakChzyINGQDOOrSfSPI8rdeqHJLC6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174548; c=relaxed/simple;
	bh=RRE3fn45Tem1fb5Iwt6h6+mzcVKDCXxICiL/IKQ6JNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFPmTj2R/GIajVyyrfNBBEFD28A/fio/peWoskKOpq+ErFHkxtg61oqqVZ6oJgyVTY8K2v6fN+mO+C66LzcoDlcpu83UauHQAjFe7o0zC9fERMQkkP5kc/k0z4XqXdx+puljYTTbkunL4ut+KWROathsZZl5JgYHm4JkVnLRw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pK9sxva6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4555f89b236so51828245e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1753174543; x=1753779343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5sMMlMp4JYJW8EJKP9n/ji7lHZnH0vLWAeBXf2oueuw=;
        b=pK9sxva6aEQyGbzVy4i31COGXPw4A3GHyqJJLGPKrSVSlME+pRcCaipYqZxw5hjDjl
         4RlRqkr35XZDW6bhTXYQ/TyJppd4W2cBx7o/1pJTWc3XoiqREALO12LqdJ+Sm2zk6yB1
         jORbsO8TDsGNuS2W3i10WGA5fcefPkzkm8BCZezt0blZIJ+LbWClaYv8qrG5dhAnXKHp
         MpVIh170+i6HwGxFZg/Ko+Vq3YKbcA9HZb8fmTBC8bhmhhghA/zNNHgAk+9aHe8/qh5x
         phXvNEVhTpZPnTcCdXHEaoug1Zip8dlrQpWfztJq8xFIOJIU3Ipw2EvFSMQnIIH1ULqm
         33Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753174543; x=1753779343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sMMlMp4JYJW8EJKP9n/ji7lHZnH0vLWAeBXf2oueuw=;
        b=Ir68zS7y/RkJLKNLxEloMJukVLtiGc1QifdQL0CDWgLgtTjH3aP6E4E7hnhFuXK8ne
         6N0nBJMjFvCbHW1QNp1LakAMZGSABnO9nT/5bfGGYqGnEglvnm5XvdSjWclQj1SPwKgx
         BHRcaCIri1nLm14z085QUx8hCsF7nk24H99A8uWJfwNLTOq5yjiYGS+a1/0axFSz+XSP
         zFK6whol13u6skPmXulWuqwe2cyIwWUqUX70T68RNQtb3ocFGuyUavbpVWPF36lcmbQ1
         l6Mtj2T2Rght9pxP7Z1zBehaddOf7P8ArJlyLk/+H5w2NsK4UZR3ajavqicrj4zHWIVv
         loWw==
X-Gm-Message-State: AOJu0YzQa6jyrsPLvDmmxr9G71rxXWq8wunS1LBEd88Vk6pfWZSA3Ktp
	ZK/mgrIbKwSii2uCl+zue00AwP6LvdEkSSEzU+ghXwROtR0c8mbx4RCibwebVQnTuaI=
X-Gm-Gg: ASbGncveX0+aVHxTUK3zYJd2AzuIghF8YcWJHlv2/lWlCWUPqGt6ZLRbhWTDafR1V/L
	4eATVY+RyQAWBnV4dgoDe1hQziSUTwk1KbXysX2fP0GR+gtyvFn41OcvG4HG9kf+1A+xDln7vhP
	eoZei+tmvtyI+/H4BFtcaim4DivNJ8S2Q6xNqiSzKAhosePUXtZvbzQ4VdFm3R+UKFgF/C3sd8P
	ZqIy7a5oVdNVayX5KoIuj7Pj3500rH9uhDJPzPlayrvlQMtigoLLDObn+AAY2O6pIdcl+blMQSF
	FubPfo+7G/0tHYmVeg9nREEmMW2o0C8WPipuUSjcvMJL2+ZNdkXZssVnWLuo2T4meFcHwpJ7gkg
	0Jll1aYLhYq2JMCjz2zfVt0k+
X-Google-Smtp-Source: AGHT+IHSbiu4q2C7DfNvETi2xUZixI0qE1wL96GjzQIVLeL1MWMeH6tzBB7tM/+mA0doJK0QEdrKFg==
X-Received: by 2002:a05:600c:8b2e:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-45631f7bc87mr206111555e9.18.1753174542524;
        Tue, 22 Jul 2025 01:55:42 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48719sm12977189f8f.47.2025.07.22.01.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:55:42 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:55:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next v2] netdevsim: add couple of fw_update_flash_*
 debugfs knobs
Message-ID: <tthpdv4l52zql7ms6q7723tbpzlacbf5ryzsx3qj3mafrzslfg@5ltgsitmnxun>
References: <20250720212734.25605-1-jiri@resnulli.us>
 <20250721160457.407df671@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721160457.407df671@kernel.org>

Tue, Jul 22, 2025 at 01:04:57AM +0200, kuba@kernel.org wrote:
>On Sun, 20 Jul 2025 23:27:34 +0200 Jiri Pirko wrote:
>> Netdevsim emulates firmware update and it takes 5 seconds to complete.
>> For some usecases, this is too long and unnecessary. Allow user to
>> configure the time by exposing debugfs knobs to set flash size, chunk
>> size and chunk time.
>
>FWIW I also find the long delays annoying when running the test
>manually. But do we need knobs for all the constants? Maybe cut
>down the size to something more reasonable and expose just one
>knob to control the length of the msleep()?

Sure.

>-- 
>pw-bot: cr

