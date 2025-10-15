Return-Path: <netdev+bounces-229576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B8CBDE755
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB843C3C42
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03AC326D67;
	Wed, 15 Oct 2025 12:26:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED5326D45
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531185; cv=none; b=aotLo9v3vN61TXXku8s+eHH6FUHocGyJjBjTUBzEeFjmgnpOFEZYWkae12TFkOaIh3JXYcgbkLI583Ikasw6njrhDTumlA4rJHwTStE8B854tuBrFTZ4E+NK0O/l6XXJARInf5vbSzWUPm5GeHoSn396DMjWictUf4jvSPBJW4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531185; c=relaxed/simple;
	bh=IMfcknDJB0UOHWZ7tIIMN5Yxi04OQoJ/I4+6wpNumKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7924LWvJzijlBJOF4mO8regHKBtsNIzQV/ebkUbmq+fS1pCJ6bVCpZN+PMC3IdizhYbdmnC1kVg/eo+KYFQ32l9sDtfhDflPignIMr7JAg+DEn1Bo+E4vQI0i8x3vpNhlTosKT7R11VlU+z8Ol74vwwq+bh8boZuoCVitc+UWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b50206773adso167057066b.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 05:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760531182; x=1761135982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRloKA8na02gpFAHevugN2xsMZ26S2/fWI8LdYKdlfE=;
        b=DPJYWJj3eSCTE/BSG8s2eviqqIwOqNE7B4HFn4OWA3j8AorDIAAxQFKzBkfVd1oiNi
         kRW0YdDuJHl3H+Q6KnkPyzbPszmIHTO+iqMCn06X7rsh9P8MtVzb3IXkUQYW8Vn8SD0U
         a07gZ3X5QI9XFf4szdGQOSd/Kx5smmXt+piQSm/HfQ133x3PfxPgtGjTAyMW/2JfyXxL
         0aKJO4DwodaJMeGpsP9ptDnprjWygGnz8csq5wLZC6eydcda8XvlyemS8TNKfEXV07D7
         lqypOJV6lAZhfoJERq9co2QgspeUkbDPBJ6nUE50qKb1XXae1Orkj0g1KCQg3gjWwaFV
         najw==
X-Forwarded-Encrypted: i=1; AJvYcCW4D9obTSwIBQXgHGl1uTMwD/7UphXK+nyzmuHzQJcYq06ehYKHsCTXTlcSTS3+Uy2gueO0HWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKxuTr25RzuHTVUeFWrxD53dDvpxlLnkjdBvMM4FxFVoRcQRK3
	v/vc3+7aAkcRNz8k7mezllNSf9/8WFoPs47ov+JHwCfATBmGS/wUVxJB
X-Gm-Gg: ASbGnctfimrSI8Iq9P+zswifbCW8d0TSgsIh8jMjz3RK+sNtbzR5jikB4MDrx15a7my
	9eSrm7piT0SA9ryiczvhdZ9f0s9Eq8VdIeau6H8rteKRkF6Xgc6uHlJsI8/WUmqakfb2MAOxPhy
	e4Cyz3vJQmUJx9P4SPFutIGgsJ4WPGpNLcIqcMlTeklfxAvs7ZM6gxqFVg8MF9WMOFNsfQrwWsw
	u8DMBZQikA+HCf4X6T6tbbTPTQmsPuZEXZVBoHR/OkyueY4X6aXbdMZXmIVyaSq6VgeFXw5xWzb
	5SSKJDUSYLzO36XoAvrxKL1xi7r0MmxzHWPVVvXP95+G0UK90J1fll3zpLxJ70/+t1JHJyWLq1A
	HTmiiro6HyM/q8fLtyhg4SZMD+oq++6jz41mcvJYdVXXMqw==
X-Google-Smtp-Source: AGHT+IEKCls9xRmVQxWCii9c//rw4jMsCwS1BlylPp9rfyCq4x4yoDzUiZV0Ig28KMI39hpJ+AZieg==
X-Received: by 2002:a17:906:4fc7:b0:b4a:e7c9:84c1 with SMTP id a640c23a62f3a-b50bcc1ad08mr3305454166b.7.1760531181849;
        Wed, 15 Oct 2025 05:26:21 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5fd784022dsm79184266b.14.2025.10.15.05.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 05:26:21 -0700 (PDT)
Date: Wed, 15 Oct 2025 05:26:19 -0700
From: Breno Leitao <leitao@debian.org>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: saeedm@nvidia.com, itayavr@nvidia.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dcostantino@meta.com, kuba@kernel.org
Subject: Re: mlx5: CX7: fw_tracer: crash at mlx5_tracer_print_trace()
Message-ID: <uhlgxrlphs6cufrbm7mkp3nmtkrvhtoxbgd6rt7uojogfrbdoc@4mgzpab3dv3a>
References: <hanz6rzrb2bqbplryjrakvkbmv4y5jlmtthnvi3thg5slqvelp@t3s3erottr6s>
 <e9abc694-27f2-4064-873c-76859573a921@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9abc694-27f2-4064-873c-76859573a921@nvidia.com>

Hello Moshe,

On Wed, Oct 15, 2025 at 12:13:29PM +0300, Moshe Shemesh wrote:
> On 10/9/2025 3:42 PM, Breno Leitao wrote:
> >
> > My understanding that we are printf %s with params[0], which is 557514328 (aka
> > 0x213afe58). So, sprintf is trying to access the content of 0x213afe58, which
> > is invalid, and crash.
> > 
> > Is this a known issue?
> 
> Not a known issue, not expected, thanks for reporting.
> We will send patch to protect from such crash.

Thanks. how do you plan to protect it? I understand that the string is
coming from the firmware and the kernel is just using it in snprintf. Is
it right?

> Please send FW version it was detected on.

`ethtool -i` outputs:
	firmware-version: 28.44.2506 (FB_0000000030)

Thanks for your answer,
--breno

