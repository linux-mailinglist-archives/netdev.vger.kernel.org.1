Return-Path: <netdev+bounces-138976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849819AF911
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 07:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F75B220B8
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2D18C930;
	Fri, 25 Oct 2024 05:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzLwX3A4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF251E492;
	Fri, 25 Oct 2024 05:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729832781; cv=none; b=F8MM2PhJu15FRukri6km+awbDgaRi4tN5R0FbReufBn4D0xrE6OVyY5qoDH0BpzgcMq7hqQx30rYNeORXO/9+8uTxzonQ0HFEEqZhJwF0Ky2qsJZI2DQGCSmrBG1Aswt8eaBL1H72JI3P1ozgz/JVGVC7t+BHuY8gRtw9yD1RkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729832781; c=relaxed/simple;
	bh=G0TW1MHX9q3O94Z9uB5GhQ/gVEMlXD7XcVH1NUUhal8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W43H/NEcO2an/v7Hp7IQG+x52X5ROX53jRrrociLuFfPuEig5uY+PbyFKqtaBAkyPT/HP/yGnhjLzAHv/BibquHeh3iUdmmHCqiNLIm8VtLZlJjmcX83N8WVVgjq1i6rOpxdfxjt07yZkwLqK8NCRe0g/4nMVdWrFim1q2WQLQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzLwX3A4; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a4e40a1d7eso2244965ab.1;
        Thu, 24 Oct 2024 22:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729832778; x=1730437578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lrrFN+mHZMwxcP5FxfkCqubko9uzPwGKW+YiwvO7WRE=;
        b=RzLwX3A4GhHLRQl42FG1ypSIB5NqIHgWpZ6C3ElJSTNhvH19948Yu1XQuM5cG/Sx2c
         FYuRiFLiGDYgUcUlB/tQmVhYH3V1HMvurkVRzen0dHLWBB3JeqO2LHrngRZX0M6+o7f9
         wo5IZ1FQbHxCz0BGzpqhcrbD4gMR4NBQAGZ+ht5CjfO8OMPEkoumtQmQUPfEyM44juDn
         Dqi0If4yFUjVpp39gPbMr2tlUjnsTDffP1mZX9nUvN6WDc0tFbRzq1+HnHpWuZjAZvAV
         kMo8TCIV67sgR+mqFmkxBuz06tX9u0Sdad9dXJgIFH8MrKls6dGDWYMXPLtyhVX1miJC
         7nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729832778; x=1730437578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrrFN+mHZMwxcP5FxfkCqubko9uzPwGKW+YiwvO7WRE=;
        b=J9SPjHk9gXhkOxoJar+epMM82t6QE5Yhbw0ymJT5hKMqUea+CwuWi58CmERfzKGXA9
         S03g8GPuWaf8al1HaG/ggZiwIla+n3KgGuDBW0qpO0C05PzZUwdlyzSFq4pFILxu6RO1
         Ifgrq/kGtAsrQM4gX4MmJpIn9YVNGytRT+WJCtAzy88+dbgGXSMY6AkGulNfRXCzFUpo
         DK0CGpnIuZeFSLFF45ooQjni1bwczhjPg0nn25MdMWHCx9XSoRpIhQ8/2tlrJOrN0XSq
         UrwdMzLm8HVvjCFKuxgAiAC/9vzwuJCHJ48stEO3clVd2ZpzcgOmTXB/+cqHgsAJU97+
         /g0w==
X-Forwarded-Encrypted: i=1; AJvYcCU4Lgh5BkouvpWquc86Hp4vhht3Q7mp7fsdQhRHK2b8ZwpTztCeENlPDrN6ygCm5OVo62W5yM2QXVSuiH8D@vger.kernel.org, AJvYcCWCeZestfg5iSwOBPtvBRHZL7fjLKr2DDPpop0T1TlQSBY9c0CLWIlxwsVWPnsOHQZ4EyN1yeTb@vger.kernel.org, AJvYcCX8Y25SYcE4wNTPGCZXEzSyVeNlqlm4ifWy+Jzx0czo0h3rA81bcQUKhK9GiBa/NUASd9McyR0Y0jQ0EYDUKMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5kDAp69HoSG8oyStL6UvtUy/0eHNhaorNmu/fdDiqn16g8My
	O+bYt9KzrnZmXLh4m/OwKL1WmJvm/UhnYtIlFFolmAIjHjI/smjD
X-Google-Smtp-Source: AGHT+IG9eFw1S1NRd1I3j1OEIDPkFWdnUdNub1uGVLvjvjh+3FMVMCl9vW8ceP5nCaJkh4kCZkZGJg==
X-Received: by 2002:a05:6e02:b2a:b0:39d:2939:3076 with SMTP id e9e14a558f8ab-3a4d5a0431cmr97853315ab.25.1729832778418;
        Thu, 24 Oct 2024 22:06:18 -0700 (PDT)
Received: from Fantasy-Ubuntu ([2001:56a:7eb6:f700:63af:26f:9965:8909])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a72e92sm224534a12.92.2024.10.24.22.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 22:06:17 -0700 (PDT)
Date: Thu, 24 Oct 2024 23:06:15 -0600
From: Johnny Park <pjohnny0508@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: horms@kernel.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, pmenzel@molgen.mpg.de
Subject: Re: [PATCH v3] [net-next] igb: Fix 2 typos in comments in igb_main.c
Message-ID: <ZxsnR_fJ5aGKWJTq@Fantasy-Ubuntu>
References: <Zxne9hBl5E5VhKGm@Fantasy-Ubuntu>
 <91005d18-37c7-483b-bda5-2fa57a884a17@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91005d18-37c7-483b-bda5-2fa57a884a17@intel.com>

On Thu, Oct 24, 2024 at 10:41:25AM +0200, Przemek Kitszel wrote:
> On 10/24/24 07:45, Johnny Park wrote:
> you should collect Reviewed-by tags, as the one from Simon on v2.
Sorry, I wasn't aware of that rule. For future pathces I'll include reviewed/acked tags.

> for future Intel Ethernet drivers series, please target them to IWL
> (net-next in the Subject becomes iwl-next)
Sorry again, from the other patchworks https://patchwork.ozlabs.org/project/intel-wired-lan/list/ I should have noticed that pattern.  
> >   	ring = q_vector->ring;
> > -	/* intialize ITR */
> > +	/* initialize ITR */
> >   	if (rxr_count) {
> >   		/* rx or rx/tx vector */
> 
> Would be great to have capitalization errors fixed too, Rx, Tx, VF, not
> necessarily in this patch.
That sounds like a good idea, perhaps fixing those will be my next patch.
 
> to reduce traffic, I'm fine with this, to go via any tree:
> Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Thank you for the review!

Regards,
Johnny

