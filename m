Return-Path: <netdev+bounces-114134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DE09411AB
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529301C2106E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A0198850;
	Tue, 30 Jul 2024 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="If4ER82B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFAA1957F0
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341914; cv=none; b=QxQz+RWEvF66bLh9LXhsNWPOHZki3lJbP4OAmHFBU8tYDjSFsXRw3h2ciNEBj+wrst2VmPsBlQBAvr+kwJVJn6JtDSI2JJuNIaZgcOmdLK7HwFLY8roq/bHADYJc3XziowsuG1Le2+1D13UHMWfPjJmkwUIYMFC7jTXjcuYUbco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341914; c=relaxed/simple;
	bh=o7NO9zXqOyRqftVAozlTkm8jTlopScBcFjpHip03dLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgjC1FvzgXbvxi0ZXd7KxvrPz5apziE5wqt0GM5hb64NQEhZ5jSzbrf12ecaOTZLo8msI/hXbbdsUdONBb02HliN9PVD3/rf/oAK0e1mROMrauijJ2LB3dXVW38awUcGPfa9xJ0rQDwhh4Av3Bd72bbEBcJccsYun6TxV/F/jOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=If4ER82B; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso52537451fa.3
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 05:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722341909; x=1722946709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o7NO9zXqOyRqftVAozlTkm8jTlopScBcFjpHip03dLg=;
        b=If4ER82B6ZjFTpXShD5Pa+MjFQfE+4smw3JzwWaYY/Wnnc8l1ZM4qRv+Myprv7qeNl
         Znv5cKra1pmgCZGoxjJV6mOBi1kzHhLR0JM43MoroD2pw/BXjdOol9PeMiOMHE9vCq/A
         ZC4uxMhEBOJ/+kJtWdfsq+9XuotnyP1SwKTo1AkcNS0ukBv+1FzMnNsZeOfiFkxKjsk3
         7pCNvObKA7xdwYHT7rumLt1PBbcohZQ1CkufbI6GFLGB1eyOE4tV5wVZeQUy+dfEvK8h
         QKNkG6A29NF9V77O8XtOQtdy071ALzbotdV2Dhx+u9To665MZlg3JZcRzelWuxmINaxn
         rUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722341909; x=1722946709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7NO9zXqOyRqftVAozlTkm8jTlopScBcFjpHip03dLg=;
        b=b07YOMwmOBC3srq515tTvuQzlw0XueCiY2Si2IKwbJvv1giGQYx3A5ZpiLb3yKdS4g
         2nuj6GhCdKGuH9lzwSbcNNGJMRLJ8zmCHRuePWv6e9vzIcmuljsC/G91RKhey7rHsP+2
         ad6UHsEjTg9fQowNGNVaBwZ2sDOLxPwt8id2r7HjgHqN1lHHPj4m7zKw6bpy5ZjESMkv
         CNUWL71ZWk3xZKDUBbW9lBb8SS5lXwUI3r7CkhahdaerhYfTds0XlMrMo2/NtjcfS+vP
         Xj+CIsInkr5koVNG8Ha2jg4IWS5ivcmLluT+GlKEYHikq4W4q0tEWUzwznKYGEzUBoKl
         Sj4Q==
X-Gm-Message-State: AOJu0Yxh4tCq2wS0HecpOEg/32iBBGtXOLjSlCQhYqBUrWhLIVnRuHf/
	C9dlKBGeWGXnkh8kyfRpM9USXxpoBOxIbAd3IkR/beZymRHCf+j8aKxNfMtOgw8=
X-Google-Smtp-Source: AGHT+IG+dpu7EjrahfelYBuqGaPntrq7DoBOdLFJPM69rtKjoD5HMPyKDdxR3Ao+EGXYF5cjVFYaiA==
X-Received: by 2002:a2e:924c:0:b0:2f0:1a19:f3f3 with SMTP id 38308e7fff4ca-2f12ee4229fmr76173011fa.33.1722341908747;
        Tue, 30 Jul 2024 05:18:28 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b10849ebd4sm4350109a12.39.2024.07.30.05.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:18:28 -0700 (PDT)
Date: Tue, 30 Jul 2024 14:18:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <ZqjaEyV-YeAH-87D@nanopsycho.orion>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>

Wed, May 08, 2024 at 10:20:51PM CEST, pabeni@redhat.com wrote:


>+ * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs devices.

This is interesting. Do you mean you can put a shaper on a specific VF
queue from hypervisor? I was thinking about it recently, I have some
concerns.

In general a nic user expects all queues to behave in the same way,
unless he does some sort of configuration (dcb for example).
VF (the VM side) is not different, it's also a nic.

If you allow the hypervisor to configure shapers on specifig VF queues,
you are breaking VM's user expectation. He did not configure any
different queue treating, yet they are treated differently.

Is that okay? What do you think?

