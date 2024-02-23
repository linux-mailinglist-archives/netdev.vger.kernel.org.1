Return-Path: <netdev+bounces-74329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895AB860E91
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB621C24840
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C781D5D8EE;
	Fri, 23 Feb 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="G5PstWH5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F165D46D
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681506; cv=none; b=O+aa5St0i6mnXLUzBkFMokhm0bOuxgHpViRUU2DFlPx+pDbqkrcA+KBWcfMWAGg6Q8ZrZ7MPi59aEh5WDt9IK2gsJp+b0taWzbgjJDkjG1SnpmTPca5OsaqSUnubnlkiqNoef1TrNYW1uzik1AGu5+eNsXrnRtU/I5dhthYLSTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681506; c=relaxed/simple;
	bh=RqtsaE056Krnim8QDKYiai6V0prmbpjnfSDFqfueVIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8sOhukVQjivwBz2bSr65pHzcxLvA3R9c9bGo1rvdE4ULc7fEXqI1Wu6f3MRXArDSL1LtTQEgzWOv3a439kQAX/Ya3FvRdgN0QzzmmbmlvkKRinxLOhesUUH8jPjBD9SG7ia9FvGyzKW9/ooFX9BXNjIjAq40P3mqUrFTazgi+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=G5PstWH5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d8d5165dbso101915f8f.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 01:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708681503; x=1709286303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+nH1F52q4rLe3ymlUZMyRqVEVVMZkXwzmavUZRGEwv4=;
        b=G5PstWH59b5PaHlhyExmjmVqjjdcBLdm4VnkuvYwR8y8hKznjilKrBu2vGv2j5IHxu
         wL9mDgHthRgWac5HgbJ3yml+e/kBi2fZwxZ7/VJ0k+JWzqLSKAVwZNs6WRYsIErOfP3J
         B1v3rtDLJvilRxQqFmNDgl/HwVKnQfZRt3bRgu0zEAKTf2MVag8ZvGEm/6uRM/E0PA8j
         U4l1ZpHX0p/cnSPwAhz2iY/cJkYlaFCoWE6g3GSkKq+6FMWBNpP0NDE+RXdmRcMPq6qe
         sIlblTyClJpIDRW6zuyiCoztHvWv1UYZk4p7DkWppX74iv3/BEnMF2VkoW7NKcbUrcw9
         zZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708681503; x=1709286303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nH1F52q4rLe3ymlUZMyRqVEVVMZkXwzmavUZRGEwv4=;
        b=uGO5NFDSqoDtkrcHFcRYgSsotXMcMdiKa5JDlD2lpiFvvEPgXdgpFT6Y0voQEOpbrf
         ZaIDWDzohz/pPn9j9XbWAizaN77dDqgbbf26RtTAmPippfq+siLSMAaiOYKmEygPwmRx
         G0G1fZV7ydOWWGh8gkaCf2LWiQK1N4qoOi9gGSeTS9zh2rKJYy4so86TPF8j959PWmpe
         5bgzifTNLa8660sRgyUFggLworMg5n1kIZbSxkixJhr7Q93Gj55smtV3t53LPQpza4ve
         FgKYovlC/nPyZm8YbZHme4viQVJvs8VNwFxMz9VNu+PNXjbRHA9V6HUn6BFV7sEWlSzt
         2Syg==
X-Forwarded-Encrypted: i=1; AJvYcCXPCkB70w772C3oAz82IEQb7TFye/4BT2fKQlT436/5BEF3cm4RUOUhsxiRaqRbpMMiJl1PSAZwrvF8d4Hd91sbiY5HS68K
X-Gm-Message-State: AOJu0Yycb7YF7ytURYidGBcMCq521w+PTIj7itk7plHmU0r2I63I9l/F
	q6zTaTW339W7NbGQ8XrNRP1uBv0tfHGU8fBDHpiBaLl20Zu6AhWbc0zS7d5GrwY=
X-Google-Smtp-Source: AGHT+IEMYZMDyaCNjC5G1U1WTbH2JglqVVhiwwy0U9OE9LYAfJieqXydgfrrbq/8v5nS0XunwGDuQQ==
X-Received: by 2002:a5d:4e89:0:b0:33d:746b:f360 with SMTP id e9-20020a5d4e89000000b0033d746bf360mr956434wru.51.1708681503176;
        Fri, 23 Feb 2024 01:45:03 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id r5-20020adff105000000b003392206c808sm2139169wro.105.2024.02.23.01.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:45:02 -0800 (PST)
Date: Fri, 23 Feb 2024 10:45:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	horms@kernel.org, przemyslaw.kitszel@intel.com,
	Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
Message-ID: <ZdhpHSWIbcTE-LQh@nanopsycho>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
 <20240219100555.7220-5-mateusz.polchlopek@intel.com>
 <ZdNLkJm2qr1kZCis@nanopsycho>
 <20240221153805.20fbaf47@kernel.org>
 <df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
 <20240222150717.627209a9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222150717.627209a9@kernel.org>

Fri, Feb 23, 2024 at 12:07:17AM CET, kuba@kernel.org wrote:
>On Thu, 22 Feb 2024 14:25:21 +0100 Mateusz Polchlopek wrote:
>> >> This is kind of proprietary param similar to number of which were shot
>> >> down for mlx5 in past. Jakub?  
>> > 
>> > I remain somewhat confused about what this does.
>> > Specifically IIUC the problem is that the radix of each node is
>> > limited, so we need to start creating multi-layer hierarchies
>> > if we want a higher radix. Or in the "5-layer mode" the radix
>> > is automatically higher?  
>> 
>> Basically, switching from 9 to 5 layers topology allows us to have 512 
>> leaves instead of 8 leaves which improves performance. I will add this 
>> information to the commit message and Documentation too, when we get an 
>> ACK for devlink parameter.
>
>Sounds fine. Please update the doc to focus on the radix, rather than
>the layers. Layers are not so important to the user. And maybe give an
>example of things which won't be possible with 5-layer config.
>
>Jiri, I'm not aware of any other devices with this sort of trade off.
>We shouldn't add the param if either:
> - this can be changed dynamically as user instantiates rate limiters;
> - we know other devices have similar needs.
>If neither of those is true, param seems fine to me..

Where is this policy documented? If not, could you please? Let's make
this policy clear for now and for the future.

