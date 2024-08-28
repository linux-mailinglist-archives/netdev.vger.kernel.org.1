Return-Path: <netdev+bounces-122630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E09961FE7
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 08:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5B6286085
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 06:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3A114E2C0;
	Wed, 28 Aug 2024 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="W9HgkuHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CD05A79B
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724827224; cv=none; b=qeyHjPdRUfdjU5TjAX46+mYQU7qcsDl012dol0ED6A7QEa44lYqZZYoDDT0gipPPhe3IRuyBbNQjVydkE1ht1ibyikchN6UBD+QMMqesPEye38/UupxBSCksgJllRvGuxmIJ5hdCqP1bzjYwafLP8PaRknP0L1HU/iLbc5lK+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724827224; c=relaxed/simple;
	bh=wnTKebm28g9pgSJT4p2bS/6XPWnEnxosH9QGV3MEap0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J258Ea3wM3xgdyyYyXRF6VwczPex53iplz9ArrFHH0XuO9ddDxCHRzxgUFP76a0/PXaPJRKggA4CW572F42WYtIk4EXTDTmBR1MFrLJvACUE/0ky8FDS5pN6XAYADh7GjhKfYGv2qxiTEbZDUxm/MywBtIQtHH3cmxV2vrnLej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=W9HgkuHZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so55499985e9.2
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 23:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724827217; x=1725432017; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tFYwIt/vYltZhhyshZXeGI+RU2+UIznLFStPDmRM/G4=;
        b=W9HgkuHZ2lGJsc5T1xb6zCyxErjIUfZvSuDb1wAayBf4nSN7Tu6sW8D4tIwB4iLTfb
         HR1rPCec3CsF6eEfxtCaXuOe5kRHj7gdIVGO4k6+lpiYpSuI8hJnptKjACkuSG6FDGsB
         13hl4y8x+4MXGW6bTK8bKAPMuwxT6sAwvOZNHG55ovwIkgz3dgh3wXk07xNyxjz+FAkG
         LllLtWun1j0gE1PvRXHF5apyrsFLfpZuKc0kPPj1Kz6XUix2gfdthQRMwcQ8f7r4mfJY
         0WD3ITn7q4vRYEci1YIj9k/aHO+eArNqTwEHtNhOmZ9ERdN6AzwBxUE2BjneOZrEOqtY
         c9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724827217; x=1725432017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFYwIt/vYltZhhyshZXeGI+RU2+UIznLFStPDmRM/G4=;
        b=IPXw5Y63a8A+HIzo68a4Qz3dS5OvtviUr36D0mafmovlUNB/u4EvDwS/lpvseCKWPu
         VsDzRnDJHbz0FxRnYz5Q7liiBiMYR4KZPWjJUCNVbYtYkYSea+Jg5wPRS/17f8sZejD4
         aF8pqgJR+xiGy0gADzDMxpesn9GfwVzqzIfAZcgPFIhCCUo2cJP2FR2aMge+xKeGeRdX
         kP63N0ZIZt3TncUgmYxN5jtHI3eyP4iwGDxQUg3ovdJyWKBPUK/rJ8nUaNtQzSvvkcQK
         U6IEkEnyap0WJjRMgKojqdPBBpstMIIcZ+1T/WPwCmlOT0KIBDhGnetNS5gcrweeOaXP
         G7sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE44pl/DIJ9Y38grKHIGemo8q5jzMhvkEIc4/wnqgqkjjkWk67aYlXZHfFCWh1c4/2qNag6tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu88cxkUTHSOPodv0LvwkrYFS0wwLHKGX0ho7XJ4u+e38oCtnH
	nN7ZOUAs+bHpoBHUwltEtJhsAV/VM/QeTd4hwk000fsZyK9Wv4N4yRdJtjo5I8A=
X-Google-Smtp-Source: AGHT+IEse35BHYKnVB5XO6/ta0KjGq2XY09MWZMOb1yiWWD67PmK8Z39qWCFPqmVxibNxrOy5x7ruA==
X-Received: by 2002:a05:600c:35cc:b0:426:60e4:c691 with SMTP id 5b1f17b1804b1-42acc8de777mr102147405e9.11.1724827216707;
        Tue, 27 Aug 2024 23:40:16 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63b1283sm10569505e9.30.2024.08.27.23.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 23:40:15 -0700 (PDT)
Date: Wed, 28 Aug 2024 08:40:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <Zs7GTlTWDPYWts64@nanopsycho.orion>
References: <Zsh3ecwUICabLyHV@nanopsycho.orion>
 <c7e0547b-a1e4-4e47-b7ec-010aa92fbc3a@redhat.com>
 <ZsiQSfTNr5G0MA58@nanopsycho.orion>
 <a15acdf5-a551-4fb2-9118-770c37b47be6@redhat.com>
 <ZsxLa0Ut7bWc0OmQ@nanopsycho.orion>
 <432f8531-cf4a-480c-84f7-61954c480e46@redhat.com>
 <20240827075406.34050de2@kernel.org>
 <CAF6piCL1CyLLVSG_jM2_EWH2ESGbNX4hHv35PjQvQh5cB19BnA@mail.gmail.com>
 <20240827140351.4e0c5445@kernel.org>
 <CAF6piC+O==5JgenRHSAGGAN0BQ-PsQyRtsObyk2xcfvhi9qEGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6piC+O==5JgenRHSAGGAN0BQ-PsQyRtsObyk2xcfvhi9qEGA@mail.gmail.com>

Tue, Aug 27, 2024 at 11:54:48PM CEST, pabeni@redhat.com wrote:
>On Tue, Aug 27, 2024 at 11:10 PM Jakub Kicinski <kuba@kernel.org> wrote:
>> Literally the only change I would have expected based on this branch of
>> the conversation is slight adjustment to the parameters to ops. Nothing
>> else. No netlink changes. Only core change would be to wrap the ops.
>
>FTR, the above is quite the opposite of my understanding of the whole
>conversation so far. If the whole delta under discussion is just that,
>we could make such a change at any given time (and I would strongly
>support the idea to make it only when the devlink bits will be ready)
>and its presence (or absence) will not block the net_device/devlink
>shaper callback consolidation in any way.
>
>I thought Jiri intended the whole core bits to be adapted to handle
>'binding' instead of net_device, to allow a more seamless plug of
>devlink.
>@Jiri: did I misread your words?

Yep that is correct. But you don't need the UAPI extension for that, as
UAPI for devlink rate already exists.

Regarding your shaper UAPI. I think that you just need to make sure it
is easily extendable by another binding in the future. The current
ifindex binding is fine for your shaper UAPI. Just have it in nest and
allow to extend by another attr later on.

Code speaks:

enum net_shaper_a_binding {
       NET_SHAPER_A_BINDING_IFINDEX = 1;
};

enum {
       NET_SHAPER_A_BINDING = 1, /*nested enum net_shaper_a_binding*/
       NET_SHAPER_A_.....
       ..................
       ..................
};


Later on we can easily extend the UAPI by: 

enum net_shaper_a_binding {
       NET_SHAPER_A_BINDING_IFINDEX = 1;
       NET_SHAPER_A_BINDING_DEVLINK_PORT;
}

Makes sense?

>
>Thanks,
>
>Paolo
>

