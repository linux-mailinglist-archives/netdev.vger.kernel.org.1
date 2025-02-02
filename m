Return-Path: <netdev+bounces-161963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43900A24CB9
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 07:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200A67A2A7D
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 06:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8938435958;
	Sun,  2 Feb 2025 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2jU44DT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A6FE573
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738477472; cv=none; b=Byb28U0Yz/QfZUZuvNU3/Ve/6udcenKVKfZE9Lukzb4+Kj9EkJvscR5kCyMeg9INj+6oiuEbkfY0KCLlvkGaNzfW3qyMshx1wUacidxondI3rtI7u/2z7KHJtrTnLT/H6kr8zeVD+sffx8F2WibjxvaasJoPB9/Xk2fFkLnzkI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738477472; c=relaxed/simple;
	bh=Pnip2h4XNIWMgvL8oAId92Nu6kEwDFKJxgEPR7PbRHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpRPIlgPySyzUDeHF6PkcW2XGRrSLhD2fyq5VmBvzy+V0z1Xh1UMlCGpIvb8nm0ICCZbJ6HQyTxycxOHZtqsuBMlirHxNj81VlAQ5c0ORIW0n3GKB5S73ahLXhcKwfH1sBt/OeA+gbA1XOLTXPvtXlWBKpNtMGJUmZrc/7iB6BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2jU44DT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so4289506a91.3
        for <netdev@vger.kernel.org>; Sat, 01 Feb 2025 22:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738477470; x=1739082270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eTCA/SKa9InIf+Kf02iyJXhxqOfl3ZMPLJSo9EyZ94I=;
        b=a2jU44DTQN1Nrr3D08nRSKi3xYTGM9LMPhIXLEsmOKfxYZh5EvCNblwC9r8ftZ7IQA
         bHCKuINfgEVYK2Qk1R6Ci3bLGMIXRPZtwLTpWpzUzbnCWKap0y6C87fUJOQ001l/PJGe
         SVG42vWNP2Chyd3crZBGd3niTbu921BTFq7qg+gxSfjzM+c7Vp1DasBdXFfpkJSXIxdo
         TezTwv+NQSvopIecHdlu11G72AiHouI4OGLxFxDFQEeDHOgUMe5CjIfanNlVNjmGbJCO
         oe510+bhY4t5bcI2xrD0v8qRNhx7i5VIA+DGh5SMpZ46FmwRHec4omAz9v+fYKF6M2zf
         pe5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738477470; x=1739082270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTCA/SKa9InIf+Kf02iyJXhxqOfl3ZMPLJSo9EyZ94I=;
        b=gGBa8UYhzluhDSHx3LZ4hdRxKUh2TFE3SPuqSvW1k2o+itwr2o6VLoQQ5qNhID6k3Q
         Y9NK2ybYbq3cL6rpGXPvZow3tSEfB264dSwRgWjtlKcpDi94ZspKGbec5uOZdBx43rkm
         SA6fjhsQiJHnPK1ZqAf+Xylq/h5laoWGLIgrAGtQ2dVxfA/p57xRX1FZr74D4CY0oyrM
         uDyYoOoNUJX1aVBdbxvhjY4MjnSIx0Ffnl97jS2WhmLbnVhBEr1RKpY/9ibeq8FEHnNP
         /bxG34HJAC3FRE6nBJfMbKTkudtUWtxtVFa+BRRu//z8V2FL/1S4JRtWabT6enLyua8c
         VNDQ==
X-Gm-Message-State: AOJu0YzPw8ta5u0COsKqDE0vvSCxB0NbDHCmrriwq/f7cn2pm59qBrXq
	P8fzpbuXEA3Q+lb9tPDDhL22FrbNPIJSRAFev124qDNZqCgl1lOz
X-Gm-Gg: ASbGnctmRWh6EYBChJ9kqlEulQiPt/ej8nF4M9otgEjYrRKIDC1PFrRRZD5wPMqwhAq
	uMj8idexyIqorInrg04unpPqFnJvA/4n8TdG2FNGtx1I76gWtRDE39oyL+sJYZ5mYl84MY8m+W9
	oZOyrMBYbLVfJmG1jIFmIF1qbHh0J8I8EjbrZxt1qRCZOWAlUDDbjoMYk+YjJn7gLOvjqtaC3Vf
	YbXZz9axuP0DVrue8bbEK2wxmeuhVSviy6Qlp+zTBqtxd9MYR5+MenosnlPHaV3MBrFYw01GmyN
	L32Grmuk7GCMeO6fO9ybOi/7Tm0givz1W9o=
X-Google-Smtp-Source: AGHT+IHk+ibHlZauGAb0/a6fFWctJ4sDxgPIJKXoPI8J872Zxqabfwejx5lWsuDiTxEpwoYjl6/ilg==
X-Received: by 2002:a17:90b:5190:b0:2ee:d63f:d8f with SMTP id 98e67ed59e1d1-2f83abb91d4mr25539249a91.13.1738477470164;
        Sat, 01 Feb 2025 22:24:30 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bcd1605sm8936219a91.18.2025.02.01.22.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 22:24:29 -0800 (PST)
Date: Sat, 1 Feb 2025 22:24:27 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Wojtek Wasko <wwasko@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC net-next] ptp: Add file permission checks on PHC
 chardevs
Message-ID: <Z58Pm4BL44gQzyKD@hoboy.vegasvil.org>
References: <DM4PR12MB8558AB3C0DEA666EE334D8BCBEE82@DM4PR12MB8558.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB8558AB3C0DEA666EE334D8BCBEE82@DM4PR12MB8558.namprd12.prod.outlook.com>

On Fri, Jan 31, 2025 at 06:29:23PM +0000, Wojtek Wasko wrote:
> Udev sets strict 600 permissions on /dev/ptp* devices, preventing

Udev is user space, isn't it?

> unprivileged users from accessing the time [1]. This patch enables
> more granular permissions and allows readonly access to the PTP clocks.
> 
> Add permission checking for ioctls which modify the state of device.
> Notably, require WRITE for polling as it is only used for later reading
> timestamps from the queue (there is no peek support). POSIX clock
> operations (settime, adjtime) are checked in the POSIX layer.

This change log is not comprehensible.
A proper change log has three parts:

1. context

2. problem   (What is the issue?)

3. solution  (How does the patch address the issue?)

Thanks,
Richard

