Return-Path: <netdev+bounces-118711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C37952876
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181C128266B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 04:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0175E2576F;
	Thu, 15 Aug 2024 04:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ4l9mIS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF942F30
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 04:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723695381; cv=none; b=fb985B42o7gsW2bMd5n6vhjNQQV295sweRVLsrRIMhN1WBj8Xb6HoN/CwT/ml+9iYUvfWgqymHEEdasYLGx0U4RqvWAL3sTP3fZAJ6SDSUXIeoHfTTfdwZJDXjXJ197LSvBaJ9R9v1S7QV+sZaSdRcAecJPkDVslLKj+lsfQ1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723695381; c=relaxed/simple;
	bh=gTt/+Ayb9WplNm8QnWzGyFm3+hZq4T3lROh35523lis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itiW2dAS8r4eJOVXm/oXW4spzi8cp1dp7d+2l/s9j2SUSqXG7c0YQWGd6RY4FUhkZBMdoVFcom8jmu02pOS1apmOd3PhfejsdorlDmhGSsC1VmbzDWWVczJci39FmiLSn1BMzoNrrx/DbRDnjhvOvO9mWFcMdCQ2RhZhX89FA7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQ4l9mIS; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb80633dcfso78269a91.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 21:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723695380; x=1724300180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYqJIU8toLDO8QFfuGnWt/0lWF7rEmFz2WYnc7Sx+j4=;
        b=ZQ4l9mISNjYRha7UExmXTSxrdM8H0Y1bAR6eXIuLk7I6bFEWYpnu7+hU6gyPVQWniL
         GBxw1c8ypY0kuYY31VrZQUU0A0QDRHdSw8BlbrFJntioTW68oMqilQZPbrl9PWj1kHUg
         Bo8Plf58xbnj1xZj64zRu35SZGmKNV42IyNid7MllUwz2/20N+S630FblaTX+S+b0KDV
         LB05Dln2lWLv97xlFYZIgzRIc1fB93F0QHBpBOrdLRffZmc+cK/hGqkEaYlixbdJpta/
         SebsNBL467dYT1z6yxgPtuiB5Pjg/IO3xzWh213k7zipZg6lI0RmjZUARqWvDTn8Cnbf
         7PQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723695380; x=1724300180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYqJIU8toLDO8QFfuGnWt/0lWF7rEmFz2WYnc7Sx+j4=;
        b=iGGGlfI/W7ZUDh3EV2rs8tDuam5Svp14OxxD3eSSrEQp8lNCZROG3p809UiRYkf8pp
         xBszpnxjCF1PLQIuLsN3A2a/CLZ6Hz9Qbmou1RhJovR9PN+H0J9gIloY49faZlcBPCsw
         0a12G5d77pxV+Hw9GHLh5Y9CBSjiqGPIcetcavufCA4tQZORVxjr/CfS2lRIXUIWInPY
         6HpujbJGfJpC6Bwnz6lT8oahUGGhPvxEQc14WW4Ow9N1CYTeWeZvgbPhWHH3ZmNW9YKv
         U9IAD1cHu1o3ijsiNf3Fy9a2M/ty1avwbiSbQSw3xPBaOUzMofAED3ST2jpJ88iRUKoj
         FVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6LbQbTEeascDoXXpdzJ0DH90iJp28nUFMunwtxDEwloy+ljimp9YtY3eJDa1RgaII4rtCjYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbFv5Pc06Ljxn6FjYc9djUWIgWggXQPidK+alSzZ+GTsdCSklx
	RS9zIIdpvAaIfXfv0GaMjpwzreDF8VV6Igm0pwJ1Q99lbvfdb+Bd
X-Google-Smtp-Source: AGHT+IGQKKuCjg1TZTo1TTqsk664xB3n0UIdXs0cZp6NqLcKej2KishDb8xr+vHbejSIRoQBgNJZzg==
X-Received: by 2002:a17:902:f20a:b0:201:e4c9:5e95 with SMTP id d9443c01a7336-201e4c961dcmr19729375ad.5.1723695379597;
        Wed, 14 Aug 2024 21:16:19 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038b4a5sm3656875ad.217.2024.08.14.21.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 21:16:19 -0700 (PDT)
Date: Wed, 14 Aug 2024 21:16:12 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Maciek Machnikowski <maciek@machnikowski.net>,
	netdev@vger.kernel.org, jacob.e.keller@intel.com,
	darinzon@amazon.com, kuba@kernel.org
Subject: Re: [RFC 0/3] ptp: Add esterror support
Message-ID: <Zr2BDLnmIHCrceze@hoboy.vegasvil.org>
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
 <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
 <Zr13BpeT1on0k7TN@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr13BpeT1on0k7TN@hoboy.vegasvil.org>

On Wed, Aug 14, 2024 at 08:33:26PM -0700, Richard Cochran wrote:
> On Wed, Aug 14, 2024 at 03:08:07PM +0200, Andrew Lunn wrote:
> 
> > So the driver itself does not know its own error? It has to be told
> > it, so it can report it back to user space. Then why bother, just put
> > it directly into the ptp4l configuration file?
> 
> This way my first reaction as well.

Actually, looking at the NTP code, we have:

void process_adjtimex_modes(const struct __kernel_timex *txc,)
{
	...
	if (txc->modes & ADJ_ESTERROR)
		time_esterror = txc->esterror;
	...
}

So I guess PHCs should also support setting this from user space?

adding CC: Miroslav

At least it would be consistent.


Thanks,
Richard

