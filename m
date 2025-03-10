Return-Path: <netdev+bounces-173490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91966A592EC
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987EE3AC6F3
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F3D221719;
	Mon, 10 Mar 2025 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stackhpc-com.20230601.gappssmtp.com header.i=@stackhpc-com.20230601.gappssmtp.com header.b="BwZYlJn5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DBA22157D
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606972; cv=none; b=cYKLj5W5VWWbHfoEX7Ct1OQKd702Nx/nMUYB3m/RJUsYfvVBnYhxHhKam8ZHrNadJkqVbqi6FT72RAYg6y70d/7bfc+eKZ+SdDSXuAxIhVaYxKDeAWBR4tB+yKEGfhNurWKb3nbUNVxUNO/ifC4ueK7iXH4Ha9ArxM235hz21ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606972; c=relaxed/simple;
	bh=rQycO5DG4hnPaHc1MEGcMMiM6ZW+scVlpHqiZIRyIPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1zwLKodXp4NtgRg/+/YbNrFo9YtBxHKz4HaKT2YoCzs//nPyMfmymDWnG4GNk2IPu3sHDGlb6dkYPytkebxsBO2MtQiox7B3Qs41698uzX058vdNdCLECef3BRToiK8dMxoqioBIFvY9NosuNL9StbUq1nrkp6WYKjmd1i43rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stackhpc.com; spf=pass smtp.mailfrom=stackhpc.com; dkim=pass (2048-bit key) header.d=stackhpc-com.20230601.gappssmtp.com header.i=@stackhpc-com.20230601.gappssmtp.com header.b=BwZYlJn5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stackhpc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stackhpc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2239c066347so67306215ad.2
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 04:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackhpc-com.20230601.gappssmtp.com; s=20230601; t=1741606970; x=1742211770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g4E4j1WUYf+OvBoySO8TidMK8V6kgfsxnFNxizqLyeo=;
        b=BwZYlJn5eeMh+jcFauYX2sWzCl4Z9t39HEAGZra/x7lQt0+7kcFGkgoGOqzfLyuMXE
         b5gvdpY2aG70sHX7IXP+oztnahwaNH5H47NFQfbAKbAbSEdE5XvOGDaO4xYuH9gWj5gI
         kOZ2GZqUQ5AuW1c6HnIIZIBmfSUBZMEXDunf7smM7r+aDXWbhM9ZPnsnqTxyoegV03vU
         oeP8EDBN4RSf+MKyCWk/z+ojzz71y2bJXchcz2UJqCWCmS5ZwFRkLuM8rEbIhCAGhXrs
         wn7mcZPmpcYqhdAumzWIA+r4pRASaHsvsp0FEpHfwOO0ZcfFcdQ5zFRyi8ZvQznCfMn7
         IVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741606970; x=1742211770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4E4j1WUYf+OvBoySO8TidMK8V6kgfsxnFNxizqLyeo=;
        b=WLZ3ryZ5WlrCgVlH/mhNXwc9W06J8JrtvIcbCzuNG2OhG8MEqqE3dPX366gdOCrgLW
         /q+gHb0b/CVA7wHpKnbF93+mnA80VD+VsKVf9ktSyURCIaXDmKsijFI3hLTg0kgilu4E
         pv3ItewmhGNUU9XXCKttntHw/CzyRGBLBct6U/nz4PHzidIk/SxnnoW6U8TSO6CxqrSO
         yaNfEpID/o4/FxnYgGvj1fxwKoQSUf+yvFZjyq+tX0narIDawIS7pppbjJd4x2I4++An
         pWJdw2ol/ZlDtu6QReAQm+eTvLWYzGYga0BQKGS7g6BaNPj8kIoa22LJKjonwAT2kcT7
         WQrA==
X-Forwarded-Encrypted: i=1; AJvYcCWq5eoRF9B8/cKwy6dM741b2IB4+vflzOWXfGEtnzUUiTZM+SisC3y4seVi8w0LI/uXX/e+r7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhRPHFeFQjQ5pQwC+4IOrGkONNWvfpSPrebPmZPx2VB/odgcmf
	0ZD2V83kPqUDrgMYCWlYe+0VIEVlr1nVyT1kollkF5QWnZiU8rL/NPhEFOrdA36E6miBdmjfk3N
	YrwJJxb5ygoSsA62XshyC94va5CVyJvhkXhLXuw==
X-Gm-Gg: ASbGncu8flHgJ0AHW2jylY6CD7DSDUT9ri9P+lzRiU/dSLct4TWtKosnKETk5D+YqoS
	6FOkqPhuQYRrgTUmodKxVQmrE4C2kpjQ/SdakutJQd7dpM0ban6zOsuidZAP/ViqwmRMpups78H
	QGkGVmsd0NMmEV4Ai9Dxkm0kGteGLY8OvRx9NBFaJ/AeMSjatzKKb113rdjHnSBGhPh6f5ykc=
X-Google-Smtp-Source: AGHT+IF1kATHZhSdH+l69i/XoyGTeFN4GU2J5QUgxJNSnWMJQlJveSCcLzz6YQhlzT4azTHh1/0QcV5ZPMjjqQy2TXY=
X-Received: by 2002:a17:90b:380e:b0:2ff:64a0:4a57 with SMTP id
 98e67ed59e1d1-2ff7ceef536mr17796709a91.26.1741606970455; Mon, 10 Mar 2025
 04:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214132453.4108-1-michal.swiatkowski@linux.intel.com>
 <2fcd3d16-c259-4356-82b7-2f1a3ad45dfa@lunn.ch> <Z69MESaQ4cUvIy4z@mev-dev.igk.intel.com>
 <c22f5a47-7fe0-4e83-8a0c-6da78143ceb3@redhat.com>
In-Reply-To: <c22f5a47-7fe0-4e83-8a0c-6da78143ceb3@redhat.com>
From: Pierre Riteau <pierre@stackhpc.com>
Date: Mon, 10 Mar 2025 12:42:13 +0100
X-Gm-Features: AQ5f1Jr7ptlFvOdXyUd00bt5D7Cqqa_mKBT8ZvAA9JqIA7_Sv1a6OQcN1He8obU
Message-ID: <CA+ny2sxC2Y7bxhkO7HqX+6E_Myf24_trmCUrroKFkyoce7QC9A@mail.gmail.com>
Subject: Re: [net v1] devlink: fix xa_alloc_cyclic error handling
To: Paolo Abeni <pabeni@redhat.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>, 
	netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, 
	Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 12:56, Paolo Abeni <pabeni@redhat.com> wrote:
>
>
>
> On 2/14/25 2:58 PM, Michal Swiatkowski wrote:
> > On Fri, Feb 14, 2025 at 02:44:49PM +0100, Andrew Lunn wrote:
> >> On Fri, Feb 14, 2025 at 02:24:53PM +0100, Michal Swiatkowski wrote:
> >>> Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
> >>> from xa_alloc_cyclic() in scheduler code [1]. The same is done in
> >>> devlink_rel_alloc().
> >>
> >> If the same bug exists twice it might exist more times. Did you find
> >> this instance by searching the whole tree? Or just networking?
> >>
> >> This is also something which would be good to have the static
> >> analysers check for. I wounder if smatch can check this?
> >>
> >>      Andrew
> >>
> >
> > You are right, I checked only net folder and there are two usage like
> > that in drivers. I will send v2 with wider fixing, thanks.
>
> While at that, please add the suitable fixes tag(s).
>
> Thanks,
>
> Paolo

Hello,

I haven't seen a v2 patch from Michal Swiatkowski. Would it be okay to
at least merge this net/devlink/core.c fix for inclusion in 6.14? I
can send a revised patch adding the Fixes tag. Driver fixes could be
addressed separately.

Thanks,
Pierre

