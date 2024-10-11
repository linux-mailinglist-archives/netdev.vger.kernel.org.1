Return-Path: <netdev+bounces-134560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6284D99A1FD
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 12:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6031C23132
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1A12141A6;
	Fri, 11 Oct 2024 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI49pF31"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5814B212F13
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643897; cv=none; b=YPQzQPxgb6zqcS9wZ6DewqejF2YrUnSqOlofItuw2t2uFr2g6VnG1DL9emFnaf35DzgAWe6jb54FZ6iRxbpTDmE1P47l76m714QkkpG1Q4pqT+eR9t04IdPvKFnpff6pvIKXeOIoccRk6O9W2TUpSUgTTKKbL4BTrEJg9bnWVHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643897; c=relaxed/simple;
	bh=e2z4/peJaVww8Tg9FLFIjg9ra9nDsolcR8MZMt4qk2o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=CmVzLIkyhdWlRbx9J1hl6td9Tdb2M8ybjdZ7EMLKkLvU1Q8qqiFxu2iENjWJt78icLLYzmsngdUJEavgs1/jI79vT4JQxiHnpJwwirfW9XanNZ7ByN7lYCe+zMHkUzyMhB7zBR1zIKmNyl3jBvQz/XzVonuikIc4aV4735M32u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI49pF31; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398a26b64fso1906133e87.3
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 03:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728643892; x=1729248692; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2z4/peJaVww8Tg9FLFIjg9ra9nDsolcR8MZMt4qk2o=;
        b=lI49pF31FvZJPU9Lva4nFw01app6NNSUMQMIjumYiEBJRacYxVb5mBHESZ5FfZ8qsT
         Z8QEhIZ6XbvZgmEy8lleDM8uc0u4KqprTprsC0mXXg4bvzLn6Z/36nmhLh/ecNGY6xNI
         6A1G99EBA0G6zL70qTqQQ5WACygE4vjCF6S1tJmKkAZDghkbFQZli6UjdaHVtSn7+YW/
         IAg1+O4xifg0VoSpNdn9DWEvvI7F8qMxDNd0WNtkW9Yo7utunl2QdbdPqs3vWOo4LVQ7
         l1uoR7Z1c5EmkvuLpQ+5YgF10/r7OlTpTf2GYw8uz7wm/WyMFMsypqP4e60jENw4Juf3
         05qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728643892; x=1729248692;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2z4/peJaVww8Tg9FLFIjg9ra9nDsolcR8MZMt4qk2o=;
        b=dSEkri4lPRMopXSykc4M8Gpf/HjtJK2c/gJ499WYpU5eqaouiDI38kc09IT6avHdlD
         r9tdSBnVbQ85OfqB5xIvDKz1VYoE5cu89If6xxqWlvZl18sQeb1wHoVCVTPig/7qBLtU
         44FDPl4evZAR71H4ygP4vgFSUluDn3LnHvei5rdwia2xWeLLwCYTIskx1sVnWMxrKdmD
         sQuWCmDz1KOGY1Xfpu3FxvqwW9e9aM/0Hr9ddHPR9VqLAAvZb5jtEdVecnzwJDY61O9Q
         3tLdjQopi4sbgW41BgGkGM6oTfTLcmQgo/61XxX8uYArcMFk7xTa1luIrzXM9IXj4Lyy
         p97A==
X-Gm-Message-State: AOJu0Yy5UeNRX8IzOX5RjiGr6mKAie3A6ZPqm0xgt4hmkdIeYfCWBS3b
	4cKWVt1JBCGAWj2QE2pKkcgWiPx/NssTlqH2LE532mi/8CQLVb1A
X-Google-Smtp-Source: AGHT+IGVN0vTvs9FzsdE+uqTLs0+8U363LVAIy25WlDYaObVLUXqUQVBXkSnHl97i1nYcfZmrdRpYA==
X-Received: by 2002:a05:6512:2807:b0:539:9527:3d59 with SMTP id 2adb3069b0e04-539da58b34cmr1284110e87.52.1728643892060;
        Fri, 11 Oct 2024 03:51:32 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:c9b8:df99:9ba5:b7d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f9a9sm3650808f8f.74.2024.10.11.03.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:51:31 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  vadim.fedorenko@linux.dev,
  arkadiusz.kubalewski@intel.com,  saeedm@nvidia.com,  leon@kernel.org,
  tariqt@nvidia.com
Subject: Re: [PATCH net-next v2 1/2] dpll: add clock quality level attribute
 and op
In-Reply-To: <20241010130646.399365-2-jiri@resnulli.us> (Jiri Pirko's message
	of "Thu, 10 Oct 2024 15:06:45 +0200")
Date: Fri, 11 Oct 2024 11:36:01 +0100
Message-ID: <m2cyk7ylim.fsf@gmail.com>
References: <20241010130646.399365-1-jiri@resnulli.us>
	<20241010130646.399365-2-jiri@resnulli.us>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiri Pirko <jiri@resnulli.us> writes:

> From: Jiri Pirko <jiri@nvidia.com>
>
> In order to allow driver expose quality level of the clock it is
> running, introduce a new netlink attr with enum to carry it to the
> userspace. Also, introduce an op the dpll netlink code calls into the
> driver to obtain the value.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

