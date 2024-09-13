Return-Path: <netdev+bounces-128016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B07C977799
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C508286F23
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB221B1D5F;
	Fri, 13 Sep 2024 03:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDCr7DGB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A778A1B12C2
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 03:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726199727; cv=none; b=ed0fx0bwIVGL6/FWU9fZuj58+Lwo4mSq32PcB4dlROkJiQD+rhfkESsrtsL/kzzuKVOko/itKMzCJK3Gh734Lg7Ri909MT2NoBR2ocwn8uWByXZXWwexNsnvvPttox2iBNYU+N6xDQMBH6RrdrnlXvhYkYy8oa7iOYXy23yTREo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726199727; c=relaxed/simple;
	bh=7pa/x4lIKK/pFdBU+jEv6uFMUlXo8yCFCmMv5TWfegQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgmhuovucepU3pEvQXfL02kVdkW461bqdSo7clz/Un1kyYF7Pvdc7uyCKBd8oa0R1RVb20+aGx+pc2fLgSmnZD6sfjII7HjG9a13tT7yrQkTQgPmdMZKVz6UDrISBkzdLJ2PkkvtCW2/63gB2YD0R7o8FoAEDrEux6j31lt8XJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDCr7DGB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2068acc8a4fso4033865ad.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726199725; x=1726804525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P1EnhwZghocUIZWeB8iqFOUHTLe7sj6ltVOzOSiPFB0=;
        b=PDCr7DGBpXSz6u8/goNT7UpxbHAOD/Owl7zBCUquVK/hlw5h6fP5Xna6qLUNtHLfPl
         1s3eh0FC4l6jLkgsc6+2LymtMx/hUUOR/tB6JK5WdH+nSGt5LiWQrpL5TD+VPo/GNEdc
         E6zBkRe8Dvhw6I4vqi7QnNRSSOGaqr8MU5YkzKCDhjYZPNHOBDhtwAa/oMEf6H8ILo4+
         a1x/JqocyQ3L5jQwABlUeLoilBgH+2egNyHIjnnxAtgfVUg+J2I2xlKHW+ugAImwnXB0
         wj7R22w8XI2B4wYswVdnONqDc9O3PxEslQD6aLpkF8xzh6C+dRlaMQnp/CgceeIRMeHd
         G8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726199725; x=1726804525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1EnhwZghocUIZWeB8iqFOUHTLe7sj6ltVOzOSiPFB0=;
        b=iDjTINhJmH4L5AS/YmDynRLQCI/kBoFEP5Q6GfEE/+kFNXd3WUlAugtTuAuLHm/tUa
         DulfQAdB8pbJNN5s/otOl2A+c4u9bAUxPPMNLSgIkyI1yIPji3PCmOnqWk+y+XANd50j
         2YbmIPlvU4gpyjzYGqF1t9q5zID9GkQ2ezvj0GSnhQzpvUkEFFEGN0Z+lOKTZlpfKT3t
         6KsVC1FMhdyKu6koh6O6KitC14fVuNlr1opThBc9gtkk5OEvlz/96M62BRtDtLtOV+Iz
         Q9/0mwSIzJiB/HXkli1MGOy0Y7x/U7hfyt+Owss02+K6JNov76fC56T3Cypo3D4mLJBQ
         bHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcgtksiRZYMNqRHOzsyoBaEi6p+RAe5G513asiAkTawpQcr4m//K6d0LDExMtml5o2z9Fj18Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1yqWZuXocIzmnwz9MZPEF4oTZ9SMbphbwMcOggYtF71Z+n8x
	GTOj8Oy5M7l0iCsm+qPs+QdYH0zzrELTfEs1yDWUM+V2IZTFQdpZ
X-Google-Smtp-Source: AGHT+IGmlbtnJvdklZqyzpZ4YfdTxDCg8PwfK2acS64f+aFt61pnmyUjhfJkcZ8H9I9a2QAOAnO/yQ==
X-Received: by 2002:a17:902:e5cb:b0:205:866d:174f with SMTP id d9443c01a7336-20782be4e02mr17722135ad.44.1726199724859;
        Thu, 12 Sep 2024 20:55:24 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af4794csm20680875ad.114.2024.09.12.20.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 20:55:24 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:55:22 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Christophe ROULLIER <christophe.roullier@foss.st.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Maciek Machnikowski <maciek@machnikowski.net>
Subject: Re: [BUG] Regression with commit: ptp: Add .getmaxphase callback to
 ptp_clock_info
Message-ID: <ZuO3qgO9OfUJrYUS@hoboy.vegasvil.org>
References: <8aac51e0-ce2d-4236-b16e-901f18619103@foss.st.com>
 <Zt8V3dmVGSsj2nKy@hoboy.vegasvil.org>
 <b7f33997-de4e-4a3d-ab1e-0e8fc77854ec@foss.st.com>
 <ZuEZG6DM3SUdkE62@hoboy.vegasvil.org>
 <0ff0672d-9c36-4ff6-b863-3dce83d4d172@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ff0672d-9c36-4ff6-b863-3dce83d4d172@foss.st.com>

On Thu, Sep 12, 2024 at 04:51:51PM +0200, Christophe ROULLIER wrote:
> Hi Richard,
> 
> 
> I put in attachment result of pahole.
> 
> It is :
> 
> struct ptp_clock_caps {
>     int                        max_adj;              /*     0 4 */
>     int                        n_alarm;              /*     4 4 */
>     int                        n_ext_ts;             /*     8 4 */
>     int                        n_per_out;            /*    12 4 */
>     int                        pps;                  /*    16 4 */
>     int                        n_pins;               /*    20 4 */
>     int                        cross_timestamping;   /*    24 4 */
>     int                        adjust_phase;         /*    28 4 */
>     int                        max_phase_adj;        /*    32 4 */
>     int                        rsv[11];              /*    36 44 */
> 
>     /* size: 80, cachelines: 2, members: 10 */
>     /* last cacheline: 16 bytes */
> };

Total size is 80 bytes.

As expected.

So I can't explain the error that you are seeing.

Sorry,
Richard


