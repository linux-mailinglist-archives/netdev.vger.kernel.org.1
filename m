Return-Path: <netdev+bounces-127213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E919797490D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 06:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9B2288242
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 04:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E2C40862;
	Wed, 11 Sep 2024 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0mi67UC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A893714287
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 04:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726028065; cv=none; b=kcqm7eqwa5Tdmi4S26ObOLenJx8tR4+fusiFm+2FvnR8QDxb20DdUsnbw8yKcdz8qTjjR6bvA1bI+PHRw5aR+qpWAeh6cXByHUXfkifYStboJu718ZPWehJ3VQekUhlnYVsEU/w0Q+uPMtyoI+EhEjpws4CKFjTyeQXZmtlP7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726028065; c=relaxed/simple;
	bh=RPStZsHG3cMsrPT7TcvcHhcuYIxgrJTGmtUA6lnirl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyQb8jj2p4PVx2YBfn7Pcau9RqQeyr87vXnJsoGCrtsAxxcrrxTOeygmn243w7tm6Q52HhmKXinkSbyhUEUy9lFHM7cnbbGlZn4CbOYXF6RVs0PbkIUKSLSSrfL3HpfNcWTCCUm2m+qyYCcsMlUwZ8iCKM1wY9MS5t91ahBoXzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0mi67UC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-205909af9b5so50107055ad.3
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 21:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726028063; x=1726632863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zo1Mz0mCibvDjuHMiLv6hWXuOi9Lehm9B8rJqA3HQI=;
        b=D0mi67UC5OpgFHs+ENaLnWHi64I6fTJh8zGUdOattHZfohSlFD8Z2QHBOVyW8DbcD0
         k7Xpbas27lDe4AlKrMqF2f32+xqw7ogxTKGio2ov5Pti72nEM++EuuHdhnTa5m1SSzfA
         wpMfaXu5KmsNoBfgz9+nATdmyl2fGOB7sQlUBYwalNUh0gVvvt5jiXFHjEnUUTgRuHrm
         2EBOftuExdXJrmpE9C82cgQoDeCFO6CzoPMbNz2JJR7VbgW7gBu6MOQ3BWgdFWDx6eV/
         fSqFE4jcpP42STcLOWt8h9kgFrRdQLK8ICcSAnTUbhP/xgqkyqb5hhpXqruHjbkeSaML
         PhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726028063; x=1726632863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zo1Mz0mCibvDjuHMiLv6hWXuOi9Lehm9B8rJqA3HQI=;
        b=V65hG9MK0J42KhdLxZqW3tGgiDtzs1R9mv+fWzvum+nWiIz3X0TT7nA8xFi66p3By+
         AXoHWW32/6+38heSkeJ+Otq/Fzd0p3Sr+SsrDlQPA5qmNn2c6Wi1aqglQWNejxP3C1pP
         B0tI15dQR8up93lBBrbw79m3ec25hShonVHlnd8gwI8RCvn6sYEiO/bK5CcZaWunY37W
         xs5suHDLzHdwUgmXIHcpfkJLyIQAJBSqa4oP0ohM+OrT40rLfDriURP1zjR82yQkT8Uu
         Ssnl6c+JjgfIfwhSi4rxLmpRlTmfjSDOvVEbydqrHl+17Adz6TUG2iPd7LO807wrHWC1
         niZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ZCPoeg/wBG9OGqmMpZvajIZLniSyGvL6nXcasa+LNfj67PJNugAe2iVWyRq+msXZvpr3ayM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVyIal+J08bPB4rnd+0vo4IryZR9xRkOhN18kdS3qK5/QhxVk
	sYWPo4HKWJplpK+kAvqDoOD1Uc2bGZnX70XMXxFVgNGu8vtbNs00
X-Google-Smtp-Source: AGHT+IEjeKgBWbJHlGU+5f2VOqN+FcVXZq58rhxC2Mh1ohKTfc3RRYH6VVTMOOz4of2DIXMZOrZ+sA==
X-Received: by 2002:a17:902:f542:b0:207:5665:32b2 with SMTP id d9443c01a7336-207566533ddmr12321155ad.40.1726028062738;
        Tue, 10 Sep 2024 21:14:22 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eeaa8fsm55464565ad.142.2024.09.10.21.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 21:14:22 -0700 (PDT)
Date: Tue, 10 Sep 2024 21:14:19 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Christophe ROULLIER <christophe.roullier@foss.st.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Maciek Machnikowski <maciek@machnikowski.net>
Subject: Re: [BUG] Regression with commit: ptp: Add .getmaxphase callback to
 ptp_clock_info
Message-ID: <ZuEZG6DM3SUdkE62@hoboy.vegasvil.org>
References: <8aac51e0-ce2d-4236-b16e-901f18619103@foss.st.com>
 <Zt8V3dmVGSsj2nKy@hoboy.vegasvil.org>
 <b7f33997-de4e-4a3d-ab1e-0e8fc77854ec@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7f33997-de4e-4a3d-ab1e-0e8fc77854ec@foss.st.com>

On Tue, Sep 10, 2024 at 08:49:57AM +0200, Christophe ROULLIER wrote:
> I've tested with platform 32bits and 64 bits and I have same error.
> 
> Toolchain/compiler used are:
> 
> aarch64-ostl-linux-gcc --version
> aarch64-ostl-linux-gcc (GCC) 11.3.0
> or
> 
> arm-ostl-linux-gnueabi-gcc --version
> arm-ostl-linux-gnueabi-gcc (GCC) 12.2.0

Something is off.

Can you run `pahole` on the ptp4l binaries that you are using, and
check the layout of `struct ptp_clock_caps` ?

It should look something like the ones below...

Thanks,
Richard

---
struct ptp_clock_caps1 {
        int                        max_adj;              /*     0     4 */
        int                        n_alarm;              /*     4     4 */
        int                        n_ext_ts;             /*     8     4 */
        int                        n_per_out;            /*    12     4 */
        int                        pps;                  /*    16     4 */
        int                        rsv[15];              /*    20    60 */

        /* size: 80, cachelines: 2, members: 6 */
        /* last cacheline: 16 bytes */
};
struct ptp_clock_caps2 {
        int                        max_adj;              /*     0     4 */
        int                        n_alarm;              /*     4     4 */
        int                        n_ext_ts;             /*     8     4 */
        int                        n_per_out;            /*    12     4 */
        int                        pps;                  /*    16     4 */
        int                        n_pins;               /*    20     4 */
        int                        cross_timestamping;   /*    24     4 */
        int                        adjust_phase;         /*    28     4 */
        int                        rsv[12];              /*    32    48 */

        /* size: 80, cachelines: 2, members: 9 */
        /* last cacheline: 16 bytes */
};
struct ptp_clock_caps3 {
        int                        max_adj;              /*     0     4 */
        int                        n_alarm;              /*     4     4 */
        int                        n_ext_ts;             /*     8     4 */
        int                        n_per_out;            /*    12     4 */
        int                        pps;                  /*    16     4 */
        int                        n_pins;               /*    20     4 */
        int                        cross_timestamping;   /*    24     4 */
        int                        adjust_phase;         /*    28     4 */
        int                        max_phase_adj;        /*    32     4 */
        int                        rsv[11];              /*    36    44 */

        /* size: 80, cachelines: 2, members: 10 */
        /* last cacheline: 16 bytes */
};

