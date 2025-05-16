Return-Path: <netdev+bounces-191122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9162AABA230
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 19:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D016A0176D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E6921ADB9;
	Fri, 16 May 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS11WGz9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B391D5CED
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417844; cv=none; b=vCKVZgzYcE5NIwyVJj7fQ8/hDDZKZ9NMX7Btw5qKtY7fqUi1syQdT7CgjQsgB49cAD528CEmRQuJ0LRggCaPy847OXqlf7G2GyCLljQM1lrQfBBobXjJjJqrCLbgqHl5IHq3plrAOWxif5pKWdLyLdmv0VpuqasvFGk2dmig3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417844; c=relaxed/simple;
	bh=NdEi0mAxVYxac2R7t/wvw+LieqKCFd/4Oukr12k4Plo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+pr/zmJh/hpDj7a0nL2IrrI9MxK+/gp046BsXWeV0VTGv4qIwWyS/cZ4hCWir0Vza3E6AsGGml6UZr6akTdiyjQF8gN1AeLPNGOXTDAcShF+YGojjGH2/6xBX5unQZS0SaebRQn5qLsaHW1PVFxKhk2VHeDVmJeEDNk1IIive0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS11WGz9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e3b069f23so20702765ad.2
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747417842; x=1748022642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm7LWlhKV3X6JUwQSLeM2lT6t+tA2KHi6xe41UkyOZk=;
        b=PS11WGz9i3fRDS9FOphwP951KVu5tLLqjjGXzPpvxE6gFbLFk4Wo7tHPow+/7lzAzz
         oY8q9aOsY760CmXUDNnWu6RR0p7mZ2EgSGTzt7neiAzyghgbdcg2XymM1ttoIWwemMYX
         z0sOP96d+btXptVsEl721XSdUEXzZDX/A9X2lhio9TfYyw9xJJW0Rn0OX15serDjvrVb
         FCKFIDCFtYIPDHPQZZhBHMx0klkja7f7ajSuF7D7Q5nra9qq3VB8KWsuuQqH/5O5R7pi
         PZ+4mdJ//+oV9LqvaOyYl1JP7ru5oPHSP05e+idSequcq1OyQoN1MQFh9vsCjyB/d9+U
         UpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747417842; x=1748022642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm7LWlhKV3X6JUwQSLeM2lT6t+tA2KHi6xe41UkyOZk=;
        b=V89r+ssIeWuRo/Hx3sVBlx1frdnJDTW5oC9dSRGUmUw+e0F+rJToXycdNszsV/6bhP
         v+ygGmqoipbj0tRxT05Kps4d6O+glxu5mCqBZlAxnVlmk+HMul63Ef2mMBTTHt8Yn6WK
         c/gC875SODVeql4wofOloXzQLq+RHanFsihcuLVdg7KmWvWAAwYiCY91So6s8P2CkN/V
         0iIn/V08TI5bSokQ+18E7H4VQ0Q0Tc+DlD8+M41vvLxOr3gR6mww0BufkKO8DUgrJLyM
         wf6WC+pCE97Iym1RTEy8L1aCHCudF9BGFE9T4N4dgTGKN8n+/oOebzqAy/6BamoDnM4l
         usIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxdy1fETXJW+TctIqxr8ltyB5Uf53cK/IutRiJvbWzzduPhuluMqCbcAv6ZidslaOM2xcbOnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqTBg17zBs8dCZQ9JUp8pK0DFYnpFmgh+gkE3sALRWawLYxon7
	bChySulTVCw11/2k2N5iQVkR/Xcw13pwj4Svgat4EcrjKfQwcWHiJ+U=
X-Gm-Gg: ASbGncvl73wYBPo9eqqyr6tzRwwLR4nUGrqX7c5Yzsp+aSi9J+s5kwrH3YwPrXqhXrd
	AJuZK38GLI2fq2fy47MxirpxtmsJgibi6RvURfaQFeH89DLSbdytliJSra5jJENhzh0yczNo35a
	NC/hJ1cmEOqWDQIwpez74LVrEhkF7h5fBFWZYGQ5lFqXgw3K4hGY7R+5ve1EacP9u6EIfr9YreU
	BLLOWq7g8I1YOvQGDxT+fRGb44iQpbIT7QS+Ga4d6tUBwwYZvIbTjbPt64BMq8lr4AzjE6SARlM
	vZOSw3m7S/c0C56RykGpcKsnBHt4Qc795uGsxnaLFKb8hl8LlITDVKcGmdP6JHBcnRoXDZ9+gKd
	dFnyxc9E/IDSF
X-Google-Smtp-Source: AGHT+IHr5Ybh5ximYbfC1vDSTYU+8mCnWi8Slac7weAqzNw50+Ay4WQq1OJhe2qBS6WT+3MK8GCaeA==
X-Received: by 2002:a17:902:f551:b0:21f:71b4:d2aa with SMTP id d9443c01a7336-231de351542mr49603055ad.5.1747417841679;
        Fri, 16 May 2025 10:50:41 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4e977f6sm17072065ad.131.2025.05.16.10.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 10:50:40 -0700 (PDT)
Date: Fri, 16 May 2025 10:50:40 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me
Subject: Re: [PATCH net-next] net: let lockdep compare instance locks
Message-ID: <aCd68HA340VLNbHt@mini-arch>
References: <20250515193609.3da84ac3@kernel.org>
 <20250516030000.48858-1-kuniyu@amazon.com>
 <20250516082243.1befa6f4@kernel.org>
 <20250516101441.5ad5b722@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516101441.5ad5b722@kernel.org>

On 05/16, Jakub Kicinski wrote:
> On Fri, 16 May 2025 08:22:43 -0700 Jakub Kicinski wrote:
> > On Thu, 15 May 2025 19:59:41 -0700 Kuniyuki Iwashima wrote:
> > > > Is the thinking that once the big rtnl lock disappears in cleanup_net
> > > > the devices are safe to destroy without any locking because there can't
> > > > be any live users trying to access them?    
> > > 
> > > I hope yes, but removing VF via sysfs and removing netns might
> > > race and need some locking ?  
> > 
> > I think we should take the small lock around default_device_exit_net()
> > and then we'd be safe? Either a given VF gets moved to init_net first
> > or the sysfs gets to it and unregisters it safely in the old netns.
> 
> Thinking about it some more, we'll have to revisit this problem before
> removing the big lock, anyway. I'm leaning towards doing this for now:

+1

